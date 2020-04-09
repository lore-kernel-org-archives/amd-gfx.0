Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 18:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58CB20757
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 18:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MrlwWZIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58CB20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601C16E15D;
	Thu,  9 Apr 2020 18:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4B36E23D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Q65ZfxGCOXDyibkgNECB3F/5D7aJifSXBHv+qldYJ4g=; b=MrlwWZIsNnQ2mG7aaGTWEbjnCd
 FirzPIE+4XpQBOJCKeQ2d6jvFPS7IydlAlmLxaRD2AwYoi5kEFhQfr8ecUoNr57+/o63f7qGpqRyL
 5iDM1XSBaGOUJAIHykTX1byif1cvY4fEKaiTcE/5yHrc63rTSl7z3rsrUThVxpQKDjq6xOSun9n1O
 vNnuLw7jgRMm2PEAe8hMyuj29I5/uSFVFV5J3K9oGMqMJG+qPQQZbtsioQc8B3OGqgsnan65dK/vi
 D+M+ZdTO4zoUmtSMCnm8PKHrpTZM/eQy5HKY2wJqZ76MukwVYrxOHe6vrWkIdzMXNuWLyaJWBjEWc
 AfWTennA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMag1-0004ql-UG; Thu, 09 Apr 2020 17:09:18 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D18B300B38;
 Thu,  9 Apr 2020 19:09:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 28EA62BA1D82B; Thu,  9 Apr 2020 19:09:16 +0200 (CEST)
Date: Thu, 9 Apr 2020 19:09:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200409170916.GR20760@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
X-Mailman-Approved-At: Thu, 09 Apr 2020 18:02:59 +0000
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
 mhiramat@kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 09, 2020 at 05:59:56PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 04:13:08PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 02, 2020 at 09:33:54AM +0200, Christian K=F6nig wrote:
> =

> > > yes, using the floating point calculations in the display code has be=
en a
> > > source of numerous problems and confusion in the past.
> > > =

> > > The calls to kernel_fpu_begin() and kernel_fpu_end() are hidden behin=
d the
> > > DC_FP_START() and DC_FP_END() macros which are supposed to hide the
> > > architecture depend handling for x86 and PPC64.
> > > =

> > > This originated from the graphics block integrated into AMD CPU (wher=
e we
> > > knew which fp unit we had), but as far as I know is now also used for
> > > dedicated AMD GPUs as well.
> > > =

> > > I'm not really a fan of this either, but so far we weren't able to co=
nvince
> > > the hardware engineers to not use floating point calculations for the
> > > display stuff.

> I'll need another approach, let me consider.

Christian; it says these files are generated, does that generator know
which functions are wholly in FPU context and which are not?

My current thinking is that if I annotate all functions that are wholly
inside kernel_fpu_start() with an __fpu function attribute, then I can
verify that any call from regular text to fpu text only happens inside
kernel_fpu_begin()/end(). And I can ensure that all !__fpu annotation
fuctions only contain !fpu instructions.

Can that generator add the __fpu function attribute or is that something
that would need to be done manually (which seems like it would be
painful, since it is quite a bit of code) ?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
