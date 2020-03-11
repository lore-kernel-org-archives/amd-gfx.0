Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA39C2BAEE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB1C20575
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oj2+9cL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB1C20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04EA6E9E8;
	Wed, 11 Mar 2020 19:14:39 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAF76E9E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:35:18 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id e20so2350359qto.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eYOHMjSMYAiqyn3S+V97OaKejU5YnzW7DlF+2YMOcF0=;
 b=Oj2+9cL+KscU9a9zK4Suzl5t1bo3inZGbyVIq9f/zeCmxkVp6hpJxKiilnqnMZQ/FY
 88384yWaxGdO7AK2SvS4w/5ttmUJ1QwwiIIQkIru3m4YEvr6DVRfcc2LZX2b+WisWs3x
 Q9/ZJPxajspOeqvaygRv/+e66+A+86ngTjF2dHCc+iW767kCXhfOPdAWbvM9qhpvmh52
 a1hdeiAzVdj1EC+964oWge4gJ1EvDWASPw6bKneNMxHD5zeTPMdbLleLYVkd/wi+PWZ9
 2CJq/Ge+3bDYLHuaBaG8pI2c5Dwhg7JguuNwrBTyac857oUPLrhjtOnYkU9jB4pEhySk
 Wr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eYOHMjSMYAiqyn3S+V97OaKejU5YnzW7DlF+2YMOcF0=;
 b=ECMGpf0EmzPXkhuBxN6daQUwCYu+92U07NLGC14Ovj6nEZ3EyRPlEL7e66ByOCBtXS
 LnKZBGVKCiAbQGzjSG8+8+ZPr0wFiSp1CCPLTi0E/iJ8IChb91wbUfskCdherY5K7CHk
 j3apJNaAJ/BQ2aQRdu1ShbuMuJxA9OGXXVyW62gDqp/GxY/b9mMOPkPyIqhu1S+RQ8E6
 OkSzfm64iGAp5AraNA3Wnp5txkZHWCzlkrbOKHQiccy5ZZbC7Wkfi6r8ZSrbrzK36oEe
 KvEA02Qv9BX+3D4zBH2eZOX3gcZ3ZTa2QrK4IhEPEdXqVOFbgthNlR/FhCTJdZJljD40
 Jk4w==
X-Gm-Message-State: ANhLgQ1LFVneraAvlfKGXuoRJyyF9aglPfWSrpAMYvD8YBrXPaOZqvDg
 ARnVcVsnX9ZjXuAwS+h6jQEuwQ==
X-Google-Smtp-Source: ADFU+vvtZI7GOONaM2bhtDz46uIiycc1D5Nn8U4YJ8Luo17HKLeSzNTw8qbnVEqbl89i5RN+bVZ38Q==
X-Received: by 2002:ac8:1758:: with SMTP id u24mr4036108qtk.148.1583951716868; 
 Wed, 11 Mar 2020 11:35:16 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id u26sm948048qku.97.2020.03.11.11.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 11:35:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jC6CJ-00016R-6m; Wed, 11 Mar 2020 15:35:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH  hmm 4/8] mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
Date: Wed, 11 Mar 2020 15:35:02 -0300
Message-Id: <20200311183506.3997-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311183506.3997-1-jgg@ziepe.ca>
References: <20200311183506.3997-1-jgg@ziepe.ca>
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

All success exit paths from the walker functions must set the pfns array.

A migration entry with no required fault is a HMM_PFN_NONE return, just
like the pte case.

Fixes: d08faca018c4 ("mm/hmm: properly handle migration pmd")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 32dcbfd3908315..5f5ccf13dd1e85 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -394,7 +394,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			pmd_migration_entry_wait(walk->mm, pmdp);
 			return -EBUSY;
 		}
-		return 0;
+		return hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
 	} else if (!pmd_present(pmd))
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
