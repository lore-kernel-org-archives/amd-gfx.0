Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89051C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 11:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDF910E779;
	Wed,  2 Apr 2025 11:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aGAvCt7G";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25A110E765
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 11:29:27 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso48140795e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Apr 2025 04:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743593366; x=1744198166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SStuOzhlMGEjGT4dXtNPZjxslmZqEzyOucN7Ec8lxcs=;
 b=aGAvCt7GRSqqrfXHMR3pRz0a/iGQWTgiCh0IpIWz2+tN+MM+qpfNocyv68I0piiiMA
 yDZ+25ASZq/cW0Nk6zoWM6dTlAcp3+3bISav4Fmyw9uqbaOIk5IevKW2eu6ndoKYtJv/
 NpekV8fpkiA8ZPgfxG5jYeCNMF8AMNPji24YzguEKfZ8DsUV9Df+Y60R/ZRxHn2vyZx1
 URCyGnOX6/2Ywt2Rt+to4G+6gZjVMHzhe6cf1gtRBWkmC7N3dNTTWaN+FEJV9SIwsQaY
 NKltZ8rY43/SP8Gi7nSxkThALSc5/84MLHfbsrUPEy8PZn6uBM3Fx3mg4hTcsL8mfjm3
 6DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743593366; x=1744198166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SStuOzhlMGEjGT4dXtNPZjxslmZqEzyOucN7Ec8lxcs=;
 b=QWHa5GZxiX5OSlyXjLZkY7hWFeL86obIBGyd2xuKKD3G3LRwd55Azqgi8wA0wmC813
 +vIMs2J7Y65Ae1ptZ97Sox30qXyIFAvPRW3k8YroERG9q3D/AvCaF8kZLcdL/Qm+OYGF
 1AGxuv0pi0RffLl7Whmp4UeZapEnRLtWev7gGm6+pFMpAiSDZmOKaHugV8fNIvCMKBEf
 Tn2YqGTi1B8Gi/D31HI/VqXIY5UHwXcDGIo1IDvSRhEC5ue7ZuwCzHwf2tI8oyfQ8Z9p
 H87MMh2eX9AAnZRX5BAczBVuVspHiPOT3QQESEHSk/D/tes16VbSo/KceNILI01DMMJN
 /bxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl6IbMVhlAaHdFNHscpYileq19V+6Lra8w4DgLUxXLeBms3fpgBpcoy/k9M1sRPxphPgnhhrrO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWb2qyKTl5ysTdis8x+LIKD+qBPZikylC/TSkdZIbQ2WKfHzta
 1QODh0QyliH1sIuNofA+9qp6MPFsBbAsyvRYnHaiyNuY7Q8LyeBn
X-Gm-Gg: ASbGnctZntZ6vxFI6/5uFf7XjnIcZNdbVEFyzd/GMbmtIBQ29Q0PaLUvHvgChZELpfY
 ppNbVRLqmaPlpSgegLK+y4ZcxeRjuQ89D5LH6ToxTlTIdTpZtLr3UeyHH/oOhZV8++QrNSx0do3
 yHK/Dyo0TsN0AEAHVvUJZFxQ3GM4nmHsE/YLLhy30TxrOBBKUh4D6w7Ob9J7debCYjYf365od0z
 vz89pGlW96QEXJ5aa64qaPwHrQUjqggRhMQvjQ48fufo1vsh0pNsFb+Tn1sLSfpPGZgClBFX1Yk
 XApsVmh01TLwIjZGwgAe7ZQavPg0clL1NiZNUmZid+xpDyCFL3t1eVP3Q0sn23Mr1gaKN9zyAw=
 =
X-Google-Smtp-Source: AGHT+IEkiYnb2H3VfnXp2bIYOMa4Rcp1NaKjJeuMmmEai3UKPaXwVkBewpZfuUAI08umgfMmX7cVaw==
X-Received: by 2002:a05:600c:811b:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-43e8f73a9bcmr139081185e9.14.1743593366172; 
 Wed, 02 Apr 2025 04:29:26 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66d56csm16899691f8f.59.2025.04.02.04.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 04:29:25 -0700 (PDT)
Message-ID: <8ec90a29-e91e-4573-a4a2-aaec41c4b8da@gmail.com>
Date: Wed, 2 Apr 2025 13:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: revert "always sync the GFX pipe on ctx
 switch"
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250331130152.2342-1-christian.koenig@amd.com>
 <20250331130152.2342-2-christian.koenig@amd.com>
 <af699f76-bcf0-4cbe-a308-97188b809e64@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <af699f76-bcf0-4cbe-a308-97188b809e64@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 01.04.25 um 12:50 schrieb SRINIVASAN SHANMUGAM:
>
> On 3/31/2025 6:31 PM, Christian König wrote:
>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936.
>>
>> Turned out that this has some negative consequences for some workloads.
>> Instead check if the cleaner shader should run directly.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 802743efa3b3..5eab1c1a380c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -191,8 +191,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>       need_ctx_switch = ring->current_ctx != fence_ctx;
>>       if (ring->funcs->emit_pipeline_sync && job &&
>>           ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
>> -
>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
> Should we need to, do this context switch, only on SRIOV cases "amdgpu_sriov_vf(adev)" or even in normal BM use cases also?
>> +         amdgpu_vm_need_pipeline_sync(ring, job))) {
>>           need_pipe_sync = true;
>>             if (tmp)
> If yes, could we split this patch into two 1. Actuall revert 2. below part is new changes?

No, splitting it into two would be incorrect since the two decisions depend on each other.

>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b5ddfcbbc9fc..5f0f9e4beea9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -689,7 +689,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>           patch = amdgpu_ring_init_cond_exec(ring,
>>                              ring->cond_exe_gpu_addr);
>>   -    if (need_pipe_sync)
>> +    if (need_pipe_sync || cleaner_shader_needed)
>
> Here now, this pipe line synchronization was usually meant for GPU jobs? and not for client level switching? may I kno please, why it was OR'ed  for even "cleaner_shader_needed"? Is that do we have any usecases like where we don't need pipeline sync in between jobs but we need to emit pipeline sync only when "cleaner_shader_needed"  (ie., wrt new enforce_isolation feature)? - but even though in this "new_enforce_isolation feature" case - we would be skipping the GPU jobs level pipe line synchronization within a client? and do we forsee any synchronization/disruption issues in between jobs within a same client wrt new enforce_ioslation feature?

Pipeline sync means we wait for the pipeline to be idle (except for our self).

This is necessary when one job depends on the results of another one, under SRIOV when switching the ring from one context to another or if the VMID is reused and we have a specific bug in the compute engine.

It is also necessary while we switch GDS, OA or GWS resources or when we want to run the cleaner shader.

I will update the code to make that a bit more easier to understand.

Regards,
Christian.

>
> Best regards,
>
> Srini
>
>>           amdgpu_ring_emit_pipeline_sync(ring);
>>         if (cleaner_shader_needed)

