Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705B1D2C55C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B71610E690;
	Tue, 22 Oct 2024 14:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUF61UmW";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81A110E690
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 14:05:15 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so27221915e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729605914; x=1730210714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a2FgQNB8tls3g86RBrhh8xXjF23uw9iugosNPwVauhE=;
 b=JUF61UmWOFE9oORXHLNP1jP88Dpsgs5YUlQG7BF4OogNEwZoBgfQbMVKU2CeSsu4+Z
 1XyQUoPwW8WroqQp2m2F+93489nfb18sbHxkQj6fzva6ziAbj9WQTA7wSlDP0ouyI154
 7WKHU/wWsTz4LgyExhhono/8FOkOfIt7LbbhVMeoV9vTQw4q+tefakmrpQ6mOCyKhzx8
 V8uwduAw9Za3aM+E+b1W0v46byfjuqziDcSWdJPIi2KzdMbfTX6BMj/7mgcacu1drIth
 kP1elwIi2JzE5T5trrKIz15v4dkAewq5m1ZRsil0HOULdrP5B1D1TidZ5aS6OP+e8Low
 aHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605914; x=1730210714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2FgQNB8tls3g86RBrhh8xXjF23uw9iugosNPwVauhE=;
 b=iZTMtly+QfgAHbpUctKQnpPWrNL8BrEhbmg2/yEthMD9xxgVpLydsLX0LtiX3uZSw5
 ihAdw9Pn/BVCmAHnUc7m1VJIpik214DmDVyvOt5P79ECXld7Dfb3E+FaIYmcu5zo5NeH
 UhKdCh0g2G30cpHGisZVDW54CGlMs+Kfbk25i8MZ3KeCtVAvItpU3IyDiOAJx+bEh9jF
 Z+BOTx+lFQZAB5hniQBnxsfK0MmW1lNOz9ThLiWOrc22BTk56iNsxLbuZX6BfR64Tzku
 mEwZ/s3bnw/dickE5tpFp3fB37qHjdkeEw0ecN56Rl/tlYP2byR/u7lkgaN+XVeS5Lnw
 tiqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQgDQ6s7PrpggIKRGhL4cMYAmVFq1vsO1j3dHNV1i/mbSHilBC59TKjfWANgGxAFdeqR65tDDk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo0xbXr0b98r0S2IyUD1s4bEYEQr+qqrN9K1rBR0r/jQ8Tyh4w
 zEYO+3WecC/yqmA1n+BuQyAv9ZE9wjIloSmfzQtKqOooRf6qVn61
X-Google-Smtp-Source: AGHT+IH2edQ1+7sme+NuR3qf+ZCxvS3ZW/ZhUj1S3KTM9yiBzw+pCcub1Q/Qlg1EP8/FSsSpb7oxTQ==
X-Received: by 2002:a05:600c:3ba2:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-4317b915ce2mr29006675e9.31.1729605913546; 
 Tue, 22 Oct 2024 07:05:13 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc4dfsm90072455e9.45.2024.10.22.07.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 07:05:13 -0700 (PDT)
Message-ID: <b5d78aae-efc0-4d81-b9bb-213ea598957e@gmail.com>
Date: Tue, 22 Oct 2024 16:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove extra use of volatile
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241022135307.3566557-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241022135307.3566557-1-Victor.Zhao@amd.com>
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

Am 22.10.24 um 15:53 schrieb Victor Zhao:
> as the adding of mb() should be sufficient in function unmap_queues_cpsch,
> remove the add of volatile type as recommended
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5a318376203c..38c19dc8311d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2048,7 +2048,7 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
>   {
>   	unsigned long end_jiffies = msecs_to_jiffies(timeout_ms) + jiffies;
>   	struct device *dev = dqm->dev->adev->dev;
> -	volatile uint64_t *fence_addr = dqm->fence_addr;
> +	uint64_t *fence_addr = dqm->fence_addr;
>   
>   	while (*fence_addr != fence_value) {
>   		/* Fatal err detected, this response won't come */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index bddb169bb301..09ab36f8e8c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -260,7 +260,7 @@ struct device_queue_manager {
>   	uint16_t		vmid_pasid[VMID_NUM];
>   	uint64_t		pipelines_addr;
>   	uint64_t		fence_gpu_addr;
> -	volatile uint64_t	*fence_addr;
> +	uint64_t		*fence_addr;
>   	struct kfd_mem_obj	*fence_mem;
>   	bool			active_runlist;
>   	int			sched_policy;

