Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC5DC47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 23:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0710F613D8
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 23:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0710F613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52816F4F3;
	Thu, 27 May 2021 23:10:59 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35796F4F3;
 Thu, 27 May 2021 23:10:58 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id e17so2258856iol.7;
 Thu, 27 May 2021 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hyMnVQT3uILhsayUiB51yYlscbJXei219nOcfMZbk0g=;
 b=ndasi/1WhYCH93Zprui/GY40/sn19ao3HLj2XT2v9EbazWcigmdEugKPhYF0n+yT6/
 r90yLFnoxKRv4zHSeUCR6aRAK2G4JXu9lCBMk2OC7M3y5j41ApJyGGWLSEiZvYr+/Iw7
 EoWG/0tcEi1Za1aImy3BIlTABk7lIRYgfs1f5Vf5EbQamG8Ga/Z7fqRphGxadI9PWZtZ
 j9ZmGl+5QTm3SB8QXpLXxAnznbsX8v9BJ8T9BFTvTdbYVGnTZhs6qn32xzJQfOOa6+sj
 zR36KQWCvD8Tz/MU1YxGj7IYqhLJRSPt7aoffgsDK8WEG5sLd/t4whHwulfZG+3RNdbM
 ldYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hyMnVQT3uILhsayUiB51yYlscbJXei219nOcfMZbk0g=;
 b=bbw+6URBkqtNlmXS7lWH/Ztovq/8oLWse87lQfWAe2hWTHErQTha9n/0UbrEZzmLmq
 Xv91NWORR/TceEMM16bEfleXnn+3eRGccgPYSjgsqRS+ljvMeISiJGNnum0cADB8AhLv
 OPhc2GRx+LfcAnmDSC7rDhlTnIhZMZfn7MkbCnIQTUuregaIG4tv1/+Qzrri4+pgrhui
 sM9tZsdmkOy+W8u1fFHwnwpAzNZtb8g9Xj4rSj3DglINrzOCKe30iGzZEeu4eJjAaj1y
 EuKNNFMhdIH11vzBtM+PS4ukDthjfLlOYiqQj9b0WH/YkyFAxJ0vNJ7+G0nkWcGAB5Vw
 H1gA==
X-Gm-Message-State: AOAM53026JcF85tti0Z4/JktTC51mVL0qHnzDU4+SLjasNP//Qv/vaLZ
 /4sUDsLWn4S1w48TCQftyqs=
X-Google-Smtp-Source: ABdhPJy41x9vuWRCqnDRM6SkBRLwhShGggcTKxx9ubB3k12ssllC99aPqznxBEX133FPxW+i4upInQ==
X-Received: by 2002:a05:6602:2ccf:: with SMTP id
 j15mr4777023iow.56.1622157058325; 
 Thu, 27 May 2021 16:10:58 -0700 (PDT)
Received: from Harpoon.amd.com ([165.204.55.251])
 by smtp.gmail.com with ESMTPSA id r5sm1860014ilb.1.2021.05.27.16.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 16:10:40 -0700 (PDT)
From: Felix Kuehling <felix.kuehling@gmail.com>
X-Google-Original-From: Felix Kuehling <Felix.Kuehling@amd.com>
To: felix.kuehling@amd.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] mm: add generic type support for device zone page
 migration
Date: Thu, 27 May 2021 19:08:08 -0400
Message-Id: <20210527230809.3701-5-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527230809.3701-1-Felix.Kuehling@amd.com>
References: <20210527230809.3701-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
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
Cc: Alex Sierra <alex.sierra@amd.com>, dri-devel@lists.freedesktop.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, jgg@nvidia.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

This support is only for generic type anonymous memory.
Generic type with zone device pages require to take an extra reference,
as it's done with device private type.
Also, support added to migrate pages meta-data for generic device type.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 mm/migrate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 20ca887ea769..33e573a992e5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -380,7 +380,8 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
 	 * Device private pages have an extra refcount as they are
 	 * ZONE_DEVICE pages.
 	 */
-	expected_count += is_device_private_page(page);
+	expected_count +=
+			(is_device_private_page(page) || is_device_generic_page(page));
 	if (mapping)
 		expected_count += thp_nr_pages(page) + page_has_private(page);
 
@@ -2607,7 +2608,7 @@ static bool migrate_vma_check_page(struct page *page)
 		 * FIXME proper solution is to rework migration_entry_wait() so
 		 * it does not need to take a reference on page.
 		 */
-		return is_device_private_page(page);
+		return is_device_private_page(page) | is_device_generic_page(page);
 	}
 
 	/* For file back page */
@@ -3069,10 +3070,12 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 		mapping = page_mapping(page);
 
 		if (is_zone_device_page(newpage)) {
-			if (is_device_private_page(newpage)) {
+			if (is_device_private_page(newpage) ||
+			    is_device_generic_page(newpage)) {
 				/*
-				 * For now only support private anonymous when
-				 * migrating to un-addressable device memory.
+				 * For now only support private and devdax/generic
+				 * anonymous when migrating to un-addressable
+				 * device memory.
 				 */
 				if (mapping) {
 					migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
