Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB8C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 14:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3A16128D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 14:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3A16128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14ED16E055;
	Wed,  7 Apr 2021 14:20:35 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A456E92D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 14:20:33 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id w28so28752302lfn.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Apr 2021 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5C7imrHkGeU9UD94AvVduK1+ZeZfy8b62Ujx5UM4wVk=;
 b=TO7H7H64/mkZxmsXLV1iCyaFg3nw9FHn1Ov/Ul6k4n2YSlbOcD7foDmhQffClbY0EQ
 c1jmmg88Fn+Q4gqg3Q+gL0hQED+7VKlIYW9sFj5TNA7TAdWnoxzZp+AwB5KyaOT+Pl/Y
 oVyAoI6KvDkrwqZ4sBRa9AKB8HE7qM38Qu++Z/b905xci9pyObxlXhcYNqly8PhRa+rc
 ROjjS5UYdxrL7iRbJqTKyhJSriWuWPco49G2DFIYzNOJ7jwdc8Fbhsh/CDJ3gp6H+XNp
 RUYRC5jwxzxcSyrSYTiWA6agAIlw4fbD1OaGvbl/l45S9Dz7KZSODbQLiUGFq2t3HssV
 LWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5C7imrHkGeU9UD94AvVduK1+ZeZfy8b62Ujx5UM4wVk=;
 b=kr5Rfoee0T/QhgZfN8cqCxQFsEOzPs4x4yGCeqGmUft2VX86wqbbZuJIckMBOcEVgp
 I5q71jW4GxBFyjkIPhUI/2glGFrsvQxOsnRC6OFuQBSjfXAvAeYS3RqCa7upnntOG676
 HY0A6TNMTXKSKt+DOmUq0deBkStDId4FBrP+WdZoGwxUfQBuMUbzmqGJVAKXTfLcBx98
 8LU20Ir9Zaxgz6NL7ZM8k4ejAYh7U2EoJPrTztPHKFk6x5uWuObCC5hHpzk33903y162
 3xZpCVRNVmjBNGQx0mq0qOfIahezKi+ThzQ1v3Qh4zGzCp+hGbmMdrveniN8eVhiHsP6
 hgVQ==
X-Gm-Message-State: AOAM531737BrfzSw15ApjpsuqGDuivu/xoz/nRl943tgaXeymn9FtyQv
 jkHqeCXb9DDbSzwT03xlV4OHMhOgwbU=
X-Google-Smtp-Source: ABdhPJwHYfk07I/7/b3J/BPbEYu6zjlab4sJFftEnK8af5zeZA5OnqeYfgroJ7JEjjRISdwdr8J5Fw==
X-Received: by 2002:a05:6512:10c5:: with SMTP id
 k5mr2783900lfg.320.1617805231997; 
 Wed, 07 Apr 2021 07:20:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0?
 ([2a02:908:1252:fb60:c8cb:bea6:b85a:47d0])
 by smtp.gmail.com with ESMTPSA id w12sm2547991ljm.50.2021.04.07.07.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Apr 2021 07:20:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Add show_fdinfo() interface
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210407133105.39702-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eab015a4-8780-72fb-7212-01f9da0b80d4@gmail.com>
Date: Wed, 7 Apr 2021 16:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407133105.39702-1-Roy.Sun@amd.com>
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
Cc: Alexander.Deucher@amd.com, David M Nieto <David.Nieto@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.04.21 um 15:31 schrieb Roy Sun:
> Tracking devices, process info and fence info using
> /proc/pid/fdinfo
>
> Signed-off-by: David M Nieto <David.Nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 247 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  51 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   1 +
>   6 files changed, 306 insertions(+), 1 deletion(-)
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
> index 000000000000..72e61a89c0ea
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -0,0 +1,247 @@

Still no SPDX license tag.

> +/*
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
> +uint64_t amdgpu_get_proc_mem(struct drm_file *file, struct amdgpu_fpriv *fpriv)
> +{
> +	int id;
> +	struct drm_gem_object *gobj;
> +	uint64_t total = 0;
> +
> +	spin_lock(&file->table_lock);
> +	idr_for_each_entry(&file->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		unsigned int domain = amdgpu_mem_type_to_domain(
> +			bo->tbo.mem.mem_type);
> +
> +		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> +			total += amdgpu_bo_size(bo);

Why only VRAM memory?

> +	}
> +	spin_unlock(&file->table_lock);

This should probably be as helper in the amdgpu_gem.c file.

> +
> +	if (fpriv->vm.process_info) {
> +		struct kgd_mem *mem;
> +
> +		mutex_lock(&fpriv->vm.process_info->lock);
> +		list_for_each_entry(mem, &fpriv->vm.process_info->kfd_bo_list,
> +			validate_list.head) {
> +			struct amdgpu_bo *bo = mem->bo;
> +			unsigned int domain = amdgpu_mem_type_to_domain(
> +				bo->tbo.mem.mem_type);
> +
> +			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> +				total += amdgpu_bo_size(bo);
> +			}
> +
> +		list_for_each_entry(mem, &fpriv->vm.process_info->userptr_valid_list,
> +			validate_list.head) {
> +			struct amdgpu_bo *bo = mem->bo;
> +			unsigned int domain = amdgpu_mem_type_to_domain(
> +				bo->tbo.mem.mem_type);
> +
> +			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> +				total += amdgpu_bo_size(bo);
> +		}
> +
> +		mutex_unlock(&fpriv->vm.process_info->lock);

This needs to be moved into the VM or even better the 
amdkfd_process_info code.

> +	}
> +
> +	return total;
> +}
> +
> +uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed)
> +{
> +	struct amdgpu_ctx_entity *centity;
> +	struct idr *idp;
> +	struct amdgpu_ctx *ctx;
> +	uint32_t id, i;
> +	uint64_t now, t1, t2;
> +	uint64_t total = 0, min = 0;
> +
> +
> +	if (idx >= AMDGPU_MAX_ENTITY_NUM)
> +		return 0;
> +
> +	idp = &fpriv->ctx_mgr.ctx_handles;
> +
> +	mutex_lock(&fpriv->ctx_mgr.lock);
> +	idr_for_each_entry(idp, ctx, id) {
> +		if (!ctx->entities[hwip][idx])
> +			continue;
> +
> +		centity = ctx->entities[hwip][idx];
> +
> +		for (i = 0; i < amdgpu_sched_jobs; i++) {
> +			struct dma_fence *fence;
> +			struct drm_sched_fence *s_fence;
> +
> +			spin_lock(&ctx->ring_lock);
> +			fence = dma_fence_get(centity->fences[i]);
> +			spin_unlock(&ctx->ring_lock);

That is quite racy.

> +			if (!fence)
> +				continue;
> +			s_fence = to_drm_sched_fence(fence);
> +			if (!dma_fence_is_signaled(&s_fence->scheduled))
> +				continue;
> +			now = ktime_to_ns(ktime_get());
> +			t1 = ktime_to_ns(s_fence->scheduled.timestamp);
> +			t2 = !dma_fence_is_signaled(&s_fence->finished) ?
> +				0 : ktime_to_ns(s_fence->finished.timestamp);
> +			dma_fence_put(fence);
> +
> +			t1 = now - t1;
> +			t2 = (t2 == 0) ? 0 : now - t2;
> +
> +			total += t1 - t2;
> +			if (t1 > min)
> +				min = t1;

Please use ktime for the calculation here.

> +		}
> +
> +	}
> +
> +	mutex_unlock(&fpriv->ctx_mgr.lock);

Again that needs to be in the ctx handling code in general.

> +
> +	if (elapsed)
> +		*elapsed = min;
> +
> +	return total;
> +}
> +
> +uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id)
> +{
> +	enum amd_ip_block_type type;
> +	uint32_t count = 0;
> +	int i;
> +
> +	switch (id) {
> +	case AMDGPU_HW_IP_GFX:
> +		type = AMD_IP_BLOCK_TYPE_GFX;
> +		break;
> +	case AMDGPU_HW_IP_COMPUTE:
> +		type = AMD_IP_BLOCK_TYPE_GFX;
> +		break;
> +	case AMDGPU_HW_IP_DMA:
> +		type = AMD_IP_BLOCK_TYPE_SDMA;
> +		break;
> +	case AMDGPU_HW_IP_UVD:
> +		type = AMD_IP_BLOCK_TYPE_UVD;
> +		break;
> +	case AMDGPU_HW_IP_VCE:
> +		type = AMD_IP_BLOCK_TYPE_VCE;
> +		break;
> +	case AMDGPU_HW_IP_UVD_ENC:
> +		type = AMD_IP_BLOCK_TYPE_UVD;
> +		break;
> +	case AMDGPU_HW_IP_VCN_DEC:
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		type = AMD_IP_BLOCK_TYPE_VCN;
> +		break;
> +	case AMDGPU_HW_IP_VCN_JPEG:
> +		type = (amdgpu_device_ip_get_ip_block(adev,
> +			AMD_IP_BLOCK_TYPE_JPEG)) ?
> +			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++)
> +		if (adev->ip_blocks[i].version->type == type &&
> +		    adev->ip_blocks[i].status.valid &&
> +		    count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
> +			count++;
> +	return count;
> +
> +}

Please just completely drop that and use AMDGPU_HW_IP_* directly.

We certainly don't want decode and encode show up as one value.

> +
> +void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +	uint32_t bus, dev, fn, i;
> +
> +	if (amdgpu_file_to_fpriv(f, &fpriv))
> +		return;
> +	struct drm_file *file = f->private_data;
> +	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +
> +	bus = adev->pdev->bus->number;
> +	dev = PCI_SLOT(adev->pdev->devfn);
> +	fn = PCI_FUNC(adev->pdev->devfn);
> +	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
> +			fpriv->vm.pasid);
> +
> +	seq_printf(m, "mem:\t%llu kB\n", amdgpu_get_proc_mem(file, fpriv)/1024UL);
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> +		uint32_t enabled = amdgpu_get_ip_count(adev, i);
> +		uint32_t count = amdgpu_ctx_num_entities[i];
> +		int idx = 0;
> +		uint64_t total = 0, min = 0;
> +		uint32_t perc, frac;
> +
> +		if (enabled) {

Please rather use "if (!enabled) continue style here.

Regards,
Christian.

> +			for (idx = 0; idx < count; idx++) {
> +				total = amdgpu_get_fence_usage(fpriv,
> +					i, idx, &min);
> +
> +				if ((total == 0) || (min == 0))
> +					continue;
> +
> +				perc = div64_u64(10000 * total, min);
> +				frac = perc % 100;
> +
> +				seq_printf(m, "%s%d:\t%d.%d%%\n",
> +						amdgpu_ip_name[i],
> +						idx, perc/100, frac);
> +			}
> +		}
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> new file mode 100644
> index 000000000000..4d73a820f7e7
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> @@ -0,0 +1,51 @@
> +/*
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
> +struct amdgpu_proc;
> +struct amdgpu_ctx;
> +uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
> +
> +uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed);
> +
> +uint64_t amdgpu_get_proc_mem(struct drm_file *file, struct amdgpu_fpriv *fpriv);
> +
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

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
