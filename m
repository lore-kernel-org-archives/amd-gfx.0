Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5413FC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 18:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AC010E0EE;
	Wed, 26 Jul 2023 18:30:13 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9DA10E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 18:30:12 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b055510c9dso137163fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396211; x=1691001011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhxaF1Uyc+L9XtNkr1cn4jwgJJ84ykDBetrBxCMQYa8=;
 b=S8sB0htJeCxbBEUNC7sMzwbVVX5ES6mjBaR2a+NbbCBRR9naReWEjv+vJPb3KfBqQ0
 so2yDpq1s/zZkDygEYRfVRQleWakDQeKrsbtl/qJ5SdNMC8Zrz9Ekl2KcF+VyF7d6fAe
 hwkYAlLTB5TQppiWubHdN4xeTXViTv3xyF2ZOxcXVAf7CaQTsTQLgVI0mCWFrSQ0qNwX
 x+A+b9tueZECq4xhCzof5NQoyZ0EqEjzBmzRbRr1FHeHb1X1LI42lSoWGHNOrzAgEHJu
 qychhmKoOZmJ7nIWjOY3wUWXHmiUaHweTHYnfSvIA7ke3v6qRSP8OUv2UY8JU6rAH5hh
 UrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396211; x=1691001011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhxaF1Uyc+L9XtNkr1cn4jwgJJ84ykDBetrBxCMQYa8=;
 b=R3OG77lSCo9pzws/e80W9kEfiUrOc4HDEKseAkBM63GKBJ/MkgkOh83x97nbX17ifU
 enGUu/1n64+ZV79ducl3NaLQqyNfIt/fjQcJQ6Glw2DL9HZglkuObODqISBywz59bs7i
 dk9jbh59SAIHQ6yZ5NettfBC/6mTxvXuev8hljaGaZVNO2u+3AVF/w00meQ7b5mfakYK
 64wg5JbD9XMjYATIvpdDuPjm78r1nN88/1snevmYSGbqMbhI3lvOXYOpC/HuoPl452bE
 Fo8uTVtU5gv1SWxiT4kyJqejZDAjODEZBbqUTZR9dew3sZg5caRKmosctCcPM81EkdNg
 4v2Q==
X-Gm-Message-State: ABy/qLZY+jGfsaw+N6gFqBH7noFhA1e7t36PwB244Hp8YP7tBK2ajjTh
 Q90ItEU8vAs3j1KIWPmeXO4zHS2kBqLeqMii2OxDvacfF0U=
X-Google-Smtp-Source: APBJJlFUR4oIcYOT9l+KHpUbPEYrZxTU6SbYDY/7EymnVTfRthHLI50aN1qH3H+OBpfNZoqGapj+LCPkaaicgZwd6pg=
X-Received: by 2002:a05:6870:a117:b0:1bb:8cc2:8c3e with SMTP id
 m23-20020a056870a11700b001bb8cc28c3emr383738oae.15.1690396211446; Wed, 26 Jul
 2023 11:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230726141636.2474263-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726141636.2474263-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 14:30:00 -0400
Message-ID: <CADnq5_OZF218wH47SzdyMFkYyhcww6tAxnNNH_AV4NcFPK-kgg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix ENOSYS with better fitting error codes in
 radeon_gem.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 26, 2023 at 10:17=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Replace the error code from 'ENOSYS' to 'EOPNOTSUPP' for unimplemented
> radeon_gem_pread_ioctl & radeon_gem_pwrite_ioctl
>
> Fixes the following:
>
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index d0119c5f7eb3..358d19242f4b 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -316,7 +316,7 @@ int radeon_gem_pread_ioctl(struct drm_device *dev, vo=
id *data,
>  {
>         /* TODO: implement */
>         DRM_ERROR("unimplemented %s\n", __func__);
> -       return -ENOSYS;
> +       return -EOPNOTSUPP;
>  }
>
>  int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
> @@ -324,7 +324,7 @@ int radeon_gem_pwrite_ioctl(struct drm_device *dev, v=
oid *data,
>  {
>         /* TODO: implement */
>         DRM_ERROR("unimplemented %s\n", __func__);
> -       return -ENOSYS;
> +       return -EOPNOTSUPP;
>  }
>
>  int radeon_gem_create_ioctl(struct drm_device *dev, void *data,
> --
> 2.25.1
>
