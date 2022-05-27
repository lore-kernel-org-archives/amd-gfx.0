Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D25C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 May 2022 13:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C3910EB51;
	Fri, 27 May 2022 13:22:34 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC48610F6B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 May 2022 13:22:32 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-e656032735so5782548fac.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 May 2022 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b6223VG41YQj2COFt5LSu8VrWTgFAalqG/2PoQbZedk=;
 b=eOLxSt/twHXuswTX1wpKd2SWknRFQmQkOQsMs0ngid/8gvQ4h+iQmt+fUybyUYAVtT
 RXi0JRY3wfA3GJBdT5b1UiZv2o0NuUhmr5kE/wfp0QQZ8jG9G0mznUCHuwBf/gTRmoEK
 kqwh6JML6MMh0PramSSeVP4lCUyZui6sTg8OGewplcLYO6Ny92i9kmVFvsvR7lAMxEQo
 jmmwMctwFFhqcjjTDVxEjfl/gEJwRx6J1LdKBWbi9Xq4OkDXYnZ8TIVnZAZIoU4VJlQW
 fL2vNM33JepGTds77d1tmFXONiOjB6ZtyvIgSAV4WWfgA01ExKCv+hBXgHPhKv3g0qbv
 T1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b6223VG41YQj2COFt5LSu8VrWTgFAalqG/2PoQbZedk=;
 b=edRPFG4C9wUJ32hpGTvexJA5zR9UdizJEdjENVlkhqI/ZJ2FA3V3D+NjPNu8Bbmcgv
 wp9wyP9j7XLbjGFTNf9bhjpwt5HXgTlVo3t2+N1hA551rSagXVArA1MwSp09BGz8XHNq
 DaOs/42ZBa5cINx0wIYQn5vXT8kuU6gMWzOneVXapppwZ5hAclPHdBTr0KNTRp+jmWHZ
 jEqGa3jN7H4ks+EHutvcxvBNrq7P6A9I5W0YFIj7DCgbA/ATbPkVsHOqqO3FCsIDAdP8
 hjekZd/NBgKagtR+AwcCN0SxyCWd12c7bR/GDbajDccLuvqyxFDLo1rdeoIXQ+Vg0rNi
 2p9A==
X-Gm-Message-State: AOAM530dMcgKay/0GLkR5B4RqI5h4ukiWA7Lo4XgtHvM5EvsGFgad9gU
 dcZ4EuN6PeMKjozKx14kDhcrpR0A5ifmABn8a3oPcONA
X-Google-Smtp-Source: ABdhPJwP9cfR/pi1aQmZYRb695aNPAhISMkL8A8KSFJG/KJubKNfpFxv7B8yHZmI2qSITz4E5lVOjKoNoTENj5riLdg=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr4212146oap.253.1653657752029; Fri, 27
 May 2022 06:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220527094620.3064524-1-kenneth.feng@amd.com>
In-Reply-To: <20220527094620.3064524-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 May 2022 09:22:21 -0400
Message-ID: <CADnq5_M0qsjxaiwr2PKVLGfmqCObx3GGPnN59hu-pA9CBOpy+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: align the cg and pg settings
To: Kenneth Feng <kenneth.feng@amd.com>
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

On Fri, May 27, 2022 at 5:46 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> align the cg and pg settings between gc_v11_0 and gc_v11_2
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 5566ddbfd188..26fda7a170da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -546,12 +546,17 @@ static int soc21_common_early_init(void *handle)
>                 adev->cg_flags =
>                         AMD_CG_SUPPORT_GFX_CGCG |
>                         AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_REPEATER_FGCG |
>                         AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_JPEG_MGCG;
> +                       AMD_CG_SUPPORT_JPEG_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS;
>                 adev->pg_flags =
>                         AMD_PG_SUPPORT_VCN |
>                         AMD_PG_SUPPORT_VCN_DPG |
> -                       AMD_PG_SUPPORT_JPEG;
> +                       AMD_PG_SUPPORT_JPEG |
> +                       AMD_PG_SUPPORT_ATHUB |
> +                       AMD_PG_SUPPORT_MMHUB;
>                 adev->external_rev_id = adev->rev_id + 0x10;
>                 break;
>         default:
> --
> 2.25.1
>
