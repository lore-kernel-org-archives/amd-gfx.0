Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501B3CCD192
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 13:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FA210E7CC;
	Wed, 15 Oct 2025 13:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aXna21vs";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91B010E7CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 13:12:50 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b5538e4343fso144876a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760533970; x=1761138770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlgxm8aEwySH9sffT1fjJI1/nvl6rGArtB+49tQqFPM=;
 b=aXna21vsbbv8Ur/CAeNfspiS+4OAVx2CHVVCnOuWX4yxHlNeSS/xLxDaX3t2fWcDyb
 bCWlb0HX0q+yPucUEU7L7cE6Wdjg3P0cPaeoP+npAKz6NARYzizzhbZVeGIflpL/epG8
 RHi+00N/5S62hfpOWm3Bd7cGGBeTczW/vAHMgojckOik7SIuqJOKv9I/e3UtqUsvOrbW
 7Y0/zQTAPUYQO4y7Z7rjrGI/A+XvEKbWydw3qoKpCsvQwzDHabv8sgzTHarhWu6h5edS
 n5VPIIlm3k+l5GLxJNy8BViQSSuOIa1s0gEOAxm3tAtIZxLA8eY9pyL8atnOLB99P70M
 tvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760533970; x=1761138770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlgxm8aEwySH9sffT1fjJI1/nvl6rGArtB+49tQqFPM=;
 b=nZK0xRPU0TJP6e5ByAMCuS6Io4AzRmPmfaWs6mDbGsWTTHVa3/1y6Po8f0K8pqj3AB
 Dp9a1gYcgjpjVseez9XMu5/DLWwFg2t+G5UmDjo0a6Mfb3hzAyDzrftbg8VQLhRYTcJK
 M2kAl8iG/A/8+6OqKEMLPaD9Jh5u6QOy7wpcsu0Ns/Kjz3GaDlvRndz9As4gkCm+1ewn
 T4686hx7zQxZIbXNDCOIRfqbwbvrJ3lk9yGypsdPso7eY6V5nvhAzEaESnS9/X+BghPK
 4tDb9NgAS9ThL4NDLWXoTopJECmVE5wFqyJXjdaTXmRSRWtqOgB3QWK0CgYYuB0fGjEX
 OjSg==
X-Gm-Message-State: AOJu0YxGnzZeSbXWFFjiB9TGgz5Qy3/WXaagEE/yFdD95CO/L7cRfb8f
 3fpAl9rYAz+HxkVFEA8b0gJUnLboTtGTYiS7m6S1a7Y89vPCQibrA9pnbuiXu92upY5dqeGkrDw
 YtPWl7C2y1xPrvf/kloa40C7kTw5fKiE=
X-Gm-Gg: ASbGncvcZi0cK1oNhiCSFsiN+4jsbYoCz09bUDakPPClAoTiTuYtify/l2/9kaubKDu
 2CC6BZANU1u3BvBv0Nt9SHFO7V0yCSWmJj1OoWNjygTjUQ5MA5fMTTDRbSzfWzcaWAYkBg0wKuT
 46OSuNC9ulAjbpklic/hetntlo8pMhdBMNk1b5pCse6uUoRD62THx+fwtwGC80T5SZX0lyClf3y
 H7u2FqWxCsYivyrRFjf2X+++Q==
X-Google-Smtp-Source: AGHT+IFa8oJbXwUI9Xg32dod8H9rO7wR3e75qwMU0Ak9jC2dD4Cnwkpu8iLChLb8+AsB3OzG/3UyrNEDRsb9tf5HaSI=
X-Received: by 2002:a17:902:d2c4:b0:273:a653:bacf with SMTP id
 d9443c01a7336-2902725d2ebmr221041095ad.0.1760533969856; Wed, 15 Oct 2025
 06:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251014201346.9422-1-yunru.pan@amd.com>
 <20251014201346.9422-4-yunru.pan@amd.com>
In-Reply-To: <20251014201346.9422-4-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 09:12:38 -0400
X-Gm-Features: AS18NWAPAzWpBXgYYURHOm-5NCSXEABM8P0sTMEN4BD3bK_p8XVYUNrp2oR2s1c
Message-ID: <CADnq5_PKQYCBaOYpe-8CJdwwHb+3SMo12Sf+jivpiiBwbyNbOg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
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

On Tue, Oct 14, 2025 at 4:21=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> - During guest driver init, asa VFs receive PF msg to
>         init dynamic critical region(v2), VFs reuse fw_vram_usage_*
>          from ttm to store critical region tables in a 5MB chunk.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 ++++++
>  3 files changed, 31 insertions(+), 19 deletions(-)
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

Do you need this check here?  Is vram_usagebyfirmware valid on V2
systems?  If that table if not present on V2 systems, then you don't
need to change anything here since amdgpu_atom_parse_data_header()
will return an error.  Other than that, looks good to me.

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
> index 96bd0185f936..b5148a33b6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1944,19 +1944,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>
>         /*
> -        *The reserved vram for driver must be pinned to the specified
> -        *place on the VRAM, so reserve it early.
> +        * The reserved VRAM for the driver must be pinned to a specific
> +        * location in VRAM, so reserve it early.
>          */
>         r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>         if (r)
>                 return r;
>
>         /*
> -        * only NAVI10 and onwards ASIC support for IP discovery.
> -        * If IP discovery enabled, a block of memory should be
> -        * reserved for IP discovey.
> +        * only NAVI10 and later ASICs support IP discovery.
> +        * If IP discovery is enabled, a block of memory should be
> +        * reserved for it.
>          */
> -       if (adev->mman.discovery_bin) {
> +       if (adev->mman.discovery_bin && !adev->virt.is_dynamic_crit_regn_=
enabled) {
>                 r =3D amdgpu_ttm_reserve_tmr(adev);
>                 if (r)
>                         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 27235f3f3b81..820dab538164 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -940,6 +940,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>         adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].si=
ze_kb =3D
>                 init_data_hdr->bad_page_size_in_kb;
>
> +       /* reserved memory starts from crit region base offset with the s=
ize of 5MB */
> +       adev->mman.fw_vram_usage_start_offset =3D adev->virt.crit_regn.of=
fset;
> +       adev->mman.fw_vram_usage_size =3D adev->virt.crit_regn.size_kb <<=
 10;
> +       dev_info(adev->dev,
> +               "critical region v%d requested to reserve memory start at=
 %08x with %d KB.\n",
> +                       init_data_hdr->version,
> +                       adev->mman.fw_vram_usage_start_offset,
> +                       adev->mman.fw_vram_usage_size >> 10);
> +
>         adev->virt.is_dynamic_crit_regn_enabled =3D true;
>
>  out:
> --
> 2.34.1
>
