Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61748C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 13:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D71910E7F8;
	Wed,  3 Jul 2024 13:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="biUds8q0";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7971510E55C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 08:25:05 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-58b447c511eso672728a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jul 2024 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719908704; x=1720513504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yxt7bK/qz0lF4+ZrKEp9zmq4vYogronpllYr+bdkbFc=;
 b=biUds8q0hwg0dUyQ/iTdZdd2nYNAmzDK+Vr1AKRQT4SOINSsm+UP+kcD8J6KT2KlDP
 PkUBFDmWsoRv498C4eeGojhoWgEgIGp2hivsqaUnc3NTnSFC4RevysZBhIGMp5RfRdR6
 PF1EbHYxkeuSyjoJZj4lu7r8JuYCQso5Ip7b0DPDnB7nmXXD7I70iQibiRCqIVqYFLu4
 IfKsCZigvX46W+4XXO7GINW7yUWz/SX+OuuzaOAw/xPpCpsJNp03gVii5RrcsUWnKhOb
 lAMnDi/x2izw+Tb3n8GwJA/kzf9HRRV4D+hk1vF9eEYrH7npE9FIZEcBSOMAZo58C6kw
 TtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719908704; x=1720513504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yxt7bK/qz0lF4+ZrKEp9zmq4vYogronpllYr+bdkbFc=;
 b=VPZMETGz+h0KA6PdKJxA7ggej0jkxtIhiInD/nAcFaW6NZuu9w64+X5W5hsIMOxGYC
 afERRwy1RbzeTbzKSZx4m3U2nlgZycrJmydXtOqcnDZK0/pCZEA/bXKNA7G8+l0Yi0Rc
 kJginF8iik/5XYBn5JeoAHyy7JWqWWl3WbEXGiI7+XDZUdfZwCZY/l8rj2tRywXU0fho
 9+7k3Bpx+ZwxAvZgKUZUDwJO+sMNpZbnBDoLE9zokJMgsWmo/1XI69N1Bw4OtYxCnIpT
 ZqdJqtdtXqBPrrmCGE6mjNx80+UQ+BtqwVX8GbpEfQsbnDdQJTujNBy68F++sGzpSTU4
 LlPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdP/iJXzZIxyJm81fj8tcZs6BmoLOlb5jiWYqz/02wIA4aMtqJ7Jw28qr7dRDX5s+vvM5C9d3gwQdcub/E8tmhV1OeYoNjNFt1q/rz4g==
X-Gm-Message-State: AOJu0YxzVk9LDq6pJ8fGSp3QOhIoTb0feU9CpgwvJE5R6yBiap6cnuwj
 AZfT3KtzZvEFxuJpnN/EF3m8P7KClip5Ze2x4NbpLgaD9367Wgh8JZcRcSsfmvbUdfyIXX7ZxN2
 uOKlqvjj8ru1I6oHrZwcZmv+cNms=
X-Google-Smtp-Source: AGHT+IGwglRlUmIumlLg7tmOse/5xVovqFBHW7c3bA/EmPO1/H2LF0T+nVsF56ObTlq7ziJ/bSZHV4wMpBlyurV7x3A=
X-Received: by 2002:a05:6402:5216:b0:57d:2c9:6497 with SMTP id
 4fb4d7f45d1cf-5879ede274dmr7593085a12.3.1719908703516; Tue, 02 Jul 2024
 01:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
 <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
 <BL1PR12MB5158CCFAE59B15D8D0228A4B8EDC2@BL1PR12MB5158.namprd12.prod.outlook.com>
 <CADVcqdzvw9i37Gf35TKrxTmiR7DoUWtVi9PMrWpn4t+uTuNfEQ@mail.gmail.com>
 <DM4PR12MB51652B525669A4001C1EF9F58EDC2@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CADVcqdyJEHRXZMrWJEzGA2w17hXcKgrvQM0nf5c15YB6nJO9ag@mail.gmail.com>
 <DM4PR12MB90721105FE7F16EF8BEF297BF0DC2@DM4PR12MB9072.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB90721105FE7F16EF8BEF297BF0DC2@DM4PR12MB9072.namprd12.prod.outlook.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
Date: Tue, 2 Jul 2024 10:24:47 +0200
Message-ID: <CADVcqdzx32dcz_WpfvCipC=NfGDsyjUUA=VjJqzx506PEh59Ag@mail.gmail.com>
Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
To: "Li, Humphrey" <Humphrey.Li@amd.com>
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 03 Jul 2024 13:03:44 +0000
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

Yes, I can try two panels of the same model. The results are:
LG 32UL950 + LG 27UL850 =3D> "MCLK constant boost" (issue)
LG 27UL950 + LG 27UL850 =3D> "MCLK is scaling down" (no-issue)

>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> yeah,  there timings look the same, but could you try panels of exactly t=
he same model?
>
>
>
> Humphrey
>
>
>
> ________________________________
> From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
> Sent: Tuesday, July 2, 2024 13:59
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: Li, Humphrey <Humphrey.Li@amd.com>; Alex Deucher <alexdeucher@gmail.c=
om>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondar=
y Monitor Connected
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> I see the same modeline setting for both of them, does that mean "same ti=
ming" ?
>
> $ xrandr --verbose | grep '*current' -A 2
>   3840x2160 (0x4a) 533.250MHz +HSync -VSync *current +preferred
>         h: width  3840 start 3888 end 3920 total 4000 skew    0 clock 133=
.31KHz
>         v: height 2160 start 2214 end 2219 total 2222           clock  60=
.00Hz
> --
>   3840x2160 (0x4a) 533.250MHz +HSync -VSync *current +preferred
>         h: width  3840 start 3888 end 3920 total 4000 skew    0 clock 133=
.31KHz
>         v: height 2160 start 2214 end 2219 total 2222           clock  60=
.00Hz
>
>
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > The two high resolution panels have different timings so it's needed to=
 be fixed to high memory clock level.
> > @Li, Humphrey to further comment.
> > Thanks.
> >
> >
> > -----Original Message-----
> > From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
> > Sent: Tuesday, July 2, 2024 12:20 PM
> > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
> > Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Second=
ary Monitor Connected
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > Hi,
> >
> > Yes, they are 4k monitors. Any reason for such and expected boost for t=
hem?
> >
> > BTW: I try to increase blanking periods for both monitors without any c=
hange.
> >
> > Jaroslav P.
> >
> > >
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Jaroslav,
> > > Are both of your monitors 4K resolution?
> > > Then most likely the memory clock is expected to be boosted.
> > > Thanks.
> > >
> > >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Alex Deucher
> > > Sent: Monday, July 1, 2024 11:07 PM
> > > To: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Subject: Re: High Power Consumption of AMD RX6800xt in Idle with
> > > Secondary Monitor Connected
> > >
> > > Caution: This message originated from an External Source. Use proper =
caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Mon, Jul 1, 2024 at 3:25=E2=80=AFAM Jaroslav Pulchart <jaroslav.pu=
lchart@gmail.com> wrote:
> > > >
> > > > Dear AMD GPU Kernel Maintainers,
> > > >
> > > > I am writing to report an issue with high power consumption of my
> > > > AMD RX6800xt graphics card when a secondary monitor is connected.
> > > >
> > > > Upon investigation, I observed that my desktop computer generates
> > > > more heat while idling. I determined that the high power consumptio=
n
> > > > issue arises when I connect a secondary monitor to my AMD RX6800xt
> > > > card, causing it to consume approximately 40W of power in idle stat=
e .
> > > >
> > > > I checked the "GFX Clocks and Power:" in
> > > > /sys/kernel/debug/dri/1/amdgpu_pm_info of my RX6800xt during idle,
> > > > and here are the findings:
> > > >
> > > > With the secondary monitor connected memory frequency is up and
> > > > constantly at 1000MHz:
> > > >         1000 MHz (MCLK)
> > > >         3 MHz (SCLK)
> > > >         1825 MHz (PSTATE_SCLK)
> > > >         1000 MHz (PSTATE_MCLK)
> > > >         856 mV (VDDGFX)
> > > >         45.00 W (average SoC)
> > > >
> > > > Single monitor connected:
> > > >         96 MHz (MCLK)
> > > >         0 MHz (SCLK)
> > > >         1825 MHz (PSTATE_SCLK)
> > > >         1000 MHz (PSTATE_MCLK)
> > > >         6 mV (VDDGFX)
> > > >         8.00 W (average SoC)
> > > >
> > > > The significant difference in power consumption between the two
> > > > states indicates a potential issue in power management that needs t=
o
> > > > be addressed. Your assistance in resolving this matter would be
> > > > greatly appreciated.
> > >
> > > It depends on the timing of the monitors.  The memory reclocking can =
only occur during blanking periods on the monitors.  If the reclocking is d=
one outside of the blanking periods, you will see flickering or artifacts o=
n the display when it happens.  If the blanking periods are too short the d=
river can only downclock memory when the displays are off.  Adding more mon=
itors makes this harder as you have to take into account the blanking perio=
ds on all monitors.  You can try adjusting the modelines used on each displ=
ay to increase the blanking periods.
> > >
> > > Alex
