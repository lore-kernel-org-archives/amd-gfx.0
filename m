Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E879CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 15:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A3810EC4C;
	Fri, 10 Oct 2025 15:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iTmx4LJB";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C3F10EC4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 15:11:11 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-27eda3a38ceso3647155ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760109071; x=1760713871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfAtLB/rPk/bL2/d95XWtllo82z6rkkRzYJxDmefHjw=;
 b=iTmx4LJBS1rjMkXMBZ5/3BE8RgnD4v0bzYxuLI8h8fdnlx7Mp6QaLmltv8p1OozvG2
 ZVq2JcnUaBKVwFOfHbZDtmDe1Xk2IXsjiW21odmDP6n3BOSsYTXtiXf1RKf/lYFcMpv+
 +TIJrV+myuUsjyQqP2xF8y3qpSle9k6CejGfz79QMrbMeKUh1M59Ie/ZXUizOFsaM/IW
 hrBVcNh8GiCr3IbjyztiJ2iSLR0cZPUBMwTrLrUrOv590gYfAGnvbdCq5AtN8GkQsFl3
 BZWbV3tyJX3lQv59NzdZ25Ud/a9gearxrMDAoF7Jgh/H8kQoUAFhX9gqMJ3XHfvu32P5
 Faow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109071; x=1760713871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfAtLB/rPk/bL2/d95XWtllo82z6rkkRzYJxDmefHjw=;
 b=u43PzaKwvSENPLdfflLKxu5KtFQKFYRDGTUASHOG5cmNuxyhQJulWig6HWZrdFR9US
 GNIIpdyi55YJPHFs5oQmmbsYXKCFKhQnyjesxeeqeO+F1koYd1Pk6yNXsOghFvN81oSY
 eo45kVD49RGW9746oDDOoCl/9Y9ZedCIyFIso/reBzgFHR5Xo6LKcYZd510BvO2PMp0d
 mWlhDfiA4DxxpXkSYGlffRSjFz+obwzOOhWhJWFnHOolY7JPuNdQdtaxKIwKMfdd5azG
 VpPBoHioI+BGn5L6IBvdZXhAd35NSVh+0FGlFjXCyqoZjVUoM+41wFIZpv6fSAJq+7je
 gylQ==
X-Gm-Message-State: AOJu0YzWo8Lbf5dwb/WDJLOOQN3ckXQuYAfiyoK3XY4LbvYgrp/xwho0
 xz2fPfbBTPbHTs9ElGuZdQw4j3CRfQKPvbYiuB1HL0MzKGQ8R5XQMxg10ozLUVFA58/fjB4h9so
 BP9xKriMFnuhRG3KppP9dSuvgy3oBotg=
X-Gm-Gg: ASbGnctWsmoWy7xw0RKdBXL14EV9MwxYeY+OqvSA7xHrtu21Qb0S+7Lr3gy0bAMa8J3
 nq1V9sSckqZ3zjttX1DRiZLG7iWwg3/eO34EBPlnuud7LDZS5wrndg116bX1JMys18wR6Sz7YYC
 5gzAAy0r0WcNdL4H2jjH6ipc4Ha/lFg1s0+rJwRYN00o/593ar1PoR2iK+4idKIMGVNS5N3/H6Q
 WZziPSiRJOfbC2cJhU9ypvYxA==
X-Google-Smtp-Source: AGHT+IH4sckW6FcEXvf+hq/HYRCdCEoZwa27c+cDamha/QYuN97pUbMjA5/JHJbCBYFs1uqyKrWGPoU8AAFRLW99ePs=
X-Received: by 2002:a17:902:ea07:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-2902743e550mr90423195ad.6.1760109071115; Fri, 10 Oct 2025
 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-4-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-4-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 11:10:58 -0400
X-Gm-Features: AS18NWB1wCNpSQkPXZEhsddVhBMmotu2XgXP4rNDKh5ubRG6lhfrjl1MXvoHc9A
Message-ID: <CADnq5_O+OL8GVwaGdCjb5OD6_e3ap-Rf4W0JKuOinx-c0SBCpg@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com, Jeffrey.Chan@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 10, 2025 at 1:21=E2=80=AFAM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> - During guest driver init, asa VFs receive PF msg to
>         init dynamic critical region(v2), VFs reuse fw_vram_usage_*
>          from ttm to store critical region tables in a 5MB chunk.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 33 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 +++++
>  3 files changed, 44 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index c7d32fb216e4..636385c80f64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -181,19 +181,22 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct =
amdgpu_device *adev)
>         u8 frev, crev;
>         int usage_bytes =3D 0;
>
> -       if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev,=
 &data_offset)) {
> -               if (frev =3D=3D 2 && crev =3D=3D 1) {
> -                       fw_usage_v2_1 =3D
> -                               (struct vram_usagebyfirmware_v2_1 *)(ctx-=
>bios + data_offset);
> -                       amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> -                                       fw_usage_v2_1,
> -                                       &usage_bytes);
> -               } else if (frev >=3D 2 && crev >=3D 2) {
> -                       fw_usage_v2_2 =3D
> -                               (struct vram_usagebyfirmware_v2_2 *)(ctx-=
>bios + data_offset);
> -                       amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> -                                       fw_usage_v2_2,
> -                                       &usage_bytes);
> +       /* Skip atomfirmware allocation for SRIOV VFs when dynamic crit r=
egn is enabled */
> +       if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_en=
abled)) {
> +               if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev=
, &crev, &data_offset)) {

Do these tables actually exist on a V2 setup?  If not or if the
version numbers are invalid, the current code should handle this
already and there is no need for an extra check here.

Alex

> +                       if (frev =3D=3D 2 && crev =3D=3D 1) {
> +                               fw_usage_v2_1 =3D
> +                                       (struct vram_usagebyfirmware_v2_1=
 *)(ctx->bios + data_offset);
> +                               amdgpu_atomfirmware_allocate_fb_v2_1(adev=
,
> +                                               fw_usage_v2_1,
> +                                               &usage_bytes);
> +                       } else if (frev >=3D 2 && crev >=3D 2) {
> +                               fw_usage_v2_2 =3D
> +                                       (struct vram_usagebyfirmware_v2_2=
 *)(ctx->bios + data_offset);
> +                               amdgpu_atomfirmware_allocate_fb_v2_2(adev=
,
> +                                               fw_usage_v2_2,
> +                                               &usage_bytes);
> +                       }
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 96bd0185f936..c0810c53703c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1943,23 +1943,28 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       /*
> -        *The reserved vram for driver must be pinned to the specified
> -        *place on the VRAM, so reserve it early.
> -        */
> -       r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
> -       if (r)
> -               return r;
> -
> -       /*
> -        * only NAVI10 and onwards ASIC support for IP discovery.
> -        * If IP discovery enabled, a block of memory should be
> -        * reserved for IP discovey.
> +       /* For VFs with dynamic critical regions (v2), fw_reserve_vram is=
 already
> +        * reserved, so no additional memory reservation is required belo=
w.
>          */
> -       if (adev->mman.discovery_bin) {
> -               r =3D amdgpu_ttm_reserve_tmr(adev);
> +       if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver !=3D =
GPU_CRIT_REGION_V2)) {
> +               /*
> +                * The reserved VRAM for the driver must be pinned to a s=
pecific
> +                * location in VRAM, so reserve it early.
> +                */
> +               r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>                 if (r)
>                         return r;
> +
> +               /*
> +                * only NAVI10 and later ASICs support IP discovery.
> +                * If IP discovery is enabled, a block of memory should b=
e
> +                * reserved for it.
> +                */
> +               if (adev->mman.discovery_bin) {
> +                       r =3D amdgpu_ttm_reserve_tmr(adev);
> +                       if (r)
> +                               return r;
> +               }
>         }
>
>         /* allocate memory as required for VGA
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 6eca5e8a7375..461e83728594 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -940,6 +940,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>                 adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABL=
E_ID].size_kb =3D
>                         init_data_hdr->bad_page_size_in_kb;
>
> +               /* reserved memory starts from crit region base offset wi=
th the size of 5MB */
> +               adev->mman.fw_vram_usage_start_offset =3D adev->virt.crit=
_regn.offset;
> +               adev->mman.fw_vram_usage_size =3D adev->virt.crit_regn.si=
ze_kb << 10;
> +               dev_info(adev->dev,
> +                       "critical region v%d requested to reserve memory =
start at %08x with %d KB.\n",
> +                         init_data_hdr->version,
> +                         adev->mman.fw_vram_usage_start_offset,
> +                         adev->mman.fw_vram_usage_size >> 10);
> +
>                 adev->virt.is_dynamic_crit_regn_enabled =3D true;
>                 break;
>         default:
> --
> 2.34.1
>
