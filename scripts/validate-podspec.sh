#!/bin/zsh

#--------------------------------------------
# 回收宝pod库打包脚本
# author：jinjianglun
# site：www.huishoubao.com.cn
# slogan：学的不仅是技术，更是梦想！
#--------------------------------------------
##### 说明 开始 #####
# 1.修改本地podspec版本信息
# 2.pod lib lint
# 3.拉取最新代码，更新tag
# 4.提交本地修改
# 5.pod repo push
##### 说明 结束  #####



podspecName="Prelude.podspec"
repo="AllenSpecs"
podspecVersion=""

set -e

# 1.修改本地podspec版本信息
function modify_local_podspec_info() {
    echo "--- Step: version_podspec ---"

		a=`grep -E 'spec.version.*=' ${podspecName}`
		b=${a#*\'}
		podspecVersion=${b%\'*}
		
		LineNumber=`grep -nE 'spec.version.*=' ${podspecName} | cut -d : -f1`
		git_rev_list=`git rev-list --tags --max-count=1`
		newVersion=`git describe --tags ${git_rev_list}`

		#判断提交的tag上面跟podspec是否一致
		if test ${podspecVersion} != ${newVersion} ; then
				# 修改HSBKit.podspec文件中的version为指定值
				sed -i "" "${LineNumber}s/${podspecVersion}/${newVersion}/g" ${podspecName}
				
				# 修改readme版本号
				sed -i "" "s/${podspecVersion}/${newVersion}/g" README.md
				podspecVersion=${newVersion}
		fi
		echo "--- Step: version_podspec $newVersion---"
}

# 2.pod lib lint
function pod_lib_lint_test() {
		echo "--- Step: pod_lib_lint ---"
		pod lib lint $podspecName  --no-clean --skip-import-validation --allow-warnings
}


# 3.提交本地修改
function git_comment_publish() {
		echo "--- Step: git_add ---"
		git add .
		echo "--- Step: git_commit ---"
		git commit -m "bump version to ${podspecVersion}"
		echo "--- Step: push ---"
		git push origin
}

# 4.拉取最新代码，更新tag
function git_updare_tags() {
		echo "--- Step: git_pull ---"
		git pull && git fetch --tags
		echo "--- Step: push_git_tags ---"
		git push origin --tags
		echo "--- Step: push_to_git_remote ---"
		echo `$pwd`
		git push origin master:master --tags
		
		git_rev_list=`git rev-list --tags --max-count=1`
		newVersion=`git describe --tags ${git_rev_list}`

		echo "--- Step: podspecVersion:${podspecVersion}---"
		echo "--- Step: newVersion:${newVersion} ---"
		#判断提交的tag上面跟podspec是否一致
		if "${podspecVersion}" == "${newVersion}" ; then
				echo "--- Step: git_tag_exists ---"
				echo "--- Step: remove_git_tag ---"
				git tag -d $podspecVersion&git push origin :$podspecVersion
		fi
		
		echo "--- Step: add_git_tag ---"
		git tag -am 'update' $podspecVersion
		echo "--- Step: push_git_tags ---"
		git push origin --tags
}

# 5.pod repo push
function pod_repo_push() {
		echo "--- Step: pod_push ---"
		#pod repo push $repo $podspecName --allow-warnings --skip-import-validation
}


argc=$1

echo "----------------------------------"
echo "--- step:准备进行打包 ---"

case $argc in 
		"check")
    		modify_local_podspec_info
    		pod_lib_lint_test
    ;;
		"make")
		    modify_local_podspec_info
				pod_lib_lint_test
				git_comment_publish
				git_updare_tags
				pod_repo_push
    ;;
esac

echo "--- step:完成打包 ---"
echo "----------------------------------"