Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D8FC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 13:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9B10E4FA;
	Wed, 19 Mar 2025 13:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cryogf4v";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEC710E4FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 13:09:47 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-301a6347494so383861a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742389787; x=1742994587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v46vHtFLjZ6pKGHwpW89XNp8xdhO1DsFG7kpt3FyD+Q=;
 b=cryogf4vuA+QK47bIMn/SL+GZEhTTYmfDPjFUeRyB+amRYDuFQthbdBru4pZA1cgqY
 odB4FKAy1cm0+IHTwyVX2AuiOhkZuSJwvieKXC3qLHgvoi4Pcg9Tax6iuXi6oYpZG1OV
 F5dQqeASQX1tSWx/RaEXZ3diUVByFeik6mBDeDkGmBALRfpzghv++oPsJSUPzO6n0T0J
 4fPDo0ZrYIKBQoXIjAQPW2QyvHnW/xJP9bVdeWFXJJ6krBcR1Egpi9PgClM/O9S8MrFO
 /JDNGUSfLc42t898CxF786EBa4QL3a9qRse3XWTUUePU8U+Pjg0s3tLjRMBAg3fbWb4l
 RpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742389787; x=1742994587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v46vHtFLjZ6pKGHwpW89XNp8xdhO1DsFG7kpt3FyD+Q=;
 b=CG5yE21M/N/2WaUgCX2Nx8u+6xW5CHLq+jhIexLqnd+MnCeqyPKufAyPIwkePUpLPU
 PnUeePeA5NFGT/6KlIk1xyQh6HW2fY//iUUlDsPDKYVaoL3GTwt1Lex/dq5AZ+9fXMBF
 e0Qp3Gr6GF+StiRx4GtP35m4JCzFppwh9ksMf2qsR3S+RVDwY3my7l76+SfLGsYDWkdQ
 8aR0kKH93UmazxVdemc0MpyEtJ00JPkgq4yvZ8HpMrLRlgrqxwwZ7sdQ3GqmG0pFOHFt
 fz2SXZfmxXf/eYE2/Au8cxoSUl/1bkmK7Tn11VXTFijQNffTfyw/mRmuILkP/NOeAlEP
 ukmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHu3GPsxjpBAIDMbA5/7OMqUCQylXOfXFQM4TGQvNWjYT2BQE2NbhxCLxbJpKq5vTS1abMVyBL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8b396wsEMp8a9wPqIeXi8bGOe/LpvzCmmdmZpvjXq6IgF2yry
 Kh8vRfjPbdQ7wOLk3NFr2xnARxF6xGnlKTvbnpEOsSreAPZQwu896BwHwVx7cZVFV8wq8Uk5Y2r
 ohfauhAMQ8zQoTI4oKYjY235LC1k=
X-Gm-Gg: ASbGncuV+iDE4iZE+kFD2IodS0oN4JqfJiUUcJczBgKR+QDV+y5h96rU0W4RESfiigx
 gVV7YwT0Jb1J+ZNpP73EHr8QvyQwgcGqv9fGzFNcl8GILqAYsENFvHhSqfWQhpCk3vpuMEdsmH0
 rCncdWyS+oll3mcLoOlQGRPAnZDy3R77vyNcFv
X-Google-Smtp-Source: AGHT+IED6VBDxCko6PEW7bsFZMarAXAqdIlsBAukGkOCk4FQSVi2opVcyrLfpM06Qtbf2yinkjnM7DgRrJ68gp6guOY=
X-Received: by 2002:a17:90b:4b04:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-301bfc73453mr1213192a91.3.1742389786768; Wed, 19 Mar 2025
 06:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-7-alexander.deucher@amd.com>
 <DS7PR12MB600516A56433E841BA20BD3AFBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600516A56433E841BA20BD3AFBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 09:09:35 -0400
X-Gm-Features: AQ5f1JpyWspRWB2JMYK8hIs11Kex6f6Jrw687ztSUq4bWYjoFM53q2Xp312sH-Q
Message-ID: <CADnq5_M-4JbuVqoWGT-LXDa0-Bk_5Qn1tw+LO+LT165-4G78ag@mail.gmail.com>
Subject: Re: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
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

On Wed, Mar 19, 2025 at 5:03=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, March 13, 2025 10:42 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> > <Sunil.Khatri@amd.com>
> > Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
> > disable_kq=3D1
> >
> > If we don't have kernel queues, the vmids can be used by the MES for us=
er
> > queues.
> >
> > Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
> > drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
> > drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 971bf01fe46a9..a536a78342a09 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -106,7 +106,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >
> >       adev->mes.total_max_queue =3D
> > AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> >       adev->mes.vmid_mask_mmhub =3D 0xffffff00;
> > -     adev->mes.vmid_mask_gfxhub =3D 0xffffff00;
> > +     adev->mes.vmid_mask_gfxhub =3D adev->gfx.disable_kq ? 0xfffffffe =
:
> > +0xffffff00;
> >
> Question: Why here only set some of the GCHUB VMID to validate? Is that V=
MID reserved for other specific usage?  While it seems vmid_mask_mmhub is n=
ot further used in the MES FW?

None of the engines managed by MES use mmhub.  GFX, compute, and SDMA
are all gchub clients.  I suppose we could actually set the mmhub mask
to 0.  Driver manages mmhub for VCN, VPE, etc.   When we eventually
enable the umsched for VCN, VPE user queues, those will all be mmhub
clients.

Alex

>
> Anway this patch is: Acked-by: Prike Liang <Prike.Liang@amd.com>
>
>
> >       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> >               /* use only 1st ME pipe */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > index 95d894a231fcf..19a5f196829f3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block
> > *ip_block)
> >        * amdgpu graphics/compute will use VMIDs 1-7
> >        * amdkfd will use VMIDs 8-15
> >        */
> > -     adev->vm_manager.first_kfd_vmid =3D 8;
> > +     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
> >
> >       amdgpu_vm_manager_init(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > index bf8d01da88154..a2f6c9f4ebf2f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -838,7 +838,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block
> > *ip_block)
> >        * amdgpu graphics/compute will use VMIDs 1-7
> >        * amdkfd will use VMIDs 8-15
> >        */
> > -     adev->vm_manager.first_kfd_vmid =3D 8;
> > +     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
> >
> >       amdgpu_vm_manager_init(adev);
> >
> > --
> > 2.48.1
>
