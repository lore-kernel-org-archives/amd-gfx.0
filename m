Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7EBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A485206FA
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A485206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD426EB65;
	Thu, 18 Jun 2020 15:40:08 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9698F6EB5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 15:37:48 +0000 (UTC)
IronPort-SDR: NXuw5SMGh844p9VYPJqyFYciPpt0sDivnmB/2Mi+pnUfQanMlrclFAkEwqatC+YQEBVDffC38w
 zzg575yxvWPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="160725887"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; d="scan'208";a="160725887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 08:37:48 -0700
IronPort-SDR: CzS5MoOz9LW2W8ufcf7VltJ40EwQvdPZ9f1UIByPKyXcF7fjAaxqMgTRiN1ED9CIyfAtjpBrfb
 JU43hSx3nDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; d="scan'208";a="291807299"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 18 Jun 2020 08:37:47 -0700
Date: Thu, 18 Jun 2020 08:37:47 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 02/12] ocxl: Change type of pasid to unsigned int
Message-ID: <20200618153747.GE15763@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-3-git-send-email-fenghua.yu@intel.com>
 <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Thu, 18 Jun 2020 15:40:07 +0000
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
 Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Frederic,

On Thu, Jun 18, 2020 at 10:05:19AM +0200, Frederic Barrat wrote:
> =

> =

> Le 13/06/2020 =E0 02:41, Fenghua Yu a =E9crit=A0:
> >PASID is defined as "int" although it's a 20-bit value and shouldn't be
> >negative int. To be consistent with type defined in iommu, define PASID
> >as "unsigned int".
> =

> =

> It looks like this patch was considered because of the use of 'pasid' in
> variable or function names. The ocxl driver only makes sense on powerpc a=
nd
> shouldn't compile on anything else, so it's probably useless in the conte=
xt
> of that series.
> The pasid here is defined by the opencapi specification
> (https://opencapi.org), it is borrowed from the PCI world and you could
> argue it could be an unsigned int. But then I think the patch doesn't go =
far
> enough. But considering it's not used on x86, I think this patch can be
> dropped.

The first 3 patches clean up pasid and flag defitions to prepare for
following patches.

If you think this patch can be dropped, we will drop it.

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
