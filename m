Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2BEC3065C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 07:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B237D10E547;
	Tue,  2 Jul 2024 07:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WbOhSw/B";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4874B10E0EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 06:00:16 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so161006a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jul 2024 23:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719900014; x=1720504814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nssNrLwkLI+NUrM25Ewx6N9xGTHvxG50OdYX2CFNzMg=;
 b=WbOhSw/B2f38Pa40Rj827ww6/VB9kjrPM9VGenTV1/UZN9ZU530mJoyceGE8uh1LXI
 UwzPgy8O7tQ+iqggwRkljPKD5qpJRshNH5byjzg5s6q/2sdmnethywG2kNM6ZjwDpZB2
 k0dfShc1YS0l0OXAoboYaFYHrpwEqNDOwrzcc0BOqyh3FyB8zYcZDzDe0Er2uhaf6st4
 9izWkmNNWjrT/rrFqW3n+0qgQvqOsvgfqeZbFzHDV7Ml1S1aCMs8wseQN2SgnlWIRhyP
 SBeoSvvTvwU1fdSdtY2SPRw54ERvb2PDNeIA65HN58ZlqXubI3SLONVgvjMkF9Tm5nyU
 HktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719900014; x=1720504814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nssNrLwkLI+NUrM25Ewx6N9xGTHvxG50OdYX2CFNzMg=;
 b=WYs3bvRqokN64x1VmI0D4NYsrWEZ9b/oQ2zv6G/uc60Z05PuAxSGnmVFC+a5CQkf1k
 zZ3tlefXyjSBnru4m6uWomfxTqMKB9EmnkAylAqE29woNzmqr9szVtca9Es99ZuPHeAT
 2hzreYH2tBKP6OCcGPIdFthzAKX7mKEyaa4jAea2Rqm6CpSHSMQcnFraz27zijwKrVyL
 46BGqnv33ny3z07B8aR3USnckHpo3tA4I4uuwjqE8T9T3kdBSfzM/JLPqXZDnuRbgJzO
 q28nLtCVA6eUiG+fbhPYygMth9AlkAZGH9OQrWpj29PV0w+ZuuzQ9CA3b1N17J6N00xM
 hYaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI7bTS90b6hWbpZW+hp94qHM3maxxnHx4UVf7P7n6QjqIJujV1d5Nb9AfgbPHv9YhXNe7Y/2lUwhPcdSGBUty9gggg7J9HObvOnCUUDg==
X-Gm-Message-State: AOJu0Yy7rmaV+TNPzEBVl/KYT0ExbCULUioso4GRjS8HpJfDqdn8wEFs
 tJHTRJROCNGTDy+wmbP/Pw+70vYyS1mZkLLOO3VO06beZ1Ni4kcb8lxPB0c8gRf3Iy+HEBlwqh5
 Di2v/mnXZTW5iLQzrj0nU4nEXpfEO51iH9Cs=
X-Google-Smtp-Source: AGHT+IF7Q3QFx+7KDD0cN3IilOb8e4ySiOCsOABN9lnuKSziZ9qxnJzqxNVrlx+QXnUS16Qf33t28Gz6wEsmY+Eb/GI=
X-Received: by 2002:a05:6402:84f:b0:57c:db99:a131 with SMTP id
 4fb4d7f45d1cf-587a09195b9mr6219031a12.29.1719900014110; Mon, 01 Jul 2024
 23:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
 <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
 <BL1PR12MB5158CCFAE59B15D8D0228A4B8EDC2@BL1PR12MB5158.namprd12.prod.outlook.com>
 <CADVcqdzvw9i37Gf35TKrxTmiR7DoUWtVi9PMrWpn4t+uTuNfEQ@mail.gmail.com>
 <DM4PR12MB51652B525669A4001C1EF9F58EDC2@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51652B525669A4001C1EF9F58EDC2@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
Date: Tue, 2 Jul 2024 07:59:58 +0200
Message-ID: <CADVcqdyJEHRXZMrWJEzGA2w17hXcKgrvQM0nf5c15YB6nJO9ag@mail.gmail.com>
Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Li, Humphrey" <Humphrey.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 02 Jul 2024 07:30:28 +0000
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

I see the same modeline setting for both of them, does that mean "same timi=
ng" ?

$ xrandr --verbose | grep '*current' -A 2
  3840x2160 (0x4a) 533.250MHz +HSync -VSync *current +preferred
        h: width  3840 start 3888 end 3920 total 4000 skew    0 clock 133.3=
1KHz
        v: height 2160 start 2214 end 2219 total 2222           clock  60.0=
0Hz
--
  3840x2160 (0x4a) 533.250MHz +HSync -VSync *current +preferred
        h: width  3840 start 3888 end 3920 total 4000 skew    0 clock 133.3=
1KHz
        v: height 2160 start 2214 end 2219 total 2222           clock  60.0=
0Hz


>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> The two high resolution panels have different timings so it's needed to b=
e fixed to high memory clock level.
> @Li, Humphrey to further comment.
> Thanks.
>
>
> -----Original Message-----
> From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
> Sent: Tuesday, July 2, 2024 12:20 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondar=
y Monitor Connected
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Hi,
>
> Yes, they are 4k monitors. Any reason for such and expected boost for the=
m?
>
> BTW: I try to increase blanking periods for both monitors without any cha=
nge.
>
> Jaroslav P.
>
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Jaroslav,
> > Are both of your monitors 4K resolution?
> > Then most likely the memory clock is expected to be boosted.
> > Thanks.
> >
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Alex Deucher
> > Sent: Monday, July 1, 2024 11:07 PM
> > To: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: High Power Consumption of AMD RX6800xt in Idle with
> > Secondary Monitor Connected
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Jul 1, 2024 at 3:25=E2=80=AFAM Jaroslav Pulchart <jaroslav.pulc=
hart@gmail.com> wrote:
> > >
> > > Dear AMD GPU Kernel Maintainers,
> > >
> > > I am writing to report an issue with high power consumption of my
> > > AMD RX6800xt graphics card when a secondary monitor is connected.
> > >
> > > Upon investigation, I observed that my desktop computer generates
> > > more heat while idling. I determined that the high power consumption
> > > issue arises when I connect a secondary monitor to my AMD RX6800xt
> > > card, causing it to consume approximately 40W of power in idle state =
.
> > >
> > > I checked the "GFX Clocks and Power:" in
> > > /sys/kernel/debug/dri/1/amdgpu_pm_info of my RX6800xt during idle,
> > > and here are the findings:
> > >
> > > With the secondary monitor connected memory frequency is up and
> > > constantly at 1000MHz:
> > >         1000 MHz (MCLK)
> > >         3 MHz (SCLK)
> > >         1825 MHz (PSTATE_SCLK)
> > >         1000 MHz (PSTATE_MCLK)
> > >         856 mV (VDDGFX)
> > >         45.00 W (average SoC)
> > >
> > > Single monitor connected:
> > >         96 MHz (MCLK)
> > >         0 MHz (SCLK)
> > >         1825 MHz (PSTATE_SCLK)
> > >         1000 MHz (PSTATE_MCLK)
> > >         6 mV (VDDGFX)
> > >         8.00 W (average SoC)
> > >
> > > The significant difference in power consumption between the two
> > > states indicates a potential issue in power management that needs to
> > > be addressed. Your assistance in resolving this matter would be
> > > greatly appreciated.
> >
> > It depends on the timing of the monitors.  The memory reclocking can on=
ly occur during blanking periods on the monitors.  If the reclocking is don=
e outside of the blanking periods, you will see flickering or artifacts on =
the display when it happens.  If the blanking periods are too short the dri=
ver can only downclock memory when the displays are off.  Adding more monit=
ors makes this harder as you have to take into account the blanking periods=
 on all monitors.  You can try adjusting the modelines used on each display=
 to increase the blanking periods.
> >
> > Alex
