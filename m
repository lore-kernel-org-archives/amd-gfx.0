Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28207C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 13:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D335CD54BA;
	Tue,  9 Aug 2022 13:08:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084BDCB75D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660033668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBg7wYwWFfzcklgJyUvVBcbgyPfvF7n88mrZW8wKg+E=;
 b=IzI466JOJmFgzOhzKYI9tGTk0SgVdpaxCB/zXNRZ3XIRraLcWX/X1K4jvRibYK/MbqMxsB
 nPMDTEkoz7wSUy+9Y8oq9ATrEwsxlGbfSsi/NnkT2kLQXa6DMZL+g3M0SDBpK+F4KDPHyt
 1agjYeOQ3RKICfx1Ii+zyFyXI89N+f4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-7_TCMv0KO8eCvjM0BUmZpQ-1; Tue, 09 Aug 2022 04:27:47 -0400
X-MC-Unique: 7_TCMv0KO8eCvjM0BUmZpQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 m18-20020a056402511200b0043d601a8035so7019103edd.20
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Aug 2022 01:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=PBg7wYwWFfzcklgJyUvVBcbgyPfvF7n88mrZW8wKg+E=;
 b=KzvEXAjf22hI3UYS/MruPOQU68XI5HrEqeRch3Tu/gZS+CnbscSQ3KzvVJZFNghwoE
 YGer1eBPEhnmwWozCA0wK+YBfYyBmMekI1OyR53KT/p+yY2TbuBQetyzjO7VJAzNbLq2
 KU1iK9YZUPsinkavj+DQixnoInl5WlNj74MOH8yf3ygzoXFU8fTTmU/AWYaLGiQbuZhT
 tAIJVMt04DI+1DlKWW/BY61wKzjJstdfCjM/vfRlWZWVOFNCrX9zG7GgHrZ4qGEe4UXK
 HLLwHNCiFd8VivFXvL1dFuKmQKmMOhEqDj4TI1nNtTB/rIjsXYyP6z1LDM02O5HAgbe/
 D+ag==
X-Gm-Message-State: ACgBeo2E16vE01EpYFE0wE8OIRj8ViwhRJwqWSewmDRnCi1Gyk3vLlQf
 3MyxT4XKXLV/kMQ5s17bQWkMU3l35yz0aLP3MnZ0YzPLaaOUrWjnrtDRTxFtTyZy97mgVP4wmlZ
 lDEVVToMbo9x8+o5Ctn2t40GTyA==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr16449248ejc.161.1660033665209; 
 Tue, 09 Aug 2022 01:27:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+fpiweccxV0eTDG0X3VBVqB/KV+OBnqKhWM4hy8hu3sriy993Xw1AjUgpXYCzizUQcLK/0Q==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr16449224ejc.161.1660033664877; 
 Tue, 09 Aug 2022 01:27:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 g20-20020aa7d1d4000000b0043e8334f762sm5635399edp.65.2022.08.09.01.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Aug 2022 01:27:44 -0700 (PDT)
Message-ID: <2d3d8b12-1818-df27-8c4e-cdfeb2ff2c35@redhat.com>
Date: Tue, 9 Aug 2022 10:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] drm/amd/display: set panel orientation before
 drm_dev_register
To: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, sungjoon.kim@amd.com, nikola.cornij@amd.com
References: <20220804161349.3561177-1-mwen@igalia.com>
 <20220808185332.4pqpy5d3jgwqpbe4@mail.igalia.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220808185332.4pqpy5d3jgwqpbe4@mail.igalia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 09 Aug 2022 13:07:57 +0000
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
Cc: contact@emersion.fr, seanpaul@chromium.org, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 8/8/22 20:53, Melissa Wen wrote:
> On 08/04, Melissa Wen wrote:
>> To set the panel orientation property with quirk, we need the mode size
>> provided by EDID. This info is available after EDID is read by dc_link_detect()
>> and updated by amdgpu_dm_update_connector_after_detect(). The detection
>> happens at driver load in amdgpu_dm_initialize_drm_device() and,
>> therefore, we can get modes and set panel orientation before
>> drm_dev_register() to avoid DRM warns on creating the connector property
>> after device registration:
> 
> + Simon, Hans and Sean

Thanks, the patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
>>
>> [    2.563969] ------------[ cut here ]------------
>> [    2.563971] WARNING: CPU: 6 PID: 325 at drivers/gpu/drm/drm_mode_object.c:45 drm_mode_object_add+0x72/0x80 [drm]
>> [    2.563997] Modules linked in: btusb btrtl btbcm btintel btmtk bluetooth rfkill ecdh_generic ecc usbhid crc16 amdgpu(+) drm_ttm_helper ttm agpgart gpu_sched i2c_algo_bit drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm serio_raw sdhci_pci atkbd libps2 cqhci vivaldi_fmap ccp sdhci i8042 crct10dif_pclmul crc32_pclmul hid_multitouch ghash_clmulni_intel aesni_intel crypto_simd cryptd wdat_wdt mmc_core cec xhci_pci sp5100_tco rng_core xhci_pci_renesas serio 8250_dw i2c_hid_acpi i2c_hid btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq dm_mirror dm_region_hash dm_log dm_mod pkcs8_key_parser crypto_user
>> [    2.564032] CPU: 6 PID: 325 Comm: systemd-udevd Not tainted 5.18.0-amd-staging-drm-next+ #67
>> [    2.564034] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0105 03/21/2022
>> [    2.564036] RIP: 0010:drm_mode_object_add+0x72/0x80 [drm]
>> [    2.564053] Code: f0 89 c3 85 c0 78 07 89 45 00 44 89 65 04 4c 89 ef e8 e2 99 04 f1 31 c0 85 db 0f 4e c3 5b 5d 41 5c 41 5d c3 80 7f 50 00 74 ac <0f> 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 4c
>> [    2.564055] RSP: 0018:ffffb2e880413860 EFLAGS: 00010202
>> [    2.564056] RAX: ffffffffc0ba1440 RBX: ffff99508a860010 RCX: 0000000000000001
>> [    2.564057] RDX: 00000000b0b0b0b0 RSI: ffff99508c050110 RDI: ffff99508a860010
>> [    2.564058] RBP: ffff99508c050110 R08: 0000000000000020 R09: ffff99508c292c20
>> [    2.564059] R10: 0000000000000000 R11: ffff99508c0507d8 R12: 00000000b0b0b0b0
>> [    2.564060] R13: 0000000000000004 R14: ffffffffc068a4b6 R15: ffffffffc068a47f
>> [    2.564061] FS:  00007fc69b5f1a40(0000) GS:ffff9953aff80000(0000) knlGS:0000000000000000
>> [    2.564063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    2.564063] CR2: 00007f9506804000 CR3: 0000000107f92000 CR4: 0000000000350ee0
>> [    2.564065] Call Trace:
>> [    2.564068]  <TASK>
>> [    2.564070]  drm_property_create+0xc9/0x170 [drm]
>> [    2.564088]  drm_property_create_enum+0x1f/0x70 [drm]
>> [    2.564105]  drm_connector_set_panel_orientation_with_quirk+0x96/0xc0 [drm]
>> [    2.564123]  get_modes+0x4fb/0x530 [amdgpu]
>> [    2.564378]  drm_helper_probe_single_connector_modes+0x1ad/0x850 [drm_kms_helper]
>> [    2.564390]  drm_client_modeset_probe+0x229/0x1400 [drm]
>> [    2.564411]  ? xas_store+0x52/0x5e0
>> [    2.564416]  ? kmem_cache_alloc_trace+0x177/0x2c0
>> [    2.564420]  __drm_fb_helper_initial_config_and_unlock+0x44/0x4e0 [drm_kms_helper]
>> [    2.564430]  drm_fbdev_client_hotplug+0x173/0x210 [drm_kms_helper]
>> [    2.564438]  drm_fbdev_generic_setup+0xa5/0x166 [drm_kms_helper]
>> [    2.564446]  amdgpu_pci_probe+0x35e/0x370 [amdgpu]
>> [    2.564621]  local_pci_probe+0x45/0x80
>> [    2.564625]  ? pci_match_device+0xd7/0x130
>> [    2.564627]  pci_device_probe+0xbf/0x220
>> [    2.564629]  ? sysfs_do_create_link_sd+0x69/0xd0
>> [    2.564633]  really_probe+0x19c/0x380
>> [    2.564637]  __driver_probe_device+0xfe/0x180
>> [    2.564639]  driver_probe_device+0x1e/0x90
>> [    2.564641]  __driver_attach+0xc0/0x1c0
>> [    2.564643]  ? __device_attach_driver+0xe0/0xe0
>> [    2.564644]  ? __device_attach_driver+0xe0/0xe0
>> [    2.564646]  bus_for_each_dev+0x78/0xc0
>> [    2.564648]  bus_add_driver+0x149/0x1e0
>> [    2.564650]  driver_register+0x8f/0xe0
>> [    2.564652]  ? 0xffffffffc1023000
>> [    2.564654]  do_one_initcall+0x44/0x200
>> [    2.564657]  ? kmem_cache_alloc_trace+0x177/0x2c0
>> [    2.564659]  do_init_module+0x4c/0x250
>> [    2.564663]  __do_sys_init_module+0x12e/0x1b0
>> [    2.564666]  do_syscall_64+0x3b/0x90
>> [    2.564670]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [    2.564673] RIP: 0033:0x7fc69bff232e
>> [    2.564674] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
>> [    2.564676] RSP: 002b:00007ffe872ba3e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
>> [    2.564677] RAX: ffffffffffffffda RBX: 000055873f797820 RCX: 00007fc69bff232e
>> [    2.564678] RDX: 000055873f7bf390 RSI: 0000000001155e81 RDI: 00007fc699e4d010
>> [    2.564679] RBP: 00007fc699e4d010 R08: 000055873f7bfe20 R09: 0000000001155e90
>> [    2.564680] R10: 000000055873f7bf R11: 0000000000000246 R12: 000055873f7bf390
>> [    2.564681] R13: 000000000000000d R14: 000055873f7c4cb0 R15: 000055873f797820
>> [    2.564683]  </TASK>
>> [    2.564683] ---[ end trace 0000000000000000 ]---
>> [    2.564696] ------------[ cut here ]------------
>> [    2.564696] WARNING: CPU: 6 PID: 325 at drivers/gpu/drm/drm_mode_object.c:242 drm_object_attach_property+0x52/0x80 [drm]
>> [    2.564717] Modules linked in: btusb btrtl btbcm btintel btmtk bluetooth rfkill ecdh_generic ecc usbhid crc16 amdgpu(+) drm_ttm_helper ttm agpgart gpu_sched i2c_algo_bit drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm serio_raw sdhci_pci atkbd libps2 cqhci vivaldi_fmap ccp sdhci i8042 crct10dif_pclmul crc32_pclmul hid_multitouch ghash_clmulni_intel aesni_intel crypto_simd cryptd wdat_wdt mmc_core cec xhci_pci sp5100_tco rng_core xhci_pci_renesas serio 8250_dw i2c_hid_acpi i2c_hid btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq dm_mirror dm_region_hash dm_log dm_mod pkcs8_key_parser crypto_user
>> [    2.564738] CPU: 6 PID: 325 Comm: systemd-udevd Tainted: G        W         5.18.0-amd-staging-drm-next+ #67
>> [    2.564740] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0105 03/21/2022
>> [    2.564741] RIP: 0010:drm_object_attach_property+0x52/0x80 [drm]
>> [    2.564759] Code: 2d 83 f8 18 74 33 48 89 74 c1 08 48 8b 4f 08 48 89 94 c1 c8 00 00 00 48 8b 47 08 83 00 01 c3 4d 85 d2 75 dd 83 7f 58 01 75 d7 <0f> 0b eb d3 41 80 78 50 00 74 cc 0f 0b eb c8 44 89 ce 48 c7 c7 28
>> [    2.564760] RSP: 0018:ffffb2e8804138d8 EFLAGS: 00010246
>> [    2.564761] RAX: 0000000000000010 RBX: ffff99508c1a2000 RCX: ffff99508c1a2180
>> [    2.564762] RDX: 0000000000000003 RSI: ffff99508c050100 RDI: ffff99508c1a2040
>> [    2.564763] RBP: 00000000ffffffff R08: ffff99508a860010 R09: 00000000c0c0c0c0
>> [    2.564763] R10: 0000000000000000 R11: 0000000000000020 R12: ffff99508a860010
>> [    2.564764] R13: ffff995088733008 R14: ffff99508c1a2000 R15: ffffffffc068a47f
>> [    2.564765] FS:  00007fc69b5f1a40(0000) GS:ffff9953aff80000(0000) knlGS:0000000000000000
>> [    2.564766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    2.564767] CR2: 00007f9506804000 CR3: 0000000107f92000 CR4: 0000000000350ee0
>> [    2.564768] Call Trace:
>> [    2.564769]  <TASK>
>> [    2.564770]  drm_connector_set_panel_orientation_with_quirk+0x4a/0xc0 [drm]
>> [    2.564789]  get_modes+0x4fb/0x530 [amdgpu]
>> [    2.565024]  drm_helper_probe_single_connector_modes+0x1ad/0x850 [drm_kms_helper]
>> [    2.565036]  drm_client_modeset_probe+0x229/0x1400 [drm]
>> [    2.565056]  ? xas_store+0x52/0x5e0
>> [    2.565060]  ? kmem_cache_alloc_trace+0x177/0x2c0
>> [    2.565062]  __drm_fb_helper_initial_config_and_unlock+0x44/0x4e0 [drm_kms_helper]
>> [    2.565072]  drm_fbdev_client_hotplug+0x173/0x210 [drm_kms_helper]
>> [    2.565080]  drm_fbdev_generic_setup+0xa5/0x166 [drm_kms_helper]
>> [    2.565088]  amdgpu_pci_probe+0x35e/0x370 [amdgpu]
>> [    2.565261]  local_pci_probe+0x45/0x80
>> [    2.565263]  ? pci_match_device+0xd7/0x130
>> [    2.565265]  pci_device_probe+0xbf/0x220
>> [    2.565267]  ? sysfs_do_create_link_sd+0x69/0xd0
>> [    2.565268]  really_probe+0x19c/0x380
>> [    2.565270]  __driver_probe_device+0xfe/0x180
>> [    2.565272]  driver_probe_device+0x1e/0x90
>> [    2.565274]  __driver_attach+0xc0/0x1c0
>> [    2.565276]  ? __device_attach_driver+0xe0/0xe0
>> [    2.565278]  ? __device_attach_driver+0xe0/0xe0
>> [    2.565279]  bus_for_each_dev+0x78/0xc0
>> [    2.565281]  bus_add_driver+0x149/0x1e0
>> [    2.565283]  driver_register+0x8f/0xe0
>> [    2.565285]  ? 0xffffffffc1023000
>> [    2.565286]  do_one_initcall+0x44/0x200
>> [    2.565288]  ? kmem_cache_alloc_trace+0x177/0x2c0
>> [    2.565290]  do_init_module+0x4c/0x250
>> [    2.565291]  __do_sys_init_module+0x12e/0x1b0
>> [    2.565294]  do_syscall_64+0x3b/0x90
>> [    2.565296]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [    2.565297] RIP: 0033:0x7fc69bff232e
>> [    2.565298] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
>> [    2.565299] RSP: 002b:00007ffe872ba3e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
>> [    2.565301] RAX: ffffffffffffffda RBX: 000055873f797820 RCX: 00007fc69bff232e
>> [    2.565302] RDX: 000055873f7bf390 RSI: 0000000001155e81 RDI: 00007fc699e4d010
>> [    2.565303] RBP: 00007fc699e4d010 R08: 000055873f7bfe20 R09: 0000000001155e90
>> [    2.565303] R10: 000000055873f7bf R11: 0000000000000246 R12: 000055873f7bf390
>> [    2.565304] R13: 000000000000000d R14: 000055873f7c4cb0 R15: 000055873f797820
>> [    2.565306]  </TASK>
>> [    2.565307] ---[ end trace 0000000000000000 ]---
>>
>> --
>>
>> v2:
>> - call amdgpu_dm_connector_get_modes() instead of ddc_get_modes() (Harry)
>>
>> Fixes: d77de7880e0e0 ("amd/display: enable panel orientation quirks")
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 0d54c1486739..2de37b976c23 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4133,6 +4133,7 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
>>  	}
>>  }
>>  
>> +static void amdgpu_set_panel_orientation(struct drm_connector *connector);
>>  
>>  /*
>>   * In this architecture, the association
>> @@ -4324,6 +4325,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>  					adev_to_drm(adev)->vblank_disable_immediate = false;
>>  			}
>>  		}
>> +		amdgpu_set_panel_orientation(&aconnector->base);
>>  	}
>>  
>>  	/* Software is initialized. Now we can register interrupt handlers. */
>> @@ -6682,6 +6684,10 @@ static void amdgpu_set_panel_orientation(struct drm_connector *connector)
>>  	    connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
>>  		return;
>>  
>> +	mutex_lock(&connector->dev->mode_config.mutex);
>> +	amdgpu_dm_connector_get_modes(connector);
>> +	mutex_unlock(&connector->dev->mode_config.mutex);
>> +
>>  	encoder = amdgpu_dm_connector_to_encoder(connector);
>>  	if (!encoder)
>>  		return;
>> @@ -6726,8 +6732,6 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>>  		 * restored here.
>>  		 */
>>  		amdgpu_dm_update_freesync_caps(connector, edid);
>> -
>> -		amdgpu_set_panel_orientation(connector);
>>  	} else {
>>  		amdgpu_dm_connector->num_modes = 0;
>>  	}
>> -- 
>> 2.35.1
>>

