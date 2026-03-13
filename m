Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B6106FD9A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A81210E009;
	Fri, 13 Mar 2026 08:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="e9d2UbTa";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F6510E009
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:39:47 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b943b75dc42so297405266b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773391186; x=1773995986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0x1u5UHM2GdPCyUBfPkJyDi3DwiMDi8D2gqVPIeYt6g=;
 b=e9d2UbTanit/q3LmliKIAQdNj6QAdmgKNjGwLguyCj633dV7lGWajSWqFoJytHp+QK
 JA0CFkocRFf+FirrgkmUITySzFIswTr8As4H++0zYCmJ4/vKBROaA3oxYHb2/DLaFaU6
 UJxqOOREU54L2VC/Lbq0R6NIv4jbk7hgY+B4I/sbXjGzq9LNzeSie3Rf9bdkX48szSrh
 fcmNx/dLbsM5oBay5/l5NRKpVowNCKDI4XID50Wh58ULMrwniI7/9vFch8vCiKt8CUnj
 DsgRcLwinkEmzXTJm1K/r0a+Aobhq1QidaLacmq+Zn4Re3TNfEIwIQ9KyQmTOPTuV3ba
 baZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773391186; x=1773995986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0x1u5UHM2GdPCyUBfPkJyDi3DwiMDi8D2gqVPIeYt6g=;
 b=EjSlssccWuGoQObL9vm2dffs0CVMuP/Kq5GtgHmlV88tbaYmKuPPFDxtaMBkxrY4po
 pjoGge4cUftXMtWHGJID7twfmomPIAwNIgPXoiS2GnlpQXuAfBYqQWBNfpfhf3UEg30q
 0Mo5F5qcowYlJpgVZTQ4gfGAmRoARclZfv2Xu0TXFLL9ZYF1hDZ3o3ANKWO5gz2J5ENo
 mcPJ37k4XXTdLFP+Y9Jo6DqfejCwCsfrYfVNJnDQDYjMlSmC+AmnBr/kvT2MbE/SiYEQ
 OxMHUDYeasiGxbJ4vdXukF7PkeRRGJWgHUXx+Ggs3UovK32eM4VWGQXlKTBkagDTeOvn
 eu+Q==
X-Gm-Message-State: AOJu0Yz5R7nSZDw5iLprsu9Bq77hgU8NXZzAM8osDbDxWFMynOfuREHF
 Hknd+zQj97c+5Q8PAjYKzGXDFavmXT1rxo2du80/TXoJc8Rk0MWxnIwjI5GEFW4tKrQ=
X-Gm-Gg: ATEYQzxLcIOHuAUJUdv9LRotK6CzY+S73+iPcaTt5w2BTOSQZJNVvumL6JEn2pPIe/W
 Z3soCgLEQ4VsEPBhs30u+ZlK3HpHYl2mK5QG1vt4e/BYvQlOF7eunDxLQG8ABIymb76aMm8URNG
 D2qiomQDJqjnnFtCEG2nBmHQxflmjKUeDuzz907CnLaPBm6JNoYlOLBIATL4pedZ94R2uZh+PHk
 TKH7G+uw2SG9FcW+SN0nMc5SyrJI8FLubpJbtkLu0MtY83zrYYr/DAvvH4KV8IC8hv1FytZmCyx
 WAbLtg9TTcSybuz0svXJJCA0/H2Bxgy5BXLoZ+cYVNZF74dIZe5pW1XPLzpuP/3pWbkrJ8C4Oz6
 OSThWHPuZEXxIUgb7W99oTGNQb6JWIKLJJDkLUH/7EbM77sw8wXJaZZHtAX56xSm2Yob+8GMoMH
 xcjHEVzc8Y709ddQYPWSByFvg2s0QXNRxTDFS5CZxRgUUy
X-Received: by 2002:a17:907:709:b0:b96:ebf6:4c1f with SMTP id
 a640c23a62f3a-b97650e8035mr129869366b.22.1773391185474; 
 Fri, 13 Mar 2026 01:39:45 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cdb299esm29286166b.44.2026.03.13.01.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:39:45 -0700 (PDT)
Message-ID: <3d80b2b5-4d1d-4435-8418-f59e2b905ed7@ursulin.net>
Date: Fri, 13 Mar 2026 08:39:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects
 when count is non zero
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260310135531.3954691-1-sunil.khatri@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260310135531.3954691-1-sunil.khatri@amd.com>
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


On 10/03/2026 13:55, Sunil Khatri wrote:
> In function amdgpu_userq_wait_ioctl, call function drm_gem_objects_lookup
> only if the count is valid i.e non zero.
> 
> In case of object count is 0 set the pointer to NULL for proper clean
> up.

Hasn't this been discussed already with the conclusion that nothing is 
broken? Or I am missing something?
Regards,

Tvrtko

> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++-------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f32fd768fb..a4fff90b190a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_timeline_handles;
>   	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_read_handles),
> -				   num_read_bo_handles,
> -				   &gobj_read);
> -	if (r)
> -		goto free_timeline_points;
> +	if (num_read_bo_handles) {
> +		r = drm_gem_objects_lookup(filp,
> +					   u64_to_user_ptr(wait_info->bo_read_handles),
> +					   num_read_bo_handles,
> +					   &gobj_read);
> +		if (r)
> +			goto free_timeline_points;
> +	} else {
> +		gobj_read = NULL;
> +	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_write_handles),
> -				   num_write_bo_handles,
> -				   &gobj_write);
> -	if (r)
> -		goto put_gobj_read;
> +	if (num_write_bo_handles) {
> +		r = drm_gem_objects_lookup(filp,
> +					   u64_to_user_ptr(wait_info->bo_write_handles),
> +					   num_write_bo_handles,
> +					   &gobj_write);
> +		if (r)
> +			goto put_gobj_read;
> +	} else {
> +		gobj_write = NULL;
> +	}
>   
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>   		      (num_read_bo_handles + num_write_bo_handles));

