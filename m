Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8756BC71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F46D10E772;
	Tue, 17 Jun 2025 15:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmBHA4OH";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A5910E772
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:38:13 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-313336f8438so1185217a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750174693; x=1750779493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Eew2fnewPuu4kirEWCGmpo02CsjedtZ1Ia05OWlh/M=;
 b=BmBHA4OHcDsR2kQAJjDWP3Ms9i9yIf/7PSWB/XvBVbloSlOMR5aTou3BIV8xEJZSeE
 qohXrFp2cYRg2Sq9LUeTomAA0WID3d4viy+FnAIpcm6nvOEloXUOWoacvBqSyhrDre46
 Z9k7nYjQvkybypYOj495+vrqvpHGaB+7AC8e5AFhPxKtWm/p0A+W0oWDoxWEj9ziFJg9
 6Pc9bfLCrEKW36zFX3Lh7+B5g8YRmTAEnHb61Bnq/UPi3+gYCnZRf5k80/rfDD7CTe94
 wtw/9LoCDLzbaiz0B0bWho1L3VzS2t8nzo5GHn+ro+pg1BK55ozX5YrAkjSladH1C0Jh
 t6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750174693; x=1750779493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Eew2fnewPuu4kirEWCGmpo02CsjedtZ1Ia05OWlh/M=;
 b=sukMqCWMCofBZfG2bhwQ/+/5oJG2sb1WdpSwZJwyu4Nk+TKKKMXL3n7T6l7KUjDj2K
 O9XKrWwXB2gEUuTCwdESiso3b62W/+Lm/BC/fTBQXWYeav5yc6BVLDqwMsBRA3ifVQew
 ERBq/YZKIbeCRfj2+P1766sR9oejK8CONQJrNQcqybdmb4XMRZ/jwQmjOIKwVNzeQYOa
 CX+h65y3hjepE86dlszc8av+LXzXNkUwOgw/kiK+RybUgiJxFp6/efmenDgJKauHzGiw
 QS1BJaDLhHkqM5glGvQChN+J/CUoxK9c6Mn5gyrixnOMyHE2Wc3C+jCW9a8BVajxuPQ0
 ajcQ==
X-Gm-Message-State: AOJu0YwXxYinTBFEJVehkjHOx0ixbGLtzgJkEilPRYcjnCH3AE9xhbb8
 UeD7MEJDkvHh/ZPhzfZArM6lIcbbBcHofV6nE0Z3YPGWSk+2iNwdW4mu0jE9vpve3MJjpRSOUH5
 aswOd1uWYkOkAyXd7BburrhyfpR2Gyjg=
X-Gm-Gg: ASbGncv6y9xzAbwU3k0ARmAAt0Nti8E504aYaa9kuDjEWoKTbSXRu14BHw6UOG6i192
 SUe/kiXprwYJfkkt9mMELpbwTDW7PICSZpDccmD/eMmMQpgyZRqH86iLSW2f6WndYjYtffe9cuG
 ycy671EiDra41apLrq5pbqxo8reTM0n/sfVPYEhLc01Q4r
X-Google-Smtp-Source: AGHT+IHW8uHgRAG1wq8a0Hp3pFzPVmYh+USakzuXmW3sawGb0aKYCPLqo2lQJWuHE8QXlk6whfnKTRxI3ZKh7DCa4OE=
X-Received: by 2002:a17:90b:1fcd:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-313f1d533d2mr7763547a91.3.1750174693063; Tue, 17 Jun 2025
 08:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-6-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-6-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 11:38:01 -0400
X-Gm-Features: AX0GCFtlny8qVlkjYr5MIjrS2rZ4WGbtaZWtx71zue_bcS1CW91aKkQ1gJXlqo8
Message-ID: <CADnq5_OC_Hej2okXWu53UtJgYU-=ga+DobZ-reaintt2eCjqjg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] drm/amdgpu: track the userq bo va for its obj
 management
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

On Tue, Jun 17, 2025 at 4:12=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> The user queue object destroy requires ensuring its
> VA has been unmapped prior to the queue being destroyed.
> Otherwise, the kernel driver should report an invalidated
> error to the user IOCLT request.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 2882ef8fe719..2a7ec7daf3da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -459,12 +459,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
ue_id)
>                 amdgpu_bo_unpin(queue->db_obj.obj);
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
> +
> +       /*
> +        * At this point the userq obj va should be unmapped,
> +        * otherwise will return error to user.
> +        */

I think ideally the queue would remain mapped until after it's
destroyed.  I.e., on the userspace side:

destroy queue
unmap VAs
free BOs

Alex

> +       if (amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
> +               drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va sho=
uldn't be mapped during destroying userq\n");
> +               r=3D  -EINVAL;
> +       }
> +
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         /*TODO: It requires a reset for unmap error*/
>         if (r !=3D AMDGPU_USERQ_STATE_UNMAPPED) {
>                 drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a =
HW mapping userq\n");
>                 r =3D -ETIMEDOUT;
>         }
> +
> +       amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
>
> @@ -585,6 +597,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>                 goto unlock;
>         }
>
> +       /* refer to the userq objects vm bo*/
> +       amdgpu_userq_buffer_va_get(queue->vm, args->in.queue_va);
> +       amdgpu_userq_buffer_va_get(queue->vm, args->in.rptr_va);
> +       amdgpu_userq_buffer_va_get(queue->vm, args->in.wptr_va);
> +
>         qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_=
COUNT, GFP_KERNEL);
>         if (qid < 0) {
>                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id=
\n");
> --
> 2.34.1
>
