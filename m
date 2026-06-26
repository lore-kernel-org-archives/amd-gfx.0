Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614B5C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 19:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB91810E274;
	Fri, 26 Jun 2026 19:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cBoHEM+Y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D8910E274
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rOmIE0CF+Mz+pl53T+O7iOs66YOotTKS+U+8CKwg3lY=; b=cBoHEM+YJ7h4FdVCcCbvCmHa0C
 fAmVZHZ+u9dC1YLDdW4CdlVy0aCZR0bNkcrDZLYaRPIUO8Ozp2YFSHhGjiD3kSh8e15eB7qghj1Nh
 tiL82dVxl1mvcSd2oOZfpLB0Q1qZtx3h84IIvW1SKb5PCH/n5zLCKANVCr+MDW5+GmqVdIDxrzH1p
 YSwxbeApujKOKZM31//nyV8CIm0ptGfoNSLwBSHzeKTRl8m6gfHXmnvP5HF91li8ZBYz2CAmmoCFl
 GtpkkWvHrWSqcvjcBnSREY1ygk0BV1bdVjYmBss/zmIC761am6AgfSNKgy+5b142G1c0zjHI1zlm2
 FfeFiWOA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wdBsj-005dKB-1d; Fri, 26 Jun 2026 21:06:29 +0200
Message-ID: <f2817235-3f0f-4a95-ba21-e5c0913f7c07@igalia.com>
Date: Fri, 26 Jun 2026 20:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Remove unused amdgpu_device_ip_is_hw
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <20260626085558.97923-2-tvrtko.ursulin@igalia.com>
 <4887714.vXUDI8C0e8@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4887714.vXUDI8C0e8@timur-max>
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


On 26/06/2026 17:59, Timur Kristóf wrote:
> On 2026. június 26., péntek 10:55:56 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> This function is unused so lets remove it.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
> 
> Nice cleanup!
> 
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> Are there any more uses left of the amdgpu_ip_block_status.hw field?
> As far as I can see the field is set but never used, maybe we could remove it
> too. What did this field mean anyway?

It appears used during init/fini and suspend/resume, a little bit in 
reset. I am not quite sure what it means - could it be "hw initialized" 
or "hw ready"?

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 21 ---------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h |  2 --
>>   2 files changed, 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c index 6aa54156bbc9..62285e973c5c
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
>> @@ -368,27 +368,6 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device
>> *adev, return 0;
>>   }
>>
>> -/**
>> - * amdgpu_device_ip_is_hw - is the hardware IP enabled
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
>> - *
>> - * Check if the hardware IP is enable or not.
>> - * Returns true if it the IP is enable, false if not.
>> - */
>> -bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
>> -			    enum amd_ip_block_type block_type)
>> -{
>> -	struct amdgpu_ip_block *ip_block;
>> -
>> -	ip_block = amdgpu_device_ip_get_ip_block(adev, block_type);
>> -	if (ip_block)
>> -		return ip_block->status.hw;
>> -
>> -	return false;
>> -}
>> -
>>   /**
>>    * amdgpu_device_ip_is_valid - is the hardware IP valid
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h index 1d0df6d93957..11739fbdeaa6
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
>> @@ -146,8 +146,6 @@ void amdgpu_device_ip_get_clockgating_state(struct
>> amdgpu_device *adev, u64 *flags);
>>   int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
>>   				   enum amd_ip_block_type
> block_type);
>> -bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
>> -			    enum amd_ip_block_type block_type);
>>   bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
>>   			       enum amd_ip_block_type block_type);
> 
> 
> 
> 

