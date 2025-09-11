Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05495CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 18:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A85210E3FA;
	Thu, 11 Sep 2025 18:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SDkRp3R9";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA7010E3FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 18:53:22 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-32d89e962cdso107998a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757616802; x=1758221602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1t8u81UPWoBwEegQyYwELSjVO48uNg9VYqCxbxMKDI=;
 b=SDkRp3R9eUI3Bf0pE4ndWi8Gx/evekN+tcRMAow8tGOHwgNuH4N2qfxAqqrEVkCfSL
 jqRrYVj3rtkFbzzU42mz23lDhOady0nXQzjU31l+UPa4JC6RJ1O+q6cwdkengPbvKezq
 V9O8vf5n/knd0V/1XBjfo3GEMXzVQntEzHrs8mIulm+E9P7C7wFsmkbZJaAq8Zq8ljv/
 bnUl2RH0QKSoepz59daJ/zd7SHaSVKYXMCkwPJ13a5Bum1NH7Xv9KLaXHbIhNCXguslv
 TuNslwB69B+TgQ+WpmDDppY3NRcwJpxxtGbLqq4/Jn3ouQ+eKzOXQmJrxzjw5AiYuyzW
 v9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757616802; x=1758221602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1t8u81UPWoBwEegQyYwELSjVO48uNg9VYqCxbxMKDI=;
 b=sWp2vfvbO5IBend20roLKZGoU2EDIxxdyHEXn3L41+CLW4SGPt3kbepH/Hc1U0UAGo
 u05CiS7q8oYrdb9uvJYUlgZjD8xWg/Mduz+Wr/6mg1lfVkWHu5fcloC6fZyWzXQzhbRf
 WK2A0+eSfuZ7L4ts5X8+x/+C4fhri1/0KKXGPcBzEl49bjjVq2YoUKFXkB+cVANqLQ/M
 ZwmDIwXaLvAlHSZqd0VU/cP2FCh+wXSk7/dlkDVNUiSJMjioI/LMtyxJV/ON6Z1r0wN2
 R4oLqIcJ7RmWNTsTP30SBy9gCYRUgdl5kevEN5yuQxuXMdNO+AUc0oapFXygbfoyU42c
 VEZA==
X-Gm-Message-State: AOJu0YwOdIVQv+r0SjDjVJAJKW1BQv3jJ6ZT4Qq8LB1DdRGP6aueqKFB
 CvjrXuiWP+ylKQUjYx9ZMepz0ylpHVoe6ppMnQHm9ySaEyjwLyn03d5FND1yrPjjmRY5MQ1d58x
 XWWPeH1UuRZwW6NmLVmLEIpwxuz4A1J4=
X-Gm-Gg: ASbGncuzM/L30T9yh6R0cqsanrI0EIwxcLMvboPpExMaJEf/7ZCGZJRYwr915KWpDDr
 y+In6XdWmGaJK207CW/GQjBYa3/EsiUCsVPXkGl8xc+xyhaxUCoGoTf+GwG64M4TQKx5lSaz8P/
 xJKO63xmgHiCG/BXyCHxPf0N2p3p8qySPz0FS4Cb9vOjCPJqEM3oKbR7nP8967jfnbK4Jc8Jj1V
 GnguTuxoVL6oilPig==
X-Google-Smtp-Source: AGHT+IHdWxq7GA7QJD8lyY07pNQTKh4+AnVW3kMslJv4MWVTfkRPwwBeqJDhtEoHLN50O/2u4WPE4VBFPlQF08ZmhuQ=
X-Received: by 2002:a17:90b:4d0e:b0:32b:9416:3125 with SMTP id
 98e67ed59e1d1-32de4fc4fb3mr103393a91.7.1757616801750; Thu, 11 Sep 2025
 11:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 14:53:10 -0400
X-Gm-Features: Ac12FXynsHrZ8EgEHwjqMHl5A_-UAfntUY5qgU7uYEzleUa1NPY8JctlbmuxrtM
Message-ID: <CADnq5_M_Nv6d2rJFzA5B6CR3TqvKgjgRkd=ro0xY=jnZtFgMnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: adjust MES API used for suspend and resume
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Sep 10, 2025 at 4:16=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Use the suspend and resume API rather than remove queue
> and add queue API.  The former just preempts the queue
> while the latter remove it from the scheduler completely.
> There is no need to do that, we only need preemption
> in this case.
>
> V2: replace queue_active with queue state
> v3: set the suspend_fence_addr
> v4: allocate another per queue buffer for the suspend fence, and  set the=
 sequence number.
>     also wait for the suspend fence. (Alex)
> v5: use a wb slot (Alex)
> v6: Change the timeout period. For MES, the default timeout  is  2100000;=
 /* 2100 ms */ (Alex)
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Feel free to apply patches 1, 2.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3a4fd6de08ce..8e771ca67d43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -404,10 +404,82 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_m=
gr,
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
>
> +static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
> +                            struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_suspend_gang_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       signed long timeout =3D 2100000; /* 2100 ms */
> +       u64 fence_gpu_addr;
> +       u32 fence_offset;
> +       u64 *fence_ptr;
> +       int i, r;
> +
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +               return 0;
> +       r =3D amdgpu_device_wb_get(adev, &fence_offset);
> +       if (r)
> +               return r;
> +
> +       fence_gpu_addr =3D adev->wb.gpu_addr + (fence_offset * 4);
> +       fence_ptr =3D (u64 *)&adev->wb.wb[fence_offset];
> +       *fence_ptr =3D 0;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +       queue_input.suspend_fence_addr =3D fence_gpu_addr;
> +       queue_input.suspend_fence_value =3D 1;
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r) {
> +               DRM_ERROR("Failed to suspend gang: %d\n", r);
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < timeout; i++) {
> +               if (*fence_ptr =3D=3D 1)
> +                       goto out;
> +               udelay(1);
> +       }
> +       r =3D -ETIMEDOUT;
> +
> +out:
> +       amdgpu_device_wb_free(adev, fence_offset);
> +       return r;
> +}
> +
> +static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_resume_gang_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> +               return -EINVAL;
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_PREEMPTED)
> +               return 0;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               dev_err(adev->dev, "Failed to resume queue, err (%d)\n", =
r);
> +       return r;
> + }
> +
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .mqd_create =3D mes_userq_mqd_create,
>         .mqd_destroy =3D mes_userq_mqd_destroy,
>         .unmap =3D mes_userq_unmap,
>         .map =3D mes_userq_map,
>         .detect_and_reset =3D mes_userq_detect_and_reset,
> +       .preempt =3D mes_userq_preempt,
> +       .restore =3D mes_userq_restore,
>  };
> --
> 2.49.0
>
