Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61AECCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 13:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1C610E9D3;
	Thu, 16 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Le3DRAhh";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252B910E9D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 13:00:08 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-79e5e17f6dfso39758b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760619607; x=1761224407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGVZUH0XwJPiEZ4flG2mmiibx1LMTMu+L3yprbm4drU=;
 b=Le3DRAhh4yA+eq8aDr2GjWh/piUfXIrYVuRS9kV4RodQr7njMUq4ngwOb8QDkv1w3z
 TD5POEsSQ0R04q3ha3JmSHFXSYAP0Kt93Qt9GQ2ev5ssTENVqV3EbYavPicuLqHMYXa/
 NvWNveXeGUHrabinh5AXZLzW2BenAnAQtH8F304dLo5pgGCBO+6iGxwDQ6b3tpjAC1TI
 soSuZQZhDP12CxOf8z0nUmZrjhzhHFpMYpjZZmtw8UASyFb8zZEtoNXV62jvSebypxDD
 vIeOMsC+oI/KLQfOdqWczusy5JoC6K9dIMLG2HEFK1rqxzleW+CH1arM08v8lODGXcBi
 6HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760619607; x=1761224407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGVZUH0XwJPiEZ4flG2mmiibx1LMTMu+L3yprbm4drU=;
 b=cOWTwU91MmWRQx8DO0C8VvIBgnDDLobmSkxjO3usxQ/07tQnINfhmeJ/J4XBX+YAGZ
 LK3cbxink64+0oixtp0gwWzuMoBE4JMjETpuWqOTkl8UrQIkDG14dhYYVtE9d+HEnk15
 HOpNPaOAD1amB+DWDv06q5l1B9O94fV+ntCmGQS4iBpqPNNEjpuWo6fkMUYx7kJIp5xy
 TtC6M/dA4NcBBh0AVOZfPlJRwUP+FPQXkbPy2No3AdftHriSxs28H26+kQVc2ZH6epVP
 cnODzHPZ0VTxm2QD1KhC5GKn53p1//aIgtmet/IsKrYWr7v4p9QfQgzpHyTzqh7c8qeo
 rmAw==
X-Gm-Message-State: AOJu0Yy68OgeCMXA5csnEykgQYfVrt/9s6Acwvv+E12dgmeHREZCRlUu
 EMZ/+/Bx9zvaiilYuHmijC6mNpH8lxAwIyM4sOszUpHPFClAojDF2zNN+J45pErCy07tWYH5mCs
 I5zmhJmNL6gGP5k26u1ornP7tERc2mvc=
X-Gm-Gg: ASbGncvpkelfFrHf162+FJWcQ6W1gQpp5lusB+EGdw5Q6uns5i6OVfAFhId/L6E39BE
 1UTWsYBtgtQci7VcvHld5a2bjdM6Yz7iUiRGxJMnAVIBiUPS4Fbws6iUyp/NNvKHhmvJ/FRD+Uy
 yx3Cpw+eCz44XwbpSWqNHrWh9+kIdE4ipkJgdPRliX/26238p/wFbooxpHjunl/sGUptwMUSaBg
 xESbnS2nIhM7U9XkR8B7HWVRrOFir/S8wVKhXOENJ2Q4lh5qNsmkAwRPJJJxDRKC1uA83o=
X-Google-Smtp-Source: AGHT+IGd+fp5IdHapfb03Kd5eYWO4qzLir9ybkLGUibKXp561CZX9xDUYG+PIsDwK9zp1404GZJJoe5paz8JCBJlBqA=
X-Received: by 2002:a17:902:fb8b:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2902743ae8fmr152550965ad.6.1760619607363; Thu, 16 Oct 2025
 06:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251015214848.11580-1-yunru.pan@amd.com>
 <20251015214848.11580-3-yunru.pan@amd.com>
In-Reply-To: <20251015214848.11580-3-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 08:59:55 -0400
X-Gm-Features: AS18NWBT6dV_hFPQsnLcVGJNsy-RL_geBaMWdr4abUwCZ8IXapAmGG8HWud8UAY
Message-ID: <CADnq5_MUYRBmSgacjn9XRBmU-PhoHp5bL+fYiY3==_jMHCoMKg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
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

On Wed, Oct 15, 2025 at 5:49=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> - During guest driver init, asa VFs receive PF msg to
>         init dynamic critical region(v2), VFs reuse fw_vram_usage_*
>          from ttm to store critical region tables in a 5MB chunk.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 ++++++
>  3 files changed, 30 insertions(+), 18 deletions(-)
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
> index 7583da3d9ab0..e226c3aff7d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1939,17 +1939,17 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
>         if (adev->discovery.reserve_tmr) {
>                 r =3D amdgpu_ttm_reserve_tmr(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 805ecc69a8b5..12659990abe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -999,6 +999,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>                 goto out;
>         }
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
