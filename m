Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DDFC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450F689DF7;
	Mon, 22 Nov 2021 15:56:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C156389DF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyUI92eXDf3ENi366B6OjNZfM42gHlGoI3lTuLSzMZdLN6c8EgScw2KduP6dv3n5CmIUdMHSm1YhfvwyaEGaxcLO8cLWCgAxSZJxAVYxM0A3dorYnxoNP1YfZJNOPUzv4yjX0jurSg8onpXJqOMo0twoANRyrq5bFp+7lXHxsIAfnAq5x2d149qZbjwNI35UrhoHshZ52fq45R8GKfQcqW67nd9XNq82smNRaEvCr6fD9vmWfg9TjTlm457jkdufJ8rM0i2mhGCBl5AqGj4HtGbXdhdipmzesz3l84LeUq6TISkkNBF4WfOO8Rp71+KF7xVjZG4RjnerWBnG6vtXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o04cVpZSdiOZmO3pBqLt7SeMrNUcCQVEjFXWhkdAus=;
 b=fvwYvlogiq2sr70EzCPikLpMCbLJFVBR6ls8hefAUKc/VRtD7YxNZELzb+HbX7z59RU2yv7kQVaoLg73juXFzi2c+VZHtofxu2gKXWrj2txCeWLvrVSTgEbFIEF2fxlkwH6V4L2F7yahYofjY1YifebVb7DX0Sac0NGr2jMx3uXiFTQhwEJDNPDQi/uj1+HW9YbWjrRcxAd4hOyFddRKFfFhODQmioTbeHz1xWuv2CMkABiUPoC+9RkpIvDQBXYFi32jtmLPP3nydBmvvpEytnsV90ToeQiAi64Mdff0v89NwaanGR4/1YzN/gGoVYLV3e4kIb57Rvc3STmgOnw5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o04cVpZSdiOZmO3pBqLt7SeMrNUcCQVEjFXWhkdAus=;
 b=wZ+sa33VYLNN/S6Ayz5+0BHBObQFegIc1+HhfZzhzNnW9NLrYx2QHT5TcYCD2R3p+028oqHUMkm0Oci68CrIZhpcNob0xpdL/MHYbqQcvl/j8A36uuaqU6LKsYfU81Apk4Mr8vJ9tDOsTCGF66Ze34E0/jdi4aG0+M9uy8Xha9k=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by BYAPR12MB3253.namprd12.prod.outlook.com (2603:10b6:a03:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 15:55:59 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::96) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 15:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 15:55:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 22 Nov
 2021 09:55:57 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: handle IH ring1 overflow
Date: Mon, 22 Nov 2021 10:55:44 -0500
Message-ID: <20211122155544.9930-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed4ec46c-59e7-4c21-f574-08d9add0936d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3253:
X-Microsoft-Antispam-PRVS: <BYAPR12MB325381E5253430F7CA5D7551E69F9@BYAPR12MB3253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ip6UjEjPKJAWF+AO7FiolUq/ZKSk+ibhjVL6z4REM2QmqlklPvgf3deq2PvDYY+/ssauRCB+T1b+5ySSZjfd3IuVQ7fhE2JTlFtCyNZhXmW7f32KG70LTgtV3B9Q1SfezkdIS4VDxsVgcDfWg7IxLtXtwEAt32Kulaiqkl2NBYC0bxR+dLRyV/b7q1CQv/VzEX9tu4JETzBy8U4atOmW3z+v1U+8WV3t4QOD/GgaK37LWmlmqhnrkI33pvc3aq0vz7mxCqvju3vRbFmFc7wvEfYIwBxeyiX28osZXG5BNoV/dKUElBpMzvmAOE6EzZlgIPS/5BkaU/pX2FyHmLSRd9gfTCMnxiQAABcWznp/t2Mpom3TvV5/nvG2uTwYy+uPxS9PeITTzyfIYzj+UBKRtvZuCi5mcaU7bvyoSCD3G9Z7wc8MsALDSTBu/ZGpqtnzEAUBQtUpAvh9smuYf7Vv2Q/lNiLZ96YbJKwsDMlutcZGnidE1xlswSexPNQeveZ41lZeuWqE+I/3DeURdWS6kNkbQ6ZFPcIsZnl309SQCiMK8ROoIUGHvLbFZ+tij5s5yY18q9NP4K+g3Lcw/0uKE8YM5XjpF6GFMwysPB23c1Ygp4jjiF9XppqZ0NpjbkWgb2Y2fsid316d1bs4EZc0hfTkW9jalnTZBN0oW0LuyOvYn8oXlPZCA7lXVEQ6IhHDqch5bHIkgawWnd/z738TOphPWpVs+EozdPb7LaiUac=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(7696005)(5660300002)(81166007)(30864003)(426003)(6916009)(1076003)(2616005)(36756003)(186003)(16526019)(86362001)(54906003)(2906002)(6666004)(8936002)(4326008)(8676002)(316002)(36860700001)(70206006)(83380400001)(336012)(70586007)(26005)(356005)(82310400003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 15:55:58.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4ec46c-59e7-4c21-f574-08d9add0936d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3253
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IH ring1 is used to process GPU retry fault, overflow is enabled to
drain retry fault because we want receive other interrupts while
handling retry fault to recover range. There is no overflow flag set
when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
and drain retry fault.

Add helper function amdgpu_ih_decode_iv_ts to get 48bit timestamp from
IV entry. drain retry fault check processed_timestamp is larger than
checkpoint timestamp.

Add function amdgpu_ih_process1 to process IH ring1 until timestamp of
rptr is larger then timestamp of next entry.

Helper amdgpu_ih_ts_after to compare time stamps with 48bit wrap around.

Enable navi asics 48bit time stamp in IV.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 106 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  10 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |   1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |   2 +-
 7 files changed, 96 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index f3d62e196901..dc07776c7d0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -164,52 +164,46 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
+/* return true if time stamp t2 is after t1 with 48bit wrap around */
+static inline bool amdgpu_ih_ts_after(uint64_t t1, uint64_t t2)
+{
+	return ((t1 < t2 && (t2 - t1) < (1ULL << 47)) ||
+		(t1 > t2 && (t1 - t2) > (1ULL << 47)));
+}
+
 /* Waiter helper that checks current rptr matches or passes checkpoint wptr */
-static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
+static bool amdgpu_ih_has_checkpoint_processed_ts(struct amdgpu_device *adev,
 					struct amdgpu_ih_ring *ih,
-					uint32_t checkpoint_wptr,
-					uint32_t *prev_rptr)
+					uint64_t checkpoint_ts)
 {
-	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
-
-	/* rptr has wrapped. */
-	if (cur_rptr < *prev_rptr)
-		cur_rptr += ih->ptr_mask + 1;
-	*prev_rptr = cur_rptr;
-
-	/* check ring is empty to workaround missing wptr overflow flag */
-	return cur_rptr >= checkpoint_wptr ||
-	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
+	return checkpoint_ts <= ih->processed_timestamp;
 }
 
 /**
- * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
+ * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
  *
  * @adev: amdgpu_device pointer
  * @ih: ih ring to process
  *
  * Used to ensure ring has processed IVs up to the checkpoint write pointer.
  */
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					struct amdgpu_ih_ring *ih)
 {
-	uint32_t checkpoint_wptr, rptr;
+	uint32_t checkpoint_wptr;
+	uint64_t checkpoint_ts;
 
 	if (!ih->enabled || adev->shutdown)
 		return -ENODEV;
 
 	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-	/* Order wptr with rptr. */
+	/* Order wptr with ring data. */
 	rmb();
-	rptr = READ_ONCE(ih->rptr);
-
-	/* wptr has wrapped. */
-	if (rptr > checkpoint_wptr)
-		checkpoint_wptr += ih->ptr_mask + 1;
+	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr - 32);
 
 	return wait_event_interruptible(ih->wait_process,
-				amdgpu_ih_has_checkpoint_processed(adev, ih,
-						checkpoint_wptr, &rptr));
+				amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
+						checkpoint_ts));
 }
 
 /**
@@ -253,6 +247,60 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 	return IRQ_HANDLED;
 }
 
+/**
+ * amdgpu_ih_process1 - interrupt handler work for IH ring1
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: ih ring to process
+ *
+ * Interrupt handler of IH ring1, walk the IH ring1.
+ * Returns irq process return code.
+ */
+int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
+{
+	uint64_t ts, ts_next;
+	unsigned int count;
+	u32 wptr;
+
+	if (dev_WARN_ONCE(adev->dev, ih != &adev->irq.ih1, "not ring1"))
+		return 0;
+
+	if (!ih->enabled || adev->shutdown)
+		return IRQ_NONE;
+
+	wptr = amdgpu_ih_get_wptr(adev, ih);
+	if (ih->rptr == wptr)
+		return 0;
+
+restart_ih:
+	count = AMDGPU_IH_MAX_NUM_IVS;
+
+	ts = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr);
+	ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr + 32);
+	while (amdgpu_ih_ts_after(ts, ts_next) && --count) {
+		amdgpu_irq_dispatch(adev, ih);
+		ih->rptr &= ih->ptr_mask;
+		ts = ts_next;
+		ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr + 32);
+	}
+	/*
+	 * Process the last timestamp updated entry or one more entry
+	 * if count = 0, ts is timestamp of the entry.
+	 */
+	amdgpu_irq_dispatch(adev, ih);
+	amdgpu_ih_set_rptr(adev, ih);
+	ih->processed_timestamp = ts;
+	wake_up_all(&ih->wait_process);
+
+	wptr = amdgpu_ih_get_wptr(adev, ih);
+	/* Order reading of wptr vs. reading of IH ring data */
+	rmb();
+	if (amdgpu_ih_ts_after(ts, amdgpu_ih_decode_iv_ts(adev, ih, wptr - 32)))
+		goto restart_ih;
+
+	return IRQ_HANDLED;
+}
+
 /**
  * amdgpu_ih_decode_iv_helper - decode an interrupt vector
  *
@@ -298,3 +346,13 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 	/* wptr/rptr are in bytes! */
 	ih->rptr += 32;
 }
+
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr)
+{
+	uint32_t index = (rptr & ih->ptr_mask) >> 2;
+	uint32_t dw1, dw2;
+
+	dw1 = le32_to_cpu(ih->ring[index + 1]);
+	dw2 = le32_to_cpu(ih->ring[index + 2]);
+	return dw1 | ((u64)(dw2 & 0xffff) << 32);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 0649b59830a5..1bbbaf44ba8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -68,6 +68,7 @@ struct amdgpu_ih_ring {
 
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
+	uint64_t		processed_timestamp;
 };
 
 /* provided by the ih block */
@@ -76,12 +77,15 @@ struct amdgpu_ih_funcs {
 	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			  struct amdgpu_iv_entry *entry);
+	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr);
 	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 };
 
 #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
 #define amdgpu_ih_decode_iv(adev, iv) \
 	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
+#define amdgpu_ih_decode_iv_ts(adev, ih, rptr) \
+	((adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr)))
 #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
 
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
@@ -89,10 +93,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih);
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
+					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
+int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
 				struct amdgpu_iv_entry *entry);
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index e9023687dc9a..891486cca94b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
 						  irq.ih1_work);
 
-	amdgpu_ih_process(adev, &adev->irq.ih1);
+	amdgpu_ih_process1(adev, &adev->irq.ih1);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 1d8414c3fadb..1af1358f9650 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -160,6 +160,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
@@ -724,6 +725,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs navi10_ih_funcs = {
 	.get_wptr = navi10_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = navi10_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index a9ca6988009e..3070466f54e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs vega10_ih_funcs = {
 	.get_wptr = vega10_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = vega10_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index f51dfc38ac65..3b4eb8285943 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs vega20_ih_funcs = {
 	.get_wptr = vega20_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = vega20_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10868d5b549f..663489ae56d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
 
-		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
+		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
 						     &pdd->dev->adev->irq.ih1);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
-- 
2.17.1

