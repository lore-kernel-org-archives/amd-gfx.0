Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DF2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDFB6120D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DDFB6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F28686EA21;
	Wed, 29 Sep 2021 09:52:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F1A6EA21
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:52:00 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id z2so1337287wmc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=CWqkKItkZzZkhfZWk6PjoTQi84q64oYdhOG/wcPFwUU=;
 b=JnVWyjGYC5fJWv436d5z7792/vOT1OOq+29UkhLAvERwWwTrMdTRJVX02UakCQDBw1
 kfo9vvS5HgkB3LiYO7pqlP3E+4rEPVkNalE8dm3tqH7t7BhIGHgBhjbJK61SQo8Ra5Fd
 aYEx2nEo+D3qRcUPXVEiIo7B/8LU/8pOYv0BlavX2KORQXhqM5MdnnNXaTHBq77ovRy8
 bqpRhhW2I3epcPdAK9KXMG9TEkplzVQL3bdOS5T9UJe3w8D6Aam5kDCgh8AZa6IblZhh
 KvljEGmoivM5/i3MGfOqzue7sPpm6zQQorKFD0HlkUXHnfYOjd0s1muDcS+rMm9cZwM8
 UqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=CWqkKItkZzZkhfZWk6PjoTQi84q64oYdhOG/wcPFwUU=;
 b=AzF4kuXRZsKBrM3zwMjfGwOSPELEJtPsd+qm7KiA4KfgG+wyNj1YF6N+LoHABifmJN
 43GExwh02I93ujU+LBMplo0QYy2FPknzCptgWyVfPaWKqhCkjPneA88JJ0VnySYqrIlr
 h+jLqVSFyqW8CEq1xK1Mjc7LobTtSDBWuRCDvvtBgAtfdmuewxlzqDw9mY7McOjT+94S
 DNcNTBYdRzUOI/8CISdfulHRM1+1fHNBwcP1o6jNdYckWZ9HTYJKLzhTKDRYdz/L9frp
 n0U8BqYx45LiqVdA+TtOfpWKuVUK29vuETxxNeNQWpFbXlk5OyY5082BExYg8i5bfe5D
 FGdw==
X-Gm-Message-State: AOAM530u5YKltxfW2Y3HRCWWcmnfjMBfuuI8jjEp90okRAJysCiin8C/
 VRmuITzYMaVf7TIDMJAo7l4GmY4OykY=
X-Google-Smtp-Source: ABdhPJytUdIsssuFVdOT+wU6VpY4fZyEFJK+eZ3rdziDmFoQa/dj+nE66NcU0JRQ2ek4Enbt5sfG4A==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr9128194wmh.137.1632909119361; 
 Wed, 29 Sep 2021 02:51:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4405:6e4f:ef81:78d1?
 ([2a02:908:1252:fb60:4405:6e4f:ef81:78d1])
 by smtp.gmail.com with ESMTPSA id p3sm1678255wrn.47.2021.09.29.02.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:51:58 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/pm: Fix that RPM cannot be obtained for specific
 GPU
To: Alex Deucher <alexdeucher@gmail.com>
Cc: huangyizhi <huangyizhi@hnu.edu.cn>, "Quan, Evan" <evan.quan@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, xinhui pan
 <Xinhui.Pan@amd.com>, Dave Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee.jones@linaro.org>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210928004941.6978-1-huangyizhi@hnu.edu.cn>
 <5e4e8b4e-a8be-300c-8c9c-96a65e0a467f@gmail.com>
 <CADnq5_Mw_652K=Oe0OGPCfzcdfk68nqXp-yLeUDLGxM-41HVSw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1685a2a7-10d4-44bd-dc43-5cbc4cd64488@gmail.com>
Date: Wed, 29 Sep 2021 11:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Mw_652K=Oe0OGPCfzcdfk68nqXp-yLeUDLGxM-41HVSw@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.21 um 23:50 schrieb Alex Deucher:
> On Tue, Sep 28, 2021 at 2:29 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 28.09.21 um 02:49 schrieb huangyizhi:
>>> The current mechanism for obtaining RPM is to read tach_period from
>>> the register, and then calculate the RPM together with the frequency.
>>> But we found that on specific GPUs, such as RX 550 and RX 560D,
>>> tach_period always reads as 0 and smu7_fan_ctrl_get_fan_speed_rpm
>>> will returns -EINVAL.
>>>
>>> To solve this problem, when reading tach_period as 0, we try
>>> to estimate the current RPM using the percentage of current pwm, the
>>> maximum and minimum RPM.
>> Well that is most likely a bad idea.
>>
>> When the fan speed is not available faking some value is certainly not
>> the right solution, especially when you don't know the topology of the
>> DC conversion driven by the PWM.
>>
> I think there is a flag in the vbios to determine whether a specific
> board supports rpm based fan control.  This used to be an AIB specific
> option.  If the flag is not set, the driver should not expose the rpm
> interface for fan control, only the PWM interface.  I think at some
> point rpm fan control became mandatory, but maybe it was still an
> option on polaris and we are missing a check for that flag.

Yeah, that sounds totally sane to me as well.

Let's ask for a volunteer for the job on Thursday if not somebody from 
the community speaks up.

Christian.

>
> Alex
>
>
>> Christian.
>>
>>> Signed-off-by: huangyizhi <huangyizhi@hnu.edu.cn>
>>> ---
>>>    .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 28 ++++++++++++++++---
>>>    1 file changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
>>> index a6c3610db23e..307dd87d6882 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
>>> @@ -81,6 +81,11 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
>>>    {
>>>        uint32_t tach_period;
>>>        uint32_t crystal_clock_freq;
>>> +     uint32_t duty100;
>>> +     uint32_t duty;
>>> +     uint32_t speed_percent;
>>> +     uint64_t tmp64;
>>> +
>>>
>>>        if (hwmgr->thermal_controller.fanInfo.bNoFan ||
>>>            !hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolution)
>>> @@ -89,13 +94,28 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
>>>        tach_period = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
>>>                        CG_TACH_STATUS, TACH_PERIOD);
>>>
>>> -     if (tach_period == 0)
>>> -             return -EINVAL;
>>> +     if (tach_period == 0) {
>>>
>>> -     crystal_clock_freq = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
>>> +             duty100 = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
>>> +                             CG_FDO_CTRL1, FMAX_DUTY100);
>>> +             duty = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
>>> +                             CG_THERMAL_STATUS, FDO_PWM_DUTY);
>>>
>>> -     *speed = 60 * crystal_clock_freq * 10000 / tach_period;
>>> +             if (duty100 == 0)
>>> +                     return -EINVAL;
>>>
>>> +             tmp64 = (uint64_t)duty * 100;
>>> +             do_div(tmp64, duty100);
>>> +             speed_percent = MIN((uint32_t)tmp64, 100);
>>> +
>>> +             *speed = speed_percent * (hwmgr->thermal_controller.fanInfo.ulMaxRPM
>>> +                     - hwmgr->thermal_controller.fanInfo.ulMinRPM) / 100;
>>> +     } else {
>>> +
>>> +             crystal_clock_freq = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
>>> +
>>> +             *speed = 60 * crystal_clock_freq * 10000 / tach_period;
>>> +     }
>>>        return 0;
>>>    }
>>>

