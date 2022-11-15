Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE69C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 14:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F3410E400;
	Tue, 15 Nov 2022 14:11:58 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CED10E402
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 14:11:54 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id v1so24452610wrt.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OGldzvQQE8WUf1KzNW1/0buYZ7aDJpWHwegwzYDyWJA=;
 b=cSnmuJ9xcDMb2Zft9F7ijlnE5QB001MWJ8xixNWAfXu/CdHTtQoz2bgCnrSrFYu+Md
 IyldaD514uoPiNSTPMx+gG9xwbY4yR9W1qYp8+SjqttYZyfPeRygzOWpzDyH1Ztt84YO
 kY7qOAaUg9oTgcOKZSvjjr+wOSkKyqPR/rucwrqSitT9wZ1PcmdKQNSkDXSTe07OdYcG
 Vf7ECOwDdc7YsEPFTD9khud+DvWIxH20k2r69dCr4t0rQCfEH+5uCICVDr48peFV7IAM
 Zmim1MdsD4KAx+FFAw+rDRw8PZfViLON66S35u7KSMTciVRFYrUujL8EyLVjZPk7YcLN
 EhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGldzvQQE8WUf1KzNW1/0buYZ7aDJpWHwegwzYDyWJA=;
 b=09hn4anGetarjC/hYI13HVvYuwVuHmnuFmrNCJrP6gtDG9WbadgE5mohIlB+yvKmqC
 P+L5wmyao77AJhq5+BfWMOkV8HPVStym46/kgpm9t6NTTtq1SXPPARpRIV94DA9BkCSH
 g6NJrEutexi7eKoxdtqBM+LUJgUoNPf+NJ6UJu50QON1vzPkOZcsYHszzIaGx1FlU7D2
 teMnQjkKHhhE6SrKmZH0nJqCjaCt5c9fjin3P6xPuhEuZABUxrXL+XMcLF4Y0zwPxS8S
 cgPt6OMjQ+YHasgOsHPsmAdfnGGhSoCMdS4TXXozdyEnmknS6i0hxmiftygyxmLJOdhm
 wsUQ==
X-Gm-Message-State: ANoB5plaZmKsngmLQ2q+tZL3DzQ+W7l3faJCfAxpdBPYAWubyHFvAqCw
 BcPOCTpOw3UUfqjbtpFBU2Y=
X-Google-Smtp-Source: AA0mqf61x1OoKo7bf3GEkctjW6H9eevWR9qWTPwI7qxCkpggC9A4lRG7WsPEQJoG9TeQSGnRVJLejA==
X-Received: by 2002:a05:6000:10c4:b0:236:5c22:216c with SMTP id
 b4-20020a05600010c400b002365c22216cmr11181811wrx.696.1668521513230; 
 Tue, 15 Nov 2022 06:11:53 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:2207:38ee:dfc8:db04?
 ([2a02:908:1256:79a0:2207:38ee:dfc8:db04])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a7bce8a000000b003c6bd12ac27sm15362778wmj.37.2022.11.15.06.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Nov 2022 06:11:52 -0800 (PST)
Message-ID: <68896add-08ce-9f99-619a-b8b9345ce0fe@gmail.com>
Date: Tue, 15 Nov 2022 15:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: use the last IB as gang leader v2
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20221115094206.6181-1-christian.koenig@amd.com>
 <fc7e683f-4983-8adb-b8ed-3c756e179ef8@amd.com>
 <CADnq5_PXG=A4DUhfhnTAoZkCGnOKNm5oFrmZG-0vaxgbXz362w@mail.gmail.com>
 <CADnq5_MDYLpvxUeRpASp9gk4wuthot3RwkckQCny5fKEE_X2Pg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MDYLpvxUeRpASp9gk4wuthot3RwkckQCny5fKEE_X2Pg@mail.gmail.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I wanted to push this directly to drm-misc-fixes.

But going to add one in case someone tries to backport the gang submit 
changes.

Regards,
Christian.

Am 15.11.22 um 15:10 schrieb Alex Deucher:
> Would be good to add a Fixes tag.
>
> Alex
>
> On Tue, Nov 15, 2022 at 9:09 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> On Tue, Nov 15, 2022 at 4:44 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>> Am 15.11.22 um 10:42 schrieb Christian König:
>>>> It turned out that not the last IB specified is the gang leader,
>>>> but instead the last job allocated.
>>>>
>>>> This is a bit unfortunate and not very intuitive for the CS
>>>> interface, so try to fix this.
>>> Alex could you take a look at this? I would really like to get this into
>>> the next -rc.
>>>
>>> Thanks,
>>> Christian.
>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++++++++++++++-------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
>>>>    2 files changed, 17 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index 1bbd39b3b0fc..fbdf139cf497 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -109,6 +109,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>>>>                return r;
>>>>
>>>>        ++(num_ibs[r]);
>>>> +     p->gang_leader_idx = r;
>>>>        return 0;
>>>>    }
>>>>
>>>> @@ -300,7 +301,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>>>                if (ret)
>>>>                        goto free_all_kdata;
>>>>        }
>>>> -     p->gang_leader = p->jobs[p->gang_size - 1];
>>>> +     p->gang_leader = p->jobs[p->gang_leader_idx];
>>>>
>>>>        if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
>>>>                ret = -ECANCELED;
>>>> @@ -1194,16 +1195,18 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>>>>                        return r;
>>>>        }
>>>>
>>>> -     for (i = 0; i < p->gang_size - 1; ++i) {
>>>> +     for (i = 0; i < p->gang_size; ++i) {
>>>> +             if (p->jobs[i] == leader)
>>>> +                     continue;
>>>> +
>>>>                r = amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
>>>>                if (r)
>>>>                        return r;
>>>>        }
>>>>
>>>> -     r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
>>>> +     r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
>>>>        if (r && r != -ERESTARTSYS)
>>>>                DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
>>>> -
>>>>        return r;
>>>>    }
>>>>
>>>> @@ -1237,9 +1240,12 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>>>>        for (i = 0; i < p->gang_size; ++i)
>>>>                drm_sched_job_arm(&p->jobs[i]->base);
>>>>
>>>> -     for (i = 0; i < (p->gang_size - 1); ++i) {
>>>> +     for (i = 0; i < p->gang_size; ++i) {
>>>>                struct dma_fence *fence;
>>>>
>>>> +             if (p->jobs[i] == leader)
>>>> +                     continue;
>>>> +
>>>>                fence = &p->jobs[i]->base.s_fence->scheduled;
>>>>                r = amdgpu_sync_fence(&leader->sync, fence);
>>>>                if (r)
>>>> @@ -1275,7 +1281,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>>>>        list_for_each_entry(e, &p->validated, tv.head) {
>>>>
>>>>                /* Everybody except for the gang leader uses READ */
>>>> -             for (i = 0; i < (p->gang_size - 1); ++i) {
>>>> +             for (i = 0; i < p->gang_size; ++i) {
>>>> +                     if (p->jobs[i] == leader)
>>>> +                             continue;
>>>> +
>>>>                        dma_resv_add_fence(e->tv.bo->base.resv,
>>>>                                           &p->jobs[i]->base.s_fence->finished,
>>>>                                           DMA_RESV_USAGE_READ);
>>>> @@ -1285,7 +1294,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>>>>                e->tv.num_shared = 0;
>>>>        }
>>>>
>>>> -     seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1],
>>>> +     seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
>>>>                                   p->fence);
>>>>        amdgpu_cs_post_dependencies(p);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>>>> index cbaa19b2b8a3..f80adf9069ec 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>>>> @@ -54,6 +54,7 @@ struct amdgpu_cs_parser {
>>>>
>>>>        /* scheduler job objects */
>>>>        unsigned int            gang_size;
>>>> +     unsigned int            gang_leader_idx;
>>>>        struct drm_sched_entity *entities[AMDGPU_CS_GANG_SIZE];
>>>>        struct amdgpu_job       *jobs[AMDGPU_CS_GANG_SIZE];
>>>>        struct amdgpu_job       *gang_leader;

