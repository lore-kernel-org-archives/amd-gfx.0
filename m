Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2ABC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 18:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF6F2072E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 18:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu0J/Bcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF6F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F1E8951E;
	Mon,  6 Jan 2020 18:35:14 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094EE8951E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 18:35:14 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id l12so43187997qtq.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 10:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mDXd4tnS3YE+DazPD6+gnDm/uI88VTab7Gaah1nwjtA=;
 b=fu0J/Bcb6+sFHLPYm/tYBnrkCVYwckoGqAazsaWrLoqUFVbjDIWbJo9vnIwEPs4BMN
 5DhdDFfkyuyxF6F/TZXG1lz387qdXisS5g7F71GOA/n8K4d+z3mV06gc5eshD13+89YW
 0tU8/CyuKG+Sr/TlErKWDAp8ezCpiIGWBUOzfVVr6SDpLTUQjVUW/wD8FtV+vPeII7xP
 trP1xmDgP5YObCG0fzxPkUdQrg0FMWn3Dy0xaug5d30lxuxcjhoOan8csHF5YCERXuCN
 AsCm3/yJPxXYZxT+TTANKEASWfQBDzRE0A4nJij2x8ErTv+FI/My1JtL8kVUPZeu5N7u
 fHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mDXd4tnS3YE+DazPD6+gnDm/uI88VTab7Gaah1nwjtA=;
 b=K/4qeWd41z4Q3RtjmuwqfvxI/xl/e33Z8MbhkwZvTJvtmxAw9mm6012AOCF2jxgMvZ
 PhvZqbq77Uvrk7AgdCuC9Rq++KJ1vcPJ67B4xei53kHD/BWC/24e8YmvFSoykmu/B490
 DOXdy8vjtGGoSa6KfygDy4rLrnFXQJP1Fbv83gDDP3yip2clgujR6UJJIXVNY3X4/3zC
 4ocAXSmqMyH3x/BnSpIfr96UWVxi9ZYg3hHF+RG6AVHsHo10ijhw5tfABMWJlYWiXC1s
 n99wWRlvXEkB6ytcdaqOe88r7ZoN/6Zr6r95HmSOALlg5nfimPoqmWyZ40eDHq+8ePgw
 jWNQ==
X-Gm-Message-State: APjAAAXMpsnomncqlc9Ndcb1wgc3o7PQv0jVh9kBral+9RDwIJign+qf
 Hkb29DVi0I51zDhNhf0F9tqya3Wy
X-Google-Smtp-Source: APXvYqzER0YVIejKSKpyh9KN63xBRLXjO7lLQbgv6WlrPUSKwfvC17wLZMKtNgB0CNbZPyQ7YOOTiw==
X-Received: by 2002:ac8:7443:: with SMTP id h3mr73746239qtr.202.1578335712846; 
 Mon, 06 Jan 2020 10:35:12 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id t1sm18895879qkt.129.2020.01.06.10.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:35:12 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gmc: move invaliation bitmap setup to common
 code
Date: Mon,  6 Jan 2020 13:35:05 -0500
Message-Id: <20200106183506.692030-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So it can be shared with newer GMC versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 40 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 32 +-------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h   | 10 -------
 4 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index bbcd11ac5bbb..d6901b274790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -333,3 +333,43 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mmhub_ras_fini(adev);
 	amdgpu_xgmi_ras_fini(adev);
 }
+
+	/*
+	 * The latest engine allocation on gfx9 is:
+	 * Engine 2, 3: firmware
+	 * Engine 0, 1, 4~16: amdgpu ring,
+	 *                    subject to change when ring number changes
+	 * Engine 17: Gart flushes
+	 */
+#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
+#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
+
+int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
+		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
+		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned i;
+	unsigned vmhub, inv_eng;
+
+	for (i = 0; i < adev->num_rings; ++i) {
+		ring = adev->rings[i];
+		vmhub = ring->funcs->vmhub;
+
+		inv_eng = ffs(vm_inv_engs[vmhub]);
+		if (!inv_eng) {
+			dev_err(adev->dev, "no VM inv eng for ring %s\n",
+				ring->name);
+			return -EINVAL;
+		}
+
+		ring->vm_inv_eng = inv_eng - 1;
+		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
+
+		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
+			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b499a3de8bb6..c91dd602d5f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -267,5 +267,6 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
+int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 68f9a1fa6dc1..e3bbeab28152 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -795,36 +795,6 @@ static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
 	}
 }
 
-static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
-		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
-	unsigned i;
-	unsigned vmhub, inv_eng;
-
-	for (i = 0; i < adev->num_rings; ++i) {
-		ring = adev->rings[i];
-		vmhub = ring->funcs->vmhub;
-
-		inv_eng = ffs(vm_inv_engs[vmhub]);
-		if (!inv_eng) {
-			dev_err(adev->dev, "no VM inv eng for ring %s\n",
-				ring->name);
-			return -EINVAL;
-		}
-
-		ring->vm_inv_eng = inv_eng - 1;
-		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
-
-		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
-			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);
-	}
-
-	return 0;
-}
-
 static int gmc_v9_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -833,7 +803,7 @@ static int gmc_v9_0_late_init(void *handle)
 	if (!gmc_v9_0_keep_stolen_memory(adev))
 		amdgpu_bo_late_init(adev);
 
-	r = gmc_v9_0_allocate_vm_inv_eng(adev);
+	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
 	/* Check if ecc is available */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
index 49e8be761214..e0585e8c6c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
@@ -24,16 +24,6 @@
 #ifndef __GMC_V9_0_H__
 #define __GMC_V9_0_H__
 
-	/*
-	 * The latest engine allocation on gfx9 is:
-	 * Engine 2, 3: firmware
-	 * Engine 0, 1, 4~16: amdgpu ring,
-	 *                    subject to change when ring number changes
-	 * Engine 17: Gart flushes
-	 */
-#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
-#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
-
 extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;
 extern const struct amdgpu_ip_block_version gmc_v9_0_ip_block;
 #endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
