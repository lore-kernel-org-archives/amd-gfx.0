Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1592C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 14:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1902610EC9C;
	Wed, 24 Apr 2024 14:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IScRdoAW";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470FD10EC9C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 14:23:39 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-41b1ed3ffd4so2917855e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713968617; x=1714573417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5Nv5bC8/XE5hdCjDsttHVbHjitMMdQYFm6PVDPRK7Q=;
 b=IScRdoAW9Nxc2d4RwWYHV4gGz5pys0+imFAMLsUfoK/MbqOuxgjz6YGjZNQn059TKW
 2ZlamfM5xtCgc9Vk6Zk3xzqu8oVezeTyv48r2LnqYhS5GZt6+HE5Lad659FEpviNzTqn
 JqMUU8UtxnCn/d2NYw+n2+5eWfw1erxMJHmqVR6KVRdOHaFq3d5GFKgyyfOpSq9FiPZR
 cEHlHMK4ZCKbweJ2cvNfBy3ISGil0g2tmTO3XmcXPVBBEKgkkgUwbz1lFuaaWBMRjANW
 MClmOdDRVxQ2EcL4S9SziFd3J4J6SMvaP9YXlbcbEsq21J0qkUqwA15Bv52yZQhUGG+W
 3ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968617; x=1714573417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5Nv5bC8/XE5hdCjDsttHVbHjitMMdQYFm6PVDPRK7Q=;
 b=SQps6ok420q4a6WlMSYZ9UrtayLlN6gwviJ8pGvf+JNQPUfUhlFAKbVsR3fBbpIcLV
 4YbwyUHs7tmwbttElm5tHObihcWRUxwlLa6p82Wb0BIC8piC6/MurXmMzacTOqI4qlns
 O2lTcnQoDCmPsKCqFCxoHnk5yR2MXBYT/gr3A0kZopJLC/XtEP8d7JWJcHSXB2jtSpqw
 KHlmjJu2l/icSXa+U35+RBiLm+7ERnwZ4stowfa+xkGMkjwT1uC8KPiCFgTv8bG45FFF
 jjzeTF6un1E2swtet/elzhRhglHy/J2EwEZCiUtq4BeYOCFpgABrmvKP+qgDIGE5MxxL
 jJ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQuCQkC+ZSFPXyKvj1rpkMF7F4wDTg8NIeYHkN/zuUwbL0tCDo33aFo//FW+67axGnwoDn14m6g0WQM7ATIOKuYjVJ6OLGKLLigM2Shg==
X-Gm-Message-State: AOJu0YxDqzofUgH/gucgqx6UWqDS2lPXEWIGvOYQxj13oe+T5dEbaa/J
 rsT71dwuzIgeFb/NXKMIwz7yErsmrf+5RvSitT4TAc05ukgEXZMH
X-Google-Smtp-Source: AGHT+IFaxSxlnjMqZYji36PANBxBe+8Ie11BMht+rcSwU1RlK8bDNGxuLv+LzeaV5BkB09C4YQKQ7Q==
X-Received: by 2002:a05:600c:1da7:b0:41b:24c0:aec5 with SMTP id
 p39-20020a05600c1da700b0041b24c0aec5mr406687wms.13.1713968617241; 
 Wed, 24 Apr 2024 07:23:37 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a05600c190a00b00418a9961c47sm24031541wmq.47.2024.04.24.07.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 07:23:36 -0700 (PDT)
Message-ID: <aba22e69-5640-4821-a469-da59ad8ffbf1@gmail.com>
Date: Wed, 24 Apr 2024 16:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix uninitialized scalar variable warning
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240423143109.1288890-1-tim.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240423143109.1288890-1-tim.huang@amd.com>
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

Am 23.04.24 um 16:31 schrieb Tim Huang:
> From: Tim Huang <Tim.Huang@amd.com>
>
> Clear warning that uses uninitialized value fw_size.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d95555dc5485..fb5de23fa8d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1205,7 +1205,8 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
>   		fw_size = le32_to_cpu(cp_hdr_v2_0->data_size_bytes);
>   		break;
>   	default:
> -		break;
> +		dev_err(adev->dev, "Invalid ucode id %u\n", ucode_id);
> +		return;
>   	}
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {

