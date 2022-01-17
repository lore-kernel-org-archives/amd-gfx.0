Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDF8C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 14:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C3410E2EF;
	Mon, 17 Jan 2022 14:07:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A0110E638
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642413528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08T3n5IWCHMWsVkAtjOf6+gJCb4Fku4CYCaGHHt4aUA=;
 b=ATQ1dPsE4cu8v68cyCZKzeh2178URvktN9aF5F4sbwYUOhhr8rcxACGs63nY2QzsRNatzC
 y2iXRVgrF4vzb7TbdZUv7crDabXcsFTUNz+gy+vrwqx2og0W2b3GV73NTGWKcBXyBwqlSm
 cOuk5JYYTdGf0lujyJ/E9JNQx6aax+M=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-ZtS1rfxeMRKkk_Z3PJNmCQ-1; Mon, 17 Jan 2022 04:58:47 -0500
X-MC-Unique: ZtS1rfxeMRKkk_Z3PJNmCQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 x9-20020a9d3789000000b005909c996b68so5779749otb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 01:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=08T3n5IWCHMWsVkAtjOf6+gJCb4Fku4CYCaGHHt4aUA=;
 b=mzCvWaAl+HuPh1i7ZUinTz9ihaiCa0OT5kH7yqqM+fY5EoOlqEmXiqurI5V3dbtqok
 FB45wtxB7CyTBrumpGHpO3cLrKUuuTKfnDvElM15A2WifcgaSDFXGdbsnv2yDLJ0t9/E
 6GEiTyqS6rS+/bX+uxMX+eIAEpjvUtP/PL72DPohy3y6mwqN766MnTCmS0bRZasHgOMW
 8F9axbd+167egzwjn6pcFMRDSoXTW3li9VuuIJxxdqSv5tbPU3NRGAapO6xj4rU/1Izq
 FyNio8f5TH8j+cYqA1cNyT/dZB3nOtFkcjDembx1huqd6xZP93cJjey35DzuJ3IuiCwl
 o9bw==
X-Gm-Message-State: AOAM530TMIFBB91SonhpnvLI9ZXV0Impjo9NEzjx63CPSz+Tnq0UpWD9
 6io8PIgkUZOW0GvWvk7oS8V2eqMNoFQ6xoBWeIkuCsx+89JswMcYSBlrZl12zvgnEyEkLFvjan8
 P1+Do86hHcr8NVn4v54WslPZ0dvmSYCtgBHCLuiTENQ==
X-Received: by 2002:a05:6808:bc8:: with SMTP id
 o8mr1843864oik.45.1642413526613; 
 Mon, 17 Jan 2022 01:58:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKct3SgWBeF/ZhMKb6rKuC5442JSq+bQAVO4Sk9trpwNF3/J1RWA8Lzqm64XqwB0izwPNICUqFSEzQGkSnJ34=
X-Received: by 2002:a05:6808:bc8:: with SMTP id
 o8mr1843854oik.45.1642413526412; 
 Mon, 17 Jan 2022 01:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20220117093848.1884-1-christian.koenig@amd.com>
In-Reply-To: <20220117093848.1884-1-christian.koenig@amd.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Jan 2022 10:58:28 +0100
Message-ID: <CAASaF6yQL+PSxMMrmSa7ix4iV0R3zGfAoqqOWCVS-BcuckMO4g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix error handling in radeon_driver_open_kms
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 17 Jan 2022 14:07:22 +0000
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
Cc: arthur.marsh@internode.on.net, bp@alien8.de, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 17, 2022 at 10:38 AM Christian K=C3=B6nig
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

Thanks for quick patch, applied on top of 8d0749b4f83b Merge tag
'drm-next-2022-01-07'
it fixed the boot panic for me.

Tested-by: Jan Stancek <jstancek@redhat.com>

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

