Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2407C77B61
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 15:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2615E10E1C2;
	Sun,  9 Apr 2023 15:38:15 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FE910E1C2
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 15:38:12 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id e2so2558264wrc.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681054691; x=1683646691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BxI3TG5hCjM1GLjbUhDL1g0lMg6/kDW1yB0KoT56Fq4=;
 b=Zvpgk2rnWlVeICz7Yc22GM7mmL+tzcKJZrZvXQLZitLeHheA0mpspm8/DJEuxvpymS
 QgxyOXKqWgF0FGAuvbUD7yRUN3GjIxk3bufAHoDcljzgbHCtFRBV9tEPjyUd+N5gKnua
 39Zz0xA7bgrTCsS7nU//kGt0N2JWpCN7QGecbIfbpEZE2c6EQcz9CRGHTyliUfJahz/d
 5WCXtmjwAtFNz+XB+OzgF1SrVHkkEf2s4i92UvdbcQvPpzqKYtDTKz0DCFbT7HE2tish
 hf43V6lgUWhMRpCLfVacZm1319ousGzwk+WDc63DRvU3BChRd2OxxCwg5ZYRfZUeME3Q
 C49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681054691; x=1683646691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BxI3TG5hCjM1GLjbUhDL1g0lMg6/kDW1yB0KoT56Fq4=;
 b=SVEHyWX3taRHIBKAQX7kX5TPHGShHxVHuwUO2PTFoCqOiQPJSAB9nOQWwf8Z8gKWo5
 Po4D+o8twAU/u9fvMt1dE4bIpqlo8SGNWJgK0MnZnZXsu5wJFYZmSY18yghIvBcpW9Aq
 flv+tbMEhE7Q20bUmzZLDuw6V/ZCNDyeJJMPg0IuXHoD7JslS/wGOQnsX4DTA2Zau+Xr
 3BSr+WJKTKxCXCXpvCVF4r9IjRWbyhNnrUffN4Lb1iZH+oyjuPaJvFdrMv5jbL5bARv2
 S07CYcvDKqPCyvm/HcnbRw0OuIQmjZYlF2VWsDEDHeBB0vUSKEyznEm94QjeqaJiZEvU
 loAg==
X-Gm-Message-State: AAQBX9fMdtzygeeaaHDVuN6jlwWyMY0jql59jW3FS0uYi6HyFoO3s/4+
 Zwz/LiN0dsFRrvW8v12++fs=
X-Google-Smtp-Source: AKy350Yo21KRdDA0yYFvext5o++5uAFYzBMIm52OBbF5D9uD9v1jK0JkAa+HpMcQfyzL0VvZQcScaA==
X-Received: by 2002:a5d:6b4c:0:b0:2e5:1c60:5afd with SMTP id
 x12-20020a5d6b4c000000b002e51c605afdmr4807299wrw.1.1681054690654; 
 Sun, 09 Apr 2023 08:38:10 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:f3e8:9542:46ff:241f?
 ([2a02:908:1256:79a0:f3e8:9542:46ff:241f])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b002efb6e0c495sm4759769wrv.91.2023.04.09.08.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Apr 2023 08:38:10 -0700 (PDT)
Message-ID: <7d5bb5e5-91a7-71ba-8fa4-6d1cbcb00b26@gmail.com>
Date: Sun, 9 Apr 2023 17:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
 <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
 <99dad825-894a-bc00-7a26-6b1b917477d4@gmail.com>
 <CAP+8YyF8-5aVoLBmAUy0rS6rturFk0GMYy6Y6wLA2p9U1P7iAw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAP+8YyF8-5aVoLBmAUy0rS6rturFk0GMYy6Y6wLA2p9U1P7iAw@mail.gmail.com>
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
Cc: maraeo@gmail.com, timur.kristof@gmail.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, David Airlie <airlied@gmail.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.04.23 um 17:32 schrieb Bas Nieuwenhuizen:
> On Sun, Apr 9, 2023 at 5:30 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 09.04.23 um 16:44 schrieb Bas Nieuwenhuizen:
>>> We need to introduce a new version of the info struct because
>>> libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
>>> so the mesa<->libdrm_amdgpu interface can't handle increasing the
>>> size.
>> Those are not forgotten, but simply unnecessary.
>>
>> The size of the input output structures are given to the IOCTL in bytes
>> and additional bytes should be filled with zeros.
> At the ioctl side, yes, but it is libdrm_amdgpu filling in the size,
> while passing in the struct directly from the client (mesa or
> whatever). So if we have new libdrm_amdgpu and old mesa, then mesa
> allocates  N bytes on the stack and libdrm_amdgpu happily tells the
> kernel in the ioctl "this struct is N+8 bytes long" which would cause
> corruption?

WTF? This has a wrapper in libdrm? Well then that's indeed horrible broken.

In this case please define the new structure as extension of the old 
one. E.g. something like:

struct drm_amdgpu_info_hw_ip2 {
     struct drm_amdgpu_info_hw_ip    base;
     ....
};

This way we can make it clear that this is an extension.

Thanks,
Christian.

>
> - Bas
>
>> So you should be able to extend the structures at the end without
>> breaking anything.
>>
>> Regards,
>> Christian.
>>
>>> This info would be used by radv to figure out when we need to
>>> split a submission into multiple submissions. radv currently has
>>> a limit of 192 which seems to work for most gfx submissions, but
>>> is way too high for e.g. compute or sdma.
>>>
>>> Because the kernel handling is just fine we can just use the v2
>>> everywhere and have the return_size do the versioning for us,
>>> with userspace interpreting 0 as unknown.
>>>
>>> Userspace implementation:
>>> https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
>>> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
>>>
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
>>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: David Airlie <airlied@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++--
>>>    include/uapi/drm/amdgpu_drm.h           | 29 +++++++++++++++++++++++++
>>>    2 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 89689b940493..c7e815c2733e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>>>
>>>    static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                             struct drm_amdgpu_info *info,
>>> -                          struct drm_amdgpu_info_hw_ip *result)
>>> +                          struct drm_amdgpu_info_hw_ip2 *result)
>>>    {
>>>        uint32_t ib_start_alignment = 0;
>>>        uint32_t ib_size_alignment = 0;
>>> @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                return -EINVAL;
>>>        }
>>>
>>> +     result->max_ibs = UINT_MAX;
>>>        for (i = 0; i < adev->num_rings; ++i) {
>>>                /* Note that this uses that ring types alias the equivalent
>>>                 * HW IP exposes to userspace.
>>> @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                if (adev->rings[i]->funcs->type == info->query_hw_ip.type &&
>>>                    adev->rings[i]->sched.ready) {
>>>                        ++num_rings;
>>> +                     result->max_ibs = min(result->max_ibs,
>>> +                                           adev->rings[i]->max_ibs);
>>>                }
>>>        }
>>>
>>> @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>                }
>>>                return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>>>        case AMDGPU_INFO_HW_IP_INFO: {
>>> -             struct drm_amdgpu_info_hw_ip ip = {};
>>> +             struct drm_amdgpu_info_hw_ip2 ip = {};
>>>                int ret;
>>>
>>>                ret = amdgpu_hw_ip_info(adev, info, &ip);
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index b6eb90df5d05..45e5ae546d19 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
>>>        __u32 enabled_rb_pipes_mask_hi;
>>>    };
>>>
>>> +/* The size of this struct cannot be increased for compatibility reasons, use
>>> + * struct drm_amdgpu_info_hw_ip2 instead.
>>> + */
>>>    struct drm_amdgpu_info_hw_ip {
>>>        /** Version of h/w IP */
>>>        __u32  hw_ip_version_major;
>>> @@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {
>>>        __u32  ip_discovery_version;
>>>    };
>>>
>>> +/* The prefix fields of this are intentionally the same as those of
>>> + * struct drm_amdgpu_info_hw_ip. The struct has a v2 to resolve a lack of
>>> + * versioning on the libdrm_amdgpu side.
>>> + */
>>> +struct drm_amdgpu_info_hw_ip2 {
>>> +     /** Version of h/w IP */
>>> +     __u32  hw_ip_version_major;
>>> +     __u32  hw_ip_version_minor;
>>> +     /** Capabilities */
>>> +     __u64  capabilities_flags;
>>> +     /** command buffer address start alignment*/
>>> +     __u32  ib_start_alignment;
>>> +     /** command buffer size alignment*/
>>> +     __u32  ib_size_alignment;
>>> +     /** Bitmask of available rings. Bit 0 means ring 0, etc. */
>>> +     __u32  available_rings;
>>> +     /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>>> +     __u32  ip_discovery_version;
>>> +     /** The maximum number of IBs one can submit in a single submission
>>> +      * ioctl. (When using gang submit: this is per IP type)
>>> +      */
>>> +     __u32  max_ibs;
>>> +     /** padding to 64bit for arch differences */
>>> +     __u32  pad;
>>> +};
>>> +
>>>    struct drm_amdgpu_info_num_handles {
>>>        /** Max handles as supported by firmware for UVD */
>>>        __u32  uvd_max_handles;

