Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49474CF58C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 12:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13E410E03D;
	Thu, 26 Sep 2024 12:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MC7sZO/7";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DAC10E03D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 12:29:54 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-42cae102702so7765425e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727353793; x=1727958593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X3Pj+K5ZcDexa6hoEG2gdhqy7vYSui5lNIhmobH1CrA=;
 b=MC7sZO/7kJsMyEdSXCeOqu0WFNdgNI+1/kOjXH4agQW3rDuRr202qokJOYccigbfOX
 pImlHHsVAYe4nbH+trNUi7mg/ojMy0S7TB8/ZttQaBOpfjcJYHT/isYWEjxYyGe1l7FA
 /0k0cA3zxw1oOjc9pLEId5o8X92Dwrr6dRH+Qs150PTB/JyKeUXQkXKVn9aEfibbiFn6
 rpNo8YoX08FpgCkFtb5b8pKdE7jjiHiljFW8S+3YJxi9SAFK1mSg1hs8BgC4nUybtxML
 EepnKynTFH+TqYFLF9RLSnRMrqy3T0yqlM5SlQKQ/JNsZ5k+wRu3FTIP3HP//qI8iNiv
 HWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727353793; x=1727958593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3Pj+K5ZcDexa6hoEG2gdhqy7vYSui5lNIhmobH1CrA=;
 b=NnKb5YmGj+VqZHv7118278TxQw3Nb0POM06qzGWZ+oF5UDG6slAAaE6R+hKv9eJ3fB
 fN2pmV7Wqi08a7wZ6yb5RhN90vgqfMvwC6I75AmdfuKAroV6XektBgxWfhEydqd7CYIu
 Uh4WElEZ5FFH2VBkUE2lFiUq9lLqr/ZWGUX67aRJotn70JWMnoSI6kLdbqdsG3/AQUeM
 JMb3uII3pbaZrIqd1s9KtmxETpIqjjsE8JLGMCw3bzZSLLOZm6VyfSI9GYfq0Ce5/l9N
 /c0AABvFz3WWUsLcOUDJiOX2lknAdxtCIytvCTUYgIMZn2ytvQlFZI1GU1NIV4a+7cbG
 w07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8E2aiq0uBF+IJWcZVWZJj0Y2zeLXbzvn7zdjWuJ7ZosC6MWDYbozRTylsUJLyQlkfa70t/XFl@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6MsGskq5sGRw8aBQjdpE0KGU1KXJmFKfK7PTsbL+M6jHN3C7H
 dX/l/tfNWAjl8UXU7Yls+4geftYdYzunLnvR3fGc7Ubc0qDu/9nEkPTF9jHj
X-Google-Smtp-Source: AGHT+IHRxv5AgYiFD56qdblFUjOI7TYwtAIaF7yRjEZAHEIXL6k+5hchERT5sVRRsrAHR3fXA5A60w==
X-Received: by 2002:a05:600c:468d:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42e96102f17mr35507785e9.6.1727353793019; 
 Thu, 26 Sep 2024 05:29:53 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a52915sm46183665e9.39.2024.09.26.05.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 05:29:52 -0700 (PDT)
Message-ID: <feedcd2d-eccb-47fe-9d58-b660b286bf7c@gmail.com>
Date: Thu, 26 Sep 2024 14:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/08] drm/amdgpu: Add the missing error handling for
 xa_store() call
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <20240925195928.142001-7-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240925195928.142001-7-Arunpravin.PaneerSelvam@amd.com>
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

Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
> Add the missing error handling for xa_store() call in the function
> amdgpu_userq_fence_driver_alloc().
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f3576c31428c..43429661f62d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -101,9 +101,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	get_task_comm(fence_drv->timeline_name, current);
>   
>   	xa_lock_irqsave(&adev->userq_xa, flags);
> -	__xa_store(&adev->userq_xa, userq->doorbell_index,
> -		   fence_drv, GFP_KERNEL);
> +	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
> +			      fence_drv, GFP_KERNEL));
>   	xa_unlock_irqrestore(&adev->userq_xa, flags);
> +	if (r)
> +		goto free_seq64;
>   
>   	userq->fence_drv = fence_drv;
>   

