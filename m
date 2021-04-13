Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF87C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5416109D
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5416109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E7989CD9;
	Tue, 13 Apr 2021 12:54:05 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF1289C1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:54:03 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id g5so19042791ejx.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jNn71djwgrOaJvPIevG9GO9cxm7GetgheKousM8rV1Y=;
 b=QQyvebNLasw6MAZAfCprsfDImgbNbN11QQgOOL6o2onNoNKGk15QND+HAD9q9zX0fC
 jaJ83WN+bAdmLdbTHekegcC7wCxsjhf/hPNwUVGVrlm11CzobTb5XhvX00ct5hm/EodR
 IDAy8o+tn8tUXV6sgt+jXQRMm0Ji6HZbNtsY6XHPUpbz2h3ejd+KOJrPfTCaZQp2MMDP
 YgbZfC1hT6uj0vVCtrJGJuXDeHlGNzZm/SneWNx72kZMdTbZdF0GX6rA5tuXo/lq3+B9
 MvCbck/q28XBceV4yoCmRY+hWaUwBNVuw+W3g/oaacd34xK0h5ptucqt5z96B5lrw2Ub
 qkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jNn71djwgrOaJvPIevG9GO9cxm7GetgheKousM8rV1Y=;
 b=n+okfQo1aHJ1CKARMoTcZVeVQda/MLO7B0OirwQVFxhRq9RZTo/rOpuMC7xNCpWrqV
 lmp/l5GSadfNNKZ8n5CAUHNXf11KCiX0CJAnsy0Zvap+A2ofaSEfa7tFbzGfYKfvOGdJ
 cqL9RJ1KNXVjUTaQVhMjwcQihCNs8MO7/wKstZ8ua+gXEFETUBZ1qwlOsNdCgaplBZ4t
 rdqGlo7YOSkcNad5dIlAdstiGJ+XAAWdR+131uprGT6Lxo0IR7uBUiN+a/rNi+8RJBPQ
 v6SlJ43W4IGH8AxXvXTIrj51bwlvAKwtkBOExsK4k5cXhkr44NnI5B7ktg4T1gucJf+O
 3hig==
X-Gm-Message-State: AOAM531jmPTXAOpQ6buCPaWw6t9uXsx3/OwbJOzIlhBX2Pfdf/aH+nGz
 m8OR7CRYLRwati+bx2g2bGrKhaf9ymA=
X-Google-Smtp-Source: ABdhPJwbtsgOJ2qtMY7ktb6mTjJlBh/apJWllrYEeZbWC56uHpQI/6YDMGPIVu4ADV9euPvjqzjSlg==
X-Received: by 2002:a17:907:2d14:: with SMTP id
 gs20mr26037932ejc.449.1618318441842; 
 Tue, 13 Apr 2021 05:54:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587?
 ([2a02:908:1252:fb60:acbc:5f44:93b6:4587])
 by smtp.gmail.com with ESMTPSA id t15sm10133044edw.84.2021.04.13.05.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 05:54:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210413121444.36903-1-Roy.Sun@amd.com>
 <20210413121444.36903-2-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <55049ce7-2a70-b6ec-38cf-b7d9d610e64c@gmail.com>
Date: Tue, 13 Apr 2021 14:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413121444.36903-2-Roy.Sun@amd.com>
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

Am 13.04.21 um 14:14 schrieb Roy Sun:
> Tracking devices, process info and fence info using
> /proc/pid/fdinfo
>
> Signed-off-by: David M Nieto <David.Nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  59 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 149 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  43 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  21 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  35 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   2 +
>   12 files changed, 321 insertions(+), 3 deletions(-)
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
> index 0350205c4897..8d33571754d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -651,3 +651,62 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	idr_destroy(&mgr->ctx_handles);
>   	mutex_destroy(&mgr->lock);
>   }
> +
> +ktime_t amdgpu_ctx_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed)

That starts to look better, but please change this function so that it 
gets a amdgpu_ctx_mgr structure as first parameter and rename it to 
amdgpu_ctx_mgr_fence_usage.

> +{
> +	struct amdgpu_ctx_entity *centity;
> +	struct idr *idp;
> +	struct amdgpu_ctx *ctx;
> +	uint32_t id, i;
> +	ktime_t now, t1;
> +	ktime_t total = 0, max = 0;
> +
> +
> +	if (idx >= AMDGPU_MAX_ENTITY_NUM)
> +		return 0;
> +
> +	idp = &fpriv->ctx_mgr.ctx_handles;
> +
> +	mutex_lock(&fpriv->ctx_mgr.lock);
> +	idr_for_each_entry(idp, ctx, id) {

Maybe move everything from here till the end of the loop into a separate 
function.

> +		if (!ctx->entities[hwip][idx])
> +			continue;
> +
> +		centity = ctx->entities[hwip][idx];
> +		now = ktime_get();
> +		for (i = 0; i < amdgpu_sched_jobs; i++) {
> +			struct dma_fence *fence;
> +			struct drm_sched_fence *s_fence;
> +
> +			spin_lock(&ctx->ring_lock);
> +			fence = dma_fence_get(centity->fences[i]);
> +			spin_unlock(&ctx->ring_lock);
> +			if (!fence)
> +				continue;
> +			s_fence = to_drm_sched_fence(fence);
> +			if (!dma_fence_is_signaled(&s_fence->scheduled))
> +				continue;
> +			t1 = s_fence->scheduled.timestamp;
> +			if (t1 >= now)
> +				continue;
> +			if (dma_fence_is_signaled(&s_fence->finished) &&
> +						s_fence->finished.timestamp < now)

That is indented to far to the right, the "s_fence..." should be below 
the "dma_fence..." in the line above.

> +				total += ktime_sub(s_fence->finished.timestamp, t1);
> +			else
> +				total += ktime_sub(now, t1);
> +			t1 = ktime_sub(now, t1);
> +			dma_fence_put(fence);
> +			if (t1 > max)
> +				max = t1;

Please write this as "max = max(max, t1);".

> +		}
> +
> +	}
> +
> +	mutex_unlock(&fpriv->ctx_mgr.lock);
> +
> +	if (elapsed)
> +		*elapsed = max;
> +
> +	return total;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index f54e10314661..8ee42f12e5f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -87,5 +87,6 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
> -
> +ktime_t amdgpu_ctx_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed);

Please keep the empty line between the declarations and the #endif.

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
> index 000000000000..6243b79a335f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -0,0 +1,149 @@
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

Again, why do you need this? Just expose the raw data you have in the 
context.

> +
> +	for (i = 0; i < adev->num_ip_blocks; i++)
> +		if (adev->ip_blocks[i].version->type == type &&
> +		    adev->ip_blocks[i].status.valid &&
> +		    count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
> +			return 1;
> +	return 0;
> +}
> +
> +void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +	uint32_t bus, dev, fn, i;
> +	uint64_t vram_mem, gtt_mem;
> +	struct drm_file *file = f->private_data;
> +	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +
> +	if (amdgpu_file_to_fpriv(f, &fpriv))
> +		return;
> +	bus = adev->pdev->bus->number;
> +	dev = PCI_SLOT(adev->pdev->devfn);
> +	fn = PCI_FUNC(adev->pdev->devfn);
> +
> +	vram_mem = amdgpu_vm_memory(fpriv, AMDGPU_GEM_DOMAIN_VRAM) +
> +		amdgpu_gem_memory(file, AMDGPU_GEM_DOMAIN_VRAM, fpriv);
> +	gtt_mem = amdgpu_vm_memory(fpriv, AMDGPU_GEM_DOMAIN_GTT) +
> +		amdgpu_gem_memory(file, AMDGPU_GEM_DOMAIN_GTT, fpriv);

The VRAM and GTT usage should probably be determined in one call to 
those functions, otherwise they are not really valid.

> +	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
> +			fpriv->vm.pasid);
> +	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
> +	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> +		uint32_t enabled = amdgpu_get_ip_count(adev, i);
> +		uint32_t count = amdgpu_ctx_num_entities[i];
> +		int idx = 0;
> +		uint64_t total = 0, min = 0;
> +		uint32_t perc, frac;
> +
> +		if (enabled) {
> +
> +			for (idx = 0; idx < count; idx++) {
> +				total = amdgpu_ctx_fence_usage(fpriv,
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 311bcdc59eda..6711c7653c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -740,6 +740,27 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +uint64_t amdgpu_gem_memory(struct drm_file *file, unsigned int domain,
> +			struct amdgpu_fpriv *fpriv)
> +{
> +	int id;
> +	struct drm_gem_object *gobj;
> +	uint64_t total = 0;
> +
> +	spin_lock(&file->table_lock);
> +	idr_for_each_entry(&file->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		unsigned int m_domain = amdgpu_mem_type_to_domain(
> +			bo->tbo.mem.mem_type);
> +
> +		if (m_domain == domain)
> +			total += amdgpu_bo_size(bo);
> +	}
> +	spin_unlock(&file->table_lock);

BTW: This isn't accurate. The same memory can be opened under multiple 
handles.

Getting this from the VM subsystem would be better.

> +
> +	return total;
> +}
> +
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			struct drm_file *filp)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index 637bf51dbf06..017f034370fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -70,5 +70,6 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   
>   int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   				struct drm_file *filp);
> -
> +uint64_t amdgpu_gem_memory(struct drm_file *file, unsigned int domain,
> +			struct amdgpu_fpriv *fpriv);
>   #endif
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
> index daf926a63c51..073205f2fce2 100644
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
> @@ -3286,6 +3287,40 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   	get_task_comm(vm->task_info.process_name, current->group_leader);
>   }
>   
> +uint64_t amdgpu_vm_memory(struct amdgpu_fpriv *fpriv,
> +			unsigned int domain)
> +{
> +	uint64_t total = 0;
> +
> +	if (fpriv->vm.process_info) {

Please rather use "if (!fpriv->vm.process_info) return" here.

Christian.

> +		struct kgd_mem *mem;
> +
> +		mutex_lock(&fpriv->vm.process_info->lock);
> +		list_for_each_entry(mem, &fpriv->vm.process_info->kfd_bo_list,
> +			validate_list.head) {
> +			struct amdgpu_bo *bo = mem->bo;
> +			unsigned int m_domain = amdgpu_mem_type_to_domain(
> +				bo->tbo.mem.mem_type);
> +
> +			if (m_domain == domain)
> +				total += amdgpu_bo_size(bo);
> +			}
> +
> +		list_for_each_entry(mem, &fpriv->vm.process_info->userptr_valid_list,
> +			validate_list.head) {
> +			struct amdgpu_bo *bo = mem->bo;
> +			unsigned int m_domain = amdgpu_mem_type_to_domain(
> +				bo->tbo.mem.mem_type);
> +			if (m_domain == domain)
> +				total += amdgpu_bo_size(bo);
> +		}
> +
> +		mutex_unlock(&fpriv->vm.process_info->lock);
> +	}
> +
> +	return total;
> +}
> +
>   /**
>    * amdgpu_vm_handle_fault - graceful handling of VM faults.
>    * @adev: amdgpu device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 976a12e5a8b9..88e4950dccfd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -447,6 +447,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +uint64_t amdgpu_vm_memory(struct amdgpu_fpriv *fpriv, unsigned int domain);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
