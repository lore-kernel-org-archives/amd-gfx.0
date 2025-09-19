Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31243CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 20:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C016A10EA85;
	Fri, 19 Sep 2025 20:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZDKrekcO";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56EC710EA87
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 20:24:56 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3307e8979f2so505738a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758313496; x=1758918296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvBYiUmhu+Ia7hwods4YJ3WbOQ/3/7d192fgi68OWT8=;
 b=ZDKrekcO3ujbfOAaiE3/qz1qsfMoQ5UvvgUXGY4OTku0R2yrFmM5r9eYwA3RdwSXu6
 q+naqbiyt4sTjdTXqY38xk1Zto1zbhN3xlAat1jDAlEhXe+eUHwerWqi68kxEvDlwNYw
 MF4OYRvdqW+bKOW/JNOJeh18Qwi7h3XaTVZJksf1zO2ZZ8wo46vGjteQB+TlY9w8gZzp
 Bd8VK1Jp8He2btI0CYSpe1aaWFR5y2dAsM696h4q3FHIqOaPioouQ4vjap7Gm/t9pt7F
 FeB3ZEUUgNN9UeNZNsM/uBeaODg/f7dgjGd7cEKi0CO7FOGdp+r1D8Eg+bSM/yxME+qr
 yQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758313496; x=1758918296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvBYiUmhu+Ia7hwods4YJ3WbOQ/3/7d192fgi68OWT8=;
 b=u/VCP07LBJSlBmjG4IUNpnUkR3A/ptnjzJZORoGUT39y0mHCEfguw8PDOmWSie+L5B
 reHhWu5ycX/BJ80tRhUi1T+VbHmywBo2smQGwF4OrfJto8I/98x2Iv+ncLCv/U3AgxMx
 i/LTJapWoBibzPEdX7X4Rkhy4ulwmAvK/BJ1qpV1DvPRSOiXGqXX1js8ZMD/Z2BX6GIo
 xYOCuTpPAPRpNkhlaHwtedw911ipYIp0GjOllz7dLMLQCs1c+3k34hr0OTBR2r9q34cl
 cJ3p0Jocxt+aQLL/zHsxUSUjH9jSd+nxHGKN/a84p8Js7v4l55mZvuVU4Yx7pzPjExC9
 Lt2A==
X-Gm-Message-State: AOJu0YynPo4bIToRBeAIqYmSoeAQVAC+7/j1D4wvrjXrLRUuK55j1cZ8
 cTKFERH5zNSIdRZjggkOWH19SzDYtyFrx3dvZtsLZgZSDbhNg06OVJ//JMrHzk7bAqSFCWJk6eO
 Mf9B2QOAwcnYI7cKyG7s+UivJu1G4BgY=
X-Gm-Gg: ASbGncsMdge1ZwWisc90+wvK4dRwQVjBnWlSqIA33IaSBtSLKROBDxZbVoNomOGhM1D
 Nwta8WpDMtVorRm0Z+lbOUQjyWoHKYMYRYY9lzTaS+035YRDmtdX7WfKD99ywIWrrZ59P9v/JVj
 uLswgDcqXXiGwUP4kdodWSdOESV+XtBanxHUeJJifrpyW3kMpeSlI/twkEL9u+aHOsqY+WFCxdD
 IZm2+A=
X-Google-Smtp-Source: AGHT+IFxhJnA0uY8zPT/tKUh/Dd9ycH5YtNDhAMHcHfgK35tCyas6MgoGNDER61PZV2neFKZOA+O4gMSVAh+ILkebrs=
X-Received: by 2002:a17:90b:33c8:b0:330:7e89:7591 with SMTP id
 98e67ed59e1d1-33097fd8a39mr3087402a91.1.1758313495635; Fri, 19 Sep 2025
 13:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
 <20250919081113.2797985-8-Prike.Liang@amd.com>
In-Reply-To: <20250919081113.2797985-8-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 16:24:44 -0400
X-Gm-Features: AS18NWBGHCQUJ7g9ZMNslqXbKzHpKSJOHU9C4u34djG00HvSU6NY9k5boXRACtE
Message-ID: <CADnq5_MLgDofb=3i_xnNQ-Tk=5sBDqqsQhApbibNphYoBcKvSA@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] drm/amdgpu/userq: implement support for query
 status
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Sunil Khatri <sunil.khatri@amd.com>
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

On Fri, Sep 19, 2025 at 4:29=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Query the status of the user queue, currently whether
> the queue is hung and whether or not VRAM is lost.
>
> v2: Misc cleanups
>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Might as well squash patches 9 and 10 into patch 8.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 224d09019997..8ac7236091fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -610,6 +610,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         queue->queue_type =3D args->in.ip_type;
>         queue->vm =3D &fpriv->vm;
>         queue->priority =3D priority;
> +       queue->generation =3D amdgpu_vm_generation(adev, &fpriv->vm);
>
>         db_info.queue_type =3D queue->queue_type;
>         db_info.doorbell_handle =3D queue->doorbell_handle;
> @@ -699,6 +700,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>         return r;
>  }
>
> +static int
> +amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq =
*args)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_usermode_queue *queue;
> +       int queue_id =3D args->in.queue_id;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +
> +       queue =3D amdgpu_userq_find(uq_mgr, queue_id);
> +       if (!queue) {
> +               dev_dbg(adev->dev, "Invalid queue id to query\n");
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +       args->out_qs.flags =3D 0;
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> +               args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_H=
UNG;
> +       if (queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm)=
)
> +               args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_V=
RAMLOST;
> +
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +
> +       return 0;
> +}
> +
>  static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>                                         union drm_amdgpu_userq *args,
>                                         struct drm_file *filp)
> @@ -779,7 +808,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>                 if (r)
>                         drm_file_err(filp, "Failed to destroy usermode qu=
eue\n");
>                 break;
> -
> +       case AMDGPU_USERQ_OP_QUERY_STATUS:
> +               r =3D amdgpu_userq_query_status(filp, args);
> +               if (r)
> +                       drm_file_err(filp, "Failed to query usermode queu=
e status\n");
> +               break;
>         default:
>                 drm_dbg_driver(dev, "Invalid user queue op specified: %d\=
n", args->in.op);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 7bbbb5988fc7..e0ca466681f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>         struct dentry           *debugfs_queue;
>
>         struct list_head        userq_va_list;
> +       uint64_t                generation;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.34.1
>
