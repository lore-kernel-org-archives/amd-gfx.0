Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B313AC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 10:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21A910F17A;
	Fri,  8 Jul 2022 10:05:17 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD26112099
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 10:05:16 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id u15so12435819ejx.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xAEUsSOv3AUPBSnuwtv4j8MOsIbYlDnajPcRwnpB2T0=;
 b=ZeK6wTiDkN7b4tqaT4h7hXNihSVy2UMnUkvGd8kb4RRIq8aBYLUJC83C4dR5ZcsTw+
 PBkMNeUWXOM3Wvbup603/uIoTTNb8FLATsEFVQBzCx6ErtEIvGl/8MXswljZmfxAwjOV
 oPzRGLM227sb6X7ElL+xopHxRNR/21AiOnzy9P9pS8OxbQhtyQx01Jz+h3zd+aeu7bJ6
 6MAkc3625PDhQnjc+HZ1fcuY12UD6pbU82IqDmUlty5fDijKA8aB6sUlI8uPYQJznsei
 9mjG/Z3oNgGClogi4Hffis3Yr0frjImj5tgP/Co8zgaW63QtJ6rJM3wf0Ymsk3sFLDAn
 0uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xAEUsSOv3AUPBSnuwtv4j8MOsIbYlDnajPcRwnpB2T0=;
 b=uQsx7l99NpllTi16NyBzhDxk3KEPiiipASu6SYrgATvUhm/40EkXSSZQGnv+d5flyS
 NYkIvT8EZSiX7dp3bBz5sa6u7i3ofq1bpG7EnTqNw1NhM6+Ia9VgdXElyKeC3sO+pL+u
 W5b3Ye6kfrMtfsVPiJEUg33LJC1LJY6V3STxMKq6HXmFgZt//kQTHWdrN0v2DaJfmMFF
 X/N0PrnsuwK/oacWNYva1ilppQUz+VGDUiHtEupHOcJ3GoMy6aJWcHzWZQiZSKvEslEJ
 kx4wIuLLwIkrfxvPpTgEgNe/i3+uiObCd9jOoyyZZHW1c9H4KWcKlSCUqGIcUQHK/Zoi
 UmUQ==
X-Gm-Message-State: AJIora95GmLePfo9b8MZXh4AZ3VAdSln2YVFClysrTR3PxbHZfQIUew5
 ekHJbC+IuSMk/EMw3BsBCKkpAzuBizs=
X-Google-Smtp-Source: AGRyM1tF8crxlPZeXsFREMphHADNwlYImXVspOEnm9LJ5e39N+bY9C9tOYAMi1tCdqHKiU3QKS73kw==
X-Received: by 2002:a17:906:8a58:b0:72a:d029:d92e with SMTP id
 gx24-20020a1709068a5800b0072ad029d92emr2627936ejc.354.1657274655096; 
 Fri, 08 Jul 2022 03:04:15 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:95df:c673:e23c:7b70?
 ([2a02:908:1256:79a0:95df:c673:e23c:7b70])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a1709061ece00b007121361d54asm20020146ejj.25.2022.07.08.03.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jul 2022 03:04:14 -0700 (PDT)
Message-ID: <1045fcae-f72e-44b3-2392-021efbc8630d@gmail.com>
Date: Fri, 8 Jul 2022 12:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Remove one duplicated ef removal
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220708015346.3027-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220708015346.3027-1-xinhui.pan@amd.com>
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.07.22 um 03:53 schrieb xinhui pan:
> That has been done in BO release notify.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0f9811d02f61..49536fa8d269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1583,11 +1583,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   	if (!process_info)
>   		return;
>   
> -	/* Release eviction fence from PD */
> -	amdgpu_bo_reserve(pd, false);
> -	amdgpu_bo_fence(pd, NULL, false);
> -	amdgpu_bo_unreserve(pd);
> -
>   	/* Update process info */
>   	mutex_lock(&process_info->lock);
>   	process_info->n_vms--;

