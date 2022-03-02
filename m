Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B01C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 08:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C116B10EA43;
	Wed,  2 Mar 2022 08:35:54 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7262410EA43
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 08:35:53 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 bg16-20020a05600c3c9000b00380f6f473b0so2750715wmb.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 00:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=fzX0MRjEHD1jxxhsHdsntOIEo5znAt3PjLW6m984x84=;
 b=D1wa1VPyNDwL1hd2JqwS+9k2qflcRo+qQJV5xa3s6IMB8lAh+j+zrWVPU02fDwUDFf
 0vVvW/LQZ6dyi2RXf3Hpx4JY0ss4C3H8XxqMtoyUevbd1XzHxhYElzd0pG9g0SZ8kojT
 Pnv+jF5azmEo0PEcEHK3bfE2SuVhTOWfQz4lDvfRwLySkvV6oPzOf5k066mh8rOBPiW/
 /EuDF8xzQk8JkOy5+zwwisoqN2o303ifvHqPruCgTheHWc/3fysLUUh7WQPyvHk+Xw96
 U8EaLYJLSUFvfYfF5X0+gfnOmYWYr0K2gjM6z/KKj2gt+holDAwj5NpjDzYyXX2ER42K
 ELlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fzX0MRjEHD1jxxhsHdsntOIEo5znAt3PjLW6m984x84=;
 b=Xh/NhGXv0ghxLs6RS3x0/qyciMa0Te6sha4J8+G8Gd9l5q63+yBXmKy9ohpXfsXzqb
 tNShsEwUz+rAQBWZOJLKNU1reEYXVyX1jgOBP/lV9fysE+dZp6zHt6EbGm3opRgixCCj
 U1ee9XFnOCztvuNQv6yOBfamZ3scXWwVe1sCB9uXueepfB5LVphlfn1e/JquvYsvADUy
 iLt0soYKgaL0enNxH2oRoOMjHmewFr/5+4iyl3CDQ/Ag8BgzGypv7Yzf2ij54v0vNbmy
 KYizlMrlrNzRDYdgoUyctE3YVzpIJfY8/IEF0fnbBIUQweNo+F63RnqMD2quPL6pTlEJ
 E+Yw==
X-Gm-Message-State: AOAM531aaQ07jIUvJuqVqUA14oiLIrv7T46I1BlDjNsvXTBf6N7z9brV
 q3kOmZ2ai+4kuvfTZf/dsjg=
X-Google-Smtp-Source: ABdhPJwio3qnoytxq6Hx5uqsjwzdm4gIDVggxSghdF1DqhbuLcmEhfq3Dc8Z9D1A+nkwoJDdZZSO4Q==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id
 f18-20020a7bcc12000000b0037c01ae100amr20588033wmh.54.1646210152045; 
 Wed, 02 Mar 2022 00:35:52 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:91d6:cd7c:ea5f:1ff5?
 ([2a02:908:1252:fb60:91d6:cd7c:ea5f:1ff5])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a056000120600b001ea9414f2c3sm16066240wrx.12.2022.03.02.00.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 00:35:51 -0800 (PST)
Message-ID: <b2af1138-641e-fbf2-9b1e-6263a5997558@gmail.com>
Date: Wed, 2 Mar 2022 09:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] drm/amdgpu: remove unused gpu_info firmwares
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220301160114.1404305-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220301160114.1404305-1-alexander.deucher@amd.com>
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

Am 01.03.22 um 17:01 schrieb Alex Deucher:
> These were leftover from bring up and are no longer
> necessary.  The information is available via
> the IP discovery table.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 ----------------------
>   1 file changed, 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6113ddc765a7..2f732a1758d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -80,12 +80,7 @@ MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
> -MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
> -MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
> -MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> -MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
> -MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
>   
>   #define AMDGPU_RESUME_MS		2000
>   #define AMDGPU_MAX_RETRY_LIMIT		2
> @@ -1992,27 +1987,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>   	case CHIP_ARCTURUS:
>   		chip_name = "arcturus";
>   		break;
> -	case CHIP_RENOIR:
> -		if (adev->apu_flags & AMD_APU_IS_RENOIR)
> -			chip_name = "renoir";
> -		else
> -			chip_name = "green_sardine";
> -		break;
> -	case CHIP_NAVI10:
> -		chip_name = "navi10";
> -		break;
> -	case CHIP_NAVI14:
> -		chip_name = "navi14";
> -		break;
>   	case CHIP_NAVI12:
>   		chip_name = "navi12";
>   		break;
> -	case CHIP_VANGOGH:
> -		chip_name = "vangogh";
> -		break;
> -	case CHIP_YELLOW_CARP:
> -		chip_name = "yellow_carp";
> -		break;
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);

