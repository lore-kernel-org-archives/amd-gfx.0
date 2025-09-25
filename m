Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBC7CAC5B1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 17:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1E710E2D8;
	Thu, 25 Sep 2025 17:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NBtkzLMA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4256610E2D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:55:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF8AB42BA4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8A0C4CEF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758822946;
 bh=SOX3LuioJhf5z9bEgu8+xkPZn2U5lQnB8s5KD7WDdtk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NBtkzLMAUtlRKsuGk2OnBVigtIxuKKCiEIw74tDaf66AnpamtkvviitdqBx03j+CD
 aRdY5P2fPccd68BCXpXjN/PlbmgVXpdfWYor+Rl8qLCSFdr04zA6uZ2n9KipAq5X0x
 5faaHzjiG0FQT50Y/+h+Tn5CHH6X7Gv6P7NlRTSNbXsB4nHk2Tr3xWXpVxBgt+nZX9
 SOt2qU676cvYK44FxGJ5UCDLPqv5a/BSa+uvu2Mj+IAMtmrqfV3Oxj+39+uyHwUIB/
 x1GUS3RjQMkAPhtJ8X+3exwIXmC1rDlDMg+om2Vibh2O/2w2uKdSqLunTXAbqzPUnJ
 gOK8YscDuih5Q==
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-3544c64380eso1750808fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 10:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWKay/iqNM7fvFW42dwkIujX2jNYRwNu5JeNOqAwvuwQQC0+o6btXclRsJJC+Daz4AWxVLcqyu6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhU6JPmxrF0iGwXN1G0vOib4BPGAK8m3C6aP2SHWOgmLkxZ6gO
 Q+3xah5EGpVpMC7IS0ph/GAUiJRrt8C5/uxV5QpfKDaV5zJSEx46KWYh1noXnH4vFfu541b5sV0
 sxriPQYCuKIHpaOK3v/al2uVUirtr9Ok=
X-Google-Smtp-Source: AGHT+IGG8FX7px7uMGlED2/O1sgQ6fpg0RvmRNrTUyS6FAsizclLEwVO3sbNSmDEcURRAP9GXskXU+qQYKMmOAiJJ6Y=
X-Received: by 2002:a05:6870:d38a:b0:34a:7993:23c1 with SMTP id
 586e51a60fabf-35eea66da59mr2145468fac.36.1758822946174; Thu, 25 Sep 2025
 10:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org>
 <20250925155918.2725474-2-superm1@kernel.org>
 <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
 <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 19:55:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irbKvO-tFaQWa8E0dLikN6d=y6yOxJfzQvpDVPe-TaTw@mail.gmail.com>
X-Gm-Features: AS18NWD0ZuSYH2-4dsLZ41SysFJ4itstUGzPImpphTh8Dz2mqPfS4s_3sanqDyc
Message-ID: <CAJZ5v0irbKvO-tFaQWa8E0dLikN6d=y6yOxJfzQvpDVPe-TaTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Samuel Zhang <guoqing.zhang@amd.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>,
 Kenneth Crudup <kenny@panix.com>
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

On Thu, Sep 25, 2025 at 7:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 25, 2025 at 7:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> > >
> > > Hybrid sleep will hibernate the system followed by running through
> > > the suspend routine.  Since both the hibernate and the suspend routin=
e
> > > will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be calle=
d
> > > before starting the suspend sequence.
> > >
> > > Add an explicit call to pm_restore_gfp_mask() to power_down() before
> > > the suspend sequence starts. Don't call pm_restore_gfp_mask() when
> > > exiting suspend sequence it is already called:
> > >
> > > ```
> > > power_down()
> > > ->suspend_devices_and_enter()
> > > -->dpm_resume_end()
> > > ```
> > >
> > > Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> > > Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > > Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend =
sequence")
> > > Tested-by: Kenneth Crudup <kenny@panix.com>
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > > v2:
> > >  * Move under CONFIG_SUSPEND scope (LKP robot)
> > >  * Add tags
> > > ---
> > >  kernel/power/hibernate.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 2f66ab4538231..52c1818749724 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -695,6 +695,7 @@ static void power_down(void)
> > >
> > >  #ifdef CONFIG_SUSPEND
> > >         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> > > +               pm_restore_gfp_mask();
> > >                 error =3D suspend_devices_and_enter(mem_sleep_current=
);
> > >                 if (error) {
> > >                         hibernation_mode =3D hibernation_ops ?
> > > @@ -862,7 +863,15 @@ int hibernate(void)
> > >                                 power_down();
> > >                 }
> > >                 in_suspend =3D 0;
> > > -               pm_restore_gfp_mask();
> > > +               switch (hibernation_mode) {
> > > +#ifdef CONFIG_SUSPEND
> > > +               case HIBERNATION_SUSPEND:
> > > +                       break;
> > > +#endif
> > > +               default:
> > > +                       pm_restore_gfp_mask();
> > > +                       break;
> > > +               }
> >
> > You're breaking HIBERNATION_TEST_RESUME here AFAICS
>
> Well, not really because of the hibernation_mode check.
>
> > and power_down() doesn't return.
>
> But this still is true.

Well, except when it does HIBERNATION_SUSPEND.

But can you just make power_down() call pm_restrict_gfp_mask() before
returning and leave the code in hibernate() as is?
