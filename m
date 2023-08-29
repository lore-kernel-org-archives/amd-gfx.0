Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DA7C83F14
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 12:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3ED10E301;
	Tue, 29 Aug 2023 12:56:44 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D69910E252
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 12:08:20 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1qaxVt-0005Gc-4Q; Tue, 29 Aug 2023 14:08:05 +0200
Message-ID: <6a39c016-0f00-6cfa-834e-abe5acb79757@leemhuis.info>
Date: Tue, 29 Aug 2023 14:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Content-Language: en-US, de-DE
To: kkabe@vega.pgw.jp
References: <230722113014.M0204460@vega.pgw.jp>
 <230723205506.M0106064@vega.pgw.jp>
 <20230723103210.4b1b032e@rorschach.local.home>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230723103210.4b1b032e@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1693310900;
 d89c738a; 
X-HE-SMSGID: 1qaxVt-0005Gc-4Q
X-Mailman-Approved-At: Tue, 29 Aug 2023 12:56:38 +0000
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
Cc: dave.hansen@linux.intel.com, regressions@lists.linux.dev,
 Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, mingo@redhat.com, bp@alien8.de,
 Steven Rostedt <rostedt@goodmis.org>, bagasdotme@gmail.com, hpa@zytor.com,
 alexander.deucher@amd.com, tglx@linutronix.de, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

I still have this issue on my list of tracked regressions.

Was this fixed in between? Doesn't look like it from here, but I might
be missing something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 23.07.23 16:32, Steven Rostedt wrote:
> On Sun, 23 Jul 2023 20:55:06 +0900
> <kkabe@vega.pgw.jp> wrote:
> 
>> So I tried to trap NULL and return:
>>
>> ================ patch-drm_vblank_cancel_pending_works-printk-NULL-ret.patch
>> diff -up ./drivers/gpu/drm/drm_vblank_work.c.pk2 ./drivers/gpu/drm/drm_vblank_work.c
>> --- ./drivers/gpu/drm/drm_vblank_work.c.pk2	2023-06-06 20:50:40.000000000 +0900
>> +++ ./drivers/gpu/drm/drm_vblank_work.c	2023-07-23 14:29:56.383093673 +0900
>> @@ -71,6 +71,10 @@ void drm_vblank_cancel_pending_works(str
>>  {
>>  	struct drm_vblank_work *work, *next;
>>  
>> +	if (!vblank->dev) {
>> +		printk(KERN_WARNING "%s: vblank->dev == NULL? returning\n", __func__);
>> +		return;
>> +	}
>>  	assert_spin_locked(&vblank->dev->event_lock);
>>  
>>  	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
>> ================
>>
>> This time, the printk trap does not happen!! and radeon.ko works.
>> (NULL check for vblank->worker is still fireing though)
>>
>> Now this is puzzling.
>> Is this a timing issue?
> 
> It could very well be. And the ftrace patch could possibly not be the
> cause at all. But the thread that is created to do the work is causing
> the race window to be opened up, which is why you see it with the patch
> and don't without it. It may not be the problem, it may just tickle the
> timings enough to trigger the bug, and is causing you to go on a wild
> goose chase in the wrong direction.
> 
> -- Steve
> 
> 
>> Is systemd-udevd doing something not favaorble to kernel?
>> Is drm vblank code running without enough initialization?
>>
>> Puzzling is, that purely useland activity
>> (logging in on tty1 before radeon.ko load)
>> is affecting kernel panic/no-panic.
> 
> 
> 
