Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766DEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 13:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B391110EA86;
	Tue,  1 Mar 2022 13:15:46 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E8010EA86
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 13:15:45 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id p4so6847494edi.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 05:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=6LpUvgln5ZaVyPgod0VxMqPJAqqHVvfc9RdAu4bNRkA=;
 b=bwj/OUPyBzDXvWJisFarYFVXJjcZ1R32pIlf10S5W/7JaEf/H2PmkmP94nx9KFpdTo
 xu+ydK5xYn2l/epVV0J1KvAj0WbTwFztVcYXly+XSI5czYjdncNcytuw/KDv5vKCZfpS
 fBackBIuAYPhOA6hAXm+b4b/CDGbaYABpev0iPpJwW53hzciHEQ0C8jWfZiYnGNby7w8
 YGvCg6wOAndNd8QzQz2Gq3eQdrBOOyWfxVh06dgClUBIrjFUAHuVyeubuVlt0JwY2Mx/
 qKPPZqZdgEf17bEGHynkHCW233LGsdjzYkvVnyyl2VRJQBxaQ6cTVf8iBAiVWLZDcg4t
 ddGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6LpUvgln5ZaVyPgod0VxMqPJAqqHVvfc9RdAu4bNRkA=;
 b=x31FzS5jKhcT+xXcaOyYmqH8Moa+yvZkCFWvlWkV8J2SEy++x6Wd61qUCvl/BUf+M9
 oyb0g572QwOW/uuAD6volHB+DxfxX77+3D5Q1nQQu2a+nmlYhHSHKyGXPHIrmU+2AGIS
 PjFbciQfIDUNve8LjxAl6/IcP09M8wtAAefSShrDZ38l5A19+fYsO28ALBPF62/mBJqK
 FVlT8R4nfv6uFxgjqdWxHrgwB+jGjXbF9T8gxMNAP1xsYea1/WL9hJWX/5WToW3i2oKd
 GxiXH2a/tsR+lqt73mXiIQtz/OC5UsPzMWGJWO4rjDyqrmNOr/wwJQEFf7P/bQk/SJlt
 Kq6A==
X-Gm-Message-State: AOAM532Y+Bw8J8y20GGyauD6miXUGVir2bt+6kExq5o16aJwG3hkRNLi
 kZtQ8iGISaUeL61CaXboKeU=
X-Google-Smtp-Source: ABdhPJxv4U4oMrEU4pvWH8cKpCBZDJ7kE6EZ6dmwvmrHI4tSUdj2/sYelYlqHGEicCSf15FCdf/IUg==
X-Received: by 2002:a05:6402:528f:b0:410:e24f:91fd with SMTP id
 en15-20020a056402528f00b00410e24f91fdmr24925171edb.99.1646140544431; 
 Tue, 01 Mar 2022 05:15:44 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 go41-20020a1709070da900b006d643bdd4d4sm4947782ejc.56.2022.03.01.05.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 05:15:43 -0800 (PST)
Message-ID: <5fd37a12-15b4-dbed-441b-278d3a39578f@gmail.com>
Date: Tue, 1 Mar 2022 14:15:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add noretry=1 for gc 10.3.6
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220301130505.3723500-1-yifan1.zhang@amd.com>
 <20220301130505.3723500-2-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220301130505.3723500-2-yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.03.22 um 14:05 schrieb Yifan Zhang:
> From: Aaron Liu <aaron.liu@amd.com>
>
> By default, set noretry=1 for kfd exception test.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ab75e189bc0b..4bbd8501c6c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -595,6 +595,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>   			gmc->noretry = amdgpu_noretry;
>   		break;
>   	}
> +
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 6)) {
> +		if (amdgpu_noretry == -1)
> +			gmc->noretry = 1;
> +		else
> +			gmc->noretry = amdgpu_noretry;
> +	}

You should probably move the whole switch case to version checks instead.

Christian.

>   }
>   
>   void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,

