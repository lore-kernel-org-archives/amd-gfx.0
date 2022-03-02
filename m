Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD7FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 16:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872A010EDD4;
	Wed,  2 Mar 2022 16:53:54 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20F810EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 16:53:53 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id i66so1520737wma.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=H8o3pcCa93nBFcPC2dUZ5t0MATa7g3+O09uRQc3h0CE=;
 b=EEMqYC5pOoQHhVGyXR+Das8E9nEvAdh6+7SNI8SVVmwt1gLK3HAPaB7p0/yWUXn2YT
 0+skKV50c5ff/l8wl9KvowAONfj/9tBjowZl2P2SYEK6ymNjRC8hzhY/MgJShFhtV/tC
 qzX7G52vxIXy6qYJjcvVwSs4ueHLqFNkt0fv9Y3s0Gy6yJqpVkdWa2ANDnmpNiV2s1R5
 dhpgiulaIuorHVZD5fmnu6hrJlntBz43xM4KbeWwx79spxe0AFtD7EgYWJot3BRPk/wI
 roXakRrI+XKvJvxaD0EHckxT1ZP4I/Vo1qN/PW5K5gk+pVTtdevifv+iy/losFQHhOnD
 GQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=H8o3pcCa93nBFcPC2dUZ5t0MATa7g3+O09uRQc3h0CE=;
 b=KQ/xuoMqN2Q9U1grRZpz2Thyiimu8uomVoQNIXWQC5mfIA32frOjEXT10sIGP49w6+
 XFXKz6QVHBKiPnEWdvp2V9EdM3liorlLmMXbitFrlLQtWp7f3U0ahq2ih9aM66F8Iwl0
 tU1oVf+jmG+jiLVi28ARQ9CAPeQwj42YpgSsTRFJivygc3cKsprjKz2eAf2k3W0Nj+fj
 FwlBuLA1kGwe/iChOEZd8pMAJWhjRptL/aF1dZHd0eMOfsYmk5p1O4hX/o0LgxCFKOMO
 tiHHMVkBvk2QyeqQZaFoUYA0g9T3iinQBQAGOL+7mRbzt7zOL+DLxhgky+wwymIIEjms
 DcOw==
X-Gm-Message-State: AOAM5307QqsN6/AaE22Yjxl3EpSkXECybj5hbKoIThkrfyvDt9cLNZGO
 5D9Kretu71ZpHkuQNhkqSQw=
X-Google-Smtp-Source: ABdhPJyupx71+bETyprlfjNi0y8QFK9/ocNh5OcPqP2/esnN+Ww+cGoEQvRYz/thWbJMOCM7s4wb9g==
X-Received: by 2002:a05:600c:378b:b0:380:d7b4:c4a1 with SMTP id
 o11-20020a05600c378b00b00380d7b4c4a1mr539962wmr.171.1646240032433; 
 Wed, 02 Mar 2022 08:53:52 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:49ae:65d3:55b3:dd3f?
 ([2a02:908:1252:fb60:49ae:65d3:55b3:dd3f])
 by smtp.gmail.com with ESMTPSA id
 n65-20020a1c2744000000b003862bfb509bsm981754wmn.46.2022.03.02.08.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 08:53:51 -0800 (PST)
Message-ID: <d4d029c6-b132-a0be-5ec6-c295eba4e36d@gmail.com>
Date: Wed, 2 Mar 2022 17:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: remove redundant null check
Content-Language: en-US
To: Weiguo Li <liwg06@foxmail.com>, alexander.deucher@amd.com
References: <CADnq5_Na2UtFUTX5uphZH6THw7PisPM835TLgjB=Ne_3==VJUg@mail.gmail.com>
 <tencent_DD9048474C138FE4294644B7CEEDF7D84806@qq.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <tencent_DD9048474C138FE4294644B7CEEDF7D84806@qq.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.03.22 um 17:17 schrieb Weiguo Li:
> Remove the redundant null check since the caller ensures
> that 'ctx' is never NULL.
>
> Signed-off-by: Weiguo Li <liwg06@foxmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
> * take Christian and Alex's suggestion
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f522b52725e4..2f38de406937 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -261,9 +261,6 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>   	struct amdgpu_device *adev = ctx->adev;
>   	enum amd_dpm_forced_level current_level;
>   
> -	if (!ctx)
> -		return -EINVAL;
> -
>   	current_level = amdgpu_dpm_get_performance_level(adev);
>   
>   	switch (current_level) {
> @@ -293,9 +290,6 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>   	enum amd_dpm_forced_level level;
>   	int r;
>   
> -	if (!ctx)
> -		return -EINVAL;
> -
>   	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>   	if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
>   		r = -EBUSY;

