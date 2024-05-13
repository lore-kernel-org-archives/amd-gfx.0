Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0698C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 15:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF2F10E2D5;
	Mon, 13 May 2024 15:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Un72z9VN";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50EA10E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 15:36:24 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so1298993f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715614583; x=1716219383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VVgGdbZWGmnsPnNYP/IsFtGLEqc6Bs1ULuLhTF79R5E=;
 b=Un72z9VNeOvkIvA2VYvV/kG4dGWCGeB82AeTLHj8TPy30qMm4Qbr584vp5E5PYUFY0
 pP3BSURVOEiPGguw7BZW5XeyYiU9RGEaOHToG3Z1exivcE8dBEhCGRYj2Imd9N+O+Npl
 2bpTOayvYiaSPRblghvby5aaUzGAjALOgYfnrjpSZRdqmrUAHTLs9aW/ISRZrS7HhRa9
 ZWY3+qZSGBoLCqn+mSh5Dpp7ZriXfhOspYx2Zl7fwIEN3xbtDeMBwtmzeyzehnvHdMKU
 Nys7vz7GQ+/VQggp/bymmjlzGYhy0k/PkQkuo2BlcND8T3vo9gS29obys46a5sAZb5KF
 AdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715614583; x=1716219383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VVgGdbZWGmnsPnNYP/IsFtGLEqc6Bs1ULuLhTF79R5E=;
 b=qpmviKyhLZFnQXI616UcktpVWn5h2kY3EEjr5XXNb50uGopLpld/jm9x7JtzH/aQaN
 1MOgXwA8AoM8uQ6GaJ0Q8i/z53ryBP2Q5BXgNNGzp+0OL/BikJMJyv29PZKgokEJNvSt
 PMUZYSC9wsGVHL7YhJygEnVuwPfsVS5u7i5usdZ6y+Wy63lBYd4LSrMxDLQML3O9NGy/
 ll0/3uoUFC/DEJoXQKWC8cklcEM7MdXlvajNeOpoyI5hxEhF5xgoGHqjfB/ivaZl68E3
 oyiuWZDJfEoe/6nO9jnuMUtYsD0q48YHp/dQlnnurETJJ78eOqxpzh1cBX4p1UZaIkIH
 LZkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbKe2omG3YCj3dt5G7Xh/3MZF++aqz7sgfGAajUaYwvoBNE+/2E5/UxFPlCpuzzidEODg/fLWCS0Mxwr3p5xkBNh/A/A5fdALpCIyg/Q==
X-Gm-Message-State: AOJu0YycDm7a8frj5wWCG7MkQze72HU0cVOEpI0a/D2UwvdWRww/RJ0j
 5mnggVmF+YYCy96uBWce5ZLwqU9jSExz6PUcbszBnOpZB3Oz+3aF
X-Google-Smtp-Source: AGHT+IEnOsNQ7MqSOHApE6iEyOAC6OYin77EmAFSxY7DlM5S7wLXGstGQwZe3uIkIDYxOU1m4G/uAg==
X-Received: by 2002:a05:6000:d4a:b0:34a:b682:7978 with SMTP id
 ffacd0b85a97d-3504a73eea3mr7304657f8f.42.1715614582631; 
 Mon, 13 May 2024 08:36:22 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc077sm11303528f8f.104.2024.05.13.08.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 08:36:22 -0700 (PDT)
Message-ID: <f24e41df-057d-4719-b605-9ac72f81f117@gmail.com>
Date: Mon, 13 May 2024 17:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Add Ring Hang Events
To: Ori Messinger <Ori.Messinger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240513041414.130959-1-Ori.Messinger@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240513041414.130959-1-Ori.Messinger@amd.com>
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

Am 13.05.24 um 06:14 schrieb Ori Messinger:
> This patch adds 'ring hang' events to the driver.
> This is done by adding a 'reset_ring_hang' bool variable to the
> struct 'amdgpu_reset_context' in the amdgpu_reset.h file.
> The purpose for this 'reset_ring_hang' variable is whenever a GPU
> reset is initiated due to a ring hang, the reset_ring_hang should
> be set to 'true'.
>
> Additionally, the reset cause is passed into the kfd smi event as
> a string, and is displayed in dmesg as an error.
>
> This 'amdgpu_reset_context' struct is now also passed
> through across all relevant functions, and another event type
> "KFD_SMI_EVENT_RING_HANG" is added to the kfd_smi_event enum.

Well general NAK to that design.

Why in the world would we want to expose the ring hang through the KFD 
SMI interface?

Regards,
Christian.

>
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
> Change-Id: I6af3022eb1b4514201c9430d635ff87f167ad6f7
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  9 ++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  7 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
>   include/uapi/linux/kfd_ioctl.h              | 15 ++++++++-------
>   10 files changed, 56 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e3738d417245..f1c6dc939cc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -133,6 +133,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>   
>   	reset_context.method = AMD_RESET_METHOD_NONE;
>   	reset_context.reset_req_dev = adev;
> +	reset_context.reset_ring_hang = true;
> +	strscpy(reset_context.reset_cause, "hws_hang", sizeof(reset_context.reset_cause));
> +	DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
>   	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> @@ -261,12 +264,12 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>   	return r;
>   }
>   
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
>   {
>   	int r = 0;
>   
>   	if (adev->kfd.dev)
> -		r = kgd2kfd_pre_reset(adev->kfd.dev);
> +		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1de021ebdd46..c9030d8b8308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>   };
>   
>   struct amdgpu_device;
> +struct amdgpu_reset_context;
>   
>   enum kfd_mem_attachment_type {
>   	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
> @@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>   
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> +			    struct amdgpu_reset_context *reset_context);
>   
>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>   
> @@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   void kgd2kfd_device_exit(struct kfd_dev *kfd);
>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +		      struct amdgpu_reset_context *reset_context);
>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> @@ -459,7 +462,7 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   	return 0;
>   }
>   
> -static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
>   {
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 00fe3c2d5431..b18f37426b5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5772,7 +5772,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>   
> -		amdgpu_amdkfd_pre_reset(tmp_adev);
> +		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>   
>   		/*
>   		 * Mark these ASICs to be reseted as untracked first
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..c3e32f21aa49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -77,6 +77,22 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   
>   		reset_context.method = AMD_RESET_METHOD_NONE;
>   		reset_context.reset_req_dev = adev;
> +		reset_context.reset_ring_hang = true;
> +		if (ring->name) {
> +			/* Ensure buffer length of 64 is not exceeded during copy of ring->name  */
> +			size_t name_length;
> +
> +			for (name_length = 0; name_length < sizeof(reset_context.reset_cause) - 6 &&
> +			     ring->name[name_length] != '\0'; name_length++) {
> +				reset_context.reset_cause[name_length] = ring->name[name_length];
> +			}
> +			strscpy(reset_context.reset_cause + name_length, "_hang",
> +				sizeof(reset_context.reset_cause) - name_length);
> +		} else {
> +			strscpy(reset_context.reset_cause, "unknown_hang",
> +				sizeof(reset_context.reset_cause));
> +		}
> +		DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
>   		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
>   		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1dd13ed3b7b5..e2d65c5c17c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2479,6 +2479,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   		reset_context.method = AMD_RESET_METHOD_NONE;
>   		reset_context.reset_req_dev = adev;
>   
> +		reset_context.reset_ring_hang = true;
> +		strscpy(reset_context.reset_cause, "ras_hang", sizeof(reset_context.reset_cause));
> +		DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
> +
>   		/* Perform full reset in fatal error mode */
>   		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
>   			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 5a9cc043b858..757284ab36e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ struct amdgpu_reset_context {
>   	struct amdgpu_hive_info *hive;
>   	struct list_head *reset_device_list;
>   	unsigned long flags;
> +	bool reset_ring_hang;
> +	char reset_cause[64];
>   };
>   
>   struct amdgpu_reset_handler {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 6b15e55811b6..88171f24496b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -35,6 +35,7 @@
>   #include "kfd_migrate.h"
>   #include "amdgpu.h"
>   #include "amdgpu_xcp.h"
> +#include "amdgpu_reset.h"
>   
>   #define MQD_SIZE_ALIGNED 768
>   
> @@ -931,7 +932,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   	kfree(kfd);
>   }
>   
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
>   {
>   	struct kfd_node *node;
>   	int i;
> @@ -941,7 +942,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   
>   	for (i = 0; i < kfd->num_nodes; i++) {
>   		node = kfd->nodes[i];
> -		kfd_smi_event_update_gpu_reset(node, false);
> +		kfd_smi_event_update_gpu_reset(node, false, reset_context);
>   		node->dqm->ops.pre_reset(node->dqm);
>   	}
>   
> @@ -981,7 +982,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>   	for (i = 0; i < kfd->num_nodes; i++) {
>   		node = kfd->nodes[i];
>   		atomic_set(&node->sram_ecc_flag, 0);
> -		kfd_smi_event_update_gpu_reset(node, true);
> +		kfd_smi_event_update_gpu_reset(node, true, NULL);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 06ac835190f9..3ffe4b61fe4f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_vm.h"
>   #include "kfd_priv.h"
>   #include "kfd_smi_events.h"
> +#include "amdgpu_reset.h"
>   
>   struct kfd_smi_client {
>   	struct list_head list;
> @@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
>   	add_event_to_kfifo(pid, dev, event, fifo_in, len);
>   }
>   
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context)
>   {
>   	unsigned int event;
>   
> @@ -224,6 +226,9 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>   	} else {
>   		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>   		++(dev->reset_seq_num);
> +		if (reset_context && reset_context->reset_ring_hang)
> +			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_RING_HANG, "%s\n",
> +					  reset_context->reset_cause);
>   	}
>   	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index fa95c2dfd587..85010b8307f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -24,11 +24,14 @@
>   #ifndef KFD_SMI_EVENTS_H_INCLUDED
>   #define KFD_SMI_EVENTS_H_INCLUDED
>   
> +struct amdgpu_reset_context;
> +
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   					     uint64_t throttle_bitmask);
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context);
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>   				    unsigned long address, bool write_fault,
>   				    ktime_t ts);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 285a36601dc9..7c94d2c7da13 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -519,13 +519,14 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>   	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>   	KFD_SMI_EVENT_GPU_POST_RESET = 4,
> -	KFD_SMI_EVENT_MIGRATE_START = 5,
> -	KFD_SMI_EVENT_MIGRATE_END = 6,
> -	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
> -	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
> -	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
> -	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
> -	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +	KFD_SMI_EVENT_RING_HANG = 5,
> +	KFD_SMI_EVENT_MIGRATE_START = 6,
> +	KFD_SMI_EVENT_MIGRATE_END = 7,
> +	KFD_SMI_EVENT_PAGE_FAULT_START = 8,
> +	KFD_SMI_EVENT_PAGE_FAULT_END = 9,
> +	KFD_SMI_EVENT_QUEUE_EVICTION = 10,
> +	KFD_SMI_EVENT_QUEUE_RESTORE = 11,
> +	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
>   
>   	/*
>   	 * max event number, as a flag bit to get events from all processes,

