Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3717ED185F9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0835910E726;
	Thu,  8 Jan 2026 13:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Car4j9yd";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2119010E649
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=rcre3mwyvnaire3ybtyde6wxoi.protonmail; t=1767807068; x=1768066268;
 bh=aPgxw0Gx8oH9qHdwoW5+x8cld6geW5HvabdWs74V2/A=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Car4j9ydkCcEz+f2rR1YzJdkpAS+kN+cGQjdRpoe2quptrpv7YMHcsKb2aRnw/qon
 hsolXghP6wF8zwHMGP6t2J60WuDVzL64eIM8yNE1gLipznM6+AEMotNv6GFPrSxI/x
 3FbIHpPtlhkJ/SXkGYmabnYIO/p/v3mmh15LA4sw4HJTsQBR7U6Fi0NH6bYBRrReo4
 2f+g4xCs8WC0vQNVGH/ReqsXEEBhU75p+se47eQ7GG8oCewHLdaB4d90wXCtgfHdbS
 UXHuoZMhbgqseib8FSosPsEEuA7N7sKapprvKY+uUr+VmgBaxQ/3/W+8O6v7PpOuok
 TTyCY1yEkpM3g==
Date: Wed, 07 Jan 2026 17:31:03 +0000
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From: alliancetrooper <alliancetrooper@proton.me>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: External HDMI monitor fails to wake up from DPMS/consoleblank since
 kernel 6.18
Message-ID: <zeo54utdQP5v8eYapWyEEqMIAIVyazyK360IARqaw91yEK75U_c7NHDmchrX_XG5irs3AJ9m-ytSXUXsS2Z4Awh1BzBR9HfwHW7a9e1uKgg=@proton.me>
Feedback-ID: 88488025:user:proton
X-Pm-Message-ID: b07ed1d920aee9a7ecf95fb2183cee72b7e55e42
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 Jan 2026 13:37:29 +0000
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

Hello.

I am reporting a regression in the kernel. an external HDMI monitor fails t=
o wake up from a low-power state.
The issue occurs both in the VT console (using `consoleblank` parameter) an=
d in the X.Org graphical session (using `xset dpms force off`).
The internal laptop display resumes correctly. This problem was not present=
 in Linux kernel 6.17. It started occurring after updating to kernel 6.18.0=
.
My Kernel: 6.18.3, built from vanilla sources in Gentoo. Display controller=
: Advanced Micro Devices, Inc. [AMD/ATI] Strix [Radeon 880M / 890M] (rev c4=
).

No messages in dmesg regarding this.

Steps to Reproduce:
1. =C2=A0Connect an external monitor via HDMI.
2. =C2=A0Boot with the kernel parameter `consoleblank=3D30`.
3. =C2=A0Wait 30 seconds for the screen to blank and some time (no more tha=
n 5 mins) additionally.
4. =C2=A0Try to wake the display by pressing a key. The external monitor re=
mains off, while the internal laptop display turns on.
5. =C2=A0Also reproducible in X11/Xorg session using `xset dpms force off`.=
 It is also needed to spent some time in off state.

Thank you.
