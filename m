Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63546CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 10:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBBB10E5C1;
	Tue,  4 Nov 2025 10:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="pVfuyBwE";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8F610E5C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 10:50:26 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so39606205e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762253425; x=1762858225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZFURhTQxM8EHK9nOeUKxK0la3s1nJV7awrg7MX2Up1g=;
 b=pVfuyBwE1cXYROndorTliRNAUC42UZEJ13Dg9ICd25ikl0qweSxjpMirh9KDPnbgUJ
 UzmV9/P/IiIwlOU0nfLkdg+JCTUi3LUM26gijMV8WseB/1Nu63k/AGmjKRlr1eC2VML/
 kNh5Dt+Ed8SsUzIkgEzS7HYl8Krac3BlGDXQ2iBZI7SBnk5JgetkrcxJSKvWt9l9KXeD
 HJCeyTMEU3Jyxm/YhubdOmBFhnqENJFSuOkaXD176c1j5qssatBicDCl+UhX9iWEv8UW
 7B1ftKc6rH5Yo7UYgjLJp4IShdx9PqbChC7mk8quA6O2f0p89zvT67fVEVEyPiW5Drmn
 v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762253425; x=1762858225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFURhTQxM8EHK9nOeUKxK0la3s1nJV7awrg7MX2Up1g=;
 b=oVuGPSTLV7qdSMnMZNJrLR/BESage7736FZvbYE3jS4oGyimdgOScJadi+YcqljJn2
 P4lPpWbJ4S/K4h7nSp5C3rCXIa7TS3pI5JlaPlUSwR3+u63gfQVlVh9GHmdUFHmrr/n5
 4xA6QI337iLNbMH7qJP8POyAfTohDT5epC7RsWYo9r3v4aeWGkew9LGi8U3wFqDMC6yJ
 YZ2zbmq7on3wrLTiNeV91krMCRE7DozZJkEaE9RntzVkmlJiopNKqUpDqote9eJ7bJXJ
 Ie5zCVQ4O+hgKzYCvCL/BZKjg6q9a2bI9jsNfojkXw1N2EDWdX0zP2Xhbn7wUXxITvBy
 ff2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZV49tN/i9D+84xepR0Hz340bsoBxOFITWO5KrXEPrjtAu37/3Zj1xNMW8Rjbcw37uDX7gHHi9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLaYGedE4sXVAfKilLJFmnxj8Js5yfYmAxjQaSRY0dtIisOMOe
 3nsFERAoHhJBMgz4vsjtIlQabuJBiJoGkLS8F/tvcIq97PI6vAnBXLsj9ypGJ9HfYuM=
X-Gm-Gg: ASbGncvJq98/PRtQ3IO58BqAyDoBLWFRFONnRr7Lbms9h9dxcjDJ1jY4ceRo7LqKybc
 QcRFRVG78NGuLZ/cT+29ba2RhXyjRSSVD2e9Oq/viDF2zZG11IgX7FXNJybatzTYihu4cFp3+U+
 UTXfvb/J5Q7KKp5Ra6ygCOzuzkmAlwXoDDAx5JpRBvJFUgGG1NKJiMCxsYAVCpFaxCT2SYFf1fY
 1Zqzuv/qsblN9f6VNyeJg4NFplD4f+a1k3Opwbwgy4onKDIMzWoXV/tc6yJhRHuzOQsLsA8YTMP
 DGwv/ghtWWP7fivQbA/YQegD9/xBhDf5qvhhAdhsbaASWtJVGNFgVgUw1DTyXNnUBcmtx0ptlqH
 Hq+7wcDmPPHDdmI51/3EsSdXnnU20KhxttoO4GNleC9VLwpSQAZUuuhgkwn3g3z+WUZNkS32VQy
 s++HD33ECUuKsm2YJj
X-Google-Smtp-Source: AGHT+IHNfPFWfYkMfT7WlKJS07IbGQH5DaGOJbF8eWAxIecxDSTK6LwBBOkjSb/gwUptUtgnRPLKTg==
X-Received: by 2002:a05:600d:8346:b0:477:54cd:202f with SMTP id
 5b1f17b1804b1-47754cd2267mr16511715e9.3.1762253424283; 
 Tue, 04 Nov 2025 02:50:24 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c374f84sm203798985e9.0.2025.11.04.02.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 02:50:23 -0800 (PST)
Message-ID: <1a620331-4238-40fe-890b-1678403c3428@ursulin.net>
Date: Tue, 4 Nov 2025 10:50:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 Stanley.Yang@amd.com
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
 <20250918013507.2629620-6-YiPeng.Chai@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250918013507.2629620-6-YiPeng.Chai@amd.com>
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


On 18/09/2025 02:35, YiPeng Chai wrote:
> Add amdgpu ras system functions.
> 
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 268 ++++++++++++++++++
>   drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     | 109 +++++++
>   2 files changed, 377 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
>   create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> 
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> new file mode 100644
> index 000000000000..40071b876333
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
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
> +#include "ras_sys.h"
> +#include "amdgpu_ras_mgr.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
> +
> +static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context *ras_core, void *data)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	uint64_t seq_no;
> +
> +	seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_UE);
> +	RAS_DEV_INFO(adev,
> +		"{%llu} Uncorrectable hardware error(ERREVENT_ATHUB_INTERRUPT) detected!\n",
> +		seq_no);
> +
> +	return amdgpu_ras_process_handle_unexpected_interrupt(adev, data);
> +}
> +
> +static int amdgpu_ras_sys_poison_consumption_event(struct ras_core_context *ras_core,
> +				void *data)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	struct ras_event_req *req = (struct ras_event_req *)data;
> +	pasid_notify pasid_fn;
> +
> +	if (!req)
> +		return -EINVAL;
> +
> +	if (req->pasid_fn) {
> +		pasid_fn = (pasid_notify)req->pasid_fn;
> +		pasid_fn(adev, req->pasid, req->data);
> +	}
> +
> +	return 0;
> +}
> +
> +static int amdgpu_ras_sys_gen_seqno(struct ras_core_context *ras_core,
> +			enum ras_seqno_type seqno_type, uint64_t *seqno)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +	struct ras_event_manager *event_mgr;
> +	struct ras_event_state *event_state;
> +	struct amdgpu_hive_info *hive;
> +	enum ras_event_type event_type;
> +	uint64_t seq_no;
> +
> +	if (!ras_mgr || !seqno ||
> +		(seqno_type >= RAS_SEQNO_TYPE_COUNT_MAX))
> +		return -EINVAL;
> +
> +	switch (seqno_type) {
> +	case RAS_SEQNO_TYPE_UE:
> +		event_type = RAS_EVENT_TYPE_FATAL;
> +		break;
> +	case RAS_SEQNO_TYPE_CE:
> +	case RAS_SEQNO_TYPE_DE:
> +		event_type = RAS_EVENT_TYPE_POISON_CREATION;
> +		break;
> +	case RAS_SEQNO_TYPE_POISON_CONSUMPTION:
> +		event_type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
> +		break;
> +	default:
> +		event_type = RAS_EVENT_TYPE_INVALID;
> +		break;
> +	}
> +
> +	hive = amdgpu_get_xgmi_hive(adev);
> +	event_mgr = hive ? &hive->event_mgr : &ras_mgr->ras_event_mgr;
> +	event_state = &event_mgr->event_state[event_type];
> +	if ((event_type == RAS_EVENT_TYPE_FATAL) && amdgpu_ras_in_recovery(adev)) {
> +		seq_no = event_state->last_seqno;
> +	} else {
> +		seq_no = atomic64_inc_return(&event_mgr->seqno);
> +		event_state->last_seqno = seq_no;
> +		atomic64_inc(&event_state->count);
> +	}
> +	amdgpu_put_xgmi_hive(hive);
> +
> +	*seqno = seq_no;
> +	return 0;
> +
> +}
> +
> +static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
> +				   enum ras_notify_event event_id, void *data)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(ras_core->dev);
> +	int ret = 0;
> +
> +	switch (event_id) {
> +	case RAS_EVENT_ID__BAD_PAGE_DETECTED:
> +		schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
> +		break;
> +	case RAS_EVENT_ID__POISON_CONSUMPTION:
> +		amdgpu_ras_sys_poison_consumption_event(ras_core, data);
> +		break;
> +	case RAS_EVENT_ID__RESERVE_BAD_PAGE:
> +		ret = amdgpu_ras_reserve_page(ras_core->dev, *(uint64_t *)data);
> +		break;
> +	case RAS_EVENT_ID__FATAL_ERROR_DETECTED:
> +		ret = amdgpu_ras_sys_detect_fatal_event(ras_core, data);
> +		break;
> +	case RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM:
> +		ret = amdgpu_dpm_send_hbm_bad_pages_num(ras_core->dev, *(uint32_t *)data);
> +		break;
> +	case RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP:
> +		ret = amdgpu_dpm_send_hbm_bad_channel_flag(ras_core->dev, *(uint32_t *)data);
> +		break;
> +	case RAS_EVENT_ID__DEVICE_RMA:
> +		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, NULL);
> +		ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
> +		break;
> +	case RAS_EVENT_ID__RESET_GPU:
> +		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
> +		break;
> +	default:
> +		RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static u64 amdgpu_ras_sys_get_utc_second_timestamp(struct ras_core_context *ras_core)
> +{
> +	return ktime_get_real_seconds();
> +}
> +
> +static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ras_core,
> +				uint32_t *status)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	uint32_t gpu_status = 0;
> +
> +	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +		gpu_status |= RAS_GPU_STATUS__IN_RESET;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		gpu_status |= RAS_GPU_STATUS__IS_VF;
> +
> +	*status = gpu_status;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context *ras_core,
> +			struct device_system_info *dev_info)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +
> +	dev_info->device_id = adev->pdev->device;
> +	dev_info->vendor_id = adev->pdev->vendor;
> +	dev_info->socket_id = adev->smuio.funcs->get_socket_id(adev);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_ras_sys_gpu_reset_lock(struct ras_core_context *ras_core,
> +			bool down, bool try)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	int ret = 0;
> +
> +	if (down && try)
> +		ret = down_read_trylock(&adev->reset_domain->sem);
> +	else if (down)
> +		down_read(&adev->reset_domain->sem);
> +	else
> +		up_read(&adev->reset_domain->sem);
> +
> +	return ret;
> +}
> +
> +static bool amdgpu_ras_sys_detect_ras_interrupt(struct ras_core_context *ras_core)
> +{
> +	return !!atomic_read(&amdgpu_ras_in_intr);
> +}
> +
> +static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
> +	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	struct psp_context *psp = &adev->psp;
> +	struct psp_ring *psp_ring;
> +	struct ta_mem_context *mem_ctx;
> +
> +	if (mem_type == GPU_MEM_TYPE_RAS_PSP_RING) {
> +		psp_ring = &psp->km_ring;
> +		gpu_mem->mem_bo = adev->firmware.rbuf;
> +		gpu_mem->mem_size = psp_ring->ring_size;
> +		gpu_mem->mem_mc_addr = psp_ring->ring_mem_mc_addr;
> +		gpu_mem->mem_cpu_addr = psp_ring->ring_mem;
> +	} else if (mem_type == GPU_MEM_TYPE_RAS_PSP_CMD) {
> +		gpu_mem->mem_bo = psp->cmd_buf_bo;
> +		gpu_mem->mem_size = PSP_CMD_BUFFER_SIZE;
> +		gpu_mem->mem_mc_addr = psp->cmd_buf_mc_addr;
> +		gpu_mem->mem_cpu_addr = psp->cmd_buf_mem;
> +	} else if (mem_type == GPU_MEM_TYPE_RAS_PSP_FENCE) {
> +		gpu_mem->mem_bo = psp->fence_buf_bo;
> +		gpu_mem->mem_size = PSP_FENCE_BUFFER_SIZE;
> +		gpu_mem->mem_mc_addr = psp->fence_buf_mc_addr;
> +		gpu_mem->mem_cpu_addr = psp->fence_buf;
> +	} else if (mem_type == GPU_MEM_TYPE_RAS_TA_FW) {
> +		gpu_mem->mem_bo = psp->fw_pri_bo;
> +		gpu_mem->mem_size = PSP_1_MEG;
> +		gpu_mem->mem_mc_addr = psp->fw_pri_mc_addr;
> +		gpu_mem->mem_cpu_addr = psp->fw_pri_buf;
> +	} else if (mem_type == GPU_MEM_TYPE_RAS_TA_CMD) {
> +		mem_ctx = &psp->ras_context.context.mem_context;
> +		gpu_mem->mem_bo = mem_ctx->shared_bo;
> +		gpu_mem->mem_size = mem_ctx->shared_mem_size;
> +		gpu_mem->mem_mc_addr = mem_ctx->shared_mc_addr;
> +		gpu_mem->mem_cpu_addr = mem_ctx->shared_buf;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	if (!gpu_mem->mem_bo || !gpu_mem->mem_size ||
> +		!gpu_mem->mem_mc_addr || !gpu_mem->mem_cpu_addr) {
> +		RAS_DEV_ERR(ras_core->dev, "The ras psp gpu memory is invalid!\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
> +	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
> +{
> +
> +	return 0;
> +}
> +
> +const struct ras_sys_func amdgpu_ras_sys_fn = {
> +	.ras_notifier = amdgpu_ras_sys_event_notifier,
> +	.get_utc_second_timestamp = amdgpu_ras_sys_get_utc_second_timestamp,
> +	.gen_seqno = amdgpu_ras_sys_gen_seqno,
> +	.check_gpu_status = amdgpu_ras_sys_check_gpu_status,
> +	.get_device_system_info = amdgpu_ras_sys_get_device_system_info,
> +	.gpu_reset_lock = amdgpu_ras_sys_gpu_reset_lock,
> +	.detect_ras_interrupt = amdgpu_ras_sys_detect_ras_interrupt,
> +	.get_gpu_mem = amdgpu_ras_sys_get_gpu_mem,
> +	.put_gpu_mem = amdgpu_ras_sys_put_gpu_mem,
> +};
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> new file mode 100644
> index 000000000000..c48ff26525d6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
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
> +#ifndef __RAS_SYS_H__
> +#define __RAS_SYS_H__
> +#include <linux/stdarg.h>
> +#include <linux/printk.h>
> +#include <linux/dev_printk.h>
> +#include "amdgpu.h"
> +
> +#define RAS_DEV_ERR(device, fmt, ...)                                               \
> +	do {                                                                      \
> +		if (device)                                                             \
> +			dev_err(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__); \
> +		else                                                                  \
> +			printk(KERN_ERR fmt, ##__VA_ARGS__);                              \
> +	} while (0)
> +
> +#define RAS_DEV_WARN(device, fmt, ...)                                               \
> +	do {                                                                       \
> +		if (device)                                                              \
> +			dev_warn(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__); \
> +		else                                                                   \
> +			printk(KERN_WARNING fmt, ##__VA_ARGS__);                           \
> +	} while (0)
> +
> +#define RAS_DEV_INFO(device, fmt, ...)                                                 \
> +	do {                                                                         \
> +		if (device)                                                                \
> +			dev_info(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__);   \
> +		else                                                                     \
> +			printk(KERN_INFO fmt, ##__VA_ARGS__);                                \
> +	} while (0)
> +
> +#define RAS_DEV_DBG(device, fmt, ...)                                                  \
> +	do {                                                                         \
> +		if (device)                                                                \
> +			dev_dbg(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__);    \
> +		else                                                                     \
> +			printk(KERN_DEBUG fmt, ##__VA_ARGS__);                               \
> +	} while (0)
> +
> +#define RAS_INFO(fmt, ...)  printk(KERN_INFO fmt, ##__VA_ARGS__)
> +
> +#define RAS_DEV_RREG32_SOC15(dev, ip, inst, reg) \
> +({ \
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
> +	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> +			 0, ip##_HWIP, inst); \
> +})
> +
> +#define RAS_DEV_WREG32_SOC15(dev, ip, inst, reg, value) \
> +({ \
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
> +	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
> +			  value, 0, ip##_HWIP, inst); \
> +})
> +
> +/* GET_INST returns the physical instance corresponding to a logical instance */
> +#define RAS_GET_INST(dev, ip, inst) \
> +({ \
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
> +	adev->ip_map.logical_to_dev_inst ? \
> +		adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP, inst) : inst; \
> +})
> +
> +#define RAS_GET_MASK(dev, ip, mask) \
> +({ \
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
> +	(adev->ip_map.logical_to_dev_mask ? \
> +		adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) : mask); \
> +})
> +
> +static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *root, void *iter)
> +{
> +	return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->index);
> +}
> +
> +static inline long ras_wait_event_interruptible_timeout(void *wq_head,
> +			int (*condition)(void *param), void *param, unsigned int timeout)
> +{
> +	return wait_event_interruptible_timeout(*(wait_queue_head_t *)wq_head,
> +				condition(param), timeout);

Void *wq_head with a cast is a bit scary. I don't see why it is needed. 
Or even the whole wrapper TBH.

Regards,

Tvrtko

> +}
> +
> +extern const struct ras_sys_func amdgpu_ras_sys_fn;
> +
> +#endif

