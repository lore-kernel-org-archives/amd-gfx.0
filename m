Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80862C54FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 11:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A6010E268;
	Thu, 16 Nov 2023 11:11:25 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C021910E268
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 11:11:22 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40838915cecso5267755e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 03:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700133081; x=1700737881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fw7EMDPsjW5B0WvPq6tPMZM1EXUaJoJYkR3b56qPMJg=;
 b=PX0VLytwkVwdsN4D3fN/l8pe0PPB01duxpNaYtgTF2oXGQi/w2kmNX9UG69qnagSj5
 GVZ/Vsvrezm1WMlQWc+xAZbJcDzfghEnFMm/MN+KElJPoBCc40WkYxxsGOOP2nXqE1IE
 fxXetB5l8i2eWxWsv+KG/86B5gcd4pZc95e1Xj8yOuO+hdRQ3Zr8VYkCqgwbdsNCqsVo
 V/dS3W8qNEr8j7vD7VCvzaTdVZCQ/wYuGhADwfCmkzl0gtsXXUzwizelHaxsiFjWk2+U
 cXSP1UI56vLxbdCXVDVra394zqZ0DmGhviQ2LKSNsLUldGoSfsAFzXP+aw3w6Aj1D3Bw
 wb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700133081; x=1700737881;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fw7EMDPsjW5B0WvPq6tPMZM1EXUaJoJYkR3b56qPMJg=;
 b=rmkrIILED1dwkjfu0UUrQLBKHa2QjTV1t0t3yNkL21dP7UFpjPuKl3j0sy9Lo3v3Z0
 37f9gTSaWofbgz+BckMxCDSZ9sEGQ3Xd9ugmdjO6KSCxFl28JdT5e9jyiZhvlCDcYRXn
 PkSGLJcFi4FoHX1MOYou9m3xG8qArxSXCxAGIf0JSXvva6jMIbO9qH2dyOFv6Eig0eYH
 RWJwmrUXUdbg5uew8oRQ0POvpXkvLFaEH3e0ru3QLKPdIiWwTW9mGzyRyHibjhbFyF6r
 xlkT49Xzo3IhwjosoMomrUlXvEjFYoqus/CTtSMcVrYtcbCe5v+47InVAicHBrRa/Htn
 ui3A==
X-Gm-Message-State: AOJu0Yy/r+lV28sBrA54PdgGZakyfp3XgBOhGqhsizXrsv7RWSbVBwJM
 OPdXZmRUk/W9LGYYGV555PcEd2+VHe0=
X-Google-Smtp-Source: AGHT+IFhh2/pcz/odFrldaBhkqHHpk5a3ToCOuzbU178zpmKboQsAyLfKCdzpF/WEQOunlXE7iTduA==
X-Received: by 2002:a05:600c:350f:b0:405:49aa:d578 with SMTP id
 h15-20020a05600c350f00b0040549aad578mr12500852wmq.37.1700133080788; 
 Thu, 16 Nov 2023 03:11:20 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c444300b004063c9f68f2sm3185583wmn.26.2023.11.16.03.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 03:11:20 -0800 (PST)
Message-ID: <f1b877d8-d446-4a50-9a0e-1f0c99c164ed@gmail.com>
Date: Thu, 16 Nov 2023 12:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Enable checkpoint and restore of VRAM Bos with
 no VA
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231116024705.591555-1-Ramesh.Errabolu@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231116024705.591555-1-Ramesh.Errabolu@amd.com>
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



Am 16.11.23 um 03:47 schrieb Ramesh Errabolu:
> Tag VRAM BOs that do not have a VA with a unique Id, a 128-bit
> UUID. This unique Id is used to distinguish BOs that might
> otherwise be of same size. Checkpoint and restore assumes
> that these BOs are not imported into a DRM device that is
> accessible either from current process or its parent or
> child process
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  29 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c      | 190 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h      | 103 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  17 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  30 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
>   9 files changed, 370 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 260e32ef7bae..851e2c4db372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -270,7 +270,8 @@ amdgpu-y += \
>   	amdgpu_amdkfd_gc_9_4_3.o \
>   	amdgpu_amdkfd_gfx_v10.o \
>   	amdgpu_amdkfd_gfx_v10_3.o \
> -	amdgpu_amdkfd_gfx_v11.o
> +	amdgpu_amdkfd_gfx_v11.o \
> +	amdgpu_criu.o
>   
>   ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
>   amdgpu-y += amdgpu_amdkfd_gfx_v7.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fcf8a98ad15e..6c0d7e6a66cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -289,7 +289,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		struct amdgpu_device *adev, uint64_t va, uint64_t size,
>   		void *drm_priv, struct kgd_mem **mem,
> -		uint64_t *offset, uint32_t flags, bool criu_resume);
> +		uint64_t *offset, uint32_t flags,
> +		bool criu_resume, uuid_t *uuid);
>   int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
>   		uint64_t *size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2e302956a279..b139ffd519e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -25,6 +25,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/task.h>
> +#include <linux/uuid.h>
>   #include <drm/ttm/ttm_tt.h>
>   
>   #include "amdgpu_object.h"
> @@ -35,6 +36,7 @@
>   #include "amdgpu_dma_buf.h"
>   #include <uapi/linux/kfd_ioctl.h>
>   #include "amdgpu_xgmi.h"
> +#include "amdgpu_criu.h"
>   #include "kfd_priv.h"
>   #include "kfd_smi_events.h"
>   
> @@ -1718,7 +1720,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		struct amdgpu_device *adev, uint64_t va, uint64_t size,
>   		void *drm_priv, struct kgd_mem **mem,
> -		uint64_t *offset, uint32_t flags, bool criu_resume)
> +		uint64_t *offset, uint32_t flags,
> +		bool criu_resume, uuid_t *uuid)
>   {
>   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>   	struct amdgpu_fpriv *fpriv = container_of(avm, struct amdgpu_fpriv, vm);
> @@ -1814,13 +1817,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		 va, (*mem)->aql_queue ? size << 1 : size,
>   		 domain_string(alloc_domain), xcp_id);
>   
> -	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
> -				       bo_type, NULL, &gobj, xcp_id + 1);
> +	/* Construction of VRAM BO one with no VA, during CRIU Restore
> +	 * should consult BO table. Will return either a previously
> +	 * constructed BO or will construct a BO anew
> +	 */
> +	if (criu_resume && (va == 0) && (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
> +		ret = restore_vram_bo(adev, aligned_size, 1, alloc_flags, uuid,
> +				&gobj, xcp_id + 1);
> +	else
> +		ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain,
> +				alloc_flags, bo_type, NULL, &gobj, xcp_id + 1);
> +
>   	if (ret) {
>   		pr_debug("Failed to create BO on domain %s. ret %d\n",
>   			 domain_string(alloc_domain), ret);
>   		goto err_bo_create;
>   	}
> +
>   	ret = drm_vma_node_allow(&gobj->vma_node, drm_priv);
>   	if (ret) {
>   		pr_debug("Failed to allow vma node access. ret %d\n", ret);
> @@ -1843,6 +1856,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   
>   	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
>   
> +	/* Initialize the UUID field of a BO that:
> +	 *     - Represents a VRAM BO
> +	 *     - Does not have a VA bound
> +	 *     - Is allocated outside CRIU Resume procedure
> +	 */
> +	if (!criu_resume && (va == 0) && (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)) {
> +		if (uuid_is_null(&bo->uuid))
> +			uuid_gen(&bo->uuid);
> +	}
> +
>   	if (user_addr) {
>   		pr_debug("creating userptr BO for user_addr = %llx\n", user_addr);
>   		ret = init_user_pages(*mem, user_addr, criu_resume);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
> new file mode 100644
> index 000000000000..4b43a3df6913
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +
> +#include "amdgpu_criu.h"
> +
> +/*
> + * Hash table to host BOs that have their unique IDs initialized
> + * The table comes into play during CRIU Restore procedure
> + *
> + * @note: Currently these BOs encapsulate device memory i.e. are
> + * VRAM BOs
> + */
> +DECLARE_HASHTABLE(criu_bo_table, CRIU_BO_TABLE_SIZE);
> +static DEFINE_MUTEX(criu_mutex);
> +
> +/* Global counter to track life of Hash table */
> +atomic_t criu_bo_counter = ATOMIC_INIT(0);
> +
> +void print_uuid(uuid_t *uuid)

All non-static function should have an amdgpu_ prefix.



> +{
> +	pr_err("\n");
> +	for (int idx = 0; idx < 16; idx++)
> +		pr_err("Idx[%d] %d\n", idx, uuid->b[idx]);
> +	pr_err("\n");
> +}
> +
> +void print_uuid_compare(uuid_t *uuid1, uuid_t *uuid2)
> +{
> +	pr_err("\n");
> +	for (int idx = 0; idx < 16; idx++)
> +		pr_err("Idx[%d] %d,  %d\n", idx, uuid1->b[idx], uuid2->b[idx]);
> +	pr_err("\n");
> +}
> +
> +void inc_table_counter(uint32_t cntr)
> +{
> +	int init;
> +
> +	mutex_lock(&criu_mutex);
> +	init = atomic_read(&criu_bo_counter);
> +	if (init == 0x00) {
> +		pr_debug("%s(), Invoking hash_init api\n", __func__);
> +		hash_init(criu_bo_table);
> +	}
> +
> +	atomic_add(cntr, &criu_bo_counter);
> +	init = atomic_read(&criu_bo_counter);
> +	mutex_unlock(&criu_mutex);
> +}
> +
> +static void free_bo_table(void)
> +{
> +	struct criu_bo_uuid *bo_uuid = NULL;
> +	uint32_t bkt;
> +
> +	hash_for_each_rcu(criu_bo_table, bkt, bo_uuid, node)
> +		hash_del_rcu(&bo_uuid->node);
> +}
> +
> +void dec_table_counter(uint32_t cntr)
> +{
> +	uint32_t deinit;
> +
> +	mutex_lock(&criu_mutex);
> +	atomic_sub(cntr, &criu_bo_counter);
> +	deinit = atomic_read(&criu_bo_counter);
> +	if (deinit == 0x00) {
> +		pr_debug("%s(), Invoking free_bo_table api\n", __func__);
> +		free_bo_table();
> +	}
> +
> +	if (deinit < 0)
> +		pr_err("%s(), BO Table counter is inconsistent: %d\n", __func__, deinit);
> +
> +	mutex_unlock(&criu_mutex);
> +}
> +
> +uint32_t query_table_counter(void)
> +{
> +	uint32_t cntr;
> +
> +	mutex_lock(&criu_mutex);
> +	cntr = atomic_read(&criu_bo_counter);
> +	mutex_unlock(&criu_mutex);
> +	return cntr;
> +}
> +
> +/* Determine if BO is present in Hash table */
> +static void add_bo_uuid(struct criu_bo_uuid *bo_uuid)
> +{
> +	mutex_lock(&criu_mutex);
> +	hash_add_rcu(criu_bo_table, &bo_uuid->node, (uintptr_t)bo_uuid->uuid);
> +	mutex_unlock(&criu_mutex);
> +}
> +
> +/* Determine if BO is present in Hash table
> + *
> + * @note: Does the look up object based on value of key
> + * and not just its integer value
> + */
> +static struct criu_bo_uuid *get_bo_uuid(uuid_t *uuid)
> +{
> +	struct criu_bo_uuid *bo_uuid = NULL;
> +	uint32_t bkt;
> +
> +	mutex_lock(&criu_mutex);
> +	hash_for_each_rcu(criu_bo_table, bkt, bo_uuid, node)
> +		if (uuid_equal(uuid, bo_uuid->uuid))
> +			goto ret_abo;
> +
> +ret_abo:
> +	mutex_unlock(&criu_mutex);
> +	return bo_uuid;
> +}
> +
> +int restore_vram_bo(struct amdgpu_device *adev,
> +		    unsigned long size, int align, u64 flags,
> +		    uuid_t *uuid, struct drm_gem_object **gobj, int8_t xcp_id_plus1)
> +{
> +	enum ttm_bo_type bo_type = ttm_bo_type_device;
> +	u32 domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	struct criu_bo_uuid *bo_uuid;
> +	struct amdgpu_bo *abo;
> +	int ret;
> +
> +	/* Determine if VRAM was built originally for exporting it
> +	 * to peers. Currently the only VRAM BOs that are exportable
> +	 * are those that do not have a VA attached
> +	 */
> +	if (unlikely(uuid == NULL)) {
> +		pr_err("A NULL UUID is Illegal for VRAM BOs without a VA\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Determine if BO is already present in hash table */
> +	bo_uuid = get_bo_uuid(uuid);
> +
> +	/* Return the BO present in table */
> +	if (bo_uuid != NULL) {
> +		abo = bo_uuid->abo;
> +		*gobj = &(abo->tbo.base);
> +		return 0;
> +	}
> +
> +	/* Build the BO and add it to table before returning it */
> +	ret = amdgpu_gem_object_create(adev, size, align,
> +			domain, flags, bo_type, NULL, gobj, xcp_id_plus1);
> +	if (ret) {
> +		pr_err("Failed to Restore VRAM BO, Retval: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Re-init uuid of BO that identifies it uniquely and
> +	 * add the BO into the table
> +	 */
> +	abo = gem_to_amdgpu_bo(*gobj);
> +	uuid_copy(&(abo->uuid), uuid);
> +	bo_uuid = kzalloc(sizeof(*bo_uuid), GFP_KERNEL);
> +	if (bo_uuid == NULL)
> +		return -EINVAL;
> +	bo_uuid->abo = abo;
> +	bo_uuid->uuid = uuid;
> +	add_bo_uuid(bo_uuid);
> +
> +	/* Return the BO that was built */
> +	*gobj = &(abo->tbo.base);
> +	return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
> new file mode 100644
> index 000000000000..b895c698a2e0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: MIT
> + *
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +#ifndef AMDGPU_CRIU_H_INCLUDED
> +#define AMDGPU_CRIU_H_INCLUDED
> +
> +#include <linux/list.h>
> +#include <linux/atomic.h>
> +#include <linux/pagemap.h>
> +#include <linux/dma-buf.h>
> +#include <linux/sched/mm.h>
> +#include <linux/hashtable.h>
> +#include <linux/sched/task.h>
> +#include <uapi/linux/kfd_ioctl.h>
> +
> +#include "amdgpu_object.h"
> +#include "amdgpu_gem.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_amdkfd.h"
> +#include "amdgpu_dma_buf.h"
> +
> +/* Specify Hash table and its size to host VRAM BOs that have their
> + * unique IDs iniialized. These BOs which can be exported as Dmabuf
> + * allows user space to bind different virtual addresses on different
> + * DRM devices.
> + *
> + * @note: Currently these BOs encapsulate device memory i.e. are VRAM BOs
> + */
> +#define CRIU_BO_TABLE_SIZE	    8
> +extern DECLARE_HASHTABLE(criu_bo_table, CRIU_BO_TABLE_SIZE);
> +
> +struct criu_bo_uuid {
> +
> +	/* Unique ID of BO, serves the role of KEY */
> +	uuid_t *uuid;
> +
> +	/* Handle of BO, serves the role of VALUE */
> +	struct amdgpu_bo *abo;
> +
> +	/* Allows chaining of BO being managed by table */
> +	struct hlist_node node;
> +};
> +
> +
> +/* Global counter to track life of Hash table */
> +extern atomic_t criu_bo_counter;
> +
> +/**
> + * restore_vram_bo() - Returns handle of a GEM object either by look up
> + * or by construction. Look up a Global BO table to determine if the BO
> + * of concern has already been constructed. By construction if the look
> + * up fails to find the BO in the global BO table
> + *
> + * NOTE: Following two conditions must be held TRUE when invoking this method
> + *  - This method deals with VRAM BOs only. Invoking this method to handle
> + *    BOs of other kinds is invalid.
> + *  - This method is invoked during a CRIU Restore procedure. An Invocation
> + *    outside of this scneario is invalid
> + *
> + * @adev: Handle of device to use in construction
> + * @size: BO's memory size in bytes
> + * @align: Alignment requirements, if any, in allocating memory
> + * @flags: Flags to apply in allocating memory
> + * @uuid: Handle of UUID object to be restored
> + * @gobj: Output parameter updated with handle of GEM object
> + * @xcp_id_plus1: ID of the XCD on which BO is to be created
> + *
> + * Return: ZERO if successful, a negative value in case of error
> + */
> +int restore_vram_bo(struct amdgpu_device *adev,
> +		    unsigned long size, int align, u64 flags,
> +		    uuid_t *uuid, struct drm_gem_object **gobj,
> +		    int8_t xcp_id_plus1);
> +
> +void print_uuid(uuid_t *uuid);
> +void print_uuid_compare(uuid_t *uuid1, uuid_t *uuid2);
> +
> +uint32_t query_table_counter(void);
> +void inc_table_counter(uint32_t cntr);
> +void dec_table_counter(uint32_t cntr);
> +
> +#endif	/* AMDGPU_CRIU_H_INCLUDED */
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index d28e21baef16..dc61b252fe49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -117,6 +117,23 @@ struct amdgpu_bo {
>   	 * for memory accounting.
>   	 */
>   	int8_t				xcp_id;
> +
> +	/*
> +	 * @uuid: Unique ID of a BO that is being exported. The 128-bit ID is
> +	 * considered to be unique across processes and time. One use of this
> +	 * ID is to support CRIU operations of Checkpointing & Restore.
> +	 *
> +	 * ID is a byte array of length UUID_SIZE. This is to accommodate UUID,
> +	 * a 128-bit number defined by RFC 4122. Hex string form of UUID is
> +	 * defined as a sequence of 32 hexadecimal digits, divided into five
> +	 * groups that are delimited by hyphens "-". The sequence of groups
> +	 * from length perspective is: 8-4-4-4-12.
> +	 *
> +	 * The default value of this field is set ZEROS. It is initialized to a
> +	 * NON-ZERO value when a BO is exported using GEM Prime Apis. Currently
> +	 * the only BOs that can be exported are GTT and VRAM BOs.
> +	 */
> +	uuid_t uuid;

Clear NAK to add this to the amdgpu_bo structure.

This is not related to general BO handling but a specialized use case.

What exactly are you trying to do here in the first place?

Regards,
Christian.

>   };
>   
>   struct amdgpu_bo_user {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 06988cf1db51..310a48b627ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -38,6 +38,7 @@
>   #include <linux/dma-buf.h>
>   #include <linux/fdtable.h>
>   #include <linux/processor.h>
> +#include <linux/uuid.h>
>   #include "kfd_priv.h"
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_svm.h"
> @@ -45,6 +46,7 @@
>   #include "kfd_smi_events.h"
>   #include "amdgpu_dma_buf.h"
>   #include "kfd_debug.h"
> +#include "amdgpu_criu.h"
>   
>   static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>   static int kfd_open(struct inode *, struct file *);
> @@ -1147,7 +1149,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		dev->adev, args->va_addr, args->size,
>   		pdd->drm_priv, (struct kgd_mem **) &mem, &offset,
> -		flags, false);
> +		flags, false, NULL);
>   
>   	if (err)
>   		goto err_unlock;
> @@ -1848,6 +1850,12 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>   		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
>   			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>   
> +			/* Count BOs whose VA is either zero or is equal
> +			 * to or exceed GPUVMs base address
> +			 *
> +			 * @note: BOs whose VA is below GPUVM base are
> +			 * used internally, e.g. Trap handler buffer
> +			 */
>   			if (!kgd_mem->va || kgd_mem->va > pdd->gpuvm_base)
>   				num_of_bos++;
>   		}
> @@ -1936,6 +1944,12 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   			bo_bucket->alloc_flags = (uint32_t)kgd_mem->alloc_flags;
>   			bo_priv->idr_handle = id;
>   
> +			/* Copy uuid of BO that identifies it uniquely
> +			 * Currently this is true for only VRAM BOs that
> +			 * have been exported
> +			 */
> +			uuid_copy((uuid_t *)bo_priv->uuid, &kgd_mem->bo->uuid);
> +
>   			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   				ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
>   								&bo_priv->user_addr);
> @@ -2295,6 +2309,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
>   	int ret;
>   	const bool criu_resume = true;
>   	u64 offset;
> +	uuid_t *uuid;
>   
>   	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
>   		if (bo_bucket->size !=
> @@ -2318,10 +2333,17 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
>   	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		offset = bo_priv->user_addr;
>   	}
> -	/* Create the BO */
> +
> +	/* Acquire handle of UUID of BO if need be */
> +	uuid = NULL;
> +	if ((bo_bucket->addr == 0) &&
> +	    (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
> +		uuid = (uuid_t *)bo_priv->uuid;
> +
>   	ret = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(pdd->dev->adev, bo_bucket->addr,
>   						      bo_bucket->size, pdd->drm_priv, kgd_mem,
> -						      &offset, bo_bucket->alloc_flags, criu_resume);
> +						      &offset, bo_bucket->alloc_flags,
> +							  criu_resume, uuid);
>   	if (ret) {
>   		pr_err("Could not create the BO\n");
>   		return ret;
> @@ -2728,10 +2750,12 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
>   		ret = criu_unpause(filep, p, args);
>   		break;
>   	case KFD_CRIU_OP_RESTORE:
> +		inc_table_counter(p->n_pdds);
>   		ret = criu_restore(filep, p, args);
>   		break;
>   	case KFD_CRIU_OP_RESUME:
>   		ret = criu_resume(filep, p, args);
> +		dec_table_counter(p->n_pdds);
>   		break;
>   	default:
>   		dev_dbg(kfd_device, "Unsupported CRIU operation:%d\n", args->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a40f8cfc6aa5..320408239896 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1178,7 +1178,7 @@ int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
>    * kfd_criu_svm_range_priv_data
>    */
>   
> -#define KFD_CRIU_PRIV_VERSION 1
> +#define KFD_CRIU_PRIV_VERSION 2
>   
>   struct kfd_criu_process_priv_data {
>   	uint32_t version;
> @@ -1193,6 +1193,7 @@ struct kfd_criu_device_priv_data {
>   struct kfd_criu_bo_priv_data {
>   	uint64_t user_addr;
>   	uint32_t idr_handle;
> +	uint8_t uuid[16];	/* Unique Id of BO whose size is UUID_SIZE */
>   	uint32_t mapped_gpuids[MAX_GPU_INSTANCE];
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index c10d050e1a61..1969eb9375c2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -716,7 +716,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>   
>   	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, gpu_va, size,
>   						 pdd->drm_priv, mem, NULL,
> -						 flags, false);
> +						 flags, false, NULL);
>   	if (err)
>   		goto err_alloc_mem;
>   

