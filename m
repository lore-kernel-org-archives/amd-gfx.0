Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B48CAC5B1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 17:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3835F10E00B;
	Thu, 25 Sep 2025 17:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdMlnqs1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C5510E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:51:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 09942611D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA1C4CEF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758822674;
 bh=gRdOscOTHhI+i0F0NbGwOm6Fee4wavwmKfYcYfw8HB4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bdMlnqs13WtqWOYvSEm7QPcF4lZ7BEqkSJ6sWgaI42hlusLhREvEbyjc1YDlT6C7Z
 56Cxvfkh9mZl6pmW7H/DC5tUtACHzls2xyPk+0mlyfzx0TEj2ogSUuFXS17Omt9jEC
 q9laddRJS3xZxCCPA+zhXpyc8ptELnRtShtSdxbRrSeeMfuT8qVNyPY2ZJyfx/wEXX
 CJDxTtzqnpkkK2BXUMm8vHw28ITH3qcbtAXD90VBnl4DTPPt+aIsmaPzXTUkh2/CFH
 o1R8xUh1e8EKxmBGbASylTtK81ZKburJTWlzeW9D5tUnuF/Apfp2IN326OjHscc5tj
 6YiIcaHM3SDiA==
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-321289dee84so662289fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 10:51:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ySfO6K6QC1psejv761JyztseM5/FmVm5rU/of9M2sPkbG2lWv4XsuS5s5Gy+V0dfr+9ibNYv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/ymF9vn4zsF66qyv2//hrSYYRCkkd1Fprh77SS/PqyWCk+fKf
 7yXFkvw0TRU0SvWN4rTkbdviLRmir1rg5GN/2/kg8rGPTEJhW4050xMW+n9BfUDv82fBRyDZ66R
 PuT60SZ8cnNRxyaat9E16n0OWmlPperc=
X-Google-Smtp-Source: AGHT+IF+BZnZzFQD0fUzXPwYbYWCPdphHFnalJrklbCIrlGUekVrPspRNbln3iasB+dASXFC5TL7AhzbFjg8JUgNu30=
X-Received: by 2002:a05:6870:2199:b0:30b:cb2f:bae4 with SMTP id
 586e51a60fabf-35ebf3f478bmr2024381fac.12.1758822674050; Thu, 25 Sep 2025
 10:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org>
 <20250925155918.2725474-2-superm1@kernel.org>
 <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 19:51:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
X-Gm-Features: AS18NWBYxPcokk8u39pxoHMFexm82rrMjsS6VNFjlb5geOK8p8n90_IqPsrwZiE
Message-ID: <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
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

On Thu, Sep 25, 2025 at 7:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
> >
> > Hybrid sleep will hibernate the system followed by running through
> > the suspend routine.  Since both the hibernate and the suspend routine
> > will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
> > before starting the suspend sequence.
> >
> > Add an explicit call to pm_restore_gfp_mask() to power_down() before
> > the suspend sequence starts. Don't call pm_restore_gfp_mask() when
> > exiting suspend sequence it is already called:
> >
> > ```
> > power_down()
> > ->suspend_devices_and_enter()
> > -->dpm_resume_end()
> > ```
> >
> > Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> > Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend se=
quence")
> > Tested-by: Kenneth Crudup <kenny@panix.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > ---
> > v2:
> >  * Move under CONFIG_SUSPEND scope (LKP robot)
> >  * Add tags
> > ---
> >  kernel/power/hibernate.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 2f66ab4538231..52c1818749724 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -695,6 +695,7 @@ static void power_down(void)
> >
> >  #ifdef CONFIG_SUSPEND
> >         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> > +               pm_restore_gfp_mask();
> >                 error =3D suspend_devices_and_enter(mem_sleep_current);
> >                 if (error) {
> >                         hibernation_mode =3D hibernation_ops ?
> > @@ -862,7 +863,15 @@ int hibernate(void)
> >                                 power_down();
> >                 }
> >                 in_suspend =3D 0;
> > -               pm_restore_gfp_mask();
> > +               switch (hibernation_mode) {
> > +#ifdef CONFIG_SUSPEND
> > +               case HIBERNATION_SUSPEND:
> > +                       break;
> > +#endif
> > +               default:
> > +                       pm_restore_gfp_mask();
> > +                       break;
> > +               }
>
> You're breaking HIBERNATION_TEST_RESUME here AFAICS

Well, not really because of the hibernation_mode check.

> and power_down() doesn't return.

But this still is true.

>
> >         } else {
> >                 pm_pr_dbg("Hibernation image restored successfully.\n")=
;
> >         }
> > --
