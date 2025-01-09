Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C6E77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 17:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2E010EEEA;
	Thu,  9 Jan 2025 17:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZkdyfHIJ";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C263B10EEE7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 17:15:35 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-71e2764aa46so629739a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1736442875; x=1737047675; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd7H2oMVgJKb+hVmlZW25AUZ1qgCc3z3UsI/6b3PjQY=;
 b=ZkdyfHIJXLigVRzfUJmool1ivUUYryyHwOcBCeUkSAeaTA4oz4eNR3V2OxTBrX610U
 0gSCyzQsf14Dh9Awe6p23rxjVmxFAORknLXKndjCqmRM08dkou8kyTgFGgHjL62vgzwG
 yzbAUjBNX0NLg6yALsytpJqDp7YGsdEZUiTqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442875; x=1737047675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fd7H2oMVgJKb+hVmlZW25AUZ1qgCc3z3UsI/6b3PjQY=;
 b=aFWQIJzfDl5oLjsO7dW8XYwlD9KPEiTpJTh46VawMXrSFXgOJHOT3s+mhQ2muJzOFM
 981RAc44qtnxtZ+FVZ5eLruXTWEGBxtvEu2jqJos1CRypzabGUkVo8vRXepfgKv5jDAy
 nE+OSqp3Y6YlUhOSVpVM9kwUBnhHfUlABF4uUxhzmgpA8Tw5Cag4NgTe7T1pXiz09S/E
 xsEIMKYxyaHrpS+ea9hI64F9gts1FqD0BclnTxPALQ4Un4+yf4zAyWOQ7RicqgKgjAQw
 un+5rp6hLd0E2uW8HCQD+v4F/PXglCkfXIbdlZnfq4k7ozfuIayDJfidY7HOirbSo7Gh
 O17Q==
X-Gm-Message-State: AOJu0Yz1fpZ2PhO/VXecPVE8nYjxMB6ooVvFsfZ5Chm7Sc1FtMfDu7ij
 VtDR0RX1ZCw1ucxRusvH2rtD4+HaFBiP6UeGYmCaRL5z9w8u5SFK1SAf2WGR/60++LFwrgziJZV
 rez6qvXQjWFDBFgTO5VzYnq0QZNjLQePO8Q+WEA==
X-Gm-Gg: ASbGncuFBW9K4IaOdCDE9a1QTfH6jRUE7mGf8xW6noOlxcTDkUmIPjy/4xXbJZsl/03
 1NvEFAZsDMKClGQocmBttfLOvsLRO9zgz/kTdmtXGnF9HFSh12e+O3gXdEDKCnl3I+Bs=
X-Google-Smtp-Source: AGHT+IEUSJND1ziIx8ZLyy3zU/1u7HllKEF/Ph6nhKn6UrCc5I7aNHTGOK7jGLvIKuwevMQlAa5Q/0FnWRlMWurNudE=
X-Received: by 2002:a05:6808:4491:b0:3eb:47f9:a803 with SMTP id
 5614622812f47-3ef2ec23f39mr4595543b6e.18.1736442875002; Thu, 09 Jan 2025
 09:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20250109165756.26401-1-felix.kuehling@amd.com>
In-Reply-To: <20250109165756.26401-1-felix.kuehling@amd.com>
From: Simona Vetter <simona.vetter@ffwll.ch>
Date: Thu, 9 Jan 2025 18:14:23 +0100
X-Gm-Features: AbW1kvZSPulF_R0ZYDJBXZnHV16xwcz0z3PlBrgQDJEteO_-RgQC6WiXLAFbwCs
Message-ID: <CAKMK7uF7v3uYgAPVeDM9VraAXgMZcHx09Wd+9Gfq9G5Rar_Xgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: allow pinning DMA-bufs into VRAM if all
 importers can do P2P
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Pak Nin Lui <pak.lui@amd.com>
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

On Thu, 9 Jan 2025 at 17:58, Felix Kuehling <felix.kuehling@amd.com> wrote:
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

I thought the big reason we never did this was that there's no way to
account vram pinning properly, until now? But with the cgroup stuff
finally moving that's no longer a concern I guess, but I'd at least
note that down in the commit message. And maybe land this only after
the cgroup stuff is in?

Anyway code looks like how we designed this all to work, so ack.
-Sima

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


--=20
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
