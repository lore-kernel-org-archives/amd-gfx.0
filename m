Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D888AC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 15:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D8C10E459;
	Tue, 23 May 2023 15:49:43 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD59010E459
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 15:49:41 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3982f09df74so475125b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684856980; x=1687448980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byzCPe+qmGeohaJWNZkhM3ida6LbG+uy43REJAAqA8M=;
 b=LupvOE/I9c2NICrzmGx0sYsGcQm/KJGhl4b1wj3pIvoMXpdA4U+pF4OkM8W44BYTQO
 6+2OdY8s/Qyp5o+n79CUAUwmSOkKLZxdmMm5bcVew7+KRxS0l1tG3dL53uWnnvjV68nY
 ChuobjmOZF8unS2NkpYWvf9hsTspuD89VbuYHHKXmQ+VjZaEAo4zkfjRNH8ts1EsbyKd
 mZRyCM7zWnr1ywp1n7Jhcc4Kh8HMVGNtf+O2DStj8aYr9ht+fLVL3nmG8GhHCfOt8ad/
 ZR0uWLYA4kGCb3OM5zQzYQM6JSeIIfL1C2hWLCjMoeF+vY1yoOnuXa0+DEJZ1pXvS4Fg
 t9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856980; x=1687448980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byzCPe+qmGeohaJWNZkhM3ida6LbG+uy43REJAAqA8M=;
 b=Lv+AXYkE2S0mSX+poojwC3tvvDgTYjOHaBZkFwcwHnj+6+tV/TsjDp4yNcAy40+UGB
 fe/YisN8zn/PJbJQEymZ1eDSAFjfYPVNClPy03dsWe4NivjOqHo4TMylIGC6vInXKI3Y
 I19hFPMjMZWWlpGY7jfr3CafdFsEaYPjx6mLz+V3Fi4vEq08PBjcWj1u9gdvGAWdU7Jp
 7dgAtBZmH81N/d64c9bAS/5v1HwJpekz8k6ygqhfzRzqVlLTEQtn0YyFUIuBLDN/MH7u
 3jK4HDfrIkz6/08/kkYBlNzFuGYwEbYmHxjJQhBmwIrs3bXxxYlm3Iv45eIOPeFSsj04
 WQmw==
X-Gm-Message-State: AC+VfDzoLEZIMoYD3+GdtsOj3TGFz992P0qdjjxhPUWmqz+HdTUgDa+s
 UHt4+kWAYYlTCkIVkPGzHDAFfmAWVqK+IRYZM7Q=
X-Google-Smtp-Source: ACHHUZ68GK9wsKpRkq0cqYzSFAHH++9sl/J9yeH53hOZbMdwsGNIhFFnZPMtt0Ire649A4w/WJKbdVevj65vZNOlP+M=
X-Received: by 2002:aca:1b07:0:b0:396:20fd:7362 with SMTP id
 b7-20020aca1b07000000b0039620fd7362mr7522519oib.28.1684856980591; Tue, 23 May
 2023 08:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230523132914.3144843-1-James.Zhu@amd.com>
 <20230523132914.3144843-3-James.Zhu@amd.com>
In-Reply-To: <20230523132914.3144843-3-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 11:49:29 -0400
Message-ID: <CADnq5_NMkAq_KCUtG9Y_VjePH7EqMa4LFxMHLD=s-wt4FwQuYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: use amdxcp platform device as spatial
 partition
To: James Zhu <James.Zhu@amd.com>
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
Cc: Alexander.Deucher@amd.com, jamesz@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 23, 2023 at 9:29=E2=80=AFAM James Zhu <James.Zhu@amd.com> wrote=
:
>
> Use amdxcp platform device as spatial partition device.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 12 ++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3d91e123f9bd..852c98dd40ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -51,6 +51,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_reset.h"
> +#include "../amdxcp/amdgpu_xcp_drv.h"
>
>  /*
>   * KMS wrapper.
> @@ -2944,6 +2945,7 @@ static void __exit amdgpu_exit(void)
>         amdgpu_sync_fini();
>         amdgpu_fence_slab_fini();
>         mmu_notifier_synchronize();
> +       amdgpu_xcp_drv_release();
>  }
>
>  module_init(amdgpu_init);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index 6ab5713ff741..9e3a7efaf584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu_drv.h"
>
>  #include <drm/drm_drv.h>
> +#include "../amdxcp/amdgpu_xcp_drv.h"
>
>  static int __amdgpu_xcp_run(struct amdgpu_xcp_mgr *xcp_mgr,
>                             struct amdgpu_xcp_ip *xcp_ip, int xcp_state)
> @@ -228,21 +229,20 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_devic=
e *adev)
>         struct drm_device *p_ddev;
>         struct pci_dev *pdev;
>         struct drm_device *ddev;
> -       int i;
> +       int i, ret;
>
>         pdev =3D adev->pdev;
>         ddev =3D adev_to_drm(adev);
>
>         for (i =3D 0; i < MAX_XCP; i++) {
> -               p_ddev =3D drm_dev_alloc(&amdgpu_partition_driver,
> -                       &pci_upstream_bridge(pdev)->dev);
> -               if (IS_ERR(p_ddev))
> -                       return PTR_ERR(p_ddev);
> +               ret =3D amdgpu_xcp_drm_dev_alloc(&p_ddev);
> +               if (ret)
> +                       return ret;
>
>                 /* Redirect all IOCTLs to the primary device */
>                 adev->xcp_mgr->xcp[i].rdev =3D p_ddev->render->dev;
>                 adev->xcp_mgr->xcp[i].pdev =3D p_ddev->primary->dev;
> -               adev->xcp_mgr->xcp[i].driver =3D p_ddev->driver;
> +               adev->xcp_mgr->xcp[i].driver =3D (struct drm_driver *)p_d=
dev->driver;
>                 adev->xcp_mgr->xcp[i].vma_offset_manager =3D p_ddev->vma_=
offset_manager;
>                 p_ddev->render->dev =3D ddev;
>                 p_ddev->primary->dev =3D ddev;
> --
> 2.34.1
>
