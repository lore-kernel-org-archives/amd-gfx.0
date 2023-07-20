Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EEFC001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EA310E62F;
	Fri, 21 Jul 2023 08:20:49 +0000 (UTC)
Received: from mailgw.gate-on.net (auth.Gate-On.Net [210.197.74.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD28510E1C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 23:40:03 +0000 (UTC)
Received: from vega.pgw.jp (unknown [49.135.109.134])
 by mailgw.gate-on.net (Postfix) with ESMTP id B4DD0802A3;
 Fri, 21 Jul 2023 08:39:58 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
 by vega.pgw.jp (Postfix) with SMTP
 id BF312A53D; Fri, 21 Jul 2023 08:39:55 +0900 (JST)
From: <kkabe@vega.pgw.jp>
Content-Type: text/plain; charset=ISO-2022-JP
To: rostedt@goodmis.org
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference,
 address:00000004
In-Reply-To: Your message of "Mon, 17 Jul 2023 11:36:23 -0400".
 <20230717113623.41878887@gandalf.local.home>
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date: Fri, 21 Jul 2023 08:39:55 +0900
Message-ID: <230721083955.M0102626@vega.pgw.jp>
X-Mailman-Approved-At: Fri, 21 Jul 2023 08:20:41 +0000
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

rostedt@goodmis.org sed in <20230717113623.41878887@gandalf.local.home>

>> On Fri, 14 Jul 2023 14:34:04 +0900
>> <kkabe@vega.pgw.jp> wrote:
>> 
>> > Patch in
>> > https://bugzilla.kernel.org/show_bug.cgi?id=217669#c4
>> > fixed the problem in freedesktop.org kernel 5.18.0-rc2 .
>> > This may explain that in kernel.org tree, the said commit is in kernel-5.19.
>> 
>> You mean the patch that adds:
>> 
>> 	#if defined(FTRACE_MCOUNT_MAX_OFFSET) && (FTRACE_MCOUNT_MAX_OFFSET)
>> 
>> ?
>> 
>> Nothing should be setting FTRACE_MCOUNT_MAX_OFFSET to anything but non
>> zero. But doing a grep, I now see:
>> 
>> # define FTRACE_MCOUNT_MAX_OFFSET ENDBR_INSN_SIZE
>> 
>> Where it breaks that assumption if ENDBR_INSN_SIZE == 0 :-p
>>  (and that's my code!)
>> 
>> OK, does this fix it? (I haven't tested nor compiled this)
>> 
>> -- Steve
>> 
>> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
>> index 897cf02c20b1..801f4414da3e 100644
>> --- a/arch/x86/include/asm/ftrace.h
>> +++ b/arch/x86/include/asm/ftrace.h
>> @@ -13,7 +13,7 @@
>>  #ifdef CONFIG_HAVE_FENTRY
>>  # include <asm/ibt.h>
>>  /* Add offset for endbr64 if IBT enabled */
>> -# define FTRACE_MCOUNT_MAX_OFFSET	ENDBR_INSN_SIZE
>> +# define FTRACE_MCOUNT_MAX_OFFSET	(ENDBR_INSN_SIZE + MCOUNT_INSN_SIZE)
>>  #endif
>>  
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>> 

Unfortunately this patch didn't fix freedesktop.org 5.18.0-rc2 tree.
(vblank->worker == NULL check fires otherwise a panic)

Applying this to kernel.org 6.4.3 results in totally different error as in 
https://bugzilla.kernel.org/show_bug.cgi?id=217669#c0
so there may be multiple regressions I'm chasing.

-- 
kabe

