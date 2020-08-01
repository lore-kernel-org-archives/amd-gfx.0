Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 08:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A029206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 08:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A029206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA276E215;
	Mon,  3 Aug 2020 08:21:02 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9110B6E128
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Aug 2020 00:42:09 +0000 (UTC)
IronPort-SDR: Ub4n405VLt6R7WGd5csIl9EnC4RA8vtjvkum1k0YlF6Mkttyuu+QErwX0GQ3HP7FaENx8EOVM3
 66BsNh+4MaQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="149342580"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; d="scan'208";a="149342580"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2020 17:42:09 -0700
IronPort-SDR: P6H3jEK43GdS1/8t4/7dSlDlGHhnsqkKpcsT+VzyPTLx2laDWwmcvrMJ+8mkdacBSts+EB4NII
 1VV+17pJzvng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; d="scan'208";a="329450720"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
 by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2020 17:42:08 -0700
Date: Sat, 1 Aug 2020 00:42:08 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200801004208.GA324365@otcwcpicx6.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
 <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
X-Mailman-Approved-At: Mon, 03 Aug 2020 08:20:56 +0000
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
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Borislav Petkov <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Andy,

On Fri, Jul 31, 2020 at 04:34:11PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in the current thread's PASID MSR. The
> > #GP fault handler will initialize the MSR if a PASID has been allocated
> > for this process.
> >
> > Decoding the user instruction is ugly and sets a bad architecture
> > precedent. It may not function if the faulting instruction is modified
> > after #GP.
> >
> > Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> > without a valid PASID value programmed. #GP error codes are 16 bits and all
> > 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> > choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> > when loading from the source operand, so its not fully comprehending all
> > the reasons. Rather than special case the ENQCMD, in future Intel may
> > choose a different fault mechanism for such cases if recovery is needed on
> > #GP.
> 
> Decoding the user instruction is ugly and sets a bad architecture
> precedent, but we already do it in #GP for UMIP.  So I'm unconvinced.

Maybe just remove the "Decoding the user instruction ... bad architecture
precedent" sentence? The sentence is vague.

As described in the following "It may not function ..." sentence, the real
issue of parsing the instruction is the instruction may be modified by
another processor before it's parsed in the #GP handler.

If just keep the "It may not function ..." sentence, is that good enough to
explain why we don't parse the faulting instruction?

> 
> Memo to Intel, though: you REALLY need to start thinking about what
> the heck an OS is supposed to do with all these new faults you're
> coming up with.  The new #NM for TILE is utterly nonsensical.  Sure,
> it works for an OS that does not use CR0.TS and as long as no one
> tries to extend the same mechanism for some new optional piece of
> state, but as soon as Intel tries to use the same mechanism for
> anything else, it falls apart.
> 
> Please do better.

Internally we did discuss the error code in #GP for PASID with HW architects.
But due to some uarch reason, it's not simple to report the error code for
PASID:( Please see previous discussion on the error code for PASID:
https://lore.kernel.org/lkml/20200427224646.GA103955@otc-nc-03/

It's painful for our SW guys to check exception reasons if hardware
doesn't explicitly tell us.

Hopefully the heuristics (fixup the PASID MSR if the process already has
a valid PASID but the MSR doesn't have one yet) in this patch is acceptable.
 
> 
> > +
> > +/*
> > + * Write the current task's PASID MSR/state. This is called only when PASID
> > + * is enabled.
> > + */
> > +static void fpu__pasid_write(u32 pasid)
> > +{
> > +       u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> > +
> > +       fpregs_lock();
> > +
> > +       /*
> > +        * If the MSR is active and owned by the current task's FPU, it can
> > +        * be directly written.
> > +        *
> > +        * Otherwise, write the fpstate.
> > +        */
> > +       if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> > +               wrmsrl(MSR_IA32_PASID, msr_val);
> > +       } else {
> > +               struct ia32_pasid_state *ppasid_state;
> > +
> > +               ppasid_state = get_xsave_addr(&current->thread.fpu.state.xsave,
> > +                                             XFEATURE_PASID);
> > +               /*
> > +                * ppasid_state shouldn't be NULL because XFEATURE_PASID
> > +                * is enabled.
> > +                */
> > +               WARN_ON_ONCE(!ppasid_state);
> > +               ppasid_state->pasid = msr_val;
> 
> WARN instead of BUG is nice, but you'll immediate oops if this fails.
> How about:
> 
> if (!WARN_ON_ONCE(!ppasid_state))
>   ppasid_state->pasid = msr_val;

OK. I will fix this issue.

Thank you very much for your review!

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
