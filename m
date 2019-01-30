From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amd-staging-drm-next: Oops - BUG: unable to handle kernel NULL
 pointer dereference, bisected.
Date: Wed, 30 Jan 2019 13:02:59 +0100
Message-ID: <2c13e24c-6d53-a7f5-55ed-d44d7c58f655@gmail.com>
References: <1631249.cbNX0rPzdC@eclipse>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0794761007=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1631249.cbNX0rPzdC@eclipse>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0794761007==
Content-Type: multipart/alternative;
 boundary="------------C0A150A4F0E676DE2DAC90D6"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C0A150A4F0E676DE2DAC90D6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

This is a known issue, see here as well 
https://bugs.freedesktop.org/show_bug.cgi?id=109487

Christian.

Am 30.01.19 um 12:07 schrieb Przemek Socha:
> Good morning,
>
> after last pull from the amd-staging-drm-next tree (29th of February) I have
> random Oops on A6 6310 APU with r4 Mullins.
>
> Here is the Oops part of the log taken from pstore:
>
> <1>[   55.166270] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000208
> <1>[   55.166281] #PF error: [normal kernel read fault]
> <6>[   55.166285] PGD 0 P4D 0
> <4>[   55.166293] Oops: 0000 [#1] PREEMPT SMP
> <4>[   55.166301] CPU: 3 PID: 11006 Comm: kwin_x11:cs0 Not tainted 5.0.0-rc1+
> #44
> <4>[   55.166305] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13)
> 08/04/2016
> <4>[   55.166320] RIP: 0010:ttm_bo_bulk_move_lru_tail+0xd3/0x188 [ttm]
> <4>[   55.166326] Code: 00 4c 8b 0a 48 8b 81 a8 00 00 00 48 81 c1 a8 00 00 00
> 49 89 02 4c 8b 92 b0 00 00 00 4c 89 50 08 44 89 c0 48 c1 e0 04 4c 01 c8 <4c>
> 8b 90 08 02 00 00 4d 89 1a 4c 8b 90 08 02 00 00 4c 89 92 b0 00
> <4>[   55.166330] RSP: 0018:ffffa8bdc0f33b18 EFLAGS: 00010246
> <4>[   55.166335] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> ffff9cfa935778f8
> <4>[   55.166339] RDX: ffff9cfa950c5050 RSI: 0000000000000070 RDI:
> ffff9cfa93575dd0
> <4>[   55.166342] RBP: ffff9cfa5d44d800 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   55.166346] R10: ffff9cfa8f7730f8 R11: ffff9cfa950c50f8 R12: ffff9cfa93575dd0
> <4>[   55.166350] R13: ffff9cfa93575800 R14: 0000000000000001 R15: ffffffffc03adc10
> <4>[   55.166355] FS:  00007fb327fff700(0000) GS:ffff9cfa97b80000(0000) knlGS:
> 0000000000000000
> <4>[   55.166359] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   55.166363] CR2: 0000000000000208 CR3: 00000002150f0000 CR4:
> 00000000000406e0
> <4>[   55.166366] Call Trace:
> <4>[   55.166477]  amdgpu_vm_move_to_lru_tail+0xe4/0x100 [amdgpu]
> <4>[   55.166563]  amdgpu_cs_ioctl+0x14e7/0x1b08 [amdgpu]
> <4>[   55.166586]  ? __switch_to_asm+0x40/0x70
> <4>[   55.166689]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
> <4>[   55.166698]  drm_ioctl_kernel+0xa4/0xe8
> <4>[   55.166707]  drm_ioctl+0x1db/0x358
> <4>[   55.166805]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
> <4>[   55.166901]  amdgpu_drm_ioctl+0x44/0x78 [amdgpu]
> <4>[   55.166931]  do_vfs_ioctl+0x9f/0x618
> <4>[   55.166940]  ksys_ioctl+0x5b/0x88
> <4>[   55.166947]  __x64_sys_ioctl+0x11/0x18
> <4>[   55.166955]  do_syscall_64+0x50/0x168
> <4>[   55.166963]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[   55.166969] RIP: 0033:0x7fb34b035fa7
> <4>[   55.166974] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 8d
> dc 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d a9 ae 0c 00 f7 d8 64 89 01 48
> <4>[   55.166978] RSP: 002b:00007fb327ffea88 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> <4>[   55.166984] RAX: ffffffffffffffda RBX: 00007fb327ffec58 RCX: 00007fb34b035fa7
> <4>[   55.166987] RDX: 00007fb327ffeb10 RSI: 00000000c0186444 RDI:
> 0000000000000010
> <4>[   55.166991] RBP: 00007fb327ffeb10 R08: 00007fb327ffec80 R09:
> 00007fb327ffec58
> <4>[   55.166995] R10: 00007fb327ffeca0 R11: 0000000000000246 R12:
> 00000000c0186444
> <4>[   55.166998] R13: 0000000000000010 R14: 000055ecd2705dc0 R15:
> 0000000000000003
> <4>[   55.167004] Modules linked in: rfcomm nf_tables ebtable_nat ip_set
> nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables overlay squashfs
> loop bnep ipv6 rtsx_usb_ms memstick rtsx_usb_sdmmc rtsx_usb uvcvideo
> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
> media ath3k btusb btintel bluetooth ecdh_generic ath9k ath9k_common kvm_amd
> ath9k_hw sdhci_pci kvm cqhci irqbypass mac80211 sdhci crc32_pclmul
> ghash_clmulni_intel ath serio_raw mmc_core cfg80211 amdgpu mfd_core chash
> gpu_sched xhci_pci ttm xhci_hcd ehci_pci ehci_hcd sp5100_tco
> <4>[   55.167063] CR2: 0000000000000208
> <4>[   55.167069] ---[ end trace bf1c4be089002236 ]---
>
> Bisected, and  it seems that the bad commit is "drm/amdgpu: cleanup setting
> bulk_movable". I hope this is relevant.
>
> full git bisect log:
>
> git bisect start
> # good: [10117450735c7a7c0858095fb46a860e7037cb9a] drm/amd/display: add -msse2
> to prevent Clang from emitting libcalls to undefined SW FP routines
> git bisect good 10117450735c7a7c0858095fb46a860e7037cb9a
> # bad: [b9c6252b7f980e7e03c0bf659a251798b36a8094] Revert "drm/amd/display: add
> -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"
> git bisect bad b9c6252b7f980e7e03c0bf659a251798b36a8094
> # good: [1de29da5b7281c9a8427d84948bf3d77bc4b8d16] drm: disable uncached DMA
> optimization for ARM and arm64
> git bisect good 1de29da5b7281c9a8427d84948bf3d77bc4b8d16
> # good: [bbf48cae572b39c4df6023b01d6f8de66ef41b34] Revert "test patch for hpd
> dpms check"
> git bisect good bbf48cae572b39c4df6023b01d6f8de66ef41b34
> # good: [257b75d373c77d6792d0011f7379398ba60799ec] drm/amdgpu: Show XGMI node
> and hive message per device only once
> git bisect good 257b75d373c77d6792d0011f7379398ba60799ec
> # good: [4d771657c533d8fe3b574c561084f66aebc77bb6] drm/amdgpu: cleanup
> amdgpu_pte_update_params
> git bisect good 4d771657c533d8fe3b574c561084f66aebc77bb6
> # bad: [4ef27005fefd4be102010b7d8552fec1ee13435a] drm/amdgpu: cleanup setting
> bulk_movable
> git bisect bad 4ef27005fefd4be102010b7d8552fec1ee13435a
> # first bad commit: [4ef27005fefd4be102010b7d8552fec1ee13435a] drm/amdgpu:
> cleanup setting bulk_movable
>
> 4ef27005fefd4be102010b7d8552fec1ee13435a is the first bad commit
> commit 4ef27005fefd4be102010b7d8552fec1ee13435a
> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Date:   Mon Jan 28 13:41:58 2019 +0100
>
>      drm/amdgpu: cleanup setting bulk_movable
>      
>      We only need to set this to false now when BOs are removed from the LRU.
>      
>      Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>      Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>
> If other info is needed, please do not hesitate.
>
> Thanks,
> Przemek.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------C0A150A4F0E676DE2DAC90D6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">This is a known issue, see here as well
      <a class="moz-txt-link-freetext" href="https://bugs.freedesktop.org/show_bug.cgi?id=109487">https://bugs.freedesktop.org/show_bug.cgi?id=109487</a><br>
      <br>
      Christian.<br>
      <br>
      Am 30.01.19 um 12:07 schrieb Przemek Socha:<br>
    </div>
    <blockquote type="cite" cite="mid:1631249.cbNX0rPzdC@eclipse">
      <pre class="moz-quote-pre" wrap="">Good morning,

after last pull from the amd-staging-drm-next tree (29th of February) I have 
random Oops on A6 6310 APU with r4 Mullins.

Here is the Oops part of the log taken from pstore:

&lt;1&gt;[   55.166270] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000208
&lt;1&gt;[   55.166281] #PF error: [normal kernel read fault]
&lt;6&gt;[   55.166285] PGD 0 P4D 0 
&lt;4&gt;[   55.166293] Oops: 0000 [#1] PREEMPT SMP
&lt;4&gt;[   55.166301] CPU: 3 PID: 11006 Comm: kwin_x11:cs0 Not tainted 5.0.0-rc1+ 
#44
&lt;4&gt;[   55.166305] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13) 
08/04/2016
&lt;4&gt;[   55.166320] RIP: 0010:ttm_bo_bulk_move_lru_tail+0xd3/0x188 [ttm]
&lt;4&gt;[   55.166326] Code: 00 4c 8b 0a 48 8b 81 a8 00 00 00 48 81 c1 a8 00 00 00 
49 89 02 4c 8b 92 b0 00 00 00 4c 89 50 08 44 89 c0 48 c1 e0 04 4c 01 c8 &lt;4c&gt; 
8b 90 08 02 00 00 4d 89 1a 4c 8b 90 08 02 00 00 4c 89 92 b0 00
&lt;4&gt;[   55.166330] RSP: 0018:ffffa8bdc0f33b18 EFLAGS: 00010246
&lt;4&gt;[   55.166335] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
ffff9cfa935778f8
&lt;4&gt;[   55.166339] RDX: ffff9cfa950c5050 RSI: 0000000000000070 RDI: 
ffff9cfa93575dd0
&lt;4&gt;[   55.166342] RBP: ffff9cfa5d44d800 R08: 0000000000000000 R09: 
0000000000000000
&lt;4&gt;[   55.166346] R10: ffff9cfa8f7730f8 R11: ffff9cfa950c50f8 R12: ffff9cfa93575dd0
&lt;4&gt;[   55.166350] R13: ffff9cfa93575800 R14: 0000000000000001 R15: ffffffffc03adc10
&lt;4&gt;[   55.166355] FS:  00007fb327fff700(0000) GS:ffff9cfa97b80000(0000) knlGS:
0000000000000000
&lt;4&gt;[   55.166359] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
&lt;4&gt;[   55.166363] CR2: 0000000000000208 CR3: 00000002150f0000 CR4: 
00000000000406e0
&lt;4&gt;[   55.166366] Call Trace:
&lt;4&gt;[   55.166477]  amdgpu_vm_move_to_lru_tail+0xe4/0x100 [amdgpu]
&lt;4&gt;[   55.166563]  amdgpu_cs_ioctl+0x14e7/0x1b08 [amdgpu]
&lt;4&gt;[   55.166586]  ? __switch_to_asm+0x40/0x70
&lt;4&gt;[   55.166689]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
&lt;4&gt;[   55.166698]  drm_ioctl_kernel+0xa4/0xe8
&lt;4&gt;[   55.166707]  drm_ioctl+0x1db/0x358
&lt;4&gt;[   55.166805]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
&lt;4&gt;[   55.166901]  amdgpu_drm_ioctl+0x44/0x78 [amdgpu]
&lt;4&gt;[   55.166931]  do_vfs_ioctl+0x9f/0x618
&lt;4&gt;[   55.166940]  ksys_ioctl+0x5b/0x88
&lt;4&gt;[   55.166947]  __x64_sys_ioctl+0x11/0x18
&lt;4&gt;[   55.166955]  do_syscall_64+0x50/0x168
&lt;4&gt;[   55.166963]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
&lt;4&gt;[   55.166969] RIP: 0033:0x7fb34b035fa7
&lt;4&gt;[   55.166974] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 8d 
dc 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 &lt;48&gt; 3d 
01 f0 ff ff 73 01 c3 48 8b 0d a9 ae 0c 00 f7 d8 64 89 01 48
&lt;4&gt;[   55.166978] RSP: 002b:00007fb327ffea88 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
&lt;4&gt;[   55.166984] RAX: ffffffffffffffda RBX: 00007fb327ffec58 RCX: 00007fb34b035fa7
&lt;4&gt;[   55.166987] RDX: 00007fb327ffeb10 RSI: 00000000c0186444 RDI: 
0000000000000010
&lt;4&gt;[   55.166991] RBP: 00007fb327ffeb10 R08: 00007fb327ffec80 R09: 
00007fb327ffec58
&lt;4&gt;[   55.166995] R10: 00007fb327ffeca0 R11: 0000000000000246 R12: 
00000000c0186444
&lt;4&gt;[   55.166998] R13: 0000000000000010 R14: 000055ecd2705dc0 R15: 
0000000000000003
&lt;4&gt;[   55.167004] Modules linked in: rfcomm nf_tables ebtable_nat ip_set 
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables overlay squashfs 
loop bnep ipv6 rtsx_usb_ms memstick rtsx_usb_sdmmc rtsx_usb uvcvideo 
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev 
media ath3k btusb btintel bluetooth ecdh_generic ath9k ath9k_common kvm_amd 
ath9k_hw sdhci_pci kvm cqhci irqbypass mac80211 sdhci crc32_pclmul 
ghash_clmulni_intel ath serio_raw mmc_core cfg80211 amdgpu mfd_core chash 
gpu_sched xhci_pci ttm xhci_hcd ehci_pci ehci_hcd sp5100_tco
&lt;4&gt;[   55.167063] CR2: 0000000000000208
&lt;4&gt;[   55.167069] ---[ end trace bf1c4be089002236 ]---

Bisected, and  it seems that the bad commit is "drm/amdgpu: cleanup setting 
bulk_movable". I hope this is relevant.

full git bisect log:

git bisect start
# good: [10117450735c7a7c0858095fb46a860e7037cb9a] drm/amd/display: add -msse2 
to prevent Clang from emitting libcalls to undefined SW FP routines
git bisect good 10117450735c7a7c0858095fb46a860e7037cb9a
# bad: [b9c6252b7f980e7e03c0bf659a251798b36a8094] Revert "drm/amd/display: add 
-msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"
git bisect bad b9c6252b7f980e7e03c0bf659a251798b36a8094
# good: [1de29da5b7281c9a8427d84948bf3d77bc4b8d16] drm: disable uncached DMA 
optimization for ARM and arm64
git bisect good 1de29da5b7281c9a8427d84948bf3d77bc4b8d16
# good: [bbf48cae572b39c4df6023b01d6f8de66ef41b34] Revert "test patch for hpd 
dpms check"
git bisect good bbf48cae572b39c4df6023b01d6f8de66ef41b34
# good: [257b75d373c77d6792d0011f7379398ba60799ec] drm/amdgpu: Show XGMI node 
and hive message per device only once
git bisect good 257b75d373c77d6792d0011f7379398ba60799ec
# good: [4d771657c533d8fe3b574c561084f66aebc77bb6] drm/amdgpu: cleanup 
amdgpu_pte_update_params
git bisect good 4d771657c533d8fe3b574c561084f66aebc77bb6
# bad: [4ef27005fefd4be102010b7d8552fec1ee13435a] drm/amdgpu: cleanup setting 
bulk_movable
git bisect bad 4ef27005fefd4be102010b7d8552fec1ee13435a
# first bad commit: [4ef27005fefd4be102010b7d8552fec1ee13435a] drm/amdgpu: 
cleanup setting bulk_movable

4ef27005fefd4be102010b7d8552fec1ee13435a is the first bad commit
commit 4ef27005fefd4be102010b7d8552fec1ee13435a
Author: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Date:   Mon Jan 28 13:41:58 2019 +0100

    drm/amdgpu: cleanup setting bulk_movable
    
    We only need to set this to false now when BOs are removed from the LRU.
    
    Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
    Reviewed-by: Chunming Zhou <a class="moz-txt-link-rfc2396E" href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>

If other info is needed, please do not hesitate.

Thanks,
Przemek.
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C0A150A4F0E676DE2DAC90D6--

--===============0794761007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0794761007==--
