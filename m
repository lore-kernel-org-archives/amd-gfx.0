Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D7AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 19:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9632860F23
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 19:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9632860F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FE689E5F;
	Tue, 12 Oct 2021 19:07:00 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D3C89BCD;
 Tue, 12 Oct 2021 19:03:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC15E60E09;
 Tue, 12 Oct 2021 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1634065405;
 bh=41ZgXWvJqX6cNDtIQEONvKgmB5mmWoA3gdKQ9esdOVk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=0blFRlQK51dgu5FJKOqFr1L6t3mVBbILK25yhOQvYbDuiPk4p/Xlmnu0gZa3KlXFG
 piH0prBBWaQ3m2nPz29jPiijWku3bv4yF077HespUJB5jDIWOWf1wBVn/h4JIWCJTW
 NDX7+IpzU2qmix0bc6QUcCtixPz37PA42oiuSsT8=
Date: Tue, 12 Oct 2021 12:03:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 linux-mm@kvack.org, rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, jglisse@redhat.com,
 apopple@nvidia.com
Subject: Re: [PATCH v1 00/12] MEMORY_DEVICE_COHERENT for CPU-accessible
 coherent device memory
Message-Id: <20211012120322.224d88dad0188160a40dd615@linux-foundation.org>
In-Reply-To: <20211012185629.GZ2744544@nvidia.com>
References: <20211012171247.2861-1-alex.sierra@amd.com>
 <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
 <20211012185629.GZ2744544@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 Oct 2021 19:06:59 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 12 Oct 2021 15:56:29 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:

> > To what other uses will this infrastructure be put?
> > 
> > Because I must ask: if this feature is for one single computer which
> > presumably has a custom kernel, why add it to mainline Linux?
> 
> Well, it certainly isn't just "one single computer". Overall I know of
> about, hmm, ~10 *datacenters* worth of installations that are using
> similar technology underpinnings.
> 
> "Frontier" is the code name for a specific installation but as the
> technology is proven out there will be many copies made of that same
> approach.
> 
> The previous program "Summit" was done with NVIDIA GPUs and PowerPC
> CPUs and also included a very similar capability. I think this is a
> good sign that this coherently attached accelerator will continue to
> be a theme in computing going foward. IIRC this was done using out of
> tree kernel patches and NUMA localities.
> 
> Specifically with CXL now being standardized and on a path to ubiquity
> I think we will see an explosion in deployments of coherently attached
> accelerator memory. This is the high end trickling down to wider
> usage.
> 
> I strongly think many CXL accelerators are going to want to manage
> their on-accelerator memory in this way as it makes universal sense to
> want to carefully manage memory access locality to optimize for
> performance.

Thanks.  Can we please get something like the above into the [0/n]
changelog?  Along with any other high-level info which is relevant?

It's rather important.  "why should I review this", "why should we
merge this", etc.

