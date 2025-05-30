Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E4C5B543
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 21:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59F310E886;
	Fri, 30 May 2025 21:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpoPEg3W";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A039D10E886
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 21:36:07 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-309f26c68b8so271772a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748640967; x=1749245767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nSQ3qTixmRUVZHDXIbGxJ1YwUu8Az6mK93n+egB4hM=;
 b=OpoPEg3WagxYtuOkcn7jZWucsEg2Iei8wYAGIx/H/hJaMOUJFq4c3objx79ogNH9p/
 Y48HjLZasdF6Y8NFake/PjvNxxyDUDYvkC1zLEanmbPjxf2M58UjzqObUjloUvZqpBgg
 ac7WnXiVaNtJH74tsrgDbFiXPuXnBPuk1jz2Y07elPIekZ0eenOa8meQaivITInTOUO1
 Zuqjcqe7TtIxlUgSLMvbeG/DwokD+XiUl+YIAApp4l08qfyzvdPxqTvU279QxzrBVoDw
 tLNGW4+UaG0aji2iwmHUTneOqjhW/8ux4JRoXuHf+/f1ifZ4s8npWrSYhj0LhiuFONnL
 iyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748640967; x=1749245767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nSQ3qTixmRUVZHDXIbGxJ1YwUu8Az6mK93n+egB4hM=;
 b=mB3l2lJGqOAbwi9OXKV7+bKjvb0eQC3pfBakoaxqfbAc4XlADc9JOZwIouhwMy+9KR
 pzUc778JvSjb4Mjn82hWat4UGodbxS1l4ox1EZyqreijoE7nQ6MaMbfR8WKkheYzwfWY
 p4kHcyygYPioWeUlqeOXGhjbm3wvXXiI7Ktms48c/+Rk2j04VtcB8iZN2+q7nvoB84bD
 RS7aFid54HykY7XeiCO6UobwqQobDG/VlcSosSiJL8jnDospebcsSOVovPxM6Twb5alF
 m5WdUtEF7ZtOOk1XE+aDgiK1+GCujSfawmUS9o5kZqwn4O9jtQgK07Dlg/3LSFGDEp8D
 tIvQ==
X-Gm-Message-State: AOJu0YyW9ciK+EaK0TbZ8CRlwI6pmpuZArUXroRssT1aXjFyMKefKv2o
 cVJed4+WZ/v3cgPyMx/PpgEk/ks3o3Uz86TuAsJiM1Ihllnls7WcIPjyl7JI/ndyhLdGMISjCYa
 5EjkzGWcePjpBFGHWB//iqMdEJijmo/0A2w==
X-Gm-Gg: ASbGnctsZu42PB4kcnj+1rMxngKM5tuwBnZbBSykIgTDrIf5+T5plJOLt00FD1XjQF0
 TC//Xhz4kmV84yW9TyrH3XWFVzFefgVAoCnOT8BLmLcxshQYj9AvGcYW0zmr6SF+xxrK1FrKPfv
 Xs5000P85hcHN/fKZjSy4iXlXx2WsKq3xlqw==
X-Google-Smtp-Source: AGHT+IG/dCvDRb5cQ5JXpTqBN1oBUT35o9IWnMb1IpZm3Im/0pPqZvtRIJ9dA9JFLN6eBOFL5yI6Tsx6EqpviDCN5+s=
X-Received: by 2002:a17:90b:1e01:b0:311:e8cc:424b with SMTP id
 98e67ed59e1d1-3124db244fdmr2217957a91.5.1748640967092; Fri, 30 May 2025
 14:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
In-Reply-To: <20250530075505.882004-3-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 17:35:55 -0400
X-Gm-Features: AX0GCFtpliOPAv6273DUVy4ieqfio26gob8QGSuqDeBSUOkSMhDP0Lnz3yNRxo8
Message-ID: <CADnq5_MiNwVgkAhK+17_WW-guameouvy=Wj307jNXS5jO0429g@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com
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

On Fri, May 30, 2025 at 4:20=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> The userq buffer should complete its attached work before
> being destroyed.

I don't think that is possible.  The user may not have a fence
associated with the queue.  If the user destroys the queue, we should
just unmap it and clean up.

Alex

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 8eea0e1e1b6a..f45585bd5872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -217,6 +217,8 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mg=
r *uq_mgr,
>  void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_userq_obj *userq_obj)
>  {
> +       amdgpu_bo_sync_wait(userq_obj->obj, AMDGPU_FENCE_OWNER_UNDEFINED,
> +                       false);
>         amdgpu_bo_kunmap(userq_obj->obj);
>         amdgpu_bo_unref(&userq_obj->obj);
>  }
> @@ -317,7 +319,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>                 amdgpu_bo_unpin(queue->db_obj.obj);
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
> -       amdgpu_bo_unref(&queue->db_obj.obj);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         if (r !=3D AMDGPU_USERQ_STATE_UNMAPPED) {
>                 drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap th=
e queue for destroying.\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 1457fb49a794..b46e67b179fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -336,6 +336,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr=
,
>                       struct amdgpu_usermode_queue *queue)
>  {
>         amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +       if (queue->db_obj.obj->tbo.pin_count)
> +               amdgpu_bo_unpin(queue->db_obj.obj);
> +       amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>         kfree(queue->userq_prop);
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
> --
> 2.34.1
>
