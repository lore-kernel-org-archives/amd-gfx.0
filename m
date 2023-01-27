Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6832C54EAA
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jan 2023 14:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3AE10E98F;
	Fri, 27 Jan 2023 14:14:32 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A649C10E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jan 2023 12:52:51 +0000 (UTC)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1pLODp-0001vu-Om; Fri, 27 Jan 2023 13:52:49 +0100
Message-ID: <cea5051b-1a13-45a9-6cbe-a664a9cd1d88@leemhuis.info>
Date: Fri, 27 Jan 2023 13:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ALSA: hda/hdmi: Use only dynamic PCM device allocation
 #forregzbot
Content-Language: en-US, de-DE
From: "Linux kernel regression tracking (#update)" <regressions@leemhuis.info>
To: ALSA development <alsa-devel@alsa-project.org>
References: <20220922084017.25925-1-perex@perex.cz>
 <1c9c00dec72c241a399b3b7c0a305382a5712529.camel@bi-co.net>
 <163d5366-35d9-f7db-cf50-796d6b011c0a@leemhuis.info>
In-Reply-To: <163d5366-35d9-f7db-cf50-796d6b011c0a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1674823971;
 dfef2cc9; 
X-HE-SMSGID: 1pLODp-0001vu-Om
X-Mailman-Approved-At: Fri, 27 Jan 2023 14:14:31 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 26.12.22 14:26, Thorsten Leemhuis wrote:
> On 25.12.22 13:14, Michael Laß wrote:
>> CC'ing amd-gfx as this might be an issue in the amd driver.
>>
>> This change causes a regression in Linux 6.1 at least on some AMD APUs.
>> There are reports from users with Ryzen 4750U, 5800U and 5850U chips
>> where the HDMI sound devices don't show up anymore. I'm affected by
>> this as well.
>>
>> Reverting this commit (ef6f5494) makes the HDMI audio devices show up
>> again. I verified that this is still an issue in current Linux git
>> (72a85e2b).
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced ef6f5494faf6a37c74990689a
> #regzbot title alsa: hda/hdmi: HDMI sound devices don't show up anymore
> with some AMD APUs
> #regzbot ignore-activity

#regzbot fix: 090ddad4c7a9
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

