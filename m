Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B29FC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF0911BCDE;
	Thu,  7 Jul 2022 18:23:48 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA9311B9DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:23:46 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id n66so15239743oia.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K2l5F4dc2kprDJbBx9G1DgCj73eILsVLGFPF+bJSRlk=;
 b=KPXE87qpdgZa1oyS2BwctG6TV4lDc4ZN63Ncv3e4DwV0U4k9+Phd9JF7SCZtU0VS+y
 FegY3cE+GL1erkJfQC+ytVF5y1mEOh38dMD6x/ofJ7ii0psKzdplk+yvS+MGrpiFMmbL
 YvCPa9HuZ/NZIv2TgANDXiUQqBKHGR54MFuEq4MHShNzN2JwKOZclyUnxN9ngEpQ2YgA
 y6TjRhYRnFNfFiAgrb+9uAEk6ZpVN/kGvPIc2l4ubJuLGzY7cYGGf3tARhgDnqwbMB3P
 Xx0Y5ZZLPpHh2BmZmth/IVLmwkv6yJ7V79ZU1BXdgfj0xHXvxFtyj23odZZl15Mhs8X3
 Ckhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K2l5F4dc2kprDJbBx9G1DgCj73eILsVLGFPF+bJSRlk=;
 b=BofBECWn7VowIxpVXSaaGCyicYOEpenHeminRRtHE7QpiT/4jFt5fx0qts79UuG3ls
 J/fDGKN3ae/9q7Nnogy1S42urKJ8CeCOCQQQDoDm57+QCH3eCCHIbSQGeuc5x1EzKPZ4
 sTHUJfAqlX/tGue+0dmrBhMz6vf7IFQ5X3utG5SSOI10jS8lJGDcAMuoj0ibVuwOl1Qf
 cHzVkDdRxIgYSo1AZDKuzNzaE6tYgB/fXv+tAyxLguFIurnCLnT/8mGWQPnpo6KbeSor
 +zmb0ShQwSSJCiQFIhrzOWpB5Yx7YPwbZpNL5n64/R3FqFgrZA7WWE2taYIVTEDTl4Tu
 yulQ==
X-Gm-Message-State: AJIora9/bpxAH+5nyPyZg/JV5HRnFaGgQdbC3rraJcvGOSHhWjxpe1Xu
 0KHpBI0oe4aHpnvqP9yiCW61IKp6qvoD5PPI20G1UA==
X-Google-Smtp-Source: AGRyM1vDqJ6jYAfS3d7ZZa5Hmyulu3LIOBi20NdsVnLsrkp/J91a7WPRN/NHwmcW3W8PRis0yOYl0Xi55Hc4YcpX0iw=
X-Received: by 2002:a05:6808:1691:b0:325:61f7:7e6a with SMTP id
 bb17-20020a056808169100b0032561f77e6amr3384227oib.256.1657218226102; Thu, 07
 Jul 2022 11:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220707095053.6755-1-xinhui.pan@amd.com>
In-Reply-To: <20220707095053.6755-1-xinhui.pan@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 7 Jul 2022 19:23:34 +0100
Message-ID: <CAHbf0-HhAEk3P+pV=T==EV9f_yXbwMu-qBJ3V9XFi80mmuwVLA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
To: xinhui pan <xinhui.pan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

This appears to fix https://gitlab.freedesktop.org/drm/amd/-/issues/2074

Feel free to add my tested by

Thanks

Mike

On Thu, 7 Jul 2022 at 10:51, xinhui pan <xinhui.pan@amd.com> wrote:
>
> Fence is accessed by dma_resv_add_fence() now.
> Use amdgpu_amdkfd_remove_eviction_fence instead.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0036c9e405af..1e25c400ce4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>
>         if (!process_info)
>                 return;
> -
>         /* Release eviction fence from PD */
>         amdgpu_bo_reserve(pd, false);
> -       amdgpu_bo_fence(pd, NULL, false);
> +       amdgpu_amdkfd_remove_eviction_fence(pd,
> +                                       process_info->eviction_fence);
>         amdgpu_bo_unreserve(pd);
>
>         /* Update process info */
> --
> 2.34.1
>
