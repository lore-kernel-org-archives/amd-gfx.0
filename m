Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE38AD116FF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 08:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0FA10E592;
	Tue,  2 Dec 2025 08:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TaDr7HVh";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57E010E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 03:49:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477632d9326so30958835e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 19:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764647342;
 x=1765252142; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1Mip76oR/J7pQnuSTihzljgSX9wgGK+T6mAyrxM6Y8=;
 b=TaDr7HVhDMhHFA5/4KFITOc2YvRSMLTx8x+eIHEUGC7YZqQ7Y+3phEqWzo0Asvyroc
 VpHZ8+o81x6v2zEP4TCJkeIucGjy17oj/lC5gDReAV9+nHjG4wcLpeKbMxEr49jHmx+t
 9s9UUOSZNaSkaigNXcFq5p19CWwkmTx/kn3xDlz8nd+Kat0IRMIfVGppiWL/SGykfT6h
 ZncR8C+8tUjTKe+YXB7ftv9DHT0wo/AzGj7LYhBGBYj6XoW4Y/XBmTM4YM5oj2lb1WOo
 IirX4VM5jN1ygr7woUMBGl0ZisVDrsXZjeO/UEyMW/60XgsgsoQRyDvGLIMYF97+bjop
 mFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764647342; x=1765252142;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q1Mip76oR/J7pQnuSTihzljgSX9wgGK+T6mAyrxM6Y8=;
 b=mwQAqASO7Zx6vVJLnPnDWCwPUmkps1NFPKtdP9PQQNYvXyeMPjtizsaBBx1veBoNV0
 tfJoc3qdHHnn+0i56K5lv2kDd1bVTlKthF2wACWO6mvhVtYmxEajl/J9ezlTkfUVoEb+
 8Oz7JJZNEut7SGVy1QqNPu35/OINBW2/tcHOZ2kGfq+jsejsjFOqlzIJQpND5wXTe77g
 psaZotajBYanBdCPejMLWL0icXYIHCb1IDThCNDlYS7nvk/2m/5m/DUGJdd7GtBs21X0
 Uc9CPzdRPAphTW8VINuPYZM7n4sch6Yx/kiILUg92Dt8I+C8B6avr/LrnVb74oHlEekP
 pjpg==
X-Gm-Message-State: AOJu0YzpVbiOV09Ew+IB8c84A9ZoVCl22BleomrC3eZeh0tniZ9uqZ1U
 p6SoGv9NAxLAp+rhn5idJW6yoLUgSJI2Czmx0Ljxm3RcCHA1zq/xPCCAyDLF/YmG4zGZBoJ2OeP
 EjSKL
X-Gm-Gg: ASbGncutyONLhfIgBDGqavGEQbZcuzd0qvvFditBMhI/iU+W1lNaniM7ryL98okY6eH
 swXPqtzrqLVq5462me9KtP16BeW54/CfwuIVQ7GPlPwm82Mnw6DLaAmgu/IFi/QXkTXfYu0ku4F
 9OdlpUK3XzBy/eI3J5H9il/spfL9U/j3U9IyDQ+WFEPYXOtgCFfGmNjSS1AGxr+124ckJaUof29
 0wfpgsw9JP4+jzYTTapCp7dCm1PMhiHnZKhs86CcEeDR5yjWgoMl/yvZW6t1j6uqzHkYGDLsMoX
 IkhLoaLmX8aYaJJDrEPpWLJ+V7EszOKf0xL8sRiW+J34Jgjqv80fls/pFmS0tf9a9B0JcoQBnUn
 OuGqEriAGyPnjp3vlV3afOkozt3RK644R/KD1Wz3SZuWUqosMgmLvHQJBr+G+YFAVjAoGPC47LV
 JV5r4KSG5yAfHOPaQwjcRJyKMCTp/7jR6vN4lBwq8Ag6Uq+13o+OFl
X-Google-Smtp-Source: AGHT+IFThOljGVlAloEsaZtpZrqllL7YU+hPnXBGvqqHa5UfsOpKU7fqJ7OaECBGVXHd6acc7rrtow==
X-Received: by 2002:a5d:5848:0:b0:429:b8e2:1064 with SMTP id
 ffacd0b85a97d-42cc1d19df2mr45191899f8f.47.1764647341771; 
 Mon, 01 Dec 2025 19:49:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d614asm30279286f8f.12.2025.12.01.19.48.59
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 19:49:01 -0800 (PST)
Date: Mon, 1 Dec 2025 19:48:52 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: amd-gfx@lists.freedesktop.org
Subject: AMD GPU crash in firefox
Message-ID: <20251201194852.5f65e5b8@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 02 Dec 2025 08:16:18 +0000
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

I get random AMD GPU graphics crashes on my system.
Usually it is when I am using Firefox on one display, but other one continues to work.
Luckily it clears after auto-suspend, so reboot is not always needed.

The system is Debian testing on Minisform Atonman G7 PT:
$ uname -r
6.17.8+deb14-amd64
$ lspci | grep Radeon
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 33 [Radeon RX 7600/7600 XT/7600M XT/7600S/7700S / PRO W7600] (rev c7)

# dmesg | grep amdgpu
[    2.108329] [drm] amdgpu kernel modesetting enabled.
[    2.108416] amdgpu: Virtual CRAT table created for CPU
[    2.108426] amdgpu: Topology: Add CPU node
[    2.108526] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
[    2.108580] amdgpu 0000:03:00.0: amdgpu: initializing kernel modesetting (IP DISCOVERY 0x1002:0x7480 0x1F4C:0xB006 0xC7).
[    2.108590] amdgpu 0000:03:00.0: amdgpu: register mmio base: 0xFC900000
[    2.108592] amdgpu 0000:03:00.0: amdgpu: register mmio size: 1048576
[    2.112195] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <soc21_common>
[    2.112196] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v11_0>
[    2.112198] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <ih_v6_0>
[    2.112199] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[    2.112200] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[    2.112201] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[    2.112202] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v11_0>
[    2.112204] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v6_0>
[    2.112205] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v4_0>
[    2.112206] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v4_0>
[    2.112207] amdgpu 0000:03:00.0: amdgpu: detected ip block number 10 <mes_v11_0>
[    2.112216] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.112218] amdgpu: ATOM BIOS: 113-BRT138292-001
[    2.112880] amdgpu 0000:03:00.0: amdgpu: CP RS64 enable
[    2.113936] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    2.113937] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    2.113990] amdgpu 0000:03:00.0: amdgpu: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.113995] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
[    2.113997] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.114082] amdgpu 0000:03:00.0: amdgpu: amdgpu: 8176M of VRAM memory ready
[    2.114084] amdgpu 0000:03:00.0: amdgpu: amdgpu: 32003M of GTT memory ready.
[    2.114468] amdgpu 0000:03:00.0: amdgpu: [drm] Loading DMUB firmware via PSP: version=0x07002F00
[    2.114607] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 22
[    2.171535] amdgpu 0000:03:00.0: amdgpu: reserve 0x1300000 from 0x81fc000000 for PSP TMR
[    2.267750] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    2.275339] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    2.275340] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    2.275368] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x00000035, smu fw if version = 0x00000040, smu fw program = 0, smu fw version = 0x00525e00 (82.94.0)
[    2.275370] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[    2.316195] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    2.316529] amdgpu 0000:03:00.0: amdgpu: [drm] Display Core v3.2.340 initialized on DCN 3.2.1
[    2.316531] amdgpu 0000:03:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
[    2.318380] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x07002F00
[    2.374675] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.506774] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.675018] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.739109] amdgpu: HMM registered 8176MB device memory
[    2.740314] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    2.740323] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    2.740361] amdgpu: Virtual CRAT table created for GPU
[    2.740456] amdgpu: Topology: Add dGPU node [0x7480:0x1002]
[    2.740457] kfd kfd: amdgpu: added device 1002:7480
[    2.740468] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8, active_cu_number 32
[    2.740472] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    2.740474] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.740475] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.740476] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    2.740478] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    2.740479] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    2.740480] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    2.740481] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    2.740482] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    2.740483] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[    2.740484] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
[    2.740486] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    2.740487] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[    2.740488] amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
[    2.741815] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm
[    2.742103] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
[    2.747107] fbcon: amdgpudrmfb (fb0) is primary device
[    2.945928] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    5.878002] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])

[ 7820.648000] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0] flip_done timed out
[ 8817.492261] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
[ 8817.492272] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0] commit wait timed out
[ 8827.732082] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
[ 8827.732094] amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:77:plane-6] commit wait timed out

[15098.101360] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[15098.101368] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[15098.101534] amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
[15100.933194] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[15100.989233] amdgpu 0000:03:00.0: amdgpu: reserve 0x1300000 from 0x81fc000000 for PSP TMR
[15101.085342] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
[15101.092952] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
[15101.092953] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
[15101.092955] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[15101.092958] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x00000035, smu fw if version = 0x00000040, smu fw program = 0, smu fw version = 0x00525e00 (82.94.0)
[15101.092960] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[15101.135102] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[15101.144351] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x07002F00
[15101.471792] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[15101.471796] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[15101.471797] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[15101.471798] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[15101.471799] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[15101.471800] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[15101.471801] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[15101.471802] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[15101.471803] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[15101.471804] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[15101.471805] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
[15101.471806] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[15101.471807] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[15101.471808] amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
[16260.283220] amdgpu 0000:03:00.0: amdgpu: VM memory stats for proc RDD Process(12593) task firefox-es:cs0(5217) is non-zero when fini
[16260.367845] amdgpu 0000:03:00.0: amdgpu: VM memory stats for proc firefox-esr(5175) task firefox-es:cs0(5055) is non-zero when fini
