Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D02CF885C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 13:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D255B10E270;
	Thu, 20 Nov 2025 13:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="coYvNwON";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9E810E270
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 13:52:23 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b983fbc731bso129094a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763646742; x=1764251542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QEPFMHrqylGUQFwyGrhlwQdBzZ3YLxAFdVfHmwT0Nc=;
 b=coYvNwONGxIy4iGZorO01PN1yiks2/YqZeXohzRY7VvBmUi4oWWU0kfN6G3TH2N3h7
 FfeL3YizS4ASaFC4KTqIKxsVdX1U4qjuzZdChckW98PykzINzsdaRguo16pKI9bW2Puo
 SKf9iBOqgoQl+FOSK8FsWLD015U1bOw1EtPMGn9o7Yx9X4GJfB/TCg/AJU/FhYo/rPRi
 noO92L/KxsL1frnL3f7z9jNNjvygQ3Xukv/joH7g5+0TZf0iR4kzoqDnOiCyULJ2GNhk
 4aRiQq+krVkTjPONukkNlR1/5+vW4tRjIcDJp72RNZ5if7t/RJbFW5PM0N/YrrZIH9TF
 N7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763646742; x=1764251542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8QEPFMHrqylGUQFwyGrhlwQdBzZ3YLxAFdVfHmwT0Nc=;
 b=IY6LU0jzJiSDJSiie1Ojn8Z3ttOs5ubFZFiAic0VWH/AHib2t9CQfREgwKX0XoY5Bp
 WM+oBldxOx3leLxnI0cHc+EkeP+e4UTVlgwLq8dfjyAPL9GCTBUQfp9k0vCGDFD/jdNN
 R0V4fn9t8AA2xZdncbdaCy+SrSlaYG+9bSqE40XlUkMqspYrsW+YiMXMkdfbuUhHNIPr
 uSCjJ1TUYv4fUTotwgAOPxEKZzf+kyBPV31gEW6DdOo96NIe2oYvl6Cx7MFc8asB13bx
 8ISYNdBzVdUY7S7s+KFKmbobFGtkvvM5iwtV3PdipxZGEO4RmvnryFfSw2NAXx6TFIsc
 Go9Q==
X-Gm-Message-State: AOJu0Yw/3EV/GyUG5DTYXBxXmiIVAQJt9KVTry2d074D29NEHhx0k84u
 djjRMnNzzW7tedBXxwl0WZ0F7kmN4/CaRAQP0C9ztXQkvtXho8NaBCiADHFVaaRBSa1lZpop2dj
 GZX9aD5UfHatjCtD6Ly5bgvjE3QcvCDw=
X-Gm-Gg: ASbGncv52IKDwsFOLRxcGAnCoPVn1BKFexsDmBqoj3oIFdb4Z2pF+xewL13+uQmzBnq
 0gPrTW/0jtnAlg+Twn7k9PDNZRp/L1AiJM5/O4F3wBJMKGz7Q3hsTyW8ZI5gRpOItWx9Rq+B8mH
 Z0OnjZWmBLvelPCFST3BBfjduwwQwnvM0I2wNbpsmFyh1yreSLDX/abD9Bigq+YJaXZiNIcCiSW
 hbBI2lgiHF+untBVKiGa5eud4KjuJS5xMPOHaBlUzzOSvk8oT3m8mTbvchgzrdHlI/ZUX0=
X-Google-Smtp-Source: AGHT+IET/zxyx7Bf9SA7uZgE6fZF76lYBUc0es7r3M0mixc/Hsq7PGKbPYl/8g1+1XAmoyZFASuA6LVrghKXdJ2JZR0=
X-Received: by 2002:a05:7022:ea46:20b0:11b:aff2:4cd5 with SMTP id
 a92af1059eb24-11c957481d3mr523602c88.2.1763646742404; Thu, 20 Nov 2025
 05:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20251119235042.992611-1-tianci.yin@amd.com>
In-Reply-To: <20251119235042.992611-1-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Nov 2025 08:52:10 -0500
X-Gm-Features: AWmQ_blYCyISF4WZIFHECYqcHYiimOX75tCkW5J5AAvB-DUWqv4cyjeKLKS-uBw
Message-ID: <CADnq5_PtaVf4W-9OD=Kbz9OTYM9gYYdNZewB=gc9M0+PP7iS9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enlarge DMA mask to 48-bit for GFX11 and GFX12
To: Tianci Yin <tianci.yin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Kasiviswanathan Harish <Harish.Kasiviswanathan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
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

On Wed, Nov 19, 2025 at 6:59=E2=80=AFPM Tianci Yin <tianci.yin@amd.com> wro=
te:
>
> From: tiancyin <tianci.yin@amd.com>
>
> [Why]
> On some servers equipped with huge system memory at multi-terabyte scale,
> the PCI bus physical address alignment policy may assign GPUs very large
> bus addresses that exceed 44 bits. This causes DMA address overflow error=
s:
>
> [   83.216803] amdgpu 0000:43:00.0: DMA addr 0x0000210b39000000+8388608
> overflow (mask fffffffffff, bus limit 0).
>
> [How]
> Enlarge the DMA mask from 44-bit to 48-bit to accommodate larger physical
> addresses.

The GPU only has 44 bits of DMA addressing so you can't increase this.
You'll need to use the IOMMU if you have more address space than the
GPU can access.

Alex

>
> Signed-off-by: tiancyin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 24 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 26 +++++++++++++++++++++-----
>  2 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index a1f8141f28c9..60393e311537 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include <linux/firmware.h>
> +#include <linux/processor.h>
>  #include <linux/pci.h>
>
>  #include <drm/drm_cache.h>
> @@ -726,7 +727,7 @@ static int gmc_v11_0_gart_init(struct amdgpu_device *=
adev)
>
>  static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       int r, vram_width =3D 0, vram_type =3D 0, vram_vendor =3D 0;
> +       int r, vram_width =3D 0, vram_type =3D 0, vram_vendor =3D 0, dma_=
mask;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         adev->mmhub.funcs->init(adev);
> @@ -805,13 +806,26 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>          */
>         adev->gmc.mc_mask =3D 0xffffffffffffULL; /* 48 bit MC */
>
> -       r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
> +       dma_mask =3D boot_cpu_data.x86_phys_bits >=3D 48 ? 48 : 44;
> +#else
> +       dma_mask =3D 44;
> +#endif
> +       r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask)=
);
>         if (r) {
> -               dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n=
");
> -               return r;
> +               dev_notice(adev->dev,
> +                       "amdgpu: %d bit DMA is not available, fallback to=
 44 bit.\n",
> +                       dma_mask);
> +               dma_mask =3D 44;
> +               r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(d=
ma_mask));
> +               if (r) {
> +                       dev_warn(adev->dev,
> +                                "amdgpu: No suitable DMA available.\n");
> +                       return r;
> +               }
>         }
>
> -       adev->need_swiotlb =3D drm_need_swiotlb(44);
> +       adev->need_swiotlb =3D drm_need_swiotlb(dma_mask);
>
>         r =3D gmc_v11_0_mc_init(adev);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index f4a19357ccbc..5ca3d1141cb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include <linux/firmware.h>
> +#include <linux/processor.h>
>  #include <linux/pci.h>
>
>  #include <drm/drm_cache.h>
> @@ -742,7 +743,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *=
adev)
>
>  static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       int r, vram_width =3D 0, vram_type =3D 0, vram_vendor =3D 0;
> +       int r, vram_width =3D 0, vram_type =3D 0, vram_vendor =3D 0, dma_=
mask;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         adev->mmhub.funcs->init(adev);
> @@ -802,13 +803,28 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>          */
>         adev->gmc.mc_mask =3D 0xffffffffffffULL; /* 48 bit MC */
>
> -       r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
> +       dma_mask =3D boot_cpu_data.x86_phys_bits >=3D 48 ? 48 : 44;
> +#else
> +       dma_mask =3D 44;
> +#endif
> +       r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask)=
);
>         if (r) {
> -               printk(KERN_WARNING "amdgpu: No suitable DMA available.\n=
");
> -               return r;
> +               printk(KERN_NOTICE
> +                       "amdgpu: %d bit DMA is not available, fallback to=
 44 bit.\n",
> +                       dma_mask);
> +               dma_mask =3D 44;
> +               r =3D dma_set_mask_and_coherent(adev->dev,
> +                                             DMA_BIT_MASK(dma_mask));
> +               if (r) {
> +                       printk(KERN_WARNING
> +                              "amdgpu: No suitable DMA available.\n");
> +                       return r;
> +               }
> +
>         }
>
> -       adev->need_swiotlb =3D drm_need_swiotlb(44);
> +       adev->need_swiotlb =3D drm_need_swiotlb(dma_mask);
>
>         r =3D gmc_v12_0_mc_init(adev);
>         if (r)
> --
> 2.34.1
>
