Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D44C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 21:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85AC10EF19;
	Mon, 27 Jun 2022 21:31:01 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B2A10EF19
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 21:31:00 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id eq6so14869350edb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WOazrAXV3Z6CU6TB2nh+hFxOT/o3x/qUKCZiPzVFloI=;
 b=mEuQIn+rwOIq6o9O9xDFFWDGDSWeDGx5dxvM8Q2VBpdVOJpChCK4TTWZAcjKdyet/a
 9KupwKYbkk5e4m8zeS46ZvXTic0M9hgb8IwBXffM9DnH3PbVTabEh92RWpIgLinzieYA
 mJ0ly4ksgW6N7zbAmhKN6FSgsh1R01bySHnloGRbKb2uYvZ6CqvyAJ0M52Ss/FXlZPL7
 oiwLl+SqapVC4k6bxJKvR8AH6yOjCZOY6iOs2m8Csnkm9roDDgI8eqtrKChEEFDHlp/h
 dtuCrsZ1v65F/ABkyTSeQ5dmgP5TNr5qetQMHn4ybYEgxLEUcM9kdq2oL89bzjO0Q/vn
 vRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WOazrAXV3Z6CU6TB2nh+hFxOT/o3x/qUKCZiPzVFloI=;
 b=Ff4AUi0nTPHyqy/V37NybnysiAy1EIRCjsAxM3XIYZoS7pVLJRtNKja4V59xKM9/M8
 sVEkZCTTRtBtPxS739/UcNH5KXXfMXjdhhAVr5aGKHWWD+vLzp8Rk/3IglzWI9VZBf06
 meMElO1O81sjrDTzOJUDe8Ghkc/zILpryguWDUnQJ0D+4xH9H5bs5J5/8couZ7+/TgtX
 qSG3Vu/XTgXB7h32fLYBC04xcSA/cCXWxgSscDrGNNjiOA6LTQ0p7yakFjC4QQdPW3ZV
 4Yh2lPZgDFFsIZ/d9DQgOqlEp8doCKNctaCsU6XAKcTBdAbLklmw72wx2Vx3IdEyVuAB
 XKxA==
X-Gm-Message-State: AJIora8CUBnMh6F9OgNc3YM0nHLoMUxBTYjR7QnmY8yIYOKTLyjwqU7U
 2fd2PG5A6tVopD43mw6kqPslop+L2ISw1Tby8mvg6PVjDVs=
X-Google-Smtp-Source: AGRyM1tqGuTxuyylxrrLIdYd4L5stxB8yxXyTbLck63YRoFPh63pM+o6P0J6hnnGbWw4lwERSrRbC6CbbBy1Dj20taw=
X-Received: by 2002:a05:6402:158e:b0:435:7d0f:ac85 with SMTP id
 c14-20020a056402158e00b004357d0fac85mr19070968edv.93.1656365458920; Mon, 27
 Jun 2022 14:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <62d06aef-ff23-93a3-dc36-c4840b1f6d80@amd.com>
 <20220621144227.664800-1-luben.tuikov@amd.com>
In-Reply-To: <20220621144227.664800-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jun 2022 17:30:46 -0400
Message-ID: <CADnq5_ORKFBJi27b4z_U4rCOwSaCd--xMLdtcAPaN_j2Xzy3Pw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: remove ctx->lock"
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 21, 2022 at 10:42 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> This reverts commit e68efb27647f2106d6b545667f35b2ea39746b57.
>
> We see that the bo validate list gets corrupted, in
> amdgpu_cs_list_validate(), the lobj->tv.bo is NULL. Then getting usermm o=
n
> the next line, references a NULL bo and we get a koops.
>
> Bisecting leads to the commit being reverted as the cause of the list
> corruption. See the link below for details of the corruption failure.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048#note_1427539

Looks like this bug is also relevant:

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D216143

> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>  3 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 36ac1f1d11e6b4..e619031753b927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -128,6 +128,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>                 goto free_chunk;
>         }
>
> +       mutex_lock(&p->ctx->lock);
> +
>         /* skip guilty context job */
>         if (atomic_read(&p->ctx->guilty) =3D=3D 1) {
>                 ret =3D -ECANCELED;
> @@ -585,16 +587,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_par=
ser *p,
>                 }
>         }
>
> -       /* Move fence waiting after getting reservation lock of
> -        * PD root. Then there is no need on a ctx mutex lock.
> -        */
> -       r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> -       if (unlikely(r !=3D 0)) {
> -               if (r !=3D -ERESTARTSYS)
> -                       DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n")=
;
> -               goto error_validate;
> -       }
> -
>         amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_thresh=
old,
>                                           &p->bytes_moved_vis_threshold);
>         p->bytes_moved =3D 0;
> @@ -722,6 +714,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_pa=
rser *parser, int error,
>         dma_fence_put(parser->fence);
>
>         if (parser->ctx) {
> +               mutex_unlock(&parser->ctx->lock);
>                 amdgpu_ctx_put(parser->ctx);
>         }
>         if (parser->bo_list)
> @@ -965,7 +958,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *ad=
ev,
>         if (parser->job->uf_addr && ring->funcs->no_user_fence)
>                 return -EINVAL;
>
> -       return 0;
> +       return amdgpu_ctx_wait_prev_fence(parser->ctx, parser->entity);
>  }
>
>  static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
> @@ -1384,6 +1377,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 goto out;
>
>         r =3D amdgpu_cs_submit(&parser, cs);
> +
>  out:
>         amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 53f9268366f29e..2ef5296216d64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -286,6 +286,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr=
, int32_t priority,
>         kref_init(&ctx->refcount);
>         ctx->mgr =3D mgr;
>         spin_lock_init(&ctx->ring_lock);
> +       mutex_init(&ctx->lock);
>
>         ctx->reset_counter =3D atomic_read(&mgr->adev->gpu_reset_counter)=
;
>         ctx->reset_counter_query =3D ctx->reset_counter;
> @@ -400,6 +401,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>                 drm_dev_exit(idx);
>         }
>
> +       mutex_destroy(&ctx->lock);
>         kfree(ctx);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.h
> index 0fa0e56daf67e9..cc7c8afff4144c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -53,6 +53,7 @@ struct amdgpu_ctx {
>         bool                            preamble_presented;
>         int32_t                         init_priority;
>         int32_t                         override_priority;
> +       struct mutex                    lock;
>         atomic_t                        guilty;
>         unsigned long                   ras_counter_ce;
>         unsigned long                   ras_counter_ue;
>
> base-commit: f4b3c543a2a759ce657de4b6b7e88eaddee85ec2
> --
> 2.36.1.74.g277cf0bc36
>
