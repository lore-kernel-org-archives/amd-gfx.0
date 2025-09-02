Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A0DCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF08B10E72C;
	Tue,  2 Sep 2025 13:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iEiin5KU";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A866910E72C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:59:24 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b49cf060d2bso434345a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756821564; x=1757426364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXn4tgE4+qgj4+VpYtPATM0skQTx1UO+3uGolIKN+i4=;
 b=iEiin5KUtKOChld4khYfg4f9SW9NnrpQO4OkQLi/SkeRFAE7CvyaTD6hH66gUZxdTp
 H4ONZminafoKjdG+1qeJKiF6QKQbkTTclGruOwikfx+XbWE26y2x/RyOTT0cvGdFvc4O
 WYOHxc9Xn0gtuS4UTkNn9j+CMwMNicFNYh/WmTNu9IxHlNxLY+YSoyhDomcfzZnAzyY0
 58KyivVW/AlN0qVwo0Nx7o0wYeR7W7CJ92juEO/k2iyJWiQa7cwG5CgGfK8iAxbJLpv9
 3K6mYU7c+v3SDf/jO29ojBHZ2CsoUCsk7J6akrP1NbaSVm8Hpar85ZSP8kHjWOEeRYP3
 4mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756821564; x=1757426364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXn4tgE4+qgj4+VpYtPATM0skQTx1UO+3uGolIKN+i4=;
 b=oUGJmCkR5AijJwS55xHqwmN6fAAJcXR+hibDddOsuiHdDZlFl0OAWHX8IfkarNDQtV
 dLhc3PcIjKADCYaqt8kUKj1+gCR1rNJKWLFayDsZqEuPpGAYgwkOuYh3rJCqCi8z3jpM
 RaEvCueK3JbjAf6pyK0RxVs9u85gdeb+XTkGsOsKTtohET/NLug4yJPcK80/qFScLVGM
 8wpOm/Q24jZZQRK1/+Gos3vogKG8c1DtUV/1s4MrkZl4Y0keowF+7MtzxDHyTrQsYSLo
 qBXP0WECjWJMFAJAp7nd7e4RZ+07jyBjbSXWToMqa2tEy3w9nnVjuAh3hT4r4p+EDB2A
 RxUg==
X-Gm-Message-State: AOJu0YwsF9di9yb6JPvgT20dli3wic0/a2aZVsNyiatHr/7tWFX2CkXi
 xIDSQGD6UQQ4lB+PmGxhCxE1YxKfMOM8XULXsq8weED+DYGlXUpCSVH7R05AYpgUrzKWTQv8rNk
 HLu6omteTirBKMhmhjKmx2z7g0CgdsgQNzQ==
X-Gm-Gg: ASbGnctlemwlqo13X3+DW0BF9Ap7r3daLW2T6TA+bOzyd5QnCE9idjQu3DiUZvmtkvX
 nZhE/jFvE+i5umTkvOAupW/dcHRoosVHUaEKkk7XX0aqwCSj4nyrVU90Ps9U5/MIOIoOMWYL4YI
 i8xSeqeXRPmmE6MEz7L56yGJgxJewxhuJzgWqZ6+prlOh3sf55FcTIO06t0B+ogxpCDzVfwazKY
 /ukaqc=
X-Google-Smtp-Source: AGHT+IHcsMwJyVi6ChKyC3gRlfrcHbtLN+uq09baBCGN/qeS4Nq19/Zrt81URby27/4ndbb1SFHOZLSkiMenboxGo14=
X-Received: by 2002:a17:903:2308:b0:248:f762:866b with SMTP id
 d9443c01a7336-2490fc97171mr112482085ad.6.1756821564058; Tue, 02 Sep 2025
 06:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250825215631.628949-1-timur.kristof@gmail.com>
 <CADnq5_MjEuHz89Mv-_n5BoE4GMWD_PweLEwb=nydO1KdioPG2w@mail.gmail.com>
In-Reply-To: <CADnq5_MjEuHz89Mv-_n5BoE4GMWD_PweLEwb=nydO1KdioPG2w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 09:59:12 -0400
X-Gm-Features: Ac12FXyHDq5Es4HbWgPpwbLfxC9Kdh-nDRGvdxnMoFYr28S5fbKRichD4tQZc_w
Message-ID: <CADnq5_N3AA+etH6_v8a8CZbvBeRsZVNWvAUOLcWMATfuR=6wRw@mail.gmail.com>
Subject: Re: [PATCH 0/4] DC: Fix page flip timeouts on DCE 6 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, alexhung@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
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

On Tue, Aug 26, 2025 at 10:23=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, Aug 25, 2025 at 5:56=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com> wrote:
> >
> > Compared to the previous version of this series, v2 fixes
> > the rebase conflicts on amd-staging-drm-next and includes
> > an additional patch to address page flip timeouts when the
> > displays are blanked.
> >
> > Currently when using DC on DCE 6, it produces pageflip timeouts:
> >
> > 1. When displays are blanked
> > This is caused by (mistakenly) turning off the display engine
> > clock on DCE 6.0 and 6.4 which is also the DP clock.
> >
> > 2. After suspend/resume
> > The root cause is that DC assumes that the VUPDATE interrupt
> > is always present, when in fact it isn't supported by DCE 6,
> > which also doesn't support VRR.
> >
> > Finally, there is also a patch to disable fast boot mode
> > on DCE 6. The rationale is that this already didn't work
> > on DCE 8, and even if it did I have no means to test it.
> >
> > Timur Krist=C3=B3f (4):
> >   drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
> >   drm/amd/display: Disable fastboot on DCE 6 too
> >   drm/amd/display: Disable VRR on DCE 6
> >   drm/amd/display: Don't use non-registered VUPDATE on DCE 6 (v2)
>
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

@alexhung@amd.com
Were you planning to include this series in an upcoming DC promotion
or should I pick it up?

Thanks,

Alex

>
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
> >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
> >  drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
> >  drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
> >  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
> >  .../dc/resource/dce60/dce60_resource.c        | 11 +++++++-
> >  6 files changed, 46 insertions(+), 20 deletions(-)
> >
> > --
> > 2.50.1
> >
