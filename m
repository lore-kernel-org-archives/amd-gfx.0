Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE404C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 07:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A76110E2FE;
	Wed, 28 Sep 2022 07:36:17 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716F310E29D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 07:01:36 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1odR4Y-0003a8-C9; Wed, 28 Sep 2022 09:01:34 +0200
Message-ID: <2e35ddaf-92c8-7289-31b0-4b85429a001a@leemhuis.info>
Date: Wed, 28 Sep 2022 09:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] drm/amd/display: Prevent OTG shutdown during PSR SU
Content-Language: en-US, de-DE
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220927231339.187788-1-sunpeng.li@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220927231339.187788-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1664348496;
 a39a0f27; 
X-HE-SMSGID: 1odR4Y-0003a8-C9
X-Mailman-Approved-At: Wed, 28 Sep 2022 07:36:14 +0000
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
 regressions@lists.linux.dev, git@augustwikerfors.se
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 28.09.22 01:13, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Enabling Z10 optimizations allows DMUB to disable the OTG during PSR
> link-off. This theoretically saves power by putting more of the display
> hardware to sleep. However, we observe that with PSR SU, it causes
> visual artifacts, higher power usage, and potential system hang.
>
> [...]
>
> Fixes: 7cc191ee7621 ("drm/amd/display: Implement MPO PSR SU")

Many thx for taking care of this. There is one small thing to improve,
please add the following tags here:

Reported-by: August Wikerfors <git@augustwikerfors.se>
Link:
https://lore.kernel.org/r/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/

To explain: Linus[1] and others considered proper link tags in cases
like important, as they allow anyone to look into the backstory weeks or
years from now. That why they should be placed here, as outlined by the
documentation[2]. I care personally, because these tags make my
regression tracking efforts a whole lot easier, as they allow my
tracking bot 'regzbot' to automatically connect reports with patches
posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/r/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)
