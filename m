Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9EBC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 19:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A841010E267;
	Thu,  1 Jun 2023 19:01:21 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28CF10E267
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 19:01:19 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-557c9d7011aso942432eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jun 2023 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685646078; x=1688238078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrjR2vTHJl7GJl2nGjvFNuaGcAxjwCU1dEfBnmk1YwM=;
 b=ctN1gB+0myaX8ihdepWYNSz4UlzuiaoS1bwccpRLGT4myYzUD/b4lKJ9T//eZ67wTa
 U29N591LOHOSy7Kwys8pvQxGzoCqM8GYHk3ZpYiO0jQEvzRnZ/N6fArjC1Wwe7n6TuPv
 4s9PnPjNNMi+6Bnprh9HHtdhl7AqlUI4CBZxo6TN8GhW4LBpovNrKHwaegaP3qzgOvEy
 0l84Nf2wXxVmlfMA2SqCO2ZVVtG19b6T58t+08C1yMAu7Yc3RaJjI7MhUq6XjnoN3uZh
 y1354uumdhk91L3THF59Ry/gl8X8TUw78E7sO+r/m4w0+N+WRz6TomYENF8OYqRQgToj
 dQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685646078; x=1688238078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrjR2vTHJl7GJl2nGjvFNuaGcAxjwCU1dEfBnmk1YwM=;
 b=M6/xSudlxmTitbppdi81IQchDh1ibk33cjeaUe8ewsEN2V2p4RXEsW6MrAyIvZi/qr
 wHYuhRYx5T2OvjUPsvuklEnrs2Peb0QV6QBWV4PDHwv26JDaNZ9dIETDXW5AdkCe3nV1
 Fu36UTSwhproshjcDnTfL4SeHxHzKeESa0w45XYyOrdF4B3gK2NFe+hd/Ecpfa80KLA/
 QBm1tY3HtPTm6XQV9qIZwKdy7SpKI7LIzvoM5Wp2GVivT0nqv5a9+E5uc1RJgARQ7PB9
 nYhCYknfrRB33TmmHAOp9H33VcJGZujhdXhghMzlunGp2sNLlleINGBmfun742asWj5f
 Fsjg==
X-Gm-Message-State: AC+VfDyF0xnH9zlV+Oi3G2/mqDUNaQnkCofRozMQB8SVZxEOs/GiPnWU
 L01eSXRkqRJZ8fr05vW1BElY4hzPI97X7MqdqOwDYIkV
X-Google-Smtp-Source: ACHHUZ5lBDTvq6NKwPnqyOU2ijg4ZNOU9JEZAXuJTDrF3sFvu0U4ewlDhX7DUAptkVfMl7opseqTRqW/5kD/WTq5+fo=
X-Received: by 2002:a05:6820:1acc:b0:555:5fa3:1519 with SMTP id
 bu12-20020a0568201acc00b005555fa31519mr1472198oob.4.1685646078399; Thu, 01
 Jun 2023 12:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
 <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
 <MN0PR12MB610115263A4DEE12FCAB5D69E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CADnq5_PSsLLC7gRTDohur+2Oy2g_r0ziwOottbRVdWrJZ4HxAw@mail.gmail.com>
 <MN0PR12MB61015B1C47145EE26E88440BE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CADnq5_MV+SWQ25j0tXY991f4aofvM9qfJadWY=pm3Gmzze-haw@mail.gmail.com>
In-Reply-To: <CADnq5_MV+SWQ25j0tXY991f4aofvM9qfJadWY=pm3Gmzze-haw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Jun 2023 15:01:06 -0400
Message-ID: <CADnq5_OGw6r7ObC_h1ypFRtnz8OZ_WubRQEgKagdzsuUvv6jHg@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 2:23=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Thu, Jun 1, 2023 at 1:32=E2=80=AFPM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [AMD Official Use Only - General]
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Thursday, June 1, 2023 11:15 AM
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=ADndol=
a
> > > <rafael@espindo.la>
> > > Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS suppo=
rt
> > > again
> > >
> > > On Thu, Jun 1, 2023 at 11:33=E2=80=AFAM Limonciello, Mario
> > > <Mario.Limonciello@amd.com> wrote:
> > > >
> > > > [AMD Official Use Only - General]
> > > >
> > > > > -----Original Message-----
> > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > Sent: Wednesday, May 31, 2023 10:22 PM
> > > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > > Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=AD=
ndola
> > > > > <rafael@espindo.la>
> > > > > Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS s=
upport
> > > > > again
> > > > >
> > > > > On Wed, May 31, 2023 at 9:26=E2=80=AFAM Alex Deucher
> > > <alexdeucher@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > On Tue, May 30, 2023 at 6:34=E2=80=AFPM Mario Limonciello
> > > > > > <mario.limonciello@amd.com> wrote:
> > > > > > >
> > > > > > > commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS suppor=
t")
> > > > > showed
> > > > > > > improvements to power consumption over suspend when s0ix wasn=
't
> > > > > enabled in
> > > > > > > BIOS and the system didn't support S3.
> > > > > > >
> > > > > > > This patch however was misguided because the reason the syste=
m
> > > didn't
> > > > > > > support S3 was because SMT was disabled in OEM BIOS setup.
> > > > > > > This prevented the BIOS from allowing S3.
> > > > > > >
> > > > > > > Also allowing GPUs to use the s2idle path actually causes pro=
blems if
> > > > > > > they're invoked on systems that may not support s2idle in the=
 platform
> > > > > > > firmware. `systemd` has a tendency to try to use `s2idle` if =
`deep` fails
> > > > > > > for any reason, which could lead to unexpected flows.
> > > > > > >
> > > > > > > The original commit also fixed a problem during resume from s=
uspend
> > > to
> > > > > idle
> > > > > > > without hardware support, but this is no longer necessary wit=
h commit
> > > > > > > ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than
> > > Raven")
> > > > > > >
> > > > > > > Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS
> > > > > support")
> > > > > > > to make it match the expected behavior again.
> > > > > > >
> > > > > > > Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> > > > > > > Link:
> > > > >
> > > https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgp=
u
> > > > > /amdgpu_acpi.c#L1060
> > > > > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > >
> > > > > > Patch 1 is:
> > > > > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > > Patch 2 seems a bit much, but I could be convinced if you think=
 it
> > > > > > will actually help more than a warn would.  Users already assum=
e warn
> > > > > > is a kernel crash.  I'm not sure the average user makes a disti=
nction
> > > > > > between warn and err.
> > > > > >
> > > > >
> > > > > You'll need to revert d2a197a45daacd ("drm/amd: Only run s3 or s0=
ix if
> > > > > system is configured properly") as well, otherwise, we'll break
> > > > > runtime pm.
> > > > >
> > > >
> > > > Can you elaborate more on your thought process?  d2a197a45daacd was
> > > added in 5.18
> > > > and cf488dcd0ab7 was added in 6.3.  I can't imagine runtime PM is b=
roken
> > > the whole time
> > > > on dGPUs.
> > >
> > > I tested this patch yesterday and it broke runtime pm because
> > > amdgpu_pmops_prepare() returned 1.  I haven't delved into what
> > > condition broke.  Reverting this patch restored runtime pm.  This is =
a
> > > Threadripper box that only supports S3.  The dGPUs were polaris and
> > > navi2x.
> > >
> >
> > But runtime_suspend isn't supposed to run the prepare() callback AFACIT=
.
> > SMART_PREPARE is only used for system wide suspend/resume.
>
> Not sure what is happening then as amdgpu_acpi_is_s0ix_active() only
> affects amdgpu_pmops_prepare(), amdgpu_pmops_suspend(), and
> amdgpu_pmops_resume().  I'll try to trace what is going on.

Nevermind, now I can't repro it.

Alex


>
> Alex
>
> >
> > > Alex
> > >
> > >
> > > >
> > > > > Alex
> > > > >
> > > > > > Alex
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
> > > > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > > > index aeeec211861c..e1b01554e323 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > > > > @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struc=
t
> > > > > amdgpu_device *adev)
> > > > > > >          * S0ix even though the system is suspending to idle,=
 so return false
> > > > > > >          * in that case.
> > > > > > >          */
> > > > > > > -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > > > > > > +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) =
{
> > > > > > >                 dev_warn_once(adev->dev,
> > > > > > >                               "Power consumption will be high=
er as BIOS has not been
> > > > > configured for suspend-to-idle.\n"
> > > > > > >                               "To use suspend-to-idle change =
the sleep mode in BIOS
> > > > > setup.\n");
> > > > > > > +               return false;
> > > > > > > +       }
> > > > > > >
> > > > > > >  #if !IS_ENABLED(CONFIG_AMD_PMC)
> > > > > > >         dev_warn_once(adev->dev,
> > > > > > >                       "Power consumption will be higher as th=
e kernel has not
> > > been
> > > > > compiled with CONFIG_AMD_PMC.\n");
> > > > > > > -#endif /* CONFIG_AMD_PMC */
> > > > > > > +       return false;
> > > > > > > +#else
> > > > > > >         return true;
> > > > > > > +#endif /* CONFIG_AMD_PMC */
> > > > > > >  }
> > > > > > >
> > > > > > >  #endif /* CONFIG_SUSPEND */
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
