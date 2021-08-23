Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_MIME_MALF autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33943C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 10:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC226137B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 10:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECC226137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7C6899DC;
	Mon, 23 Aug 2021 10:39:56 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10092899DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 10:39:55 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id n24so21157854ion.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=/pipjCVpLBB8OM3A/h9OhGFVizdo5lTvIJ3b9IDr1hc=;
 b=RNxYTPR8dnkAJ5YK0yk/BKZ/rbRnPmnC/Pyy0qe5w6WQaWVS1yGYQocaDYsKqxW9y+
 c7FooU8K0LsTA9+Ru7BN6hfkzTLq2aFgPMrnU1OM7B1WUJwRCc1/xfHVo6Xy+X/LcMvJ
 8bxjq/0FDplp7eq+6Ihys/B9brR9Gf/8+xB+lg/Lx9CX0DClpopscSSHqNiwkYZ+T+es
 yvrTbrux0zsoRJ5Gp9y2AgTkpwZw1xTZq1JyiCvtMb7W3aGKEVxpqofmMx6S6ZbQ+lBr
 G38RbD9tIVetjL0DnpSA+1h4cJqiODajPHzU7B/JRUpz3Zgs0UJPxLyTmcUWGSxHPQNd
 vonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=/pipjCVpLBB8OM3A/h9OhGFVizdo5lTvIJ3b9IDr1hc=;
 b=RUvl8nZePAzmnYEjGPrJA2Bq46hpQx1aUsdzSNrLq3Ky/5aKnL8j1D/0AYjCp9u1IM
 WKj0wQHosWUXsGpjy7rjOIWa2MFoVq8FHYbkr6CNalkfs1N73XYDqXIvPR9ECfkD7J+2
 zFxUlpmy3SaPLQIVOsPuunt+rsC87RuAjkUOCi8diE4G0H82bmVu7E4swDlPiCSsz3wP
 10ZOENh+QRh7g7VN0x11uD1y4eL82+fTpEkhQ1QH4dQeLaWVQ7VYF9KBgInWaPynK02u
 kgJTOI612+NOesTJtnHHESrAcCqFqcgqcADsUzZDmJWyPYfgveM7ejQfykJLwtczRFHg
 RmeQ==
X-Gm-Message-State: AOAM533FAvj7RftGpLqfYaWgNuGvF7TgmP6iOcpSnodHJrGv5lL0xAsD
 ALYm/Ga46K3cnCq7S4CtzlUmt6I5g5H4KWAHlBVBs+1WreU=
X-Google-Smtp-Source: ABdhPJxh0HdM64vA9wfvQl5Edj7O2DoLgmwfxAlgMlxO3gUX6TDvVbRHSSJv1ZI6kBS0TCtvlR8Ou/fke4fyyUJ8Y10=
X-Received: by 2002:a6b:d915:: with SMTP id r21mr14262151ioc.76.1629715194206; 
 Mon, 23 Aug 2021 03:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.1512.1629705579.907.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.1512.1629705579.907.amd-gfx@lists.freedesktop.org>
From: Evans Jahja <evansjahja13@gmail.com>
Date: Mon, 23 Aug 2021 17:39:58 +0700
Message-ID: <CAAq5pW_6ExZURMJkSPWr0+b_6XTzD0kON99+j9=vQVqQWL=sBQ@mail.gmail.com>
Subject: RE: Voltage control on Southern Island GPU using radeon
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000003c5e5405ca37a3f4"
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

--0000000000003c5e5405ca37a3f4
Content-Type: text/plain; charset="UTF-8"

Hi Kenneth,

I understand that changing voltage 'standalone' is not a good idea. In that
case, would it be possible to change the voltage table so that it would
give a lower clock on certain voltage?

For example, I would like to change

sclk 900, vddc: 1050

to

sclk 800, vddc: 1050

Thanks

On Mon, Aug 23, 2021, 14:59 <amd-gfx-request@lists.freedesktop.org> wrote:

> Send amd-gfx mailing list submissions to
>         amd-gfx@lists.freedesktop.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> or, via email, send a message with subject or body 'help' to
>         amd-gfx-request@lists.freedesktop.org
>
> You can reach the person managing the list at
>         amd-gfx-owner@lists.freedesktop.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of amd-gfx digest..."
>
>
> Today's Topics:
>
>    1. RE: Voltage control on Southern Island GPU using radeon
>       driver (Feng, Kenneth)
>    2. RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
>       UVD/VCE on suspend (Quan, Evan)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 23 Aug 2021 07:11:10 +0000
> From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
> To: "Koenig, Christian" <Christian.Koenig@amd.com>, Evans Jahja
>         <evansjahja13@gmail.com>, "amd-gfx@lists.freedesktop.org"
>         <amd-gfx@lists.freedesktop.org>
> Subject: RE: Voltage control on Southern Island GPU using radeon
>         driver
> Message-ID:
>         <
> BY5PR12MB55607F9193F1A315210D1B838EC49@BY5PR12MB5560.namprd12.prod.outlook.com
> >
>
> Content-Type: text/plain; charset="utf-8"
>
> [AMD Official Use Only]
>
> Hi Evans
> I'm sorry but I don't suggest you manually control the standalone voltage
> because it's predefined with the clock value.
> A decrease of voltage could hit the hardware critical path. You may need
> to change the clock and voltage together, we call it dpm level change.
> Thanks.
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Christian K?nig
> Sent: Monday, August 23, 2021 2:26 PM
> To: Evans Jahja <evansjahja13@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: Voltage control on Southern Island GPU using radeon driver
>
> [CAUTION: External Email]
>
> Hi Evans,
>
> in general the voltage tables are stored in the atombios and the best
> advice I can give you is to first double check if there isn't an updated
> BIOS for your hardware.
>
> But Alex is the expert on power management, especially for those older
> hardware generations. Maybe he has another idea what to try.
>
> Regards,
> Christian.
>
> Am 23.08.21 um 03:56 schrieb Evans Jahja:
> > Hi, I have a HAINAN GPU below:
> >
> > lspci -nn
> > 0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc.
> > [AMD/ATI] Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]
> >
> > I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.
> >
> > I'm trying to understand more on how voltage control works and how I
> > can modify the voltage for doing overvoltage / undervoltage on my GPU.
> > The reason is I am observing how running programs under high GPU load
> > (glmark2) would lead to crashes when I use dpm=1 in either radeon or
> > amdgpu driver, which seems to happen when I am reaching power level 4
> > (sclk 900MHz), while a lighter program like glxgears could run and
> > switch power levels  between 0,1,2 without issue under both drivers. I
> > believe my laptop might be faulty, but I would like to take this
> > opportunity to try fixing it from the driver's side so that it can run
> > anyway, however limited.
> >
> > Right now, I have managed to increase the performance of my GPU by
> > manually overwriting the sclk to 630MHz in all performance_levels in
> > radeon_pm.c, which surprises me as overriding the clock was not
> > possible for me to do previously via sysfs.
> >
> > I've managed to tweak both sclk and mclk (or so I believe), but I
> > still cannot tweak the voltage (vddc). The reason is, if I increase
> > the sclk to 650MHz, the lockup will happen again. Changing the
> > pl->vddc  variable does not seem to do anything. After various tracing
> > with printk, I understand that on my system:
> >
> > pi->voltage_control = radeon_atom_is_voltage_gpio(rdev,
> > SET_VOLTAGE_TYPE_ASIC_VDDC,
> >    VOLTAGE_OBJ_GPIO_LUT)
> >
> > this returns false, while:
> >
> > si_pi->voltage_control_svi2 =
> > radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYPE_ASIC_VDDC,
> >    VOLTAGE_OBJ_SVID2);
> >
> > This returns true, so I believe my system is using SVI2 somehow to set
> > the voltage. Having no experience with SVI2, I read online and found
> > out that SVI2 is a voltage regulator that uses Data / Clock pins to
> > clock-in 8 bits of information and convert it to some voltage value
> > between OFF, 0.5V -> 1.5V, offering fine control based on some look up
> > table.
> >
> > My questions are as follows:
> > Is it possible for me to modify my system so that I can manually
> > adjust the voltage to my GPU?
> >
> > Thank you very much in advance. This is the first time I deal with
> > kernel drivers, so any guidance on the matter helps a lot.
> >
> > - Evans
> >
> >
>
> ------------------------------
>
> Message: 2
> Date: Mon, 23 Aug 2021 07:59:36 +0000
> From: "Quan, Evan" <Evan.Quan@amd.com>
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James"
>         <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
>         <amd-gfx@lists.freedesktop.org>, "Liu, Leo" <Leo.Liu@amd.com>,
>         "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
>         <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
>         UVD/VCE on suspend
> Message-ID:
>         <
> DM6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.namprd12.prod.outlook.com
> >
>
> Content-Type: text/plain; charset="utf-8"
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, August 20, 2021 10:23 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, James <James.Zhu@amd.com>;
> > amd-gfx@lists.freedesktop.org; Liu, Leo <Leo.Liu@amd.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > UVD/VCE on suspend
> >
> > On Thu, Aug 19, 2021 at 10:15 PM Quan, Evan <Evan.Quan@amd.com> wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > Sent: Thursday, August 19, 2021 10:36 PM
> > > To: Zhu, James <James.Zhu@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > > Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > > UVD/VCE on suspend
> > >
> > >
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > > If that is done  ?
> > >
> > >
> > >
> > > +               amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +
> AMD_PG_STATE_GATE);
> > > +               amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +
> > > + AMD_CG_STATE_GATE);
> > >
> > >
> > >
> > > Usual order is CG followed by PG. It comes in the else part, so less
> likely to
> > happen. Nice to fix for code correctness purpose.
> > >
> > > [Quan, Evan] Thanks Lijo. Make sense to me. However, actually these
> code
> > were copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c.
> > Same logic was used there. So, maybe @Zhu, James or @Liu, Leo can share
> > some insights about this.
> > >
> >
> > It looks like it is wrong there as well.  We should be gating the clocks
> before
> > the power.  The order is also wrong in amdgpu_uvd_ring_begin_use().  We
> > need to ungate the power before the clocks
> [Quan, Evan] I created a patch for this. But during the verification, I
> got the errors below
> [   87.420822] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   88.443029] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   89.465386] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   90.487629] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   91.510380] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   92.533782] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   93.557400] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   94.580708] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   95.603832] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   96.627727] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> trying to reset the VCPU!!!
> [   96.657453] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
> giving up!!!
> [   96.665892] [drm:amdgpu_device_ip_set_powergating_state [amdgpu]]
> *ERROR* set_powergating_state of IP block <uvd_v6_0> failed -1
> [   97.697422] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]]
> *ERROR* IB test failed on uvd (-110).
> [   98.721432] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]]
> *ERROR* IB test failed on uvd_enc0 (-110).
> [   99.745407] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]]
> *ERROR* IB test failed on uvd_enc1 (-110).
> [   99.857784] [drm:amdgpu_device_delayed_init_work_handler [amdgpu]]
> *ERROR* ib ring test failed (-110).
>
> After checking the related source code roughly. It seems the underlaying
> implementation of -> set_powergating_state(e.g.
> uvd_v6_0_set_powergating_state ) performs more jobs than just power gating.
> And I guess maybe some of those jobs needs to be performed after ->
> set_clockgating_state. James and Leo may comment more.
>
> BR
> Evan
> >
> > Alex
> >
> >
> > >
> > >
> > > BR
> > >
> > > Evan
> > >
> > >
> > >
> > > Thanks,
> > >
> > > Lijo
> > >
> > >
> > >
> > > From: Zhu, James <James.Zhu@amd.com>
> > > Sent: Thursday, August 19, 2021 7:49 PM
> > > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Pan, Xinhui
> > > <Xinhui.Pan@amd.com>
> > > Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > > UVD/VCE on suspend
> > >
> > >
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >
> > >
> > > Why not move changes into hw_fini?
> > >
> > >
> > >
> > > Best Regards!
> > >
> > >
> > >
> > > James Zhu
> > >
> > > ________________________________
> > >
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > Evan Quan <evan.quan@amd.com>
> > > Sent: Wednesday, August 18, 2021 11:08 PM
> > > To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> > > <Evan.Quan@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > > Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > > UVD/VCE on suspend
> > >
> > >
> > >
> > > Perform proper cleanups on UVD/VCE suspend: powergate enablement,
> > > clockgating enablement and dpm disablement. This can fix some hangs
> > > observed on suspending when UVD/VCE still using(e.g. issue
> > > "pm-suspend" when video is still playing).
> > >
> > > Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24
> > ++++++++++++++++++++++++
> > > drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23
> > +++++++++++++++++++++++
> > >  2 files changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > index 4eebf973a065..d0fc6ec18c29 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > @@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
> > >          int r;
> > >          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > >
> > > +       /*
> > > +        * Proper cleanups before halting the HW engine:
> > > +        *   - cancel the delayed idle work
> > > +        *   - enable powergating
> > > +        *   - enable clockgating
> > > +        *   - disable dpm
> > > +        *
> > > +        * TODO: to align with the VCN implementation, move the
> > > +        * jobs for clockgating/powergating/dpm setting to
> > > +        * ->set_powergating_state().
> > > +        */
> > > +       cancel_delayed_work_sync(&adev->uvd.idle_work);
> > > +
> > > +       if (adev->pm.dpm_enabled) {
> > > +               amdgpu_dpm_enable_uvd(adev, false);
> > > +       } else {
> > > +               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> > > +               /* shutdown the UVD block */
> > > +               amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +
> AMD_PG_STATE_GATE);
> > > +               amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +
> AMD_CG_STATE_GATE);
> > > +       }
> > > +
> > >          r = uvd_v6_0_hw_fini(adev);
> > >          if (r)
> > >                  return r;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > index 6d9108fa22e0..a594ade5d30a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > @@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
> > >          int r;
> > >          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > >
> > > +       /*
> > > +        * Proper cleanups before halting the HW engine:
> > > +        *   - cancel the delayed idle work
> > > +        *   - enable powergating
> > > +        *   - enable clockgating
> > > +        *   - disable dpm
> > > +        *
> > > +        * TODO: to align with the VCN implementation, move the
> > > +        * jobs for clockgating/powergating/dpm setting to
> > > +        * ->set_powergating_state().
> > > +        */
> > > +       cancel_delayed_work_sync(&adev->vce.idle_work);
> > > +
> > > +       if (adev->pm.dpm_enabled) {
> > > +               amdgpu_dpm_enable_vce(adev, false);
> > > +       } else {
> > > +               amdgpu_asic_set_vce_clocks(adev, 0, 0);
> > > +               amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_VCE,
> > > +
> AMD_PG_STATE_GATE);
> > > +               amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_VCE,
> > > +
> AMD_CG_STATE_GATE);
> > > +       }
> > > +
> > >          r = vce_v3_0_hw_fini(adev);
> > >          if (r)
> > >                  return r;
> > > --
> > > 2.29.0
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> ------------------------------
>
> End of amd-gfx Digest, Vol 63, Issue 280
> ****************************************
>

--0000000000003c5e5405ca37a3f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi Kenneth,</div><div dir=3D"auto"><br>=
</div><div>I understand that changing voltage &#39;standalone&#39; is not a=
 good idea. In that case, would it be possible to change the voltage table =
so that it would give a lower clock on certain voltage?</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">For example, I would like to change</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">sclk 900, vddc: 1050</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">to</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">sclk 800, vddc: 1050</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Thanks</div><div dir=3D"auto"><br><div class=3D"gmail_quot=
e" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 23, 2021,=
 14:59  &lt;<a href=3D"mailto:amd-gfx-request@lists.freedesktop.org">amd-gf=
x-request@lists.freedesktop.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Send amd-gfx mailing list submissions to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:amd-gfx@lists.freedesktop.org=
" target=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a><br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.freedesktop.org/mailma=
n/listinfo/amd-gfx" rel=3D"noreferrer noreferrer" target=3D"_blank">https:/=
/lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:amd-gfx-request@lists.freedes=
ktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx-request@lists.freede=
sktop.org</a><br>
<br>
You can reach the person managing the list at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:amd-gfx-owner@lists.freedeskt=
op.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx-owner@lists.freedeskto=
p.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
=C2=A0 =C2=A01. RE: Voltage control on Southern Island GPU using radeon<br>
=C2=A0 =C2=A0 =C2=A0 driver (Feng, Kenneth)<br>
=C2=A0 =C2=A02. RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<=
br>
=C2=A0 =C2=A0 =C2=A0 UVD/VCE on suspend (Quan, Evan)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Mon, 23 Aug 2021 07:11:10 +0000<br>
From: &quot;Feng, Kenneth&quot; &lt;<a href=3D"mailto:Kenneth.Feng@amd.com"=
 target=3D"_blank" rel=3D"noreferrer">Kenneth.Feng@amd.com</a>&gt;<br>
To: &quot;Koenig, Christian&quot; &lt;<a href=3D"mailto:Christian.Koenig@am=
d.com" target=3D"_blank" rel=3D"noreferrer">Christian.Koenig@amd.com</a>&gt=
;, Evans Jahja<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:evansjahja13@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">evansjahja13@gmail.com</a>&gt;, &quot;<=
a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"no=
referrer">amd-gfx@lists.freedesktop.org</a>&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a=
>&gt;<br>
Subject: RE: Voltage control on Southern Island GPU using radeon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:BY5PR12MB55607F9193F1A315=
210D1B838EC49@BY5PR12MB5560.namprd12.prod.outlook.com" target=3D"_blank" re=
l=3D"noreferrer">BY5PR12MB55607F9193F1A315210D1B838EC49@BY5PR12MB5560.nampr=
d12.prod.outlook.com</a>&gt;<br>
<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
[AMD Official Use Only]<br>
<br>
Hi Evans<br>
I&#39;m sorry but I don&#39;t suggest you manually control the standalone v=
oltage because it&#39;s predefined with the clock value.<br>
A decrease of voltage could hit the hardware critical path. You may need to=
 change the clock and voltage together, we call it dpm level change.<br>
Thanks.<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org" =
target=3D"_blank" rel=3D"noreferrer">amd-gfx-bounces@lists.freedesktop.org<=
/a>&gt; On Behalf Of Christian K?nig<br>
Sent: Monday, August 23, 2021 2:26 PM<br>
To: Evans Jahja &lt;<a href=3D"mailto:evansjahja13@gmail.com" target=3D"_bl=
ank" rel=3D"noreferrer">evansjahja13@gmail.com</a>&gt;; <a href=3D"mailto:a=
md-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx@=
lists.freedesktop.org</a><br>
Subject: Re: Voltage control on Southern Island GPU using radeon driver<br>
<br>
[CAUTION: External Email]<br>
<br>
Hi Evans,<br>
<br>
in general the voltage tables are stored in the atombios and the best advic=
e I can give you is to first double check if there isn&#39;t an updated BIO=
S for your hardware.<br>
<br>
But Alex is the expert on power management, especially for those older hard=
ware generations. Maybe he has another idea what to try.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 23.08.21 um 03:56 schrieb Evans Jahja:<br>
&gt; Hi, I have a HAINAN GPU below:<br>
&gt;<br>
&gt; lspci -nn<br>
&gt; 0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc.<br>
&gt; [AMD/ATI] Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]<br>
&gt;<br>
&gt; I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.<br>
&gt;<br>
&gt; I&#39;m trying to understand more on how voltage control works and how=
 I <br>
&gt; can modify the voltage for doing overvoltage / undervoltage on my GPU.=
<br>
&gt; The reason is I am observing how running programs under high GPU load<=
br>
&gt; (glmark2) would lead to crashes when I use dpm=3D1 in either radeon or=
 <br>
&gt; amdgpu driver, which seems to happen when I am reaching power level 4 =
<br>
&gt; (sclk 900MHz), while a lighter program like glxgears could run and <br=
>
&gt; switch power levels=C2=A0 between 0,1,2 without issue under both drive=
rs. I <br>
&gt; believe my laptop might be faulty, but I would like to take this <br>
&gt; opportunity to try fixing it from the driver&#39;s side so that it can=
 run <br>
&gt; anyway, however limited.<br>
&gt;<br>
&gt; Right now, I have managed to increase the performance of my GPU by <br=
>
&gt; manually overwriting the sclk to 630MHz in all performance_levels in <=
br>
&gt; radeon_pm.c, which surprises me as overriding the clock was not <br>
&gt; possible for me to do previously via sysfs.<br>
&gt;<br>
&gt; I&#39;ve managed to tweak both sclk and mclk (or so I believe), but I =
<br>
&gt; still cannot tweak the voltage (vddc). The reason is, if I increase <b=
r>
&gt; the sclk to 650MHz, the lockup will happen again. Changing the<br>
&gt; pl-&gt;vddc=C2=A0 variable does not seem to do anything. After various=
 tracing<br>
&gt; with printk, I understand that on my system:<br>
&gt;<br>
&gt; pi-&gt;voltage_control =3D radeon_atom_is_voltage_gpio(rdev,<br>
&gt; SET_VOLTAGE_TYPE_ASIC_VDDC,<br>
&gt;=C2=A0 =C2=A0 VOLTAGE_OBJ_GPIO_LUT)<br>
&gt;<br>
&gt; this returns false, while:<br>
&gt;<br>
&gt; si_pi-&gt;voltage_control_svi2 =3D<br>
&gt; radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYPE_ASIC_VDDC,<br>
&gt;=C2=A0 =C2=A0 VOLTAGE_OBJ_SVID2);<br>
&gt;<br>
&gt; This returns true, so I believe my system is using SVI2 somehow to set=
 <br>
&gt; the voltage. Having no experience with SVI2, I read online and found <=
br>
&gt; out that SVI2 is a voltage regulator that uses Data / Clock pins to <b=
r>
&gt; clock-in 8 bits of information and convert it to some voltage value <b=
r>
&gt; between OFF, 0.5V -&gt; 1.5V, offering fine control based on some look=
 up <br>
&gt; table.<br>
&gt;<br>
&gt; My questions are as follows:<br>
&gt; Is it possible for me to modify my system so that I can manually <br>
&gt; adjust the voltage to my GPU?<br>
&gt;<br>
&gt; Thank you very much in advance. This is the first time I deal with <br=
>
&gt; kernel drivers, so any guidance on the matter helps a lot.<br>
&gt;<br>
&gt; - Evans<br>
&gt;<br>
&gt;<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Mon, 23 Aug 2021 07:59:36 +0000<br>
From: &quot;Quan, Evan&quot; &lt;<a href=3D"mailto:Evan.Quan@amd.com" targe=
t=3D"_blank" rel=3D"noreferrer">Evan.Quan@amd.com</a>&gt;<br>
To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_bl=
ank" rel=3D"noreferrer">alexdeucher@gmail.com</a>&gt;<br>
Cc: &quot;Lazar, Lijo&quot; &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" targe=
t=3D"_blank" rel=3D"noreferrer">Lijo.Lazar@amd.com</a>&gt;, &quot;Zhu, Jame=
s&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:James.Zhu@amd.com" target=
=3D"_blank" rel=3D"noreferrer">James.Zhu@amd.com</a>&gt;, &quot;<a href=3D"=
mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"noreferrer">=
amd-gfx@lists.freedesktop.org</a>&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a=
>&gt;, &quot;Liu, Leo&quot; &lt;<a href=3D"mailto:Leo.Liu@amd.com" target=
=3D"_blank" rel=3D"noreferrer">Leo.Liu@amd.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Deucher, Alexander&quot; &lt;<a href=3D"m=
ailto:Alexander.Deucher@amd.com" target=3D"_blank" rel=3D"noreferrer">Alexa=
nder.Deucher@amd.com</a>&gt;, &quot;Chen, Guchun&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:Guchun.Chen@amd.com" targ=
et=3D"_blank" rel=3D"noreferrer">Guchun.Chen@amd.com</a>&gt;, &quot;Pan, Xi=
nhui&quot; &lt;<a href=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Xinhui.Pan@amd.com</a>&gt;<br>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 UVD/VCE on suspend<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:DM6PR12MB261946019274A3F1=
B5C09995E4C49@DM6PR12MB2619.namprd12.prod.outlook.com" target=3D"_blank" re=
l=3D"noreferrer">DM6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.nampr=
d12.prod.outlook.com</a>&gt;<br>
<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
[AMD Official Use Only]<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">alexdeucher@gmail.com</a>&gt;<br>
&gt; Sent: Friday, August 20, 2021 10:23 PM<br>
&gt; To: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_bla=
nk" rel=3D"noreferrer">Evan.Quan@amd.com</a>&gt;<br>
&gt; Cc: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" target=3D"_b=
lank" rel=3D"noreferrer">Lijo.Lazar@amd.com</a>&gt;; Zhu, James &lt;<a href=
=3D"mailto:James.Zhu@amd.com" target=3D"_blank" rel=3D"noreferrer">James.Zh=
u@amd.com</a>&gt;;<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=
=3D"noreferrer">amd-gfx@lists.freedesktop.org</a>; Liu, Leo &lt;<a href=3D"=
mailto:Leo.Liu@amd.com" target=3D"_blank" rel=3D"noreferrer">Leo.Liu@amd.co=
m</a>&gt;; Deucher,<br>
&gt; Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_=
blank" rel=3D"noreferrer">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun<b=
r>
&gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank" rel=3D"no=
referrer">Guchun.Chen@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xi=
nhui.Pan@amd.com" target=3D"_blank" rel=3D"noreferrer">Xinhui.Pan@amd.com</=
a>&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<br=
>
&gt; UVD/VCE on suspend<br>
&gt; <br>
&gt; On Thu, Aug 19, 2021 at 10:15 PM Quan, Evan &lt;<a href=3D"mailto:Evan=
.Quan@amd.com" target=3D"_blank" rel=3D"noreferrer">Evan.Quan@amd.com</a>&g=
t; wrote:<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" targe=
t=3D"_blank" rel=3D"noreferrer">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt; Sent: Thursday, August 19, 2021 10:36 PM<br>
&gt; &gt; To: Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com" target=3D=
"_blank" rel=3D"noreferrer">James.Zhu@amd.com</a>&gt;; Quan, Evan<br>
&gt; &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_blank" rel=3D"nore=
ferrer">Evan.Quan@amd.com</a>&gt;;<br>
&gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank=
" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank" rel=3D"noreferrer">Alexander.Deucher@amd.com</a>&g=
t;; Chen, Guchun<br>
&gt; &gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Guchun.Chen@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mai=
lto:Xinhui.Pan@amd.com" target=3D"_blank" rel=3D"noreferrer">Xinhui.Pan@amd=
.com</a>&gt;<br>
&gt; &gt; Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris=
12<br>
&gt; &gt; UVD/VCE on suspend<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; If that is done=C2=A0 ?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice_ip_set_powergating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_PG_STATE_GATE);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice_ip_set_clockgating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +<br>
&gt; &gt; + AMD_CG_STATE_GATE);<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Usual order is CG followed by PG. It comes in the else part, so l=
ess likely to<br>
&gt; happen. Nice to fix for code correctness purpose.<br>
&gt; &gt;<br>
&gt; &gt; [Quan, Evan] Thanks Lijo. Make sense to me. However, actually the=
se code<br>
&gt; were copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c.<br>
&gt; Same logic was used there. So, maybe @Zhu, James or @Liu, Leo can shar=
e<br>
&gt; some insights about this.<br>
&gt; &gt;<br>
&gt; <br>
&gt; It looks like it is wrong there as well.=C2=A0 We should be gating the=
 clocks before<br>
&gt; the power.=C2=A0 The order is also wrong in amdgpu_uvd_ring_begin_use(=
).=C2=A0 We<br>
&gt; need to ungate the power before the clocks<br>
[Quan, Evan] I created a patch for this. But during the verification, I got=
 the errors below<br>
[=C2=A0 =C2=A087.420822] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A088.443029] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A089.465386] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A090.487629] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A091.510380] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A092.533782] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A093.557400] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A094.580708] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A095.603832] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A096.627727] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[=C2=A0 =C2=A096.657453] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, giving up!!!<br>
[=C2=A0 =C2=A096.665892] [drm:amdgpu_device_ip_set_powergating_state [amdgp=
u]] *ERROR* set_powergating_state of IP block &lt;uvd_v6_0&gt; failed -1<br=
>
[=C2=A0 =C2=A097.697422] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* IB test failed on uvd (-110).<br>
[=C2=A0 =C2=A098.721432] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* IB test failed on uvd_enc0 (-110).<br>
[=C2=A0 =C2=A099.745407] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* IB test failed on uvd_enc1 (-110).<br>
[=C2=A0 =C2=A099.857784] [drm:amdgpu_device_delayed_init_work_handler [amdg=
pu]] *ERROR* ib ring test failed (-110).<br>
<br>
After checking the related source code roughly. It seems the underlaying im=
plementation of -&gt; set_powergating_state(e.g.=C2=A0 uvd_v6_0_set_powerga=
ting_state ) performs more jobs than just power gating. And I guess maybe s=
ome of those jobs needs to be performed after -&gt; set_clockgating_state. =
James and Leo may comment more.<br>
<br>
BR<br>
Evan<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; BR<br>
&gt; &gt;<br>
&gt; &gt; Evan<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Lijo<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; From: Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com" target=
=3D"_blank" rel=3D"noreferrer">James.Zhu@amd.com</a>&gt;<br>
&gt; &gt; Sent: Thursday, August 19, 2021 7:49 PM<br>
&gt; &gt; To: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D=
"_blank" rel=3D"noreferrer">Evan.Quan@amd.com</a>&gt;; <a href=3D"mailto:am=
d-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx@l=
ists.freedesktop.org</a><br>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank" rel=3D"noreferrer">Alexander.Deucher@amd.com</a>&g=
t;; Chen, Guchun<br>
&gt; &gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Guchun.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mai=
lto:Lijo.Lazar@amd.com" target=3D"_blank" rel=3D"noreferrer">Lijo.Lazar@amd=
.com</a>&gt;; Pan, Xinhui<br>
&gt; &gt; &lt;<a href=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Xinhui.Pan@amd.com</a>&gt;<br>
&gt; &gt; Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris=
12<br>
&gt; &gt; UVD/VCE on suspend<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Why not move changes into hw_fini?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Best Regards!<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; James Zhu<br>
&gt; &gt;<br>
&gt; &gt; ________________________________<br>
&gt; &gt;<br>
&gt; &gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedes=
ktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx-bounces@lists.freede=
sktop.org</a>&gt; on behalf of<br>
&gt; &gt; Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" target=3D"_bla=
nk" rel=3D"noreferrer">evan.quan@amd.com</a>&gt;<br>
&gt; &gt; Sent: Wednesday, August 18, 2021 11:08 PM<br>
&gt; &gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_b=
lank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"m=
ailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"noreferrer">a=
md-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank" rel=3D"noreferrer">Alexander.Deucher@amd.com</a>&g=
t;; Chen, Guchun<br>
&gt; &gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Guchun.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mai=
lto:Lijo.Lazar@amd.com" target=3D"_blank" rel=3D"noreferrer">Lijo.Lazar@amd=
.com</a>&gt;; Quan, Evan<br>
&gt; &gt; &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_blank" rel=3D=
"noreferrer">Evan.Quan@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:X=
inhui.Pan@amd.com" target=3D"_blank" rel=3D"noreferrer">Xinhui.Pan@amd.com<=
/a>&gt;<br>
&gt; &gt; Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<b=
r>
&gt; &gt; UVD/VCE on suspend<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Perform proper cleanups on UVD/VCE suspend: powergate enablement,=
<br>
&gt; &gt; clockgating enablement and dpm disablement. This can fix some han=
gs<br>
&gt; &gt; observed on suspending when UVD/VCE still using(e.g. issue<br>
&gt; &gt; &quot;pm-suspend&quot; when video is still playing).<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed<br>
&gt; &gt; Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com"=
 target=3D"_blank" rel=3D"noreferrer">evan.quan@amd.com</a>&gt;<br>
&gt; &gt; Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan@amd.co=
m" target=3D"_blank" rel=3D"noreferrer">xinhui.pan@amd.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24<br>
&gt; ++++++++++++++++++++++++<br>
&gt; &gt; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23<br>
&gt; +++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 2 files changed, 47 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; index 4eebf973a065..d0fc6ec18c29 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; @@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D =
(struct amdgpu_device *)handle;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Proper cleanups before halting the=
 HW engine:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- cancel the delayed i=
dle work<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- enable powergating<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- enable clockgating<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- disable dpm<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * TODO: to align with the VCN implem=
entation, move the<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * jobs for clockgating/powergating/d=
pm setting to<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * -&gt;set_powergating_state().<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cancel_delayed_work_sync(&amp;adev-&g=
t;uvd.idle_work);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.dpm_enabled) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dp=
m_enable_uvd(adev, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_as=
ic_set_uvd_clocks(adev, 0, 0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* shutdo=
wn the UVD block */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice_ip_set_powergating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_PG_STATE_GATE);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice_ip_set_clockgating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_STATE_GATE);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D uvd_v6_0_hw_fini(adev);<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn r;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; index 6d9108fa22e0..a594ade5d30a 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; @@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D =
(struct amdgpu_device *)handle;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Proper cleanups before halting the=
 HW engine:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- cancel the delayed i=
dle work<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- enable powergating<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- enable clockgating<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- disable dpm<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * TODO: to align with the VCN implem=
entation, move the<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * jobs for clockgating/powergating/d=
pm setting to<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * -&gt;set_powergating_state().<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cancel_delayed_work_sync(&amp;adev-&g=
t;vce.idle_work);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.dpm_enabled) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dp=
m_enable_vce(adev, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_as=
ic_set_vce_clocks(adev, 0, 0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice_ip_set_powergating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_PG_STATE_GATE);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice_ip_set_clockgating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_STATE_GATE);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vce_v3_0_hw_fini(adev);<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn r;<br>
&gt; &gt; --<br>
&gt; &gt; 2.29.0<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 63, Issue 280<br>
****************************************<br>
</blockquote></div></div></div>

--0000000000003c5e5405ca37a3f4--
