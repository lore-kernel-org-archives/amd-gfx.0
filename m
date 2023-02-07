Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81FDC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C1D10E500;
	Tue,  7 Feb 2023 14:11:58 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FE610E500
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:11:56 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1636eae256cso19218758fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mYwdHGGxUxPKyTYoTHp/+Q9Ncem5lJnI7ERa1HreSKU=;
 b=dwbAELd+HNEeDyKzFsOOHrX7Z15hIAk/FN5TxQ6Qz2bSyQPrisGG+K+33QzaznHmO/
 BLxtg6Oz3E6yEtJvZSrjobayG6qtKmMaYeIwbVJalAHGFWnAwBKFPCCCz1WNNKcQFy9j
 +L764YMOn12piiQzQEqZB03npnmMAUv5Uk+OqOa8K5VU6i5JOWrT8FXP8+w1+j/3sbY9
 KOeGUfetv8c3+HLv0EyRiAxbeIxZj+mhVKOjreg9wxqJ5kxhtIUBG3gi4KgQUfBsJh1z
 1ScueUJW8m1T4ALxP1opaLJswOSItN5fRu2NjNR0UaRxpB5FPh85VMfru5mNbHWTcP02
 dRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYwdHGGxUxPKyTYoTHp/+Q9Ncem5lJnI7ERa1HreSKU=;
 b=C1rkDueeF9yVJ88vVn1TAwOGDn5OHlHqKkEx6Cke1ow4yX6aCXKsPjQitJs62BkKUo
 sUTQ9sCxvXZl7zP5QDXMBk6AZDQXiLSqiZUNed4bB282Ogyt8MJn4gNK/7oAcm3Y3AFW
 mWHNwJ1jjKP6+nUuOzRShTgQ16t4TT0Mnhi+7ms0M0knulVD8ryWeiHBj6TF22LD9LYN
 TFPSdYL+xUNjXeTkW2QckE5hae341cjhValGALsgoi42/h+pfOuCz7EgopDnCjFmIKMM
 18lD3yE4hi2ysWEySCJl8XjaDORfqZb268Tl/F51m++6YqsxKSErZ4hOWw6S3dlkxHK9
 FDIw==
X-Gm-Message-State: AO0yUKWuI33o7ryOFpLL1smHFgk2KEa+yJb5XQUeluKzmfAPAn6W2doe
 HFNd3eN5Jdp1K/QSf+QNOnFKdoEAogql6LwZmAI=
X-Google-Smtp-Source: AK7set+VWz3I8tKyZKm9ULKpPh6OAhGH7QxjrHUuDWJczdh2YWEyhBBsH08HsqkxpWFQ+DBjrnufnHIMTN6p5krqFYA=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr462094oab.96.1675779115760; Tue, 07
 Feb 2023 06:11:55 -0800 (PST)
MIME-Version: 1.0
References: <CQBXN5LYZ99S.333O6ZIGOX2JS@mcoffin-dev-tower>
 <CADnq5_NWHPQSSF0M1GsL=nPrGdYJ8+4mHD23260q2caPKwE-7g@mail.gmail.com>
In-Reply-To: <CADnq5_NWHPQSSF0M1GsL=nPrGdYJ8+4mHD23260q2caPKwE-7g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 09:11:44 -0500
Message-ID: <CADnq5_MT8MJp1iq6P-MTHgL8-2JdAfMfQLi7iHH0v8ezPWqfCw@mail.gmail.com>
Subject: Re: Indexing of FeatureCtrlMask for SMU13 OverDrive
To: Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 11:36 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Feb 6, 2023 at 8:17 PM Matt Coffin <mcoffin13@gmail.com> wrote:
> >
> > Hello again,
> >
> > I've been working on OverDrive support for smu13, as you probably
> > already know. In that endeavor, it also contains the following:
> >
> > 1. I've come up with a few patterns that I think will reduce the
> > amount of boilerplate and SMU-specific code required to do
> > implement these interfaces in the future.
> > 2. Since the old pp_od_clk_voltage sysfs interface is inadequate for
> > usage in setting values other than a few indexed clock/voltage settings,
> > I'll likely be sending a proposed "generic" interface, where OD settings
> > are exposed to userspace by ASIC-specific indexed identifiers.
> >
> > But, those are beside the point, for now.
> >
> > While picking through the existing headers, the information in
> > smu_v13_0_0_pptable.h seems to not quite be in line with what I'm seeing
> > coming from the card, so I'm instead focusing mainly on
> > smu13_driver_if_v13_0_0.h.
> >
> > In the two OverDrive-related structs, OverDriveTable_t and
> > OverDriveLimits_t, the FeatureCtrlMask member seems to be controlling
> > which of the "features" of OverDrive would actually be in use. As of
> > yet, I haven't been able to find an index of what the bits in here
> > actually mean. Is there any way you could help me out with that?
>
> I can ask tomorrow.  That said, we are working on OD support and
> should have patches available soon.

Those bits refer to the OD feature bits PP_OD_FEATURE_*.  Looks like
they are missing from smu13_driver_if_v13_0_0.h, but they are the same
as the ones in smu13_driver_if_v13_0_7.h.

Alex

>
> Alex
>
>
>
> >
> > My best guess thus far is that they are by each element of the
> > OverDriveTable_t struct, but that's only just a guess.
> >
> > For reference, here are the values I'm seeing present in each at boot
> > time.
> >
> > Since FeatureCtrlMask is 0b11111001101, the current theory is that the
> > "unsupported" features would be VddGfxVmax, GfxclkFmin, GfxclkFmax. Does
> > that line up with what we'd be expecting for this ASIC?
> >
> > Thanks in advance for any information you can provide. I really
> > appreciate the work that you all do.
> >
> > Thanks,
> > Matt
> >
> > OverDriveLimits:
> >         FeatureCtrlMask: [0x000007cd, 0x000007cd]
> >         VoltageOffsetPerZoneBoundary: [-450, 0]
> >         VddGfxVmax: [0, 0]
> >         IdlePwrSavingFeaturesCtrl: [0x00, 0x00]
> >         RuntimePwrSavingFeaturesCtrl: [0x00, 0x00]
> >         GfxclkFmin: [500, 5000]
> >         GfxclkFmax: [500, 5000]
> >         UclkFmin: [97, 1500]
> >         UclkFmax: [97, 1500]
> >         Ppt: [-10, 15], Tdc: [-10, 0]
> >         FanLinearPwmPoints: [23, 100]
> >         FanLinearTempPoints: [25, 100]
> >         FanMinimumPwm: [23, 100]
> >         AcousticTargetRpmThreshold: [500, 3200]
> >         AcousticLimitRpmThreshold: [500, 3200]
> >         FanTargetTemperature: [25, 105]
> >         FanZeroRpmEnable: [0, 1]
> >         FanZeroRpmStopTemp: [25, 100]
> >         FanMode: [0, 1]
> >         MaxOpTemp: [50, 110]
> > OverDriveTable:
> >         FeatureCtrlMask: 0x00000000
> >         VoltageOffsetPerZoneBoundary[0]: 0
> >         VoltageOffsetPerZoneBoundary[1]: 0
> >         VoltageOffsetPerZoneBoundary[2]: 0
> >         VoltageOffsetPerZoneBoundary[3]: 0
> >         VoltageOffsetPerZoneBoundary[4]: 0
> >         VoltageOffsetPerZoneBoundary[5]: 0
> >         VddGfxVmax: 1150
> >         IdlePwrSavingFeaturesCtrl: 0x00
> >         RuntimePwrSavingFeaturesCtrl: 0x00
> >         GfxclkFmin: 500
> >         GfxclkFmax: 2890
> >         UclkFmin: 97
> >         UclkFmax: 1249
> >         Ppt: 0
> >         Tdc: 0
> >         FanLinearPwmPoints[0]: 0
> >         FanLinearPwmPoints[1]: 0
> >         FanLinearPwmPoints[2]: 0
> >         FanLinearPwmPoints[3]: 0
> >         FanLinearPwmPoints[4]: 0
> >         FanLinearPwmPoints[5]: 0
> >         FanLinearTempPoints[0]: 0
> >         FanLinearTempPoints[1]: 0
> >         FanLinearTempPoints[2]: 0
> >         FanLinearTempPoints[3]: 0
> >         FanLinearTempPoints[4]: 0
> >         FanLinearTempPoints[5]: 0
> >         FanMinimumPwm: 35
> >         AcousticTargetRpmThreshold: 1250
> >         AcousticLimitRpmThreshold: 1500
> >         FanTargetTemperature: 94
> >         FanZeroRpmEnable: 1
> >         FanZeroRpmStopTemp: 55
> >         FanMode: 0
> >         MaxOpTemp: 110
