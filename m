Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB6C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7379420709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Lmt+5Qnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7379420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304796E1BC;
	Fri, 20 Mar 2020 17:21:23 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155AB6E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 16:57:46 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id i13so3568463pfe.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=plnR+AZUQA4jCFYWVdv/wzRwNH8DzG0o2FQjh9+mrVM=;
 b=Lmt+5Qnlb7tZ275uEF6CrSndb1nH26tPFDzh2G1CUyCkxbm+gfTR/9UE3crQdDlJQh
 zmDaHW+IgXVtcdbAmv4hoLUSr5lYkwBNwHpy0XvkP82YNW5ma7lMC3aBxDeZeT2kmy1U
 2nAs/Opt9M0EKy6+Kh7fhaf32m2Di4KqjejRG9g0z4FnY2Pat8Htb0koubS/nf9KAPFs
 PSI4nUpk4CKGkqKtCWfJHuhhF+pADywPoMWjBRV3PCt6hQfR0Dgo7gdQXneMMYC7477Y
 ca/pQG/eWdcoGxoPCQJSbqxDMQwRysQoyM3BtxSKQP6+VSgziwwAYZeerX5zHFkfh2Hp
 cLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=plnR+AZUQA4jCFYWVdv/wzRwNH8DzG0o2FQjh9+mrVM=;
 b=sTstzZV2Ei31TyOejpD1aQZZl3qzXBiF5oEZOQwu03jTybDHHda8sZF6w9c3or6rEZ
 7/Paj5D1i+yBBqqN6pq1J6vsfsPFUiPdRuwe+ECnNkEJ28GimvJlRzq/XL6W3ueIJrrQ
 P+c9fiJJc1PgjDuzqRCoY7kqGQXOM1MqDNmwlgeNxT+np20UXp7T9Zvj+WHe8Ng+7PGn
 HUQEZmynIqH+Pfj/tKTVZ1Of6rudkls255YUOvLxcyF8+Rc1zXnZ+Pup7HK/s1daazrO
 KDUwBEt3x9QsL4AKgyMYR4jnPepSt3tVwqB+b7bVWySt5UvL+D4UpKNQUjmMCrjXe769
 Xk1A==
X-Gm-Message-State: ANhLgQ3qZE70Cw6TkaiHOuLgAswmClb2dj1KNPTvOP3epka4LCDS0Oko
 QaEMEGkqFrIPrVfxdZJKL7ipomfU3HnZhA==
X-Google-Smtp-Source: ADFU+vtu5OS3SdeDn9uwmE+9CRkN0K3PbZf2rBY2gGT27gwYaZlGzWtAypX6nlEbkEhbBrccm2MO7w==
X-Received: by 2002:a05:6214:364:: with SMTP id
 t4mr4400809qvu.124.1584723027047; 
 Fri, 20 Mar 2020 09:50:27 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id 69sm4435782qki.131.2020.03.20.09.50.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 09:50:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jFKql-0005kO-Dn; Fri, 20 Mar 2020 13:50:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH hmm 5/6] mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef
Date: Fri, 20 Mar 2020 13:49:04 -0300
Message-Id: <20200320164905.21722-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320164905.21722-1-jgg@ziepe.ca>
References: <20200320164905.21722-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 20 Mar 2020 17:21:22 +0000
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

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 7f77fb6e35cf78..a09b4908e9c81a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -192,7 +192,6 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		unsigned long end, uint64_t *pfns, pmd_t pmd)
 {
@@ -215,11 +214,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
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
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
