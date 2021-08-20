Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7CDC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42DA610A3
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C42DA610A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3776EA80;
	Fri, 20 Aug 2021 13:05:33 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2EA6E832;
 Fri, 20 Aug 2021 04:56:30 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id AD1156736F; Fri, 20 Aug 2021 06:56:27 +0200 (CEST)
Date: Fri, 20 Aug 2021 06:56:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
 jglisse@redhat.com
Subject: Re: [PATCH v6 02/13] mm: remove extra ZONE_DEVICE struct page refcount
Message-ID: <20210820045627.GA27083@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com>
 <20210813063150.2938-3-alex.sierra@amd.com>
 <7b821150-af18-f786-e419-ec245b8cfb1e@nvidia.com>
 <393e9815-838d-5fe6-d6ab-bfe7b543fef6@amd.com>
 <e155ed59-8c3c-4046-e731-f082ee4b10bb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e155ed59-8c3c-4046-e731-f082ee4b10bb@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Fri, 20 Aug 2021 13:05:32 +0000
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

On Wed, Aug 18, 2021 at 12:28:30PM -0700, Ralph Campbell wrote:
> Did you test on a system without CONFIG_ARCH_HAS_PTE_SPECIAL defined?
> In that case, mmap() of a DAX device will call insert_page() which calls
> get_page() which would trigger VM_BUG_ON_PAGE().

__vm_insert_mixed still ends up calling insert_pfn for the
!CASE_ARCH_HAS_PTE_SPECIAL if pfn_t_devmap() is true, which it should
be for DAX.  (and as said in my other mail, I suspect we should disallow
that case anyway, as no one can test it in practice).
