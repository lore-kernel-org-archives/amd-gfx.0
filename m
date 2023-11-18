Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E47C2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 15:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9651210E41B;
	Mon, 20 Nov 2023 15:40:26 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82C710E08A
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Nov 2023 14:25:09 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1r4MFw-0004iM-8d; Sat, 18 Nov 2023 15:25:08 +0100
Message-ID: <7f4d0dc4-eba7-4221-a1d6-d815c2f3b967@leemhuis.info>
Date: Sat, 18 Nov 2023 15:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Content-Language: en-US, de-DE
To: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1700317510;
 bfff7da7; 
X-HE-SMSGID: 1r4MFw-0004iM-8d
X-Mailman-Approved-At: Mon, 20 Nov 2023 15:40:24 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 14.11.23 11:55, Mikhail Gavrilov wrote:
> Hi,
> Yesterday came the 6.7-rc1 kernel.
> And surprisingly it turned out it is not working with my LG C3.
> I use this OLED TV as my primary monitor.
> After login to GNOME I see a horizontal flashing bar with a picture of
> the desktop background on white screen.
> Demonstration: https://youtu.be/7F76VfRkrVo
> 
> I made a bisection.
> And bisect said that the first bad commit is:
> commit ed6e2782e9747508888f671e1101250bb19045be
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced ed6e2782e9747508888f671e1101250bb190
#regzbot title drm/amd/display: horizontal flashing bar with a picture
of the desktop background on white screen after login
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

