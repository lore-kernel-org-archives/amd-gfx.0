Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57ABC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664AC60F22
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 664AC60F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEBA6E250;
	Wed, 20 Oct 2021 10:55:16 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446076E250
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:55:15 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id o24so10576838wms.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Qx+OHHyeY4JelsZNCjNSSknYHiv+prF8aHO2OiisbY0=;
 b=Kr+8+U02jVXY8yd3K/yzgHE1K1C+lpahYwpo7hHfsOKdSUD6a7M+JfQqS8CbxVf1sW
 Iwe+39gMSnKUkYursZA8YeBDo1nM76T2hATS9x5aJ1RuWAajZ/fU2Nc1jsPTyYX5b1O5
 3JB/sct+PYxoSmPaD4X2cZ5N8dvxRWHrStZAhmErTS0rdqztBCxu5+++AjbUdWrGymlc
 y+kIEsUp6WLJNiWgVKhQS0PLTl0QfQaFxjXvZVMiWFo+7liG7Nh0ZmjusBpqvIEPSZ/O
 wtD7d8EvYCCWHlWoLqnYAkqItwNRX1EAvFEJ7ADr05S3o/BPfFvtJ9tVNl6MoCCnz9rB
 gmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Qx+OHHyeY4JelsZNCjNSSknYHiv+prF8aHO2OiisbY0=;
 b=PVa6jyki9+v0+jpWU1QAkHpNNS/GsrTw07BAlJGXiUnAunCHodXViN5SItVj4+wXTl
 +UvtxWdEcULvN+TiNgQ+ZNKCG1pPIOkqkfdjyiLsx8PpDXD5bbbSBKnSApv4a6GnZawE
 QFiWZ3rplShYyPQUurA2DRtNzi/OD7ai+1pqpfPHwcFYUBYEB69h0zFWG2jmcHMh/CKZ
 irDKiH8+OH7TsMQV61LNjpb6W1KupIty4hrvT27Sn8KrOBR2R5fNtpu6PLVy2BfYNTyh
 Dl2oRfEKq8dbjqZTMOLyuVbQnHOli6/oPSGscLRrB0v/iFGpv2AjwgOW61PXbQ2wvoFM
 tWEA==
X-Gm-Message-State: AOAM530O9DGL4jTqm2gppC6kQvSbz9EJGYVi/0vwU0t5oyQGMwacWQPs
 bHF9BX+PhreQYLSsxYYUq48=
X-Google-Smtp-Source: ABdhPJyC391ldoFoPpHPRfEPVflumnk9+zDf5jheQJ/cihsl8f3vZ/caDZZUByLxMhQOgq/aa3EyeQ==
X-Received: by 2002:adf:b1c5:: with SMTP id r5mr51129495wra.357.1634727313732; 
 Wed, 20 Oct 2021 03:55:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6?
 ([2a02:908:1252:fb60:6048:8836:7968:5df6])
 by smtp.gmail.com with ESMTPSA id l13sm1679595wrn.79.2021.10.20.03.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 03:55:13 -0700 (PDT)
Subject: Re: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <20211019175050.934527-3-kent.russell@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a826bce1-bcff-3984-0d27-30b6c4e0e045@gmail.com>
Date: Wed, 20 Oct 2021 12:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019175050.934527-3-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Am 19.10.21 um 19:50 schrieb Kent Russell:
> When a GPU hits the bad_page_threshold, it will not be initialized by
> the amdgpu driver. This means that the table cannot be cleared, nor can
> information gathering be performed (getting serial number, BDF, etc).
> Add an override called ignore_bad_page_threshold that can be set to true
> to still initialize the GPU, even when the bad page threshold has been
> reached.

I would rather question the practice of this bad pages threshold.

As far as I know the hardware works perfectly fine even when we have 
more bad badles then expected, we should just warn really loudly about it.

Christian.

>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d58e37fd01f4..b85b67a88a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
>   extern int amdgpu_ras_enable;
>   extern uint amdgpu_ras_mask;
>   extern int amdgpu_bad_page_threshold;
> +extern bool amdgpu_ignore_bad_page_threshold;
>   extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>   extern int amdgpu_async_gfx_ring;
>   extern int amdgpu_mcbp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 96bd63aeeddd..3e9a7b072888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -189,6 +189,7 @@ struct amdgpu_mgpu_info mgpu_info = {
>   int amdgpu_ras_enable = -1;
>   uint amdgpu_ras_mask = 0xffffffff;
>   int amdgpu_bad_page_threshold = -1;
> +bool amdgpu_ignore_bad_page_threshold;
>   struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>   	.timeout_fatal_disable = false,
>   	.period = 0x0, /* default to 0x0 (timeout disable) */
> @@ -880,6 +881,18 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>   MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
>   module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>   
> +/**
> + * DOC: ignore_bad_page_threshold (bool) Bad page threshold specifies
> + * the threshold value of faulty pages detected by RAS ECC. Once the
> + * threshold is hit, the GPU will not be initialized. Use this parameter
> + * to ignore the bad page threshold so that information gathering can
> + * still be performed. This also allows for booting the GPU to clear
> + * the RAS EEPROM table.
> + */
> +
> +MODULE_PARM_DESC(ignore_bad_page_threshold, "Ignore bad page threshold (false = respect bad page threshold (default value)");
> +module_param_named(ignore_bad_page_threshold, amdgpu_ignore_bad_page_threshold, bool, 0644);
> +
>   MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>   module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>   

