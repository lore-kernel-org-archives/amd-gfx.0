Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE371EE20AA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCD910E7F7;
	Fri,  6 Feb 2026 14:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HAkTHqS1";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F89010E329
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 05:14:20 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-59e2cb21520so411392e87.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 21:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770354859; cv=none;
 d=google.com; s=arc-20240605;
 b=Z4V8Pu/kJtrdeTN+KYMTEFfOUE9K8Prx2BIOgbAeA+XxKBrWwrRIvDry+mfRaOjwf/
 R0qtmlicMq/rFfEEhVDflz/ubL0HQZm6bvZr9mA18pnXV2t8t/mFgJbUsJA1P04TODGS
 2CXN858UezPrr/jKQsra3t+c2QySQC8tYdAybTdC4bNhN5jkoPTHDVRSKEqNwVeVZaKh
 j3hu8+YNcw+kDJDPR6BgJsvJgdLgs3S1sXKfCfCM5nwsv3QjBbGc2hk6cAUyT33gx/Nf
 AbxD+Ljo1C8Fy7YZpccnChjEiu+H+G3VUUXKZim7GJXrBFqqUOZid5qyfxfnMYtrWpDW
 4T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=k5jOIViDlhsz3z8odSG73YMDlVJsFTiQKJUwKnhmu1A=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=B8F2l4sDbNGyj83+RZ2jy86aT83gGWPe7Ap9IyW/Bd3mumvamTiLCys52+mRSZ7Gl6
 q8pZKQByaEVrVrAicC38VpH6szfRSb3nJcTrImUyHtoLQyGQIGCHRI5PjmDRxMK17r6E
 76ABtTaWuJuY1MAUal4KDc/CodUqg8grTZlZsNoqEb97SC2kGmxDdi8c9wkRybVDg2LG
 SUhdASuFb8fRMMMMQ/3Q1GfaV9XoWtsXD2LCYFNkTyJHs5tf7yQQn++P6L8r3jMpZmC0
 QIziiQtYCaN6LS9k2nLY/KHiVOk5/Wue9nzYAvUUdq2wg/yTyW4tgjhHRMMvp1E4hUlU
 aZYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770354859; x=1770959659; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k5jOIViDlhsz3z8odSG73YMDlVJsFTiQKJUwKnhmu1A=;
 b=HAkTHqS1Qiz1zK45R33S1nMC53rOTKsdGvhN20j4eoCfGhh7PlWXuylHv0vhhbliIr
 iIGZRe0qsCdRlvB7BZrN5z35IVurGbGjqHP7hjeeh7/iHxCsBJoDsAvxlTWb2esszFvU
 8Uop3JDS0q30SPEKUJYkWkF/XvUsdyUxvdK+yCuvZzp8WgYm2tl3LbXGpf84NE+7TplS
 PozRpu0hyh5ltE0HONXdi4qPZ0MNSYRpG53dml4DoHLyS7t8NrVa5mkcFW+pMwt49ccU
 xIsvyNf4DzH+F8OqOD97RtX99oikgyWD2MTidpx/r4Qef0FDfqytswTfSbHZysIG+xub
 iEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770354859; x=1770959659;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k5jOIViDlhsz3z8odSG73YMDlVJsFTiQKJUwKnhmu1A=;
 b=ro3s+Y/RbwnJs1JCvlEZU6AFq0cco9VJa4zc9SRrem8lLeCb8ueex1+qIBmZ4etdaf
 yruLCXVFDf28DqBPp74OGQZmLHhBD0JmFQFT3tuGZqW6euIu9dmsQ0CjttjNjbyanjgG
 Ix4vtNDFFFHeRFUbMcEV8u9SIzVuuraJ4QNNOuxH1ePx+88L9NwKfbpXd5t6e+1yQEcj
 cvQN76i2PJY3sPrDpGM5LJAUbE1PRIN85Wi46bsynj2XA5mH7V/S4TmYlvBgvnWZoCN6
 JfJMpsCv7pJe2N+5D505sY2MUZcnQ1YAXNW+YypytWDGZckfe31p3fxZX6VfSu58d/cr
 BCZQ==
X-Gm-Message-State: AOJu0YzDfhU2uFhQEQDvOUVQ1bAf2HzW4/bBmuxR7Ig9trtVS4t/VOT2
 1T+dm85KGk9HsOrVoKmx82ix+O+eM5ddP/UgJlxKK9OXVRu4WjaBBSM2YsKkzHbJNrRrbZzlNOg
 ujlwzqPuzCm2t2uaI6pIV3hdNBjVZ4GVCIA==
X-Gm-Gg: AZuq6aI3x2FuTJ8KJ9/ScsrJawCFMR/mBQULb8mETcsW57sIqCoJ+XTnopDirfutrw+
 B8Ekzpsu+K/ObVZ0sE5xyf5wObhZpMyrdiv6AfXMFIqsYMRW6aob4nb/PpHOm0LntxO+xB93bCC
 e0fFQJU1Hl/bEE8vMXUAm6bCHdGY6MR1rtAAfjQOr33+DUCrihxcBvdSH5cR9bqZNjjbJf69kWV
 hbPHjw6OKfscVMsOhEPUy8cf6w5ogRhsW4YBYFuOn0Zwhg4Rdfkut/MdVlyqFYt/OVNuh4=
X-Received: by 2002:ac2:51ce:0:b0:59d:f669:c92d with SMTP id
 2adb3069b0e04-59e451582aamr392705e87.28.1770354858359; Thu, 05 Feb 2026
 21:14:18 -0800 (PST)
MIME-Version: 1.0
From: Sean Wilson <seanthewilson06@gmail.com>
Date: Fri, 6 Feb 2026 00:14:07 -0500
X-Gm-Features: AZwV_QinCKllf0V4UDAnDvUR9rOd9KR1_veODGqWmXw8BTglV4WOdkfUm_i_Qpk
Message-ID: <CAHhNixZWkaKgfA-1GtV3NK1LRu_2oOC3Xgq4DsA6c6RkxOyCfw@mail.gmail.com>
Subject: =?UTF-8?Q?HDMI_2=2E1_FRL_support_using_Intel=E2=80=99s_i915_driver_app?=
 =?UTF-8?Q?roach?=
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000757dd7064a20dc05"
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

--000000000000757dd7064a20dc05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a cross post of my feature request on AMD=E2=80=99s GitLab.

Describe the problem

Due to licensing restrictions, AMD GPUs are currently limited to HDMI 2.0,
which has a maximum bandwidth of 18 Gbps. This limits users to lower max
resolutions and refresh rates even when the hardware is capable of HDMI
2.1. DisplayPort works at full advertised capacity, but this doesn=E2=80=99=
t help
users like me who are connecting to TVs that only have HDMI.
Describe the new feature behavior

My idea involves implementing HDMI 2.1 FRL (Fixed Rate Link) support which
will allow the GPU to take advantage of the full 48 Gbps bandwidth that
HDMI 2.1 supports. My implementation is based on adapting Intel=E2=80=99s
implementation of FRL used in the i915 driver in ARC GPUs.

Intel ARC GPU drivers previously relied on built-in DP to HDMI PCONs, but
these were added at the dedication of the board vendor and not a mandatory
part of the chipset. Intel successfully added native HDMI 2.1 FRL support
to their open source driver by repurposing the TMDS clock lane for FRL,
which enabled the full 48 Gbps bandwidth. This implementation was merged
into the mainline kernel in late 2022 and appears to somehow navigated the
HDMI Forum licensing restrictions that currently limit AMD=E2=80=99s driver=
s.

Here is the relevant mailing list discussion:
https://lists.freedesktop.org/archives/intel-gfx/2022-November/311389.html

The expected behavior would result in AMD GPUs with HDMI 2.1 hardware
capabilities to be able to negotiate FRL mode with compatible HDMI 2.1
displays. This would give users access to 48 Gbps bandwidth over HDMI,
enabling higher max resolution an refresh rates such as 4k@144Hz and
8k@60Hz.

This will NOT enable the full 2.1 spec, however it will provide the
bandwidth 2.1 allows for (which I believe is the most important benefit).
Describe the target user/application

The target user is anyone with an AMD GPU connecting to an HDMI TV or
monitor. Just for one, Linux gamers would gravely benefit from this as max
refresh rates are greatly limited by HDMI.

The existing userspace (compositors, DEs, etc.) should be able to remain
untouched. The kernel would simply expose higher max resolutions and
refresh rates through the standard DRM interface. This is modeled after how
the Intel implementation works, so userspace applications wouldn=E2=80=99t =
need to
know what mode they=E2=80=99re using, they just see the available modes exp=
osed by
the kernel. I wouldn=E2=80=99t imagine this feature would break any existin=
g
userspace applications given that it only expands the available display
modes when 2.1 compatible hardware is detected.
How do you plan to validate this feature

I am NOT a developer and lack the programming knowledge to test and
implement this feature myself. I am proposing this concept based on reading
on Intel=E2=80=99s successful implementation, hoping that someone with the =
ability
can validate its feasibility on AMD hardware.

I=E2=80=99d imagine it could be validated by testing with various HDMI 2.1 =
displays
and verifying that 4k@144Hz works correctly. Backwards compatibility with
2.0 and earlier displays should be tested to confirm they still work
without FRL. Although I don=E2=80=99t think it would be an issue, composite=
s should
be tested to make sure they work without modification. Display mode
switching and hot plugging should also be tested.
Business case

This feature would eliminate a major limitation for Linux users with AMD
GPUs who want to use HDMI. Given the emerging Linux gaming market, this
would be a major step forward for devices such as the Steam machine, which
are marketed as living-room style gaming consoles. Furthermore, this would
bring AMD GPUs on Linux to closer parity with Nvidia, given that HDMI 2.1
is fully supported on Nvidia=E2=80=99s proprietary Linux driver. This would=
 GREATLY
help AMD=E2=80=99s competitive position in the Linux gaming market.
Draft of the userspace API

No new userspace APIs should be needed. As stated earlier, the existing DRM
interfaces would expose the higher bandwidth modes when an HDMI 2.1 FRL
capable display is detected.

Granted, I am fairly new to display drivers, and I have VERY limited
understanding, the two main things I am unsure about are

1. Do AMD GPUs with HDMI 2.1 hardware capability support an architecture
that would allow repurposing the TMDS clock channel for FRL in a similar
way to Intel?

2. Are there non-hardware obstacles in AMD=E2=80=99s display controller
architecture that would prevent adapting Intel=E2=80=99s implementation?

I, along with a major portion of the Linux gaming community would very much
appreciate it if someone can confirm if this is viable.

--000000000000757dd7064a20dc05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a cross post of my feature request on AMD=E2=80=99s GitLab.<div dir=
=3D"auto"><span style=3D"font-family:&quot;helvetica neue&quot;;font-size:1=
7pt;font-weight:700;white-space:pre-wrap;background-color:transparent;color=
:rgb(0,0,0)"><br></span></div><div dir=3D"auto"><span style=3D"font-family:=
&quot;helvetica neue&quot;;font-size:17pt;font-weight:700;white-space:pre-w=
rap;background-color:transparent;color:rgb(0,0,0)">Describe the problem</sp=
an><br></div><div dir=3D"auto"><div style=3D"font-size:inherit"><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:12pt;margin-bottom:12pt;font-size:=
inherit"><span style=3D"font-size:11pt;font-family:&quot;helvetica neue&quo=
t;;font-weight:400;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-variant-alternates:normal;font-variant-numeric:normal=
;font-variant-east-asian:normal;text-decoration:none;vertical-align:baselin=
e;white-space:pre-wrap;background-color:transparent;color:rgb(0,0,0)">Due t=
o licensing restrictions, AMD GPUs are currently limited to HDMI 2.0, which=
 has a maximum bandwidth of 18 Gbps. This limits users to lower max resolut=
ions and refresh rates even when the hardware is capable of HDMI 2.1. Displ=
ayPort works at full advertised capacity, but this doesn=E2=80=99t help use=
rs like me who are connecting to TVs that only have HDMI.</span></p><h2 dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:18pt;margin-bottom:4pt;font-s=
ize:inherit"><span style=3D"font-size:17pt;font-family:&quot;helvetica neue=
&quot;;font-weight:700;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-alternates:normal;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;text-decoration:none;vertical-align:bas=
eline;white-space:pre-wrap;background-color:transparent;color:rgb(0,0,0)">D=
escribe the new feature behavior</span></h2><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-top:12pt;margin-bottom:12pt;font-size:inherit"><span style=
=3D"font-size:11pt;font-family:&quot;helvetica neue&quot;;font-weight:400;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-variant-alternates:normal;font-variant-numeric:normal;font-variant-east-a=
sian:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wr=
ap;background-color:transparent;color:rgb(0,0,0)">My idea involves implemen=
ting HDMI 2.1 FRL (Fixed Rate Link) support which will allow the GPU to tak=
e advantage of the full 48 Gbps bandwidth that HDMI 2.1 supports. My implem=
entation is based on adapting Intel=E2=80=99s implementation of FRL used in=
 the i915 driver in ARC GPUs.</span></p><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:12pt;margin-bottom:12pt;font-size:inherit"><span style=3D"=
font-size:11pt;font-family:&quot;helvetica neue&quot;;font-weight:400;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-va=
riant-alternates:normal;font-variant-numeric:normal;font-variant-east-asian=
:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap;b=
ackground-color:transparent;color:rgb(0,0,0)">Intel ARC GPU drivers previou=
sly relied on built-in DP to HDMI PCONs, but these were added at the dedica=
tion of the board vendor and not a mandatory part of the chipset. Intel suc=
cessfully added native HDMI 2.1 FRL support to their open source driver by =
repurposing the TMDS clock lane for FRL, which enabled the full 48 Gbps ban=
dwidth. This implementation was merged into the mainline kernel in late 202=
2 and appears to somehow navigated the HDMI Forum licensing restrictions th=
at currently limit AMD=E2=80=99s drivers.</span></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:12pt;margin-bottom:12pt;font-size:inherit"><sp=
an style=3D"font-size:11pt;font-family:&quot;helvetica neue&quot;;font-weig=
ht:400;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-variant-alternates:normal;font-variant-numeric:normal;font-varian=
t-east-asian:normal;text-decoration:none;vertical-align:baseline;white-spac=
e:pre-wrap;background-color:transparent;color:rgb(0,0,0)">Here is the relev=
ant mailing list discussion: </span><a href=3D"https://lists.freedesktop.or=
g/archives/intel-gfx/2022-November/311389.html" style=3D"text-decoration:no=
ne"><span style=3D"font-size:11pt;font-family:&quot;helvetica neue&quot;;fo=
nt-weight:400;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-alternates:normal;font-variant-numeric:normal;font=
-variant-east-asian:normal;text-decoration:underline;vertical-align:baselin=
e;white-space:pre-wrap;background-color:transparent;color:rgb(0,0,0)">https=
://lists.freedesktop.org/archives/intel-gfx/2022-November/311389.html</span=
></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;margin-bo=
ttom:12pt;font-size:inherit"><span style=3D"font-size:11pt;font-family:&quo=
t;helvetica neue&quot;;font-weight:400;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-variant-alternates:normal;font-va=
riant-numeric:normal;font-variant-east-asian:normal;text-decoration:none;ve=
rtical-align:baseline;white-space:pre-wrap;background-color:transparent;col=
or:rgb(0,0,0)">The expected behavior would result in AMD GPUs with HDMI 2.1=
 hardware capabilities to be able to negotiate FRL mode with compatible HDM=
I 2.1 displays. This would give users access to 48 Gbps bandwidth over HDMI=
, enabling higher max resolution an refresh rates such as 4k@144Hz and 8k@6=
0Hz.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;mar=
gin-bottom:12pt;font-size:inherit"><span style=3D"font-size:11pt;font-famil=
y:&quot;helvetica neue&quot;;font-weight:400;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-variant-alternates:normal;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap;background-color:transpare=
nt;color:rgb(0,0,0)">This will NOT enable the full 2.1 spec, however it wil=
l provide the bandwidth 2.1 allows for (which I believe is the most importa=
nt benefit).</span></p><h2 dir=3D"ltr" style=3D"line-height:1.38;margin-top=
:18pt;margin-bottom:4pt;font-size:inherit"><span style=3D"font-size:17pt;fo=
nt-family:&quot;helvetica neue&quot;;font-weight:700;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-variant-alternates:=
normal;font-variant-numeric:normal;font-variant-east-asian:normal;text-deco=
ration:none;vertical-align:baseline;white-space:pre-wrap;background-color:t=
ransparent;color:rgb(0,0,0)">Describe the target user/application</span></h=
2><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;margin-bottom:12=
pt;font-size:inherit"><span style=3D"font-size:11pt;font-family:&quot;helve=
tica neue&quot;;font-weight:400;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-variant-alternates:normal;font-variant-n=
umeric:normal;font-variant-east-asian:normal;text-decoration:none;vertical-=
align:baseline;white-space:pre-wrap;background-color:transparent;color:rgb(=
0,0,0)">The target user is anyone with an AMD GPU connecting to an HDMI TV =
or monitor. Just for one, Linux gamers would gravely benefit from this as m=
ax refresh rates are greatly limited by HDMI.</span></p><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:12pt;margin-bottom:12pt;font-size:inherit"=
><span style=3D"font-size:11pt;font-family:&quot;helvetica neue&quot;;font-=
weight:400;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-alternates:normal;font-variant-numeric:normal;font-va=
riant-east-asian:normal;text-decoration:none;vertical-align:baseline;white-=
space:pre-wrap;background-color:transparent;color:rgb(0,0,0)">The existing =
userspace (compositors, DEs, etc.) should be able to remain untouched. The =
kernel would simply expose higher max resolutions and refresh rates through=
 the standard DRM interface. This is modeled after how the Intel implementa=
tion works, so userspace applications wouldn=E2=80=99t need to know what mo=
de they=E2=80=99re using, they just see the available modes exposed by the =
kernel. I wouldn=E2=80=99t imagine this feature would break any existing us=
erspace applications given that it only expands the available display modes=
 when 2.1 compatible hardware is detected.</span></p><h2 dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:18pt;margin-bottom:4pt;font-size:inherit"><=
span style=3D"font-size:17pt;font-family:&quot;helvetica neue&quot;;font-we=
ight:700;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-variant-alternates:normal;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;text-decoration:none;vertical-align:baseline;white-sp=
ace:pre-wrap;background-color:transparent;color:rgb(0,0,0)">How do you plan=
 to validate this feature</span></h2><p dir=3D"ltr" style=3D"line-height:1.=
38;margin-top:12pt;margin-bottom:12pt;font-size:inherit"><span style=3D"fon=
t-size:11pt;font-family:&quot;helvetica neue&quot;;font-weight:400;font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-varia=
nt-alternates:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap;back=
ground-color:transparent;color:rgb(0,0,0)">I am NOT a developer and lack th=
e programming knowledge to test and implement this feature myself. I am pro=
posing this concept based on reading on Intel=E2=80=99s successful implemen=
tation, hoping that someone with the ability can validate its feasibility o=
n AMD hardware.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:12pt;margin-bottom:12pt;font-size:inherit"><span style=3D"font-size:11pt=
;font-family:&quot;helvetica neue&quot;;font-weight:400;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-variant-alternat=
es:normal;font-variant-numeric:normal;font-variant-east-asian:normal;text-d=
ecoration:none;vertical-align:baseline;white-space:pre-wrap;background-colo=
r:transparent;color:rgb(0,0,0)">I=E2=80=99d imagine it could be validated b=
y testing with various HDMI 2.1 displays and verifying that 4k@144Hz works =
correctly. Backwards compatibility with 2.0 and earlier displays should be =
tested to confirm they still work without FRL. Although I don=E2=80=99t thi=
nk it would be an issue, composites should be tested to make sure they work=
 without modification. Display mode switching and hot plugging should also =
be tested.</span></p><h2 dir=3D"ltr" style=3D"line-height:1.38;margin-top:1=
8pt;margin-bottom:4pt;font-size:inherit"><span style=3D"font-size:17pt;font=
-family:&quot;helvetica neue&quot;;font-weight:700;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-variant-alternates:no=
rmal;font-variant-numeric:normal;font-variant-east-asian:normal;text-decora=
tion:none;vertical-align:baseline;white-space:pre-wrap;background-color:tra=
nsparent;color:rgb(0,0,0)">Business case</span></h2><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:12pt;margin-bottom:12pt;font-size:inherit"><sp=
an style=3D"font-size:11pt;font-family:&quot;helvetica neue&quot;;font-weig=
ht:400;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-variant-alternates:normal;font-variant-numeric:normal;font-varian=
t-east-asian:normal;text-decoration:none;vertical-align:baseline;white-spac=
e:pre-wrap;background-color:transparent;color:rgb(0,0,0)">This feature woul=
d eliminate a major limitation for Linux users with AMD GPUs who want to us=
e HDMI. Given the emerging Linux gaming market, this would be a major step =
forward for devices such as the Steam machine, which are marketed as living=
-room style gaming consoles. Furthermore, this would bring AMD GPUs on Linu=
x to closer parity with Nvidia, given that HDMI 2.1 is fully supported on N=
vidia=E2=80=99s proprietary Linux driver. This would GREATLY help AMD=E2=80=
=99s competitive position in the Linux gaming market.</span></p><h2 dir=3D"=
ltr" style=3D"line-height:1.38;margin-top:18pt;margin-bottom:4pt;font-size:=
inherit"><span style=3D"font-size:17pt;font-family:&quot;helvetica neue&quo=
t;;font-weight:700;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-variant-alternates:normal;font-variant-numeric:normal=
;font-variant-east-asian:normal;text-decoration:none;vertical-align:baselin=
e;white-space:pre-wrap;background-color:transparent;color:rgb(0,0,0)">Draft=
 of the userspace API</span></h2><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:12pt;margin-bottom:12pt;font-size:inherit"><span style=3D"font-si=
ze:11pt;font-family:&quot;helvetica neue&quot;;font-weight:400;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-variant-a=
lternates:normal;font-variant-numeric:normal;font-variant-east-asian:normal=
;text-decoration:none;vertical-align:baseline;white-space:pre-wrap;backgrou=
nd-color:transparent;color:rgb(0,0,0)">No new userspace APIs should be need=
ed. As stated earlier, the existing DRM interfaces would expose the higher =
bandwidth modes when an HDMI 2.1 FRL capable display is detected.</span></p=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;margin-bottom:12p=
t;font-size:inherit"><span style=3D"font-size:11pt;font-family:&quot;helvet=
ica neue&quot;;font-weight:400;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-variant-alternates:normal;font-variant-nu=
meric:normal;font-variant-east-asian:normal;text-decoration:none;vertical-a=
lign:baseline;white-space:pre-wrap;background-color:transparent;color:rgb(0=
,0,0)">Granted, I am fairly new to display drivers, and I have VERY limited=
 understanding, the two main things I am unsure about are</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;margin-bottom:12pt;font-=
size:inherit"><span style=3D"font-size:11pt;font-family:&quot;helvetica neu=
e&quot;;font-weight:400;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-variant-alternates:normal;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;text-decoration:none;vertical-align:ba=
seline;white-space:pre-wrap;background-color:transparent;color:rgb(0,0,0)">=
1. Do AMD GPUs with HDMI 2.1 hardware capability support an architecture th=
at would allow repurposing the TMDS clock channel for FRL in a similar way =
to Intel?</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12p=
t;margin-bottom:12pt;font-size:inherit"><span style=3D"font-size:11pt;font-=
family:&quot;helvetica neue&quot;;font-weight:400;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-variant-alternates:nor=
mal;font-variant-numeric:normal;font-variant-east-asian:normal;text-decorat=
ion:none;vertical-align:baseline;white-space:pre-wrap;background-color:tran=
sparent;color:rgb(0,0,0)">2. Are there non-hardware obstacles in AMD=E2=80=
=99s display controller architecture that would prevent adapting Intel=E2=
=80=99s implementation?</span></p><p dir=3D"ltr" style=3D"line-height:1.38;=
margin-top:12pt;margin-bottom:12pt;font-size:inherit"><span style=3D"font-s=
ize:11pt;font-family:&quot;helvetica neue&quot;;font-weight:400;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-variant-=
alternates:normal;font-variant-numeric:normal;font-variant-east-asian:norma=
l;text-decoration:none;vertical-align:baseline;white-space:pre-wrap;backgro=
und-color:transparent;color:rgb(0,0,0)">I, along with a major portion of th=
e Linux gaming community would very much appreciate it if someone can confi=
rm if this is viable.</span></p><br style=3D"font-size:inherit"><br style=
=3D"font-size:inherit"></div><br></div>

--000000000000757dd7064a20dc05--
