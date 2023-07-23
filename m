Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B2DC001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A669A10E315;
	Mon, 24 Jul 2023 12:59:09 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A348E10E1A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 14:27:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DD64060DBE;
 Sun, 23 Jul 2023 14:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B8C433C8;
 Sun, 23 Jul 2023 14:27:44 +0000 (UTC)
Date: Sun, 23 Jul 2023 10:27:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <kabe@vega.pgw.jp>
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Message-ID: <20230723102733.70baeb1a@rorschach.local.home>
In-Reply-To: <230722113014.M0204460@vega.pgw.jp>
References: <230721083955.M0102626@vega.pgw.jp>
 <230722113014.M0204460@vega.pgw.jp>
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
 tglx@linutronix.de, kkabe@vega.pgw.jp, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, 22 Jul 2023 11:30:14 +0900
<kabe@vega.pgw.jp> wrote:

> >> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> >> index 897cf02c20b1..801f4414da3e 100644
> >> --- a/arch/x86/include/asm/ftrace.h
> >> +++ b/arch/x86/include/asm/ftrace.h
> >> @@ -13,7 +13,7 @@
> >>  #ifdef CONFIG_HAVE_FENTRY
> >>  # include <asm/ibt.h>
> >>  /* Add offset for endbr64 if IBT enabled */
> >> -# define FTRACE_MCOUNT_MAX_OFFSET	ENDBR_INSN_SIZE
> >> +# define FTRACE_MCOUNT_MAX_OFFSET	(ENDBR_INSN_SIZE + MCOUNT_INSN_SIZE)
> >>  #endif
> >>  
> >>  #ifdef CONFIG_DYNAMIC_FTRACE
> >>   
> 
> Above patch didn't work, but
> Does it matter that I am compiling with "gcc -fcf-protection=none"
> to not emit endbr32 instructions for i586?

This patch is supposed to address the case when ENDBR_INSN_SIZE is
zero. So I would think that that wouldn't matter.

-- Steve
