Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5AACCA47C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 01:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699A010E26A;
	Thu, 30 Jun 2022 01:04:24 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA07810E288;
 Wed, 29 Jun 2022 23:24:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 710AD614D9;
 Wed, 29 Jun 2022 23:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB1C34114;
 Wed, 29 Jun 2022 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1656545053;
 bh=Dnxtg2+47dMB9fvk3mpZuwgNcKCi6p+et4oU9iDj/kY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=yIUhyRd1UmOnjNmm25XNKViGfXOi0X4HOJ10GLIlf13tTMKTjOUKLDyQ4Z2DbDg0O
 cVQjech3q/YmOGPV9iO+PcS3fpGyfcUYsFfe1708PQjUEfslyL6ytDB/D+Pq4Yvxiq
 Yqsj0t71BtS8NGnMPbzTZ5t6X4C+LtXr/VhhiUbg=
Date: Wed, 29 Jun 2022 16:24:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
Message-Id: <20220629162412.d6aa0bf6244e487e4279fc31@linux-foundation.org>
In-Reply-To: <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-2-alex.sierra@amd.com>
 <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
 <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jun 2022 01:04:23 +0000
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
 willy@infradead.org, David Hildenbrand <david@redhat.com>, apopple@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, jgg@nvidia.com,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 29 Jun 2022 18:08:40 -0400 Felix Kuehling <felix.kuehling@amd.com> wrote:

> >
> > I'd have called it "is_longterm_pinnable_page", but I am not a native
> > speaker, so no strong opinion :)
> 
> I think only the patch title has the name backwards. The code uses 
> is_longterm_pinnable_page.

Patch title was quite buggy ;) I made it "mm: rename is_pinnable_page()
to is_longterm_pinnable_page()" in my copy.


