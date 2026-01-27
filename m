Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D78ED2592B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB8010E645;
	Wed, 28 Jan 2026 10:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="T1dexUoy";
	dkim-atps=neutral
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C97410E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 14:28:23 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso50651535e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769524101;
 x=1770128901; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S63dU78a3Znyblh1XR9U7xz3eYtCr6IqN/77n+ctexc=;
 b=T1dexUoyH6fe2askY3NF8re2GgxteCvX6JBSdsuvjeNDjYwQKEE7PNhR6PFEGr7Jg2
 CVv6f+K3WaYZ8JbrSCCoD1MtQv4q/natpv6un31PK5jOBpcpqxowUyUcCR4zh7ZXCXSN
 FvZ8IiDixdsBlZWgtnMZ3IC8M8WE0T2xWx7NYLaPWZ6lifq2Ca8RoBYqQ2HT7f1KY5u2
 w+EIjfhLFjSDYjt8XkmfaP+HB3DKwiMyGeN1KOsRxeJLq4iGYgAxqbONp72IIVpSsa2+
 AiqiX5g+MIZzdRfMCUdwhyjriZTnoRC/bsfSQfDWQ6iUgpbZgJ93nAOHZhYX8fg9MdXV
 Wucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769524101; x=1770128901;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S63dU78a3Znyblh1XR9U7xz3eYtCr6IqN/77n+ctexc=;
 b=dxBgGxw8KC1KMx14e8puHvVLDJFK+vwOH33CA3pxMXfZKJ3NtprizhnjcHPVLNlzjG
 L8UW+BuXYGTIgPX2nU0/a2Wwnb+Ryf/25uwPgg1drDjl7ZBssAv/nnpkshPeC8neKpwb
 N6ySVqGLFyHDhw/zHpNwrOtgAk0S48zLfJoJG6xRYoLwunIfgVh/TocCJOjpNTd3CX37
 /UDdJ0Yypm710XSwuth16Kq7y5DhxZsRBqKBy9lmQRb+409uU0saMOnmbDyCsMVnpykO
 4MR2z41W8GAgiCTFTosg4msAZ2tQX2yR+9tc8D0l17Vvoq6vZI0wFLJ4Z8trPWkABw6n
 aAYw==
X-Gm-Message-State: AOJu0YzGE+rSEtXhDCB2Bi247H3FIH1eCBGG7ejUdY5vpgEQbjn7Ecx0
 UEj2Yx1hbd2B3mY4E7OOitQtA/afxaSjI9GLIqzr8/wFm+UjuHDh9liMZaLaBWY26DE=
X-Gm-Gg: AZuq6aKo+TUQDzZoAJqBaN/2l1v3tRCHxu2+51hV6w77c86ZG5wLjICyeMMvQ2GWX3n
 Nr6qhmQ2UUSD2fBaXbG4NoZCDLLtQ9Yv1nZQhFUdBTbsY5EWnlw65q1lkahzKvEeU4Xiuu2zN6r
 wZG441ugzismn87IIP9LGKbtSPSWyVuShwT7wfpZqeiMJVVuWS0NBzgbW/YTJdamA++TvaKi+NY
 ZH/hBMWcR+gL4nYrIIch/7Gt7bIXBnUg3uSwMKXxkTXL68H+W3eTEHuWTbNBju646XYDQIqx+6V
 N/rZudsidqCoZlcJV//SzuUXg53nbcfXajhoRS5H6FXpotsz05yifbsKNPEwj095WGseLaTXVbf
 NXaR1RSB4uiFPztakBNYAbDXQBGKJmrpRKAftXSMcZ+M58IbLt09RMxsoTLnLxP5gnl9gEtVfvQ
 lt6A0QUEHfWR696uOzakESqPnwf6o0/+tPd+xHW/Dh8JqbA6YJ0wvR
X-Received: by 2002:a05:600c:4f0f:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-48069e23ecbmr26549885e9.1.1769524100685; 
 Tue, 27 Jan 2026 06:28:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm68149015e9.14.2026.01.27.06.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:28:20 -0800 (PST)
Date: Tue, 27 Jan 2026 06:28:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org
Subject: [BUG] screen lockup on AMD Radeon RX 7600 GPU
Message-ID: <20260127062811.5d0769d2@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 28 Jan 2026 10:55:00 +0000
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

One of my systems with dual monitors often locks up one screen,
usually when running firefox. That whole screen is frozen, but
other screen still works. This feels like an AMD GPU driver bug.
It is not easily repeatable, can happen once or twice per day.
Has happened since the system was setup; not a new regression.

System is Minisforum Atomman G7 PT running Debian testing. 6.17.13+deb14-amd64


Kernel log GPU related: dmesg | grep amdgpu
[    2.149257] [drm] amdgpu kernel modesetting enabled.
[    2.149337] amdgpu: Virtual CRAT table created for CPU
[    2.149350] amdgpu: Topology: Add CPU node
[    2.149441] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
[    2.149488] amdgpu 0000:03:00.0: amdgpu: initializing kernel modesetting (IP DISCOVERY 0x1002:0x7480 0x1F4C:0xB006 0xC7).
[    2.149497] amdgpu 0000:03:00.0: amdgpu: register mmio base: 0xFC900000
[    2.149498] amdgpu 0000:03:00.0: amdgpu: register mmio size: 1048576
[    2.153103] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <soc21_common>
[    2.153105] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v11_0>
[    2.153106] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <ih_v6_0>
[    2.153107] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[    2.153109] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[    2.153110] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[    2.153111] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v11_0>
[    2.153112] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v6_0>
[    2.153114] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v4_0>
[    2.153115] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v4_0>
[    2.153116] amdgpu 0000:03:00.0: amdgpu: detected ip block number 10 <mes_v11_0>
[    2.153128] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.153129] amdgpu: ATOM BIOS: 113-BRT138292-001
[    2.153763] amdgpu 0000:03:00.0: amdgpu: CP RS64 enable
[    2.154833] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    2.154834] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    2.154888] amdgpu 0000:03:00.0: amdgpu: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.154893] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
[    2.154894] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.154982] amdgpu 0000:03:00.0: amdgpu: amdgpu: 8176M of VRAM memory ready
[    2.154985] amdgpu 0000:03:00.0: amdgpu: amdgpu: 32003M of GTT memory ready.
[    2.155359] amdgpu 0000:03:00.0: amdgpu: [drm] Loading DMUB firmware via PSP: version=0x07002F00
[    2.155502] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 22
[    2.211656] amdgpu 0000:03:00.0: amdgpu: reserve 0x1300000 from 0x81fc000000 for PSP TMR
[    2.307864] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    2.315456] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    2.315457] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    2.315485] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x00000035, smu fw if version = 0x00000040, smu fw program = 0, smu fw version = 0x00525e00 (82.94.0)
[    2.315487] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[    2.357021] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    2.357469] amdgpu 0000:03:00.0: amdgpu: [drm] Display Core v3.2.340 initialized on DCN 3.2.1
[    2.357471] amdgpu 0000:03:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
[    2.359421] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x07002F00
[    2.690664] amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 150000 tries - optc32_disable_crtc line:195
[    2.723979] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.724019] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.878979] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.945932] amdgpu: HMM registered 8176MB device memory
[    2.946972] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    2.946984] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    2.947017] amdgpu: Virtual CRAT table created for GPU
[    2.947113] amdgpu: Topology: Add dGPU node [0x7480:0x1002]
[    2.947115] kfd kfd: amdgpu: added device 1002:7480
[    2.947126] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8, active_cu_number 32
[    2.947129] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    2.947131] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.947132] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.947133] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    2.947134] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    2.947136] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    2.947137] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    2.947138] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    2.947139] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    2.947140] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[    2.947141] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
[    2.947143] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    2.947144] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[    2.947145] amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
[    2.948463] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm
[    2.948731] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
[    2.951967] amdgpu 0000:03:00.0: amdgpu: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22 
[    2.955225] fbcon: amdgpudrmfb (fb0) is primary device
[    3.253830] amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 150000 tries - optc32_disable_crtc line:195
[    3.413948] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    5.866585] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[ 1903.594221] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0] flip_done timed out


Devices: lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge
00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A]
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A]
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 71)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstream Port of PCI Express Switch (rev 12)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream Port of PCI Express Switch (rev 12)
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 33 [Radeon RX 7600/7600 XT/7600M XT/7600S/7700S / PRO W7600] (rev c7)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 31 HDMI/DP Audio
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
05:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
06:00.0 Network controller: MEDIATEK Corp. MT7925 802.11be 160MHz 2x2 PCIe Wireless Network Adapter [Filogic 360]
07:00.0 Ethernet controller: Intel Corporation Ethernet Controller I226-V (rev 04)
08:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge PCIe Dummy Function (rev d8)
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 19h PSP/CCP
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI
08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI
08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Audio Coprocessor (rev 62)
08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Ryzen HD Audio Controller
09:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 2.0 xHCI


Full kernel log:
[    0.000000] Linux version 6.17.13+deb14-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-15 (Debian 15.2.0-12) 15.2.0, GNU ld (GNU Binutils for Debian) 2.45.50.20251209) #1 SMP PREEMPT_DYNAMIC Debian 6.17.13-1 (2025-12-20)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.17.13+deb14-amd64 root=UUID=64d3d740-d9ee-4045-a5a4-c5608861a5bb ro iommu=pt quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009aff000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a211fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a212000-0x00000000aea01fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000aea02000-0x00000000b4a01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b4a02000-0x00000000b4b01fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000b4b02000-0x00000000b6b01fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b6b02000-0x00000000babfefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000babff000-0x00000000bbffcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bbffd000-0x00000000bcffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bd7f3000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000103de7ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000103eec0000-0x00000010601fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=0xb6aea000 ACPI 2.0=0xb6aea014 TPMFinalLog=0xb6ab7000 SMBIOS=0xba892000 SMBIOS 3.0=0xba891000 MEMATTR=0xab8d9018 ESRT=0xaa556e18 MOKvar=0xbaa7b000 INITRD=0xa95bba98 RNG=0xb4ab9018 TPMEventLog=0xb4aad018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem49: MMIO range=[0xf0000000-0xf7ffffff] (128MB) from e820 map
[    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000] efi: Remove mem50: MMIO range=[0xfd000000-0xfedfffff] (30MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] reserved
[    0.000000] efi: Not removing mem51: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem52: MMIO range=[0xfee01000-0xffffffff] (17MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
[    0.000000] efi: Remove mem54: MMIO range=[0x1040000000-0x10601fffff] (514MB) from e820 map
[    0.000000] e820: remove [mem 0x1040000000-0x10601fffff] reserved
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: Micro Computer (HK) Tech Limited AtomMan G Series/DRBAA, BIOS 1.04 08/01/2024
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2495.339 MHz processor
[    0.000133] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000134] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000137] last_pfn = 0x103de80 max_arch_pfn = 0x400000000
[    0.000141] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built from 9 variable MTRRs
[    0.000143] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000363] last_pfn = 0xbbffd max_arch_pfn = 0x400000000
[    0.002651] esrt: Reserving ESRT space from 0x00000000aa556e18 to 0x00000000aa556e50.
[    0.002656] e820: update [mem 0xaa556000-0xaa556fff] usable ==> reserved
[    0.002667] Using GB pages for direct mapping
[    0.002845] RAMDISK: [mem 0x9ae72000-0x9fb8bfff]
[    0.003050] ACPI: Early table checksum verification disabled
[    0.003052] ACPI: RSDP 0x00000000B6AEA014 000024 (v02 ALASKA)
[    0.003054] ACPI: XSDT 0x00000000B6AE9728 0000E4 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003058] ACPI: FACP 0x00000000B4AF7000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.003061] ACPI: DSDT 0x00000000B4AF0000 00638D (v02 ALASKA A M I    01072009 INTL 20220331)
[    0.003062] ACPI: FACS 0x00000000B6AE7000 000040
[    0.003063] ACPI: IVRS 0x00000000B4B01000 0000D0 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.003064] ACPI: SSDT 0x00000000B4AF9000 007F51 (v02 AMD    Vortex   00000002 MSFT 05000000)
[    0.003065] ACPI: SSDT 0x00000000B4AF8000 0001CC (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.003066] ACPI: FIDT 0x00000000B4AEF000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003067] ACPI: MCFG 0x00000000B4AEE000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.003068] ACPI: HPET 0x00000000B4AED000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.003069] ACPI: WDRT 0x00000000B4AEC000 000047 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.003070] ACPI: UEFI 0x00000000B6495000 000048 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003071] ACPI: FPDT 0x00000000B4AEB000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003072] ACPI: VFCT 0x00000000B4ADC000 00E284 (v01 ALASKA A M I    00000001 AMD  33504F47)
[    0.003073] ACPI: TPM2 0x00000000B4ADB000 00004C (v04 ALASKA A M I    00000001 AMI  00000000)
[    0.003074] ACPI: SSDT 0x00000000B4AD1000 009A6E (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.003075] ACPI: CRAT 0x00000000B4ACF000 001D28 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.003076] ACPI: CDIT 0x00000000B4ACE000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.003077] ACPI: SSDT 0x00000000B4ACD000 0008A2 (v02 AMD    CPMDFDG2 00000001 INTL 20220331)
[    0.003078] ACPI: SSDT 0x00000000B4ACB000 001C40 (v02 AMD    CPMD3CLD 00000001 INTL 20220331)
[    0.003079] ACPI: SSDT 0x00000000B4ACA000 000788 (v02 AMD    CPMDFIG5 00000001 INTL 20220331)
[    0.003080] ACPI: SSDT 0x00000000B4AC0000 009713 (v02 AMD    CPMCMN   00000001 INTL 20220331)
[    0.003081] ACPI: WSMT 0x00000000B4ABF000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003082] ACPI: APIC 0x00000000B4ABE000 00015E (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.003083] ACPI: SSDT 0x00000000B4ABD000 000952 (v02 AMD    CPMMSOSC 00000001 INTL 20220331)
[    0.003084] ACPI: SSDT 0x00000000B4ABC000 000464 (v02 AMD    AMDWOV   00000001 INTL 20220331)
[    0.003085] ACPI: SSDT 0x00000000B4ABA000 00102E (v02 AMD    CPMACPV7 00000001 INTL 20220331)
[    0.003085] ACPI: Reserving FACP table memory at [mem 0xb4af7000-0xb4af7113]
[    0.003086] ACPI: Reserving DSDT table memory at [mem 0xb4af0000-0xb4af638c]
[    0.003086] ACPI: Reserving FACS table memory at [mem 0xb6ae7000-0xb6ae703f]
[    0.003087] ACPI: Reserving IVRS table memory at [mem 0xb4b01000-0xb4b010cf]
[    0.003087] ACPI: Reserving SSDT table memory at [mem 0xb4af9000-0xb4b00f50]
[    0.003087] ACPI: Reserving SSDT table memory at [mem 0xb4af8000-0xb4af81cb]
[    0.003088] ACPI: Reserving FIDT table memory at [mem 0xb4aef000-0xb4aef09b]
[    0.003088] ACPI: Reserving MCFG table memory at [mem 0xb4aee000-0xb4aee03b]
[    0.003088] ACPI: Reserving HPET table memory at [mem 0xb4aed000-0xb4aed037]
[    0.003088] ACPI: Reserving WDRT table memory at [mem 0xb4aec000-0xb4aec046]
[    0.003088] ACPI: Reserving UEFI table memory at [mem 0xb6495000-0xb6495047]
[    0.003089] ACPI: Reserving FPDT table memory at [mem 0xb4aeb000-0xb4aeb043]
[    0.003089] ACPI: Reserving VFCT table memory at [mem 0xb4adc000-0xb4aea283]
[    0.003089] ACPI: Reserving TPM2 table memory at [mem 0xb4adb000-0xb4adb04b]
[    0.003089] ACPI: Reserving SSDT table memory at [mem 0xb4ad1000-0xb4adaa6d]
[    0.003090] ACPI: Reserving CRAT table memory at [mem 0xb4acf000-0xb4ad0d27]
[    0.003090] ACPI: Reserving CDIT table memory at [mem 0xb4ace000-0xb4ace028]
[    0.003090] ACPI: Reserving SSDT table memory at [mem 0xb4acd000-0xb4acd8a1]
[    0.003090] ACPI: Reserving SSDT table memory at [mem 0xb4acb000-0xb4accc3f]
[    0.003091] ACPI: Reserving SSDT table memory at [mem 0xb4aca000-0xb4aca787]
[    0.003091] ACPI: Reserving SSDT table memory at [mem 0xb4ac0000-0xb4ac9712]
[    0.003091] ACPI: Reserving WSMT table memory at [mem 0xb4abf000-0xb4abf027]
[    0.003091] ACPI: Reserving APIC table memory at [mem 0xb4abe000-0xb4abe15d]
[    0.003092] ACPI: Reserving SSDT table memory at [mem 0xb4abd000-0xb4abd951]
[    0.003092] ACPI: Reserving SSDT table memory at [mem 0xb4abc000-0xb4abc463]
[    0.003092] ACPI: Reserving SSDT table memory at [mem 0xb4aba000-0xb4abb02d]
[    0.003184] No NUMA configuration found
[    0.003185] Faking a node at [mem 0x0000000000000000-0x000000103de7ffff]
[    0.003192] NODE_DATA(0) allocated [mem 0x103de55540-0x103de7ffff]
[    0.003321] Zone ranges:
[    0.003322]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.003323]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.003323]   Normal   [mem 0x0000000100000000-0x000000103de7ffff]
[    0.003324]   Device   empty
[    0.003324] Movable zone start for each node
[    0.003325] Early memory node ranges
[    0.003325]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.003326]   node   0: [mem 0x0000000000100000-0x0000000009afefff]
[    0.003326]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.003327]   node   0: [mem 0x000000000a212000-0x00000000aea01fff]
[    0.003327]   node   0: [mem 0x00000000babff000-0x00000000bbffcfff]
[    0.003327]   node   0: [mem 0x0000000100000000-0x000000103de7ffff]
[    0.003330] Initmem setup node 0 [mem 0x0000000000001000-0x000000103de7ffff]
[    0.003334] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.003343] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.003415] On node 0, zone DMA32: 1281 pages in unavailable ranges
[    0.004911] On node 0, zone DMA32: 18 pages in unavailable ranges
[    0.004984] On node 0, zone DMA32: 16893 pages in unavailable ranges
[    0.005143] On node 0, zone Normal: 16387 pages in unavailable ranges
[    0.005172] On node 0, zone Normal: 8576 pages in unavailable ranges
[    0.005536] ACPI: PM-Timer IO Port: 0x808
[    0.005542] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.005554] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
[    0.005558] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
[    0.005559] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.005560] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.005562] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.005563] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.005567] CPU topo: Max. logical packages:   1
[    0.005568] CPU topo: Max. logical dies:       2
[    0.005568] CPU topo: Max. dies per package:   2
[    0.005571] CPU topo: Max. threads per core:   2
[    0.005571] CPU topo: Num. cores per package:    16
[    0.005571] CPU topo: Num. threads per package:  32
[    0.005571] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.005582] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.005583] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.005583] PM: hibernation: Registered nosave memory: [mem 0x09aff000-0x09ffffff]
[    0.005584] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a211fff]
[    0.005584] PM: hibernation: Registered nosave memory: [mem 0xaa556000-0xaa556fff]
[    0.005585] PM: hibernation: Registered nosave memory: [mem 0xaea02000-0xbabfefff]
[    0.005586] PM: hibernation: Registered nosave memory: [mem 0xbbffd000-0xffffffff]
[    0.005587] [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.005588] Booting paravirtualized kernel on bare hardware
[    0.005590] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.008125] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.008699] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u262144
[    0.008702] pcpu-alloc: s217088 r8192 d28672 u262144 alloc=1*2097152
[    0.008703] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.008706] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31 
[    0.008716] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.17.13+deb14-amd64 root=UUID=64d3d740-d9ee-4045-a5a4-c5608861a5bb ro iommu=pt quiet
[    0.008933] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.008934] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    0.008934] printk: log_buf_len min size: 131072 bytes
[    0.009000] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.009001] printk: early log buf free: 118928(90%)
[    0.012364] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.014095] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.014257] software IO TLB: area num 32.
[    0.019451] Fallback order for Node 0: 0 
[    0.019459] Built 1 zonelists, mobility grouping on.  Total pages: 16701196
[    0.019459] Policy zone: Normal
[    0.019467] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.024715] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.030967] ftrace: allocating 46812 entries in 184 pages
[    0.030968] ftrace: allocated 184 pages with 4 groups
[    0.031318] Dynamic Preempt: lazy
[    0.031379] rcu: Preemptible hierarchical RCU implementation.
[    0.031379] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.031380] 	Trampoline variant of Tasks RCU enabled.
[    0.031380] 	Rude variant of Tasks RCU enabled.
[    0.031381] 	Tracing variant of Tasks RCU enabled.
[    0.031381] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.031382] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.031392] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.031394] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.031395] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.033649] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.033832] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.033969] Console: colour dummy device 80x25
[    0.033970] printk: legacy console [tty0] enabled
[    0.033993] ACPI: Core revision 20250404
[    0.034093] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.034106] APIC: Switch to symmetric I/O mode setup
[    0.034334] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.034577] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.035174] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.054111] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23f8068e97d, max_idle_ns: 440795257872 ns
[    0.054114] Calibrating delay loop (skipped), value calculated using timer frequency.. 4990.67 BogoMIPS (lpj=9981356)
[    0.054128] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.054171] LVT offset 1 assigned for vector 0xf9
[    0.054294] LVT offset 2 assigned for vector 0xf4
[    0.054330] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.054331] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.054332] process: using mwait in idle threads
[    0.054334] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.054337] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.054338] Transient Scheduler Attacks: Mitigation: Clear CPU buffers
[    0.054339] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.054339] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.054339] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.054340] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.054340] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.054342] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.054342] active return thunk: srso_alias_return_thunk
[    0.054349] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.054350] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.054350] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.054351] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.054351] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.054351] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.054352] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.054352] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.054353] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
[    0.054354] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.054354] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.054355] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.054355] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.054356] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.054356] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.054357] x86/fpu: xstate_offset[12]: 2456, xstate_sizes[12]:   24
[    0.054357] x86/fpu: Enabled xstate features 0x1ae7, context size is 2480 bytes, using 'compacted' format.
[    0.074527] Freeing SMP alternatives memory: 44K
[    0.074530] pid_max: default: 32768 minimum: 301
[    0.074563] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    0.074621] landlock: Up and running.
[    0.074622] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.074694] AppArmor: AppArmor initialized
[    0.074714] TOMOYO Linux initialized
[    0.074877] LSM support for eBPF active
[    0.074969] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.075027] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.183419] smpboot: CPU0: AMD Ryzen 9 7945HX with Radeon Graphics (family: 0x19, model: 0x61, stepping: 0x2)
[    0.183586] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
[    0.183613] ... version:                2
[    0.183614] ... bit width:              48
[    0.183615] ... generic registers:      6
[    0.183616] ... value mask:             0000ffffffffffff
[    0.183617] ... max period:             00007fffffffffff
[    0.183617] ... fixed-purpose events:   0
[    0.183618] ... event mask:             000000000000003f
[    0.183719] signal: max sigframe size: 3376
[    0.183779] rcu: Hierarchical SRCU implementation.
[    0.183780] rcu: 	Max phase no-delay instances is 1000.
[    0.183816] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.186113] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.186113] smp: Bringing up secondary CPUs ...
[    0.186113] smpboot: x86: Booting SMP configuration:
[    0.186113] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.224114] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.256114] smp: Brought up 1 node, 32 CPUs
[    0.256114] smpboot: Total of 32 processors activated (159701.69 BogoMIPS)
[    0.295886] node 0 deferred pages initialised in 40ms
[    0.298138] Memory: 65430376K/66804784K available (17192K kernel code, 3289K rwdata, 12368K rodata, 4392K init, 3864K bss, 1349772K reserved, 0K cma-reserved)
[    0.298685] devtmpfs: initialized
[    0.298685] x86/mm: Memory block size: 2048MB
[    0.299367] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a211fff] (73728 bytes)
[    0.299367] ACPI: PM: Registering ACPI NVS region [mem 0xb4b02000-0xb6b01fff] (33554432 bytes)
[    0.299367] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.299367] posixtimers hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.299367] futex hash table entries: 8192 (524288 bytes on 1 NUMA nodes, total 512 KiB, linear).
[    0.299367] pinctrl core: initialized pinctrl subsystem
[    0.299367] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.299367] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.299367] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.299367] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.299367] audit: initializing netlink subsys (disabled)
[    0.299367] audit: type=2000 audit(1769521359.000:1): state=initialized audit_enabled=0 res=1
[    0.299367] thermal_sys: Registered thermal governor 'fair_share'
[    0.299367] thermal_sys: Registered thermal governor 'bang_bang'
[    0.299367] thermal_sys: Registered thermal governor 'step_wise'
[    0.299367] thermal_sys: Registered thermal governor 'user_space'
[    0.299367] thermal_sys: Registered thermal governor 'power_allocator'
[    0.299367] cpuidle: using governor ladder
[    0.299367] cpuidle: using governor menu
[    0.302154] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.302231] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000) for domain 0000 [bus 00-7f]
[    0.302242] PCI: Using configuration type 1 for base access
[    0.302307] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.302307] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.302307] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.302307] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.302307] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.302601] ACPI: Added _OSI(Module Device)
[    0.302602] ACPI: Added _OSI(Processor Device)
[    0.302603] ACPI: Added _OSI(Processor Aggregator Device)
[    0.312933] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.314681] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.318521] ACPI: Interpreter enabled
[    0.318533] ACPI: PM: (supports S0 S3 S4 S5)
[    0.318535] ACPI: Using IOAPIC for interrupt routing
[    0.318812] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.318814] PCI: Ignoring E820 reservations for host bridge windows
[    0.319001] ACPI: Enabled 6 GPEs in block 00 to 1F
[    0.322021] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.322131] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    0.322195] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power resource
[    0.325314] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.325319] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.325402] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    0.325409] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers this bridge
[    0.325679] PCI host bridge to bus 0000:00
[    0.325681] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.325683] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.325684] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.325685] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.325686] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.325687] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfcffffff window]
[    0.325689] pci_bus 0000:00: root bus resource [mem 0x1040000000-0xfdffffffff window]
[    0.325690] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.325701] pci 0000:00:00.0: [1022:14d8] type 00 class 0x060000 conventional PCI endpoint
[    0.325782] pci 0000:00:00.2: [1022:14d9] type 00 class 0x080600 conventional PCI endpoint
[    0.325856] pci 0000:00:01.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
[    0.325921] pci 0000:00:01.1: [1022:14db] type 01 class 0x060400 PCIe Root Port
[    0.325933] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.325937] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.325939] pci 0000:00:01.1:   bridge window [mem 0xfc900000-0xfcbfffff]
[    0.325945] pci 0000:00:01.1:   bridge window [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.325995] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.326096] pci 0000:00:01.2: [1022:14db] type 01 class 0x060400 PCIe Root Port
[    0.326119] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.326123] pci 0000:00:01.2:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.326177] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.326273] pci 0000:00:01.3: [1022:14db] type 01 class 0x060400 PCIe Root Port
[    0.326285] pci 0000:00:01.3: PCI bridge to [bus 05]
[    0.326289] pci 0000:00:01.3:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    0.326343] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.326418] pci 0000:00:02.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
[    0.326481] pci 0000:00:02.1: [1022:14db] type 01 class 0x060400 PCIe Root Port
[    0.326493] pci 0000:00:02.1: PCI bridge to [bus 06]
[    0.326497] pci 0000:00:02.1:   bridge window [mem 0xfbe00000-0xfc0fffff]
[    0.326550] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.326644] pci 0000:00:03.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
[    0.326706] pci 0000:00:03.1: [1022:14db] type 01 class 0x060400 PCIe Root Port
[    0.326718] pci 0000:00:03.1: PCI bridge to [bus 07]
[    0.326722] pci 0000:00:03.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.326732] pci 0000:00:03.1: enabling Extended Tags
[    0.326777] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.326868] pci 0000:00:04.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
[    0.326939] pci 0000:00:08.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
[    0.327003] pci 0000:00:08.1: [1022:14dd] type 01 class 0x060400 PCIe Root Port
[    0.327013] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.327016] pci 0000:00:08.1:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.327024] pci 0000:00:08.1: enabling Extended Tags
[    0.327050] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.327144] pci 0000:00:08.3: [1022:14dd] type 01 class 0x060400 PCIe Root Port
[    0.327153] pci 0000:00:08.3: PCI bridge to [bus 09]
[    0.327157] pci 0000:00:08.3:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.327164] pci 0000:00:08.3: enabling Extended Tags
[    0.327190] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.327276] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.327373] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.327476] pci 0000:00:18.0: [1022:14e0] type 00 class 0x060000 conventional PCI endpoint
[    0.327509] pci 0000:00:18.1: [1022:14e1] type 00 class 0x060000 conventional PCI endpoint
[    0.327542] pci 0000:00:18.2: [1022:14e2] type 00 class 0x060000 conventional PCI endpoint
[    0.327575] pci 0000:00:18.3: [1022:14e3] type 00 class 0x060000 conventional PCI endpoint
[    0.327607] pci 0000:00:18.4: [1022:14e4] type 00 class 0x060000 conventional PCI endpoint
[    0.327640] pci 0000:00:18.5: [1022:14e5] type 00 class 0x060000 conventional PCI endpoint
[    0.327673] pci 0000:00:18.6: [1022:14e6] type 00 class 0x060000 conventional PCI endpoint
[    0.327705] pci 0000:00:18.7: [1022:14e7] type 00 class 0x060000 conventional PCI endpoint
[    0.327804] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.327822] pci 0000:01:00.0: BAR 0 [mem 0xfcb00000-0xfcb03fff]
[    0.327826] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.327831] pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
[    0.327834] pci 0000:01:00.0:   bridge window [mem 0xfc900000-0xfcafffff]
[    0.327842] pci 0000:01:00.0:   bridge window [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.327912] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.328075] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.328129] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.328150] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.328155] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.328158] pci 0000:02:00.0:   bridge window [mem 0xfc900000-0xfcafffff]
[    0.328166] pci 0000:02:00.0:   bridge window [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.328240] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.328510] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.328573] pci 0000:03:00.0: [1002:7480] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.328605] pci 0000:03:00.0: BAR 0 [mem 0xfa00000000-0xfbffffffff 64bit pref]
[    0.328608] pci 0000:03:00.0: BAR 2 [mem 0xfc00000000-0xfc0fffffff 64bit pref]
[    0.328610] pci 0000:03:00.0: BAR 4 [io  0xf000-0xf0ff]
[    0.328612] pci 0000:03:00.0: BAR 5 [mem 0xfc900000-0xfc9fffff]
[    0.328614] pci 0000:03:00.0: ROM [mem 0xfca00000-0xfca1ffff pref]
[    0.328695] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.328850] pci 0000:03:00.1: [1002:ab30] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.328879] pci 0000:03:00.1: BAR 0 [mem 0xfca20000-0xfca23fff]
[    0.328939] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.329056] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.329133] pci 0000:04:00.0: [144d:a80a] type 00 class 0x010802 PCIe Endpoint
[    0.329161] pci 0000:04:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 64bit]
[    0.329327] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.329380] pci 0000:05:00.0: [144d:a80c] type 00 class 0x010802 PCIe Endpoint
[    0.329407] pci 0000:05:00.0: BAR 0 [mem 0xfcd00000-0xfcd03fff 64bit]
[    0.329554] pci 0000:00:01.3: PCI bridge to [bus 05]
[    0.329619] pci 0000:06:00.0: [14c3:7925] type 00 class 0x028000 PCIe Endpoint
[    0.329657] pci 0000:06:00.0: BAR 0 [mem 0xfbe00000-0xfbffffff 64bit]
[    0.329661] pci 0000:06:00.0: BAR 2 [mem 0xfc000000-0xfc007fff 64bit]
[    0.329725] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.329835] pci 0000:00:02.1: PCI bridge to [bus 06]
[    0.329906] pci 0000:07:00.0: [8086:125c] type 00 class 0x020000 PCIe Endpoint
[    0.329941] pci 0000:07:00.0: BAR 0 [mem 0xfc700000-0xfc7fffff]
[    0.329945] pci 0000:07:00.0: BAR 3 [mem 0xfc800000-0xfc803fff]
[    0.329949] pci 0000:07:00.0: ROM [mem 0xfc600000-0xfc6fffff pref]
[    0.330013] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    0.330137] pci 0000:00:03.1: PCI bridge to [bus 07]
[    0.330207] pci 0000:08:00.0: [1022:14de] type 00 class 0x130000 PCIe Legacy Endpoint
[    0.330227] pci 0000:08:00.0: enabling Extended Tags
[    0.330323] pci 0000:08:00.2: [1022:1649] type 00 class 0x108000 PCIe Endpoint
[    0.330359] pci 0000:08:00.2: BAR 2 [mem 0xfc400000-0xfc4fffff]
[    0.330361] pci 0000:08:00.2: BAR 5 [mem 0xfc548000-0xfc549fff]
[    0.330365] pci 0000:08:00.2: enabling Extended Tags
[    0.330448] pci 0000:08:00.3: [1022:15b6] type 00 class 0x0c0330 PCIe Endpoint
[    0.330464] pci 0000:08:00.3: BAR 0 [mem 0xfc300000-0xfc3fffff 64bit]
[    0.330469] pci 0000:08:00.3: enabling Extended Tags
[    0.330493] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[    0.330559] pci 0000:08:00.4: [1022:15b7] type 00 class 0x0c0330 PCIe Endpoint
[    0.330575] pci 0000:08:00.4: BAR 0 [mem 0xfc200000-0xfc2fffff 64bit]
[    0.330581] pci 0000:08:00.4: enabling Extended Tags
[    0.330604] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[    0.330675] pci 0000:08:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoint
[    0.330690] pci 0000:08:00.5: BAR 0 [mem 0xfc500000-0xfc53ffff]
[    0.330696] pci 0000:08:00.5: enabling Extended Tags
[    0.330718] pci 0000:08:00.5: PME# supported from D0 D3hot D3cold
[    0.330789] pci 0000:08:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
[    0.330804] pci 0000:08:00.6: BAR 0 [mem 0xfc540000-0xfc547fff]
[    0.330810] pci 0000:08:00.6: enabling Extended Tags
[    0.330832] pci 0000:08:00.6: PME# supported from D0 D3hot D3cold
[    0.330910] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.330949] pci 0000:09:00.0: [1022:15b8] type 00 class 0x0c0330 PCIe Endpoint
[    0.330969] pci 0000:09:00.0: BAR 0 [mem 0xfcc00000-0xfccfffff 64bit]
[    0.330975] pci 0000:09:00.0: enabling Extended Tags
[    0.331004] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    0.331079] pci 0000:00:08.3: PCI bridge to [bus 09]
[    0.331467] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.331499] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.331526] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.331559] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.331588] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.331613] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.331638] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.331663] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.332157] iommu: Default domain type: Passthrough (set via kernel command line)
[    0.334919] pps_core: LinuxPPS API ver. 1 registered
[    0.334921] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.334923] PTP clock support registered
[    0.334931] EDAC MC: Ver: 3.0.0
[    0.335008] efivars: Registered efivars operations
[    0.335008] NetLabel: Initializing
[    0.335008] NetLabel:  domain hash size = 128
[    0.335008] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.335008] NetLabel:  unlabeled traffic allowed by default
[    0.335008] PCI: Using ACPI for IRQ routing
[    0.338740] PCI: pci_cache_line_size set to 64 bytes
[    0.338791] resource: Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    0.338792] e820: reserve RAM buffer [mem 0x09aff000-0x0bffffff]
[    0.338794] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.338795] e820: reserve RAM buffer [mem 0xaa556000-0xabffffff]
[    0.338796] e820: reserve RAM buffer [mem 0xaea02000-0xafffffff]
[    0.338797] e820: reserve RAM buffer [mem 0xbbffd000-0xbbffffff]
[    0.338798] e820: reserve RAM buffer [mem 0x103de80000-0x103fffffff]
[    0.338838] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.338838] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.338838] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.338838] vgaarb: loaded
[    0.338838] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.338838] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.340217] clocksource: Switched to clocksource tsc-early
[    0.340217] VFS: Disk quotas dquot_6.6.0
[    0.340217] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.340217] AppArmor: AppArmor Filesystem Enabled
[    0.340217] pnp: PnP ACPI init
[    0.340217] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.340217] system 00:01: [mem 0x1000000000000 window] could not be reserved
[    0.340217] system 00:03: [io  0x0a00-0x0a1f] has been reserved
[    0.340217] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    0.340217] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.340217] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.340217] system 00:04: [io  0x040b] has been reserved
[    0.340217] system 00:04: [io  0x04d6] has been reserved
[    0.340217] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.340217] system 00:04: [io  0x0c14] has been reserved
[    0.340217] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.340217] system 00:04: [io  0x0c52] has been reserved
[    0.340217] system 00:04: [io  0x0c6c] has been reserved
[    0.340217] system 00:04: [io  0x0c6f] has been reserved
[    0.340217] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.340217] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.340217] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.340217] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.340217] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.340217] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.340217] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.340217] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.340217] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.340217] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.340217] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.340217] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.340217] system 00:04: [mem 0xfeb00000-0xfeb00fff] has been reserved
[    0.340217] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.340217] pnp: PnP ACPI: found 5 devices
[    0.344923] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.344982] NET: Registered PF_INET protocol family
[    0.345091] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.353001] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    0.353028] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.353190] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.353462] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.353520] TCP: Hash tables configured (established 524288 bind 65536)
[    0.353657] MPTCP token hash table entries: 65536 (order: 9, 1572864 bytes, linear)
[    0.353779] UDP hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.353928] UDP-Lite hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.354041] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.354046] NET: Registered PF_XDP protocol family
[    0.354066] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.354074] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.354078] pci 0000:02:00.0:   bridge window [mem 0xfc900000-0xfcafffff]
[    0.354081] pci 0000:02:00.0:   bridge window [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.354086] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.354088] pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
[    0.354092] pci 0000:01:00.0:   bridge window [mem 0xfc900000-0xfcafffff]
[    0.354095] pci 0000:01:00.0:   bridge window [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.354099] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.354101] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.354103] pci 0000:00:01.1:   bridge window [mem 0xfc900000-0xfcbfffff]
[    0.354105] pci 0000:00:01.1:   bridge window [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.354115] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.354118] pci 0000:00:01.2:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.354129] pci 0000:00:01.3: PCI bridge to [bus 05]
[    0.354131] pci 0000:00:01.3:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    0.354143] pci 0000:00:02.1: PCI bridge to [bus 06]
[    0.354145] pci 0000:00:02.1:   bridge window [mem 0xfbe00000-0xfc0fffff]
[    0.354156] pci 0000:00:03.1: PCI bridge to [bus 07]
[    0.354158] pci 0000:00:03.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.354170] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.354176] pci 0000:00:08.1:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.354180] pci 0000:00:08.3: PCI bridge to [bus 09]
[    0.354182] pci 0000:00:08.3:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.354186] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.354188] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.354189] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.354190] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.354191] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.354192] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfcffffff window]
[    0.354194] pci_bus 0000:00: resource 10 [mem 0x1040000000-0xfdffffffff window]
[    0.354195] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.354196] pci_bus 0000:01: resource 1 [mem 0xfc900000-0xfcbfffff]
[    0.354197] pci_bus 0000:01: resource 2 [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.354198] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.354200] pci_bus 0000:02: resource 1 [mem 0xfc900000-0xfcafffff]
[    0.354201] pci_bus 0000:02: resource 2 [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.354202] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.354203] pci_bus 0000:03: resource 1 [mem 0xfc900000-0xfcafffff]
[    0.354204] pci_bus 0000:03: resource 2 [mem 0xfa00000000-0xfc0fffffff 64bit pref]
[    0.354206] pci_bus 0000:04: resource 1 [mem 0xfce00000-0xfcefffff]
[    0.354207] pci_bus 0000:05: resource 1 [mem 0xfcd00000-0xfcdfffff]
[    0.354208] pci_bus 0000:06: resource 1 [mem 0xfbe00000-0xfc0fffff]
[    0.354209] pci_bus 0000:07: resource 1 [mem 0xfc600000-0xfc8fffff]
[    0.354211] pci_bus 0000:08: resource 1 [mem 0xfc200000-0xfc5fffff]
[    0.354212] pci_bus 0000:09: resource 1 [mem 0xfcc00000-0xfccfffff]
[    0.354322] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.354602] PCI: CLS 64 bytes, default 64
[    0.354626] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.354670] Trying to unpack rootfs image as initramfs...
[    0.354686] pci 0000:00:01.0: Adding to iommu group 0
[    0.354699] pci 0000:00:01.1: Adding to iommu group 1
[    0.354710] pci 0000:00:01.2: Adding to iommu group 2
[    0.354722] pci 0000:00:01.3: Adding to iommu group 3
[    0.354741] pci 0000:00:02.0: Adding to iommu group 4
[    0.354752] pci 0000:00:02.1: Adding to iommu group 5
[    0.354768] pci 0000:00:03.0: Adding to iommu group 6
[    0.354779] pci 0000:00:03.1: Adding to iommu group 7
[    0.354794] pci 0000:00:04.0: Adding to iommu group 8
[    0.354810] pci 0000:00:08.0: Adding to iommu group 9
[    0.354822] pci 0000:00:08.1: Adding to iommu group 10
[    0.354833] pci 0000:00:08.3: Adding to iommu group 11
[    0.354853] pci 0000:00:14.0: Adding to iommu group 12
[    0.354863] pci 0000:00:14.3: Adding to iommu group 12
[    0.354909] pci 0000:00:18.0: Adding to iommu group 13
[    0.354920] pci 0000:00:18.1: Adding to iommu group 13
[    0.354932] pci 0000:00:18.2: Adding to iommu group 13
[    0.354943] pci 0000:00:18.3: Adding to iommu group 13
[    0.354957] pci 0000:00:18.4: Adding to iommu group 13
[    0.354968] pci 0000:00:18.5: Adding to iommu group 13
[    0.354978] pci 0000:00:18.6: Adding to iommu group 13
[    0.354989] pci 0000:00:18.7: Adding to iommu group 13
[    0.355000] pci 0000:01:00.0: Adding to iommu group 14
[    0.355012] pci 0000:02:00.0: Adding to iommu group 15
[    0.355029] pci 0000:03:00.0: Adding to iommu group 16
[    0.355042] pci 0000:03:00.1: Adding to iommu group 17
[    0.355053] pci 0000:04:00.0: Adding to iommu group 18
[    0.355065] pci 0000:05:00.0: Adding to iommu group 19
[    0.355076] pci 0000:06:00.0: Adding to iommu group 20
[    0.355088] pci 0000:07:00.0: Adding to iommu group 21
[    0.355108] pci 0000:08:00.0: Adding to iommu group 22
[    0.355121] pci 0000:08:00.2: Adding to iommu group 23
[    0.355133] pci 0000:08:00.3: Adding to iommu group 24
[    0.355144] pci 0000:08:00.4: Adding to iommu group 25
[    0.355156] pci 0000:08:00.5: Adding to iommu group 26
[    0.355168] pci 0000:08:00.6: Adding to iommu group 27
[    0.355179] pci 0000:09:00.0: Adding to iommu group 28
[    0.355421] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.355428] AMD-Vi: Interrupt remapping enabled
[    0.479386] Freeing initrd memory: 78952K
[    0.574540] AMD-Vi: Virtual APIC enabled
[    0.574545] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.574545] software IO TLB: mapped [mem 0x00000000a5690000-0x00000000a9690000] (64MB)
[    0.574577] LVT offset 0 assigned for vector 0x400
[    0.574743] perf: AMD IBS detected (0x00000bff)
[    0.574894] amd_uncore: 16 amd_df counters detected
[    0.574903] amd_uncore: 6 amd_l3 counters detected
[    0.574911] amd_uncore: 4 amd_umc_0 counters detected
[    0.574917] amd_uncore: 4 amd_umc_1 counters detected
[    0.575053] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.586856] Initialise system trusted keyrings
[    0.586862] Key type blacklist registered
[    0.586907] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    0.587014] fuse: init (API version 7.44)
[    0.587116] integrity: Platform Keyring initialized
[    0.587119] integrity: Machine keyring initialized
[    0.596389] Key type asymmetric registered
[    0.596390] Asymmetric key parser 'x509' registered
[    0.596540] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.596635] io scheduler mq-deadline registered
[    0.598263] ledtrig-cpu: registered to indicate activity on CPUs
[    0.598369] pcieport 0000:00:01.1: PME: Signaling with IRQ 26
[    0.598388] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.598564] pcieport 0000:00:01.2: PME: Signaling with IRQ 27
[    0.598684] pcieport 0000:00:01.3: PME: Signaling with IRQ 28
[    0.598805] pcieport 0000:00:02.1: PME: Signaling with IRQ 29
[    0.598925] pcieport 0000:00:03.1: PME: Signaling with IRQ 30
[    0.599045] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    0.599161] pcieport 0000:00:08.3: PME: Signaling with IRQ 32
[    0.600089] Monitor-Mwait will be used to enter C-1 state
[    0.603323] Estimated ratio of average max frequency by base frequency (times 1024): 1630
[    0.603525] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.604098] Linux agpgart interface v0.103
[    0.618673] tpm_crb MSFT0101:00: Disabling hwrng
[    0.620839] i8042: PNP: No PS/2 controller found.
[    0.620874] mousedev: PS/2 mouse device common for all mice
[    0.620891] rtc_cmos 00:02: RTC can wake from S4
[    0.621072] rtc_cmos 00:02: registered as rtc0
[    0.621097] rtc_cmos 00:02: setting system clock to 2026-01-27T13:42:40 UTC (1769521360)
[    0.621119] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    0.622712] efifb: probing for efifb
[    0.622718] efifb: framebuffer at 0xfa00000000, using 1952k, total 1950k
[    0.622720] efifb: mode is 800x600x32, linelength=3328, pages=1
[    0.622721] efifb: scrolling: redraw
[    0.622722] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.622775] Console: switching to colour frame buffer device 100x37
[    0.622949] fb0: EFI VGA frame buffer device
[    0.623047] NET: Registered PF_INET6 protocol family
[    0.623371] Segment Routing with IPv6
[    0.623372] RPL Segment Routing with IPv6
[    0.623377] In-situ OAM (IOAM) with IPv6
[    0.623390] mip6: Mobile IPv6
[    0.623392] NET: Registered PF_PACKET protocol family
[    0.623414] mpls_gso: MPLS GSO support
[    0.625140] microcode: Current revision: 0x0a60120a
[    0.625141] microcode: Updated early from: 0x0a601206
[    0.625600] resctrl: L3 allocation detected
[    0.625601] resctrl: MB allocation detected
[    0.625602] resctrl: SMBA allocation detected
[    0.625603] resctrl: L3 monitoring detected
[    0.625627] IPI shorthand broadcast: enabled
[    0.627289] sched_clock: Marking stable (626371538, 249182)->(631547587, -4926867)
[    0.627465] registered taskstats version 1
[    0.627638] Loading compiled-in X.509 certificates
[    0.647337] Loaded X.509 cert 'Build time autogenerated kernel key: 89b9ee3b66ae95085142bc42159ae75c54f7d2c0'
[    0.649269] Demotion targets for Node 0: null
[    0.649351] Key type .fscrypt registered
[    0.649352] Key type fscrypt-provisioning registered
[    0.655263] Key type encrypted registered
[    0.655264] AppArmor: AppArmor sha256 policy hashing enabled
[    0.655330] integrity: Loading X.509 certificate: UEFI:db
[    0.655337] integrity: Loaded X.509 cert 'MINISFORUM OWN CA: 815a459eeaeb7a9e42fabf9897858520'
[    0.655338] integrity: Loading X.509 certificate: UEFI:db
[    0.655346] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.655347] integrity: Loading X.509 certificate: UEFI:db
[    0.655354] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.655355] integrity: Loading X.509 certificate: UEFI:db
[    0.655362] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.655363] integrity: Loading X.509 certificate: UEFI:db
[    0.655369] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    0.655370] integrity: Loading X.509 certificate: UEFI:db
[    0.655376] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    0.656072] ima: Allocated hash algorithm: sha256
[    0.698677] ima: No architecture policies found
[    0.698696] evm: Initialising EVM extended attributes:
[    0.698698] evm: security.selinux
[    0.698699] evm: security.SMACK64 (disabled)
[    0.698701] evm: security.SMACK64EXEC (disabled)
[    0.698702] evm: security.SMACK64TRANSMUTE (disabled)
[    0.698703] evm: security.SMACK64MMAP (disabled)
[    0.698705] evm: security.apparmor
[    0.698706] evm: security.ima
[    0.698707] evm: security.capability
[    0.698708] evm: HMAC attrs: 0x1
[    0.700203] RAS: Correctable Errors collector initialized.
[    0.702636] clk: Disabling unused clocks
[    0.702638] PM: genpd: Disabling unused power domains
[    0.703301] Freeing unused decrypted memory: 2028K
[    0.703648] Freeing unused kernel image (initmem) memory: 4392K
[    0.703656] Write protecting the kernel read-only data: 32768k
[    0.703968] Freeing unused kernel image (text/rodata gap) memory: 1236K
[    0.704192] Freeing unused kernel image (rodata/data gap) memory: 1968K
[    0.733813] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.733816] Run /init as init process
[    0.733817]   with arguments:
[    0.733818]     /init
[    0.733819]   with environment:
[    0.733820]     HOME=/
[    0.733821]     TERM=linux
[    0.878599] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.878636] ACPI: button: Power Button [PWRB]
[    0.878685] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.879599] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    0.879604] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    0.880737] ACPI: button: Power Button [PWRF]
[    0.884844] Key type psk registered
[    0.886986] i2c i2c-2: Successfully instantiated SPD at 0x50
[    0.891699] i2c i2c-2: Successfully instantiated SPD at 0x51
[    0.891766] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    0.891979] Intel(R) 2.5G Ethernet Linux Driver
[    0.891981] Copyright(c) 2018 Intel Corporation.
[    0.892107] igc 0000:07:00.0: PCIe PTM not supported by PCIe bus/controller
[    0.900428] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    0.900447] nvme nvme1: pci function 0000:05:00.0
[    0.900452] nvme nvme0: pci function 0000:04:00.0
[    0.901980] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:12/LNXVIDEO:00/input/input2
[    0.903517] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    0.903558] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    0.903615] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    0.905111] ACPI: bus type USB registered
[    0.905132] usbcore: registered new interface driver usbfs
[    0.905140] usbcore: registered new interface driver hub
[    0.905149] usbcore: registered new device driver usb
[    0.909818] nvme nvme1: D3 entry latency set to 10 seconds
[    0.913512] nvme nvme1: 16/0/0 default/read/poll queues
[    0.915755]  nvme1n1: p1 p2 p3
[    0.916007] nvme nvme0: D3 entry latency set to 10 seconds
[    0.922653] nvme nvme0: 32/0/0 default/read/poll queues
[    0.925254]  nvme0n1: p1 p2 p3
[    0.929956] igc 0000:07:00.0 (unnamed net_device) (uninitialized): PHC added
[    0.941828] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.941832] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 1
[    0.942160] xhci_hcd 0000:08:00.3: hcc params 0x0120ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.942383] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.942385] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 2
[    0.942387] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.942443] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
[    0.942446] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.942448] usb usb1: Product: xHCI Host Controller
[    0.942449] usb usb1: Manufacturer: Linux 6.17.13+deb14-amd64 xhci-hcd
[    0.942450] usb usb1: SerialNumber: 0000:08:00.3
[    0.942550] hub 1-0:1.0: USB hub found
[    0.942561] hub 1-0:1.0: 2 ports detected
[    0.942735] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.942763] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
[    0.942765] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.942766] usb usb2: Product: xHCI Host Controller
[    0.942767] usb usb2: Manufacturer: Linux 6.17.13+deb14-amd64 xhci-hcd
[    0.942768] usb usb2: SerialNumber: 0000:08:00.3
[    0.942840] hub 2-0:1.0: USB hub found
[    0.942851] hub 2-0:1.0: 2 ports detected
[    0.943012] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.943016] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus number 3
[    0.943363] xhci_hcd 0000:08:00.4: hcc params 0x0120ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.943589] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.943591] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus number 4
[    0.943593] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.943630] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
[    0.943632] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.943633] usb usb3: Product: xHCI Host Controller
[    0.943634] usb usb3: Manufacturer: Linux 6.17.13+deb14-amd64 xhci-hcd
[    0.943635] usb usb3: SerialNumber: 0000:08:00.4
[    0.943713] hub 3-0:1.0: USB hub found
[    0.943724] hub 3-0:1.0: 2 ports detected
[    0.943838] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.943863] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
[    0.943865] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.943866] usb usb4: Product: xHCI Host Controller
[    0.943867] usb usb4: Manufacturer: Linux 6.17.13+deb14-amd64 xhci-hcd
[    0.943868] usb usb4: SerialNumber: 0000:08:00.4
[    0.943941] hub 4-0:1.0: USB hub found
[    0.943952] hub 4-0:1.0: 2 ports detected
[    0.944106] xhci_hcd 0000:09:00.0: xHCI Host Controller
[    0.944111] xhci_hcd 0000:09:00.0: new USB bus registered, assigned bus number 5
[    0.945365] xhci_hcd 0000:09:00.0: USB3 root hub has no ports
[    0.945380] xhci_hcd 0000:09:00.0: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.945614] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
[    0.945615] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.945616] usb usb5: Product: xHCI Host Controller
[    0.945617] usb usb5: Manufacturer: Linux 6.17.13+deb14-amd64 xhci-hcd
[    0.945618] usb usb5: SerialNumber: 0000:09:00.0
[    0.945696] hub 5-0:1.0: USB hub found
[    0.945703] hub 5-0:1.0: 1 port detected
[    0.950941] ACPI: bus type drm_connector registered
[    0.951840] igc 0000:07:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    0.951843] igc 0000:07:00.0 eth0: MAC: c8:ff:bf:01:22:19
[    0.953615] igc 0000:07:00.0 enp7s0: renamed from eth0
[    1.196280] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.200312] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[    1.336630] usb 1-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice=90.13
[    1.336634] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.336636] usb 1-1: Product: USB2.0 Hub             
[    1.336637] usb 1-1: Manufacturer: VIA Labs, Inc.         
[    1.336638] usb 1-1: SerialNumber: 000000000
[    1.343920] usb 5-1: New USB device found, idVendor=13d3, idProduct=3604, bcdDevice= 1.00
[    1.343923] usb 5-1: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[    1.343925] usb 5-1: Product: Wireless_Device
[    1.343926] usb 5-1: Manufacturer: MediaTek Inc.
[    1.343927] usb 5-1: SerialNumber: 000000000
[    1.390711] hub 1-1:1.0: USB hub found
[    1.391026] hub 1-1:1.0: 4 ports detected
[    1.485730] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[    1.604266] tsc: Refined TSC clocksource calibration: 2495.321 MHz
[    1.604277] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23f7f5d10cb, max_idle_ns: 440795295035 ns
[    1.604322] clocksource: Switched to clocksource tsc
[    1.612263] usb 2-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice=90.13
[    1.612264] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.612266] usb 2-1: Product: USB3.0 Hub             
[    1.612267] usb 2-1: Manufacturer: VIA Labs, Inc.         
[    1.612268] usb 2-1: SerialNumber: 000000000
[    1.630567] hub 2-1:1.0: USB hub found
[    1.630736] hub 2-1:1.0: 4 ports detected
[    2.149257] [drm] amdgpu kernel modesetting enabled.
[    2.149337] amdgpu: Virtual CRAT table created for CPU
[    2.149350] amdgpu: Topology: Add CPU node
[    2.149441] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
[    2.149488] amdgpu 0000:03:00.0: amdgpu: initializing kernel modesetting (IP DISCOVERY 0x1002:0x7480 0x1F4C:0xB006 0xC7).
[    2.149497] amdgpu 0000:03:00.0: amdgpu: register mmio base: 0xFC900000
[    2.149498] amdgpu 0000:03:00.0: amdgpu: register mmio size: 1048576
[    2.153103] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <soc21_common>
[    2.153105] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v11_0>
[    2.153106] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <ih_v6_0>
[    2.153107] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[    2.153109] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[    2.153110] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[    2.153111] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v11_0>
[    2.153112] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v6_0>
[    2.153114] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v4_0>
[    2.153115] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v4_0>
[    2.153116] amdgpu 0000:03:00.0: amdgpu: detected ip block number 10 <mes_v11_0>
[    2.153128] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.153129] amdgpu: ATOM BIOS: 113-BRT138292-001
[    2.153763] amdgpu 0000:03:00.0: amdgpu: CP RS64 enable
[    2.154817] Console: switching to colour dummy device 80x25
[    2.154833] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    2.154834] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    2.154888] amdgpu 0000:03:00.0: amdgpu: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.154893] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
[    2.154894] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.154901] [drm] Detected VRAM RAM=8176M, BAR=8192M
[    2.154902] [drm] RAM width 128bits GDDR6
[    2.154982] amdgpu 0000:03:00.0: amdgpu: amdgpu: 8176M of VRAM memory ready
[    2.154985] amdgpu 0000:03:00.0: amdgpu: amdgpu: 32003M of GTT memory ready.
[    2.154997] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    2.155048] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
[    2.155359] amdgpu 0000:03:00.0: amdgpu: [drm] Loading DMUB firmware via PSP: version=0x07002F00
[    2.155502] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 22
[    2.184253] usb 1-1.1: new high-speed USB device number 3 using xhci_hcd
[    2.211656] amdgpu 0000:03:00.0: amdgpu: reserve 0x1300000 from 0x81fc000000 for PSP TMR
[    2.307864] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    2.315456] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    2.315457] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    2.315485] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x00000035, smu fw if version = 0x00000040, smu fw program = 0, smu fw version = 0x00525e00 (82.94.0)
[    2.315487] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[    2.339632] usb 1-1.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.03
[    2.339634] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.339635] usb 1-1.1: Product: USB2.1 Hub
[    2.339636] usb 1-1.1: Manufacturer: Generic
[    2.357021] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    2.357469] amdgpu 0000:03:00.0: amdgpu: [drm] Display Core v3.2.340 initialized on DCN 3.2.1
[    2.357471] amdgpu 0000:03:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
[    2.359421] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x07002F00
[    2.383191] hub 1-1.1:1.0: USB hub found
[    2.392267] hub 1-1.1:1.0: 4 ports detected
[    2.420915] usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
[    2.446823] usb 2-1.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.03
[    2.446825] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.446827] usb 2-1.1: Product: USB3.2 Hub
[    2.446828] usb 2-1.1: Manufacturer: Generic
[    2.479116] hub 2-1.1:1.0: USB hub found
[    2.480629] hub 2-1.1:1.0: 4 ports detected
[    2.616262] usb 1-1.2: new full-speed USB device number 4 using xhci_hcd
[    2.690664] amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 150000 tries - optc32_disable_crtc line:195
[    2.723979] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.724019] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.807395] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.10
[    2.807400] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.807402] usb 1-1.2: Product: USB Receiver
[    2.807404] usb 1-1.2: Manufacturer: Logitech
[    2.868255] usb 1-1.1.1: new full-speed USB device number 5 using xhci_hcd
[    2.878979] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.941810] hid: raw HID events driver (C) Jiri Kosina
[    2.945932] amdgpu: HMM registered 8176MB device memory
[    2.946972] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    2.946984] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    2.947017] amdgpu: Virtual CRAT table created for GPU
[    2.947113] amdgpu: Topology: Add dGPU node [0x7480:0x1002]
[    2.947115] kfd kfd: amdgpu: added device 1002:7480
[    2.947126] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8, active_cu_number 32
[    2.947129] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    2.947131] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.947132] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.947133] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    2.947134] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    2.947136] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    2.947137] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    2.947138] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    2.947139] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    2.947140] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[    2.947141] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
[    2.947143] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    2.947144] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[    2.947145] amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
[    2.948463] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm
[    2.948731] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
[    2.951967] amdgpu 0000:03:00.0: amdgpu: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22 
[    2.955225] fbcon: amdgpudrmfb (fb0) is primary device
[    2.955541] [drm] pre_validate_dsc:1634 MST_DSC dsc precompute is not needed
[    2.958433] usbcore: registered new interface driver usbhid
[    2.958434] usbhid: USB HID core driver
[    2.962827] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C52B.0001/input/input3
[    3.026396] usb 1-1.1.1: New USB device found, idVendor=051d, idProduct=0002, bcdDevice= 0.90
[    3.026398] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.026400] usb 1-1.1.1: Product: Back-UPS NS 1350M2 FW:954.e3 .D USB FW:e3     
[    3.026401] usb 1-1.1.1: Manufacturer: American Power Conversion
[    3.026402] usb 1-1.1.1: SerialNumber: 3B1741X04129  
[    3.096002] hid-generic 0003:051D:0002.0004: hiddev0,hidraw0: USB HID v1.00 Device [American Power Conversion Back-UPS NS 1350M2 FW:954.e3 .D USB FW:e3     ] on usb-0000:08:00.3-1.1.1/input0
[    3.108324] hid-generic 0003:046D:C52B.0001: input,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:08:00.3-1.2/input0
[    3.108471] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C52B.0002/input/input4
[    3.108582] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C52B.0002/input/input5
[    3.164321] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C52B.0002/input/input6
[    3.164409] hid-generic 0003:046D:C52B.0002: input,hiddev1,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:08:00.3-1.2/input1
[    3.164543] hid-generic 0003:046D:C52B.0003: hiddev2,hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:08:00.3-1.2/input2
[    3.184254] usb 1-1.1.2: new high-speed USB device number 6 using xhci_hcd
[    3.253830] amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 150000 tries - optc32_disable_crtc line:195
[    3.395406] Console: switching to colour frame buffer device 160x45
[    3.413948] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    3.452656] logitech-djreceiver 0003:046D:C52B.0003: hiddev1,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:08:00.3-1.2/input2
[    3.497429] usb 1-1.1.2: New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.12
[    3.497434] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=2
[    3.497436] usb 1-1.1.2: SerialNumber: 1E0B63F0
[    3.568995] input: Logitech Wireless Device PID:405e Keyboard as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.2/0003:046D:C52B.0003/0003:046D:405E.0005/input/input8
[    3.608275] usb 1-1.1.4: new full-speed USB device number 7 using xhci_hcd
[    3.664635] input: Logitech Wireless Device PID:405e Mouse as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.2/0003:046D:C52B.0003/0003:046D:405E.0005/input/input9
[    3.664738] hid-generic 0003:046D:405E.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:405e] on usb-0000:08:00.3-1.2/input2:1
[    3.670799] input: Logitech MX Keys as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.2/0003:046D:C52B.0003/0003:046D:408A.0006/input/input13
[    3.732440] usb 1-1.1.4: New USB device found, idVendor=1532, idProduct=0531, bcdDevice= 1.00
[    3.732447] usb 1-1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.732450] usb 1-1.1.4: Product: Razer Seiren Mini
[    3.732452] usb 1-1.1.4: Manufacturer: Razer Inc
[    3.732454] usb 1-1.1.4: SerialNumber: UC2116L03302382
[    3.799983] hid-generic 0003:1532:0531.0007: hidraw3: USB HID v1.11 Device [Razer Inc Razer Seiren Mini] on usb-0000:08:00.3-1.1.4/input2
[    3.936710] logitech-hidpp-device 0003:046D:408A.0006: input,hidraw4: USB HID v1.11 Keyboard [Logitech MX Keys] on usb-0000:08:00.3-1.2/input2:2
[    3.966850] input: Logitech M720 Triathlon as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-1/1-1.2/1-1.2:1.2/0003:046D:C52B.0003/0003:046D:405E.0005/input/input15
[    4.076710] logitech-hidpp-device 0003:046D:405E.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech M720 Triathlon] on usb-0000:08:00.3-1.2/input2:1
[    4.200270] raid6: avx512x4 gen() 36598 MB/s
[    4.268273] raid6: avx512x2 gen() 38163 MB/s
[    4.336276] raid6: avx512x1 gen() 30549 MB/s
[    4.404267] raid6: avx2x4   gen() 38951 MB/s
[    4.472259] raid6: avx2x2   gen() 39589 MB/s
[    4.540259] raid6: avx2x1   gen() 29039 MB/s
[    4.540260] raid6: using algorithm avx2x2 gen() 39589 MB/s
[    4.608258] raid6: .... xor() 54071 MB/s, rmw enabled
[    4.608259] raid6: using avx512x2 recovery algorithm
[    4.610795] xor: automatically using best checksumming function   avx       
[    4.612986] async_tx: api initialized (async)
[    4.840585] Btrfs loaded, zoned=yes, fsverity=yes
[    4.872708] PM: Image not found (code -22)
[    4.986016] EXT4-fs (nvme1n1p2): orphan cleanup on readonly fs
[    4.986245] EXT4-fs (nvme1n1p2): mounted filesystem 64d3d740-d9ee-4045-a5a4-c5608861a5bb ro with ordered data mode. Quota mode: none.
[    5.024396] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[    5.051722] systemd[1]: Inserted module 'autofs4'
[    5.059155] systemd[1]: systemd 259-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    5.059161] systemd[1]: Detected architecture x86-64.
[    5.061460] systemd[1]: Hostname set to <phoenix.local>.
[    5.219499] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    5.292938] systemd[1]: /usr/lib/systemd/system/system-xfs_scrub.slice:15: Support for option CPUAccounting= has been removed and it is ignored
[    5.306933] systemd[1]: /usr/lib/systemd/system/xfs_scrub_all.service:26: Support for option CPUAccounting= has been removed and it is ignored
[    5.367209] systemd[1]: Queued start job for default target graphical.target.
[    5.409803] systemd[1]: Created slice machine.slice - Virtual Machine and Container Slice.
[    5.410453] systemd[1]: Created slice system-cups.slice - CUPS Slice.
[    5.410719] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[    5.410986] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[    5.411264] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[    5.411614] systemd[1]: Created slice system-xfs_scrub.slice - xfs_scrub background service slice.
[    5.411812] systemd[1]: Created slice user.slice - User and Session Slice.
[    5.411853] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[    5.411993] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[    5.412006] systemd[1]: Expecting device dev-disk-by\x2duuid-24EB\x2dF9BB.device - /dev/disk/by-uuid/24EB-F9BB...
[    5.412010] systemd[1]: Expecting device dev-disk-by\x2duuid-fa852e1a\x2db866\x2d4967\x2d89fd\x2dd4b07d1545ca.device - /dev/disk/by-uuid/fa852e1a-b866-4967-89fd-d4b07d1545ca...
[    5.412023] systemd[1]: Reached target imports.target - Image Downloads.
[    5.412042] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[    5.412058] systemd[1]: Reached target slices.target - Slice Units.
[    5.412068] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[    5.412086] systemd[1]: Reached target virt-guest-shutdown.target - libvirt guests shutdown target.
[    5.412135] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[    5.412190] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[    5.415244] systemd[1]: Listening on rpcbind.socket - RPCbind Server Activation Socket.
[    5.416350] systemd[1]: Listening on systemd-ask-password.socket - Query the User Interactively for a Password.
[    5.416759] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[    5.417224] systemd[1]: Listening on systemd-factory-reset.socket - Factory Reset Management.
[    5.417288] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    5.417346] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[    5.417903] systemd[1]: Listening on systemd-mute-console.socket - Console Output Muting Service Socket.
[    5.417978] systemd[1]: Listening on systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket.
[    5.418008] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.418017] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.418064] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    5.418094] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    5.418129] systemd[1]: Listening on systemd-udevd-varlink.socket - udev Varlink Socket.
[    5.418168] systemd[1]: Listening on systemd-userdbd.socket - User Database Manager Socket.
[    5.418863] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[    5.419377] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[    5.419926] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[    5.420465] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[    5.420518] systemd[1]: auth-rpcgss-module.service - Kernel Module supporting RPCSEC_GSS was skipped because of an unmet condition check (ConditionPathExists=/etc/krb5.keytab).
[    5.421136] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[    5.421749] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[    5.422394] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    5.423320] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[    5.423343] systemd[1]: modprobe@drm.service - Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
[    5.423868] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[    5.423885] systemd[1]: modprobe@fuse.service - Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
[    5.424408] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[    5.424505] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
[    5.424535] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    5.425805] systemd[1]: Starting systemd-journald.service - Journal Service...
[    5.426816] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    5.426830] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.426853] systemd[1]: systemd-pcrproduct.service - TPM NvPCR Product ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.427469] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[    5.427502] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.428131] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[    5.428677] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[    5.430201] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[    5.430552] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[    5.430627] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[    5.430695] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[    5.430736] pstore: Using crash dump compression: deflate
[    5.430891] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[    5.431522] pstore: Registered efi_pstore as persistent store backend
[    5.431831] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[    5.432003] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
[    5.432118] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
[    5.432315] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    5.432432] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[    5.433071] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[    5.433578] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[    5.434607] systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
[    5.436125] i2c_dev: i2c /dev entries driver
[    5.436672] systemd-journald[685]: Collecting audit messages is disabled.
[    5.438932] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[    5.442253] lp: driver loaded but no devices found
[    5.443359] ppdev: user-space parallel port driver
[    5.445438] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    5.445469] device-mapper: uevent: version 1.0.3
[    5.445522] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    5.445874] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[    5.446378] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
[    5.446985] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
[    5.454125] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
[    5.455242] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[    5.474199] EXT4-fs (nvme1n1p2): re-mounted 64d3d740-d9ee-4045-a5a4-c5608861a5bb r/w.
[    5.474996] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[    5.475268] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[    5.475305] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
[    5.475910] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[    5.475935] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[    5.476834] systemd[1]: Starting systemd-timesyncd.service - Network Time Synchronization...
[    5.477552] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[    5.477564] systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.477576] systemd[1]: systemd-pcrnvdone.service - TPM PCR NvPCR Initialization Separator was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.482555] systemd[1]: Starting systemd-userdbd.service - User Database Manager...
[    5.484570] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
[    5.485528] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
[    5.491544] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
[    5.497728] systemd[1]: Started systemd-userdbd.service - User Database Manager.
[    5.502945] systemd[1]: Started systemd-journald.service - Journal Service.
[    5.513802] systemd-journald[685]: Received client request to flush runtime journal.
[    5.641940] input: PC Speaker as /devices/platform/pcspkr/input/input16
[    5.643266] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[    5.645033] ccp 0000:08:00.2: tee enabled
[    5.645388] ccp 0000:08:00.2: psp enabled
[    5.656231] spd5118 2-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    5.656751] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    5.656754] RAPL PMU: hw unit of domain package 2^-16 Joules
[    5.656755] RAPL PMU: hw unit of domain core 2^-16 Joules
[    5.668440] spd5118 2-0051: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    5.698007] mc: Linux media interface: v0.10
[    5.699110] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    5.705013] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7b54b4961b8b4fadf'
[    5.705104] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
[    5.705198] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.705283] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    5.739231] Adding 66804732k swap on /dev/nvme1n1p3.  Priority:-2 extents:1 across:66804732k SS
[    5.807880] videodev: Linux video capture interface: v2.00
[    5.831536] Bluetooth: Core ver 2.22
[    5.831555] NET: Registered PF_BLUETOOTH protocol family
[    5.831557] Bluetooth: HCI device and connection manager initialized
[    5.831560] Bluetooth: HCI socket layer initialized
[    5.831565] Bluetooth: L2CAP socket layer initialized
[    5.831568] Bluetooth: SCO socket layer initialized
[    5.832485] kvm_amd: TSC scaling supported
[    5.832487] kvm_amd: Nested Virtualization enabled
[    5.832488] kvm_amd: Nested Paging enabled
[    5.832489] kvm_amd: LBR virtualization supported
[    5.832498] kvm_amd: Virtual GIF supported
[    5.832498] kvm_amd: Virtual NMI enabled
[    5.838638] snd_rpl_pci_acp6x 0000:08:00.5: enabling device (0000 -> 0002)
[    5.853879] usb 1-1.1.2: Found UVC 1.00 device <unnamed> (046d:0825)
[    5.853977] usbcore: registered new interface driver btusb
[    5.854126] snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
[    5.854211] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    5.854251] snd_hda_intel 0000:08:00.6: enabling device (0000 -> 0002)
[    5.856141] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20251015213201
[    5.857931] MCE: In-kernel MCE decoding enabled.
[    5.866585] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    5.867993] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input17
[    5.868060] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input18
[    5.868113] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input19
[    5.868162] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input20
[    5.873376] mt7925e 0000:06:00.0: enabling device (0000 -> 0002)
[    5.878298] mt7925e 0000:06:00.0: ASIC revision: 79250000
[    5.880657] snd_hda_codec_alc882 hdaudioC1D0: ALCS1200A: SKU not ready 0x00000000
[    5.881013] snd_hda_codec_alc882 hdaudioC1D0: autoconfig for ALCS1200A: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    5.881015] snd_hda_codec_alc882 hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.881016] snd_hda_codec_alc882 hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    5.881017] snd_hda_codec_alc882 hdaudioC1D0:    mono: mono_out=0x0
[    5.881018] snd_hda_codec_alc882 hdaudioC1D0:    inputs:
[    5.881020] snd_hda_codec_alc882 hdaudioC1D0:      Rear Mic=0x18
[    5.881021] snd_hda_codec_alc882 hdaudioC1D0:      Front Mic=0x19
[    5.889768] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input21
[    5.889832] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input22
[    5.889892] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input23
[    5.889941] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input24
[    5.889988] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input25
[    5.955801] mt7925e 0000:06:00.0: HW/SW Version: 0x8a108a10, Build Time: 20251015212927a

[    5.976683] usbcore: registered new interface driver uvcvideo
[    5.996427] amd_atl: AMD Address Translation Library initialized
[    5.996478] intel_rapl_common: Found RAPL domain package
[    5.996479] intel_rapl_common: Found RAPL domain core
[    6.222632] logitech-hidpp-device 0003:046D:408A.0006: HID++ 4.5 device connected.
[    6.303962] mt7925e 0000:06:00.0: WM Firmware Version: ____000000, Build Time: 20251015213023
[    6.478552] loop: module loaded
[    6.481282] loop0: detected capacity change from 0 to 197464
[    6.488831] loop1: detected capacity change from 0 to 1088256
[    6.488942] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    6.490383] loop2: detected capacity change from 0 to 1057184
[    6.491908] loop3: detected capacity change from 0 to 136904
[    6.493863] loop4: detected capacity change from 0 to 151456
[    6.496194] loop5: detected capacity change from 0 to 2717240
[    6.497714] loop6: detected capacity change from 0 to 136896
[    6.499227] loop7: detected capacity change from 0 to 240712
[    6.503137] loop11: detected capacity change from 0 to 151448
[    6.504583] loop10: detected capacity change from 0 to 8
[    6.505698] loop8: detected capacity change from 0 to 808920
[    6.506059] loop9: detected capacity change from 0 to 240712
[    6.506425] loop16: detected capacity change from 0 to 187776
[    6.510380] loop12: detected capacity change from 0 to 595504
[    6.510390] loop15: detected capacity change from 0 to 298920
[    6.510396] loop18: detected capacity change from 0 to 298920
[    6.510401] loop17: detected capacity change from 0 to 104296
[    6.510417] loop13: detected capacity change from 0 to 96480
[    6.510448] loop14: detected capacity change from 0 to 98480
[    6.594706] audit: type=1400 audit(1769521366.467:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="flatpak" pid=1177 comm="apparmor_parser"
[    6.594709] audit: type=1400 audit(1769521366.467:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="keybase" pid=1186 comm="apparmor_parser"
[    6.594711] audit: type=1400 audit(1769521366.467:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="devhelp" pid=1172 comm="apparmor_parser"
[    6.594712] audit: type=1400 audit(1769521366.467:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1164 comm="apparmor_parser"
[    6.594714] audit: type=1400 audit(1769521366.467:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ipa_verify" pid=1184 comm="apparmor_parser"
[    6.594715] audit: type=1400 audit(1769521366.467:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1163 comm="apparmor_parser"
[    6.594717] audit: type=1400 audit(1769521366.467:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="epiphany" pid=1174 comm="apparmor_parser"
[    6.594719] audit: type=1400 audit(1769521366.467:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1161 comm="apparmor_parser"
[    6.594720] audit: type=1400 audit(1769521366.467:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1158 comm="apparmor_parser"
[    6.594722] audit: type=1400 audit(1769521366.467:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="firefox" pid=1176 comm="apparmor_parser"
[    6.991075] mt7925e 0000:06:00.0 wlp6s0: renamed from wlan0
[    7.515614] RPC: Registered named UNIX socket transport module.
[    7.515616] RPC: Registered udp transport module.
[    7.515618] RPC: Registered tcp transport module.
[    7.515619] RPC: Registered tcp-with-tls transport module.
[    7.515620] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.569867] usb 1-1.1.2: set resolution quirk: cval->res = 384
[    7.624290] Bluetooth: hci0: Device setup in 1728759 usecs
[    7.624294] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    7.686539] usbcore: registered new interface driver snd-usb-audio
[    7.734536] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.734539] Bluetooth: BNEP filters: protocol multicast
[    7.734543] Bluetooth: BNEP socket layer initialized
[    7.735713] Bluetooth: MGMT ver 1.23
[    7.741318] NET: Registered PF_ALG protocol family
[    7.768411] Bluetooth: RFCOMM TTY layer initialized
[    7.768426] Bluetooth: RFCOMM socket layer initialized
[    7.768440] Bluetooth: RFCOMM ver 1.11
[    7.774841] nvme nvme0: using unchecked data buffer
[    7.812962] NET: Registered PF_QIPCRTR protocol family
[    8.249883] loop19: detected capacity change from 0 to 8
[   10.076683] logitech-hidpp-device 0003:046D:405E.0005: HID++ 4.5 device connected.
[   11.220753] igc 0000:07:00.0 enp7s0: NIC Link is Up 2500 Mbps Full Duplex, Flow Control: RX/TX
[   13.512052] netfs: FS-Cache loaded
[   13.574408] Key type dns_resolver registered
[   13.685760] NFS: Registering the id_resolver key type
[   13.685765] Key type id_resolver registered
[   13.685767] Key type id_legacy registered
[   14.728284] usb 1-1.1.2: reset high-speed USB device number 6 using xhci_hcd
[   15.209320] rfkill: input handler disabled
[   73.174043] rfkill: input handler enabled
[   73.239858] usb 1-1.1.2: reset high-speed USB device number 6 using xhci_hcd
[   74.005075] rfkill: input handler disabled
[   74.300195] input: solaar-keyboard as /devices/virtual/input/input26
[   74.742093] SCSI subsystem initialized
[  324.243024] loop19: detected capacity change from 0 to 240712
[  324.657411] loop20: detected capacity change from 0 to 298920
[  324.785192] kauditd_printk_skb: 149 callbacks suppressed
[  324.785195] audit: type=1400 audit(1769521687.099:161): apparmor="DENIED" operation="open" class="file" profile="/usr/sbin/cupsd" name="/etc/paperspecs" pid=11758 comm="cupsd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[  324.791115] audit: type=1400 audit(1769521687.103:162): apparmor="DENIED" operation="capable" class="cap" profile="/usr/sbin/cupsd" pid=11758 comm="cupsd" capability=12  capname="net_admin"
[  325.173526] audit: type=1400 audit(1769521687.487:163): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine" pid=11774 comm="apparmor_parser"
[  325.173530] audit: type=1400 audit(1769521687.487:164): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=11774 comm="apparmor_parser"
[  325.182970] audit: type=1400 audit(1769521687.495:165): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap-update-ns.subsurface" pid=11776 comm="apparmor_parser"
[  325.316897] audit: type=1400 audit(1769521687.627:166): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.subsurface.subsurface" pid=11777 comm="apparmor_parser"
[  325.753799] audit: type=1400 audit(1769521688.067:167): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine" pid=11785 comm="apparmor_parser"
[  325.753804] audit: type=1400 audit(1769521688.067:168): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=11785 comm="apparmor_parser"
[  325.830073] audit: type=1400 audit(1769521688.143:169): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.discord.hook.configure" pid=11789 comm="apparmor_parser"
[  325.889155] audit: type=1400 audit(1769521688.203:170): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap-update-ns.discord" pid=11787 comm="apparmor_parser"
[ 1903.594221] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0] flip_done timed out
