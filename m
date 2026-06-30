Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B1DC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 08:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DD310EBA6;
	Tue, 30 Jun 2026 08:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Vq6AOGNM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3773910EBA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MOvnq0a9Ekl/Y3MEvI8d2DF+xN8pWsdpk7IOCr+r5Ew=; b=Vq6AOGNMf9Cm6QHV7Iu2mkElBE
 Zt7t1D+vZwRMkhRDqwRu0K+6GFzNP/wRd8QU1ElHi/WJsCdwlRkciQ71CV8zhGpwHoookqGIywKkG
 kkd2/TaPMrHxlTV2rFbhwFyXmRCRqTRekC6O5HOTAIs0Pxh137th9frFyIU3k+QmFHEToLuHo+UUN
 7HkfiHPA7hMgpy11AeEqs4ZcySibRuqdfMP7XT6NraPJTFQNQPcL2TsADhAGiPeenDdVOu7SQfxJl
 pOxD6WcfK6HBjab4X2qRpUFT8u6tAh1B4SFfxhOW6fZEJFyutk0+yjOiifb0vWN6fIuAH5UE3h/aB
 e45gOZNg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1weU4a-0070Kx-0S; Tue, 30 Jun 2026 10:44:04 +0200
Message-ID: <c084716d-715c-4b1a-84ac-d2554fc18fbc@igalia.com>
Date: Tue, 30 Jun 2026 09:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Do not fiddle with the idle workers too
 much
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <20260626085558.97923-4-tvrtko.ursulin@igalia.com>
 <7279658.9J7NaK4W3v@timur-max>
 <662f5a91-b065-4a76-96ee-b497b0b5f5b1@igalia.com>
Content-Language: en-GB
In-Reply-To: <662f5a91-b065-4a76-96ee-b497b0b5f5b1@igalia.com>
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


On 26/06/2026 19:59, Tvrtko Ursulin wrote:
> 
> On 26/06/2026 18:15, Timur Kristóf wrote:
>> On 2026. június 26., péntek 10:55:58 közép-európai nyári idő Tvrtko 
>> Ursulin
>> wrote:
>>> Idle workers only need to be canceled or pushed back if we are 
>>> potentially
>>> idle. Make the both operations conditional on the pre-increment and 
>>> post-
>>> decrement status of the in-flight job counter.
>>>
>>
>> Nice catch!
> 
> I now have some second thoughts about this one. Think I have inverted 
> the logic of what it needs to achieve. I blame the heat wave :) but at 
> least I am pretty sure there is still a way to make it more efficient. I 
> will re-visit next week.

Okay I now again think the patch is fine. I got confused by the 
total_submission_count tracking only in flight ring emissions, while the 
idle worker has a secondary gate on emitted fences.

I had some ideas on how to further optimise this, by reducing to a 
single criteria, moving the counter tracking to track hw fences emission 
and retire, and also to prefer just letting the idle worker fire instead 
of canceling (much cheaper to self-cancel), but.. I got bogged down in 
the VCN code and did not get it all working in reasonable time.

So I think for now if AMD is happy with this one, I think it could be 
picked up as is, and I can follow up with further improvements when I 
get some more free time.

Regards,

Tvrtko

>>
>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 11 +++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c |  9 +++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 12 +++++-------
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 +++++-------
>>>   4 files changed, 20 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c index 
>>> 85372af1216d..623a5339bc47
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -2460,9 +2460,8 @@ void amdgpu_gfx_profile_ring_begin_use(struct
>>> amdgpu_ring *ring) else
>>>           profile = PP_SMC_POWER_PROFILE_COMPUTE;
>>>
>>> -    atomic_inc(&adev->gfx.total_submission_cnt);
>>> -
>>> -    cancel_delayed_work_sync(&adev->gfx.idle_work);
>>> +    if (!atomic_fetch_inc(&adev->gfx.total_submission_cnt))
>>> +        cancel_delayed_work_sync(&adev->gfx.idle_work);
>>>
>>>       /* We can safely return early here because we've cancelled the
>>>        * the delayed work so there is no one else to set it to false
>>> @@ -2490,9 +2489,9 @@ void amdgpu_gfx_profile_ring_end_use(struct
>>> amdgpu_ring *ring) if (amdgpu_dpm_is_overdrive_enabled(adev))
>>>           return;
>>>
>>> -    atomic_dec(&ring->adev->gfx.total_submission_cnt);
>>> -
>>> -    schedule_delayed_work(&ring->adev->gfx.idle_work,
>>> GFX_PROFILE_IDLE_TIMEOUT); +    if
>>> (atomic_dec_and_test(&ring->adev->gfx.total_submission_cnt))
>>> +        schedule_delayed_work(&ring->adev->gfx.idle_work,
>>> +                      GFX_PROFILE_IDLE_TIMEOUT);
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c index 
>>> 63ee6ba6a931..57935c321515
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> @@ -134,8 +134,8 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
>>> *ring) {
>>>       struct amdgpu_device *adev = ring->adev;
>>>
>>> -    atomic_inc(&adev->jpeg.total_submission_cnt);
>>> -    cancel_delayed_work_sync(&adev->jpeg.idle_work);
>>> +    if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
>>> +        cancel_delayed_work_sync(&adev->jpeg.idle_work);
>>>
>>>       mutex_lock(&adev->jpeg.jpeg_pg_lock);
>>>       amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_JPEG,
>>> @@ -145,8 +145,9 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
>>> *ring)
>>>
>>>   void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
>>>   {
>>> -    atomic_dec(&ring->adev->jpeg.total_submission_cnt);
>>> -    schedule_delayed_work(&ring->adev->jpeg.idle_work,
>> JPEG_IDLE_TIMEOUT);
>>> +    if (atomic_dec_and_test(&ring->adev->jpeg.total_submission_cnt))
>>> +        schedule_delayed_work(&ring->adev->jpeg.idle_work,
>>> +                      JPEG_IDLE_TIMEOUT);
>>>   }
>>>
>>>   int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c index 
>>> b261aa7c1ba8..8d2abf706dfd
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -506,9 +506,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring 
>>> *ring)
>>> struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>>>
>>> -    atomic_inc(&vcn_inst->total_submission_cnt);
>>> -
>>> -    cancel_delayed_work_sync(&vcn_inst->idle_work);
>>> +    if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
>>> +        cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>
>>>       mutex_lock(&vcn_inst->vcn_pg_lock);
>>>       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>> @@ -550,10 +549,9 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring 
>>> *ring)
>>>           !adev->vcn.inst[ring->me].using_unified_queue)
>>>           atomic_dec(&ring->adev->vcn.inst[ring-
>>> me].dpg_enc_submission_cnt);
>>>
>>> -    atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>> -
>>> -    schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>> -                  VCN_IDLE_TIMEOUT);
>>> +    if
>>> (atomic_dec_and_test(&ring->adev->vcn.inst[ring- 
>>> >me].total_submission_cnt))
>>> +        schedule_delayed_work(&ring->adev->vcn.inst[ring-
>>> me].idle_work, +
>>>     VCN_IDLE_TIMEOUT);
>>>   }
>>>
>>>   int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c index 8b8184fe6764..0d8a3cea63ee
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> @@ -159,9 +159,8 @@ static void vcn_v2_5_ring_begin_use(struct 
>>> amdgpu_ring
>>> *ring) struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
>>>
>>> -    atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
>>> -
>>> -    cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>>> +    if (!atomic_fetch_inc(&adev->vcn.inst[0].total_submission_cnt))
>>> +        cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>>>
>>>       /* We can safely return early here because we've cancelled the
>>>        * the delayed work so there is no one else to set it to false
>>> @@ -207,10 +206,9 @@ static void vcn_v2_5_ring_end_use(struct 
>>> amdgpu_ring
>>> *ring) !adev->vcn.inst[ring->me].using_unified_queue)
>>>           atomic_dec(&adev->vcn.inst[ring-
>>> me].dpg_enc_submission_cnt);
>>>
>>> -    atomic_dec(&adev->vcn.inst[0].total_submission_cnt);
>>> -
>>> -    schedule_delayed_work(&adev->vcn.inst[0].idle_work,
>>> -                  VCN_IDLE_TIMEOUT);
>>> +    if (atomic_dec_and_test(&adev->vcn.inst[0].total_submission_cnt))
>>> +        schedule_delayed_work(&adev->vcn.inst[0].idle_work,
>>> +                      VCN_IDLE_TIMEOUT);
>>>   }
>>>
>>>   /**
>>
>>
>>
>>
> 

