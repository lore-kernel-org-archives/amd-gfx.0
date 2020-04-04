Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD064C2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 13:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9494720672
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z7oS8zO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9494720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C4A6E29B;
	Sun,  5 Apr 2020 13:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8E96ECDD
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Apr 2020 03:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ibkTI/yyTgRhpR95ppr6ajtD7LeL8TZWLWwT1L/4/y0=; b=Z7oS8zO1OCznvgpB0S548tE2FE
 fV4rCljvLaG2+ieGlEb7UzfiZkiPXP8SoK5pb3RUpXs0Y2iQypL8NzcANc/kfF/jdsuum2M2jdulg
 U9qvrCWDebhNxnzOcws+cp07Ab84DC3N/oNYeKq8HN1sBbOdssBfbY9m6dkN8mzM/b34Mg869mx4b
 SAz3VVXrNxYs2IwEYiS8pndoluZqJi7f53yL9jxkXHB1NhFKdiji2UO0dNIrEpGMQhBCu0amvENIH
 Pq/rjGbLfLozdgOH0uWCIBynJOAVc7mM1BqGV3PBvCwglZZIVV6v5WZG3O8QLuRxT56OY41BRuKgv
 LrlXk70Q==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKZH7-0006sn-MZ; Sat, 04 Apr 2020 03:15:13 +0000
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f5565d3-90a5-be3e-d79d-715d7b94880d@infradead.org>
Date: Fri, 3 Apr 2020 20:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
Content-Language: en-US
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/3/20 8:08 PM, Masami Hiramatsu wrote:
> +static inline int insn_is_fpu(struct insn *insn)
> +{
> +	if (!insn->opcode.got)
> +		insn_get_opcode(insn);
> +	if (inat_is_fpu(insn->attr)) {
> +		if (insn->attr & INAT_FPUIFVEX)
> +			return insn_is_avx(insn);
> +		return 1;
> +	}

	return 0; // ??

> +}
> +


-- 
~Randy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
