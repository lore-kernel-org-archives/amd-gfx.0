Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC53EB64DC
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jul 2023 09:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F7810E092;
	Sat, 15 Jul 2023 09:04:21 +0000 (UTC)
Received: from mailgw.gate-on.net (auth.Gate-On.Net [210.197.74.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA8510E8BA
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jul 2023 02:39:17 +0000 (UTC)
Received: from vega.pgw.jp (unknown [49.135.109.134])
 by mailgw.gate-on.net (Postfix) with ESMTP id 813E68018A;
 Sat, 15 Jul 2023 11:39:14 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
 by vega.pgw.jp (Postfix) with SMTP
 id 3562DA53D; Sat, 15 Jul 2023 11:39:11 +0900 (JST)
From: <kkabe@vega.pgw.jp>
Content-Type: text/plain; charset=ISO-2022-JP
To: rostedt@goodmis.org
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference,
 address:00000004
In-Reply-To: Your message of "Fri, 14 Jul 2023 10:00:19 -0400".
 <20230714100019.6bf9b1ab@gandalf.local.home>
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date: Sat, 15 Jul 2023 11:39:11 +0900
Message-ID: <230715113911.M0124687@vega.pgw.jp>
X-Mailman-Approved-At: Sat, 15 Jul 2023 09:04:18 +0000
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
Cc: dave.hansen@linux.intel.com, regressions@lists.linux.dev,
 Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, mingo@redhat.com, bp@alien8.de,
 bagasdotme@gmail.com, hpa@zytor.com, alexander.deucher@amd.com,
 tglx@linutronix.de, kkabe@vega.pgw.jp, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

rostedt@goodmis.org sed in <20230714100019.6bf9b1ab@gandalf.local.home>

>> On Fri, 14 Jul 2023 14:34:04 +0900
>> <kkabe@vega.pgw.jp> wrote:
>> 
>> > >> > So I'm confused about why it's mentioned. Was it backported?  
>> > >> 
>> > >> Taketo Kabe, could you please help to clean this confusion up? Did you
>> > >> mean 5.19 in https://bugzilla.kernel.org/show_bug.cgi?id=217669#c5 ? And
>> > >> BTW: did you really use a vanilla kernel for your bisection?  
>> > 
>> > 
>> > Reporter Me:
>> > I bisected using freedesktop.org kernel tree, which git commit ID is
>> > in sync with kernel.org
>> > but version number in ./Makefile could be slighty behind. 
>> > 
>> > Patch in
>> > https://bugzilla.kernel.org/show_bug.cgi?id=217669#c4
>> > fixed the problem in freedesktop.org kernel 5.18.0-rc2 .
>> > This may explain that in kernel.org tree, the said commit is in kernel-5.19.
>> 
>> Even if the bisect did land on this commit, it doesn't make sense. I would
>> think that one of the results of the bisect was incorrect (a pass that
>> should have failed?), as that would lead the bisect down to the wrong
>> conclusion.
>> 
>> Now if you you remove this commit and everything works fine, and add it
>> back again and it fails reliably, then I can't argue it is not the commit.

I agree with that it does not make sense.
But reverting that commit made the freedesktop.org kernel-5.18-0-rc2 not panic,
and adding it back made kernel panic
(actually, check for vblank->worker==NULL fires)

>> 
>> But the commit in question kicks off a worker thread at boot up to search
>> for weak functions that were tagged to be traced by the function tracer and
>> sets them to "disabled" to never be traced.
>> 
>> Is the function tracer used at all here? I really do not see how this
>> commit affects the code that is crashing. Unless there's something wrong
>> with the way the kworker was set up and it corrupted other kworkers :-/
>> -- Steve

Yes, this is puzzling. That's why I need other people's opinion on this.
Does it matter the DUT is a slow machine (Pentium 120MHz)?

-- 
kabe

