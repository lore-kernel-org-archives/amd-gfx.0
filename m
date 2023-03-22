Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2185DC6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 08:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965E010E36D;
	Wed, 22 Mar 2023 08:48:34 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B06810E36D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 08:48:32 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so69702568edb.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679474910;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+5jgo36K4UEp60b0loNYxwW6OEvf4rw7+rBhvi/qDc=;
 b=dcyyTXNksqB/gia45l3Fk9o9ooDof0XzUXIFkCGyNU43XcD/Pzl625Lbn1B42P6KFu
 7iGgh1fQ9doNaIZn4AgzzhCgHPuJo+v3pXGf5b8YoquNfmJjZ/JBhVF8gBrfv+NGHs6A
 jMGdavmHNUya6fQQic3/bAcmUgTOh9xztFE4kpyjNsxJyA4inj3unjQg0lrruDl4aSiB
 0stqjZoUZZdL/OM7IpZ831qmQ1z3j/J8Sa/fPKFsFP2rAiPgckDktKPbKJRkV4liawmG
 vlA8zs7SMkWCiEHLH7LWiiDrBkzBn015rY4HemGGngz6lRaPSkicAYAlIp6MgMsNvCvG
 9jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679474910;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+5jgo36K4UEp60b0loNYxwW6OEvf4rw7+rBhvi/qDc=;
 b=EABlyAvtRyzuQE6X2bQiaWKqZa3etZakzG3/A7ECG9rJ/u4Ugt/XXIMia0g9FmJHjP
 HVhQGp34paTFqYaQXm4a4laZDBwHahlbYrPwYr138AGHgeU9tPt9H83G8ynwLP3ek7tZ
 FNqtFDWa46D3ZT6ZhgX1duxwIqQzV0zLeo/X2ZistQPy7Oxv+EV3A7JbGlgpo1Wi5fEc
 6f6OdEHkAJS/+NJ2bmIPtvX4G9T782tM7tpfDlLbA8yMgQl/7navaO1zPy3MKmY+W1qZ
 f7tyVJpzf8P+qV06GxC+MZaZCmOWKBnRhSW8VFyQbg4Uea64nVYfwL24xfwvSwfOA0b3
 PGCQ==
X-Gm-Message-State: AO0yUKXH5Cit0XJ4tdoJ6A+tuanU/Dpasf0LAQr/hsYiDXsiBVqnZ399
 WsROrXMbXwpPDbAjxUHNp04=
X-Google-Smtp-Source: AK7set8aLk2yB0hw1nLKYoS5ogq1n8LlXbza/bbSh7AFo3gWHeGTfxU9UaL2Pr0/p1BAKOOaNnQ+hQ==
X-Received: by 2002:a17:906:2c4b:b0:931:cac0:60f3 with SMTP id
 f11-20020a1709062c4b00b00931cac060f3mr5438394ejh.60.1679474910432; 
 Wed, 22 Mar 2023 01:48:30 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:65e5:3673:f4af:8235?
 ([2a02:908:1256:79a0:65e5:3673:f4af:8235])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170906285300b009316e0b610csm6882866ejc.34.2023.03.22.01.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Mar 2023 01:48:30 -0700 (PDT)
Message-ID: <07b35e4b-c574-0ad8-9c71-591dc5457979@gmail.com>
Date: Wed, 22 Mar 2023 09:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] drm/amdgpu: track MQD size for gfx and compute
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230321193922.2029808-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230321193922.2029808-1-alexander.deucher@amd.com>
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

Am 21.03.23 um 20:39 schrieb Alex Deucher:
> It varies by generation and we need to know the size
> to expose this via debugfs.

I suspect we can't just use the BO size for this?

If yes the series is Reviewed-by: Christian König <christian.koenig@amd.com>

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c50d59855011..5435f41a3b7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   					return r;
>   				}
>   
> +				ring->mqd_size = mqd_size;
>   				/* prepare MQD backup */
>   				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
>   				if (!adev->gfx.me.mqd_backup[i])
> @@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   				return r;
>   			}
>   
> +			ring->mqd_size = mqd_size;
>   			/* prepare MQD backup */
>   			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
>   			if (!adev->gfx.mec.mqd_backup[i])
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7942cb62e52c..deb9f7bead02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -257,6 +257,7 @@ struct amdgpu_ring {
>   	struct amdgpu_bo	*mqd_obj;
>   	uint64_t                mqd_gpu_addr;
>   	void                    *mqd_ptr;
> +	unsigned                mqd_size;
>   	uint64_t                eop_gpu_addr;
>   	u32			doorbell_index;
>   	bool			use_doorbell;

