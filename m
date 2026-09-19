Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F87C982FB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F184110E46D;
	Mon, 21 Sep 2026 07:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ruszin.hu header.i=@ruszin.hu header.b="HaxJe7Cn";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Sat, 19 Sep 2026 12:51:29 UTC
Received: from smtp02.rackhost.hu (smtp02.rackhost.hu [91.227.138.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AA389220
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ruszin.hu;
 s=smtp0220241218; t=1789821963;
 bh=IEHaUojRDypGGnNHHU41dWz5cQroyqeLcaIzNQ3odAU=;
 h=Date:To:Cc:From:Subject:From;
 b=HaxJe7CnvvkJ+SZM2hNRA38VD972i2pZbmHOWxaGr6icvWkpWi3iLfjjc6uKchQGn
 P4wfwCtVpCVTSpbiL8aYUeGvDMgxQmQbvAj7bKWLeKVb0VjAM+LbFd2npMLX5JTk24
 MeKqgdq998j/kZkhCMmAaGaAm2oc6CSaoZjwKkKuTFPr5cM13K4gPGHSFZxUkr/qTR
 wPKC0zM54O2W2BQRLH1uDl3hkVJAbooLa1Nqkam7r7mJbJI/vbg3pgaCFJxF8HxFHg
 yQH+ePuUj4L3JOtZzmHPO3sN2GBrJ+AFAO8zDJrVGlrmkTSPK41BF2WN6Eqd06NCGK
 S0dLG4aAj7tBA==
Received: from [192.168.31.165] (h52-147.pool185-195.dyn.tolna.net
 [185.195.52.147])
 by smtp02.rackhost.hu (Postfix) with ESMTPSA id 4053C208A8;
 Sat, 19 Sep 2026 14:46:03 +0200 (CEST)
Content-Type: multipart/alternative;
 boundary="------------d58JeMZo5mbt8r2CwmSnrKEr"
Message-ID: <8acee140-5842-42dc-a37a-401725de2539@ruszin.hu>
Date: Sat, 19 Sep 2026 14:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, kenneth.feng@amd.com,
 Shyam-sundar.S-k@amd.com, mario.limonciello@amd.com
From: Daniel Ruszin <daniel@ruszin.hu>
Subject: [Krackan Point] ~3 W Linux/Windows panel-off power gap on ThinkPad
 T14 Gen 6 AMD (drm/amd#5863)
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:11:54 +0000
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

This is a multi-part message in MIME format.
--------------d58JeMZo5mbt8r2CwmSnrKEr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I opened drm/amd#5863 because I am seeing a fairly large and very 
reproducible power-consumption difference between Linux and Windows on 
my Lenovo ThinkPad T14 Gen 6 AMD (21QJ0057HV, Ryzen AI 7 PRO 350 / 
Krackan Point):

https://gitlab.freedesktop.org/drm/amd/-/issues/5863

The problem originally appeared with normal distribution kernels, 
including the Ubuntu 24.04 OEM kernel. I only started building custom 
kernels later, because I wanted to understand what was actually keeping 
the machine at this higher power level.

The short version of the measurements is:

|Screen on / idle Linux, clean multi-user.target: ~7.57 W Windows, 
normal desktop: ~5.60–5.78 W Internal display off Linux, panel verified 
powered off: ~5.27–5.45 W Windows, after natural screen-off: ~2.25–2.29 W|

On Linux I can now verify zero DRM streams, an inactive eDP link, 
backlight and panel power off, all HUBPs power-gated, and actual 
IPS1/IPS2 entries. Despite this, the machine still remains around 5.3–5.5 W.

During the investigation I also found what looks like a separate DCN35 
zero-stream idle-policy issue. With the existing logic, a connected eDP 
panel with zero streams does not satisfy the headless condition used to 
reallow idle optimizations.

An experimental change allows IPS2 to work, but the measured improvement 
is only around 0.1–0.2 W at APU level, so it does not seem to explain 
the main difference. Active RCG also remains at zero despite long 
idle-admission windows and quiescent HUBP state.

I am trying to be careful with the Windows comparison because this is a 
Modern Standby system. The PowerShell measurement process remained 
runnable with SYSTEM_REQUIRED and EXECUTION_REQUIRED requests, but 
Windows may still be reaching deeper runtime residency between samples. 
I therefore do not want to claim that the Linux and Windows states are 
internally identical.

One thing that makes me hesitant to blame the APU itself is that I have 
found reports from other Linux users with very similar hardware showing 
much better efficiency.

A ThinkPad T14s Gen 6 AMD owner with a Ryzen AI 7 350 / Radeon 860M 
reported roughly 2.1 W idle with the stock TuneD profiles and about 1.5 
W after further tuning. I also found a Framework 13 owner with the Ryzen 
AI 7 350 reporting roughly 10–12 hours of Linux battery life.

I realize these are anecdotal reports from different machines and 
configurations, so I am not treating them as controlled evidence. Still, 
they make me think the platform itself should be capable of considerably 
better Linux power efficiency.

For some practical context, my normal workload is software development 
and cybersecurity work: VSCodium, Signal/Discord, Spotify, a browser 
with several tabs, SSH terminals, and usually an RDP session.

With that workload, Linux tends to put the laptop around 10–11 W, while 
Windows is closer to ~7 W. Unfortunately, Windows does not provide the 
environment and tooling I normally need, which is why I have been trying 
quite hard to understand what Linux might be missing here.

At this point I am mostly trying to determine whether Linux is missing 
some Krackan-specific platform-power transition or initialization 
involving SMU/PMFW, DF/UMC, ACPI/platform coordination, or another 
parent power domain.

I may of course be looking in the wrong place, which is why guidance 
from people familiar with the platform would be extremely useful.

The GitLab issue contains the measurements and the investigation so far.

I have the machine available for testing and can build and test kernels 
quickly. If there is a diagnostic patch, additional telemetry, firmware 
trace, or a specific experiment that could help narrow this down, I 
would be very happy to run it.

Thanks for taking a look.

Regards,

-- 
_____________________________________
Daniel Ruszin
Software Engineer | Cybersecurity Practitioner | Accountant

Mobile:    +36 20 249-2996   (+Viber, Signal, Telegram, etc.)
E-mail:daniel@ruszin.hu

--------------d58JeMZo5mbt8r2CwmSnrKEr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,</p>
    <p>I opened drm/amd#5863 because I am seeing a fairly large and very
      reproducible power-consumption difference between Linux and
      Windows on my Lenovo ThinkPad T14 Gen 6 AMD (21QJ0057HV, Ryzen AI
      7 PRO 350 / Krackan Point):</p>
    <p><a href="https://gitlab.freedesktop.org/drm/amd/-/issues/5863"
        class="moz-txt-link-freetext">https://gitlab.freedesktop.org/drm/amd/-/issues/5863</a></p>
    <p>The problem originally appeared with normal distribution kernels,
      including the Ubuntu 24.04 OEM kernel. I only started building
      custom kernels later, because I wanted to understand what was
      actually keeping the machine at this higher power level.</p>
    <p>The short version of the measurements is:</p>
    <pre><code><font size="4">Screen on / idle
  Linux, clean multi-user.target:          ~7.57 W
  Windows, normal desktop:                 ~5.60–5.78 W

Internal display off
  Linux, panel verified powered off:       ~5.27–5.45 W
  Windows, after natural screen-off:       ~2.25–2.29 W</font></code></pre>
    <p>On Linux I can now verify zero DRM streams, an inactive eDP link,
      backlight and panel power off, all HUBPs power-gated, and actual
      IPS1/IPS2 entries. Despite this, the machine still remains around
      5.3–5.5 W.</p>
    <p>During the investigation I also found what looks like a separate
      DCN35 zero-stream idle-policy issue. With the existing logic, a
      connected eDP panel with zero streams does not satisfy the
      headless condition used to reallow idle optimizations.</p>
    <p>An experimental change allows IPS2 to work, but the measured
      improvement is only around 0.1–0.2 W at APU level, so it does not
      seem to explain the main difference. Active RCG also remains at
      zero despite long idle-admission windows and quiescent HUBP state.</p>
    <p>I am trying to be careful with the Windows comparison because
      this is a Modern Standby system. The PowerShell measurement
      process remained runnable with SYSTEM_REQUIRED and
      EXECUTION_REQUIRED requests, but Windows may still be reaching
      deeper runtime residency between samples. I therefore do not want
      to claim that the Linux and Windows states are internally
      identical.</p>
    <p>One thing that makes me hesitant to blame the APU itself is that
      I have found reports from other Linux users with very similar
      hardware showing much better efficiency.</p>
    <p>A ThinkPad T14s Gen 6 AMD owner with a Ryzen AI 7 350 / Radeon
      860M reported roughly 2.1 W idle with the stock TuneD profiles and
      about 1.5 W after further tuning. I also found a Framework 13
      owner with the Ryzen AI 7 350 reporting roughly 10–12 hours of
      Linux battery life.</p>
    <p>I realize these are anecdotal reports from different machines and
      configurations, so I am not treating them as controlled evidence.
      Still, they make me think the platform itself should be capable of
      considerably better Linux power efficiency.</p>
    <p>For some practical context, my normal workload is software
      development and cybersecurity work: VSCodium, Signal/Discord,
      Spotify, a browser with several tabs, SSH terminals, and usually
      an RDP session.</p>
    <p>With that workload, Linux tends to put the laptop around 10–11 W,
      while Windows is closer to ~7 W. Unfortunately, Windows does not
      provide the environment and tooling I normally need, which is why
      I have been trying quite hard to understand what Linux might be
      missing here.</p>
    <p>At this point I am mostly trying to determine whether Linux is
      missing some Krackan-specific platform-power transition or
      initialization involving SMU/PMFW, DF/UMC, ACPI/platform
      coordination, or another parent power domain.</p>
    <p>I may of course be looking in the wrong place, which is why
      guidance from people familiar with the platform would be extremely
      useful.</p>
    <p>The GitLab issue contains the measurements and the investigation
      so far.</p>
    <p>I have the machine available for testing and can build and test
      kernels quickly. If there is a diagnostic patch, additional
      telemetry, firmware trace, or a specific experiment that could
      help narrow this down, I would be very happy to run it.</p>
    <p>Thanks for taking a look.</p>
    <p>Regards,</p>
    <p></p>
    <pre class="moz-signature" cols="72">-- 
_____________________________________
Daniel Ruszin
Software Engineer | Cybersecurity Practitioner | Accountant

Mobile:    +36 20 249-2996   (+Viber, Signal, Telegram, etc.)
E-mail:    <a class="moz-txt-link-abbreviated" href="mailto:daniel@ruszin.hu">daniel@ruszin.hu</a></pre>
  </body>
</html>

--------------d58JeMZo5mbt8r2CwmSnrKEr--
