Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A23FC3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 23:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557B510E08F;
	Fri,  9 May 2025 23:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RVjHN08I";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF9E10E08F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 23:51:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-739ab4447c7so431639b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 May 2025 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746834712; x=1747439512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ihG08QjYNZI1Xdlv3kW3TDElBu5HfBQ3kiDYkphKPs=;
 b=RVjHN08IIj1m6BcGBfdGoC+ZQugJpIS/3qIaWa/1rQat+I9raO9sfPQ07cNeiR6Ys2
 f092IJz2NUoNBDxgWie+ztsYsMU6xtCuiLpYSzJs8w/zbLfKYU7l2nnvoHnRJkGaNYsr
 pW+jQEM+OlNX1EQxDjRaboRxKn8Y2D1F5Cc0C5AC2VjHtwlmvqvtt2Bp0Qw5+7yQKCTr
 hwLGuW6L+dDLN19rpE1kB2etvH5UiyjsW6P2X8F64gszoTheumm4Ji/kK2E+9ezWWOyH
 i+o+BMZp2cx8AIgI1upSzTicdgRczfTIcynpDiMdPDsHK2WU23R3EjYdETyDbLscImAu
 1TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746834712; x=1747439512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ihG08QjYNZI1Xdlv3kW3TDElBu5HfBQ3kiDYkphKPs=;
 b=QMKjZ/zoAKfsH8lflEQpLrhvYOM5BBpR/lBMiAhY7/a1BWi3MGs2wbC8uNEeksRhyW
 itOeVCL0qaHMih8qMk+6C+eqYXAu3P25VYwWxJtqNTqKtSAl9+aLHkkK5tDZJPbdzIvM
 l2XlZN0pWPXzW9QBPe2kcHdYkzK0JiIx65H8lRpSetB7qKwSqyyzBWU+/usmUa+qWk1f
 xPQUeEU4BHam2UlS6GOHY2OrNz0q+9tXIuH/HDLeR122Jy1irxtIC6tA0f5vA4IZdtnC
 LdSoE+ZuDopcPGbW088aeWVpLOc8plT6x3nRQs85K4MspgKSMmbCHDveaOap0gJL+1J1
 r40A==
X-Gm-Message-State: AOJu0YxYc1vnoswD/MBMlGQVuEh+IyZVC9T32Y253sYVzsQyfS+A+wPG
 CurNzTzVz1Agg3LOG69pKLuBMYTUjlxj3wGTyy5FjHYlgR2RJWWJq3AHIQBN6Bpw+G/MY3+USx2
 bOFpb93ivb6Z5NfjbZ36aPG8eicA=
X-Gm-Gg: ASbGncuB7Od0n+Zpi2gT4q6sKyvRVYC8XniLQaC20eXxt/C1RqS8gx+MJ+5euhY3Rc0
 y5D9xLXL/xd/uY7XY/85ze3gxy0FT4/fX0PSaAfrU2YDj6Ow7AKnV15/xJ1x4IALP0q9vVZoKLB
 tjZysbjQsC19+rnOO2FVPL410zPScUv7lT
X-Google-Smtp-Source: AGHT+IHySFcMevaubHkKQHxZI42onomKw45CJkABsQ8BNnlIKP43zbjB/3ubGVY4r4Abc6gRwBDR2bkU8zVmpFr4eMU=
X-Received: by 2002:a17:902:d2c1:b0:215:435d:b41a with SMTP id
 d9443c01a7336-22fc8b0fb2cmr27653965ad.1.1746834711862; Fri, 09 May 2025
 16:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250507140631.200770-1-alexander.deucher@amd.com>
 <CADnq5_NmR7TZnMXWCsz_wznTOmW=mLhF2h1itou=SkhX83GMww@mail.gmail.com>
In-Reply-To: <CADnq5_NmR7TZnMXWCsz_wznTOmW=mLhF2h1itou=SkhX83GMww@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 May 2025 19:51:40 -0400
X-Gm-Features: ATxdqUHSN_hkwViE5EGL1wZfY7wmn77Y68PGjc0k8FCjV9U1Y_ncQaAqfSQyuuU
Message-ID: <CADnq5_Oekuk_jvyYQFwUzgDjCYo8gTCJPbx+QxS677xWjMrxVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: drop warning in event_interrupt_isr_v1*()
To: Alex Deucher <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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

Ping?

On Thu, May 8, 2025 at 4:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Ping?
>
> Alex
>
> On Wed, May 7, 2025 at 10:07=E2=80=AFAM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Commit ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vm=
id_mgr_init()")
> > enables all 16 vmids for MMHUB on GC 10 and newer for KGD since
> > there are no KFD resources using MMHUB.  With this change, KFD
> > starts seeing MMHUB vmids in it's range with no pasid set.  As
> > such there is no need to warn, we can just ignore those interrupts.
> >
> > Fixes: ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vm=
id_mgr_init()")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 3 +--
> >  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> > index 54870b4c50000..3e1ad89747979 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> > @@ -175,8 +175,7 @@ static bool event_interrupt_isr_v10(struct kfd_node=
 *dev,
> >                 data[0], data[1], data[2], data[3], data[4], data[5], d=
ata[6],
> >                 data[7]);
> >
> > -       /* If there is no valid PASID, it's likely a bug */
> > -       if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt")=
)
> > +       if (pasid =3D=3D 0)
> >                 return 0;
> >
> >         /* Interrupt types we care about: various signals and faults.
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > index eb88ba8d8b012..2788a52714d10 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > @@ -287,8 +287,7 @@ static bool event_interrupt_isr_v11(struct kfd_node=
 *dev,
> >                 data[0], data[1], data[2], data[3], data[4], data[5], d=
ata[6],
> >                 data[7]);
> >
> > -       /* If there is no valid PASID, it's likely a bug */
> > -       if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt")=
)
> > +       if (pasid =3D=3D 0)
> >                 return false;
> >
> >         /* Interrupt types we care about: various signals and faults.
> > --
> > 2.49.0
> >
