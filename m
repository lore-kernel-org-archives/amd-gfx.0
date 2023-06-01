Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5384C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 18:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5587010E0C1;
	Thu,  1 Jun 2023 18:23:38 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F6B10E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 18:23:36 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-19f3550bcceso1256037fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jun 2023 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685643815; x=1688235815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMuqrvJexzbwANov+a4x8C+LNXsBKDI37cTRjl/MluQ=;
 b=nkWBIBdHdjgz9CXmgSCtRvnEXjjs42KMxV49PX6MaVlSIeMBRqkmVipb0NUN1iGfKP
 lAkXSRphTHgIcdt4PEi+uYNzfiEzWJ7xVvvySDQ1ArT3HBTm1jP1yfQzUZ+0qf+PNwMB
 uaTWEs5Z9WZ8e6OwXXaoraQTTEN6IOAlRE7UhoT80tcbLB8dsxNqo7/QLQjZ1bPX1ev6
 WMZ99Na6whtLXXpgFZY/QvmU2bcjkVyOLc7+dWxeWrreL/lxgSXSLelC9ck0l1dxO+3y
 00IDKDirZY/tvr6ChCHHAg/TmbG4PrBzOuQqMlpAichzW8OYHO4gWyzLfGqx6yWo6aZv
 /otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685643815; x=1688235815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMuqrvJexzbwANov+a4x8C+LNXsBKDI37cTRjl/MluQ=;
 b=C2vArXSKZylkVd1LwiB9sC0Y70DKpAeWfXoSnUM7C9Yk9j0JSotTkM+PYkzGQcjuFc
 3N8JfhsZV5N+m34BfhVyqwircXKARxc6a9fiAET/7Jz9R40B7Z64disETm/9Ei3gRwE1
 bgWl/BoiMyPs3Mla+AB6ZQy00Iv5GQ6AH3+9dW5kiQ0ni2a20l3Wvbtou+Ba6JxdIgYG
 JQNd8LGebWRk9GEzDT95899ARwWjxiSh56AY1bOKsMv7iG2QoaKjdNRw5YCDyeohQ5J3
 DfLxOBihm6ybL3QxKzmOZUQIx4ls6U2hlKx01dnq46XFejx3xyDNn3F6Cwe2iNaj7/qd
 sRPA==
X-Gm-Message-State: AC+VfDwug0P0ypm74GUKH67dLRCU77Pqua3ziWY8Oowx/z6xk2ud2aQf
 SnLlwS9jnK5sou+Fn7lypI02irS1VeCtoeTS7E1Dg0S0yz4=
X-Google-Smtp-Source: ACHHUZ6Ral4or+izOJWtYQ0W6HFTe/QtqZwVYeXY0SPslIPUJuY6WtNHcX9/kv7JNPMblnMsC0Mg7n521sflZE98s1k=
X-Received: by 2002:a05:6870:e6d2:b0:19e:8f22:f0c0 with SMTP id
 s18-20020a056870e6d200b0019e8f22f0c0mr62514oak.9.1685643815383; Thu, 01 Jun
 2023 11:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
 <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
 <MN0PR12MB610115263A4DEE12FCAB5D69E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CADnq5_PSsLLC7gRTDohur+2Oy2g_r0ziwOottbRVdWrJZ4HxAw@mail.gmail.com>
 <MN0PR12MB61015B1C47145EE26E88440BE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61015B1C47145EE26E88440BE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Jun 2023 14:23:24 -0400
Message-ID: <CADnq5_MV+SWQ25j0tXY991f4aofvM9qfJadWY=pm3Gmzze-haw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
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

On Thu, Jun 1, 2023 at 1:32=E2=80=AFPM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, June 1, 2023 11:15 AM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=ADndola
> > <rafael@espindo.la>
> > Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support
> > again
> >
> > On Thu, Jun 1, 2023 at 11:33=E2=80=AFAM Limonciello, Mario
> > <Mario.Limonciello@amd.com> wrote:
> > >
> > > [AMD Official Use Only - General]
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Wednesday, May 31, 2023 10:22 PM
> > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=ADnd=
ola
> > > > <rafael@espindo.la>
> > > > Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS sup=
port
> > > > again
> > > >
> > > > On Wed, May 31, 2023 at 9:26=E2=80=AFAM Alex Deucher
> > <alexdeucher@gmail.com>
> > > > wrote:
> > > > >
> > > > > On Tue, May 30, 2023 at 6:34=E2=80=AFPM Mario Limonciello
> > > > > <mario.limonciello@amd.com> wrote:
> > > > > >
> > > > > > commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support"=
)
> > > > showed
> > > > > > improvements to power consumption over suspend when s0ix wasn't
> > > > enabled in
> > > > > > BIOS and the system didn't support S3.
> > > > > >
> > > > > > This patch however was misguided because the reason the system
> > didn't
> > > > > > support S3 was because SMT was disabled in OEM BIOS setup.
> > > > > > This prevented the BIOS from allowing S3.
> > > > > >
> > > > > > Also allowing GPUs to use the s2idle path actually causes probl=
ems if
> > > > > > they're invoked on systems that may not support s2idle in the p=
latform
> > > > > > firmware. `systemd` has a tendency to try to use `s2idle` if `d=
eep` fails
> > > > > > for any reason, which could lead to unexpected flows.
> > > > > >
> > > > > > The original commit also fixed a problem during resume from sus=
pend
> > to
> > > > idle
> > > > > > without hardware support, but this is no longer necessary with =
commit
> > > > > > ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than
> > Raven")
> > > > > >
> > > > > > Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS
> > > > support")
> > > > > > to make it match the expected behavior again.
> > > > > >
> > > > > > Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> > > > > > Link:
> > > >
> > https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu
> > > > /amdgpu_acpi.c#L1060
> > > > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > >
> > > > > Patch 1 is:
> > > > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > Patch 2 seems a bit much, but I could be convinced if you think i=
t
> > > > > will actually help more than a warn would.  Users already assume =
warn
> > > > > is a kernel crash.  I'm not sure the average user makes a distinc=
tion
> > > > > between warn and err.
> > > > >
> > > >
> > > > You'll need to revert d2a197a45daacd ("drm/amd: Only run s3 or s0ix=
 if
> > > > system is configured properly") as well, otherwise, we'll break
> > > > runtime pm.
> > > >
> > >
> > > Can you elaborate more on your thought process?  d2a197a45daacd was
> > added in 5.18
> > > and cf488dcd0ab7 was added in 6.3.  I can't imagine runtime PM is bro=
ken
> > the whole time
> > > on dGPUs.
> >
> > I tested this patch yesterday and it broke runtime pm because
> > amdgpu_pmops_prepare() returned 1.  I haven't delved into what
> > condition broke.  Reverting this patch restored runtime pm.  This is a
> > Threadripper box that only supports S3.  The dGPUs were polaris and
> > navi2x.
> >
>
> But runtime_suspend isn't supposed to run the prepare() callback AFACIT.
> SMART_PREPARE is only used for system wide suspend/resume.

Not sure what is happening then as amdgpu_acpi_is_s0ix_active() only
affects amdgpu_pmops_prepare(), amdgpu_pmops_suspend(), and
amdgpu_pmops_resume().  I'll try to trace what is going on.

Alex

>
> > Alex
> >
> >
> > >
> > > > Alex
> > > >
> > > > > Alex
> > > > >
> > > > > > ---
> > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
> > > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > > index aeeec211861c..e1b01554e323 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > > @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct
> > > > amdgpu_device *adev)
> > > > > >          * S0ix even though the system is suspending to idle, s=
o return false
> > > > > >          * in that case.
> > > > > >          */
> > > > > > -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > > > > > +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> > > > > >                 dev_warn_once(adev->dev,
> > > > > >                               "Power consumption will be higher=
 as BIOS has not been
> > > > configured for suspend-to-idle.\n"
> > > > > >                               "To use suspend-to-idle change th=
e sleep mode in BIOS
> > > > setup.\n");
> > > > > > +               return false;
> > > > > > +       }
> > > > > >
> > > > > >  #if !IS_ENABLED(CONFIG_AMD_PMC)
> > > > > >         dev_warn_once(adev->dev,
> > > > > >                       "Power consumption will be higher as the =
kernel has not
> > been
> > > > compiled with CONFIG_AMD_PMC.\n");
> > > > > > -#endif /* CONFIG_AMD_PMC */
> > > > > > +       return false;
> > > > > > +#else
> > > > > >         return true;
> > > > > > +#endif /* CONFIG_AMD_PMC */
> > > > > >  }
> > > > > >
> > > > > >  #endif /* CONFIG_SUSPEND */
> > > > > > --
> > > > > > 2.34.1
> > > > > >
