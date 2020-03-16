Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE17EC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFD920658
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b4PO6Gx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFD920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CA289BFF;
	Mon, 16 Mar 2020 19:13:15 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E356E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 19:04:45 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id n1so5709591qvz.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BWUlD7DMxUCjadcoWlHWZLSyInqh6sPVvbrJFhGcEXw=;
 b=b4PO6Gx41wgIvNR75/iEEHqP7YeAWOo5I4vM1hYEixFuze+GD6DaYqoq6TC5z6ZmrJ
 Ay/5Z5n3+GxgulTlewop2xKyUtwkOsk/3xSb3Dci9QGrROQg0xNI4SUrd6gZB6+izdNe
 N1pEZM8nEhG8cFaafaI7oaJVEsr/RZaSPAOGp/dvEqzcI/FlL1EmhGf5oLnxpn5fsFMX
 0vDAhrju1L63wESfxt4lt2sv7hw8jBZVFlY4uyOJvCMiAZXPlnY61hAjM+L2/9omI9RE
 eSIpwURT9g78RsWcH396M8bdPtPAtYe5mLGXoaunFXluYfTsfHTzArNAe1Kq2Vj3zALv
 DJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BWUlD7DMxUCjadcoWlHWZLSyInqh6sPVvbrJFhGcEXw=;
 b=MXYK9T8ZuQYY0dwUi2wn4/HNgGPIYkLQXh0IZJiPJ3NiNbYh3UkkYauSy8eOcEyLGQ
 2IaDMHjs4gz6lVse1UYp/ciEx4Kxf5hJb5VNwRt5HJ7UyLtckHbUSuvU+3EWsyeRuVr/
 deC0Ne2MLecngH3PwpLAMEf9IQ6Z6UlRqZaqmPCbGznPJMGgfreBw5qcR/HBKdDGXhm8
 VoTE4EPf9REhyEYZd5t0nFPzmvVOcKBMmimDxUB7s7IQaKz3yJz+rdIqh0ddNGY1NhOb
 tsWJFI4/5dI3cVVJ2jQbM5hKe5876UnUPI92+OCXdIGNt2U0r6ezxG1FO+8TnsXNdpZ/
 Ms1A==
X-Gm-Message-State: ANhLgQ2W/nxIocCQgx9HILB6U4D2U7Rfp45mCAgnEyFylTpT5vOBvDjQ
 L/BpXlSayDmhm+IzbEGZOoiICQ==
X-Google-Smtp-Source: ADFU+vupCuGjSfz+zG9xNUf8/b9EmEfqnAO4l1aoYhG7XjmfvRH/QvbrSw7U+oPGZcF3Uap4STtBfQ==
X-Received: by 2002:ad4:4847:: with SMTP id t7mr1236975qvy.237.1584385484358; 
 Mon, 16 Mar 2020 12:04:44 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x19sm407776qtm.47.2020.03.16.12.04.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 12:04:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDv2Z-0006k6-7W; Mon, 16 Mar 2020 16:04:43 -0300
Date: Mon, 16 Mar 2020 16:04:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 2/2] mm: remove device private page support from
 hmm_range_fault
Message-ID: <20200316190443.GM20941@ziepe.ca>
References: <20200316175259.908713-1-hch@lst.de>
 <20200316175259.908713-3-hch@lst.de>
 <c099cc3c-c19f-9d61-4297-2e83df899ca4@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c099cc3c-c19f-9d61-4297-2e83df899ca4@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 19:13:14 +0000
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Bharata B Rao <bharata@linux.ibm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 11:42:19AM -0700, Ralph Campbell wrote:
> 
> On 3/16/20 10:52 AM, Christoph Hellwig wrote:
> > No driver has actually used properly wire up and support this feature.
> > There is various code related to it in nouveau, but as far as I can tell
> > it never actually got turned on, and the only changes since the initial
> > commit are global cleanups.
> 
> This is not actually true. OpenCL 2.x does support SVM with nouveau and
> device private memory via clEnqueueSVMMigrateMem().
> Also, Ben Skeggs has accepted a set of patches to map GPU memory after being
> migrated and this change would conflict with that.

Other than the page_to_dmem() possibly doing container_of on the wrong
type pgmap, are there other bugs here to fix?

Something like this is probably close to the right thing to fix that
and work with Christoph's 1/2 patch - Ralph can you check, test, etc?

diff --git a/mm/hmm.c b/mm/hmm.c
index 9e8f68eb83287a..9fa4748da1b779 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -300,6 +300,20 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 				range->flags[HMM_PFN_DEVICE_PRIVATE];
 			cpu_flags |= is_write_device_private_entry(entry) ?
 				range->flags[HMM_PFN_WRITE] : 0;
+
+			/*
+			 * If the caller understands this kind of device_private
+			 * page, then leave it as is, otherwise fault it.
+			 */
+			hmm_vma_walk->pgmap = get_dev_pagemap(
+				device_private_entry_to_pfn(entry),
+				hmm_vma_walk->pgmap);
+			if (!unlikely(!pgmap))
+				return -EBUSY;
+			if (hmm_vma_walk->pgmap->owner !=
+			    hmm_vma_walk->dev_private_owner)
+				cpu_flags = 0;
+
 			hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
 					   &fault, &write_fault);
 			if (fault || write_fault)

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
