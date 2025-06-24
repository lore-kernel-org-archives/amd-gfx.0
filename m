Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98A0C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 17:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1D510E608;
	Tue, 24 Jun 2025 17:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tgurzkb9";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC5E10E608
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 17:06:19 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-313067339e9so592031a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750784779; x=1751389579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fT0ShTBLUj9DynKgpayj9EV4d1NX6Tdc67pEj7oFFAY=;
 b=Tgurzkb922iCyfSAuHUyjkgosEAg3QrAgV0X1Lk1n804BvQ9ECsTLvpOo53dZ0du2r
 3N/ORoaRp3NDMema+1wulfKL5CKmfdu+6yXgM1wHwSNCzMzu0fN7X1jaT2LmGsbgP0YF
 qmi46UgRpfIvnBQQLp76CLUrska5/i64bQrjFVLz6Uh5pLtZL2Y1xwREhXpsHH3sWSx6
 BaZG6q4Mi1q9llLuoq/Ry7hH5o8TI7W4ZnFkEUmMzO7F73EMbexFa8psmvNQFqgxKu9g
 miAcGdFieMfu0escLVKP4cXed5NqrIiBBy6w2HSW2YASbeL5kPsHBYfgaWK5G2UdTrlX
 GqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750784779; x=1751389579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fT0ShTBLUj9DynKgpayj9EV4d1NX6Tdc67pEj7oFFAY=;
 b=T6zjvV5Ptu1fnOZkc6F8IeGeqX/LyPMgYkxeDu5UMS9yDYIJbc0IlqCGhMcQ4X2HKY
 LxtrAlIjHmuvPmI1ap94iV7okOdZfeNQFqOKsyd5rJWabFaZLSoi3yb/ecUMLFqPrOZI
 2m5JmKMH33isWnoAz4tAt8NhvZTsW6nZMM8Qe0y8+6rXOOOFM9cGlrcqiPdg54DT3YDZ
 LY7Y5RznnOX0hEG8EXIrjhr//YhHC9OoNeA9xrZTNS6y/gZHksjbg2e/SCQMpFDC0zm7
 XziUKL5OV+tL0z6fj3li458MggHY09FokKXCKSmY98qqVBKXmQl7U3oTGS7aZ3s4pT7H
 aEoQ==
X-Gm-Message-State: AOJu0Ywcgh4NUY9TD6d2CXzn8fJ1Ulk6yE8+WNcZTIyCFcE4E368oo/p
 jnln3GP4sIfjQNYPkPpKiNnbWzMfIIFcybLFA+BC/BxHopXQRg8tucsUHSNby0OgApB+nlwwA+L
 QQWWbLNGOvsAlbfm2Ce5Ahom8MQiXJwqfU/QK
X-Gm-Gg: ASbGnct41dnUQhzJbb6a8yGY3QT4gTU8wxLhlGwLwSviP/rGbRiuEP/6pPCw+CrjMyn
 YK5NyD5bTI50uKHdQpnYezGXU+J7bbAFGl9p92dClxCPnuVwhCDUU6U7r+mLV1i7Xb0H2+HlGsC
 RPAJGpqFTF+8M0Wki17QSSFt7tGNBe1gtBLMg+zrgPUc6M
X-Google-Smtp-Source: AGHT+IGSsE3IX6hQgjZJXvmLu9PVrFrXApKnQ6dcZsVaH+KP/euStut6RJQ0v7OxLGMTdm4jPjYIhgvBCiqzwO2p03o=
X-Received: by 2002:a17:90b:17cb:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-3159d8e05f7mr10116057a91.5.1750784778694; Tue, 24 Jun 2025
 10:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-10-Prike.Liang@amd.com>
In-Reply-To: <20250624084535.1178476-10-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 13:06:07 -0400
X-Gm-Features: AX0GCFvyyX98_os0DOvyltN6EODxVyypM7k3GWvjPu5iJL5wXMYMLOcmd3DF3t8
Message-ID: <CADnq5_ME8GNEjZdkfjGAEL69=PqOtLVui1jqao3JmwK1XMnHFQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
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

On Tue, Jun 24, 2025 at 4:46=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It doesn't need to attach the invalid eviction fence
> to non-userq's BOs.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 2c68118fe9fd..50356aa23a99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -294,12 +294,14 @@ static int amdgpu_gem_object_open(struct drm_gem_ob=
ject *obj,
>         else
>                 ++bo_va->ref_count;
>
> -       /* attach gfx eviction fence */
> -       r =3D amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> -       if (r) {
> -               DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n=
");
> -               amdgpu_bo_unreserve(abo);
> -               return r;
> +       /* attach gfx eviction fence when userq created*/
> +       if (vm->is_userq_context) {
> +               r =3D amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> +               if (r) {
> +                       DRM_DEBUG_DRIVER("Failed to attach eviction fence=
 to BO\n");
> +                       amdgpu_bo_unreserve(abo);
> +                       return r;
> +               }
>         }
>
>         amdgpu_bo_unreserve(abo);
> @@ -365,7 +367,7 @@ static void amdgpu_gem_object_close(struct drm_gem_ob=
ject *obj,
>                         goto out_unlock;
>         }
>
> -       if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +       if (!amdgpu_vm_is_bo_always_valid(vm, bo) && vm->is_compute_conte=
xt)

Did you mean vm->is_userq_context here?

Alex

>                 amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>
>         bo_va =3D amdgpu_vm_bo_find(vm, bo);
> --
> 2.34.1
>
