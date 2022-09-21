Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDBFC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 07:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B3C10E281;
	Wed, 21 Sep 2022 07:37:35 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9036710E85B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 06:56:33 +0000 (UTC)
Received: by mail-ua1-x932.google.com with SMTP id z14so1986925uam.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ellismichael.com; s=google;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date; bh=3LSFLVW24wnPdweAnkKQC3e9vz1XdGo3VtzC1mLLjao=;
 b=NY4YqA585i8KMVBocQxN5EPUcDWAQRBp92Ixaf5T9tlLvR43YGbPWEgPYp9IxjqzJY
 0gITwKAMSkj1AoI9QbIP42EAJR9+xnIG+PmaLilehtEGFWlupZUJz5dahT3PzCCE/4GN
 FIY5yg5T3wX/2T/WGL5Z6axps8sLxMW1lspuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date;
 bh=3LSFLVW24wnPdweAnkKQC3e9vz1XdGo3VtzC1mLLjao=;
 b=0vyF2btNXRwsfPpsg+vbYm29xKDKRpjLhNfSksJmsQxwz4U14ZppDDEh3XBuBuWixS
 9dJYmTkzXhDAuYeGtBu7wGY1X4F15tWEjcLbindX3ompqopmbzGL9KTZ8DgvGSOeH0iy
 R6I1If3sMIDQsvc4vgpgccWdvU+Celvvfi+qHkjewCN0bBCNtPRVopIM9UpHOldrKkuj
 3iXFkoiFcUxVS4mbpV1mqccFpfex1j4m3hBnIhSoK/ru6hlRRucMZlQZRzC1aomXlVSS
 LJV/ZIHP+tYCH0yIRsV4U8CTewWai/S44oH4QIZPzFYqLzDU0ARh4wk1MnxLYXY0++eq
 fF6Q==
X-Gm-Message-State: ACrzQf314PIBt9MVh323lDG/ilO3HlZ1NcUFMJfZOHpRZCcR6TYroOnu
 LIykM66/TghQJSMcKAqA9HkXVFnBKgXG6A==
X-Google-Smtp-Source: AMsMyM5GbgUxgi5/Lbpd+rQQJ69qZ4ZdmHvMdx/cgaEDZA0VQdTRokFbYAbFPzUBPW45p5Ws+qZjVQ==
X-Received: by 2002:ab0:74cf:0:b0:3b7:4f7c:2ddf with SMTP id
 f15-20020ab074cf000000b003b74f7c2ddfmr9821293uaq.103.1663743391333; 
 Tue, 20 Sep 2022 23:56:31 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 d3-20020ab02103000000b0039f721a88b4sm369287ual.9.2022.09.20.23.56.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Sep 2022 23:56:30 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id k2so5658811vsk.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 23:56:30 -0700 (PDT)
X-Received: by 2002:a67:db0d:0:b0:388:6e87:fd17 with SMTP id
 z13-20020a67db0d000000b003886e87fd17mr10073847vsj.64.1663743390024; Tue, 20
 Sep 2022 23:56:30 -0700 (PDT)
MIME-Version: 1.0
From: Ellis Michael <ellis@ellismichael.com>
Date: Tue, 20 Sep 2022 23:56:04 -0700
X-Gmail-Original-Message-ID: <CAGTTKFv0uiViGJS5UmDkM00ms0ieDiksmCON4a_3FBBayTS1-g@mail.gmail.com>
Message-ID: <CAGTTKFv0uiViGJS5UmDkM00ms0ieDiksmCON4a_3FBBayTS1-g@mail.gmail.com>
Subject: PROBLEM: UBSAN error in kfd_device_queue_manager.c
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 21 Sep 2022 07:37:32 +0000
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reporting an undefined behavior issue in the amdgpu driver in the
linux kernel I ran into recently. It appears during boot, fairly early
in the process.


[drm] UVD initialized successfully.
[drm] VCE initialized successfully.
kfd kfd: amdgpu: Allocated 3969056 bytes on gart
================================================================================

UBSAN: shift-out-of-bounds in
/build/linux-kQ6jNR/linux-5.15.0/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:997:32
shift exponent 64 is too large for 64-bit type 'long long unsigned int'
CPU: 10 PID: 483 Comm: systemd-udevd Not tainted 5.15.0-48-generic #54-Ubuntu
Hardware name: To Be Filled By O.E.M. B550M Pro4/B550M Pro4, BIOS
P2.30 02/24/2022
Call Trace:
 <TASK>
 show_stack+0x52/0x5c
 dump_stack_lvl+0x4a/0x63
 dump_stack+0x10/0x16
 ubsan_epilogue+0x9/0x49
 __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
 initialize_nocpsch.cold+0x15/0x59 [amdgpu]
 device_queue_manager_init+0x20b/0x3b0 [amdgpu]
 kgd2kfd_device_init.cold+0x1af/0x483 [amdgpu]
 amdgpu_amdkfd_device_init+0x135/0x170 [amdgpu]
 amdgpu_device_ip_init+0x681/0x6a4 [amdgpu]
loop33: detected capacity change from 0 to 8
 amdgpu_device_init.cold+0x25b/0x7db [amdgpu]
 ? do_pci_enable_device+0xdb/0x110
 amdgpu_driver_load_kms+0x1e/0x270 [amdgpu]
 amdgpu_pci_probe+0x1ce/0x260 [amdgpu]
 local_pci_probe+0x4b/0x90
 pci_device_probe+0x119/0x1f0
 really_probe+0x222/0x420
 __driver_probe_device+0x119/0x190
 driver_probe_device+0x23/0xc0
 __driver_attach+0xbd/0x1e0
 ? __device_attach_driver+0x120/0x120
 bus_for_each_dev+0x7e/0xd0
 driver_attach+0x1e/0x30
 bus_add_driver+0x148/0x220
 driver_register+0x95/0x100
 __pci_register_driver+0x68/0x70
 amdgpu_init+0x7c/0x1000 [amdgpu]
 ? 0xffffffffc1a40000
 do_one_initcall+0x48/0x1e0
 ? kmem_cache_alloc_trace+0x19e/0x2e0
 do_init_module+0x52/0x260
 load_module+0xacd/0xbc0
 __do_sys_finit_module+0xbf/0x120
 __x64_sys_finit_module+0x18/0x20
 do_syscall_64+0x5c/0xc0
 ? syscall_exit_to_user_mode+0x27/0x50
 ? __x64_sys_newfstatat+0x1c/0x30
 ? do_syscall_64+0x69/0xc0
 ? __x64_sys_mmap+0x33/0x50
 ? do_syscall_64+0x69/0xc0
 ? do_syscall_64+0x69/0xc0
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f06f3fb9a3d
Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d c3 a3 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc7ce54ae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000556c9ab3e3d0 RCX: 00007f06f3fb9a3d
RDX: 0000000000000000 RSI: 00007f06f4150441 RDI: 000000000000001a
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
R10: 000000000000001a R11: 0000000000000246 R12: 00007f06f4150441
R13: 0000556c9aa05fb0 R14: 0000556c9ab40460 R15: 0000556c9ab35150
 </TASK>
================================================================================
amdgpu: SW scheduler is used
amdgpu: SRAT table not found
amdgpu: Virtual CRAT table created for GPU
amdgpu: Topology: Add dGPU node [0x6938:0x1002]
kfd kfd: amdgpu: added device 1002:6938
amdgpu 0000:06:00.0: amdgpu: SE 4, SH per SE 1, CU per SH 8, active_cu_number 32
[drm] fb mappable at 0xD1813000
[drm] vram apper at 0xD0000000
[drm] size 19906560
[drm] fb depth is 24
[drm]    pitch is 13824
fbcon: amdgpudrmfb (fb0) is primary device


This only started recently, possibly after I replaced my motherboard
and CPU (though, not my GPU).

Quick info on my system:
Ubuntu 22.04.1, kernel version 5.15.0-48
Ryzen 5600
ASRock B550m Pro4
R9 380X (STRIX-R9380X-OC4G-GAMING)


This is potentially related to a bug I recently reported to the Ubuntu
bug tracker where my display wouldn't come back from being blank, and
I would see series of messages of the form:
amdgpu:
    last message was failed ret is 0
amdgpu:
    failed to send message 145 ret is 0
amdgpu:
    last message was failed ret is 0
amdgpu:
    failed to send message 146 ret is 0

That bug is here: https://bugs.launchpad.net/ubuntu/+bug/1990323/

I suspect that I should probably report it to this mailing list,
though, and I'm happy to send a separate email if you want me to.
Please let me know if there's any other information you need for me or
anything I can do.

Thanks!



More thorough information on my system:
$ cat /proc/version
Linux version 5.15.0-48-generic (buildd@lcy02-amd64-080) (gcc (Ubuntu
11.2.0-19ubuntu1) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.38)
#54-Ubuntu SMP Fri Aug 26 13:26:29 UTC 2022

$ lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Root Complex
Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin ? routed to IRQ 26
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff [disabled]
Memory behind bridge: fcf00000-fcffffff [size=1M]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin ? routed to IRQ 27
Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
I/O behind bridge: 0000f000-0000ffff [size=4K]
Memory behind bridge: fcb00000-fcdfffff [size=3M]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin ? routed to IRQ 28
Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
I/O behind bridge: 0000e000-0000efff [size=4K]
Memory behind bridge: fce00000-fcefffff [size=1M]
Prefetchable memory behind bridge: 00000000d0000000-00000000e01fffff [size=258M]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:05.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:07.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:07.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 30
Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
I/O behind bridge: 0000f000-00000fff [disabled]
Memory behind bridge: fff00000-000fffff [disabled]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 31
Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
I/O behind bridge: 0000f000-00000fff [disabled]
Memory behind bridge: fc800000-fcafffff [size=3M]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 61)
Subsystem: ASRock Incorporation FCH SMBus Controller
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: piix4_smbus
Kernel modules: i2c_piix4, sp5100_tco

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
Subsystem: ASRock Incorporation FCH LPC Bridge
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 0
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 1
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 2
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 3
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: k10temp
Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 4
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 5
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 6
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 7
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 Non-Volatile memory controller: Sandisk Corp Device 5030 (rev
01) (prog-if 02 [NVM Express])
Subsystem: Sandisk Corp Device 5030
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 39
NUMA node: 0
Region 0: Memory at fcf00000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: nvme
Kernel modules: nvme

02:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Device 43ee
(prog-if 30 [XHCI])
Subsystem: ASMedia Technology Inc. Device 1142
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 34
Region 0: Memory at fcda0000 (64-bit, non-prefetchable) [size=32K]
Capabilities: <access denied>
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci

02:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] Device
43eb (prog-if 01 [AHCI 1.0])
Subsystem: ASMedia Technology Inc. Device 1062
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 38
Region 5: Memory at fcd80000 (32-bit, non-prefetchable) [size=128K]
Expansion ROM at fcd00000 [disabled] [size=512K]
Capabilities: <access denied>
Kernel driver in use: ahci
Kernel modules: ahci

02:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43e9
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin C routed to IRQ 33
Bus: primary=02, secondary=03, subordinate=05, sec-latency=0
I/O behind bridge: 0000f000-0000ffff [size=4K]
Memory behind bridge: fcb00000-fccfffff [size=2M]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

03:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 35
Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
I/O behind bridge: 0000f000-00000fff [disabled]
Memory behind bridge: fcc00000-fccfffff [size=1M]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

03:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 36
Bus: primary=03, secondary=05, subordinate=05, sec-latency=0
I/O behind bridge: 0000f000-0000ffff [size=4K]
Memory behind bridge: fcb00000-fcbfffff [size=1M]
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

04:00.0 Non-Volatile memory controller: Sandisk Corp Device 5014
(prog-if 02 [NVM Express])
Subsystem: Sandisk Corp Device 5014
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 34
NUMA node: 0
Region 0: Memory at fcc00000 (64-bit, non-prefetchable) [size=16K]
Region 4: Memory at fcc04000 (64-bit, non-prefetchable) [size=256]
Capabilities: <access denied>
Kernel driver in use: nvme
Kernel modules: nvme

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
Subsystem: ASRock Incorporation Motherboard (one of many)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 34
Region 0: I/O ports at f000 [size=256]
Region 2: Memory at fcb04000 (64-bit, non-prefetchable) [size=4K]
Region 4: Memory at fcb00000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: r8169
Kernel modules: r8169

06:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Tonga XT / Amethyst XT [Radeon R9 380X / R9 M295X] (rev f1)
(prog-if 00 [VGA controller])
Subsystem: ASUSTeK Computer Inc. Tonga XT / Amethyst XT [Radeon R9
380X / R9 M295X]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 116
Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at e0000000 (64-bit, prefetchable) [size=2M]
Region 4: I/O ports at e000 [size=256]
Region 5: Memory at fce00000 (32-bit, non-prefetchable) [size=256K]
Expansion ROM at fce40000 [disabled] [size=128K]
Capabilities: <access denied>
Kernel driver in use: amdgpu
Kernel modules: amdgpu

06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Tonga
HDMI Audio [Radeon R9 285/380]
Subsystem: ASUSTeK Computer Inc. Tonga HDMI Audio [Radeon R9 285/380]
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 112
Region 0: Memory at fce60000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

07:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Starship/Matisse PCIe Dummy Function
Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe
Dummy Function
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: <access denied>

08:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Starship/Matisse Reserved SPP
Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: <access denied>

08:00.1 Encryption controller: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Cryptographic Coprocessor PSPCPP
Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse
Cryptographic Coprocessor PSPCPP
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 108
Region 2: Memory at fc900000 (32-bit, non-prefetchable) [size=1M]
Region 5: Memory at fca08000 (32-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>
Kernel driver in use: ccp
Kernel modules: ccp

08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB
3.0 Host Controller (prog-if 30 [XHCI])
Subsystem: ASRock Incorporation Matisse USB 3.0 Host Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin C routed to IRQ 99
Region 0: Memory at fc800000 (64-bit, non-prefetchable) [size=1M]
Capabilities: <access denied>
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci

08:00.4 Audio device: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse HD Audio Controller
Subsystem: ASRock Incorporation Starship/Matisse HD Audio Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin D routed to IRQ 114
Region 0: Memory at fca00000 (32-bit, non-prefetchable) [size=32K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

$ cat /proc/cpuinfo
processor : 0
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 0
cpu cores : 6
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 1
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 1
cpu cores : 6
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 2
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 2
cpu cores : 6
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 3
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 3
cpu cores : 6
apicid : 6
initial apicid : 6
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 4
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 4
cpu cores : 6
apicid : 8
initial apicid : 8
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 5
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 5
cpu cores : 6
apicid : 10
initial apicid : 10
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 6
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 0
cpu cores : 6
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 7
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 1
cpu cores : 6
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 8
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2800.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 2
cpu cores : 6
apicid : 5
initial apicid : 5
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 9
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 3
cpu cores : 6
apicid : 7
initial apicid : 7
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 10
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2200.000
cache size : 512 KB
physical id : 0
siblings : 12
core id : 4
cpu cores : 6
apicid : 9
initial apicid : 9
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

processor : 11
vendor_id : AuthenticAMD
cpu family : 25
model : 33
model name : AMD Ryzen 5 5600 6-Core Processor
stepping : 2
microcode : 0xa201205
cpu MHz : 2201.672
cache size : 512 KB
physical id : 0
siblings : 12
core id : 5
cpu cores : 6
apicid : 11
initial apicid : 11
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov
succor smca
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips : 6987.09
TLB size : 2560 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

$ cat /proc/modules
rfcomm 81920 21 - Live 0x0000000000000000
vboxnetadp 28672 0 - Live 0x0000000000000000 (O)
vboxnetflt 28672 0 - Live 0x0000000000000000 (O)
vboxdrv 573440 2 vboxnetadp,vboxnetflt, Live 0x0000000000000000 (O)
rpcsec_gss_krb5 36864 0 - Live 0x0000000000000000
auth_rpcgss 139264 1 rpcsec_gss_krb5, Live 0x0000000000000000
nfsv4 843776 2 - Live 0x0000000000000000
nfs 393216 3 nfsv4, Live 0x0000000000000000
lockd 110592 1 nfs, Live 0x0000000000000000
grace 16384 1 lockd, Live 0x0000000000000000
fscache 385024 1 nfs, Live 0x0000000000000000
netfs 45056 1 fscache, Live 0x0000000000000000
ip6t_REJECT 16384 1 - Live 0x0000000000000000
nf_reject_ipv6 20480 1 ip6t_REJECT, Live 0x0000000000000000
xt_hl 16384 22 - Live 0x0000000000000000
ip6_tables 32768 52 - Live 0x0000000000000000
ip6t_rt 20480 3 - Live 0x0000000000000000
ipt_REJECT 16384 1 - Live 0x0000000000000000
nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
xt_LOG 20480 10 - Live 0x0000000000000000
nf_log_syslog 20480 10 - Live 0x0000000000000000
cmac 16384 3 - Live 0x0000000000000000
algif_hash 16384 1 - Live 0x0000000000000000
algif_skcipher 16384 1 - Live 0x0000000000000000
af_alg 32768 6 algif_hash,algif_skcipher, Live 0x0000000000000000
bnep 28672 2 - Live 0x0000000000000000
nft_limit 16384 13 - Live 0x0000000000000000
xt_limit 16384 0 - Live 0x0000000000000000
xt_addrtype 16384 4 - Live 0x0000000000000000
intel_rapl_msr 20480 0 - Live 0x0000000000000000
intel_rapl_common 40960 1 intel_rapl_msr, Live 0x0000000000000000
xt_tcpudp 20480 20 - Live 0x0000000000000000
xt_conntrack 16384 16 - Live 0x0000000000000000
nf_conntrack 172032 1 xt_conntrack, Live 0x0000000000000000
nf_defrag_ipv6 24576 1 nf_conntrack, Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack, Live 0x0000000000000000
nft_compat 20480 137 - Live 0x0000000000000000
nft_counter 16384 172 - Live 0x0000000000000000
snd_hda_codec_realtek 159744 1 - Live 0x0000000000000000
snd_hda_codec_generic 102400 1 snd_hda_codec_realtek, Live 0x0000000000000000
sunrpc 585728 10 rpcsec_gss_krb5,auth_rpcgss,nfsv4,nfs,lockd, Live
0x0000000000000000
ledtrig_audio 16384 1 snd_hda_codec_generic, Live 0x0000000000000000
edac_mce_amd 36864 0 - Live 0x0000000000000000
amdgpu 9854976 84 - Live 0x0000000000000000
snd_hda_codec_hdmi 77824 1 - Live 0x0000000000000000
nf_tables 245760 395 nft_limit,nft_compat,nft_counter, Live 0x0000000000000000
binfmt_misc 24576 1 - Live 0x0000000000000000
snd_usb_audio 352256 1 - Live 0x0000000000000000
libcrc32c 16384 2 nf_conntrack,nf_tables, Live 0x0000000000000000
snd_hda_intel 53248 5 - Live 0x0000000000000000
nfnetlink 20480 2 nft_compat,nf_tables, Live 0x0000000000000000
snd_usbmidi_lib 45056 1 snd_usb_audio, Live 0x0000000000000000
snd_intel_dspcfg 28672 1 snd_hda_intel, Live 0x0000000000000000
kvm_amd 155648 0 - Live 0x0000000000000000
snd_intel_sdw_acpi 20480 1 snd_intel_dspcfg, Live 0x0000000000000000
snd_hda_codec 163840 4
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,
Live 0x0000000000000000
kvm 1028096 1 kvm_amd, Live 0x0000000000000000
snd_hda_core 110592 5
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
gspca_vc032x 36864 0 - Live 0x0000000000000000
snd_hwdep 16384 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
btusb 61440 0 - Live 0x0000000000000000
snd_pcm 143360 5
snd_hda_codec_hdmi,snd_usb_audio,snd_hda_intel,snd_hda_codec,snd_hda_core,
Live 0x0000000000000000
btrtl 24576 1 btusb, Live 0x0000000000000000
uvcvideo 106496 0 - Live 0x0000000000000000
btbcm 24576 1 btusb, Live 0x0000000000000000
crct10dif_pclmul 16384 1 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
gspca_main 36864 1 gspca_vc032x, Live 0x0000000000000000
btintel 40960 1 btusb, Live 0x0000000000000000
videobuf2_vmalloc 20480 2 uvcvideo,gspca_main, Live 0x0000000000000000
aesni_intel 376832 4 - Live 0x0000000000000000
videobuf2_memops 20480 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 32768 2 uvcvideo,gspca_main, Live 0x0000000000000000
iommu_v2 24576 1 amdgpu, Live 0x0000000000000000
bluetooth 704512 53 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
videobuf2_common 77824 5
uvcvideo,gspca_main,videobuf2_vmalloc,videobuf2_memops,videobuf2_v4l2,
Live 0x0000000000000000
snd_seq_midi 20480 0 - Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,crypto_simd, Live 0x0000000000000000
gpu_sched 45056 1 amdgpu, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
videodev 258048 5
gspca_vc032x,uvcvideo,gspca_main,videobuf2_v4l2,videobuf2_common, Live
0x0000000000000000
ecdh_generic 16384 2 bluetooth, Live 0x0000000000000000
drm_ttm_helper 16384 1 amdgpu, Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
ecc 36864 1 ecdh_generic, Live 0x0000000000000000
mc 65536 5 snd_usb_audio,uvcvideo,videobuf2_v4l2,videobuf2_common,videodev,
Live 0x0000000000000000
rapl 20480 0 - Live 0x0000000000000000
joydev 32768 0 - Live 0x0000000000000000
snd_rawmidi 49152 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
ttm 86016 2 amdgpu,drm_ttm_helper, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
snd_seq 77824 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
drm_kms_helper 311296 1 amdgpu, Live 0x0000000000000000
wmi_bmof 16384 0 - Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
cec 61440 1 drm_kms_helper, Live 0x0000000000000000
snd_timer 40960 2 snd_pcm,snd_seq, Live 0x0000000000000000
rc_core 65536 1 cec, Live 0x0000000000000000
i2c_algo_bit 16384 1 amdgpu, Live 0x0000000000000000
k10temp 16384 0 - Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
snd 106496 25 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_usb_audio,snd_hda_intel,snd_usbmidi_lib,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 20480 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
ccp 102400 1 kvm_amd, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
sch_fq_codel 20480 2 - Live 0x0000000000000000
cuse 16384 3 - Live 0x0000000000000000
nct6775 102400 0 - Live 0x0000000000000000
hwmon_vid 16384 1 nct6775, Live 0x0000000000000000
ipmi_devintf 20480 0 - Live 0x0000000000000000
ipmi_msghandler 122880 1 ipmi_devintf, Live 0x0000000000000000
msr 16384 0 - Live 0x0000000000000000
parport_pc 49152 0 - Live 0x0000000000000000
ppdev 24576 0 - Live 0x0000000000000000
lp 28672 0 - Live 0x0000000000000000
parport 69632 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ramoops 32768 0 - Live 0x0000000000000000
reed_solomon 28672 1 ramoops, Live 0x0000000000000000
pstore_blk 16384 0 - Live 0x0000000000000000
pstore_zone 32768 1 pstore_blk, Live 0x0000000000000000
mtd 77824 0 - Live 0x0000000000000000
drm 622592 31 amdgpu,gpu_sched,drm_ttm_helper,ttm,drm_kms_helper, Live
0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
ip_tables 32768 8 - Live 0x0000000000000000
x_tables 53248 12
ip6t_REJECT,xt_hl,ip6_tables,ip6t_rt,ipt_REJECT,xt_LOG,xt_limit,xt_addrtype,xt_tcpudp,xt_conntrack,nft_compat,ip_tables,
Live 0x0000000000000000
autofs4 49152 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 65536 0 - Live 0x0000000000000000
hid 151552 2 hid_generic,usbhid, Live 0x0000000000000000
nvme 49152 3 - Live 0x0000000000000000
r8169 102400 0 - Live 0x0000000000000000
gpio_amdpt 20480 0 - Live 0x0000000000000000
xhci_pci 24576 0 - Live 0x0000000000000000
ahci 45056 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
realtek 32768 1 - Live 0x0000000000000000
i2c_piix4 32768 0 - Live 0x0000000000000000
nvme_core 135168 5 nvme, Live 0x0000000000000000
libahci 45056 1 ahci, Live 0x0000000000000000
xhci_pci_renesas 20480 1 xhci_pci, Live 0x0000000000000000
wmi 32768 1 wmi_bmof, Live 0x0000000000000000
gpio_generic 20480 1 gpio_amdpt, Live 0x0000000000000000
