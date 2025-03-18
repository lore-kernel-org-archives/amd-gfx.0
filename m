Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19806C28B28
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 15:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFEF10E218;
	Tue, 18 Mar 2025 15:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XJgTtuTf";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BEB10E218
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 15:24:10 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff5f2c5924so486059a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742311450; x=1742916250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TX9GkHJWm1mBQkioFH53YpDa20l+wUA3Z3iy49wqzK8=;
 b=XJgTtuTfHOEsxBWfYJ5CxlI4SIkIBVCqJA+XknDZq09dOt5Squm/bS06CK5Gmc4NV5
 lnLRdKjyLgQqNg7VvaZKx8a17FIwq3OantG+e/9qKXFE2gmdfmUHMhbglVWFdyrzzNZj
 6T9JdH2/9vPx5ay2WGJ1qmzAfJOtKYHgZMqzBsfspYt+Bgwt0CH/GQrHNlRvw8MhzfFr
 RWbuum4/5PRCzh0o1+gSy53sZChTPL6u2umo7jERYc7pd6JOBQLVTJzROWx4k4XcvPfx
 BlN4j9BasjiV+PqeacnBTI0udTnXT2rrxoQvW7tAzWp8ifQSz75711dLCLkGlos1XSem
 4q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311450; x=1742916250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TX9GkHJWm1mBQkioFH53YpDa20l+wUA3Z3iy49wqzK8=;
 b=n90Iupm4M/ZElw0h8fa89aVszVct4ANm9PaEzc6kOlnRuSvQy5SfgaUT3sIm7luf4O
 eQ5yeqmUhpxoPQ+5qM2oA1NoBAJDrzydpZB2x03/NfPDlqIG1acih3CN1VISaCUbQXDl
 vDM+91n2kfxPvLP9Z9IoaM+kN2vtgxqepokFoz2cbMm+c9o/WddsqGPVHuWGfGWqnAD7
 fRADRgyF0gOLiounwaB80j741VOLE9ibyUFutV01azEHiXWvsr+rfscilRZByj7meTk1
 jBzZlcJ3AtqkgveJqyQ5USSywHbGCttY1yAPcLQCmSxMne4WKj13ysJf/mFw6V2FfQi3
 +7xg==
X-Gm-Message-State: AOJu0YygGeWJYA8AdddX/AlED0sIlkE25kdjOcT0yKlHLVjRlIg4w4q8
 ymeVjJrK6At+0Zmr+VrUHJwzxNAzUhoOOG3WcllkjaD0naRPzYPZib6AA57x/MXItvdO6sjNq/R
 USabm+q+S42kuNdGSiBxCKK1cZpI=
X-Gm-Gg: ASbGnctzkMJqUXj0uNw1qDYpMuI5xUhje2F75SY12NNxuVXOaPDP2q09RBqey8W0d5Z
 kP0EB7QWs69WCSmrPw437e79Z5sWJHoqpTde7qnhNFjADFlH33VbLVLszlTAvig+KPEow3iKazU
 btsXrIyMuk37OctVM91pkXB6RMxS1Okl1mDlcm
X-Google-Smtp-Source: AGHT+IHch57HZfHEHalJOUMVMO+yKh14djWaTnQGa0Vj41CZDzVvalEKw3JwQym0mT7hUjF7BixUb/8QXvo8GZuivTc=
X-Received: by 2002:a17:90b:4b12:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-30151d8e5camr7716892a91.7.1742311450243; Tue, 18 Mar 2025
 08:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250318151915.5413-1-christian.koenig@amd.com>
In-Reply-To: <20250318151915.5413-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 11:23:56 -0400
X-Gm-Features: AQ5f1Jp3nZDlOhhhD6Bszd75ule_aerCgExbYKP-bcLow4-sBdMekLSCQv3LFlk
Message-ID: <CADnq5_O1sRU4meb+tRUZ9RTH5QS6enh2oUtYTViiPH187BtyAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove invalid usage of sched.ready
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Mar 18, 2025 at 11:19=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> I can't count how often I had to remove this nonsense.
>
> Probably doesn't need an explanation any more.

Was actually about to send out the same patch.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 65fa583c34a4..9cb499195fff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -2675,7 +2675,6 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_de=
vice *adev)
>         u32 tmp;
>         u32 rb_bufsz;
>         u64 rb_addr, rptr_addr, wptr_gpu_addr;
> -       u32 i;
>
>         /* Set the write pointer delay */
>         WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
> @@ -2730,12 +2729,6 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_d=
evice *adev)
>
>         /* start the ring */
>         gfx_v12_0_cp_gfx_start(adev);
> -
> -       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -               ring =3D &adev->gfx.gfx_ring[i];
> -               ring->sched.ready =3D true;
> -       }
> -
>         return 0;
>  }
>
> @@ -3083,10 +3076,6 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(stru=
ct amdgpu_device *adev)
>         if (r)
>                 goto done;
>
> -       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -               ring =3D &adev->gfx.gfx_ring[i];
> -               ring->sched.ready =3D true;
> -       }
>  done:
>         return r;
>  }
> --
> 2.34.1
>
