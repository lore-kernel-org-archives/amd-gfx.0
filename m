Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF319D185F8
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933FB10E735;
	Thu,  8 Jan 2026 13:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="laVDJOxN";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765D310E736
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 13:45:24 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-122008d4dc0so40237c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 05:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767879924; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbpvhAFGdpB/zVH/GGH6+lBjsuJTr0g1HuSg7EyeJ0jBXgd6almVVe6/byd7I8OXqF
 JTApLK4xCaZpxvsUlXx3Z0ddLOL10e4aMnTcRKsB4qsKJo0L3AiCMP+MBkm5mfTS4GV+
 OXkWBvjLUGBOR5ApBOP/Yxp1yxcTjcfj9Luqa5hPHnlSJteSa4Us5wPTipxaifI2yekP
 M1lpUN++4so1hTLHgohtsSffNF0ChF2WQztM5ho5w3+uIYCz1zUn03Z5LlcDtvlrRUDk
 Xi37K/r5W+I4VO1B/9jv7pXI/F7kiJqdPIfzvMOer9JhsK31VFp6f7wIbcbbSztamrYJ
 8S4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5kQ2xUBja8BPoXZgKKixyqanUA0WqT9oPPSrbJ2WMqY=;
 fh=TyrN4UHeSRgv5JUkFpg7+Vh1rbFQQeIKCJoH2Uu7G48=;
 b=fZt1JzFJdY8aY03aYx/u3532J3g4kIYOe6WV69L4Y0+WDdTXGDAPcT8ErYPnCoTRdE
 Sw/zSCADXIp0uHLHWYtvfAx583wYJukj98ZQQx4AL21VCesIlL49WzY+1C9ljbqB0tG9
 3151A3DJzLx/VldM7tvE1r9kL0RhWZ0wg6upkTNTr2+uANIxgV5hTGfF8a49CK/3PiUI
 oNIaK4NkV1M1IfFVvNKLgjAAN1BWQCqyA06uNnHk3SWE1YbMPzq3sOtmh5S/dej+PwvX
 N4k/7+4UvWwVudAXOKD9YlhRtHlybc5JWqex8YlUj2FF52gwlCj9Eik7PBj4HQXZHuUn
 AHSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767879924; x=1768484724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kQ2xUBja8BPoXZgKKixyqanUA0WqT9oPPSrbJ2WMqY=;
 b=laVDJOxNi2I+YZMsIO2Ti4NB/zMl1fO+sCl2fqK/th/gB2wU1u4rnU6jE4vrx7l0Au
 FlLpRB7wTgYB1iXa368EK+6VmxkUf2x3gJwOV6BJK+D2KDVKxej6y8l1232cahGjPUso
 ixWs24x/UOwM6BvcsFZaJYsvMp0SbvWRh3gtBd0mk5leaYoFbNz59lysfOBXItl2LDg+
 YQUtZeEKsB1WvC/HFMRro5EYOvws0h1bjkCh3qQM7ldFz1JiRtqETr8zhFqbATHp1fEZ
 SCSSy8J0rvjx0GhUoFoby/E1TFjaG+/oeam+mGcvnjieOTj3cJJm6vxN67Wx4A8l/CRj
 QsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767879924; x=1768484724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5kQ2xUBja8BPoXZgKKixyqanUA0WqT9oPPSrbJ2WMqY=;
 b=cyYKuvN1IZ3Gtqw4glIMVqpF4O/a8KPPeplNHmyE7U92V9wEVsQ/KMw0dr+1rHPAs4
 BD+WD2lSbTGzNYEPeh20C7BijpA0KL3B2KVhJXBld2sfoa/7W6CoLVKgNlFNGRP2TkLm
 qtwi+ZZKD9ELfSEg1+ocnng3CW+bgPaQ3nHK/Sk2fUx/LmlpmxM05QrtMUjH+ceXfIk5
 YG8OHynWFvV9M3CWfYU89GZwXXHAPbGSeTgkj4zY6iQWAaZvy5en4HcVyS54gxiOitNz
 VO2n4s83BXYScWWiUoszVnc2dORiV9U2J6a6IwEddS0mUh1/D3HPaRsHnz75ebjbnNqD
 +SDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX72Ugv54JyuFuGxjbQl8qLCttOAVAsxFer501Mzkv3VAGrErobkwOkG/T5tHDj4r2anY4DRNPx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrltqyKMsKY2YDVTPIEa1MVXXvt04niti0fLVG250lLHBXKtKz
 xbajvja1HbBBeXfby8e+dtd/QTDt8sbtmOkdBQWE8s6/GI7eO/AMGZ84H7HjNO/Tkm8ybGijWgQ
 /hsZes5aQn5FpNSaM7BIdCcMBNgUWU8Y=
X-Gm-Gg: AY/fxX4odlHN9OtdLB05MbsFRt4QMQ3KltRQJczsVOICfdafg44D/jzwD1swV7O+CAh
 EXrxDB49bBZgEFLrevVeDUic5efdmIfaCb1iv8SSAqf7gddzMmv86ygfehHmPOd2O243kDmgnug
 oB7PMR6QumbD+gEa3c8ESKKQLPrur04H83nXN3/aFHRaX+8QJchVFDzufa5+ZfMG+HnEUQTaEbg
 rEtjBiRizQdG9NOwXm66UG2rqp8noh7PGqyVThvBOWPtOMXj7r9+MoE09dL2gslChExdVVbFbEG
 iVc47RE=
X-Google-Smtp-Source: AGHT+IEBdT/4NQPN1Q/dZKLpUk5ZjD5kfC8Qu4NKTxN7CASsd1b5HxOvqIf2jcUrrdSL7grjTpF/8/huDcpRGx09DGk=
X-Received: by 2002:a05:7022:30b:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-121f8b770a1mr2665225c88.7.1767879923526; Thu, 08 Jan 2026
 05:45:23 -0800 (PST)
MIME-Version: 1.0
References: <x22LVmFvTwDrklnrfzto0X8folnEtLitNgQKjJxtTH99P9Bplb8S28jJT74Eqd_9w3jfQepZ5Q62_bIw6DhpzG5iDiTboHr-8B8Ilx3Qjzg=@proton.me>
In-Reply-To: <x22LVmFvTwDrklnrfzto0X8folnEtLitNgQKjJxtTH99P9Bplb8S28jJT74Eqd_9w3jfQepZ5Q62_bIw6DhpzG5iDiTboHr-8B8Ilx3Qjzg=@proton.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 08:45:12 -0500
X-Gm-Features: AQt7F2r9b6T3KTqlzpOXr8acssEsjb91F3IbJYBGIxUXINPOAbbEyhP0aqPoATc
Message-ID: <CADnq5_OoZeFi-VeeMV4AMDxgt+__TmAiN6WE+m0hmYXtmSjx1Q@mail.gmail.com>
Subject: Re: External HDMI monitor fails to wake up from DPMS/consoleblank
 since kernel 6.18
To: alliancetrooper <alliancetrooper@proton.me>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Jan 7, 2026 at 5:42=E2=80=AFPM alliancetrooper
<alliancetrooper@proton.me> wrote:
>
> Hello.
>
> I am reporting a regression in the kernel. an external HDMI monitor fails=
 to wake up from a low-power state.
> The issue occurs both in the VT console (using consoleblank parameter) an=
d in the X.Org graphical session (using xset dpms force off).
> The internal laptop display resumes correctly. This problem was not prese=
nt in Linux kernel 6.17. It started occurring after updating to kernel 6.18=
.0.

Please file a ticket at:
https://gitlab.freedesktop.org/drm/amd/-/issues

Can you bisect?

Thanks,

Alex

> My Kernel: 6.18.3, built from vanilla sources in Gentoo. Display controll=
er: Advanced Micro Devices, Inc. [AMD/ATI] Strix [Radeon 880M / 890M] (rev =
c4).
>
> No messages in dmesg regarding this.
>
> Steps to Reproduce:
> 1.  Connect an external monitor via HDMI.
> 2.  Boot with the kernel parameter consoleblank=3D30.
> 3.  Wait 30 seconds for the screen to blank and some time (no more than 5=
 mins) additionally.
> 4.  Try to wake the display by pressing a key. The external monitor remai=
ns off, while the internal laptop display turns on.
> 5.  Also reproducible in X11/Xorg session using xset dpms force off. It i=
s also needed to spent some time in off state.
>
> Thank you.
