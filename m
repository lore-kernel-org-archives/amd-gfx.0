Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 20:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA731613C8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 20:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA731613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A9F89DDD;
	Fri, 19 Nov 2021 20:23:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E1E89D1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 20:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgO7GdV5LD+AXpw2wAMtX5WmVrUayBV4H3Nr2H27wgvxIUXRoZAxBV10C7hYry2EDok3fKSH+5fiLE3FpHgBUu+ZXpp27leUrOqTsyAL7DmSLXgIVcsN8VeIzS7Nvsx85tETrOZ9uBA0YxASi+N5vv/7/MeYT6EXNrwhYYlPLcE4ahEoaL+otjw/FJ9k2yLfo5N6vfxrYPOi9zG+gS8tI0JPXqkOtabBEmCD6kfIHGZgWHaFN/ewWuDjZMFE5adsws6l/soT5mclEIV4KQyw79B7VMYoThEZWZBoLYxqNqvBB8m8Vzz/rJ033QpOFZkyZqv4bTnmLBPpYQKKxYIjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIQkQD5TMNVFhoy2ARD7XoQkxWWWu4HglpVGZXQat/c=;
 b=GtHxSKNvi8VpwAlXPe63z7ve1TQ2HdTwg8sQfETAUBF3Mg63rZ+vwj37/ZYFCvHRSpikhaUwZ8V4r480fODe7peUkWyf6gQGh8ETz5w6DfauS3xm3jTkF1yxUlX2cXJtm47jCEMmk5Zogm7ZSXfhZ1gpW7IPwiCklJLBtdO9DmYTkOqIG46oWMY+3rMpkUznG/VHJ+LhFVyxxY6ovHFEB7zkT1GAIpJlzm9gWrgN8W49+8UvvfpNRa3KI8qTmApU77MI38SF+8daaqit4qyiuUUsT9YnhXzwqUY5o9j6aDFeurpZdQVgtnGb9XPDT121izD7gE4TjznsCalewP5lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIQkQD5TMNVFhoy2ARD7XoQkxWWWu4HglpVGZXQat/c=;
 b=ltSyXTrcEX+mVX2UEsRmrAeDjU3cYcjtMLwVJZSMsuV3LQ/1HtCI7aN50GMQEqGIoZyo+7nAHtZTtvZxGB9XqB3YNoa8uqU4jz1b3hh1oVvpVJNG7dXGXy1NB/ciNgA6kvVuPt7YyTktzg6b1fuOgCDQvu0m/p+lV5fCSX+8vDU=
Received: from MWHPR18CA0060.namprd18.prod.outlook.com (2603:10b6:300:39::22)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 20:22:57 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::a5) by MWHPR18CA0060.outlook.office365.com
 (2603:10b6:300:39::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 20:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 20:22:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 14:22:53 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: handle IH ring1 overflow
Date: Fri, 19 Nov 2021 15:22:33 -0500
Message-ID: <20211119202233.13486-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee0bf16e-0759-4c9c-fbce-08d9ab9a5f89
X-MS-TrafficTypeDiagnostic: CH2PR12MB4954:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4954298AFF8DEB8DF3742B4AE69C9@CH2PR12MB4954.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+IV7MQxOShgzsUkv2+OaJVM1ngOfBL8qeKlsjuH28kW/SjUfJ628+XUlsqH/uVbcDK6Dc04bRRN71waBQAyLJ0l25liCSWouQgRNOMVGJ08vRO8qjA6VWZhbioKus6R20NrYARcc7zbBHClDRJjgHc0k3nbNONr70sAnANvJXXXuZZqzrddTpeHqF/8JPWgwopzOKym7EZhhjZPOWgU6nK9OtDDkLcJ0fEdyvirsmf2/hKlUnEzYYzu7FaMuyvUDdNc/VB8iLENIYMik/gRxcXH8xSMKU4Ur38oeuSADhS5x2+cBMuuVGKrpZoee3lHK8tXb5gToLAlm1a3Yab5n82eDpRBFj31oEXLRvZegWZF+1bXLPPvevqLle02X0xqafTz4b5kzktrVz87YR/hk4pAafX15IxAbVASZAEaD8WwJCsnzo3S+MpdbnHe3CUpaX68y94b8ilxaA12x7R2FSZ6Opyn7foZtKyDx7r5wnPnBvQ5RkCyQJFYv2plmikP9GOicnX+yp5VIo5mkB+KxLbnagECD58ZFOldUQ1erQeE8mrnvsAoTohKMPYVTeAvJS37248Zjy1HubmGuJosqvVGoJhfxYc1RWrR5fTiHbWjqsYkdhPo8pT86bGl+B9KlxQjhQSjwUt/gLpRZ96S71kozodzBVwOYflY0lAlOyGYxXOkv3JUvYQxws2ihlqU6Bj6uzGJseLz8Wkvqsby7wu1FMIEHRA3T7jVdcD/sd0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(16526019)(36860700001)(5660300002)(2616005)(83380400001)(186003)(54906003)(26005)(336012)(70586007)(6666004)(8936002)(6916009)(70206006)(2906002)(86362001)(47076005)(7696005)(81166007)(508600001)(316002)(82310400003)(4326008)(426003)(8676002)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 20:22:56.4128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0bf16e-0759-4c9c-fbce-08d9ab9a5f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
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
IV entry. drain retry fault check timestamp of rptr is larger than
timestamp of (checkpoint_wptr - 32).

Add function amdgpu_ih_process1 to process IH ring1 until timestamp of
rptr is larger then timestamp of (rptr + 32).

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 98 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
 4 files changed, 80 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index f3d62e196901..ad12f9d5d86a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -165,51 +165,41 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 }
 
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
+	/* After wakeup, ih->rptr is the entry which is being processed, check
+	 * the timestamp of previous entry which is processed.
+	 */
+	return checkpoint_ts <= amdgpu_ih_decode_iv_ts(ih, ih->rptr - 32);
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
+	checkpoint_ts = amdgpu_ih_decode_iv_ts(ih, checkpoint_wptr - 32);
 
 	return wait_event_interruptible(ih->wait_process,
-				amdgpu_ih_has_checkpoint_processed(adev, ih,
-						checkpoint_wptr, &rptr));
+				amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
+						checkpoint_ts));
 }
 
 /**
@@ -253,6 +243,56 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
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
+	ts = amdgpu_ih_decode_iv_ts(ih, ih->rptr);
+	ts_next = amdgpu_ih_decode_iv_ts(ih, ih->rptr + 32);
+	while (ts < ts_next && --count) {
+		amdgpu_irq_dispatch(adev, ih);
+		ih->rptr &= ih->ptr_mask;
+		ts = ts_next;
+		ts_next = amdgpu_ih_decode_iv_ts(ih, ih->rptr + 32);
+	}
+	/*
+	 * Process the last timestamp updated entry or one more entry
+	 * if count = 0, ts is timestamp of the entry.
+	 */
+	amdgpu_irq_dispatch(adev, ih);
+	amdgpu_ih_set_rptr(adev, ih);
+	wake_up_all(&ih->wait_process);
+
+	wptr = amdgpu_ih_get_wptr(adev, ih);
+	/* Order reading of wptr vs. reading of IH ring data */
+	rmb();
+	if (ts < amdgpu_ih_decode_iv_ts(ih, wptr - 32))
+		goto restart_ih;
+
+	return IRQ_HANDLED;
+}
+
 /**
  * amdgpu_ih_decode_iv_helper - decode an interrupt vector
  *
@@ -298,3 +338,13 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 	/* wptr/rptr are in bytes! */
 	ih->rptr += 32;
 }
+
+uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32 rptr)
+{
+	uint32_t index = (rptr & ih->ptr_mask) >> 2;
+	uint32_t dw1, dw2;
+
+	dw1 = ih->ring[index + 1];
+	dw2 = ih->ring[index + 2];
+	return dw1 | ((u64)(dw2 & 0xffff) << 32);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 0649b59830a5..15e8fe0e5e40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -89,10 +89,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
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
+uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32 rptr);
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 88360f23eb61..9e566ec54cf5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1968,7 +1968,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
 
-		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
+		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
 						     &pdd->dev->adev->irq.ih1);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
-- 
2.17.1

