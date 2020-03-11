Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB8C4CECE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4A520575
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="On0nSMgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4A520575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AE46E9EB;
	Wed, 11 Mar 2020 19:14:39 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7416E9E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:35:17 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id l13so2329704qtv.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XocowDuniR0hmNfpL1nEDZsX1TOc8gKZoEyeLoQxAU8=;
 b=On0nSMgzQD/BpXWJeG3hXripgnyMnySf+BC95POCcQqeO/TzGQajxSwEOoyuXJtnu9
 Cfx3f+Xjjn9Ee1s/v/MuIMr+SVLx7H7b1hMWPBCqfg+l6JS+9WMRPfQEczcnGusZzh+Y
 15/zHItu4eJaxFNVJYFq9I0qdDWF7UHAcr9ha3NYPnbyqFNembAnXROws9f7wDW67p0y
 3upwjd+YZigMo3GnsOPgN9fKtEQuJn8s/S9ZJefjtE7nRs8HH5QwgQTYKapfTZpgpWeD
 4n+8FpA3t8sOWGh/aaUkNXcy9C0l9AZdjs7ES4bsrq1pMQMtujg25B3xc3/zgDG4pype
 JtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XocowDuniR0hmNfpL1nEDZsX1TOc8gKZoEyeLoQxAU8=;
 b=lhQwVam6VSB9/Qpvn6XUS8nrEfiIZ7FBaJGA9SDprg7BBkup/MwdzsBsdVLWAZX+Zh
 468Z4XYge7WElwCwdm0K0b0jB+GZSzMdOGs87weOp4xNouy1cfZwPyknN7BhKg7kTBiC
 c6GAghZPdxWtfBG/tgKB5cXbe5fPp+ogYpMx/CoH1nac+AmXxhn0UNkVwqQqXCRnmkxj
 PBUkTnNCCDtvkTHRgUJXNqpoSbH45E0BOReKUkpe70CmXn73MTuBKxIeGGnasmMBUEgh
 mX+FyV7VQ0VWRwJK16rIx0xpn+vSuU5D85ysUmUJxTDbhi5U8MS0f8oeIoYqOl9q0LOu
 WWuw==
X-Gm-Message-State: ANhLgQ3y8wcgloA5tyt6ZLpeSzcnCfWI1v7FeOVy3Tm/QxsUlWmzb1U7
 2rnGsC++ieHzBSD8nklZDbchng==
X-Google-Smtp-Source: ADFU+vuHlgD4b9kXT5mtcSVhfQ4qfz45k/hdWlhMqHwFglRZBRjT/lnkg+9CGQkkuoKUS5C0N6Ncpw==
X-Received: by 2002:ac8:6685:: with SMTP id d5mr3989843qtp.170.1583951716238; 
 Wed, 11 Mar 2020 11:35:16 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id h5sm9213171qkc.118.2020.03.11.11.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 11:35:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jC6CI-000163-UO; Wed, 11 Mar 2020 15:35:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH  hmm 0/8] Various error case bug fixes for hmm_range_fault()
Date: Wed, 11 Mar 2020 15:34:58 -0300
Message-Id: <20200311183506.3997-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Mar 2020 19:14:38 +0000
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

The hmm_range_fault() flow is fairly complicated. The scheme allows the
caller to specify if it needs a usable result for each page, or if it only
needs the current page table status filled in. This mixture of behavior is
useful for a caller that wants to build a 'prefetch around fault'
algorithm.

Although we have no in-tree users of this capability, I am working on
having RDMA ODP work in this manner, and removing these bugs from
hmm_range_fault() is a necessary step.

The basic principles are:

 - If the caller did not ask for a VA to be valid then hmm_range_fault()
   should not fail because of that VA

 - If 0 is returned from hmm_range_fault() then the entire pfns array
   contains valid data

 - HMM_PFN_ERROR is set if faulting fails, or if asking for faulting
   would fail

 - A 0 return from hmm_range_fault() does not have HMM_PFN_ERROR in any
   VA's the caller asked to be valid

This series does not get there completely, I have a followup series
closing some more complex cases.

I tested this series using Ralph's hmm tester he posted a while back,
other testing would be appreciated.

Jason Gunthorpe (8):
  mm/hmm: add missing unmaps of the ptep during hmm_vma_handle_pte()
  mm/hmm: don't free the cached pgmap while scanning
  mm/hmm: do not call hmm_vma_walk_hole() while holding a spinlock
  mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
  mm/hmm: add missing call to hmm_range_need_fault() before returning
    EFAULT
  mm/hmm: reorganize how !pte_present is handled in hmm_vma_handle_pte()
  mm/hmm: return -EFAULT when setting HMM_PFN_ERROR on requested valid
    pages
  mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL
    handling

 mm/hmm.c | 166 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 79 insertions(+), 87 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
