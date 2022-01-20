Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0501C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 15:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCB110E499;
	Thu, 20 Jan 2022 15:18:52 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8B710E499
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 15:18:51 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 c3-20020a9d6c83000000b00590b9c8819aso7958527otr.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5KSyqqObG1R5qthIGhHShEM+LlwTnYYuJrdHwho3cDI=;
 b=UuAJXFdRC2/Rk0+oKynfh67xNKrClYgouspoSm8CEMiccYVrJw/CgsDtOGlTcfDzrK
 Sv4dWChC3PEaeKtMmb8ED9I0y9N05UTIXT0Kv6exAwq6SBdu4BSFhnj8bl/pmMfMD8qb
 JtTynnBiF9R2K6tLdBRKXQrR2hCrjyhOC2skd+Z6kooxc8Jk/MldyIZrOJ9IPl4xjkLF
 2ko3iWpy2uc2p2asLj1Zoe4LozmGmyBrBfjjvSTeMIGJEJ7FSSTfERx4TnDxKQIoO2Dp
 nAa2cbD9/Ado12950JgO0xyjb0s3Nl6ZmehxvK0cD0P+4TN1cH1T8orYoSrxnXhezVha
 s4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5KSyqqObG1R5qthIGhHShEM+LlwTnYYuJrdHwho3cDI=;
 b=zIe6/1qm/hOABgCx+ISbmcC+XK7UvdmCUeIQY9vtV5jWTFkj5KVepqFiUR6D4TEuH9
 oCJ613+1djeDY4XSUYd+AkpbR+S9WhtOoCvNRKKJKB/Ex2LuKlqlxQl6iQlnzl4QTMqB
 NUz60UTxhD3nEuIfIYOLN4FeMuSNA7BlAbNihP8C5CdfFybjL2lPrFwTtIrXWmevYhRs
 lyHJRcEiciB04NyCMjuaL/oE6a7sCSldK+pMQJSZ1NDtMFs3N/m45788VZDPHrK0gYpK
 YNDM06WfTFyAv/7Cpb6wQa2e9xFCdLnD2HlPslzoo10yFvWAftVdLPYdlC6wEUiL5tZk
 UFLA==
X-Gm-Message-State: AOAM533DpZdkSa1cIfd4zFRKL05WX83akFmkJ39rCufpEb+d6Tv2SBtG
 G5Z5YJ9YJZ2HhoQ8Kh9jP/gG56vxs3N4Azp2IwvrfG3I
X-Google-Smtp-Source: ABdhPJynQTS6hwaQMrZOnL+UprscGqoWkNtfaaJgs3B2igZ4HHUUKr6y5gNQKGubxAwLDassD145OqRetS/P2Kkyxbs=
X-Received: by 2002:a9d:12f7:: with SMTP id
 g110mr29499691otg.299.1642691930450; 
 Thu, 20 Jan 2022 07:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20220120090337.2542-1-christian.koenig@amd.com>
 <20220120090337.2542-2-christian.koenig@amd.com>
In-Reply-To: <20220120090337.2542-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jan 2022 10:18:39 -0500
Message-ID: <CADnq5_Pf527+c7paBy_bagXySgF51pWonc+oo0B5-3=Sxnbnuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: protected amdgpu_dma_buf_move_notify
 against hotplug
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Anatoli.Antonovitch@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jan 20, 2022 at 4:03 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Add the proper drm_dev_enter()/drm_dev_exit() calls here.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index 8756f505c87d..eb31ba3da403 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -36,6 +36,7 @@
>  #include "amdgpu_gem.h"
>  #include "amdgpu_dma_buf.h"
>  #include "amdgpu_xgmi.h"
> +#include <drm/drm_drv.h>
>  #include <drm/amdgpu_drm.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-array.h>
> @@ -447,14 +448,18 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachmen=
t *attach)
>         struct ttm_operation_ctx ctx =3D { false, false };
>         struct ttm_placement placement =3D {};
>         struct amdgpu_vm_bo_base *bo_base;
> -       int r;
> +       int idx, r;
>
>         if (bo->tbo.resource->mem_type =3D=3D TTM_PL_SYSTEM)
>                 return;
>
> +       if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +               return;
> +
>         r =3D ttm_bo_validate(&bo->tbo, &placement, &ctx);
>         if (r) {
>                 DRM_ERROR("Failed to invalidate DMA-buf import (%d))\n", =
r);
> +               drm_dev_exit(idx);
>                 return;
>         }
>
> @@ -490,6 +495,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment =
*attach)
>
>                 dma_resv_unlock(resv);
>         }
> +       drm_dev_exit(idx);
>  }
>
>  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops =3D {
> --
> 2.25.1
>
