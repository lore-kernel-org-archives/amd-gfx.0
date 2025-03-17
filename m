Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97339C28B28
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 09:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B65B10E444;
	Tue, 18 Mar 2025 09:54:43 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B5910E17F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=kCP6P7yJ1EJoBeDBSv5lCGzst5JQBxOgm8I7ArCLzlg=; b=ZNmH1lkItLLY360TY75djLPMl2
 /UZ3iB+4CnNFCsMZPeKI09RjX0bavf5byHu7s1nz8KaB6uWZR16O4Z5Y3RLrz4Kmrmmvi9sTjv24G
 OnAULmm43gtrsu1Z2zLgUX/fCEjVRPoDrKM7W5DFJBG7JcEoMVvum6qVuruweP8rcZKQe12XnBPhz
 /4vDoxwfiREFOfenXWrjK0vUxAXC0dMWDHf+RnLU2i1lv1jng2t0UzIK7ljJXyi2k8RMst8DkCKOK
 7O3aw95orufCZeNas+1N1dAHMBETxzrXUTr+9suNC2UFQAJ8Q1EGPXQINGKTYvfmBKeZGmDpZDT0Y
 CEE0L+Og==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tuGGp-00000009RTO-1sAT; Mon, 17 Mar 2025 19:37:07 +0000
Date: Mon, 17 Mar 2025 19:37:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Where do ttm->pages come from?
Message-ID: <Z9h54wu2Nqbf4OqF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 18 Mar 2025 09:54:43 +0000
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

We're close to removing page->mapping from the kernel, and I've run into
amdgpu's use of page->mapping (setting it to ->dev_mapping and comparing
it against ->dev_mapping).

What I need to understand to know how to fix this properly is who
allocates these pages for what purpose?  I've got this far:

amdgpu_ttm_tt_set_user_pages() populates ttm->pages.
That's called from amdgpu_cs_parser_bos() which got e->userpages from
amdgpu_ttm_tt_get_user_pages().
amdgpu_ttm_tt_get_user_pages() got them from
amdgpu_hmm_range_get_pages()
amdgpu_hmm_range_get_pages() gets them from calling hmm_pfn_to_page()
which ... could get pages from anywhere?

But cleaarly they can't be _any_ pages because if they were anon or
file pages, overwriting page->mapping would blow up horribly today.
So they must be driver pages, but I can't see where they're allocated.
Is it ttm_pool_alloc_page()?
