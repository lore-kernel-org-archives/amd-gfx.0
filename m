Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614BC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 19:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFDE206D7
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 19:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFDE206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBB56E2FF;
	Mon,  3 Aug 2020 19:00:19 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FCC6E297
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 15:19:22 +0000 (UTC)
IronPort-SDR: PvyekHt6G43SM8Aam9tHsJk0LSXpe1H+H98GSNxr9e1GNP7hLmL23kJy0cTmqzlF9xDn/vDoPk
 4qezzRN1k0pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="149560566"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="149560566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 08:19:22 -0700
IronPort-SDR: G0CjCKxyQN08Sca20ML1Bsnx7p1bnKn36NhasF0+OG9kDqMZzCPmnowotiPrSoudbZAq71rwjl
 YBYDIsTbgPxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="305870584"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by orsmga002.jf.intel.com with ESMTP; 03 Aug 2020 08:19:21 -0700
Date: Mon, 3 Aug 2020 08:19:21 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200803151921.GA387967@otc-nc-03>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
 <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
 <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com>
 <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Mon, 03 Aug 2020 19:00:16 +0000
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

On Mon, Aug 03, 2020 at 08:12:18AM -0700, Andy Lutomirski wrote:
> On Mon, Aug 3, 2020 at 8:03 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 7/31/20 4:34 PM, Andy Lutomirski wrote:
> > >> Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> > >> without a valid PASID value programmed. #GP error codes are 16 bits and all
> > >> 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> > >> choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> > >> when loading from the source operand, so its not fully comprehending all
> > >> the reasons. Rather than special case the ENQCMD, in future Intel may
> > >> choose a different fault mechanism for such cases if recovery is needed on
> > >> #GP.
> > > Decoding the user instruction is ugly and sets a bad architecture
> > > precedent, but we already do it in #GP for UMIP.  So I'm unconvinced.
> >
> > I'll try to do one more bit of convincing. :)
> >
> > In the end, we need a way to figure out if the #GP was from a known "OK"
> > source that we can fix up.  You're right that we could fire up the
> > instruction decoder to help answer that question.  But, it (also)
> > doesn't easily yield a perfect answer as to the source of the #GP, it
> > always involves a user copy, and it's a larger code impact than what
> > we've got.
> >
> > I think I went and looked at fixup_umip_exception(), and compared it to
> > the alternative which is essentially just these three lines of code:
> >
> > > +     /*
> > > +      * If the current task already has a valid PASID in the MSR,
> > > +      * the #GP must be for some other reason.
> > > +      */
> > > +     if (current->has_valid_pasid)
> > > +             return false;
> > ...> +  /* Now the current task has a valid PASID in the MSR. */
> > > +     current->has_valid_pasid = 1;
> >
> > and *I* was convinced that instruction decoding wasn't worth it.
> >
> > There's a lot of stuff that fixup_umip_exception() does which we don't
> > have to duplicate, but it's going to be really hard to get it anywhere
> > near as compact as what we've got.
> >
> 
> I could easily be convinced that the PASID fixup is so trivial and so
> obviously free of misfiring in a way that causes an infinite loop that
> this code is fine.  But I think we first need to answer the bigger
> question of why we're doing a lazy fixup in the first place.

We choose lazy fixup for 2 reasons. 

- If some threads were already created before the MSR is programmed, then
  we need to fixup those in a race free way. scheduling some task-work etc.
  We did do that early on, but decided it was ugly. 
- Not all threads need to submit ENQCMD, force feeding the MSR probably
  isn't even required for all. Yes the overhead isn't probably big, but
  might not even be required for all threads.

We needed to fixup MSR in two different way. To keep the code simple, the
choice was to only fixup on #GP, that eliminated the extra code we need to
support case1.

Cheers,
Ashok
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
