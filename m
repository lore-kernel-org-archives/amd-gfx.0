Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE37D41C2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 12:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4207810E237;
	Thu, 11 Dec 2025 12:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yv3t3zl6";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F15E10E237
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 12:08:24 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ee328b8e38so101261cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765454903; x=1766059703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Zr5JEAVQjlffM6WKgL5EYw+Ouk6UM7j868+/hsXa4Y=;
 b=Yv3t3zl6Si6ayRRs98qIZgE30uMg3v9DWXnyQjtsmVwH+ujARWISfOGE7FKd+swm84
 fGfy8pECLsq/VsUftQ5qUgdb7blyxqms8Dg9zyJ+kpqUZrTRx9wrAPzJSO7Ybp2Eitfr
 uxh72dAPCQX4UnVEdsDqxnocBhHDPnSMl6utNDGblsuJEW4h7yyDtqE+gUzDdBCvX7i1
 AxOpY4MHpmbW8m/ghaYfQr97v1BK995uUn3encAt3RI+p6muLqWKrZy8eN/Uyzr3MmY9
 om89EoE/sGRlWsw14yyDjrkF4TCND8VZvY2h/W7PiGkW4/8IhmnVpfabHPtcqX2tDz6o
 PgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765454903; x=1766059703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Zr5JEAVQjlffM6WKgL5EYw+Ouk6UM7j868+/hsXa4Y=;
 b=UMTAvQ+iLdh+CxH6X7LkFZ/q+IYuKa4lmGptAIYqhGz3Upuzpb7iPM8oVRSNl8dcwf
 1KLQuf+/GO5PNaGxArqzVS3dxcnTDWkvVSxFiaK4Dzi7hao/3epKcpHhUQRS7Hi5W+Me
 1GzGm6HSaLYbDTMVWUp/pvnzKNQ3m6nGKAQteSBhEn/bWH+QoFZm2hlyBQd+PGV0WMrX
 rKDAh88VIFXPJusAhUSVhhi4zlHhaIqD/lFrgKS6uEfxG5GJZg3FnDmWET2DBTmSZWR5
 vX3Akyif+JjtOQ1ebB0zFGmIAPItKhMuEgdbj0TuDZAgr3puw/SvVeGW8tPWWJJAmi0k
 LlbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXymhGeNuwRoKg938EU7W2sKiuvlUL39ErktswLsDWeoo6HutbVXYKfpJGC3NO5bciEBSmQ7mLq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7RuVKlO04f9pEujzaNgET31HvmR54nR2wou3O5oLXISpkhfyq
 h3YLNiuTPCXP2uY5m5eAH6cvopMo7xNjx7iNF3ZLL9h82N4DcdzGA2Nn
X-Gm-Gg: AY/fxX6mKoaSbHO9/VbZKChPb1+YBieuiMbvdDPmfWc2KpQ82LFf8PkIm5VMvE2tCIx
 lUjM0Lb8bohL1HHi0udqmqFl2k7QIPefbKA3+VJ3Whbxsvxx7UmphQk8w8ZD66H5m3WFqk263Dr
 u0U9OmrmeSjWzs8ZuLUeOKOdmnnYsJImTwKz3Q4pVu1HieuJ8fQE7bVOSfw5KoUKeK2eTQgN5o+
 HnnbhIhDFCqxgnipW+WVZx+BYqCti2JxkGN9czKaGZpG1/YQp3r0av+V3duFQyCx+yTL+Ym3Xrc
 b5d8i7d2MhHtGfbT6R9h8m035iDZFs0MKPWXLBb1sSXroPoCAwCTcdqand/X1PsUp8jxb8rHbvP
 rt5kY6ijRh5qSEvwTrgb3d6HOaHGURNyWA1RKXfWcVGhSxeoLWvaH8jtLDYm5BijjYqOY0tSogX
 NGMZCCj320cTUwvtctD3nMdOl4uFeGeWzSshMOxTFRutg=
X-Google-Smtp-Source: AGHT+IGhHdN6vXV4TcYKNKhjXV4plrQ0UBmfAdrZ5eoIvPLEraINaFoTsnZ8s6/0r+tOwHzEYNE3jw==
X-Received: by 2002:a05:622a:1f0f:b0:4ee:209c:be59 with SMTP id
 d75a77b69052e-4f1b1b4bdaamr86738421cf.55.1765454903002; 
 Thu, 11 Dec 2025 04:08:23 -0800 (PST)
Received: from [10.254.120.126] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd70a30bsm15613761cf.31.2025.12.11.04.08.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Dec 2025 04:08:22 -0800 (PST)
Message-ID: <5f55a311-8924-44cd-af55-c0ccc4d20218@gmail.com>
Date: Thu, 11 Dec 2025 13:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cache the pasid in amdgpu_device_gpu_recover
To: phasta@kernel.org, alexander.deucher@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com, vitaly.prosyak@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20251210125740.9551-1-christian.koenig@amd.com>
 <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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

On 12/10/25 14:00, Philipp Stanner wrote:
> On Wed, 2025-12-10 at 13:57 +0100, Christian König wrote:
>> The job might already be freed up here. So cache the pasid for later
>> use.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Philipp Stanner <phasta@mailbox.org>
> 
> No! :D
> 
> You read the wrong quote.
> Matthew found your issue (in the middle of my time zone's night, while
> I was peacefully asleep).

Oh, good point. Sorry the credits go to Matthew of course.

> 
>> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> 
> I think there was a gitlab ticket about that a month ago? Could be
> added to Closes:

Yeah, I remember that as well but I can't find it of hand.

Does anybody have the right link at hand?

Thanks,
Christian.

> 
> 
> P.
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 654f4844b7ad..84bb89498e12 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6506,8 +6506,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>  	struct list_head device_list;
>>  	bool job_signaled = false;
>>  	struct amdgpu_hive_info *hive = NULL;
>> -	int r = 0;
>>  	bool need_emergency_restart = false;
>> +	unsigned int pasid = job->pasid;
>> +	int r = 0;
>>  
>>  	/*
>>  	 * If it reaches here because of hang/timeout and a RAS error is
>> @@ -6605,7 +6606,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>  		struct amdgpu_task_info *ti = NULL;
>>  
>>  		if (job)
>> -			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
>> +			ti = amdgpu_vm_get_task_info_pasid(adev, pasid);
>>  
>>  		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
>>  				     ti ? &ti->task : NULL);
> 

