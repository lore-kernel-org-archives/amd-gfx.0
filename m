Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B1FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 15:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A43D8BAE0;
	Mon, 11 Jul 2022 15:24:03 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8AD8E987;
 Mon, 11 Jul 2022 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rcQF7iugd2cu8An1gTYADBIF1lWVn+jc8HlNL1UeLoM=; b=gVStaT9Kg0MMbppoH83xjPscGs
 IFbnv81Y2Qux27iyh2Ytl5RYRUv/rrc/FF853SfUcRswpEscsP7xj4ckdRrrmFlKVPdCkfjDFWPJV
 a6BE4mHwC98MjNV7ILSxNmudVQYo/YACzEjfygVSi9TN8tlCjTOLQQUWznoWY739TfIIQPlyYa2mY
 OsowUrkakCcxofte6qfDxJ43ipH5CUD9JiHbZadiUR5ps47qHAgjlAHSPevIEYvLqBZsGOC2JKq8i
 KFOLAViCUYEoLKdytMRp4fnJce4T+X2CknDxNQzRotjz/y2NXtCO92RF15eLW0OoWR33g46bZ3vax
 fHzP8VIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oAtxM-0060dO-5n; Mon, 11 Jul 2022 14:00:12 +0000
Date: Mon, 11 Jul 2022 15:00:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v8 07/15] mm/gup: migrate device coherent pages when
 pinning instead of failing
Message-ID: <Ysws7LOirtQ07JG/@casper.infradead.org>
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-8-alex.sierra@amd.com>
 <2c4dd559-4fa9-f874-934f-d6b674543d0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4dd559-4fa9-f874-934f-d6b674543d0f@redhat.com>
X-Mailman-Approved-At: Mon, 11 Jul 2022 15:24:02 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 Felix.Kuehling@amd.com, apopple@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 11, 2022 at 03:35:42PM +0200, David Hildenbrand wrote:
> > +		/*
> > +		 * Device coherent pages are managed by a driver and should not
> > +		 * be pinned indefinitely as it prevents the driver moving the
> > +		 * page. So when trying to pin with FOLL_LONGTERM instead try
> > +		 * to migrate the page out of device memory.
> > +		 */
> > +		if (folio_is_device_coherent(folio)) {
> > +			WARN_ON_ONCE(PageCompound(&folio->page));
> 
> Maybe that belongs into migrate_device_page()?

... and should be simply WARN_ON_ONCE(folio_test_large(folio)).
No need to go converting it back into a page in order to test things
that can't possibly be true.
