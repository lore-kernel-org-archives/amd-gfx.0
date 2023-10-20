Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0310C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 16:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F8310E079;
	Fri, 20 Oct 2023 16:37:53 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A75B10E079
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 16:37:52 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1dcfb2a3282so692790fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697819871; x=1698424671; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaBoCk8Wmd3PLFg95Z3fb9GDjYjVfC7FRTiL7n+f0B8=;
 b=knrQDuO49Mgi/MIXChIDmzCbi+RJ4+Mj/zirU0s0f2ljKqPzuiFvjk3aY0etw5WUHD
 CKmpbSzunQ9op5cF4Q3tCYCak8YiO/KUEs5UMkL9D0U9oBovPFa66nSiY/MBvTZ2NINn
 J2EQOSZHte7VwRWYkHlR7+/Z1UXF32JkwrZ1EqEK1ksKUU5vhFoKvZFSfK4cBtDbK2lh
 l0TI/VK6O8RvGMl6Ic+BHIbDEUS7FYF/O9lgfrHtO8/JkoTrsw9H8OvtBVn5T+ofn3VG
 dLOCvBNJzVrT0FHhbaUaPbUbTq5DXurX/qrINgP+xTsQUroEZS1XB7BP8lFv1WDtwZVK
 k8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819871; x=1698424671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaBoCk8Wmd3PLFg95Z3fb9GDjYjVfC7FRTiL7n+f0B8=;
 b=V8RZnMRH1rHPwGqLwVt+9zVe31rV2TdDSAl/SZoJbpw/zqBHAdZ54EX10ree/P2w7V
 msLHX8jxjc3bS0bl5pr5RisF5s5hQiLIlOBxnzxe6uQnj8ATgQTsJDAr2DkU6skkaFSM
 0lmH8Yf6fxp/uby2O1+/a52wbqW+C7QJeguMjCskvN9c3ZErJZHJ0ui/LblbHtNZNzb4
 RasWcbd6uY0d52mcbvll5VbUMp5OKq+CC6X8Cv1JaZ9cu/KyFxfVUDwkMt3HMYpnlipy
 pknOfWZatKtBB2mkq/50VfZIJqUqvKfbdMoAr1sC62955flG8MEWaDJZJcVHy3ATQCjt
 WaLg==
X-Gm-Message-State: AOJu0Yy37R1mPfI5bze0wsiiKUtA5Hn558blLuvSmimRK6V5UpUE5oUB
 Te+e5ElqTRBbOXVALL7qkLUYIBM8QV5XJsCQY6+bn/+c
X-Google-Smtp-Source: AGHT+IF4XZPXy78N3lg6Ug6VYHJ8w7kWssd5sGqwOjIQvxKx3MjoNElfpnHJ7AHHrAJUwx8CWVAj7Q1O/SgGM+drUsM=
X-Received: by 2002:a05:6870:ed91:b0:1e9:88c2:ba80 with SMTP id
 fz17-20020a056870ed9100b001e988c2ba80mr2996303oab.30.1697819871244; Fri, 20
 Oct 2023 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231018010359.30393-1-luben.tuikov@amd.com>
In-Reply-To: <20231018010359.30393-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Oct 2023 12:37:40 -0400
Message-ID: <CADnq5_MSiZ6ScQyEicyKJnihssXNwNQXDVNHKbF=nAcFyymt7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove redundant call to priority_is_valid()
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 17, 2023 at 9:22=E2=80=AFPM Luben Tuikov <luben.tuikov@amd.com>=
 wrote:
>
> Remove a redundant call to amdgpu_ctx_priority_is_valid() from
> amdgpu_ctx_priority_permit(), which is called from amdgpu_ctx_init() whic=
h is
> called from amdgpu_ctx_alloc() which is called from amdgpu_ctx_ioctl(), w=
here
> we've called amdgpu_ctx_priority_is_valid() already first thing in the
> function.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Please push this to drm-misc since it depends on your previous patches.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 68db924161ef66..4c6ffca97c4512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -56,6 +56,10 @@ bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
>                 return true;
>         default:
>         case AMDGPU_CTX_PRIORITY_UNSET:
> +               /* UNSET priority is not valid and we don't carry that
> +                * around, but set it to NORMAL in the only place this
> +                * function is called, amdgpu_ctx_ioctl().
> +                */
>                 return false;
>         }
>  }
> @@ -96,9 +100,6 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
>  static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>                                       int32_t priority)
>  {
> -       if (!amdgpu_ctx_priority_is_valid(priority))
> -               return -EINVAL;
> -
>         /* NORMAL and below are accessible by everyone */
>         if (priority <=3D AMDGPU_CTX_PRIORITY_NORMAL)
>                 return 0;
> @@ -625,8 +626,6 @@ static int amdgpu_ctx_query2(struct amdgpu_device *ad=
ev,
>         return 0;
>  }
>
> -
> -
>  static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>                                     struct amdgpu_fpriv *fpriv, uint32_t =
id,
>                                     bool set, u32 *stable_pstate)
> @@ -669,8 +668,10 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *d=
ata,
>         id =3D args->in.ctx_id;
>         priority =3D args->in.priority;
>
> -       /* For backwards compatibility reasons, we need to accept
> -        * ioctls with garbage in the priority field */
> +       /* For backwards compatibility, we need to accept ioctls with gar=
bage
> +        * in the priority field. Garbage values in the priority field, r=
esult
> +        * in the priority being set to NORMAL.
> +        */
>         if (!amdgpu_ctx_priority_is_valid(priority))
>                 priority =3D AMDGPU_CTX_PRIORITY_NORMAL;
>
>
> base-commit: 915718484b8fa1eede4499a939e2e4fc0d85caa4
> prerequisite-patch-id: a36f628997d923f66da5342e760e8b45ff959fb8
> prerequisite-patch-id: f15148c302329c0c60d86040571c61d367bd05e7
> --
> 2.42.0
>
