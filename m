Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28066C001DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6A110E2F7;
	Mon, 24 Jul 2023 12:58:35 +0000 (UTC)
Received: from mailgw.gate-on.net (auth.Gate-On.Net [210.197.74.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F76D10E0D3
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jul 2023 01:57:19 +0000 (UTC)
Received: from vega.pgw.jp (unknown [49.135.109.134])
 by mailgw.gate-on.net (Postfix) with ESMTP id 3DE47802A7;
 Sat, 22 Jul 2023 10:57:17 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
 by vega.pgw.jp (Postfix) with SMTP
 id 7059CA53D; Sat, 22 Jul 2023 10:57:14 +0900 (JST)
From: <kkabe@vega.pgw.jp>
Content-Type: text/plain; charset=ISO-2022-JP
To: rostedt@goodmis.org
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointerdereference,
 address:00000004
In-Reply-To: Your message of "Mon, 17 Jul 2023 11:21:38 -0400".
 <20230717112138.1fd48cca@gandalf.local.home>
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date: Sat, 22 Jul 2023 10:57:14 +0900
Message-ID: <230722105714.M0104460@vega.pgw.jp>
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:34 +0000
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

rostedt@goodmis.org sed in <20230717112138.1fd48cca@gandalf.local.home>

>> On Sat, 15 Jul 2023 11:39:11 +0900
>> <kkabe@vega.pgw.jp> wrote:
>> 
>> 
>> > Yes, this is puzzling. That's why I need other people's opinion on this.
>> > Does it matter the DUT is a slow machine (Pentium 120MHz)?
>> > 
>> 
>> Hmm, I wonder because the workqueue is running __init functions, could it
>> possibly be that it didn't finish before the end of boot, where it frees
>> all the functions? It shouldn't do that because there's code to make sure
>> it's done before it continues further.
>> 
>> But just in case something isn't working as planned, you could try this
>> patch to see if the bug goes away.
>> 
>> -- Steve
>> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 05c0024815bf..af5a40ef3be4 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -3771,13 +3771,13 @@ static int test_for_valid_rec(struct dyn_ftrace *rec)
>>  	return 1;
>>  }
>>  
>> -static struct workqueue_struct *ftrace_check_wq __initdata;
>> -static struct work_struct ftrace_check_work __initdata;
>> +static struct workqueue_struct *ftrace_check_wq;
>> +static struct work_struct ftrace_check_work;
>>  
>>  /*
>>   * Scan all the mcount/fentry entries to make sure they are valid.
>>   */
>> -static __init void ftrace_check_work_func(struct work_struct *work)
>> +static void ftrace_check_work_func(struct work_struct *work)
>>  {
>>  	struct ftrace_page *pg;
>>  	struct dyn_ftrace *rec;
>> 

Just in case I tried this patch too;
no banana, it panics (vblank->worker == NULL check fires)

-- 
kabe

