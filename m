Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63654C00E86
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044E410E50D;
	Wed, 20 Sep 2023 15:26:22 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A8110E50D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:26:20 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bf038b8f87so550739a34.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695223579; x=1695828379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDwAgO/nD+EHJsFcagvtt3M6YddBMxekDDPaCdbxQWY=;
 b=i2ru4ixi7L6WDUj7FpGVoxxbKrcGdjl/Wqzzkwu2UDOmfhaE0G2wo+4rRaXGknG59G
 vCIohcUCet8zAbylH45thBgAXN2dt003+vn+TBcwIGtDzn31iPlXOUw3MJl4sex7bpfn
 l+/v7daozm7SbULDZ7GhAX0C3pwx2Ta9LGTYijNP596OeUWYLtjfPjoF0ljlghzAiv1h
 t/+gjASZcn6uSrfgBr4a/CcvsS0ijH8mI1CthRgmcDBfDS+uDWIs4P749qzb7H4alljp
 6ylijJB2KCtq4TSbbD30enL215TT+AaiWcaJSPVc8fiNPQDbZcOtb1mTNkvIm103FmI4
 uh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695223579; x=1695828379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDwAgO/nD+EHJsFcagvtt3M6YddBMxekDDPaCdbxQWY=;
 b=QzQJTey2bR2JV5JR5T/MJ4lgKj4NDPQmHS22JMH1lYbnhcqhia422HMVqMgFWgoj4f
 CMOisZbLdqwcEprk0vZa3rEiqn5pde/GdzEMjELoRQ5f/GvOrCbejG3891pqjRsxF8pW
 5sSh8tobuTK9N9aXRmmLY7/RGeZCCWGR6RaxWiyNg1b2UIKSuE8IWOFUlbkK/d7vodNt
 MFFNQF/YcmaTwExMlhmpyHz1xCt+Su37E8ZmAv9i0quZZfpvti/QJxH19z5eOldIIvR6
 6mVDCQjwYNcpRStwzMTJJTvJuLe9GxcWVyBwmHEsI2wY9uAyZL/QbfkNxNNjPVb0ufn+
 4GJg==
X-Gm-Message-State: AOJu0Ywwqa8Z3E2WPtzRNr+KwNnRbVV1lGnqZd73dgyn37Ys07v/e7NY
 yXr+KbPQvTSEIIhuRfl+R/VvM5tTIY8bDfIuePrK9Eii
X-Google-Smtp-Source: AGHT+IGGe11yS6Keare1nz7xyEtSCcqvJzxqfa41W9zcsoLbW3oBw0oQb+5WXXmV2SbrAtdHUiDAs5vWslk3R6PKLFg=
X-Received: by 2002:a05:6871:69f:b0:19a:2d23:4e32 with SMTP id
 l31-20020a056871069f00b0019a2d234e32mr3717855oao.28.1695223579480; Wed, 20
 Sep 2023 08:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-10-shashank.sharma@amd.com>
In-Reply-To: <20230908160446.2188-10-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 11:26:08 -0400
Message-ID: <CADnq5_PNf16JzP=P=Xg06o+hkQvDJ8+es+Kv83TRpCjf_7Ujrw@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] drm/amdgpu: cleanup leftover queues
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 8, 2023 at 12:25=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> This patch adds code to cleanup any leftover userqueues which
> a user might have missed to destroy due to a crash or any other
> programming error.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index a311d4949bb8..0c78579b0791 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -61,12 +61,23 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_use=
rq_mgr *uq_mgr,
>         return index;
>  }
>
> +static void
> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> +                        struct amdgpu_usermode_queue *queue,
> +                        int queue_id)
> +{
> +       const struct amdgpu_userq_funcs *uq_funcs =3D uq_mgr->userq_funcs=
[queue->queue_type];
> +
> +       uq_funcs->mqd_destroy(uq_mgr, queue);
> +       idr_remove(&uq_mgr->userq_idr, queue_id);
> +       kfree(queue);
> +}
> +
>  static int
>  amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>  {
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>         struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> -       const struct amdgpu_userq_funcs *uq_funcs;
>         struct amdgpu_usermode_queue *queue;
>
>         mutex_lock(&uq_mgr->userq_mutex);
> @@ -77,12 +88,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int q=
ueue_id)
>                 mutex_unlock(&uq_mgr->userq_mutex);
>                 return -EINVAL;
>         }
> -       uq_funcs =3D uq_mgr->userq_funcs[queue->queue_type];
> -       uq_funcs->mqd_destroy(uq_mgr, queue);
> +
>         amdgpu_bo_unpin(queue->db_bo);
>         amdgpu_bo_unref(&queue->db_bo);
> -       idr_remove(&uq_mgr->userq_idr, queue_id);
> -       kfree(queue);
> +       amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>
>         mutex_unlock(&uq_mgr->userq_mutex);
>         return 0;
> @@ -207,6 +216,12 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *u=
serq_mgr, struct amdgpu_devi
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
> +       uint32_t queue_id;
> +       struct amdgpu_usermode_queue *queue;
> +
> +       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
> +               amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
> +
>         idr_destroy(&userq_mgr->userq_idr);
>         mutex_destroy(&userq_mgr->userq_mutex);
>  }
> --
> 2.42.0
>
