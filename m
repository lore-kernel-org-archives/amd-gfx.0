Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 07:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232B661073
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 07:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 232B661073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CD96E239;
	Fri, 15 Oct 2021 07:25:43 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BDA6E1A3;
 Thu, 14 Oct 2021 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fxcLVRG2Jku0ajx1R51YzWOEmjfFWOgHA52RS+phND0=; b=hJChu81HMFnOk2mOnqyhd+aZtv
 3RzV8zPkoJkUHzUTz5GgiZ+listhRDQekfOBkR90UtQ2T1RzDS9xEDu+Xg8X6MpGuaPXdTpJENrP+
 N9lL4PeVE+DrKuffpedBb6bGoElR+WBOPDTHCqD/0FdDaj2E3SOaJdIB8LZ0jOe1/lg1Wx2fVq29b
 /pGZtjz7ji+oGbkLPezf8ivP5RJ20y0B2SqhEYs3dFDfEWnNSUQoHSWexPFklVi1xKgZUBUzD4jvp
 Z0D9PwJQldNvfJyOvWouJg6sE1rfP4OM+KHdUwffPvVoYHqOKxa84aqjmiMUJprcaZXS2lBIKYutb
 cHcfxkiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mb3mJ-008SzI-UQ; Thu, 14 Oct 2021 16:40:35 +0000
Date: Thu, 14 Oct 2021 17:40:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alex Sierra <alex.sierra@amd.com>
Cc: akpm@linux-foundation.org, Felix.Kuehling@amd.com, linux-mm@kvack.org,
 rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
 jglisse@redhat.com, apopple@nvidia.com
Subject: Re: [PATCH v1 1/2] ext4/xfs: add page refcount helper
Message-ID: <YWhdd7IFspw0wicW@casper.infradead.org>
References: <20211014153928.16805-1-alex.sierra@amd.com>
 <20211014153928.16805-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014153928.16805-2-alex.sierra@amd.com>
X-Mailman-Approved-At: Fri, 15 Oct 2021 07:25:38 +0000
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

On Thu, Oct 14, 2021 at 10:39:27AM -0500, Alex Sierra wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add a helper function to hide this detail.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
