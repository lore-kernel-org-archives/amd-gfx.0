Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA625C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F3F10E083;
	Tue, 10 May 2022 14:39:44 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1326110E083
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:39:43 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id r1so18724080oie.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5ymiU19J91DnU/NWdpCn6lAoVXbZqkxU1rDDwwqvXsI=;
 b=avTZtCmCje5g/DUfFrql9z7xInq2XDER2j8SUoB3JyXOtwbctPEP0BRFnj9ATrkKp7
 ZV9/Irbv3yqISs5nm/rlkwzetrBPS0Y3aEPCT8MwS2maVoDSHhBuvdXjb6EVEcRZAoZP
 7R+cgUpFvSVKuiqROPFifWbChcGNh1cgtIoaTGYhdArKZDflmtxPdftYjoZF2D5CWb7x
 B+2eM43Ubj0WSDU9FHQ3fcjrwWTrYdrjFrq2fHfsYWskVlYYpr7+16uUJ+LyupPxFMeA
 ZLOO1YfRP/MTGexMxIEV9nUQQtUvvaHTcKoy86JLh+4afA8PCbDKv5gNwLPbb+5S8sPN
 DMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5ymiU19J91DnU/NWdpCn6lAoVXbZqkxU1rDDwwqvXsI=;
 b=aXZ58+bNnklr70wn4jQWKeQsu2oaa1W8ICcdN17K4iMTIy5WbkxxJRygFLUqG/xAsk
 1T2tN7PVR8IqWhrehIlaA4iPoGcNju5AkMKJfoe8F/4mjhPBSYwCRQjl5wfozkWQtbuP
 ETDTk+6arULgepmYrsi90UfBX8lDz891uGV7EFH29eWM/uLnwtnsSgJXo/D9JtZf7w49
 HNZewhKNran2L3ZyKW0iQ2tRMDFO8gaF77A56ATey+Ku30o/uW6xqPt48Azmuh3JFAfw
 Ghppdb6KMDb/Q+AC7SDBbX/Fj9PA6foUsx14VQj8OFUnWidoXumoh6afDKpTwo8fvZG7
 crxg==
X-Gm-Message-State: AOAM530xmxZJbs4wOoTlSKZJ2yU4XoNZvy4gRKTL03reWLvdblt8E8FZ
 aW63d84p6PHkBtP0JQqfr5+BL5ykWGVQLxjC89c=
X-Google-Smtp-Source: ABdhPJyylVtNv31nD/52DMYFu+e7/nxhAVZdh2Kmp/qPztNo0Zs4qVSXQIt6tv62/57LDftTQc5CS+Rz1hfbGlJBUZI=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr177629oiw.253.1652193582394; Tue, 10
 May 2022 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510113649.879821-1-christian.koenig@amd.com>
 <20220510113649.879821-2-christian.koenig@amd.com>
In-Reply-To: <20220510113649.879821-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 May 2022 10:39:31 -0400
Message-ID: <CADnq5_MQZJ1MjQvYHE1j_jrHd4yyjgzOi3zfXE1Mbe8+TO1D2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: move internal vram_mgr function into the
 C file
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <arunpravin.paneerselvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 10, 2022 at 7:36 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> No need to have those in the header.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 27 ------------------
>  2 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 51d9d3a4456c..7a5e8a7b4a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -50,6 +50,35 @@ to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
>         return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
>  }
>
> +static inline struct drm_buddy_block *
> +amdgpu_vram_mgr_first_block(struct list_head *list)
> +{
> +       return list_first_entry_or_null(list, struct drm_buddy_block, lin=
k);
> +}
> +
> +static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head=
 *head)
> +{
> +       struct drm_buddy_block *block;
> +       u64 start, size;
> +
> +       block =3D amdgpu_vram_mgr_first_block(head);
> +       if (!block)
> +               return false;
> +
> +       while (head !=3D block->link.next) {
> +               start =3D amdgpu_vram_mgr_block_start(block);
> +               size =3D amdgpu_vram_mgr_block_size(block);
> +
> +               block =3D list_entry(block->link.next, struct drm_buddy_b=
lock, link);
> +               if (start + size !=3D amdgpu_vram_mgr_block_start(block))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +
> +
>  /**
>   * DOC: mem_info_vram_total
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.h
> index 9a2db87186c7..4b267bf1c5db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -53,33 +53,6 @@ static inline u64 amdgpu_vram_mgr_block_size(struct dr=
m_buddy_block *block)
>         return PAGE_SIZE << drm_buddy_block_order(block);
>  }
>
> -static inline struct drm_buddy_block *
> -amdgpu_vram_mgr_first_block(struct list_head *list)
> -{
> -       return list_first_entry_or_null(list, struct drm_buddy_block, lin=
k);
> -}
> -
> -static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head=
 *head)
> -{
> -       struct drm_buddy_block *block;
> -       u64 start, size;
> -
> -       block =3D amdgpu_vram_mgr_first_block(head);
> -       if (!block)
> -               return false;
> -
> -       while (head !=3D block->link.next) {
> -               start =3D amdgpu_vram_mgr_block_start(block);
> -               size =3D amdgpu_vram_mgr_block_size(block);
> -
> -               block =3D list_entry(block->link.next, struct drm_buddy_b=
lock, link);
> -               if (start + size !=3D amdgpu_vram_mgr_block_start(block))
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
>  static inline struct amdgpu_vram_mgr_resource *
>  to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
>  {
> --
> 2.25.1
>
