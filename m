Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C26C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 01:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8410661248
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 01:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8410661248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A51989B9A;
	Mon, 23 Aug 2021 01:56:36 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C939289B9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 01:56:33 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id b200so19869265iof.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Aug 2021 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=GYnrv0VeBOU5sopV7fw9CP+tWRnurt3mcJV4LpLP0bQ=;
 b=LhzMoDSXt+7FWQU4pnjZT/Sr+MZHGZXbANp1ugqRjQUPUJiEXt7DqN32ezw/83O7oZ
 VSOd9HIcL8oNySQKtBC1BlkRiR0MK9ynLPmaJyo+s9dMmIWYoSzxkFeG/3lEFEQGcZmt
 1nhpJyz7XyBD5RgVj80oqVrK69ab/sPXvH6xwCOAWofu1JhEWEh1t+ZKBwi3Dj2YO6ur
 zvAWX7Wh7jeszOUn8O8neTSDeqnOf40SyU5Yj72eugY6ZI4cHBgxGkUkn9xkbwv8K2/U
 1eKufmduidmJtwaX/TfhCO+W3BrOGhuCy9TiJMYi124Xhjuv+ZI8OjkJfkkwI9dcgPD1
 91pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=GYnrv0VeBOU5sopV7fw9CP+tWRnurt3mcJV4LpLP0bQ=;
 b=tVzOvwM25GjxJr75HE4WBk5IyX9RIgxBS7GGMHuGcsCtXdDl3PoC5tgPwdZd47v3UK
 sJsYjnN4ybLQVtgsDhAG4LqOrmVKrVZOa+48dc626QyAPb4zQigSsQ1wakPZaxcmJNSh
 4ZT0JrQpxUwCcpKdi18Hm30OhBGKh0nEEmWCll7XAFU9/8RHWV+/nLjOpAhr74zdfZD1
 PUE+NFjFDTzgDKKUfuJtjNm531qrSuMYf2A2ndA8l7B45NCr8NKWa9/QHtICIzrePSwV
 pdJ/OKOaSGwL6g4eVaPTyo/SHLOV7+Oc0XIxIWtN/dM/1vFn6CzBDxK0V9fV1YssfRlc
 11kA==
X-Gm-Message-State: AOAM5336KM8G4qEfxv5JHUG4MtTxAoAPw9Tj+ISl5vKm3/akfI/EmjtY
 B8SF/ufvNtbeqF5dRx2uM6r0I9QAiEUdoWDHAb6O7okkQutMqw==
X-Google-Smtp-Source: ABdhPJxjbE1hq49lquMxMwPoKNuCQu1dU4Qn8XGmwGQBMdxpxT63k+e111OIoyVck8OfsOsfOohP4dLqwkvX94kRtzc=
X-Received: by 2002:a6b:fb0b:: with SMTP id h11mr23960520iog.59.1629683793058; 
 Sun, 22 Aug 2021 18:56:33 -0700 (PDT)
MIME-Version: 1.0
From: Evans Jahja <evansjahja13@gmail.com>
Date: Mon, 23 Aug 2021 08:56:21 +0700
Message-ID: <CAAq5pW_7Tv=qzTeUkTuMZMwq+FN63Qmz3pXCiwMx5R4Gbg89bA@mail.gmail.com>
Subject: Voltage control on Southern Island GPU using radeon driver
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000094de3605ca30534e"
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

--00000000000094de3605ca30534e
Content-Type: text/plain; charset="UTF-8"

Hi, I have a HAINAN GPU below:

lspci -nn
0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI]
Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]

I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.

I'm trying to understand more on how voltage control works and how I can
modify the voltage for doing overvoltage / undervoltage on my GPU. The
reason is I am observing how running programs under high GPU load (glmark2)
would lead to crashes when I use dpm=1 in either radeon or amdgpu driver,
which seems to happen when I am reaching power level 4 (sclk 900MHz), while
a lighter program like glxgears could run and switch power levels  between
0,1,2 without issue under both drivers. I believe my laptop might be
faulty, but I would like to take this opportunity to try fixing it from the
driver's side so that it can run anyway, however limited.

Right now, I have managed to increase the performance of my GPU by manually
overwriting the sclk to 630MHz in all performance_levels in radeon_pm.c,
which surprises me as overriding the clock was not possible for me to do
previously via sysfs.

I've managed to tweak both sclk and mclk (or so I believe), but I still
cannot tweak the voltage (vddc). The reason is, if I increase the sclk to
650MHz, the lockup will happen again. Changing the pl->vddc  variable does
not seem to do anything. After various tracing with printk, I understand
that on my system:

pi->voltage_control = radeon_atom_is_voltage_gpio(rdev,
SET_VOLTAGE_TYPE_ASIC_VDDC,
   VOLTAGE_OBJ_GPIO_LUT)

this returns false, while:

si_pi->voltage_control_svi2 =
radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYPE_ASIC_VDDC,
   VOLTAGE_OBJ_SVID2);

This returns true, so I believe my system is using SVI2 somehow to set the
voltage. Having no experience with SVI2, I read online and found out that
SVI2 is a voltage regulator that uses Data / Clock pins to clock-in 8 bits
of information and convert it to some voltage value between OFF, 0.5V ->
1.5V, offering fine control based on some look up table.

My questions are as follows:
Is it possible for me to modify my system so that I can manually adjust the
voltage to my GPU?

Thank you very much in advance. This is the first time I deal with kernel
drivers, so any guidance on the matter helps a lot.

- Evans

--00000000000094de3605ca30534e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, I have a HAINAN GPU below:<div><br></div><div>lspci -n=
n</div><div>0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc.=
 [AMD/ATI] Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]<br></div><div><br=
></div><div>I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.</div><di=
v><br></div><div>I&#39;m trying to understand more on how voltage control w=
orks and how I can modify the voltage for doing overvoltage / undervoltage =
on my GPU. The reason is I am observing how running programs under high GPU=
 load (glmark2) would=C2=A0lead to crashes when I use dpm=3D1 in either rad=
eon or amdgpu driver, which seems to happen when I am reaching power level =
4 (sclk 900MHz), while a lighter=C2=A0program like glxgears could run and s=
witch power levels=C2=A0 between 0,1,2 without issue under both drivers. I =
believe=C2=A0my laptop might be faulty, but I would like to take this oppor=
tunity to try fixing it from the driver&#39;s side so that it can run anywa=
y, however limited.</div><div><br></div><div>Right now, I have managed to i=
ncrease the performance of my GPU by manually overwriting the sclk to 630MH=
z in all performance_levels in radeon_pm.c, which surprises me as overridin=
g the clock was not possible for me to do previously via sysfs.=C2=A0</div>=
<div><br></div><div>I&#39;ve managed to tweak both sclk and mclk (or so I b=
elieve), but I still cannot tweak the voltage (vddc). The reason is, if I i=
ncrease the sclk to 650MHz, the lockup will happen again. Changing the pl-&=
gt;vddc=C2=A0 variable does not seem to do anything. After various tracing =
with printk, I understand that on my system:<br></div><div><br></div><div>p=
i-&gt;voltage_control =3D radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYP=
E_ASIC_VDDC,<br>					 =C2=A0 =C2=A0VOLTAGE_OBJ_GPIO_LUT)<br></div><div><br>=
</div><div>this returns false, while:</div><div><br></div><div>si_pi-&gt;vo=
ltage_control_svi2 =3D<br>			radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_=
TYPE_ASIC_VDDC,<br>						 =C2=A0 =C2=A0VOLTAGE_OBJ_SVID2);<br></div><div><b=
r></div><div>This returns true, so I believe my system is using SVI2 someho=
w to set the voltage. Having no experience with SVI2, I read online and fou=
nd out that SVI2 is a voltage regulator that uses Data / Clock pins to cloc=
k-in 8 bits of information and convert it to some voltage value between OFF=
, 0.5V -&gt; 1.5V, offering fine control based on some look up table.</div>=
<div><br></div><div>My questions are as follows:</div><div>Is it possible f=
or me to modify my system so that I can manually adjust the voltage to my G=
PU?</div><div><br></div><div>Thank you very much in advance. This is the fi=
rst time I deal with kernel drivers, so any guidance on the matter helps a =
lot.</div><div><br></div><div>- Evans</div><div><br></div><div><br></div></=
div>

--00000000000094de3605ca30534e--
