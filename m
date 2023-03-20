Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F634C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 16:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F9410E5E7;
	Mon, 20 Mar 2023 16:05:02 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2482D10E5EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 16:05:00 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id t15so10871356wrz.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679328298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXI8Beo9ebuwNRbT+jiQTlLo7R04yMynx8D7LMv/fPQ=;
 b=OQT5m1tL6VdC4MceFIOzjPigXdZHqBLtHpJVbJle9hYYyJwNkm4t9/r21ax08vu0rO
 SoLePHWhphmiZYaDJhUehWmP4CEs1crMe4aUalE3mbzyUXYVzpI4bdH92EvPeIxv1uET
 UYbK4ZIMTTysEK1vbw3rL//6YQg7Lyyi11BqxZYR9roYBdQo6mM6JFG5bkXNwOYqLI3A
 9SjCUgSjXHbR93p/H7wuR1+r/lKqscSFFvPeUQ7lNlsJad+Z9JB1bG1TbsYDmWnAdfZ4
 YNX2+BFPDQVqNgtjXa9Q//B+nIc8HrrWphGZbfGzaJ6g/UTy5OaokL4Fbj1Otme56EhA
 nA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679328298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXI8Beo9ebuwNRbT+jiQTlLo7R04yMynx8D7LMv/fPQ=;
 b=xDKeU4q3HmCRAwqzrp3d2MLei9fqfI73AwLCnVvhOlAbNs++bT7PiVNqpAzUl5diOL
 CWDTePAyzgkaY09hvhubb+FELO1w0o1WL0oy4GeZm89H5YmN2jHxtA+gMjed6fQj6Qr4
 Mdysffm9TxjwN7vzrgqWnhK9fiI/xZ4yOqobZKWOyyu6WbdvK/okt1N52SJ4nf0TUza9
 y7hkf1xPQSRXtMwdpvO8+7oL4EA+xiRKZ4CY9LhKrCx3V1FpHcs7Dt4+fuUNscjstdqg
 fWPp8uzbDbq9Cv31anCyqjlTvqAFpZObE6MKk79VGySElLv/iQHMXstItYYP/VnjEz5+
 FX5Q==
X-Gm-Message-State: AO0yUKW4ql1odk824NYm7J8Q/uvr8puO/6H5T6iBHU4SGH+WnmRRi2c3
 9Y+DpIWrBGnwunPgsjRRq61gASeyhq4=
X-Google-Smtp-Source: AK7set8XqH5ANDvyTiWbRNm81bnXLwMCsXpK8LXEwrKtB6MRFmd/1bYorW6nRcYFIpCI5nR4jOBcGg==
X-Received: by 2002:a5d:6b11:0:b0:2ce:a65e:817f with SMTP id
 v17-20020a5d6b11000000b002cea65e817fmr44986wrw.25.1679328298511; 
 Mon, 20 Mar 2023 09:04:58 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fae3:596:f1a7:6853?
 ([2a02:908:1256:79a0:fae3:596:f1a7:6853])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b002d1bfe3269esm9232541wro.59.2023.03.20.09.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Mar 2023 09:04:58 -0700 (PDT)
Message-ID: <27a14c40-3208-535d-8ad9-e20ab70d4da5@gmail.com>
Date: Mon, 20 Mar 2023 17:04:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] drm/amdgpu: add gfx shadow CS IOCTL support
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-4-alexander.deucher@amd.com>
 <a1b61e2f-d69c-4401-b9d5-46c80c14ae15@amd.com>
 <CADnq5_NenjAzNtjw_LFRQM96j3jXYTRi7MBFOr767v=PVSW+BA@mail.gmail.com>
 <0bb546d2-e208-2250-2eeb-797e8486ef89@amd.com>
 <CADnq5_NPdkg_69LjC7NrGk8OgeAceVo6O2oRtzmgZm-GXXSRUQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NPdkg_69LjC7NrGk8OgeAceVo6O2oRtzmgZm-GXXSRUQ@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.03.23 um 17:01 schrieb Alex Deucher:
> On Mon, Mar 20, 2023 at 11:55 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 20.03.23 um 16:49 schrieb Alex Deucher:
>>> On Mon, Mar 20, 2023 at 11:46 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>> Am 17.03.23 um 18:17 schrieb Alex Deucher:
>>>>> From: Christian König <christian.koenig@amd.com>
>>>>>
>>>>> Add support for submitting the shadow update packet
>>>>> when submitting an IB.  Needed for MCBP on GFX11.
>>>>>
>>>>> v2: update API for CSA (Alex)
>>>>> v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
>>>>>        Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
>>>>>        amdgpu_cs_pass1()
>>>>>        Only initialize shadow on first use
>>>>>        (Alex)
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 24 ++++++++++++++++++++++++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  4 ++++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++++++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>>>>>     5 files changed, 37 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> index f6144b378617..9bdda246b09c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> @@ -280,6 +280,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>>>>                 case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>>>>>                 case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
>>>>>                 case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>>>>> +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>>>>>                         break;
>>>>>
>>>>>                 default:
>>>>> @@ -587,6 +588,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> +static void amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
>>>>> +                             struct amdgpu_cs_chunk *chunk)
>>>>> +{
>>>>> +     struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
>>>>> +     bool shadow_initialized = false;
>>>>> +     int i;
>>>>> +
>>>>> +     for (i = 0; i < p->gang_size; ++i) {
>>>>> +             p->jobs[i]->shadow_va = shadow->shadow_va;
>>>>> +             p->jobs[i]->csa_va = shadow->csa_va;
>>>>> +             p->jobs[i]->gds_va = shadow->gds_va;
>>>> Do we really need all three VAs separately?
>>>>
>>>>> +             if (!p->ctx->shadow_initialized) {
>>>>> +                     p->jobs[i]->init_shadow = true;
>>>>> +                     shadow_initialized = true;
>>>>> +             }
>>>>> +     }
>>>>> +     if (shadow_initialized)
>>>>> +             p->ctx->shadow_initialized = true;
>>>> This is a really bad idea since the IOCTL can be interrupted later on.
>>>>
>>>> Why do we need that?
>>> Yes.  We have to only initial the buffer the first time it's used.
>>> Doing it again will overwrite whatever userspace has done with it
>>> since then.
>> I don't get what you mean with that? This here doesn't make any sense at
>> all.
>>
>> The shadow buffer addresses must be given with every CS and updated over
>> and over again. Otherwise this solution won't work correctly.
> The shadow replaces the old SET/LOAD model.  When the UMD uses the
> shadow buffer, they no longer have to send all of their state anymore
> in the IB.  The CP FW will automatically load whatever was saved when
> it processes this packet.  However, the shadow needs to be initialized
> by the CP FW the first time it is used.  All subsequent times, it will
> just be a save/restore by the FW.  I guess the alternative would be
> for the UMD to specify if it wants initialization or not, but tracking
> it in the kernel aligns better with the user mode queue model where
> this is handled by the MQD and is initialized the first time the queue
> is loaded.

This approach is just utterly nonsense.

The problem is that neither the kernel nor the fw can know if that's the 
first submission. Only the UMD can know that.

That's the same issue we previously had with PAL and the old model which 
didn't worked at all.

Christian.

>
> Alex
>
>> Christian.
>>
>>> Alex
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>> +}
>>>>> +
>>>>>     static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>>>>>     {
>>>>>         unsigned int ce_preempt = 0, de_preempt = 0;
>>>>> @@ -629,6 +650,9 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>>>>>                         if (r)
>>>>>                                 return r;
>>>>>                         break;
>>>>> +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>>>>> +                     amdgpu_cs_p2_shadow(p, chunk);
>>>>> +                     break;
>>>>>                 }
>>>>>         }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>> index 0fa0e56daf67..909d188c41f2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>>>>         unsigned long                   ras_counter_ce;
>>>>>         unsigned long                   ras_counter_ue;
>>>>>         uint32_t                        stable_pstate;
>>>>> +     bool                            shadow_initialized;
>>>>>     };
>>>>>
>>>>>     struct amdgpu_ctx_mgr {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> index bcccc348dbe2..d88964b9407f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> @@ -212,6 +212,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>>>>         }
>>>>>
>>>>>         amdgpu_ring_ib_begin(ring);
>>>>> +
>>>>> +     if (job && ring->funcs->emit_gfx_shadow)
>>>>> +             amdgpu_ring_emit_gfx_shadow(ring, job);
>>>>> +
>>>>>         if (job && ring->funcs->init_cond_exec)
>>>>>                 patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> index 9790def34815..b470808fa40e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> @@ -68,6 +68,12 @@ struct amdgpu_job {
>>>>>         uint64_t                uf_addr;
>>>>>         uint64_t                uf_sequence;
>>>>>
>>>>> +     /* virtual addresses for shadow/GDS/CSA */
>>>>> +     uint64_t                shadow_va;
>>>>> +     uint64_t                csa_va;
>>>>> +     uint64_t                gds_va;
>>>>> +     bool                    init_shadow;
>>>>> +
>>>>>         /* job_run_counter >= 1 means a resubmit job */
>>>>>         uint32_t                job_run_counter;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index 3989e755a5b4..8643d4a92c27 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -212,6 +212,7 @@ struct amdgpu_ring_funcs {
>>>>>         void (*end_use)(struct amdgpu_ring *ring);
>>>>>         void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>>>>>         void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
>>>>> +     void (*emit_gfx_shadow)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>>>>>         void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
>>>>>                           uint32_t reg_val_offs);
>>>>>         void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>>>>> @@ -307,6 +308,7 @@ struct amdgpu_ring {
>>>>>     #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>>>>>     #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>>>>>     #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
>>>>> +#define amdgpu_ring_emit_gfx_shadow(r, j) (r)->funcs->emit_gfx_shadow((r), (j))
>>>>>     #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
>>>>>     #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>>>>>     #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))

