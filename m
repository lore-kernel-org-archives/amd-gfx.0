Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B53C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 18:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616B410F703;
	Fri, 26 Jun 2026 18:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QT59V1SN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FC110F703
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bkRu7ES02iECNJ0VDxKjB5l2K+1X50pQ0IKSs+7ftFs=; b=QT59V1SNrR8Oe4Nt5gjMDZqyEZ
 0AhzH2AG6WFAN8LG2k9Znvq4x9RBhuRqgouN0ojz7bqa8k7PNZPSAiTsr7nod5gJMnZJ9mUnsvENO
 naCjkOvfazPefQ8a3QJrUbYgLxWNKAnY5XsPN3E2WyFU2lCmC6TjpziOBwOashxhk0dVnfzphOj39
 nbOQIi4wiwYynpPng1ZrAzE94pb1+UWJGVVrOw2gzU9PItQt//dQx1iA7kkcM4//FaCEy6kxqMtyO
 pB6Y+A4iFv6M/n56AyS53JTOCT49FXpxy9VIFt+Lz4KvmVujmrECyw81wUddMyq8zwRRbUAzsTj+2
 090+Foww==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wdBm0-005dC2-Op; Fri, 26 Jun 2026 20:59:32 +0200
Message-ID: <662f5a91-b065-4a76-96ee-b497b0b5f5b1@igalia.com>
Date: Fri, 26 Jun 2026 19:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Do not fiddle with the idle workers too
 much
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <20260626085558.97923-4-tvrtko.ursulin@igalia.com>
 <7279658.9J7NaK4W3v@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <7279658.9J7NaK4W3v@timur-max>
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


On 26/06/2026 18:15, Timur Kristóf wrote:
> On 2026. június 26., péntek 10:55:58 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> Idle workers only need to be canceled or pushed back if we are potentially
>> idle. Make the both operations conditional on the pre-increment and post-
>> decrement status of the in-flight job counter.
>>
> 
> Nice catch!

I now have some second thoughts about this one. Think I have inverted 
the logic of what it needs to achieve. I blame the heat wave :) but at 
least I am pretty sure there is still a way to make it more efficient. I 
will re-visit next week.

Regards,

Tvrtko

> 
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 11 +++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c |  9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 12 +++++-------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 +++++-------
>>   4 files changed, 20 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c index 85372af1216d..623a5339bc47
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -2460,9 +2460,8 @@ void amdgpu_gfx_profile_ring_begin_use(struct
>> amdgpu_ring *ring) else
>>   		profile = PP_SMC_POWER_PROFILE_COMPUTE;
>>
>> -	atomic_inc(&adev->gfx.total_submission_cnt);
>> -
>> -	cancel_delayed_work_sync(&adev->gfx.idle_work);
>> +	if (!atomic_fetch_inc(&adev->gfx.total_submission_cnt))
>> +		cancel_delayed_work_sync(&adev->gfx.idle_work);
>>
>>   	/* We can safely return early here because we've cancelled the
>>   	 * the delayed work so there is no one else to set it to false
>> @@ -2490,9 +2489,9 @@ void amdgpu_gfx_profile_ring_end_use(struct
>> amdgpu_ring *ring) if (amdgpu_dpm_is_overdrive_enabled(adev))
>>   		return;
>>
>> -	atomic_dec(&ring->adev->gfx.total_submission_cnt);
>> -
>> -	schedule_delayed_work(&ring->adev->gfx.idle_work,
>> GFX_PROFILE_IDLE_TIMEOUT); +	if
>> (atomic_dec_and_test(&ring->adev->gfx.total_submission_cnt))
>> +		schedule_delayed_work(&ring->adev->gfx.idle_work,
>> +				      GFX_PROFILE_IDLE_TIMEOUT);
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c index 63ee6ba6a931..57935c321515
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -134,8 +134,8 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
>> *ring) {
>>   	struct amdgpu_device *adev = ring->adev;
>>
>> -	atomic_inc(&adev->jpeg.total_submission_cnt);
>> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>> +	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
>> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
>>
>>   	mutex_lock(&adev->jpeg.jpeg_pg_lock);
>>   	amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_JPEG,
>> @@ -145,8 +145,9 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
>> *ring)
>>
>>   void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
>>   {
>> -	atomic_dec(&ring->adev->jpeg.total_submission_cnt);
>> -	schedule_delayed_work(&ring->adev->jpeg.idle_work,
> JPEG_IDLE_TIMEOUT);
>> +	if (atomic_dec_and_test(&ring->adev->jpeg.total_submission_cnt))
>> +		schedule_delayed_work(&ring->adev->jpeg.idle_work,
>> +				      JPEG_IDLE_TIMEOUT);
>>   }
>>
>>   int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c index b261aa7c1ba8..8d2abf706dfd
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -506,9 +506,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>> struct amdgpu_device *adev = ring->adev;
>>   	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>>
>> -	atomic_inc(&vcn_inst->total_submission_cnt);
>> -
>> -	cancel_delayed_work_sync(&vcn_inst->idle_work);
>> +	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
>> +		cancel_delayed_work_sync(&vcn_inst->idle_work);
>>
>>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>> @@ -550,10 +549,9 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>>   	    !adev->vcn.inst[ring->me].using_unified_queue)
>>   		atomic_dec(&ring->adev->vcn.inst[ring-
>> me].dpg_enc_submission_cnt);
>>
>> -	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>> -
>> -	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>> -			      VCN_IDLE_TIMEOUT);
>> +	if
>> (atomic_dec_and_test(&ring->adev->vcn.inst[ring->me].total_submission_cnt))
>> +		schedule_delayed_work(&ring->adev->vcn.inst[ring-
>> me].idle_work, +				
>>     VCN_IDLE_TIMEOUT);
>>   }
>>
>>   int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c index 8b8184fe6764..0d8a3cea63ee
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -159,9 +159,8 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring
>> *ring) struct amdgpu_device *adev = ring->adev;
>>   	struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
>>
>> -	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
>> -
>> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>> +	if (!atomic_fetch_inc(&adev->vcn.inst[0].total_submission_cnt))
>> +		cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>>
>>   	/* We can safely return early here because we've cancelled the
>>   	 * the delayed work so there is no one else to set it to false
>> @@ -207,10 +206,9 @@ static void vcn_v2_5_ring_end_use(struct amdgpu_ring
>> *ring) !adev->vcn.inst[ring->me].using_unified_queue)
>>   		atomic_dec(&adev->vcn.inst[ring-
>> me].dpg_enc_submission_cnt);
>>
>> -	atomic_dec(&adev->vcn.inst[0].total_submission_cnt);
>> -
>> -	schedule_delayed_work(&adev->vcn.inst[0].idle_work,
>> -			      VCN_IDLE_TIMEOUT);
>> +	if (atomic_dec_and_test(&adev->vcn.inst[0].total_submission_cnt))
>> +		schedule_delayed_work(&adev->vcn.inst[0].idle_work,
>> +				      VCN_IDLE_TIMEOUT);
>>   }
>>
>>   /**
> 
> 
> 
> 

