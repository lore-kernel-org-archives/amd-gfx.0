Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1857EC02188
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 08:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB3B10E360;
	Mon, 20 Jan 2025 08:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=noa-labs.com header.i=@noa-labs.com header.b="FI+aNz6m";
	dkim-atps=neutral
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF8410E04A
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2025 19:29:18 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e17de2816so1979474a34.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2025 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=noa-labs.com; s=google; t=1737314957; x=1737919757;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eB+XF5t9qSTrDYSB6vFFB13ujeusu2J8BPPlfuJz3Ho=;
 b=FI+aNz6mmbkTgUtVXvR/lVwinEceOz0a2El7nFXtBkALzyJf7WWo2F4QvpfLK+WzAF
 pQLQTM/qTFVnxNULRWeGbBjJfkt/dwZonkMT0qPWU2PSBd6WuqheCfGByKs5/1kN+eVQ
 OKCK9n7Az0zEWWHNwXt2FGWdNASfBkItGKq5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737314957; x=1737919757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eB+XF5t9qSTrDYSB6vFFB13ujeusu2J8BPPlfuJz3Ho=;
 b=c1PRdsfoj/jhkLjQ9r22+71qM5Xu2AsKT2wnTEinrPyNA8rXycFSUXpADZbxVmLRn0
 mpvcqu1wllnbvsh8LkHMge9KJQGT2HeAaYXdQmqdwBa4qnqz11wkM1+u0utSSavbeBQK
 qMSQ7+mg47f6k1zxycadA3L1+VWYhruiagHW/fgFONaNwSWYjEAJMdhN9uiGF19i4Vst
 Nzf/TG/dg56jPZ0f1APK8+SL0eq7O1dZnQzu1rvrcSTkNEHxajEC02XTeyW+323Sg7ht
 5MxQ/SSUNc9OHwENrOviF4EoTz6upkDAeEeijPSd0Ja/W3pyCPNHd9+p8Tbqmbxnx3uP
 cluw==
X-Gm-Message-State: AOJu0YwDIzVxVE+EgcwhoFt3uJIXsiDkg0vRdNdfKZC8wzhnC1P8kbMj
 6K80xE4HIY7ydTVss97BQV1RVIMJEi59lZwziSfyvQ0y+IkH7sZbUB8POZZBe6YtHQV24giLR0e
 9CX8D5JpebB/XXvbKd0FcqbZq7uWqQ/pBn38TRQ==
X-Gm-Gg: ASbGncsDW/LDfyJ7OF4mgJ/mvdD4V5w5KIPrXOkJsD6De9ou+EyyX6hpW95Ntrn6a3H
 cL2RRatAmOrrY0RLQa1jOPHW4ft0atm1EtqEKoVgc1r3GhnKR2LZRykcLMOMEnZIDcGnhIL7EyU
 A+lrN0eOAh
X-Google-Smtp-Source: AGHT+IHBwJZhF0QJ1Vd+FCO4ZJ6qXAcbKf5F3rjodsxp5aD4b8XKPIiAUuibtC4RQropUDkYCS36JWf8yifNnIOSLKc=
X-Received: by 2002:a05:6871:a58b:b0:29e:2991:d953 with SMTP id
 586e51a60fabf-2b1c0b0279cmr5848946fac.20.1737314957416; Sun, 19 Jan 2025
 11:29:17 -0800 (PST)
MIME-Version: 1.0
References: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
 <CADnq5_Pj0NLqwiooxyXULERo8YQTh1TN76FVnM9MZt3FCMFSwg@mail.gmail.com>
 <CAG-pW8GaL+JSGSmu-G3qbskPoHe=iU4usMP293RB7gr5VVbUQg@mail.gmail.com>
In-Reply-To: <CAG-pW8GaL+JSGSmu-G3qbskPoHe=iU4usMP293RB7gr5VVbUQg@mail.gmail.com>
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Sun, 19 Jan 2025 23:29:07 +0400
X-Gm-Features: AbW1kvZFere2SwAcEGR7zzYVgMJmYKPL12FYpoCJ31lW65J2G8MnOjAycH6HBFs
Message-ID: <CAG-pW8Fe95BTyw2pVTrKJQJs0MnFshXGztWnLk9dqx8B1V6X1g@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Jan 2025 08:46:01 +0000
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

On Sun, Jan 19, 2025 at 5:53=E2=80=AFPM Pavel Nikulin <pavel@noa-labs.com> =
wrote:
>
> On Fri, Jan 17, 2025 at 6:08=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Fri, Jan 17, 2025 at 7:27=E2=80=AFAM Pavel Nikulin <pavel@noa-labs.c=
om> wrote:
> > >
> > > I think it persists as of 6.12.9 and today's firmware version from gi=
t.
> > >
> > > Hardware Asus um560.6
> > >
> > > It only happens when the AC adaptor is disconnected, and the screen
> > > refresh frequency is set to 120hz. It does not happen on any other
> > > refresh frequency, or when the charger is connected.
> > >
> > > It might be happening in Windows, but at much lower rate, like once i=
n
> > > a month. The windows version might be applying some mitigations.
> > >
> > > Trying to catch what may be a prelude to hang never worked. It's just
> > > instahang, without panic, or anything. I cannot debug it without
> > > JTAGing the CPU, for which I have no equipment, nor am I sure if ther=
e
> > > are even JTAG headers exposed on the laptop motherboard.
> >
> > Please file a bug report and attach your dmesg output.
> > https://gitlab.freedesktop.org/drm/amd/-/issues
> >
> > Alex
>
> Unfortunately, what I would have would be the same dmesg as anyone
> else, however I have made following observations:
>
> Disabling PSR with debug mask makes it stable.
>
> If I set the refresh frequency to 60Hz, the lpddr memory clocks wiggle
> around 600mHz, and keep going back and forth (spread spectrum
> working.)
>
> If I switch to any other frequency, they stay stably at 937mhz (spread
> spectrum stops working,) and hangs happen.
>
> If I disconnect antennas from the MT7925 WiFi module, the issues are
> gone (as well as the wifi connectivity.)
>
> If I RFKILL the mt7925, both wifi, and bluetooth, it may still hang.
>
> If I nevertheless try to connect by putting the open laptop right next
> to the access point, the laptop will hang.
>
> But if I only try to do the same with 2.4GHz bluetooth mouse, it will
> continue to work. If I connect to 2.4GHz wifi, it will still hang
> after a few minutes.
>
> If I use the RTL8156BG based type-C usb dongle, and disconnect the
> power. It works stable. If I keep the connection going on type-C
> dongle, but switch on wifi, and set it as a default route, everything
> works stable, regardless if I connect to 5GHz or 2.4GHz wifi.
>
> If I try to put grounding tape around DP cables, and around the wifi
> module, it did not do anything conclusively.
>
> If I try to manually set the GPU performance to high, it marginally
> improves the hanging rate.
>
> DP 2.0, and 2.1 works on 600MHz, 1.4 on 300MHz, 1.2 on 150MHz
> depending on link speed, which I can't measure
>
> So, here is what think may have happened during the transition from 6.11 =
to 6.12
>
> - Something PCIE related (ASPM, other PCIE frequency/power settings)
> - Something PSR related (PSR raises memory clock rate, disables spread sp=
ectrum)
> - Something power related (undervoltage happens when type-C port, or
> power is not plugged in)
> - Something RF related (rendered less likely by it keeping working
> with type-C ethernet dongle plugged in, but not active)
>
> My guess it's an interplay in between PCIE, and PSR setting. Less
> likely, a hardware problem.
>
> I do remember, someone with a similar bug did dissect the breakage to
> a PCIE related commit.
>
> Do you want me to still put all of the above into a bug ticket on gitlab?

What is stabilising the system:

Following kernel command line parameters:
pcie_aspm=3Doff
amdgpu_debugmask=3D0x200
amdgpu_debugmask=3D0x10
