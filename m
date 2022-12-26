Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3218C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 15:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AC610E040;
	Tue, 27 Dec 2022 15:34:00 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B506810E0D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Dec 2022 13:26:18 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1p9nUa-0005in-9g; Mon, 26 Dec 2022 14:26:12 +0100
Message-ID: <163d5366-35d9-f7db-cf50-796d6b011c0a@leemhuis.info>
Date: Mon, 26 Dec 2022 14:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ALSA: hda/hdmi: Use only dynamic PCM device allocation
 #forregzbot
Content-Language: en-US, de-DE
To: ALSA development <alsa-devel@alsa-project.org>
References: <20220922084017.25925-1-perex@perex.cz>
 <1c9c00dec72c241a399b3b7c0a305382a5712529.camel@bi-co.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <1c9c00dec72c241a399b3b7c0a305382a5712529.camel@bi-co.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1672061178;
 bba30278; 
X-HE-SMSGID: 1p9nUa-0005in-9g
X-Mailman-Approved-At: Tue, 27 Dec 2022 15:33:58 +0000
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
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 25.12.22 13:14, Michael Laß wrote:
> CC'ing amd-gfx as this might be an issue in the amd driver.
> 
> This change causes a regression in Linux 6.1 at least on some AMD APUs.
> There are reports from users with Ryzen 4750U, 5800U and 5850U chips
> where the HDMI sound devices don't show up anymore. I'm affected by
> this as well.
> 
> Reverting this commit (ef6f5494) makes the HDMI audio devices show up
> again. I verified that this is still an issue in current Linux git
> (72a85e2b).

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced ef6f5494faf6a37c74990689a
#regzbot title alsa: hda/hdmi: HDMI sound devices don't show up anymore
with some AMD APUs
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.


> Am Donnerstag, dem 22.09.2022 um 10:40 +0200 schrieb Jaroslav Kysela:
>>> Per discussion on the alsa-devel mailing list [1], the legacy PIN to PCM
>>> device mapping is obsolete nowadays. The maximum number of the simultaneously
>>> usable PCM devices is equal to the HDMI codec converters.
>>>
>>> Remove the extra PCM devices (beyond the detected converters) and force
>>> the use of the dynamic PCM device allocation. The legacy code is removed.
>>>
>>> I believe that all HDMI codecs have the jack sensing feature. Move the check
>>> to the codec probe function and print a warning, if a codec without this
>>> feature is detected.
> 
> The corresponding message ("jack not detectable") is not shown on the
> affected system.
> 
>>> [1] https://lore.kernel.org/alsa-devel/2f37e0b2-1e82-8c0b-2bbd-1e5038d6ecc6@perex.cz/
> 
> Links to some reports of this issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=216836
> https://bbs.archlinux.org/viewtopic.php?pid=2075700
> https://bugs.archlinux.org/task/76917
> https://www.reddit.com/r/archlinux/comments/zsqq7i/hdmi_audio_is_broken_after_updating_kernel_to_611
> 
> Best regards,
> Michael
