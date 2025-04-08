Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E56C369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 17:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6599C10E218;
	Tue,  8 Apr 2025 17:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hwqLpMmr";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9F910E283
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 17:32:59 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so619767a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744133579; x=1744738379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngSbCRJoM7Fmraivkw37TVqg5KTlTwSRqg0aMTaBWKY=;
 b=hwqLpMmrKc7OjHpdb+Yy2rTC7LrVbsireQQ5GVYDI2ndE+M6O38PZD4HvkhGxGeMay
 fWMOK2aPJpZTyOdcSIa+bFH1aYn8D1FwXkFdejA0NFMHDXS+w/XYXGXayONb/rlG8LUR
 fvsLJamBYKubkUZPRBCdeN6827SKd6ZHFHQ7ayv1D/xHETGKX13XkcG1zUWZTQl/zPpS
 lYgZBWpfnIEekK61RfF6ESIzg4QxN2GxmSyb1FMpuOsX2XxDwJZjdWau2IWGjhdHneQN
 b+WacOXqp41dKIZmkJE/meqtyA5k38LQmob2oj08c7HrpJe8Ikbfu/rOSthfKkxICjFZ
 9WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744133579; x=1744738379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngSbCRJoM7Fmraivkw37TVqg5KTlTwSRqg0aMTaBWKY=;
 b=qWoNSbak6H6xixsiwRYr43CpiVwIL8jFok7/AgGv+nSqY1KfvYt+/uNLH+nP1q5Jqd
 6bz+afOhsnZbrQfZITEUyOVONlG13v5wtnl++c22HivX3PErjV8o8t8fTeZRHA1La//4
 3+oTgumnBaI30aSxqcp4KKKtr8SG7xhlW9vlwJndVsxoc/kx/EI3fZgXa+6EVuVcEbbu
 fCyAwlnOW+iLsKRGop+qmN49ahMVK3FvTGEDXJnYCJjWiZ/nBjzG4DqLNTGmH++jRWYh
 g9O0EFRR0d9dM3kvxa7tWPqXUFIGgdfUV+IVOzYfyXIsH7yKwnVyxxkfpif5rqVS4dry
 i72g==
X-Gm-Message-State: AOJu0YzTQ+hDSpIY3LAk9op1MJLw7RQEd+8pRETWfL8TWov0AGZ1RK5t
 Gftbz2pw0/1MOf51BZIqHX3egEfVQrJUHoXJavelwRqc5hbwzGwxtcbZQeI46T+h8pr2PxHYe/4
 S7vDn4d0D8078Mb5Dl0yB4LLZokU=
X-Gm-Gg: ASbGncvfIJB7qqGtvyXy2au27bQJH5kID+1rP6XoV8SbAZxbesCXlDShJTHHXF7+5lt
 jY9Frqxuk7kr0xSLOjNWp8vsqstlDUX/+vW8+y6Eqg8MbWDTvHuuSmR96XA/V+QWqfJ2o2K+UpP
 Kz571v6ZlNiD4jset2kv++f4ztQQ==
X-Google-Smtp-Source: AGHT+IG3gx5tUcIQ2PTFZvWbtbmQU4GsTB4X9vPFD1DM65r7tfI+8O1LYRERkBDllvFsPltkdcjKEPwIaoIWQYKmwIU=
X-Received: by 2002:a17:90b:4b0f:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-306dbc1f301mr35481a91.3.1744133578575; Tue, 08 Apr 2025
 10:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250402121125.1689394-1-sunil.khatri@amd.com>
In-Reply-To: <20250402121125.1689394-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Apr 2025 13:32:47 -0400
X-Gm-Features: ATxdqUGbSrRG0iyXDltpSzZEUFMs8q4OZA0gAPuNqwfGcbhh5WJalng2_d8Wtrg
Message-ID: <CADnq5_NBzQ07vhQRh1VfRWu2GV3sMOJzxeKhMEZeM6B4N20kBA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: make mes_userq_unmap as int from void
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Apr 2, 2025 at 8:11=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> mes_userq_unmap could fail due to MES fw unable to
> unmap the queue and the return value needs is not
> to be ignored and handled on first step itself.
>
> Also queue->queue_active set to false in this function
> but only when the queue is removed successfully. If the
> queue is not removed successfully then dont change the active
> state of the queue.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index b469b800119f..8f6c12a78f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -144,7 +144,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_=
mgr,
>         return 0;
>  }
>
> -static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>                             struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> @@ -159,9 +159,12 @@ static void mes_userq_unmap(struct amdgpu_userq_mgr =
*uq_mgr,
>         amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>         amdgpu_mes_unlock(&adev->mes);
> -       if (r)
> +       if (r) {
>                 DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +               return r;
> +       }
>         queue->queue_active =3D false;
> +       return 0;
>  }
>
>  static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> @@ -345,7 +348,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr=
,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>
>         if (queue->queue_active)
> -               mes_userq_unmap(uq_mgr, queue);
> +               if (mes_userq_unmap(uq_mgr, queue))
> +                       return;

If we return early here, we'll leak the userq props and mqd and it
will also lead to a runtime pm imbalance.

Alex

>
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>         kfree(queue->userq_prop);
> @@ -358,10 +362,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mg=
r,
>  static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
>                                    struct amdgpu_usermode_queue *queue)
>  {
> -       if (queue->queue_active) {
> -               mes_userq_unmap(uq_mgr, queue);
> -               queue->queue_active =3D false;
> -       }
> +       if (queue->queue_active)
> +               return mes_userq_unmap(uq_mgr, queue);
>
>         return 0;
>  }
> --
> 2.34.1
>
