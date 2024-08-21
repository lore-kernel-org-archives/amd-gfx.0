Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE2DC531DF
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 07:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C6C10E79F;
	Thu, 22 Aug 2024 07:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lirmm.fr header.i=@lirmm.fr header.b="eoyEa52R";
	dkim-atps=neutral
X-Greylist: delayed 345 seconds by postgrey-1.36 at gabe;
 Wed, 21 Aug 2024 11:58:21 UTC
Received: from kirkenes.lirmm.fr (kirkenes.lirmm.fr [193.49.104.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FFD10E8DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 11:58:21 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by kirkenes.lirmm.fr (Postfix) with ESMTPSA id 2F88BF94
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 13:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirmm.fr; s=mail;
 t=1724241154; bh=RSS1SCA7TGlFtcnUwubl0ZphF+ny5nRJLXHO86dVl5Y=;
 h=Reply-To:From:Date:Subject:To:From;
 b=eoyEa52RfSLRLxB5WLRWgsF1vgFMmBb5RBpbFRD1JIjYQIp3re9NohaAav2yyoaYG
 atGcouwPBvjaNeppTBHGeJRQMQ2oRE14Vpj5JjIdLlhM7Wor4hnnF8VnRyhdHtZGgo
 IP9Fy3qV18B4Cdm0bars1O76uhYfQfuvT4D+x/+A9lTRDg9VKZHDvkD0yzGvVdzSWr
 h7eMsu3BCC/vHjr5CRdzBT1fA1Nz7/PjfOFHL6lpBB58OLepd1lqSAn5Hv9iYz3YIb
 7M4zci1Ps6Tu8L7nkhhJ1RVQELcuIjp9ZaFDWYm0ocfJiYXKJkjZ80txy6T/LhlKig
 brHfwotMDieqQ==
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-27020fca39aso3847144fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 04:52:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwfhxMCUOLbBJ3XMs6irAHrY9B2kKt3S9kNlIxJqkmnbX40a25C
 8WumIezU/psDqswT28JTdhoylQHy1++qxhhmi7w13auucdN9dX0jEFtfMOkN11eQFDgMycN9x6c
 Fe4/ZED6BbIHey36Jgem4za3+Eu8=
X-Google-Smtp-Source: AGHT+IG6BcrYpP9ilOZnyeBPbuIp5i41CTP2ZJ1kNUHyttZgQ5ux/y76J66EYxNNDfVv7oysNHfj+v5X35fgXvanUL4=
X-Received: by 2002:a05:6871:5222:b0:25e:1cdf:c604 with SMTP id
 586e51a60fabf-2738be308f0mr1882139fac.31.1724241152942; Wed, 21 Aug 2024
 04:52:32 -0700 (PDT)
MIME-Version: 1.0
From: Krister Swenson <krister.swenson@lirmm.fr>
Date: Wed, 21 Aug 2024 13:52:06 +0200
X-Gmail-Original-Message-ID: <CALEYxHUaxtVx5M-k0v+3jTKWQB5ipSjy1HWQ6o5=krR_vKL3aw@mail.gmail.com>
Message-ID: <CALEYxHUaxtVx5M-k0v+3jTKWQB5ipSjy1HWQ6o5=krR_vKL3aw@mail.gmail.com>
Subject: two AMD cards failing with radeon driver
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000006dd5ab0620302df3"
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

--0000000000006dd5ab0620302df3
Content-Type: text/plain; charset="UTF-8"

Hello all,

I couldn't find a list to send mail to concerning the radeon driver. Is
this an OK place?

I'm desperate for help, as I have crippling issues with my AMD cards since
updating to Ubuntu 24.04. This is my work machine, and it's seriously
hampering my productivity.

I have a bit of experience messing around with this stuff over the last
decades, but remain very naive about debugging graphics problems. I have
two cards:

03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Oland GL [FirePro W2100]
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]

Since the update the Radeon HD no longer works: I can boot into safe mode,
but any attempt to start GDM results in a black screen with a line at the
bottom.

The FirePro card appears to work fine, until the driver goes haywire and I
see a screen full of snow. I can still <ctrl><alt><F4> to a terminal and
shut the machine down (without seeing anything but snow), but the graphics
will not work. This happens with Wayland and Xorg. I posted a bug report
here that includes details from syslog:

https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-video-ati/+bug/2068342

I would greatly appreciate any advice, hints, or workarounds on this issue,
as it's seriously holding me back. Thank you folks!

kms

p.s.

A few more details follow...

=> sudo lshw -c video
  *-display
       description: VGA compatible controller
       product: Oland GL [FirePro W2100]
       vendor: Advanced Micro Devices, Inc. [AMD/ATI]
       physical id: 0
       bus info: pci@0000:03:00.0
       logical name: /dev/fb0
       version: 00
       width: 64 bits
       clock: 33MHz
       capabilities: pm pciexpress msi vga_controller bus_master cap_list
rom fb
       configuration: depth=32 driver=radeon latency=0 resolution=2560,1080
       resources: irq:50 memory:e0000000-efffffff memory:f3e00000-f3e3ffff
ioport:8000(size=256) memory:f3e40000-f3e5ffff
  *-display
       description: VGA compatible controller
       product: Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
       vendor: Advanced Micro Devices, Inc. [AMD/ATI]
       physical id: 0
       bus info: pci@0000:04:00.0
       version: 00
       width: 64 bits
       clock: 33MHz
       capabilities: pm pciexpress msi vga_controller bus_master cap_list
rom
       configuration: driver=radeon latency=0
       resources: irq:51 memory:d0000000-dfffffff memory:f3d20000-f3d3ffff
ioport:7000(size=256) memory:f3d00000-f3d1ffff

--0000000000006dd5ab0620302df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello all,</div><div><br></div><div>I couldn&#39;t fi=
nd a list to send mail to  concerning the radeon driver. Is this an OK plac=
e?</div><div><br></div><div>I&#39;m desperate for help, as I have crippling=
 issues with my AMD cards since updating to Ubuntu 24.04. This is my work m=
achine, and it&#39;s seriously hampering my productivity.</div><div><br></d=
iv><div>I have a bit of experience messing around with this stuff over the =
last decades, but remain very naive about debugging graphics problems. I ha=
ve two cards:</div><div><br></div><div>03:00.0 VGA compatible controller: A=
dvanced Micro Devices, Inc. [AMD/ATI] Oland GL [FirePro W2100]<br>04:00.0 V=
GA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XT =
[Radeon HD 7470/8470 / R5 235/310 OEM]</div><div><br></div><div>Since the u=
pdate the Radeon HD no longer works: I can boot into safe mode, but any att=
empt to start GDM results in a black screen with a line at the bottom.</div=
><div><br></div><div>The FirePro card appears to work fine, until the drive=
r goes haywire and I see a screen full of snow. I can still &lt;ctrl&gt;&lt=
;alt&gt;&lt;F4&gt; to a terminal and shut the machine down (without seeing =
anything but snow), but the graphics will not work. This happens with Wayla=
nd and Xorg. I posted a bug report here that includes details from syslog:<=
/div><div><br><a href=3D"https://bugs.launchpad.net/ubuntu/+source/xserver-=
xorg-video-ati/+bug/2068342">https://bugs.launchpad.net/ubuntu/+source/xser=
ver-xorg-video-ati/+bug/2068342</a></div><div><br></div><div>I would greatl=
y appreciate any advice, hints, or workarounds on this issue, as it&#39;s s=
eriously holding me back. Thank you folks!</div><div><br></div><div>kms</di=
v><div><br></div><div>p.s.<br></div><div><br></div><div>A few more details =
follow...<br></div><div><br></div><div>=3D&gt; sudo lshw -c video<br>=C2=A0=
 *-display =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0description: VGA compatible controller<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0product: Oland GL [FirePro W2100]<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0vendor: Advanced Micro Devices, Inc. [AMD/ATI]<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0physical id: 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0bus info: pci@000=
0:03:00.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0logical name: /dev/fb0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0version: 00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0width: 64 bit=
s<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0clock: 33MHz<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
capabilities: pm pciexpress msi vga_controller bus_master cap_list rom fb<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0configuration: depth=3D32 driver=3Dradeon late=
ncy=3D0 resolution=3D2560,1080<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0resources: irq=
:50 memory:e0000000-efffffff memory:f3e00000-f3e3ffff ioport:8000(size=3D25=
6) memory:f3e40000-f3e5ffff<br>=C2=A0 *-display<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0description: VGA compatible controller<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0pro=
duct: Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0vendor: Advanced Micro Devices, Inc. [AMD/ATI]<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0physical id: 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0bus info: pci@000=
0:04:00.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0version: 00<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0width: 64 bits<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0clock: 33MHz<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0capabilities: pm pciexpress msi vga_controller bus_mast=
er cap_list rom<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0configuration: driver=3Dradeo=
n latency=3D0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0resources: irq:51 memory:d00000=
00-dfffffff memory:f3d20000-f3d3ffff ioport:7000(size=3D256) memory:f3d0000=
0-f3d1ffff</div><div>
=20
</div>
</div>

--0000000000006dd5ab0620302df3--
