Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AA4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 19:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7AD8933E;
	Tue, 23 Nov 2021 19:23:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1748933E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 19:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBRC5UBvp/7aVNoDwFLQngehMGWb49f5dNE2LjP1bUYbAniuHGmi+fLXUcN12Q3OCf+v2vU0JdZ7h70QL78xxLEMhGUmubbhsBVPGl7j1bJH01d/9w0sJgCcfF2N9CqUPjrGmikoC/fM1WnIS5rhwjgTwB9MFMr3pJzmFgdK3383KTyssuwP4/ewyIaICwxczpd+L5W+aeFhsZElqBQtpGNjt0O4EhvyNsU1/R+B8ObAl1kn+6FSrLs2nwbZoDYZcsWzRsQVcJ7dnoyyErym96lr3HfAg5caf3l+IvkLtl3tyKy0RidhX8tHU7GMA1X8UbMhIbrzXHKnfpap3I5aVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COHc9qLQwMEhs+OPEGP4JhqFQNVHR2eH9iGsc6bX224=;
 b=hTpoMd7vzY44qqHS60xE0WHuPxrwoqG6MG5WmmLDwvas4cwH6MrfyhuT6wm4pWFjMbY0npJCm74LLcVXF0A0oWEr0ZFZUZZIHcDXalMFM7H0hYhs8TiGaTL+fZ4rYFxuBvtXqr27czvnfs1AFTspJtHYDJevHNAXRjCPdlz7H4wimUpyNWEDdRMhZ/KVFeUBnVAe3gGl9bUJC5VeC82ut2Q8fSD2JOtDd1wqv1F3KvTYcx8+LNfN181z4ihJmUQTe3qMGw4ruANpo8CEe0I65Z4dadwxTbJJmLB68pEOIXvpSgdCg3nCs5BtDElDNA51Kc4RlIV+nKBoxSvd7h/tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COHc9qLQwMEhs+OPEGP4JhqFQNVHR2eH9iGsc6bX224=;
 b=TkyLrAtKxprS3wARZ4jPa8Glt0wQgjARo+PbsYyMiGnqWWYZdZDstCIaGA8I5OvnPGQ/opZHModgjxU1cqntrgNXtpiWCywrBWMuzEatxnVbwfbX8jqIFRRxwDHeujE5pLCMUt+m0492UkriHdgO5FnoetSOszt3ZGpcMiqeTH0=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 19:23:17 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::7d) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 19:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 19:23:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 13:23:16 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
Date: Tue, 23 Nov 2021 14:22:54 -0500
Message-ID: <20211123192254.21681-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18001d1e-2100-4918-6d94-08d9aeb6b3cf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-Microsoft-Antispam-PRVS: <SA0PR12MB443114F2CBA35305C2F17CF0E6609@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vygIbbnODtlx9cZSv2+YYsZOkiXgQoRiCcIonr8i5Aae5YOebwTMkrj3PM2yMabqypJTMxYGZq+Wygl3Y7gUr15Otlc6jAyiOzveA9ccSzaFmDOr52OS9pb7xuhaidRARhLAa5Jn/K9G3Rs9Q+OroYSbUXZWGjSWI7+CN48zxwnt7Qjutjdbcm2MHyF1i0TbOsjPoQYzNXmCcVwbk1AMWH2GSyCOFFePMottiMY80STUgTcjkgtp1D5WprWQJFPvWuiMtmvdh0vJiiZWH93QQHbzVhKxprJHnmfkMK5tT5StTERSIzKwNovCbxImMC5OoISlyMHBsNGGNDfPjfElMPGKnajaZiXDTlLsCFtyExR7Sz6YCcYFBH0w8XRZP3+pj2CVVgbrTYk4AvHAvkEC9JVJC3yvpTgGSzvdTssb/Vw0J6xCnCqD3J1TLaju6xXoDJthlyvAmaI7vNoVDf5UJRE87/R1CwQfM2YflU+QkdJUTZu/sJM77P7DJ0AWlmKKrWjf/rkB6xd1f0IXZZ2cxLznS+08PCFsLwJ5Ghx1Yc94RPOfAeQ9Sm7JMsv9zoYa0FMemGnZmrsl9tpkWpC3ZpNcmNQOQJBBLnA0pHpc546G+Ahri+0fJyjDxf2Y+gg64DzRzxAHtf6oIUF/PIGblLuxznEnOSHthQlsQT7itgNN7ZAngqbkv2ydeZ2zmJ8fNJ1G6Xf4W6YxaDMueyfgARfhBQTr+WK8RaibYqA06gk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(81166007)(86362001)(2616005)(426003)(82310400004)(36860700001)(336012)(70586007)(54906003)(8676002)(8936002)(6916009)(30864003)(508600001)(70206006)(2906002)(316002)(83380400001)(356005)(1076003)(4326008)(26005)(186003)(16526019)(47076005)(5660300002)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 19:23:17.2073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18001d1e-2100-4918-6d94-08d9aeb6b3cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
IV entry. drain retry fault is done if processed_timestamp is
equal to or larger than checkpoint timestamp.

Add function amdgpu_ih_process1 to process IH ring1 until timestamp of
rptr is larger then timestamp of next entry.

Helper amdgpu_ih_ts_after to compare time stamps with 48bit wrap around.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 107 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |   1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |   1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |   2 +-
 7 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 0c7963dfacad..30b4e0e01444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -164,52 +164,45 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
+/* return true if time stamp t2 is after t1 with 48bit wrap around */
+static inline bool amdgpu_ih_ts_after(uint64_t t1, uint64_t t2)
+{
+	return ((int64_t)(t2 << 16) - (int64_t)(t1 << 16)) > 0LL;
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
+	return !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts);
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
+	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
 
 	return wait_event_interruptible(ih->wait_process,
-				amdgpu_ih_has_checkpoint_processed(adev, ih,
-						checkpoint_wptr, &rptr));
+				amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
+						checkpoint_ts));
 }
 
 /**
@@ -254,6 +247,56 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
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
+	ts = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr, 0);
+	ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr, 1);
+	while (amdgpu_ih_ts_after(ts, ts_next) && --count) {
+		amdgpu_irq_dispatch(adev, ih);
+		ih->rptr &= ih->ptr_mask;
+		ts = ts_next;
+		ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr, 1);
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
+	if (amdgpu_ih_ts_after(ts, amdgpu_ih_decode_iv_ts(adev, ih, wptr, -1)))
+		goto restart_ih;
+
+	return IRQ_HANDLED;
+}
+
 /**
  * amdgpu_ih_decode_iv_helper - decode an interrupt vector
  *
@@ -298,4 +341,20 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 
 	/* wptr/rptr are in bytes! */
 	ih->rptr += 32;
+	ih->processed_timestamp = entry->timestamp;
+}
+
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed offset)
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
index 0649b59830a5..d7e1ffeca38f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -68,6 +68,7 @@ struct amdgpu_ih_ring {
 
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
+	uint64_t		processed_timestamp;
 };
 
 /* provided by the ih block */
@@ -76,12 +77,17 @@ struct amdgpu_ih_funcs {
 	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			  struct amdgpu_iv_entry *entry);
+	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
+				 signed offset);
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
@@ -89,10 +95,13 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
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
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed offset);
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

