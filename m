Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDBC55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FCD206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PJU8eX+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FCD206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A18F6E9F0;
	Wed, 22 Apr 2020 06:56:12 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C2E89971
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 00:21:48 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id v7so790796qkc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hEPIJxk11M+bwls0ktX3yeu2tCbVhvYKkshsYLxwJ44=;
 b=PJU8eX+3xC4GFafdKdc5DzhySnCpoyt7nJs8v67HgDINaqKjejFlIyZkRz1SMGAhw7
 s7uCk6tfphwUwyiPpH9jqN9ymuNDMYIObXz70LxBi9HaysQdWxohkFGXN0RvWIlTxp/O
 tk8seckt54OXGh2bDVptRn4OT4fWVGdecI9gba+EmxFSinr4oBL1z6hGl1wB3yCT077w
 vbR/HQjg0rmYIXBXC6owWBUrSADfN+E7jMfKwzS6l5twx5JuWUw+KuKPdYjUryqiun37
 eUhKmuvUjIJxADNxWm6SAsdm2PXKSRXA+mhtSiWZ4LdaaJW+8+0i0QIXND3fe1+0a2J9
 rdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hEPIJxk11M+bwls0ktX3yeu2tCbVhvYKkshsYLxwJ44=;
 b=NJ1TdBJ/r7zg4fmB2P9crTP2V4tw1/QkTLAiZZAHIO2+FgHW0eMRqeTH1LD9ogamQj
 U+6iVUrol+VlcCeqIUrvz8VjyqIKT28TyFhSUqrdaJ4Yde12CfmFgTBkwA7DRhKyj83b
 8/ainxcZjWuBnaQR3zb4lS13vrQqY0RCxqUcvNn15pE5/Za/0+XW8Zni/S1ic9zZA5tR
 TKwz1p3tuRnqkE4QW3hqccE7U7f62h+81rbjYNqeOtaXvZSIJ2kuZuBL3jq/Hw80vvNE
 OPyhmHUcoiuhkH/zuefX5rIXttem7e8bK+Q8GmE99JqYZPxRe5Sm1UA8Ji1G9j0APc1H
 kDbQ==
X-Gm-Message-State: AGi0PuaPrBvf/gMdmX5Jltq9eX3xRsIsEkn1qmuMVW4M/sOQT8pLZH/g
 keyVDzMtgU8AMbEyxnQXJrGySQ==
X-Google-Smtp-Source: APiQypKNqeVCSfFJPwxNHCrvjHy0VYH6Avw8SVeDX8eOa+urgHv9P1i8eAZ64MakyRhzM6BfopRBjw==
X-Received: by 2002:a37:8781:: with SMTP id
 j123mr24068830qkd.308.1587514908014; 
 Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id u27sm2859237qtc.73.2020.04.21.17.21.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jR398-0000BE-Gp; Tue, 21 Apr 2020 21:21:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH hmm 3/5] drm/amdgpu: remove dead code after hmm_range_fault()
Date: Tue, 21 Apr 2020 21:21:44 -0300
Message-Id: <3-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Apr 2020 06:54:54 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

Since amdgpu does not use the snapshot mode of hmm_range_fault() a
successful return already proves that all entries in the pfns are
HMM_PFN_VALID, there is no need to check the return result of
hmm_device_entry_to_page().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index efc1329a019127..bff8e64701a547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -862,17 +862,13 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 		goto out_free_pfns;
 	}
 
-	for (i = 0; i < ttm->num_pages; i++) {
-		/* FIXME: The pages cannot be touched outside the notifier_lock */
+	/*
+	 * Due to default_flags, all pages are HMM_PFN_VALID or
+	 * hmm_range_fault() fails. FIXME: The pages cannot be touched outside
+	 * the notifier_lock, and mmu_interval_read_retry() must be done first.
+	 */
+	for (i = 0; i < ttm->num_pages; i++)
 		pages[i] = hmm_device_entry_to_page(range, range->pfns[i]);
-		if (unlikely(!pages[i])) {
-			pr_err("Page fault failed for pfn[%lu] = 0x%llx\n",
-			       i, range->pfns[i]);
-			r = -ENOMEM;
-
-			goto out_free_pfns;
-		}
-	}
 
 	gtt->range = range;
 	mmput(mm);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
