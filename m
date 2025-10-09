Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A20CCD185
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1B610EA2E;
	Thu,  9 Oct 2025 12:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I2Nkz2Bb";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F19210EA2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 12:52:28 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2699ef1b4e3so1413365ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760014347; x=1760619147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5BEOLvlpOfJhDc2Lt1Jld+zRE1vBLBVpw7uOvdBKvk=;
 b=I2Nkz2Bbeeh6ZvLDxs8iChMHjuga/Aj45y00T+j7ssuuTTD0/04bfiKPFEA2NCXswm
 PraEBZnmNJiOV5eBmnqhrFbXYgc+HKYXhvFYTewoV/kZJdqgCTkzWkOFgVXl0p09MGnL
 Ikl8pnJjKk4DaO9Z2J1gHapA/UckFog6mw3n6pNkwHSNNWwY9a3KVB6FtOAlCb1bWzhb
 RDbMqf84mCP/GgAK0inaFGXXx9aLV+q9ekJE+4vTIwAhyzTZUBysrSO8GA3B5mlkmvzO
 AZMCz6QNck/QnZZg8twn1aL17j6eyF5RtHYZwMloTRRo+12h7A64M0tJuaLhGZMELUq4
 VP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760014347; x=1760619147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z5BEOLvlpOfJhDc2Lt1Jld+zRE1vBLBVpw7uOvdBKvk=;
 b=X1u1wkpXcfRx+jGl3501Tu0HLNAzSTH+YbuFMFoT3UAYULv3i/P75xv1LWKj0sR6Rm
 9B/ui6Sb+0c3AMMpgFqUtv95ACI2RQKMLNLgBBKRka57AdRl5Qpa/ZMgHL+rBsUoc+Sn
 90pDPohX3LXSDvWhW3JqYhGVQILniCLcyU3hcQ+xRkjwNzEhHHURG4YzdccAM9VZNxER
 BQjK/HbnOF/zkx+gqB84kqj5QXZSg55SjBG6lo5wVkdNrf9jlNbuMQFItEMB42/zxrHp
 0LFRY0guNIiKxax/QBTgx6ZMaoSL6jheSRycatjfyIuMBlxdvJGcl1Z2Ph3LmIr8Y++v
 XM0w==
X-Gm-Message-State: AOJu0Ywu2VDDCQUjCAxw+V3Fz7E5fs5h7TGLJpSLm4X6gnTB/rXGnq1i
 yRGBdkunvHSNYkypOyAFpWfvtn7vYRk+kpq/yJon3ubhDPpWdDTovUgQeeehIQnLc/pV6HtVRfU
 f26Bjvgg4jw+r1vscvAOiofnGDppqDQ8=
X-Gm-Gg: ASbGnctuy7sc0I5KSPvKlyYjdjxgy6KFe0qFYGU7wGoWro3tszUX2eNWjJUDegj0OAN
 K/qErZ1ZhPskusYb3z9f6LUmPVM0SnQTDYanhfI0lYg95i/YXPZSrqSB8jaSaEXYzKq9L0/7ic7
 9W0wXTTPqJeJ3Gp8COjDgYxgJa1awq16h8MMrjHMsRtMcsOAvRQ++x/vGxs5kQd8WHT89vaspjx
 zXD6jrPgmpStxNlSdaqSWK9oaIIWBpETbraXyXGlw==
X-Google-Smtp-Source: AGHT+IHuWxkOrtMlj+WCMWLhDfuLiG8tgkakwimVIr1WqrwKb2cY0F7hc5trcEhUDQD9eVl73rttmFyQvrXDEahYKaw=
X-Received: by 2002:a17:902:c40b:b0:267:b312:9cd8 with SMTP id
 d9443c01a7336-290273038efmr46907085ad.8.1760014347504; Thu, 09 Oct 2025
 05:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251009033047.25004-1-yunru.pan@amd.com>
In-Reply-To: <20251009033047.25004-1-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 08:52:16 -0400
X-Gm-Features: AS18NWBclIZ8C9lt1ez-qpKOr2kjwOSux_icVQiLMcT5Ayc1HohD1kFzq5IfQaw
Message-ID: <CADnq5_PmGaNfZKTOT0okjtOPz4KA_YWxu0YFoez-q3AzgNkFBQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Shravankumar.Gande@amd.com
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

On Wed, Oct 8, 2025 at 11:46=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> - During guest driver init, asa VFs receive PF msg to
>         init dynamic critical region(v2), VFs reuse fw_vram_usage_*
>          from ttm to store critical region tables in a 5MB chunk.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 33 +++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  8 ++++++
>  2 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 96bd0185f936..4ba34ba74671 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1943,23 +1943,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
> -        */
> -       if (adev->mman.discovery_bin) {
> -               r =3D amdgpu_ttm_reserve_tmr(adev);
> +       /* VFs using dynamic critical regions(v2) won't need to reserve f=
or below memory */
> +       if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver !=3D =
GPU_CRIT_REGION_V2)) {
> +               /*
> +                *The reserved vram for driver must be pinned to the spec=
ified
> +                *place on the VRAM, so reserve it early.
> +                */
> +               r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>                 if (r)
>                         return r;
> +
> +               /*
> +                * only NAVI10 and onwards ASIC support for IP discovery.
> +                * If IP discovery enabled, a block of memory should be
> +                * reserved for IP discovey.
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
> index 46c19e96086a..e9dbab53cb06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -931,6 +931,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>                 adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_IN=
FO_TABLE_ID] =3D
>                         init_data_hdr->bad_page_size_in_kb;
>
> +               /* reserved memory starts from crit region base offset wi=
th the size of 5MB */
> +               adev->mman.fw_vram_usage_start_offset =3D adev->virt.crit=
_region_base_offset;
> +               adev->mman.fw_vram_usage_size =3D adev->virt.crit_region_=
size_in_kb << 10;
> +               DRM_INFO("critical region v%d requested to reserve memory=
 start at %08x with %d KB.\n",

Please use dev_info() here so we have proper multi-gpu support.

Alex

> +                         init_data_hdr->version,
> +                         adev->mman.fw_vram_usage_start_offset,
> +                         adev->mman.fw_vram_usage_size >> 10);
> +
>                 adev->virt.init_data_done =3D true;
>                 break;
>         default:
> --
> 2.34.1
>
