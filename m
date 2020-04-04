Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AACC2BA17
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 13:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A0A20672
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 13:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zuv5E7Nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A0A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861C16E249;
	Sun,  5 Apr 2020 13:54:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4735A6E09C
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Apr 2020 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dBfBsCmH+Eo1IEVIov38NE0cr2dP5E/BRHhdQtoIDak=; b=zuv5E7NjreiQ5XBFzn1PjCMVNV
 5jlV9xfeyuYdiFQDdIRKMCVcHcR7OrMF8OAi/cb5kWg2eHOLySIleDucXovsfjveBE5dBEfeOnEJ5
 xsf/mpIZYKRsNwcAOBoysY7X4sjUDDX9+F1Drp9vz/ft02QfFO3C9Ava5WHPWQtbN1a2u6VWKpHh+
 IOUVxvbxQkUagwelFrXW1GOjQ8vB6FFg+A7tRCvITwxk0ajpOTFj7oBMN6LBb8gEL8901GSrdKqD9
 tR8vLwcHLqSSFTZCIFQDgCsmVr9OAeBqyoB/7oykglpseUcht3wj4PGhIdxS5Q/elLYDQJmY0t62n
 ACn+msaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKjqV-0000fy-P3; Sat, 04 Apr 2020 14:32:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5AE919834EB; Sat,  4 Apr 2020 16:32:24 +0200 (CEST)
Date: Sat, 4 Apr 2020 16:32:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200404143224.GL2452@worktop.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Sun, 05 Apr 2020 13:54:42 +0000
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

On Sat, Apr 04, 2020 at 12:08:08PM +0900, Masami Hiramatsu wrote:
> From c609be0b6403245612503fca1087628655bab96c Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Fri, 3 Apr 2020 16:58:22 +0900
> Subject: [PATCH] x86: insn: Add insn_is_fpu()
> 
> Add insn_is_fpu(insn) which tells that the insn is
> whether touch the MMX/XMM/YMM register or the instruction
> of FP coprocessor.

Looks good, although I changed it a little like so:

--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -133,11 +133,12 @@ static inline int insn_is_fpu(struct ins
 {
 	if (!insn->opcode.got)
 		insn_get_opcode(insn);
-	if (inat_is_fpu(insn->attr)) {
+	if (inat_is_fpu(insn->attr)) {
 		if (insn->attr & INAT_FPUIFVEX)
 			return insn_is_avx(insn);
 		return 1;
 	}
+	return 0;
 }
 
 static inline int insn_has_emulate_prefix(struct insn *insn)
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -269,14 +269,14 @@ d4: AAM Ib (i64)
 d5: AAD Ib (i64)
 d6:
 d7: XLAT/XLATB
-d8: ESC
-d9: ESC
-da: ESC
-db: ESC
-dc: ESC
-dd: ESC
-de: ESC
-df: ESC
+d8: FPU
+d9: FPU
+da: FPU
+db: FPU
+dc: FPU
+dd: FPU
+de: FPU
+df: FPU
 # 0xe0 - 0xef
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,10 +65,11 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	mmxreg_expr = "^[HLNPQUVW][a-z]+"
-	mmx_expr = "^\\((emms|fxsave|fxrstor|ldmxcsr|stmxcsr)\\)"
-	mmxifvex_expr = "^CMOV" # CMOV is non-vex non-mmx
-	fpu_expr = "^ESC"
+
+	mmxreg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	mmx_expr = "^\\(emms\\)"	  # MMX/SSE nmemonics lacking operands
+	mmxifvex_expr = "^CMOV"		  # nmemonics NOT an AVX
+	fpu_expr = "^FPU"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
