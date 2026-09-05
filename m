Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B10FC79FAA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EA710E691;
	Mon,  7 Sep 2026 07:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="M4hkv8VP";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E287710E040
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 12:48:14 +0000 (UTC)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hcY645Hc0z5yfq;
 Sat,  5 Sep 2026 14:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1788612492;
 bh=OU5x8yokvCFRppPufZHfMlHFFLJzDvjmknScUM1G23k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M4hkv8VPs8yl+uw2+ks3FT+TlHhtCMlX2km2XEGxl750mS5C8Se8hoDILOnlfdJeo
 c+K38BEtbXUH8SMTdrzRnk2udnD04SGcUK6zGdRhxGufISY6de1Zwpr6UBUlhryyas
 COP1UIJgx4AeH1Bu2SCWMY3mj89jJ6gzmG5Qo6F0Hpgs1xOHg/7ERMtj3jj+znEREV
 1VcobalxQTaQTF2pduH1eiCdjeztMsTTxVGM3JiWO6hVTy5MVc63fWOb6M9UxLnLjW
 qO6auAN23qoG9i7IR5GaptvtO/V5VGVNJC1IgmzJnfABLI7mRSq++fo0Zq6IoIi6wr
 8Nl+lIilPSe6Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hcY643jjKz4yD3;
 Sat,  5 Sep 2026 14:48:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hcY626TP0z8tZK;
 Sat,  5 Sep 2026 14:48:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 382085FC66;
 Sat,  5 Sep 2026 14:48:10 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4b6d96df-297f-4a48-af51-049d2e65302b@leemhuis.info>
Date: Sat, 5 Sep 2026 14:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 7.3-rc1][gfx1150] GPU crash after recoverable gfx
 fault: MES reset fails and KFD queues die
To: Harris Landgarten <harrisl@deeplearntech.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <1703738761.32618.1788387749218.JavaMail.zimbra@lhjonline.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <1703738761.32618.1788387749218.JavaMail.zimbra@lhjonline.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178861249055.3026816.13140888215807878483@mxe9fb.netcup.net>
X-NC-CID: DmbWt5qjeLlihKAGTX6qk3bknU1OH3WVuvNhMhe2szUn3j0aq2s=
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:01:06 +0000
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

On 9/3/26 00:22, Harris Landgarten wrote:
> I am seeing what appears to be a GPU reset/recovery regression on Linux 7.3-rc1 on gfx1150.

Thx for the report. There is still a chance that someone might help your
here, but unless that happens soon I suggest you submit this to the
central place for amdgpu bug report, which is
https://gitlab.freedesktop.org/drm/amd/-/work_items/ -- ideally after
checking for existing reports there. Afterwards please drop a link to
the report here in a reply.

Ciao, Thorsten

> Hardware:
> 
> * Beelink SER9
> * AMD Ryzen AI 9 HX 370
> * Radeon 890M / gfx1150
> * 64 GB RAM
> * GNOME Wayland
> 
> The fault is triggered intermittently while running Opera with Lumosity in expanded view. The trigger is not deterministic, so I have not attempted a bisect.
> 
> The important point is that the same type of initial gfxhub/SQC permission fault also occurs on Linux 7.2.3, but the recovery behavior is very different.
> 
> On 7.2.3, the fault is contained. Opera loses its GPU context, the gfx ring reset succeeds, Opera restarts its GPU process, and the rest of the system continues running.
> 
> Relevant 7.2.3 log:
> 
> ```text
> amdgpu 0000:c5:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:7 pasid:74)
> amdgpu 0000:c5:00.0:  Process opera pid 11770 thread opera:cs0 pid 11785
> amdgpu 0000:c5:00.0:   in page starting at address 0x0000ffff3f800000 from client 10
> amdgpu 0000:c5:00.0: GCVM_L2_PROTECTION_FAULT_STATUS:0x00701430
> amdgpu 0000:c5:00.0:          Faulty UTCL2 client ID: SQC (data) (0xa)
> amdgpu 0000:c5:00.0:          MORE_FAULTS: 0x0
> amdgpu 0000:c5:00.0:          WALKER_ERROR: 0x0
> amdgpu 0000:c5:00.0:          PERMISSION_FAULTS: 0x3
> amdgpu 0000:c5:00.0:          MAPPING_ERROR: 0x0
> amdgpu 0000:c5:00.0:          RW: 0x0
> amdgpu 0000:c5:00.0: ring gfx_0.0.0 timeout, signaled seq=10957, emitted seq=10959
> amdgpu 0000:c5:00.0:  Process opera pid 11770 thread opera:cs0 pid 11785
> amdgpu 0000:c5:00.0: Starting gfx_0.0.0 ring reset
> opera.desktop[11770]: SharedContextState context lost via EXT_robustness. Reset status = GL_INNOCENT_CONTEXT_RESET_KHR
> opera.desktop[11770]: Restarting GPU process due to unrecoverable error. Context was lost.
> amdgpu 0000:c5:00.0: Ring gfx_0.0.0 reset succeeded
> amdgpu 0000:c5:00.0: [drm] device wedged, but no recovery needed
> ```
> 
> On 7.3-rc1, a similar Opera-triggered gfxhub/SQC permission fault eventually escalates into failure of the GPU recovery path. A second gfx ring times out in gnome-shell, MES fails to respond to RESET, the ring reset fails, the driver escalates to a full GPU reset, KFD queues cannot be removed, and an active ROCm Python process is terminated with a GPU Hang.
> 
> Relevant 7.3-rc1 log:
> 
> ```text
> amdgpu 0000:c5:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:4 pasid:191)
> amdgpu 0000:c5:00.0:  Process opera pid 3311317 thread opera:cs0 pid 3311323
> amdgpu 0000:c5:00.0:   in page starting at address 0x000000003b800000 from client 10
> amdgpu 0000:c5:00.0: GCVM_L2_PROTECTION_FAULT_STATUS:0x00401430
> amdgpu 0000:c5:00.0:          Faulty UTCL2 client ID: SQC (data) (0xa)
> amdgpu 0000:c5:00.0:          MORE_FAULTS: 0x0
> amdgpu 0000:c5:00.0:          WALKER_ERROR: 0x0
> amdgpu 0000:c5:00.0:          PERMISSION_FAULTS: 0x3
> amdgpu 0000:c5:00.0:          MAPPING_ERROR: 0x0
> amdgpu 0000:c5:00.0:          RW: 0x0
> 
> amdgpu 0000:c5:00.0: ring gfx_0.1.0 timeout, signaled seq=610533, emitted seq=610534
> amdgpu 0000:c5:00.0:  Process gnome-shell pid 4563 thread gnome-shel:cs0 pid 4582
> amdgpu 0000:c5:00.0: Starting gfx_0.1.0 ring reset
> amdgpu 0000:c5:00.0: MES failed to respond to msg=RESET
> amdgpu 0000:c5:00.0: failed to reset legacy queue
> amdgpu 0000:c5:00.0: Ring gfx_0.1.0 reset failed
> amdgpu 0000:c5:00.0: GPU reset begin!. Source:  1
> amdgpu 0000:c5:00.0: Failed to evict queue 2
> amdgpu: Failed to suspend process pid 36553
> amdgpu 0000:c5:00.0: remove_all_kfd_queues_mes: Failed to remove queue 1 for dev 55238
> HW Exception by GPU node-1 (...) reason :GPU Hang
> ```
> 
> Earlier in the same 7.3-rc1 boot there was also an Opera gfx ring timeout that initially recovered successfully:
> 
> ```text
> amdgpu 0000:c5:00.0: ring gfx_0.0.0 timeout, signaled seq=1413296, emitted seq=1413298
> amdgpu 0000:c5:00.0:  Process opera pid 518561 thread opera:cs0 pid 518596
> amdgpu 0000:c5:00.0: Starting gfx_0.0.0 ring reset
> amdgpu 0000:c5:00.0: Ring gfx_0.0.0 reset succeeded
> amdgpu 0000:c5:00.0: [drm] device wedged, but no recovery needed
> ```
> 
> So the browser workload can trigger a gfx fault on both kernels. The regression I am reporting is the failure of gfx1150 recovery on 7.3-rc1: a fault which is recoverable on 7.2.3 can instead progress to MES RESET failure, failed ring reset, full GPU reset, and loss of active KFD/ROCm queues.
> 
> I have also seen similar GPU crashes on older kernels in the past, but those appeared to have been fixed. Linux 7.2.3 currently demonstrates the expected recovery behavior on this machine.
> 
> I can provide the complete journal logs from a failing 7.3-rc1 run if useful.
> 
> Kernel versions tested:
> 
> * Linux 7.3-rc1: GPU recovery failure reproduced with full system crash.
> * Linux 7.2.3: same class of Opera-triggered gfxhub/SQC fault observed, but gfx ring reset succeeds and the system continues running.
> 
> The system is currently booted into 7.2.3, so a current `uname -a` will show the working comparison kernel rather than the kernel on which the crash occurred.
> uname -a
> 
>  lspci -nnk
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Root Complex [1022:1507]
> 	DeviceName: Device 3
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Root Complex [1022:1507]
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo IOMMU [1022:1508]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo IOMMU [1022:1508]
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Dummy Host Bridge [1022:1509]
> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo PCIe USB4 Bridge [1022:150a]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo PCIe USB4 Bridge [1022:150a]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo PCIe USB4 Bridge [1022:150a]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo PCIe USB4 Bridge [1022:150a]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Dummy Host Bridge [1022:1509]
> 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge [1022:150b]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge [1022:150b]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge [1022:150b]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Dummy Host Bridge [1022:1509]
> 00:03.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge [1022:150b]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Dummy Host Bridge [1022:1509]
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Internal GPP Bridge to Bus [C:A] [1022:150c]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Internal GPP Bridge to Bus [C:A] [1022:150c]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Internal GPP Bridge to Bus [C:A] [1022:150c]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Internal GPP Bridge to Bus [C:A] [1022:150c]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Internal GPP Bridge to Bus [C:A] [1022:150c]
> pcilib: Error reading /sys/bus/pci/devices/0000:00:08.3/label: Operation not permitted
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo Internal GPP Bridge to Bus [C:A] [1022:150c]
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 71)
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b]
> 	Kernel driver in use: piix4_smbus
> 	Kernel modules: i2c_piix4, sp5100_tco
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e]
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 0 [1022:16f8]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 1 [1022:16f9]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 2 [1022:16fa]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 3 [1022:16fb]
> 	Kernel driver in use: k10temp
> 	Kernel modules: k10temp
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 4 [1022:16fc]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 5 [1022:16fd]
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 6 [1022:16fe]
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Strix Data Fabric; Function 7 [1022:16ff]
> c1:00.0 Non-Volatile memory controller [0108]: Micron Technology Inc 2550 NVMe SSD (DRAM-less) [1344:5416] (rev 01)
> 	Subsystem: Micron Technology Inc Device [1344:1100]
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
> c2:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
> 	Subsystem: Intel Corporation Wi-Fi 6 AX200NGW [8086:0084]
> 	Kernel driver in use: iwlwifi
> 	Kernel modules: iwlwifi
> c3:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125] (rev 05)
> 	Subsystem: Realtek Semiconductor Co., Ltd. Device [10ec:0123]
> 	Kernel driver in use: r8169
> 	Kernel modules: r8169
> c4:00.0 Non-Volatile memory controller [0108]: Micron Technology Inc 2550 NVMe SSD (DRAM-less) [1344:5416] (rev 01)
> 	Subsystem: Micron Technology Inc Device [1344:1100]
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
> c5:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI] Strix [Radeon 880M / 890M] [1002:150e] (rev c1)
> 	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:0124]
> 	Kernel driver in use: amdgpu
> 	Kernel modules: amdgpu
> c5:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [Rembrandt/Strix] [1002:1640]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [Rembrandt/Strix] [1002:1640]
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
> c5:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Strix/Krackan/Strix Halo CCP/ASP [1022:17e0]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Krackan/Strix Halo CCP/ASP [1022:17e0]
> 	Kernel driver in use: ccp
> 	Kernel modules: ccp
> c5:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:151e]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:15b9]
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> c5:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] Audio Coprocessor [1022:15e2] (rev 70)
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Audio Coprocessor [1022:15e2]
> 	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x
> c5:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah HD Audio Controller [1022:15e3]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:d997]
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
> c6:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo PCIe Dummy Function [1022:150d]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo PCIe Dummy Function [1022:150d]
> c6:00.1 Signal processing controller [1180]: Advanced Micro Devices, Inc. [AMD] Strix/Krackan/Strix Halo Neural Processing Unit [1022:17f0] (rev 10)
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Strix/Krackan/Strix Halo Neural Processing Unit [1022:17f0]
> c7:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:151f]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:15b9]
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> c7:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:151a]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:151a]
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> c7:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:151b]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:151b]
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> c7:00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB4 Router 0 [1022:151c]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] USB4 Router 0 [1022:151c]
> 	Kernel driver in use: thunderbolt
> 	Kernel modules: thunderbolt
> c7:00.6 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB4 Router 1 [1022:151d]
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] USB4 Router 1 [1022:151d]
> 	Kernel driver in use: thunderbolt
> 	Kernel modules: thunderbolt
> 
> doas cat /sys/kernel/debug/dri/0/amdgpu_firmware_info 
> VCE feature version: 0, firmware version: 0x00000000
> UVD feature version: 0, firmware version: 0x00000000
> MC feature version: 0, firmware version: 0x00000000
> ME feature version: 35, firmware version: 0x00000021
> PFP feature version: 35, firmware version: 0x00000035
> CE feature version: 0, firmware version: 0x00000000
> RLC feature version: 1, firmware version: 0x1151054a
> RLC SRLC feature version: 0, firmware version: 0x00000000
> RLC SRLG feature version: 0, firmware version: 0x00000000
> RLC SRLS feature version: 0, firmware version: 0x00000000
> RLCP feature version: 1, firmware version: 0x11510341
> RLCV feature version: 0, firmware version: 0x00000000
> MEC feature version: 35, firmware version: 0x00000024
> IMU feature version: 0, firmware version: 0x0b331d00
> SOS feature version: 0, firmware version: 0x00000000
> ASD feature version: 553648405, firmware version: 0x21000115
> TA XGMI feature version: 0x00000000, firmware version: 0x00000000
> TA RAS feature version: 0x00000000, firmware version: 0x00000000
> TA HDCP feature version: 0x00000000, firmware version: 0x17000052
> TA DTM feature version: 0x00000000, firmware version: 0x1200001e
> TA RAP feature version: 0x00000000, firmware version: 0x00000000
> TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
> SMC feature version: 0, program: 9, firmware version: 0x095d0e00 (93.14.0)
> SDMA0 feature version: 60, firmware version: 0x0000000f
> VCN feature version: 0, firmware version: 0x09118022
> DMCU feature version: 0, firmware version: 0x00000000
> DMCUB feature version: 0, firmware version: 0x09005100
> TOC feature version: 0, firmware version: 0x0000000b
> MES_KIQ feature version: 6, firmware version: 0x00000075
> MES feature version: 1, firmware version: 0x00000091
> VPE feature version: 60, firmware version: 0x0000003d
> VBIOS version: 113-STRIXEMU-001
> 
> 
> 
> 

