Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A77C02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 08:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB07110E36B;
	Mon, 20 Jan 2025 08:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=noa-labs.com header.i=@noa-labs.com header.b="nOe1glFI";
	dkim-atps=neutral
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C2A10E103
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2025 13:53:32 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f2e31139d9so1631506eaf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2025 05:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=noa-labs.com; s=google; t=1737294812; x=1737899612;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUjuFJLKy70JiVPZF76Avmg4XWgc8QZMGWJrLXoKepE=;
 b=nOe1glFI5Pu5nJIyYEqYR238+I3EYCdFE6uoqubQI8srtnUjFPIS4h6KSQflUyP6bC
 CJhs2NQ7CjvzCphwYH8BryhtK9v5Tt4CgvNWKt4ep0F9Po1KxWBkLt7PCy7NaB9atjHQ
 JNUaf5ry+5U1GCsgHvy2+Jmp7eNTdF/gujJZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737294812; x=1737899612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUjuFJLKy70JiVPZF76Avmg4XWgc8QZMGWJrLXoKepE=;
 b=VtxlR/tlvMw1u0d/BFrKwiRlFR3b7OFjib2qMbq/SbaVP0e1zjHjw+e5yNiZ4EwghC
 ccE/VZLMO7Fk7GhI1kARN3XgwIH1Z1DKe+1JwxkIjGX3zP++H1y+7ahhcjo6UxUP1qcz
 1ErFmp7bC7LRKc4lj0zeAqXz8XyxjdbqITKVhK85Zwu/RM5cbTIbZJk3IhwYVxMQlq15
 Znbi5qqzv5gmIgrbH8mbJvi3Yztsed3MB28+FKumdVaVuHTmiVpvn9NrehIWzKwINXTG
 BN+iHNgICDCY88vr6oykjYeA+g+iGSTopA/2/1dTonHzNvErpl+2rbc4sUz4Taeq43He
 JfEw==
X-Gm-Message-State: AOJu0YzHfAKNhJ6w6R2vDXFfUV6EOEFzXNwid9EnC/phOs+ny6X9hIgt
 sAzSp52G0cVd5APhhw1w0WDhIWmuMhXlBTthXQyx46Mes1ZLopnb8K8QaQvwCrtURatgITTtnkA
 nf4pe6iyY1zyb0L8qkXsyLXKUvcOOrmZ22FIGlA==
X-Gm-Gg: ASbGncvVPVcblYKkAnZpWRO0viOxVf+u092oPI1bTV2lYmNKCvwV6VT0/i+iSLl+/lF
 /E7h4qCcBgqAuxPYiU7G3htPLHNUOn8QibOVD621GlZGwEExN+GvyxH4c5BV4FnJDb7RiWTVqgz
 StVW+E1mya
X-Google-Smtp-Source: AGHT+IFtvtyywoLX2q7eM+43vLCy4/VwkBf8cKIWf3xoSxKgUK05HOfQqW9cxGA5P0A5Yg5EFQSrZ6C2Z1nJPt6YClQ=
X-Received: by 2002:a05:6870:794:b0:297:26a9:32ef with SMTP id
 586e51a60fabf-2b1c0cd175amr5507076fac.33.1737294811781; Sun, 19 Jan 2025
 05:53:31 -0800 (PST)
MIME-Version: 1.0
References: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
 <CADnq5_Pj0NLqwiooxyXULERo8YQTh1TN76FVnM9MZt3FCMFSwg@mail.gmail.com>
In-Reply-To: <CADnq5_Pj0NLqwiooxyXULERo8YQTh1TN76FVnM9MZt3FCMFSwg@mail.gmail.com>
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Sun, 19 Jan 2025 17:53:22 +0400
X-Gm-Features: AbW1kvZk9HYDFXD9cQeC1hnfKn44hgeybWoMkTCNaiTOLjiBNrlrgrcxTMDrY90
Message-ID: <CAG-pW8GaL+JSGSmu-G3qbskPoHe=iU4usMP293RB7gr5VVbUQg@mail.gmail.com>
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

On Fri, Jan 17, 2025 at 6:08=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Jan 17, 2025 at 7:27=E2=80=AFAM Pavel Nikulin <pavel@noa-labs.com=
> wrote:
> >
> > I think it persists as of 6.12.9 and today's firmware version from git.
> >
> > Hardware Asus um560.6
> >
> > It only happens when the AC adaptor is disconnected, and the screen
> > refresh frequency is set to 120hz. It does not happen on any other
> > refresh frequency, or when the charger is connected.
> >
> > It might be happening in Windows, but at much lower rate, like once in
> > a month. The windows version might be applying some mitigations.
> >
> > Trying to catch what may be a prelude to hang never worked. It's just
> > instahang, without panic, or anything. I cannot debug it without
> > JTAGing the CPU, for which I have no equipment, nor am I sure if there
> > are even JTAG headers exposed on the laptop motherboard.
>
> Please file a bug report and attach your dmesg output.
> https://gitlab.freedesktop.org/drm/amd/-/issues
>
> Alex

Unfortunately, what I would have would be the same dmesg as anyone
else, however I have made following observations:

Disabling PSR with debug mask makes it stable.

If I set the refresh frequency to 60Hz, the lpddr memory clocks wiggle
around 600mHz, and keep going back and forth (spread spectrum
working.)

If I switch to any other frequency, they stay stably at 937mhz (spread
spectrum stops working,) and hangs happen.

If I disconnect antennas from the MT7925 WiFi module, the issues are
gone (as well as the wifi connectivity.)

If I RFKILL the mt7925, both wifi, and bluetooth, it may still hang.

If I nevertheless try to connect by putting the open laptop right next
to the access point, the laptop will hang.

But if I only try to do the same with 2.4GHz bluetooth mouse, it will
continue to work. If I connect to 2.4GHz wifi, it will still hang
after a few minutes.

If I use the RTL8156BG based type-C usb dongle, and disconnect the
power. It works stable. If I keep the connection going on type-C
dongle, but switch on wifi, and set it as a default route, everything
works stable, regardless if I connect to 5GHz or 2.4GHz wifi.

If I try to put grounding tape around DP cables, and around the wifi
module, it did not do anything conclusively.

If I try to manually set the GPU performance to high, it marginally
improves the hanging rate.

DP 2.0, and 2.1 works on 600MHz, 1.4 on 300MHz, 1.2 on 150MHz
depending on link speed, which I can't measure

So, here is what think may have happened during the transition from 6.11 to=
 6.12

- Something PCIE related (ASPM, other PCIE frequency/power settings)
- Something PSR related (PSR raises memory clock rate, disables spread spec=
trum)
- Something power related (undervoltage happens when type-C port, or
power is not plugged in)
- Something RF related (rendered less likely by it keeping working
with type-C ethernet dongle plugged in, but not active)

My guess it's an interplay in between PCIE, and PSR setting. Less
likely, a hardware problem.

I do remember, someone with a similar bug did dissect the breakage to
a PCIE related commit.

Do you want me to still put all of the above into a bug ticket on gitlab?
