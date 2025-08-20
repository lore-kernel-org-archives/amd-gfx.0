Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1928CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FCE10E7F9;
	Wed, 20 Aug 2025 21:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DT41sT4k";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171AD10E7F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:41:25 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2447d607b70so446385ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755726084; x=1756330884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wf/riEltdwDT3RmnbU8SY1Qqb1imy3W4PGqziZynI5Y=;
 b=DT41sT4kMGeBH5sOelXPgkGhNNeAAo9EGCYa4EXCY1te6klnsad6Rw1vdW3DM3hHI1
 ZC687oFOEL9krUWvkeeSTqKGc6AyWbFd+JovePNtpZb2bmr7NzEVqvne5se3pv/jZCks
 9DgzG7qAgxUA/OaEqv0cD73ARWxVFhXa9qmDgcUApgVHldwizeD5ssmgJ52PoM1Gx5Ov
 k0HFCd3TUR8+p4NJCtWpBTahFGb25ilt4/LwcoclYzoBOlgBMrmWV+Impj+3sL92qkfI
 9aa2hQafEnHUo4XeqaxrkI6noKLIOhG+wCNINe01+V1DGbD3whSU2cd0OiL3h8CkXT/M
 CSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755726084; x=1756330884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wf/riEltdwDT3RmnbU8SY1Qqb1imy3W4PGqziZynI5Y=;
 b=eMeQ0BL1zOs9NBqbsYojExsv+2YhvaoSG3OTXdj286B54kc+3r7J6F68qW3CXdNLPb
 IXFS4omgROxlf4beX08JMgajWS5OPVFcWip2bOUUC7eqtsRNVGE3dtHwtJQomj1eKGTl
 z8HtJoGL7ShVMF6kzk1oHvgf/HnhWrQg0+rCDKv5SHJ9BCuCwtaqvrnih4pG3EJdMGFq
 g3r2raobqsOhzQcCVGlU/ixyHQDFwH2qU/t8CySPSDIyeiT6zpGpRBu/caq7eDPYKvFN
 TQbwS9RqYNeLkgx9RMsuQ5des7R3DBcZG9K3bFpdsqXuYr08eg4TbIrdbPoshEQ2Tkbh
 A7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/IARDl2uP9Ixe4mjW19FSjLIroq5esh7mjYCA2CyLKYrjJI7T1DHkm7dnybkp1xk5rF1a2hso@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaNdUtowYXabSiwPZf1Hsjt/GEQfS1cpJxYr2OBvfUUYMkG0ZI
 Z0Oq5IyKEEjHAOp76/dtHlNOGrfgbap0CbHs/VsIMpkt+X5rsd8SjJ8wkxbHqxJc2gQ86JpHqGd
 f6QDZrq+9zHjTteZ+UgJ8zfdiIefKwwY=
X-Gm-Gg: ASbGnctYi+K3UOFRpC6svj+IsY/2+yyqpN4Ma1Z/N8+82ivn/3DuIfXJGJNW7UGa4wY
 rudtTbTWmxGflq4wWUcWIjh+gkmWDYSUFre3UCmFY/KtptiFacgCs8RHXyoq7rahhDBh4ZKdo1o
 kv3pyUYu+oOS/D8jIGL93sYiLFwSZ8w5rZZCP5oo0BjG9SF+reVGAe8BFLajDWfiSx+oE70x7jK
 K6O6+s=
X-Google-Smtp-Source: AGHT+IG4BUOzr4LL7DdJKTYcKlK9Lxy/dwlNK/ZMafCQ4ClOocumr77zcAWeYfoERZmbm3xMrgXnUa9IM4gw31DNdV4=
X-Received: by 2002:a17:903:41c2:b0:240:58a7:892f with SMTP id
 d9443c01a7336-245fec09768mr1663895ad.5.1755726084402; Wed, 20 Aug 2025
 14:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 17:41:12 -0400
X-Gm-Features: Ac12FXyXyDOlHseveDI6YUbW6zuwnPOP7BH9ZifjmL6RhUjuhLM35OI-FDc6px0
Message-ID: <CADnq5_P_KOT_e2mLp=mr0sNEYS_nhMDvNxLEvHUfQbakyGisdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] drm/amdgpu/uapi: add AMDGPU_GEM_DOMAIN_MMIO_REMAP
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Aug 20, 2025 at 7:43=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add a new GEM domain bit AMDGPU_GEM_DOMAIN_MMIO_REMAP to allow
> userspace to request the MMIO remap (HDP flush) page via GEM_CREATE.
>
> - include/uapi/drm/amdgpu_drm.h:
>   * define AMDGPU_GEM_DOMAIN_MMIO_REMAP
>   * include the bit in AMDGPU_GEM_DOMAIN_MASK
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This patch should probably also add a check to
amdgpu_gem_create_ioctl() which rejects the
AMDGPU_GEM_DOMAIN_MMIO_REMAP domain for now and then drop that in your
last patch.

Alex

> ---
>  include/uapi/drm/amdgpu_drm.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index bdedbaccf776..fc44e301adbb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -103,6 +103,8 @@ extern "C" {
>   *
>   * %AMDGPU_GEM_DOMAIN_DOORBELL Doorbell. It is an MMIO region for
>   * signalling user mode queues.
> + *
> + * %AMDGPU_GEM_DOMAIN_MMIO_REMAP       MMIO remap page (special mapping =
for HDP flushing).
>   */
>  #define AMDGPU_GEM_DOMAIN_CPU          0x1
>  #define AMDGPU_GEM_DOMAIN_GTT          0x2
> @@ -111,13 +113,15 @@ extern "C" {
>  #define AMDGPU_GEM_DOMAIN_GWS          0x10
>  #define AMDGPU_GEM_DOMAIN_OA           0x20
>  #define AMDGPU_GEM_DOMAIN_DOORBELL     0x40
> +#define AMDGPU_GEM_DOMAIN_MMIO_REMAP   0x80
>  #define AMDGPU_GEM_DOMAIN_MASK         (AMDGPU_GEM_DOMAIN_CPU | \
>                                          AMDGPU_GEM_DOMAIN_GTT | \
>                                          AMDGPU_GEM_DOMAIN_VRAM | \
>                                          AMDGPU_GEM_DOMAIN_GDS | \
>                                          AMDGPU_GEM_DOMAIN_GWS | \
> -                                        AMDGPU_GEM_DOMAIN_OA | \
> -                                        AMDGPU_GEM_DOMAIN_DOORBELL)
> +                                        AMDGPU_GEM_DOMAIN_OA | \
> +                                        AMDGPU_GEM_DOMAIN_DOORBELL | \
> +                                        AMDGPU_GEM_DOMAIN_MMIO_REMAP)
>
>  /* Flag that CPU access will be required for the case of VRAM domain */
>  #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED  (1 << 0)
> --
> 2.34.1
>
