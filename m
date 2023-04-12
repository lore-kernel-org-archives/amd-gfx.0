Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2BC7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 14:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B0710E814;
	Wed, 12 Apr 2023 14:12:03 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A61710E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 14:12:01 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id j1so15052249wrb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681308719; x=1683900719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ptZR3bMJ9/PzGgqPrw3Jl+HR2DBTJ/21n1IiBsgEDs0=;
 b=JqDe2h/W4kiKT4QSq6TeiqNrK6LQsd7FdJl8IhnhjlkcxI/62qS/04Xuv/wqTZs4DM
 i1ZEw9OCXEmbQRFC4AZkZ514Weov8s9UmGp8rWic2lz9ZO2htHfAcXtDXv3SpoRJComL
 XPAmVo31lbA55QcIlauNnWbFQRRNpu1k9Fu3tXf7KMfKquL+hgQzqfgMBVSdiniiu14w
 gUaWxe4xnhrE614eWhICy4XJAWApP/wL+wt1mnEjHJbROqPVO5HbonZqdCks8J6tjR0R
 wbHV4bUydTiwyJrlwarkdVZhWM99PyRGJiXlIzVonrI0M3Ucc3DxTrfOT0zEenrCfc5q
 0Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681308719; x=1683900719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ptZR3bMJ9/PzGgqPrw3Jl+HR2DBTJ/21n1IiBsgEDs0=;
 b=6keBVa4P+y7OKDx9Es6VGx8j7kohcteoAtC5MwZvPTk0ZIP/vRcqTop5Smv8Qo0yab
 QN8p4yDjmY3pGDWm+Kxy1yCt8vqrTqvJJmPJGCowvE/+lqIj9EC4XkwGXjw4R1wsAYZa
 kglg0e99eYiWYVbn+lXx8X9HCZhC6/p+a2AfSGF8cowhQtRapc6O+2EguUMWFXxE+Pp6
 LILoIv03oNRHemBDbGba1WA1e/x/ZE0Ym2MCoaPMmcDeqpnXYBeMKOeq6jsyzwEXEkqS
 20T4fkeb3vgTFUsvmI0WNKVHq7MWTbyaABC2Ibl2zqFz49EnHbshGOOtnGj6xvkg9IkG
 sqcw==
X-Gm-Message-State: AAQBX9d5/Gcc0mQJGCWS164SRbtLmw/VpT7U4g6WqEkvBwJCkI2o3Qrb
 WT35cewQ3nQOPUxBG34Gjz0=
X-Google-Smtp-Source: AKy350bWAAILW1pV6dxnpXfYHmzsynqZIYfNYdMgG4GjSIY2BajZFbz/fDK9SH8DVjZ8iyQXaAsYrA==
X-Received: by 2002:a05:6000:10cb:b0:2ef:ac43:2f with SMTP id
 b11-20020a05600010cb00b002efac43002fmr8747577wrx.62.1681308718899; 
 Wed, 12 Apr 2023 07:11:58 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fe02:9bb5:5deb:be0e?
 ([2a02:908:1256:79a0:fe02:9bb5:5deb:be0e])
 by smtp.gmail.com with ESMTPSA id
 z14-20020adfd0ce000000b002c55306f6edsm17258901wrh.54.2023.04.12.07.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Apr 2023 07:11:58 -0700 (PDT)
Message-ID: <f653f458-c891-afda-f31d-c54e85e4656d@gmail.com>
Date: Wed, 12 Apr 2023 16:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add a max ibs per submission limit.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
 <4365dd57-f61d-9d19-79c8-697f0554fa26@gmail.com>
 <CAP+8YyELApwVc06d29P4hRETdXJoXo2M_GqiKhsPie-MLsAe_Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAP+8YyELApwVc06d29P4hRETdXJoXo2M_GqiKhsPie-MLsAe_Q@mail.gmail.com>
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 14:50 schrieb Bas Nieuwenhuizen:
> On Wed, Apr 12, 2023 at 2:46 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 12.04.23 um 14:18 schrieb Bas Nieuwenhuizen:
>>> And ensure each ring supports that many submissions. This makes
>>> sure that we don't get surprises after the submission has been
>>> scheduled where the ring allocation actually gets rejected.
>>>
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
>>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 ++++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>>>    3 files changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index 7af3041ccd0e..8362738974c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>>>        if (r < 0)
>>>                return r;
>>>
>>> +     if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
>>> +             return -EINVAL;
>>> +
>>>        ++(num_ibs[r]);
>>>        p->gang_leader_idx = r;
>>>        return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index dc474b809604..abd70d2f26f6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -49,6 +49,25 @@
>>>     * them until the pointers are equal again.
>>>     */
>>>
>>> +/**
>>> + * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
>>> + *
>>> + * @type: ring type for which to return the limit.
>>> + */
>>> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>>> +{
>>> +     switch (type) {
>>> +     case AMDGPU_RING_TYPE_GFX:
>>> +     case AMDGPU_RING_TYPE_COMPUTE:
>>> +             /* gfx/compute are often used more extensively and radv
>>> +              * has historically assumed the limit was 192.
>>> +              */
>>> +             return 192;
>>> +     default:
>>> +             return 50;
>>> +     }
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_ring_alloc - allocate space on the ring buffer
>>>     *
>>> @@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>        int sched_hw_submission = amdgpu_sched_hw_submission;
>>>        u32 *num_sched;
>>>        u32 hw_ip;
>>> +     unsigned int max_ibs_dw;
>>>
>>>        /* Set the hw submission limit higher for KIQ because
>>>         * it's used for a number of gfx/compute tasks by both
>>> @@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>                return r;
>>>        }
>>>
>>> +     max_ibs_dw = ring->funcs->emit_frame_size +
>>> +                  amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
>>> +     max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
>>> +     max_dw = max(max_dw, max_ibs_dw);
>> I think something like "if (WARN_ON(max_ibs_dw > max_dw) max_dw =
>> max_ibs_dw;" would be more appropriate.
> I really like it this way because it automatically does the right
> thing. In comparison it is difficult getting the test matrix together
> for a WARN_ON on something that differs every generation, and I don't
> know what we'd gain from doing it that way?

Especially the older hw generations are quite limited in the size of the 
ring buffer.

For example we had to split page table updates into smaller submissions 
(and later moved it into IBs) because the SDMA couldn't handle a large 
ring buffer (the limit was just 1MiB or something like that IIRC).

I want to avoid that we unintentionally increase the submission limit to 
more than some hw generation can do.

Regards,
Christian.

>
>
>> Apart from that this looks really good to me,
>> Christian.
>>
>>> +
>>>        ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
>>>
>>>        ring->buf_mask = (ring->ring_size / 4) - 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 3989e755a5b4..e6e672727529 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -317,6 +317,7 @@ struct amdgpu_ring {
>>>    #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
>>>    #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>>>
>>> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>>>    int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>>    void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
>>>    void amdgpu_ring_ib_end(struct amdgpu_ring *ring);

