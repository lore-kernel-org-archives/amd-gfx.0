Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E3EC77B6F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 12:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6427710E1E6;
	Tue, 11 Apr 2023 12:35:05 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B67E10E1E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 12:35:03 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-50489b16e6aso1854687a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681216501; x=1683808501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W0wg/rxmPOvwlju1pIGob77hyoUGzVYvvkmH74hEBOI=;
 b=eGy0x5+SNnV0jqUd9Ed+v5exKaJEkNZJHiWqyDvRhLW4wDzmw1AFA64V3VvDCmwlg3
 R4sH1ugiHLD1Slsow/VxXJAD7OizlTFHGrF0u2ZZj4Ta2TMC7MRZ4F03z7iBpHMPEqz7
 QhQ6cfbXIx6NNRsF4RSvwOj/ux28kA/8T/KsXEm25j7FhMoxO8Kgx6zr343DckxxNMu6
 Dv/rczqI/eR5wZRw8HIVqeyRMKTfTMdONeJwjlKFYAha5uXg84LJ6cSIADPahC+3f4fF
 HSLP+mIvWQ2zMantfA7RuAdDPTB9ad6OHWoulAUkryLe3yBqeHLBF8KPkYp7QFLQFr8m
 kY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681216501; x=1683808501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0wg/rxmPOvwlju1pIGob77hyoUGzVYvvkmH74hEBOI=;
 b=IpR+0C3nziHZ6xejvxZzMTL2dPFV8R3au539njf8LvgnvhClf5B6leojI5C7J3v9VF
 Of85FmkoOqqseyYQTlfJV5Q+a/4hyB1SnAdb2k9R21Y2Rftn+gY78byU3FpyH23yi3MT
 lNaBWXKvxdtZJGDdbiqtaVw4dh+4WtotgR8i1cy3sVEiQGBHkI9Wn8P+e4HpejUv02Fc
 xdLE8xxkhSUUrccIew1TfNrq1IDqjiqxQA2XPtvVe+2sim/OkFYt9/GBYNYHvV0vC+MW
 KT4pqPx9Q8UW7wzEXMjW1o0weKMqktTBgKNS5MIDwcVGFfAFjLJ9WeItGiadQvQZ4cH5
 BjGg==
X-Gm-Message-State: AAQBX9e0q/HPimlJMkCC8lE+pYJA24kQe00gj/63zrAhvcR8IlxPBycw
 BspRI1vE81dq3BNco4S9UDMAp3I8A7qUpw==
X-Google-Smtp-Source: AKy350ZKGth8f6ZqbUGVMW+NNIX02j8NgQ1lZFvDHVxTRab25td5pugCIsJ2XR3cJ3CHG1JE0QicOA==
X-Received: by 2002:aa7:cb46:0:b0:504:7d53:2148 with SMTP id
 w6-20020aa7cb46000000b005047d532148mr10756257edt.30.1681216501385; 
 Tue, 11 Apr 2023 05:35:01 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 cm4-20020a0564020c8400b00504b2d9f4d7sm1297434edb.54.2023.04.11.05.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Apr 2023 05:35:00 -0700 (PDT)
Message-ID: <e1b64ac5-45e0-7527-d454-6897f5aa0374@gmail.com>
Date: Tue, 11 Apr 2023 14:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Reject submissions with too many IBs.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, maraeo@gmail.com,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
> Instead of failing somewhere in the scheduler after the
> ioctl has already succeeded.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>   3 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 995ee9ff65c9..8db6618b9049 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -113,6 +113,15 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!entity)
>   		return 0;
>   
> +	if (entity->rq && entity->rq->sched) {

I've just double checked and this stuff here is not necessary 
initialized yet. We need to move this a bit around.

Probably best place for the check is in amdgpu_cs_submit() after calling 
drm_sched_job_arm().

Alternatively we could go the other way around. Instead of keeping the 
max_ibs in the ring we keep a max_ibs per ip_type in adev and make sure 
that each ring can handle at least those during initialization.

Then we can check if the num_ibs are valid in amdgpu_cs_p1_ib() when we 
count them.

Thinking more about it the later is probably the better variant.

Regards,
Christian.

> +		struct amdgpu_ring *ring = to_amdgpu_ring(entity->rq->sched);
> +
> +		if (num_ibs > ring->max_ibs) {
> +			DRM_DEBUG("Rejected a submission with too many IBs");
> +			return -EINVAL;
> +		}
> +	}
> +
>   	return drm_sched_job_init(&(*job)->base, entity, owner);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index dc474b809604..933cb95a0e30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -324,6 +324,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	ring->max_dw = max_dw;
>   	ring->hw_prio = hw_prio;
>   
> +	if (ring->funcs->emit_ib_size) {
> +		ring->max_ibs =
> +			(max_dw - ring->funcs->emit_frame_size) / ring->funcs->emit_ib_size;
> +	}
> +
>   	if (!ring->no_scheduler) {
>   		hw_ip = ring->funcs->type;
>   		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..7a295d80728b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -245,6 +245,7 @@ struct amdgpu_ring {
>   	unsigned		ring_size;
>   	unsigned		max_dw;
>   	int			count_dw;
> +	unsigned		max_ibs;
>   	uint64_t		gpu_addr;
>   	uint64_t		ptr_mask;
>   	uint32_t		buf_mask;

