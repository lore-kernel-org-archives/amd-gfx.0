Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C14CC02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 11:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64A310E15A;
	Wed, 15 Jan 2025 11:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8CTP3dV";
	dkim-atps=neutral
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1586110E15A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 11:23:05 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso63291635e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736940183; x=1737544983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5r6KMlEH8bs+csVml7SCFCWOghNOBTWLOAlw5xy9LY=;
 b=m8CTP3dV31mnijvXcGh2wTvmVtjrYfsTsQHSeljHz4LG77wLdSvTRH522JiEXhT6hm
 2ahNJF5Np36iApoYfky2BKpNMcctUXjtascXC6jL/Dz8FI91jgO4XXKwN7Q/y9Xxvn63
 r3dGoTnd49AMai+yTa+W4gXtE3VJLZ4W6drwvJbTxFVE5HR/J/fMSrBKg94MjlCpVTIh
 jOMx+P0aRHsAGrZRb4QUoiLhaMKtDYDCEOY/hbM01Pn8ITW1We2uP9eNwLVuNrX0Blb8
 5M3qWCEzUeFIavp/YktjJfCpC9l++Ph4mLVhZME+Tfs3kOOqG3otCRtMdM3NOu1I3uje
 xkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736940183; x=1737544983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5r6KMlEH8bs+csVml7SCFCWOghNOBTWLOAlw5xy9LY=;
 b=jV+RkKCkGezsHe5fcqIW8OW6zcj6IG2Ytq0Z0wlwQHiAdObNoaUQ3U/4AlgqAxIo7j
 bJl7DOmrwZGC0JhsbrFtXdXgL0PDfXwuCqBa5xefeHmUdIZqe0Aapadop2rQ3P5kesPa
 SbF1KWNTydiTeyGPSygCBR8apcR5eCWUaxtSawevfdfjGy2fKB1V9V6DrQL+Rmqq5OeF
 JrZsuGXCV/fs0hQ9Dcbm3ZMk8fDZrsjbNLlXQnEv4B4CqtCPnj6OYMVmxJXftNLFJMoX
 l+8J3Wrb/yKosGUKEb0IqzM+XCYJx4WQ64pS4uLJy2WYZtFxmUZiOoSvUkL9lpsoHbG0
 MgeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqsiL5bMU3rucLeyu0iKmJIvjC81Q1bLWq0C+HMRIcCYoN50ImorJxYjhONUXygsEVtJXctiCk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp5HTGEQd5K4rDIRXAyX+X7hJrwb7HqWpQwcRH+JsRLtdfz7iW
 nU/ZrNmPrQScyMLUS2/ttDQOfSff/z5zW3jCobm+EgnHtIUDmFNoVV9c39lN
X-Gm-Gg: ASbGncsionL83HoEA++rgu0QsJ9YPrlCledxtP94auWKmoSARMsDzFKBNJkeI+ltp8E
 UUgmy5qXtMgoHZGMD0AapBgh2091gO6WWsKo7oFiuXpMopLI/504QIdydjWs7WYzDsiyuQ4246H
 iW2UlW2LtoJwDVK/zcUMj3GCmdRBX89FfvrFsuyF1Pl8e4aewMjKrPvd/OaJ9j4IvMjXKMwIFjo
 /JrpLJt7NPEpHy42O3Emh2CBr8W9kvsIQh3KQTMpTWBGZ7vZiKaJG61GHZ9sIjUSPb4lCrSoPqJ
 Us3iAZqR+A==
X-Google-Smtp-Source: AGHT+IEgUQMUpGtGt07w/PYM4NJ7T4/LrnJCBkw+XZd1ckF5I0OKZF/fGK14U6Sqp961csVxv2upyQ==
X-Received: by 2002:a05:600c:3103:b0:434:a746:9c82 with SMTP id
 5b1f17b1804b1-436e26ae9b1mr288444855e9.5.1736940183151; 
 Wed, 15 Jan 2025 03:23:03 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e59ecsm19714845e9.35.2025.01.15.03.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 03:23:02 -0800 (PST)
Message-ID: <9e9921c9-02c4-4cfe-b2d9-4f797036aa4c@gmail.com>
Date: Wed, 15 Jan 2025 12:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
To: Gerry Liu <gerry@linux.alibaba.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "shuox.liu@linux.alibaba.com" <shuox.liu@linux.alibaba.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <cover.1736847835.git.gerry@linux.alibaba.com>
 <46f008f8-6e88-4475-9510-6072f990c377@amd.com>
 <DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com>
 <820617e7-f82f-4a08-9035-0c4a753b61ee@amd.com>
 <CH0PR12MB53726FB2D787A0A6D22A2603F4182@CH0PR12MB5372.namprd12.prod.outlook.com>
 <3C088F3C-8592-494D-8976-4BCD64C2A6A9@linux.alibaba.com>
 <CH0PR12MB5372685232446C6C2D3E2860F4192@CH0PR12MB5372.namprd12.prod.outlook.com>
 <38C26576-828A-473B-B620-9BF10781C063@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <38C26576-828A-473B-B620-9BF10781C063@linux.alibaba.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Shaoyun and Gerry,

yes good idea, live migration is certainly an option as well.

In live migration the hypervisor transparently provides the same GPU 
configuration to the client on the new GPU like it has seen it before on 
the old GPU. In other words your fully state including VRAM content and 
locations, FW and HW state is transferred from one GPU to another.

Checkpoint/restore on the other hand works on the application level by 
writing the state of a specific application into a checkpoint file with 
the help of the user mode and kernel drivers.

The hibernation approach you proposed kind of sits in between those two 
ideas. But the hypervisor of the new GPU is not aware of the old GPU 
configuration and the user mode driver side isn't aware that it is moved 
to different hardware either while configuration parameters still 
change. That's why you have to add those hacks to update the location of 
pinned BOs into the firmware.

But as far as I can see that will never work 100% reliable because you 
can't look into the firmware code and update all pointers there. 
Especially when firmware stack etc.. is relative to parameters the 
hypervisor has set.

Regards,
Christian.

Am 15.01.25 um 06:24 schrieb Gerry Liu:
>
>> 2025年1月15日 12:03，Liu, Shaoyun <Shaoyun.Liu@amd.com> 写道：
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> I might misunderstood your requirement . For live migration, it's transparent  to the guest.  The guest can be  in running  state (ex. like running  some compute stuff),  hypervisor     and gim driver together will handle the GPU HW state migration from source vGPU to other  identical  vGPU .  It doesn't requires the guest to do the suspend/resume.  You can contact other engineers that work on SRIOV for more live  migration support info.
> Yeah, there are different usage scenarios:
> 1) live migration
> 2) hibernate/suspend/resume
> 3) snapshot and clone
> Currently we are focusing on live migration and hibernation, and hope that we can base on common underlying technologies.
>
>> Regards
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: Gerry Liu <gerry@linux.alibaba.com>
>> Sent: Tuesday, January 14, 2025 8:48 PM
>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com; simona@ffwll.ch; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Russell, Kent <Kent.Russell@amd.com>; shuox.liu@linux.alibaba.com; amd-gfx@lists.freedesktop.org
>> Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
>>
>>
>>
>>> 2025年1月15日 02:00，Liu, Shaoyun <Shaoyun.Liu@amd.com> 写道：
>>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> I think to resume with different SRIOV vGPUs depends on the  hypervisor has the live migration support . Different Hypervisor have different implementation , basically  it will call into the  host gpu driver in different stage and  host side do the  hw related  migration including the FW state.
>> Hi Shaoyun,
>>         Great news! That sounds like what I’m looking for:)
>>         Is there any documentation about how to enable this with an in-house implemented hypervisor? Will the hypervisor need to cooperate with the gim driver to enable resume with different vGPUs?
>> Regards
>> Gerry
>>
>>> Regards
>>> Shaoyun.liu
>>>
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Christian König
>>> Sent: Tuesday, January 14, 2025 7:44 AM
>>> To: Gerry Liu <gerry@linux.alibaba.com>
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
>>> <Xinhui.Pan@amd.com>; airlied@gmail.com; simona@ffwll.ch; Khatri,
>>> Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,
>>> Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>;
>>> Russell, Kent <Kent.Russell@amd.com>; shuox.liu@linux.alibaba.com;
>>> amd-gfx@lists.freedesktop.org
>>> Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
>>>
>>> Hi Gerry,
>>>
>>> Am 14.01.25 um 12:03 schrieb Gerry Liu:
>>> 2025年1月14日 18:46，Christian König <christian.koenig@amd.com> 写道：
>>>
>>> Hi Jiang,
>>>
>>> Some of the firmware, especially the multimedia ones, keep FW pointers to buffers in the suspend/resume state.
>>>
>>> In other words the firmware needs to be in the exact same location before and after resume. That's why we don't unpin the firmware BOs, but rather save their content and restore it. See function amdgpu_vcn_save_vcpu_bo() for reference.
>>>
>>> Additional to that the serial numbers, IDs etc are used for things like TMZ. So anything which uses HW encryption won't work any more.
>>>
>>> Then even two identical boards can have different harvest and memory channel configurations. Could be that we might be able to abstract that with SR-IOV but I won't rely on that.
>>>
>>> To summarize that looks like a completely futile effort which most likely won't work reliable in a production environment.
>>> Hi Christian,
>>>   Thanks for the information. Previously I assume that we may reset the asic and reload all firmwares on resume, but missed the vcn ip block which save and restore firmware vram content during suspend/resume. Is there any other IP blocks which save and restore firmware ram content?
>>>
>>> Not that I of hand know of any, but neither the hypervisor nor the driver stack was designed with something like this in mind. So could be that there are other dependencies I don't know about.
>>>
>>> I do remember that this idea of resuming on different HW than suspending came up a while ago and was rejected by multiple parties as to complicated and error prone.
>>>
>>> So we never looked more deeply into the possibility of doing that.
>>>
>>>
>>>
>>>   Our usage scenario targets GPGPU workload (amdkfd) with AMD GPU in single SR-IOV vGPU mode. Is it possible to resume on a different vGPU device in such a case?
>>>
>>> If I'm not completely mistaken you can use checkpoint/restore for that. It's still under development, but as far as I can see it should solve your problem quite nicely.
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>
>>> Regards,
>>> Gerry
>>>
>>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 14.01.25 um 10:54 schrieb Jiang Liu:
>>> For virtual machines with AMD SR-IOV vGPUs, following work flow may be
>>> used to support virtual machine hibernation(suspend):
>>> 1) suspends a virtual machine with AMD vGPU A.
>>> 2) hypervisor dumps guest RAM content to a disk image.
>>> 3) hypervisor loads the guest system image from disk.
>>> 4) resumes the guest OS with a different AMD vGPU B.
>>>
>>> The step 4 above is special because we are resuming with a different
>>> AMD vGPU device and the amdgpu driver may observe changed device
>>> properties. To support above work flow, we need to fix those changed
>>> device properties cached by the amdgpu drivers.
>>>
>>> With information from the amdgpu driver source code (haven't read
>>> corresponding hardware specs yet), we have identified following
>>> changed device properties:
>>> 1) PCI MMIO address. This can be fixed by hypervisor.
>>> 2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
>>>    they are information only.
>>> 3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC address.
>>> 4) mc_fb_offset, which affects VRAM physical address.
>>>
>>> We will focus on the VRAM address related changes here, because it's
>>> sensitive to the GPU functionalities. The original data sources
>>> include .get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
>>> The main data cached by amdgpu driver are adev->gmc.vram_start and
>>> adev->vm_manager.vram_base_offset. And the major consumers of the
>>> cached information are ip_block.hw_init() and GMU page table builder.
>>>
>>> After code analysis, we found that most consumers of
>>> dev->gmc.vram_start and adev->vm_manager.vram_base_offset directly
>>> read value from these two variables on demand instead of caching them.
>>> So if we fix these two cached fields on resume, everything should work as expected.
>>>
>>> But there's an exception, and an very import exception, that callers
>>> of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
>>> VRAM addresses. With further analysis, the callers of these interface
>>> have three different patterns:
>>> 1) This pattern is safe.
>>>    - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>>>    - call amdgpu_bo_free_kernel() in ip_block.suspend()
>>>    - call amdgpu_bo_create_reserved() in ip_block.resume()
>>> 2) This pattern works with current implementaiton of amdgpu_bo_create_reserved()
>>>    but bo.pin_count gets incorrect.
>>>    - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>>>    - call amdgpu_bo_create_reserved() in ip_block.resume()
>>> 3) This pattern needs to be enhanced.
>>>    - call amdgpu_bo_create_reserved() in ip_block.sw_init()
>>>
>>> So my question is which pattern should we use here? Personally I
>>> prefer pattern 2 with enhancement to fix the bo.pin_count.
>>>
>>> Currently there're still bugs in SRIOV suspend/resume, so we can't
>>> test our hypothesis. And we are not sure whether there are still other
>>> blocking to enable resume with different AMD SR-IOV vGPUs.
>>>
>>> Help is needed to identify more task items to enable resume with
>>> different AMD SR-IOV vGPUs:)
>>>
>>> Jiang Liu (2):
>>>   drm/amdgpu: update cached vram base addresses on resume
>>>   drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()
>>>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
>>> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
>>> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
>>> 7 files changed, 51 insertions(+), 2 deletions(-)

