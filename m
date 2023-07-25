Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE5C001DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D91710E13D;
	Tue, 25 Jul 2023 13:16:02 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673D010E13D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 13:15:59 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a425ef874dso3859450b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690290958; x=1690895758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYtYXO3YGC/lSWSx/QkJF1wFgyrMuWGsoLogarf8GnM=;
 b=XENbLvBQQK9132ZZCBhW/bu14vMCmq8C2V7fRN04Lu5U5kinXbvUxnXu7mVSkbZRPB
 ouO5jltlKNw/Swqhv3Hz00LhGy7UisMEIGkTFlkb5/7xlzVQB+lVPOXBIXeftJecnm2/
 WVwMm6ZjNBkkBlJIWpK6sXRLWqsaA+jOvJnPzqA+VBGqi0fgFwFJUgoX9QvsbUdHEkby
 RlhZZ2MQO7XNtFogKfO6gx6+FiE3kmvK8mCTDU+BwSpkseAR9h66SpP3GnIeSvUkSTLg
 I6vCaeXqyUfu4SWqeB3F3WNRqkAODk00WOnaZqhj7Hq0tetszNMrKULAIYUreikieY6t
 eySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690290958; x=1690895758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYtYXO3YGC/lSWSx/QkJF1wFgyrMuWGsoLogarf8GnM=;
 b=NHdtcYue/Dg+0CBPnnn0k4SgtyAWYa1zhap62nrPUDOrM5R9KJ37bbdZE+ZzKOEjie
 2LIxn1dYMsD+Q8F71Jf9QIRbtJUEIXyPCxDH3AEoqRbanoGKI3+3YWufNaAInKAIjdfp
 q7fR3Sp3BHJ17b5u+lsWvIK2tu4JQp+z8uCNPjHmLbQ+/j8h4NVHaLdUoOUb4wRIRmcw
 o92Urh72+mQTT/d19x6C0cvYokfoXwO438GvF2kY3qwtWD92mHrH1J5mn67SydXNp50R
 2tso15SwVOPVKLsIYGDkHc/oMhXTfJh0R9zOHiq+RISsD61aVL571QU4s7vPwrOh5OmM
 h+jw==
X-Gm-Message-State: ABy/qLYYloMDhgLGXBfUXHhBtm1/x96JCGHQLwthOXsheafOfL+72o8D
 H4E7iLD0MMopiBq+sAeQy6AcIrJe2Bg2fTTky0FoD4qZ
X-Google-Smtp-Source: APBJJlHWkqBsywbBaXV4/IHCRcCctITSB77+iAoO5FxYszXFGtr9Kfc+IfkotM3hry5ePv7OCxUWU1u3hrABwnQRglg=
X-Received: by 2002:a05:6808:2119:b0:3a4:298f:b2e0 with SMTP id
 r25-20020a056808211900b003a4298fb2e0mr16330265oiw.26.1690290958622; Tue, 25
 Jul 2023 06:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230725092020.3777355-1-Prike.Liang@amd.com>
In-Reply-To: <20230725092020.3777355-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jul 2023 09:15:47 -0400
Message-ID: <CADnq5_Pj9XqiggwpD2uA_rP0sEbV6JMYCh1hOWjG1L6MACdGzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
To: Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 25, 2023 at 5:20=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Now the SDMA firmware support SDMA MGCG properly,
> so let's enable it from the driver side.

If this is only supported on certain firmware versions, do we need a
version check?

Alex


>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c        | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 6853b93ac82e..9bf7872e260d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -901,7 +901,8 @@ static int nv_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_ATHUB_LS |
>                         AMD_CG_SUPPORT_IH_CG |
>                         AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_JPEG_MGCG;
> +                       AMD_CG_SUPPORT_JPEG_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG;
>                 adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
>                         AMD_PG_SUPPORT_VCN |
>                         AMD_PG_SUPPORT_VCN_DPG |
> @@ -962,7 +963,8 @@ static int nv_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_ATHUB_LS |
>                         AMD_CG_SUPPORT_IH_CG |
>                         AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_JPEG_MGCG;
> +                       AMD_CG_SUPPORT_JPEG_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG;
>                 adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
>                         AMD_PG_SUPPORT_VCN_DPG |
>                         AMD_PG_SUPPORT_JPEG |
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 809eca54fc61..f8b6a2637d1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1653,6 +1653,7 @@ static int sdma_v5_2_set_clockgating_state(void *ha=
ndle,
>         case IP_VERSION(5, 2, 5):
>         case IP_VERSION(5, 2, 6):
>         case IP_VERSION(5, 2, 3):
> +       case IP_VERSION(5, 2, 7):
>                 sdma_v5_2_update_medium_grain_clock_gating(adev,
>                                 state =3D=3D AMD_CG_STATE_GATE);
>                 sdma_v5_2_update_medium_grain_light_sleep(adev,
> --
> 2.34.1
>
