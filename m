Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00FBC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 04:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B6B10E2D7;
	Tue,  7 Feb 2023 04:36:52 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01D810E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 04:36:51 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id bd6so2670160oib.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 20:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJqSX127DJPkZDvXxxr2YVLWo+6Awtq8G2+nnX0y4YY=;
 b=mghiWiUwqXxGjw6zu6KK43pvi3WzHDV2nnOEcMHzMXkePNeybRXxwNEXu0e7muH/X5
 AZPd0l6yAVwt81EmNBAEMNYvVW87KFTN8rw4jSzjMrQ4zYIOxy7hdZtXr0yp/BoT4LWi
 oK5zA1/4z1jWhyqWtrv4guqxEc8ZLX8HMzjhPcOOS5qEBW4sO6wWP0wzHYPbXNeA4iTj
 wnAfxaX8bFEpqQASLQwb9Ovt9bDlQxz63ELCj4DpZ7GoZyHReaf41/Ii2cHOx2HZTpq+
 BcHFb01DwffEZE5MW5GxZ4b2LyKbordGurXNBCyVOpr+WJ1HC4IPjBi3yviCveDEAKLC
 M8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJqSX127DJPkZDvXxxr2YVLWo+6Awtq8G2+nnX0y4YY=;
 b=h9u6QnSKUHV4Yz6PzVUvwrv8YL7yITVsvMOM3C6CCt1ECJIBbatC9JVWa0wYzx4Inz
 3mPSBdU7xvhjXFDn0FJ2zBfXvn+FN4KVfveA6sObWvSS5VupQ6X4zI29ccata0hxAUt4
 vnGQV4AKu9oqueGxNtnIP2owDr1WTS0A1xd5iYRtaF16KK6QOXjCEuEar4GTfcGtKB6u
 vjuM0P/BrJdvQw7VWqgiAoC/sID83s3/4i5ozucQjIMsAoN8QNAYQNxzfcwuU400HUgm
 TGTr2mWnz7Lk5UKTLpCWQDMqFikujTP9oe4DAbeajrVRTITo2++PKQmW099c8uilc9kv
 ddMQ==
X-Gm-Message-State: AO0yUKWe1LMeIMx9cbRj8T20TpE8TDD56UCjXdojsBzIZf+0xcnbdqjx
 xp1sct3Vk6eYUF008DJGcX9+iGhgq9j05bj46hEXS/D9
X-Google-Smtp-Source: AK7set+kzYIT8LmXroms8l4t+DES/UsRKyQDhZzfFuC7EuKdW2alSPMwWg2LYlVORF0cL42GvCWqT0xbmGS8amRh7r8=
X-Received: by 2002:a05:6808:6242:b0:378:4edd:a89c with SMTP id
 dt2-20020a056808624200b003784edda89cmr1412778oib.46.1675744611035; Mon, 06
 Feb 2023 20:36:51 -0800 (PST)
MIME-Version: 1.0
References: <CQBXN5LYZ99S.333O6ZIGOX2JS@mcoffin-dev-tower>
In-Reply-To: <CQBXN5LYZ99S.333O6ZIGOX2JS@mcoffin-dev-tower>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 23:36:39 -0500
Message-ID: <CADnq5_NWHPQSSF0M1GsL=nPrGdYJ8+4mHD23260q2caPKwE-7g@mail.gmail.com>
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

On Mon, Feb 6, 2023 at 8:17 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> Hello again,
>
> I've been working on OverDrive support for smu13, as you probably
> already know. In that endeavor, it also contains the following:
>
> 1. I've come up with a few patterns that I think will reduce the
> amount of boilerplate and SMU-specific code required to do
> implement these interfaces in the future.
> 2. Since the old pp_od_clk_voltage sysfs interface is inadequate for
> usage in setting values other than a few indexed clock/voltage settings,
> I'll likely be sending a proposed "generic" interface, where OD settings
> are exposed to userspace by ASIC-specific indexed identifiers.
>
> But, those are beside the point, for now.
>
> While picking through the existing headers, the information in
> smu_v13_0_0_pptable.h seems to not quite be in line with what I'm seeing
> coming from the card, so I'm instead focusing mainly on
> smu13_driver_if_v13_0_0.h.
>
> In the two OverDrive-related structs, OverDriveTable_t and
> OverDriveLimits_t, the FeatureCtrlMask member seems to be controlling
> which of the "features" of OverDrive would actually be in use. As of
> yet, I haven't been able to find an index of what the bits in here
> actually mean. Is there any way you could help me out with that?

I can ask tomorrow.  That said, we are working on OD support and
should have patches available soon.

Alex



>
> My best guess thus far is that they are by each element of the
> OverDriveTable_t struct, but that's only just a guess.
>
> For reference, here are the values I'm seeing present in each at boot
> time.
>
> Since FeatureCtrlMask is 0b11111001101, the current theory is that the
> "unsupported" features would be VddGfxVmax, GfxclkFmin, GfxclkFmax. Does
> that line up with what we'd be expecting for this ASIC?
>
> Thanks in advance for any information you can provide. I really
> appreciate the work that you all do.
>
> Thanks,
> Matt
>
> OverDriveLimits:
>         FeatureCtrlMask: [0x000007cd, 0x000007cd]
>         VoltageOffsetPerZoneBoundary: [-450, 0]
>         VddGfxVmax: [0, 0]
>         IdlePwrSavingFeaturesCtrl: [0x00, 0x00]
>         RuntimePwrSavingFeaturesCtrl: [0x00, 0x00]
>         GfxclkFmin: [500, 5000]
>         GfxclkFmax: [500, 5000]
>         UclkFmin: [97, 1500]
>         UclkFmax: [97, 1500]
>         Ppt: [-10, 15], Tdc: [-10, 0]
>         FanLinearPwmPoints: [23, 100]
>         FanLinearTempPoints: [25, 100]
>         FanMinimumPwm: [23, 100]
>         AcousticTargetRpmThreshold: [500, 3200]
>         AcousticLimitRpmThreshold: [500, 3200]
>         FanTargetTemperature: [25, 105]
>         FanZeroRpmEnable: [0, 1]
>         FanZeroRpmStopTemp: [25, 100]
>         FanMode: [0, 1]
>         MaxOpTemp: [50, 110]
> OverDriveTable:
>         FeatureCtrlMask: 0x00000000
>         VoltageOffsetPerZoneBoundary[0]: 0
>         VoltageOffsetPerZoneBoundary[1]: 0
>         VoltageOffsetPerZoneBoundary[2]: 0
>         VoltageOffsetPerZoneBoundary[3]: 0
>         VoltageOffsetPerZoneBoundary[4]: 0
>         VoltageOffsetPerZoneBoundary[5]: 0
>         VddGfxVmax: 1150
>         IdlePwrSavingFeaturesCtrl: 0x00
>         RuntimePwrSavingFeaturesCtrl: 0x00
>         GfxclkFmin: 500
>         GfxclkFmax: 2890
>         UclkFmin: 97
>         UclkFmax: 1249
>         Ppt: 0
>         Tdc: 0
>         FanLinearPwmPoints[0]: 0
>         FanLinearPwmPoints[1]: 0
>         FanLinearPwmPoints[2]: 0
>         FanLinearPwmPoints[3]: 0
>         FanLinearPwmPoints[4]: 0
>         FanLinearPwmPoints[5]: 0
>         FanLinearTempPoints[0]: 0
>         FanLinearTempPoints[1]: 0
>         FanLinearTempPoints[2]: 0
>         FanLinearTempPoints[3]: 0
>         FanLinearTempPoints[4]: 0
>         FanLinearTempPoints[5]: 0
>         FanMinimumPwm: 35
>         AcousticTargetRpmThreshold: 1250
>         AcousticLimitRpmThreshold: 1500
>         FanTargetTemperature: 94
>         FanZeroRpmEnable: 1
>         FanZeroRpmStopTemp: 55
>         FanMode: 0
>         MaxOpTemp: 110
