Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 15:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207A910E9D1;
	Wed, 23 Feb 2022 15:12:41 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F82D10E9D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 15:12:39 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id qx21so52986689ejb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Flqzrxo2+/eafHgZTKXPT8JXkIWMfvqQYNt1GMvXdjs=;
 b=CWDkhqFGzVNdUkEWWqEt8R3tBr/+hwLGOve9f3vr0sWkmtJ+GJvxeoYBFmbTnv/rmY
 +Fpa4PQ/70tLX5jeAaCHDfIuLsmiqwWYZ0EOlwMeADCaVps6/C3rYr3TDV+TMNOeXbaE
 jM/FXnNcTqelECMjVbBK0eDi6J1H+/uzGk8XatBZv+YBZ53uxvleyiy4GGtfT1WIlxSu
 VTlgdmv9Nkuh7RMTCmRfO9Kbi5HbPYukK9wDzOvSSVSH9ttGL4Y27wr5Ibn2XTCA6/hK
 A7GV+A8cCw44DC+SLlN2+5VRenCIZ30nbpAE2bDFioP/BQJMjBxzWdG6+Ihbbth9+1na
 84wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Flqzrxo2+/eafHgZTKXPT8JXkIWMfvqQYNt1GMvXdjs=;
 b=fx3DmtCmFYlWYGck2DvDwVlR5ilxbEDBzWYzVbcKzMXTvB/dw6HsZ9uAPrIN/1HNGP
 rvfX/5loiUcYLz6Npz36PpjPxrf3qYg6Tx25QHuYR7/PMkr62OQ8t7PEBoQ7+MNh9fzn
 6TWekNjfHKcsEmLJiVEST9Z2B8PDeQhZYFYcd7FhML1eKbUF+9Zyk/nenPNJ4Gphv43v
 UtEec1TAkgE70ByKn0My9oFWpkQGWwisci7pDYTUhhTxb6XBi1Oajjgu2XwdTvme7d6t
 Hy3Ca+iD+R8R/PXBP/5WL3F0JQrnjpWM9K7ztxiZor47WjMKg4Zi69zm6Tri/pZMLRZO
 uD2A==
X-Gm-Message-State: AOAM530K+CchYCPE91fku6SfxWf9h3rikDckct/4czd27WWNJE31fl0D
 pvcn74l5DIgdI0PJUuGRT7g=
X-Google-Smtp-Source: ABdhPJzGtTvvbC9lgd/prLYjTFtcRtBHKy5F9WlV/5BfC5KuhOFMR2DS7XPoC/frdIpAn0CVwgbhaQ==
X-Received: by 2002:a17:907:1c9f:b0:6ce:e4e5:a6d2 with SMTP id
 nb31-20020a1709071c9f00b006cee4e5a6d2mr166449ejc.304.1645629158009; 
 Wed, 23 Feb 2022 07:12:38 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:6302:a8d7:78e4:4380?
 ([2a02:908:1252:fb60:6302:a8d7:78e4:4380])
 by smtp.gmail.com with ESMTPSA id c6sm7493101ejs.130.2022.02.23.07.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 07:12:37 -0800 (PST)
Message-ID: <a123ab50-87ed-5692-ff38-c6970db828c5@gmail.com>
Date: Wed, 23 Feb 2022 16:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu/benchmark: fix error handling
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220223142307.1659697-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220223142307.1659697-1-alexander.deucher@amd.com>
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

Am 23.02.22 um 15:23 schrieb Alex Deucher:
> Forgot to assign the return value here.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index 3136a9ad2d54..edc6377ec5ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -163,8 +163,8 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
>   			 test_number);
>   		/* simple test, VRAM to VRAM */
> -		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
> -				      AMDGPU_GEM_DOMAIN_VRAM);
> +		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
> +					  AMDGPU_GEM_DOMAIN_VRAM);
>   		if (r)
>   			goto done;
>   		break;

