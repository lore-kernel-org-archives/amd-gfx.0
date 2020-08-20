Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A1C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A5A207DE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGlRbWjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A5A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F3D6E04A;
	Thu, 20 Aug 2020 09:11:01 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F646E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 09:10:59 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r15so1258785wrp.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AeW16od1jzp0Xif4L+2wiBDXA8XOh+JYgZNJ0zYrfJQ=;
 b=QGlRbWjJX7DrbP8p4YYw4FGDmqaoPx5fQRTyD1zcG5BNDA1qD4Ar8Qk4i/YQUus5lt
 RPvlAvuuPS5/Dbm0BNTll6KM2pVbyLE/Nz3Ek0KprOfGmPTLkbh9kyHh4/rBVSTfujtn
 NhdPDsGkq1T/rSDdazyRCgR5zQ3UQeV1AYLMDK/rjy0fq6xuBIsEp++x7O/3c8UpqeRh
 GUL+sye6uiVFj60jcRypKyNjlhBQ6mMlhtZe0T+tvu4n9+fJ9/5/ZnQNakoEU8wnoQee
 jtv27VqeTw+3luuQyz2a7Lb05ogU7QHtMAVDnCSN3y28CoP/ES3PQAylMUa4UOzHIuoy
 GSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AeW16od1jzp0Xif4L+2wiBDXA8XOh+JYgZNJ0zYrfJQ=;
 b=qx/JvCSEE12PfB4vQWdbSazaST4ZphNpwpBk5fRl2E58gVgY5aQuHB5dJqh6Vr4Z/m
 gfyGdBWIOwSEbOxSEk9zmQulaH4srxZJYKqn2TU3fW1JXxr6lGhxw1kki4UcvKZ75qQu
 cM3mr8lOcsPiRCci9YIW2Dj3yhsvVp/auavbp8AO/MbWFPJH+7fbZmF4yYTBgWnm8pcK
 gmiQa5qTsRLAfAz9oY7x8KaVXZtYLG90ptfbDZJCAAh9eW5av0LZ/oXaclcfmIds/g24
 hHUFSKFGNKo8QPZ1o0dhYinpGqxkzH8Ezcegoe1ZiBYWLFhYiRBApQ4E5oORnS2+kbYL
 v+7A==
X-Gm-Message-State: AOAM532bU2Mkmmkk7jxih50jORp28B5F/hlDn6/5HZpzK6b/evHGHSiT
 6TMsdbBANXDHSgZvleeDYT0=
X-Google-Smtp-Source: ABdhPJzy7ON8tMzz7LGullfCs3ySNpTTOZuVqN+dt4y1TyOufN0LTAVDlzofonASNfaQihqJ8/Gcwg==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2326084wrv.39.1597914658587;
 Thu, 20 Aug 2020 02:10:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b11sm2755449wrq.32.2020.08.20.02.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 02:10:58 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: change reset lock from mutex to rw_semaphore
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com,
 christian.koenig@amd.com
References: <20200820020941.10988-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a7421de6-5980-4a2f-a1c8-1265135de98a@gmail.com>
Date: Thu, 20 Aug 2020 11:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820020941.10988-1-Dennis.Li@amd.com>
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

Am 20.08.20 um 04:09 schrieb Dennis Li:
> clients don't need reset-lock for synchronization when no
> GPU recovery.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c8aec832b244..ec11ed2a9ca4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -954,7 +954,7 @@ struct amdgpu_device {
>   
>   	atomic_t 			in_gpu_reset;
>   	enum pp_mp1_state               mp1_state;
> -	struct mutex  lock_reset;
> +	struct rw_semaphore reset_sem;
>   	struct amdgpu_doorbell_index doorbell_index;
>   
>   	struct mutex			notifier_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 79b397800cbc..0090e850eab9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -101,14 +101,17 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
>   
>   	file->private_data = adev;
>   
> -	mutex_lock(&adev->lock_reset);
> +	if (down_read_killable(&adev->reset_sem))
> +		return -EINTR;

Better use ret = down_read_killable(); if (ret) return ret; here. Same 
for all other places of course.

> +
>   	if (adev->autodump.dumping.done) {
>   		reinit_completion(&adev->autodump.dumping);
>   		ret = 0;
>   	} else {
>   		ret = -EBUSY;
>   	}
> -	mutex_unlock(&adev->lock_reset);
> +
> +	up_read(&adev->reset_sem);
>   
>   	return ret;
>   }
> @@ -1242,7 +1245,8 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>   	}
>   
>   	/* Avoid accidently unparking the sched thread during GPU reset */
> -	mutex_lock(&adev->lock_reset);
> +	if (down_read_killable(&adev->reset_sem))
> +		return -EINTR;
>   
>   	/* hold on the scheduler */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> @@ -1269,7 +1273,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>   		kthread_unpark(ring->sched.thread);
>   	}
>   
> -	mutex_unlock(&adev->lock_reset);
> +	up_read(&adev->reset_sem);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -1459,7 +1463,10 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>   		return -ENOMEM;
>   
>   	/* Avoid accidently unparking the sched thread during GPU reset */
> -	mutex_lock(&adev->lock_reset);
> +	if (down_read_killable(&adev->reset_sem)) {
> +		kfree(fences);
> +		return -EINTR;

Maybe better use a "goto err;" style error handling here.

> +	}
>   
>   	/* stop the scheduler */
>   	kthread_park(ring->sched.thread);
> @@ -1500,7 +1507,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>   	/* restart the scheduler */
>   	kthread_unpark(ring->sched.thread);
>   
> -	mutex_unlock(&adev->lock_reset);
> +	up_read(&adev->reset_sem);
>   
>   	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 78fd2c9a7b7d..82242e2f5658 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3054,7 +3054,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->virt.vf_errors.lock);
>   	hash_init(adev->mn_hash);
>   	atomic_set(&adev->in_gpu_reset, 0);
> -	mutex_init(&adev->lock_reset);
> +	init_rwsem(&adev->reset_sem);
>   	mutex_init(&adev->psp.mutex);
>   	mutex_init(&adev->notifier_lock);
>   
> @@ -4206,7 +4206,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)
>   	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
>   		return false;
>   
> -	mutex_lock(&adev->lock_reset);
> +	down_write(&adev->reset_sem);
>   
>   	atomic_inc(&adev->gpu_reset_counter);
>   	switch (amdgpu_asic_reset_method(adev)) {
> @@ -4229,7 +4229,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>   	amdgpu_vf_error_trans_all(adev);
>   	adev->mp1_state = PP_MP1_STATE_NONE;
>   	atomic_set(&adev->in_gpu_reset, 0);
> -	mutex_unlock(&adev->lock_reset);
> +	up_write(&adev->reset_sem);
>   }
>   
>   static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index f27d83f2de78..8ac63f13fc6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -238,19 +238,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
> -	int locked;
>   
>   	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>   	 * otherwise the mailbox msg will be ruined/reseted by
>   	 * the VF FLR.
> -	 *
> -	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
> -	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
> -	 * which means host side had finished this VF's FLR.
>   	 */
> -	locked = mutex_trylock(&adev->lock_reset);
> -	if (locked)
> -		atomic_set(&adev->in_gpu_reset, 1);
> +	down_read(&adev->reset_sem);

Somebody from the virtualization team should take a look at this as well.

Christian.

>   
>   	do {
>   		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
> @@ -261,10 +254,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	} while (timeout > 1);
>   
>   flr_done:
> -	if (locked) {
> -		atomic_set(&adev->in_gpu_reset, 0);
> -		mutex_unlock(&adev->lock_reset);
> -	}
> +	up_read(&adev->reset_sem);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 3cb10ab943a6..bcc583f087e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -259,19 +259,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
> -	int locked;
>   
>   	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>   	 * otherwise the mailbox msg will be ruined/reseted by
>   	 * the VF FLR.
> -	 *
> -	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
> -	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
> -	 * which means host side had finished this VF's FLR.
>   	 */
> -	locked = mutex_trylock(&adev->lock_reset);
> -	if (locked)
> -		atomic_set(&adev->in_gpu_reset, 1);
> +	down_read(&adev->reset_sem);
>   
>   	do {
>   		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
> @@ -282,10 +275,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	} while (timeout > 1);
>   
>   flr_done:
> -	if (locked) {
> -		atomic_set(&adev->in_gpu_reset, 0);
> -		mutex_unlock(&adev->lock_reset);
> -	}
> +	up_read(&adev->reset_sem);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
