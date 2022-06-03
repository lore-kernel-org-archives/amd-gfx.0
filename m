Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6024BC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 12:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A75113640;
	Fri,  3 Jun 2022 12:10:38 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EC2113640
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 12:10:37 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id n28so9877322edb.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=pSkfRv+yI+lFD4w/1lj2Vy+cWk8gS5F87Gy5E0cU8c8=;
 b=FtJXoceSAUlQ9k++0PgLQGczF7EO4SpYqXxgIuFWO+fU0Pw1PEYAVfJtroEi4SiApZ
 x1+nxQp85W9zRiY14EvvQWMYSqYUH9crmeN81NSGGEcJnaR9HO2cSbZnTLbU2afUGXbN
 SyvkTSlzbSK6h9uf1y2ZssVWSzFt+pTO9InG7q1hspx710l7PyUgIOhwTTBLE8lvTOTd
 ++b7pRHqKCQAgo3Xrcj9mzClBKoTDSpGn8AMq2KI31nshNdGPnSikLYXKd52fO6LmtTX
 PGrbZ8EnwkPWwUsTIEK6FLEQGMRBQgjvkHb9kIUPfv9c1+qfANw6jSs1DBtCnbEqcA9E
 loNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pSkfRv+yI+lFD4w/1lj2Vy+cWk8gS5F87Gy5E0cU8c8=;
 b=TyDAzTU4xM5aOgBgeStmp4zfn0glatDRjsDQ7eKU3FxMW+urjyvu0oYdl67vW6twqs
 1h4D94/cf1/+JFDex93SGJMkL17ELkjy0jEeOyOKrmorX1KFwcPMnSFaqb7E8Wrmt67V
 xoPGRhAUhGzMTzihh2b8XtXwIgagVDkCqc/4djvsg9o1DJa+cZqIxyFOLUoWChnJAH1z
 P1+vPogyEzRckoMXnGKLcIU8rWtC4VQQbv+VsG+YQHs6//xzXktu5QanMY3n89xhW8nD
 etveXjBmptAq79tCYJwOHexYfo5hG3hWLJlGBNUhmM3vpLUQsaXI7qlAEGAaHQX7VZE2
 svVw==
X-Gm-Message-State: AOAM532uwNUUm9Lr7XSnovsx09yFB6p1JnhFN2GESVAdDF8baUVY9lsm
 Y54GFA/aug/9jhtUPRxFTRM=
X-Google-Smtp-Source: ABdhPJzkF2hD8YhEBsuPZ3JG4nTxucNcjhEA1r5HwmIZj4Mn8tUSCUuBV+UrIHjRmAaDz0tOdwm/2w==
X-Received: by 2002:a05:6402:1449:b0:42d:d250:e504 with SMTP id
 d9-20020a056402144900b0042dd250e504mr10342206edx.213.1654258235656; 
 Fri, 03 Jun 2022 05:10:35 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8059:9432:a21:a38b?
 ([2a02:908:1256:79a0:8059:9432:a21:a38b])
 by smtp.gmail.com with ESMTPSA id
 g3-20020aa7dd83000000b0042bc5a536edsm3812673edv.28.2022.06.03.05.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jun 2022 05:10:35 -0700 (PDT)
Message-ID: <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
Date: Fri, 3 Jun 2022 14:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220603102106.149508-1-christian.koenig@amd.com>
 <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
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

Am 03.06.22 um 14:08 schrieb Pierre-Eric Pelloux-Prayer:
> Hi Christian,
>
> The patch is: Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> Could you add a reference to https://gitlab.freedesktop.org/drm/amd/-/issues/2037 in the commit message?

Sure, can you also give me an rb or acked-by so that I can push it?

Thanks,
Christian.

>
> Thanks,
> Pierre-Eric
>
> On 03/06/2022 12:21, Christian König wrote:
>> The job is not yet initialized here.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures directly in CS parsers")
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index 3cabceee5f57..39405f0db824 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>>   };
>>   
>> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
>> -				struct amdgpu_job *job)
>> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
>>   {
>>   	struct drm_gpu_scheduler **scheds;
>>   
>>   	/* The create msg must be in the first IB submitted */
>> -	if (atomic_read(&job->base.entity->fence_seq))
>> +	if (atomic_read(&p->entity->fence_seq))
>>   		return -EINVAL;
>>   
>>   	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
>>   		[AMDGPU_RING_PRIO_DEFAULT].sched;
>> -	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
>> +	drm_sched_entity_modify_sched(p->entity, scheds, 1);
>>   	return 0;
>>   }
>>   
>> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>> -			    uint64_t addr)
>> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
>>   {
>>   	struct ttm_operation_ctx ctx = { false, false };
>>   	struct amdgpu_bo_va_mapping *map;
>> @@ -1848,7 +1846,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>>   		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
>>   			continue;
>>   
>> -		r = vcn_v3_0_limit_sched(p, job);
>> +		r = vcn_v3_0_limit_sched(p);
>>   		if (r)
>>   			goto out;
>>   	}
>> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>   					   struct amdgpu_job *job,
>>   					   struct amdgpu_ib *ib)
>>   {
>> -	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>> +	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
>>   	uint32_t msg_lo = 0, msg_hi = 0;
>>   	unsigned i;
>>   	int r;
>> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>   			msg_hi = val;
>>   		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
>>   			   val == 0) {
>> -			r = vcn_v3_0_dec_msg(p, job,
>> -					     ((u64)msg_hi) << 32 | msg_lo);
>> +			r = vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 | msg_lo);
>>   			if (r)
>>   				return r;
>>   		}
>>

