Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB7C3B185
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9467220679
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZL1Pb4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9467220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210B06E90F;
	Mon, 17 Feb 2020 10:16:10 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8213B6E90B;
 Mon, 17 Feb 2020 10:16:07 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y17so18938604wrh.5;
 Mon, 17 Feb 2020 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HnLxeOLGupkDJKKR65u4bZIaT5KCNOAxjAw6kZ3MPNo=;
 b=RZL1Pb4Mto2hMZ2qZu9Ahv1u1n4SAD8J8vgB+7L+dWBxk9Pwdic7aGqbYXyORgF+t0
 04bitASNsN1/MnDG2V05YvRglp/shdsOFwX+5C5OY+0AQhC3UX3xNSYVYEo6JEM67Q3D
 1COriVMB18ZhHUsjnbXdBqahWfSM1/aRHj6Tx8c58xpupOkLFHF6RcrVHjczZ9GZWMvH
 C7cOFjBhYqyC2zD14vDmNkTVmCl0ZC0oWb3pAB/mVUZzpPvVmq7szqMCsZrAvZHHi8SM
 Q62UiqOJEsanuH+z1+BPAb6yD1bFpK6VtMcQWZsuEUDWUueo1c8w2sDNZ8BaymUancg3
 7ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HnLxeOLGupkDJKKR65u4bZIaT5KCNOAxjAw6kZ3MPNo=;
 b=M8n2v/emOmfjUs9Aejo+cusL52pxYv1PiIH36oBnkUD/JxXD2e2CpjZHO/ecFPzVzX
 lx/w43tRF31TSOaLGqte3J0pvyoQtwyIR5emxkc/z7GId5GUUsOJu7zmLTqDojjZmjta
 rA5U/Lhzxzo1EE4xxprxpjdWr4VVoo5dVfz2axNGqyZhWxkHdp2L3JKEbxiyN6QiMKN4
 2eXK7L76UBdtNlKBozbEhYaiLtF7TSBge8Y6v4GgoMeyXUwzSqP/LL25qXcQ7vFuVCMX
 X4GDZsxdZTyYb/WtaoYUmdQe2cpVz324UHeC0ufp1krPvO/XcqUVb92A5hE/bNN6erIx
 qcTw==
X-Gm-Message-State: APjAAAU9+rMIZSFtM1/rmUDiU3boWHGxPbx8VQ/X6sbt5DmFsMD679O0
 Ic7zXpt4hAulEb1iBtkf+vAgW+78LDa86A==
X-Google-Smtp-Source: APXvYqwftzEieeUL51SR2I+5cD15PjEtFk0+pRkz1Iz6npq6o9LveRie8nTjStEGisSbhA/Ijx3OJg==
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr20963644wrf.174.1581934565740; 
 Mon, 17 Feb 2020 02:16:05 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F261400BC111EAD619EC67C.dip0.t-ipconnect.de.
 [2003:c5:8f26:1400:bc11:1ead:619e:c67c])
 by smtp.gmail.com with ESMTPSA id a16sm278487wrt.30.2020.02.17.02.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 02:16:05 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 5/7] drm/qxl: don't use ttm bo->offset
Date: Mon, 17 Feb 2020 11:18:39 +0100
Message-Id: <20200217101841.7437-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217101841.7437-1-nirmoy.das@amd.com>
References: <20200217101841.7437-1-nirmoy.das@amd.com>
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch also removes slot->gpu_offset which is not required as
VRAM and PRIV slot are in separate PCI bar

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    | 5 ++---
 drivers/gpu/drm/qxl/qxl_kms.c    | 5 ++---
 drivers/gpu/drm/qxl/qxl_object.h | 5 -----
 drivers/gpu/drm/qxl/qxl_ttm.c    | 9 ---------
 4 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 27e45a2d6b52..58e7098a17ff 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -311,10 +311,9 @@ qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 		(bo->tbo.mem.mem_type == TTM_PL_VRAM)
 		? &qdev->main_slot : &qdev->surfaces_slot;
 
-	WARN_ON_ONCE((bo->tbo.offset & slot->gpu_offset) != slot->gpu_offset);
+       /* TODO - need to hold one of the locks to read bo->tbo.mem.start */
 
-	/* TODO - need to hold one of the locks to read tbo.offset */
-	return slot->high_bits | (bo->tbo.offset - slot->gpu_offset + offset);
+	return slot->high_bits | ((bo->tbo.mem.start << PAGE_SHIFT) + offset);
 }
 
 /* qxl_display.c */
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 70b20ee4741a..7a5bf544f34d 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -86,11 +86,10 @@ static void setup_slot(struct qxl_device *qdev,
 	high_bits <<= (64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits));
 	slot->high_bits = high_bits;
 
-	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx, gpu_offset 0x%lx\n",
+	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx\n",
 		 slot->index, slot->name,
 		 (unsigned long)slot->start_phys_addr,
-		 (unsigned long)slot->size,
-		 (unsigned long)slot->gpu_offset);
+		 (unsigned long)slot->size);
 }
 
 void qxl_reinit_memslots(struct qxl_device *qdev)
diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 8ae54ba7857c..21fa81048f4f 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -48,11 +48,6 @@ static inline void qxl_bo_unreserve(struct qxl_bo *bo)
 	ttm_bo_unreserve(&bo->tbo);
 }
 
-static inline u64 qxl_bo_gpu_offset(struct qxl_bo *bo)
-{
-	return bo->tbo.offset;
-}
-
 static inline unsigned long qxl_bo_size(struct qxl_bo *bo)
 {
 	return bo->tbo.num_pages << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 62a5e424971b..635d000e7934 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -51,11 +51,6 @@ static struct qxl_device *qxl_get_qdev(struct ttm_bo_device *bdev)
 static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 			     struct ttm_mem_type_manager *man)
 {
-	struct qxl_device *qdev = qxl_get_qdev(bdev);
-	unsigned int gpu_offset_shift =
-		64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits + 8);
-	struct qxl_memslot *slot;
-
 	switch (type) {
 	case TTM_PL_SYSTEM:
 		/* System memory */
@@ -66,11 +61,7 @@ static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case TTM_PL_VRAM:
 	case TTM_PL_PRIV:
 		/* "On-card" video ram */
-		slot = (type == TTM_PL_VRAM) ?
-			&qdev->main_slot : &qdev->surfaces_slot;
-		slot->gpu_offset = (uint64_t)type << gpu_offset_shift;
 		man->func = &ttm_bo_manager_func;
-		man->gpu_offset = slot->gpu_offset;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED |
 			     TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_MASK_CACHING;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
