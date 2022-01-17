Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 18:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A33C10F8C6;
	Mon, 17 Jan 2022 18:56:07 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47A610F8C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 18:56:05 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id q186so24874001oih.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=de4LrM+J0LArVdwuuZ6tfzx4Gz5UmVS4Kf/WjtdLcTA=;
 b=JSSsfTionQAeq2FDyKo+d+NkAulEIfXK0vlBz6FOYv7GxFGIvpLFqd7IAWvhXWKhMh
 xE7Otw2p2o9YsJdHC/k4pPaA85MMVEaswQ3t5cwby5RuNUpKQGaEreFLHt2NzZAiTPKg
 IsdKEnfzQPKBbrh9Fj3A6UREb+YaKkEZU2G7EWBECDwWUNTLVA3aYVz2gHpzuMNRKb44
 ojOgmiIEcPylHBfbJF0tWsRJ5ntEyDqYd+b3y8Uu5cpsphh5DtMMEEcIIBeeSqypRwhK
 BXDEN500P0kh4QeGYBobxT1O70Pact4TkMvF2do2FfKlchmrYB+RyNtHPYLsalY6HLZ5
 8yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=de4LrM+J0LArVdwuuZ6tfzx4Gz5UmVS4Kf/WjtdLcTA=;
 b=L7Fj3Of9z3M00zK5vnYt6xqszmuh+YO7wFcT9k5Eu4Ke2irzio+z4CmdP1wNdhcg6K
 ZXQSs4b/6yhP6o5ZTh8tPcgGQQqPox90mxHju0wbcAH9tn+jNSXYnUw9UNl56pWe4bJI
 +WcNVlx6qPjR1wRccpZYGwhEoMG2el+4zMkDVXuYAjcmwcJeYJYGjN66oyASsKsS7O8X
 ocoSniwDYPh/sHVQZ4r6KRc0wlHhx4M+jd/XfrpPkZZ2wqQI6KQef/nhzy440HELhE8m
 RklpMGeqDKOlnebce8Ka7L6LfxqoJ9lso1LaXSCVwQW/JBV5rScZNWCLFJVG4HgREk44
 puZw==
X-Gm-Message-State: AOAM532LL3YU266gFb3YOU2nyiH/wC0zuo6VrHewCfslqxD1CEfcCWHy
 HnjUk01ZpCqo7DTn68u/EJBjHlEPYG6Kbwx4j8I=
X-Google-Smtp-Source: ABdhPJzrKuGxJRjsuMaiVDO0bqyaufhGDrgFXhl3iwnxg/gYPriwS0cKX6PihRsHyhMM0ZCt07msMTTrUSIeokPNxZ0=
X-Received: by 2002:a05:6808:ab2:: with SMTP id
 r18mr16006951oij.123.1642445765133; 
 Mon, 17 Jan 2022 10:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20220117093848.1884-1-christian.koenig@amd.com>
In-Reply-To: <20220117093848.1884-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Jan 2022 13:55:54 -0500
Message-ID: <CADnq5_PGvqZq_gwPSJoGrfie4u_fc=KU=xrnABvO_HPvYELsrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix error handling in radeon_driver_open_kms
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
Cc: arthur.marsh@internode.on.net, Borislav Petkov <bp@alien8.de>,
 jstancek@redhat.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 17, 2022 at 4:38 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The return value was never initialized so the cleanup code executed when
> it isn't even necessary.
>
> Just add proper error handling.
>
> Fixes: 2ad5d8fca195 ("drm/radeon/radeon_kms: Fix a NULL pointer dereferen=
ce in radeon_driver_open_kms()")
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

If you kept the same labels, the patch would be smaller, but either way,

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index e2488559cc9f..11ad210919c8 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -666,18 +666,18 @@ int radeon_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
>                 fpriv =3D kzalloc(sizeof(*fpriv), GFP_KERNEL);
>                 if (unlikely(!fpriv)) {
>                         r =3D -ENOMEM;
> -                       goto out_suspend;
> +                       goto err_suspend;
>                 }
>
>                 if (rdev->accel_working) {
>                         vm =3D &fpriv->vm;
>                         r =3D radeon_vm_init(rdev, vm);
>                         if (r)
> -                               goto out_fpriv;
> +                               goto err_fpriv;
>
>                         r =3D radeon_bo_reserve(rdev->ring_tmp_bo.bo, fal=
se);
>                         if (r)
> -                               goto out_vm_fini;
> +                               goto err_vm_fini;
>
>                         /* map the ib pool buffer read only into
>                          * virtual address space */
> @@ -685,7 +685,7 @@ int radeon_driver_open_kms(struct drm_device *dev, st=
ruct drm_file *file_priv)
>                                                         rdev->ring_tmp_bo=
.bo);
>                         if (!vm->ib_bo_va) {
>                                 r =3D -ENOMEM;
> -                               goto out_vm_fini;
> +                               goto err_vm_fini;
>                         }
>
>                         r =3D radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
> @@ -693,19 +693,21 @@ int radeon_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
>                                                   RADEON_VM_PAGE_READABLE=
 |
>                                                   RADEON_VM_PAGE_SNOOPED)=
;
>                         if (r)
> -                               goto out_vm_fini;
> +                               goto err_vm_fini;
>                 }
>                 file_priv->driver_priv =3D fpriv;
>         }
>
> -       if (!r)
> -               goto out_suspend;
> +       pm_runtime_mark_last_busy(dev->dev);
> +       pm_runtime_put_autosuspend(dev->dev);
> +       return 0;
>
> -out_vm_fini:
> +err_vm_fini:
>         radeon_vm_fini(rdev, vm);
> -out_fpriv:
> +err_fpriv:
>         kfree(fpriv);
> -out_suspend:
> +
> +err_suspend:
>         pm_runtime_mark_last_busy(dev->dev);
>         pm_runtime_put_autosuspend(dev->dev);
>         return r;
> --
> 2.25.1
>
