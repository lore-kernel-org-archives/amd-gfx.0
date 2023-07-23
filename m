Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73F4C001DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE6910E2F9;
	Mon, 24 Jul 2023 12:58:55 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5196210E032
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 14:32:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B90C160DC5;
 Sun, 23 Jul 2023 14:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A5C433C8;
 Sun, 23 Jul 2023 14:32:11 +0000 (UTC)
Date: Sun, 23 Jul 2023 10:32:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <kkabe@vega.pgw.jp>
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Message-ID: <20230723103210.4b1b032e@rorschach.local.home>
In-Reply-To: <230723205506.M0106064@vega.pgw.jp>
References: <230722113014.M0204460@vega.pgw.jp>
 <230723205506.M0106064@vega.pgw.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:33 +0000
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
 tglx@linutronix.de, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, 23 Jul 2023 20:55:06 +0900
<kkabe@vega.pgw.jp> wrote:

> So I tried to trap NULL and return:
> 
> ================ patch-drm_vblank_cancel_pending_works-printk-NULL-ret.patch
> diff -up ./drivers/gpu/drm/drm_vblank_work.c.pk2 ./drivers/gpu/drm/drm_vblank_work.c
> --- ./drivers/gpu/drm/drm_vblank_work.c.pk2	2023-06-06 20:50:40.000000000 +0900
> +++ ./drivers/gpu/drm/drm_vblank_work.c	2023-07-23 14:29:56.383093673 +0900
> @@ -71,6 +71,10 @@ void drm_vblank_cancel_pending_works(str
>  {
>  	struct drm_vblank_work *work, *next;
>  
> +	if (!vblank->dev) {
> +		printk(KERN_WARNING "%s: vblank->dev == NULL? returning\n", __func__);
> +		return;
> +	}
>  	assert_spin_locked(&vblank->dev->event_lock);
>  
>  	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
> ================
> 
> This time, the printk trap does not happen!! and radeon.ko works.
> (NULL check for vblank->worker is still fireing though)
> 
> Now this is puzzling.
> Is this a timing issue?

It could very well be. And the ftrace patch could possibly not be the
cause at all. But the thread that is created to do the work is causing
the race window to be opened up, which is why you see it with the patch
and don't without it. It may not be the problem, it may just tickle the
timings enough to trigger the bug, and is causing you to go on a wild
goose chase in the wrong direction.

-- Steve


> Is systemd-udevd doing something not favaorble to kernel?
> Is drm vblank code running without enough initialization?
> 
> Puzzling is, that purely useland activity
> (logging in on tty1 before radeon.ko load)
> is affecting kernel panic/no-panic.

