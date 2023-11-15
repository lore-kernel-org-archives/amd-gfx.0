Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F7C47072
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 09:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FFA10E50C;
	Wed, 15 Nov 2023 09:15:55 +0000 (UTC)
X-Greylist: delayed 571 seconds by postgrey-1.36 at gabe;
 Wed, 15 Nov 2023 03:15:45 UTC
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9375210E38C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 03:15:45 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id D4A593200982
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 22:06:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 14 Nov 2023 22:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1700017570; x=1700103970; bh=72a8GWWuNFpNa1sH7pNfRakzY
 b3vuG6LyIAQwz3mJZU=; b=OYBNkqEVZcMp0S01AZajKm8P9u5PrH4ULSBgGAwUQ
 QCU+TulBXC6fsv6fIGdOm3bW1nyTuzz3/9TA6/oZSO3x7YmHezcffzkxn9o2DlQE
 PY7F149ufkoAMNcQ3STeKXYblrxGqH4GZUNJCWVizXwaMQNAbADzzlBFg6nx0Peo
 AnAzi31BiqSmkKHzBB1H5oVZt3N+dO5GrpANy3FCyyR+SES5y4m+WoyJy016jV9C
 k77AhRg/P7AFlE9n7ERWZtFALtO0h7u2JAM0vguQ5NaGpssrbwerKTDDANn2vSHu
 1y5mYqFhDtZkt1MZaZ/HXhziU1M7K8KygOO74q8qbJo2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1700017570; x=1700103970; bh=72a8GWWuNFpNa1sH7pNfRakzYb3vuG6LyIA
 Qwz3mJZU=; b=UmfakmAmuY/ToNiTJ1r6VY/htayR5c5Cdtsjd0ZglMSc/DvvtC5
 7WPr2UkNxjSJxGjEVKNeX4APi7nukENGPohUtzUqaCZ4HCBKrnK+zFQszsbNYcY2
 jQGFXlWz0GV6G5nztcRYbbmmexwHHzhQUFhid2bCaGGpdm1DZCSdgCsIW5c0280p
 kuA9ElcjYzdYSUPP6f7lz6IHfx3lUiAKdAZCaIr+HfT3RvTWJvy2zWG1BMH1H6aj
 YiKMvlEq4ttp4juah+lXh9APD9nNNt6YlFoevTqIDW9kk4UQv1Hfb/NHJyQFtJ8f
 MnV3GQtEOFOSit3nvgfPbqP9+Pcd+PRXwlQ==
X-ME-Sender: <xms:ojVUZQ4wZtc8Vt8X_hNYj_wJ6q7S8r1wsLdUn79ywUqhf2om8-MKJg>
 <xme:ojVUZR4mjT7ZlsPjnElcRbVBR677EUlr9yuS8xSHdj1pi1q9WYOByIGRn_K4cGwwN
 wwESp9oDojsI01K0BA>
X-ME-Received: <xmr:ojVUZfeGYJF8XTd7jZh80Q1dkpLDtrOCtzSLYJmC6mv0FTm6xwkYTsuxNc6Qdsh0_bLrYC8fKAFhGichs9GgbfFIAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefgedgheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpeffhf
 fvuffkgggtugesthdtredttddtvdenucfhrhhomheplfgrnhcujfgvnhgurhhikhcuhfgr
 rhhruceokhgvrhhnvghlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepffehge
 dtffefheejheelheefjefhgfegheejiefgueelieetuedvjeekudfhgfeinecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfh
 grrhhrrdgttg
X-ME-Proxy: <xmx:ojVUZVLN8oF18w3Xg6RyvNM3JC6Qj2qeacG0cNAF2Vtogh4Lc3XuPA>
 <xmx:ojVUZULctBjoPJ2NALbV0XPvhyAq_teUzK0geNuP951L1rvkHPy-5g>
 <xmx:ojVUZWywo8wruabvjbejG3hkKxpnGfIRyYgKs3gEw4iFXpKE1WnVjw>
 <xmx:ojVUZbm--E5eyeOXcvjhnTCAffA3yHHkyYNUvJcjg1NPyt00n41G6Q>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 22:06:09 -0500 (EST)
Date: Wed, 15 Nov 2023 04:06:07 +0100
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: amd-gfx@lists.freedesktop.org
Subject: drm/amdgpu: dmesg errors on 6.7.0-rc1 with latest firmware
Message-ID: <ZVQ1n0DdLNvQHa3H@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 15 Nov 2023 09:15:52 +0000
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

Hi all,

just took out 6.7.0-rc1 for a spin (including latest upstream linux-firmware).
GPU is an RX 7800 XT. I'm getting a constant flood of errors in dmesg.

Otherwise I don't observe any out of place behavior on linux. However, when I
reboot into Windows I get a low resolution display (I'm assuming the normal
AMD driver on Windows does not get loaded). Completely unplugging the PC
from the wall fixes that issue until the next time I boot using 6.7.0-rc1
and latest firmware.

Haven't tested other scenarios yet (like latest firmware on kernel 6.6).

Best Regards
Jan

Here is an excerpt from the errors (grepped dmesg for "amdgpu"):

Nov 14 20:16:14 desktop kernel: [drm] amdgpu kernel modesetting enabled.
Nov 14 20:16:14 desktop kernel: amdgpu: Virtual CRAT table created for CPU
Nov 14 20:16:14 desktop kernel: amdgpu: Topology: Add CPU node
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
Nov 14 20:16:14 desktop kernel: amdgpu: ATOM BIOS: 113-APM6767CL-100
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: CP RS64 enable
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_early_init [amdgpu]] JPEG decode is enabled in VM mode
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: vgaarb: deactivate vga console
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: MEM ECC is not presented.
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SRAM ECC is not presented.
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: VRAM: 16368M 0x0000008000000000 - 0x00000083FEFFFFFF (16368M used)
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: AGP: 133660672M 0x0000008400000000 - 0x00007FFBFFFFFFFF
Nov 14 20:16:14 desktop kernel: [drm] amdgpu: 16368M of VRAM memory ready
Nov 14 20:16:14 desktop kernel: [drm] amdgpu: 32021M of GTT memory ready.
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Will use PSP to load VCN firmware
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x0000003d, smu fw if version = 0x0000003f, smu fw program = 0, smu fw version = 0x00503b00 (80.59.0)
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]] JPEG decode initialized successfully.
Nov 14 20:16:14 desktop kernel: amdgpu: HMM registered 16368MB device memory
Nov 14 20:16:14 desktop kernel: kfd kfd: amdgpu: Allocated 3969056 bytes on gart
Nov 14 20:16:14 desktop kernel: kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
Nov 14 20:16:14 desktop kernel: amdgpu: Virtual CRAT table created for GPU
Nov 14 20:16:14 desktop kernel: amdgpu: Topology: Add dGPU node [0x747e:0x1002]
Nov 14 20:16:14 desktop kernel: kfd kfd: amdgpu: added device 1002:747e
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SE 3, SH per SE 2, CU per SH 10, active_cu_number 60
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_1 uses VM inv eng 1 on hub 8
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 4 on hub 8
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
Nov 14 20:16:14 desktop kernel: [drm] Initialized amdgpu 3.56.0 20150101 for 0000:03:00.0 on minor 1
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x000080840f902000 from client 10
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B52
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:14 desktop kernel: fbcon: amdgpudrmfb (fb0) is primary device
Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
Nov 14 20:16:15 desktop kernel: snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808448f4c000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afd000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afb000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afa000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afb000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afa000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afb000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afd000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA1 (0xe)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808448f4c000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459afb000 from client 10
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e53000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B52
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e46000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B52
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e52000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B52
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e46000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B53
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e52000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e46000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B53
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e53000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459852000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e46000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CB/DB (0x0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000808459e51000 from client 10
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B52
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x1


[...]


