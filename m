Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A03C02187
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 09:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296C210E513;
	Tue, 21 Jan 2025 09:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=noa-labs.com header.i=@noa-labs.com header.b="iGPPFCfY";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FF010E12C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 00:07:45 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-29fcbf3d709so1687219fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=noa-labs.com; s=google; t=1737418005; x=1738022805;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAjfoDVG0C0GYUMIELB7JPtHk8sukSTwpMJsA3FPLIQ=;
 b=iGPPFCfYVeSzun4oYwMjMDe0hx2j3skuId297AJx+Prv+tWutLbToKrYd+qKFxEMRg
 m5A2sAPbDzUrbERY86FqDtWcxvEOrq9AzAQxpV0WZ056blvf32rRMioFLrhZQ7c5g9rf
 nKezbIuoGzCW+eg49ggIkUHNnPzzx9rAPiVjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737418005; x=1738022805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAjfoDVG0C0GYUMIELB7JPtHk8sukSTwpMJsA3FPLIQ=;
 b=Di734DHSdDYqjHv0PHhSDs3QG2pz766QNtXWIYVGrp4cR48Y18IFpHlR5oz3Bmwhy3
 T6VWcGnoC2pHFit0Vkt5J6rwz6fPLUzvZuIX/2wOKQIPtQmvjziALcrygoMInr1g3cPh
 b/B9DyF+hma1YX8yfnX3F+wehwHthYC/yGjyRWgcpX29kGmrpcGznyT0Ya0PEf9mnngI
 c+qug0A8bMmTjFZ9LkIlenUfNItM3RdHB/FxRs+PfSZjtU+MMt5QZIQ/abyEY0vUMh+3
 z6tsFmLe0RaMMxCd0FcjsbaAgtw9j4VV9Zhu2eCLN8Up35wS5BwUHQDn8dJAwo06zqZW
 Vxpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDzhm5NPlkYRNthTxzLXGgCny4TyzxJU76fHRx99eftAgp+/4rOKFRl//vhCO4prFCyiChpAsO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0QVG+TPGsQpQacbOnMIyUaout3xTvCRyPIybvt+7aEYmfKaz3
 5t0klvV0mBsQ0K0EGFmv2aEK9suW/vr2GBZcYVEJQEHV+eZi4rOtfeY7odTo7F0EOa/eTrgEx9v
 JhjMEzFulOlCse6LcM9sREAsOB01FSzEUxSSXLw==
X-Gm-Gg: ASbGnct2gaa0brgzO0M6K1uPxPhUCY4T8pz9N543byLypKAJ3PuKCrOZLATXfzQOBwv
 N/0Fo2/Yc2G5gnG+kiqOo8hRgju3YJQun/pQddag0CgcTdtcgWgnoeAXNPrKPH/jDZwhY5gEsVH
 sXRY75sd1U
X-Google-Smtp-Source: AGHT+IEJlf8MbwOXXuEwQIFYjqMIoWpSFzaspLuHVF12EXMVy+lwuJXx38AUD7oOsDQXWWQrK9+Bg+bfZWCnD7H+qd4=
X-Received: by 2002:a05:6870:6e14:b0:29e:1b72:7586 with SMTP id
 586e51a60fabf-2b1c0a299f0mr8351823fac.18.1737418004893; Mon, 20 Jan 2025
 16:06:44 -0800 (PST)
MIME-Version: 1.0
References: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
 <CADnq5_Pj0NLqwiooxyXULERo8YQTh1TN76FVnM9MZt3FCMFSwg@mail.gmail.com>
 <CAG-pW8GaL+JSGSmu-G3qbskPoHe=iU4usMP293RB7gr5VVbUQg@mail.gmail.com>
 <CAG-pW8Fe95BTyw2pVTrKJQJs0MnFshXGztWnLk9dqx8B1V6X1g@mail.gmail.com>
 <BL1PR12MB514453D8463E8CB1C2997464F7E72@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514453D8463E8CB1C2997464F7E72@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Tue, 21 Jan 2025 04:06:35 +0400
X-Gm-Features: AbW1kvaJa2Z--NzVHTnuCRaftxeXvfPec8Ms1rpccuKSNnySysXOPssu0tZKs_g
Message-ID: <CAG-pW8EsjPssH_OOtAK7=X99UDjwBE93JF7uxADGVcU2ScWfpQ@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jan 2025 09:14:35 +0000
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

On Tue, Jan 21, 2025 at 12:50=E2=80=AFAM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Pave=
l
> > Nikulin
> > Sent: Sunday, January 19, 2025 2:29 PM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like=
 no one
> > cares.
> >
> > On Sun, Jan 19, 2025 at 5:53=E2=80=AFPM Pavel Nikulin <pavel@noa-labs.c=
om> wrote:
> > >
> > > On Fri, Jan 17, 2025 at 6:08=E2=80=AFPM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Fri, Jan 17, 2025 at 7:27=E2=80=AFAM Pavel Nikulin <pavel@noa-la=
bs.com> wrote:
> > > > >
> > > > > I think it persists as of 6.12.9 and today's firmware version fro=
m git.
> > > > >
> > > > > Hardware Asus um560.6
> > > > >
> > > > > It only happens when the AC adaptor is disconnected, and the
> > > > > screen refresh frequency is set to 120hz. It does not happen on
> > > > > any other refresh frequency, or when the charger is connected.
> > > > >
> > > > > It might be happening in Windows, but at much lower rate, like
> > > > > once in a month. The windows version might be applying some mitig=
ations.
> > > > >
> > > > > Trying to catch what may be a prelude to hang never worked. It's
> > > > > just instahang, without panic, or anything. I cannot debug it
> > > > > without JTAGing the CPU, for which I have no equipment, nor am I
> > > > > sure if there are even JTAG headers exposed on the laptop motherb=
oard.
> > > >
> > > > Please file a bug report and attach your dmesg output.
> > > > https://gitlab.freedesktop.org/drm/amd/-/issues
> > > >
> > > > Alex
> > >
> > > Unfortunately, what I would have would be the same dmesg as anyone
> > > else, however I have made following observations:
> > >
> > > Disabling PSR with debug mask makes it stable.
> > >
> > > If I set the refresh frequency to 60Hz, the lpddr memory clocks wiggl=
e
> > > around 600mHz, and keep going back and forth (spread spectrum
> > > working.)
> > >
> > > If I switch to any other frequency, they stay stably at 937mhz (sprea=
d
> > > spectrum stops working,) and hangs happen.
> > >
> > > If I disconnect antennas from the MT7925 WiFi module, the issues are
> > > gone (as well as the wifi connectivity.)
> > >
> > > If I RFKILL the mt7925, both wifi, and bluetooth, it may still hang.
> > >
> > > If I nevertheless try to connect by putting the open laptop right nex=
t
> > > to the access point, the laptop will hang.
> > >
> > > But if I only try to do the same with 2.4GHz bluetooth mouse, it will
> > > continue to work. If I connect to 2.4GHz wifi, it will still hang
> > > after a few minutes.
> > >
> > > If I use the RTL8156BG based type-C usb dongle, and disconnect the
> > > power. It works stable. If I keep the connection going on type-C
> > > dongle, but switch on wifi, and set it as a default route, everything
> > > works stable, regardless if I connect to 5GHz or 2.4GHz wifi.
> > >
> > > If I try to put grounding tape around DP cables, and around the wifi
> > > module, it did not do anything conclusively.
> > >
> > > If I try to manually set the GPU performance to high, it marginally
> > > improves the hanging rate.
> > >
> > > DP 2.0, and 2.1 works on 600MHz, 1.4 on 300MHz, 1.2 on 150MHz
> > > depending on link speed, which I can't measure
> > >
> > > So, here is what think may have happened during the transition from
> > > 6.11 to 6.12
> > >
> > > - Something PCIE related (ASPM, other PCIE frequency/power settings)
> > > - Something PSR related (PSR raises memory clock rate, disables sprea=
d
> > > spectrum)
> > > - Something power related (undervoltage happens when type-C port, or
> > > power is not plugged in)
> > > - Something RF related (rendered less likely by it keeping working
> > > with type-C ethernet dongle plugged in, but not active)
> > >
> > > My guess it's an interplay in between PCIE, and PSR setting. Less
> > > likely, a hardware problem.
> > >
> > > I do remember, someone with a similar bug did dissect the breakage to
> > > a PCIE related commit.
> > >
> > > Do you want me to still put all of the above into a bug ticket on git=
lab?
> >
> > What is stabilising the system:
> >
> > Following kernel command line parameters:
> > pcie_aspm=3Doff
> > amdgpu_debugmask=3D0x200
> > amdgpu_debugmask=3D0x10
>
> There were a bunch of PSR related fixes that went into 6.13 (and cc'ed st=
able, so should eventually make their way to 6.12) last week.  Can you try =
an updated 6.13 kernel without those debug options?
>
> Alex
>

I am running git 9bffa1ad25b8b3b95d8f463e5c24dabe3c87d54d . Does
anyone here have a recent Ryzen based ASUS laptop, and hardware debug
gear?
