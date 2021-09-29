Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1517860F58
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1517860F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8F16E197;
	Wed, 29 Sep 2021 09:16:57 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43B96E197
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:16:56 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id s21so3039856wra.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=wqNJ5SNTgknIupOcMp59GxxSFHujm5VVAZagUSVdybM=;
 b=Aa8Fmc16n1fVLZgHq2T1dUy4wk4CZVzrS3yuqEqafLkRJg4JSTuhqGJLmGTbltPTZ0
 MqX9/lB+ONgVRz95DWvJkjq+4a6Wbry+auMWQlcRJyx1lbDmutPp3G0SAS3H2/PPtC+m
 l/86uGimDzEXPJUEgg+sGwlaaruA0M7cDsbEDSW+AhvMO1b+ZMbk8ik3nN7PV2Yx1FPL
 yvJRS8Sbp2/5Sjw6nmBRe6yAorGwEvkDb3IBx8jWr265ykgvXzxl6VN+qzVhjVfJbCcF
 nTNYMyrmrlKlGIy2YLvZTssoKEGI8yaQzlgqW4vE1Wbdrk4CNtlcHc3hJkFik51DKCnB
 000Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wqNJ5SNTgknIupOcMp59GxxSFHujm5VVAZagUSVdybM=;
 b=s3iZmZmOQS/kXdgKtcA+I9njNVe8D82Ce6JnJZYZ9+E44dMLexvNie+nk0H+i8zubU
 d+e3RIQsPpz38cwwPLzLnYaTqPFgB9FeL5WfbiuBfyNV+lKiFAqltJlsQzBHn5DXZQhb
 JIEKN33F8HUTZeTQUv/DvDBF6tJ8vHeFSSK4XZBYFwFh5K6bxXj0UtMJdpiL021cossq
 uIMZ+nSE44VgimM8tgK0P0iA52RpWlxZnrbGVClgXd9NzSks4Pm2mhT6At3DYojhDq1e
 uvQJ2iuaHi3ckgwnSVKnoUPZpIzJx1X7obECMMygR6Pr01tDYVAqQTWohvf8PTbU06in
 NZyw==
X-Gm-Message-State: AOAM532zperM9CgJAF3bTUSB2zx5Oq7L0t1QYtMZkaCBy4RyYo2j3MFD
 si/Yt+Ay4f6McW3IDUAK4UuEZhEzxVs=
X-Google-Smtp-Source: ABdhPJyzZwWHgs5ejXIkm2DFbkYe8Ros1YD/Ri3e6X001PvUYZJC5hocIqL6jIfNIXCYPCHU5JfC6Q==
X-Received: by 2002:a05:6000:160c:: with SMTP id
 u12mr5514055wrb.100.1632907015477; 
 Wed, 29 Sep 2021 02:16:55 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4405:6e4f:ef81:78d1?
 ([2a02:908:1252:fb60:4405:6e4f:ef81:78d1])
 by smtp.gmail.com with ESMTPSA id d3sm1929547wrb.36.2021.09.29.02.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:16:55 -0700 (PDT)
Subject: Re: [PATCH 31/64] drm/amdgpu/soc15: export common IP functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-32-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <562f7253-7f0b-6580-519b-f96066b846e7@gmail.com>
Date: Wed, 29 Sep 2021 11:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928164237.833132-32-alexander.deucher@amd.com>
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

Am 28.09.21 um 18:42 schrieb Alex Deucher:
> So they can be driven by IP discovery table.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 1b1e9bfd20f1..dffe7d7ff9e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -706,7 +706,7 @@ static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
>   	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
>   }
>   
> -static const struct amdgpu_ip_block_version vega10_common_ip_block =
> +const struct amdgpu_ip_block_version vega10_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
>   	.major = 2,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
> index a025339ac5e9..f9359003385d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> @@ -28,6 +28,8 @@
>   #include "nbio_v7_0.h"
>   #include "nbio_v7_4.h"
>   
> +extern const struct amdgpu_ip_block_version vega10_common_ip_block;
> +
>   #define SOC15_FLUSH_GPU_TLB_NUM_WREG		6
>   #define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	3
>   

