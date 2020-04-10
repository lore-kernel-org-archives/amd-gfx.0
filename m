Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC9FC2BB85
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 00:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38B420769
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 00:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="taEFXAPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38B420769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7755B6E19C;
	Fri, 10 Apr 2020 00:47:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83A56E19C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 00:47:32 +0000 (UTC)
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D9DF20768;
 Fri, 10 Apr 2020 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586479652;
 bh=enGM3Zk5ckxO6YjhHclG/EyDxbe/4faXeT7uJSpIT3M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=taEFXAPgJjLCfnupDKhIlGYKK6UO3ZzxKmeDDnETQjIy6FCNAMjjXf0BeZH6jSqkQ
 PL1cRbyDaRAqoFPgYZP5SFgT8lPdbhYOOHRqj5F4KFmCPQz8hozPzS8nkxybBlU/ko
 BrA61BTbYo1FXoBNn6EUVLgz1PURBOAoMCGS81dw=
Date: Fri, 10 Apr 2020 09:47:26 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86: insn: Add insn_is_fpu()
Message-Id: <20200410094726.f9885bafa730fe2a8b3b3c3a@kernel.org>
In-Reply-To: <20200409143212.GW20696@hirez.programming.kicks-ass.net>
References: <20200407155449.GF20730@hirez.programming.kicks-ass.net>
 <158636215075.6641.10786116450376715657.stgit@devnote2>
 <20200409143212.GW20696@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: David Zhou <David1.Zhou@amd.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jann Horn <jannh@google.com>, Leo Li <sunpeng.li@amd.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Harry Wentland <harry.wentland@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 9 Apr 2020 16:32:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 09, 2020 at 01:09:11AM +0900, Masami Hiramatsu wrote:
> > Add insn_is_fpu(insn) which tells that the insn is
> > whether touch the FPU/SSE/MMX register or the instruction
> > of FP coprocessor.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> 
> Sadly, it turns out I need "FWAIT" too, which I tried adding like the
> below, but that comes apart most mighty :/

Thanks for pointing it out. Now I understand the FWAIT/WAIT is used
to wait for FPU...

> 
> The trouble is that FWAIT doesn't take a MODRM, so the previous
> assumption that INAT_FPU implied INAT_MODRM needs to be broken, and I
> think that ripples through somewhere.

Oops, I missed it.

> 
> (also, your patch adds some whitespace to convert_operands(), not sure
> that was intended)

Ah, that's my typo.

> 
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -206,7 +206,7 @@ Table: one byte opcode
>  98: CBW/CWDE/CDQE
>  99: CWD/CDQ/CQO
>  9a: CALLF Ap (i64)
> -9b: FWAIT/WAIT
> +9b: FWAIT/WAIT {FPU}
>  9c: PUSHF/D/Q Fv (d64)
>  9d: POPF/D/Q Fv (d64)
>  9e: SAHF
> --- a/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -331,9 +331,13 @@ function convert_operands(count,opnd,
>  		if (match(opcode, rex_expr))
>  			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
>  
> +		# check coprocessor escape
> +		if (match(ext, "^ESC"))
> +			flags = add_flags(flags, "INAT_MODRM")
> +
>  		# check FPU/MMX/SSE superscripts
>  		if (match(ext, fpu_expr))
> -			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
> +			flags = add_flags(flags, "INAT_FPU")


OK, I'll include this.

Thank you,

>  
>  		# check VEX codes
>  		if (match(ext, evexonly_expr))


-- 
Masami Hiramatsu <mhiramat@kernel.org>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
