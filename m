Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA60EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4417410E274;
	Mon, 17 Jul 2023 15:48:59 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C78A10E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:21:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 85E2C61117;
 Mon, 17 Jul 2023 15:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA2C433C8;
 Mon, 17 Jul 2023 15:21:41 +0000 (UTC)
Date: Mon, 17 Jul 2023 11:21:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <kkabe@vega.pgw.jp>
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Message-ID: <20230717112138.1fd48cca@gandalf.local.home>
In-Reply-To: <230715113911.M0124687@vega.pgw.jp>
References: <20230714100019.6bf9b1ab@gandalf.local.home>
 <230715113911.M0124687@vega.pgw.jp>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 17 Jul 2023 15:48:57 +0000
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

On Sat, 15 Jul 2023 11:39:11 +0900
<kkabe@vega.pgw.jp> wrote:


> Yes, this is puzzling. That's why I need other people's opinion on this.
> Does it matter the DUT is a slow machine (Pentium 120MHz)?
> 

Hmm, I wonder because the workqueue is running __init functions, could it
possibly be that it didn't finish before the end of boot, where it frees
all the functions? It shouldn't do that because there's code to make sure
it's done before it continues further.

But just in case something isn't working as planned, you could try this
patch to see if the bug goes away.

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf..af5a40ef3be4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3771,13 +3771,13 @@ static int test_for_valid_rec(struct dyn_ftrace *rec)
 	return 1;
 }
 
-static struct workqueue_struct *ftrace_check_wq __initdata;
-static struct work_struct ftrace_check_work __initdata;
+static struct workqueue_struct *ftrace_check_wq;
+static struct work_struct ftrace_check_work;
 
 /*
  * Scan all the mcount/fentry entries to make sure they are valid.
  */
-static __init void ftrace_check_work_func(struct work_struct *work)
+static void ftrace_check_work_func(struct work_struct *work)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
