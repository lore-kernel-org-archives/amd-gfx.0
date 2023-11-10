Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B102C4167D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D33210E0C5;
	Fri, 10 Nov 2023 14:48:16 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3D010E0C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:48:13 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32fb190bf9bso1993688f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 06:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699627692; x=1700232492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rDM0twlXiXIvN2aV8dwTmhrwhhGG93vGzD5fVgF26Ak=;
 b=AHNCibdZqn+bFqfnXCY3hMIlSrZZ3SWEp+jesEOr87JI4mW6YxcP1NHrI710WRpW6D
 KkeBv5JG1/Yk7frXEPJDbD5od4oHtkmfvB+Y/sRIuQ2WRQzxNLRelIqq4x8smUx0svYL
 +Cn1ZISUaq+pLmS6KiqoB3NWVXFGfqPhWNOFfq1/WwgqaJ1Ek0TdqxDub/GP1FC4l2hF
 S3prPCFJ/npdIKEfuDMP/TN26def1ASPiEPuLb48qJ1hL3n6VEN4eXskumOPyChtEdWF
 W/Bd2XIlSaIEg7yp7kc6mExlge8n4n7Z0bYqEHztDBkhmar6PDwiBl4+au+ErtGKLSub
 jVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699627692; x=1700232492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDM0twlXiXIvN2aV8dwTmhrwhhGG93vGzD5fVgF26Ak=;
 b=NSaBAg5sl6SVtEoF0b02HIp2D2j8H/jZ+eFWMIhqpt0guNKTVRP9y3xvDIPbSdEPUL
 QWo0/JssmbH7+iSCSJ/rMyyVCL9J5bVx/qktCViq2hiU9m0pLGx0Z5zAZeRJdGJdb46q
 fVaDDg2ao6QErKA1MaY+En7V3yHYVmPRG4dgB9C7ljdum9YFmlepcQsNUGoBY/VhsH/P
 pqlgdSvmAuqs1azFivw9lMllO2zdWqnBn6fA7LIQcr8DHd1AWjd6IxkLSr/gobxpFFhD
 i5d8atTxvw6h+RI3i5LMgvgY7GgOF/E8RVAhqFQ4lOMQgzMbASQvHqOr0BxaLUFhXqWc
 /roQ==
X-Gm-Message-State: AOJu0Yx38wVFYiHIeHdv/UmVbZDiFTChwQYl+c+MPDqOhDAOWjkVjgyS
 KYfPU6PJuQm1QcXZih94iYo=
X-Google-Smtp-Source: AGHT+IE1shdL4t6RTqlQ6eQTPbfP9cy/HrGWJS1BQUOCTCB6z57dGdpB48iAXeYJaWybLFsgrCZHPQ==
X-Received: by 2002:adf:e195:0:b0:32f:a8bb:31b6 with SMTP id
 az21-20020adfe195000000b0032fa8bb31b6mr3458923wrb.7.1699627691855; 
 Fri, 10 Nov 2023 06:48:11 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6110000000b0032f983f7306sm2064076wrt.78.2023.11.10.06.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 06:48:11 -0800 (PST)
Message-ID: <a8e73966-e233-4ec8-9e33-9821da64e67c@gmail.com>
Date: Fri, 10 Nov 2023 15:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231109073813.552664-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231109073813.552664-1-lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.11.23 um 08:38 schrieb Lijo Lazar:
> cancel_work is not backported to all custom kernels.

Well this is pretty clear NAK to pushing this upstream. We absolutely 
can't add workaround for older kernels.

You could keep this in the backported kernel, but why should cancel_work 
not be available?

Regards,
Christian.

>   Add a workaround to
> skip execution of already queued recovery jobs, if the device is already
> reset.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 16 ++++++++++++++++
>   3 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bebc73c6822c..c66524e2a56a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5411,6 +5411,8 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   
> +	amdgpu_reset_domain_clear_pending(adev->reset_domain);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   	if (!amdgpu_sriov_vf(adev))
>   		cancel_work(&adev->reset_work);
> @@ -5452,6 +5454,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	bool audio_suspended = false;
>   	bool gpu_reset_for_dev_remove = false;
>   
> +	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
> +		return 0;
> +
>   	gpu_reset_for_dev_remove =
>   			test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
>   				test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4baa300121d8..3ece7267d6ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -120,6 +120,14 @@ void amdgpu_reset_destroy_reset_domain(struct kref *ref)
>   	kvfree(reset_domain);
>   }
>   
> +static void amdgpu_reset_domain_cancel_all_work(struct work_struct *work)
> +{
> +	struct amdgpu_reset_domain *reset_domain =
> +		container_of(work, struct amdgpu_reset_domain, clear);
> +
> +	reset_domain->drain = false;
> +}
> +
>   struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
>   							     char *wq_name)
>   {
> @@ -142,6 +150,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   
>   	}
>   
> +	INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work);
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
>   	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index b0335a1c5e90..70059eea7e2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -87,6 +87,8 @@ struct amdgpu_reset_domain {
>   	struct rw_semaphore sem;
>   	atomic_t in_gpu_reset;
>   	atomic_t reset_res;
> +	struct work_struct clear;
> +	bool drain;
>   };
>   
>   #ifdef CONFIG_DEV_COREDUMP
> @@ -137,6 +139,20 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
>   	return queue_work(domain->wq, work);
>   }
>   
> +static inline void amdgpu_reset_domain_clear_pending(struct amdgpu_reset_domain *domain)
> +{
> +	domain->drain = true;
> +	/* queue one more work to the domain queue. Till this work is finished,
> +	 * domain is in drain mode.
> +	 */
> +	queue_work(domain->wq, &domain->clear);
> +}
> +
> +static inline bool amdgpu_reset_domain_in_drain_mode(struct amdgpu_reset_domain *domain)
> +{
> +	return domain->drain;
> +}
> +
>   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);

