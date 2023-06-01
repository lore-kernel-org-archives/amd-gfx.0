Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E8C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 16:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D3710E036;
	Thu,  1 Jun 2023 16:14:56 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3757B10E580
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 16:14:54 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-19f268b1d83so929094fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jun 2023 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685636093; x=1688228093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDTF1dxP38D6BWtYQZzES+nhQ4V/B517i5WJP67hI8E=;
 b=NgkM9Z/faMiVf5dA+OiJzA1s3nAYCgh7EhrlnOHbqysdbfOZGJmSDEjym9D/RPjLsU
 mK8+mRowr901sKQSXGt6bAbo3uyk8uF94G5pjIbX92nVxVeeS+z9QFB/dgfE/KB+CBkv
 zrxHSvKYGUdzw+DF5Tnu+7kBstuYwwbZUZcLBWwzsoq3g6mhMd/n2SElX8aq4NdatoMN
 sgh0S70XNmRl+uaOjNFl3cwXhzwK/H7ILgn8BiJp/V4sUC9L3YlsV0yEAuD8RfV0+fsM
 Sj2fvsr2qDqb5+Mq7BiGaRuofy1KBXsuQo3ZyMqjWCGRS2yIaIqu5ekzqSwhYMBiC6kU
 40TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685636093; x=1688228093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDTF1dxP38D6BWtYQZzES+nhQ4V/B517i5WJP67hI8E=;
 b=SeGW/rkHNHOb6FR1RoNmBo8vMbnYkR3S0PcMlPOcCivBTVDDlxWGglAocEbQu/NJxJ
 DwV4uGDy34jT38KzUGiuH87o3qLAKW4r3hNSB7JjLrJk4+mwcMWCvoa7vK+KxRHmvnno
 XTBiqSvLCwHhQ4sLv3bugnKdn3riPXpc+Kw8Pfdp43QjRFjLcYgGKqiMTw1PD+ABWEEu
 L7IsZiAt6xs95lGZvQQy8xTf57lU6rnZFO78nfLhVIQ9AjO5ThUCqT6Za56qjPx8UFWM
 5GHQg/3IqRCmlVuuTzG01UwJ06xfQSua3KDXxyLP1469gbKP6tZoCmRW25j6kuIcnW29
 3xgQ==
X-Gm-Message-State: AC+VfDyqtAmQIJUZodkACmoy0qKGiKmzzZynlmB+wKJfgZzoMSI1foY2
 mcho7cPuPjeqO4JmniX4Xln8Fqqfun8IK5BUVms=
X-Google-Smtp-Source: ACHHUZ7L8eRim0PK8TGoVpyEH9OtxzjUpUGZ79/KqZXHjeugp4omDSAW4fJLnyvhhKgm9j3mTGjX3CGmlACukyaiBLE=
X-Received: by 2002:a05:6870:e7c3:b0:199:cadf:10b0 with SMTP id
 q3-20020a056870e7c300b00199cadf10b0mr5570474oak.13.1685636092703; Thu, 01 Jun
 2023 09:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
 <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
 <MN0PR12MB610115263A4DEE12FCAB5D69E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610115263A4DEE12FCAB5D69E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Jun 2023 12:14:40 -0400
Message-ID: <CADnq5_PSsLLC7gRTDohur+2Oy2g_r0ziwOottbRVdWrJZ4HxAw@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 11:33=E2=80=AFAM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, May 31, 2023 10:22 PM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=ADndola
> > <rafael@espindo.la>
> > Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support
> > again
> >
> > On Wed, May 31, 2023 at 9:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com>
> > wrote:
> > >
> > > On Tue, May 30, 2023 at 6:34=E2=80=AFPM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > >
> > > > commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> > showed
> > > > improvements to power consumption over suspend when s0ix wasn't
> > enabled in
> > > > BIOS and the system didn't support S3.
> > > >
> > > > This patch however was misguided because the reason the system didn=
't
> > > > support S3 was because SMT was disabled in OEM BIOS setup.
> > > > This prevented the BIOS from allowing S3.
> > > >
> > > > Also allowing GPUs to use the s2idle path actually causes problems =
if
> > > > they're invoked on systems that may not support s2idle in the platf=
orm
> > > > firmware. `systemd` has a tendency to try to use `s2idle` if `deep`=
 fails
> > > > for any reason, which could lead to unexpected flows.
> > > >
> > > > The original commit also fixed a problem during resume from suspend=
 to
> > idle
> > > > without hardware support, but this is no longer necessary with comm=
it
> > > > ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")
> > > >
> > > > Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS
> > support")
> > > > to make it match the expected behavior again.
> > > >
> > > > Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> > > > Link:
> > https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu
> > /amdgpu_acpi.c#L1060
> > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >
> > > Patch 1 is:
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > Patch 2 seems a bit much, but I could be convinced if you think it
> > > will actually help more than a warn would.  Users already assume warn
> > > is a kernel crash.  I'm not sure the average user makes a distinction
> > > between warn and err.
> > >
> >
> > You'll need to revert d2a197a45daacd ("drm/amd: Only run s3 or s0ix if
> > system is configured properly") as well, otherwise, we'll break
> > runtime pm.
> >
>
> Can you elaborate more on your thought process?  d2a197a45daacd was added=
 in 5.18
> and cf488dcd0ab7 was added in 6.3.  I can't imagine runtime PM is broken =
the whole time
> on dGPUs.

I tested this patch yesterday and it broke runtime pm because
amdgpu_pmops_prepare() returned 1.  I haven't delved into what
condition broke.  Reverting this patch restored runtime pm.  This is a
Threadripper box that only supports S3.  The dGPUs were polaris and
navi2x.

Alex


>
> > Alex
> >
> > > Alex
> > >
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > index aeeec211861c..e1b01554e323 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > > @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct
> > amdgpu_device *adev)
> > > >          * S0ix even though the system is suspending to idle, so re=
turn false
> > > >          * in that case.
> > > >          */
> > > > -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > > > +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> > > >                 dev_warn_once(adev->dev,
> > > >                               "Power consumption will be higher as =
BIOS has not been
> > configured for suspend-to-idle.\n"
> > > >                               "To use suspend-to-idle change the sl=
eep mode in BIOS
> > setup.\n");
> > > > +               return false;
> > > > +       }
> > > >
> > > >  #if !IS_ENABLED(CONFIG_AMD_PMC)
> > > >         dev_warn_once(adev->dev,
> > > >                       "Power consumption will be higher as the kern=
el has not been
> > compiled with CONFIG_AMD_PMC.\n");
> > > > -#endif /* CONFIG_AMD_PMC */
> > > > +       return false;
> > > > +#else
> > > >         return true;
> > > > +#endif /* CONFIG_AMD_PMC */
> > > >  }
> > > >
> > > >  #endif /* CONFIG_SUSPEND */
> > > > --
> > > > 2.34.1
> > > >
