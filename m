Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B321C48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 14:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7E310E8F2;
	Thu, 15 Feb 2024 14:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdLC+7Dm";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E06210E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 14:43:05 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-33b189ae5e8so468796f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708008184; x=1708612984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z/54/bVxqitDArdjSZj5UFEFneL4QNiBVdb4RxSBqfU=;
 b=IdLC+7Dmjw0UMgnA8O7GiAOERXwuabv0GoFxVm9KQC74aWWAaL7cGpbT9e//fG3IpO
 xc95VeNVH1u0g/SS/FADNSSfPt1paJSXiB8Vbgqb9sa6p9h777nFkI/0XYRRExqVM0UJ
 a5edoPBE1XD4JUMqhSqCE8pEEO3YX1spJ/3QVk5qKi1txjTVOMI2v37mBZ1mV6GYNo02
 Qe5aoF/b0dxglc2HZ9e+6xCLKZnhExgc1Bu49l9fPdGU4YFvepHfqbfJfYbNpCuxq9ug
 pwyrL/JtJrQV0fcquLirnwpE7t6LfRUD+JTUfa3NfUqznRPwPKj2I9uFFKh1RR5D3SRv
 +NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008184; x=1708612984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z/54/bVxqitDArdjSZj5UFEFneL4QNiBVdb4RxSBqfU=;
 b=eOp09mNCclZNPMzXHTxA7C/wsnLXhXhXFI1e7uCIBqBWd0UtVBMijrC3BmE9LlZjY2
 dV+zZ6On5z4GIxgpxQeg1Aio5IsKre0U8CXdaoR+3TMeFyz3WOso0qJAz5obdkLSdsOR
 FmSgX6OKXac4OGI0AdXd33iIEOKg/bZIQRNYpuTZB0ONsoDi6iN8d7+57SkL/bLY04p2
 EGyhXOqhx1X+Fz5Ys/ntR+JuIX/v7ocimLDZtIv6Op7aHtkSXtVOGJyfixl+kWokyB28
 RE8tmWv9+oJm1zTkuo2IzUbbvxE/fjJttbBiA2gXyQ6kJkit8k4Qw42k/jJVg0ldzhnA
 geGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAcLeVSnQXp6RvJGwa8hgL96aVt/qhVzaJN1h3Lpw1/d0AZDGDUW5bYdeSCJ9DNGB7pMTBkKRVvaSwhGgG52YNe14QPkeNnRSuv5+gCw==
X-Gm-Message-State: AOJu0YwBL7SwBUNUAbHK9hifRCdCo8PGmSYJ+KKyn0LOF9lYociBoC97
 wJhj9eRarCco33EVQtPLA56+pr80rg4G+3IRq26yxZIN7nm6ynTx9es76ZB0
X-Google-Smtp-Source: AGHT+IFNeZCF620V4H6eh9M2RonaY6+GD6WYNiwgKMzFCeW+S1YG0aH+d4Hmleqepn1gNPQRfg+RRw==
X-Received: by 2002:a5d:490b:0:b0:33d:13b0:d219 with SMTP id
 x11-20020a5d490b000000b0033d13b0d219mr296375wrq.17.1708008183486; 
 Thu, 15 Feb 2024 06:43:03 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bp9-20020a5d5a89000000b0033d0a0b0d06sm1517612wrb.96.2024.02.15.06.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:43:03 -0800 (PST)
Message-ID: <49e99cc0-9a33-45b6-a0c6-482e54491a38@gmail.com>
Date: Thu, 15 Feb 2024 15:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240129155621.824237-1-alexander.deucher@amd.com>
 <BL1PR12MB514476B2675A7FEA612D6473F7482@BL1PR12MB5144.namprd12.prod.outlook.com>
 <55944c59-2943-4557-ad23-eff38b548383@gmail.com>
 <CADnq5_NtabnxNXA50+W92k-4302B=tazjhxzGDnp9or1uZmAkw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NtabnxNXA50+W92k-4302B=tazjhxzGDnp9or1uZmAkw@mail.gmail.com>
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

Am 15.02.24 um 15:36 schrieb Alex Deucher:
> On Thu, Feb 15, 2024 at 2:53 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Well using this is in sysfs is a bug to begin with. This would prevent
>> starting new applications and crashing applications which don't expect
>> to get an -EPERM in return here.
>>
>> If we need to make operations mutual exclusive with resets then we need
>> to take the appropriate locks and *not* work around by abusing
>> amdgpu_in_reset().
>>
>> The functionality of amdgpu_in_reset() is just to check in lower level
>> functions if we are inside the higher level reset thread and *not*
>> protect anybody from concurrent access.
>>
>> I think we should probably completely nuke the underlying flag and using
>> the thread owner of the lock to prevent such an abuse.
> Can we land some variant of this for now?

I don't think so, it most likely will break existing use cases.

What we might be able to do is to frame this with 
amdgpu_device_lock_reset_domain() / amdgpu_device_unlock_reset_domain().

> It fixes known issues and it's the same behavior we have in sysfs and debugfs already.

Yeah, as I said that is broken to begin with. It's just that for sysfs 
and debugfs nobody notices.

Regards,
Christian.

>    It's not
> clear to me how this should best be handled.  We basically want to
> block any access to the GPU (registers, firmwares, etc.) while the GPU
> is going through a reset.  Just locking the reset domain doesn't seem
> like the right solution.
>
> Alex
>
>> Regards,
>> Christian.
>>
>> Am 12.02.24 um 21:56 schrieb Deucher, Alexander:
>>> [AMD Official Use Only - General]
>>>
>>> Ping?
>>>
>>>> -----Original Message-----
>>>> From: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Sent: Monday, January 29, 2024 10:56 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
>>>>
>>>> This avoids queries to read registers or query the SMU for telemetry data while
>>>> the GPU is in reset. This mirrors what we already do for sysfs.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index a2df3025a754..d522e99c6f81 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -607,6 +607,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
>>>> *data, struct drm_file *filp)
>>>>         int i, found, ret;
>>>>         int ui32_size = sizeof(ui32);
>>>>
>>>> +     if (amdgpu_in_reset(adev))
>>>> +             return -EPERM;
>>>> +
>>>>         if (!info->return_size || !info->return_pointer)
>>>>                 return -EINVAL;
>>>>
>>>> --
>>>> 2.42.0

