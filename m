Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE4DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 19:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A3910E027;
	Thu, 10 Nov 2022 19:50:36 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688E110E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 19:50:30 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-13be3ef361dso3263360fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpoLdvRflktQN7U9c5G434i5k6igw7JRT2IHc7qtmk0=;
 b=HVOaDTPDqnSHbrNBcsUODsBGtNj71hTeMHrHQFCH+Eqesse4GHqCFlxhxkVql20AYu
 orKbhWs8i6RnencmUjz/l8WUeZoLh4OGgMvvJ7gTTb1gygCejS0UOeeWpduW/BLmTwjS
 Ydgq9YRzU9OKkb6pfH8DjbIb7jdu9wSiTrNXZXic+cTK1vDc+taVDrOxWDujOvWaFNIx
 UsIxZ1k8xr93I292Ve+nWRw1qnEpBdPLVdreMmcD+4bTqF2SHDRlN+meEeHEuVIJDZgF
 QpuBZbBohTYm3XU+sR0ufdhHdZCuqBI9qTE/pHdvMAUmVt2OyJccjkAYhFFZqSHd5VBy
 i6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpoLdvRflktQN7U9c5G434i5k6igw7JRT2IHc7qtmk0=;
 b=7/Q4bKMpbse2dqn8xgHebb8Q6cW+L8xvVXZwZR3nfgiZVBN3Ol6eG1ZibUhhGXa7XD
 FZc3OlOHjiKreyRwpcYxEaRKF9jD4l7644pe2O72gKqC5cBrw72LvdY0FjZ+hO2nCkIo
 CrVZza+AXoQw1MXiJG3fyASXXKLZB5WOIc/3us9HDY3AzvUoKAJjfi5q+HnRbY97tjVN
 qti7Q/OaaNK4k/b0/Pe+L7X1oXHYfO1zPcMWlSJpIhYsXdWxZuPDF53z272HOfAfRPNz
 Ld4eEdPo6FPIW4LwaO15lOioJOfzH657zogISlK4s7w9cSz5FWUdpBy8HTdc+3JKn2Q2
 SmWQ==
X-Gm-Message-State: ACrzQf2cyo/A07MqeK/E6NO88ebyUgarbkpZeg95/ZoCOjpvZsHWBdxq
 nziw7Pc8NaOZcSUDm0gAK6/d7SYzyZzVYVPLsak=
X-Google-Smtp-Source: AMsMyM7/aeEfqXDDH280FG+apQQxmO7pE6h5/e99SBudI8LyEhNy9oCNc1RQLwGN6ybflTxq/Xu+YELxcpmRasGoJFU=
X-Received: by 2002:a05:6871:4503:b0:12d:58c1:33f9 with SMTP id
 nj3-20020a056871450300b0012d58c133f9mr2085137oab.46.1668109829153; Thu, 10
 Nov 2022 11:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20221110130009.1835-1-christian.koenig@amd.com>
In-Reply-To: <20221110130009.1835-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Nov 2022 14:50:17 -0500
Message-ID: <CADnq5_M3pfo0W2fXRjFd6b5Enhgfd9V+zCOkNEpazmXP++Oi2w@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: always register an MMU notifier for
 userptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 10, 2022 at 8:00 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Since switching to HMM we always need that because we no longer grab
> references to the pages.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> CC: stable@vger.kernel.org

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 8ef31d687ef3..111484ceb47d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -413,11 +413,9 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev,=
 void *data,
>         if (r)
>                 goto release_object;
>
> -       if (args->flags & AMDGPU_GEM_USERPTR_REGISTER) {
> -               r =3D amdgpu_mn_register(bo, args->addr);
> -               if (r)
> -                       goto release_object;
> -       }
> +       r =3D amdgpu_mn_register(bo, args->addr);
> +       if (r)
> +               goto release_object;
>
>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>                 r =3D amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages=
);
> --
> 2.34.1
>
