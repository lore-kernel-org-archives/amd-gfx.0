Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCD0C71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8408B10E1FD;
	Tue, 29 Aug 2023 14:05:19 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658D110E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:05:17 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5735282d713so2339035eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693317916; x=1693922716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/hN1bcLwZKawWV6EKsAyiZW7JOBXpVgstk2qqWjRkY=;
 b=o1LheyVQKU11ukOGcDXQRQKPzLVZUWy9de6y3O3vmJsg1Wwnl0gj9+8XLRToYFasTl
 yo8qPzOySxiCbU5+z/gl3zhHVOxXyDd1tgymhl2NEMOqbF60YxtFvGB4Sz8XGgpJzTtc
 Rs7qG6dmZH0wzl/N5dweIC4YvDSR2f9scdwMMZxyJKVBVe9+PhJSwBHvhK3qTJV9/JmO
 9cmwO0/LuFiEanizfLwh0jNjhwFq1tK5btz3ty4Ci6o0/gsErcKXmVjP81VFK93Afy7q
 KzznPe4/8BzZ/bObN0DMRKTS29c1wv0gitH9h4Bf/xdHo1moHU/wlDxplr/F6P4hp0xM
 E6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693317916; x=1693922716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/hN1bcLwZKawWV6EKsAyiZW7JOBXpVgstk2qqWjRkY=;
 b=GEBLZAotjsol6nz6yW8CIXWp61uRWXGC4sgaHTIRO5JvnKGEIMulTjDbX3XOpq3JY5
 jnzKvYureJRe3BB9FKHnzcBXm82yqTo59ZYP9Dhv5E1NrpqoltQOSnfo2HTGJ7GA0miQ
 MEUJG5cEYrDfSvQnLaD4K6NLcJkmaBLhvIijcdk1jkEzHG2Qp3A6YtosT2kJ5LysofFI
 vB9hIloxqr8B+cT2jRhxVtFW6CcVjjv0OzUFnEbqFkOJCoJj/Jv2snXEfmTyxYL2l/jV
 Xn/VV12DGZZPjeH+z5qQL+rlX4SrR9DCUzbaqmCCAQVwaDjqjlb6ieSk+140lNvPuQy4
 N7Ew==
X-Gm-Message-State: AOJu0YzbJiokE4W7ihvtnu7z6SlkUnAD1DvxWuubzUBoQlQ+kNeqEmb0
 b5DN4hZQzBo45yaWEvquQBZLDDixHKHxUlTNClx8gyZU
X-Google-Smtp-Source: AGHT+IFbV3/PLu4vYRZ5T1N5/ssMtXrPUnNvgje8xjh6hLNkD1cRpRsPGmgofW/fVw4hPmI2cyCq2QiJoIDPJcjIPaI=
X-Received: by 2002:a4a:3457:0:b0:56c:7428:4a35 with SMTP id
 n23-20020a4a3457000000b0056c74284a35mr16346281oof.7.1693317916423; Tue, 29
 Aug 2023 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230829112050.4024-1-christian.koenig@amd.com>
In-Reply-To: <20230829112050.4024-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Aug 2023 10:05:05 -0400
Message-ID: <CADnq5_M9max+b8ZXFgXYz8GLKcRRV-eLozXzFz2NwHc0ON5FqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_cs_p1_user_fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 29, 2023 at 8:00=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The offset is just 32bits here so this can potentially overflow if
> somebody specifies a large value. Instead reduce the size to calculate
> the last possible offset.
>
> The error handling path incorrectly drops the reference to the user
> fence BO resulting in potential reference count underflow.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index f4b5572c54f2..5c8729491105 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -139,23 +139,14 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs=
_parser *p,
>         drm_gem_object_put(gobj);
>
>         size =3D amdgpu_bo_size(bo);
> -       if (size !=3D PAGE_SIZE || (data->offset + 8) > size) {
> -               r =3D -EINVAL;
> -               goto error_unref;
> -       }
> +       if (size !=3D PAGE_SIZE || data->offset > (size - 8))
> +               return -EINVAL;
>
> -       if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
> -               r =3D -EINVAL;
> -               goto error_unref;
> -       }
> +       if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
> +               return -EINVAL;
>
>         *offset =3D data->offset;
> -
>         return 0;
> -
> -error_unref:
> -       amdgpu_bo_unref(&bo);
> -       return r;
>  }
>
>  static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
> --
> 2.34.1
>
