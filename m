Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53224C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 13:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF26B11216A;
	Wed,  8 Jun 2022 13:47:41 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739C0112165
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 13:47:40 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id w27so27126556edl.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jun 2022 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=NtOWkip4vPtoLditIPmPtytdAsN/0IJJQDaSY/il/mQ=;
 b=LiYgXBW5gTopBb8p0qEkME/ERa5QRliqIdUbUc24k0D5pp5Bje3ogUaLr3q5Z6wDuy
 X96HHqVziOQINUv3SmNWKVvnWE284OtoSP06ZANxInQx8qKalcN5s5AV8d4HvsDAyIHB
 m8UTKnHVuMPwEOFvzEdOxNZjZZ9IqLyslir5MeAAsn5Ga/A4KrPElmvmGqTWvDT8A2BR
 hWhnqEeONeJENxkeFR39z4TkPrc5rp/fbKY8+qGllPNzUk6SBKzaCOONHgjhZjFkn80j
 FR2IaUfdJi8AZgYFudx/hhteuxqwOoubiwswZFIiLsvn9l31NL5QE4eY/r6G3tbYN8cU
 k78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NtOWkip4vPtoLditIPmPtytdAsN/0IJJQDaSY/il/mQ=;
 b=ycCWEqsKLo6PxQ1/Za55cVJQmW51DqjytPA/lxdlp9DAhuwdeM0qTZx+G9krIaxFyK
 YXQ5ykAN0p9dDaBNkRMdp4yfDpgit/Ju4zbfmSfKrZ+MGyZU0bLv0hF1eDctDBUNFbNI
 of0FInu9Alhz4v8DSKm2GsWCxu2gnvyhkstuzxvszgxCBiJjbwM/10hLTbKE9nX3/F5G
 UOLgDc/OpTkyD7Yr0zS+oG5PA8bz3UdMTYHusz2zeoR7FrvEDhqVe1j+ngPcPf6qUlk+
 cMSWqrvwFM6s+J6ehZmodNr4h3gMsIyDyT1kX/i9h3GJ+f5ScYcu4SCCkVA8UXZGSYXL
 XsGw==
X-Gm-Message-State: AOAM533e9qvV8+paBRIcqL2EvKR6wwnP4W71V7Ay7hNQGQK7/kBuwgd2
 2ue8wzErbKQkxHoGD6bBmU4=
X-Google-Smtp-Source: ABdhPJzrW7L86su5clLSIc1y6NvBcF0RY1o/Nbo8ZSqOZ+sBnTGF8KLG1nboH4zVRvzLzuNvNM2bzQ==
X-Received: by 2002:a05:6402:4145:b0:42d:842a:f916 with SMTP id
 x5-20020a056402414500b0042d842af916mr38978505eda.357.1654696058876; 
 Wed, 08 Jun 2022 06:47:38 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:2f36:54a0:e1ea:c1ad?
 ([2a02:908:1256:79a0:2f36:54a0:e1ea:c1ad])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a056402414b00b0043158c608e4sm5622048eda.27.2022.06.08.06.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 06:47:38 -0700 (PDT)
Message-ID: <04afbaac-8c8f-3b8a-6e76-036043d07cfa@gmail.com>
Date: Wed, 8 Jun 2022 15:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Dong, Ruijing"
 <Ruijing.Dong@amd.com>
References: <20220603102106.149508-1-christian.koenig@amd.com>
 <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
 <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
 <CADnq5_NS49jdkQuXK58CdfShNW9j1q4HwXtBZtqJ2m3MACD8uA@mail.gmail.com>
 <CADnq5_OEsnjhmp_g0zXjNjAfv=0uN2jq79wTMtxnae_OYjUEjw@mail.gmail.com>
 <CH2PR12MB3927CE81E4A14A41359DC1FB95A59@CH2PR12MB3927.namprd12.prod.outlook.com>
 <CADnq5_Pq8M4AgjtwknyKmb1p8RqFYuxYb0b2B2-tpiVTqqWKDA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_Pq8M4AgjtwknyKmb1p8RqFYuxYb0b2B2-tpiVTqqWKDA@mail.gmail.com>
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
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I need to look into this more deeply when I'm back from sick leave.

Till then this workaround should be sufficient since VCN3 is the only 
callback which tries to adjust the instance.

Regards,
Christian.

Am 07.06.22 um 22:22 schrieb Alex Deucher:
> We'll need to implement the parse callbacks for vcn4 as well if we
> haven't already.
>
> Alex
>
> On Tue, Jun 7, 2022 at 4:20 PM Dong, Ruijing <Ruijing.Dong@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> I can see for VCN4, AV1 dec/enc also need to limit to the first instance.
>>
>> Thanks,
>> Ruijing
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
>> Sent: Friday, June 3, 2022 10:12 AM
>> To: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Cc: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
>>
>> Do the other uvd/vce/vcn ring parse functions need a similar fix?
>>
>> Alex
>>
>>
>> On Fri, Jun 3, 2022 at 10:08 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> On Fri, Jun 3, 2022 at 8:10 AM Christian König
>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> Am 03.06.22 um 14:08 schrieb Pierre-Eric Pelloux-Prayer:
>>>>> Hi Christian,
>>>>>
>>>>> The patch is: Tested-by: Pierre-Eric Pelloux-Prayer
>>>>> <pierre-eric.pelloux-prayer@amd.com>
>>>>>
>>>>> Could you add a reference to https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2037&amp;data=05%7C01%7CRuijing.Dong%40amd.com%7C5ba73dfe91ba47e21dd608da456b0609%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637898623221806051%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WgIZD299Xe0XVG%2Ftb2rn14njS%2FgHIhtIHIDAZ2Fj40k%3D&amp;reserved=0 in the commit message?
>>>> Sure, can you also give me an rb or acked-by so that I can push it?
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>>> Thanks,
>>>>> Pierre-Eric
>>>>>
>>>>> On 03/06/2022 12:21, Christian König wrote:
>>>>>> The job is not yet initialized here.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures
>>>>>> directly in CS parsers")
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
>>>>>>    1 file changed, 7 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>>>> index 3cabceee5f57..39405f0db824 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>>>> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>>>>>>       .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>>>>    };
>>>>>>
>>>>>> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
>>>>>> -                            struct amdgpu_job *job)
>>>>>> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
>>>>>>    {
>>>>>>       struct drm_gpu_scheduler **scheds;
>>>>>>
>>>>>>       /* The create msg must be in the first IB submitted */
>>>>>> -    if (atomic_read(&job->base.entity->fence_seq))
>>>>>> +    if (atomic_read(&p->entity->fence_seq))
>>>>>>               return -EINVAL;
>>>>>>
>>>>>>       scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
>>>>>>               [AMDGPU_RING_PRIO_DEFAULT].sched;
>>>>>> -    drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
>>>>>> +    drm_sched_entity_modify_sched(p->entity, scheds, 1);
>>>>>>       return 0;
>>>>>>    }
>>>>>>
>>>>>> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>>>>>> -                        uint64_t addr)
>>>>>> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t
>>>>>> +addr)
>>>>>>    {
>>>>>>       struct ttm_operation_ctx ctx = { false, false };
>>>>>>       struct amdgpu_bo_va_mapping *map; @@ -1848,7 +1846,7 @@
>>>>>> static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>>>>>>               if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
>>>>>>                       continue;
>>>>>>
>>>>>> -            r = vcn_v3_0_limit_sched(p, job);
>>>>>> +            r = vcn_v3_0_limit_sched(p);
>>>>>>               if (r)
>>>>>>                       goto out;
>>>>>>       }
>>>>>> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>>>>                                          struct amdgpu_job *job,
>>>>>>                                          struct amdgpu_ib *ib)
>>>>>>    {
>>>>>> -    struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>>>>>> +    struct amdgpu_ring *ring =
>>>>>> + to_amdgpu_ring(p->entity->rq->sched);
>>>>>>       uint32_t msg_lo = 0, msg_hi = 0;
>>>>>>       unsigned i;
>>>>>>       int r;
>>>>>> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>>>>                       msg_hi = val;
>>>>>>               } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
>>>>>>                          val == 0) {
>>>>>> -                    r = vcn_v3_0_dec_msg(p, job,
>>>>>> -                                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>> +                    r = vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32
>>>>>> + | msg_lo);
>>>>>>                       if (r)
>>>>>>                               return r;
>>>>>>               }
>>>>>>

