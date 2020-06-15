Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F37C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 18:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF8320656
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZsZQvXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF8320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2246E4CD;
	Mon, 15 Jun 2020 18:55:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D45E6E4C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kaLeQNKpwo/3pmt93qdeNrph7VCKxinWeBQB+muxlqU=; b=kZsZQvXl1NJZtySSQyofXqG2gJ
 LGW3VjHm9TuX25UqvO3KZKb2oOIY9GxryxwgyWiyhctAhFfedcv/u0AMokGAfuDcuQv/YwEGvsQmY
 8hielzOiarmpwSn/5Z/0ZHjthHpnyNcIvvdozZPWoKwXF1+6ZCXlGxvI5cc6bKSJLMgkeQfJy9onI
 UNvacJvt2GszmscxRPRxdOJ3tSlgyXdm46wtChlF5IIN4RMh0tlBKzaD0+BDmhBAEVFIMAXXXwcY2
 cISoF7L3RZDb4UNipJqrTeB82lsBma2Gf1fHVAikvl9tjy6NvvycYEJ6lHhJjlERcYaO3c4E8tvMX
 H2PwgC9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkttx-000598-1L; Mon, 15 Jun 2020 18:32:09 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7A7430604B;
 Mon, 15 Jun 2020 20:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B5E05203DCA15; Mon, 15 Jun 2020 20:32:04 +0200 (CEST)
Date: Mon, 15 Jun 2020 20:32:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615183204.GE2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181921.GA33928@otc-nc-03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615181921.GA33928@otc-nc-03>
X-Mailman-Approved-At: Mon, 15 Jun 2020 18:55:20 +0000
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
 Dave Jiang <dave.jiang@intel.com>, Joerg Roedel <joro@8bytes.org>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 15, 2020 at 11:19:21AM -0700, Raj, Ashok wrote:
> On Mon, Jun 15, 2020 at 06:03:57PM +0200, Peter Zijlstra wrote:
> > 
> > I don't get why you need a rdmsr here, or why not having one would
> > require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> > 
> > > > > +	 */
> > > > > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > > > > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > > > > +		return false;
> > > > > +
> > > > > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > > > > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > 
> > How much more expensive is the wrmsr over the rdmsr? Can't we just
> > unconditionally write the current PASID and call it a day?
> 
> The reason to check the rdmsr() is because we are using a hueristic taking
> GP faults. If we already setup the MSR, but we get it a second time it
> means the reason is something other than PASID_MSR not being set.
> 
> Ideally we should use the TIF_ to track this would be cheaper, but we were
> told those bits aren't easy to give out. 

Why do you need a TIF flag? Why not any other random flag in current?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
