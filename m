Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F34C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 19:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EB210EACD;
	Fri, 28 Mar 2025 19:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NlUINpIp";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFDD10EACA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 19:14:26 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so534337a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743189266; x=1743794066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kawljUbq+bccO8k5zU1eJD742LIN7Wuqx1u9FsEzKws=;
 b=NlUINpIppwByWJseSsJziyuMDLeeFLBsXqyAn0gfrOXS4QOCl3u2w/XkODdCqcI4VF
 fjKGwL4qavgCnjONm5jy4O+lPsLD07SaKfo0gXXSgqstAvJZXrhgtn7MhUskJN1tG/3I
 kwZ2B487QDn7CjpxgWvGG/nE8NGNvvVRLP4yd58hlRK+/ojeViLIUu3x0YPx8dnTPHnj
 30LFlCqBqe4qAe1PKWKNW6XMbdoZcaQsmJryzbYBIx0l2ImLgod3pToTFPEFBPMpoFyf
 EVxj01RQ61yAOSDUlcDzJZg37Swuc/Hl6yYpXse2pWM53pvAXqjBMgrsqcmXYxm96s0F
 qAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743189266; x=1743794066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kawljUbq+bccO8k5zU1eJD742LIN7Wuqx1u9FsEzKws=;
 b=fxZCp2swWHFC58ZmWJ0+XPhP33hPwE64PmW6bKUEAQMil82gI/WZjFQi53OOALBGWV
 kAx/ZaOzEnx6S3yVhTqY398her5OclWomtrMBmSx4GtvJQiX0kOUdpHWUfGw0eyZ6v3/
 OTM9BzQ9Rt7pDR4HPyi5rEp3pIahoi3QyJ4Anh2cIw0bNDBDg50IUNBvNuFTo/7NO20k
 7bCivzNVrhh/4jbnjEGvmfoZVgOtiEz0BjYN8d9Z0AHj+YnDLOCRoSdtp+ARRr1MkFJT
 tDNsuDuTTlrTlpdi9BvRAJchnKeDRxy5L5YRXa6SW55X4rEbGNoKdLC/WUSUqm1g7Z7C
 vcrQ==
X-Gm-Message-State: AOJu0Yzw7tuH7BwWxLAEFM1+fzwYgLqDfwbwNtqBV+SZyfP5c+HNdo6I
 I8UQVUIGxqevfvGkE1dvLkGF5bror1Vu5QCVscpBwFu96MDNDDVTeF8oJELpyMf2xqi4CADrRNM
 k23ahH3rjQS/az+oeuCXDsa/lpBHMPw==
X-Gm-Gg: ASbGncvL0Cj2hYgLXECq8pfbzSyp4VaOYhd2TVt6pwspi8snSvDhYRiBMdrmGsZYlOT
 bbOIoRgjb0c1twv2TNMn0RGf2ybV20Xnwknbxk287kNWrpm08VWbWzTrFPTzdgmPG+vxrlYhmFX
 Gq09CwPCpjWB9OLq/BuGRc9LsadA==
X-Google-Smtp-Source: AGHT+IEs3ceyLBiPKCVN5a29HuQovTbEy48panJUW7/O/Yi5gGYYFxTFbmrMSb1+JzgRMaZr3f+ZTByztNtyJ7FuQbQ=
X-Received: by 2002:a17:90b:390f:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-3053216fadamr208880a91.7.1743189266275; Fri, 28 Mar 2025
 12:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250109165756.26401-1-felix.kuehling@amd.com>
In-Reply-To: <20250109165756.26401-1-felix.kuehling@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Mar 2025 15:14:13 -0400
X-Gm-Features: AQ5f1Jo1o48eYXwy8AuRKziRttFXwn0FI0YKnF66KAosuaJHBm_9rGG_x1XVarM
Message-ID: <CADnq5_N465Z58E9EroVDMtx2E=cAhGbJgC=TE6BhCsVdptwcmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: allow pinning DMA-bufs into VRAM if all
 importers can do P2P
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Pak Nin Lui <pak.lui@amd.com>, Simona Vetter <simona.vetter@ffwll.ch>
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

On Thu, Jan 9, 2025 at 12:07=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> support if all attachments can do P2P. If any attachment can't do
> P2P just pin into GTT instead.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Tested-by: Pak Nin Lui <pak.lui@amd.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>

Applied along with the cgroups patch for amdgpu.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 25 +++++++++++++++------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index 8e81a83d37d84..83390143c2e9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -72,11 +72,25 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmab=
uf,
>   */
>  static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>  {
> -       struct drm_gem_object *obj =3D attach->dmabuf->priv;
> -       struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> +       struct dma_buf *dmabuf =3D attach->dmabuf;
> +       struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(dmabuf->priv);
> +       u32 domains =3D bo->preferred_domains;
>
> -       /* pin buffer into GTT */
> -       return amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +       dma_resv_assert_held(dmabuf->resv);
> +
> +       /*
> +        * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> +        * support if all attachments can do P2P. If any attachment can't=
 do
> +        * P2P just pin into GTT instead.
> +        */
> +       list_for_each_entry(attach, &dmabuf->attachments, node)
> +               if (!attach->peer2peer)
> +                       domains &=3D ~AMDGPU_GEM_DOMAIN_VRAM;
> +
> +       if (domains & AMDGPU_GEM_DOMAIN_VRAM)
> +               bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +
> +       return amdgpu_bo_pin(bo, domains);
>  }
>
>  /**
> @@ -131,9 +145,6 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma=
_buf_attachment *attach,
>                 r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>                 if (r)
>                         return ERR_PTR(r);
> -
> -       } else if (bo->tbo.resource->mem_type !=3D TTM_PL_TT) {
> -               return ERR_PTR(-EBUSY);
>         }
>
>         switch (bo->tbo.resource->mem_type) {
> --
> 2.34.1
>
