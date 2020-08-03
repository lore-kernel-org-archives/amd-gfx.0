Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A2C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 19:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C02206D7
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 19:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C02206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA5F6E2EA;
	Mon,  3 Aug 2020 19:00:17 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABE96E2FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 17:19:47 +0000 (UTC)
IronPort-SDR: oa1b7AWQngxZZUJdz9gKP3PXL3TKsCiU8w6eX25m1OrTFDM7ZoiQ6rF8uqHL+HOANazZOhxTco
 khccyu9bYSyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="213694294"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="213694294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 10:19:47 -0700
IronPort-SDR: KtHv35ANwZ8f7TkVfEpIBacjRUfJCoFDiYIqTEtwVJn0JL3JUXRZ6F9eqNCZZWvhjuk8Saq7H4
 s4Ctke6jmV9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="275358327"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
 by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2020 10:19:47 -0700
Date: Mon, 3 Aug 2020 17:19:47 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200803171947.GA329474@otcwcpicx6.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
 <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
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

Hi, Andy,

On Fri, Jul 31, 2020 at 06:28:37PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in the current thread's PASID MSR. The
> > #GP fault handler will initialize the MSR if a PASID has been allocated
> > for this process.
> 
> Let's take a step back here.  Why are we trying to avoid IPIs?  If you
> call munmap(), you IPI other CPUs running tasks in the current mm.  If
> you do perf_event_open() and thus acquire RDPMC permission, you IPI
> other CPUs running tasks in the current mm.  If you call modify_ldt(),
> you IPI other CPUs running tasks in the current mm.  These events can
> all happen more than once per process.
> 
> Now we have ENQCMD.  An mm can be assigned a PASID *once* in the model
> that these patches support.  Why not just send an IPI using
> essentially identical code to the LDT sync or the CR4.PCE sync?

ldt (or the other two cases) is different from ENQCMD: the PASID MSR
is per-task and is supported by xsaves.

The per-task PASID MSR needs to updated to ALL tasks. That means IPI,
which only updates running tasks' MSRs, is not enough. All tasks' MSRs
need to be updated when a PASID is allocated.

This difference increases the complexity of sending IPI to running tasks
and updating sleeping tasks's MSRs with locking etc.

Of course, it's doable not to update the MSRs in all task when a new PASID
is allocated to the mm. But that means we need to discard xsaves support
for the MSR and create our own switch function to load the MSR. That
increases complexity.

We tried similar IPI way to update the PASID in about 200 lines of code.
As Dave Hansen pointed, it's too complex. The current lazy updating the MSR
only takes essential 3 lines of code in #GP.

Does it make sense to still use the current fix up method to update the MSR?

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
