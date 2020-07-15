Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F7C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2655A2064C
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2655A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF1D6E115;
	Thu, 16 Jul 2020 10:28:57 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6C56E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 23:32:02 +0000 (UTC)
IronPort-SDR: Gg9QIFUXOHhAheJj258srdt6wPMJ7o0mAilrLGM6wAScyA1jeF5yw4NXGEj/lQFI7XZbzukgNd
 K6k4+wqtpc6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="210822713"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; d="scan'208";a="210822713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 16:32:00 -0700
IronPort-SDR: cZvsAGDgpGF+2NbxakPS01kIeZEkM3esK0Xo0RC0msz+O1PuaVl0fyjRi+rZ8CiAPRiGdMsLcJ
 Mfelb6mDMgGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; d="scan'208";a="308429363"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2020 16:32:00 -0700
Date: Wed, 15 Jul 2020 16:32:00 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200715233200.GD64320@romley-ivt3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-4-git-send-email-fenghua.yu@intel.com>
 <DM5PR11MB1435394EDA593222F19F3BF8C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435394EDA593222F19F3BF8C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Thu, 16 Jul 2020 10:28:56 +0000
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
Cc: Peter Zijlstra <peterz@infradead.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Borislav Petkov <bp@alien8.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Luck, Tony" <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Yi,

On Mon, Jul 13, 2020 at 08:25:20PM -0700, Liu, Yi L wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Sent: Tuesday, July 14, 2020 7:48 AM
> > From: Ashok Raj <ashok.raj@intel.com>

Thank you for your comments!

But I think we don't need to update this patch because the current text
is better than suggested changes. I would rather to keep this patch
unchanged. Please see my following explanations for details.

> > +(PRI) allow devices to function much the same way as the CPU handling
> > +application page-faults. For more information please refer to PCIe
> > +specification Chapter 10: ATS Specification.
> > +
> 
> nit: may be helpful to mention Chapter 10 of PCIe spec since 4.0. before that, ATS has its
> own specification.

This doc only refers to the latest specs. Older specs are not useful
for this spec.

> > +ENQCMD is the glue that ensures applications can directly submit
> > +commands to the hardware and also permit hardware to be aware of
> > +application context to perform I/O operations via use of PASID.
> > +
> 
> maybe a reader will ask about ENQCMDs after reading ENQCMD/S spec. :-)

This doc only covers ENQCMD. ENQCMDS is out of scope of this doc.

> > +- Allocate the PASID, and program the process page-table (cr3) in the
> > +PASID
> > +  context entries.
> 
> nit: s/PASID context entries/PASID table entries/

Kernel IOMMU does use PASID context. So we would keep the current text.

> 
> > +- Register for mmu_notifier() to track any page-table invalidations to
> > +keep
> > +  the device tlb in sync. For example, when a page-table entry is
> 
> not only device tlb. I guess iotlb is also included.

I think they are same/similar concepts. No need to duplicate here.

> > +it into the new MSR to communicate the process identity to platform hardware.
> > +ENQCMD uses the PASID stored in this MSR to tag requests from this process.
> > +When a user submits a work descriptor to a device using the ENQCMD
> > +instruction, the PASID field in the descriptor is auto-filled with the
> > +value from MSR_IA32_PASID. Requests for DMA from the device are also
> > +tagged with the same PASID. The platform IOMMU uses the PASID in the
> 
> not quite get " Requests for DMA from the device are also tagged with the
> same PASID"

The DMA access from device to the process address space uses the same PASID
set up in the MSR.
 
> 
> > +transaction to perform address translation. The IOMMU api's setup the
> 
> s/api's/apis/ ?


> 
> > +corresponding PASID entry in IOMMU with the process address used by the CPU
> > (for e.g cr3 in x86).
> 
> with the process page tables used by the CPU (e.g. the page tables pointed by cr3 in x86).

We use address to match the "address space" specified in the term of PASID.
page table is implementation details. So we would keep the current text.

> > +The MSR must be configured on each logical CPU before any application
> 
> s/MSR/MSR_IA32_PASID/

The MSR refers to MSR_IA32_PASID. We don't need to repeat long
"MSR_IA32_PASID" everywhere while a short "the MSR" is better and clear
in the doc.

> > +thread can interact with a device. Threads that belong to the same
> > +process share the same page tables, thus the same MSR value.
> 
> s/MSR/PASID/

The "MSR" is better because we focus on the MSR value here that is set up for
each thread.

> 
> > +
> > +PASID is cleared when a process is created. The PASID allocation and
> 
> s/PASID/MSR_IA32_PASID/

No. It is PASID that is cleared per process creation. We are not talking about
the MSR here although the MSR will cleared as part of process FPU init.

> 
> > +MSR programming may occur long after a process and its threads have been
> > created.
> > +One thread must call bind() to allocate the PASID for the process. If a
> 
> s/bind()/iommu_sva_bind_device()/ or say "call iommu api to bind a process with
> a device." :-)

bind() is better because the binding function may be changed (e.g. it was
changed in 5.8). People know bind() means binding. Even in the future the
binding function is changed again, we don't need to change the text here
if using bind().

> 
> > +thread uses ENQCMD without the MSR first being populated, it will cause #GP.
> > +The kernel will fix up the #GP by writing the process-wide PASID into
> > +the thread that took the #GP. A single process PASID can be used
> > +simultaneously with multiple devices since they all share the same address space.
> 
> simultaneously with multiple devices if they all share the process address
> space.

Using "since" is better. It explains "why".

> 
> > +
> > +New threads could inherit the MSR value from the parent. But this would
> 
> s/MSR/MSR_IA32_PASID/

Ditto. It's unnecessary to use long "MSR_IA32_PASID" everywhere.
"The MSR" is concise and clear.

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
