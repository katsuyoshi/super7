# -*- coding: utf8 -*-

class Super7

  @@keisu_table = [
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
    @deme_list = []
  end
  
  def put_deme deme
    @deme_list.unshift deme
    @deme_list.pop if @deme_list.size > 5
    calc_deme @deme_list[1], @deme_list[0] if @deme_list.size >= 2
  end
  
private
  def calc_deme first, second
    dig = Array[Array.new(3), Array.new(3), Array.new(3)]
    kei = Array.new(3)
    norm_kei = Array.new(3)
    3.times do |i|
      dig[0][i] = first[i,1].to_i
      dig[1][i] = second[i,1].to_i
      kei[i] = (10 + dig[1][i] - dig[0][i]) % 10
    end
    norm_kei[0] = kei[0] % 2
    norm_kei[1] = (kei[1] + 10 - kei[0]) % 10
    norm_kei[2] = (kei[2] + 10 - kei[0]) % 10
    index = norm_kei[1] * 10 + norm_kei[2]
    next_kei = @@keisu_table[norm_kei[0]][index]
    3.times do |i|
      dig[2][i] = (dig[1][i] + next_kei[i,1].to_i) % 10
    end
    "#{dig[2][0]}#{dig[2][1]}#{dig[2][2]}"
  end

end



s = Super7.new
p s.put_deme "624"
p s.put_deme "476"
p s.put_deme "222"
p s.put_deme "068"
p s.put_deme "464"
p s.put_deme "420"

#d = s.calc_deme "624", "476"

#p d
#p deme

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
