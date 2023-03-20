Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F261FC77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 15:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895BB10E5DB;
	Mon, 20 Mar 2023 15:50:27 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AC510E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 15:50:25 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id i9so10829643wrp.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679327424;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vEc13fCNEv863hN+YdpZ0jFbDRqPvZekTQifnHxQfYI=;
 b=lPFA43mWy6KNmcJPcV8Ud3MqpXa+q5eruADryeK9S1SKC7nv6gcAobxib+Hddd7TgY
 5ARpqent+k+pBb6O6tMQF+Cja04WlA2nAyhS87lSB+3XN3GVQhFpjgcof0p8RbGXex0x
 /nj3GPnJkcToCXC6lcTj6S44bKVNDGi5ZRR9Ue6tmNclyuCMlv8Uwhd59lwX6XlSULzr
 qoMoVi3js86NRGE/cBnm+Eu7JbfKJsnmIrxwitXmemAZ7kI9yE193o5+ew4NT2LsGZx0
 lFPa1fLCoSuqr7jffB31JvlrvrGAWW5A4mo7g2m28vP5GYpxjS2Bp6F4DX3rChSlheNz
 9JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679327424;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEc13fCNEv863hN+YdpZ0jFbDRqPvZekTQifnHxQfYI=;
 b=gM88r/ozB6JlFfhYom17z3lpPDJ6i8F+qSajpTwD15rJWyxYnDRM3sQ2NTFBtFtqUM
 alSYVGVHZGnDRpYjDh+QgELgAB/RLQxcA6YLeO6ihu0TX4PPQaLNKioZ5Cd2ghxulppe
 K3nKwwhSDVRagmteqAXXPvrivTbpYoebpQaYgXuGJp69siIapWHCPzDltG+A1gnRrspM
 AJOiI7W/OdWLiVUP0GhkfhbIi5Jniggga78Uph+vXGVFfJyZ1CBhjYcpeARywcXgpbB4
 UirTIzB7UWbnUaRV4qr1LcUfgSLYxWNSDt3p0hRQqsFdGr6Xcdb6r/fqc0JGiCMtEY4L
 mwOw==
X-Gm-Message-State: AO0yUKUHSicgqhp2MxtEum62v8p4AwuTjLNbn6uEkGtBwilAWVjuISBk
 wzUH5aD+dPDtTR4dLAu0zAU=
X-Google-Smtp-Source: AK7set/ji8GWoMb//cLfl2hUFNw+6DnAOwduhJTPHSifF1XKHJqgrJ7ycL8I03m20PNlTWwqmPCmmw==
X-Received: by 2002:adf:eb08:0:b0:2d6:6af:4899 with SMTP id
 s8-20020adfeb08000000b002d606af4899mr4236711wrn.8.1679327423814; 
 Mon, 20 Mar 2023 08:50:23 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fae3:596:f1a7:6853?
 ([2a02:908:1256:79a0:fae3:596:f1a7:6853])
 by smtp.gmail.com with ESMTPSA id
 e23-20020a5d5957000000b002cfefa50a8esm9150855wri.98.2023.03.20.08.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Mar 2023 08:50:23 -0700 (PDT)
Message-ID: <85ad6c14-e85b-ad6d-f037-a4c85d541181@gmail.com>
Date: Mon, 20 Mar 2023 16:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/10] drm/amdgpu: don't require a job for cond_exec and
 shadow
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-7-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230317171748.682691-7-alexander.deucher@amd.com>
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

Am 17.03.23 um 18:17 schrieb Alex Deucher:
> We need to reset the shadow state every time we submit an
> IB and there needs to be a COND_EXEC packet after the
> SET_Q_PREEMPTION_MODE packet for it to work properly, so
> we should emit both of these packets regardless of whether
> there is a job present or not.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index d88964b9407f..cd5b0df44ffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -213,10 +213,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   
>   	amdgpu_ring_ib_begin(ring);
>   
> -	if (job && ring->funcs->emit_gfx_shadow)
> +	if (ring->funcs->emit_gfx_shadow)
>   		amdgpu_ring_emit_gfx_shadow(ring, job);
>   
> -	if (job && ring->funcs->init_cond_exec)
> +	if (ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
>   	amdgpu_device_flush_hdp(adev, ring);

