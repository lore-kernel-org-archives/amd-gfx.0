Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A39D5AE75
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 08:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA9810E7BF;
	Thu,  7 Nov 2024 08:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKumNC6N";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F0010E2E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 15:31:35 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-20cbcd71012so78948895ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2024 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730907094; x=1731511894; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q8jaWf2xrBXMPxQoii0wHnCD6lmVOnUbenrJStOU+aM=;
 b=OKumNC6NxMUYgXFXBOX0fYx8ZPL1stDSnLsMMJZa3jZ6KgUlV3G7iseGGCSx7rRiEa
 f3oX7YmxjZkLrpWsPPONsaMEaOcpYQAroPtL8q1JTU6Ty0DMXqL8wMFOVmi12zbl697j
 opdA9t/umdIaGwS3CJDlf8Xc8j8J71+yBOfeHDNoxM/3Sg9Fc+7rkENFUVr2RRccioEl
 Pa9qAbezYqF633pndWdz+ZY1jD6FbLyRW8TmZDN/gIb9VsdNh3Mx6JzA2kwg1U7PHosJ
 jivFWEFqpHqg3/OBQSS9tvEA8xb28PrPAjA8xN9JM+uIgKJat351PcP+zXDs8luFSW02
 pIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730907094; x=1731511894;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q8jaWf2xrBXMPxQoii0wHnCD6lmVOnUbenrJStOU+aM=;
 b=k310FnItiGlQdZpMWEB6I0O8otHjQZVS3pH1BzjxufQSw6QB/uy6p6fzMDm4O0EJkH
 +vEH4U+Aex639YvRbmIn5mzT+6zCbOISTQlTcx2GDBh4fIVE2H4hNu7QT/pf7Eyj2M9U
 Cmfq42uTMQHdo0kImd+q81GxW/8BEznvx/0PLzF1tRkZ3vAEFsy9MTOFfJs57eoK0vUY
 X5dWBb2RkiwMKENv0gjmD/mfPHk/MegIqWcYinWEo43mwvx7+3gtkXFolFiMhKpJu1YJ
 gMqPWv+8my6NR6Z9eAptpzQVQ2AcdZYNjUCzNYoantar60+gIJpjBzMr4Bol/orcZJft
 qYag==
X-Gm-Message-State: AOJu0YyDVrTTYNm1ij17Rt0H4436qDg63asaxCYsfUl+99Fpm7mzc8BL
 gwEar66IZsmgUixU3QXiaxeBmY2EDBHAL5Q1/Qcp722gPP4XkEeS0uGDKaNZpaLmfXI7/tkDJLw
 P/Qk/po6RgibD8V/BcE6rmazXzd1vhtkc
X-Google-Smtp-Source: AGHT+IFyFAhVHTEuLrrO+FqqqHBERxoaonaxtYv99usDos9srD/tJ6ukQnzE4alvWSSFjZ05tIU9UMdvvsQJELzYes0=
X-Received: by 2002:a17:90b:384f:b0:2e9:2329:8ca8 with SMTP id
 98e67ed59e1d1-2e94c29eab3mr26800622a91.6.1730907093539; Wed, 06 Nov 2024
 07:31:33 -0800 (PST)
MIME-Version: 1.0
From: Kenneth Topp <twenty88@gmail.com>
Date: Wed, 6 Nov 2024 10:31:22 -0500
Message-ID: <CAE6xmHJLMixQpiJaPGLkzL3wsfeFQBbEVn2U2fwi=o5eFn86Tg@mail.gmail.com>
Subject: no-retry page fault on 6.11.6 kernel with radeon VII
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 07 Nov 2024 08:03:03 +0000
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

Greetings,

I'm getting no-retry page fault fatal errors (kills Xwayland):

[  177.470230 <    6.102062 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.470483 <    0.000253 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.470535 <    0.000052 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc2000 from IH
client 0x1b (UTCL2)
[  177.470584 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0030113D
[  177.470625 <    0.000041 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
[  177.470666 <    0.000041 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x1
[  177.470706 <    0.000040 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x6
[  177.470745 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x3
[  177.470784 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x1
[  177.470822 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0

I can seem to trigger this at will by visiting a specific website with
brave-browser and clicking around (website is the plex web interface
to their media server product).  I haven't tried other browsers, but
I've been using the browser without issues for a few days. I'm running
fedora 41 with fairly stock settings, on an amd cpu and radeon VII
gpu.  This started after a recent upgrade of my cpu/motherboard, but
I've used this GPU on my old machine going to the website without
issue in the past.

Because I can trigger this specifically and otherwise the machine
seems fine, I'm thinking this is a driver issue.  If there's any way I
can diagnose this further, I'd be happy to do so.

Thanks,

Ken



full kernel log (grep amdgpu)


[   24.704005 <    0.131995 >] myhost kernel: [drm] amdgpu kernel
modesetting enabled.
[   24.705003 <    0.000998 >] myhost kernel: amdgpu: vga_switcheroo:
detected switching method \_SB_.PCI0.GP17.VGA_.ATPX handle
[   24.705058 <    0.000055 >] myhost kernel: amdgpu: ATPX version 1,
functions 0x00000000
[   24.708005 <    0.002947 >] myhost kernel: amdgpu: Virtual CRAT
table created for CPU
[   24.708021 <    0.000016 >] myhost kernel: amdgpu: Topology: Add CPU node
[   24.708038 <    0.000017 >] myhost kernel: amdgpu 0000:03:00.0:
enabling device (0006 -> 0007)
[   24.710022 <    0.000006 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: Fetched VBIOS from VFCT
[   24.710081 <    0.000059 >] myhost kernel: amdgpu: ATOM BIOS:
113-D3600200-106
[   24.813006 <    0.005001 >] myhost kernel: amdgpu 0000:03:00.0:
vgaarb: deactivate vga console
[   24.813157 <    0.000151 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: Trusted Memory Zone (TMZ) feature not supported
[   24.813239 <    0.000082 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: MEM ECC is not presented.
[   24.813308 <    0.000069 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: SRAM ECC is not presented.
[   24.813382 <    0.000074 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: RAS INFO: ras initialized successfully, hardware ability[4]
ras_mask[4]
[   24.813477 <    0.000014 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VRAM: 16368M 0x0000008000000000 - 0x00000083FEFFFFFF (16368M
used)
[   24.813544 <    0.000067 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
[   24.813620 <    0.000006 >] myhost kernel: [drm] amdgpu: 16368M of
VRAM memory ready
[   24.813625 <    0.000005 >] myhost kernel: [drm] amdgpu: 95403M of
GTT memory ready.
[   24.813648 <    0.000005 >] myhost kernel: amdgpu: hwmgr_sw_init
smu backed is vega20_smu
[   24.839004 <    0.017000 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.839016 <    0.000012 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.839020 <    0.000004 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.860013 <    0.000008 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.860019 <    0.000006 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.860026 <    0.000007 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.881040 <    0.000013 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.881047 <    0.000007 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.881053 <    0.000006 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.902005 <    0.017973 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.902026 <    0.000021 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.902040 <    0.000014 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.923021 <    0.000013 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.923025 <    0.000004 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.923034 <    0.000009 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.944047 <    0.000039 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.944052 <    0.000005 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.944056 <    0.000004 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.965056 <    0.000040 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.965073 <    0.000017 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.965078 <    0.000005 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   24.986099 <    0.000074 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* TIMEOUT ERROR !!!
[   24.986127 <    0.000028 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* ReadData() - I2C error occurred :8
[   24.996025 <    0.009898 >] myhost kernel: [drm:unlock_bus
[amdgpu]] *ERROR* Failed to unlock the bus from SMU
[   25.051032 <    0.048858 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: reserve 0x400000 from 0x83fe000000 for PSP TMR
[   25.163034 <    0.112002 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: RAP: optional rap ta ucode is not available
[   25.184032 <    0.017019 >] myhost kernel: snd_hda_intel
0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   25.689067 <    0.000045 >] myhost kernel:
[drm:smu_v11_0_i2c_xfer.cold [amdgpu]] *ERROR* Received
I2C_NAK_7B_ADDR_NOACK !!!
[   25.689076 <    0.000009 >] myhost kernel: [drm:smu_v11_0_i2c_xfer
[amdgpu]] *ERROR* WriteI2CData() - I2C error occurred :1
[   25.689085 <    0.000009 >] myhost kernel:
[drm:amdgpu_ras_eeprom_init [amdgpu]] *ERROR* Failed to read EEPROM
table header, res:-5
[   25.689110 <    0.000025 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: Failed to initialize ras recovery! (-5)
[   25.739062 <    0.049952 >] myhost kernel: amdgpu: HMM registered
16368MB device memory
[   25.740003 <    0.000941 >] myhost kernel: kfd kfd: amdgpu:
Allocated 3969056 bytes on gart
[   25.740290 <    0.000287 >] myhost kernel: kfd kfd: amdgpu: Total
number of KFD nodes to be created: 1
[   25.740320 <    0.000030 >] myhost kernel: amdgpu: Virtual CRAT
table created for GPU
[   25.740325 <    0.000005 >] myhost kernel: amdgpu: Topology: Add
dGPU node [0x66af:0x1002]
[   25.740331 <    0.000006 >] myhost kernel: kfd kfd: amdgpu: added
device 1002:66af
[   25.740356 <    0.000025 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: SE 4, SH per SE 1, CU per SH 16, active_cu_number 60
[   25.740444 <    0.000088 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring gfx uses VM inv eng 0 on hub 0
[   25.740495 <    0.000051 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   25.740537 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   25.740576 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[   25.740615 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[   25.740654 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[   25.740693 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[   25.740735 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[   25.740773 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[   25.740812 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
[   25.740850 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
[   25.740887 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring page0 uses VM inv eng 1 on hub 8
[   25.740973 <    0.000086 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring sdma1 uses VM inv eng 4 on hub 8
[   25.741023 <    0.000050 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring page1 uses VM inv eng 5 on hub 8
[   25.741061 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring uvd_0 uses VM inv eng 6 on hub 8
[   25.741100 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring uvd_enc_0.0 uses VM inv eng 7 on hub 8
[   25.741137 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring uvd_enc_0.1 uses VM inv eng 8 on hub 8
[   25.741173 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring uvd_1 uses VM inv eng 9 on hub 8
[   25.741210 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring uvd_enc_1.0 uses VM inv eng 10 on hub 8
[   25.741247 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring uvd_enc_1.1 uses VM inv eng 11 on hub 8
[   25.741284 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring vce0 uses VM inv eng 12 on hub 8
[   25.741322 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring vce1 uses VM inv eng 13 on hub 8
[   25.741361 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring vce2 uses VM inv eng 14 on hub 8
[   25.748016 <    0.006655 >] myhost kernel: amdgpu: Detected AMDGPU
DF Counters. # of Counters = 8.
[   25.748034 <    0.000018 >] myhost kernel: amdgpu: Detected AMDGPU
2 Perf Events.
[   25.748041 <    0.000007 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: Runtime PM not available
[   25.748138 <    0.000097 >] myhost kernel: [drm] Initialized amdgpu
3.59.0 for 0000:03:00.0 on minor 1
[   25.758015 <    0.009877 >] myhost kernel: fbcon: amdgpudrmfb (fb0)
is primary device
[   25.987041 <    0.029999 >] myhost kernel: amdgpu 0000:03:00.0:
[drm] fb0: amdgpudrmfb frame buffer device
[   26.005302 <    0.018261 >] myhost kernel: amdgpu 0000:7d:00.0:
enabling device (0006 -> 0007)
[   26.005642 <    0.000006 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: Fetched VBIOS from VFCT
[   26.005721 <    0.000079 >] myhost kernel: amdgpu: ATOM BIOS: 102-RAPHAEL-008
[   26.043035 <    0.037314 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental
(default)
[   26.043390 <    0.000013 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M
used)
[   26.043477 <    0.000087 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[   26.043582 <    0.000011 >] myhost kernel: [drm] amdgpu: 2048M of
VRAM memory ready
[   26.043589 <    0.000007 >] myhost kernel: [drm] amdgpu: 95403M of
GTT memory ready.
[   26.066028 <    0.022403 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: reserve 0xa00000 from 0xf47e000000 for PSP TMR
[   26.132029 <    0.066001 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: RAS: optional ras ta ucode is not available
[   26.138005 <    0.005976 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: RAP: optional rap ta ucode is not available
[   26.138081 <    0.000076 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[   26.140004 <    0.001923 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: SMU is initialized successfully!
[   26.142005 <    0.000992 >] myhost kernel: snd_hda_intel
0000:7d:00.1: bound 0000:7d:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   26.146003 <    0.003000 >] myhost kernel: kfd kfd: amdgpu:
Allocated 3969056 bytes on gart
[   26.146054 <    0.000051 >] myhost kernel: kfd kfd: amdgpu: Total
number of KFD nodes to be created: 1
[   26.146102 <    0.000048 >] myhost kernel: amdgpu: Virtual CRAT
table created for GPU
[   26.146106 <    0.000004 >] myhost kernel: amdgpu: Topology: Add
dGPU node [0x13c0:0x1002]
[   26.146110 <    0.000004 >] myhost kernel: kfd kfd: amdgpu: added
device 1002:13c0
[   26.146135 <    0.000025 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: SE 1, SH per SE 1, CU per SH 2, active_cu_number 2
[   26.146175 <    0.000040 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[   26.146212 <    0.000037 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on hub 0
[   26.146247 <    0.000035 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.0.0 uses VM inv eng 4 on hub 0
[   26.146280 <    0.000033 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.1.0 uses VM inv eng 5 on hub 0
[   26.146314 <    0.000034 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[   26.146348 <    0.000034 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[   26.146383 <    0.000035 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[   26.146416 <    0.000033 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[   26.146449 <    0.000033 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[   26.146482 <    0.000033 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[   26.146516 <    0.000034 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 on hub 0
[   26.146548 <    0.000032 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[   26.146582 <    0.000034 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8
[   26.146614 <    0.000032 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 8
[   26.146648 <    0.000034 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 8
[   26.146682 <    0.000034 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 8
[   26.147003 <    0.000321 >] myhost kernel: amdgpu 0000:7d:00.0:
amdgpu: Runtime PM not available
[   26.148013 <    0.001010 >] myhost kernel: [drm] Initialized amdgpu
3.59.0 for 0000:7d:00.0 on minor 0
[   26.154014 <    0.006001 >] myhost kernel: amdgpu 0000:7d:00.0:
[drm] Cannot find any crtc or sizes
[  177.470230 <    6.102062 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.470483 <    0.000253 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.470535 <    0.000052 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc2000 from IH
client 0x1b (UTCL2)
[  177.470584 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0030113D
[  177.470625 <    0.000041 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
[  177.470666 <    0.000041 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x1
[  177.470706 <    0.000040 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x6
[  177.470745 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x3
[  177.470784 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x1
[  177.470822 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.470860 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.470898 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.470935 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd8000 from IH
client 0x1b (UTCL2)
[  177.470974 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.471021 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.471060 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.471098 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.471137 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.471176 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.471213 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.471249 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.471286 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.471323 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc0000 from IH
client 0x1b (UTCL2)
[  177.471361 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.471398 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.471435 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.471471 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.471509 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.471544 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.471580 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.471616 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.471653 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.471688 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd0000 from IH
client 0x1b (UTCL2)
[  177.471725 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.471761 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.471797 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.471831 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.471868 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.471903 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.471938 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.471974 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.472013 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.472048 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc8000 from IH
client 0x1b (UTCL2)
[  177.472086 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.472123 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.472159 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.472194 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.472228 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.472263 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.472298 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.472333 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.472369 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.472404 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc0000 from IH
client 0x1b (UTCL2)
[  177.472439 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.472474 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.472509 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.472544 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.472580 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.472616 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.472650 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.472685 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.472722 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.472758 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd6000 from IH
client 0x1b (UTCL2)
[  177.472795 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.472830 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.472866 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.472902 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.472936 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.472972 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.473015 <    0.000043 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.473052 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.473088 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.473124 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd2000 from IH
client 0x1b (UTCL2)
[  177.473161 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.473197 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.473232 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.473267 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.473301 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.473336 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.473371 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.473406 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.473442 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.473477 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc8000 from IH
client 0x1b (UTCL2)
[  177.473512 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.473549 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.473583 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.473618 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.473726 <    0.000108 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.473768 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.473803 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  177.473852 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  177.473887 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  177.473923 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd4000 from IH
client 0x1b (UTCL2)
[  177.473961 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  177.473997 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  177.474038 <    0.000041 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  177.474073 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  177.474109 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  177.474143 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  177.474177 <    0.000034 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.729538 <    0.000143 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.729809 <    0.000271 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.729885 <    0.000076 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc2000 from IH
client 0x1b (UTCL2)
[  187.729931 <    0.000046 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0030113D
[  187.729968 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
[  187.730028 <    0.000060 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x1
[  187.730068 <    0.000040 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x6
[  187.730107 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x3
[  187.730143 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x1
[  187.730180 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.730217 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.730254 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.730299 <    0.000045 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dda000 from IH
client 0x1b (UTCL2)
[  187.730345 <    0.000046 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  187.730391 <    0.000046 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  187.730432 <    0.000041 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  187.730469 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  187.730506 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  187.730710 <    0.000204 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  187.730837 <    0.000127 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.730921 <    0.000084 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.730996 <    0.000075 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.731095 <    0.000099 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc2000 from IH
client 0x1b (UTCL2)
[  187.731169 <    0.000074 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  187.731243 <    0.000074 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  187.731315 <    0.000072 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  187.731387 <    0.000072 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  187.731493 <    0.000106 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  187.731595 <    0.000102 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  187.731693 <    0.000098 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.731769 <    0.000076 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.731819 <    0.000050 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.731868 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc0000 from IH
client 0x1b (UTCL2)
[  187.731916 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  187.731964 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  187.732020 <    0.000056 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  187.732067 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  187.732116 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  187.732167 <    0.000051 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  187.732216 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.732255 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.732294 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.732331 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd8000 from IH
client 0x1b (UTCL2)
[  187.732377 <    0.000046 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0030113D
[  187.732425 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
[  187.732464 <    0.000039 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x1
[  187.732499 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x6
[  187.732536 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x3
[  187.732573 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x1
[  187.732608 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.732645 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.732680 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.732717 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd0000 from IH
client 0x1b (UTCL2)
[  187.732755 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0030113D
[  187.732793 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
[  187.732829 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x1
[  187.732864 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x6
[  187.732902 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x3
[  187.732937 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x1
[  187.732973 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.733015 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.733060 <    0.000045 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.733096 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc8000 from IH
client 0x1b (UTCL2)
[  187.733131 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0030113D
[  187.733167 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
[  187.733204 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x1
[  187.733239 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x6
[  187.733275 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x3
[  187.733310 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x1
[  187.733346 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.733384 <    0.000038 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.733419 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.733456 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc8000 from IH
client 0x1b (UTCL2)
[  187.733492 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  187.733543 <    0.000051 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  187.733585 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  187.733622 <    0.000037 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  187.733670 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  187.733721 <    0.000051 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  187.733770 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.733818 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.733865 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.733915 <    0.000050 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dc0000 from IH
client 0x1b (UTCL2)
[  187.733963 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  187.734020 <    0.000057 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  187.734070 <    0.000050 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  187.734117 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  187.734164 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  187.734211 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  187.734261 <    0.000050 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.734308 <    0.000047 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: [gfxhub0] no-retry page fault (src_id:0 ring:158 vmid:3
pasid:32776)
[  187.734358 <    0.000050 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:  for process Xwayland pid 5930 thread Xwayland:cs0 pid 6496)
[  187.734407 <    0.000049 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:   in page starting at address 0x0000800101dd6000 from IH
client 0x1b (UTCL2)
[  187.734455 <    0.000048 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  187.734497 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          Faulty UTCL2 client ID: CB (0x0)
[  187.734533 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MORE_FAULTS: 0x0
[  187.734575 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          WALKER_ERROR: 0x0
[  187.734617 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          PERMISSION_FAULTS: 0x0
[  187.734659 <    0.000042 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          MAPPING_ERROR: 0x0
[  187.734695 <    0.000036 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu:          RW: 0x0
[  187.734730 <    0.000035 >] myhost kernel: amdgpu 0000:03:00.0:
amdgpu: ring gfx timeout, but soft recovered
