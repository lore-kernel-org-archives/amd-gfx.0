Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F0C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1978F20716
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LO8u6Sf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1978F20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8327A6EA75;
	Fri, 27 Mar 2020 20:24:44 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9F56EA75
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 20:00:33 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id v7so12236976qkc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w7HT384dLquXkifrMSaPZlakZIt6uG6pSy8/vMIPtTg=;
 b=LO8u6Sf1tFMYHfFgs/mRngqSax2KnXlZcJO3p0Dc+bnFdWQ3mFI2oTFey6thDTmmaF
 6vQSVW9hkX0MF2gHtADWhz2PG6//81Sy+koWSRmlUtdE4JkEDlbi+Hl7e9/fJkqBDQ1W
 wZGR9Wj/y9vVjDnX6QH2oWytEcLS1b2oPoz2PvXkTnw7cdsqRkzHAarbUERdJ7ThoQ/X
 cjfSJj6agzko8pFrT99pB+ejxChHQOTwCS/jnyQVX3vj5kkIgnEKBBVdjZ6Uyg+MCpb7
 McioaeQ1NszNr6YE8lMUcEsAudEty68BJWZfarn6H3IuArhauChB9pgs+awHkyiMwPkH
 VdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w7HT384dLquXkifrMSaPZlakZIt6uG6pSy8/vMIPtTg=;
 b=uNZtqeXRak1bJHZ00W76p/9wlWZUxA2eLjMC/KoWmJ0Y6D82Q2EWTOG8NJDCRLBoRp
 kRxRDWVM4LTz2F0efvsaSg2hyQ/LpfxG+41XNGvmLGB0ZNOMHIBlrGtG+eSQcQr82dfh
 REtQHr5X/82DSSudOd1erurX/VlAKX4wA3eoVRf+auye4V7lDoI9rij8spse21sLR+tU
 sooN4DCA79O1eTevKowU5XyP4IlGGbIQMzISLkUG8ieo+x9Lsf5DHv8MPK25mLIwZY0x
 ih7IPYhWVBcb3IOOlQYeIMPxFGWuMoWFXDNHyzp5VqQP31Bcgwox05R+eQcdNklvpyZW
 eWwQ==
X-Gm-Message-State: ANhLgQ3fjG3xujmwyHk+VWeKKy7cz1hSICDSgvdY5CwpmX2OutNhC/4s
 GkzFwOFVKel5GB43fxMaCk35gPPWqdp4Hw==
X-Google-Smtp-Source: ADFU+vsV4R08VNgi3U0EcEDSpq36V0bb1XOE53WhiumJ5wLNMq9YlKH0bNPjhSJsWggFm8HqFwZeRw==
X-Received: by 2002:a37:86c4:: with SMTP id i187mr1090284qkd.110.1585339232485; 
 Fri, 27 Mar 2020 13:00:32 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id n64sm4367174qkf.23.2020.03.27.13.00.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Mar 2020 13:00:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jHv9V-0007g4-98; Fri, 27 Mar 2020 17:00:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 7/9] mm/hmm: do not unconditionally set pfns when
 returning EBUSY
Date: Fri, 27 Mar 2020 17:00:19 -0300
Message-Id: <20200327200021.29372-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200327200021.29372-1-jgg@ziepe.ca>
References: <20200327200021.29372-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Mar 2020 20:24:43 +0000
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

In hmm_vma_handle_pte() and hmm_vma_walk_hugetlb_entry() if fault happens
then -EBUSY will be returned and the pfns input flags will have been
destroyed.

For hmm_vma_handle_pte() set HMM_PFN_NONE only on the success returns that
don't otherwise store to pfns.

For hmm_vma_walk_hugetlb_entry() all exit paths already set pfns, so
remove the redundant store.

Fixes: 2aee09d8c116 ("mm/hmm: change hmm_vma_fault() to allow write fault on page basis")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 3303686bf16d24..dc826898979bc5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -244,11 +244,11 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	pte_t pte = *ptep;
 	uint64_t orig_pfn = *pfn;
 
-	*pfn = range->values[HMM_PFN_NONE];
 	if (pte_none(pte)) {
 		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
 		if (required_fault)
 			goto fault;
+		*pfn = range->values[HMM_PFN_NONE];
 		return 0;
 	}
 
@@ -269,8 +269,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		}
 
 		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
-		if (!required_fault)
+		if (!required_fault) {
+			*pfn = range->values[HMM_PFN_NONE];
 			return 0;
+		}
 
 		if (!non_swap_entry(entry))
 			goto fault;
@@ -488,7 +490,6 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	orig_pfn = range->pfns[i];
-	range->pfns[i] = range->values[HMM_PFN_NONE];
 	cpu_flags = pte_to_hmm_pfn_flags(range, entry);
 	required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags);
 	if (required_fault) {
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
