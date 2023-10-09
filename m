Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89F6E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 09:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423AA10E243;
	Mon,  9 Oct 2023 09:06:13 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A466110E23D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 09:06:11 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3214cdb4b27so4102419f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696842370; x=1697447170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAUDs6o6lIY8Hue0wBGy26flf0/My1ck12UQ8K/Bpzg=;
 b=TXcMtuy6sZhATSITTK6B2zdN/Jdv/oGsW0fUgRyGsyBzejy4PtISfBI8/Jyz8JdH/Q
 RN7gKtdjSGWf1sNHdpxE7NbTEIvfJD3Bxow4eqCvRdJxa3nAz9XZRPDeYpzNvoYjtwOq
 jSa28hOkh3VqLixowEdDoYZiqJXIgtIcnBMQ34JOjtMmNQbUuyxSEPd8Rsx3Ob+e4+Ly
 TmTrd62MCOSJG0cxm1RBCbVAigWe/XHF12xyZxmj9vYLOXnEcz+immy6NF3LQ/Ti/HhB
 PzAGUNa14WNUlWx9w/oS9r3HJMaLabfYzoVf3VxqXMWYiMEOuGKsDmRXgNQvfeu1TBHf
 wn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696842370; x=1697447170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAUDs6o6lIY8Hue0wBGy26flf0/My1ck12UQ8K/Bpzg=;
 b=HMLW4ARBsf6YOnk9FN/nXFHADRy1rdnCwKUgR2JopK+dEkuBFSmN/GP+gKHQv9oXjZ
 uyaTt1nc8w9yUUUg+CruntoCeAvaNhEJkZBKsxV8/MF98Sm5KgdjQdq6EeG8B59e8Aca
 JXpx7AdWHeEo6bdhxQxZPshTidtNjiLyUwX18esr/+1f6sXKUdPmZ4gc+i2fvpwwcbET
 aIp8yr2CzhzXkVBsCSSXocJJtE0GQcdcT6n6D67FUy/F9gotuctJXodTnHy1YD2+g5Qi
 e/pWCZJDRIrZC0IUmZkZEgB96FEAfvzr4kIHAPeLCbqncbdPrdkB6xLrsDt0WoCUNPkn
 oMbw==
X-Gm-Message-State: AOJu0YxvuT6yicpIjgYo4rUQIzZ0Lc84jFC4bnGnnm7zwfhM37Z3kaRi
 7J7v9s0kRcxc7D4Nrt6JJeM=
X-Google-Smtp-Source: AGHT+IHLPOTYSw/Tlc4l+dGrPZYGna9MGQOuFiEbbX6apiBSODswzyZYJpmURsJQYeydihsDlLPy3A==
X-Received: by 2002:a05:6000:10c9:b0:320:fc:97bc with SMTP id
 b9-20020a05600010c900b0032000fc97bcmr12522581wrx.1.1696842369606; 
 Mon, 09 Oct 2023 02:06:09 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x8-20020adfcc08000000b003296bb21c77sm8408527wrh.80.2023.10.09.02.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:06:09 -0700 (PDT)
Message-ID: <312fe578-928b-4213-9d35-21de517d1cc4@gmail.com>
Date: Mon, 9 Oct 2023 11:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/amd: Capture errors in
 amdgpu_switcheroo_set_state()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-5-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231006185026.5536-5-mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 20:50 schrieb Mario Limonciello:
> amdgpu_switcheroo_set_state() calls lots of functions that could
> fail under memory pressure or for other reasons.  Don't assume
> everything can successfully run sequentially, and check return codes
> for everything that returns one.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++++++-----
>   1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a362152cd0da..8dfcff783dab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1749,23 +1749,45 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>   		/* don't suspend or resume card normally */
>   		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>   
> -		pci_set_power_state(pdev, PCI_D0);
> -		amdgpu_device_load_pci_state(pdev);
> +		r = pci_set_power_state(pdev, PCI_D0);
> +		if (r) {
> +			DRM_WARN("pci_set_power_state failed (%d)\n", r);
> +			return;
> +		}
> +		if (!amdgpu_device_load_pci_state(pdev))
> +			return;
>   		r = pci_enable_device(pdev);
>   		if (r)
>   			DRM_WARN("pci_enable_device failed (%d)\n", r);
> -		amdgpu_device_resume(dev, true);
> +		r = amdgpu_device_resume(dev, true);
> +		if (r) {
> +			DRM_WARN("amdgpu_device_resume failed (%d)\n", r);
> +			return;
> +		}
>   
>   		dev->switch_power_state = DRM_SWITCH_POWER_ON;
>   	} else {
>   		pr_info("switched off\n");
>   		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> -		amdgpu_device_prepare(dev);
> -		amdgpu_device_suspend(dev, true);
> -		amdgpu_device_cache_pci_state(pdev);
> +		r = amdgpu_device_prepare(dev);
> +		if (r) {
> +			DRM_WARN("amdgpu_device_prepare failed (%d)\n", r);
> +			return;
> +		}
> +		r = amdgpu_device_suspend(dev, true);
> +		if (r) {
> +			DRM_WARN("amdgpu_device_suspend failed (%d)\n", r);
> +			return;
> +		}
> +		if (!amdgpu_device_cache_pci_state(pdev))
> +			return;
>   		/* Shut down the device */
>   		pci_disable_device(pdev);
> -		pci_set_power_state(pdev, PCI_D3cold);
> +		r = pci_set_power_state(pdev, PCI_D3cold);
> +		if (r) {
> +			DRM_WARN("pci_set_power_state failed (%d)\n", r);
> +			return;
> +		}
>   		dev->switch_power_state = DRM_SWITCH_POWER_OFF;
>   	}
>   }

