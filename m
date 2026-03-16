Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C18F506D2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2980B10E201;
	Mon, 16 Mar 2026 13:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C4Reei8C";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D3210E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 13:55:27 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-124713e4244so284533c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 06:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773669327; cv=none;
 d=google.com; s=arc-20240605;
 b=Of9PiTyDWj2AZ30H1pmzuhCQ8sTXNb6YThNtncgxbpaeI3YX1zMouKGUQt/EuT3KcR
 Om0xmbiIcTBGVtZcakpzLPvgrTWfTdRxiOH7ljb1EtYtWfqTTUfbFI25/bZCUXmvdTzW
 FC017P5soZIKtEaf6pI9tVmnfiTTcDgfJ16MXFITFElnuH3zHtsf+6NyEDgBLayTqlbU
 LzfulF5ElvOuFxZ2qZyZuUA4xvVUhtNHCD2snUp3jQoJMUJUVg/BHsTHXZL4Hf/K18C4
 WmgA4Kdo8mdTx05P0lkPmDTgOS2pMR1KGOkMQLx0/exqZMNXj6wSYOf9OD9um7CDvd5Z
 edPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
 fh=X5jMauChbUOmBCb2N54P6sd+OkLhciMcUbT+GqIvW4E=;
 b=R8TGvZpjT00sZW7VGAk1jNGU9IgEED3QY5dI8Mpk9UwQXechXYFYP07SVZGZhwBBty
 VlInGFE1m20rD7hIt0f1n7kHgo8vS/qSYjQvVABpjg/cWbuHhX53UhnFF2/R5lkt349V
 Pj1gFWs/dyXmkUcXhyUTvGDP5UxWpqO8xY5A3CBsV0lzLh4yAX72qEgdz7mwRjYBFmUB
 MEQ9xHwNqKIKtHW/YXPLMofHkMlmfO3OUADFae6CATm/QFqvPOUes2D4TCSXzaWXs/Z0
 s4WPv6EULvrYKvliW1427pdEGKLkeqUEe10HseCqUMbaLv8nlWFSEqon8zo47RiQWfMY
 0TZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773669327; x=1774274127; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
 b=C4Reei8CFb9MbrBebD5YuRiqvBWiZhSYGMzGagNNUTqQEzDWWr15ARchPDA0yXSXZg
 +OBa/YWnYansoKM4y+tJ8wEn+7NsKMpHw6OGf2BRjHgGfBUirFjOPeJ3KUhV076+a5WI
 z1IInlqyDVvoF7GWwJfDpiluadixh7l7OB0AtPoVdhNbhzYY7fXJHrnKwD3zK46+Pj8c
 ahQAMbMcgJ//FXwcZqi8N/p+86I2TvxAa7HohQIEdOru8UoMq/r2XPILBCugHkuqZD4a
 R6SJaitmy2AQ5LPW8yemdE/QgKGIoL6D958vzd8LU/v75ppyzeNEEDa729xLwLyj2nRy
 Fmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773669327; x=1774274127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
 b=oSkxZwnND+XuzshyBGxH4lVuUds+MCV45joFQbidVrfb8w4m5AVc42J8/5NDXUsmTs
 wa7yypXhcJKFW848WYGZtxeGJG1spW3csydJq1A6SflTQSyHTIeK3MHfvGLkL4Qs1SlA
 OmT8D5ekhCnfgvdSmoRYwrYlFX8/QFa0n5u/OrKCTZa0yePnEycoVII6Fkt9XQmZuByB
 qNs4+xNdyf/d0pAQt6dnpTtKygBGDWwLc4S3O91M0+qGPdfgkvoTTa2hXPECRPsrfMAI
 ryzjbI+EpnogPTi5whS2fzlSbsCkeAhq12p7rYpZGUn3nH8sMqvzsBffzRSRefTuouPF
 jYRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhEnrz+/QfDmmPgyJtd6unCvnkWy+av0xqJq9qOnBcDc57cNU1OIKMM/NR9NhIwypGbz/RsDCd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymidgfbZ3KJlVZcdRvoia1KpJ3e4KmMlWTr43Vv323OipN9zUE
 zk7hAwh/KRbPbVtgogRNMLr/QP/dUIK2bW2NSmGQECCiWcfUXcEtGDP6VVh45wU3wr7R6iRVKjR
 Czn0CGME+szL34bE2sH3/DP3i9V3EoXw=
X-Gm-Gg: ATEYQzzQQvz2GxY4xNkNldBDq8NYFvyG7sfR6/Koc7zHvJOe0pbtl7jCCCcJMmXyFmZ
 i4WIHkz+Eqsfkhbi9PykowVeGjKHdlbLjMGBjzET728GklFLXPVr1Snimhj/FW6lWa5gt2IxWpM
 +fpQafHcUJ5JeBSsGUJJN9ip7GlPP3APzXt6pOzdY+NEL0Uh5T2tQAIprpXwCgMZ48BJIR0xVU/
 rNVVWRXur+gwI5X+3f5Rymk8RMRGmTBFJcFmZM6j5ypyK1C+LnrijlP30y9FRegbUdoG7UA/ajD
 zhc5R/aH4nQG7OuiwY5LnVGbJG7I2hCFSUpP4lJDaHmVA2XbEst3DuCLz2QjqUUZLrCMAQ==
X-Received: by 2002:a05:7300:5381:b0:2be:7eb2:2ed3 with SMTP id
 5a478bee46e88-2bea539bff3mr2901460eec.1.1773669326880; Mon, 16 Mar 2026
 06:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
In-Reply-To: <1phlu3bs.ritesh.list@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 09:55:15 -0400
X-Gm-Features: AaiRm53_ccrgezS35W1n8IrX8XVanOeDHAQj2R8ZIMS0L2p2PMNUMQSQA2nolFQ
Message-ID: <CADnq5_Mk+D5CSe61F6DewQjevjhsduiga21f8dVrLwR28zcwvQ@mail.gmail.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>, linuxppc-dev@lists.ozlabs.org, 
 Gaurav Batra <gbatra@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Donet Tom <donettom@linux.ibm.com>
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

On Mon, Mar 16, 2026 at 5:44=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.c=
om> wrote:
>
> Dan Hor=C3=A1k <dan@danny.cz> writes:
>
> +cc Gaurav,
>
> > Hi,
> >
> > starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
> > initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4=
100)
> > with the following in the log
> >
> > ...
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: =
256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
>
>                   ^^^^
> So looks like this is a PowerNV (Power9) machine.
>
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
Detected VRAM RAM=3D4096M, BAR=3D4096M
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
RAM width 128bits GDDR5
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu:=
 64-bit OK but direct DMA is limited by 0
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_io=
mmu_get_required_mask: returning bypass mask 0xfffffffffffffff
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M=
 of VRAM memory ready
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570=
M of GTT memory ready.
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) =
failed to allocate kernel bo
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
Debug VRAM access will use slowpath MM access
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
GART: num cpu pages 4096, num gpu pages 65536
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) =
failed to allocate kernel bo
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) =
create WB bo failed
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu=
_device_wb_init failed -12
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu=
_device_ip_init failed
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal =
error during GPU init
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finish=
ing device.
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe =
with driver amdgpu failed with error -12
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm f=
inalized
> > ...
> >
> > After some hints from Alex and bisecting and other investigation I have
> > found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a634=
2fb821d8ed501af956dd0
> > is the culprit and reverting it makes amdgpu load (and work) again.
>
> Thanks for confirming this. Yes, this was recently added [1]
>
> [1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@l=
inux.ibm.com/
>
>
> @Gaurav,
>
> I am not too familiar with the area, however looking at the logs shared
> by Dan, it looks like we might be always going for dma direct allocation
> path and maybe the device doesn't support this address limit.

The device only supports a 40 bit DMA mask.

Alex

>
>  b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: =
64-bit OK but direct DMA is limited by 0
>  b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iom=
mu_get_required_mask: returning bypass mask 0xfffffffffffffff
>
> Looking at the code..
>
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index fe7472f13b10..d5743b3c3ab3 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size=
, dma_addr_t *dma_handle,
>         /* let the implementation decide on the zone to allocate from: */
>         flag &=3D ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>
> -       if (dma_alloc_direct(dev, ops)) {
> +       if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>                 cpu_addr =3D dma_direct_alloc(dev, size, dma_handle, flag=
, attrs);
>         } else if (use_dma_iommu(dev)) {
>                 cpu_addr =3D iommu_dma_alloc(dev, size, dma_handle, flag,=
 attrs);
>
> Now, do we need arch_dma_alloc_direct() here? It always returns true if
> dev->dma_ops_bypass is set to true, w/o checking for checks that
> dma_go_direct() has.
>
> whereas...
>
> /*
>  * Check if the devices uses a direct mapping for streaming DMA operation=
s.
>  * This allows IOMMU drivers to set a bypass mode if the DMA mask is larg=
e
>  * enough.
>  */
> static inline bool
> dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
> ..dma_go_direct(dev, dev->coherent_dma_mask, ops);
> ....  ...
>       #ifdef CONFIG_DMA_OPS_BYPASS
>           if (dev->dma_ops_bypass)
>               return min_not_zero(mask, dev->bus_dma_limit) >=3D
>                       dma_direct_get_required_mask(dev);
>       #endif
>
> dma_alloc_direct() already checks for dma_ops_bypass and also if
> dev->coherent_dma_mask >=3D dma_direct_get_required_mask(). So...
>
> .... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
> Isn't dma_alloc_direct() checks sufficient?
>
> Thoughts?
>
> -ritesh
>
>
> >
> > for the record, I have originally opened https://gitlab.freedesktop.org=
/drm/amd/-/issues/5039
> >
> >
> >       With regards,
> >
> >               Dan
