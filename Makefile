# �����Ϸ�
CC = gcc
CPP = g++

# C++ �����Ϸ� �ɼ�
CXXFLAGS = -Wall -03 -lrt

# �ҽ� ���� ���丮
SRC_DIR = ./src

# ������Ʈ ���� ���丮
OBJ_DIR = ./obj

# �����ϰ��� �ϴ� ���� ���� �̸� (���� ��� �̸�)
TARGET = head_pose

# MAKE �� �ҽ� ���ϵ�
# wildcard �� SRC_DIR���� *.cc�� �� ���ϵ� ����� �̾Ƴ� �ڿ�
# notdir�� ���� �̸��� �̾Ƴ���.
# (e.g. SRCS�� foo.cc bar.cc main.cc�� �ȴ�.)
SRCS = $(notdir $(wildcard $(SRC_DIR)/*.c))

OBJS = $(SRCS:.c=.o)

# OBJS ���� object ���ϵ� �̸� �տ� $(OBJ_DIR)/ �� ���δ�.
OBJECTS = $(patsubst %.o, $(OBJ_DIR)/%.o, $(OBJS))
DEPS = $(OBJECTS:.o=.d)

all : head_pose

# ������ & ��ũ
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.c
	$(CC) $(CXXFLAGS) -c  $< -o $@ -MD

./obj/ldmarkmodel.o : ./src/ldmarkmodel.cpp
	$(CPP) $(CXXFLAGS) -c $< -o $@ -MD

./obj/head_pose.o : ./src/head_pose.cpp
	$(CPP) $(CXXFLAGS) -c $< -o $@ -MD

$(TARGET) : $(OBJECTS)
	$(CPP) $(CXXFLAGS) -o $(TARGET) $(OBJECTS) $(pkg-config opencv4 --libs --cflags)

.PHONY : clean all

clean :
	rm -f $(OBJECTS) $(DEPS) $(TARGET)

-include $(DEPS)