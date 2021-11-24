Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0769C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 22:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FE76E218;
	Wed, 24 Nov 2021 22:58:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE456E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 22:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTCTQu5zRNq/2IweaJ7BPudKsQK02t2Kq2mKRXZGzsH9ph6+2fMOISMB8sIykr3+8qJASG43W450BV+06v/ROvzJ5up0BWRIol/DSEKhoeJSncNa7YZP/e00r7iF/8/1zoBdL4jkRv8/en6dP5RILAFzJefLq0hdzsZBL3ED2OamObhTlHgzdzPOp9FBoxWlXS8Csa+ydQxqWhr84vob0OSYCUyF1kt2sk4FT7gciJS3ghskG/W2JVzyuN+a1NvRSRG3FBvwUCS3OmAOEqUWJclurRd/mZv9gMVOlUw/G23gdHoycaP2zBXWVhhqpdGN8RFMhPP3w/FzoszKEdb8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1gxmZcIrSVTNbcJxJvFu/R2vchXUcihVNb+mgVtJL0=;
 b=ZaKWAUz2uD0wjTqVL/VRK+jAfV4ZTn5BA6v3c4i0eG5JNnjaXOCCwn1+yNuJIcVXst3j4k+MQMQQRECWY8AD/h+h/MdgFBZ9qxR+f0pAB8vlfU0dPmECtTyUneXYn0iHbQi4NNE3THc46JKOdXioXp5Bu5CWMVGjz/ULeBP/Xk7dK51jeyLpZkTqr3Nw7UbUZa6VWEH7i/a23fVt6RO3kVLjGq/XjeC1C5orkZsWBINjbUAJ60jIE6WLEF5NJ2sa2yph5X17UcXCVr8PG9MQmVVtZMpcU0Pg4XPhkPRbXDLWztgc3YZar9zcVNT6K0iIIcEcHmABIaQvRq+ZmeEfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1gxmZcIrSVTNbcJxJvFu/R2vchXUcihVNb+mgVtJL0=;
 b=1JzBQ2oWFX3v8i3j42+ng1ouQ2ho+WDjteH6LJhJ9KzW0QHj9L589l3GN/dW/WOWHWH0ZXpCgGquiZKnEd+pGhP/m52JFRRxdNVINvvYwpfGZ0jdEGrOFZ71LutWaq7HfJRM6KsFtDLEj9q9Vg/PuQzF0QauvhUoIFC81iC1Edo=
Received: from BN6PR1101CA0015.namprd11.prod.outlook.com
 (2603:10b6:405:4a::25) by BN8PR12MB3154.namprd12.prod.outlook.com
 (2603:10b6:408:6d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 22:58:41 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::44) by BN6PR1101CA0015.outlook.office365.com
 (2603:10b6:405:4a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Wed, 24 Nov 2021 22:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Wed, 24 Nov 2021 22:58:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 16:58:39 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6] drm/amdgpu: handle IH ring1 overflow
Date: Wed, 24 Nov 2021 17:58:27 -0500
Message-ID: <20211124225827.26232-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e43ced-9880-435e-8f28-08d9af9df51f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3154:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31544A883A654448E62A15C6E6619@BN8PR12MB3154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAu3qF0xfR+H23jsLfaCu6XcG0wB/74YJZ/EHAhcs5w51v3q1uvd41CqYC50gAYzXR///H40CWxBBw2cUWBooJ79IRn2Wex8tVfMfXX25Wsbgb6ITjF21srPQu0e/CeUzKdMfDdvPg+YMYUZl5jaBkGP6cgpn+o0oHBmPj1PO1TUeaRgXVKlqjzX9zai02t3rrU0qF/bZah/b6RETfzeG60rqAmGwY57G+yrs6DhA/3w3Kfg7NYk72ssN/J10/xpdON/eMaffpmd9bwwMjU7jI/cV0mCGBsy/9sP31+jR9lUoGLyr4QNHcftvLF9oKwKWdGfEAP/UNOdwDafXK7djRdStSUsDW88fi9keC6tdfi4Az6gd8MfZkywLE9JzMPbAiCzCw2D3GHa8LkAzjY1A0tQPoHApVXRlvVfBPts9KBoTdDghsxO4Z/hhRFtQlymp7UXfh9CPpFLNVWOW/FT5dbd+SgFLKccY4PAtxkJUkdJVSWdrHVKlj5Iwv69FF/gD+KgGY/a9cHBEEkgt0CZxIu9glenbu1JeuYSxk8eE0TNp5xEemS3whBuy+y99cpDuoYKG3mhIz9ljizO4oWiJvEO8udXJYsS0TJEE4kz+RARYDzs7XrcaBwP9ZRQcqw3zLV+mOXQH87j+z1SVgbVt6t062+43ONIn+gkeUmdu6WRzp7tsniNkPqvZbW0iA+6lpHIzKWXYhEmOHgZA5YjOWMLoQzL/BrNUxAkTqdOAsc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(70206006)(2616005)(81166007)(8936002)(47076005)(70586007)(6666004)(7696005)(356005)(36756003)(4326008)(186003)(508600001)(2906002)(83380400001)(5660300002)(8676002)(54906003)(82310400004)(6916009)(336012)(426003)(86362001)(36860700001)(316002)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:58:40.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e43ced-9880-435e-8f28-08d9af9df51f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3154
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

Add amdgpu_ih_function interface decode_iv_ts for different chips to get
timestamp from IV entry with different iv size and timestamp offset.
amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.

Drain retry fault is done if processed_timestamp is equal to or larger
than checkpoint timestamp. Page fault handler skips retry fault entry if
entry timestamp goes backward.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 58 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 16 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  2 +-
 8 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 0c7963dfacad..3e043acaab82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -164,52 +164,32 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
-/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
-static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih,
-					uint32_t checkpoint_wptr,
-					uint32_t *prev_rptr)
-{
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
-}
-
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
+	long timeout = HZ;
 
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
+	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
 
-	return wait_event_interruptible(ih->wait_process,
-				amdgpu_ih_has_checkpoint_processed(adev, ih,
-						checkpoint_wptr, &rptr));
+	return wait_event_interruptible_timeout(ih->wait_process,
+		    !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
+		    timeout);
 }
 
 /**
@@ -298,4 +278,22 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 
 	/* wptr/rptr are in bytes! */
 	ih->rptr += 32;
+	if (ih == &adev->irq.ih1 &&
+	    amdgpu_ih_ts_after(ih->processed_timestamp, entry->timestamp))
+		ih->processed_timestamp = entry->timestamp;
+}
+
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset)
+{
+	uint32_t iv_size = 32;
+	uint32_t dw1, dw2;
+	uint32_t index;
+
+	rptr += iv_size * offset;
+	index = (rptr & ih->ptr_mask) >> 2;
+
+	dw1 = le32_to_cpu(ih->ring[index + 1]);
+	dw2 = le32_to_cpu(ih->ring[index + 2]);
+	return dw1 | ((u64)(dw2 & 0xffff) << 32);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 0649b59830a5..dd1c2eded6b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
 
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
+	uint64_t		processed_timestamp;
 };
 
+/* return true if time stamp t2 is after t1 with 48bit wrap around */
+#define amdgpu_ih_ts_after(t1, t2) \
+		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
+
 /* provided by the ih block */
 struct amdgpu_ih_funcs {
 	/* ring read/write ptr handling, called from interrupt context */
 	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			  struct amdgpu_iv_entry *entry);
+	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
+				 signed int offset);
 	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 };
 
 #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
 #define amdgpu_ih_decode_iv(adev, iv) \
 	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
+#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
+	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
+	(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr), (offset)))
 #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
 
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
@@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih);
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
+					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
 				struct amdgpu_iv_entry *entry);
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..b129898db433 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -119,6 +119,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 		}
 
+		/* Stale retry fault if timestamp goes backward */
+		if (entry->ih == &adev->irq.ih1 &&
+		    amdgpu_ih_ts_after(entry->timestamp, entry->ih->processed_timestamp))
+			return 1;
+
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..c0d9b254bbb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -535,6 +535,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 		}
 
+		/* Stale retry fault if timestamp goes backward */
+		if (entry->ih == &adev->irq.ih1 &&
+		    amdgpu_ih_ts_after(entry->timestamp, entry->ih->processed_timestamp))
+			return 1;
+
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 38241cf0e1f1..8ce5b8ca1fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
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

