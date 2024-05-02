Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712D2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DC110F102;
	Thu,  2 May 2024 15:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ss8GdRtP";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5307010F102
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:14:49 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-34e0d47bd98so608259f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714662887; x=1715267687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DU9SSuV7y2IjaoWd45Kr7jhJxvFTnvGgwhEd7e0ppRo=;
 b=Ss8GdRtPhCBXEwaVW21Bx6+mc3rFST6K048QMt93ViegoQ4LxV6Tdeq8/pS1qD38uK
 50yAmEPIsvXcdwuicBTgOyu8t+4i2At576RPoKQI4hcMqp+TNBQXisbJzyrpEXmfbB5W
 y8iT9K0gVach/9yG737GI1K1M8pDiUVXBpYQkGss6u0p12O6fBSZ+FHTPdPWj6/0MM5x
 5jggztiMhISAIff0YjN9Vk+aAqYLD/AKuU71Djli5uzmsnWpHs94k1zJqBO1aCZzwje3
 CIl8ybPM2G9s8oZW5dqzJmMEB6LemiZmhCir+JjAL8qhVzMpaunbRkh2RdOcy1+Q/bZJ
 Hibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714662887; x=1715267687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DU9SSuV7y2IjaoWd45Kr7jhJxvFTnvGgwhEd7e0ppRo=;
 b=O+JbsMyCiGnddn0jty+NfVrn96X2NMW/KDpdf3pR1RsiSb7dZittnZEO6xuA852tBT
 otYRqcREYyNSPORnpR+U0d0IB91hmjvaL+lMwb7V5qqHS7InxOD093JUTnHSO09iWBzZ
 mh6rfrYjm1HZsXFAJv2WUldzg64PVDfKLmqSzyQEkWZbkE9N1yLj73JAo6TZxoV/dBxS
 cjIbWUNpN1TUV73g8kWaCFrigj+F62OhlMHHwEkGGPSKaPUclVLXQiF2oftR3du2lTDI
 1s3yxOLx9fZhKSbEN+f0qcxgum3d97zX8y5EE0lU7rtLU/S4FNRdodZYrun/70kus6ch
 ipeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmNmctaKMW92yC0OIED3MhvIwZegO4+KxR0TlC8kRSwPiN0lSwbXIc/4msDYBf17a3Gg9LMb5TnLyYuAP7bCQD14K16PHcGaFwRS8bXQ==
X-Gm-Message-State: AOJu0YwGPtKcRqLx6KfaOTd1dAJo0aeVtfJQNICbugC/mwUamHpoUVt6
 r/7SyJx47TZqoN7gR9NMmYltvhlNloF5M+mNnwqCHsGKLvJzwIUO
X-Google-Smtp-Source: AGHT+IEr0cqseQSHkX30qzwQ0u/1trdXTkBNS28JZ16beV06toekHYxRBEjs3lD7WYKMNhnz3TeETg==
X-Received: by 2002:adf:e60c:0:b0:34c:bf22:73f9 with SMTP id
 p12-20020adfe60c000000b0034cbf2273f9mr23542wrm.28.1714662887173; 
 Thu, 02 May 2024 08:14:47 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p12-20020adfe60c000000b0034ccd06a6a3sm1493662wrm.18.2024.05.02.08.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 08:14:46 -0700 (PDT)
Message-ID: <9b19831b-d534-49b1-9786-38c3cdb5b02f@gmail.com>
Date: Thu, 2 May 2024 17:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/14] drm/amdgpu: create MES-V11 usermode queue for GFX
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-6-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426134810.1250-6-shashank.sharma@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 26.04.24 um 15:48 schrieb Shashank Sharma:
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Adds a new file which will be used for MES based userqueue
>    functions targeting GFX and SDMA IP.
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>    MES-V11 for GFX IP.
>
> V1: Worked on review comments from Alex:
>      - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>      - Reuse the existing adev->mqd[ip] for MQD creation
>      - Formatting and arrangement of code
>
> V3:
>      - Integration with doorbell manager
>
> V4: Review comments addressed:
>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>      - Align name of structure members (Luben)
>      - Don't break up the Cc tag list and the Sob tag list in commit
>        message (Luben)
> V5:
>     - No need to reserve the bo for MQD (Christian).
>     - Some more changes to support IP specific MQD creation.
>
> V6:
>     - Add a comment reminding us to replace the amdgpu_bo_create_kernel()
>       calls while creating MQD object to amdgpu_bo_create() once eviction
>       fences are ready (Christian).
>
> V7:
>     - Re-arrange userqueue functions in adev instead of uq_mgr (Alex)
>     - Use memdup_user instead of copy_from_user (Christian)
>
> V9:
>     - Moved userqueue code from gfx_v11_0.c to new file mes_v11_0.c so
>       that it can be reused for SDMA userqueues as well (Shashank, Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 110 ++++++++++++++++++
>   3 files changed, 116 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 05a2d1714070..a640bfa468ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -184,7 +184,8 @@ amdgpu-y += \
>   amdgpu-y += \
>   	amdgpu_mes.o \
>   	mes_v10_1.o \
> -	mes_v11_0.o
> +	mes_v11_0.o \
> +	mes_v11_0_userqueue.o

Do we really need a new C file for this or could we put the two 
functions into mes_v11_0.c as well?

Apart from that it looks correct to me, but I'm really not that deep 
inside the code at the moment.

Regards,
Christian.

>   
>   # add UVD block
>   amdgpu-y += \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f7325b02a191..525bd0f4d3f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1331,6 +1331,8 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
> +
>   static int gfx_v11_0_sw_init(void *handle)
>   {
>   	int i, j, k, r, ring_id = 0;
> @@ -1347,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_mec = 2;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>   		break;
>   	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 4):
> @@ -1358,6 +1361,7 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_mec = 1;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>   		break;
>   	default:
>   		adev->gfx.me.num_me = 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> new file mode 100644
> index 000000000000..9e7dee77d344
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "amdgpu.h"
> +#include "amdgpu_gfx.h"
> +#include "v11_structs.h"
> +#include "mes_v11_0.h"
> +#include "amdgpu_userqueue.h"
> +
> +static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
> +				      struct drm_amdgpu_userq_in *args_in,
> +				      struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
> +	struct drm_amdgpu_userq_mqd *mqd_user;
> +	struct amdgpu_mqd_prop *userq_props;
> +	int r;
> +
> +	/* Incoming MQD parameters from userspace to be saved here */
> +	memset(&mqd_user, 0, sizeof(mqd_user));
> +
> +	/* Structure to initialize MQD for userqueue using generic MQD init function */
> +	userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
> +	if (!userq_props) {
> +		DRM_ERROR("Failed to allocate memory for userq_props\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd)) {
> +		DRM_ERROR("MQD size mismatch\n");
> +		r = -EINVAL;
> +		goto free_props;
> +	}
> +
> +	mqd_user = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
> +	if (IS_ERR(mqd_user)) {
> +		DRM_ERROR("Failed to read user MQD\n");
> +		r = -EFAULT;
> +		goto free_props;
> +	}
> +
> +	r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
> +	if (r) {
> +		DRM_ERROR("Failed to create MQD object for userqueue\n");
> +		goto free_mqd_user;
> +	}
> +
> +	/* Initialize the MQD BO with user given values */
> +	userq_props->wptr_gpu_addr = mqd_user->wptr_va;
> +	userq_props->rptr_gpu_addr = mqd_user->rptr_va;
> +	userq_props->queue_size = mqd_user->queue_size;
> +	userq_props->hqd_base_gpu_addr = mqd_user->queue_va;
> +	userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
> +	userq_props->use_doorbell = true;
> +
> +	queue->userq_prop = userq_props;
> +
> +	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize MQD for userqueue\n");
> +		goto free_mqd;
> +	}
> +
> +	return 0;
> +
> +free_mqd:
> +	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +
> +free_mqd_user:
> +	kfree(mqd_user);
> +
> +free_props:
> +	kfree(userq_props);
> +
> +	return r;
> +}
> +
> +static void
> +mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
> +			    struct amdgpu_usermode_queue *queue)
> +{
> +	kfree(queue->userq_prop);
> +	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +}
> +
> +const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
> +	.mqd_create = mes_v11_0_userq_mqd_create,
> +	.mqd_destroy = mes_v11_0_userq_mqd_destroy,
> +};

