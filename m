Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BAAC3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 13:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9B910E0BB;
	Wed, 24 Jul 2024 13:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QFpMEKZN";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF36810E0BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 13:32:50 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-79b530ba612so768214a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721827970; x=1722432770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UDcxaWoZLc5gNpyjAOhd/6ZbojKSLZVZkKqLfzqil0=;
 b=QFpMEKZNY7+YNgZMZJzMBmpOiM+4L+fvSRyIT2KoOXXIBv0uXc6e0dCiYCAs5UB//f
 twxYfDCR34hp64oUwI0bu/JQUg4OxzhPl2UL9m2xuRehpBGLcZMTjbhrmk+gK4hxd/0Z
 +MbCnNxpC61NypAops7iWeeqzzlNCpPgtOOxOG8oabc8fajLg9rbJvJxyKWxR/dDHrIm
 DsA1MTDwLXPay5BRZWKQqCL22VfNA1WHY1USkuwHxvez9DFe9oLMUmbGIHteg+RA89YA
 rwC8G3JU4EFnu4wvLFXhfwZZdmOmaqV3RIoyPrBhhmu0jttdpu/petk1QZYeFnP2pCee
 hK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721827970; x=1722432770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UDcxaWoZLc5gNpyjAOhd/6ZbojKSLZVZkKqLfzqil0=;
 b=h7I/1762Qstby+eZrMfP0Rd8SJ41LaouAGvLHfV3ob7/DdoxTyn1MdaenByHiHFR/e
 NUNlxKcPEifDhRM8//apWT9+uRNV1Bl2gmw1mk+ERXLJhRnS/UeIChhX7/0nBd28uOmI
 z2W+o2Zsa1XMxBJfdX5MaA8w5O3XyB68whNES6KOLkiad1g4HAvYiRU1C2xgWcyuFQnI
 LkrzIZj2G9K5oopOJHOHFuZj6OdwJWlvfsFkQCb8/hxPFazShefO3sSC4MdRwiNhCZF5
 6x1sPrubpBMGGn+AjHWiypmnTSA3tIVc14Vi05+vX7YPhInVzGcYr/x9o4UAysSEaNBm
 c56A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDEG7ZUnazD0na4JeSpSlv+k63X+Wn/DLy/qMVS3fvKDMjL3vr2pmixNScqIO09MApQEUZyKl6/Zq3CIwBtVpLtGlxYls7CWFozHgX5Q==
X-Gm-Message-State: AOJu0YymdqWwVRthsjMOV9PdkaDyIpq8u3jqj0GiXpaMFNH0I4Vi3pOO
 DpkzE8CE4FtC0jNOZrJvUDAap+u9uAeUHSl/rGpcdvRveO3KgHp/ZR1AZzGZcIU6KcbVGC2GUDG
 YlzfA7IgJnMXQ+WH+5UVfM9tYvjb785+l
X-Google-Smtp-Source: AGHT+IGqyju6LP6NTLxGoxqGRt88jtMouFyjzJg1LlAHD56avFzDHaOyAah5MAGwFJnbPPAjD6yHVRVKkDuqzm4/zNA=
X-Received: by 2002:a17:90b:3e84:b0:2c9:6b02:15ca with SMTP id
 98e67ed59e1d1-2cd161ca95dmr11140078a91.39.1721827970087; Wed, 24 Jul 2024
 06:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240724075047.57198-1-christian.koenig@amd.com>
In-Reply-To: <20240724075047.57198-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jul 2024 09:32:38 -0400
Message-ID: <CADnq5_PM6kfgYEgJmoCFXD8Rpiy2xqHzgy0Q=VLZejwpJ_ZAJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing
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

On Wed, Jul 24, 2024 at 4:00=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise we won't get correct access to the IB.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3501
Fixes: e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index ec888fc6ead8..41055224930f 100644
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
> @@ -1778,13 +1778,12 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parse=
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
