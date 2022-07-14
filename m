Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A81C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 13:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E131F10FB3A;
	Thu, 14 Jul 2022 13:23:22 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4544310ED86
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 13:23:20 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id g1so2370620edb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C9zyBXNABTrUP8L52hdntmTqNlGKEhbykzlkjNJJbIY=;
 b=pEIs6HfeSpjOSZo+217ZW1f56bmDG7u10BxalFy8yhShCLquxvnfZVGjLTsj/oP7TJ
 kfHzzNcLjsoOc4ngaJ7yehkHg5CFMy7OnI1Pp3Y9fttvTEYR8NNH04J0fdEIWx+UH3BH
 Yz5mlnsLuqDkses92LKcaOkCvYVxN2XvnHTv8QrgNd/8RFwUgm9Ai4Y8QhZsx2F5orIF
 VlNlbWMhBi2XfrH15NzsJHsgl5dwWVBZjQfJzghEvOyOTLUzeYdJQJnY6h3/EEaJmpqK
 /5KBJjItbUFxvA9C3AYg29i4jLHANw5uUjKM3Pls2joav/F887/L+tzNzIsBcSH5zLf3
 NAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C9zyBXNABTrUP8L52hdntmTqNlGKEhbykzlkjNJJbIY=;
 b=mS9U5SHVHBgmzHdNdZFa0l6GuUW8CAeLZ9qC6sQd65hCB1CN1NNy9iShFNZiHvrPqv
 lBHydy2xt8mJERPJniqdiik8QY9gKKYpHSkhY7CYZGy1DwtALlr5Gy16SrzcmIL+y3Y3
 wVi/demff2k/7sPsFiVP0PcR3KDNvKS/IPRX5xoKanPg6Rq7AnMuDzplnTj4xerq445L
 SLkNC+jzH6s62dlQkHdpFsDuysucVSdLaebzgExVqKwHN0T3z63HqC1TxeWIApYfafuc
 Rhu7aLl7PC4nXj+UpdX81r5KuMEdiqGIA+04rFDmMrdsfMQ7QQ0akCE1EKTCCJmhTyA3
 GY+w==
X-Gm-Message-State: AJIora+EPYRDYadfFiw1iW3H1BYBu73ZjDnUu2NuOCwnqVd2MNa182n/
 wEBfYQx/ZUvvHSY6LQ/Xr9Db1JC4/Vs=
X-Google-Smtp-Source: AGRyM1sAsFnsvTKy4YqHclfTBPcVcmG0ZJscLdJuYk6A1zqFexQBMto0TLLHSJlSQ2DknW2JVyi7iA==
X-Received: by 2002:a05:6402:48c:b0:43a:8bc7:f440 with SMTP id
 k12-20020a056402048c00b0043a8bc7f440mr12186497edv.8.1657804998428; 
 Thu, 14 Jul 2022 06:23:18 -0700 (PDT)
Received: from EliteBook.fritz.box (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 ek9-20020a056402370900b0042de3d661d2sm1035399edb.1.2022.07.14.06.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 06:23:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: re-apply "move internal vram_mgr function
 into the C file""
Date: Thu, 14 Jul 2022 15:23:15 +0200
Message-Id: <20220714132315.587217-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714132315.587217-1-christian.koenig@amd.com>
References: <20220714132315.587217-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This re-applys commit 708d19d9f362766147cab79eccae60912c6d3068.

The original problem this was reverted for was found and the correct fix
will be merged to drm-misc-next-fixes.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 27 ------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 51d9d3a4456c..7a5e8a7b4a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -50,6 +50,35 @@ to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
 	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
 }
 
+static inline struct drm_buddy_block *
+amdgpu_vram_mgr_first_block(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct drm_buddy_block, link);
+}
+
+static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
+{
+	struct drm_buddy_block *block;
+	u64 start, size;
+
+	block = amdgpu_vram_mgr_first_block(head);
+	if (!block)
+		return false;
+
+	while (head != block->link.next) {
+		start = amdgpu_vram_mgr_block_start(block);
+		size = amdgpu_vram_mgr_block_size(block);
+
+		block = list_entry(block->link.next, struct drm_buddy_block, link);
+		if (start + size != amdgpu_vram_mgr_block_start(block))
+			return false;
+	}
+
+	return true;
+}
+
+
+
 /**
  * DOC: mem_info_vram_total
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 9a2db87186c7..4b267bf1c5db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -53,33 +53,6 @@ static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *block)
 	return PAGE_SIZE << drm_buddy_block_order(block);
 }
 
-static inline struct drm_buddy_block *
-amdgpu_vram_mgr_first_block(struct list_head *list)
-{
-	return list_first_entry_or_null(list, struct drm_buddy_block, link);
-}
-
-static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
-{
-	struct drm_buddy_block *block;
-	u64 start, size;
-
-	block = amdgpu_vram_mgr_first_block(head);
-	if (!block)
-		return false;
-
-	while (head != block->link.next) {
-		start = amdgpu_vram_mgr_block_start(block);
-		size = amdgpu_vram_mgr_block_size(block);
-
-		block = list_entry(block->link.next, struct drm_buddy_block, link);
-		if (start + size != amdgpu_vram_mgr_block_start(block))
-			return false;
-	}
-
-	return true;
-}
-
 static inline struct amdgpu_vram_mgr_resource *
 to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
 {
-- 
2.25.1

