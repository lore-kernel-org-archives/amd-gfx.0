Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED6DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 20:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B85E6E252;
	Thu, 25 Nov 2021 20:30:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D785E6E252
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 20:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9vL1/mBqcEBNvc1icII69z1hIOUzYpXK3byHiMfmtz64KbpzCWWMmQsxkM5/xo6c/MWXfjQ8TaisdNvY0lUq9QEFrPX8JdfzQ5iXtdY2O24fg4oKT0YT+dCwncP9We9KUbLPaH/rOsoHa3vCsevz9gBdY3LAFbU1cq7KCoGmv0CqTEK3ypRb4SWnc2nG0991y/nxWHgtASzSkpewhJ//jQ7YrR/wJdz2RgL2q8XBi+a2yope+2PCPguCIzm6OdypMJVUj+/VtBbBpVlMxmTom/DzOCOe54tPc8tmkeXCLf7QaOigbezgcRkIin29Y6nZK4Lpith4iVOuWaL/mcuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F2z8FeTvapOxy/4zrO2dzEq15Wb8LTaw0tLqqZGX3E=;
 b=AqpANJ2YoQb55q4zXhf1yhqM6HWGCBcJbJFxKDh6lk+zcSoojzc78zvk98BnxpNM1KC46OyEAvzVm9MjaSUZ6CNt91XbwjHk5jgTobiE10sT40OL0HPrrm5y5j1KQLL0ofQ0g/ZXiZPhl5lA7rdeylReaJvjFbwwXhKTeZ6W/tg6D3u8GyW8NJ6lC6N3CuYP85YUSsWDgA8kZwNzrQK+VC608xbdKirNWwPQej9wK4kP+gd6a6KcNCcSAF8NxO6ZNxvTXkm0N4dEPQ5Y/4TkIauI7Nkk0Qsrnwn08izeGoWbAkfKKMrQcAUhpzfp/zZ14BxL3eymJVezWXUFfRfsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F2z8FeTvapOxy/4zrO2dzEq15Wb8LTaw0tLqqZGX3E=;
 b=bPGhkymCg8hI8p1cBFUsB2rlrisdMVwrVJZN0VDrfc9C31qR52KmtFdXIpSZYzEgSZHalePnjdVlnrjRj3Hc5sSr5MXPh5VeYrOo70bArtVL0qQ8K/YO1rFlXwlk6zt0gATR3tGEtCjc16F42QoseJ9BKAewVJA94aUa9nuzsE0=
Received: from MWHPR22CA0065.namprd22.prod.outlook.com (2603:10b6:300:12a::27)
 by BN6PR12MB1937.namprd12.prod.outlook.com (2603:10b6:404:108::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 20:30:23 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::ea) by MWHPR22CA0065.outlook.office365.com
 (2603:10b6:300:12a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 25 Nov 2021 20:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 20:30:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 14:30:21 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8] drm/amdgpu: handle IH ring1 overflow
Date: Thu, 25 Nov 2021 15:30:03 -0500
Message-ID: <20211125203003.18038-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca81c15d-d556-4103-5965-08d9b052683b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1937:
X-Microsoft-Antispam-PRVS: <BN6PR12MB193784B8EFBA6D098EF3A728E6629@BN6PR12MB1937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KiYPbAIyUkIm/O+gnqPc1ZfHFGxOftKpUd3/RgOOliHB+Mh77HYxwQ6YA1M+9nCw95JCe2YW672Foj6hILGi0Da3101NdhkWwfG+ZK6fRpnwua+J3MNG67NubrAIEFDFsLi0Ba6K6XMbh8G31lRi/el6llKv5j44p5rAjnfS3UFCMKQ7ejrkRPbbB+Kh1hMIcQBdUb5n5aetuIBSWbhld6me51dx46dlwofGdByMoSRec/P0w7tOQ1emvL1n2DgQH4Vcg4NLAiKaOqpew0erJXcf7+VYa/tkdav+JpXDkUTLhLj1l3qARaTK8ytUGvlqePDAVlyZe2acW1+BRmWenZdKZR6wfAdglILGutdchBwkUWAZCDCzNCnhKJ+OZe/BoSmXwG71YOeYnM3CkPYQp5gPlwMv/ULyXHblOW5s3o1lvF/kkNnUEe+DhPlkuvaWJwLuVvlCw1jFN+OF4bWwvm8HrYlBMNHH3j36YrPaHrHtTD/rL9hWe4NRcJ1RaPT7LnwcfVg0QHP3UpBBcyoRIqryRV1Ltjuavs7T0QLJlWm3qK5BK0fbPObG5lj3y0tLvYsZzzrIoVXVWdDGmqcp5Ip78fzPzueEQg8NFcRoAjwbiGpzln296fGKfQATm8BhixqhuM5M/xeQPQabrWgqoHw9LbG5qe4Y5AP761odE9yd+IuA1h+AWUAQRmet+kXTdYLJwp3U+nmReN5XS/GqieE+x9oI7FJUthBq6TIqBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(16526019)(70206006)(70586007)(186003)(508600001)(86362001)(54906003)(6916009)(30864003)(83380400001)(7696005)(26005)(356005)(47076005)(316002)(1076003)(336012)(8676002)(36860700001)(4326008)(5660300002)(2616005)(2906002)(426003)(8936002)(6666004)(36756003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 20:30:23.0453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca81c15d-d556-4103-5965-08d9b052683b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1937
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

If fault timestamp goes backward, the fault is filtered and should not
be processed. Drain fault is finished if processed_timestamp is equal to
or larger than checkpoint timestamp.

Add amdgpu_ih_function interface decode_iv_ts for different chips to get
timestamp from IV entry with different iv size and timestamp offset.
amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 55 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 16 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
 11 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 45761d0328c7..403a968f3d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -350,6 +350,7 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
  * amdgpu_gmc_filter_faults - filter VM faults
  *
  * @adev: amdgpu device structure
+ * @ih: interrupt ring that the fault received from
  * @addr: address of the VM fault
  * @pasid: PASID of the process causing the fault
  * @timestamp: timestamp of the fault
@@ -358,7 +359,8 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
  * True if the fault was filtered and should not be processed further.
  * False if the fault is a new one and needs to be handled.
  */
-bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
+bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp)
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
@@ -366,6 +368,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	struct amdgpu_gmc_fault *fault;
 	uint32_t hash;
 
+	/* Stale retry fault if timestamp goes backward */
+	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
+		return true;
+
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e55201134a01..8458cebc6d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -316,7 +316,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
 			      struct amdgpu_gmc *mc);
 void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
-bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
+bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
 void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 				     uint16_t pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 0c7963dfacad..8050f7ba93ad 100644
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
@@ -299,3 +279,18 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 	/* wptr/rptr are in bytes! */
 	ih->rptr += 32;
 }
+
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset)
+{
+	uint32_t iv_size = 32;
+	uint32_t ring_index;
+	uint32_t dw1, dw2;
+
+	rptr += iv_size * offset;
+	ring_index = (rptr & ih->ptr_mask) >> 2;
+
+	dw1 = le32_to_cpu(ih->ring[ring_index + 1]);
+	dw2 = le32_to_cpu(ih->ring[ring_index + 2]);
+	return dw1 | ((u64)(dw2 & 0xffff) << 32);
+}
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index e9023687dc9a..571b11117992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -521,6 +521,9 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	/* Send it to amdkfd as well if it isn't already handled */
 	if (!handled)
 		amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
+
+	if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
+		ih->processed_timestamp = entry.timestamp;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..d696c4754bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 
 		/* Process it onyl if it's the first fault for this address */
 		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, addr, entry->pasid,
+		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
 					     entry->timestamp))
 			return 1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..7490ce8295c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -523,7 +523,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 		/* Process it onyl if it's the first fault for this address */
 		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, addr, entry->pasid,
+		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
 					     entry->timestamp))
 			return 1;
 
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

