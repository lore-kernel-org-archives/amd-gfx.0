Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E075BC7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 08:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC7210EB04;
	Thu,  6 Apr 2023 08:04:51 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E53E10EAEA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 06:25:01 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id h3so10441753qtu.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Apr 2023 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680762300;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LrETg5K1WxrjG92hDMvBvAcI0yVnKFBZ3mX9X7d+ci4=;
 b=QFyBcAS11O8A2DVvrGeXadYzl5ZMEviq0EamRBG4lWeevXM/Ndhcyj5IvDfZbOwJ7S
 iBzQOUj/i0aUf7ubMb26m3GyvDw4caR2wushhZz20B3ss8lHw8l2+HA8S0ptIpCAYEDN
 /990uZiKl0D6RhyituBJTfW+bzqjVkR4lbPs25nVjvi0dMsZ0wk+ZaHc+QVVb5tAel67
 5a7bEd6hRULGELFzn6EpSktrI260nHvRjzun/0CVdQ0Di5tmKvQ9KgeKC/yQeMnul4zX
 FDniSNgRV1rg2JEexjwuW9m9fyE0LgvLR1tXbN9aT/JJeBlGJ4ows9LyT6Xp1GsEw468
 uXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680762300;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrETg5K1WxrjG92hDMvBvAcI0yVnKFBZ3mX9X7d+ci4=;
 b=G5IqXho7wm9IyvaJ+Ny7IOFBY8jQ3WM0qmxaNarnutWhgoaMeI55rIAG8LMjRov7gV
 itWBfosQu9w5rJitgMAkMQ7YFCLHxOmsM+Hf+DPi0j0koIBePSsgwxfgsOHque3IR3Oe
 WyCB/w7AaIrgbjz2FB03X4L+FBMmHnUgJpAzi6L5VOSqzy3hib0OfPbUntUmEIIYoiJc
 3r+y301Eq3vRck4MLQKD2rGD8VgLRO8JB3uemum/5M4fD4ybKpwfJ/f6NLL3DUMSDH8K
 zGwbQjsR05Tc5uvmdBWiaJ6USKQEb7wTtm4575oMJ0DcXE0kUp0iqH3nVatKlYPY9l4x
 LjGw==
X-Gm-Message-State: AAQBX9eoUTSg12JD3Lw6GIMRxTFN11POttGkd8Y8aUOGZLxYBes/zE8q
 NrfKM/pIx4GR63wn4HdiDStcGZn9FsS2e3n35ZDQksltisE=
X-Google-Smtp-Source: AKy350Y++iPbM0ghSygi/TB+JUTcOMxk2eQJELQT0aYFbyrsxBO8tIJWZP+AQKGi/2smkYkvaUhY5YPbjGl7UJKNy/Q=
X-Received: by 2002:a05:622a:1c8:b0:3d9:650a:7a9f with SMTP id
 t8-20020a05622a01c800b003d9650a7a9fmr2158444qtw.3.1680762300043; Wed, 05 Apr
 2023 23:25:00 -0700 (PDT)
MIME-Version: 1.0
From: __- -__ <isapgswell@gmail.com>
Date: Thu, 6 Apr 2023 03:24:44 -0300
Message-ID: <CAN9WMdMkC+DTKE=SC2HX7yP3dh0Hoy-i55UtNv1wtkHMcv8d4w@mail.gmail.com>
Subject: [INNOVATION] AMD nvme (pcie 4.0)
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000d893ca05f8a4f7cc"
X-Mailman-Approved-At: Thu, 06 Apr 2023 08:04:50 +0000
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

--000000000000d893ca05f8a4f7cc
Content-Type: text/plain; charset="UTF-8"

Hi,

I have read on the internet that asrock launched a nvme pcie gpu.

On Linux distros we dont have support to graphics 3D and stream processors
(opencl) simultaneously like windows 10/11.

My notebook have two nvme slots.

So, why not a amd's dedicated nvme vram (video ram) devices?

It would represent a high improvement to VR (virtual reality), AR
(augmented reality), deep learning, machine learning, IA (artificial
inteligence [constraints]), stereo 3D, real time and more realistic gaming
8k/16k/+k, etc

With this we can even implement tickless gpu/graphics/apis/drivers/kernel.

Valve's source 2 engine now have this feature (tickless [sub-ticks]).
That's wonderfull!

What about tickless X11(xorg)/Wayland and all Linux graphics stack. No more
render delays nor input lag ;)

A amd's dedicated nvme ( pcie 4.0 x8 or x16 ) nvram :D

APU + dGPU with an optional dedicated nvme (nvram) for both (opencl rules)

What about opencl thundercache, turbo opencl or opencl boost? Why not all
of this mixed stages on-demand?

We dont have yet a known way to "overclock" opencl by gpu exclusively.
Maybe AMD software's can do the job. Less or no race condition anymore.

Intel has dedicated desktop gpus, its oficial, but i dont know intel's
roadmap for mobile. AMD has the oportunity to make notebooks powerful like
workstations and desktops.

Dont forget this "new" device run coldest as possible. Heat sink, thermal
pads, etc.

Valve's steam deck have made progress about that.

Apple has a macbook air with no active cooler system.

Think about it ...

Thank you!

Luiz

--000000000000d893ca05f8a4f7cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">I have re=
ad on the internet that asrock launched a nvme pcie gpu.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">On Linux distros we dont have support to g=
raphics 3D and stream processors (opencl) simultaneously like windows 10/11=
.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">My notebook have=
 two nvme slots.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">S=
o, why not a amd&#39;s dedicated nvme vram (video ram) devices?</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">It
 would represent a high improvement to VR (virtual reality), AR=20
(augmented reality), deep learning, machine learning, IA (artificial=20
inteligence [constraints]), stereo 3D, real time and=20
more realistic gaming 8k/16k/+k, etc</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">With this we can even implement tickless gpu/graphics/apis/dri=
vers/kernel.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Valve&#39;s=
 source 2 engine now have this feature (tickless [sub-ticks]). That&#39;s w=
onderfull!</div><div dir=3D"auto"><br></div><div dir=3D"auto">What about ti=
ckless X11(xorg)/Wayland and all Linux graphics stack. No more render delay=
s nor input lag ;)</div><div dir=3D"auto"><br></div><div dir=3D"auto">A amd=
&#39;s dedicated nvme ( pcie 4.0 x8 or x16 ) nvram :D</div><div dir=3D"auto=
"><br></div><div>APU + dGPU with an optional dedicated nvme (nvram) for bot=
h (opencl rules)<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Wha=
t about opencl thundercache, turbo opencl or opencl boost? Why not all of t=
his mixed stages on-demand?</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">We dont have yet a known way to &quot;overclock&quot; opencl by gpu exc=
lusively. Maybe AMD software&#39;s can do the job. Less or no race conditio=
n anymore.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Intel
 has dedicated desktop gpus, its oficial, but i dont know intel&#39;s=20
roadmap for mobile. AMD has the oportunity to make notebooks powerful=20
like workstations and desktops.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Dont forget this &quot;new&quot; device run coldest as possible. =
Heat sink, thermal pads, etc.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Valve&#39;s steam deck have made progress about that.</div><div dir=
=3D"auto"><br></div><div>Apple has a macbook air with no active cooler syst=
em.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Think about it .=
..</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you!</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Luiz</div><div class=3D"gmail-yj6q=
o"></div><div dir=3D"auto" class=3D"gmail-adL"><br></div><div dir=3D"auto" =
class=3D"gmail-adL"><br><br></div></div>

--000000000000d893ca05f8a4f7cc--
