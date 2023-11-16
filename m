Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BD1C54FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 15:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BFE10E60C;
	Thu, 16 Nov 2023 15:00:32 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0058A10E60C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 15:00:29 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1e9c42fc0c9so379912fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700146829; x=1700751629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bb4aUt91aRUTVuyQjEsDRuN7N4nFq8RYe6G27zGol3M=;
 b=YzrJ3xg3W5NGHv11Kea2OONwzlkvBUWFj7s7fpz6jmLJLXufBvS1LQNdlm3Ef5DDRD
 hlxx2srZwKXHJ4swUL165mM1esluWNytbtvl0hNwnl4CcJ5w70ZgldIkfRk1kjWa9hks
 ia0uCNPiTeZ92vjG/0V3DR8rLmgd7ULsx6n/xVCpoHZxSAhd5AJVN5MACwG6rMhwaGDr
 wKAvSDHhhz9MgJsOn0eIlW9NRXm6ic2fTkSqqXSLgCqaxZk+RiMmqvTJLEZFzZSVaC4j
 o90OgvSMem8yadLmOJiEwtqj6V29o9Vlq18loCB3YcuJDo1QLQg5bAV0gengYtT6w2G2
 7jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700146829; x=1700751629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bb4aUt91aRUTVuyQjEsDRuN7N4nFq8RYe6G27zGol3M=;
 b=q3vag21MHl7P4iYXU5Z355DsxjsSqGaDbzXeaRjt2IXsPVzO8VyqT9c58HKPXkA0rv
 4MmUXadEa40VY90YRWLJz9qBujI19UN7Rg6DEytFsjIrODL9xr1OQ1E91xBhrkjkG6VG
 mLS4H1MuTcrSwQTl8NtBg9GOWLStC2O5VCUDUh/J9udYf1qkln05AlIXQT9AxfmR8yLJ
 Hv+ONAj0RXJZkB7NjjHpP+nnmlkOjWHagt7EVfu66hrMJYq2NaalVXa/p+iKssT6reWP
 p3F7MfSBRSVd23agem4rJYDhABkPGdLkIFQWgFkmIP2irIhuC6dJuEXyjVBsAt7483y1
 z5xQ==
X-Gm-Message-State: AOJu0YyNhy87catGNwcEeCH1f7IqTHzHgZOluoZSIpNL9AKRwq/Hglqi
 PnbKqOk2ot4dOJzOItlMZX6njTfh/YLDzL3RNaTbiYnaXmw=
X-Google-Smtp-Source: AGHT+IEs41re5WoNFmtQ1D+eE6S+YNCUmjCbM8fRmFrgGN5JB1rHe/kXHHW9rsBoJsSyS0ZB+rNVV+Et9AmBMdYpgXk=
X-Received: by 2002:a05:6870:c102:b0:1f5:5da4:9355 with SMTP id
 f2-20020a056870c10200b001f55da49355mr5422713oad.57.1700146828827; Thu, 16 Nov
 2023 07:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20231115214029.960838-1-ivlipski@amd.com>
In-Reply-To: <20231115214029.960838-1-ivlipski@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 10:00:17 -0500
Message-ID: <CADnq5_MU3qcH_wMxkL257+cWmWB25qgXGuH8jX7GgWUXRa2m-g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: fix AGP init order"
To: ivlipski@amd.com
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
Cc: kenny.ho@amd.com, rodrigo.siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, nicholas.choi@amd.com, hamza.mahfooz@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will break other things.  The proper fix is either:
https://patchwork.freedesktop.org/patch/567101/
and/or:
https://patchwork.freedesktop.org/series/126220/

Alex

On Thu, Nov 16, 2023 at 7:27=E2=80=AFAM <ivlipski@amd.com> wrote:
>
> From: Ivan Lipski <ivlipski@amd.com>
>
> This commit caused a page fault issue on RX7000 series GPU.
> It would occur when running different IGT tests, including
> kms_properties*
> kms_cursor_legacy*
> kms_prop_blob@blob*
>
> It would also occur on desttop after some time of idling.
>
> The easiest fix for it seems to revert it.
>
> This reverts commit b93ed51c32caad2b96cbc8e4754802078ede87ab.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 --
>  7 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index cef920a93924..0dcb6c36b02c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1062,6 +1062,9 @@ static const char * const amdgpu_vram_names[] =3D {
>   */
>  int amdgpu_bo_init(struct amdgpu_device *adev)
>  {
> +       /* set the default AGP aperture state */
> +       amdgpu_gmc_set_agp_default(adev, &adev->gmc);
> +
>         /* On A+A platform, VRAM can be mapped as WB */
>         if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
>                 /* reserve PAT memory space to WC for VRAM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 0ec7b061d7c2..a43d1aa42e11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -672,7 +672,6 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu=
_device *adev,
>         /* add the xgmi offset of the physical node */
>         base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_s=
egment_size;
>
> -       amdgpu_gmc_set_agp_default(adev, mc);
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>         amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>         if (!amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index ba4c82f5e617..ee7f3f8c1b4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -637,7 +637,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu=
_device *adev,
>
>         base =3D adev->mmhub.funcs->get_fb_location(adev);
>
> -       amdgpu_gmc_set_agp_default(adev, mc);
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>         amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
>         if (!amdgpu_sriov_vf(adev) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index 42e103d7077d..7f66954fd302 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -211,7 +211,6 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_=
device *adev,
>
>         base <<=3D 24;
>
> -       amdgpu_gmc_set_agp_default(adev, mc);
>         amdgpu_gmc_vram_location(adev, mc, base);
>         amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index efc16e580f1e..61ca1a82b651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -239,7 +239,6 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_=
device *adev,
>
>         base <<=3D 24;
>
> -       amdgpu_gmc_set_agp_default(adev, mc);
>         amdgpu_gmc_vram_location(adev, mc, base);
>         amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index ff4ae73d27ec..fa59749c2aef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -413,7 +413,6 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_=
device *adev,
>                 base =3D RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
>         base <<=3D 24;
>
> -       amdgpu_gmc_set_agp_default(adev, mc);
>         amdgpu_gmc_vram_location(adev, mc, base);
>         amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index c1f2f166f064..83733156ee53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1621,8 +1621,6 @@ static void gmc_v9_0_vram_gtt_location(struct amdgp=
u_device *adev,
>  {
>         u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
>
> -       amdgpu_gmc_set_agp_default(adev, mc);
> -
>         /* add the xgmi offset of the physical node */
>         base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_s=
egment_size;
>         if (adev->gmc.xgmi.connected_to_cpu) {
> --
> 2.34.1
>
