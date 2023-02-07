Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00890C05027
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 01:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B2C10E1C3;
	Tue,  7 Feb 2023 01:17:20 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B81010E1C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 01:17:18 +0000 (UTC)
Received: by mail-il1-x12c.google.com with SMTP id z17so2219146ilm.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 17:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:from:subject:message-id:date:content-transfer-encoding
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9LvxCDgZiqQ3mfejZh50Yl4QLgGf8+vSDYAHKjeZgY=;
 b=ScfOSH5w7wcz/eZuRmXjcHXEYKvIPNfdAZSKuTPa2Raa1RpQtZkbzoSpSIVjDt/Laz
 mAZHydZ4E5E/48uLlTO6Evi6DKcl6lZSdvKD7hob5pku+nUF0OV3g0P8gA4NAHm+lI8Q
 3SnxoMCLJlFodVJPIr4QnQbDVbmT4HR2lB2u2YF9B8KMC8uMnYpdh9GiXMKJuFiDLUx4
 ubQpA0HdAB0d85S5R9poCu8bhsb3br0mSefMVwJC/hw6TzjF4IT8IctdJZJwj4dsO2g5
 36mMjHPdreQJjW4Ug9pFNbR2JxSf8OtUr4s0iYMwFNCblCfoObfoALo4vkgcz68t7F16
 JiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:from:subject:message-id:date:content-transfer-encoding
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9LvxCDgZiqQ3mfejZh50Yl4QLgGf8+vSDYAHKjeZgY=;
 b=kpMqXtgpETfwRUnmaGV4cQthl5mL2EZwl/LIh/rWw6TqY1Z0dI5g7Y2nZqPd8iT0J+
 0D+760MaumflMQagubVWQcCcrB9M9d8gWKeqv17sNdSnkBVWKqdxHCTtDtSa9Mx5CbQj
 S1N0LGya5Hh38YbmN/xXqYlMsqG1fBpdWb5KPNB4NQ27ky0u2R4O51ApvSgb7UGYG/ks
 +tGC4sz1TQkUnWEGgBbBNNgfgRAFihZfHezBAYoLyG+4OLyx5zfh36Gqop/1hPjls/ce
 ZocGfsADELIcoPKtj4j8hkLb7X/ev+UFC6zL2J+/t5yxLMFVzViN34GIy4r4dk4vedGH
 IRLw==
X-Gm-Message-State: AO0yUKV16VTpMF9uokrkDA9pVgY8PO8cqd6/kTsay86pKgbkxlJfrkLT
 t9y0hQgPOHAH+T1hEj1qpTDsuzCGrbw=
X-Google-Smtp-Source: AK7set9J69nJGbfK928JKUMjiNXfa8kPAofZMDFTggYrW9CgQAQUxWHMmifenyCyDdhkWzLoB4+CEw==
X-Received: by 2002:a92:7a0e:0:b0:310:9a14:9662 with SMTP id
 v14-20020a927a0e000000b003109a149662mr1186197ilc.16.1675732637218; 
 Mon, 06 Feb 2023 17:17:17 -0800 (PST)
Received: from localhost ([2602:47:d3e7:3200:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a02ca14000000b003a958f51423sm3978094jak.167.2023.02.06.17.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Feb 2023 17:17:16 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Feb 2023 18:17:16 -0700
Message-Id: <CQBXN5LYZ99S.333O6ZIGOX2JS@mcoffin-dev-tower>
Subject: Indexing of FeatureCtrlMask for SMU13 OverDrive
From: "Matt Coffin" <mcoffin13@gmail.com>
To: <amd-gfx@lists.freedesktop.org>, "Quan, Evan" <Evan.Quan@amd.com>
X-Mailer: aerc 0.14.0
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

Hello again,

I've been working on OverDrive support for smu13, as you probably
already know. In that endeavor, it also contains the following:

1. I've come up with a few patterns that I think will reduce the
amount of boilerplate and SMU-specific code required to do
implement these interfaces in the future.
2. Since the old pp_od_clk_voltage sysfs interface is inadequate for
usage in setting values other than a few indexed clock/voltage settings,
I'll likely be sending a proposed "generic" interface, where OD settings
are exposed to userspace by ASIC-specific indexed identifiers.

But, those are beside the point, for now.

While picking through the existing headers, the information in
smu_v13_0_0_pptable.h seems to not quite be in line with what I'm seeing
coming from the card, so I'm instead focusing mainly on
smu13_driver_if_v13_0_0.h.

In the two OverDrive-related structs, OverDriveTable_t and
OverDriveLimits_t, the FeatureCtrlMask member seems to be controlling
which of the "features" of OverDrive would actually be in use. As of
yet, I haven't been able to find an index of what the bits in here
actually mean. Is there any way you could help me out with that?

My best guess thus far is that they are by each element of the
OverDriveTable_t struct, but that's only just a guess.

For reference, here are the values I'm seeing present in each at boot
time.

Since FeatureCtrlMask is 0b11111001101, the current theory is that the
"unsupported" features would be VddGfxVmax, GfxclkFmin, GfxclkFmax. Does
that line up with what we'd be expecting for this ASIC?

Thanks in advance for any information you can provide. I really
appreciate the work that you all do.

Thanks,
Matt

OverDriveLimits:
        FeatureCtrlMask: [0x000007cd, 0x000007cd]
        VoltageOffsetPerZoneBoundary: [-450, 0]
        VddGfxVmax: [0, 0]
        IdlePwrSavingFeaturesCtrl: [0x00, 0x00]
        RuntimePwrSavingFeaturesCtrl: [0x00, 0x00]
        GfxclkFmin: [500, 5000]
        GfxclkFmax: [500, 5000]
        UclkFmin: [97, 1500]
        UclkFmax: [97, 1500]
        Ppt: [-10, 15], Tdc: [-10, 0]
        FanLinearPwmPoints: [23, 100]
        FanLinearTempPoints: [25, 100]
        FanMinimumPwm: [23, 100]
        AcousticTargetRpmThreshold: [500, 3200]
        AcousticLimitRpmThreshold: [500, 3200]
        FanTargetTemperature: [25, 105]
        FanZeroRpmEnable: [0, 1]
        FanZeroRpmStopTemp: [25, 100]
        FanMode: [0, 1]
        MaxOpTemp: [50, 110]
OverDriveTable:
        FeatureCtrlMask: 0x00000000
        VoltageOffsetPerZoneBoundary[0]: 0
        VoltageOffsetPerZoneBoundary[1]: 0
        VoltageOffsetPerZoneBoundary[2]: 0
        VoltageOffsetPerZoneBoundary[3]: 0
        VoltageOffsetPerZoneBoundary[4]: 0
        VoltageOffsetPerZoneBoundary[5]: 0
        VddGfxVmax: 1150
        IdlePwrSavingFeaturesCtrl: 0x00
        RuntimePwrSavingFeaturesCtrl: 0x00
        GfxclkFmin: 500
        GfxclkFmax: 2890
        UclkFmin: 97
        UclkFmax: 1249
        Ppt: 0
        Tdc: 0
        FanLinearPwmPoints[0]: 0
        FanLinearPwmPoints[1]: 0
        FanLinearPwmPoints[2]: 0
        FanLinearPwmPoints[3]: 0
        FanLinearPwmPoints[4]: 0
        FanLinearPwmPoints[5]: 0
        FanLinearTempPoints[0]: 0
        FanLinearTempPoints[1]: 0
        FanLinearTempPoints[2]: 0
        FanLinearTempPoints[3]: 0
        FanLinearTempPoints[4]: 0
        FanLinearTempPoints[5]: 0
        FanMinimumPwm: 35
        AcousticTargetRpmThreshold: 1250
        AcousticLimitRpmThreshold: 1500
        FanTargetTemperature: 94
        FanZeroRpmEnable: 1
        FanZeroRpmStopTemp: 55
        FanMode: 0
        MaxOpTemp: 110
