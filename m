Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605C5C48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 14:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C714310E90F;
	Thu, 15 Feb 2024 14:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K12c5jzS";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B764A10E91A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 14:46:58 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2d0d95e8133so11905411fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708008416; x=1708613216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c/RPhuq+iaYBdoZx3lyflVb/douN8cdJHC5285G3KmY=;
 b=K12c5jzS456q2tIHOlQGkViV+whQWvktmIyVOdQXO9GLFtTlVaZoLF3/LAtwCz8xg+
 h8321kNP/Z/7vqMdC4tkzFL3D08UD3BU5lHmx705uK1aU0k6oFI4jxD6xD/1bRyO53SC
 9iyoZZYtzCErbuUhf5yzw0gWfKf2q8GawmAPVhG1uIZtWD6pbQuTEW5g+rvrVJPR1+Dd
 9IQ4JNT1mqpHW2ctRFlzH+BqiMLZd6IaYuKoiMMxSEmDG5nDdysbbcARj75rn2MgI33l
 0r2LxGlVTUOS1Z9wo9vp7o2cUMYFEbQ84a/MkfghmEWc0K1MI0ppf3eGLvALOFSTIylf
 cjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008416; x=1708613216;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/RPhuq+iaYBdoZx3lyflVb/douN8cdJHC5285G3KmY=;
 b=Nsot+wy3Oryb8J8txTnV/fXJGfbTAtqxLWSTSv8qKa1h+R564WPMAJJYGtcd5kCZzt
 c+A4AgXU5Ib16KyVYdmJRrRXKrEPygh4zpBuk2tETLYFT18bwU16DU3d3gGp56e2UNY8
 kD42sozyrF5pnSDmFF+AJmJe0PdUfWt3v8g5TEdWEKW8Vij6agVS411clcoAQ6zsiD7q
 BvTLyt5OHTTf0lMzeZaXHU1qIrTN46abrLO4JycquRr6nDzFwMuh4bMZORd/9qS/+aBF
 cAI8iQLdIKBdIQdHmMt17nJ3hOOJDalY/3U+RwiMWn4lIIVYOVq16e1lgKn+DU0txJes
 3gCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqMLy/9llqgyTyVYAAMJpzPvd+mch1awewY2bEp62Z4ufcfxNFi3NNXv7+rVw/oxDCSAAXYDk6WNPSqlGrCW3Q3hJYMWBlIBozSpzQVw==
X-Gm-Message-State: AOJu0YxqlvM0pAjzWTNHR0JuO+CaqRBzZ9WBQqP5Govs59uFOomfGpif
 HxUv742BIFWUlJ6PKvQoNYEd5A0Y4CDVvqrOlV0hOu+C+AydpvFMPF6YBxP+
X-Google-Smtp-Source: AGHT+IHabpasovipMgzjrHxwvVSP1TAMIBYvqYhsf+yaDMp1GnqVw56sbC6o/fNctyS5ELtL0rwG5Q==
X-Received: by 2002:a2e:2a85:0:b0:2d0:c95a:f31b with SMTP id
 q127-20020a2e2a85000000b002d0c95af31bmr1587207ljq.24.1708008415906; 
 Thu, 15 Feb 2024 06:46:55 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c470800b004117e45f12esm2262704wmo.22.2024.02.15.06.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:46:55 -0800 (PST)
Message-ID: <3b042c1d-9a92-46f8-936b-2400dba7ba70@gmail.com>
Date: Thu, 15 Feb 2024 15:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240129155621.824237-1-alexander.deucher@amd.com>
 <BL1PR12MB514476B2675A7FEA612D6473F7482@BL1PR12MB5144.namprd12.prod.outlook.com>
 <55944c59-2943-4557-ad23-eff38b548383@gmail.com>
 <CADnq5_NtabnxNXA50+W92k-4302B=tazjhxzGDnp9or1uZmAkw@mail.gmail.com>
 <49e99cc0-9a33-45b6-a0c6-482e54491a38@gmail.com>
In-Reply-To: <49e99cc0-9a33-45b6-a0c6-482e54491a38@gmail.com>
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



Am 15.02.24 um 15:43 schrieb Christian König:
> Am 15.02.24 um 15:36 schrieb Alex Deucher:
>> On Thu, Feb 15, 2024 at 2:53 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Well using this is in sysfs is a bug to begin with. This would prevent
>>> starting new applications and crashing applications which don't expect
>>> to get an -EPERM in return here.
>>>
>>> If we need to make operations mutual exclusive with resets then we need
>>> to take the appropriate locks and *not* work around by abusing
>>> amdgpu_in_reset().
>>>
>>> The functionality of amdgpu_in_reset() is just to check in lower level
>>> functions if we are inside the higher level reset thread and *not*
>>> protect anybody from concurrent access.
>>>
>>> I think we should probably completely nuke the underlying flag and 
>>> using
>>> the thread owner of the lock to prevent such an abuse.
>> Can we land some variant of this for now?
>
> I don't think so, it most likely will break existing use cases.
>
> What we might be able to do is to frame this with 
> amdgpu_device_lock_reset_domain() / amdgpu_device_unlock_reset_domain().
>
>> It fixes known issues and it's the same behavior we have in sysfs and 
>> debugfs already.
>
> Yeah, as I said that is broken to begin with. It's just that for sysfs 
> and debugfs nobody notices.

Wait a second, debugfs is actually doing the right thing in some functions:

         /* Avoid accidently unparking the sched thread during GPU reset */
         r = down_read_killable(&adev->reset_domain->sem);
         if (r)
                 goto pro_end;
...

         up_read(&adev->reset_domain->sem);

This needs to replace amdgpu_in_reset() in pretty much all debugfs and 
sysfs function.

Probably best to wrap that in some inline amdgpu_reset_* functions and 
document why those needs to be used.

Regards,
Christian.


>
> Regards,
> Christian.
>
>>    It's not
>> clear to me how this should best be handled.  We basically want to
>> block any access to the GPU (registers, firmwares, etc.) while the GPU
>> is going through a reset.  Just locking the reset domain doesn't seem
>> like the right solution.
>>
>> Alex
>>
>>> Regards,
>>> Christian.
>>>
>>> Am 12.02.24 um 21:56 schrieb Deucher, Alexander:
>>>> [AMD Official Use Only - General]
>>>>
>>>> Ping?
>>>>
>>>>> -----Original Message-----
>>>>> From: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>> Sent: Monday, January 29, 2024 10:56 AM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>> Subject: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in 
>>>>> reset
>>>>>
>>>>> This avoids queries to read registers or query the SMU for 
>>>>> telemetry data while
>>>>> the GPU is in reset. This mirrors what we already do for sysfs.
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> index a2df3025a754..d522e99c6f81 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> @@ -607,6 +607,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>>> void
>>>>> *data, struct drm_file *filp)
>>>>>         int i, found, ret;
>>>>>         int ui32_size = sizeof(ui32);
>>>>>
>>>>> +     if (amdgpu_in_reset(adev))
>>>>> +             return -EPERM;
>>>>> +
>>>>>         if (!info->return_size || !info->return_pointer)
>>>>>                 return -EINVAL;
>>>>>
>>>>> -- 
>>>>> 2.42.0
>

