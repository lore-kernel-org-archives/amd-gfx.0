Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEEC25B50
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 11:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A2810E1B1;
	Mon, 23 Jan 2023 11:29:07 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7677910E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 11:29:05 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-15f97c478a8so13487133fac.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 03:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cWVJZPZuYoNdVhRWNGnF8aqI6GOxRLk9QTOMhyHoO8s=;
 b=aPT78zKPX9x8FD5ulTbgTRKd9lGlGOlVxxw02F21pAKm3EHDCzl1hReBODUt4eH26Y
 N/ksDAyVkoVB5uJu39kcJqE7w5+poV8bB2RphZPNmes+0AtL4DVb+bIMc6waTFJOJpO5
 dviUBY5SWqeX4n0o5X8qi74gsMs7wXO3HBZn5OZ7iM9T74nXe8foAdOSoYMXgILk4Pdq
 b8JnKdd8snFGBQTWZEtKu4obZtlUcKVUbkVoSRjelyKXULhdmeNYuRuVYlrjKPQOBNpP
 yYjkgDIWazq0hfrRLDK+otHLdzX2DAYzLPM1zh/FhB3lnyisZe7U2Wwl0xFeIlZesmXa
 HCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cWVJZPZuYoNdVhRWNGnF8aqI6GOxRLk9QTOMhyHoO8s=;
 b=CL+LYKebaAko84jfF4Hxu1ZIjOR8NhCLX4ASASWHZ2e9vOqmmEcnDaovBJM5iaW8ef
 ohy2n3rTTOnRlJjaZjtnFFNJowyU8DBexrrey/qUrRd5eBwolryWKnSqvGO85uJDkggY
 KrNRhLqfAUVtlr3njTYkW3JBYVuv6WFFnDZHf2t4+deMsSdm6NvOwJVf6MIQDJusOhtE
 sOfNb+y8ECaJQ+gH9LNoFOG1ivN3vPCjZQDhP2cSmswRj2dDcaMe/1c8ZSD6U9u4Jum0
 HVM0IQJ2SZZ9dnRBEHTMqI+qew0CCySepCPsjQd0bKb7GD4QOx742Zo+ImonUCoQPXFf
 J5Fg==
X-Gm-Message-State: AFqh2krPlOqn4sCF+Y3ziSIkeLyvEm0r0vXP51b5T4v+a2aYiY4Q/S5r
 CeJ6zIy2eowO4X+1PVIGFRsw7lpQRkFdYpnyaAQ=
X-Google-Smtp-Source: AMrXdXuGel1eON6zEYaGGxOhSzTgg62UsVW/vaudDUYm/OVyjGRyPQpoJNyFs3ch1qJBv+4S2aJC2rchY+saBAnEDPU=
X-Received: by 2002:a05:6870:aa86:b0:143:7fba:ce51 with SMTP id
 gr6-20020a056870aa8600b001437fbace51mr1735033oab.297.1674473344603; Mon, 23
 Jan 2023 03:29:04 -0800 (PST)
MIME-Version: 1.0
References: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
In-Reply-To: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 23 Jan 2023 12:28:53 +0100
Message-ID: <CAD=4a=WuexXdWwRQXby0KnG=AQnR0fXsJAu=dNABU4irNgTdBg@mail.gmail.com>
Subject: Re: Minimal kernel version for 7900XT
To: =?UTF-8?B?R29yYW4gTWVracSH?= <meka@tilda.center>
Content-Type: multipart/alternative; boundary="000000000000e41c8e05f2ecb420"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000e41c8e05f2ecb420
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

6.0 should be enough:
https://www.phoronix.com/review/rx7900xt-rx7900xtx-linux

The firmware files is maybe the most complicated part right now...

//Ernst

Den m=C3=A5n 23 jan. 2023 kl 11:11 skrev Goran Meki=C4=87 <meka@tilda.cente=
r>:

> Hello,
>
> I'm trying to figure out what's the minimal kernel version that supports
> the 7900XT. I found that the driver supports SLES 15:
>
> https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-series/amd-rad=
eon-rx-7900-series/amd-radeon-rx-7900xt
>
> I also found that SLES 15 SP 4 runs on 5.14:
> https://www.suse.com/support/kb/doc/?id=3D000019587#SLE15SP4
>
> The problem I have is that I can't find PCI ID (for my card it's 744c)
> in the list:
>
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/=
amdgpu_drv.c#L1654
>
> Can you help me understand how this card works with Linux without PCI ID
> anywhere mentioned in the code, please? Thank you!
>
> Regards,
> meka
>

--000000000000e41c8e05f2ecb420
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">6.0 should be enough:</div><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif"><a href=3D"https://www.ph=
oronix.com/review/rx7900xt-rx7900xtx-linux">https://www.phoronix.com/review=
/rx7900xt-rx7900xtx-linux</a></div><div class=3D"gmail_default" style=3D"fo=
nt-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default=
" style=3D"font-family:arial,helvetica,sans-serif">The firmware files is ma=
ybe the most complicated part right now...<br></div><div class=3D"gmail_def=
ault" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">//Ernst=
<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">Den m=C3=A5n 23 jan. 2023 kl 11:11 skrev Goran Meki=C4=87 &lt;mek=
a@tilda.center&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hello,<br>
<br>
I&#39;m trying to figure out what&#39;s the minimal kernel version that sup=
ports <br>
the 7900XT. I found that the driver supports SLES 15:<br>
<a href=3D"https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-serie=
s/amd-radeon-rx-7900-series/amd-radeon-rx-7900xt" rel=3D"noreferrer" target=
=3D"_blank">https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-seri=
es/amd-radeon-rx-7900-series/amd-radeon-rx-7900xt</a><br>
<br>
I also found that SLES 15 SP 4 runs on 5.14:<br>
<a href=3D"https://www.suse.com/support/kb/doc/?id=3D000019587#SLE15SP4" re=
l=3D"noreferrer" target=3D"_blank">https://www.suse.com/support/kb/doc/?id=
=3D000019587#SLE15SP4</a><br>
<br>
The problem I have is that I can&#39;t find PCI ID (for my card it&#39;s 74=
4c) <br>
in the list:<br>
<a href=3D"https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c#L1654" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.=
c#L1654</a><br>
<br>
Can you help me understand how this card works with Linux without PCI ID <b=
r>
anywhere mentioned in the code, please? Thank you!<br>
<br>
Regards,<br>
meka<br>
</blockquote></div>

--000000000000e41c8e05f2ecb420--
