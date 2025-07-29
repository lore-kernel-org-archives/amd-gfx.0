Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62711C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 13:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B98890CE;
	Tue, 29 Jul 2025 13:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eI6UzP1+";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC32310E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 13:08:41 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b3badf1afc0so336597a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753794521; x=1754399321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X68WelXsk8BJuvuughpps18Z3y4ZivBN2zfN7ftNueM=;
 b=eI6UzP1+2EnIk9oVF5PKomzThYzouz2MyCsElzoReicwMtcQ4W4fU4sLl6pNO3r5OP
 N4fncQdaILvXWVGPTSR5ssGpd/QD+qj0HgtdheUsBn+mkt1B7MbqMT+m7ajWRJu0vqxd
 h7wANOpEOrrOo/sLFHOWxIRUk/n1kGKoJD/ZBQDTux7qFR7E0Xts3QiKpa1/SEYE8iCz
 GjNf6LXHlZmIf+AdnP7GJKBLzlfqnVAPPqQ7XuxzH06rY+8kBW4L/za6iSP6Q68G2G2R
 R/N1aqaRW4hP5SmIoHRmNywLphtCxYTWprGyZGlBECXovqyGbz5ZiOHkt9ljctHJ3eJE
 sXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753794521; x=1754399321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X68WelXsk8BJuvuughpps18Z3y4ZivBN2zfN7ftNueM=;
 b=jBUSjKPBEXkF3qrz1d5sRDUh03ft+O9mRhYO54p+/yb4wl3qlhAK8yE2myKWSV0m1z
 apZB8ZVkayHMC3z8DKta5d4gW0TTtRuhQ+iFh65Dcag2pM/KHYVjtsjPGDr0I15fX+db
 wVvH719jhsLTrfnG4yqK0bH0fJF4RdC+aIYC38w5UZ6gIAGqixi/VuiNSburA9/6lRFc
 vkn98I30KEZBr6H/TvC17UyIJwfrhVpgDE6uz1YSZ8eTuOBP97/KKe6T27dbi3SfIOk9
 jvnK1/mppBuAyKcxyG+1Rz4d/4mGPRmY8Npazp2Mbfk1oMbMBQH83MF0p3tsLKq4iRU6
 qolw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkwutUMoWUTF3RnUJ9ZOS6KViyEs9jXBoCd2ojq5unBZuKgJ5WtcIJ2elsPtdGoCuJ+rFkhC2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLshaJp5tJrpDXbabEU7NXFjLlIYmndmAmQwhyAo1ju3hrDD+K
 c0u5TS8d5wxoiRFCdJ6oks4hppv8UmjG1GZgSjV+QT/g9WFgexw1KAvxe6I5JjfRLEVNWKe25Jv
 FXIgycCe/Qr8kjeGQc81mrE+DzqtfUZT3BA==
X-Gm-Gg: ASbGncv2nKPdJQ0RzQM3KCFxuaSVakHbFB2pOPRcDIS4MkMknePuxOcEtTphuh3qB9K
 CbyGr8lTrQbC/itlUbRu19XobDQWqz2Y1w39JGCNBZWugO8cP/Jz+JubvwxCdBWle39CxyhsTt/
 dTQ9FAhQUc2vr8LqpmmwqEspefEDd/VVt8W/R9nleCsY/Z36KA/i8YTCBQGr351G8/HfOEABqLn
 BxxbzwDJ+MzJxlPQrE=
X-Google-Smtp-Source: AGHT+IH6A3PdX7vOY2nxkfeBSC+HWkB29hlGZZ2xnochjdc4+0TOHRO5+kAEwFdOyJ8WgBd3WTLExI1oKs0e/0UDD4s=
X-Received: by 2002:a17:90b:1b4f:b0:31f:16ee:5ddf with SMTP id
 98e67ed59e1d1-31f16ee66b8mr2880073a91.5.1753794521204; Tue, 29 Jul 2025
 06:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250723090624.53536-1-YuanShang.Mao@amd.com>
 <PH0PR12MB5420F1D3878389D200D4E419E05AA@PH0PR12MB5420.namprd12.prod.outlook.com>
 <CADnq5_MBSe2tuczKGwigygErxYUXg=O+H63NcnFnMd_C0qLwpA@mail.gmail.com>
 <PH0PR12MB5420F3163B34DB33AF74B6D9E025A@PH0PR12MB5420.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5420F3163B34DB33AF74B6D9E025A@PH0PR12MB5420.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Jul 2025 09:08:29 -0400
X-Gm-Features: Ac12FXzmIKGM5ZK_vOuvhcdKFqFiDFGSsePlBUINhnR-HuvsaZLxY8aeQrAippY
Message-ID: <CADnq5_O-Nc7JtjxCWOdq9Eqx66n16_a5dgJ2=PO=FSfVduCBWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "cao,
 lin" <lin.cao@amd.com>, 
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
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

On Mon, Jul 28, 2025 at 10:41=E2=80=AFPM YuanShang Mao (River)
<YuanShang.Mao@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alexander
>
> > I didn't think we actually resubmitting jobs anymore.  How are we endin=
g up trying to resubmit in the first place?
>
> It is not about resubmitting. amdgpu_vm_generation will check if the VM i=
s valid for this job to use. For example, if a gfx job depends on an sdma j=
ob, which is already cancelled, then the gfx job should be skipped.

Ah, that makes sense.  Can you include that in the patch description?
With that included, the patch is
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Perhaps the dependencies between tasks should be resolved by the drm inst=
ead of amdgpu.

If we can do that or check the dependencies via the job itself that
would be better in the long term.

Alex

>
> uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_v=
m *vm)
> {
>         uint64_t result =3D (u64)atomic_read(&adev->vram_lost_counter) <<=
 32;
>
>         if (!vm)
>                 return result;
>
>         result +=3D lower_32_bits(vm->generation);
>         /* Add one if the page tables will be re-generated on next CS */
>         if (drm_sched_entity_error(&vm->delayed))
>                 ++result;
>
>         return result;
> }
>
> Thanks
> River
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, July 29, 2025 2:10 AM
> To: YuanShang Mao (River) <YuanShang.Mao@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org; cao, lin <lin.cao@a=
md.com>; Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
>
> On Mon, Jul 28, 2025 at 5:01=E2=80=AFAM YuanShang Mao (River) <YuanShang.=
Mao@amd.com> wrote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Alexander
> >
> >         Since Christian is on vacation. Could you help review the below=
 patch?
> >         If set job->vm to null in amdgpu_job_prepare_job, the job which=
 should be skipped in amdgpu_job_run will be submitted unexpectedly.
>
> I think we can just remove the amdgpu_vm_generation() check in amdgpu_job=
_run().  I didn't think we actually resubmitting jobs anymore.  How are we =
ending up trying to resubmit in the first place?
>
> Alex
>
> >
> > Thanks
> > River
> >
> >
> > -----Original Message-----
> > From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
> > Sent: Wednesday, July 23, 2025 5:06 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; YuanShang Mao
> > (River) <YuanShang.Mao@amd.com>
> > Subject: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
> >
> > job->vm is used in function amdgpu_job_run to get the page
> > table re-generation counter and decide whether the job should be skippe=
d.
> >
> > Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index 45febdc2f349..18998343815e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -360,13 +360,6 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched=
_job,
> >                         dev_err(ring->adev->dev, "Error getting VM ID (=
%d)\n", r);
> >                         goto error;
> >                 }
> > -               /*
> > -                * The VM structure might be released after the VMID is
> > -                * assigned, we had multiple problems with people tryin=
g to use
> > -                * the VM pointer so better set it to NULL.
> > -                */
> > -               if (!fence)
> > -                       job->vm =3D NULL;
> >                 return fence;
> >         }
> >
> > --
> > 2.25.1
> >
