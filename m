Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C91C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 11:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131CB10E72D;
	Thu, 21 Mar 2024 11:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="r+MO07Uh";
	dkim-atps=neutral
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E48710E717
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 11:18:05 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-41477211086so1551405e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1711019883; x=1711624683;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=urwSnpyMI06YjTDMhum08BK2i3aSLYqWZOF9qoWhgTI=;
 b=r+MO07Uh81Vy79O7WesRb/PU5zHGXuvOpxb2PAsD5ZpxvZMYw19/wi+OTcT9B0b1xO
 BXND81SfaA4ReC8EZzukIIwbGRspXUHeY8RVc5UiwjWsPhLwoSWK+HQy2XN7a9Hx3y96
 bcz6IjC6TVyJfFJQl1jxHsZia1y3pTptdzuWZ9rw8WvNJLdwPLo9ipaFYOIYClYfVUvv
 nnDiGE3VLFpNSe01y2czBSYTAGh8i3G4smfO+V8fW+VUcibIbqI0kqVvt5k2RGlRZwLA
 Ndg4jKzQUgawWPXuzZryPNe8z/FuJ12D+9fz+tdYOg1SC3qqkoeZ/Jt+AoChWs3CMuOw
 Dprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711019883; x=1711624683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=urwSnpyMI06YjTDMhum08BK2i3aSLYqWZOF9qoWhgTI=;
 b=PLas3tDEfu/xyIN3V55jiLobfkbirTEAHp500JVXIVsiO59tg6kvGeHianvI0ACpyq
 u0NHa31HBadx3uh4eF7FRGsPs9XhZjJlk6V9FNEFEkweY01oY18Oo2CpTG9Pbm5Lhy4Q
 FSOwCiQFg5Tu7937ILtzI1nfPvT+AqktGjoA65SsGQCj/Swa1qZG9sWSRcjbQ86TIKuP
 jC326/59dLDGlBBvjqAOjhs/fL4pAJEfYCLHCfYVUVybNf1T21HZW/ZbhV2q9SLPPA1z
 6jNwcjDynG+LtS8YLdtR2rq1cYvdr347fTP1a1ZW/6UrirPmlcQwJHcXCnXrsUaC9RYh
 N92g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8iuSdZ2Rm44VXmmAKw6IpmJ/3XPyVR9D2ZJqH+4/mbwEeG0SPOo4EnaJlOeFhcyhI/xt9H0qcdBvQ9HLiYaA+83qU9s9dByfnhigNAA==
X-Gm-Message-State: AOJu0YwwpI8mkXpBueneAmMMtO/iMFRiOhdi3vB/+P17/9DkDEyjP+cM
 EYKHB7DsoOChFC1Rtzr74+Ski1qDFCd3xLjOADuGEKdI02O7PaZ74IojinrUhuA=
X-Google-Smtp-Source: AGHT+IEUz/602yeMz9nxEfUU37VHJjcinGb2NoUg6TpDKenAEpq/+NnL4+LcBE15pX9XfJDnzOeDgg==
X-Received: by 2002:a05:600c:5713:b0:413:2ab7:4396 with SMTP id
 jv19-20020a05600c571300b004132ab74396mr1507109wmb.18.1711019883422; 
 Thu, 21 Mar 2024 04:18:03 -0700 (PDT)
Received: from [192.168.0.101] ([84.65.0.132])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c314d00b004146d736fcdsm4719443wmo.36.2024.03.21.04.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 04:18:03 -0700 (PDT)
Message-ID: <a949469e-6f80-475d-9da9-8f1351aafeae@ursulin.net>
Date: Thu, 21 Mar 2024 11:18:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix use after free in trace_amdgpu_bo_move
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Beyond Wang <Wang.Beyond@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20240320144038.46706-1-tursulin@igalia.com>
 <20240320171216.48248-1-tursulin@igalia.com>
 <9520bc6f-669e-4724-8fd3-3bf8c36bdcb0@amd.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <9520bc6f-669e-4724-8fd3-3bf8c36bdcb0@amd.com>
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


Hi Christian,

On 21/03/2024 10:25, Christian König wrote:
> Am 20.03.24 um 18:12 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tursulin@ursulin.net>
>>
>> Pipelined object migration will free up the old bo->resource, meaning
>> the tracepoint added in 94aeb4117343 ("drm/amdgpu: fix ftrace event
>> amdgpu_bo_move always move on same heap") will trigger an use after free
>> when it dereferences the cached old_mem.
>>
>> Fix it by caching the memory type locally, which is the only thing
>> tracepoint wants to know about.
>>
>> While at it convert the whole function to use the cached memory types for
>> consistency.
>>
>> v2:
>>   * Fix compilation.
> 
> I do remember that we have fixed this before. Question is really why it 
> shows up again.
> 
> Going to investigate.

If it helps, and if I did not mistrace something, this is the call trace 
I saw with use after free:

ttm_mem_evict_first
   ttm_bo_handle_move_mem
     amdgpu_move (via bdev->funcs->move)
       amdgpu_move_blit
   	ttm_bo_move_accel_cleanup
	  ttm_bo_move_pipeline_evict
  	    ttm_resource_free(bo, &bo->resource);
... unwind back to amdgpu_bo_move:
       trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);

And this old_mem is now uaf since old_mem is &bo->resource from the top 
of amdgpu_move, before if was freed in ttm_bo_move_pipeline_evict.

Regards,

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
>> Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move 
>> always move on same heap")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
>> Cc: Beyond Wang <Wang.Beyond@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> ---
>> Beware this is a speculative fix for now based only on source code
>> analysis and backtraces from 3171. It is also a bit on the churny side so
>> I am happy to minimize it. But most importantly, given how I don't have
>> any experience in amdgpu, I am looking for domain experts to either
>> confirm or disprove my analysis.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 47 ++++++++++++-------------
>>   1 file changed, 22 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 8722beba494e..81189aab5a04 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -452,10 +452,11 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>       struct amdgpu_device *adev;
>>       struct amdgpu_bo *abo;
>>       struct ttm_resource *old_mem = bo->resource;
>> +    uint32_t new_mem_type = new_mem->mem_type;
>> +    uint32_t old_mem_type;
>>       int r;
>> -    if (new_mem->mem_type == TTM_PL_TT ||
>> -        new_mem->mem_type == AMDGPU_PL_PREEMPT) {
>> +    if (new_mem_type == TTM_PL_TT || new_mem_type == 
>> AMDGPU_PL_PREEMPT) {
>>           r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
>>           if (r)
>>               return r;
>> @@ -464,20 +465,18 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>       abo = ttm_to_amdgpu_bo(bo);
>>       adev = amdgpu_ttm_adev(bo->bdev);
>> -    if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>> -             bo->ttm == NULL)) {
>> +    if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM && bo->ttm == 
>> NULL)) {
>>           ttm_bo_move_null(bo, new_mem);
>>           goto out;
>>       }
>> -    if (old_mem->mem_type == TTM_PL_SYSTEM &&
>> -        (new_mem->mem_type == TTM_PL_TT ||
>> -         new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>> +    old_mem_type = old_mem->mem_type;
>> +    if (old_mem_type == TTM_PL_SYSTEM &&
>> +        (new_mem_type == TTM_PL_TT || new_mem_type == 
>> AMDGPU_PL_PREEMPT)) {
>>           ttm_bo_move_null(bo, new_mem);
>>           goto out;
>>       }
>> -    if ((old_mem->mem_type == TTM_PL_TT ||
>> -         old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>> -        new_mem->mem_type == TTM_PL_SYSTEM) {
>> +    if ((old_mem_type == TTM_PL_TT || old_mem_type == 
>> AMDGPU_PL_PREEMPT) &&
>> +        new_mem_type == TTM_PL_SYSTEM) {
>>           r = ttm_bo_wait_ctx(bo, ctx);
>>           if (r)
>>               return r;
>> @@ -488,22 +487,22 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>           goto out;
>>       }
>> -    if (old_mem->mem_type == AMDGPU_PL_GDS ||
>> -        old_mem->mem_type == AMDGPU_PL_GWS ||
>> -        old_mem->mem_type == AMDGPU_PL_OA ||
>> -        old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>> -        new_mem->mem_type == AMDGPU_PL_GDS ||
>> -        new_mem->mem_type == AMDGPU_PL_GWS ||
>> -        new_mem->mem_type == AMDGPU_PL_OA ||
>> -        new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>> +    if (old_mem_type == AMDGPU_PL_GDS ||
>> +        old_mem_type == AMDGPU_PL_GWS ||
>> +        old_mem_type == AMDGPU_PL_OA ||
>> +        old_mem_type == AMDGPU_PL_DOORBELL ||
>> +        new_mem_type == AMDGPU_PL_GDS ||
>> +        new_mem_type == AMDGPU_PL_GWS ||
>> +        new_mem_type == AMDGPU_PL_OA ||
>> +        new_mem_type == AMDGPU_PL_DOORBELL) {
>>           /* Nothing to save here */
>>           ttm_bo_move_null(bo, new_mem);
>>           goto out;
>>       }
>>       if (bo->type == ttm_bo_type_device &&
>> -        new_mem->mem_type == TTM_PL_VRAM &&
>> -        old_mem->mem_type != TTM_PL_VRAM) {
>> +        new_mem_type == TTM_PL_VRAM &&
>> +        old_mem_type != TTM_PL_VRAM) {
>>           /* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
>>            * accesses the BO after it's moved.
>>            */
>> @@ -511,10 +510,8 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>       }
>>       if (adev->mman.buffer_funcs_enabled) {
>> -        if (((old_mem->mem_type == TTM_PL_SYSTEM &&
>> -              new_mem->mem_type == TTM_PL_VRAM) ||
>> -             (old_mem->mem_type == TTM_PL_VRAM &&
>> -              new_mem->mem_type == TTM_PL_SYSTEM))) {
>> +        if (((old_mem_type == TTM_PL_SYSTEM && new_mem_type == 
>> TTM_PL_VRAM) ||
>> +             (old_mem_type == TTM_PL_VRAM && new_mem_type == 
>> TTM_PL_SYSTEM))) {
>>               hop->fpfn = 0;
>>               hop->lpfn = 0;
>>               hop->mem_type = TTM_PL_TT;
>> @@ -540,7 +537,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object 
>> *bo, bool evict,
>>               return r;
>>       }
>> -    trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>> +    trace_amdgpu_bo_move(abo, new_mem_type, old_mem_type);
>>   out:
>>       /* update statistics */
>>       atomic64_add(bo->base.size, &adev->num_bytes_moved);
> 
