Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A133C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 20:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050B720658
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 20:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nsCUT+96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050B720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977EE6E4CF;
	Mon, 16 Mar 2020 20:15:19 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E816E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 20:09:31 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id l13so15407279qtv.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PDNAD6S4KTd0gVi/XavugH3SkseCvoY3JtPvtDkTohU=;
 b=nsCUT+96D3VjNsrl2Pj9woIM6G1+L/e49spoRATL4fYjDKCmMd79hBVnO7MFyaCD1E
 H69sQ7R6uU7FU1kcv0npVCqHpzMBtsvzDK28Pfw8oN0s3CNOZ7+TbImmjH8HhEb/Yvdx
 ZG3uBlKT8XbAsY+s/pCfiSC3PXRh+bHBVMDz5a3bPc3ch47yOIAYnLcRAYKXiXB3N6I2
 jKc2tog/kKDGW+zuxi6eIrzxrsWorBN3cVgs8d7fBlFPY8tOruUkf6N4YQJhaUkJ8eHZ
 Memms57s9EmDz1lMImGj4va9n96e8vXoFpeBuA+HvVvzgW9e98ej1R2E3nBP0qv2Md/p
 Yt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PDNAD6S4KTd0gVi/XavugH3SkseCvoY3JtPvtDkTohU=;
 b=iAbxZZPnwl9jserE8LFDsn8xQpEhmjinwY5rLq5I/G92qf3QVZJjOFKyb9A5cwiHdk
 ZoILSu4NpwwyiH/0k6aucvmopLtxyH0Ch4gs3EtNXIo4BvyOTxAqNYyVL9c9V9ikFAYA
 coZhhJ4ulz8kt8Vj7KOcEZyNemgpAFdm2/5Tj1v2Vjw6Dt0uFOT7T3bNHszieMIliDnB
 m4Sr2tVFuJEaIz0mgstKViKHJNqof5tjv6MlBVc9gTiYkODk02pwYAgbkIqezhVOLaZr
 yR5PlYTYaAX+0TwOtL23dCFMDmYvxtiVIDDUPQtDNxqxiQaaMQurUMA8QoRZtsclpmBG
 eyIw==
X-Gm-Message-State: ANhLgQ3VqgKCWCtKwn4nfr6S69IIMrTZWMusT22BAB2NP43OmYm7QXkz
 Twyu26aWCEcjOEtTEsKxPZ2Rwg==
X-Google-Smtp-Source: ADFU+vvdX8KgG8/0KMMaE8Eeq2N9rxxz03kyvkaJo4ff8RQccEfxQBSqW5ZD+n9+Mwx3iLq3b9YiFA==
X-Received: by 2002:ac8:5193:: with SMTP id c19mr1934353qtn.204.1584389370366; 
 Mon, 16 Mar 2020 13:09:30 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id t7sm516565qtr.88.2020.03.16.13.09.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 13:09:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDw3F-0007G3-BI; Mon, 16 Mar 2020 17:09:29 -0300
Date: Mon, 16 Mar 2020 17:09:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm: remove device private page support from
 hmm_range_fault
Message-ID: <20200316200929.GB20010@ziepe.ca>
References: <20200316175259.908713-1-hch@lst.de>
 <20200316175259.908713-3-hch@lst.de>
 <c099cc3c-c19f-9d61-4297-2e83df899ca4@nvidia.com>
 <20200316184935.GA25322@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316184935.GA25322@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 20:15:18 +0000
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
Cc: Ralph Campbell <rcampbell@nvidia.com>, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 07:49:35PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 16, 2020 at 11:42:19AM -0700, Ralph Campbell wrote:
> >
> > On 3/16/20 10:52 AM, Christoph Hellwig wrote:
> >> No driver has actually used properly wire up and support this feature.
> >> There is various code related to it in nouveau, but as far as I can tell
> >> it never actually got turned on, and the only changes since the initial
> >> commit are global cleanups.
> >
> > This is not actually true. OpenCL 2.x does support SVM with nouveau and
> > device private memory via clEnqueueSVMMigrateMem().
> > Also, Ben Skeggs has accepted a set of patches to map GPU memory after being
> > migrated and this change would conflict with that.
> 
> Can you explain me how we actually invoke this code?
> 
> For that we'd need HMM_PFN_DEVICE_PRIVATE NVIF_VMM_PFNMAP_V0_VRAM
> set in ->pfns before calling hmm_range_fault, which isn't happening.

Oh, I got tripped on this too

The logic is backwards from what you'd think.. If you *set*
HMM_PFN_DEVICE_PRIVATE then this triggers:

hmm_pte_need_fault():
	if ((cpu_flags & range->flags[HMM_PFN_DEVICE_PRIVATE])) {
		/* Do we fault on device memory ? */
		if (pfns & range->flags[HMM_PFN_DEVICE_PRIVATE]) {
			*write_fault = pfns & range->flags[HMM_PFN_WRITE];
			*fault = true;
		}
		return;
	}

Ie if the cpu page is a DEVICE_PRIVATE and the caller sets
HMM_PFN_DEVICE_PRIVATE in the input flags (pfns) then it always faults
it and never sets HMM_PFN_DEVICE_PRIVATE in the output flags.

So setting 0 enabled device_private support, and nouveau is Ok.

AMDGPU is broken because it can't handle device private and can't set
the flag to supress it.

I was going to try and sort this out as part of getting rid of range->flags

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
