Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FFAC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 13:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4EA10E073;
	Mon, 24 Jun 2024 13:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ayFFQl/h";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E19510E073
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 13:13:27 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-6c4926bf9bbso2650405a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719234807; x=1719839607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6gAeKpBq/ROIhFkJCSTGkGYv0Aq0Aci1a3hPGO/mfM=;
 b=ayFFQl/hJU3SeTIWRhlMOvHDzlsMS6LsbY9aS2GnCOIiAWlEbtEsIHu69Rc8Ss4oZq
 ju1zfHvl7mhDLKLm7kYkooBklCZvzeUnHTR7kiGbDnESRoHHDrDNWIKXdw71+kDelpSB
 c5667KqUST154JgblwRxroeWGxf+0Y5B2/gluATo9vgFeZWeQvVEXJ7taCuoyA3UT82j
 E3KJC0Sptmbc1/Dk+TVFp1sNqA/+13Zq+azfUqpvEeNHryHcxghqW3Ecf5BGN+/3mZVC
 W/3eWLvAfSAwIPavD2BD+dkRX94XuzGdPaA1dommrwiAlgX8hkGNP04vB099mZCE9Z7g
 U7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234807; x=1719839607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6gAeKpBq/ROIhFkJCSTGkGYv0Aq0Aci1a3hPGO/mfM=;
 b=NGkzN0wFtbntmlM6kufsxgE7IJKR7PGLfLGrVNoMeLEtpGiydmFCSQZabl0up3OFkD
 AN84DEYZdbs+ob7AfKorf1sIHR9yStI20ygzQul60CbKj7pgjzF0FYaKM+5IKw3XXfcJ
 ElMFwCl2USE4Gy97jMJ3C9ZQvi0snwwyqxO1AXwUY/LU5AEufMdPJJ1qtZz/hAIT4rbR
 KW8GVd7JzYX0Ez827S6m8jsnzMwgs4ccCVNqTjKZ/zlaVnW5EJ4RHDnI4p/GYVCAPHX3
 O5Gzr8ZWar8kTKXPexus6wSZv/6Ry9/sYPcRijGOrwyRPk/DRMZj45yUDdcOg3rlxpcT
 8qPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcD0f9m4zOSc27EduaRjSEjzGFlxp8bZb5886NkwIGet1WDeN2suVbwLcDB7sYiHUep1TfgoOcZfVQXUVC40n+xWS7zk7vwWWCCGy2vg==
X-Gm-Message-State: AOJu0Yw90N6uZgg/uwRJVVMlD3JUjpEgK1M+L6jFxIJEpuMZOSHCikWD
 NQymu7LZa8pMsvBdXN5xpTj9IbFqdB6dIYdXIcuEclqXD9ER8szr4WV44dC4Wx8z6GwCothp7xe
 jOT75HM1NnihM+ZaPjzhKOpsKgH8=
X-Google-Smtp-Source: AGHT+IEkH0oSalDOWzIvAh4Y48gkgXpS7cjW4e+lwlF2dn8WS+hqrSp4KOjFXuqKvhGKl5d0E31RRpkvJR1tWgBNiXc=
X-Received: by 2002:a17:90b:3a91:b0:2c8:a88b:4e6e with SMTP id
 98e67ed59e1d1-2c8a88b72d6mr22690a91.35.1719234806883; Mon, 24 Jun 2024
 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240624091040.1623473-1-christian.koenig@amd.com>
In-Reply-To: <20240624091040.1623473-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jun 2024 09:13:15 -0400
Message-ID: <CADnq5_Oot7mgA1J6G24urumTLpfWOf5i-K9rg82+2Ypj45rHdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: revert allow write access to mapped userptrs"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Jun 24, 2024 at 5:17=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This reverts commit 358c258a816baed4c6997b59c2117578a1360498.
>
> Jerome actually pointed out why that stuff doesn't work in 2016:
> https://lists.freedesktop.org/archives/dri-devel/2016-March/103062.html
>
> Unfortunately the revert somehow got lost.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: 358c258a816baed4c6997b59c2117578a1360498

Fixes: 358c258a816b ("drm/amdgpu: allow write access to mapped userptrs")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 3adaa4670103..331969b96a5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -433,10 +433,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev=
, void *data,
>             AMDGPU_GEM_USERPTR_REGISTER))
>                 return -EINVAL;
>
> -       if (!(args->flags & AMDGPU_GEM_USERPTR_READONLY) &&
> -            !(args->flags & AMDGPU_GEM_USERPTR_REGISTER)) {
> +       if (!(args->flags & AMDGPU_GEM_USERPTR_READONLY) && (
> +            !(args->flags & AMDGPU_GEM_USERPTR_ANONONLY) ||
> +            !(args->flags & AMDGPU_GEM_USERPTR_REGISTER))) {
>
> -               /* if we want to write to it we must install a MMU notifi=
er */
> +               /* if we want to write to it we must require anonymous
> +                  memory and install a MMU notifier */
>                 return -EACCES;
>         }
>
> --
> 2.34.1
>
