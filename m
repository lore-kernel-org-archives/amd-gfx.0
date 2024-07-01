Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7A7C3065A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 15:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BBF10E270;
	Mon,  1 Jul 2024 15:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aCr/Emzp";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D04F10E45B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 15:07:24 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-706524adf91so2475032b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jul 2024 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719846444; x=1720451244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3EoiktPQkY/tlljpNUk5WVnnOLC56JnC+/nGR8GpPs=;
 b=aCr/EmzpLYTUi5ZSRfAktwW6uLApTjIE9zONx8BU6clqQM6NZun//PE6QatOGLZABz
 O0KHJ8jdNc/cPF6L9tODq36bIjKC61uG24mHUYwLgL6W+gLRSXh2CFQEOIvQNTnHcD5u
 2SM8z3p37KvpAq/iwj4wtNY+ac/TYtwVQCqkYCFBxBuGbVPc/rEcMZOMixfPrleaFY/B
 WOtrZsqrL+qzYkie+PPb31TG3MBPsKot01kYz5xmXAzuYwZuF2OKc+wuCdW/7aQH79tD
 OxsurOQTRIRKh6mfoW8RBrqE1VM3fZusFuB6ZeoFv+dqnbq8IaEW8WiSkmn37ok6C+QH
 NpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846444; x=1720451244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3EoiktPQkY/tlljpNUk5WVnnOLC56JnC+/nGR8GpPs=;
 b=iEVDpVwynYImmD3W61M467ef4qckYPW6d7cHiQwN+B4QWCJ2r2yCD0tViJO8IvtaGc
 wCNu6a5SZw/ROqvLWqbo2p2OCW4T3roKvWmSMRfLeBIhiCKZaVrHhBRj8w6iPoib5J+x
 7BlFSaB3y9o0d4flc4UfH9CxLXFvf8WQn9NTMCMcAiwFgAuEQG5k3HHpPVh/dQOkjMb5
 tEajZibx1fWtPFAz2WU3u3ygueBIsl3YuXxPe8ZM4E6f3+ridG4ncWXy27NGJ82rCp9m
 mFnJErBeKiJSrePP+USDrhWRtqpPWw+OIpuu5izCLEyUM6iuKGfI80W4Jhp6geGbPeLC
 fhKQ==
X-Gm-Message-State: AOJu0YwY4J0tYNCN3NwMme2bNwmEqhDvM6myf9Cc/HioOgibgTmLU+2K
 FpcQjGr114jaq1UXNOr54wHK9l8SSbxqSHqO8ThH1RUMyRvG1xKTtQFqVawTjH1k/rSr8Dp/XY+
 HntrqJNb/6HmaZvzGYtYYjJDI7ufA8A==
X-Google-Smtp-Source: AGHT+IHwOZfKIB3Kteim9Ic+7aIF9TfllYHw4AfCewu1sf1JYfrOAPLntMrUEOiWusA3CtGrA3tUHqlPiSRP7L82UCg=
X-Received: by 2002:a05:6a20:6a20:b0:1be:d161:47e7 with SMTP id
 adf61e73a8af0-1bef60fce9amr9502914637.24.1719846443450; Mon, 01 Jul 2024
 08:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
In-Reply-To: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Jul 2024 11:07:11 -0400
Message-ID: <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
To: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 1, 2024 at 3:25=E2=80=AFAM Jaroslav Pulchart
<jaroslav.pulchart@gmail.com> wrote:
>
> Dear AMD GPU Kernel Maintainers,
>
> I am writing to report an issue with high power consumption of my AMD
> RX6800xt graphics card when a secondary monitor is connected.
>
> Upon investigation, I observed that my desktop computer generates more
> heat while idling. I determined that the high power consumption issue
> arises when I connect a secondary monitor to my AMD RX6800xt card,
> causing it to consume approximately 40W of power in idle state .
>
> I checked the "GFX Clocks and Power:" in
> /sys/kernel/debug/dri/1/amdgpu_pm_info of my RX6800xt during idle, and
> here are the findings:
>
> With the secondary monitor connected memory frequency is up and
> constantly at 1000MHz:
>         1000 MHz (MCLK)
>         3 MHz (SCLK)
>         1825 MHz (PSTATE_SCLK)
>         1000 MHz (PSTATE_MCLK)
>         856 mV (VDDGFX)
>         45.00 W (average SoC)
>
> Single monitor connected:
>         96 MHz (MCLK)
>         0 MHz (SCLK)
>         1825 MHz (PSTATE_SCLK)
>         1000 MHz (PSTATE_MCLK)
>         6 mV (VDDGFX)
>         8.00 W (average SoC)
>
> The significant difference in power consumption between the two states
> indicates a potential issue in power management that needs to be
> addressed. Your assistance in resolving this matter would be greatly
> appreciated.

It depends on the timing of the monitors.  The memory reclocking can
only occur during blanking periods on the monitors.  If the reclocking
is done outside of the blanking periods, you will see flickering or
artifacts on the display when it happens.  If the blanking periods are
too short the driver can only downclock memory when the displays are
off.  Adding more monitors makes this harder as you have to take into
account the blanking periods on all monitors.  You can try adjusting
the modelines used on each display to increase the blanking periods.

Alex
