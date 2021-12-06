Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E928EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 12:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7713173D90;
	Mon,  6 Dec 2021 12:12:58 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86B973D87
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 12:12:56 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id t9so21945848wrx.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 04:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vdmOqoATPldO50S/CH3mjM/QXGqMKz2r9yS0Qfm4mYU=;
 b=iYayy8gTFhchG0xfnVPSB7faFkOa0eMXt0sac++pyvOXmhTlTwnZqB4c6IPSV5+j/m
 vnATR8tHWXjaxCMdnfB/nU5K0rHK0F0QXX/cn4at9yp88z43ugKf1fvnvHfpqowUgYL3
 5QVJI5FD2bCdHgLdg/pqyJZHMVjic5BeClHzpIH2diOOxdyEit/Xsf6tjgf/cDCZz3Fh
 YUAJM4sM/j9jQQ5NCTbkW4lmuFMLF//KuLsn1NKp/tnLXuDS/bc+enLjpLvcCNsAQm7/
 8/hxI1a4KolpEWpwLN6c1Y9Q7FjhvCaPHMdEmHJcYdr7IkI16EZUC09xQJ6xpTbQM70Z
 XsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vdmOqoATPldO50S/CH3mjM/QXGqMKz2r9yS0Qfm4mYU=;
 b=6O5D7WN2anVj/3r3cUH20KLyRMZXsPSSvFc+jYq5uMFS53WbMPdIWyj6LMBRNeQ1aQ
 6Q1EGT7HsZ0uw5fZ7VIsfJ4N6OGAQLLHL+8T+nkqxtMRDtMcxGrK99ufDvPeqXw4xVNP
 e3X1ykVq+fbJL/sOsFdo+9NcyK+yHrcccN6QNUpbf67Iy5TiR3WQxUsA/ZGqfnMBLkf1
 UyY+ranxIrPoqobDR29gxIstRh0BuOqPZ9ZlL1OpiSmnPFelfLZZFeCKxEEEf753DNTz
 UyrV6NqTaXUg9aKb5BvJmK87DHn4jkuX4BBrerfyffJ3RqH2A3D4crYUyYsDIxf33CEZ
 8Vcg==
X-Gm-Message-State: AOAM533nWRpi42tbQUsfegzWwkRzBdVTNjRBT3HC85s/hsFVyXg6DZRK
 wt1o9UfTKLrINpqx6w/L4ZTcWoGgxHo=
X-Google-Smtp-Source: ABdhPJwZed4gw0De5wS43dH0lNejRfLmKAx5OdrmPk/vkv0EVxr+HMhaa2F9o9hiweG6RvGOmJpwHQ==
X-Received: by 2002:a05:6000:2a3:: with SMTP id
 l3mr42186420wry.415.1638792775097; 
 Mon, 06 Dec 2021 04:12:55 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id b6sm14357478wmq.45.2021.12.06.04.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 04:12:54 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20211202191912.6148-1-alexander.deucher@amd.com>
 <b05f1327-b26d-ac47-4bac-f94979bd3741@gmail.com>
 <CADnq5_OgW3vfG5kjV-67KYc4RxavJeZOWvNEo5vm9siHj2B0HA@mail.gmail.com>
 <79ab8197-890a-494d-6687-de0f3d467360@gmail.com>
 <8e0b8d8f-b64f-8d17-a877-9a3171b60b2e@amd.com>
 <9d584c64-9351-5b84-6721-887aaeb0bc36@gmail.com>
 <7be3f643-040e-e9ff-46b2-3739112c07e0@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a381e89e-84c2-92ed-2a06-cb6818d6aba7@gmail.com>
Date: Mon, 6 Dec 2021 13:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7be3f643-040e-e9ff-46b2-3739112c07e0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.12.21 um 12:36 schrieb Lazar, Lijo:
> On 12/6/2021 4:52 PM, Christian König wrote:
>> Am 06.12.21 um 11:56 schrieb Lazar, Lijo:
>>> On 12/5/2021 2:53 PM, Christian König wrote:
>>>> Am 03.12.21 um 17:13 schrieb Alex Deucher:
>>>>> On Fri, Dec 3, 2021 at 7:15 AM Christian König
>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>> Am 02.12.21 um 20:19 schrieb Alex Deucher:
>>>>>>> This adds a new IOCTL currently used to implement querying
>>>>>>> and setting the stable power state for GPU profiling. The
>>>>>>> stable pstates use fixed clocks and disable certain power
>>>>>>> features in order to get accurate pipeline profiling.
>>>>>>>
>>>>>>> Currently this is handled via sysfs, and that is still
>>>>>>> available, but this makes it easier for applications
>>>>>>> to utilize.  Note that the power state is global so
>>>>>>> setting it will affect all applications.  There are currently
>>>>>>> no checks in place to prevent multiple applications from
>>>>>>> using this interface, but it doesn't make sense to do
>>>>>>> profiling while you have multiple applications running in the
>>>>>>> first place, so it's up to the user to ensure this in order
>>>>>>> to get good results.
>>>>>>>
>>>>>>> This patch add an interface to query what profiling mode is
>>>>>>> currently active and to set enable a profiling mode.
>>>>>> First of all I wouldn't call this profiling mode. Profiling is 
>>>>>> the use
>>>>>> case, but performance and power management are what is controlled 
>>>>>> here.
>>>>>>
>>>>> Ok.
>>>>>
>>>>>> Then we already have functionality for process and context priority
>>>>>> override for the SW scheduler in amdgpu_sched.c. I think we 
>>>>>> should add
>>>>>> this functionality there.
>>>>> I'm not sure I follow.  Do you mean to integrate this with the
>>>>> rendering context?  That was what my original patch did (attached).
>>>>> Or were you thinking it would be better to make this part of the 
>>>>> sched
>>>>> ioctl?
>>>>
>>>> The later,
>>>>
>>>> The scheduler IOCTLs are all about adjusting the default priority 
>>>> of a process (and optionally a context as well).
>>>>
>>>> Putting the hardware power management control alongside that kind 
>>>> of makes sense I think.
>>>>
>>>> Something like AMDGPU_SCHED_OP_POWER.
>>>
>>> That doesn't make sense to me. This is not optimizing scheduling for 
>>> power. These settings are applied to the whole hardware. Even if we 
>>> assume a hypothetical case of 'no-scheduler' (only one app running), 
>>> the settings can be used to figure out whether an app is sensitive 
>>> to GFXCLK vs MCLK or which phases of the app are sensitive.
>>
>> What clocks are eventually in use is pretty much irrelevant. The 
>> functionality is that the application is defining a power level to 
>> use when it is active.
>>
>
> Exactly and it's irrelevant how it is made active. It just wants to 
> run something under certain conditions for specific cases.
>
> For ex: it could just collect some data for a time period less than 
> scheduled quantum and it could make use of in the next phase of its 
> logic. It is very much internal to the app and I don't see any 
> scheduler related logic inside that (just because an app is made 
> active by a scheduler).

This is about the GPU scheduler who decides which application runs on 
the GPU and not related to the CPU scheduler in any way.

Our current plan is to expose the performance level globally, because it 
is to much overhead to change the performance level on each application 
switch.

But ideally you won't do that. Instead each application should note the 
performance level it wants to the kernel and the kernel then makes an 
adequate decision based on that.

Since this is related to how jobs are scheduled and switching between 
applications I suggested to put it into amdgpu_scheduler.c.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> That we currently do that globally and only allow the first 
>> application to modify this is an implementation detail.
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>
>>>> Christian.
>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 
>>>>>>> ++++++++++++++++++++
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>>>>>>>    include/uapi/drm/amdgpu_drm.h               |  28 +++++
>>>>>>>    5 files changed, 173 insertions(+), 1 deletion(-)
>>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>> index 7fedbb725e17..4cf5bf637a9e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o 
>>>>>>> amdgpu_nbio.o \
>>>>>>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o 
>>>>>>> amdgpu_rap.o \
>>>>>>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o 
>>>>>>> amdgpu_hdp.o \
>>>>>>> -     amdgpu_eeprom.o amdgpu_mca.o
>>>>>>> +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>>>>>>>
>>>>>>>    amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> index bc1355c6248d..0e27f9673f8f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> @@ -46,6 +46,7 @@
>>>>>>>    #include "amdgpu_sched.h"
>>>>>>>    #include "amdgpu_fdinfo.h"
>>>>>>>    #include "amdgpu_amdkfd.h"
>>>>>>> +#include "amdgpu_profile.h"
>>>>>>>
>>>>>>>    #include "amdgpu_ras.h"
>>>>>>>    #include "amdgpu_xgmi.h"
>>>>>>> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc 
>>>>>>> amdgpu_ioctls_kms[] = {
>>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, 
>>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, 
>>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, 
>>>>>>> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>> +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, 
>>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>    };
>>>>>>>
>>>>>>>    static const struct drm_driver amdgpu_kms_driver = {
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..94fe408e810f
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>> @@ -0,0 +1,112 @@
>>>>>>> +/*
>>>>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>>>>> + *
>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>> obtaining a
>>>>>>> + * copy of this software and associated documentation files 
>>>>>>> (the "Software"),
>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>> without limitation
>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>> sublicense,
>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>> whom the
>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>> conditions:
>>>>>>> + *
>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>> be included in
>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>> + *
>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>> KIND, EXPRESS OR
>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>> MERCHANTABILITY,
>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>>> EVENT SHALL
>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>> CLAIM, DAMAGES OR
>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>> OTHERWISE,
>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>> THE USE OR
>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>> +#include "amdgpu.h"
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * amdgpu_profile_ioctl - Manages settings for profiling.
>>>>>>> + *
>>>>>>> + * @dev: drm device pointer
>>>>>>> + * @data: drm_amdgpu_vm
>>>>>>> + * @filp: drm file pointer
>>>>>>> + *
>>>>>>> + * Returns:
>>>>>>> + * 0 for success, -errno for errors.
>>>>>>> + */
>>>>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>>>>> +                      struct drm_file *filp)
>>>>>>> +{
>>>>>>> +     union drm_amdgpu_profile *args = data;
>>>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>>> +     const struct amd_pm_funcs *pp_funcs = 
>>>>>>> adev->powerplay.pp_funcs;
>>>>>>> +     enum amd_dpm_forced_level current_level, requested_level;
>>>>>>> +     int r;
>>>>>>> +
>>>>>>> +     if (pp_funcs->get_performance_level)
>>>>>>> +             current_level = 
>>>>>>> amdgpu_dpm_get_performance_level(adev);
>>>>>>> +     else
>>>>>>> +             current_level = adev->pm.dpm.forced_level;
>>>>>>> +
>>>>>>> +     switch (args->in.op) {
>>>>>>> +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
>>>>>>> +             if (args->in.flags)
>>>>>>> +                     return -EINVAL;
>>>>>>> +             switch (current_level) {
>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>>>>>>> +                     args->out.flags = 
>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
>>>>>>> +                     break;
>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>>>>>>> +                     args->out.flags = 
>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
>>>>>>> +                     break;
>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>>>>>>> +                     args->out.flags = 
>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
>>>>>>> +                     break;
>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>>>>>>> +                     args->out.flags = 
>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
>>>>>>> +                     break;
>>>>>>> +             default:
>>>>>>> +                     args->out.flags = 
>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
>>>>>>> +                     break;
>>>>>>> +             }
>>>>>>> +             break;
>>>>>>> +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
>>>>>>> +             if (args->in.flags & 
>>>>>>> ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
>>>>>>> +                     return -EINVAL;
>>>>>>> +             switch (args->in.flags & 
>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
>>>>>>> +                     requested_level = 
>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
>>>>>>> +                     break;
>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
>>>>>>> +                     requested_level = 
>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
>>>>>>> +                     break;
>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
>>>>>>> +                     requested_level = 
>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
>>>>>>> +                     break;
>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
>>>>>>> +                     requested_level = 
>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>>>>>>> +                     break;
>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
>>>>>>> +                     requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>>>>>> +                     break;
>>>>>>> +             default:
>>>>>>> +                     return -EINVAL;
>>>>>>> +             }
>>>>>>> +
>>>>>>> +             if ((current_level != requested_level) && 
>>>>>>> pp_funcs->force_performance_level) {
>>>>>>> + mutex_lock(&adev->pm.mutex);
>>>>>>> +                     r = 
>>>>>>> amdgpu_dpm_force_performance_level(adev, requested_level);
>>>>>>> +                     if (!r)
>>>>>>> + adev->pm.dpm.forced_level = requested_level;
>>>>>>> + mutex_unlock(&adev->pm.mutex);
>>>>>>> +                     if (r)
>>>>>>> +                             return r;
>>>>>>> +             }
>>>>>>> +             break;
>>>>>>> +     default:
>>>>>>> +             return -EINVAL;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..cd1c597bae11
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>> @@ -0,0 +1,30 @@
>>>>>>> +/*
>>>>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>>>>> + *
>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>> obtaining a
>>>>>>> + * copy of this software and associated documentation files 
>>>>>>> (the "Software"),
>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>> without limitation
>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>> sublicense,
>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>> whom the
>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>> conditions:
>>>>>>> + *
>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>> be included in
>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>> + *
>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>> KIND, EXPRESS OR
>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>> MERCHANTABILITY,
>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>>> EVENT SHALL
>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>> CLAIM, DAMAGES OR
>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>> OTHERWISE,
>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>> THE USE OR
>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef __AMDGPU_PROFILE_H__
>>>>>>> +#define __AMDGPU_PROFILE_H__
>>>>>>> +
>>>>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>>>>> +                      struct drm_file *filp);
>>>>>>> +
>>>>>>> +#endif
>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>>>> index 26e45fc5eb1a..b6edf4a826f9 100644
>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>>    #define DRM_AMDGPU_VM                       0x13
>>>>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
>>>>>>>    #define DRM_AMDGPU_SCHED            0x15
>>>>>>> +#define DRM_AMDGPU_PROFILE           0x16
>>>>>>>
>>>>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE 
>>>>>>> + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>>    #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE 
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union 
>>>>>>> drm_amdgpu_fence_to_handle)
>>>>>>>    #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>>> +#define DRM_IOCTL_AMDGPU_PROFILE DRM_IOW(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
>>>>>>>
>>>>>>>    /**
>>>>>>>     * DOC: memory domains
>>>>>>> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>>>>>>>        struct drm_amdgpu_info_video_codec_info 
>>>>>>> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>>>>>>>    };
>>>>>>>
>>>>>>> +/* profile ioctl */
>>>>>>> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE  1
>>>>>>> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE  2
>>>>>>> +
>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK 0xf
>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE 0
>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD 1
>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK 2
>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK 3
>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK 4
>>>>>>> +
>>>>>>> +struct drm_amdgpu_profile_in {
>>>>>>> +     /** AMDGPU_PROFILE_OP_* */
>>>>>>> +     __u32   op;
>>>>>>> +     __u32   flags;
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct drm_amdgpu_profile_out {
>>>>>>> +     __u64   flags;
>>>>>>> +};
>>>>>>> +
>>>>>>> +union drm_amdgpu_profile {
>>>>>>> +     struct drm_amdgpu_profile_in in;
>>>>>>> +     struct drm_amdgpu_profile_out out;
>>>>>>> +};
>>>>>>> +
>>>>>>>    /*
>>>>>>>     * Supported GPU families
>>>>>>>     */
>>>>
>>

