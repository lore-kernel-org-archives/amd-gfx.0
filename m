Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B4CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 13:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9017910E608;
	Wed, 17 Sep 2025 13:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iq1Xl7M2";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBC710E608
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 13:49:46 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-267f15eb5d3so2290995ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758116986; x=1758721786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xi6AWZDbemlu/N0YZKyNsSAxBM/XjtkwnY43+WZ4854=;
 b=iq1Xl7M2ZvXhAHU7Wvn8EBCWcVCG5hg2gdQili6Nwn5gizRlnzm0BCjImwjkl2ET2W
 OXqtLSNIpvMcH9VdcZpUhbXKrOvAzvEskHsbc0+KOIjYvgUvL4zKWPz4Eui1TqkKqTvd
 Qw5BhsV186eTiMRJdojbeu/hD81ULT5FeMnwDv17tq0GFE6tj+Zpu6NkOrvZPAQZQUT/
 el2l0d5reC/fMCMLaUiseQ9uz1T3jS2E6NEbUZLvhlteByoaKhccY6cOPh/G21r0nOUl
 DFJ57aO/WdABLmw4TgmNMmwPMLhk6zzsTF8oakK/z8Jv5GIwez2mBkYf09HD5YfnAylM
 mGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116986; x=1758721786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xi6AWZDbemlu/N0YZKyNsSAxBM/XjtkwnY43+WZ4854=;
 b=MDF8Cpwq/l3gVskJcZPxcxClekRoZYSci8ynWha3Dcil39VsiuIkmCDm6KJDR8yold
 WSK9roBfHhMZre15BaKE2FPLhucVPZUj2uPcGrDiXXXne6VPYAG3FmgUg2I2nG2/JOph
 hGSD3lykjEHYyFths+6GUUG8FG4CFO4xFyrFVC9GxkIAgNZitVsvH+cAcmdadXEiC4RY
 s/S2zVq4MyiukbzmyxzUmqI5sBnxx0kORnS6XElogif8Md1KGDuIgm8kfj4Cnb6V3xxA
 FFSSKgGZ/6O6ubVVqJwAakA/rTfdyh04MGEUaeQJfFMgX2N/RPojO+SxTBohDoAPSQIK
 jNhg==
X-Gm-Message-State: AOJu0YyDRVtGr4g45/gWKJvK9XPiFurOr4CTv9vTzqjZqEZDWwTYdwHL
 a09+f1sIR6jbeEzNaslH9Ui2qMPTYDv2ng7W87jed6q2/2U3biy8GkiWJp1arR447zmgZZYx0TT
 cUOcXhXLul8Qp6W2spUE9btMZL5JsnlM=
X-Gm-Gg: ASbGncv1twHSSKAFenV4i9Y9XbjYarB4DLLswzrb2xWOT2xJPbrxkF5PaCG5YvwFhC2
 DS5hStY4qyloQJ+03759kV8lKGrbQiBmAxqZojEDnTmpRnOuxfuAGIC1ddArDrWqoH0EAD+7mLJ
 960Z4I1meQxF+zIbAu+X8XLseGO+32TPGcMLyh0bluLdhKra0RQKWOAy+4L+UrpRS+wKvEswnSi
 gW88dqn
X-Google-Smtp-Source: AGHT+IGy+JxPFS71aS5UR6XPtZex8/wjftu4uKnz4YVNkunrusOYvG+qzT8UoRWwv1NlXQ6Ck7K+kKUdv/Fjb/THouU=
X-Received: by 2002:a17:903:244d:b0:261:83d2:9d9f with SMTP id
 d9443c01a7336-2681217984emr15864815ad.4.1758116985548; Wed, 17 Sep 2025
 06:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <CADnq5_M+Ys+v=proV=Jg3cDh0REEg0EB+-VtwvMkCdGt9BTXLg@mail.gmail.com>
 <DS7PR12MB6005E88285AAB4AAE49BA111FB08A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005E88285AAB4AAE49BA111FB08A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 09:49:34 -0400
X-Gm-Features: AS18NWBDHOV5phpgt9mL5VOLA0IA_N4KuuBZdzAgtJoQRRBc0YclfPMzVPAqwVU
Message-ID: <CADnq5_NbhHNfgM4ynBghadmQyG+5tKhPXMea-3rnP70LkKP71g@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
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

On Thu, Sep 11, 2025 at 10:09=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, September 12, 2025 2:55 AM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>;
> > Khatri, Sunil <Sunil.Khatri@amd.com>
> > Subject: Re: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query stat=
us
> >
> > On Wed, Sep 10, 2025 at 7:37=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > From: Alex Deucher <alexander.deucher@amd.com>
> > >
> > > Add an API to query queue status such as whether the queue is hung or
> > > whether vram is lost.
> > >
> >
> > We need mesa code before we can land this new interface.
> Do we have a plan for upstreaming the mesa counterpart code?
> Or can we update the userq structure in the drm header first if we need t=
o upstream the following metadata solution?

We need to write the mesa code first so we can test the whole thing end to =
end.

Alex

>
> > Alex
> >
> > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/include/uapi/drm/amdgpu_drm.h
> > > b/include/uapi/drm/amdgpu_drm.h index 85b3ca14f81e..7292f7bfcd13
> > > 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -334,6 +334,7 @@ union drm_amdgpu_ctx {
> > >  /* user queue IOCTL operations */
> > >  #define AMDGPU_USERQ_OP_CREATE 1
> > >  #define AMDGPU_USERQ_OP_FREE   2
> > > +#define AMDGPU_USERQ_OP_QUERY_STATUS   3
> > >
> > >  /* queue priority levels */
> > >  /* low < normal low < normal high < high */ @@ -346,6 +347,12 @@
> > > union drm_amdgpu_ctx {
> > >  /* for queues that need access to protected content */  #define
> > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
> > >
> > > +
> > > +/* the queue is hung */
> > > +#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
> > > +/* indicate vram lost since queue was created */ #define
> > > +AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
> > > +
> > >  /*
> > >   * This structure is a container to pass input configuration
> > >   * info for all supported userqueue related operations.
> > > @@ -427,9 +434,16 @@ struct drm_amdgpu_userq_out {
> > >         __u32 _pad;
> > >  };
> > >
> > > +/* The structure to carry output of userqueue ops */ struct
> > > +drm_amdgpu_userq_out_query_state {
> > > +       __u32 flags;
> > > +       __u32 _pad;
> > > +};
> > > +
> > >  union drm_amdgpu_userq {
> > >         struct drm_amdgpu_userq_in in;
> > >         struct drm_amdgpu_userq_out out;
> > > +       struct drm_amdgpu_userq_out_query_state out_qs;
> > >  };
> > >
> > >  /* GFX V11 IP specific MQD parameters */
> > > --
> > > 2.34.1
> > >
