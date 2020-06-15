Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ABC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 15:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44B42078E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 15:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44B42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4B36E365;
	Mon, 15 Jun 2020 15:47:48 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BED989D56
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 14:53:47 +0000 (UTC)
IronPort-SDR: Bs/k7cYNEJoN7c6GfUKYcWdpxIps+Pyr9PlDSOZlAvn5bWw3/lxc8r/VZ5A14OFVfCZg/oepTY
 OYLaXZ/PgmfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 07:53:46 -0700
IronPort-SDR: hBkuUtQL8+lhTWXLYi651EBCBrGOEnQVfzIuldPKgK9Hg1HqC5sQmkx3kq2cejv4s2HjL2N4xD
 LCQ6U6PgIXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; d="scan'208";a="382567032"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 07:53:46 -0700
Date: Mon, 15 Jun 2020 07:53:46 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/12] x86: tag application address space for devices
Message-ID: <20200615145345.GA13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <20200615075202.GI2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615075202.GI2497@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Mon, 15 Jun 2020 15:47:47 +0000
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
On Mon, Jun 15, 2020 at 09:52:02AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 05:41:21PM -0700, Fenghua Yu wrote:
> 
> > This series only provides simple and basic support for ENQCMD and the MSR:
> > 1. Clean up type definitions (patch 1-3). These patches can be in a
> >    separate series.
> >    - Define "pasid" as "unsigned int" consistently (patch 1 and 2).
> >    - Define "flags" as "unsigned int"
> > 2. Explain different various technical terms used in the series (patch 4).
> > 3. Enumerate support for ENQCMD in the processor (patch 5).
> > 4. Handle FPU PASID state and the MSR during context switch (patches 6-7).
> > 5. Define "pasid" in mm_struct (patch 8).
> > 5. Clear PASID state for new mm and forked and cloned thread (patch 9-10).
> > 6. Allocate and free PASID for a process (patch 11).
> > 7. Fix up the PASID MSR in #GP handler when one thread in a process
> >    executes ENQCMD for the first time (patches 12).
> 
> If this is per mm, should not switch_mm() update the MSR ? I'm not
> seeing that, nor do I see it explained why not.

PASID value is per mm and all threads in a process have the same PASID
value in the MSR. However, the MSR is per thread and is context switched
by XSAVES/XRSTROS in patches 6-7.

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
