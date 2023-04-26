Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB330C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 11:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CBB10E90B;
	Wed, 26 Apr 2023 11:45:58 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B472410E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 11:45:56 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-50506ac462bso10419910a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682509554; x=1685101554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0OiotprmFME73oAgw7iDeIJhEkiluzEHSKar2ScdlA0=;
 b=i9t9wa71zVFaShUbxY2GXoWNm2JaNs0cLZcCCBrAv/C9Q/CyiCQwcUik3GJLLqqSJ5
 nCeFrJZD4+QPHp+YK3UxKc4yieQ526sNZ3sg2cjL1fHLpPVsupUkdoakbZAjWzJ2e35r
 Oui0gzyL9QtG5hkyvHSYw36SmHYB3Ms0kfC8NXjHr1nYjtRHGAY0Ds9cz+BJa0lWfuxj
 GSeYUyZxK5oKf40W9JwvUl0E7rf/eZkiYIPoxfrL9ycQusdqdOrTnjjDcba3m/u9pPGa
 X7caj8i7PDiipLjze21PulicHCPa8/Xx04HdT4krxQlrEy8Auicr/3dHer2hdDzZyPtj
 OSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682509554; x=1685101554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OiotprmFME73oAgw7iDeIJhEkiluzEHSKar2ScdlA0=;
 b=VTEw1UV+CChHC1ZldI+jPbuho+VXvNlQEMy9sfhCiZxNmmI33BVCbL3NaZV0eXJNIZ
 dHtTTsc5N67QJpC9UsdrDydclRZbigxyqXP47/B40nHeCNCiZStGvhiPsSoTOZNEtuoR
 7nFuLq2bNCHxYbTWCBmvSoGabKLI1944+AI1YmcweV84RQp482LikD5fVLGLGME0xVFu
 D9CoaQuR+oY1hNj7/2ngZWvyEu1wQVNWQF6rJe1mauVewm7vOopa1/kfWgSBzjMerEbT
 PqEIKfITiyC27V2mqnhiTDeHprwp+xg3kFmvDg2p5C9J/EY+Ls6bRBs2l1tUX9Y+XsMu
 Iuyg==
X-Gm-Message-State: AAQBX9cvOyibl2h1zcmmKoRwZe0jZuow/nU6zH9cRE52NuyIiWIjxy2x
 LDpHo8GmioGiGsjzMsXwehk=
X-Google-Smtp-Source: AKy350YYCLbrEdkV3eRzaFCWVWXxAKWdQulu0/0O1T5WkC/jqv0nwKRwOtxFUqehirVxX0CgdhBXUQ==
X-Received: by 2002:a17:907:76ea:b0:955:dcc9:d101 with SMTP id
 kg10-20020a17090776ea00b00955dcc9d101mr18148396ejc.18.1682509554126; 
 Wed, 26 Apr 2023 04:45:54 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 g25-20020a170906349900b0095336e8e012sm8217717ejb.176.2023.04.26.04.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Apr 2023 04:45:53 -0700 (PDT)
Message-ID: <de89cc6f-5e95-59cd-df98-19fd000f2263@gmail.com>
Date: Wed, 26 Apr 2023 13:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: fix a build warning by a typo in amdgpu_gfx.c
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, le.ma@amd.com
References: <20230426031130.147291-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230426031130.147291-1-guchun.chen@amd.com>
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.04.23 um 05:11 schrieb Guchun Chen:
> This should be a typo when intruducing multi-xx support.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Cc: Le Ma <le.ma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 60bb4bba1994..2cf1f88fde48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -470,8 +470,8 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		j = i + xcc_id * adev->gfx.num_compute_rings;
> -		ring = &adev->gfx.compute_ring[i];
> -		kfree(adev->gfx.mec.mqd_backup[i]);
> +		ring = &adev->gfx.compute_ring[j];
> +		kfree(adev->gfx.mec.mqd_backup[j]);
>   		amdgpu_bo_free_kernel(&ring->mqd_obj,
>   				      &ring->mqd_gpu_addr,
>   				      &ring->mqd_ptr);

