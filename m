Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17BC624DD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4925D10F444;
	Thu,  3 Sep 2026 07:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="N0VNPKTJ";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A5310F27D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 15:00:00 +0000 (UTC)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hZm9K5Jz3z92ZW;
 Wed,  2 Sep 2026 16:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1788361189;
 bh=5FH9gwbLH/+HekiYc9O2WRdCLDx2Be6JSTftBW/ulR8=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
 b=N0VNPKTJah5wd2zNIeGlFexjZQUcWDML3m1niSebZvvakwFfXrqgHCh2/wouWXv7A
 km1pPBrCuhnwmuCFqGeyw9bpvJ8B8dUZhBxL4IPMOgF6+b5U5PVzGBygOW1nSX0BH+
 mMVKulggrnjYrtXTJcukHE2UtMgiIHHy5K93/+3us555XULskAtYa288BhNvEJBlva
 bDvJRkqVSqjN9fWlN6Vvr/iYTF2D7/sdBE6Ogf2Q6UH+pK7O20N6qVjRq2vS4GpCdO
 Aesjev6+y8dn9LWi7rbqJGMJVZoHy5Wvr3IC37MlmKscZCdTVJDKWRBg6OHShvgTYr
 yyyiRdqk01bcA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hZm9K4cWyz7xCl;
 Wed,  2 Sep 2026 16:59:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hZm9H49jzz8tYC;
 Wed,  2 Sep 2026 16:59:47 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id D508F5F98A;
 Wed,  2 Sep 2026 16:59:46 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ae44a77f-0272-4d87-ae62-efa612939735@leemhuis.info>
Date: Wed, 2 Sep 2026 16:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RX470 - polaris10] Wrong window titlebar gradient after kernel
 update 7.1 to 7.2
To: =?UTF-8?Q?Stefan_K=C3=BChn?= <familiekuehn@posteo.de>,
 amd-gfx@lists.freedesktop.org
References: <4c48b807-cd79-433d-b5ee-76bfe72a993e@posteo.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <4c48b807-cd79-433d-b5ee-76bfe72a993e@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178836118711.256994.5369702100575139966@mxe9fb.netcup.net>
X-NC-CID: jjT6IjHoeQo3xeXL+hbtZ3ZavFJWmHxS9krrB19ZoMjDp3W2WnE=
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

On 8/31/26 22:12, Stefan Kühn wrote:
> recently I updated from a self compiled Linux 7.1(.8) to 7.2(.0) and
> spotted a possible regression in the amdgpu driver.

Thx for the report. There is still a chance that someone might help your
here, but unless that happens soon I suggest you submit this to the
central place for amdgpu bug report, which is
https://gitlab.freedesktop.org/drm/amd/-/work_items/ -- ideally after
checking for existing reports there. Afterwards please drop a link to
the report here in a reply.

Ciao, Thorsten

> [HARDWARE/SOFTWARE INFO]
> 
> Operating System: KDE neon
> KDE Plasma Version: 6.7.4
> KDE Frameworks Version: 6.29.0
> Qt Version: 6.11.1
> Kernel Version: 7.2.0-va2635 (64-bit)
> Graphics Platform: Wayland
> OpenGL version: 4.6
> GLSL version: 4.60
> Mesa version: 25.2.8
> X server version: 1.24.1
> 
> Processors: 4 × Intel® Core™ i5-4590 CPU @ 3.30GHz
> Memory: 15.6 GiB of usable RAM
> Graphics Processor: AMD Radeon RX 470 Graphics
> Manufacturer: ASUS
> Product Name: All Series
> 
> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590]
> [1002:67df] (rev cf)
> 
> 
> [WHAT HAS HAPPENED]
> 
> On my KDE desktop I can see the window titlebar gradient is now wrong.
> The theme is "breeze bright" and instead of a smooth white to light gray
> transition there is a hard cut. It looks like bright tones are clipped
> too early to white. And in the opposite (when I check with a gradient
> graphix in GIMP) dark tones are too early cut to black. It reminds me of
> limited color space where you do not have the full 0-255 range for
> brightness.
> 
> A screenshot from the titlebar viewed on another machine looks fine.
> 
> 
> [WHAT I HAVE DONE]
> 
> I collected some files with debug output from the kernel's debugfs, its
> dmesg and from modetest. For version 7.1 and 7.2, the latter was
> compiled with "make oldconfig".
> 
> The display is connected with HDMI (HDMI-A-2). DVI is unaffected.
> 
> 
> [FOUND WORKAROUND]
> 
> Using DVI cable OR changing "kwinoutputconfig.json". The property
> "rgbRange" from "Automatic" to "Limited". On Linux 7.2 the gradient is
> fine again. On Linux 7.1 both options are okay. Which I find strange?
> Should "Limited" on 7.1 not be "broken on purpose"?
> 
> 
> [AI OPINION]
> 
> For completeness: I can made the OpenAI chat available. It points to the
> "HDMI state" and wants me to check "broadcast_rgb -> output_color_space
> -> qs_bit -> Q0_Q1".
> 
> 
> Please let me know if I can be of any further help.
> 
> 
> Regards
> Stefan Kühn

