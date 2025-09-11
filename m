Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2684CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 19:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988CF10EB7D;
	Thu, 11 Sep 2025 19:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EhLIoSpz";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE43810EB7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 19:06:22 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7724ad1e7c9so145335b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757617582; x=1758222382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hu3dlf2dEUtrxClcgrPlwhBghC6E4uReL7x/6mlNf4s=;
 b=EhLIoSpz6QjxRKf51vCTkK6nkNTUF8kfYxwML4IDCfPd0ScpgGiTZyACP4JPQ2Ttzj
 F9bjJcisZxl+89POyEq29Wc2JZnx+k7P1n6EBKs7tGV/ow1zTzga0Xp6EJDwR+1VFka4
 Ppm0I7phaaTzwUGQAuPAtO0u4Su+m6qeCakD6qHBHLX6ivOFgWCYG64f7PlJAKoHKZC0
 7ev8KUPaySMgAu1SDegPaAXlq9/VhXN8+y12eHOeKshx3CxtxVzfZhHYBe32qeaibsSr
 sViiYclNWVhJFbsxvT7U1gs8KbP5bRBaL2SJAYV3/06TD3L1De4yL4JmKdrgEXWkTcJs
 3FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757617582; x=1758222382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu3dlf2dEUtrxClcgrPlwhBghC6E4uReL7x/6mlNf4s=;
 b=j7nCLN7EFMBqDo5Wo5ASogniSU9FAhUJ/IjC5wi+FzmtHpx0FJ5dvyJlY03YmDqSSP
 esyx4cXU4c8uY8MSHYTLnPAU3zz4f5zQBNmGCD1bkGowRVcfgWXh9PgOXHT+80yzAiua
 8V6DMqxvUds8gQhddDTDEZTKMfkBkk8MGivuqE34QOEo0BqTGz9HS173AkUZUEDaBSLD
 9Eei3F+PprE8Upkrm6EQtPT3vbLwCkNnZ7+XtA/mmg7A7O1TaqxgwBdyUwvvHNYbg6do
 7RyGJ+dTcILuud8UPgjoKA9gyOE+KK2t8FnEyjRwZ7pc3b6PnU4RtCtmU7jr2nW8D0Ub
 hwHg==
X-Gm-Message-State: AOJu0YycWWAnEzAQgy/UOYa+pN0DTP2ZNRV7WfLdRqrXxda8466a2zdf
 cdqY19AelnAUYh+eTFJy2OBOKru/xUsIakN0Eo4nwVXTQMe/d0xIOh7FtRra7JjcB3EvjKe+oSE
 kbX0uvQJ7/chQLbFBJTl3CriMSqOj5GI=
X-Gm-Gg: ASbGnct4pSQYQ70KybB4IDNu/HkpWpTflyq9b3kITD9y7bFTybRROnOu1kog6j/6tt9
 9+HcXU57fRtiIh+9LkiIqavSAExmrSreVeGbhGWpQ64SvVHJwTC4d2as+6Bul4OMMkD2kMqyHz6
 U+/vf99x0g23CTYFTOcseIcPqXUowipYimFoq6XeJj2DLuJB0iByfzIlT/MzVUfOv2KkEFDl8KK
 DAZF6ACXS/NFOkWIw==
X-Google-Smtp-Source: AGHT+IFkqusbTyTmeBwQ91IBddXThqTUl5Df6+oJW4zPKK4Oik69jku/wu5/pt7P8nkLgstzAxr+xEfkfSEOvMTUVW4=
X-Received: by 2002:a17:902:ea04:b0:25b:f108:b227 with SMTP id
 d9443c01a7336-25d28609c8dmr2287155ad.9.1757617582319; Thu, 11 Sep 2025
 12:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <20250910113731.2688320-7-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-7-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 15:06:10 -0400
X-Gm-Features: Ac12FXyALPxzzQ-060gMt1fZewu2p3EsNxULCAwvw_1J0Ib_2xllRIo7RKIdvI8
Message-ID: <CADnq5_N+Ps3vf7=JeiQFz54teKRZS0VmTM1S740tw2JKS__nAQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] drm/amdgpu: keeping waiting userq fence infinitely
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

On Wed, Sep 10, 2025 at 8:14=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Keeping waiting the userq fence infinitely untill
> hang detection, and then suspend the hang queue and
> set the fence error.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 7b7dae436e5e..2626a41a8418 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -199,7 +199,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -207,11 +207,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
q_mgr *uq_mgr,
>         int ret;
>
>         if (f && !dma_fence_is_signaled(f)) {
> -               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> -               if (ret <=3D 0)
> +               ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIME=
OUT);
> +               if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;

I don't think we want to set the queue state to hung here.  Just
return an error.  We'll detect the hang when we attempt to preempt the
queues and run detect_and_reset().

Alex

> +                       return -ETIME;
> +               }
>         }
> +
> +       return ret;
>  }
>
>  static void
> --
> 2.34.1
>
