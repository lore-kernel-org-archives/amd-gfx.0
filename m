Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D9BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 10:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C99610E45E;
	Fri, 25 Feb 2022 10:03:14 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C73A10E45E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 10:03:13 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id qk11so9834986ejb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 02:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=lukhCgtNAw3tVAJZ2v4s/7UimCpVvJ4iTN76wtljjc0=;
 b=YWSDu8QT1IB/SWuB5YWKmajeXdgeVmjkethh9mgnimRrO1Pt993+aWDt+sLXW02szt
 Fh26Fn0X1NxpzYAKGHl/wwNF9Q1MAi1+8dbj3kmUStlKZSJYM4XjHs0ElKLzDmYDI8fk
 bxiUlNKmqLqnrYhVtu2Rj6I2bevraijNKos6m7VCp5pSnlUCiq0wwiuCRsuS4g+LPn+C
 rpqogihszh2TNNULSBPAl8r5UpmF1ofAoAirBc/xcsqzJX8HpdMni8/WwlFDf1mDjo7Y
 X+pBLMWDnQCIbqB4tfYUcRgyEjiDIN1mDIli4vRWTD1WtSS7Jnxs2WCBQBndxRZFzod5
 cxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lukhCgtNAw3tVAJZ2v4s/7UimCpVvJ4iTN76wtljjc0=;
 b=woSajlOMssRjnQ+ONaFffcbqkJozBlOAmRyyVobbnJHBEX+y4/QyNZms/8EbzBXbHX
 ofAGxGcgZzj3NF95b9YYUN0YZNiT5E3ql38znuy/cN/r94bwrDK5H0PRGCX5vtMrHGlB
 wL5sAyJF0mgVmDsuVvUjHw0+DpIccM1kIRFzjqCbNS4mtsb9bDXIelKr+W/fDVobJivo
 YHp1kO6/3UHwP6FZkKOHOJkJZF8Ixu4PE9NIGjPt169bNs10+kTfc1dwX61dPsBzBb4N
 p+EJEk6n2UkGIMJo12e/OW7rP8Vih1TjhN1/xYZKkVkP3ZKegl20XlNXpVJQsmzmFGtW
 /tzg==
X-Gm-Message-State: AOAM532xu7dSTid9wnFGxRS/l9cTtzEykcUCyecslFo46oJRrN85y/Qy
 f//GTy/u1XO6H5zsOBmt868=
X-Google-Smtp-Source: ABdhPJxF+IPkAJ2zutBli0AOOSKnz474B3vArnic9Pdv3w3lY5mEtCvkIikHIoxfMMsZs4JBz6cd0g==
X-Received: by 2002:a17:906:4b52:b0:6cd:3863:b35e with SMTP id
 j18-20020a1709064b5200b006cd3863b35emr5391167ejv.415.1645783391832; 
 Fri, 25 Feb 2022 02:03:11 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:4ec2:4724:9276:2def?
 ([2a02:908:1252:fb60:4ec2:4724:9276:2def])
 by smtp.gmail.com with ESMTPSA id
 bk1-20020a170906b0c100b006d47308d84dsm829762ejb.33.2022.02.25.02.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Feb 2022 02:03:11 -0800 (PST)
Message-ID: <31e11072-0e9a-aeb5-de56-d8d22491ffbf@gmail.com>
Date: Fri, 25 Feb 2022 11:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Exclude PCI reset method for now.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220224180521.485627-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220224180521.485627-1-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.02.22 um 19:05 schrieb Andrey Grodzovsky:
> According to my investigation of the state of PCI
> reset recently it's not working. The reason is
> due to the fact the kernel PCI code rejects SBR
> when there are more then one PF under same bridge
> which we always have (at least AUDIO PF but usually
> more) and that because SBR will reset all the PFS
> and devices under the same bridge as you and you
> cannot assume they support SBR.
> Once we anble FLR support we can reenable this option as
> FLR is doable on single PF and doens't have this
> restriction.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ecf8c307baf6..78cdbe3c4a9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1539,6 +1539,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   		amdgpu_sched_hw_submission = roundup_pow_of_two(amdgpu_sched_hw_submission);
>   	}
>   
> +	if (amdgpu_reset_method > 4) {
> +		dev_warn(adev->dev, "invalid option for reset method, reverting to default\n");
> +		amdgpu_reset_method = -1;
> +	}
> +
>   	amdgpu_device_check_smu_prv_buffer_size(adev);
>   
>   	amdgpu_device_check_vm_size(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e18356fff710..5a2ecc65951d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -829,9 +829,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
>   /**
>    * DOC: reset_method (int)
> - * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco, 5 = pci)
> + * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
>    */
> -MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco, 5 = pci)");
> +MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
>   module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>   
>   /**

