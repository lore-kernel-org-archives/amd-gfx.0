Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2065C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B29710E789;
	Tue, 19 Apr 2022 14:49:42 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE3F10E306
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:49:42 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-e2afb80550so17765509fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UCQcrhnSU5LEstj8KBP5msxef1D1KyBqpWIXVkDLWhk=;
 b=CubJVl5MJdSL1so1ZayAwbcWccc8/lSj/ZovdhISlpq7cNdMrMIbL66tNA6pJJ2WMR
 qfksJ07A29ZAQjV6TzL6K4CkVIj3+IBRJIuEJirWz0wCCDLG7CZddRU/bwxNjJH14TNy
 1y1imPpkxwXO89vpEdQ7z1n53HhVyTJtUyaS/NhxbTde9I+GEtiTxhYWCIH9xCwIApCQ
 cDGT0RyCJI1gECccfgjUj7yoxnVmEIf8vqrTpqCFrpyby7e2Ny5XB5zljAgEM9zQobkI
 mt8o4TtnhdLZGWL3zNX9xPO9reyG6BZzv/tslzUjcaVjV3zUO+rjRA4FWw+apkZUdbI0
 5asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UCQcrhnSU5LEstj8KBP5msxef1D1KyBqpWIXVkDLWhk=;
 b=30CLYTS31bBlaT67gGw/FNxieSbQRDfJoLnkysqkTn/AL/raWvk1ZEykLrAC1m1f6J
 aJfJG8ovI5UxY2AEqUKvT+eD19wbJCZ+fOyX34Mr+JNmR0cbXMmg6mAm57GS1d0Ij8fb
 8zW34Y0DFf4DsXy8VhFFJMSs4p7PMvyE+vgNsCoNMhTRKnPMFstZ0DugWufWDmJ8Q97O
 q+gJdz3yvjJJQZdb/2AcKQAhsQVerA+r20YnXZU/MigtoQ/zCgw/4Y53DRXOWrGuduH0
 6sbzZ71e8wV0JV8t4MIqlCd3k8+6WQKLGbsWQn+vBR8fxxuaD+xMnEtsUZj2fUNDm7+9
 t/eg==
X-Gm-Message-State: AOAM531gyAAJrAWKAmbK5Ek+rEJ8SFZrqN7YVXBARjrfpTRFvhhHLW5D
 Zw3JvwhAuJxnHjwoMKp0YJ5e6QoVY0eAWUOmUwtxlbXm
X-Google-Smtp-Source: ABdhPJzjqf+aEmmAixBT4Hw+rbgPjqIjz7FWsPWWScJKt7IbCaxeiwT99ZSzo7Lg/dAVhq32oG8WSW77fHOeWB8qVlY=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr8057310oaa.200.1650379781425; Tue, 19
 Apr 2022 07:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220419141915.122157-1-christian.koenig@amd.com>
In-Reply-To: <20220419141915.122157-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Apr 2022 10:49:30 -0400
Message-ID: <CADnq5_Oy2LZ_dbYVYsi+UrQNpCGx+LPWeUcT2_D=-rWgeptuXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove pointless ttm_eu usage from vkms
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
Cc: Ryan Taylor <Ryan.Taylor@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 19, 2022 at 10:19 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We just need to reserve the BO here, no need for using ttm_eu.

Can you include a more detailed description as to why it's not
necessary?  Most of this code was copied from radeon originally.  Does
radeon need a similar cleanup?

Alex

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 32 +++++++++++++-----------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.c
> index 5224d9a39737..576849e95296 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -302,9 +302,6 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *p=
lane,
>         struct drm_gem_object *obj;
>         struct amdgpu_device *adev;
>         struct amdgpu_bo *rbo;
> -       struct list_head list;
> -       struct ttm_validate_buffer tv;
> -       struct ww_acquire_ctx ticket;
>         uint32_t domain;
>         int r;
>
> @@ -316,18 +313,19 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane =
*plane,
>         obj =3D new_state->fb->obj[0];
>         rbo =3D gem_to_amdgpu_bo(obj);
>         adev =3D amdgpu_ttm_adev(rbo->tbo.bdev);
> -       INIT_LIST_HEAD(&list);
>
> -       tv.bo =3D &rbo->tbo;
> -       tv.num_shared =3D 1;
> -       list_add(&tv.head, &list);
> -
> -       r =3D ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
> +       r =3D amdgpu_bo_reserve(rbo, true);
>         if (r) {
>                 dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
>                 return r;
>         }
>
> +       r =3D dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
> +       if (r) {
> +               dev_err(adev->dev, "allocating fence slot failed (%d)\n",=
 r);
> +               goto error_unlock;
> +       }
> +
>         if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
>                 domain =3D amdgpu_display_supported_domains(adev, rbo->fl=
ags);
>         else
> @@ -337,25 +335,29 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane =
*plane,
>         if (unlikely(r !=3D 0)) {
>                 if (r !=3D -ERESTARTSYS)
>                         DRM_ERROR("Failed to pin framebuffer with error %=
d\n", r);
> -               ttm_eu_backoff_reservation(&ticket, &list);
> -               return r;
> +               goto error_unlock;
>         }
>
>         r =3D amdgpu_ttm_alloc_gart(&rbo->tbo);
>         if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unpin(rbo);
> -               ttm_eu_backoff_reservation(&ticket, &list);
>                 DRM_ERROR("%p bind failed\n", rbo);
> -               return r;
> +               goto error_unpin;
>         }
>
> -       ttm_eu_backoff_reservation(&ticket, &list);
> +       amdgpu_bo_unreserve(rbo);
>
>         afb->address =3D amdgpu_bo_gpu_offset(rbo);
>
>         amdgpu_bo_ref(rbo);
>
>         return 0;
> +
> +error_unpin:
> +       amdgpu_bo_unpin(rbo);
> +
> +error_unlock:
> +       amdgpu_bo_unreserve(rbo);
> +       return r;
>  }
>
>  static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
> --
> 2.25.1
>
