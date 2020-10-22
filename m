Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1DDC388F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6858820657
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soeuhAP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6858820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8516E34B;
	Thu, 22 Oct 2020 05:05:42 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC39D6E34B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 05:05:41 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id n15so479920wrq.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ylqNIF3BzhTLUZjMXKgJL5mSGpbeXmJhDaWeSp0kRXc=;
 b=soeuhAP4hFFx66/v+ZJvMINQYSNvOD2xUmJeOQ0Ke2WNvRLZoOqpDIuhMBgt3i4zL9
 rUkffg61XsqTPzNps3Tqq1BVN6TnYsDlzsnEBGb7gdm7REeomeD+46IftHIcOZO61xQr
 ZgMp3mGDiW7YnRxVVyxpMaKZoDn8+3UBLRApxbAy4x9lj6lcw+MjNlRJ7CuQxA7kb+3Z
 2bZ0bnZ2xSYp/Kdz7lkcZyJjMIj7o2gYUjchMlMfO8p5SS3pm1Q+v+ZIDTk90usgJXiQ
 R9hZVCys9K2J8advBd3zUO/RDDf+P/0NUF6Agtb85kP0Qhk1zLk9fK5QVSkcB1ZShnBO
 RL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ylqNIF3BzhTLUZjMXKgJL5mSGpbeXmJhDaWeSp0kRXc=;
 b=BT4vUFW3mOemnK4+Riqvv9fFPekX5hDWo0PppX22GeDb88bW5Ss8n9qPuQ6yiAjlsP
 qXhFFUqT+16NiS5LdzX28EmauXBSYMx8LPygDN5wXFdkZCKAqbgNYQ/q+R0QBo+5Z5Yt
 s82EBKdpDSP/YbrMHVt1jiiDGCV67R+348UYSQd3WOgQAhOydpweRXey6CuaSjGe6KgK
 gq03XrU37OLXdF59NoeYk0kHFxecBuMnO9OG3TIU/13nvEWrvRyJ3jvp/v7sgMrhecAp
 IPNH0rquP2UAFpKJpOBrcQCoccP+rgFVkwA0dVfla4Lzq5pl6f6wtkzKCtif4B9HcvRK
 asFA==
X-Gm-Message-State: AOAM531oauYd8VaJ7OWi1PRRJFfwT0SlqhDk37atEiBRQPOGHEJvaP8O
 RobKwArClEBfSe0V6smhjB41rccWg4DuzON46eM=
X-Google-Smtp-Source: ABdhPJyNbKgP6opbcMMJJZWGTE2lJxos3AxRo8Ch3oc6hbY6bT0xqpyogO8fvTKMxp+778faZSp4WwUUhlBH8ELpEP4=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr604071wrn.362.1603343140494; 
 Wed, 21 Oct 2020 22:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
 <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
 <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
 <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <DM5PR12MB1657C41033410DB1F57995F28E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_MR3O_T-jSziUMdJWU=eipX+55Km3WSLzP9+Eudygayvg@mail.gmail.com>
 <DM5PR12MB165756ABF941252F123C03BD8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_M6V=-YDX5QJp-HEA2k=5HPh57zyj8tr+oVXgOo_sQUcg@mail.gmail.com>
 <DM5PR12MB1657848807541F7E6214AC3D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1657848807541F7E6214AC3D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2020 01:05:29 -0400
Message-ID: <CADnq5_PhA1bJp-3Pctjn_L9=TFU=y_Kuw7Sz42Tcdv1VoiUz8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 22, 2020 at 1:01 AM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> The speed is not 0 in the below scenario if the rpm is got from the metrics table on navi10.
> The possibility is that you were using an old firmware. The firmware on my system is 0x002a3e00
> Can you remember the version when you saw the problem?

SMC feature version: 0, firmware version: 0x002a3600

Alex

> Thanks.
> # echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1_enable
> # echo 125 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1
> # cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1
> 109
>
>
>
>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, October 22, 2020 11:28 AM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
>
> [CAUTION: External Email]
>
> On Wed, Oct 21, 2020 at 11:16 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi Alex,
> > After reboot, It is also not read back correctly as below.
> > # echo 1 >
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> > /hwmon/hwmon3/fan1_enable s# cat
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> > /hwmon/hwmon3/fan1_input
> > 183105
> > # cat
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> > /hwmon/hwmon3/fan1_enable
> > 1
> >
>
> What about if you manually set the speed.  E.g., # echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
> # echo 800 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_target
> # cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_input
>
> The problem I ran into on navi1x was setting the fan speed manually resulted in 0 for the fan speed in the metrics table.  E.g.,
>
> # echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1_enable
> # echo 125 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1
> # cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm
>
> See:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1164&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Cfdef2561887a41322e2a08d8763a897b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389341097409110%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=M6EIZVH9vxUJw0d5eh%2B6VzYKQ0LEOwMRdAaEYzrU1d8%3D&amp;reserved=0
>
> Alex
>
>
> >
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, October 22, 2020 10:18 AM
> > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun
> > <Likun.Gao@amd.com>
> > Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
> >
> > [CAUTION: External Email]
> >
> > On Wed, Oct 21, 2020 at 9:30 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> > >
> > > [AMD Official Use Only - Internal Distribution Only]
> > >
> > > Hi Alex,
> > > Navi10 also has this problem as below.
> > > # cat
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > > .0
> > > /hwmon/hwmon3/fan1_input
> > > 1217
> > > # cat
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > > .0
> > > /hwmon/hwmon3/fan1_enable
> > > 0
> > > # echo 1 >
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > > .0
> > > /hwmon/hwmon3/fan1_enable # cat
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > > .0
> > > /hwmon/hwmon3/fan1_enable
> > > 1
> > > s# cat
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > > .0
> > > /hwmon/hwmon3/fan1_input
> > > 183105
> > >
> > > In AGM, the rpm is 1800.
> >
> > Does it read back correctly if you manually set the fan rpm first before reading it back?
> >
> > Alex
> >
> >
> > >
> > >
> > >
> > > -----Original Message-----
> > > From: Feng, Kenneth
> > > Sent: Thursday, October 22, 2020 9:11 AM
> > > To: Alex Deucher <alexdeucher@gmail.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun
> > > <Likun.Gao@amd.com>
> > > Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in
> > > fan1_input
> > >
> > > [AMD Official Use Only - Internal Distribution Only]
> > >
> > > Hi Alex,
> > > Right, smu_v11_0_get_fan_speed_rpm() is not correct for sienna cichlid when it's in manual mode.
> > > An example is that in my system, the rpm is about 1800 in manual mode, confirmed with AGM and the internal smu fw scoreboard.
> > > But the fan1_input shows about 180000, which is way more than the real value.
> > > If you see the value from the metrics table is 0 on navi10, maybe it's the real rpm since we still have 0 rpm feature.
> > > I can double check the navi10.
> > > Thanks.
> > >
> > >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Thursday, October 22, 2020 2:47 AM
> > > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun
> > > <Likun.Gao@amd.com>
> > > Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in
> > > fan1_input
> > >
> > > [CAUTION: External Email]
> > >
> > > On Wed, Oct 21, 2020 at 9:40 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > > >
> > > > > On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> > > > > >
> > > > > > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > > > > > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > > > > > since the fan speed in the metrics table always reflects the
> > > > > > real fan speed,we can fetch the fan speed for both auto and manual mode.
> > > > > >
> > > > > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > > > >
> > > > > NACK.  At least on the navi boards I have, the metrics table fan
> > > > > speed reads back 0 when the fan is in manual mode.  That's why I
> > > > > changed this in the first place.
> > > >
> > > > Nevermind, I was thinking about navi1x.  If this is working
> > > > correctly on sienna cichlid, please ignore me.
> > >
> > > That said, I don't see why the current code should not work.  Maybe a bug elsewhere?  Is smu_v11_0_get_fan_speed_rpm() incorrect for sienna cichlid?
> > >
> > > Alex
> > >
> > > >
> > > > Alex
> > > >
> > > >
> > > > >
> > > > > Alex
> > > > >
> > > > >
> > > > > > ---
> > > > > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> > > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git
> > > > > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > > index 496abc31b07e..27b6cade9ade 100644
> > > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> > > > > >         if (!speed)
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > > > > > -       case AMD_FAN_CTRL_AUTO:
> > > > > > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > > > > > -                                                          METRICS_CURR_FANSPEED,
> > > > > > -                                                          speed);
> > > > > > -       default:
> > > > > > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > > > > > -       }
> > > > > > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > > > > > +                                               METRICS_CURR_FANSPEED,
> > > > > > +                                               speed);
> > > > > >  }
> > > > > >
> > > > > >  static int sienna_cichlid_get_fan_parameters(struct
> > > > > > smu_context
> > > > > > *smu)
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > > > > _______________________________________________
> > > > > > amd-gfx mailing list
> > > > > > amd-gfx@lists.freedesktop.org
> > > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2
> > > > > > F%25
> > > > > > 2F
> > > > > > lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=
> > > > > > 04
> > > > > > %7
> > > > > > C01%7Ckenneth.feng%40amd.com%7Cd8e969f4b63e4897a3df08d875f1b05
> > > > > > 0%
> > > > > > 7C
> > > > > > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389028190609906%
> > > > > > 7C
> > > > > > Un
> > > > > > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > > > > > I6
> > > > > > Ik
> > > > > > 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KomP2H%2FadKJChDbNvNPQlT
> > > > > > ot
> > > > > > mE
> > > > > > WrhutsQCHfiRIjNUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
