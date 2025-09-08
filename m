Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A606CA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 17:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBB110E58C;
	Mon,  8 Sep 2025 17:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LtwOcOi5";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B54610E58C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 17:36:07 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24b1331cb98so7797125ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757352967; x=1757957767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2s0r/otJhWB9e9UKttwl16eZjGxOkI+V7nq3RxAzng=;
 b=LtwOcOi5Vj/O+8tZ6dkpPEGJvQ1v6Y6MMSOZcZyajTFFBtS9P1yW4OpObK7SN0Bznk
 QK/PbhpGtwXaL8X3GqFaXbkLAaHEDsPA2ypoAwLJHFihvFssAieGk1N8Gxy19DVFgEIb
 3a0aqV332kobbGHwahU85E957SYvjbAEve0341/MFIxHqufJXCLXdDxlyCS3WArOV+a3
 KxVHor/OwZsqWu/7czu6wl26Uk/iq+MOA0zwSGY9YOPfszfJNJ1TcwTZtX4AEvvlJzCZ
 feZhWBZGhE8oF1xkpJ3LtUj8bBnfZQPcJ72NpUEpA86939MsG9rKjuud/MNwbV8SWgRt
 eSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757352967; x=1757957767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2s0r/otJhWB9e9UKttwl16eZjGxOkI+V7nq3RxAzng=;
 b=GuUW6dSpS/k9Mj5eIZC4Fjd9I1FuOiwPo2Lr/ZU8VxW/Ve37Lh7ZCA0QtW8dpvyBSf
 r2YYGOxjqVO0VHMd7Hv5NpOTdNlV8xblpdNviFz++ltPaLn5DK6bWnnEEar4wTZ5TAD5
 j/s5+0120+o4Dvy9zfmxWH3HmIXY5y392hsuBudHBV39eSm0DDZvdaSvtGU8tuoStIb/
 3d7M+ZW0wcKHA/etFfIBGsOjDwJG4/FhVp0QUvJAJy852sfEB7O3bv1TzA7o6xG7derV
 bIekSHKpvtg7tdDE4yTe2dTUosifGQNMZXj02xvKglV0t8U3XE1UiMtWouL59mHoemim
 QjvQ==
X-Gm-Message-State: AOJu0Yx2lmnKCSCjmO53YwOhrTF61s2kX2BA42IuM4eXIHJaEjMk3QeZ
 evZkBGCGJ/kGuDqC3Y0IuTaa4i3cEqnVgQXaLvnUiKUn+C61hzktiPUjdbN1xofVYQEbDzEuMX6
 K40BojlwcAkGktRkSkhV0iFMHul4FlZA=
X-Gm-Gg: ASbGncuprWivSSCxVHthEVPhF40g89DPZn6Kyi9Ydp5Acp8jpFmGavD7sQ+wZmAOWHA
 tgM3cTrxZlWBptVdNY435wgM9ERWQu/zrfrI3LvvtxzVhV4bQGx3XkzMeKbOdffOqqqnj5VTKkw
 MrKn8+A2jBbSddziKL8nzauYnTM1mOdfbhx5VzUc+MrdWFrPRYnyJbNxzzWhKr5uvTcwUoQy2UF
 AkpjT3asJaichN6vA==
X-Google-Smtp-Source: AGHT+IEds58zF9GOv4G/1q4JJVzxNGM4kb32ZsW02MKVLHNzwonsbDnV3DQOUySsLtUslobJu9GECSVbGJ96NJRVgSc=
X-Received: by 2002:a17:902:ea03:b0:24c:b69d:5929 with SMTP id
 d9443c01a7336-2516da048f8mr65751065ad.2.1757352966685; Mon, 08 Sep 2025
 10:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250825215631.628949-1-timur.kristof@gmail.com>
 <CADnq5_MjEuHz89Mv-_n5BoE4GMWD_PweLEwb=nydO1KdioPG2w@mail.gmail.com>
 <CADnq5_N3AA+etH6_v8a8CZbvBeRsZVNWvAUOLcWMATfuR=6wRw@mail.gmail.com>
In-Reply-To: <CADnq5_N3AA+etH6_v8a8CZbvBeRsZVNWvAUOLcWMATfuR=6wRw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 13:35:54 -0400
X-Gm-Features: Ac12FXwuvsrVlcqR3RVHAEuGER8s4tm13bD2-ApGiKxOTDOhBIMjHZ6ogBE6JaM
Message-ID: <CADnq5_MKSwBNDhnKvYpT0vMiNUzfqSv4gm2k=-bxB1Fkum3GYw@mail.gmail.com>
Subject: Re: [PATCH 0/4] DC: Fix page flip timeouts on DCE 6 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, alexhung@amd.com,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 alex.hung@amd.com
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

@alexhung@amd.com@Wentland, Harry
 Were you planning to pick this up for this week's promotion or should
I grab them?

Thanks,

Alex

On Tue, Sep 2, 2025 at 9:59=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Tue, Aug 26, 2025 at 10:23=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >
> > On Mon, Aug 25, 2025 at 5:56=E2=80=AFPM Timur Krist=C3=B3f <timur.krist=
of@gmail.com> wrote:
> > >
> > > Compared to the previous version of this series, v2 fixes
> > > the rebase conflicts on amd-staging-drm-next and includes
> > > an additional patch to address page flip timeouts when the
> > > displays are blanked.
> > >
> > > Currently when using DC on DCE 6, it produces pageflip timeouts:
> > >
> > > 1. When displays are blanked
> > > This is caused by (mistakenly) turning off the display engine
> > > clock on DCE 6.0 and 6.4 which is also the DP clock.
> > >
> > > 2. After suspend/resume
> > > The root cause is that DC assumes that the VUPDATE interrupt
> > > is always present, when in fact it isn't supported by DCE 6,
> > > which also doesn't support VRR.
> > >
> > > Finally, there is also a patch to disable fast boot mode
> > > on DCE 6. The rationale is that this already didn't work
> > > on DCE 8, and even if it did I have no means to test it.
> > >
> > > Timur Krist=C3=B3f (4):
> > >   drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
> > >   drm/amd/display: Disable fastboot on DCE 6 too
> > >   drm/amd/display: Disable VRR on DCE 6
> > >   drm/amd/display: Don't use non-registered VUPDATE on DCE 6 (v2)
> >
> > Series is:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> @alexhung@amd.com
> Were you planning to include this series in an upcoming DC promotion
> or should I pick it up?
>
> Thanks,
>
> Alex
>
> >
> > >
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-----=
--
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
> > >  drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
> > >  drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
> > >  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
> > >  .../dc/resource/dce60/dce60_resource.c        | 11 +++++++-
> > >  6 files changed, 46 insertions(+), 20 deletions(-)
> > >
> > > --
> > > 2.50.1
> > >
