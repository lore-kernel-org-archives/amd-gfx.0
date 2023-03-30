Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E597C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D643B10ECDA;
	Thu, 30 Mar 2023 06:17:20 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1657910ECDA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:17:17 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id eg48so72160700edb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680157036;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7rAc5FhwhJ3r8Fuuzi0Jo76g9RjzPLa52V1aOhZZJU=;
 b=JgyB389G+ukSEL4091u+LlKyIetfYK70gl9VezYgjrWop5V1ZEGi5vGm+A1SleZuF3
 9T3hCpKlDZ+l3fd7fREOGt/PeX9JTNd+loz/vSVZGiAtnkScL4fiXkGeUPx26zZKqIuO
 6RZj7IRkmdwAbmV+DOtbo9S+x9LFh/MNSLN+7Q0EIN/vrGgEf8/5T4piUzRvvS7kVx+0
 KSu1FWkhlFEZQ1+3zeElrvW3qz2GgoTWSrHqO9g/iheR/EMCeBuiZgcVGQn7+Sd2joJ9
 TRAXAGvq5whTnT6gUqiL3znZiZrQRTatJt3eoHcR8Pdggd4zbHfy5cndPs59/aB2lY5P
 k3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680157036;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B7rAc5FhwhJ3r8Fuuzi0Jo76g9RjzPLa52V1aOhZZJU=;
 b=cLByHCZiHWWhwoTKzgH5oIUxQOf6MgNzrTiWvnJIdZuncW7lQHO7X1pUqZI7HzjJ8l
 ZMyKg2ZFDgF1eyOAeT0RAYmmhQlOI/fyP7Kr38rSC81kUfqE7rXBDeokjLB7FLDH3yQf
 gzwpV8ij1NE8F3iufnnrTd+eu+KGC+GTL8gSyAEAaBufmPmdmVcfurkYCXI/z/+0mYrS
 AjdOSY6rEWDeePwE4NSIhNx7oVg97IGFzxrnerlOgKO+wClwQQxTHvf1Km0jVe5z2XB+
 8LPAPkOdMoOWuKAc2ARWDdOgLyRPAQwmE3xslSXrhZpsio+v2kpYsZevAM0L9RUeojjj
 KYyw==
X-Gm-Message-State: AAQBX9eiBAQ/udJ3Qw9kPcaWOSUeZ+4QzNVVffV3JSibmr0xadPz4MYy
 z/za8L1unab8JLBvNSngZmQeMx20z5g=
X-Google-Smtp-Source: AKy350ZRV/MHUw4MHE31o+tYDojMNlYqZYCPVWY2iLI4QO46Vxt957fJ3jKLFVOL9R1++G1NolDXAg==
X-Received: by 2002:a17:906:608f:b0:877:573d:e919 with SMTP id
 t15-20020a170906608f00b00877573de919mr21191383ejj.20.1680157036109; 
 Wed, 29 Mar 2023 23:17:16 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 hb6-20020a170906b88600b0093120a11a5dsm17358695ejb.92.2023.03.29.23.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Mar 2023 23:17:15 -0700 (PDT)
Message-ID: <33ad3215-55d5-723d-f1f5-65bb6d3d1d75@gmail.com>
Date: Thu, 30 Mar 2023 08:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/13] drm/amdgpu: add support for new GFX shadow size
 query
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-11-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329152521.1980681-11-alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 29.03.23 um 17:25 schrieb Alex Deucher:
> Use the new callback to fetch the data.  Return an error if
> not supported.  UMDs should use this query to check whether
> shadow buffers are supported and if so what size they
> should be.
>
> v2: return an error rather than a zerod structure.
> v3: drop GDS, move into dev_info structure.  Data will be
>      0 if not supported.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0efb38539d70..90738024cc1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -876,6 +876,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		dev_info->gl2c_cache_size = adev->gfx.config.gc_gl2c_per_gpu;
>   		dev_info->mall_size = adev->gmc.mall_size;
>   
> +
> +		if (adev->gfx.funcs->get_gfx_shadow_info) {
> +			struct amdgpu_gfx_shadow_info shadow_info;
> +			int r;

We can probably use the ret variable here instead of declaring a new one.

Christian.

> +
> +			r = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
> +			if (!r) {
> +				dev_info->shadow_size = shadow_info.shadow_size;
> +				dev_info->shadow_alignment = shadow_info.shadow_alignment;
> +				dev_info->csa_size = shadow_info.csa_size;
> +				dev_info->csa_alignment = shadow_info.csa_alignment;
> +			}
> +		}
> +
>   		ret = copy_to_user(out, dev_info,
>   				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
>   		kfree(dev_info);

