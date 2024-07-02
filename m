Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A1CC30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 07:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E2F10E54A;
	Tue,  2 Jul 2024 07:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CD8ri5LB";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35ECC10E0DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 04:20:43 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-a6fe61793e2so194786166b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jul 2024 21:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719894041; x=1720498841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKN9q3PN+5mfmetQTEzlpOvcE/JuGy0Hesb+pQz/P2E=;
 b=CD8ri5LB9rzXaCd/25ClY7/IRnV+6nhVgKeJmUyPYzO3k2sCg2sewPSJHEqqVguxsr
 BsQsaG/Bq6QcxIi6ye9V2YGfjlYj21RAeQi2+Ho4J8MfYWL72gEyp3oaE3QAGKOu7i7n
 O964KvVxQNpsrpqbmgyiIRYX3gjXBKILtOXQLWua1TNVHZgtHWbSoyEGmxS6Jbq6uhmD
 351MtMes6f7qB5Y8c35Sd2VAvoqzBAmeU9yiyRQtYR+/MIqBOrxe73q2BWOLwjHwTPBO
 fa+hZVR+B+/u1rEvBnYCjyLUd9qjnN1h7iOP5KHVhbqq/gM1y8q+5tQqpnu25l3vwW6h
 syoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719894041; x=1720498841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKN9q3PN+5mfmetQTEzlpOvcE/JuGy0Hesb+pQz/P2E=;
 b=R2KWJKASxc7p9DZJYaweLndiw/IAI10NHLCddtOdOeOcknDJK+iCTJFh+11lQxz9JV
 b/auuyJlEtFC8EDxBxhW/PCclYYaIe7EEZzvEGGBmgX806AYV0cskpkSyBGT07WEMVIB
 GEbpAgc90MIFGFI9Jhzc6tOK84rg3KbE4qWqqEkjbxU6OeSguTfbwIOlQR8WgP5YCm35
 1kBcVRSTiyj1l6diL8IJRyv3B0ONUbn8n60fa8tgv1IKAV+kTHRY3scnNRAMlNyF6dMa
 HE/RokLGX/WXlKlHqT4DA5bfe87x9YCLIrDcgPr0VPRN5h6d2QpsLtOWaCv3pWLcT3wh
 Hljg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7+IPLp/2QVWUj5r7ZaYbz5g6hfQCoWIbZMT/U9aWcDxhzvYYixeLrfD6qYKm/06bmeV7OpqsW5pYudsyL0KKJYtoqDeV3IPw5XeIA2Q==
X-Gm-Message-State: AOJu0Yy8cx845lM7TTAIwu9zl2oFL6NjXh67WsOHEKiJNOBHj2SAElCg
 BMweXMDm5gP79hZGJNjw5WQs+AJ8R2BKvgxPYP2f9qjqHBkl7GqrDArb7bYKjBx85ZaeehJZo49
 WeT9JQ1uC7GbOa5k4yuvGurSYe/k=
X-Google-Smtp-Source: AGHT+IF4+2dk6ueieN63cJSTlkbS6J8RhLwWe7qEO8YpTBJTCitnnJggFNoUFzpfbWoIHs9K0WxtFZRsDu32Z/YExo0=
X-Received: by 2002:a05:6402:2712:b0:58b:baaf:f4a2 with SMTP id
 4fb4d7f45d1cf-58bbaaff632mr91146a12.40.1719894041210; Mon, 01 Jul 2024
 21:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
 <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
 <BL1PR12MB5158CCFAE59B15D8D0228A4B8EDC2@BL1PR12MB5158.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5158CCFAE59B15D8D0228A4B8EDC2@BL1PR12MB5158.namprd12.prod.outlook.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
Date: Tue, 2 Jul 2024 06:20:24 +0200
Message-ID: <CADVcqdzvw9i37Gf35TKrxTmiR7DoUWtVi9PMrWpn4t+uTuNfEQ@mail.gmail.com>
Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, 
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

Hi,

Yes, they are 4k monitors. Any reason for such and expected boost for them?

BTW: I try to increase blanking periods for both monitors without any chang=
e.

Jaroslav P.

>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Jaroslav,
> Are both of your monitors 4K resolution?
> Then most likely the memory clock is expected to be boosted.
> Thanks.
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Monday, July 1, 2024 11:07 PM
> To: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: High Power Consumption of AMD RX6800xt in Idle with Secondar=
y Monitor Connected
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Mon, Jul 1, 2024 at 3:25=E2=80=AFAM Jaroslav Pulchart <jaroslav.pulcha=
rt@gmail.com> wrote:
> >
> > Dear AMD GPU Kernel Maintainers,
> >
> > I am writing to report an issue with high power consumption of my AMD
> > RX6800xt graphics card when a secondary monitor is connected.
> >
> > Upon investigation, I observed that my desktop computer generates more
> > heat while idling. I determined that the high power consumption issue
> > arises when I connect a secondary monitor to my AMD RX6800xt card,
> > causing it to consume approximately 40W of power in idle state .
> >
> > I checked the "GFX Clocks and Power:" in
> > /sys/kernel/debug/dri/1/amdgpu_pm_info of my RX6800xt during idle, and
> > here are the findings:
> >
> > With the secondary monitor connected memory frequency is up and
> > constantly at 1000MHz:
> >         1000 MHz (MCLK)
> >         3 MHz (SCLK)
> >         1825 MHz (PSTATE_SCLK)
> >         1000 MHz (PSTATE_MCLK)
> >         856 mV (VDDGFX)
> >         45.00 W (average SoC)
> >
> > Single monitor connected:
> >         96 MHz (MCLK)
> >         0 MHz (SCLK)
> >         1825 MHz (PSTATE_SCLK)
> >         1000 MHz (PSTATE_MCLK)
> >         6 mV (VDDGFX)
> >         8.00 W (average SoC)
> >
> > The significant difference in power consumption between the two states
> > indicates a potential issue in power management that needs to be
> > addressed. Your assistance in resolving this matter would be greatly
> > appreciated.
>
> It depends on the timing of the monitors.  The memory reclocking can only=
 occur during blanking periods on the monitors.  If the reclocking is done =
outside of the blanking periods, you will see flickering or artifacts on th=
e display when it happens.  If the blanking periods are too short the drive=
r can only downclock memory when the displays are off.  Adding more monitor=
s makes this harder as you have to take into account the blanking periods o=
n all monitors.  You can try adjusting the modelines used on each display t=
o increase the blanking periods.
>
> Alex
