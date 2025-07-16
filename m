Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA38DC83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 12:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C3B10E393;
	Wed, 16 Jul 2025 12:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UGtacZSD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FC810E393
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xWi8LhI6myKbBGdHkwu3pGdjAnfpKjB399FmKy0zROU=; b=UGtacZSDD8U616EQcNEpxSA0KY
 /66EnINxbCbbL+deVFnD3QC0YtH4ukl769iQ3O/GtMWj13aC5PIXTdpGEPtQmiOFpy9qBllhQ4hvy
 003oKPrPAUh0oUrVgHTAnJH/CSvhs4b7j/kMzmcQ0djYbM1nd1Bxk9R08RFG1Ni48Q24x5xMMgUhv
 26mwXbrfZNWdrVsStEJPwm9cyknuYh5CQk05xoAGi20P2ZVVUQEwqTPRRtstdzWkN+32xNWIcMdJ0
 Dy09+7Od6Ke51Vt4V4rlm4fb7opRgkIAlGMywwMZgazeDAZfHh7c70QhwlOx9Azls1EUvumX1N+uO
 /7VsZ0jA==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1uc1bJ-00HJlF-TZ; Wed, 16 Jul 2025 14:51:10 +0200
Message-ID: <a07c4db8-a775-4036-a30e-8266c02283df@igalia.com>
Date: Wed, 16 Jul 2025 13:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
 <CADnq5_NYhPa+6gUqeJsvXkqtkwwkWmv=F70Wv96L+CEA-AGE1w@mail.gmail.com>
 <6d19ad87-6091-477c-a1ee-ddb224a63fe1@igalia.com>
 <CADnq5_PFKKdDOnX7np+31jDfmf17=PNSFoFtmHk+XSPqRjnf4Q@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CADnq5_PFKKdDOnX7np+31jDfmf17=PNSFoFtmHk+XSPqRjnf4Q@mail.gmail.com>
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


On 11/07/2025 17:51, Alex Deucher wrote:
> On Fri, Jul 11, 2025 at 12:07 PM Tvrtko Ursulin
> <tvrtko.ursulin@igalia.com> wrote:
>>
>>
>> On 11/07/2025 16:51, Alex Deucher wrote:
>>> On Fri, Jul 11, 2025 at 9:58 AM Tvrtko Ursulin
>>> <tvrtko.ursulin@igalia.com> wrote:
>>>>
>>>>
>>>> On 11/07/2025 14:39, Alex Deucher wrote:
>>>>> On Fri, Jul 11, 2025 at 9:22 AM Tvrtko Ursulin
>>>>> <tvrtko.ursulin@igalia.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/07/2025 13:45, Christian König wrote:
>>>>>>> On 11.07.25 14:23, Tvrtko Ursulin wrote:
>>>>>>>> Commit
>>>>>>>> 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
>>>>>>>> added a workaround which disables GFXOFF for the duration of the job
>>>>>>>> submit stage (with a 100ms trailing hysteresis).
>>>>>>>>
>>>>>>>> Empirically the GFXOFF disable/enable request can suffer from significant
>>>>>>>> latencies (2ms is easily seen) which are then inserted onto the
>>>>>>>> amdgpu_job_run() path, which slows down the CPU submission of ready jobs.
>>>>>>>>
>>>>>>>> 1)
>>>>>>>> If the premise of the GFXOFF workaround is to keep it disabled while the
>>>>>>>> SDMA engine is active, the current workaround achieves that only
>>>>>>>> partially, for submissions and jobs which take less than 100ms (the GFXOFF
>>>>>>>> re-enable hysteresis), counting from the ring write phase, up to
>>>>>>>> completion.
>>>>>>>>
>>>>>>>> 2)
>>>>>>>> If disabling GFXOFF affects the GFX engine too, basing the workaround
>>>>>>>> solely on the SDMA activity creates, at minimum, a needless "chatter" on
>>>>>>>> the SMU communication channel.
>>>>>>>
>>>>>>> IIRC that is intentional. This "needless" chatter is what the workaround was all about.
>>>>>>
>>>>>> I tried to gather knowledge to how the hardware works from the comment
>>>>>> in sdma_v5_2_ring_begin_use(). Maybe I got it wrong so bear with me please.
>>>>>>
>>>>>> To try and explain my questions better. If the GFX ring/engine is busy
>>>>>> is there a point for SDMA to be requesting GFXOFF enable/disable? Or
>>>>>> maybe with diagrams...
>>>>>>
>>>>>> 1)
>>>>>>
>>>>>> SDMA:
>>>>>>
>>>>>>        ring-write     ring-commit       job-execute       job-done
>>>>>>      gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
>>>>>>
>>>>>> Was the workaround prematurely dropped in this case (aka is
>>>>>> ring->funcs->end_use() the right place to drop it from)? Probably
>>>>>> theoretical that a SDMA job takes more than 100ms but I am trying to
>>>>>> understand it all.
>>>>>>
>>>>>
>>>>> The firmware controls the power to a subset of the chip which contains
>>>>> both gfx and sdma.  Normally the firmware dynamically powers up and
>>>>> down gfx transparently when doorbells come in or the engines go idle
>>>>> for either engine.  amdgpu_gfx_off_ctrl() tells the firmware to allow
>>>>> or disallow gfxoff entry.  So what this workaround does is disallow
>>>>> gfxoff (which results in gfx being powered up) before we touch SDMA.
>>>>> Once SDMA is active, we can allow gfxoff again as it will dynamically
>>>>
>>>> Hmm so it is "once" and not "while", as the comment says:
>>>>
>>>>           /* SDMA 5.2.3 (RMB) FW doesn't seem to properly
>>>>            * disallow GFXOFF in some cases leading to
>>>>            * hangs in SDMA.  Disallow GFXOFF while SDMA is active.
>>>>
>>>> ?
>>>>
>>>> And for "once active" amdgpu_ring_commit() is what it counts?
>>>
>>> Yes, amdgpu_ring_commit() rings the doorbell and at that point the
>>> engine starts running and SDMA is active.
>>
>> Should I submit a patch to change this comment to say "Disallow GFXOFF
>> until SDMA is active (doorbell was rang)"?
> 
> Sure.

Okay, will do.

>>>>> be disabled once GFX/SDMA is no longer active.  In this particular
>>>>> case there was a race condition somewhere in the internal handshaking
>>>>> with SDMA which led to SDMA missing doorbells sometimes and not
>>>>> executing the job even if there was work in the ring.
>>>>
>>>> Thank you, more or less than what I assumed.
>>>>
>>>> But in this case there should be no harm in holding GFXOFF disabled
>>>> until the job completes (like this patch)? Only a win to avoid the SMU
>>>> communication latencies while unit is powered on anyway.
>>>
>>> The extra latency is only on the CPU side, once the
>>> amdgpu_ring_commit() is called the SDMA engine is already working.
>>
>> It is on the CPU side but can create bubbles in the pipeline, no? Is
>> there no scope with AMD to have GFX and SDMA jobs depend on each other?
>> Because, as said, I've seen some high latencies from the GFXOFF disable
>> calls.
> 
> The SDMA job is already executing at that point.  The allow gfxoff
> message to the firmware shouldn't come until later because it's
> handled by a delayed work thread from end_use().  If you have multiple
> submissions to SDMA within the delay window, the begin_use() and
> end_use() will just be ref count handling and won't actually talk to
> the firmware.

I followed up with testing a bunch more games, and is it turns out, 
Cyberpunk 2077 is the only one which has this submission patterns where 
default GFX_OFF_DELAY_ENABLE is regularly defeated.

There, around 1.2 times per second the SDMA submissions miss that 100ms 
hysteresis and cause a CPU latency over 100us (I only measured when 
 >100us and ignored the rest). Average latency is ~400us and max is 
~2ms. So IMHO quite bad.

And the vast majority of those latencies come from the SMU request. Only 
very rarely someone hits the mutex contention path.

So that was the motivation for the RFC. I suppose I could have also 
proposed to increase the hysteresis, but holding the GFXOFF disabled for 
the duration of the job sounded preferable for power consmuption.

Anyway, given I only found Cyberpunk 2077 suffers from this I guess it 
maybe isn't to interesting to upstream for you guys. Then again it is 
limited to specific old SKU so maybe it should not be that controversial 
either? Only that Christian NAKed tying it to job lifetime. So I don't 
know, AMDs call.

Regards,

Tvrtko

>>> Plus, the sooner you allow gfxoff again, the sooner it can start
>>> kicking in again.
>>
>>   From this I read that even while GFX or SDMA rings are executing jobs
>> GFXOFF can still power down stuff?
> 
> Only if all of the blocks are idle which would likely not be the case
> if you have outstanding jobs.
> 
> Alex
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>
>>>>
>>>> Regards,
>>>>
>>>> Tvrtko
>>>>
>>>>>> 2)
>>>>>>
>>>>>>
>>>>>> GFX:
>>>>>>
>>>>>>        +-----  job executing --------------------------------------+
>>>>>>
>>>>>> SDMA:
>>>>>>
>>>>>>        ring-write     ring-commit       job-execute       job-done
>>>>>>      gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
>>>>>>
>>>>>>
>>>>>> Is it required for the SDMA activity to cause SMU message traffic in
>>>>>> this case, or is the powerdomain implied to be on (GFXOFF cannot turn it
>>>>>> off while GFX is active)?
>>>>>>
>>>>>> This is the case I measured latency spikes. While the GFX load was
>>>>>> running I was seeing SDMA->run_job() spike and traced it to the SMU
>>>>>> communication.
>>>>>>
>>>>>> Hence the idea from the patch - prevent adev->gfx.gfx_off_req_count
>>>>>> dropping to zero until both GFX and SDMA are idle.
>>>>>>
>>>>>> https://imgshare.cc/rdxu2bjl
>>>>>>
>>>>>> Above is visual representation of these latencies. Y is SDMA run_job()
>>>>>> duration in micro-seconds, X is seconds wall time. Blue is stock kernel,
>>>>>> orange is with this patch. X goes for ~60 seconds, which is how long
>>>>>> Cyberpunk 2077 benchmark is.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Tvrtko
>>>>>>
>>>>>>>> If 1) and 2) hold true, we can improve on the workaround by; a) only
>>>>>>>> re-enabling GFXOFF once the job had actually completed*, and b) apply the
>>>>>>>> same workaround on other rings which share the same GFXOFF powergating
>>>>>>>> domain.
>>>>>>>
>>>>>>> The point of GFXOFF is to turn GFX on/off *without* kernel driver interaction. Otherwise we don't need it in the first place.
>>>>>>>
>>>>>>> We just have a hack for the SDMA because that moved into the GFXOFF domain with Navi and is broken on some HW generations IIRC.
>>>>>>>
>>>>>>>>
>>>>>>>> With these two applied, the GFXOFF re-enable requests are avoided
>>>>>>>> altogether during persistent activity on the GFX ring and simultaneous
>>>>>>>> sporadic activity on the SDMA ring.
>>>>>>>>
>>>>>>>> This has a positive effect of drastically reducing SDMA submission
>>>>>>>> latencies. For example during the Cyberpunk 2077 benchmark, they are
>>>>>>>> reduced from an average of 64us (stdev 60) to 9us (stdev 6). Or more
>>>>>>>> importantly the worst case latency, averaged to a one second window, is
>>>>>>>> reduced from 305us to 30us**.
>>>>>>>>
>>>>>>>> *) For ease of implementation we put the re-enable at the job free stage,
>>>>>>>> since doing it on actual completion is problematic in terms of locking.
>>>>>>>
>>>>>>> Absolutely clear NAK to this. Never ever base anything on the job livetime!
>>>>>>>
>>>>>>> We already had enough trouble with that.
>>>>>>>
>>>>>>>>
>>>>>>>> **) Submission latency ewma averaged (DECLARE_EWMA(latency, 6, 4)) -
>>>>>>>> Approximately 30 SDMA submissions per second, ewma average logged once
>>>>>>>> per second therefore significantly hides the worst case latency. Eg.
>>>>>>>> the real improvement in max submission latency is severely understated by
>>>>>>>> these numbers.
>>>>>>>
>>>>>>> Well that would indeed be quite nice to have.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>>> References: 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
>>>>>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 1 +
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 ++++++++
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 7 +++++++
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 2 ++
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
>>>>>>>>      7 files changed, 23 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> index 08f268dab8f5..eee40f385793 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> @@ -475,6 +475,7 @@ struct amdgpu_gfx {
>>>>>>>>         uint32_t                        compute_supported_reset;
>>>>>>>>
>>>>>>>>         /* gfx off */
>>>>>>>> +    bool                            gfx_off_held;       /* true: rings hold gfx_off */
>>>>>>>>         bool                            gfx_off_state;      /* true: enabled, false: disabled */
>>>>>>>>         struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
>>>>>>>>         uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>>>>> index 206b70acb29a..bf9bffe40235 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>>>>> @@ -191,6 +191,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>>>>>                 return r;
>>>>>>>>         }
>>>>>>>>
>>>>>>>> +    if (job && adev->gfx.gfx_off_held &&
>>>>>>>> +        (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
>>>>>>>> +         ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>>>>>> +         ring->funcs->type == AMDGPU_RING_TYPE_SDMA)) {
>>>>>>>> +            amdgpu_gfx_off_ctrl(adev, false);
>>>>>>>> +            job->gfx_off_held = true;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>         need_ctx_switch = ring->current_ctx != fence_ctx;
>>>>>>>>         if (ring->funcs->emit_pipeline_sync && job &&
>>>>>>>>             ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>>> index 2b58e353cca1..4cfd175ac6df 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>>> @@ -191,6 +191,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>>>>         if (!*job)
>>>>>>>>                 return -ENOMEM;
>>>>>>>>
>>>>>>>> +    (*job)->adev = adev;
>>>>>>>>         (*job)->vm = vm;
>>>>>>>>
>>>>>>>>         amdgpu_sync_create(&(*job)->explicit_sync);
>>>>>>>> @@ -268,6 +269,9 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>>>>>>
>>>>>>>>         amdgpu_sync_free(&job->explicit_sync);
>>>>>>>>
>>>>>>>> +    if (job->gfx_off_held)
>>>>>>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
>>>>>>>> +
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>         /* only put the hw fence if has embedded fence */
>>>>>>>>         if (!job->hw_fence.base.ops)
>>>>>>>>                 kfree(job);
>>>>>>>> @@ -301,6 +305,9 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>>>>>>         if (job->gang_submit != &job->base.s_fence->scheduled)
>>>>>>>>                 dma_fence_put(job->gang_submit);
>>>>>>>>
>>>>>>>> +    if (job->gfx_off_held)
>>>>>>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
>>>>>>>> +
>>>>>>>>         if (!job->hw_fence.base.ops)
>>>>>>>>                 kfree(job);
>>>>>>>>         else
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>>> index 2f302266662b..d4ab832ac193 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>>> @@ -46,6 +46,7 @@ enum amdgpu_ib_pool_type;
>>>>>>>>
>>>>>>>>      struct amdgpu_job {
>>>>>>>>         struct drm_sched_job    base;
>>>>>>>> +    struct amdgpu_device    *adev;
>>>>>>>>         struct amdgpu_vm        *vm;
>>>>>>>>         struct amdgpu_sync      explicit_sync;
>>>>>>>>         struct amdgpu_fence     hw_fence;
>>>>>>>> @@ -55,6 +56,7 @@ struct amdgpu_job {
>>>>>>>>         bool                    vm_needs_flush;
>>>>>>>>         bool                    gds_switch_needed;
>>>>>>>>         bool                    spm_update_needed;
>>>>>>>> +    bool                    gfx_off_held;
>>>>>>>>         uint64_t                vm_pd_addr;
>>>>>>>>         unsigned                vmid;
>>>>>>>>         unsigned                pasid;
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>> index 426834806fbf..22cac94e2f2a 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>> @@ -350,6 +350,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>>>>>>         ring->max_dw = max_dw;
>>>>>>>>         ring->hw_prio = hw_prio;
>>>>>>>>
>>>>>>>> +    if (ring->funcs->gfx_off_held)
>>>>>>>> +            adev->gfx.gfx_off_held = true;
>>>>>>>> +
>>>>>>>>         if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
>>>>>>>>                 hw_ip = ring->funcs->type;
>>>>>>>>                 num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> index 784ba2ec354c..afaf951b0b78 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> @@ -202,6 +202,7 @@ struct amdgpu_ring_funcs {
>>>>>>>>         bool                    support_64bit_ptrs;
>>>>>>>>         bool                    no_user_fence;
>>>>>>>>         bool                    secure_submission_supported;
>>>>>>>> +    bool                    gfx_off_held;
>>>>>>>>         unsigned                extra_dw;
>>>>>>>>
>>>>>>>>         /* ring read/write ptr handling */
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>>>>> index 42a25150f83a..c88de65e82bc 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>>>>> @@ -1944,6 +1944,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>>>>>>>>         .nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>>>>>>>>         .support_64bit_ptrs = true,
>>>>>>>>         .secure_submission_supported = true,
>>>>>>>> +    .gfx_off_held = true,
>>>>>>>>         .get_rptr = sdma_v5_2_ring_get_rptr,
>>>>>>>>         .get_wptr = sdma_v5_2_ring_get_wptr,
>>>>>>>>         .set_wptr = sdma_v5_2_ring_set_wptr,
>>>>>>>
>>>>>>
>>>>
>>

