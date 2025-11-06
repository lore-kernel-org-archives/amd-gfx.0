Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516EDCCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 17:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E1F10E996;
	Thu,  6 Nov 2025 17:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fynZQ5oi";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F247710E996
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 17:25:51 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26808b24a00so1548645ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 09:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762449951; x=1763054751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMK24glWiKINgrLLdeVPXLX3BtWebP8Ui/EKZTIvi+g=;
 b=fynZQ5oi5yZI4At7qQ0EB5CTW+rr6ZtjwnaCkZoEy9Ffr1ETbstocAUprgD5YEr8+k
 1w9NTG9UJS1N1qOxE945SnlL61ey70+L//l4LwweXDN/1tpzFFfZGTr8LShJAcPoCDvl
 /Br0RymBq7TGDCwOPSqzz5aOwegr/q1H2Whmpfa7/ATw8TOhRoOO7zjiCeGFjCYExt69
 hi50zHGjX+0W0lHKGe1iKsHJE7iQwRKUhT7YX/19GrHMtHWOq+WmmxfiaEiCN9T8rAy2
 x07yt2OT6RX+xbuxp71EMuqAW8ZZE0Dz+YBBs95sN6bbfYaDaKXwHoAKtcYRYVw130tT
 Pw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762449951; x=1763054751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMK24glWiKINgrLLdeVPXLX3BtWebP8Ui/EKZTIvi+g=;
 b=GHJdsKP4smnhDn8WG4kCDYsBkshN4VHKQc0qycIx+ieLDER8Ui7RmYospQczIsYOld
 BSzLT1ygoAZAy9HQ6sskMb7qyGS/2dcToshVpFdw2ijGHxpQ/cvD4uxhd6lDaL/k7vob
 hvFsXSJUwbXH4ADz/YmonplwrxtVm2szt0PFe9HhAPqQBT27BrARoQGyeAAncEW1RvFk
 SmmgVoyNySaZzbxsjIko7Ap4a2Qx6Llxe99UoQ9Iru8bqOHb1w9JRXeqQZW7nDl93qUN
 OTSnyyF3MtMgCGP4nuciqb5Tsc4XtQYPBw+twHPB4IoJih8dcZabGdtSxI+hXsrFYp0j
 oRBQ==
X-Gm-Message-State: AOJu0YxOMRctDCe/y+3BLAj/Z5D/MeG77kVtpRs5V+VpCv7hc/N3mtM6
 r1f4v50qW1bJdSkZnH4+s1fPOsUWXKCvNI4/ARau0hWZ2zjwYPqjY7GKUHhtj5lZ68ZGO2gjPts
 4jD3D1Vb44dTkJ/XuxuWrHrJwJxQxLeI=
X-Gm-Gg: ASbGncv6PLbTK5MvKSTsd6ORsJ/MGTtB8i8GpJ6Sx/8KCJqoC1YY6iDatODQvp7DCL2
 YblawTR2TdzmhlxkkbClB/UFcs0K1jscZzSg2hDHqN8aswNcm2IUOkloST2AXy9wkdpY6Nea/CT
 HD5NnPFuxuwXFSPPMusNvwjBcl8M059Z2uBjqdd72HGns0JdIuHnd4dArq+e6v5RmcrGrc5dCmX
 jg38237ilYtRZjyywHeL8NDjErKpiAiQAFj0rLDCrCNKg00uiZx/3srx7GXhyNhpVTcsR4=
X-Google-Smtp-Source: AGHT+IGym0WJW2gQ5CiiuB7rtFLM54zXTjanoZwejINZ1wQzHHOJDKJkh3GxmcqcDzgmgMsnaGZIncCABWqOJlCvhzE=
X-Received: by 2002:a17:902:e5cf:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-297c048a8b8mr1464035ad.6.1762449951375; Thu, 06 Nov 2025
 09:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20251106170356.47238-1-vitaly.prosyak@amd.com>
In-Reply-To: <20251106170356.47238-1-vitaly.prosyak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 12:25:40 -0500
X-Gm-Features: AWmQ_bnn-KHyidhKuY6npihVADeoIJ7_fe5oJ5UcQgZsc1SP71Ebtosmreb8N-4
Message-ID: <CADnq5_MAVEeEzjb+dnBEAQ27dpbiRzg1h5yr3oEkDC=AWJzS3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable peer-to-peer access for DCC-enabled
 GC12 VRAM surfaces
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Nov 6, 2025 at 12:21=E2=80=AFPM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Certain multi-GPU configurations (especially GFX12) may hit
> data corruption when a DCC-compressed VRAM surface is shared across GPUs
> using peer-to-peer (P2P) DMA transfers.
>
> Such surfaces rely on device-local metadata and cannot be safely accessed
> through a remote GPU=E2=80=99s page tables. Attempting to import a DCC-en=
abled
> surface through P2P leads to incorrect rendering or GPU faults.
>
> This change disables P2P for DCC-enabled VRAM buffers that are contiguous
> and allocated on GFX12+ hardware.  In these cases, the importer falls bac=
k
> to the standard system-memory path, avoiding invalid access to compressed
> surfaces.
>
> Future work could consider optional migration (VRAM=E2=86=92System=E2=86=
=92VRAM) if a
> performance regression is observed when `attach->peer2peer =3D false`.
>
> Tested on:
>  - Dual RX 9700 XT (Navi4x) setup
>  - GNOME and Wayland compositor scenarios
>  - Confirmed no corruption after disabling P2P under these conditions
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index 9a0bce3ba24c..d2d31031f672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -260,11 +260,24 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dm=
abuf,
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>
>  #ifdef HAVE_STRUCT_DMA_BUF_ATTACH_OPS_ALLOW_PEER2PEER

This patch is against the DKMS tree, for upstream, please rebase
before you commit.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +       /*
> +        * Disable peer-to-peer access for DCC-enabled VRAM surfaces on G=
FX12+.
> +        * Such buffers cannot be safely accessed over P2P due to device-=
local
> +        * compression metadata. Fallback to system-memory path instead.
> +        * Device supports GFX12 (GC 12.x or newer)
> +        * BO was created with the AMDGPU_GEM_CREATE_GFX12_DCC flag
> +        *
> +        */
> +       if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(12, 0, 0)) &&
> +               bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC) {
> +               attach->peer2peer =3D false;
> +               goto update_vm;
> +       }
>         if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
>             pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>                 attach->peer2peer =3D false;
>  #endif
> -
> +update_vm:
>         amdgpu_vm_bo_update_shared(bo);
>
>         return 0;
> --
> 2.51.2
>
