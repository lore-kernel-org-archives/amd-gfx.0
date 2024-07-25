Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE26C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 13:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCB710E056;
	Thu, 25 Jul 2024 13:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BLAUkRAj";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7CB10E056
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 13:35:58 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7a1be7b5d70so700048a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721914558; x=1722519358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJrDzbxsRC26NiSFz0MxAiILQg90Iv2jiGaTPLtWYu8=;
 b=BLAUkRAjvGn5l9KabCnoDFB3H2YbDctJwSirW+kH89m46q/pd4Q8lqFdLZk16EjhGb
 yF2ckV+bfr8oD0SmWL2AYI4b0gVeoUcRLdTMq3Y6JvNbDXZOE+ILeYx1KmcExhk49fz1
 ey2oyBE30hXtW8HjRlM3eON+Yyy/BeM/jYFSFqVXRF/8TqeoD3wK0dTfx8FpOitSMsTX
 IggqdSu66bG19nZxzQkIvdVzmoHsbrXcZu4xdg7uYu5pu5NgDgKTwKBmRWRaxFF1LPzi
 1TkXpPn1SZyBQI3LOTmMnn2349n0ZQjEIN94VIEUaB7Fiy7SRSmAEsaMFWrGUXnLWXv5
 635Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721914558; x=1722519358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJrDzbxsRC26NiSFz0MxAiILQg90Iv2jiGaTPLtWYu8=;
 b=NsYvvmgP09zFdt1Js8aPhwJ0tWZkIaH8mde19aQZ/VJ4OTB5paH3mDQx25dsl7vocD
 CdldIjs3Y1vOB47gUoDsDYU3eRGdTItx7wv2yVDvEjiqD9Xj4GoVUcPW8j7cRm23nKng
 eOHdqWAb+X4hHhpShOap8dpoozIHnVQV1JZ0txb7CM/Cwx2fkZbK8aKrwwEBG0MbbBbk
 P2WfAAtsJ12mLEuGqjc1nktSIZGr0O6OWm/i22/Xw07DL+YwR6VeP8L+QIiS+RTr8oFZ
 nc6evOmoe4pt32F+XJwMP2PsE9Dhh0cehetf+Ijkcj8Zl39h1Wq48byQ9pdma3/4Fz2P
 crEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFdCQ2MO2gxFlT8cyFwzKGmbswk9iZBOg/+CR8tBEVg3Kn4gDgQcoQPCDfMlm6qCUihn9Mbd6bzhX18PA6IAhoIZ24kxpxz3d0s1WsWg==
X-Gm-Message-State: AOJu0YxfBKWEUq6aLpIxFYCF1+W2grHUkASTShxjJnj8VtO6s6XguNVp
 NxkV+R/3ll6X75dEj4ClY5/VmYHAqFqkb7Y74X9YYCiZptD8aPbhlG5NonPYZ04wLyj8kOpbjUP
 6Ma5qCuTYuRE1UKcwj1PMrzY9w8oXOg==
X-Google-Smtp-Source: AGHT+IESp3graFZR9HpLXD9SmXF13ZAwlJDVVEZtowRzmeQFnEMgsTHSfcRnNFXyrc7/rNF5tsxdqALPZ7HREC9rl/k=
X-Received: by 2002:a17:90b:33cb:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2cdb9443005mr8775089a91.15.1721914557994; Thu, 25 Jul 2024
 06:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240725080750.183176-1-christian.koenig@amd.com>
In-Reply-To: <20240725080750.183176-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 09:35:46 -0400
Message-ID: <CADnq5_Of6-Lm-riL_Ea7DAwpjHmaFrmfCav=x0ukLJseP5NFHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: airlied@gmail.com, amd-gfx@lists.freedesktop.org
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

On Thu, Jul 25, 2024 at 4:07=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise we won't get correct access to the IB.
>
> v2: keep setting AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS to avoid problems in
>     the VRAM backend.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3501
> Fixes: e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")

Cc: stable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index ec888fc6ead8..13eb2bc69e34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1763,7 +1763,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser =
*parser,
>         struct ttm_operation_ctx ctx =3D { false, false };
>         struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_va_mapping *mapping;
> -       int r;
> +       int i, r;
>
>         addr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> @@ -1778,13 +1778,13 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parse=
r *parser,
>         if (dma_resv_locking_ctx((*bo)->tbo.base.resv) !=3D &parser->exec=
.ticket)
>                 return -EINVAL;
>
> -       if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
> -               (*bo)->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -               amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domai=
ns);
> -               r =3D ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ct=
x);
> -               if (r)
> -                       return r;
> -       }
> +       (*bo)->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +       amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
> +       for (i =3D 0; i < (*bo)->placement.num_placement; i++)
> +               (*bo)->placements[i].flags |=3D TTM_PL_FLAG_CONTIGUOUS;
> +       r =3D ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
> +       if (r)
> +               return r;
>
>         return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>  }
> --
> 2.34.1
>
