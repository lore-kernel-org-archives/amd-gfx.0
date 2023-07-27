Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B47FC0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 13:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C4588FBD;
	Thu, 27 Jul 2023 13:05:20 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0746788FBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 13:05:18 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a5ad4477a7so781050b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690463117; x=1691067917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=302L3tKva5fyhYvE5RjrUWClyuxctQWR+BgkZ4eHlRQ=;
 b=d6bN8v81tTe0bE9HguR8dlAVrnkw1QWErEfQBONHRkIhRVRKviTrw4c9/C79ABoOf7
 ZnU4BcM6wHrAxI1mRL/N/pZwAj7nVQtAFeSzC6l9gX3damXKGp4M9J58Vmby6/aJROuf
 ykIZqw8sS53lXpiOKj8QrYriGeOgVnqbFkWQi625RCEERBijXxcupvnEzFhH1MGvd5bO
 TdpwXnUpgSYJQpCiTyBT/W0xfjEeR8VT5/LsW1hakFECARFQblOj/apv7l+NlpxOUVQs
 YBxrc34fq8l3SWKhK4zz7mfxxNQqZ/eFJd7zFbiXb4F1vMnv+B10nkR3x4X2b7XUOjnD
 HRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690463117; x=1691067917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=302L3tKva5fyhYvE5RjrUWClyuxctQWR+BgkZ4eHlRQ=;
 b=Xsw7FF+hy9ArTiRtE1JOEIAya+GGTssTuH+VpgXt9rZzi/ijb9Vbm4BFe/Q4qg7IL9
 SDPMc64FN96Q2N0jfmJyPMlVubuiJ9GLQjTyxdNzy2ErUGmaNY8HaIFg+Piz82SlS9Mw
 Fp6EEYyZiBZSXc4MIf4mmHbbKUNyi/DNEbVcsVN2P5IHnv7a4T8JEn3gHaO7PYbrFyj9
 i/Hnb7cVDZ43cgArGTphaFWo7gRQZ/BRHExaBfmWVYGhpSKKHm6ZSzaZklGeWY0B6oAC
 MnR79ySfiikLsnZcL0XhpvDIxUWibcfRG1uS9GetJfW5BcUeZfZUWJJwuf9ZcS2C6BQt
 edyQ==
X-Gm-Message-State: ABy/qLZe/Ye+xgDhUa1wvi0peYTKuAJS5xFsQdfBVeP6uDA+dlI6ea3f
 O/m/hZ5NfmbmB4+vougAsrsiW3JZKcZ/J0Zc0Cg=
X-Google-Smtp-Source: APBJJlEWXiXXiyOTbmmU/iv8OHoF1PTqgLDNrq8dWM+AeV+hYjdf5z8duFz+bYPWEtRnjUsoV0mJ9A1CqKRBHW94I9E=
X-Received: by 2002:a05:6808:48:b0:3a1:c75d:b6ab with SMTP id
 v8-20020a056808004800b003a1c75db6abmr2757623oic.40.1690463117096; Thu, 27 Jul
 2023 06:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230727094922.1958587-1-Prike.Liang@amd.com>
In-Reply-To: <20230727094922.1958587-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jul 2023 09:05:05 -0400
Message-ID: <CADnq5_MEP-85KPMyVQ2e+fZ8a3g5KS4W0tnJoox5P-RYQ7Kg3Q@mail.gmail.com>
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
Cc: Alexander.Deucher@amd.com, shikaguo@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 27, 2023 at 5:49=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Now the SDMA firmware support SDMA MGCG properly,
> so let's enable it from the driver side.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c        |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 27 +++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 877989278290..e768ea34a2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -902,7 +902,8 @@ static int nv_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_ATHUB_LS |
>                         AMD_CG_SUPPORT_IH_CG |
>                         AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_JPEG_MGCG;
> +                       AMD_CG_SUPPORT_JPEG_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG;
>                 adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
>                         AMD_PG_SUPPORT_VCN |
>                         AMD_PG_SUPPORT_VCN_DPG |
> @@ -963,7 +964,8 @@ static int nv_common_early_init(void *handle)
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
> index 809eca54fc61..9779e146d37e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1571,6 +1571,30 @@ static int sdma_v5_2_process_illegal_inst_irq(stru=
ct amdgpu_device *adev,
>         return 0;
>  }
>
> +static bool sdma_v5_2_firmware_mgcg_support(struct amdgpu_device *adev,
> +                                                    int i)
> +{
> +       switch (adev->ip_versions[SDMA0_HWIP][0]) {
> +       case IP_VERSION(5, 2, 1):
> +               if (adev->sdma.instance[i].fw_version < 70)
> +                       return false;
> +               break;
> +       case IP_VERSION(5, 2, 3):
> +               if (adev->sdma.instance[i].fw_version < 47)
> +                       return false;
> +               break;
> +       case IP_VERSION(5, 2, 7):
> +               if (adev->sdma.instance[i].fw_version < 9)
> +                       return false;
> +               break;
> +       default:
> +               return true;
> +       }
> +
> +       return true;
> +
> +}
> +
>  static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_dev=
ice *adev,
>                                                        bool enable)
>  {
> @@ -1579,7 +1603,7 @@ static void sdma_v5_2_update_medium_grain_clock_gat=
ing(struct amdgpu_device *ade
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>
> -               if (adev->sdma.instance[i].fw_version < 70 && adev->ip_ve=
rsions[SDMA0_HWIP][0] =3D=3D IP_VERSION(5, 2, 1))
> +               if (!sdma_v5_2_firmware_mgcg_support(adev, i))
>                         adev->cg_flags &=3D ~AMD_CG_SUPPORT_SDMA_MGCG;
>
>                 if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)=
) {
> @@ -1653,6 +1677,7 @@ static int sdma_v5_2_set_clockgating_state(void *ha=
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
