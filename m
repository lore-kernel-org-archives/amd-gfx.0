Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D09FF8865
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 14:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B61910E2AB;
	Mon, 27 Apr 2026 14:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s+BJuNrr";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E2B10E2AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 14:01:54 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso86006845e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777298512; x=1777903312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWToCEIaXUKWmzZCo1GynuIdV0WlRzUNUcIX47DR9ME=;
 b=s+BJuNrrj40N5hhIbQz7ltcXIaDIcEuM5CBDnz+zHMyp11VBkf2JP5xgD2tXuZmaGo
 LPRxZBPZY3jNNMum4xGwsc2MLMJTjLy8YuIwfwKImAJ2c9vKzO/aW2HxH0gHwoxJ5WhY
 daJqFSS7mkHhP0wHSAhz2qib0Nnqk5incfsDVBQoapjB7W8tTvwbav3JF532X2BTnnaL
 5juEUCdYwFScaTjcd5a2ky5Kqi6NU1+H5zwp8+EwBqsN8ex4lScpTBpdMYhc9vj7wiKN
 eqav/cyKpq/WVfKVp5hY4zCMgJQyLpkvYlZGoVIhDg3VT5YisuY2BTrWTCPnHyZBGvlT
 gxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777298512; x=1777903312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DWToCEIaXUKWmzZCo1GynuIdV0WlRzUNUcIX47DR9ME=;
 b=AUC1xzNc4/nyIm4STS5GPApBUEhtqQ/PCFVWfPVVrdcH6SNIR3G2/84gnsSoG4C+/g
 pQq6KQt/i20uU30mKkquZUD8uhT8C9+zRTGWwxIZcwSwqDXaILMvHNYmH0jvUWFw6WDv
 kiGOD43+Z2d+b6Q+GyyQDvzFD9nu8HlLRZB3VX9+VwI99pTVfXG+5/ypeQ5izKnI8xog
 73QIyxw1ZGgCdDxluseB8Gfc1g7S6tnQBXxmrAZOtjyfynP7hSl2RQyTvPnMbKnSSsDI
 fEQbCvn56cZr34cOLVNDWqwXbfUxLx9cofV2/PMSKkwbJA4La7dfPSVDGea/gSXXkf+v
 1ZPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GNhu+b/mJAgEnTFLtZz4T9XcLYvy6yfBOqP8KsZ2kHvyQBDoD0kTWNDA1ltHN8/lGKrbKVk7R@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaxZLnZfc8W+FcwdGsmPp93BBb+cSp1HLXsIKwb9WXjQOCdnIc
 fi50i+POZG6VPAcziK1Ms5cNOmF2Ga93/qzRSIjR/jAX/LgP8GNVchoF
X-Gm-Gg: AeBDietIx68YK/r+oCr3lzzRicK+vWCJQYZjTsabKr0Extjfw+v83IRaqly8kU02Uqc
 lr3zzt3+cy01JEwcBVnHSF+DlH0Yc+wR83bN6l8dn8XchgBum+Jvg8uCA/0aR7Qjc/iRAz99CCq
 Az1eiMtC8sk2p8rLKtiA+Q7+E5u4RvznpctWpPY7Xew/CjtPQcO4ZUCKncPRmvXKk3XoUy7Op9f
 P8adDgY8m74xhfGiipKpE2OsUzSIi1lS74FwSWKns4fmaZMgKdlENCvj2rtt0oAn1T0fZN+fJtR
 1gltWTgwJz6aiXGnmmI0bzrZH1BpFmKBIZX4K52aaHVf+fEUA9MlZXCUamqTn7zAHeus8d6E1Wq
 3PjgzngzpcXQj2rd+dIvbmCDjGipUl3saVvAM4dNHgJY3x2xn56xXeX0lph4+rumggwX5Q8qc/4
 TC5x4jMmU/kbnbHJ7QgUaLR6KipTClvYd6we8hJgCB4JAcCJTfmm1YF4rHD0bJB3iB95gbO9lnb
 6RaSINNxA==
X-Received: by 2002:a05:600c:4593:b0:488:c120:480a with SMTP id
 5b1f17b1804b1-488fb78bf05mr614809525e9.31.1777298512250; 
 Mon, 27 Apr 2026 07:01:52 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm1050495965e9.1.2026.04.27.07.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 07:01:51 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Brandon Taylor <br.ta.2818@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] amdgpu error -22 first encountered in kernel 6.19,
 not fixed in 7.0
Date: Mon, 27 Apr 2026 16:01:50 +0200
Message-ID: <2730559.vYhyI6sBWr@timur-hyperion>
In-Reply-To: <ed3171ef-eda8-4907-a35b-2e2b8185e574@leemhuis.info>
References: <CAMYTvdA+yCqU4_9mzMUkX_3S=myExKMBCyB88dYWCMwA1edsrw@mail.gmail.com>
 <6c48aff5-b6ee-40af-98f0-c26ded3095bc@leemhuis.info>
 <ed3171ef-eda8-4907-a35b-2e2b8185e574@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Thank you Thorsten for forwarding this to me, indeed I am working on improv=
ing=20
the driver for these GPUs. See my replies below.

On Monday, April 27, 2026 11:37:53=E2=80=AFAM Central European Summer Time =
Thorsten=20
Leemhuis wrote:
> [note: please remove Timo Lindfors when replying to this mail and
> include Timur Krist=C3=B3f =E2=80=93 sorry everyone and especially Timo, =
my mailers
> address book tricked me]
>=20
> On 4/27/26 11:35, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 4/26/26 01:22, Brandon Taylor wrote:
> >> I have an AMD Radeon R9 270X GPU (yes, I know it's old) which used to
> >> default to the `radeon` firmware
> >=20
> > FYI, as using the wrong terms can lead to confusion while dealing with
> > bugs: that's not a firmware, that's the driver (sometimes also called
> > kernel module)

=2D "radeon" is the old kernel driver for these GPUs that didn't support Vu=
lkan=20
and therefore was mostly useless for gaming.
=2D "amdgpu" is the new driver, which supports Vulkan and offers better per=
f,=20
this is the default since Linux 6.19.

I don't think this is a firmware issue.

> >=20
> >> on kernel versions up to and
> >> including 6.18. I could manually change this behavior to use the new
> >> `amdgpu` firmware by setting `radeon.si_support=3D0 amdgpu.si_support=
=3D1`
> >> as kernel parameters in the GRUB bootloader. Everything worked fine,
> >> and I was able to play my Windows games without any problems.
> >>=20
> >> That was, until kernel version 6.19 came out.>
> >> 6.19, from what I was able to Google, was supposed to have AMD GPUs to
> >> default to the new `amdgpu` firmware. Unfortunately, when I updated
> >> the kernel and rebooted, I got a black screen.
> >>=20
> >> Further Google searches led me to reboot, set `nomodeset` in the
> >> kernel parameters, switch to a TTY, login, and investigate the output
> >> of a `dmesg` command =E2=80=94 and what I saw ... Well, let's just say=
 it's
> >> the kind of thing that would make Linus go Chernobyl:
> >>=20
> >> `amdgpu: probe with driver amdgpu failed with error -22`
> >=20

I am sorry this happened and understand the frustration.

Please open an issue here:
https://gitlab.freedesktop.org/drm/amd/-/work_items/new
and upload your full dmesg log. Please ping me personally @Venemo on that=20
issue after you opened it so we can start investigating what is wrong there.

I got curious so I plugged in my R9 270X right now. I am typing this email =
on=20
a computer with a Radeon R9 270X using Linux 6.19.12 on Fedora 43 and it wo=
rks=20
fine. We are going to need to need more details in order to diagnose what t=
he=20
problem really is. We might ask you to test some proposed fixes, considerin=
g=20
that the issue doesn't happen on my R9 270X, I don't have a way to verify i=
t.

> >> Now, I hope to God that this email finds whoever is responsible for
> >> breaking this `amdgpu` firmware before the same thing happens to Linus
> >> via Fedora 44, and he goes berserk. I realize that's not a heck of a
> >> lot of time, but God only knows HOW many Linux users with AMD GPUs are
> >> pissed off by this kind of issue =E2=80=94 and I for one can only imag=
ine how
> >> Linus' reaction will compare when it happens to HIM!

I'm happy to help, there is no need for personal insults.

(Note that the issue clearly doesn't affect all AMD GPUs and it clearly doe=
sn't=20
even affect all R9 270X GPUs.)

Thanks & best regards,
Timur



