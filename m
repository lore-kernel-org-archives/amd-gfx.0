Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962F4FD531B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1441510EACD;
	Fri, 27 Feb 2026 09:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HBX/5ztW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF35E10EACD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VB65Q1f/+HTwker/IknlS6k8fWiANgNt176e8r55ac0=; b=HBX/5ztWOcekJ1gdyBgzXdBdpB
 B8xR/IgtjHmH0WPS0HafatzeHQH+gkIxRcUpDTK/OF2Fqq9Ly42Trmwl9YfGiHixUF93w23d+GNB1
 Wb3bgRMaidtCyFclQHFB32Vt77j6JisoELTvPpmBvVLM+9rFWnqx65tE7YmRUg7pN744+fRAelFNV
 BSMdSCu1sCiHWYmSng6YcjLnIMi8SVuUVxgsfVlicd1gTSt3A0kTZw7OWDFahbG2RBPNEksYcqU4B
 iFPoRGMkwWbKM+PRlxCRqBp3fgloMhunGGmXooSr7/v2PupM9/EvwzQ3j62dTfTPMpcFOHPFe5NEU
 XUmRI1Xw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vvu9V-006RfR-U8; Fri, 27 Feb 2026 10:28:53 +0100
Message-ID: <fcecb3cd-bde0-49f7-b603-b80ac2e7eea2@igalia.com>
Date: Fri, 27 Feb 2026 09:28:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: Remove impossible NULL check from
 amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20260226154918.84354-1-tvrtko.ursulin@igalia.com>
 <a871d9b0-0317-42a3-89b4-a7d766fa6d53@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <a871d9b0-0317-42a3-89b4-a7d766fa6d53@amd.com>
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


On 27/02/2026 09:22, Christian König wrote:
> On 2/26/26 16:49, Tvrtko Ursulin wrote:
>> LKP reports two suspicious NULL pointer checks, triggered by
>> 4ca06f6fb45d ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>> but these checks were redundant even before. Remove them.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202602262219.UY2pqzl2-lkp@intel.com/
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index ba128b2a2d49..0f941021fcf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -548,7 +548,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	}
>>   
>>   	for (i = 0; i < num_read_bo_handles; i++) {
>> -		if (!gobj_read || !gobj_read[i]->resv)
>> +		if (!gobj_read[i]->resv)
>>   			continue;
> 
> The test for resv not NULL is also completely superfluous here.
> 
> We would have crashed much earlier with a NULL pointer dereference if the GEM object would be mangled like that.

Yep, I see that now, thank you. Will respin.

Regards,

Tvrtko

>>   		dma_resv_add_fence(gobj_read[i]->resv, fence,
>> @@ -556,7 +556,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	}
>>   
>>   	for (i = 0; i < num_write_bo_handles; i++) {
>> -		if (!gobj_write || !gobj_write[i]->resv)
>> +		if (!gobj_write[i]->resv)
>>   			continue;
>>   
>>   		dma_resv_add_fence(gobj_write[i]->resv, fence,
> 

