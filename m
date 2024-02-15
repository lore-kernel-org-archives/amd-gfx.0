Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B1CC4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 07:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081B110E26A;
	Thu, 15 Feb 2024 07:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cfia/4I/";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4900010E26A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 07:28:03 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-33cddf4b4b5so373702f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 23:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707982079; x=1708586879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J724PeHJWP0zxqy171puBImT652TP18ax4vddvoRtg8=;
 b=cfia/4I/H9P7S0dvtK7g44mR2cCf4OBhBb83jAo5Tq34Xd39aw6sKELf0gKYn5eJF3
 Zxcr5zukRkqKLBhixRBLEAUcB/MychsBFTUrBb5Q66G0zMWXqO2CvNuoRgwi+bH3iuQL
 P1u3RoO/b4dhn1kVnFaiDBA5oWMBc6BmjaTigWdHao/Oy7eZdib76IGTNmWx3xPanyPF
 4buGcQZ0C7lSo4YKT33wnv52hav05n91tyu+yV5KhbwbKbut9raeW+QrDAW1lcmP/fZT
 BOIDjkaanLm5ElgQQpDcmhI1NFfKuh3llHjPHwnui8XVSt/VH6jQvg2wzrzrNmvpCiSU
 u9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707982079; x=1708586879;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J724PeHJWP0zxqy171puBImT652TP18ax4vddvoRtg8=;
 b=l0VgyxB9asoMKLnPXGPZd5EgjAdL5PXxcCl+IAyRSCVb66fLqBXP5uFf3BzKl8PPyE
 wtR3eppS17MslZzviJ3ySLe//Eg+Of8b3oE6DWD9p5TFDKsjZ1pEuErMbglK1xKW/e87
 6FJ/KXbBQqUQ2O2pA03m53IC6I3aoiBwtil/f+oYSOfpFoD1r7wQGEAwEylgF9eRgk8p
 oxKobcwERPHvtO6yXWY+4ESlHhHCcqfq9kDTiRtx/NAt41+6rClEeRfIoBkY/UhUWpJV
 34fbWsil9UX8/Pm4KxEQpp04JiqeoAwPI77VxDCKuKN4ip9QSQkkP0W/k1ri07784ngr
 lKTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfoaa+QGzzW5vTGxSHOBxDTNsh11H+T+zYJr2SHJDGLSs2eoGfus5w5SBmjNpvfLNw1Ksbs1KbRlM2vsAeEEyGRQVt75NTh057bBgG/w==
X-Gm-Message-State: AOJu0YxyrEiErigtPhX+Go+9UvS0dYJgPtMzrU6TbVPlrgSvdYMXnZCD
 2g9+SN9yvl30bvd8VUb/TUE/Wy9TMvdV5gex6lHEGVI/JGF4a/SnlLJjyjPI
X-Google-Smtp-Source: AGHT+IF+vonNOk6L8dbFQPOV32lHI89nFZMVI8dNMJ6Ycwlhhgf9sZre6BlqOLKyjLxTg4GiZ59Lqw==
X-Received: by 2002:adf:e90a:0:b0:33b:2513:496f with SMTP id
 f10-20020adfe90a000000b0033b2513496fmr809278wrm.66.1707982079111; 
 Wed, 14 Feb 2024 23:27:59 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a5d59c5000000b0033b1277e95dsm872219wry.77.2024.02.14.23.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:27:58 -0800 (PST)
Message-ID: <55944c59-2943-4557-ad23-eff38b548383@gmail.com>
Date: Thu, 15 Feb 2024 08:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240129155621.824237-1-alexander.deucher@amd.com>
 <BL1PR12MB514476B2675A7FEA612D6473F7482@BL1PR12MB5144.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BL1PR12MB514476B2675A7FEA612D6473F7482@BL1PR12MB5144.namprd12.prod.outlook.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well using this is in sysfs is a bug to begin with. This would prevent 
starting new applications and crashing applications which don't expect 
to get an -EPERM in return here.

If we need to make operations mutual exclusive with resets then we need 
to take the appropriate locks and *not* work around by abusing 
amdgpu_in_reset().

The functionality of amdgpu_in_reset() is just to check in lower level 
functions if we are inside the higher level reset thread and *not* 
protect anybody from concurrent access.

I think we should probably completely nuke the underlying flag and using 
the thread owner of the lock to prevent such an abuse.

Regards,
Christian.

Am 12.02.24 um 21:56 schrieb Deucher, Alexander:
> [AMD Official Use Only - General]
>
> Ping?
>
>> -----Original Message-----
>> From: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Sent: Monday, January 29, 2024 10:56 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
>>
>> This avoids queries to read registers or query the SMU for telemetry data while
>> the GPU is in reset. This mirrors what we already do for sysfs.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index a2df3025a754..d522e99c6f81 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -607,6 +607,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
>> *data, struct drm_file *filp)
>>        int i, found, ret;
>>        int ui32_size = sizeof(ui32);
>>
>> +     if (amdgpu_in_reset(adev))
>> +             return -EPERM;
>> +
>>        if (!info->return_size || !info->return_pointer)
>>                return -EINVAL;
>>
>> --
>> 2.42.0

