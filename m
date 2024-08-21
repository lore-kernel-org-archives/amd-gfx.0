Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F46C5320E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 07:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9231A10E04E;
	Thu, 22 Aug 2024 07:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lirmm.fr header.i=@lirmm.fr header.b="Lb7pWtpX";
	dkim-atps=neutral
Received: from kirkenes.lirmm.fr (kirkenes.lirmm.fr [193.49.104.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC95D10E5AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 14:04:21 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by kirkenes.lirmm.fr (Postfix) with ESMTPSA id 3522415E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 16:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirmm.fr; s=mail;
 t=1724249060; bh=9oqVjncvbl9OmFqZhDygqR28cBLms34D6a9jrq5Lazo=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:From;
 b=Lb7pWtpXZCMQI3y8AfUonCNxb/1TyisZaE3MuOuP+Le4eO/zL76nM47eaoNW5OmrW
 SY5qv+w840cfu4JF1Q2xXD2PMbOhJ4Lh0hznFb4FeO6BgiwCo+gND7Yii5/Ve8wR9o
 FlB9VQUKqTYSM18i916bc5bWSQnqBhxNbIxxoSMCGccpDC1Ofky3IVAyYF+NEGWxOt
 +C4Vl71v0qL+pzsDpXiFHzfzZLAtzYooMyb3qMtLL4nmPO1yoxNNDJSHl6uWZYDiq2
 agKesDmEhsSe1UQ2IoKbg2m+VXgRaofkzT74AngnvWIyNEkauF+uBABvKoHtEW29pI
 rZyMGaQbDpbbA==
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-2704d461058so2321477fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 07:04:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKus8EmAy7Qozv5k1HSOACUUPpE3MF7ndj4mMUyhuc46YvauQn
 al3h2bfgOYekmZfs0jNXaX8sTbJJ7gMO/ASZnUncK3PRCFzfnbPzyvyD5tB2v+UTqerB6Ep/XEY
 8r92qwV2eu0TuJ37ki9t8y+jiHfo=
X-Google-Smtp-Source: AGHT+IEzOk17yvETpFrb/JgraKkzaiuJynkMsUBqcXSOIFf0GgliL7Ky+pIfaiZ5AsC4MK5GbT68+QoWMTberTcXElc=
X-Received: by 2002:a05:6871:e71a:b0:254:e89e:fc1d with SMTP id
 586e51a60fabf-2738bed3da3mr2090068fac.51.1724249058888; Wed, 21 Aug 2024
 07:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALEYxHUaxtVx5M-k0v+3jTKWQB5ipSjy1HWQ6o5=krR_vKL3aw@mail.gmail.com>
In-Reply-To: <CALEYxHUaxtVx5M-k0v+3jTKWQB5ipSjy1HWQ6o5=krR_vKL3aw@mail.gmail.com>
From: Krister Swenson <krister.swenson@lirmm.fr>
Date: Wed, 21 Aug 2024 16:03:52 +0200
X-Gmail-Original-Message-ID: <CALEYxHU3AF3u3gSzAcHj8GYpbVOPbHudgpOCAY3LgTYs1CkS3Q@mail.gmail.com>
Message-ID: <CALEYxHU3AF3u3gSzAcHj8GYpbVOPbHudgpOCAY3LgTYs1CkS3Q@mail.gmail.com>
Subject: Re: two AMD cards failing with radeon driver
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a8dffc0620320441"
X-Mailman-Approved-At: Thu, 22 Aug 2024 07:20:39 +0000
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
Reply-To: krister.swenson@lirmm.fr
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000a8dffc0620320441
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the spam folks.
I didn't realize that the new amdgpu driver would work on that old
hardware.  I'm using that driver now, hoping it will be more stable than
radeon. I'm not sure why Ubuntu is set up to use the radeon driver by
default.

kms

On Wed, Aug 21, 2024 at 1:52=E2=80=AFPM Krister Swenson <swenson@lirmm.fr> =
wrote:

> Hello all,
>
> I couldn't find a list to send mail to concerning the radeon driver. Is
> this an OK place?
>
> I'm desperate for help, as I have crippling issues with my AMD cards sinc=
e
> updating to Ubuntu 24.04. This is my work machine, and it's seriously
> hampering my productivity.
>
> I have a bit of experience messing around with this stuff over the last
> decades, but remain very naive about debugging graphics problems. I have
> two cards:
>
> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Oland GL [FirePro W2100]
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
>
> Since the update the Radeon HD no longer works: I can boot into safe mode=
,
> but any attempt to start GDM results in a black screen with a line at the
> bottom.
>
> The FirePro card appears to work fine, until the driver goes haywire and =
I
> see a screen full of snow. I can still <ctrl><alt><F4> to a terminal and
> shut the machine down (without seeing anything but snow), but the graphic=
s
> will not work. This happens with Wayland and Xorg. I posted a bug report
> here that includes details from syslog:
>
>
> https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-video-ati/+bug/206=
8342
>
> I would greatly appreciate any advice, hints, or workarounds on this
> issue, as it's seriously holding me back. Thank you folks!
>
> kms
>
> p.s.
>
> A few more details follow...
>
> =3D> sudo lshw -c video
>   *-display
>        description: VGA compatible controller
>        product: Oland GL [FirePro W2100]
>        vendor: Advanced Micro Devices, Inc. [AMD/ATI]
>        physical id: 0
>        bus info: pci@0000:03:00.0
>        logical name: /dev/fb0
>        version: 00
>        width: 64 bits
>        clock: 33MHz
>        capabilities: pm pciexpress msi vga_controller bus_master cap_list
> rom fb
>        configuration: depth=3D32 driver=3Dradeon latency=3D0 resolution=
=3D2560,1080
>        resources: irq:50 memory:e0000000-efffffff memory:f3e00000-f3e3fff=
f
> ioport:8000(size=3D256) memory:f3e40000-f3e5ffff
>   *-display
>        description: VGA compatible controller
>        product: Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
>        vendor: Advanced Micro Devices, Inc. [AMD/ATI]
>        physical id: 0
>        bus info: pci@0000:04:00.0
>        version: 00
>        width: 64 bits
>        clock: 33MHz
>        capabilities: pm pciexpress msi vga_controller bus_master cap_list
> rom
>        configuration: driver=3Dradeon latency=3D0
>        resources: irq:51 memory:d0000000-dfffffff memory:f3d20000-f3d3fff=
f
> ioport:7000(size=3D256) memory:f3d00000-f3d1ffff
>

--000000000000a8dffc0620320441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry for the spam folks.</div><div>I didn&#39;t real=
ize that the new amdgpu driver would work on that old hardware.=C2=A0 I&#39=
;m using that driver now, hoping it will be more stable than radeon. I&#39;=
m not sure why Ubuntu is set up to use the radeon driver by default.<br></d=
iv><div><br></div><div>kms<br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 21, 2024 at 1:52=E2=80=AFPM=
 Krister Swenson &lt;<a href=3D"mailto:swenson@lirmm.fr">swenson@lirmm.fr</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div>Hello all,</div><div><br></div><div>I couldn&#39;t find=
 a list to send mail to  concerning the radeon driver. Is this an OK place?=
</div><div><br></div><div>I&#39;m desperate for help, as I have crippling i=
ssues with my AMD cards since updating to Ubuntu 24.04. This is my work mac=
hine, and it&#39;s seriously hampering my productivity.</div><div><br></div=
><div>I have a bit of experience messing around with this stuff over the la=
st decades, but remain very naive about debugging graphics problems. I have=
 two cards:</div><div><br></div><div>03:00.0 VGA compatible controller: Adv=
anced Micro Devices, Inc. [AMD/ATI] Oland GL [FirePro W2100]<br>04:00.0 VGA=
 compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XT [R=
adeon HD 7470/8470 / R5 235/310 OEM]</div><div><br></div><div>Since the upd=
ate the Radeon HD no longer works: I can boot into safe mode, but any attem=
pt to start GDM results in a black screen with a line at the bottom.</div><=
div><br></div><div>The FirePro card appears to work fine, until the driver =
goes haywire and I see a screen full of snow. I can still &lt;ctrl&gt;&lt;a=
lt&gt;&lt;F4&gt; to a terminal and shut the machine down (without seeing an=
ything but snow), but the graphics will not work. This happens with Wayland=
 and Xorg. I posted a bug report here that includes details from syslog:</d=
iv><div><br><a href=3D"https://bugs.launchpad.net/ubuntu/+source/xserver-xo=
rg-video-ati/+bug/2068342" target=3D"_blank">https://bugs.launchpad.net/ubu=
ntu/+source/xserver-xorg-video-ati/+bug/2068342</a></div><div><br></div><di=
v>I would greatly appreciate any advice, hints, or workarounds on this issu=
e, as it&#39;s seriously holding me back. Thank you folks!</div><div><br></=
div><div>kms</div><div><br></div><div>p.s.<br></div><div><br></div><div>A f=
ew more details follow...<br></div><div><br></div><div>=3D&gt; sudo lshw -c=
 video<br>=C2=A0 *-display =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0description: VGA compatible controll=
er<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0product: Oland GL [FirePro W2100]<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0vendor: Advanced Micro Devices, Inc. [AMD/ATI]<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0physical id: 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0bus=
 info: pci@0000:03:00.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0logical name: /dev/fb=
0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0version: 00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0w=
idth: 64 bits<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0clock: 33MHz<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0capabilities: pm pciexpress msi vga_controller bus_master cap_=
list rom fb<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0configuration: depth=3D32 driver=
=3Dradeon latency=3D0 resolution=3D2560,1080<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
resources: irq:50 memory:e0000000-efffffff memory:f3e00000-f3e3ffff ioport:=
8000(size=3D256) memory:f3e40000-f3e5ffff<br>=C2=A0 *-display<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0description: VGA compatible controller<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0product: Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0vendor: Advanced Micro Devices, Inc. [AMD/ATI]<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0physical id: 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0b=
us info: pci@0000:04:00.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0version: 00<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0width: 64 bits<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0clock:=
 33MHz<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0capabilities: pm pciexpress msi vga_co=
ntroller bus_master cap_list rom<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0configuratio=
n: driver=3Dradeon latency=3D0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0resources: irq=
:51 memory:d0000000-dfffffff memory:f3d20000-f3d3ffff ioport:7000(size=3D25=
6) memory:f3d00000-f3d1ffff</div><div>
=20
</div>
</div>
</blockquote></div>

--000000000000a8dffc0620320441--
