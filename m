Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8031C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 09:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F456120F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F456120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00DA6E08A;
	Fri, 23 Apr 2021 09:32:49 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F7D6E08A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 09:32:48 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id x20so46250235lfu.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rP73v5gSAETuuHcnb05DT0P+n9AgvBidLeXjBkA2F8w=;
 b=Ro74Up5FQlKyz5SXBR67A4TnmJbfn7mQLhXohd79AmeYEgLqbaU0IDn/S0zPeo52t7
 biZ2loYNtesKM5pJ8K3xNDBjwEoZpBxj99Vz6RMpgC1tYDPME4jq1zvxKI/BEt5uBLds
 Agl4k3rV11JUdVKgMJfq1ilqDXLmULaYRXHNoqjQk4vih4o2JfInTa6hwGM1f/dBlKrY
 m0qgblRjg/gxQcgGdsRhJj0waRB5Pmh0e3Iq7oGe8sDlu8XjuqrgHjNJfpPdgHe85Ak+
 i+4BYw7rnK1vkW8ctX/eKel2aU0VTy+q2C3ZL2po737fW8rEDt1nR+cswvJ9FRRNHX88
 T1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rP73v5gSAETuuHcnb05DT0P+n9AgvBidLeXjBkA2F8w=;
 b=Ofz0vPpu/Y1J5bQVpAW7H4opMf4jGUGkP2IgSrNMgvXh45wqWFiY+GrYD8D8t526PR
 40ey48076ScYegGhJxugbn3VLBB0TsQXDdaB4hAeYXjhWqwCX59uS38JyAHHzVR79rBP
 DnnPjRoob3ksYwdFUDSC6v9jFyMAqNE5TTh/3+hPufrgN+zCzeTpRq3TBGh8Zc25m8Ks
 jgWJROFBOs66RVk9d/CjwwOEVc1rwkpq7Qvd9YcIca/jdAaYAXCeUoqeiH0AJicdDEbK
 EkJSVRbE63W5uhVTJ7Pw4NMWsARPSAk87C4KO+2H100A4mDQJfygWJ/mdeWz8LZcRJ4Z
 L9/A==
X-Gm-Message-State: AOAM5333zPjWD+nLOLQP7AcrzW6SQEqAUnNEP6rLZDhr6kVnygB/IgJO
 DFrqMG6lmsIOSkrwadoFgaw=
X-Google-Smtp-Source: ABdhPJynW0nVjzypdfZXIa7l2aFENaueuGgyIEDX9oqOTJy3jbkrBjRsOwXICKTl/gyU9M8tgpiW/w==
X-Received: by 2002:a19:c511:: with SMTP id w17mr1391222lfe.80.1619170366367; 
 Fri, 23 Apr 2021 02:32:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a2fd:a345:45a8:779b?
 ([2a02:908:1252:fb60:a2fd:a345:45a8:779b])
 by smtp.gmail.com with ESMTPSA id x32sm497732lfa.178.2021.04.23.02.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Apr 2021 02:32:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423091928.39615-1-Roy.Sun@amd.com>
 <20210423091928.39615-2-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a13d6f12-5287-0d9f-fa21-e7fa5d58616b@gmail.com>
Date: Fri, 23 Apr 2021 11:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423091928.39615-2-Roy.Sun@amd.com>
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



Am 23.04.21 um 11:19 schrieb Roy Sun:
> Tracking devices, process info and fence info using
> /proc/pid/fdinfo
>
> Signed-off-by: David M Nieto <David.Nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 61 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 96 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h | 43 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 45 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  2 +
>   11 files changed, 280 insertions(+), 2 deletions(-)
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
> index 125b25a5ce5b..3365feae15e1 100644
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
> index 0369d3532bf0..01603378dbc9 100644
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
> @@ -1692,6 +1692,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
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
> index 000000000000..f4ab7c65517e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -0,0 +1,96 @@
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
> +	uint32_t bus, dev, fn, i, domain;
> +	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
> +	struct drm_file *file = f->private_data;
> +	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +
> +	if (amdgpu_file_to_fpriv(f, &fpriv))
> +		return;
> +	bus = adev->pdev->bus->number;
> +	domain = pci_domain_nr(adev->pdev->bus);
> +	dev = PCI_SLOT(adev->pdev->devfn);
> +	fn = PCI_FUNC(adev->pdev->devfn);
> +


> +	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);

You need to grab the VM lock before calling this.

Something like amdgpu_bo_reserve(vm->root.bo, 
false)/amdgpu_bo_unreserve(vm->root.bo) should do it.

Apart from that looks good to me.

Regards,
Christian.

> +	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
> +			dev, fn, fpriv->vm.pasid);
> +	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
> +	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
> +	seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1345f7eba011..de728632b5df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1304,6 +1304,26 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>   }
>   
> +void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
> +				uint64_t *gtt_mem, uint64_t *cpu_mem)
> +{
> +	unsigned int domain;
> +
> +	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
> +	switch (domain) {
> +	case AMDGPU_GEM_DOMAIN_VRAM:
> +		*vram_mem += amdgpu_bo_size(bo);
> +		break;
> +	case AMDGPU_GEM_DOMAIN_GTT:
> +		*gtt_mem += amdgpu_bo_size(bo);
> +		break;
> +	case AMDGPU_GEM_DOMAIN_CPU:
> +	default:
> +		*cpu_mem += amdgpu_bo_size(bo);
> +		break;
> +	}
> +}
> +
>   /**
>    * amdgpu_bo_release_notify - notification about a BO being released
>    * @bo: pointer to a buffer object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 973c88bdf37b..659406475c2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -304,6 +304,8 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>   int amdgpu_bo_validate(struct amdgpu_bo *bo);
> +void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
> +				uint64_t *gtt_mem, uint64_t *cpu_mem);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
>   uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f95bcda8463f..7c7a387c2285 100644
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
> @@ -1718,6 +1719,50 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
> +				uint64_t *gtt_mem, uint64_t *cpu_mem)
> +{
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +				gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +				gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +				gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +				gtt_mem, cpu_mem);
> +	}
> +	spin_lock(&vm->invalidated_lock);
> +	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +				gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +				gtt_mem, cpu_mem);
> +	}
> +	spin_unlock(&vm->invalidated_lock);
> +}
>   /**
>    * amdgpu_vm_bo_update - update all BO mappings in the vm page table
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 848e175e99ff..7f670d603895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -457,6 +457,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>   void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
> +void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
> +				uint64_t *gtt_mem, uint64_t *cpu_mem);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
