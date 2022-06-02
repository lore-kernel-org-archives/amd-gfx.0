Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F302FC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C234113143;
	Thu,  2 Jun 2022 16:54:39 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D1C113143
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:54:38 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-f2bb84f9edso7442308fac.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uKy6NGcMex8K+xZxTDbxq0Qid5sHRyh4SH6lUclEbOc=;
 b=lPOol9QjY5Tup2k0HI/6kYbDD2o0kSkWC9tQsAHNCuxskkTiAygUkIf1Dlm+HX6ITQ
 8W+VZ8QQ4Rbvd73hqRTQs6Fjlr/yie36M8+NOX0REUiXMoM5Zpl8LSX7DILbhkIKAUs6
 qNIgZE5xegpgMm2EtlYjG9M6Om7/twzbIiLYh4WAiwPdVOBpcuC5DIF5yVJ+B1mf0uLD
 9EluDogAOsv8J3tk8mZonTYwDIs8BThXsnfVlqZe/mKlG8bGs/Hh7wTZYk6rdxYaLgDk
 HFmnwh40NE1bJo0vlZxyuF/Pq0wR4VrhP9b9XPl8yGBYh8A1hjl6sPewjBa+ssRaS2Vo
 SRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uKy6NGcMex8K+xZxTDbxq0Qid5sHRyh4SH6lUclEbOc=;
 b=0v1pwn8k8/lOPb8ZBmsV+6WIEPt18VRrXUrOWPtdZuTxVlW+ESslvi3dmr5PJePXMc
 W89TyWOUUbBJHXeOhILG0wn92jMELNNx56K7pCdhgykVakkkos25KIWVfLo3loKmuAvu
 9Ra6ab9ev08ufHP/zWXyvwGCle0wtk39vwFIsGPy7mK+d5FjkglxxOzAd0TIYjB5fK1E
 lE+OzajFID6gOX6nQOKD57URYlvIskfYRk7F6ZFzDXZKPgsKGsgS3JJCWN/6MDKbFQsw
 KEmYnDWyJnSoMKUtB5GXuRJoyQwrfc8Mhgv5Ey+mJi3MGrV/Fz9XpQPEYGe7uvFcVnxW
 wQqg==
X-Gm-Message-State: AOAM533fjVdgmo4sB5bd2qQBSNWNq0VK2C8uC9EnWV+HaP7R7zn2gP/m
 Zr/WpadUCrfBIpr81hLHU60DbH++cFYmnauDvm9YzJys5Es=
X-Google-Smtp-Source: ABdhPJwGIKSbvVBkFgLFcH1Kz87MQdd0o/qUnyIcqhpMgyPY4A4MffwC+QzE/chOYdMu11cDh5mQ8cpm6fZ+LoS5h34=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr3339500oap.253.1654188877443; Thu, 02
 Jun 2022 09:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220602154734.7854-1-christian.koenig@amd.com>
In-Reply-To: <20220602154734.7854-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jun 2022 12:54:26 -0400
Message-ID: <CADnq5_MopB5aUpzo_iWz5TXbxAxYXttm8L6L_SwFayUPEyZxhw@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix bulk move handling during resource init
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Mike Lothian <mike@fireburn.co.uk>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 2, 2022 at 11:47 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The resource must be on the LRU before ttm_lru_bulk_move_add() is called.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

This should at least fix the null pointer in these bugs:

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1992
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2034

Alex

> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> index 65889b3caf50..928b9140f3c5 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -169,15 +169,17 @@ void ttm_resource_init(struct ttm_buffer_object *bo=
,
>         res->bus.is_iomem =3D false;
>         res->bus.caching =3D ttm_cached;
>         res->bo =3D bo;
> -       INIT_LIST_HEAD(&res->lru);
>
>         man =3D ttm_manager_type(bo->bdev, place->mem_type);
>         spin_lock(&bo->bdev->lru_lock);
>         man->usage +=3D res->num_pages << PAGE_SHIFT;
> -       if (bo->bulk_move)
> +       if (bo->bulk_move) {
> +               list_add_tail(&res->lru, &man->lru[bo->priority]);
>                 ttm_lru_bulk_move_add(bo->bulk_move, res);
> -       else
> +       } else {
> +               INIT_LIST_HEAD(&res->lru);
>                 ttm_resource_move_to_lru_tail(res);
> +       }
>         spin_unlock(&bo->bdev->lru_lock);
>  }
>  EXPORT_SYMBOL(ttm_resource_init);
> --
> 2.25.1
>
