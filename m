Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C6AE77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 16:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A82910E643;
	Thu, 12 Dec 2024 16:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGH1Ov09";
	dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9A910E643
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 16:51:59 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215607278acso1328005ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 08:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734022319; x=1734627119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nomCpUFqXl7t/wlKFNXo/9ON55vCnySp0ZuELSEe43w=;
 b=mGH1Ov09JvEs4o3RmK0boRuy+GNw2yRQtm9NUhv0Wo/Mv4k7PlN3X5stGJ1eukvJqU
 WzziLZIaoZmUQHc2xVQt1pohHUd3VROXUH/FjNMz773yVJazDCKMVJVOebMfwjQ4aSWb
 ebKzNBuRMrJazEZj/ZakHGNiDNx0MWaWAC/9y4aIxwEFdDEhztPRr+wFvJP1MAeptaxi
 5waUFbnh5O6B1WxZX7iWYtaS1jGbNtMlSLM0XbLBtAl9FnBaUyhSFbD+t0O8Mvilzc3Q
 71Rvmzpyppd6fBxy+cNOoud1/+hJj/rYtmYs1nBsR7/MxdFwNF9DR3P/16upyrECCaad
 TGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734022319; x=1734627119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nomCpUFqXl7t/wlKFNXo/9ON55vCnySp0ZuELSEe43w=;
 b=H6hr3gGNf9dgUmpuqrCqqa8VzeA1HZnxNJrUDfepCp+7yBbJqMpLjJAnr+Kl3FC/sz
 nPIkEjkWxhcsda1aqQQUs8IWic+MkA2uG/+GKJyNret/6sKWgmjFMohNDeoo0moW4uFm
 zcrJv0sJSxT8U6JPIWDmsu8StaNMvg3mjz9U/BRoeCxurDQS6RwW1wMQX0xjXFbtmc66
 Iyj16ae5J3JuYw+k+zoELOzoCLDvZuni/o74zQDBxMVx4dRldlMqsDM6abD7WiRe3+E4
 cef9esdvYSpAbnbSI3VLI4e2iH11cMbq6neFQ5nPpBpl42HwyV3UVSjOSoR27nUDkEQ3
 1Szw==
X-Gm-Message-State: AOJu0Yw0tH20Xv2qptO3y5z/E08byrKn+OEJJQS4HK4Re7VI1Wt6N+yA
 6BMAJ7ENk/fChfi4svlzcizX2uclfSOgJkN/hlBV1EoUiripvwcpj/UPmMrpsO1OzKd2V9Yufb/
 LhAcFM1dwx0r6gD3cG+r36TkrB4UJsQ==
X-Gm-Gg: ASbGncunJlPfiPzwiQX63DNZ/Vysm1+xDecFy/sUbZxBjvLcPTv6qrFmmAmW+qWfUMe
 afBcLum5jbEJtfKHEpUspJK2syjb+seyuURUEcg==
X-Google-Smtp-Source: AGHT+IGUlc4ivH4cfveyHL2OdGG+vlFn9iFwM76l7+DgtOs8K34RuuKK9ECxV9a2BEjVvUd5qO8GPdxCc3MDeRuuXPY=
X-Received: by 2002:a17:902:ccce:b0:212:b2b:6f0d with SMTP id
 d9443c01a7336-217782d21c1mr43976885ad.0.1734022319337; Thu, 12 Dec 2024
 08:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20241212042247.3782090-1-lijo.lazar@amd.com>
In-Reply-To: <20241212042247.3782090-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Dec 2024 11:51:47 -0500
Message-ID: <CADnq5_Mco=1wfAQEqueWVene1VPw1oJ4i0kTzcg3_zNkxsyfDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use dbg level for VBIOS check messages
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

On Wed, Dec 11, 2024 at 11:24=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Driver has different ways to fetch VBIOS. If one of the methods doesn't
> find an authentic one, it will show misleading info messages eventhough
> a subsequent method finds a valid VBIOS. Keep the message level at debug
> and add device context.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 26 +++++++++++++-----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 45affc02548c..423fd2eebe1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -47,35 +47,37 @@
>  /* Check if current bios is an ATOM BIOS.
>   * Return true if it is ATOM BIOS. Otherwise, return false.
>   */
> -static bool check_atom_bios(uint8_t *bios, size_t size)
> +static bool check_atom_bios(struct amdgpu_device *adev, size_t size)
>  {
>         uint16_t tmp, bios_header_start;
> +       uint8_t *bios =3D adev->bios;
>
>         if (!bios || size < 0x49) {
> -               DRM_INFO("vbios mem is null or mem size is wrong\n");
> +               dev_dbg(adev->dev, "VBIOS mem is null or mem size is wron=
g\n");
>                 return false;
>         }
>
>         if (!AMD_IS_VALID_VBIOS(bios)) {
> -               DRM_INFO("BIOS signature incorrect %x %x\n", bios[0], bio=
s[1]);
> +               dev_dbg(adev->dev, "VBIOS signature incorrect %x %x\n", b=
ios[0],
> +                       bios[1]);
>                 return false;
>         }
>
>         bios_header_start =3D bios[0x48] | (bios[0x49] << 8);
>         if (!bios_header_start) {
> -               DRM_INFO("Can't locate bios header\n");
> +               dev_dbg(adev->dev, "Can't locate VBIOS header\n");
>                 return false;
>         }
>
>         tmp =3D bios_header_start + 4;
>         if (size < tmp) {
> -               DRM_INFO("BIOS header is broken\n");
> +               dev_dbg(adev->dev, "VBIOS header is broken\n");
>                 return false;
>         }
>
>         if (!memcmp(bios + tmp, "ATOM", 4) ||
>             !memcmp(bios + tmp, "MOTA", 4)) {
> -               DRM_DEBUG("ATOMBIOS detected\n");
> +               dev_dbg(adev->dev, "ATOMBIOS detected\n");
>                 return true;
>         }
>
> @@ -118,7 +120,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_=
device *adev)
>         memcpy_fromio(adev->bios, bios, size);
>         iounmap(bios);
>
> -       if (!check_atom_bios(adev->bios, size)) {
> +       if (!check_atom_bios(adev, size)) {
>                 kfree(adev->bios);
>                 return false;
>         }
> @@ -146,7 +148,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
>         memcpy_fromio(adev->bios, bios, size);
>         pci_unmap_rom(adev->pdev, bios);
>
> -       if (!check_atom_bios(adev->bios, size)) {
> +       if (!check_atom_bios(adev, size)) {
>                 kfree(adev->bios);
>                 return false;
>         }
> @@ -186,7 +188,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_d=
evice *adev)
>         /* read complete BIOS */
>         amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
>
> -       if (!check_atom_bios(adev->bios, len)) {
> +       if (!check_atom_bios(adev, len)) {
>                 kfree(adev->bios);
>                 return false;
>         }
> @@ -216,7 +218,7 @@ static bool amdgpu_read_platform_bios(struct amdgpu_d=
evice *adev)
>         memcpy_fromio(adev->bios, bios, romlen);
>         iounmap(bios);
>
> -       if (!check_atom_bios(adev->bios, romlen))
> +       if (!check_atom_bios(adev, romlen))
>                 goto free_bios;
>
>         adev->bios_size =3D romlen;
> @@ -324,7 +326,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device=
 *adev)
>                         break;
>         }
>
> -       if (!check_atom_bios(adev->bios, size)) {
> +       if (!check_atom_bios(adev, size)) {
>                 kfree(adev->bios);
>                 return false;
>         }
> @@ -389,7 +391,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>                                              vhdr->ImageLength,
>                                              GFP_KERNEL);
>
> -                       if (!check_atom_bios(adev->bios, vhdr->ImageLengt=
h)) {
> +                       if (!check_atom_bios(adev, vhdr->ImageLength)) {
>                                 kfree(adev->bios);
>                                 return false;
>                         }
> --
> 2.25.1
>
