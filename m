Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CDC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 21:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C5910E072;
	Tue, 30 May 2023 21:34:28 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF6A10E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 21:34:26 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6af7e368bb7so2070687a34.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685482465; x=1688074465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yqa22p9hy5Zf3W/z5LP8/ro9Fau9K60eNyXyaaw8M/U=;
 b=mBH8xr/P1oWYTu2rbfNz8imf0XTsPn/77jQPPafiNzEKqayUqUXsngS8eC28splbHX
 1fjXHDtiLgn8uCTJ2He7rU3m3kdicPsNLLYiJySY2b2ra3m8i+mRoztzpIHTwZURpvkm
 QSqVYakjOImKkFEiYpxln3R+CfRwg+zVwejPGVLPEjo5OSTokhg0aENSKORaQA3Xeh69
 rUVoUlgglEP5mdactlTiNjDrJRI/iHT9fBfPHp2osF8Z3kMkZ1JJcVYF0A3UbiNCD82Y
 D0uTeR4akumJPk0WVji3ATTLjdtNoK6gAOgwY1LD0cjqdoqrLQYGWkIH5uAnhUKJt8kc
 AxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685482465; x=1688074465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yqa22p9hy5Zf3W/z5LP8/ro9Fau9K60eNyXyaaw8M/U=;
 b=CKkd7Aa7hVo2j+WRTLI8ggC58bwHX71uLbD4xWMCBuEUPLz2k1Qa7y61ZBo4YDq/P1
 waYbxh1+RB96IBYH2vzW2/snk1sSDwM6V5MIYxdKwxcX48wV57LTPASxJtt+b1DuYJFF
 /plY2BaJkY1r2PvVJ8VPLOR4GMwXRYso92VNgk9dVG7UlfRqvKxNyvZZdampDJjfZXFw
 BMn1zXu0YdUwtqq7gKBwWqO36QKS1xTZz9L2FxuZzZMoXKL4zaB5hkoG5NOY3JL6d5E7
 ieC6EcHckjhXMyu9o3uk1JSxkTY2A/NlslePN6kp0kiT+vrNSQA6NQOYt7HGP51zMgQ0
 5gXQ==
X-Gm-Message-State: AC+VfDyaBUzdqK5eKM0co7806tAuMUWdDhK+GJMdlbujvdoxCG7WdZie
 bROWmB2s0+MeWr2vHDvxMGsD0WhqUnUQeCq8Fms=
X-Google-Smtp-Source: ACHHUZ7/zeTKMguL7qVHTDs+5nKTRjOxT2RNF4EiWaBHW8xcJx08z1yj/g/a9bbR7NrzjCvtFlC75sFbVHMLSvZQ+rQ=
X-Received: by 2002:a9d:7416:0:b0:6af:7d99:1640 with SMTP id
 n22-20020a9d7416000000b006af7d991640mr290899otk.22.1685482464885; Tue, 30 May
 2023 14:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230530175301.231070-1-mario.limonciello@amd.com>
 <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
 <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 17:34:13 -0400
Message-ID: <CADnq5_Oke4oTrHK2+=dNpY-9p1TArRO6CVWQVvKocwHP-JS+2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 30, 2023 at 2:19=E2=80=AFPM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, May 30, 2023 1:16 PM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=ADndola
> > <rafael@espindo.la>
> > Subject: Re: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support ag=
ain
> >
> > On Tue, May 30, 2023 at 1:53=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> > showed
> > > improvements to power consumption over suspend when s0ix wasn't
> > enabled in
> > > BIOS and the system didn't support S3.
> > >
> > > This patch however was misguided because the reason the system didn't
> > > support S3 was because SMT was disabled in OEM BIOS setup.
> > > This prevented the BIOS from allowing S3.
> > >
> > > Also allowing GPUs to use the s2idle path actually causes problems if
> > > they're invoked on systems that may not support s2idle in the platfor=
m
> > > firmware. `systemd` has a tendency to try to use `s2idle` if `deep` f=
ails
> > > for any reason, which could lead to unexpected flows.
> > >
> > > To make this the behavior discoverable and expected, revert commit
> > > cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") and offer
> > > a message if SMT appears to be disabled.
> > >
> > > Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> > > Link:
> > https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu
> > /amdgpu_acpi.c#L1060
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > index 3a6b2e2089f6..a3523d03d769 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/xarray.h>
> > >  #include <linux/power_supply.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/sched/smt.h>
> > >  #include <linux/suspend.h>
> > >  #include <acpi/video.h>
> > >  #include <acpi/actbl.h>
> > > @@ -1473,6 +1474,13 @@ void amdgpu_acpi_release(void)
> > >   */
> > >  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
> > >  {
> > > +#ifdef CONFIG_X86
> > > +       if (!sched_smt_active()) {
> > > +               dev_warn_once(adev->dev,
> > > +                             "SMT is disabled by the BIOS.\n"
> > > +                             "To use suspend-to-ram enable SMT in BI=
OS setup.\n");
> > > +       }
> > > +#endif
> >
> > Will this generate a spurious warning on platforms that are natively no=
n-SMT?
>
> Yeah; it could.  I'm not sure how we can reliably detect this.  I thought=
 about looking for
> the 'ht' flag, but that probably wouldn't work for this case.
>
> Are there AMD Zen CPUs or APUs that are non-SMT?  Could gate the sched_sm=
t_active()
> check to only run when it's an AMD x86 Zen SoC.

Some of the more budget conscient Athlon parts don't have SMT IIRC.

Alex


>
> >
> > Alex
> >
> > >         return !(adev->flags & AMD_IS_APU) ||
> > >                 (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM);
> > >  }
> > > @@ -1499,16 +1507,20 @@ bool amdgpu_acpi_is_s0ix_active(struct
> > amdgpu_device *adev)
> > >          * S0ix even though the system is suspending to idle, so retu=
rn false
> > >          * in that case.
> > >          */
> > > -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > > +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> > >                 dev_warn_once(adev->dev,
> > >                               "Power consumption will be higher as BI=
OS has not been
> > configured for suspend-to-idle.\n"
> > >                               "To use suspend-to-idle change the slee=
p mode in BIOS
> > setup.\n");
> > > +               return false;
> > > +       }
> > >
> > >  #if !IS_ENABLED(CONFIG_AMD_PMC)
> > >         dev_warn_once(adev->dev,
> > >                       "Power consumption will be higher as the kernel=
 has not been
> > compiled with CONFIG_AMD_PMC.\n");
> > > -#endif /* CONFIG_AMD_PMC */
> > > +       return false;
> > > +#else
> > >         return true;
> > > +#endif /* CONFIG_AMD_PMC */
> > >  }
> > >
> > >  #endif /* CONFIG_SUSPEND */
> > > --
> > > 2.34.1
> > >
