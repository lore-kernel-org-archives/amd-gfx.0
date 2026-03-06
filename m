Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157ADF01835
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 14:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F9610ED41;
	Fri,  6 Mar 2026 14:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Upy2xTSI";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E988310E3C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 08:48:35 +0000 (UTC)
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fS0Rt13H7z3yXr;
 Fri,  6 Mar 2026 09:48:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1772786906;
 bh=iYLAWAqdJS4uUCqz0qr0sNxQmBz2NGF4XjSuVdETqJA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Upy2xTSIGa9ztyLpv1LwNlaHFB5DRcFXGhOULIAz4kFQBb91QBa1jt0NguMvaPdZv
 Q4y2M9ZzWx/05xh1ZFbINr/jWLpfWN++oktBam3sqXVm6cv/wgMIHvDqHY2zOmbp/I
 tSGYhACxP0DQy21qPNLkL96FC/nHzD0TJC79fKinDotaN4V/mcelBIsdi580c894Y5
 yOv1m6QzdLlqkM5v0MxWCsZmyVOBUGfqs2wxkigStO4CWcWGtWUv2QfiqHhwnJ6Wos
 QQGW+wuHJXza00jqwJGx1m9HjL4y7IMMLG7WU5RCfecpzAX85ADkAZPrnSyQO6DHUH
 8hYtlUrPxP3KA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fS0Rt0Jcsz3yVW;
 Fri,  6 Mar 2026 09:48:26 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fS0Rr53PXz8sgW;
 Fri,  6 Mar 2026 09:48:24 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id D60D0633EC;
 Fri,  6 Mar 2026 09:48:23 +0100 (CET)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c78f97a1-a9ba-4d63-a22b-f9ff8f240ba0@leemhuis.info>
Date: Fri, 6 Mar 2026 09:48:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] AMD Radeon R9 380 (Tonga) suspend resume regression:
 black screen / no EDID on kernel 6.13+ (ref: Ubuntu #2142389)
To: Alex Huang <huangalex409@gmail.com>,
 Danilo Machado <danilomachado2002@hotmail.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
References: <CPUPR80MB65833AEF510B7D067FCCA46DA370A@CPUPR80MB6583.lamprd80.prod.outlook.com>
 <CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177278690418.1187128.18288302240743858911@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D60D0633EC
X-NC-CID: M3fH9NEvobomdOjuclzFzxB084ZUP0HfrkS5N12Sb4vLbIe2qGw=
X-Mailman-Approved-At: Fri, 06 Mar 2026 14:00:04 +0000
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

On 3/3/26 15:26, Alex Huang wrote:
> On Tue, Mar 3, 2026 at 7:30 AM Danilo Machado
> <danilomachado2002@hotmail.com <mailto:danilomachado2002@hotmail.com>>
> wrote:
> 
>     To: freedesktop@lists.freedesktop.org
>     <mailto:freedesktop@lists.freedesktop.org>
>     Subject: [Bug report] AMD Radeon R9 380 (Tonga) suspend resume
>     regression: black screen / no EDID on kernel 6.13+ (ref: Ubuntu
>     #2142389)
> 
>     Dear AMDGPU/DRM maintainers,
> 
>     I'm reporting a suspend/resume regression affecting the Radeon R9
>     380 (Tonga / GCN 3rd gen) on recent kernels (6.13+), observed on
>     Ubuntu 24.10 derivatives (Zorin OS 18) with kernel 6.17.0-14-generic.

That is a vendor kernel that contains quite a few modifications that
might contain the bug you are seeing; hence please either report the
problem to your vendor or check with the latest vanilla mainline kernel
(e.g. 7.0-rc2; latest 6.19.y might also suffice, but better test
7.0-rc). The latter is needed anyway, as the bug might already be fixed.
If the problem still happens there, you as mentioned by Alex most likely
need to do a bisection to get some tracking on this.

Ciao, Thorsten

> A nontrivial amount of pm/EDID changes occurred between 6.12 and 6.13,
> are you able to bisect the kernel between those two revisions? Even
> narrowing it down to a release candidate should be useful.
> 
> #regzbot introduced: v5.12..v5.13
> #regzbot from: Danilo Machado <danilomachado2002@hotmail.com
> <mailto:danilomachado2002@hotmail.com>>
> #regzbot monitor: https://bugs.launchpad.net/ubuntu/+source/linux/
> +bug/2142389 <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389>
> 
> Best,
> Alex H
> 
> 
>     **Hardware:**
>     - GPU: AMD Radeon R9 380 Series (Tonga XT, Tonga)
>     - Motherboard: Gigabyte B450 AORUS PRO WIFI (BIOS F66)
>     - CPU: AMD Ryzen 5 5500
>     - Connection: Direct HDMI
>     - Display server: X11
>     - Power state: Deep sleep (S3)
> 
>     **Symptoms:**
>     - After suspend (first cycle often works; subsequent cycles fail
>     consistently):
>       - System wakes (fans/LEDs active), but display shows black
>     screen / no signal ("HDMI Out of Range" on monitor).
>       - EDID read/handshake fails → no video output recovered.
>       - Keyboard/mouse may respond briefly, but desktop freezes → hard
>     reboot required.
>     - Logs show:
>       [drm] *ERROR* HDMI-A-1: probed a monitor but no|invalid EDID
>       [drm] *ERROR* No EDID read.
> 
> 
>     **Kernels tested:**
>     - Broken: 6.13.12 → 6.17.0-14 (regression starts between 6.12 and 6.13)
>     - Stable: 6.12.74 (LTS) – suspend/resume fully reliable, no EDID errors
> 
>     **GRUB parameters used:**
>     quiet splash amdgpu.si_support=1 radeon.si_support=0 amdgpu.runpm=0
>     amdgpu.dc=0
> 
>     **Reference:**
>     This matches Ubuntu bug #2142389: https://bugs.launchpad.net/ubuntu/
>     +source/linux/+bug/2142389 <https://bugs.launchpad.net/ubuntu/
>     +source/linux/+bug/2142389>
>     (Reported by me on Launchpad; includes full dmesg logs and attachments)
> 
>     The issue appears to be in the DRM/DC layer (HDMI EDID re-detection
>     during multi-cycle suspend/resume on Tonga). Downgrading to 6.12.74
>     resolves it completely.
> 
>     Is this a known regression? Any patches or additional debug info
>     needed from my side?
> 
>     Happy to test patches, provide more logs (dmesg, journalctl -b -u
>     systemd-suspend, full amdgpu debug), or try kernel builds.
> 
>     Thanks for your attention and work on amdgpu!
> 
> 
>     Tested kernels:
> 
>     6.12.74 — stable, HDMI resume works
>     6.13.12 — first resume OK, second suspend fails
>     6.14.x — HDMI issues
>     6.17.0-14 — frequent resume black screen
> 
>     Best regards,  
>     Danilo Machado  
>     Minas Gerais, Brazil  
>     (Original reporter of Ubuntu bug #2142389)
> 

