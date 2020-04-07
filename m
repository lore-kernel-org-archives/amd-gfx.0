Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21030C2BB54
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 12:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F8F206F7
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 12:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AMf5PWHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F8F206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA416E869;
	Tue,  7 Apr 2020 12:44:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BE26E835
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1d2WyDdWRKQDOOeVcfC2eCl0J9jbPjAVQfIQKvS4vOI=; b=AMf5PWHOBaDG//vZclu3Ua9h/s
 z7TeEnY1TAPLjd9hrDqtNBNt776pdd54Ge5LVy0LTmmkTuzEjI+u8GUz2BwiGYfPXI/5Os9uqGauB
 FLIAcvcCXtY1r/KCAhq7TZgQfFG8+GWKLL3M3lkLkAJhDjmGr1PcZ5Yw+/5AR/sx9DJlzpNTjQiT9
 P+nKk03qflOVYKVkWBf5z+nTEPGoxVA7yjBCQu8Iu3k4RgtGBHDTliHXoY/4g7ztr1xGyzBv0v8Ob
 Oi7hjmgVbmz0fuCGDLLPUSfztbm8xzBTSx5S1g0POafB5mR98o59iLdQ9y5zWOYCnnLmRSWgmOZYg
 rbwAM26A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLmCf-0006Ei-Gr; Tue, 07 Apr 2020 11:15:38 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C9B03007CD;
 Tue,  7 Apr 2020 13:15:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 88D9C2B907AB2; Tue,  7 Apr 2020 13:15:35 +0200 (CEST)
Date: Tue, 7 Apr 2020 13:15:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200407111535.GT20730@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
 <20200404143224.GL2452@worktop.programming.kicks-ass.net>
 <20200405121930.e3ea3e7acc7588102de483e2@kernel.org>
 <20200406102107.GI20730@hirez.programming.kicks-ass.net>
 <20200407185008.c819005f0174cae76c44a135@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200407185008.c819005f0174cae76c44a135@kernel.org>
X-Mailman-Approved-At: Tue, 07 Apr 2020 12:44:11 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
 Leo Li <sunpeng.li@amd.com>, the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 07, 2020 at 06:50:08PM +0900, Masami Hiramatsu wrote:
> On Mon, 6 Apr 2020 12:21:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > arch/x86/mm/extable.o: warning: objtool: ex_handler_fprestore()+0x8b: fpu_safe hint not an FPU instruction
> > 008b  36b:      48 0f ae 0d 00 00 00    fxrstor64 0x0(%rip)        # 373 <ex_handler_fprestore+0x93>
> > 
> > arch/x86/kvm/x86.o: warning: objtool: kvm_load_guest_fpu.isra.0()+0x1fa: fpu_safe hint not an FPU instruction
> > 01fa    1d2fa:  48 0f ae 4b 40          fxrstor64 0x40(%rbx)
> 
> Ah, fxstor will not chang the FPU/MMX/SSE regs but just store it on memory.
> OK, I'll remove it from the list.

Yeah, I don't much care if its in or out, but the way I was reading that
patch it _should_ be in, but then it doesn't seem to recognise it.

> > Also, all the VMX bits seems to qualify as FPU (I can't remember seeing
> > that previously):
> 
> Oops, let me check it.

I just send you another patch that could do with insn_is_vmx()
(sorry!!!)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
