Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAD2F53D69
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 15:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0A010E3A0;
	Mon, 16 Mar 2026 15:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+xeKuBt";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EF010E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 15:31:14 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1277863a912so300267c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 08:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773675074; cv=none;
 d=google.com; s=arc-20240605;
 b=Y7AYpxzHkM2vJJ6+nYARWFyZdCG+9BVXrxpgv8ibdGdXtgtEJ+tCxmEBIA6mVcq4T0
 SkMv1OSAEGqRIcFjRdegtYGOICtUc4XNP9dhs5nyRkYHaS6dZmXfL1rjQ23O1vwNInNy
 IjwYlmwKtgPYk1EhgsIuoKGI+wvoT0PpjrqefHdlChgqtQOAXXmNH7rM/5wLQlNNjRrU
 QJ6cyANsAPuX5WXMa3GVaz3HU+qg6rt/0wHuITsCcP3o81mqCWOMpeGyfl4Ssbl85wdU
 1leaQ/WEntnVcE/OsWzu9CecuYbXb3bZ4IJK+p4ZFsPPDLE2+jx0ixZcrxfAvuL/OeQw
 +f7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UsN57aXr45Ipq6DV7zZ6JS4j+WJbHFTjgbAOn/UtDlo=;
 fh=ow7q3Uc4roP5F+dA0+cQUSYVfnMr5pSNgkTdWbseC7k=;
 b=e4vWZUNevQEYPcJklMLvUteiHUWZ08j/lPnYIcgZuoKQtS8ttWun/X22rps03QG6zy
 8AAeR6frnDcJ/J9XXQqExuprzd1PAqKtBMl4GPp9vIk0Ijch3x3Xqrxsvw8SWApvFRmL
 DX0bLV6QLuvXnoYMT3lIbNROJoupH0uWUwpvkZzGa3n6kWbpbhyPY6icyEL5qBCc31+F
 a0m7m0S0noC4ErDeGcKkZs4b68ICRIKmTAeTya1fCGTE6hriJjI9d/Ze2IJFCI6O1jw8
 rmWp/BSVp+Vrx3jpDDVaL9WvP/CYb8s3AH+Huip2WmD5Wxycv4tD9rH9RA8m8MvjdYE0
 xyUQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773675074; x=1774279874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsN57aXr45Ipq6DV7zZ6JS4j+WJbHFTjgbAOn/UtDlo=;
 b=c+xeKuBt+qntWfptzN7rZBAp2bUy8K8qqamlGpTw5Un52wt4Aq2xGaNXu4auWp86ht
 EmXB+JoIZ25lBdeDIty2/dwzaWa7oC8H/lOaV5/3NITE24149Qoi1CTN+n9tGgY5T8Uo
 Kuh+Hdph7Dzp5Gbur+OX2npRPa1ThCMx80SE1cPo59QEE6fWFR3ZzR29f+41xkn2tfno
 2nOD6ZXocuDhQq/K/QXm0FJgyNHYSCVCN6SN2Zat7zcwEcXCBg+DQU95cgn3q7YBDjCr
 A/NVWbYw3y6xz1MR0SSRrHZ+p3WRMZw9D25po3nkO6tIfbBg0e/UcLv7ddSB8Lhf42+S
 LdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675074; x=1774279874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UsN57aXr45Ipq6DV7zZ6JS4j+WJbHFTjgbAOn/UtDlo=;
 b=jSGAV5kc17Sq+TNLYxkzpMAbHDwJrB4s6FBOcAl9dxg/O250dK6OLxO/DhIvuqRiXt
 V074qqPhj7SjKdp5XPgGpATWAuP8SucpCPLMXA/2PcKY5tVt8I0ZizoODz1zM8u1ow0z
 5Ep5GygxBU6j1AdSRKCA6VfGWdW1vQhEimbW6FDYtcPFHJt+Co2SQn4Wic0BzB/Z0Bjm
 5WqjvlljCICyREojCVp3aEzAkfpK8OZQEJt6k+Ywwwz88xJlnNDQ1ahCXuZ9wL0nVpmE
 yJFghTcBSEUKpVbQO/b3EGNvQ1fyK80jdGhYtNTleKHIYMB528u+KF3xk8/dR6LFtW1D
 loRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpPeknJZqkTWM7eRDImhjz0L0Etjppk39PaJFWxWh9kOYFLvLBGMbXq53ZGYyHzH/klU1/Tjpd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzG/0p+N/mzjEm7Ouo3bh60dLcTFPbPKV5lV4aY0F0BGWxutkI
 h2xpac36DJF4zSIi1Xl05hXZarNGyukbXChiRGwrW5WjRFOhbFI4CforzlAXg2lpOR1RS0OMKyB
 GeIKZhtrtYp5tnKEdIrTsv4GMkcCgMQw=
X-Gm-Gg: ATEYQzzn6oR50iYxDx3RgBy2NuZppne5FqR6RMwmfFFVVlELs6AG5sZtBcOQoKi65qE
 zpQLZSk9NFv2GjDCNPAZ/8ev+gsqUzpKw2+xQwul7NY6N0p125yKyILsDsdJ682USh5W4bXqupw
 SvV8nX03CJS5bWOqDHOSFb9ymKRqmFGaxdLZ0nFApnAXC5CSZdv2S7O6j+QyopJ/keA/3xv20/J
 A3lmMMJwyLN5dVQj7d32XfqMfkQtufxUciGeU470szPgvtVFMhgLQrfwttugQax6MNMMxppNIBL
 JD0CtLs3DKXkzhQx7eTebfW0xLJNKYTTrgBnU3WHLHa+uN6OhrfubyhpllFlDV9pymGR4w==
X-Received: by 2002:a05:7022:3a88:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-128f3e177damr2607421c88.3.1773675073581; Mon, 16 Mar 2026
 08:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260315164300.60672-1-theofficialflow1996@gmail.com>
In-Reply-To: <20260315164300.60672-1-theofficialflow1996@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 11:31:01 -0400
X-Gm-Features: AaiRm53Sh8dQn7OgKgaSme3pmKALr6QGFspHsG3YV06FUDLiNuiV7U3Vm1vobrA
Message-ID: <CADnq5_M+Z7_TFY5e8dRbyOt7kFCRyS5v071nvrPXcduK+bsh6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: add 0x13da cyan skillfish PCI id
To: Andy Nguyen <theofficialflow1996@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Mar 16, 2026 at 9:44=E2=80=AFAM Andy Nguyen
<theofficialflow1996@gmail.com> wrote:
>
> Add an additional PCI ID to the cyan skillfish family.
>
> Signed-off-by: Andy Nguyen <theofficialflow1996@gmail.com>

What part is this for?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 1 +
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 1 +
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 95d26f086d54..3cfca9249180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2179,6 +2179,7 @@ static const struct pci_device_id pciidlist[] =3D {
>         {0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
>
>         /* CYAN_SKILLFISH */
> +       {0x1002, 0x13DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
>         {0x1002, 0x13DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
>         {0x1002, 0x13F9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
>         {0x1002, 0x13FA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 03d125f794b0..aa25e593a000 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -204,6 +204,7 @@ enum dce_version resource_parse_asic_id(struct hw_asi=
c_id asic_id)
>                     asic_id.chip_id =3D=3D DEVICE_ID_NV_13FA ||
>                     asic_id.chip_id =3D=3D DEVICE_ID_NV_13FB ||
>                     asic_id.chip_id =3D=3D DEVICE_ID_NV_13FC ||
> +                   asic_id.chip_id =3D=3D DEVICE_ID_NV_13DA ||
>                     asic_id.chip_id =3D=3D DEVICE_ID_NV_13DB) {
>                         dc_version =3D DCN_VERSION_2_01;
>                         break;
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/=
gpu/drm/amd/display/include/dal_asic_id.h
> index 8aea50aa9533..8b647bd95691 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -217,6 +217,7 @@ enum {
>  #define DEVICE_ID_NV_13FA 0x13FA
>  #define DEVICE_ID_NV_13FB 0x13FB
>  #define DEVICE_ID_NV_13FC 0x13FC
> +#define DEVICE_ID_NV_13DA 0x13DA
>  #define DEVICE_ID_NV_13DB 0x13DB
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
> --
> 2.43.0
>
