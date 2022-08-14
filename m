Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42440C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 07:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3539DB0D91;
	Mon, 15 Aug 2022 07:46:09 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2AC11B9DB
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Aug 2022 21:23:07 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id t22so5475724pjy.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Aug 2022 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc;
 bh=8fYJW0YsZezv+V5o+zeS6R7vePJpRsrRYCSuJghbotQ=;
 b=g7UhXuCxm6RXO+fQ1s13B/EoUHQG0ybIsM1zxmHCFF6nWoxxHwHqZM36x+XZdvd+Sc
 kr5NSNDwnjXf25hCw8jiQKrVlZOga00mGISQUCTVAD/b511QbDyQ/SclCUzI0b1HjVf/
 GMP/vjtOZw083WKcaQHkUOc7dqaAcJ+IaQVvRCg/bZTvmcKzHw1liDgan2OX7+FEuntB
 Lpa43nRWIhVIR6oTRIWYoI2E3iHB5IUo1gnqIp/B9X3FARbBjOh5J+rCSrayFqSKn547
 L/90zfWGCSvBYQJrsqVR8TfbYyec55Z+8rYa1xIgX0WAo+UOPIjz5Fz8GSZdmkYkn1Ex
 Pv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc;
 bh=8fYJW0YsZezv+V5o+zeS6R7vePJpRsrRYCSuJghbotQ=;
 b=ExqE+OCpImWzUYgoioHuXWdBVnBkm8RM4a9A5ZdcQ1Dm55sBo1q8ls6ik4stRY5Wup
 UQEd6OPG4MDvArk/1u57f7Bt4sGheOCbkVFU8LHImQpDl7u6+dE487QcygFbL89Hwc66
 0bGqdFyxaI7pMTlgCb7zjS/otrZlL0oYqyg1V2MCTM+7IBHssULMnFpjg87Rs8iYBv37
 OSAaxxodr0N2J0bFsqwhjO/wWfwnPK6tN+XXb3Q2VgIYpAGe9xURvg+0fKOeWyyXOtJ7
 oYxMz3KZoW0nG0sPb5kFY1xQr5zhgShC4sqh8UV+XQWwT9cT8Jov/h8ROGp9d0sTew8t
 AeUg==
X-Gm-Message-State: ACgBeo23+KZEUjOXB2zfIx1pMGh4vk1pnpay8QIxz9wewI9vZ+OTogRE
 PmyVK+x+hIe+w7Dq/XCad07AXz/uKpfEylZOxSp3Dwk9PiZO
X-Google-Smtp-Source: AA6agR570Av4I0m/M7ElD2+WkNe5yChgxwC+7Jf5a9L1rCDhBNMGgCLuxNaaFCt+hC95kpkKUvsE4BsEjD2u0v6wAO0=
X-Received: by 2002:a17:90b:2687:b0:1f7:362a:2d08 with SMTP id
 pl7-20020a17090b268700b001f7362a2d08mr14713056pjb.218.1660512187188; Sun, 14
 Aug 2022 14:23:07 -0700 (PDT)
MIME-Version: 1.0
From: Pratham Sharma <prathamsharmasv@gmail.com>
Date: Mon, 15 Aug 2022 02:52:56 +0530
Message-ID: <CAEVueCJXQTPsgUHFM-fyLeaP5GTXh+66Nd8aU2gFF3_uhyb5WA@mail.gmail.com>
Subject: [REQUEST] Unusable state of Laptop powered by AMD SmartShift
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000001008a805e63a1fe1"
X-Mailman-Approved-At: Mon, 15 Aug 2022 07:45:57 +0000
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

--0000000000001008a805e63a1fe1
Content-Type: text/plain; charset="UTF-8"

I come from
https://gitlab.freedesktop.org/drm/amd/-/issues/1707

I have a DELL G5 SE, it's a laptop specced with a Ryzen 5 4600H, a Renoir
iGPU driving the display and RX5600M for all GPU intensive tasks.
It's as good as it gets, all AMD powered, it doesn't have a dGPU from the
You Know Who so I expected good open source driver support in the Linux
kernel.

But sadly, the state of the laptop is that it's not usable for daily
routine tasks like even opening a browser, maybe fire up Spotify or open
Steam/Lutris.
You would probably be guessing, I'm a novice who's filling the mailing list
with the issues which need to be reported on freedesktop's amd drm GitLab
but
the thing is it has been in the Issues for almost an year, here
<https://gitlab.freedesktop.org/drm/amd/-/issues/1707> it is. People on
that issue thread like me have spent months watching and reporting logs on
different kernel releases,
there's a person who has spent weeks on bisecting but we've got almost no
developer's attention. I would post logs here too but I think you'll find
enough logs on that Issues thread.

If you need logs here too, please let me know, I'll post them.

So I just want to say that it's like playing a Russian Roulette, everytime
I open/close a Electron/Chromium application like a browser Brave, or
Spotify or VS Code,
a gaming client like Steam/Lutris, there's a chance that it make the system
freeze in which even trying to switch to another TTY doesn't work and the
only option is
a reset with Magic SYSRQ keys. This has made my laptop unusable, I have had
my laptop crash in front of my friends in class by just trying to open VS
Code
believe me that's not a good look.

Could we finally get some dev attention on that GitLab thread and get a
patch out for this machine(there are other machines too with similar specs
reporting this issue on GitLab)?

--0000000000001008a805e63a1fe1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I come from<br></div><div><a href=3D"https://gitlab.f=
reedesktop.org/drm/amd/-/issues/1707">https://gitlab.freedesktop.org/drm/am=
d/-/issues/1707</a><br></div><div><br></div><div>I have a DELL G5 SE, it&#3=
9;s a laptop specced with a Ryzen 5 4600H, a Renoir iGPU driving the displa=
y and RX5600M for all GPU intensive tasks.</div><div>It&#39;s as good as it=
 gets, all AMD powered, it doesn&#39;t have a dGPU from the You Know Who so=
 I expected good open source driver support in the Linux kernel.</div><div>=
<br></div><div>But sadly, the state of the laptop is that it&#39;s not usab=
le for daily routine tasks like even opening a browser, maybe fire up Spoti=
fy or open Steam/Lutris.</div><div>You would probably be guessing, I&#39;m =
a novice who&#39;s filling the mailing list with the issues which need to b=
e reported on freedesktop&#39;s amd drm GitLab but</div><div>the thing is i=
t has been in the Issues for almost an year, <a href=3D"https://gitlab.free=
desktop.org/drm/amd/-/issues/1707">here</a> it is. People on that issue thr=
ead like me have spent months watching and reporting logs on different kern=
el releases,</div><div>there&#39;s a person who has spent weeks on bisectin=
g but we&#39;ve got almost no developer&#39;s attention. I would post logs =
here too but I think you&#39;ll find enough logs on that Issues thread.</di=
v><div><br></div><div>If you need logs here too, please let me know, I&#39;=
ll post them.</div><div><br></div><div>So I just want to say that it&#39;s =
like playing a Russian Roulette, everytime I open/close a Electron/Chromium=
 application like a browser Brave, or Spotify or VS Code,</div><div>a gamin=
g client like Steam/Lutris, there&#39;s a chance that it make the system fr=
eeze in which even trying to switch to another TTY doesn&#39;t work and the=
 only option is</div><div>a reset with Magic SYSRQ keys. This has made my l=
aptop unusable, I have had my laptop crash in front of my friends in class =
by just trying to open VS Code</div><div>believe me that&#39;s not a good l=
ook.</div><div><br></div><div>Could we finally get some dev attention on th=
at GitLab thread and get a patch out for this machine(there are other machi=
nes too with similar specs reporting this issue on GitLab)?<br></div></div>

--0000000000001008a805e63a1fe1--
