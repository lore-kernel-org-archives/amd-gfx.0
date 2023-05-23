Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8219C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 18:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FEB10E114;
	Tue, 23 May 2023 18:37:14 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D967E10E114
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 18:37:12 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5552cbcda35so59532eaf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684867031; x=1687459031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkM7bryN5f5dxX2x6wYeiqEIXKDhlh6/uNs/39OOBIQ=;
 b=Epf9JNtnUva8ThLNDH2Lh44JcRLJMvNirMpBrmbaAn9g0mHzSmAuU/0qjEJsSRiCHL
 NrJZqGj3bVdqWrv3oDVAynSvHHz6zT0nyIharQ/7KNTrdJCkVSbDIiYUNiZ9WCHMjM6o
 XB2V1dAMsQ2DcfzSql4PS/tXZTFZBVYC0CHHxE/ckFTd0x2bNd+0VC2SXjmvSUBw4/aW
 YGgvrXDYZwWYvAxtff87+s7naUP5StaLQhC9LwsP9GkGDDDq6oIBvYp8+Z3FfT6nxAaZ
 5oP/Iasswj47OM3fqbRKcNedW0yElGJj+NDcc3znuDbCa+xZ/fAvhBDBe6k1kVhUgOlX
 oHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684867031; x=1687459031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkM7bryN5f5dxX2x6wYeiqEIXKDhlh6/uNs/39OOBIQ=;
 b=N0zXn+j+JSWpjvbesZ8rXZZHvl+uj3c0vVTnh4NG0iwaaiesKHLfNgHQHAnTsjdBPc
 cke3fR7Vwny4P5QA162yDPPt1R0KzJ7hEA1sUSLxXrTj74jt0jRHNWo0+JyDVsP+iWen
 uQsUgJ2jSg4l3iqH91JzDbO9W4UJRsNiqtlnsszYa/Y1x6g/DtPRktCmGEZB+V1NtdpD
 lb5WA3+DcvoePT+xTS0gaaZGkpF/elYVKIne4CdgT/pic0uGkk1gy5XIPLOqmVbN+uRc
 sOtIIXC42JRlTiDOlZ6jwPKO4g2GQ+sGC+E7PtwDqoub6tzE3Q3BGHwMO5m66FWTynSn
 3gdg==
X-Gm-Message-State: AC+VfDy2m8Rwmj9wRv8pvkPpGwrF0aeADSvGN1p47R/lCSbOfNu6XWG0
 tBHbAsei1tRJowxbRc0psoEhK4rgOeprWZ1Qq0s=
X-Google-Smtp-Source: ACHHUZ4WjQdgYvmkh8TRn7y3g/14LR+HWtSksYtBSGrsLCEys0Z+QBACsvR8U1rGg2hYD496IQIzRhEcvRQCjn6MIr8=
X-Received: by 2002:aca:1208:0:b0:38e:7fe:2ca5 with SMTP id
 8-20020aca1208000000b0038e07fe2ca5mr9125144ois.52.1684867031406; Tue, 23 May
 2023 11:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230523183118.3080904-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230523183118.3080904-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 14:37:00 -0400
Message-ID: <CADnq5_PFOtc4bQx+5pmg=+_9Ho_Zdr_c2oiBF5r8ggcri8f+wg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unused variable in amdgpu_gfx.c
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 23, 2023 at 2:31=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function =E2=80=98amdgpu_gfx_=
disable_kcq=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:497:6: warning: variable =E2=80=
=98j=E2=80=99 set but not used [-Wunused-but-set-variable]
>   497 |  int j;
>       |      ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function =E2=80=98amdgpu_gfx_=
disable_kgq=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:528:6: warning: variable =E2=80=
=98j=E2=80=99 set but not used [-Wunused-but-set-variable]
>   528 |  int j;
>       |      ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function =E2=80=98amdgpu_gfx_=
enable_kgq=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:630:12: warning: variable =E2=80=
=98j=E2=80=99 set but not used [-Wunused-but-set-variable]
>   630 |  int r, i, j;
>       |
>
> This variable is not used so remove them.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 2b4bf6c11ae4..c7c16d6c476a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -494,7 +494,6 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev=
, int xcc_id)
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
>         int i, r =3D 0;
> -       int j;
>
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
> @@ -506,12 +505,10 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *ad=
ev, int xcc_id)
>                 return -ENOMEM;
>         }
>
> -       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               j =3D i + xcc_id * adev->gfx.num_compute_rings;
> +       for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>                 kiq->pmf->kiq_unmap_queues(kiq_ring,
>                                            &adev->gfx.compute_ring[i],

I think this should probably be j here rather than i.  Same for the
functions below.  I swear I saw a patch which fixed this, but maybe it
never landed?

Alex

>                                            RESET_QUEUES, 0, 0);
> -       }
>
>         if (kiq_ring->sched.ready && !adev->job_hang)
>                 r =3D amdgpu_ring_test_helper(kiq_ring);
> @@ -525,7 +522,6 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
>         int i, r =3D 0;
> -       int j;
>
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
> @@ -538,12 +534,10 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *ad=
ev, int xcc_id)
>                         return -ENOMEM;
>                 }
>
> -               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                       j =3D i + xcc_id * adev->gfx.num_gfx_rings;
> +               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                         kiq->pmf->kiq_unmap_queues(kiq_ring,
>                                                    &adev->gfx.gfx_ring[i]=
,
>                                                    PREEMPT_QUEUES, 0, 0);
> -               }
>         }
>
>         if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
> @@ -627,7 +621,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev,=
 int xcc_id)
>  {
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> -       int r, i, j;
> +       int r, i;
>
>         if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
>                 return -EINVAL;
> @@ -645,11 +639,9 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>                         return r;
>                 }
>
> -               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                       j =3D i + xcc_id * adev->gfx.num_gfx_rings;
> +               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                         kiq->pmf->kiq_map_queues(kiq_ring,
>                                                  &adev->gfx.gfx_ring[i]);
> -               }
>         }
>
>         r =3D amdgpu_ring_test_helper(kiq_ring);
> --
> 2.25.1
>
