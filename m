Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEEAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 12:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C51A10E404;
	Tue, 10 May 2022 12:52:08 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28E910F784
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 10:33:03 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1noNAr-0000ov-Hl; Tue, 10 May 2022 12:33:01 +0200
Message-ID: <2192e546-cac7-f802-2297-3461a1cf8e03@leemhuis.info>
Date: Tue, 10 May 2022 12:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, regressions@lists.linux.dev
References: <note_1375796@gitlab.freedesktop.org>
 <66e1d78c-bf27-80b4-9804-6c9f3a8c5547@molgen.mpg.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Fwd: Re: amd | ASUS ROG Strix G513QY fails to resume from suspend
 [regression] (#2008)
In-Reply-To: <66e1d78c-bf27-80b4-9804-6c9f3a8c5547@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1652178783;
 5bbbdb1f; 
X-HE-SMSGID: 1noNAr-0000ov-Hl
X-Mailman-Approved-At: Tue, 10 May 2022 12:52:07 +0000
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10.05.22 10:37, Paul Menzel wrote:
> Dear Linux regressions folks,
> 
> A user reported a regression [1], which also trickled down to the stable
> series, for example between 5.15.13 and 5.15.14.
> 
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/2008

Many thx for forwarding. I'll add it to the tracking to ensure it's not
forgotten:

#regzbot introduced: 887f75cfd0da44c19dd
#regzbot from: spin83
#regzbot title: drm: amdgpu: ASUS ROG Strix G513QY fails to resume from
suspend
#regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/2008

Maybe the culprit is actually daf8de0874ab5b74b38a38726fdd3d, the report
is not clear on that, I just picked the newest the reporter mentioned
for now.

See the ticket for details, there were a few replies already. According
to Paul the problems trickled down to the stable series, for example
between 5.15.13 and 5.15.14.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
-- 
P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

P.P.S.: This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/
