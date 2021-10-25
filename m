Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC84C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 13:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815496058D
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 13:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 815496058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A91A89F01;
	Mon, 25 Oct 2021 13:48:33 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085A289F01
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 13:48:32 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id a13so11652756qkg.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:reply-to
 :content-language:references:to:in-reply-to
 :content-transfer-encoding;
 bh=KY+8gJjztiryB+9+OpH9C3NB7bsSzqBrgQEAo48asFg=;
 b=edjKbTY6b/wtKTcd22d7cZPK4UBwk/NDbAsl6DTnDICow54H7A8SeIJG+Ilw6pQNLC
 vb+lsny0fGSxg2Dpc8F67Zk55d//OgQV9sPi9KVOcGhULvvPJih7oNUh6/Tfgf+ZDJ5f
 3IPpfrhzTgCx1HeF5cbxGcZoa9IFOSmmPkQVxeqTQGiV6uMJNt5dRPUyX28rxXHiBF4I
 +DdoB6ZUWw1xNuR9EgMZGT/9quQp0O7LVM6n9fJSTXd86uwPggdwSNLxLVsWZbnoiE30
 YHoZH5n6f5+OgTX+xdUe+gb8+8Us3tyix8QDuKnnnElXGcAKQjXp1ywhfEKEJE4FGFjk
 1RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:reply-to:content-language:references:to:in-reply-to
 :content-transfer-encoding;
 bh=KY+8gJjztiryB+9+OpH9C3NB7bsSzqBrgQEAo48asFg=;
 b=baJGm+or5OhBIbNjnrFQAUHeX0tMgT+6j5dsJC2/+DQVe2+aediyt9/0vttGsA/8x3
 necsWrI6SQ9s7+58smKgjp/voawFqxgGlNjRYfivJXZC/a/KS6BqfDWGcSzOJtoJ3/E1
 UOiJsQ1xXX7FfDu2JiA+L/lSXnWsE0/EjWN1dEgTg0gyus0jTrxp27+Nt1NF+lBkgrga
 WKJ7AOfeSrCNh8FnpESp2gLk6mDj5LYZmDBtSaodz7uTE1YYVrWyLtFf0XnqlwTjUHcU
 +IjFNkWsmdlx4eBsfQMI93TqewXdJzIXko+MrfwbBNMKvGR/AXq/SOJ1r3rN2D4MgZhz
 HkWA==
X-Gm-Message-State: AOAM533Sxj7nTAxe9JvNbioH7SzXh6eyStTDhZSeOLe4pHZZKxVJtLGe
 sgvpdykBRgloqgnwV0q0NrxlUxiSNRY=
X-Google-Smtp-Source: ABdhPJy2BKDdMAlVHKZaE0sHsnm72l/UuSDJ0/QqHQRxxb/Py513+YiQXwBa9x5JsB0LWI57KYCY5g==
X-Received: by 2002:a37:9c0a:: with SMTP id f10mr13865244qke.188.1635169711042; 
 Mon, 25 Oct 2021 06:48:31 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::49])
 by smtp.gmail.com with ESMTPSA id d129sm8459770qkf.136.2021.10.25.06.48.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 06:48:30 -0700 (PDT)
Message-ID: <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
Date: Mon, 25 Oct 2021 09:48:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
From: PGNet Dev <pgnet.dev@gmail.com>
Subject: amdgpu "Fatal error during GPU init"; Ryzen 5600G integrated GPU +
 kernel 5.14.13
Content-Language: en-US
References: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
To: amd-gfx@lists.freedesktop.org
In-Reply-To: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
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
Reply-To: PGNet Dev <pgnet.dev@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

( cc'ing this here, OP -> dri-devel@ )

i've a dual gpu system

	inxi -GS
		System:    Host: ws05 Kernel: 5.14.13-200.fc34.x86_64 x86_64 bits: 64 Console: tty pts/0
		           Distro: Fedora release 34 (Thirty Four)
(1)		Graphics:  Device-1: NVIDIA GK208B [GeForce GT 710] driver: nvidia v: 470.74
(2)		           Device-2: Advanced Micro Devices [AMD/ATI] Cezanne driver: N/A
		           Display: server: X.org 1.20.11 driver: loaded: nvidia unloaded: fbdev,modesetting,vesa
		           Message: Advanced graphics data unavailable for root.

running on

	cpu:    Ryzen 5 5600G
	mobo:   ASRockRack X470D4U
	bios:   vP4.20, 04/14/2021
	kernel: 5.14.13-200.fc34.x86_64 x86_64

where,

	the nvidia is a PCIe card
	the amdgpu is the Ryzen-integrated gpu

the nvidia PCI is currently my primary
it's screen-attached, and boots/functions correctly

	lsmod | grep nvidia
		nvidia_drm             69632  0
		nvidia_modeset       1200128  1 nvidia_drm
		nvidia              35332096  1 nvidia_modeset
		drm_kms_helper        303104  2 amdgpu,nvidia_drm
		drm                   630784  8 gpu_sched,drm_kms_helper,nvidia,amdgpu,drm_ttm_helper,nvidia_drm,ttm

	dmesg | grep -i nvidia
		[    5.755494] nvidia: loading out-of-tree module taints kernel.
		[    5.755503] nvidia: module license 'NVIDIA' taints kernel.
		[    5.759769] nvidia: module verification failed: signature and/or required key missing - tainting kernel
		[    5.774894] nvidia-nvlink: Nvlink Core is being initialized, major device number 234
		[    5.775299] nvidia 0000:10:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
		[    5.975449] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  470.74  Mon Sep 13 23:09:15 UTC 2021
		[    6.013181] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  470.74  Mon Sep 13 22:59:50 UTC 2021
		[    6.016444] [drm] [nvidia-drm] [GPU ID 0x00001000] Loading driver
		[    6.227295] caller _nv000723rm+0x1ad/0x200 [nvidia] mapping multiple BARs
		[    6.954906] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:10:00.0 on minor 0
		[   16.820758] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input13
		[   16.820776] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input14
		[   16.820808] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input15
		[   16.820826] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input16
		[   16.820841] input: HDA NVidia HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input17

the amdgpu is not (currently/yet) in use; no attached screen

in BIOS, currently,

	'PCI Express' (nvidia gpu) is selected as primary
	'HybridGraphics' is enabled
	'OnBoard VGA' is enabled


on boot, mods are loaded

	lsmod | grep gpu
		amdgpu               7802880  0
		drm_ttm_helper         16384  1 amdgpu
		ttm                    81920  2 amdgpu,drm_ttm_helper
		iommu_v2               24576  1 amdgpu
		gpu_sched              45056  1 amdgpu
		drm_kms_helper        303104  2 amdgpu,nvidia_drm
		drm                   630784  8 gpu_sched,drm_kms_helper,nvidia,amdgpu,drm_ttm_helper,nvidia_drm,ttm
		i2c_algo_bit           16384  2 igb,amdgpu

but i see a 'fatal error' and 'failed' probe,

	dmesg | grep -i amdgpu
		[    5.161923] [drm] amdgpu kernel modesetting enabled.
		[    5.162097] amdgpu: Virtual CRAT table created for CPU
		[    5.162104] amdgpu: Topology: Add CPU node
		[    5.162197] amdgpu 0000:30:00.0: enabling device (0000 -> 0003)
		[    5.162232] amdgpu 0000:30:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
		[    5.169105] amdgpu 0000:30:00.0: BAR 6: can't assign [??? 0x00000000 flags 0x20000000] (bogus alignment)
		[    5.174413] amdgpu 0000:30:00.0: amdgpu: Unable to locate a BIOS ROM
		[    5.174415] amdgpu 0000:30:00.0: amdgpu: Fatal error during GPU init
		[    5.174416] amdgpu 0000:30:00.0: amdgpu: amdgpu: finishing device.
		[    5.174425] Modules linked in: amdgpu(+) uas usb_storage fjes(-) raid1 drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul crc32_pclmul igb crc32c_intel cec ghash_clmulni_intel drm sp5100_tco dca ccp i2c_algo_bit wmi video sunrpc tcp_bbr nct6775 hwmon_vid k10temp
		[    5.174463]  amdgpu_device_fini_hw+0x33/0x2c5 [amdgpu]
		[    5.174594]  amdgpu_driver_load_kms.cold+0x72/0x94 [amdgpu]
		[    5.174706]  amdgpu_pci_probe+0x110/0x1a0 [amdgpu]
		[    5.174907] amdgpu: probe of 0000:30:00.0 failed with error -22


are specific configs from

	https://www.kernel.org/doc/html/latest/gpu/amdgpu.html

required to avoid/workaround the init error?  or known bug?
