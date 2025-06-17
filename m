Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9468C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA6D10E1BC;
	Tue, 17 Jun 2025 15:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMYgQAxW";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF31810E1BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:13:52 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3138e64fc73so947882a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750173232; x=1750778032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zV/Jox2MMqMZM+i8V9YHwa9NDTMaXrWnDz52PM6e0XM=;
 b=EMYgQAxWkj5UJ3am5rDb/OBdGKXzfOcIVjuBJoDRgB/x7WUSeSRQckRgc79TnofBoo
 CRwjEQj+hGUQ+/1zOM9tI9WS8IImPQgxj2hPXcgNtDEL/X2WCk4dw1pOWhvIERdEzfVO
 C4EPE7hicxh7L0oR0Sc/WWAXnXhFZV0Cv6mPo31iMcthNKUjHza8S8gJuL/BQC7LyLs8
 AVf8lSoH2gyhpuv+SulcaIK1pXxKPkc1U8qqX6W0Ml7tF2n1RgmHSX5euzopsFyLbGaz
 qcaWK83pcgeseU7WL1n7/6c4IAoj5rBDVLwtuqHZleR6DL9cZbCIfHNq54svr4RqFjfj
 t1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750173232; x=1750778032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zV/Jox2MMqMZM+i8V9YHwa9NDTMaXrWnDz52PM6e0XM=;
 b=ASsSVgtJnI4fo+ao3A/Dzu6PDu61ZRyesfvoPIRRM/n6imQGU98kM6GWPZpRXOAXVj
 gD/08/LnLfVTXDHBzTLrrKzM+bm+BiKeuBokLg85qa4Buggdahshb4hPqajq0ChAWxwv
 XLtWmUfo77BOFobsE5B5KkHrCkwv8WNlGEcAbDYZyxyo7rGp06Eylkyqu+7VWVk1cTu/
 gvzpIz8d5j+od37JLNNkG26skuWVc2m8mJSVTacDbRC+xCFRVOd7GiBlsp7ZNdjU8xNT
 z/QrgIqvxCIL2xnO8qgDAeHhXYM3q2Ol8l0xZyORRs3xaOj8XiwNVjXyN34puhqt8dAn
 98mQ==
X-Gm-Message-State: AOJu0YzZbpwOTP3ltKPJY2LFj/JoK7HcOGu7M7bUUE6stauoHHYDH9bP
 kTZqlpDk5hDoyd+tOEV+BJeJ4RMCRwsyt9yLeNzJXkJUuWRGQv5tpabNyEykPtBqmVaWT8wOZLu
 V9Lm90vRaWvCmzb21V8/BpHAER+cagpo=
X-Gm-Gg: ASbGncvDpG5bzwLL4ODAf4DO2rgK1ZnP7pqqWjUOpiJq7CvlnBz4FQTFaoVpH9/f7SV
 RcsySnZNEZxEs8olWGxz7pxglX/ybbKsnQMYyXoCMqLJvID69XyvoetCiYstl1Ph9RPsm4S5d/0
 yaPGWe+RNpmw4w9QMFqepxu+PfI8cXCc8NDxQhv6z0DK0s
X-Google-Smtp-Source: AGHT+IEsJfExJF8yd3avBdek2PvDrIuad39X09vyRNONCPtbdsGemXB0hkkPLz4yiXawVvXMaU+1s+g3yuVq7sIvEOo=
X-Received: by 2002:a17:90b:2493:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-313f9fc7712mr5177873a91.1.1750173232374; Tue, 17 Jun 2025
 08:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-3-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-3-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 11:13:40 -0400
X-Gm-Features: AX0GCFt4TKflr46Ur8rkFPFZL6TC_Up0UnFYbxFDsc9058bxp8OdxB8EEv7XoEk
Message-ID: <CADnq5_M1D1+iASZCFJMu=_QBi5yMrXgofANJCXPby9jP1ZfgYQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] drm/amdgpu: unify the userq doorbell object
 destroy
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Tue, Jun 17, 2025 at 4:27=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Unify and refine the userq doorbell object destroy.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e3cebe532c7b..dca0f76c9fce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>                 amdgpu_bo_unpin(queue->db_obj.obj);
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
> -       amdgpu_bo_unref(&queue->db_obj.obj);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         /*TODO: It requires a reset for unmap error*/
>         if (r !=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 39decc0b00f7..c6f7b613e684 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -343,6 +343,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr=
,
>                       struct amdgpu_usermode_queue *queue)
>  {
>         amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +       if (queue->db_obj.obj->tbo.pin_count)

I don't think you need to check the pin count.  Other than that, looks good=
.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               amdgpu_bo_unpin(queue->db_obj.obj);
> +       amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>         kfree(queue->userq_prop);
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
> --
> 2.34.1
>
