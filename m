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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735AC47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 20:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBD1613E3
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 20:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBD1613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DA06F4CB;
	Thu, 27 May 2021 20:56:14 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8F76F4C7;
 Thu, 27 May 2021 20:56:13 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id h11so1472005ili.9;
 Thu, 27 May 2021 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pe/cFaapJbxX6Jz6Zk1ehmG+ymWmsWcMKoth41aEtds=;
 b=PwbAU4oxKHNGnMdcyu/Rknpkbe6RbooFWgmZvbQmi57QZ0W5VCynxl3/cfalHtt3yE
 K7V2FeaPUxCYMjSIFuF39JeEbW8lzPlfmh/+FOeIOf1iBzirVrwwBQ1b2iIaCo+0xSvp
 ARpVv/JCM7OJYigcAESHgg/+LyxS+YSpUY2KEIRCbw0qY2jwra/NVav6B3JoOfapafvd
 7hlCruDn9sTAiT0N9th9Q5foTAo9vU+JQuLB4M5S+q2Q8S44zxyLZHp/7J8tM3tWxxOJ
 28c2pIAl1JNTiWDcLOLdjHSGn0gA953V+eDGRRqE8t1m4d21QSGi0Tx26MyjvrJrWQ/f
 QGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pe/cFaapJbxX6Jz6Zk1ehmG+ymWmsWcMKoth41aEtds=;
 b=kmF5e85ajl3N4pxqzcr3ZQ06c5sIMjbdi+9hjUOiAfESyxRkJ+obNG3SWO5lo8l3rT
 JioowKvX2PVXSW8G5IO0uO0CmROey+qtRqqiVWXmbKZLSagnSAVUZFn97/UJt7pcwgCf
 EKBYdVw5n25AtDChAk4FhXAW4tSvMXKRsAWUa03668T2BM8sqdLwW6JyCntJYD+F6Ycu
 4AK+SH824gUT0ZfMEhha9EiroMVLhFqX4Rjj2EEm/PfjFwrTwMdoYqbAw3OCkD9uYt0Z
 v+yDbVXeRCV/7eabrnlEsNNDOFryzZjhMt2qR/gshq5zcr63EAWj0wwqEs0I0gC8E4jT
 OVRA==
X-Gm-Message-State: AOAM533fmYAKU+aDRheHWJgCEFM5X1Btug1rHNV+9idcWs3gFrsiGJlh
 r4Gv1J/55cF2l5wLDckdMt2RYX08i0gLfg==
X-Google-Smtp-Source: ABdhPJy0ZikwCFfPlut2KTJKCyWQZz/ccCwDsVpxc+y/xNY59QIE6vQzBdIyVVrHNRXuBIlr+98x7w==
X-Received: by 2002:a92:cb42:: with SMTP id f2mr4335125ilq.71.1622148972183;
 Thu, 27 May 2021 13:56:12 -0700 (PDT)
Received: from Harpoon.amd.com ([165.204.55.251])
 by smtp.gmail.com with ESMTPSA id b10sm1577265ioz.35.2021.05.27.13.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 13:56:11 -0700 (PDT)
From: Felix Kuehling <felix.kuehling@gmail.com>
X-Google-Original-From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 03/10] drm/amdkfd: set owner ref to svm range prefault
Date: Thu, 27 May 2021 16:55:59 -0400
Message-Id: <20210527205606.2660-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527205606.2660-1-Felix.Kuehling@amd.com>
References: <20210527205606.2660-1-Felix.Kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

svm_range_prefault is called right before migrations to VRAM,
to make sure pages are resident in system memory before the migration.
With partial migrations, this reference is used by hmm range get pages
to avoid migrating pages that are already in the same VRAM domain.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 11f7f590c6ec..b298aa8dea4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -512,7 +512,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		 prange->start, prange->last, best_loc);
 
 	/* FIXME: workaround for page locking bug with invalid pages */
-	svm_range_prefault(prange, mm);
+	svm_range_prefault(prange, mm, SVM_ADEV_PGMAP_OWNER(adev));
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b939f353ac8c..54f47b09b14a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2646,7 +2646,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 /* FIXME: This is a workaround for page locking bug when some pages are
  * invalid during migration to VRAM
  */
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner)
 {
 	struct hmm_range *hmm_range;
 	int r;
@@ -2657,7 +2658,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
 	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 				       prange->start << PAGE_SHIFT,
 				       prange->npages, &hmm_range,
-				       false, true, NULL);
+				       false, true, owner);
 	if (!r) {
 		amdgpu_hmm_range_get_pages_done(hmm_range);
 		prange->validated_once = true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 4297250f259d..08542fe39303 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -176,7 +176,8 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
 void svm_range_free_dma_mappings(struct svm_range *prange);
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner);
 
 #else
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
