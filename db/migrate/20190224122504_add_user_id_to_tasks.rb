class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    #executeはSQLを実行するための文句
    #これによって今まで作成したタスクを削除できる
    #既存のタスクがある状態でタスクとユーザの関連を表すカラムを追加すると、うまくいかなくなる
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
