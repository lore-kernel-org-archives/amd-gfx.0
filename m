Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F13FCFD2F6
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Nov 2025 09:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF6D10E13D;
	Sat, 29 Nov 2025 09:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tnonline.net header.i=@tnonline.net header.b="NE7ge+dz";
	dkim-atps=neutral
Received: from mx.tnonline.net (mx.tnonline.net [135.181.111.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAF310E13D
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Nov 2025 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
 From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JAaleqGwBMGiiK9XXcrNqD4FwSOF/ZZBOhYdbn+5p8g=; t=1764408006; x=1765617606; 
 b=NE7ge+dz3SCa8Ag8nBGe+Uh/AUb+3fQlEumPuzF3L+zpimZ3ipWxrlIMS7GPZ9S/JXGWeon4FaZ
 tWmOInkpXSm42kwDiBzluc9a+DMPIc0lOr8FIxLL8Yg71tMp3dpVk++z0QsrAb51GQXPgKZKfveg0
 hw8VH70oPGA1ahSxGdlRpkNTZEvwFsxNOMGmovliqvWz0m0EOUDQipkDY+lhmMMQLsX//7W+ZuIIN
 0ce8gsO5MxeTdP2Wpo+IJjpMBT7fm8dhY2Pil4Ry3JBzYB4GmCf3i7LSpYb9jYf15KBd+zPhrq4xF
 nuaRy2zEfpDF5dKqJYB6FF/bqBSe0X2yzkKw==;
Received: from [2001:470:28:704::1] (port=59314 helo=tnonline.net)
 by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <forza@tnonline.net>)
 id 1vPH7c-000000005LH-1o26 for amd-gfx@lists.freedesktop.org;
 Sat, 29 Nov 2025 09:20:04 +0000
Received: from [192.168.0.109] (port=44074)
 by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98.2) (envelope-from <forza@tnonline.net>)
 id 1vPH7Z-00000000GHL-3KzW for amd-gfx@lists.freedesktop.org;
 Sat, 29 Nov 2025 10:20:01 +0100
Message-ID: <b156f530-7498-4785-a45c-0428512cd3ed@tnonline.net>
Date: Sat, 29 Nov 2025 10:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
From: Forza <forza@tnonline.net>
Subject: amdgpu_acpi_detect: WARNING: Unpatched return thunk in use
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I've upgraded from kernel 6.12.58 to 6.12.59 and now I see the following 
kernel warning:

```
[   13.845543] [ T1126] [drm] amdgpu kernel modesetting enabled.
[   13.845639] [ T1126] ------------[ cut here ]------------
[   13.845640] [ T1126] Unpatched return thunk in use. This should not 
happen!
[   13.845641] [ T1126] WARNING: CPU: 9 PID: 1126 at 
arch/x86/kernel/cpu/bugs.c:3484 __warn_thunk+0x2b/0x40
[   13.845646] [ T1126] Modules linked in: amdgpu(+) hwmon_vid kvm_amd 
kvm mfd_core drm_buddy drm_suballoc_helper drm_exec i2c_algo_bit 
irqbypass gigabyte_wmi drm_display_helper r8169 gpu_sched amdxcp 
drm_ttm_helper ttm i2c_piix4 e1000e i2c_smbus video tpm_crb backlight 
tpm_tis gpio_amdpt gpio_generic tpm_tis_core crct10dif_pclmul 
crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel 
sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel crypto_simd 8250 
8250_base serial_mctrl_gpio serial_base dm_mirror dm_region_hash dm_log
[   13.845673] [ T1126] CPU: 9 UID: 0 PID: 1126 Comm: (udev-worker) 
Tainted: G        W          6.12.59-gentoo #1
[   13.845676] [ T1126] Tainted: [W]=WARN
[   13.845677] [ T1126] Hardware name: Gigabyte Technology Co., Ltd. 
B450M DS3H/B450M DS3H-CF, BIOS F67 10/28/2025
[   13.845678] [ T1126] RIP: 0010:__warn_thunk+0x2b/0x40
[   13.845680] [ T1126] Code: 0f 1f 00 0f 1f 44 00 00 80 3d 6a a8 5d 02 
00 74 06 e9 84 91 68 01 cc 48 c7 c7 4a be c2 b2 c6 05 54 a8 5d 02 01 e8 
45 6a 08 00 <0f> 0b e9 69 91 68 01 cc cc cc cc cc cc cc cc cc cc cc cc 
cc cc 90
[   13.845682] [ T1126] RSP: 0018:ffffce08020ef820 EFLAGS: 00010246
[   13.845683] [ T1126] RAX: a19421c8220e9f00 RBX: 0000000000008000 RCX: 
a19421c8220e9f00
[   13.845685] [ T1126] RDX: 00000000ffffdfff RSI: 0000000000000002 RDI: 
ffffffffb3489cc0
[   13.845686] [ T1126] RBP: ffffce08020ef870 R08: 0000000000001fff R09: 
ffffffffb3459c60
[   13.845686] [ T1126] R10: 0000000000005ffd R11: 00000000ffffdfff R12: 
ffff890d01612810
[   13.845687] [ T1126] R13: ffffce08020ef8d0 R14: ffff890d01695000 R15: 
ffffce08020ef8e0
[   13.845688] [ T1126] FS:  00007f88ab8e8840(0000) 
GS:ffff89140e080000(0000) knlGS:0000000000000000
[   13.845690] [ T1126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.845691] [ T1126] CR2: 00007f88ab89c000 CR3: 000000010c430000 CR4: 
0000000000b50ef0
[   13.845692] [ T1126] Call Trace:
[   13.845694] [ T1126]  <TASK>
[   13.845695] [ T1126]  warn_thunk_thunk+0x1a/0x30
[   13.845698] [ T1126]  amdgpu_acpi_detect+0x2e1/0xbe0 [amdgpu]
[   13.846160] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846163] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846165] [ T1126]  ? _printk+0x5d/0x80
[   13.846167] [ T1126]  ? __kmem_cache_create_args+0xfe/0x3a0
[   13.846169] [ T1126]  ? __se_sys_finit_module+0x29e/0x460
[   13.846171] [ T1126]  init_module+0xf3/0xff0 [amdgpu]
[   13.846493] [ T1126]  ? ____versions+0x31f7af765d10/0x31f7af765d10 
[amdgpu]
[   13.846772] [ T1126]  ? do_one_initcall+0x14f/0x3d0
[   13.846774] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846776] [ T1126]  ? kernfs_activate+0x53/0x240
[   13.846778] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846779] [ T1126]  ? update_load_avg+0x1bb/0x7a0
[   13.846781] [ T1126]  ? enqueue_entity+0x258/0x590
[   13.846783] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846784] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846786] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846787] [ T1126]  ? update_load_avg+0x1bb/0x7a0
[   13.846789] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846790] [ T1126]  ? psi_task_switch+0x238/0x310
[   13.846792] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846793] [ T1126]  ? __switch_to+0x174/0x5d0
[   13.846795] [ T1126]  ? __switch_to_asm+0x3d/0x70
[   13.846797] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846798] [ T1126]  ? __schedule+0x4c2/0x1370
[   13.846800] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846801] [ T1126]  ? free_large_kmalloc+0x8c/0xb0
[   13.846803] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846805] [ T1126]  ? module_decompress_cleanup+0xac/0xd0
[   13.846807] [ T1126]  ? do_init_module+0x5f/0x5d0
[   13.846809] [ T1126]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.846810] [ T1126]  ? __kmalloc_cache_noprof+0x15a/0x280
[   13.846811] [ T1126]  ? __se_sys_finit_module+0x29e/0x460
[   13.846813] [ T1126]  do_init_module+0x9d/0x5d0
[   13.846815] [ T1126]  __se_sys_finit_module+0x29e/0x460
[   13.846817] [ T1126]  do_syscall_64+0x54/0xf0
[   13.846819] [ T1126]  ? irqentry_exit_to_user_mode+0x8c/0xb0
[   13.846821] [ T1126]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.846823] [ T1126] RIP: 0033:0x7f88abd42d4d
[   13.846825] [ T1126] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 30 0b 00 f7 d8 64 
89 01 48
[   13.846826] [ T1126] RSP: 002b:00007fff99c23488 EFLAGS: 00000246 
ORIG_RAX: 0000000000000139
[   13.846828] [ T1126] RAX: ffffffffffffffda RBX: 0000561cd4434e40 RCX: 
00007f88abd42d4d
[   13.846829] [ T1126] RDX: 0000000000000004 RSI: 00007f88ac2243af RDI: 
000000000000003d
[   13.846830] [ T1126] RBP: 0000000000000004 R08: 0000000000000000 R09: 
0000561cd4387160
[   13.846831] [ T1126] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000020000
[   13.846832] [ T1126] R13: 00007f88ac2243af R14: 0000561cd44352b0 R15: 
0000000000000000
[   13.846833] [ T1126]  </TASK>
[   13.846834] [ T1126] ---[ end trace 0000000000000000 ]---
[   13.851218] [ T1126] amdgpu: Virtual CRAT table created for CPU
[   13.851231] [ T1126] amdgpu: Topology: Add CPU node
[   13.851373] [ T1126] [drm] initializing kernel modesetting (RENOIR 
0x1002:0x1638 0x1458:0xD000 0xC9).
[   13.851385] [ T1126] [drm] register mmio base: 0xFC800000
[   13.851386] [ T1126] [drm] register mmio size: 524288
[   13.854289] [ T1126] [drm] add ip block number 0 <soc15_common>
[   13.854291] [ T1126] [drm] add ip block number 1 <gmc_v9_0>
[   13.854292] [ T1126] [drm] add ip block number 2 <vega10_ih>
[   13.854293] [ T1126] [drm] add ip block number 3 <psp>
[   13.854294] [ T1126] [drm] add ip block number 4 <smu>
[   13.854295] [ T1126] [drm] add ip block number 5 <dm>
[   13.854295] [ T1126] [drm] add ip block number 6 <gfx_v9_0>
[   13.854296] [ T1126] [drm] add ip block number 7 <sdma_v4_0>
[   13.854297] [ T1126] [drm] add ip block number 8 <vcn_v2_0>
[   13.854298] [ T1126] [drm] add ip block number 9 <jpeg_v2_0>
[   13.854306] [ T1126] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
[   13.854309] [ T1126] amdgpu: ATOM BIOS: 13-CEZANNE-019
[   13.854315] [ T1126] Loading firmware: amdgpu/green_sardine_asd.bin
[   13.856997] [ T1126] Loading firmware: amdgpu/green_sardine_ta.bin
[   13.857513] [ T1126] Loading firmware: amdgpu/green_sardine_dmcub.bin
[   13.858779] [ T1126] Loading firmware: amdgpu/green_sardine_pfp.bin
[   13.859346] [ T1126] Loading firmware: amdgpu/green_sardine_me.bin
[   13.859835] [ T1126] Loading firmware: amdgpu/green_sardine_ce.bin
[   13.860219] [ T1126] Loading firmware: amdgpu/green_sardine_rlc.bin
[   13.860582] [ T1126] Loading firmware: amdgpu/green_sardine_mec.bin
[   13.861161] [ T1126] Loading firmware: amdgpu/green_sardine_sdma.bin
[   13.861578] [ T1126] Loading firmware: amdgpu/green_sardine_vcn.bin
[   13.876508] [ T1126] Console: switching to colour dummy device 80x25
[   13.900631] [ T1126] amdgpu 0000:08:00.0: vgaarb: deactivate vga console
[   13.900635] [ T1126] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone 
(TMZ) feature enabled
[   13.900638] [ T1126] amdgpu 0000:08:00.0: amdgpu: MODE2 reset
[   13.900704] [ T1126] [drm] vm size is 262144 GB, 4 levels, block size 
is 9-bit, fragment size is 9-bit
[   13.900709] [ T1126] amdgpu 0000:08:00.0: amdgpu: VRAM: 768M 
0x000000F400000000 - 0x000000F42FFFFFFF (768M used)
[   13.900712] [ T1126] amdgpu 0000:08:00.0: amdgpu: GART: 1024M 
0x0000000000000000 - 0x000000003FFFFFFF
[   13.900719] [ T1126] [drm] Detected VRAM RAM=768M, BAR=768M
[   13.900720] [ T1126] [drm] RAM width 128bits DDR4
[   13.900786] [ T1126] [drm] amdgpu: 768M of VRAM memory ready
[   13.900788] [ T1126] [drm] amdgpu: 15601M of GTT memory ready.
[   13.900807] [ T1126] [drm] GART: num cpu pages 262144, num gpu pages 
262144
[   13.900932] [ T1126] [drm] PCIE GART of 1024M enabled.
[   13.900933] [ T1126] [drm] PTB located at 0x000000F42FC00000
[   13.901149] [ T1126] [drm] Loading DMUB firmware via PSP: 
version=0x0101002B
[   13.901476] [ T1126] [drm] Found VCN firmware Version ENC: 1.24 DEC: 
8 VEP: 0 Revision: 9
[   14.616559] [ T1126] amdgpu 0000:08:00.0: amdgpu: reserve 0x400000 
from 0xf42f800000 for PSP TMR
[   14.907109] [ T1126] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras 
ta ucode is not available
[   14.918179] [ T1126] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap 
ta ucode is not available
[   14.918181] [ T1126] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: 
securedisplay ta ucode is not available
[   14.918359] [ T1126] amdgpu 0000:08:00.0: amdgpu: SMU is initialized 
successfully!
[   14.919520] [ T1126] [drm] Display Core v3.2.301 initialized on DCN 2.1
[   14.919522] [ T1126] [drm] DP-HDMI FRL PCON supported
[   14.920071] [ T1126] [drm] DMUB hardware initialized: version=0x0101002B
[   14.953340] [ T1126] [drm] kiq ring mec 2 pipe 1 q 0
[   14.956276] [ T1126] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   14.956287] [ T1126] kfd kfd: amdgpu: Total number of KFD nodes to be 
created: 1
[   14.956373] [ T1126] amdgpu: Virtual CRAT table created for GPU
[   14.956436] [ T1126] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[   14.956438] [ T1126] kfd kfd: amdgpu: added device 1002:1638
[   14.956446] [ T1126] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, 
CU per SH 8, active_cu_number 7
[   14.956449] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM 
inv eng 0 on hub 0
[   14.956450] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 
uses VM inv eng 1 on hub 0
[   14.956451] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 
uses VM inv eng 4 on hub 0
[   14.956453] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 
uses VM inv eng 5 on hub 0
[   14.956454] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 
uses VM inv eng 6 on hub 0
[   14.956455] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 
uses VM inv eng 7 on hub 0
[   14.956456] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 
uses VM inv eng 8 on hub 0
[   14.956457] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 
uses VM inv eng 9 on hub 0
[   14.956458] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 
uses VM inv eng 10 on hub 0
[   14.956459] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring kiq_0.2.1.0 
uses VM inv eng 11 on hub 0
[   14.956460] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM 
inv eng 0 on hub 8
[   14.956461] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses 
VM inv eng 1 on hub 8
[   14.956462] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses 
VM inv eng 4 on hub 8
[   14.956463] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses 
VM inv eng 5 on hub 8
[   14.956464] [ T1126] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses 
VM inv eng 6 on hub 8
[   14.956729] [ T1126] amdgpu 0000:08:00.0: amdgpu: Runtime PM not 
available
[   14.956877] [ T1126] [drm] Initialized amdgpu 3.61.0 for 0000:08:00.0 
on minor 1
[   14.962569] [ T1126] fbcon: amdgpudrmfb (fb0) is primary device
[   14.962676] [ T1126] [drm] pre_validate_dsc:1629 MST_DSC dsc 
precompute is not needed
[   14.997667] [ T1126] Console: switching to colour frame buffer device 
240x67
[   15.015444] [ T1126] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb 
frame buffer device
```

The computer has a CPU with built-in GPU: AMD Ryzen 5 5600G with Radeon 
Graphics.

The kernel is compiled with LLVM/clang-21.1.6 and LTO.

Thanks

~Forzaa
