package com.fabio.aether;
public final class Rules {
 public static final int SIZE=40;
 public static int tile(int x,int y){if(x==0||y==0||x==SIZE-1||y==SIZE-1)return 3;if(x>16&&x<24&&y>16&&y<24)return 0;int h=Math.floorMod(x*7349+y*9157+x*y*31,100);return h<12?3:h<27?1:h<37?2:0;}
 public static int damage(int level){return 12+level*4;}
 public static boolean solid(int t){return t!=0;}
 public static int clamp(int n,int min,int max){return Math.max(min,Math.min(max,n));}
 public static int xpNeed(int level){return level*30;}
}
