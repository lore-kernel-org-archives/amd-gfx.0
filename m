Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B4ECAAD1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 08:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678C810E21A;
	Wed, 31 Aug 2022 08:05:30 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CC610E21A
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 08:05:29 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id y64so5482788ede.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=gLam/FTfbDQyrcki/vf3cOfz51E+6viNyByATv3cOK4=;
 b=YFF43ga7S1lQNqBDhmrOe3Sx5GjAHtf/JmTnXaQeCuTEGxCQkphkkpvb8BQskVK56l
 GeHjHZxeA0SIWrlujairmS8ewdTeJYIqpXb5Ghz9AKweI5hWkWI0C1EUMgfSLTvHwjZA
 Djnc2dXndAs4xhPxwWBdYS2F5Qf5fjzjwZqWgpYYegskaZi2NZjhGp1TjCRmaGNFUNHv
 9OG1KL8hTPZUQ3ZEpcjRNX33NpMTGbItiLeV/nDp8IQAnsCIiUoCBnOSnWiVXP8QChgJ
 du2GS4RxLu1C1Pdvq8VedDTTSQ2g6/aQwA4hmprBOS1bGeBhJZoz1x0CbU1TbaiJSkGS
 MSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=gLam/FTfbDQyrcki/vf3cOfz51E+6viNyByATv3cOK4=;
 b=joRCvbsSnavQpx83eIHawtz2UiKIkLnOQyy3ul4DruCbKTHEvcO2IvNP36l3oX+fjc
 r1Rf/QLBiExBurop6UEgIqtcrjoXBZ7Kg0zwCDadu8qrOkhqFMDA78atR/j+eWOakeMN
 8LNPEemPjz38O4VAgtth8LiCFMX46+amXBHlVEfT5hPoPOFM5CCsNHqsHa9HwZhyvflM
 XqC7Y5KgeL6bfno1k/o9RKI2KljWANV1g6Oy3zBWNLefSp5BSJcUgibtd87p0TMIJe4l
 RcDjTQiSwH9ObKD+YXPc67cqW+jlwadJBbNGMsBP0gAAXhHHNnfP3JaiPrWJAav6nvxc
 xxGg==
X-Gm-Message-State: ACgBeo33w+j5MDJ0r1ejLNNvdtKZH95Lf3YTOJfusB9F6imShKTaSvRY
 98xUdJwhkTB8dJCFdK4aBbQ=
X-Google-Smtp-Source: AA6agR4PDlv2G82Hncmfz87s3HCzlnyduVmxL2muSaN7qOpQLKoRVnWcdXkzCGH/MFPl1LzMftBicQ==
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr23352127edc.126.1661933127585; 
 Wed, 31 Aug 2022 01:05:27 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:a72b:3a8d:212a:79d7?
 ([2a02:908:1256:79a0:a72b:3a8d:212a:79d7])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a170906304100b0073d8ad7feeasm6244491ejd.213.2022.08.31.01.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Aug 2022 01:05:26 -0700 (PDT)
Message-ID: <81d366af-f017-09c5-b2c1-40af888cf8a2@gmail.com>
Date: Wed, 31 Aug 2022 10:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/19] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
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
Cc: Horace Chen <horace.chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.08.22 um 20:39 schrieb Alex Deucher:
> From: Horace Chen <horace.chen@amd.com>
>
> For further chips we will use CHIP_IP_DISCOVERY, so add this
> support for virtualization
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the entire series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 9be57389301b..0707e4338e65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -707,6 +707,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   	case CHIP_SIENNA_CICHLID:
>   	case CHIP_ARCTURUS:
>   	case CHIP_ALDEBARAN:
> +	case CHIP_IP_DISCOVERY:
>   		reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
>   		break;
>   	default: /* other chip doesn't support SRIOV */
> @@ -750,6 +751,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   		case CHIP_NAVI10:
>   		case CHIP_NAVI12:
>   		case CHIP_SIENNA_CICHLID:
> +		case CHIP_IP_DISCOVERY:
>   			nv_set_virt_ops(adev);
>   			/* try send GPU_INIT_DATA request to host */
>   			amdgpu_virt_request_init_data(adev);

