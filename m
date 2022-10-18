Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA36BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 09:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F1810EEFA;
	Tue, 18 Oct 2022 09:12:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55F810EEFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 09:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNkflQOzqdgY2p3LIKHI59xklVqLG8SwRFcIIslYEkdyjhmMTu0GTGJOIuM6zkjFEqh/2u2lvLVFizNcQzkuE4h/0pqU8diaNmr+LAsslhWhqfb4xV8U8ebZCZS66Ne/zYaxclp6jS2LlAQjY5JmQQezXHOJ74qmp8Uc9jWMFqtU3umXpiJfvDHVMa/LYwHYdntX34Ebt25JAt4R/ZIYw1xe7moYOEYwuYpFACWGUy5nM1bi4+uGD0F0rdCO2VK5TFSWcdqPBc0ooztPlH0wo+TbtHdIZaARVdg5zumVeZqLDoRJZd5hlbCO847lftGcDc/V6ZUdb0aSPshCf8X+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp4Cv9ykmozF+RCfEPgwhWehmYjIQgzKysXyJMlgB5s=;
 b=TuiWfxlRiaOCnbYn80piQQi7dmPBcRIQ0rYJgJcsnTqyP7+dheMZkpqxwNdgYgeSJULt14euuI74ktTFb4GoDwuBmoWfYXMdfQ2iEeFZDIoFOs+/5/5Fn2sQAgg9QV3dMcEgsm+4HHNukBb7qEcJhvmSy3gGiNBbBQpK6gui0aBlTgIbsei7OofzxPAE0At3TsmJl2tmPOYypCqxdz8HwvvayFOoGbc8khbc7WDKJn3xxHqOMLqx0S9HiQkcitH9cAe9DubfKFE3KXAkKqXdwpE0XWcs446J/HpwkAqogcSsFRBYsTct/kI7cL1wfdWuRTpH65Dglbg9Gc+7tyfTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp4Cv9ykmozF+RCfEPgwhWehmYjIQgzKysXyJMlgB5s=;
 b=cmsFXCOy6nczze2rxwHnN5yWCU4M/BtJ1+ysaDeWukr1z/1IPIg34vrJVDdnN51QughYQ7rZMkAlbtzQYmbMHFRKN6EEIgEeq5quyVtISinF3T5H45KPjTXjdK7StUxV3yINkHQxCJiSvWHcdvdRZdEioBFrLFIexzDAO2THZ84=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Tue, 18 Oct 2022 09:12:14 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::54) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 09:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 09:12:14 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 04:09:26 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Improve the software ring priority scheduler
Date: Tue, 18 Oct 2022 17:08:15 +0800
Message-ID: <20221018090815.2662321-5-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018090815.2662321-1-jiadong.zhu@amd.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: b46b2a30-4526-43df-389f-08dab0e8d8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSQDOAhpng6sHHJ9q8tZ+B1SzRMxhdJJYdZ2wBsvO8Wftfh0LqdNIS6/drj3AXcQUGRNPeitjjHOmiZfkVPt32HbAveh2irmOD/L7eiasc5kywRrU3p2o10a+IgZsqxzoO8ZpuWM5/Mn0dhXum6EwTNdjddKzzIo91OnCWN0fYkwTl3HH0rycaECbqireKwOOnPyiPRbFe4oFbCImWcDKx+0eMtvmhoj4GSLx+zFI41ZEN7+U6fiYKIDEH24oEeXAjAZsii3hZ40IgyGzroMCFqLFUh74mNiH4oRBT6Sz6IAFvwv8wTEEG//BHUEvKjTirl5A/cuRD3ZEppHFdUzfTRZZX7LeoOJsevfAV6WDf8U/IMiloxpnM04kdHX862pcFf6HtH8Rwo8ngYfDw3+KA+AdTL5EQZcjYCIatkGZkwfl+MXiKcgY2SGvx4PbPaWhuRh47JH0+09vLh0FHpJyCSGI9AC00fZfl8AoAxbNJDawmth/3NkBxNjjUe+87XeETeWrjUEiFNKdU+wjLpnIWTeJRV4oAxBmL6xIUOCpkkws6BJWlfGtb0kXrYqTUUraic43oF2t19jB9vRvATIDippWtL2+qiBODdC2UNqItC0zTuopvvCfWkc25AYzAsPenAar8areetW3Pi6xQ1jfMOyUFIEdzUo+giVHiNsDehsWSu8IaKxBswhSS2Zd/YHBHyI5X5FQrb6dA2ck5eHCYc/mti4Fjtcs7EQo0OsBKg2wg/N0QvJupDUe+RGYfZnDc9HDnoLPFEga+v13O+I8WkXbayoHug8LxCQc7lABco=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(36860700001)(86362001)(5660300002)(82740400003)(2876002)(2906002)(336012)(186003)(2616005)(1076003)(426003)(47076005)(16526019)(6916009)(81166007)(356005)(83380400001)(66574015)(26005)(7696005)(316002)(478600001)(54906003)(70586007)(70206006)(41300700001)(82310400005)(40480700001)(4326008)(8936002)(6666004)(40460700003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 09:12:14.3170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b2a30-4526-43df-389f-08dab0e8d8e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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
Cc: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Using the drm scheduler, the software rings' scheduling threads with different
priorities have the same opportunity to get the spinlock and copy its packages
into the real ring. Though preemption may happen for the low priority ring, it
will catch up with the high priority ring by copying more data (the resubmit
package and the current ibs) on the next calling of set_wptr. As a result, the
priority is not quite effective.

Here are some details to improve the priority of software rings at the bottom
of drm scheduler by slowing down the low priority thread with following
strategy.
1. If all the high priority fences are signaled which indicates gpu is idle
   while there are low priority packages to submit, no delay happens.
2. When there are unsignaled fences on high priority rings, we account for the
   portion of the ibs sent from the low priority ring. If the portion exceeds
   a certain threshold(eg, 30%), a timeout wait happens on low priority
   threads till more high priority ibs submitted.
3. The mechanism is started when the first time mcbp triggered, ended when all
   the high priority fences are signaled.

Cc: Christian Koenig <Christian.Koenig@amd.com>
Cc: Michel Dänzer <michel@daenzer.net>
Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 93 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  3 +
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 41b057b9358e..eac89094f1d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -27,7 +27,13 @@
 #include "amdgpu_ring.h"
 #include "amdgpu.h"
 
+/* The jiffies fallback resubmission happens */
 #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
+
+/* Maximum waiting jiffies on low priority ring thread */
+#define AMDGPU_MUX_DELAY_JIFFIES_TIMEOUT (HZ / 10)
+
+/* The time threshold of unsignaled fence that trigger mcbp */
 #define AMDGPU_MAX_LAST_UNSIGNALED_THRESHOLD_US 10000
 
 static const struct ring_info {
@@ -47,6 +53,69 @@ static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ri
 			&mux->ring_entry[ring->entry_index] : NULL;
 }
 
+static uint32_t ring_priority_to_ratio_pct(unsigned int hw_prio)
+{
+	uint32_t ratio;
+
+	switch (hw_prio) {
+	case AMDGPU_RING_PRIO_DEFAULT:
+		ratio = 30;
+		break;
+	case AMDGPU_RING_PRIO_2:
+		ratio = 100;
+		break;
+	default:
+		ratio = 100;
+	}
+	return ratio;
+}
+
+static void reset_wcnt_on_all_rings(struct amdgpu_ring_mux *mux)
+{
+	int i;
+
+	for (i = 0; i < mux->num_ring_entries; i++)
+		mux->ring_entry[i].w_cnt = 0;
+}
+
+/**
+ * Decide if the low priority ring task should be delayed when there are high
+ * priority ibs ongoing. If all the high priority fences are signaled at that
+ * time, gpu is idle, we do not need to wait. Otherwise we calculate the
+ * percentage of portions copying ibs on the current ring and compare with the
+ * threshold according to the priority.
+ */
+static bool proceed_on_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_ring *high_prio_ring;
+	u64 current_cnt, total_cnt = 0;
+	int i;
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		if (mux->ring_entry[i].ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
+			high_prio_ring = mux->ring_entry[i].ring;
+			break;
+		}
+	}
+
+	/*All high priority fences signaled indicates gpu is idle.*/
+	if (amdgpu_fence_count_emitted(high_prio_ring) == 0) {
+		reset_wcnt_on_all_rings(mux);
+		return true;
+	}
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		if (mux->ring_entry[i].ring->hw_prio == ring->hw_prio)
+			current_cnt = mux->ring_entry[i].w_cnt;
+		total_cnt += mux->ring_entry[i].w_cnt;
+	}
+
+	if (total_cnt == 0)
+		return true;
+
+	return ring_priority_to_ratio_pct(ring->hw_prio) > current_cnt * 100 / total_cnt;
+}
+
 /* copy packages on sw ring range[begin, end) */
 static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
 						  struct amdgpu_ring *ring,
@@ -73,6 +142,13 @@ static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
 	}
 }
 
+/* delay low priotiry task depending on high priority rings fence signal condition*/
+static void wait_on_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	wait_event_interruptible_timeout(mux->wait, proceed_on_ring(mux, ring),
+					 AMDGPU_MUX_DELAY_JIFFIES_TIMEOUT);
+}
+
 static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
 {
 	struct amdgpu_mux_entry *e = NULL;
@@ -126,7 +202,6 @@ static void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
 static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
 {
 	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
-
 	if (!spin_trylock(&mux->lock)) {
 		amdgpu_ring_mux_schedule_resubmit(mux);
 		DRM_ERROR("reschedule resubmit\n");
@@ -158,6 +233,7 @@ int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 	}
 
 	spin_lock_init(&mux->lock);
+	init_waitqueue_head(&mux->wait);
 	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
 
 	return 0;
@@ -205,8 +281,10 @@ void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 {
 	struct amdgpu_mux_entry *e;
 
-	spin_lock(&mux->lock);
+	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && !proceed_on_ring(mux, ring))
+		wait_on_ring(mux, ring);
 
+	spin_lock(&mux->lock);
 	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
 		amdgpu_mux_resubmit_chunks(mux);
 
@@ -238,7 +316,12 @@ void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 	} else {
 		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
 	}
+
+	e->w_cnt++;
 	spin_unlock(&mux->lock);
+
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
+		wake_up_interruptible(&mux->wait);
 }
 
 u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
@@ -373,7 +456,9 @@ int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
 	spin_lock(&mux->lock);
 	mux->pending_trailing_fence_signaled = true;
 	r = amdgpu_ring_preempt_ib(mux->real_ring);
+	reset_wcnt_on_all_rings(mux);
 	spin_unlock(&mux->lock);
+
 	return r;
 }
 
@@ -408,10 +493,6 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 	struct amdgpu_mux_entry *e;
 	struct amdgpu_mux_chunk *chunk;
 
-	spin_lock(&mux->lock);
-	amdgpu_mux_resubmit_chunks(mux);
-	spin_unlock(&mux->lock);
-
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
 		DRM_ERROR("cannot find entry!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index aa758ebc86ae..a99647e33c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -39,6 +39,7 @@ struct amdgpu_ring;
  * @sw_rptr: the read pointer in software ring.
  * @sw_wptr: the write pointer in software ring.
  * @list: list head for amdgpu_mux_chunk
+ * @w_cnt: the write count of the current ring.
  */
 struct amdgpu_mux_entry {
 	struct                  amdgpu_ring *ring;
@@ -48,6 +49,7 @@ struct amdgpu_mux_entry {
 	u64                     sw_rptr;
 	u64                     sw_wptr;
 	struct list_head        list;
+	u64                     w_cnt;
 };
 
 struct amdgpu_ring_mux {
@@ -64,6 +66,7 @@ struct amdgpu_ring_mux {
 	struct timer_list       resubmit_timer;
 
 	bool                    pending_trailing_fence_signaled;
+	wait_queue_head_t       wait;
 };
 
 /**
-- 
2.25.1

