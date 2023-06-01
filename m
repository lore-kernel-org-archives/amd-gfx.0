Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCB5C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 03:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F169210E1F3;
	Thu,  1 Jun 2023 03:22:05 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FDD10E1F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 03:22:04 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5559cd68b67so298722eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 20:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685589723; x=1688181723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D295J/QxlMKYChINbKxmAVrJjfQ/kKaIAn1JZhCWeU8=;
 b=q3ewd6iXapUrlNC3ve1g1hK0ILij1ekvoRWmkNwVzMXNyvOrJ4P4ZVglhYNloNG6Cq
 xMK6phjt2aWZj636PE2yTiN/L0EKMB5Chna7Y3c9fZ9i6iyD5/xR6ZclSiMF2H2FyEYI
 CtdOYRzleiEPkfHio7RTko4Mne6sQatTTRk5taCUzg3+SFNLDVM2KfLxhDemKEDFbFBu
 3IcD3LP8DHmm4fh+ERHONM+pUIg6NV6iRq5+YE3o0BxJ5+ymYXV4eD/A6oqZvujevgfM
 37ufOScH9J3PSqvGU98vQu38fi8ji9uUZpuZqmnkIpCnOeMcQeFi+erfMAmThAmEH6oY
 UiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685589723; x=1688181723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D295J/QxlMKYChINbKxmAVrJjfQ/kKaIAn1JZhCWeU8=;
 b=Bdlbc/QMegAPLrfdBZ1n3S72IhQ2sbskifeNhm9yJSD9UjDb4ZBcHXQMbQn0jCqm81
 A8yd8t9aYWKoLFRN8LuG+RYPvQWJ8i59VO+oEuDU0fTbKe+O5Kdjs3qYTY9cQwAQvP4d
 986zOmxtvehxhrw4rN0PoOwIqTOujBguJ4tzKZfvtDCGArEigdwSr8rG+eeNzDcYezKa
 nUyq1jwmc3gqU+2oxMKsb/45Vn4/IezNniJKDtfGdNyQfvRZduyIrhk0T1gL4HsnlEtp
 /wUcfhoZdU614MSAAImwWWA82iTjVqLAfGFa0ZrKaakjpKqsFu8ZSC4SYpdo/BdmYa4Z
 Jkgg==
X-Gm-Message-State: AC+VfDx5zTTAdpsq7YZznM9jfMZG2IeRYskV1040Iv1FMaz/aYIiPPli
 YeQ053dfzMP1VXRo2vVkUoFl7I+w7mk3H6dXn/o=
X-Google-Smtp-Source: ACHHUZ4M0Mi45yT1Cy2QnuW/HaQPPA6M8KQbnumL4GxuuJ69ulyOKPYWnoB/G0qIuspCy1SAGsXDIalEJyIcyLj/t9I=
X-Received: by 2002:a4a:2c93:0:b0:555:5ab5:a0e2 with SMTP id
 o141-20020a4a2c93000000b005555ab5a0e2mr4482819ooo.6.1685589723433; Wed, 31
 May 2023 20:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
In-Reply-To: <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 31 May 2023 23:21:52 -0400
Message-ID: <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 31, 2023 at 9:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, May 30, 2023 at 6:34=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") showed
> > improvements to power consumption over suspend when s0ix wasn't enabled=
 in
> > BIOS and the system didn't support S3.
> >
> > This patch however was misguided because the reason the system didn't
> > support S3 was because SMT was disabled in OEM BIOS setup.
> > This prevented the BIOS from allowing S3.
> >
> > Also allowing GPUs to use the s2idle path actually causes problems if
> > they're invoked on systems that may not support s2idle in the platform
> > firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fai=
ls
> > for any reason, which could lead to unexpected flows.
> >
> > The original commit also fixed a problem during resume from suspend to =
idle
> > without hardware support, but this is no longer necessary with commit
> > ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")
> >
> > Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> > to make it match the expected behavior again.
> >
> > Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> > Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_acpi.c#L1060
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Patch 1 is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Patch 2 seems a bit much, but I could be convinced if you think it
> will actually help more than a warn would.  Users already assume warn
> is a kernel crash.  I'm not sure the average user makes a distinction
> between warn and err.
>

You'll need to revert d2a197a45daacd ("drm/amd: Only run s3 or s0ix if
system is configured properly") as well, otherwise, we'll break
runtime pm.

Alex

> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index aeeec211861c..e1b01554e323 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_d=
evice *adev)
> >          * S0ix even though the system is suspending to idle, so return=
 false
> >          * in that case.
> >          */
> > -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> >                 dev_warn_once(adev->dev,
> >                               "Power consumption will be higher as BIOS=
 has not been configured for suspend-to-idle.\n"
> >                               "To use suspend-to-idle change the sleep =
mode in BIOS setup.\n");
> > +               return false;
> > +       }
> >
> >  #if !IS_ENABLED(CONFIG_AMD_PMC)
> >         dev_warn_once(adev->dev,
> >                       "Power consumption will be higher as the kernel h=
as not been compiled with CONFIG_AMD_PMC.\n");
> > -#endif /* CONFIG_AMD_PMC */
> > +       return false;
> > +#else
> >         return true;
> > +#endif /* CONFIG_AMD_PMC */
> >  }
> >
> >  #endif /* CONFIG_SUSPEND */
> > --
> > 2.34.1
> >
