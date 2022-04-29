Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78626C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 08:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E3D10FB93;
	Fri, 29 Apr 2022 08:43:25 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26E410FBAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 08:43:22 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id k23so14119837ejd.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=dUGVOWhALHxX/czFK83q3G0+vSU1W7m4/dJ2DRK561I=;
 b=QURw9yvADTeKfItKfxo1NmWKH4NMYUTmnp2seuhun3YyUtfMFjPGiGkAEzYCaeINQD
 WMZ1XOlMqHS0JWNev4we8oR4uzycGSyFq3s30NJyO9fuxFHPo9+6EVwIZwPfHrFja10n
 BgVhGtXY8sB31WHiTX2ZNlymT8l1JMKyms0mriNZovBsypcrd/CMNaIfKTWs3ODivc3u
 9J5IRhQXnGNrDx0q1y/HcxZiB/w/I33BnDy5bGP09u/4KqySetH6P7+Ea6s/FJRvyixx
 cjxgSdWEumHDih6YxVQHS4GzgtP0dm3kuvjOxBzcY2AYbxWsNZwjc1XpM17vCWxpwCmQ
 yRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dUGVOWhALHxX/czFK83q3G0+vSU1W7m4/dJ2DRK561I=;
 b=VOSoEfMqAvuLvp5U03lPPM48p1P2QfVyCn8j+mBIAkVPG0CVjGmsSIFXIqW1UDPeaf
 Z/BOpqCAVIVvx6InWh3NxVJNGtk6Qu7AiaYPvgVLQIhZsFJmcNjmY40mVPaPHOt+OCAn
 1m6B5uwHobbRFlVGf6R66YYe28ASgKIG7VBEKotoOOG2Hz6lEqCtG6hMTZWOo6UCZO54
 pYAR0zgw0+ggKb93wIAYW41q70PKhGEkQt0z/gKRLcASGORCuuPYMnTIZYEqOUxjcGNA
 heCtLuuUKyY2E/AntWo89MG5kSzzsNkZjPri66bc4b/mWdQopyHgHmUVBXLBIU5dux6i
 jbyA==
X-Gm-Message-State: AOAM530mEFd86cYcYMqLwUL5NutquTfl6VoFGe/q56o9iYpTh9XQBDh4
 uT1CmmUrv0FnFA0TInXdbeg=
X-Google-Smtp-Source: ABdhPJzNbkFrPal35AwSyjbiD/xrn27h4rwNjIj9u+/qE6e0IOJTHjOETA1HgNh/ZYV0nGnhseLu1A==
X-Received: by 2002:a17:907:7f0a:b0:6f3:9863:4183 with SMTP id
 qf10-20020a1709077f0a00b006f398634183mr22585691ejc.576.1651221801265; 
 Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:86bb:6f99:8ce5:4317?
 ([2a02:908:1256:79a0:86bb:6f99:8ce5:4317])
 by smtp.gmail.com with ESMTPSA id
 s8-20020aa7cb08000000b0042617ba638csm2678634edt.22.2022.04.29.01.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
Message-ID: <0c42bb8e-b446-90e1-b47f-41ed09359ea3@gmail.com>
Date: Fri, 29 Apr 2022 10:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Free user pages if kvmalloc_array fails
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220429002911.8207-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220429002911.8207-1-Philip.Yang@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.04.22 um 02:29 schrieb Philip Yang:
> To cleanup the BOs of bo_list which have got user pages.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 44dcbef80229..ccde951244f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -543,7 +543,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   					GFP_KERNEL | __GFP_ZERO);
>   		if (!e->user_pages) {
>   			DRM_ERROR("kvmalloc_array failure\n");
> -			return -ENOMEM;
> +			r = -ENOMEM;
> +			goto out_free_user_pages;
>   		}
>   
>   		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages);

