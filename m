Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DBC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 16:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8EC10E244;
	Mon,  5 Aug 2024 16:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TVjBkLvX";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C84710E244
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 16:07:16 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-70d2b921cdfso9482700b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Aug 2024 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722874036; x=1723478836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u31eTAl7RCVqPqHywaGBL1vhY9EPUhKR2QIcnb0yel4=;
 b=TVjBkLvXI48wkQo7BN2GfFHsRLXOYBA6vlOnpt4y6B0tARDmO/X+49tA3ZR9pDWFmd
 UlEF7uTW4AjMVEBxWv6z25Q/zOCdQTQ57bEEEwj7LWyASXiNTrh7NnSqehCBjtxOgWrE
 LGB8iWQlisBxn7BztkYuGa9bwkNRss5kYrPUAZXslYlb88GlUWPYAyh6FNCT15fhJOC9
 rUf15EbyE+rxDa64EpwZqblrVA2p+EDrW3vzZ22ighcrSdFeNVkgF+3StORzV5Qu5GUC
 cWXvSvAgijzn86diynCiq3RabJkc76XeNe0ZK/w1iNzWJ43kcyL1wOQj0mfO9K281fr3
 Rd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722874036; x=1723478836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u31eTAl7RCVqPqHywaGBL1vhY9EPUhKR2QIcnb0yel4=;
 b=j5lVegkoLKFCjkuvi5TS6gtM7QSEG2YcrXSJHybqplZrXAuNgnFoNVyyJ+Tg0TgyEK
 RCK2hRDi9my1OR1QJU1wx1jFOm91mrjzCttPCUpSJ3uPrvBZuMjcXPdSH+eb694tKWyY
 HvnS8wt3wwliaiETTHaEgdltter/Hr2l+4HKX1R6AkzDkOeL84b+gfpYunyhkQa/6Si8
 g2wkmjZmJUij+Dx7tohXP/iM6f+DydjpVW4Bwqp9g+xJijjuGYVdJBYn+5D8w7o9EA76
 44zBpjLGfj2wJrJErN3vQZgLvfhHjffcB6sVY0kWUyaaGsKxJSA80QoPY2QTgZ00NMkF
 Z8bA==
X-Gm-Message-State: AOJu0YxNMzNtf9T3fq+0h7bUW2j7EM2O3vSBNirQwrqaxvxwajH2vegs
 vCNu9jCJElfUUAi4MZ8UUrfWByzAAYL3clYRFKMlE08CijmlX7M20+tH9r/2ZrrMTJmZXcOp/fN
 yveeCFYszxCKIYLWKWOjkDHnNoOc=
X-Google-Smtp-Source: AGHT+IGY1IEpGxYHnpob5EOBpnrgDHjxpSNf1KgLPfEdeok/a392mvPGgnyt1EAiv+ZxCP1kb8xjsACn1bwth0rn92Y=
X-Received: by 2002:a17:902:e5c5:b0:1fb:4fa4:d24 with SMTP id
 d9443c01a7336-1ff5741474bmr159187745ad.50.1722874035875; Mon, 05 Aug 2024
 09:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240805140125.549000-1-Arunpravin.PaneerSelvam@amd.com>
In-Reply-To: <20240805140125.549000-1-Arunpravin.PaneerSelvam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 12:07:03 -0400
Message-ID: <CADnq5_NN141bN98x12moBofbV=MnM-zNMPOmMFrvO6_GPBZu3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add DCC GFX12 flag to enable address alignment
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 alexander.deucher@amd.com, frank.min@amd.com
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

On Mon, Aug 5, 2024 at 10:10=E2=80=AFAM Arunpravin Paneer Selvam
<Arunpravin.PaneerSelvam@amd.com> wrote:
>
> We require this flag AMDGPU_GEM_CREATE_GFX12_DCC or any other
> kernel level GFX12 DCC flag to differentiate the DCC buffers and other
> pinned display buffers(which has TTM_PL_FLAG_CONTIGUOUS enabled).
>
> If we use the TTM_PL_FLAG_CONTIGUOUS flag for DCC buffers, we may over
> allocate for all the pinned display buffers unnecessarily that leads to
> memory allocation failure.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 5415a5cc7789..7de0ac07a060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -509,7 +509,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_ma=
nager *man,
>                 /* Allocate blocks in desired range */
>                 vres->flags |=3D DRM_BUDDY_RANGE_ALLOCATION;
>
> -       if (adev->gmc.gmc_funcs->get_dcc_alignment)
> +       if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC &&
> +           adev->gmc.gmc_funcs->get_dcc_alignment)
>                 adjust_dcc_size =3D amdgpu_gmc_get_dcc_alignment(adev);
>
>         remaining_size =3D (u64)vres->base.size;
> --
> 2.25.1
>
