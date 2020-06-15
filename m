Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C761C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 18:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE1120738
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 18:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE1120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A785A6E4C1;
	Mon, 15 Jun 2020 18:25:12 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2066E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 18:19:22 +0000 (UTC)
IronPort-SDR: 0HgD2a+QoXJxS/iilMhnMPRhFi95Kxfs+Tq4ttmxlylgq29LnDZl+1kXiBM0Y5AQAMDuBIe1i8
 xQaMxaT4gKmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 11:19:21 -0700
IronPort-SDR: SdtFHoff29V9KtkfxtvNK8UK0GFz3weIqBlZYoLU507VjZSQ/qwXtL4fCM6H4L+ZylJ6G3K3Og
 KpQCvO0hDJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; d="scan'208";a="382621179"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 11:19:21 -0700
Date: Mon, 15 Jun 2020 11:19:21 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615181921.GA33928@otc-nc-03>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615160357.GA2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Mon, 15 Jun 2020 18:25:11 +0000
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
 Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
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

On Mon, Jun 15, 2020 at 06:03:57PM +0200, Peter Zijlstra wrote:
> 
> I don't get why you need a rdmsr here, or why not having one would
> require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> 
> > > > +	 */
> > > > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > > > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > > > +		return false;
> > > > +
> > > > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > > > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> 
> How much more expensive is the wrmsr over the rdmsr? Can't we just
> unconditionally write the current PASID and call it a day?

The reason to check the rdmsr() is because we are using a hueristic taking
GP faults. If we already setup the MSR, but we get it a second time it
means the reason is something other than PASID_MSR not being set.

Ideally we should use the TIF_ to track this would be cheaper, but we were
told those bits aren't easy to give out. 

Cheers,
Ashok
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
