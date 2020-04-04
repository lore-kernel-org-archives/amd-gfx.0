Return-Path: <SRS0=lN0T=5U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC949C2BA1A
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Apr 2020 08:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B182520709
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Apr 2020 08:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqCoEbX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B182520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE6D6E039;
	Sat,  4 Apr 2020 08:33:10 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54076E039
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Apr 2020 08:33:08 +0000 (UTC)
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8CD01206F5;
 Sat,  4 Apr 2020 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585989188;
 bh=VRCV/so7BKnM0P790h0/Q9OlUCaaiajC8qyNLu19kTw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MqCoEbX7Zf7roHVsgb3PwItJ3gY5pTGfQbIXgN+W8np9k/acj5NQquzfDzbrME2+d
 +tBWPDLYwo3zkAxhaPLxrvKp4qOOvAdK6pSIjmrmj5hmhnZ/wrvenpXUj4QlywPAJr
 PCJ0s4QvVymhbpIf6n0/S3u+LXdh6qt3wXNIeEX8=
Date: Sat, 4 Apr 2020 17:32:57 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse,
 -msse2 without any visible FPU state protection
Message-Id: <20200404173257.a9231d8129ce616145960c26@kernel.org>
In-Reply-To: <3f5565d3-90a5-be3e-d79d-715d7b94880d@infradead.org>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
 <3f5565d3-90a5-be3e-d79d-715d7b94880d@infradead.org>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 3 Apr 2020 20:15:11 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 4/3/20 8:08 PM, Masami Hiramatsu wrote:
> > +static inline int insn_is_fpu(struct insn *insn)
> > +{
> > +	if (!insn->opcode.got)
> > +		insn_get_opcode(insn);
> > +	if (inat_is_fpu(insn->attr)) {
> > +		if (insn->attr & INAT_FPUIFVEX)
> > +			return insn_is_avx(insn);
> > +		return 1;
> > +	}
> 
> 	return 0; // ??

Oops, right!

Hm, I need to add a caller for this API...

Thanks,

> 
> > +}
> > +
> 
> 
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
