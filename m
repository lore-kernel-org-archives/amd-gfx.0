Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDAC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 15:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C137220656
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 15:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C137220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEDC6E36F;
	Mon, 15 Jun 2020 15:50:27 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3A96E372
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 15:48:55 +0000 (UTC)
IronPort-SDR: PuvDksSyMFg/9Unv3TSz3AwLzmxjXAVXFmg3RQnnUkZDqJrWZUmT6pPDj7PtwkUTUhiEQtJBPs
 0l354QOteVMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 08:48:54 -0700
IronPort-SDR: gkkYVgcY8xV06BkKjnJOGSlBzFZYve2j2awE0FGSSUIvIj3XiwAj5QsvMoP3GPr1BbNqj0sBuD
 XicWuOj61BNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; d="scan'208";a="382581571"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 08:48:54 -0700
Date: Mon, 15 Jun 2020 08:48:54 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615154854.GB13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615075649.GK2497@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Mon, 15 Jun 2020 15:50:26 +0000
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

Hi, Peter,
On Mon, Jun 15, 2020 at 09:56:49AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 05:41:33PM -0700, Fenghua Yu wrote:
> > +/*
> > + * Apply some heuristics to see if the #GP fault was caused by a thread
> > + * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
> > + * is the problem, try initializing the IA32_PASID MSR. If the heuristic
> > + * guesses incorrectly, take one more #GP fault.
> 
> How is that going to help? Aren't we then going to run this same
> heuristic again and again and again?

The heuristic always initializes the MSR with the per mm PASID IIF the
mm has a valid PASID but the MSR doesn't have one. This heuristic usually
happens only once on the first #GP in a thread.

If the next #GP still comes in, the heuristic finds out the MSR already
has a valid PASID and thus will not fixup the MSR any more. The fixup()
returns "false" and lets others to handle the #GP.

So the heuristic will be executed once (at most) and won't be executed
again and again.

> 
> > + */
> > +bool __fixup_pasid_exception(void)
> > +{
> > +	u64 pasid_msr;
> > +	unsigned int pasid;
> > +
> > +	/*
> > +	 * This function is called only when this #GP was triggered from user
> > +	 * space. So the mm cannot be NULL.
> > +	 */
> > +	pasid = current->mm->pasid;
> > +	/* If the mm doesn't have a valid PASID, then can't help. */
> > +	if (invalid_pasid(pasid))
> > +		return false;
> > +
> > +	/*
> > +	 * Since IRQ is disabled now, the current task still owns the FPU on
> 
> That's just weird and confusing. What you want to say is that you rely
> on the exception disabling the interrupt.

I checked SDM again. You are right. #GP can be interrupted by machine check
or other interrupts. So I cannot assume the current task still owns the FPU.
Instead of directly rdmsr() and wrmsr(), I will add helpers that can access
either the MSR on the processor or the PASID state in the memory.

> 
> > +	 * this CPU and the PASID MSR can be directly accessed.
> > +	 *
> > +	 * If the MSR has a valid PASID, the #GP must be for some other reason.
> > +	 *
> > +	 * If rdmsr() is really a performance issue, a TIF_ flag may be
> > +	 * added to check if the thread has a valid PASID instead of rdmsr().
> 
> I don't understand any of this. Nobody except us writes to this MSR, we
> should bloody well know what's in it. What gives?

Patch 4 describes how to manage the MSR and patch 7 describes the format
of the MSR (20-bit PASID value and bit 31 is valid bit).

Are they sufficient to help? Or do you mean something else?

> > +	 */
> > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > +		return false;
> > +
> > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > +
> > +	return true;
> > +}
> > -- 
> > 2.19.1
> > 

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
