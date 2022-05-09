Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91FBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 06:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7652010E6E7;
	Mon,  9 May 2022 06:58:34 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B95110E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 06:58:32 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id g6so24922712ejw.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 May 2022 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=1MIJdZ/3gFRNIckemPyrS+oBqy2IGj8wDbT6g+j0R6g=;
 b=B1Dhs2VtrnSGBzZJnruRrjLIFBtuOXEMScY5+Asa4Omc1d35PipLQcgciMrw7y8sU4
 2znanqTzULsUD0TBly2mJwyPR1R5Qw3usJ/YWbAPekSO/VlVDovBFpOtcDhapLgAPGOk
 jsq3NpEWkQ/YubV2WdibepjGbVGxGaYfpxlgcWEdKOoKnb+hSg8GFiCxYTVpxvCV37K9
 uTajDCoDj1uiz9hgqkcnL1uAOreeGbM/I2822Lw98qOzZi8LHGUvhbZ9PeQLUd8Ayc2o
 DCyE00lt7QzFddovTK8llJ5TIJGGaKC23ecXUGrHjnavioDB/+Tbw25HjaR+Pho3j+vT
 +Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1MIJdZ/3gFRNIckemPyrS+oBqy2IGj8wDbT6g+j0R6g=;
 b=2UVPHbGsxQ3Dh+MUDkkjVDSbuUtlid4SZaN9KxXWYnAsLY1aueNBpxhdbWDSAOixyi
 aKxubImezURvmTQOl/DJk+28LolwDDntwJXmRoH5xnE3zXoUW4YqvevYpb8iCwuhGys8
 PCtVWUSD7eDfdzOFNSrZl3Z6lMQdKnhlhLyhS0JANx3UYX1kr+ypnmYhH8jstuvdpeel
 fWR+WYU/6vgQwZA4AufzMbcM/I2JWCGqG3Q6TB9J5219S+EyYvg1McizpRuTli3SH2y8
 Dmbe3vD/tk7ljGEjaEIBj0av3kU0Yr0AHuav13XPHh45MuHk30k8IS1GrJBdsaCZzKsS
 OsLQ==
X-Gm-Message-State: AOAM533q73sHYPNb7c75RJigQm/q9bRT9wczweTwczvoGtBgHplwYoaX
 53QndGgPfR6WA99aS3S2MAg=
X-Google-Smtp-Source: ABdhPJzThImemTESN64X3TJs2PBw0OjBc5dvZEz6zvco4y0vXEc91uPJskvZucEyrURN0WyZSfzBwg==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id
 fj4-20020a1709069c8400b006e07c756f01mr13254613ejc.103.1652079510933; 
 Sun, 08 May 2022 23:58:30 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b3fd.dip0.t-ipconnect.de.
 [87.176.179.253]) by smtp.gmail.com with ESMTPSA id
 i24-20020a05640200d800b0042617ba63a8sm6000623edu.50.2022.05.08.23.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 May 2022 23:58:30 -0700 (PDT)
Message-ID: <5ee6b398-f566-bde1-0ac2-3af96cd1b75f@gmail.com>
Date: Mon, 9 May 2022 08:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/vcn: fixed no previous prototype warning.
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220508173008.281673-1-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220508173008.281673-1-James.Zhu@amd.com>
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

Am 08.05.22 um 19:30 schrieb James Zhu:
> Fixed warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence'
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> index 08fd61622f95..1ceda3d0cd5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> @@ -21,7 +21,8 @@
>    *
>    */
>   
> -#include "amdgpu_vcn.h"
> +#include "amdgpu.h"
> +#include "vcn_sw_ring.h"
>   
>   void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	u64 seq, uint32_t flags)

