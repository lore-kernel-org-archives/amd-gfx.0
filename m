Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7854C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 19:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BD410E4BA;
	Tue, 23 May 2023 19:44:10 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB7B10E4BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 19:44:09 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5527167350bso122862eaf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871048; x=1687463048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+nbXvFGrie6ps98oa1KVBb5kP1H+pqqaVxYuszxfcc=;
 b=eVKfFQByBDuCB1GkutL8m3/X0/IFQeEbV0eEhykP4GHRNUTXy6l9+kGYUojOVJsxOH
 fbY1nBZYMs3L5BIsrTNQdhRE0/yrsYfAW2WAR7bIMiJxhKzDpYwu8zP/8bwFthCyXB4l
 kAdzDDlfeIfyUjZp12eaMEuAnu/FnOJ+cEfcCL9Gi/uz7dMUou8UJ73e3RkYGHTOxwFP
 EH9xZd8uxYLgKoocYNJUf3Er/D5GEk47zQvT48rb1VJ2zVqp7oswNEuseT0p8yUHILqF
 HML3NcVrkzmMurHJoFG8l6O8FZD5xYWPk+LBQSQcuAICBD2q8svxNlsxWTpsdXu0t78D
 9luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871048; x=1687463048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+nbXvFGrie6ps98oa1KVBb5kP1H+pqqaVxYuszxfcc=;
 b=PKgMhY4BeEHZ8EI/S60Gm3i1YGSsY7aOc/0y4jD9+GV6vqePAQ1W8iL7ZigXahE0XI
 YexVcaEdDeDj1yLhIYpgeAezW3OIUvQs6TYDjDhjPhtt5QG9eYQgw1wpK5Nx6Ir4DDQq
 btTGgiAFgiwo55ol5JNdzL0yVzB829RZ7f/OniExOhk1wMBGlRi4yS3VE6HOAeWxj5Wj
 DDoCVQpb73EzTPXARno/73iW6QYwga4ILkITbErUtYuA8JOvfs9DTg2z1GdpIz7NYKMV
 NBcQgXvNnG1L4eCMV+Q6kTcGEj3P8IVMQFxWzRRABv3HxJy/a+ELvUvZNNs+sGtqQsB/
 v4yQ==
X-Gm-Message-State: AC+VfDymDa72fmaO79KzxYOtcJHQmmLxZ5GIqNfXeTscHH7Eluwp9hmN
 oKcvqmq6ugfoyfsQdrJFHPgOXoYHGISdHfajk7H8rNZ2
X-Google-Smtp-Source: ACHHUZ4JPlUWrQ56uUiN0ToXK9qh+Mi7OSBA3GDyaEkxJs2keIPRTf/aHCGgkcFAHE6TZezF0pb7jKWnrDMpIF15uUg=
X-Received: by 2002:a54:4019:0:b0:38c:6654:a61b with SMTP id
 x25-20020a544019000000b0038c6654a61bmr8332184oie.0.1684871048279; Tue, 23 May
 2023 12:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230523190634.3094481-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230523190634.3094481-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 15:43:57 -0400
Message-ID: <CADnq5_OBsjsT=LrWEGbTAUpA-bdCEmWT9pHRUSWTzBwAUcm9Vg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix unused variable in amdgpu_gfx.c
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 23, 2023 at 3:07=E2=80=AFPM Srinivasan Shanmugam
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 2b4bf6c11ae4..a33d4bc34cee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -509,7 +509,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev=
, int xcc_id)
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 j =3D i + xcc_id * adev->gfx.num_compute_rings;
>                 kiq->pmf->kiq_unmap_queues(kiq_ring,
> -                                          &adev->gfx.compute_ring[i],
> +                                          &adev->gfx.compute_ring[j],
>                                            RESET_QUEUES, 0, 0);
>         }
>
> @@ -541,7 +541,7 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                         j =3D i + xcc_id * adev->gfx.num_gfx_rings;
>                         kiq->pmf->kiq_unmap_queues(kiq_ring,
> -                                                  &adev->gfx.gfx_ring[i]=
,
> +                                                  &adev->gfx.gfx_ring[j]=
,
>                                                    PREEMPT_QUEUES, 0, 0);
>                 }
>         }
> @@ -648,7 +648,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev,=
 int xcc_id)
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                         j =3D i + xcc_id * adev->gfx.num_gfx_rings;
>                         kiq->pmf->kiq_map_queues(kiq_ring,
> -                                                &adev->gfx.gfx_ring[i]);
> +                                                &adev->gfx.gfx_ring[j]);
>                 }
>         }
>
> --
> 2.25.1
>
