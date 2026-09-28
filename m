Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23A9C9832F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D83610E860;
	Mon, 28 Sep 2026 08:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="vCL999nq";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3211410E774
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 05:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4ZS6kstd6BIICwqAN1M2ypMQk8KRKCHT0lhVaYKNm1A=; b=vCL999nq/HIPd5KJ+zOLTAyz4G
 Aw+mGCRquekPCRK6EW4p/d6S76wWDKPuh+mMXENLfmRIi4gbC2DdaKKzsGgZMNfNTZocf5qcOGgrn
 Qd+BdMZauAbgFut1usVOeVGIswhc+/dd9d3D5o2i2P6lpryuXbcqPzlZYPlmjwD0JwzLQKRZUCLhl
 6wMN4QhKY//mhh/rk6iba/taGwIG58PXYCMpH8q1P3BQVR54tPRo5kt/3UlGC2C06rzie1PDXSqy6
 jVDOaIJ8iSWGQpWuOUEdLwxdfeo7HId8mIXZovj6TNHeJwP/UXn/OapGxmd6S7g1Hzak2INU72ltH
 sVSnI2UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1xB3jc-0000000HLnt-2UJA;
 Mon, 28 Sep 2026 05:17:04 +0000
Date: Sun, 27 Sep 2026 22:17:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <arn4UPLhYJeNNxnZ@infradead.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924225018.GB16465@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:43:05 +0000
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

On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> > +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
> 
> Last time we hardwired the GPU and IOMMU drivers together it was a
> huge mess to undo.

Every time a driver depends on an exact iommu driver is a major design
problem.

> Why does the GPU driver have to request this? Why can't the iommu
> driver know that this is a special device that can use this magic fast
> path and then auto set it when identity is asked for?
>
> How does the GPU driver even know it is magic special?

Yes.  And WTF is "perfopt" supposed to mean.  Everything is a
performance optimization.

