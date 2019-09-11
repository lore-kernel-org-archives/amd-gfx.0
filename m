From: Gabriel C <nix.or.die@gmail.com>
Subject: [Regression] 5.3-rc8 suspending from X broken with amdgpu
Date: Wed, 11 Sep 2019 20:31:37 +0200
Message-ID: <CAEJqkghRENck2NNCoxFccdph6EwAhMsBAszjkx2cj6Krrkoi8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Hello,

I am testing latest rc8/Linus git tree on my new
Acer Nitro 5 (AN515-43-R8BF) Laptop.

The box has an Ryzen7 3750H APU+RX 560x hybrid GPU(s).

Suspending ( closing the Lid ) from tty without X up
is working fine, however with X running doing the same
does not work. The display remains black.

It seems to be triggered from

 .. dcn10_hw_sequencer.c:932
dcn10_verify_allow_pstate_change_high.cold+0xc/0x229 [amdgpu]

The dmesg is way to big to post there so I uploaded it:

dmesg:
 http://crazy.dev.frugalware.org/Nitro5/dmesg.one.txt
lspci:
 http://crazy.dev.frugalware.org/Nitro5/lspci.nnvv.txt
 http://crazy.dev.frugalware.org/Nitro5/lspci.txt
config:
 http://crazy.dev.frugalware.org/Nitro5/config.nitro5-5.3-r8git

I didn't tested any other rcX kernels so I cannot tell if all are affected,
but 5.2.x kernels are working fine on this box.


The dirty state of the build is because this patch, which fixes the
NVME device on that box:
 https://lkml.org/lkml/2019/9/11/569

If you need more infos please let me know.
Also I can test any kind patches.

Best Regards,

Gabriel C
