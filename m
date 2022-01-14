Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1F6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 15:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B6310E28B;
	Fri, 14 Jan 2022 15:41:22 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8E910E28B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 15:41:20 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 l12-20020a7bc34c000000b003467c58cbdfso8154644wmj.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Pg5a9tja+yv/r/8OgkwUvxnOTQWMS5B4M2Xxobe2itk=;
 b=XGcgOjN844wbFhi/wAAseGRHTD9ge7sGOqB5MjdQaAjLZwxcMvghbslQRom8lH0bOx
 2KCHKfuLXl+Je8uJlFf/Rf7EymSg0SglKK1X0dw4aRYbyAHHQKA7682cU1/2x9U6aSbL
 hdKempH+NP2b4Kg5KkktixNBGs3/8J+IFwOcqe6qU413eZxI3ZY6F95xHTNXRAQjzzSy
 VSoQJDPMGRKzIyA66Wam0phZ0kmkk829VPqNGxgBH22dfdEJHFutwSOsaKF4I/ydoGVi
 hh7tjd8neqeMAzA0+1jAUWGjUoMDBNbsyaZzaodAhdCurXfx77VaETaid4HyHkaPGcD7
 Fqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Pg5a9tja+yv/r/8OgkwUvxnOTQWMS5B4M2Xxobe2itk=;
 b=pMxaX8jWiWc7nuiOfmIdqcFUakfiQvg1EVnUoemv22y7UV6XAI8RF/bIT86k0WqXfu
 RvbaitVWlAJgLMB+eHah2kR8NAZ6m0A0kK9oWv49+BtjDyEGWE1+IqqiO6dD2tYAsp0/
 jo/IR3NMNQW0K2EsT3x6OcCGmk5v1O+TUHrt1UTVyg+K9Ra+4opt3Ppl9TG+7z+KFRO4
 yq7axGf83CSPrW5C9Fq7ljc85sebviUXlvmLQ1urG3TJySKlHkft/ApfioEjrXiBaTZE
 qJaSy1IfNAi4/u1Hi/0pRQD/a4DjCGLk9H/eznjZus/pV3DcBMxHHb1cQOgZfjZksDIb
 PumA==
X-Gm-Message-State: AOAM530BHgNOw4dck8AD1/w8fdARAhSZIMXNnYAtdkvbf2u/YiaFe4QD
 oiuJ/u7aJ+7epwhNfZ26HwHo+DJwau0=
X-Google-Smtp-Source: ABdhPJyYqsYEqcN2OTEuhxKajUaQxEqHyBcDbwOqzWwfmx4f8zMhu4yDKlcJvWYvfH+gKZIYF89y0g==
X-Received: by 2002:a05:600c:1c26:: with SMTP id
 j38mr8674461wms.101.1642174879522; 
 Fri, 14 Jan 2022 07:41:19 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:a12a:cde6:6bdf:2808?
 ([2a02:908:1252:fb60:a12a:cde6:6bdf:2808])
 by smtp.gmail.com with ESMTPSA id n15sm1062368wrf.79.2022.01.14.07.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jan 2022 07:41:19 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220114150240.1008818-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <30e9a5be-0315-651b-c98d-2810ea1274dc@gmail.com>
Date: Fri, 14 Jan 2022 16:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114150240.1008818-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 14.01.22 um 16:02 schrieb Alex Deucher:
> Support for IP based discovery is in place now so this
> check is no longer required.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 224d073022ac..25e3ed351fd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1903,11 +1903,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   			return -ENODEV;
>   	}
>   
> -	if (flags == CHIP_IP_DISCOVERY) {
> -		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
> -		return -ENODEV;
> -	}
> -
>   	if (amdgpu_virtual_display ||
>   	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>   		supports_atomic = true;

