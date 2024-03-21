Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE1C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 13:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E04510E5EC;
	Thu, 21 Mar 2024 13:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q0VC3f8k";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9293410E5EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 13:03:30 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so611329a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711026210; x=1711631010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWC89Jnxxmqp6xiPCMAv1K3mOoRsBX8GCoVu2FPgFf0=;
 b=Q0VC3f8kBHNr++54mEBlehGwL0EcadVrNRCmiG9Hb/EZtY6LIASouU84wfLmJxY3IU
 9av+95Z+POAxbuTnleaGKwqswKq998DkQnYT9rA2ISNmwFYHOhFG5N19c7sqHT88eequ
 WTKbC25nNmQnqQok0hXTa3AfuVgPBUduch+x/tJI5tdO3Pc85DkTVgG7goqiwYKPcJ66
 pEQBJK+bZQSQ4EzVhCKVkkoPp1UO2hRU/eqJVFUit/8VISrT3Qbk8yMjkTVijT4GuJtS
 5FbZC+ygnX6Gx75SH/5kJpuIF+dhNOs1ucDtUl2udjlrmI7O9fTZmfeGZK/h/7Abqv8X
 /v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711026210; x=1711631010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWC89Jnxxmqp6xiPCMAv1K3mOoRsBX8GCoVu2FPgFf0=;
 b=d4Yrl/BySI3+DlAMG1nHaYXNbiKrEmaSFwkGoc3K73w9BG40PhDtqHsYWAu59YNmgk
 KOsKnd5Eg6JJdz1GnhK2k7WwtOJ/Lu5+arireP1Tozbb+gzkv26rcGVQIYkSNIRnDy0h
 mEwogFGzrOkO4gfygYhvyHaCuQShNSFat8bAY7xicQUS5Ye90bK9ouAGr2VzyUeK6y64
 1F8kKus0MEZGw7kO8h3Jf7pCFBwQXLPdwIlNZDMm9VmaM7jejb+nZmBZ2KgdU1uK/DLr
 KKc1Re8/llM9vljgsXSXWk4DZ94OIROK93+sYItxScWJK4O5zCLmFOr07GtdhN8YNuKY
 UJSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+avV+KEYgOvbBrhn4qWMhAVY/8WbYk5gd/t7tHen96t0PmKX9fyGYio8iLMqljba3yX4y7tDCLAp6eG0XHT5mgayutYeGjVZLWt+bA==
X-Gm-Message-State: AOJu0YzxUGS97cqrTSGA1tAYEQK5GmRBaobsbE6NUKF5wW14kSYQF9Kb
 8zTIld9qO7JJaS0KMJSYxAvQuAlX/APGStneYUFrmHM9o//BX3ZrGDl03aYgykSRRIf1p1JUGal
 PznttXfvkPPYiZrk3H748V92d6VQRPDBaz68=
X-Google-Smtp-Source: AGHT+IE3KcOnsfpsVJdj9PIOBAX4GoeNjbw7I6DrzjyH8WGvACehO3mciz9En0w8/h6bfMbfsI84ncGL4ZhxhSQrnRI=
X-Received: by 2002:a17:90b:314e:b0:29f:be68:5cf6 with SMTP id
 ip14-20020a17090b314e00b0029fbe685cf6mr8523992pjb.12.1711026209640; Thu, 21
 Mar 2024 06:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240320100926.2614497-1-Jun.Ma2@amd.com>
 <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
 <dc037723-81ca-4739-8fde-4c82da60b293@amd.com>
In-Reply-To: <dc037723-81ca-4739-8fde-4c82da60b293@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Mar 2024 09:03:16 -0400
Message-ID: <CADnq5_MvTjDjbYGH88SNacQH+Rs73vvSNVYJRftY6B4aqdsMKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime pm mode error
To: "Ma, Jun" <majun@amd.com>
Cc: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, Alexander.Deucher@amd.com
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

On Thu, Mar 21, 2024 at 2:52=E2=80=AFAM Ma, Jun <majun@amd.com> wrote:
>
>
>
> On 3/20/2024 9:24 PM, Alex Deucher wrote:
> > On Wed, Mar 20, 2024 at 6:17=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
> >>
> >> Because of the logic error, Arcturus and vega20 currently
> >> use the AMDGPU_RUNPM_NONE for runtime pm even though they
> >> support BACO. So, the code is optimized to fix this error.
> >>
> >> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 56 ++++++++++++------------=
-
> >>  1 file changed, 27 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c
> >> index 1f92fb1e7421..70cf2d0c7683 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -150,42 +150,40 @@ int amdgpu_driver_load_kms(struct amdgpu_device =
*adev, unsigned long flags)
> >>         }
> >>
> >>         adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
> >> -       if (amdgpu_device_supports_px(dev) &&
> >> -           (amdgpu_runtime_pm !=3D 0)) { /* enable PX as runtime mode=
 */
> >> -               adev->pm.rpm_mode =3D AMDGPU_RUNPM_PX;
> >> -               dev_info(adev->dev, "Using ATPX for runtime pm\n");
> >> -       } else if (amdgpu_device_supports_boco(dev) &&
> >> -                  (amdgpu_runtime_pm !=3D 0)) { /* enable boco as run=
time mode */
> >> -               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BOCO;
> >> -               dev_info(adev->dev, "Using BOCO for runtime pm\n");
> >> -       } else if (amdgpu_device_supports_baco(dev) &&
> >> -                  (amdgpu_runtime_pm !=3D 0)) {
> >> -               switch (adev->asic_type) {
> >> -               case CHIP_VEGA20:
> >> -               case CHIP_ARCTURUS:
> >> -                       /* enable BACO as runpm mode if runpm=3D1 */
> >> -                       if (amdgpu_runtime_pm > 0)
> >> -                               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BAC=
O;
> >> -                       break;
> >> -               case CHIP_VEGA10:
> >> -                       /* enable BACO as runpm mode if noretry=3D0 */
> >> -                       if (!adev->gmc.noretry)
> >> +       if (amdgpu_runtime_pm > 0) {
> >> +               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> >> +               dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> >
> > Does this need special handling for BAMACO?  Setting
> > amdgpu_runtime_pm=3D2 is supposed to set BAMACO and 1 is supposed to
> > force BACO.
> >
>
> BAMACO currently is detected in pptable_funcs->baco_enter() and baco_exit=
 function.
> We just need to set BACO flag here.
>
> How about adding a new mode AMDGPU_RUNPM_BAMACO, so we only have to check
> amdgpu_runtime_pm and detect the PM mode in initialization stage and don'=
t
> need to handle it later.

Sure that works, although we still need to verify that it is supported
on the platform or not so I think we still need to check if BAMACO is
supported in the baco_enter function and then fall back to BACO if
BAMACO is not supported.

Alex

>
> Regards,
> Ma Jun
>
> > Alex
> >
> >> +       } else if (amdgpu_runtime_pm !=3D 0) {
> >> +               if (amdgpu_device_supports_px(dev)) { /* enable PX as =
runtime mode */
> >> +                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_PX;
> >> +                       dev_info(adev->dev, "Using ATPX for runtime pm=
\n");
> >> +               } else if (amdgpu_device_supports_boco(dev)) { /* enab=
le boco as runtime mode */
> >> +                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_BOCO;
> >> +                       dev_info(adev->dev, "Using BOCO for runtime pm=
\n");
> >> +               } else if (amdgpu_device_supports_baco(dev)) {
> >> +                       switch (adev->asic_type) {
> >> +                       case CHIP_VEGA10:
> >> +                               /* enable BACO as runpm mode if noretr=
y=3D0 */
> >> +                               if (!adev->gmc.noretry)
> >> +                                       adev->pm.rpm_mode =3D AMDGPU_R=
UNPM_BACO;
> >> +                               break;
> >> +                       default:
> >> +                               /* enable BACO as runpm mode on CI+ */
> >>                                 adev->pm.rpm_mode =3D AMDGPU_RUNPM_BAC=
O;
> >> -                       break;
> >> -               default:
> >> -                       /* enable BACO as runpm mode on CI+ */
> >> -                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> >> -                       break;
> >> -               }
> >> +                               break;
> >> +                       }
> >>
> >> -               if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO)
> >> -                       dev_info(adev->dev, "Using BACO for runtime pm=
\n");
> >> +                       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO=
)
> >> +                               dev_info(adev->dev, "Using BACO for ru=
ntime pm\n");
> >> +               }
> >>         }
> >>
> >> +       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
> >> +               dev_info(adev->dev, "No PM mode for runtime pm\n");
> >> +
> >>         /* Call ACPI methods: require modeset init
> >>          * but failure is not fatal
> >>          */
> >> -
> >>         acpi_status =3D amdgpu_acpi_init(adev);
> >>         if (acpi_status)
> >>                 dev_dbg(dev->dev, "Error during ACPI methods call\n");
> >> --
> >> 2.34.1
> >>
