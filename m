Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F18EC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A3E61139
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A3E61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0523789930;
	Wed, 14 Apr 2021 14:33:14 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8CE89930
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 14:33:12 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id r9so31762198ejj.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GU6TDHh/EH7ji2P2BIe4nNO8VAecE9zpY0X5e/cOnV4=;
 b=Oj2TEE0PNdW74v6PJvZ14Z0ta5LeL/SRdKHcpQ6iBS39Z1ApSu1e0XCoICDTPbH0IL
 ua66i/vM4R7y33MS4pap9Qy+ur/v4eBbbivA7O7nKlu7aHVeT6BP9l8GmudLaTV5F2ll
 HWcF0jsD3olEuIUWK0UFHv+Dr+tklsYCIYR9NaRDYo6aiDaVgvyhModjLZ/5l1NfIsnp
 N9hmdXu7obSpRQymDw4mBiU39L6cnvUu6Xod3NteAFBM9U2RrFs3B6DHRnnfRA6L4hzw
 GLt2VGBEJeYe3+3nDRdw3waQOgmchmhGUr3ydlw28IYSAuDMtJL/tIQGvAuKGuhSZZo5
 E96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GU6TDHh/EH7ji2P2BIe4nNO8VAecE9zpY0X5e/cOnV4=;
 b=HXd5DQ70SOGNMc4oBM7mu4dfdlZDC5V9K2KIQ5i1FHVEjSx03ju/DX6wx0kHNiRTBS
 YD6KSh6mDoxb86dEB/JkhJdJUvUaH5TM04AaFtf8bcwA634jN+EJAvllDRbJe6BKdEGS
 XQH7CyNZ+D3iDwNfwF5Ph9R09weFVFgAvH84e7C7RGf4xSxPnc/tSuz/e769YRPNqOgX
 PSn85h+wEZy2Sd43U2x6TqvkoUhtW8dqGV+xenQ/ZNBXGsY//KAgE1b01VV1d827cB1u
 jXe7dQlCGahkIbkzI9rKoB/oPkBlnJVTPqPzizro2FFUnUOhAxlhzMOBsoEw6qPu5+q7
 jWew==
X-Gm-Message-State: AOAM530S382v2u64pVVjGKcSfA0E9Y6WMHHe0x7bmmnMi0ANsUf8vK5k
 1kvLb8CCoT0vZKYUg8ufT7eckzO3yOE=
X-Google-Smtp-Source: ABdhPJxJOczeA68JX3Y0piQvxSwJzqsHXTNnT0c29azjybTNwrUPMR5gSP4b3/KiTQcITWrXxrDteQ==
X-Received: by 2002:a17:906:2a46:: with SMTP id
 k6mr37573529eje.206.1618410790970; 
 Wed, 14 Apr 2021 07:33:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e9a3:13df:a504:8764?
 ([2a02:908:1252:fb60:e9a3:13df:a504:8764])
 by smtp.gmail.com with ESMTPSA id d15sm9939974ejj.42.2021.04.14.07.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Apr 2021 07:33:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210414135954.23665-1-Roy.Sun@amd.com>
 <20210414135954.23665-2-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1a8d3bfa-b410-705e-59cd-f1fed56646c7@gmail.com>
Date: Wed, 14 Apr 2021 16:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414135954.23665-2-Roy.Sun@amd.com>
Content-Language: en-US
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
Cc: David M Nieto <David.Nieto@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.04.21 um 15:59 schrieb Roy Sun:
> Tracking devices, process info and fence info using
> /proc/pid/fdinfo
>
> Signed-off-by: David M Nieto <David.Nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 61 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 91 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h | 43 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 17 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 +
>   10 files changed, 227 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee85e8aba636..d216b7ecb5d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,6 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o
>   
> +amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
> +
>   amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
>   
>   # add asic specific block
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616c85a01299..c2338a0dd1f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -107,6 +107,7 @@
>   #include "amdgpu_gfxhub.h"
>   #include "amdgpu_df.h"
>   #include "amdgpu_smuio.h"
> +#include "amdgpu_fdinfo.h"
>   
>   #define MAX_GPU_INSTANCE		16
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 0350205c4897..01fe60fedcbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -651,3 +651,64 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	idr_destroy(&mgr->ctx_handles);
>   	mutex_destroy(&mgr->lock);
>   }
> +
> +void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
> +		ktime_t *total, ktime_t *max)
> +{
> +	ktime_t now, t1;
> +	uint32_t i;
> +
> +	now = ktime_get();
> +	for (i = 0; i < amdgpu_sched_jobs; i++) {
> +		struct dma_fence *fence;
> +		struct drm_sched_fence *s_fence;
> +
> +		spin_lock(&ctx->ring_lock);
> +		fence = dma_fence_get(centity->fences[i]);
> +		spin_unlock(&ctx->ring_lock);
> +		if (!fence)
> +			continue;
> +		s_fence = to_drm_sched_fence(fence);
> +		if (!dma_fence_is_signaled(&s_fence->scheduled))
> +			continue;
> +		t1 = s_fence->scheduled.timestamp;
> +		if (t1 >= now)
> +			continue;
> +		if (dma_fence_is_signaled(&s_fence->finished) &&
> +			s_fence->finished.timestamp < now)
> +			*total += ktime_sub(s_fence->finished.timestamp, t1);
> +		else
> +			*total += ktime_sub(now, t1);
> +		t1 = ktime_sub(now, t1);
> +		dma_fence_put(fence);
> +		*max = max(t1, *max);
> +	}
> +}
> +
> +ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed)
> +{
> +	struct idr *idp;
> +	struct amdgpu_ctx *ctx;
> +	uint32_t id;
> +	struct amdgpu_ctx_entity *centity;
> +	ktime_t total = 0, max = 0;
> +
> +	if (idx >= AMDGPU_MAX_ENTITY_NUM)
> +		return 0;
> +	idp = &mgr->ctx_handles;
> +	mutex_lock(&mgr->lock);
> +	idr_for_each_entry(idp, ctx, id) {
> +		if (!ctx->entities[hwip][idx])
> +			continue;
> +
> +		centity = ctx->entities[hwip][idx];
> +		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
> +	}
> +
> +	mutex_unlock(&mgr->lock);
> +	if (elapsed)
> +		*elapsed = max;
> +
> +	return total;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index f54e10314661..10dcf59a5c6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -87,5 +87,8 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
> -
> +ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed);
> +void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
> +		ktime_t *total, ktime_t *max);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4bcc03c4c6c5..07aed377dec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -42,7 +42,7 @@
>   #include "amdgpu_irq.h"
>   #include "amdgpu_dma_buf.h"
>   #include "amdgpu_sched.h"
> -
> +#include "amdgpu_fdinfo.h"
>   #include "amdgpu_amdkfd.h"
>   
>   #include "amdgpu_ras.h"
> @@ -1691,6 +1691,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>   #ifdef CONFIG_COMPAT
>   	.compat_ioctl = amdgpu_kms_compat_ioctl,
>   #endif
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = amdgpu_show_fdinfo
> +#endif
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> new file mode 100644
> index 000000000000..104f7194e787
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: MIT
> +/* Copyright 2021 Advanced Micro Devices, Inc.
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
> + * Authors: David Nieto
> + *          Roy Sun
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/reboot.h>
> +#include <linux/syscalls.h>
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/drm_debugfs.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_gem.h"
> +#include "amdgpu_ctx.h"
> +#include "amdgpu_fdinfo.h"
> +
> +
> +static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
> +	[AMDGPU_HW_IP_GFX]	=	"gfx",
> +	[AMDGPU_HW_IP_COMPUTE]	=	"compute",
> +	[AMDGPU_HW_IP_DMA]	=	"dma",
> +	[AMDGPU_HW_IP_UVD]	=	"dec",
> +	[AMDGPU_HW_IP_VCE]	=	"enc",
> +	[AMDGPU_HW_IP_UVD_ENC]	=	"enc_1",
> +	[AMDGPU_HW_IP_VCN_DEC]	=	"dec",
> +	[AMDGPU_HW_IP_VCN_ENC]	=	"enc",
> +	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
> +};
> +
> +void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +	uint32_t bus, dev, fn, i;
> +	struct drm_file *file = f->private_data;
> +	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +
> +	if (amdgpu_file_to_fpriv(f, &fpriv))
> +		return;
> +	bus = adev->pdev->bus->number;
> +	dev = PCI_SLOT(adev->pdev->devfn);
> +	fn = PCI_FUNC(adev->pdev->devfn);
> +
> +	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
> +			fpriv->vm.pasid);
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> +		uint32_t count = amdgpu_ctx_num_entities[i];
> +		int idx = 0;
> +		uint64_t total = 0, min = 0;
> +		uint32_t perc, frac;
> +
> +		for (idx = 0; idx < count; idx++) {
> +			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
> +				i, idx, &min);
> +			if ((total == 0) || (min == 0))
> +				continue;
> +
> +			perc = div64_u64(10000 * total, min);
> +			frac = perc % 100;
> +
> +			seq_printf(m, "%s%d:\t%d.%d%%\n",
> +					amdgpu_ip_name[i],
> +					idx, perc/100, frac);
> +		}
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> new file mode 100644
> index 000000000000..41a4c7056729
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: MIT
> + * Copyright 2021 Advanced Micro Devices, Inc.
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
> + * Authors: David Nieto
> + *          Roy Sun
> + */
> +#ifndef __AMDGPU_SMI_H__
> +#define __AMDGPU_SMI_H__
> +
> +#include <linux/idr.h>
> +#include <linux/kfifo.h>
> +#include <linux/rbtree.h>
> +#include <drm/gpu_scheduler.h>
> +#include <drm/drm_file.h>
> +#include <drm/ttm/ttm_bo_driver.h>
> +#include <linux/sched/mm.h>
> +
> +#include "amdgpu_sync.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_ids.h"
> +
> +uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
> +void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 39ee88d29cca..b2e774aeab45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -41,6 +41,7 @@
>   #include "amdgpu_gem.h"
>   #include "amdgpu_display.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_fdinfo.h"
>   
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index daf926a63c51..23bb9fc2b406 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -25,6 +25,7 @@
>    *          Alex Deucher
>    *          Jerome Glisse
>    */
> +
>   #include <linux/dma-fence-array.h>
>   #include <linux/interval_tree_generic.h>
>   #include <linux/idr.h>
> @@ -3286,6 +3287,22 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   	get_task_comm(vm->task_info.process_name, current->group_leader);
>   }
>   
> +uint64_t amdgpu_vm_memory(struct amdgpu_fpriv *fpriv,
> +			unsigned int domain)
> +{
> +	uint64_t total = 0;
> +
> +	if (fpriv->vm.process_info) {
> +		struct kgd_mem *mem;
> +
> +		mutex_lock(&fpriv->vm.process_info->lock);
> +
> +		mutex_unlock(&fpriv->vm.process_info->lock);
> +	}

I was about to give my blessing, but that looks like you have removed 
something accidentally here.

Christian.

> +
> +	return total;
> +}
> +
>   /**
>    * amdgpu_vm_handle_fault - graceful handling of VM faults.
>    * @adev: amdgpu device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 976a12e5a8b9..b75cb5f416ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -447,6 +447,9 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +void amdgpu_vm_get_memory(struct amdgpu_fpriv *fpriv, uint64_t *vram_mem,
> +				uint64_t *gtt_mem);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
