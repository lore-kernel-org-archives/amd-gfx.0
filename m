Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C796C52D71
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 13:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED1810E51F;
	Wed,  7 Aug 2024 13:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="esWj3jy8";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B19910E51A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 13:48:52 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo445559a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723038532; x=1723643332; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1/H6PMH31t6lpdrhga2IYeR6m/2LHhBVc92rGBUEEo=;
 b=esWj3jy8SAx0tcR5jc+iI78uQp6Pmoc0+7DIb/FVElU9YYlmv7qw73vvCnz4q+TClQ
 F6tYSPoyVBKOnvKAyYQc/o2HKev7P2TX9RKOPmO6BL9Ng7fNanbZe5A5c2kQoJuTHTkL
 7PSJMici5ZzZCzCxXVgCYTl5W0khtCe2E1m5OTDK94B3NyTl0ZnDqDi0+MHSrNG+2LRI
 EoK+xBVWTyimLRqHZoKNpCEBeUCk8IbYFWWaR6XkJcjJVUvWTl/Uxa9em+AZxvPPuf6s
 Ri7do2hehTN4x1Rsef9vVxrAdbh335cDpiwBPGTv79in/WWK8TwlsmQJobmMprsydCPw
 9WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723038532; x=1723643332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1/H6PMH31t6lpdrhga2IYeR6m/2LHhBVc92rGBUEEo=;
 b=HB1WeyzsbDQcDgOdX+DeLwymk2Kudrm3JjseSnDkF4GtLpAmSAFvoXdrwk1gp6DLUW
 IpukMSZCWZIW9FvOD+i19+Wg5gOItqd4UYGoWmvJplddeiQVmoV72enVHw7i+5OXCnCe
 9GL5wUNDV/5/P6b128/p94BGpWx/a60GepXNq7Ht8coScZTuhLocJhF7cCJ9JP6gdzfK
 jiv8wOW87hW2coL2L2LU6pwerXy/1MpGxLh12HNLqHjTmtYwsN02r+4OLW6a+CsmmURX
 d+UE+N5snHzgz9JboL5TtUrrhapnBzhZb0NTW9uVLY2ei9CjJDVXnAXPID03XXdDpUHN
 iEFQ==
X-Gm-Message-State: AOJu0YwPYuCwyIQRsZssQE7t5sxP75NW2YlPi+NusP4IBowBGbMn80s5
 jlZGDAQE6NlmzADyNT6DFGgLelYPLuarbKvD4i/9i1RqxOLGp/DdXBD4TtgV8DiVweKVN2WNVbt
 sfen8Nf7RqXQtG1yk2CCe2WSyp84=
X-Google-Smtp-Source: AGHT+IFJbaJ5WUI/Cv66YbVLqgwp831w5wX/oaC+n55lT9bEJCnHdNuXTVXDMe17mntPOKN3GdC1I2hZHYEy035BGdw=
X-Received: by 2002:a17:90a:e184:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2d1b2d6ae95mr3231102a91.14.1723038531626; Wed, 07 Aug 2024
 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240807102612.2095510-1-Jack.Xiao@amd.com>
In-Reply-To: <20240807102612.2095510-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Aug 2024 09:48:40 -0400
Message-ID: <CADnq5_OgBLoi96ZF=uRYmrBWmMijYQh9qeUO6VTSM1X83ihisA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/mes: refine for maximum packet execution v2
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 ckoenig.leichtzumerken@gmail.com
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

On Wed, Aug 7, 2024 at 6:26=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote:
>
> Set sched_hw_submission=3D8 for mes maximum packet execution.
>
> v2. Only set sched_hw_submission.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index afcfcb786eda..ae9567c51490 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, stru=
ct amdgpu_ring *ring,
>          */
>         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
>                 sched_hw_submission =3D max(sched_hw_submission, 256);
> +       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES)
> +               sched_hw_submission =3D 8;
>         else if (ring =3D=3D &adev->sdma.instance[0].page)
>                 sched_hw_submission =3D 256;
>
> --
> 2.41.0
>
