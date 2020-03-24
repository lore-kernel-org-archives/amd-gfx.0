Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B2BC4332B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 08:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB6120409
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 08:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HhKFH+h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB6120409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893B56E46B;
	Tue, 24 Mar 2020 08:14:18 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745A189E35
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 01:15:14 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id 10so13715419qtp.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 18:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8z+Ak8LJ4cusnv639Xm98KV9Wso4IbiTcHYELSH/G24=;
 b=HhKFH+h9dsFIf1c+y5ZAjNcHJkLfL/7TByr8KqLLVhFohTYKwWhXx2XiETLziarPtW
 HmC89Ua/ZfOQ53NE5bjqh2YkzI3VjXOn9sjDenilAjM2tgLtIs+v5bMY3AnTgGPB6sBY
 b1oed859g52WVKLkm7EBX27mr9X3LBNTceG4ymOTF3BxLJp8wDGWq+wXPMW1orpJA3y1
 o4TLZlvcbSHFVCu7RdAGl/h2z1hO8vJNXGZX6OIQ3uwn+EpAbkt+7b1ZXGgMMqMoOzpy
 FqJ5FKyR0qY7mwkSGi6gaRmlHxT/E4dqGkJiaugNvgjpT+6iFBJR1xYGeMw1Je2MPBe6
 BQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8z+Ak8LJ4cusnv639Xm98KV9Wso4IbiTcHYELSH/G24=;
 b=eeWwQg8NH5O5TLrz0VGfLLL8x+J8iYem/FHjtKN30+yFtfBwjFbtVh8CRGBIrrN881
 pIfpSnqqaiTHRUlKa+Ll2SklnYetqOpcRKhCCIDZ9WHMQiJKwTCMBou2NENxlNdo987H
 3i4C+tzlYqvCp1JuLBSu/tHD2io1cllqk7aL5mYf3Fx6k8Yl+rnb+loZtWsTV2f7vNnJ
 ZwqG/cljSDg4V5+k0jGEBHCkJ0o/2FQl8Zy5AtFyp6sC0onVLO+v5T78OjIVnIE/m+s2
 r+ZgzpfBFsCloXDVb/Ke5tHDns9G3JvaiCZXmRmlcRgR9zRX2gNKL12y7/xYJwTTJnCD
 8FYA==
X-Gm-Message-State: ANhLgQ22Pg1PrR6bghpSplqWRQa11QwhLOxSk4aHcso0dA0UYrUObX4l
 yHrgDLdANpAeUhJpARlr0eTa9w==
X-Google-Smtp-Source: ADFU+vtZbGElVq6NnluuIoEaJ5hmkuMgLimt1kzM3fgd1S4xdMrXicEqcrH3LtFkdjgiw9dY0n+5gA==
X-Received: by 2002:ac8:3105:: with SMTP id g5mr3662259qtb.358.1585012513624; 
 Mon, 23 Mar 2020 18:15:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id l13sm12025440qke.116.2020.03.23.18.15.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Mar 2020 18:15:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jGY9u-0000rC-9H; Mon, 23 Mar 2020 22:15:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 5/9] mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE
 #ifdef
Date: Mon, 23 Mar 2020 22:14:53 -0300
Message-Id: <20200324011457.2817-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324011457.2817-1-jgg@ziepe.ca>
References: <20200324011457.2817-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 24 Mar 2020 08:14:14 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

This code can be compiled when CONFIG_TRANSPARENT_HUGEPAGE is off, so
remove the ifdef.

The function is only ever called under

   if (pmd_devmap(pmd) || pmd_trans_huge(pmd))

Which is statically false if !CONFIG_TRANSPARENT_HUGEPAGE, so the compiler
reliably eliminates all of this code.

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 43d107a4d9dec6..f59e59fb303e95 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -198,7 +198,6 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		unsigned long end, uint64_t *pfns, pmd_t pmd)
 {
@@ -221,11 +220,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	hmm_vma_walk->last = end;
 	return 0;
 }
-#else /* CONFIG_TRANSPARENT_HUGEPAGE */
-/* stub to allow the code below to compile */
-int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
-		unsigned long end, uint64_t *pfns, pmd_t pmd);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool hmm_is_device_private_entry(struct hmm_range *range,
 		swp_entry_t entry)
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
