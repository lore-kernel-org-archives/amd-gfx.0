Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00539C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 14:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D532067D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 14:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D532067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7584D6E992;
	Tue, 14 Jul 2020 14:48:10 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3856E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 13:54:50 +0000 (UTC)
IronPort-SDR: gd+ZGAvX5qzEePIxJGqLfwynfWO+UmJriDYch1oMOupgbPAmkeoUyLlQmbGvemo8U/KB9Sgo+Y
 WuC2dAeuAtUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128975199"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="128975199"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 06:54:50 -0700
IronPort-SDR: +XxidMzrv1a/8/8wXZ7LcHaInmy7T6RrqjR1IZ3hUJ3l6CBXlDbbvF1v1Acu2ApZ+1FOxRdw/u
 m41TaWmbXY1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="485370296"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 06:54:49 -0700
Date: Tue, 14 Jul 2020 06:54:49 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] iommu: Change type of pasid to u32
Message-ID: <20200714135449.GI32961@romley-ivt3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
 <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Tue, 14 Jul 2020 14:48:09 +0000
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

On Mon, Jul 13, 2020 at 07:45:49PM -0700, Liu, Yi L wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Sent: Tuesday, July 14, 2020 7:48 AM
> >
> > PASID is defined as a few different types in iommu including "int",
> > "u32", and "unsigned int". To be consistent and to match with uapi
> > definitions, define PASID and its variations (e.g. max PASID) as "u32".
> > "u32" is also shorter and a little more explicit than "unsigned int".
> >
> > No PASID type change in uapi although it defines PASID as __u64 in
> > some places.
> 
> just out of curious, why not using ioasid_t? In Linux kernel, PASID is
> managed by ioasid.

ioasid_t is only used in limited underneath files (ioasid.c and ioasid.h).
Instead of changing hundreds of places to use ioasid_t, it's better to
keep ioasid_t only used in the files.

And it's explict and matches with uapi to define PASID as u32. Changing
to ioasid_t in so many files (amd, gpu, crypto, etc) may confuse upper
users on "why ioasid_t".

So we had better to explicitly define PASID as u32 and keep ioasid_t in
the limited underneath files.

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
