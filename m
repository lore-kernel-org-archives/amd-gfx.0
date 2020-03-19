Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0032BC4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 01:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C4620767
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 01:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a9OAhtzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C4620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728446E0A6;
	Thu, 19 Mar 2020 01:42:16 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1AC6E9A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 00:28:51 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id v38so118480qvf.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DIzPGl46tibPTC4Nr1Fne3idEkZVxe0vRVzC9BmYyk8=;
 b=a9OAhtzpaqy8M7ZOiBkM5EuSVHd4yNecpRtC8dRP+l2pPqyfnSd8K92zu0TfGABk1Q
 hYEfZ+7acI2k/zKRdQldlZU6QmFtX2HRogB/BKnbdEtsKAhQeU6fd+MnUlz8ghM8TEw4
 4FSfDydFj/Zz5Td34FIN8pCf7ZG9IBYZHl9AGTNXWI1pvNTxE9cBf86JQxD+vBXs5Fu+
 P3YN0S0cijWwxtWJa0nTOxVZ/FIsv/TFStTBQI0wKucqAubr3tyWjsrl2pHJSEDRw/1M
 2hLIJPL3HFVUmwFiwQrI21J4bRRmujEiUZiEYQWN4CJhod6KqfASdjQsItMOv/RwHOO/
 50tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DIzPGl46tibPTC4Nr1Fne3idEkZVxe0vRVzC9BmYyk8=;
 b=hl2mOVVicEDFsbvAL2p0YHFcn6kLN0onMVczXRXRVmKPDvMq/a+Wnm+DvpGJS04q8u
 ll3Pc2NOWbwQGhagRNhURpRgFOGeH8QF0h9HKM8Y3egj1ZtQmZiYMUcHSFgPN04bMKQB
 YUrVaZbIgCaej4y1TTKgZDDbEsh4lduq2mcgc/bpUzeUgjygqWnAaj7LqaQUU6fmyLRZ
 BTEzj3kpdTOuobTkcSU7qYsuqGvKrSE0OkosdCNk6dSpm8Wc0wzyme04P6WLes//ksiK
 9Y0X5LNXnNmu3JGfesX/q9EV/WLvXFFsk3OzdwjAvOH2m6lVVlV+XsJmuK32n/4/6FdD
 iqRg==
X-Gm-Message-State: ANhLgQ1yx2IRBsowpcSk9dnz6eWIKjIVAfbQNGLsRrovO35b5SmItZoU
 awJEwcLpEjaEbO3Xa3rEQpFF9A==
X-Google-Smtp-Source: ADFU+vvSjLkx34MB68Vj6dW6PS73cWO5A0gn+n/cmS/y+KLQ6+BjGr0q6lYXU7A7Xm/H0ApV84kRRw==
X-Received: by 2002:a0c:e7c3:: with SMTP id c3mr620345qvo.62.1584577730703;
 Wed, 18 Mar 2020 17:28:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id u123sm433965qkf.77.2020.03.18.17.28.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Mar 2020 17:28:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jEj3J-000273-Ln; Wed, 18 Mar 2020 21:28:49 -0300
Date: Wed, 18 Mar 2020 21:28:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: ensure device private pages have an owner v2
Message-ID: <20200319002849.GG20941@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316193216.920734-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 19 Mar 2020 01:42:15 +0000
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
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 08:32:12PM +0100, Christoph Hellwig wrote:
> When acting on device private mappings a driver needs to know if the
> device (or other entity in case of kvmppc) actually owns this private
> mapping.  This series adds an owner field and converts the migrate_vma
> code over to check it.  I looked into doing the same for
> hmm_range_fault, but as far as I can tell that code has never been
> wired up to actually work for device private memory, so instead of
> trying to fix some unused code the second patch just remove the code.
> We can add it back once we have a working and fully tested code, and
> then should pass the expected owner in the hmm_range structure.
> 
> Changes since v1:
>  - split out the pgmap->owner addition into a separate patch
>  - check pgmap->owner is set for device private mappings
>  - rename the dev_private_owner field in struct migrate_vma to src_owner
>  - refuse to migrate private pages if src_owner is not set
>  - keep the non-fault device private handling in hmm_range_fault

I'm happy enough to take this, did you have plans for a v3?

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
