Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC041C83008
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 14:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE88206C0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 14:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE88206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BBA6E4D0;
	Tue, 28 Apr 2020 14:10:12 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9066E443;
 Tue, 28 Apr 2020 14:03:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7569968CEC; Tue, 28 Apr 2020 16:02:57 +0200 (CEST)
Date: Tue, 28 Apr 2020 16:02:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents misuse
Message-ID: <20200428140257.GA3433@lst.de>
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com>
 <20200428132005.21424-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Tue, 28 Apr 2020 14:10:10 +0000
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
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 28, 2020 at 03:19:48PM +0200, Marek Szyprowski wrote:
> 1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
>    a proper sg_table entries and call respective DMA-mapping functions
>    and adapt current code to it

That sounds reasonable to me.  Those could be pretty trivial wrappers.

>
> 
> 2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
>    which one refers to which part of the scatterlist; I'm open for
>    other names for those entries

nr_cpu_ents and nr_dma_ents might be better names, but it still would be
a whole lot of churn for little gain.  I think just good wrappers like
suggested above might be more helpful.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
