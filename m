Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF86C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 06:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119A210E743;
	Thu, 22 Aug 2024 06:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WqRb/mGu";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE40C10E743
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 06:29:37 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so2299225e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724308176; x=1724912976; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3qCjgQ61NT3W1H7eNx+8s7D5NK+EQR1NHkDhKiTiww=;
 b=WqRb/mGumNOB0Rx9P6MiWSnED7IVjpr/L4A8FVqETr63L62a9jJVZ8+UXQZejKtVy1
 NNuGUipSpmseOxbHS5to2qp7bySUluYHCVVG03191aElAb1N0aUB1XNhq0XK2R9jv9wk
 2aFcanlW931uGjUtPeoJlJ18HbLlEXy+2/a+kyyGZ7vkZcTvLI4BR5ijQbmialJCNQ0R
 314Z55TyktNRfmCx822s4LSiTW4uYGtWHSnnidnEo9sEGPIbeWuHmBKf/MSsVQMsiE0P
 lPZh8kHcG29ECz/BsAbz6gPsHNVff/9tvh/hpgYRxXB2YjzMxDAzbKc84X0CWE6t17+A
 5nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724308176; x=1724912976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N3qCjgQ61NT3W1H7eNx+8s7D5NK+EQR1NHkDhKiTiww=;
 b=hWEFNlUrgT5PAuS6gt4pQ0nlQD7jVBgo79IsdHI2xw17GSdZQ/MPKVLVBzy5PHPiJG
 RrJvD4v1C0mwNgQRAQbbhtjyOFytxWX6gBTH3AJXKm/I5PGWQNta/0FP9E69TKPyBVmw
 ktc0IrmcPTz1/JO3VzyvWQFbODsn24y/VF3o4Jv7tTS8vdKaj6155Zfcdzi0e6kLT0zK
 tpvTl2xlko6AT3yxLf3xON7eso7y2npIPoZA4vl2fznE6QE3ufhKKyi1ErHgnaGOcPQ8
 XwzGG8KzZowmOcSbeSmDrvBsgBIymMk2xlfVEN9gLBUANKqG8OPOsj6BD8oWP1JM9buQ
 x+8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6gXjJ9vd0mOFXNdpk9PtaBHT55qry7EyCkv4j1oLxkLkWB80oIJWaOCdIy3V4EajVhhr7BBp6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIwH4KdFvb6KQYyyPEuiexB+KTPDuaQvfxtgf8+ARWwpGtPCRn
 9SQ5u/1nrdfCC0tx93un4fs/QS7srgBu8TbMCNc63BOxp6rDYZbQ
X-Google-Smtp-Source: AGHT+IG0uwuexgko1wHAytuBAAREejqoub0Ah/KVMSo3xn09uryoeBB/RwEz2IBMbtdEdB7GYlVNng==
X-Received: by 2002:adf:ce8e:0:b0:371:8e50:2d06 with SMTP id
 ffacd0b85a97d-372fd82c6c8mr2537343f8f.43.1724308175384; 
 Wed, 21 Aug 2024 23:29:35 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefc604dsm48565025e9.35.2024.08.21.23.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 23:29:35 -0700 (PDT)
Message-ID: <f2ee509b-073e-4b21-87e3-e2c08b13c028@gmail.com>
Date: Thu, 22 Aug 2024 08:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/amdgpu: Add sysfs interface for running cleaner
 shader
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
 <20240815000501.1845226-8-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240815000501.1845226-8-alexander.deucher@amd.com>
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

Am 15.08.24 um 02:04 schrieb Alex Deucher:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> This patch adds a new sysfs interface for running the cleaner shader on
> AMD GPUs. The cleaner shader is used to clear GPU memory before it's
> reused, which can help prevent data leakage between different processes.
>
> The new sysfs file is write-only and is named `run_cleaner_shader`.
> Write the number of the partition to this file to trigger the cleaner shader
> on that partition. There is only one partition on GPUs which do not
> support partitioning.
>
> Changes made in this patch:
>
> - Added `amdgpu_set_run_cleaner_shader` function to handle writes to the
>    `run_cleaner_shader` sysfs file.
> - Added `run_cleaner_shader` to the list of device attributes in
>    `amdgpu_device_attrs`.
> - Updated `default_attr_update` to handle `run_cleaner_shader`.
> - Added `AMDGPU_DEVICE_ATTR_WO` macro to create write-only device
>    attributes.
>
> v2: fix error handling (Alex)
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 134 ++++++++++++++++++++++++
>   1 file changed, 134 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2e35fc2577f9..76f77cf562af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -24,10 +24,13 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <linux/pm_runtime.h>
> +
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_rlc.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_xgmi.h"
>   
> @@ -1391,6 +1394,129 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", supported_partition);
>   }
>   
> +static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	long timeout = msecs_to_jiffies(1000);
> +	struct dma_fence *f = NULL;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
> +	int i, r;
> +
> +	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL,
> +				     64, AMDGPU_IB_POOL_DIRECT,
> +				     &job);
> +	if (r)
> +		goto err;
> +
> +	job->enforce_isolation = true;
> +
> +	ib = &job->ibs[0];
> +	for (i = 0; i <= ring->funcs->align_mask; ++i)
> +		ib->ptr[i] = ring->funcs->nop;
> +	ib->length_dw = ring->funcs->align_mask + 1;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);

That's a really really bad idea. There is nothing which guarantees the 
the scheduler tries to submit something at the same time as well.

You need to allocate a scheduler entity and use that for submission.

Christian.

> +	if (r)
> +		goto err_free;
> +
> +	r = dma_fence_wait_timeout(f, false, timeout);
> +	if (r == 0)
> +		r = -ETIMEDOUT;
> +	else if (r > 0)
> +		r = 0;
> +
> +	amdgpu_ib_free(adev, ib, f);
> +	dma_fence_put(f);
> +
> +	return 0;
> +
> +err_free:
> +	amdgpu_job_free(job);
> +	amdgpu_ib_free(adev, ib, f);
> +err:
> +	return r;
> +}
> +
> +static int amdgpu_gfx_run_cleaner_shader(struct amdgpu_device *adev, int xcp_id)
> +{
> +	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	struct amdgpu_ring *ring;
> +	int num_xcc_to_clear;
> +	int i, r, xcc_id;
> +
> +	if (adev->gfx.num_xcc_per_xcp)
> +		num_xcc_to_clear = adev->gfx.num_xcc_per_xcp;
> +	else
> +		num_xcc_to_clear = 1;
> +
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +			ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
> +			if ((ring->xcp_id == xcp_id) && ring->sched.ready) {
> +				r = amdgpu_gfx_run_cleaner_shader_job(ring);
> +				if (r)
> +					return r;
> +				num_xcc_to_clear--;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (num_xcc_to_clear)
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf,
> +						 size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int ret;
> +	long value;
> +
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +	if (adev->in_suspend && !adev->in_runpm)
> +		return -EPERM;
> +
> +	ret = kstrtol(buf, 0, &value);
> +
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (value < 0)
> +		return -EINVAL;
> +
> +	if (adev->xcp_mgr) {
> +		if (value >= adev->xcp_mgr->num_xcps)
> +			return -EINVAL;
> +	} else {
> +		if (value > 1)
> +			return -EINVAL;
> +	}
> +
> +	ret = pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	ret = amdgpu_gfx_run_cleaner_shader(adev, value);
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>   static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
>   						struct device_attribute *attr,
>   						char *buf)
> @@ -1469,6 +1595,9 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   	return count;
>   }
>   
> +static DEVICE_ATTR(run_cleaner_shader, 0200,
> +		   NULL, amdgpu_gfx_set_run_cleaner_shader);
> +
>   static DEVICE_ATTR(enforce_isolation, 0644,
>   		   amdgpu_gfx_get_enforce_isolation,
>   		   amdgpu_gfx_set_enforce_isolation);
> @@ -1509,6 +1638,10 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> +	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -1516,6 +1649,7 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>   {
>   	if (!amdgpu_sriov_vf(adev))
>   		device_remove_file(adev->dev, &dev_attr_enforce_isolation);
> +	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>   }
>   
>   int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,

