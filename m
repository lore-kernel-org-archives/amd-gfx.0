Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6586EC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 13:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084D510E35B;
	Wed, 19 Mar 2025 13:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="me+0JMUJ";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F206B10E368
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 13:27:40 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-301a8b7398cso369939a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742390860; x=1742995660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOXBqZPyHalNLiByG6GGWIZt95+Ci7ExFChQ8BoWCRo=;
 b=me+0JMUJu40h4rz4wZ1vqvjLZpV3eP65GMxzPaG1vQukiiRnYLUJrM7gJBzMg9uVmz
 ir/h3ZOpX2g7qyUMvnaQXUPMQsJLbuBRewGv6nzSYyF7UknBBulEMR6R/nKRlZmD9Hw5
 J1MFredWdtqbgrXNLKleRQrb+b0oXK7mdSLxz0DFoFIYjWoCLn8HEbU6w6TsAhRLVeeb
 t7+1awehNprjNzyxTFEZUdUpA/wny6OwXuM2xSQmIhqjdN3bMh+zu2dG0ca4ZYE0u6FV
 KJAikWGXDR47U98mkxNNKQyH7AkTXW25EH+0fz+pzPKMOnT1BPerHv/UcbCsJ0AwXyrW
 vEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742390860; x=1742995660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOXBqZPyHalNLiByG6GGWIZt95+Ci7ExFChQ8BoWCRo=;
 b=lCFTR1QiOuIwSetIMGc9BcTdWL3I9JD/FMUFKeV34kbljNP1N0kQYyBo/fhOfBOt2D
 bVHImCwvdaZlk7fq3bCZklIhMQ9qnBQDGXSRvnoQCJJuwyd51arRVctF+tvi5okFPTvS
 BNgFRFBo4m/TbEX68avcGoTiolmQgvdUcF9eBG0A4iZzaTQARpjh34gVxz31WWsLN5sU
 0rWqLduJp/HJfnTqbCgA0qkyFvIewl8u5J7XjGZGcSB2DS3XuM41quz+W9GADgdK1pj0
 6HIX4GVjk3HkM6DFOp0bMrythkln3m0HIjvdrQrrh47Mn8XQxL5bk2vvFHpgq8rRD+6W
 jgHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrUW889hT7kxCGoYatRvWIaAtIB0suwMZEEi/s9GUYqD9qCg4wrAlvaQqgjUcIxm09QwDUrXv0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXEFjgj2cX+dfhcC5n6NkRdeEjEqj4OlE2MtC+yUZSvwHoTPCp
 JiLXdcF+daYA6hdYEYhJ+G0gY2FvCtT2935A35lDpz2ffXv4K3LKQqg2kb2Pf4DvRV1U8VvxKCP
 N2bC3xz+ost/lfe1q9XZw9dqNyZMTJg==
X-Gm-Gg: ASbGncudeIz21wnFFSIVFgo+nD27p7ykjleMGYGwXWL7I43HeVHQFoNBoyw7+oEaEpu
 hkoaUPMpYxz0/QHxzUxdBtYBle/ZdBFci6cPeUn5AMCK/v/83HV+J7ssoIXtC9d1ERqt591cyRX
 pNUsyG79ODMx+3+i1Zr8zRtXv03g==
X-Google-Smtp-Source: AGHT+IHWFG4Y9hNYWM0yla5xEd51fQLW3W3xlrukfzWdMkdFnCL5rhbvaQABrCaly+0Be1sIIl5Ib2zKRR+7lNYQKjY=
X-Received: by 2002:a17:90b:33c4:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-301bfbd3585mr1335416a91.2.1742390860400; Wed, 19 Mar 2025
 06:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250312185731.211350-1-alexander.deucher@amd.com>
 <20250312185731.211350-6-alexander.deucher@amd.com>
 <DS7PR12MB60050B97E4066E9841BC4BFBFBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60050B97E4066E9841BC4BFBFBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 09:27:28 -0400
X-Gm-Features: AQ5f1JoaUlKXuyny4DcGO-y4fu8NZJc-5RvZDHuSggmvD4RN_NMz2SSLK0_aEGg
Message-ID: <CADnq5_Ma2snX-WtKDCFE5ChxtuW-i6d04YsrAbp_HhQ+KNh+uw@mail.gmail.com>
Subject: Re: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is
 set
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Wed, Mar 19, 2025 at 2:42=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, March 13, 2025 2:57 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> > <Sunil.Khatri@amd.com>
> > Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq=
 is
> > set
> >
> > Make all resources available to user queues.
> >
> > Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
> > Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 5abc1ca0fee98..971bf01fe46a9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -120,21 +120,21 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >                        * Set GFX pipe 0 queue 1-7 for MES scheduling
> >                        * mask =3D 1111 1110b
> >                        */
> > -                     adev->mes.gfx_hqd_mask[i] =3D 0xFE;
> > +                     adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_k=
q ?
> > 0xFF : 0xFE;
> >               else
> >                       /*
> >                        * GFX pipe 0 queue 0 is being used by Kernel que=
ue.
> >                        * Set GFX pipe 0 queue 1 for MES scheduling
> >                        * mask =3D 10b
> >                        */
> > -                     adev->mes.gfx_hqd_mask[i] =3D 0x2;
> > +                     adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_k=
q ? 0x3 :
> > 0x2;
> >       }
> >
> >       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> >               /* use only 1st MEC pipes */
> >               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> >                       continue;
> > -             adev->mes.compute_hqd_mask[i] =3D 0xc;
> > +             adev->mes.compute_hqd_mask[i] =3D adev->gfx.disable_kq ? =
0xF :
> > 0xC;
> >       }
>
> Question: Why there are still only partial gfx(queue[0,1]) and compute(qu=
eue[0,3]) queue can be set as validate?

Those are the hardware limits.  gfx11 supports 2 queues per pipe for
gfx and both gfx11 and 12 support 4 queues per pipe for compute.

Alex

> Except that, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>.
>
> >
> >       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
> > --
> > 2.48.1
>
