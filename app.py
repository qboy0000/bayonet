from web.models import User
from web import APP, DB
import os


def CreateDatabase():
    '''创建数据库'''
    DB.create_all()


def CreateUser():
    '''创建测试账户'''
    sql = User.query.filter(User.username == 'root').first()
    if not sql:
        username = os.environ.get("WEB_USER", "root")
        password = os.environ.get("WEB_PASSWD", "qazxsw@123")
        user1 = User(username=username, password=password, name='管理员', phone='1388888888', email='admin@qq.com',
                     remark='安全工程师')
        DB.session.add(user1)
        DB.session.commit()


def DeletDb():
    '''重置数据库'''
    DB.drop_all()
    CreateDatabase()
    CreateUser()


def bayonet_main():
    CreateDatabase()
    CreateUser()
    APP.run(host='0.0.0.0', port=APP.config['PORT'])
    # APP.run(port=APP.config['PORT'])


if __name__ == '__main__':
    # DeletDb()
    bayonet_main()
