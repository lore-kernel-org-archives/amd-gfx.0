Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14736C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 14:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8625E10E731;
	Tue, 17 Jun 2025 14:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPVGiR2o";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322FB10E2AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 14:53:02 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-313756c602fso901812a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750171982; x=1750776782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02dRf1mzy0OT6fgve4g6tOIsboQbA5O8ELSVw0yrFKg=;
 b=jPVGiR2oWgd7r6QTw3OcGIvzAu7avqWMnOm2xnceH0HBiulkz+TP8+BD6hPCsiqBj8
 EhGlJLJDP7gYWppU5z/hGu0Vv7j5vRFGXnpPWWAT8UFuutoOUf7r5n2dZ4jgyyi50Ibv
 HwxJzCqrlsu0iUSi+MlFvORKbHvF1aW3ClzR7h3n+6hSX7GEcnUOLTT656eIYrQXZ+7f
 rGQcZOzHDeBbfCiE9/0vZ3Xt1IdLPZ/W3tHCQ3z7VFLrmsX6TWmU+UHlPfU/TbkMoxXD
 R5uL9wzFqVwcsySUWkHBLBMoBz7mV2OHq/bNuwOB0GqhJXQDDcvnBsyoJVSCxEM4LTJ0
 P2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750171982; x=1750776782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02dRf1mzy0OT6fgve4g6tOIsboQbA5O8ELSVw0yrFKg=;
 b=QP+JYeknTDKMuldPAPrnrHQFFmVP1EUY3KZ2Owg5L7XyR998e81BU+5A1j/wFbFUJw
 LEYK/oBsGx32Pet0hMBeruCYmQR6FS6NrZvXfFtyqYSknUtN4/HJu3JrLdIGQO8UtdIR
 xVaExO+9T/cspCMvrZ6NJWpIUPF+LSRfsfwWquXmaLooWM4HjEs6bACrfAxlCssX6fO9
 nBTEn/znRykOlsFMNneZf7K62c8vrNZ0O54bK34XUY+jtLC4xrz71J2RPmjGG+QrZGD8
 8dXLFQeuZ2NXjs/rHVVrBmj3So3obHxKNeLM4yFz5KXpioYRan1ErWqwCMek5KuGNpNZ
 CEXQ==
X-Gm-Message-State: AOJu0Yye6A9Iifbk4EdbSk29WYYnIzHDtOd8Z+GTqlMHSiMS5LV4zH6T
 gChxHrUbZ2vMzRFZA4JsKVIaPO/QE7/S/EhmiBYB1nLAVraDlM22CmP4wUOWFxieY9bg/dU9H9p
 dPYCgsZUpR3OgTuOk4ju98DEUxCOydB/b9g==
X-Gm-Gg: ASbGncvY5zH/VxhCfgdT5Li3sWN/R99nOtUgPFnzam3MnhHRISSZmGi1j8qTFaBH1WZ
 7ETof04Hxb7Yl9nEyAIwIFb8bNF5aKLU5jx8YnA+b8MDt6q/mZpq9pf3uHwskqyff+pRX/ifTLJ
 Uksvd+epf3FdDbh+K5cnUoawWWZ2ottRJhJfrRN1VuurYfWowhwxxUTxs=
X-Google-Smtp-Source: AGHT+IGDpsyLIWf9Uus/cD7K6655U/dFSYG67u6SPQwxWlZ5WM7N4KCf56ZeCMYCmpxegZrhi0nlW51TN6ESoWI5TlQ=
X-Received: by 2002:a17:90a:e7c3:b0:311:b0ec:135e with SMTP id
 98e67ed59e1d1-313f1befc7dmr7732079a91.2.1750171981625; Tue, 17 Jun 2025
 07:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-11-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-11-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 10:52:49 -0400
X-Gm-Features: AX0GCFusnXNd36xvkILxx4Z5_cEMq47eOLG-UXWDv5taopJmQV_npWKTr8pduKg
Message-ID: <CADnq5_PA=4CUHBwG1zSF7vUCkKOUGvxxtT6P-FoSfWBEDAVB1A@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] drm/amdgpu: clean up the amdgpu_userq_active()
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
> This is no invocation for amdgpu_userq_active().
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
>  2 files changed, 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index be3220a973ae..f3028f344bcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -258,22 +258,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr=
,
>         kfree(queue);
>  }
>
> -int
> -amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
> -{
> -       struct amdgpu_usermode_queue *queue;
> -       int queue_id;
> -       int ret =3D 0;
> -
> -       mutex_lock(&uq_mgr->userq_mutex);
> -       /* Resume all the queues for this process */
> -       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
> -               ret +=3D queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED;
> -
> -       mutex_unlock(&uq_mgr->userq_mutex);
> -       return ret;
> -}
> -
>  static struct amdgpu_usermode_queue *
>  amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 7e532ca0ba05..929d04c70971 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -118,8 +118,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_=
mgr *uq_mgr,
>  void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>                         struct amdgpu_eviction_fence *ev_fence);
>
> -int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
> -
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>                                   struct amdgpu_eviction_fence_mgr *evf_m=
gr);
>
> --
> 2.34.1
>
