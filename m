Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DC4C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 16:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B052078A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pwp3yCkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B052078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E693C6E3DA;
	Mon, 15 Jun 2020 16:22:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5516E379
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UVfQPVFT8zu5fELoM5Bet6sVk8Wjqh3zVoIY71Sa5zI=; b=pwp3yCkx0FzValuPTLZTDE+uLj
 PFBHm97sqLs53h2d3HqLL3ytlpmB6PojSrsWK4H5aqtjN5vCH1RTTyAEQjJVz4azHKj9aAY7OEJey
 ZE75JyGJXIBZ6WCsFz5oPBTq75nrPvhIbvX/DqyTMGbYInTNjk6XjUsXfEZm+3mMF0C9X4FA2YJml
 wiexxaTXGHytfJQ7qkJG5ZhFC9E5M2LGj76lL4MCPyG7blvIBPpjBfOGNye7pWD+fQCLLBfapvPq9
 4Qhcxp7Q4M+wUrzTtmAH8hCmNitj8/j6duDNMUq7FfEe61MFCYAmCmp5xXfGUpNr/inZHibBHUy44
 Y92f487A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkraa-0007UV-PY; Mon, 15 Jun 2020 16:04:01 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBB61306089;
 Mon, 15 Jun 2020 18:03:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B256920E05A91; Mon, 15 Jun 2020 18:03:57 +0200 (CEST)
Date: Mon, 15 Jun 2020 18:03:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615160357.GA2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615154854.GB13792@romley-ivt3.sc.intel.com>
X-Mailman-Approved-At: Mon, 15 Jun 2020 16:22:52 +0000
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
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 15, 2020 at 08:48:54AM -0700, Fenghua Yu wrote:
> Hi, Peter,
> On Mon, Jun 15, 2020 at 09:56:49AM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 12, 2020 at 05:41:33PM -0700, Fenghua Yu wrote:
> > > +/*
> > > + * Apply some heuristics to see if the #GP fault was caused by a thread
> > > + * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
> > > + * is the problem, try initializing the IA32_PASID MSR. If the heuristic
> > > + * guesses incorrectly, take one more #GP fault.
> > 
> > How is that going to help? Aren't we then going to run this same
> > heuristic again and again and again?
> 
> The heuristic always initializes the MSR with the per mm PASID IIF the
> mm has a valid PASID but the MSR doesn't have one. This heuristic usually
> happens only once on the first #GP in a thread.

But it doesn't guarantee the PASID is the right one. Suppose both the mm
has a PASID and the MSR has a VALID one, but the MSR isn't the mm one.
Then we NO-OP. So if the exception was due to us having the wrong PASID,
we stuck.

> If the next #GP still comes in, the heuristic finds out the MSR already
> has a valid PASID and thus will not fixup the MSR any more. The fixup()
> returns "false" and lets others to handle the #GP.
> 
> So the heuristic will be executed once (at most) and won't be executed
> again and again.

So I get that you want to set the PASID on-demand, but I find this all
really weird code to make that happen.

> > > +bool __fixup_pasid_exception(void)
> > > +{
> > > +	u64 pasid_msr;
> > > +	unsigned int pasid;
> > > +
> > > +	/*
> > > +	 * This function is called only when this #GP was triggered from user
> > > +	 * space. So the mm cannot be NULL.
> > > +	 */
> > > +	pasid = current->mm->pasid;
> > > +	/* If the mm doesn't have a valid PASID, then can't help. */
> > > +	if (invalid_pasid(pasid))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * Since IRQ is disabled now, the current task still owns the FPU on
> > 
> > That's just weird and confusing. What you want to say is that you rely
> > on the exception disabling the interrupt.
> 
> I checked SDM again. You are right. #GP can be interrupted by machine check
> or other interrupts. So I cannot assume the current task still owns the FPU.
> Instead of directly rdmsr() and wrmsr(), I will add helpers that can access
> either the MSR on the processor or the PASID state in the memory.

That's not in fact what I meant, but yes, you can take exceptions while
!IF just fine.

> > > +	 * this CPU and the PASID MSR can be directly accessed.
> > > +	 *
> > > +	 * If the MSR has a valid PASID, the #GP must be for some other reason.
> > > +	 *
> > > +	 * If rdmsr() is really a performance issue, a TIF_ flag may be
> > > +	 * added to check if the thread has a valid PASID instead of rdmsr().
> > 
> > I don't understand any of this. Nobody except us writes to this MSR, we
> > should bloody well know what's in it. What gives?
> 
> Patch 4 describes how to manage the MSR and patch 7 describes the format
> of the MSR (20-bit PASID value and bit 31 is valid bit).
> 
> Are they sufficient to help? Or do you mean something else?

I don't get why you need a rdmsr here, or why not having one would
require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?

> > > +	 */
> > > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > > +		return false;
> > > +
> > > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);

How much more expensive is the wrmsr over the rdmsr? Can't we just
unconditionally write the current PASID and call it a day?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
