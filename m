Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3EBC54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 20:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C05410E4B4;
	Mon, 16 Jan 2023 20:25:09 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A4B10E4B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 20:25:07 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 k44-20020a9d19af000000b00683e176ab01so16701423otk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 12:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyHrQKSrI2xY08/CxRkLvVyIkiEr34nu/gSvHRqslBo=;
 b=UCFTn+oycVkDbh8KgquiZuT29hlFXoLDiMLkARdQvQMOnjM4/MjTS13mspiBpDDbK2
 feJqCJ1enF2V1x7QIiWSkCKS3YnCgCsIe/kVsyAyazvT7hLkpjximwMZs27aQ2NLA/21
 c/yw0Q2/xB6r9kjop4930EQ+IjowT8ftbyfFmzn9eIdxY/pEYVg6Gb0+A7WJGOezdKmy
 rpPpZDl+Wj375dt0YCUcmsepca1h5C7+07pVWvbK1sdmZQukcLSgbRbkIor5OugPS6E/
 S2qGlTHWBB3o00iU8VmnDz1KSq1HCO3L2/gDFJp6mJAApFV+Pg18gkO58URqEePNE7t3
 aJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyHrQKSrI2xY08/CxRkLvVyIkiEr34nu/gSvHRqslBo=;
 b=GhVgNK3FKGxIzim8zjih39Oshxs4Bb54LcN6qKch2EABVZOJkG0azk9tI1G4ue03z0
 77sndZyBBR+aRAivAvuzF9Q9cmsNLhAAvgK28DFBWmOJj9HQ8lSUzq2p69ha5PmQBONX
 PaIhjJTbQUPaEFAByjZM3J84ndUChA1d88mYvsQUyg+NxrI/EZQtpunhuaykTfftVN7A
 PBx7L6CHLTrdjLRVq5GsbbYO1VZmaLncUucTlehvZ1vgQmnmzrNp1Fx9fjXHg1XaoVFD
 uzp9o8o9+KEtfiA7gPfSJ6hrMGbmlrkGaDX9WR4/1VWn4LMmOHabTyZLlfWzW3FucSqM
 6xTQ==
X-Gm-Message-State: AFqh2kpZZvr4yKImYtHKrLe+oXy1A2YMW8rwQ31rySoPSg7COMOeaeA1
 iqs299Olu94d4FdvwoziDP/cXsNJiwOBix6Itbs=
X-Google-Smtp-Source: AMrXdXsfOzJwqDhcn/azqVB6ZGKwEOpFCJhbNRQeCcGqpQwJqZztHtnGOUDanFillBuMMhEen+FEM4wu16QJGam5Vfg=
X-Received: by 2002:a05:6830:449:b0:684:bedc:4f54 with SMTP id
 d9-20020a056830044900b00684bedc4f54mr20178otc.233.1673900706590; Mon, 16 Jan
 2023 12:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20230116201218.5113-1-christian.koenig@amd.com>
 <CADnq5_OghKCnPJ_eGZQ=de2zaXfC6syG_h_NYCQrPLM8dT=ACQ@mail.gmail.com>
In-Reply-To: <CADnq5_OghKCnPJ_eGZQ=de2zaXfC6syG_h_NYCQrPLM8dT=ACQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 15:24:54 -0500
Message-ID: <CADnq5_NQpsaec3Azz1UVWLpYKaVouVDhCU51MnFt+wqmzXCD7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix amdgpu_job_free_resources v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, thong.thai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 16, 2023 at 3:15 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Jan 16, 2023 at 3:12 PM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > It can be that neither fence were initialized when we run out of UVD
> > streams for example.
> >
> > v2: fix typo breaking compile
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Also add:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2324

Alex

>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index f4a3122352de..6b73c074aa25 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -154,8 +154,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *=
job)
> >         struct dma_fence *f;
> >         unsigned i;
> >
> > -       /* use sched fence if available */
> > -       f =3D job->base.s_fence ? &job->base.s_fence->finished :  &job-=
>hw_fence;
> > +       /* Check if any fences where initialized */
> > +       if (job->base.s_fence && job->base.s_fence->finished.ops)
> > +               f =3D &job->base.s_fence->finished;
> > +       else if (job->hw_fence.ops)
> > +               f =3D &job->hw_fence;
> > +       else
> > +               f =3D NULL;
> > +
> >         for (i =3D 0; i < job->num_ibs; ++i)
> >                 amdgpu_ib_free(ring->adev, &job->ibs[i], f);
> >  }
> > --
> > 2.34.1
> >
