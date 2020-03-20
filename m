Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1568C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9297220709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NaCjjzld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9297220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213C36E1BA;
	Fri, 20 Mar 2020 17:21:23 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAE56E1A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 16:58:23 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id e11so7545297qkg.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=87iKgwaPy8pXzXL9YA5WV3WZml27jYwBmFGI1UGSVUk=;
 b=NaCjjzldyTssF/3z0KZL0Fqab/MMlCzRVjrru2siMv9BUoCtsVnQTd1gi0e4g7Bv7C
 7lWk8bdKCdsAa8UzZNISAM9HmDetrX83wCNt9BSFlOheErwFqT8tMGKNvHewjQr45veO
 HWg6Vy16BlP0KGklKKcCiS4VNcLzsIKutYoiODMmJPm1d2altsZ0q+sdSgGp2+g62JZb
 3CyCsoqW0ZnZ0HCHgfI/B0TdbvC598XLc03bFzjXoW1P352HHxZ0KJ8lx/pW9bAVegn3
 mG+bqtTK0HVO+f8zqeTr/natEqIDzoAw+jhHbk3xIlfLbjCkv7KSx/3qYUaodlY+D0bf
 kGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=87iKgwaPy8pXzXL9YA5WV3WZml27jYwBmFGI1UGSVUk=;
 b=KS0Ob183muhQHKd82jQcxdAmJM6OBkvkA2DzdOBpw08sttgFHSwGrE+T3wNN2ScPgV
 h976aKyRURNanw4354zokvXUTqF6GUc3wmh2iu4g+V0WyfufpfO4n+vTLqNd2a7oPfkF
 Vjitpy8R/VUF7f+xovkP5c8vGUN4HJ3ZwdpLE8OcZ83ssi2z1NP6Zd5co2rOFOCfgTVh
 WI1dGvq6i1yew9n7FkJAqR2Slt/Uko2NZJ+3OpjcyL/MJcbYoq6aFQMvzCSvoo+TtYHg
 ViGBiZxq/87/2xJQqSm/u4RwuBz7n0c8gzaXn87JgUIB3EXfGEQcxFu1vvjjMW/RBjfJ
 0Y+g==
X-Gm-Message-State: ANhLgQ23llL58G/5JidzoA6cPNoAmYwZjkVWkveMhMWWgUgMq00xCwlD
 vzulpVhf884yz38JDjh0GzRQkDwDoLYX+A==
X-Google-Smtp-Source: ADFU+vvveuclm6zQpq1BtpQVw2AZCya6AVI9ugZ2/VnoudKnWPkwAxuYh/+4WEp0jmf9H9GqVc8R6Q==
X-Received: by 2002:a37:8581:: with SMTP id h123mr8465387qkd.158.1584723024381; 
 Fri, 20 Mar 2020 09:50:24 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x74sm4382043qkb.40.2020.03.20.09.50.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 09:50:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jFKql-0005jg-5N; Fri, 20 Mar 2020 13:50:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH hmm 0/6] Small hmm_range_fault() cleanups
Date: Fri, 20 Mar 2020 13:48:59 -0300
Message-Id: <20200320164905.21722-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
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

I've had these in my work queue for a bit, nothing profound here, just some
small edits for clarity.

Ralph's hmm tester will need a small diff to work after this - which
illustrates how setting default_flags == 0 is the same as what was called
SNAPSHOT:

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 6ca953926dc13f..5f31f5b3e64cb9 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -300,7 +300,7 @@ static int dmirror_range_fault(struct dmirror *dmirror,
 
 		range->notifier_seq = mmu_interval_read_begin(range->notifier);
 		down_read(&mm->mmap_sem);
-		count = hmm_range_fault(range, 0);
+		count = hmm_range_fault(range);
 		up_read(&mm->mmap_sem);
 		if (count <= 0) {
 			if (count == 0 || count == -EBUSY)
@@ -337,8 +337,7 @@ static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
 		.flags = dmirror_hmm_flags,
 		.values = dmirror_hmm_values,
 		.pfn_shift = DPT_SHIFT,
-		.pfn_flags_mask = ~(dmirror_hmm_flags[HMM_PFN_VALID] |
-				    dmirror_hmm_flags[HMM_PFN_WRITE]),
+		.pfn_flags_mask = 0,
 		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
 				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
 		.dev_private_owner = dmirror->mdevice,
@@ -872,7 +871,7 @@ static int dmirror_range_snapshot(struct dmirror *dmirror,
 		range->notifier_seq = mmu_interval_read_begin(range->notifier);
 
 		down_read(&mm->mmap_sem);
-		count = hmm_range_fault(range, HMM_FAULT_SNAPSHOT);
+		count = hmm_range_fault(range);
 		up_read(&mm->mmap_sem);
 		if (count <= 0) {
 			if (count == 0 || count == -EBUSY)
@@ -916,7 +915,7 @@ static int dmirror_snapshot(struct dmirror *dmirror,
 		.flags = dmirror_hmm_flags,
 		.values = dmirror_hmm_values,
 		.pfn_shift = DPT_SHIFT,
-		.pfn_flags_mask = ~0ULL,
+		.pfn_flags_mask = 0,
 		.dev_private_owner = dmirror->mdevice,
 	};
 	int ret = 0;

Jason Gunthorpe (6):
  mm/hmm: remove pgmap checking for devmap pages
  mm/hmm: return the fault type from hmm_pte_need_fault()
  mm/hmm: remove unused code and tidy comments
  mm/hmm: remove HMM_FAULT_SNAPSHOT
  mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef
  mm/hmm: use device_private_entry_to_pfn()

 Documentation/vm/hmm.rst                |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |   2 +-
 include/linux/hmm.h                     |  55 +-----
 mm/hmm.c                                | 238 +++++++++---------------
 5 files changed, 98 insertions(+), 211 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
