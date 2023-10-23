Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2968C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 05:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F1A10E14A;
	Mon, 23 Oct 2023 05:49:11 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0441710E14A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 05:49:09 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54041e33845so1232549a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Oct 2023 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698040148; x=1698644948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5t1K8+dMvUwfCsKxXVlwUR+QRFsjIal4tN9rpoN8kCM=;
 b=RErhtcY/lRcBJolKBimDLBRb8P6i4Z0rvM8ksMuVJZFg4zRPoWLmPxB9eWveph4bH1
 5uT3RleuOp0HH7cvsEmD6GQ5zWhdr2cNyu66N0f0Cjj4nBmsLK5Vz7jbJRXgwmpooT1P
 rS6MHz35R4IqSISXSTTxn3MaJt9oDjSKtY7BNHCOgKorCziOemczxHYrVmGqcg7T8DTn
 N2JQLGafNZLNeeOzJ2bC0K7o4PS3gGhmp6sQ2nkXKIF7Ygo7TbO2KFfeQMRQxPIw0CVG
 19/1g1kEp2pYUAuUZaScC7iBbjfd587I37SVviluKjhMw2fSaZmxKErXM4gZrGS1ZdxD
 8iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698040148; x=1698644948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5t1K8+dMvUwfCsKxXVlwUR+QRFsjIal4tN9rpoN8kCM=;
 b=mHfUBaWT2cDurj9HmK5Bo7HRwJd4vZGFhGrkxxVyJe/lVXkYVy1qTrmjifs/UC17kv
 EgsugnTxb5Tun0CFLg3/GeaQb516KRVDuuo7ZyLrvr/HmV9tnZCL0P8Nrxk13B0O/U2c
 45/gf//ONXlwFrrIqNKD4dQH07T4zHPN/g5QlQPdjLArvaHmr8fAOly9hLFlgMuEwu+7
 JHujnual1zlUcx8lBN2HsyMWaDmlgnm2cdBWVzbthrCz4HJTDbhOn/R3xW3+hamsk3Es
 y1oJec2qO3VvYVL5OnRqhU/VQ+YMHDuP5rA7yDltIOgf85DYVchsY+LO0XKJPE8g5lX8
 GUrA==
X-Gm-Message-State: AOJu0YzAjxqxgJSnsaHtN9KswCBoDmiB7IEGyzDwQrUBI4nwsbSUnwhW
 q7sRnYHsCV69LFpaUzwuIz8=
X-Google-Smtp-Source: AGHT+IEyfH1cmk+ZHMLL2vOU/iz9B0EA4wUewFPy1L2AilgTbZlzxWTyHnlDZA7lPUSPFaAn2p+kTQ==
X-Received: by 2002:a05:6402:26cd:b0:53d:d913:d3cb with SMTP id
 x13-20020a05640226cd00b0053dd913d3cbmr6054400edd.28.1698040147997; 
 Sun, 22 Oct 2023 22:49:07 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.195])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a50cd94000000b005346925a474sm5884408edi.43.2023.10.22.22.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 22:49:07 -0700 (PDT)
Message-ID: <402f475c-bb67-4061-9521-2f811eca7657@gmail.com>
Date: Mon, 23 Oct 2023 07:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Initialize schedulers before using them
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20231023032344.164925-1-luben.tuikov@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231023032344.164925-1-luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 23.10.23 um 05:23 schrieb Luben Tuikov:
> Initialize ring schedulers before using them, very early in the amdgpu boot,
> at PCI probe time, specifically at frame-buffer dumb-create at fill-buffer.
>
> This was discovered by using dynamic scheduler run-queues, which showed that
> amdgpu was using a scheduler before calling drm_sched_init(), and the only
> reason it was working was because sched_rq[] was statically allocated in the
> scheduler structure. However, the scheduler structure had _not_ been
> initialized.
>
> When switching to dynamically allocated run-queues, this lack of
> initialization was causing an oops and a blank screen at boot up. This patch
> fixes this amdgpu bug.
>
> This patch depends on the "drm/sched: Convert the GPU scheduler to variable
> number of run-queues" patch, as that patch prevents subsequent scheduler
> initialization if a scheduler has already been initialized.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4e51dce3aab5d6..575ef7e1e30fd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -60,6 +60,7 @@
>   #include "amdgpu_atomfirmware.h"
>   #include "amdgpu_res_cursor.h"
>   #include "bif/bif_4_1_d.h"
> +#include "amdgpu_reset.h"
>   
>   MODULE_IMPORT_NS(DMA_BUF);
>   
> @@ -2059,6 +2060,19 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   
>   		ring = adev->mman.buffer_funcs_ring;
>   		sched = &ring->sched;
> +
> +		r = drm_sched_init(sched, &amdgpu_sched_ops,
> +				   DRM_SCHED_PRIORITY_COUNT,
> +				   ring->num_hw_submission, 0,
> +				   adev->sdma_timeout, adev->reset_domain->wq,
> +				   ring->sched_score, ring->name,
> +				   adev->dev);
> +		if (r) {
> +			drm_err(adev, "%s: couldn't initialize ring:%s error:%d\n",
> +				__func__, ring->name, r);
> +			return;
> +		}

That doesn't look correct either.

amdgpu_ttm_set_buffer_funcs_status() should only be called with 
enable=true as argument *after* the copy ring is initialized and valid 
to use. One part of this ring initialization is to setup the scheduler.


> +
>   		r = drm_sched_entity_init(&adev->mman.high_pr,
>   					  DRM_SCHED_PRIORITY_KERNEL, &sched,
>   					  1, NULL);

That here looks totally incorrect and misplaced to me. 
amdgpu_ttm_set_buffer_funcs_status() should only enabled/disable using 
the copy functions and not really initialize the entity.

So the entity should only be created when enable=true and it should 
especially *not* re-created all the time without properly destroying it.

Can you look at the history of the code? I'm pretty sure that this was 
at some time correctly implemented.

Thanks,
Christian.

>
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> prerequisite-patch-id: c52673df9b6fc9ee001d6261c7ac107b618912a0

