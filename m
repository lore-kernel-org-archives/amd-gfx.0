Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B46AC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF1610E800;
	Wed, 13 Mar 2024 09:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caxaNcOD";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3DB10E800
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:28:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-41330d48a29so13803525e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710322102; x=1710926902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Hlh4vAexQ0bV2zhFjs2yRPmSvCIiHUtZPyOPWOX89U=;
 b=caxaNcOD6lZdV3V2lQgK0UBEQiLJWEoG/PGOKchOzvycLRRt2Ia7YAxUrSVYH/3YSU
 Q9AmDA2WsUlNv4kgcfMohQTr0Cq0GKYeFwzsFgz5IT+8Jqaf7K/VwWxL6gd4PenwPa97
 vAvd4jr6BZIOh+3iZd+gX4V53ihx0XVf9flIpnzuoE/EmOhMXNz5n175b6S3SdVrGjyX
 /KorbKNvkSEX/cS/WFN+q7A1lfgy9yYUGApdx8qZzpSHc4+ypUfgRfuCi1LoHljr1EkW
 kWumL0GSUEXGUTfOVpDPmqV+1m1GvmMVHYAVxMIigUjgOiWYTekATPtOpF7slYFBKFuZ
 79BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710322102; x=1710926902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Hlh4vAexQ0bV2zhFjs2yRPmSvCIiHUtZPyOPWOX89U=;
 b=dEabqNmPhmJSSVvQYN3KgzlfRglm5PX5rg+fPMZYxulLq1KR8XwwUk6FERlQANE4H6
 SBll94OLTyLOdpjvM4lViH4NWz5FWpeLL8fRB+wddv687FkBklFlk/zQY0COWKm2/lZG
 ipI/CC20He3SBnyRJe3EJO5iRJMViXC3WxSfss6JLHXOQ9Udilj/xCIMckxoCHeS7rla
 T1ZUNLrt1ILMS0tFuOU3HfRAH/jUv4BkKv5i5iahavgSegXWwdDLhwx+1kPrO1KdIUWV
 tjti/PXLek6YgVGbUgrQ1qK3z16v7jZx2ET6KHaoAWnmdNWIFX92ODor8GLpQf1Bs/5t
 k0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVVR1nJt30W8czV3akHenOnnDD5yPOYCfQHtD5RMvUv1bz2D+J6nkF7uBx6HFoPLDfAAxFKjTn7ZYvraflS3Om7XyiD8a3IapLj6HLHQ==
X-Gm-Message-State: AOJu0Ywh0V6a88SEh7Y5GjIKqOPN75Y288AvagTvZ5gl3v6F9oEhAfB9
 O+3qLVN/nvtZXpAN094Vq/QLvO1ghsWB1kti8/QR71M1fey93S0M
X-Google-Smtp-Source: AGHT+IFJoOMKQLJfGcaxO7NBiLXRpL9xc+ku/LUyNVgjIhrM/lSt+5Ug81gxDgU1usKngjEa6Ec8gA==
X-Received: by 2002:a05:600c:45cb:b0:413:e531:5ae2 with SMTP id
 s11-20020a05600c45cb00b00413e5315ae2mr1765642wmo.23.1710322101827; 
 Wed, 13 Mar 2024 02:28:21 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k37-20020a05600c1ca500b00413e6c56faasm1695503wms.41.2024.03.13.02.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 02:28:21 -0700 (PDT)
Message-ID: <6b16c996-afe5-4147-87db-4e694b0557a3@gmail.com>
Date: Wed, 13 Mar 2024 10:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup unused variable
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240312153100.1046-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240312153100.1046-1-shashank.sharma@amd.com>
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

Am 12.03.24 um 16:31 schrieb Shashank Sharma:
> This patch removes an unused input variable in the MES
> doorbell function.
>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 89ac50405e25..7615daf89ba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -40,7 +40,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
>   }
>   
>   static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
> -					 struct amdgpu_mes_process *process,
>   					 int ip_type, uint64_t *doorbell_index)
>   {
>   	unsigned int offset, found;
> @@ -65,7 +64,6 @@ static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
>   }
>   
>   static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
> -					   struct amdgpu_mes_process *process,
>   					   uint32_t doorbell_index)
>   {
>   	unsigned int old, rel_index;
> @@ -623,7 +621,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	*queue_id = queue->queue_id = r;
>   
>   	/* allocate a doorbell index for the queue */
> -	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
> +	r = amdgpu_mes_kernel_doorbell_get(adev,
>   					  qprops->queue_type,
>   					  &qprops->doorbell_off);
>   	if (r)
> @@ -681,8 +679,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	return 0;
>   
>   clean_up_doorbell:
> -	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
> -				       qprops->doorbell_off);
> +	amdgpu_mes_kernel_doorbell_free(adev, qprops->doorbell_off);
>   clean_up_queue_id:
>   	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
>   	idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
> @@ -736,8 +733,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
>   			  queue_id);
>   
>   	list_del(&queue->list);
> -	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
> -				       queue->doorbell_off);
> +	amdgpu_mes_kernel_doorbell_free(adev, queue->doorbell_off);
>   	amdgpu_mes_unlock(&adev->mes);
>   
>   	amdgpu_mes_queue_free_mqd(queue);

