Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7400BCF6A88
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 09:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94EB10E6B7;
	Thu,  8 Jan 2026 09:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Z38mXn8Q";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742A610E6B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TlPpNj5h49xZsMPQz/NPQ3NakdgVXbdRXENG2IOdTwg=; b=Z38mXn8Q4pnLsWKvzUl/etKCMj
 Mpwt6hLVcSpWgDC9TQJ2nMq+17skpnWFtkR7O6LvbI/4f5XTp9FOEUDSmeWjo0YYj+LC8x4GPG1iK
 boKv0dDMG6FY6G8rkDu1YHpReHOfdqYhq5IvM0avTYmMH6CiEmSiOQoIaCpILlYmO0fNAaPH0EUO8
 VS3gABW3qXGsEoi4cE0T23HcOfwrcAiDBY8sFX/fYzcjv/g5u/pYNrAsyaQFAN5oerfdFcCnkz97O
 YqEczFLtospNMpRwJDUtPIev0wfXlTjIjwq+2NSx8/GrZfdb9CCjJjDympPb/NMia3jCFLyKk6Ojc
 Eh4Snqhg==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vdlxu-002tjp-FM; Thu, 08 Jan 2026 10:05:58 +0100
Message-ID: <9cd26795-5ae6-4737-b829-fa90fac9ad68@igalia.com>
Date: Thu, 8 Jan 2026 09:05:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] drm/amdgpu: Remove duplicate struct member
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-7-tvrtko.ursulin@igalia.com>
 <f56064d0-ecf2-45d7-9ba2-15501454fc06@amd.com>
 <4d14863f-89af-418d-b151-0d3f97b26ebf@igalia.com>
Content-Language: en-GB
In-Reply-To: <4d14863f-89af-418d-b151-0d3f97b26ebf@igalia.com>
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


On 07/01/2026 14:46, Tvrtko Ursulin wrote:
> 
> On 07/01/2026 09:01, Christian König wrote:
>> On 12/19/25 14:41, Tvrtko Ursulin wrote:
>>> Struct amdgpu_ctx contains two copies of the pointer to the context
>>> manager. Remove one.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_ctx.c
>>> index afedea02188d..41c05358d86d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -232,7 +232,7 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>       } else {
>>>           struct amdgpu_fpriv *fpriv;
>>> -        fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, 
>>> ctx_mgr);
>>> +        fpriv = container_of(ctx->mgr, struct amdgpu_fpriv, ctx_mgr);
>>>           r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>>>                           &num_scheds, &scheds);
>>
>> Well that code is utterly nonsense to begin with. 
>> amdgpu_xcp_select_scheds() needs the xcp id to select from and not fpriv.
>>
>> Can you look into re-structuring this so that we don't need that cast?
> 
> I had a look and so far only cleanup it up visually a bit so there is 
> fewer long array subscript dereferences and confusion between sel_xcp_id 
> and priv->xcp_id.
> 
> But on a more fundamental level, since it needs to write to fpriv, the 
> caller will need to have it one way or the other, no?
> 
> And then I noticed not only the atomic_read/inc usage is dodgy, but the 
> fpriv->xcp_id assignment itself is racy. Two threads submitting to the 
> same new entity appears can end up with a refcount imbalance and 
> probably worse.
> 
> Shall I replace the ref_cnt atomic with a mutex and protect the whole 
> selection?

Or maybe there is no race?

fpriv->xcp_id is first assigned in amdgpu_driver_open_kms() and there it 
looks it can mostly fail or succeed. I say mostly because the one silent 
failure path (not failing the device open) I see if xcp->ddev would be 
NULL. I am not sure if/when that can happen? If it can happen and that 
is the reason ctx init needs to retry the xcp_id selection? In which 
case it is racy.

Regards,

Tvrtko

> 
> Regards,
> 
> Tvrtko
> 
>>>           if (r)
>>> @@ -349,7 +349,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr 
>>> *mgr, int32_t priority,
>>>       else
>>>           ctx->stable_pstate = current_stable_pstate;
>>> -    ctx->ctx_mgr = &(fpriv->ctx_mgr);
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_ctx.h
>>> index aed758d0acaa..cf8d700a22fe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -56,7 +56,6 @@ struct amdgpu_ctx {
>>>       unsigned long            ras_counter_ce;
>>>       unsigned long            ras_counter_ue;
>>>       struct amdgpu_ctx_mgr        *mgr;
>>> -    struct amdgpu_ctx_mgr        *ctx_mgr;
>>>       struct amdgpu_ctx_entity    *entities[AMDGPU_HW_IP_NUM] 
>>> [AMDGPU_MAX_ENTITY_NUM];
>>>   };
>>
> 

