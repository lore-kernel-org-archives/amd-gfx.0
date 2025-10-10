Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959CBCCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 16:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E0B10E2B1;
	Fri, 10 Oct 2025 16:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOeg+oLP";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6DE10E2B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 16:23:24 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2698d47e6e7so3842415ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760113403; x=1760718203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8YXC3dFlL0HU0PxRH8qSo2dG3/+fXnFfyjEzg6ZND0=;
 b=OOeg+oLPYni2VEz9PcoVr9TtAqicuZvK/avH8el9DRKaofgQFk4zEVUbKIIHLTtFIg
 bhhWNUWr8XbtOYBvqB4TydDBa4ACyHwXE8u9PmeT0oY1hoSAa6YX40xfMpAuBT/ze/jZ
 827NcXxtWwa+7DT0rwhBg3YhoL35PJoJKSX1mefBfafF2cbNesFEBl1WkmNdYGnbAqqH
 Q3NyghAzzAmFSk5i5+wdUquo5viCrFcNG/WIRokmRJ/ZgRvTQj1gKJenrJUY/J+M7cBo
 DeYP31JYH18J82z/jKQYa2+swtSzXo4vpfaXh3wpsyh5nm8LBCIRdAWY9YbEH2c0kgjf
 SVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760113403; x=1760718203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8YXC3dFlL0HU0PxRH8qSo2dG3/+fXnFfyjEzg6ZND0=;
 b=siXxLq8J064cnQuEddksYQOa/rteOcBUoZC5EMTiNXWf78KsgCBkuRvhDzkp9Yg6qM
 bZgmO+XPVKT4EVtyc37G6nhOft7mC9nkGtz7XlabGV3hxoDHVCVbwDA1gzlNQoggbwsF
 ssWVHTg8HJeLkfgf/8c/BbPS05l1Hxi+7kiC8VdfQyI7+dxQJtt83Wm3GMTA0acBzBLU
 pS4EGHxOuCTix4TQ3jCwomaSt1hlRFIj/H5qDWBGlwA+qFnPM8P9XZAWoAOExQFcycGk
 V5bAvXaHSaBg/i3JfXgDR8lJNbCJ3i7cnm2jfLvaUaIDvfwaDMkMaBJsaG4HZU2mkxbv
 WagQ==
X-Gm-Message-State: AOJu0Yz5HX5z/k0tppLt9OGYZdWOn2F0c5U766yE6tCflp1G4O+eFc/D
 tK+gfLwrbtrqjtSiPafNlGzG7BJZKldjNAzIAYdjcRA3fiVlXw4B6QQelIJR0NZ68Lkvv2rm2Br
 v3rxMEmEkf+UVzXMuRalOOYwtmzmhhYM=
X-Gm-Gg: ASbGncv/pDmAQUI/JigRommKS6zpzfFLVRsoEvsFC0TLQ90IacHB6A6bZFmclxpjySZ
 YHMbAag1ZPZtrXcxyR59fKwDW4csF/70LSMB1IyUh8AaRdLLoPG0F1rekZuZ98HPo/astCa2UBl
 XDQ16Xbsy7ImFefeVQA9KDHm4AQBoq1pHlDs932lXDN6O1GO5z8VEVeyLB0EhZuR0CDBabH9wt2
 Ct0P+bQ0eog7yWnuA6EdvD51A==
X-Google-Smtp-Source: AGHT+IHDkzd0S9tDDF1IfMYbc40ahTe9GA7m05+5mQfba3X6F2kSmNPr2sYuWS6c9wqczwE9+bGI+OTjc0wqLDBwLqo=
X-Received: by 2002:a17:902:ecc5:b0:24e:af92:70de with SMTP id
 d9443c01a7336-2902743ae83mr90672245ad.7.1760113403397; Fri, 10 Oct 2025
 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251010145814.3514884-1-lijo.lazar@amd.com>
 <20251010145814.3514884-2-lijo.lazar@amd.com>
In-Reply-To: <20251010145814.3514884-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 12:23:11 -0400
X-Gm-Features: AS18NWByKpuxAvhljH0wDBQeng_lCwvAOd2jHVv2O_iQi_a7SPoGoF4K1fnXleY
Message-ID: <CADnq5_N6_a+OqkpGtOms6etTxAu=Yd-bfGHD7uDdUobuBbsnZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Reserve discovery TMR only if needed
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Oct 10, 2025 at 11:06=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> For legacy SOCs, discovery binary is sideloaded. Instead of checking for
> binary blob, use a flag to determine if discovery region needs to be
> reserved.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 22 ++++++++-----------
>  3 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 02b661232db8..478cbfcc5b5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -298,10 +298,15 @@ static int amdgpu_discovery_read_binary_from_mem(st=
ruct amdgpu_device *adev,
>         else
>                 vram_size <<=3D 20;
>
> +       /*
> +        * If in VRAM, discovery TMR is marked for reservation. If it is =
in system mem,
> +        * then it is not required to be reserved.
> +        */
>         if (sz_valid) {
>                 uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;
>                 amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>                                           adev->discovery.size, false);
> +               adev->discovery.reserve_tmr =3D true;
>         } else {
>                 ret =3D amdgpu_discovery_read_binary_from_sysmem(adev, bi=
nary);
>         }
> @@ -418,8 +423,11 @@ static int amdgpu_discovery_verify_npsinfo(struct am=
dgpu_device *adev,
>
>  static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *ad=
ev)
>  {
> -       if (amdgpu_discovery =3D=3D 2)
> +       if (amdgpu_discovery =3D=3D 2) {
> +               /* Assume there is valid discovery TMR in VRAM even if bi=
nary is sideloaded */
> +               adev->discovery.reserve_tmr =3D true;
>                 return "amdgpu/ip_discovery.bin";
> +       }
>
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index b1eec3af3c4a..4ce04486cc31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -36,6 +36,7 @@ struct amdgpu_discovery_info {
>         struct ip_discovery_top *ip_top;
>         uint32_t size;
>         uint8_t *bin;
> +       bool reserve_tmr;
>  };
>
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 5bf6bb3b2faa..d0a7379255e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1767,18 +1767,14 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_d=
evice *adev)
>                 ctx->init =3D PSP_MEM_TRAIN_RESERVE_SUCCESS;
>         }
>
> -       if (!adev->gmc.is_app_apu) {
> -               ret =3D amdgpu_bo_create_kernel_at(
> -                       adev, adev->gmc.real_vram_size - reserve_size,
> -                       reserve_size, &adev->mman.fw_reserved_memory, NUL=
L);
> -               if (ret) {
> -                       dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret=
);
> -                       amdgpu_bo_free_kernel(&adev->mman.fw_reserved_mem=
ory,
> -                                             NULL, NULL);
> -                       return ret;
> -               }
> -       } else {
> -               DRM_DEBUG_DRIVER("backdoor fw loading path for PSP TMR, n=
o reservation needed\n");
> +       ret =3D amdgpu_bo_create_kernel_at(
> +               adev, adev->gmc.real_vram_size - reserve_size, reserve_si=
ze,
> +               &adev->mman.fw_reserved_memory, NULL);
> +       if (ret) {
> +               dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
> +               amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NUL=
L,
> +                                     NULL);
> +               return ret;
>         }
>
>         return 0;
> @@ -1955,7 +1951,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>          * If IP discovery enabled, a block of memory should be
>          * reserved for IP discovey.
>          */
> -       if (adev->discovery.bin) {
> +       if (adev->discovery.reserve_tmr) {
>                 r =3D amdgpu_ttm_reserve_tmr(adev);
>                 if (r)
>                         return r;
> --
> 2.49.0
>
