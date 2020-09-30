Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FEEC4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 22:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F36E206F7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 22:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mwGFiDJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F36E206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07346E830;
	Wed, 30 Sep 2020 22:18:36 +0000 (UTC)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21256E830;
 Wed, 30 Sep 2020 22:18:35 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7503d50000>; Wed, 30 Sep 2020 15:16:53 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 22:18:31 +0000
Received: from agoins-ThinkPad-P50.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via
 Frontend Transport; Wed, 30 Sep 2020 22:18:30 +0000
From: Alex Goins <agoins@nvidia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH RFC 0/1] drm/ttm: Allocate transparent huge pages without
 clearing __GFP_COMP
Date: Wed, 30 Sep 2020 17:18:20 -0500
Message-ID: <20200930221821.13719-1-agoins@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601504213; bh=tMz3LKthgMWnzr+Vh8IQBgPkRR2AQ1/d22RThpXsnoY=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
 b=mwGFiDJ29YNCR0H+y/SRd0On62HFQ+reIG+9/N/VhoHqenLu8TGk9HKHlC56iB4cs
 MVOm9C3Pq4p1ai3t7MZGhJrMmvA2It9getxhN8IAOJ8K9LVt92G3euxwFv75pi9bh+
 v0tuhThKhhNBASSNhAdh7DD3I6a4Bzr+/9xYRHZDyhWHAQ2zGdkoxcgoy2FdBSyDDv
 /c7TOZeoGy8pEhjXDcHYa3aRz+rLgRhp4ksb/LUSIGLGcII9gb6baAXhikiHpbv/oR
 Vl6V8QQzU/HyIDwCjKUO1nS7CdRh5zTR2qMlG2xdJcHpsCeRna2p09i4yUD7mmuV5u
 BR9dG8ExpM9BQ==
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
Cc: Alex Goins <agoins@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 amd-gfx@lists.freedesktop.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

I've been looking into the DMA-BUFs exported from AMDGPU / TTM. Would
you mind giving some input on this?

I noticed that your changes implementing transparent huge page support
in TTM are allocating them as non-compound. I understand that using
multiorder non-compound pages is common in device drivers, but I think
this can cause a problem when these pages are exported to other drivers.

It's possible for other drivers to access the DMA-BUF's pages via
gem_prime_import_sg_table(), but without context from TTM, it's
impossible for the importing driver to make sense of them; they simply
appear as individual pages, with only the first page having a non-zero
refcount. Making TTM's THP allocations compound puts them more in line
with the standard definition of a THP, and allows DMA-BUF-importing
drivers to make sense of the pages within.

I would like to propose making these allocations compound, but based on
patch history, it looks like the decision to make them non-compound was
intentional, as there were difficulties figuring out how to map them
into CPU page tables. I did some cursory testing with compound THPs, and
nothing seems obviously broken. I was also able to map compound THP
DMA-BUFs into userspace without issue, and access their contents. Are
you aware of any other potential consequences?

Commit 5c42c64f7d54 ("drm/ttm: fix the fix for huge compound pages") should
probably also be reverted if this is applied.

Thanks,
Alex

Alex Goins (1):
  drm-ttm: Allocate compound transparent huge pages

 drivers/gpu/drm/ttm/ttm_page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
