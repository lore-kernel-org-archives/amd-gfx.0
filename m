Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B952BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 06:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5935611201F;
	Thu, 14 Apr 2022 06:40:23 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2550611201F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 06:40:22 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id i27so8144840ejd.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=adGRdKFEZcOxrQrbAP6M4wyWBaEC7isHz8Bow7yFW4w=;
 b=W/WGQc/x7Tdx+YPG6h5l/rRzWtKw9+9U5IRit5gjI9m39u5pxFSmxAM7DOAt1YEZhA
 RsGD5uZwVoTUSMBPcqpMK3GhB2F2C+yzauXj9Vxglb5so9UDNzaWx4dGif0TjuvvTzby
 NUR2Y8faHzmKtpjXgza4Puudx9nAuf+mB04JxJJOD5hnUbWwWwAAyiN7CnmLMSyOzcYh
 B2yHqFbbo5ts71XaNTg+Y657d7mOOqPLYnZm6qSlxbnSo9ho2RNeOZGALjG8zdrfN8ih
 htxe1AvAwnCa81vfsxnaPfO70sZddIdlGP52i/Fp6GfAOiEFsFvoKrYhVbIsJlzgmTDK
 Apxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=adGRdKFEZcOxrQrbAP6M4wyWBaEC7isHz8Bow7yFW4w=;
 b=3pzNXSFKBWEYuAxh2yZFx7M/X4kIvqbK8jlRhEGiIjg1xdiMb2JsaCwF7F9kPt90nk
 8EB2I+UcdfupHLGYqFrPrZhZXopeEB6HSguU5x/tTFRZ3BCc64v2ex32/SB0uPP/IEZl
 e3+wfdzDI0G8lOfcdpkmr8CJh/+K6TRNPWaeIBaU6BDfFZtl+Dm4POnA1Q2HnQUN2rNz
 eXkla9x5wtF85zXLg1pJcJnZZ5/9YYfpKooN/2rjxTWo3T0128H5pTHOj5eeIJ67tJRM
 j4XS7Hltsw9592HwfEkoZEAN4/LKQ9Pc3+P+8rpKGBs4l5Djououv8nJoncuLIFpHF6e
 oblw==
X-Gm-Message-State: AOAM5326wLDrZVZhHW0BH0T4CCuEBqs96ZpsP4UkjyaIwkRkZggRZyGl
 sCoEY0eR/BDwl4wQBYAam83IOF2TUew=
X-Google-Smtp-Source: ABdhPJyKgl456Pcz/Q881jWBU1OlvNeerZwRF3KeC64qh5bK39qGGSrpcr2fG7wP44xnoHfLz8kI+g==
X-Received: by 2002:a17:906:6a0b:b0:6e8:d7ba:6648 with SMTP id
 qw11-20020a1709066a0b00b006e8d7ba6648mr1100007ejc.288.1649918420619; 
 Wed, 13 Apr 2022 23:40:20 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:3d68:590f:61e0:5f10?
 ([2a02:908:1252:fb60:3d68:590f:61e0:5f10])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a170906540700b006d5eca5c9cfsm329316ejo.191.2022.04.13.23.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 23:40:20 -0700 (PDT)
Message-ID: <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
Date: Thu, 14 Apr 2022 08:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
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
Cc: anatoli.antonovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 13.04.22 um 21:31 schrieb Andrey Grodzovsky:
> Lock reset domain unconditionally because on resume
> we unlock it unconditionally.
> This solved mutex deadlock when handling both FATAL
> and non FATAL PCI errors one after another.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1cc488a767d8..c65f25e3a0fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5531,18 +5531,18 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   
>   	adev->pci_channel_state = state;
>   
> +	/*
> +	 * Locking adev->reset_domain->sem will prevent any external access
> +	 * to GPU during PCI error recovery
> +	 */
> +	amdgpu_device_lock_reset_domain(adev->reset_domain);
> +	amdgpu_device_set_mp1_state(adev);
> +
>   	switch (state) {
>   	case pci_channel_io_normal:
>   		return PCI_ERS_RESULT_CAN_RECOVER;

BTW: Where are we unlocking that again?

>   	/* Fatal error, prepare for slot reset */
>   	case pci_channel_io_frozen:
> -		/*
> -		 * Locking adev->reset_domain->sem will prevent any external access
> -		 * to GPU during PCI error recovery
> -		 */
> -		amdgpu_device_lock_reset_domain(adev->reset_domain);
> -		amdgpu_device_set_mp1_state(adev);
> -
>   		/*
>   		 * Block any work scheduling as we do for regular GPU reset
>   		 * for the duration of the recovery

