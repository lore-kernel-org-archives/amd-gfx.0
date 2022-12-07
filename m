Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37522C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5D810E3CA;
	Wed,  7 Dec 2022 15:20:59 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC7210E3CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 15:20:54 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1443a16b71cso18147380fac.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2V7JVeqfiJ/FYYwT8To4f+ufYN26iNvN8iiLfH/dtow=;
 b=NgnTLCjZajOXN2koWeCG/IQANr2h4iPTbFu3RpnlfklQTxtinhwWy1hWG5qCKlPnRG
 QVR0CXACVMiykgVBWtuCMZJmUX56UIICG5VdUTA1mbr+U6wfQEoeikB0jgpo3Fe/w/X8
 XfN2xgDZnZ+LqsUYEg1Zk+q9j8W/AKoEB4+7v8G0LDe6yno+P5LOqs+P9N1L0fXQ2zEc
 XuDRYZZkDyHacEufqn0ABLoUUQQXVObN+5xzuKXhOji3qQx7b/I+5lWyAxT7JjsPMxy0
 P+ck0a1rFQ5WGRp7nwou/KQymhX/c5elK9e8Mpkhcj1hgrpartkbQ1LmhveFCH3gxJPy
 YRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2V7JVeqfiJ/FYYwT8To4f+ufYN26iNvN8iiLfH/dtow=;
 b=7FFR/Wei5W+9F2jgF35El490wqHfDq2aYgv/aw0/8Gn6ThbUtVsc6vYKhADihjk4pa
 YpmNFe7QopVjO0Kt7NWY9X1eJjtHpxBGvTFEkAUnoBnSVoG4pnjp+fiBnQ7oUfd1fLn9
 ZDSgK8vwjtwMOqlZDzPBA9Sd/fqWnoG8MRao2uXlycsa2ZVDni4URWH0riP8S6KjY0US
 Xldkqka2lcs2VfE/81gU1yANuHmy30ENhT3zQXqWXrf39S9FlHKPyV0EaC7KUJF+LXvN
 j/crnXlx/mWcsph7MTCZZO2FzxE1FX1VyJgVHhpi+ClDgO4utubpWdQaRTyVf3a8tqeF
 RUDg==
X-Gm-Message-State: ANoB5pnbMqPxBG2rDoVQ7nH14i5vdsZf+l/q3xWTKpP0Sv7pqy3iHxYQ
 8fk8TlzN0Z+dPMUfwfjgdbNcZ/mSA+hxf5CrbSE=
X-Google-Smtp-Source: AA0mqf7D9a59cgTuRSxYODfvaPpsFSGrpwgx5eUhIBphsdZvurzKBPbtYEOZeHmc87WQE3TEQk2M5Dyy0MT1jrfW5JA=
X-Received: by 2002:a05:6870:7a0c:b0:143:8a81:116c with SMTP id
 hf12-20020a0568707a0c00b001438a81116cmr28773865oab.96.1670426453659; Wed, 07
 Dec 2022 07:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20221207074936.1347543-1-christian.koenig@amd.com>
In-Reply-To: <20221207074936.1347543-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 10:20:42 -0500
Message-ID: <CADnq5_O5S8_UTCiUbm8sxmhTpO2TsdqaGUg05neOqCojBLZJGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fixx NULL pointer deref in gmc_v9_0_get_vm_pte
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
Cc: Alexander.Deucher@amd.com, Kenny.Ho@amd.com, vprosyak@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 7, 2022 at 2:49 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We not only need to make sure that we have a BO, but also that the BO
> has some backing store.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 50386eb2eec8..afc0cfed5065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1185,6 +1185,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_devic=
e *adev,
>                                 struct amdgpu_bo_va_mapping *mapping,
>                                 uint64_t *flags)
>  {
> +       struct amdgpu_bo *bo =3D mapping->bo_va->base.bo;
> +
>         *flags &=3D ~AMDGPU_PTE_EXECUTABLE;
>         *flags |=3D mapping->flags & AMDGPU_PTE_EXECUTABLE;
>
> @@ -1196,7 +1198,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_devic=
e *adev,
>                 *flags &=3D ~AMDGPU_PTE_VALID;
>         }
>
> -       if (mapping->bo_va->base.bo)
> +       if (bo && bo->resource)
>                 gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.b=
o,
>                                              mapping, flags);
>  }
> --
> 2.34.1
>
