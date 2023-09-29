Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A36E7F153
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 10:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC3510E10C;
	Fri, 29 Sep 2023 10:26:34 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0858A10E10C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 10:26:31 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533edb5ac54so12901591a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695983190; x=1696587990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pRyW3KdsCb/EKU+9PcCY2CVBDYz4xB5TJVq0gVgZ6yE=;
 b=HWcbuK73EiIu7UtESXUdEqDoAeeYpq5HgQNo0qGEJTrfnhAqPDdxfnGS3RwA4TYMvX
 vZDI5qYEiQ31lTUmhMB/NUXCovjpgHlo/ka5w6spQ8OMAzVB0sOGGixd6InykyI4rD/b
 uJLuDiODHWQ0xW7uOhnuHWj/jEnZSk8RhoBEeTpxDm5AcW0fBuP7NyTo2ZSmn74esWVh
 6jHFDbZxq9ZlPrioZX+oDIzEz6+maegRd1blIKApwqnEQvtm00/MwbRkWSzKtAHpxrZt
 R6wC3a5qy6h8jeXnxngDa6wSU1rwt9Lh7lZMQoO0/xKLgdmmovbnjixQPLJL5i8D9y3i
 Q2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695983190; x=1696587990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRyW3KdsCb/EKU+9PcCY2CVBDYz4xB5TJVq0gVgZ6yE=;
 b=uy9mVcV1sOR1zulk9xZYR8A0gTQLIVnsy5d1dgbnnePh0gab7NUnkK4+ocGCHkm5P1
 PKxRk7H1VvDnCErwxcDL8B+BNmPAShBV0nagthIYR8iCqS11mL6/wEziiO07utcfAEL7
 bD2UZbVFF5+8u7LXLUgtAbLfyU4JXaTKniS6Q82uL/gGR+HVN3bVqshSHYNcHiZyzKR7
 i2aA7nLFg1sad1v2EP3QRRLSRzqSGjc/jRAKHJKX1ofq7rK4e/3r74Q/y53734q95SYT
 8RTanweAlSqHAmu0SnV3xUqhJpHxiiqQnPq7QNbOeckcxM473jYvuojh8G0JsZ2/1dW2
 6pjQ==
X-Gm-Message-State: AOJu0Yx0W0UdY+U7ejCdClSG2WBp4WHRUhqj6KyJE6jqrjOnjGl3MOMk
 skHtc7/ZNGK/2a36gjULvsE=
X-Google-Smtp-Source: AGHT+IG8kHeAScxfo7k2gkpQhUJl3NPL3FAaUqDnwq8IPCRLZOiss9EBm4pOFOJY7XkOGphEegfQzQ==
X-Received: by 2002:a17:906:5dc1:b0:9aa:16c4:be16 with SMTP id
 p1-20020a1709065dc100b009aa16c4be16mr3171811ejv.57.1695983189925; 
 Fri, 29 Sep 2023 03:26:29 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.65])
 by smtp.gmail.com with ESMTPSA id
 v10-20020aa7dbca000000b005330b2d1904sm10824274edt.71.2023.09.29.03.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 03:26:29 -0700 (PDT)
Message-ID: <7b3ca5a4-2b48-24bc-10c2-3c373e7c1d85@gmail.com>
Date: Fri, 29 Sep 2023 12:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230929093747.1456991-1-lijo.lazar@amd.com>
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

Am 29.09.23 um 11:37 schrieb Lijo Lazar:
> Move definition of package type to amdgpu header and add new package
> types for CEM and OAM.

Please don't move anything to amdgpu.h that header is in the process of 
being deprecated.

What are CEM and OAM good for here?

Regards,
Christian.

>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 73e825d20259..ac048a77e97c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -302,6 +302,13 @@ struct amdgpu_hive_info;
>   struct amdgpu_reset_context;
>   struct amdgpu_reset_control;
>   
> +enum amdgpu_pkg_type {
> +	AMDGPU_PKG_TYPE_APU = 2,
> +	AMDGPU_PKG_TYPE_CEM = 3,
> +	AMDGPU_PKG_TYPE_OAM = 4,
> +	AMDGPU_PKG_TYPE_UNKNOWN,
> +};
> +
>   enum amdgpu_cp_irq {
>   	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
>   	AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 42ac6d1bf9ca..7088c5015675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
>   
>   #define NUM_XCC(x) hweight16(x)
>   
> -enum amdgpu_pkg_type {
> -	AMDGPU_PKG_TYPE_APU = 2,
> -	AMDGPU_PKG_TYPE_UNKNOWN,
> -};
> -
>   enum amdgpu_gfx_ras_mem_id_type {
>   	AMDGPU_GFX_CP_MEM = 0,
>   	AMDGPU_GFX_GCEA_MEM,

