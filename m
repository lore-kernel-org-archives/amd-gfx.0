Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEC9CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 17:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8E410E106;
	Fri, 10 Oct 2025 17:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IeWQeePP";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E704910E106
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 17:29:52 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-27ec3db6131so4309275ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760117392; x=1760722192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk0zCOfVJjQDAjMpFNGgImDJvf8ygKhec/ghGB2PD+E=;
 b=IeWQeePPQpNnLvAexj/kDEBl1oD7jIVDHda8344/KmbJrfq/XdRDcCnlcoII7DLz25
 Dgu21mWLYo50LZ1uAITBPAlwLaAJ9+wB4hfP+ymYUJAP9b9PNVPYD6lvdFtqLwyK+Xpg
 Ie2qpO1FEyz5uQMNBNBpP4uy04lxNkw1+dQuPy21+GdV7LlWHrpiIrTwq9RQ3UrgBUnk
 5aCDXiv1H2yyeJ62SYyvTDbdcUFBs/oSIO/pD2Ce3DXe7Dq26ZbR7BOwXIRR5JzAML18
 cXG9Ywp3iSy6D2np9P7dWWc8kTldlnKXcdiRb30EE9qliuVN2WkZtnps94RtTvL1x0Ex
 gVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760117392; x=1760722192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hk0zCOfVJjQDAjMpFNGgImDJvf8ygKhec/ghGB2PD+E=;
 b=epDmv3VHds3uasAYxHlWSsyiBnYcLuE+MecTj3eHmaXZ+yqkKkYctyH8qrP/eM/Rpf
 hXaiH/Ga26qrOHkAgpdG0sc6MV0yWu9HS0COxkVISobaCLajDfJ5U+/MPI6JHtJ9EE92
 dHLyJvo9P9bLgErwU2P7fTWzP7LNcDx/VDQmmlnWj0ftTR9FeR7Q0HrVokvxRZfC7KCw
 Bj+6YpPhOenPe0nwTq/bDP1xzeS3IPRVue3I3WGPStaLrRIYVqwHL5u8bTowTFNue6L7
 shoPWeVo7bKfeaZqUxgFJFFTAiU8zFbNKjmQTFwPZZMWKSX4lKeIfMr4uCrCSGsfCIQJ
 F/Fg==
X-Gm-Message-State: AOJu0Yyp9B1WgLvslcXqE3NCDFoHxqp05M+SWG2fMPSNEKEzzJMJEU0U
 v+7q9dKj70nBRDA/j6c6K2xDCQXIXdnRaPCntBb9fYo01jpoHG+Kmtc6et3yMQWobCuv97pVjws
 ZlZUfXHOuHwBGQAIiwOombis+ksVi5hk=
X-Gm-Gg: ASbGncsvazEJ2bAOmKoqh1jKrPv+nte92vZoJs5fFyihhYWzyW6bATMDuzCkr6ULFYp
 mExWf4fo12C3Fwv7OSNiAXuAuooOnh+0kK/Y9o3jLFpsYHkDGCHEzoefsvGaptwu31YpLK1l6ca
 tnbmHei2Ws/ZgBAI4pf6GbUKYDgg/vBIVfb8hVgkR/XzV/eorbW6SYqsI2rmtw6kYQRGA6Xe5Bs
 OwouW3r8bJzMxyJIi4im2xvbQ==
X-Google-Smtp-Source: AGHT+IGwdrJbzMgYscafNr2o/m+lsiwaVN9nR+kBQ9kOnEaNHDTPJU8X222i6rh4hYdZusOcto6gtL6TnL77PVmgBy4=
X-Received: by 2002:a17:903:18b:b0:27d:6f24:ceb9 with SMTP id
 d9443c01a7336-290273e17b2mr87933235ad.3.1760117392353; Fri, 10 Oct 2025
 10:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251010170257.3516496-1-lijo.lazar@amd.com>
 <20251010170257.3516496-2-lijo.lazar@amd.com>
In-Reply-To: <20251010170257.3516496-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 13:29:40 -0400
X-Gm-Features: AS18NWD5T-m37yNSKLNqaTKBK3U3oAolJltTla_V8uAefFKLCcykZOXs1nV9IOM
Message-ID: <CADnq5_MD06kvOWrsTsWtQxhBYqOT+ak+UjxmADf1dR4fyPxBgg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Reserve discovery TMR only if needed
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Oct 10, 2025 at 1:11=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> For legacy SOCs, discovery binary is sideloaded. Instead of checking for
> binary blob, use a flag to determine if discovery region needs to be
> reserved.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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
