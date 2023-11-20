Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAB5C197A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 16:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3720F10E434;
	Mon, 20 Nov 2023 16:16:10 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE19410E432
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 16:16:07 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so14638805e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700496966; x=1701101766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKuIED46SpLHzaqk+GMg9YcCJrlMCfmnX4FjTeB2cUI=;
 b=QufawLY/y2F+SSVlEi8DP38HHIyD0qDBy/2B4n1gyd+kXI2V1AIhWCp3ZUaHW4eX1Z
 HzY6W58LT1NiZpyeyJ+6zsuoGcFh7mbYFYeU9OElFaHCSHIs67B2aVuZYMiu9YkM2bFl
 V9ZEfifjpIuLzoRV5+FVAT2yC8Sx3KdQPkoOHwXDic0+SksgRdm+M4ZcrVN2/nk3Xl6G
 vFI1wIFTKLyH1Pq0/WdZqGIQBKRprP3FZyDt47Az1w/nqeQwIVgqD9iR/oiOxBv2s31t
 wMcoEcupPbBdp0K2OTHxuVCIeRWkJm49yDSK7/SXW5T9EaHi6AS7x5twQHH7uF7QgGOZ
 t5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700496966; x=1701101766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKuIED46SpLHzaqk+GMg9YcCJrlMCfmnX4FjTeB2cUI=;
 b=FpNaRGupL8uNYl4g46Ybvdv21nIkLTPI5xo/VxsluL0gsBi7Dj0m5mk0LrXy2P/70H
 Kld/tFDlAIRJZl5CrX/P4gWmaPpP17bcRcrXvnBEnwFG+3dzVSPR+gUjDb8raGtcx5S2
 QD5MrcGkTYEUoXY0OKdiGecMWqCFfM/hmVrqDHVo/SJ4Ulx0hbVreEKDmOh486WACaEN
 Ie4on3lEqAt0qaCQ+BSyuGBgWzzsIlDwTDu+CtRPIueGf8RS+iuRd24UBSeaes5ov+Jp
 a0L/3365aAQ/kOHv1Q/CWcrA9MGKjmpxl7uaaEezBYRELtgSSipNtL+VPfXoKfdUx52+
 /dRw==
X-Gm-Message-State: AOJu0YxcDNbtIE3y3uaYHOOC8z8ZnN1+E/t9/Qr7fUXiACbv0n25pSDY
 Rv1zAbPLRiw/xlFi0P5vQaY=
X-Google-Smtp-Source: AGHT+IFPYLErTpatInLNqs75XflrlkaKAbSANEWMmPi0NSYYeZT4BhYfgUE0PU52FkCwW5vhknWceg==
X-Received: by 2002:a05:6000:186d:b0:32d:a54a:f57c with SMTP id
 d13-20020a056000186d00b0032da54af57cmr6448256wri.25.1700496966002; 
 Mon, 20 Nov 2023 08:16:06 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a5d6389000000b00332cc3e0817sm406628wru.39.2023.11.20.08.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 08:16:05 -0800 (PST)
Message-ID: <a8de3009-199a-4157-9113-4b560aaffbab@gmail.com>
Date: Mon, 20 Nov 2023 17:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231110150206.1900871-1-alexander.deucher@amd.com>
 <95b9b67e-1a85-4de2-8c93-226075401c48@amd.com>
 <CADnq5_P7EcNx=pZF6DGZ+_vtTOmXiXqe5VeUQRE5ytXYu5r3PA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_P7EcNx=pZF6DGZ+_vtTOmXiXqe5VeUQRE5ytXYu5r3PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.11.23 um 20:24 schrieb Alex Deucher:
> On Fri, Nov 10, 2023 at 10:22 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 10.11.23 um 16:02 schrieb Alex Deucher:
>>> This worked by luck if the GART aperture ended up at 0.  When
>>> we ended up moving GART on some chips, the GART aperture ended
>>> up offsetting the the AGP address since the resource->start is
>>> a GART offset, not an MC address.  Fix this by moving the AGP
>>> address setup into amdgpu_bo_gpu_offset_no_check().
>>>
>>> v2: check mem_type before checking agp
>>>
>>> Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
>>> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>> Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: christian.koenig@amd.com
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> Mario is getting a segfault with this patch on PHX.  Any ideas?

No idea, what does amdgpu_gmc_agp_addr+0x16 point to?

What could be is that the BO isn't backed by anything, e.g. GART not 
initialized yet or something like that.

In this case we probably need to add some checks to amdgpu_gmc_agp_addr().

Regards,
Christian.

>    I
> don't see how this could happen off hand.
>
> [   28.980823] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   28.980846] BUG: kernel NULL pointer dereference, address:
> 000000000000000c
> [   28.981424] #PF: supervisor read access in kernel mode
> [   28.981849] #PF: error_code(0x0000) - not-present page
> [   28.982259] PGD 0 P4D 0
> [   28.982469] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   28.982817] CPU: 10 PID: 547 Comm: (udev-worker) Not tainted
> 6.7.0-rc1-00006-ge5e258131973 #175
> [   28.984060] RIP: 0010:amdgpu_gmc_agp_addr+0x16/
> 0x60 [amdgpu]
> [   28.984828] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff
> 7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
> [   28.984829] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
> [   28.984831] RAX: 0000000000000000 RBX: ffff888103f83800 RCX:
> 0000000000000000
> [   28.984832] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI:
> ffff888103f83858
> [   28.984832] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09:
> 0000000000000000
> [   28.984833] R10: 0000000000001000 R11: 0000000000001000 R12:
> ffff888103f83800
> [   28.984834] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15:
> 0000000000000000
> [   28.984835] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000)
> knlGS:0000000000000000
> [   28.984836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.984837] CR2: 000000000000000c CR3: 000000011556e000 CR4:
> 0000000000750ef0
> [   28.984838] PKRU: 55555554
> [   28.984839] Call Trace:
> [   28.984842]  <TASK>
> [   28.984845]  ? __die+0x20/0x70
> [   28.984850]  ? page_fault_oops+0x151/0x4b0
> [   28.984854]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   28.992663]  ? do_user_addr_fault+0x65/0x6b0
> [   28.992672]  ? exc_page_fault+0x74/0x170
> [   28.992676]  ? asm_exc_page_fault+0x22/0x30
> [   28.993714]  ? amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
> [   28.994455]  amdgpu_bo_gpu_offset_no_check+0x1a/0x70 [amdgpu]
> [   28.995110]  amdgpu_bo_create_reserved.part.0+0x109/0x290 [amdgpu]
> [   28.995786]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu]
> [   28.996400]  amdgpu_bo_create_kernel+0x3f/0xa0 [amdgpu]
> [   28.996992]  amdgpu_device_init+0x15fa/0x2b60 [amdgpu]
> [   28.997591]  ? pci_bus_read_config_word+0x46/0x80
> [   28.997598]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   28.998385]  ? do_pci_enable_device+0xd4/0x100
> [   28.998390]  amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
> [   28.999194]  amdgpu_pci_probe+0x180/0x570 [amdgpu]
> [   28.999781]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.000232]  local_pci_probe+0x43/0xa0
> [   29.000552]  pci_device_probe+0xc5/0x270
> [   29.000883]  really_probe+0x1b4/0x420
> [   29.001194]  __driver_probe_device+0x84/0x170
> [   29.001558]  driver_probe_device+0x1e/0xb0
> [   29.001901]  __driver_attach+0xe5/0x1f0
> [   29.002224]  ? __pfx___driver_attach+0x10/0x10
> [   29.002594]  bus_for_each_dev+0x75/0xd0
> [   29.002919]  bus_add_driver+0x112/0x220
> [   29.003243]  driver_register+0x5c/0x120
> [   29.003569]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   29.004148]  do_one_initcall+0x41/0x300
> [   29.004471]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.004876]  ? kmalloc_trace+0x25/0x90
> [   29.005197]  do_init_module+0x64/0x250
> [   29.005201]  init_module_from_file+0x8b/0xd0
> [   29.005207]  idempotent_init_module+0x181/0x240
> [   29.006235]  __x64_sys_finit_module+0x5a/0xb0
> [   29.006238]  do_syscall_64+0x5c/0xe0
> [   29.006868]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.006870]  ? syscall_exit_to_user_mode+0x27/0x40
> [   29.006872]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.008000]  ? do_syscall_64+0x6b/0xe0
> [   29.008004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   29.008703] RIP: 0033:0x7fe6aa125c7d
> [   29.008991] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 81 0d 00 f7 d8 64 89 01 48
> [   29.008993] RSP: 002b:00007ffe22be7618 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [   29.010434] RAX: ffffffffffffffda RBX: 000055b2f8dee0f0 RCX:
> 00007fe6aa125c7d
> [   29.010435] RDX: 0000000000000000 RSI: 00007fe6aa33544a RDI:
> 0000000000000017
> [   29.010436] RBP: 00007fe6aa33544a R08: 0000000000000040 R09:
> fffffffffffffde0
> [   29.010438] R10: fffffffffffffe18 R11: 0000000000000246 R12:
> 0000000000020000
> [   29.010439] R13: 000055b2f8f12ba0 R14: 0000000000000000 R15:
> 000055b2f8f49ef0
> [   29.010443]  </TASK>
> [   29.010444] Modules linked in: binfmt_misc squashfs vfat fat
> snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common amdgpu(+)
> snd_soc_dmic snd_ps_pdm_dma snd_soc_ps_mach snd_hda_intel
> snd_intel_dspcfg snd_soc_core snd_hda_codec snd_compress ac97_bus
> snd_pcm_dmaengine snd_hda_core snd_seq_dummy uvcvideo snd_hwdep uvc
> hid_sensor_magn_3d hid_sensor_gyro_3d snd_seq_oss videobuf2_vmalloc
> snd_pci_ps hid_sensor_trigger videobuf2_memops hid_sensor_iio_common
> snd_seq_midi snd_rpl_pci_acp6x snd_seq_midi_event
> industrialio_triggered_buffer kfifo_buf videobuf2_v4l2 snd_acp_pci
> edac_mce_amd industrialio crct10dif_pclmul videobuf2_common snd_rawmidi
> snd_acp_legacy_common polyval_clmulni amdxcp gpu_sched polyval_generic
> snd_pci_acp6x joydev i2c_algo_bit videodev drm_suballoc_helper
> drm_ttm_helper snd_seq snd_pcm ghash_clmulni_intel ttm sha512_ssse3
> snd_seq_device drm_exec sha256_ssse3 mc snd_timer snd_pci_acp5x
> drm_display_helper sha1_ssse3 snd_rn_pci_acp3x snd_acp_config wmi_bmof
> snd rapl cec snd_soc_acpi drm_buddy soundcore i2c_piix4
> [   29.014048]  snd_pci_acp3x k10temp amd_pmf platform_profile
> hid_sensor_hub amd_pmc hid_multitouch serio_raw kvm_amd ccp kvm
> irqbypass iptable_filter ip6table_filter ip6_tables br_netfilter bridge
> stp llc arp_tables parport_pc ppdev lp parport loop fuse ip_tables
> rtsx_pci_sdmmc mmc_core video nvme crc32_pclmul crc32c_intel thunderbolt
> nvme_core amd_sfh r8169 rtsx_pci wmi i2c_hid_acpi i2c_hid
> [   29.023590] CR2: 000000000000000c
> [   29.023856] ---[ end trace 0000000000000000 ]---
> [   29.024220] RIP: 0010:amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
> [   29.024886] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff
> 7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
> [   29.026324] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
> [   29.026737] RAX: 0000000000000000 RBX: ffff888103f83800 RCX:
> 0000000000000000
> [   29.027290] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI:
> ffff888103f83858
> [   29.027848] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09:
> 0000000000000000
> [   29.028401] R10: 0000000000001000 R11: 0000000000001000 R12:
> ffff888103f83800
> [   29.028960] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15:
> 0000000000000000
> [   29.029521] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000)
> knlGS:0000000000000000
> [   29.030147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.030600] CR2: 000000000000000c CR3: 000000011556e000 CR4:
> 0000000000750ef0
>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
>>>    2 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index cef920a93924..d79b4ca1ecfc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>>>    u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>>>    {
>>>        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>> -     uint64_t offset;
>>> +     uint64_t offset = AMDGPU_BO_INVALID_OFFSET;
>>>
>>> -     offset = (bo->tbo.resource->start << PAGE_SHIFT) +
>>> -              amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
>>> +     if (bo->tbo.resource->mem_type == TTM_PL_TT)
>>> +             offset = amdgpu_gmc_agp_addr(&bo->tbo);
>>> +
>>> +     if (offset == AMDGPU_BO_INVALID_OFFSET)
>>> +             offset = (bo->tbo.resource->start << PAGE_SHIFT) +
>>> +                     amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
>>>
>>>        return amdgpu_gmc_sign_extend(offset);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 05991c5c8ddb..ab4a762aed5b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>>                return 0;
>>>
>>>        addr = amdgpu_gmc_agp_addr(bo);
>>> -     if (addr != AMDGPU_BO_INVALID_OFFSET) {
>>> -             bo->resource->start = addr >> PAGE_SHIFT;
>>> +     if (addr != AMDGPU_BO_INVALID_OFFSET)
>>>                return 0;
>>> -     }
>>>
>>>        /* allocate GART space */
>>>        placement.num_placement = 1;

