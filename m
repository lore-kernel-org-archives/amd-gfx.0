Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70578C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B342074D
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvT72YQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B342074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13B56E03B;
	Mon,  6 Jul 2020 10:44:46 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4876E03B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 10:44:45 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z2so18006186wrp.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2020 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Q1eQbByrc/Avy0cBcQSXgW+UhJUj1HvUUt2UvdM0anM=;
 b=LvT72YQsGeDMxIgpFzVu1rPcNvBCRnxclAlMIZC75nCSDgplG+O/K4NJ744Lz50xQG
 OL+tCtuGy0Fwm9H+QmTGMxx/GQ4ulDDl55b6s2X1Jde0lIW/VT4ltBgix4HKC9P1RYXf
 rPuG0ts6ed+NjbSFB1RyrL6HWNImeRr0m306Nn7M4Ix+5JVWk82RaHqEsvge+ykQRokK
 ROAg4RiVzHaOklX9l+hg/ZsSqXOUoq8dqXpTvnunugBxTajkxm4YDW9Lc/Iut6DGo+Vc
 8yTtGkVYi9FQ0UJU45eIFGSOhRCSnK5VpfGft18skgtgMJPakF989hzUEXWhFMuKRQkl
 JXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Q1eQbByrc/Avy0cBcQSXgW+UhJUj1HvUUt2UvdM0anM=;
 b=SpmpAO2czSmO81rZEGQ1B8D3U4Lar0x5URNv/M/Xgf/z/os8Hth+Exlbi8+FiMHMeW
 BzRUkYfvv5JZvTdmgR2OplBdmJo1F+WKSt8Zd+ZASqBPN98W/vez9a6X99miekcy7Kvm
 b6sdhEdcguk3G5BihE1KwOhUjxjwSytbJBglNfr33h7sUOHa6NF8wQ8JTf298l0Y7KEh
 +Lwv2U2GIFd2PxADyi73o1/LRctxhlv/e4hFDiEAWzIHnGK3nLEOGqJHxQTqU4XqLUia
 IWA+F1cSah+hPDdJBu3ayCAxRCcFXjx0Ec662nk3HnHfAaC5yDHtXG/WZbZSx4BpDd/g
 Jkig==
X-Gm-Message-State: AOAM5322EQtBHibRvM9iDdfVV3cj/0HgyTFDTdiiNuC2TxMLqxTgwSs0
 mCiTC3Er33kqDHYlH8q7c/uwUYnM
X-Google-Smtp-Source: ABdhPJwG/hcJVY+0s5aWgb36W/6LeRDANdXkCdgyJ5sJpWjM9VK4BloIZQEIeMZROlbaYxUHD2cchw==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr39814878wrr.342.1594032284330; 
 Mon, 06 Jul 2020 03:44:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l18sm23951594wrm.52.2020.07.06.03.44.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2020 03:44:43 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix system hang issue during GPU reset
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Tao.Zhou1@amd.com, Hawking.Zhang@amd.com,
 Guchun.Chen@amd.com
References: <20200706100113.25141-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <02be4d61-ff0c-3ce0-3ff5-4c35653cb290@gmail.com>
Date: Mon, 6 Jul 2020 12:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200706100113.25141-1-Dennis.Li@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.20 um 12:01 schrieb Dennis Li:
> During GPU reset, driver should hold on all external access to
> GPU, otherwise psp will randomly fail to do post, and then cause
> system hang.

In general a good idea, but that exposes another problem: The trylock 
has now a rather right chance to fail and that is not expected.

Christian.

>
> Signed-off-by: Dennis Li <dennis.li@amd.com>
> Change-Id: I7d5d41f9c4198b917d7b49606ba3850988e5b936
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6c7dd0a707c9..34bfc2a147ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -965,7 +965,7 @@ struct amdgpu_device {
>   
>   	bool                            in_gpu_reset;
>   	enum pp_mp1_state               mp1_state;
> -	struct mutex  lock_reset;
> +	struct rw_semaphore	reset_sem;
>   	struct amdgpu_doorbell_index doorbell_index;
>   
>   	struct mutex			notifier_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index ad59ac4423b8..4139c81389a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -611,7 +611,9 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>   	/* This works for NO_HWS. TODO: need to handle without knowing VMID */
>   	job->vmid = vmid;
>   
> +	down_read(&adev->reset_sem);
>   	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
> +	up_read(&adev->reset_sem);
>   	if (ret) {
>   		DRM_ERROR("amdgpu: failed to schedule IB.\n");
>   		goto err_ib_sched;
> @@ -649,6 +651,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>   
> +	down_read(&adev->reset_sem);
> +
>   	if (adev->family == AMDGPU_FAMILY_AI) {
>   		int i;
>   
> @@ -658,6 +662,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
>   		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
>   	}
>   
> +	up_read(&adev->reset_sem);
> +
>   	return 0;
>   }
>   
> @@ -666,11 +672,18 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>   	const uint32_t flush_type = 0;
>   	bool all_hub = false;
> +	int ret = 0;
>   
>   	if (adev->family == AMDGPU_FAMILY_AI)
>   		all_hub = true;
>   
> -	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
> +	down_read(&adev->reset_sem);
> +
> +	ret = amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
> +
> +	up_read(&adev->reset_sem);
> +
> +	return ret;
>   }
>   
>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 691c89705bcd..db5d533dd406 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -542,6 +542,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	unsigned long end_jiffies;
>   	uint32_t temp;
>   	struct v10_compute_mqd *m = get_mqd(mqd);
> +	int ret = 0;
>   
>   	if (adev->in_gpu_reset)
>   		return -EIO;
> @@ -551,6 +552,8 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	int retry;
>   #endif
>   
> +	down_read(&adev->reset_sem);
> +
>   	acquire_queue(kgd, pipe_id, queue_id);
>   
>   	if (m->cp_hqd_vmid == 0)
> @@ -633,14 +636,16 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   			break;
>   		if (time_after(jiffies, end_jiffies)) {
>   			pr_err("cp queue preemption time out.\n");
> -			release_queue(kgd);
> -			return -ETIME;
> +			ret = -ETIME;
> +			goto pro_end;
>   		}
>   		usleep_range(500, 1000);
>   	}
>   
> +pro_end:
>   	release_queue(kgd);
> -	return 0;
> +	up_read(&adev->reset_sem);
> +	return ret;
>   }
>   
>   static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 0b7e78748540..cf27fe5091aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -424,10 +424,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	enum hqd_dequeue_request_type type;
>   	unsigned long flags, end_jiffies;
>   	int retry;
> +	int ret = 0;
>   
>   	if (adev->in_gpu_reset)
>   		return -EIO;
>   
> +	down_read(&adev->reset_sem);
> +
>   	acquire_queue(kgd, pipe_id, queue_id);
>   	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
>   
> @@ -506,14 +509,16 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   			break;
>   		if (time_after(jiffies, end_jiffies)) {
>   			pr_err("cp queue preemption time out\n");
> -			release_queue(kgd);
> -			return -ETIME;
> +			ret = -ETIME;
> +			goto pro_end;
>   		}
>   		usleep_range(500, 1000);
>   	}
>   
> +pro_end:
>   	release_queue(kgd);
> -	return 0;
> +	up_read(&adev->reset_sem);
> +	return ret;
>   }
>   
>   static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index ccd635b812b5..bc8e07186a85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -420,10 +420,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	unsigned long flags, end_jiffies;
>   	int retry;
>   	struct vi_mqd *m = get_mqd(mqd);
> +	int ret = 0;
>   
>   	if (adev->in_gpu_reset)
>   		return -EIO;
>   
> +	down_read(&adev->reset_sem);
> +
>   	acquire_queue(kgd, pipe_id, queue_id);
>   
>   	if (m->cp_hqd_vmid == 0)
> @@ -504,14 +507,16 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   			break;
>   		if (time_after(jiffies, end_jiffies)) {
>   			pr_err("cp queue preemption time out.\n");
> -			release_queue(kgd);
> -			return -ETIME;
> +			ret = -ETIME;
> +			goto pro_end;
>   		}
>   		usleep_range(500, 1000);
>   	}
>   
> +pro_end:
>   	release_queue(kgd);
> -	return 0;
> +	up_read(&adev->reset_sem);
> +	return ret;
>   }
>   
>   static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index df841c2ac5e7..341ad652d910 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -540,10 +540,13 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	unsigned long end_jiffies;
>   	uint32_t temp;
>   	struct v9_mqd *m = get_mqd(mqd);
> +	int ret = 0;
>   
>   	if (adev->in_gpu_reset)
>   		return -EIO;
>   
> +	down_read(&adev->reset_sem);
> +
>   	acquire_queue(kgd, pipe_id, queue_id);
>   
>   	if (m->cp_hqd_vmid == 0)
> @@ -570,14 +573,16 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   			break;
>   		if (time_after(jiffies, end_jiffies)) {
>   			pr_err("cp queue preemption time out.\n");
> -			release_queue(kgd);
> -			return -ETIME;
> +			ret = -ETIME;
> +			goto pro_end;
>   		}
>   		usleep_range(500, 1000);
>   	}
>   
> +pro_end:
>   	release_queue(kgd);
> -	return 0;
> +	up_read(&adev->reset_sem);
> +	return ret;
>   }
>   
>   static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index aeada7c9fbea..d8f264c47b86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -100,14 +100,14 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
>   
>   	file->private_data = adev;
>   
> -	mutex_lock(&adev->lock_reset);
> +	down_read(&adev->reset_sem);
>   	if (adev->autodump.dumping.done) {
>   		reinit_completion(&adev->autodump.dumping);
>   		ret = 0;
>   	} else {
>   		ret = -EBUSY;
>   	}
> -	mutex_unlock(&adev->lock_reset);
> +	up_read(&adev->reset_sem);
>   
>   	return ret;
>   }
> @@ -1188,7 +1188,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>   	}
>   
>   	/* Avoid accidently unparking the sched thread during GPU reset */
> -	mutex_lock(&adev->lock_reset);
> +	down_read(&adev->reset_sem);
>   
>   	/* hold on the scheduler */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> @@ -1215,7 +1215,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>   		kthread_unpark(ring->sched.thread);
>   	}
>   
> -	mutex_unlock(&adev->lock_reset);
> +	up_read(&adev->reset_sem);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -1395,7 +1395,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>   		return -ENOMEM;
>   
>   	/* Avoid accidently unparking the sched thread during GPU reset */
> -	mutex_lock(&adev->lock_reset);
> +	down_read(&adev->reset_sem);
>   
>   	/* stop the scheduler */
>   	kthread_park(ring->sched.thread);
> @@ -1436,7 +1436,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>   	/* restart the scheduler */
>   	kthread_unpark(ring->sched.thread);
>   
> -	mutex_unlock(&adev->lock_reset);
> +	up_read(&adev->reset_sem);
>   
>   	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2858c09fd8c0..bc902c59c1c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3044,7 +3044,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->mn_lock);
>   	mutex_init(&adev->virt.vf_errors.lock);
>   	hash_init(adev->mn_hash);
> -	mutex_init(&adev->lock_reset);
> +	init_rwsem(&adev->reset_sem);
>   	mutex_init(&adev->psp.mutex);
>   	mutex_init(&adev->notifier_lock);
>   
> @@ -4150,10 +4150,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
>   {
>   	if (trylock) {
> -		if (!mutex_trylock(&adev->lock_reset))
> +		if (!down_write_trylock(&adev->reset_sem))
>   			return false;
>   	} else
> -		mutex_lock(&adev->lock_reset);
> +		down_write(&adev->reset_sem);
>   
>   	atomic_inc(&adev->gpu_reset_counter);
>   	adev->in_gpu_reset = true;
> @@ -4177,7 +4177,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>   	amdgpu_vf_error_trans_all(adev);
>   	adev->mp1_state = PP_MP1_STATE_NONE;
>   	adev->in_gpu_reset = false;
> -	mutex_unlock(&adev->lock_reset);
> +	up_write(&adev->reset_sem);
>   }
>   
>   static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 2975c4a6e581..d4c69f9577a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -225,8 +225,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   	if (finished->error < 0) {
>   		DRM_INFO("Skip scheduling IBs!\n");
>   	} else {
> +		down_read(&ring->adev->reset_sem);
>   		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
>   				       &fence);
> +		up_read(&ring->adev->reset_sem);
>   		if (r)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
> @@ -237,6 +239,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   	amdgpu_job_free_resources(job);
>   
>   	fence = r ? ERR_PTR(r) : fence;
> +
>   	return fence;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13ea8ebc421c..38a751f7d889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -121,6 +121,7 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
>   void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   {
>   	uint32_t count;
> +	struct amdgpu_device *adev = ring->adev;
>   
>   	/* We pad to match fetch size */
>   	count = ring->funcs->align_mask + 1 -
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 5fd67e1cc2a0..97f33540aa02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -244,11 +244,11 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	 * otherwise the mailbox msg will be ruined/reseted by
>   	 * the VF FLR.
>   	 *
> -	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
> +	 * we can unlock the reset_sem to allow "amdgpu_job_timedout"
>   	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
>   	 * which means host side had finished this VF's FLR.
>   	 */
> -	locked = mutex_trylock(&adev->lock_reset);
> +	locked = down_write_trylock(&adev->reset_sem);
>   	if (locked)
>   		adev->in_gpu_reset = true;
>   
> @@ -263,7 +263,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   flr_done:
>   	if (locked) {
>   		adev->in_gpu_reset = false;
> -		mutex_unlock(&adev->lock_reset);
> +		up_write(&adev->reset_sem);
>   	}
>   
>   	/* Trigger recovery for world switch failure if no TDR */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index ce2bf1fb79ed..484d61c22396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -265,11 +265,11 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	 * otherwise the mailbox msg will be ruined/reseted by
>   	 * the VF FLR.
>   	 *
> -	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
> +	 * we can unlock the reset_sem to allow "amdgpu_job_timedout"
>   	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
>   	 * which means host side had finished this VF's FLR.
>   	 */
> -	locked = mutex_trylock(&adev->lock_reset);
> +	locked = down_write_trylock(&adev->reset_sem);
>   	if (locked)
>   		adev->in_gpu_reset = true;
>   
> @@ -284,7 +284,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   flr_done:
>   	if (locked) {
>   		adev->in_gpu_reset = false;
> -		mutex_unlock(&adev->lock_reset);
> +		up_write(&adev->reset_sem);
>   	}
>   
>   	/* Trigger recovery for world switch failure if no TDR */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
