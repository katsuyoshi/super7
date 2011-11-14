# -*- coding: utf-8 -*-

class Super7

  @@keisu_table = [
    # 偶数
    %w(
      226 649 061 429 841 209 666 089 446 869
      236 693 072 439 852 219 676 099 456 879
      246 603 026 449 862 229 686 009 466 889
      256 613 036 493 872 239 696 019 476 899
      266 623 046 403 826 249 606 029 486 809
      276 634 056 414 836 294 616 039 496 819
      286 644 066 424 846 204 661 049 406 829
      296 653 076 433 856 213 670 093 416 838
      206 663 086 443 866 223 680 003 460 848
      216 673 096 453 876 233 690 013 470 893
    ),
    # 奇数
    %w(
      360 749 106 563 986 343 766 123 580 903
      336 759 171 539 951 319 731 199 556 979
      346 769 126 549 962 329 742 109 566 989
      356 779 136 593 972 339 752 119 576 999
      366 789 146 503 926 349 762 129 586 909
      376 899 156 523 936 393 772 139 596 919
      386 709 166 524 946 304 726 149 506 929
      396 719 176 534 996 314 736 194 516 939
      306 728 186 543 966 323 746 103 560 948
      316 738 196 553 976 333 756 113 570 993
     )
  ]

  attr_reader :deme_list
  def initialize
    @deme_list = ["000"]
  end
  
  def put_deme deme
    @deme_list.unshift deme
    @deme_list.pop if @deme_list.size > 5
    calc_deme @deme_list[1], @deme_list[0] if @deme_list.size >= 2
  end
  
private
  def calc_deme first, second
    # 1桁に分解
    first = first.split(//).map{|e| e.to_i }
    second = second.split(//).map{|e| e.to_i }
    
    # 係数計算
    keisu = []
    3.times do |i|
      keisu[i] = (10 + second[i] - first[i]) % 10
    end
    
    # 正規化
    normalized_keisu = []
    normalized_keisu[0] = keisu[0] % 2
    normalized_keisu[1] = (keisu[1] + 10 - keisu[0]) % 10
    normalized_keisu[2] = (keisu[2] + 10 - keisu[0]) % 10
    
    # 次に加算される係数取得
    index = normalized_keisu[1] * 10 + normalized_keisu[2]
    next_keisu = @@keisu_table[normalized_keisu[0]][index]
    next_keisu = next_keisu.split(//).map{|e| e.to_i }
    
    # 出目計算
    deme = []
    3.times do |i|
      deme[i] = (second[i] + next_keisu[i]) % 10
    end
    "#{deme[0]}#{deme[1]}#{deme[2]}"
  end

end


=begin
s = Super7.new
p s.put_deme "624"
p s.put_deme "476"
p s.put_deme "222"
p s.put_deme "068"
p s.put_deme "464"
p s.put_deme "420"
=end


=begin 出目
487
889 402 068
624 845 067

476 852 074
222 856 078

068
464
420
081
=end
