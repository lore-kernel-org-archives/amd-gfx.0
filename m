Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E27CE79AD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 05:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D308510E0A0;
	Wed, 20 Sep 2023 05:56:43 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C3A10E0A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 05:56:42 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso811331966b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 22:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695189401; x=1695794201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L3RXTFfrmpLgAue1jT6gZGw5id5epIzHPB2KbGFE4Ms=;
 b=H5Wn4f9oUViQF6ucECxiZd4O1AmpwxWkBCaSurIfWl8gqtSbf5e1xq3+AO+z86BNgo
 cgTsZ/AVNmsxwM267luB4lpCBBLyENId0yRMPPp7ygdDWhRE2i8rI3KUiAydR0amQ6wR
 /DvuK7IF1YrFL5knlIgwlxzXWoReRQWCZZUclV1ikBUvxRTyV/36oigRxTeKKYYQj4rW
 0DTh2PbemyQcJ3AUwV0heoArSgX5Eg6CZmbdA4E7AIySxWXB8uADzpNEJ8BZIKRs4POr
 LrreqQE76ctuzVP3ipNqgjvUshuIZRUPd6do5qirpWgMUgFpPOz6nyujmjUIObF9n8Ic
 IOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695189401; x=1695794201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L3RXTFfrmpLgAue1jT6gZGw5id5epIzHPB2KbGFE4Ms=;
 b=mXhcO9K1iaTOot6GshRREJdjQfsXWlfPlpbB8IkOU07Jb8Iq69LqdqWGLjJuyXpmfg
 /NpyNf03JMHlYDAq8HNiFSNaeVnKLRmjKs1SuJ7/6POxb2IpEksMJpIqaMcmLmbrTywf
 L5InUaG94aA0T0HiikKe7N4pKtmWY0WsZQ7h7tK2/rfKaT4qk9ne73JbvSJfcWaEqPFs
 KbVvuEkKX/L5VBYhcxOWQgHaE/QlMK4qAGajybpaJBwoVIsHa56rIfAc/296uhlyUvbL
 b/cGhsLXZvors+GPXfmwsHhehOSJHeBo+4M9dAL1JOS/vMMgMNTfYSJ0+b2Vik39xlv+
 89Ug==
X-Gm-Message-State: AOJu0YxGmmHx7wC5wT8naKVmmR73uTKXo2lIYodASWLX9nUbAuLjszVS
 TMEYVl60zaBz/sKbdpFa8e0=
X-Google-Smtp-Source: AGHT+IH1iE3P3UMaguH3DJQosPTbt8Rw5Y8ypbqsVh3lh1UqMNH1iXYBzVrVMEz3Sw0gy3w24GdC3Q==
X-Received: by 2002:a17:906:5dae:b0:9ae:3d17:d5d1 with SMTP id
 n14-20020a1709065dae00b009ae3d17d5d1mr914283ejv.77.1695189400389; 
 Tue, 19 Sep 2023 22:56:40 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.99])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a1709062e8f00b009ae3d711fd9sm1253597eji.69.2023.09.19.22.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 22:56:39 -0700 (PDT)
Message-ID: <20997c37-0daf-5e10-311e-d46e701c8ded@gmail.com>
Date: Wed, 20 Sep 2023 07:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Don't use sw fault filter if retry cam enabled
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230919140954.8150-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230919140954.8150-1-Philip.Yang@amd.com>
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.09.23 um 16:09 schrieb Philip Yang:
> If retry cam enabled, we don't use sw retry fault filter and add fault
> into sw filter ring, so we shouldn't remove fault from sw filter.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c7793db6d098..f357d1f7353a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -452,7 +452,10 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   	uint32_t hash;
>   	uint64_t tmp;
>   
> -	ih = adev->irq.retry_cam_enabled ? &adev->irq.ih_soft : &adev->irq.ih1;
> +	if (adev->irq.retry_cam_enabled)
> +		return;
> +
> +	ih = &adev->irq.ih1;
>   	/* Get the WPTR of the last entry in IH ring */
>   	last_wptr = amdgpu_ih_get_wptr(adev, ih);
>   	/* Order wptr with ring data. */

