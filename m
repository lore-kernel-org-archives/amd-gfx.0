Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDB8C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD20910EA28;
	Thu, 28 Aug 2025 15:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Db+2ohBG";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF0F10EA2E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:21:57 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-24602f6d8b6so2122775ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756394517; x=1756999317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mgLasBJMgSr0MscplszZsgkp+69oQSfdSjqVgss748=;
 b=Db+2ohBGdVoBQv7yovQcG+UOJvqviusBas4TAxuSSWoBWwMNVDZUdlF5VEKl/kCSkw
 XPeKJyXwY54N/zjGzutYxtKgvaZfIIkE5cn/7tpT86jnRhF2gzFDod+4yUPXziUnUW4C
 HRbddn1mZlOB2bEpRt0LCUF64iAyOQqBwWJxjvuWp6ZIakvGjby+WuJihz1YWJ10mIQk
 yOHg62/DTb7rEDoY7OAFGVIi73q1SAyLj/R67IavOWuKUgRv2TwQwbJEovybSanHR3zb
 7Ax7ygeZbUDFFYUtIPWj+VrB14kiwugPyTdHAparFWvP6RRYANeLgHgvkQHY1GfqpVHM
 0qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394517; x=1756999317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mgLasBJMgSr0MscplszZsgkp+69oQSfdSjqVgss748=;
 b=BCgJ1s9auR1X32Tpx5d4mKzJDjVXw2SdySrT3IlOF8cSFr0QdclaxeAa+KAdPPpJDv
 AR7WTRIV6Q1XBjvXpASiOpAvtuUtY+v4iYcxGE5zhdPLG+ZSLDd3ko2AuJO2gtx7k++g
 AjpvrS3YsCfS5VvO1koTtTbDR5Hl1/fogp4uK4TqXrbqfxvu42b9C7GlO7/hAcBj67WD
 +kbEEmnjFP7QBcawPVIEZsX9JqOF03Pj20qJOOXKycmodZITLGdS7kZSg5UAlPu/0wG/
 8bjGFScchZLrqExRu5coLqq5I+bBbdkKhDPUsm287cQNsHQWUp5LfHDo3XGAe0eUl52/
 QPag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk5R1JXLxdMz5PkNv17IjvtzKaHXnGzvTX5WlSbEXqR8l7AlLEXVuLppLJaZ+vH4G5Wtw9UuWl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztSvJzrIUN6lW5TVCQMdjxrhHVRWH46PMo8lg/KS8UMj1f+1j2
 d4JxQsO35Bkmhvv7NN1FVue39DdjNRj/He3ULSYC6wIrbY56i2TtceYp/ZA/N5fG3IB4bRnf7x/
 CL2XCy+fgqhPFYuf/mLCxqmaUriTcH+ts8KQ/
X-Gm-Gg: ASbGnctJWlUl4Shj5eJvuqkqy+kamlMj1bsic+BHyqxG1llVUgWNb63A744r0dKG1od
 wmAHyec7nHhxfpM7cATR12y1L+p7QkTQv+fD03KDASFF0FNgAzxXoELNOKIejR/0eitWJ/5P+wy
 m54QxCKjNlm8jP6KXySb2wXdh8x998gvW3K1FYqlczdy7B/Fvb/LYeG+OJc4Yev56qMgYYYwrY7
 7fgBaPj2veNynRZ7w==
X-Google-Smtp-Source: AGHT+IHdJpf77TzISe92pZmg6wLeQjWPFQL1v0XXXNF+iP7QBhHDjkmzayYR9g5YPQI5xWPFUMGmEk91yBH6Y0EWLCg=
X-Received: by 2002:a17:903:2303:b0:248:8a31:bf6f with SMTP id
 d9443c01a7336-2488a31c353mr67032865ad.4.1756394516619; Thu, 28 Aug 2025
 08:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
 <20250828064530.3948378-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828064530.3948378-5-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:21:45 -0400
X-Gm-Features: Ac12FXzPznnky4fCAfffgt2gUnrcOdbAv-MHt7C712hAsJ7d8B-0Qxl58QhQ1T8
Message-ID: <CADnq5_PsnHHz3C7gjDrH58u00OEJQzuUDfv6jYVRynjkJSksqQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
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

On Thu, Aug 28, 2025 at 5:33=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Wire up the conversions and strings for the new MMIO_REMAP placement:
>
> * amdgpu_mem_type_to_domain() maps AMDGPU_PL_MMIO_REMAP -> domain
> * amdgpu_bo_placement_from_domain() accepts the new domain
> * amdgpu_bo_mem_stats_placement() and amdgpu_bo_print_info() report it
> * res cursor supports the new placement
> * fdinfo prints "mmioremap" for the new placement
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>  4 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_fdinfo.c
> index 91d638098889..b349bb3676d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -70,6 +70,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct d=
rm_file *file)
>                 [AMDGPU_PL_GWS] =3D "gws",
>                 [AMDGPU_PL_OA] =3D "oa",
>                 [AMDGPU_PL_DOORBELL] =3D "doorbell",
> +               [AMDGPU_PL_MMIO_REMAP] =3D "mmioremap",
>         };
>         unsigned int hw_ip, i;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 122a88294883..fe486988a738 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -153,6 +153,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_b=
o *abo, u32 domain)
>                 c++;
>         }
>
> +       if (domain & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +               places[c].fpfn =3D 0;
> +               places[c].lpfn =3D 0;
> +               places[c].mem_type =3D AMDGPU_PL_MMIO_REMAP;
> +               places[c].flags =3D 0;
> +               c++;
> +       }
> +
>         if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>                 places[c].fpfn =3D 0;
>                 places[c].lpfn =3D 0;
> @@ -1545,6 +1553,8 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgp=
u_bo *bo)
>                 return AMDGPU_PL_OA;
>         case AMDGPU_GEM_DOMAIN_DOORBELL:
>                 return AMDGPU_PL_DOORBELL;
> +       case AMDGPU_GEM_DOMAIN_MMIO_REMAP:
> +               return AMDGPU_PL_MMIO_REMAP;
>         default:
>                 return TTM_PL_SYSTEM;
>         }
> @@ -1628,6 +1638,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *=
bo, struct seq_file *m)
>                         case AMDGPU_PL_DOORBELL:
>                                 placement =3D "DOORBELL";
>                                 break;
> +                       case AMDGPU_PL_MMIO_REMAP:
> +                               placement =3D "MMIO REMAP";
> +                               break;
>                         case TTM_PL_SYSTEM:
>                         default:
>                                 placement =3D "CPU";
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index 87523fcd4386..656b8a931dae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -167,6 +167,8 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 =
mem_type)
>                 return AMDGPU_GEM_DOMAIN_OA;
>         case AMDGPU_PL_DOORBELL:
>                 return AMDGPU_GEM_DOMAIN_DOORBELL;
> +       case AMDGPU_PL_MMIO_REMAP:
> +               return AMDGPU_GEM_DOMAIN_MMIO_REMAP;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_res_cursor.h
> index 50fcd86e1033..be2e56ce1355 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> @@ -91,6 +91,7 @@ static inline void amdgpu_res_first(struct ttm_resource=
 *res,
>                 break;
>         case TTM_PL_TT:
>         case AMDGPU_PL_DOORBELL:
> +       case AMDGPU_PL_MMIO_REMAP:
>                 node =3D to_ttm_range_mgr_node(res)->mm_nodes;
>                 while (start >=3D node->size << PAGE_SHIFT)
>                         start -=3D node++->size << PAGE_SHIFT;
> @@ -153,6 +154,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_=
cursor *cur, uint64_t size)
>                 break;
>         case TTM_PL_TT:
>         case AMDGPU_PL_DOORBELL:
> +       case AMDGPU_PL_MMIO_REMAP:
>                 node =3D cur->node;
>
>                 cur->node =3D ++node;
> --
> 2.34.1
>
