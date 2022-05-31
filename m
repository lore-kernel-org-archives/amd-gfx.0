Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAC0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF19C10E61E;
	Tue, 31 May 2022 21:13:38 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF2F10E585
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:13:37 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-f16a3e0529so107733fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0iFqr5PP1EuugXkA1O8Xc3S1UZCB1JjvppypLn9yLqE=;
 b=N/slr4o0JQ2gJB+r+YSKYm++8BDmhm91Tu1NQ1dhVUwBSb4ZRhnrjyPT4MtvzUYlKZ
 jCzxjcL57DRo/5TfNSM6/8u/U84JfoP3N4Yh6JIZLdbOrVOSgxFSyvEd7KJJ2PupGswI
 58Wf7hpwpI33ot1Sz5yqgxOJ9SaRY5lxDNDjUbhosyDSCQyGwbPeZe11SiYXvbECoGTX
 zt0uN2mNfs6Lg6pO3Ptcd20tR2ArpO98IXdfponDHt0PaLkelNuEXB4+9oYSxGRI7YtN
 pR9BzxahFqISfrzS3nvlSp/YhRzRvgKL7AqaHAqauu/GimTdYMlXcKXtOEnLXtq4ZI5L
 XaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0iFqr5PP1EuugXkA1O8Xc3S1UZCB1JjvppypLn9yLqE=;
 b=F2aGEvzE66ulaDZ3YKoN4EuD3kTEAsmYfqE4Uxv3BXeA0XzN/IcqgDpn7STtT7TD8l
 NIbK4Hocuu0qzrz5VBqa2dXuCNFbM+MKrC5+qygel73ajqVxe9eEp8rUX+P60/ricZG/
 HtwxbMk3nmp0/Tj7wMnwqJzZvGJncSZH3HOsd92IVLvn9RvpOvqMBQmrebLcQ735rdFA
 MWpdEmJRROEkb7jR6HLDLKtYp0xk81O5Kx1pH5fhDf032pt2bYTKDqNsXRndDNpAsgS5
 l8L6DcfU5vaG8ngb+1QHHvovuwcfjOzskRU9rCmW5WNCS/UGpS34l6Xu10rddjXlYjcA
 +PfQ==
X-Gm-Message-State: AOAM532IQaoDZN0MEwl8nYXJOa1Z0c8GdpWn9pqJmns+Jk4Y9ieOTIDM
 AIsR3K250bUohMUfSPToADRYBVdJhQ2JSAaaxGo=
X-Google-Smtp-Source: ABdhPJzg3pbD/NaYW7VsqfNyboio6IBeNxVVpkeiz3UaNMYvdPFb8vJn8UX26pBX70CA6bZQpEcwLbtyvWibzyvK3NY=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr13912922oaa.200.1654031617015; Tue, 31
 May 2022 14:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-2-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:13:26 -0400
Message-ID: <CADnq5_NqOGL6g435kS6NmqiU8+wdbzpowVwbzBqoVCnYJj4otA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify the logic in
 amdgpu_device_parse_gpu_info_fw()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, May 24, 2022 at 10:09 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Drop all of the extra cases in the default case.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ----------------------
>  1 file changed, 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4daa0e893965..7f7d475c46b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1942,35 +1942,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>         }
>
>         switch (adev->asic_type) {
> -#ifdef CONFIG_DRM_AMDGPU_SI
> -       case CHIP_VERDE:
> -       case CHIP_TAHITI:
> -       case CHIP_PITCAIRN:
> -       case CHIP_OLAND:
> -       case CHIP_HAINAN:
> -#endif
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -       case CHIP_BONAIRE:
> -       case CHIP_HAWAII:
> -       case CHIP_KAVERI:
> -       case CHIP_KABINI:
> -       case CHIP_MULLINS:
> -#endif
> -       case CHIP_TOPAZ:
> -       case CHIP_TONGA:
> -       case CHIP_FIJI:
> -       case CHIP_POLARIS10:
> -       case CHIP_POLARIS11:
> -       case CHIP_POLARIS12:
> -       case CHIP_VEGAM:
> -       case CHIP_CARRIZO:
> -       case CHIP_STONEY:
> -       case CHIP_VEGA20:
> -       case CHIP_ALDEBARAN:
> -       case CHIP_SIENNA_CICHLID:
> -       case CHIP_NAVY_FLOUNDER:
> -       case CHIP_DIMGREY_CAVEFISH:
> -       case CHIP_BEIGE_GOBY:
>         default:
>                 return 0;
>         case CHIP_VEGA10:
> --
> 2.35.3
>
