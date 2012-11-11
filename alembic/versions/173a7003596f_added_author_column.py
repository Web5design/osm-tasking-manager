"""Added author column

Revision ID: 173a7003596f
Revises: 4fbba110ab8b
Create Date: 2012-11-11 17:03:32.593702

"""

# revision identifiers, used by Alembic.
revision = '173a7003596f'
down_revision = '4fbba110ab8b'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('jobs', sa.Column('author', sa.Unicode(), nullable=True))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('jobs', 'author')
    ### end Alembic commands ###
