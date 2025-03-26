Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810C5C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 12:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CFE10E6B5;
	Wed, 26 Mar 2025 12:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l9w1XsU5";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BC110E6BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 12:46:20 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so2037810a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742993180; x=1743597980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VdFc8ryR6FVpfhJBxFUlAwBIzKAwizSBmqNBIo1Vvk=;
 b=l9w1XsU5maIdyY80wP736ZxkHa1FjLwZ3R1PKWqINRL/Y/DfR0+DXaktcRCrTOO5bp
 1bp389KOBtsLFrF5VYcFd9jxENdxu5YUSf6RtxW5azgd8Z4CO+5ZqkoSxeCqppblyCLZ
 cMC2nwsiUuMPlYhMHqvSK6YMoXpCEOAKOoUd33ZDm3388ddqrgTIajldkL9MtAPfTsn9
 0D107Cvk68oRmF4Pu27xN3EOHTJDXpcqkZSjzupCyAgKfnXwM1pj+EIDaR4ACvnzKyxC
 YqDqmDPgxNcYVJqpvdONy5KZwsEtycLH0LI3/l5A1FwXc2OCUNBB3PXrWPzcmlYPF1wb
 XTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742993180; x=1743597980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VdFc8ryR6FVpfhJBxFUlAwBIzKAwizSBmqNBIo1Vvk=;
 b=vLB3A6+hTA4fYRkQkiwtqC9gkyskjc9woM5y+X7B72+QF8+QlhjqhCrTHYAj8WzwzB
 8W7PFFvAerW+RDVu0r1/YNJHiWmPOOBLYGX76HMd60f/2kQ10NJqMbDp3DXoTZeb2Tfo
 GUcnPwu+hWNKth0PUZoE+oYoHTC3gvGcStLrX1XSJtaK2qbYAZk4nBqzfjIOAitioSRN
 7EYUvGn6IvL+Hf1VAT/o4CT2xxnqR7T3fKh7AULaZDjr1BhEErXc+2IT2th4aYuJaUdC
 FrggRfyqMHLiJSqbJdxGmagtCZb+T4T7Z+h0Ump4TRITe1RtE9b0F6xKa+r4sGremBlU
 y2pg==
X-Gm-Message-State: AOJu0YydJwlCw6r70YDZIv1ghOKfklMYuF1SgLKODlR0W2fFiG75NcSt
 FJd88/4MfxNyEAeGtyIl5YuEYIC6AYPLzalErOCRaQRayuVQiWelD4H+t9Yn5GB98JdISSfDbVI
 PggXB5ppGFzyeYpfUXYMH1k9QB1P2GfFb
X-Gm-Gg: ASbGnctaqkbgflz/T3oQWEsBVaBJoQBO3ngh1P89FkfIo4OHHGhwoj40zA6QkjkMDVQ
 tJZi0mhgzDgmcb907Rc61RYqhcVpuInfhhvkTQTMldL+mGr8dc4Qw2VZVppB58t+QFzfhjPlVuD
 qvH0IwLrWgBifPDgYlRfKEKrWi7Q==
X-Google-Smtp-Source: AGHT+IHkq9FVSykxrLg05IBwoh0SevR8rMJaDZAJT28YQVOah8opRR8v84n1SaSlpAKwuErp6ODf8Cz1tAqgf2JJmPY=
X-Received: by 2002:a17:90b:1e4b:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-3030fedf3c8mr12136123a91.4.1742993179775; Wed, 26 Mar 2025
 05:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250326034400.403935-1-lijo.lazar@amd.com>
In-Reply-To: <20250326034400.403935-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 08:46:07 -0400
X-Gm-Features: AQ5f1JpqCvjKq_Elqwws1YzI1jl5QI3STqBk2Cw5FTSIqAQE2pN35VdqW95-J0U
Message-ID: <CADnq5_NCQ-wB6Lb+56DOzrueoFSF3mW_jfUdedxaZ6uy292umg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Prefer shadow rom when available
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

On Tue, Mar 25, 2025 at 11:53=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Fetch VBIOS from shadow ROM when available before trying other methods
> like EFI method.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: 9c081c11c621 ("drm/amdgpu: Reorder to read EFI exported ROM first"=
)
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4066

Fixes: 9c081c11c621 ("drm/amdgpu: Reorder to read EFI exported ROM first")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 34 +++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 75fcc521c171..00e96419fcda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -447,6 +447,13 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device=
 *adev)
>         return true;
>  }
>
> +static bool amdgpu_prefer_rom_resource(struct amdgpu_device *adev)
> +{
> +       struct resource *res =3D &adev->pdev->resource[PCI_ROM_RESOURCE];
> +
> +       return (res->flags & IORESOURCE_ROM_SHADOW);
> +}
> +
>  static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
>  {
>         if (amdgpu_atrm_get_bios(adev)) {
> @@ -465,14 +472,27 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_devi=
ce *adev)
>                 goto success;
>         }
>
> -       if (amdgpu_read_platform_bios(adev)) {
> -               dev_info(adev->dev, "Fetched VBIOS from platform\n");
> -               goto success;
> -       }
> +       if (amdgpu_prefer_rom_resource(adev)) {
> +               if (amdgpu_read_bios(adev)) {
> +                       dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n=
");
> +                       goto success;
> +               }
>
> -       if (amdgpu_read_bios(adev)) {
> -               dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
> -               goto success;
> +               if (amdgpu_read_platform_bios(adev)) {
> +                       dev_info(adev->dev, "Fetched VBIOS from platform\=
n");
> +                       goto success;
> +               }
> +
> +       } else {
> +               if (amdgpu_read_platform_bios(adev)) {
> +                       dev_info(adev->dev, "Fetched VBIOS from platform\=
n");
> +                       goto success;
> +               }
> +
> +               if (amdgpu_read_bios(adev)) {
> +                       dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n=
");
> +                       goto success;
> +               }
>         }
>
>         if (amdgpu_read_bios_from_rom(adev)) {
> --
> 2.25.1
>
