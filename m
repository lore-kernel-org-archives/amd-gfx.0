Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82646C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 09:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C108910E236;
	Tue, 27 Sep 2022 09:14:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5820F10E0C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 09:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULQ+ZYAbBZUgVgyVmQZ2xBwvhSpJtrY/jQNyb3XY2IMc/k3aa9BLfAVQ10wvYB3M2M2wmLAE/F9Ut9348fQo62LWEIYvQJcxeN5RW6cCB4XB3GZZmAs8PO2D9Fz27743yYr3VhETyIizRTYNAaTIx7vkCJ7IRv8HnJtjzjDcEYu0JMrT8YIU4LP+AYUgSkLMjaXAiXjdXAUj6WGbQK1573XW3LGXzwfEklhoXDsJPtsxdvT1UAZg25+trBApLoLhZVra/WtsiFg2S3FLTMx8/dtiHfSaTYVGippOTnqvapI8tdPkAw8yMbAA08KT4O/znSap+2pAqXncJ6xD0XCxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t33g+qmKIumdMEQUoMfn7DhViysdQBHpwQr1cdOYryE=;
 b=DgIXcIbufeEl6WMJ5t7EFKvAqCMYlp8FKesjLWTmVdMC7sIhNiqZ+vcTayxk4AgNC4CD5neMRHzx7KUOl4zA5wT7klb/2lUulTEZmvuPtEjMfe9i5EVt8VZa+Ncd3Z/6hY8jrLMmo2YKBSQMGSPwjlpeXosUxD+WmtuVLu4ZfB0KHQB+VpG47VfdnuYL90xNn9knHHX8vD3Mq0T05z2oWcQZDoYpwcPgoVXx/suVWhGdgdWwsCJGXKzooldnIQn3HtvMX5xh7gF8Pa7UwTxg/X4tK1kRg7Hp6JRa3SQ+0ne/PZbBUdl+F5/FWGfuWOJ/yKaG3DYUAgu1sKDiPGVI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t33g+qmKIumdMEQUoMfn7DhViysdQBHpwQr1cdOYryE=;
 b=SIiGWWR2SnCoGcyhx7pcanGsQRsAk7vqf3vKOY4htDtw49TJ5gXOKBYfWJnc5jBDXL+5CzLtqCFSgj5IuzXUWgx+Vb/sya0XyYwoZF5LMU+iRae22eIvHQdeUgirGfUIGpDvSErzOEvxarRN6+neLKaK9+yylMiZNxbtpeDikaQ=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 09:13:47 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c8) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 09:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 09:13:46 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 27 Sep 2022 04:13:43 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: MCBP based on DRM scheduler (v7)
Date: Tue, 27 Sep 2022 17:13:11 +0800
Message-ID: <20220927091311.1784774-4-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927091311.1784774-1-jiadong.zhu@amd.com>
References: <20220927091311.1784774-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|BL1PR12MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: b306ed93-2c88-4b91-58a7-08daa0689581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qeNNVe4ZHDHWJw5rvDc8hd1R4BLACPXeRP2dfzw6V4fsRHtsxcYegY81F3Bsm6QwKBX3GwNDjFbbrvm/4q3lpgn3gjj0efK9XJndG+k6Uw755CAhPz2cN0IhV/NzcDnQHlsuytNGiW1MgSBUphWiKkqvd7EzHQq1LVYHAzaJDBWVS79v9w+Y3QCYaYomSwSEcUDyY87B5g0+Mo/dz/hhicy8oB3kLi5jUKTjBKkc1S8feCBoFJmfs3+b6S0CSU83B3BeGupwqlbhSlYx+uFDTLEC//z3rCCIYOhdCFtBa68MexF41YCJrqEimcwP5JzINxWCAos6zsxkKJswHBb8z1CT+GaV9avkntCuBdtBH87wWy1AZIG++EffoNVUvIse+RgjWg83zOlIgPuBkFabrU31E+v4DjsVCzt7mW2359bvzN3jmB8nRQeYluFG/Ws5aixZHCEAwb/ajwKNtbDZCiWWD5TCfhOzXbPIEZoeYRq3BGAc6GxxvQGpyIHeLanAALmXGRUPDFTFc2aa6OOYp4PX41ZjaPqao/3jW/mk7N44tBsS9Rj9GEp3kvADAfMYc7XIAlMdc9NIIzdYXwFujDCZwRvQ+nrDhJ2QhO+yMdRunhlMsZmdMih8u+o/vy7JqeNph1yJrmImGHgEfEPbhe7PiGWnE04u0Zziov+HCiA7NbE+gFz6MVo4iy7v6SjIrDtC4QAedjKTuHWh4ga3EdKKtk4FNNt2JR2Jn93mhlpTpXKK0rhQ+xt8uUWs3bMRZgZ+6FRq50xhp/VVFxY7ee3fmTY2pIkwHjK/vOflfmHXLCQoMFkVKkwByDl3b/m
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(26005)(30864003)(5660300002)(8936002)(7696005)(6666004)(40460700003)(83380400001)(41300700001)(82740400003)(36860700001)(2876002)(1076003)(36756003)(2616005)(186003)(2906002)(82310400005)(81166007)(336012)(426003)(16526019)(47076005)(356005)(6916009)(54906003)(40480700001)(4326008)(70206006)(70586007)(86362001)(478600001)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 09:13:46.9796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b306ed93-2c88-4b91-58a7-08daa0689581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Trigger Mid-Command Buffer Preemption according to the priority of the software
rings and the hw fence signalling condition.

The muxer saves the locations of the indirect buffer frames from the software
ring together with the fence sequence number in its fifo queue, and pops out
those records when the fences are signalled. The locations are used to resubmit
packages in preemption scenarios by coping the chunks from the software ring.

v2: Update comment style.
v3: Fix conflict caused by previous modifications.
v4: Remove unnecessary prints.
v5: Fix corner cases for resubmission cases.
v6: Refactor functions for resubmission, calling fence_process in irq handler.
v7: Solve conflict for removing amdgpu_sw_ring.c.

Cc: Christian Koenig <Christian.Koenig@amd.com>
Cc: Luben Tuikov <Luben.Tuikov@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 348 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  10 +-
 7 files changed, 361 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 258cffe3c06a..af86d87e2f3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		}
 	}
 
+	amdgpu_ring_ib_begin(ring);
 	if (job && ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
@@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 13db99d653bd..1f15f9242e99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -569,3 +569,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
 
 	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
 }
+
+void amdgpu_ring_ib_begin(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_begin(ring);
+}
+
+void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_end(ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e90d327a589e..6fbc1627dab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -312,6 +312,9 @@ struct amdgpu_ring {
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
 
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
+void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
+
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 2e64ffccc030..ebb37df2c897 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -37,23 +37,142 @@ static const struct ring_info {
 	{ AMDGPU_RING_PRIO_2, "gfx_high"},
 };
 
+static struct kmem_cache *amdgpu_mux_chunk_slab;
+
+static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
+								struct amdgpu_ring *ring)
+{
+	return ring->entry_index < mux->ring_entry_size ?
+			&mux->ring_entry[ring->entry_index] : NULL;
+}
+
+/* copy packages on sw ring range[begin, end) */
+static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
+						  struct amdgpu_ring *ring,
+						  u64 s_start, u64 s_end)
+{
+	u64 start, end;
+	struct amdgpu_ring *real_ring = mux->real_ring;
+
+	start = s_start & ring->buf_mask;
+	end = s_end & ring->buf_mask;
+
+	if (start == end) {
+		DRM_ERROR("no more data copied from sw ring\n");
+		return;
+	}
+	if (start > end) {
+		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
+					   (ring->ring_size >> 2) - start);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
+	} else {
+		amdgpu_ring_alloc(real_ring, end - start);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
+	}
+}
+
+static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
+{
+	struct amdgpu_mux_entry *e = NULL;
+	struct amdgpu_mux_chunk *chunk;
+	uint32_t seq, last_seq;
+	int i;
+
+	/*find low priority entries:*/
+	if (!mux->s_resubmit)
+		return;
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
+			e = &mux->ring_entry[i];
+			break;
+		}
+	}
+
+	if (!e) {
+		DRM_ERROR("%s no low priority ring found\n", __func__);
+		return;
+	}
+
+	last_seq = atomic_read(&e->ring->fence_drv.last_seq);
+	seq = mux->seqno_to_resubmit;
+	if (last_seq < seq) {
+		/*resubmit all the fences between (last_seq, seq]*/
+		list_for_each_entry(chunk, &e->list, entry) {
+			if (chunk->sync_seq > last_seq && chunk->sync_seq <= seq) {
+				amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, e->ring,
+								      chunk->start,
+								      chunk->end);
+				mux->wptr_resubmit = chunk->end;
+				amdgpu_ring_commit(mux->real_ring);
+			}
+		}
+	}
+
+	del_timer(&mux->resubmit_timer);
+	mux->s_resubmit = false;
+}
+
+static void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
+{
+	mod_timer(&mux->resubmit_timer, jiffies + AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
+}
+
+static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
+{
+	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
+
+	if (!spin_trylock(&mux->lock)) {
+		amdgpu_ring_mux_schedule_resubmit(mux);
+		DRM_ERROR("reschedule resubmit\n");
+		return;
+	}
+	amdgpu_mux_resubmit_chunks(mux);
+	spin_unlock(&mux->lock);
+}
+
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 			 unsigned int entry_size)
 {
 	mux->real_ring = ring;
 	mux->num_ring_entries = 0;
+
 	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
 	if (!mux->ring_entry)
 		return -ENOMEM;
 
 	mux->ring_entry_size = entry_size;
+	mux->s_resubmit = false;
+
+	amdgpu_mux_chunk_slab = kmem_cache_create("amdgpu_mux_chunk",
+						  sizeof(struct amdgpu_mux_chunk), 0,
+						  SLAB_HWCACHE_ALIGN, NULL);
+	if (!amdgpu_mux_chunk_slab) {
+		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
+		return -ENOMEM;
+	}
+
 	spin_lock_init(&mux->lock);
+	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
 
 	return 0;
 }
 
 void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
 {
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk, *chunk2;
+	int i;
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		e = &mux->ring_entry[i];
+		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
+			list_del(&chunk->entry);
+			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
+		}
+	}
+	kmem_cache_destroy(amdgpu_mux_chunk_slab);
 	kfree(mux->ring_entry);
 	mux->ring_entry = NULL;
 	mux->num_ring_entries = 0;
@@ -73,62 +192,48 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 	ring->entry_index = mux->num_ring_entries;
 	e->ring = ring;
 
+	INIT_LIST_HEAD(&e->list);
 	mux->num_ring_entries += 1;
 	return 0;
 }
 
-static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
-								struct amdgpu_ring *ring)
-{
-	return ring->entry_index < mux->ring_entry_size ?
-			&mux->ring_entry[ring->entry_index] : NULL;
-}
-
-/* copy packages on sw ring range[begin, end) */
-static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
-						  struct amdgpu_ring *ring,
-						  u64 s_start, u64 s_end)
-{
-	u64 start, end;
-	struct amdgpu_ring *real_ring = mux->real_ring;
-
-	start = s_start & ring->buf_mask;
-	end = s_end & ring->buf_mask;
-
-	if (start == end) {
-		DRM_ERROR("no more data copied from sw ring\n");
-		return;
-	}
-	if (start > end) {
-		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
-		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
-					   (ring->ring_size >> 2) - start);
-		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
-	} else {
-		amdgpu_ring_alloc(real_ring, end - start);
-		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
-	}
-}
-
 void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
 {
 	struct amdgpu_mux_entry *e;
 
+	spin_lock(&mux->lock);
+
+	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
+		amdgpu_mux_resubmit_chunks(mux);
+
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
 		DRM_ERROR("cannot find entry for sw ring\n");
+		spin_unlock(&mux->lock);
+		return;
+	}
+
+	/* We could skip this set wptr as preemption in process. */
+	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && mux->pending_trailing_fence_signaled) {
+		spin_unlock(&mux->lock);
 		return;
 	}
 
-	spin_lock(&mux->lock);
 	e->sw_cptr = e->sw_wptr;
+	/* Update cptr if the package already copied in resubmit functions */
+	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && e->sw_cptr < mux->wptr_resubmit)
+		e->sw_cptr = mux->wptr_resubmit;
 	e->sw_wptr = wptr;
 	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
 
-	amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
-	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
-	amdgpu_ring_commit(mux->real_ring);
-
+	/* Skip copying for the packages already resubmitted.*/
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT || mux->wptr_resubmit < wptr) {
+		amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
+		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
+		amdgpu_ring_commit(mux->real_ring);
+	} else {
+		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
+	}
 	spin_unlock(&mux->lock);
 }
 
@@ -145,7 +250,7 @@ u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ri
 	return e->sw_wptr;
 }
 
-/*
+/**
  * The return value of the readptr is not precise while the other rings could
  * write data onto the real ring buffer.After overwriting on the real ring, we
  * can not decide if our packages have been excuted or not read yet. However,
@@ -235,3 +340,168 @@ unsigned int amdgpu_sw_ring_priority(int idx)
 	return idx < ARRAY_SIZE(sw_ring_info) ?
 		sw_ring_info[idx].hw_pio : AMDGPU_RING_PRIO_DEFAULT;
 }
+
+/*Scan on low prio rings to have unsignaled fence and high ring has no fence.*/
+int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
+{
+	struct amdgpu_ring *ring;
+	int i, need_preempt;
+
+	need_preempt = 0;
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		ring = mux->ring_entry[i].ring;
+		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT &&
+		    amdgpu_fence_count_emitted(ring) > 0)
+			return 0;
+		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT &&
+		    amdgpu_fence_count_emitted(ring) > 0)
+			need_preempt = 1;
+	}
+	return need_preempt && !mux->s_resubmit;
+}
+
+/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */
+int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
+{
+	int r;
+
+	spin_lock(&mux->lock);
+	mux->pending_trailing_fence_signaled = true;
+	r = amdgpu_ring_preempt_ib(mux->real_ring);
+	spin_unlock(&mux->lock);
+	return r;
+}
+
+void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	WARN_ON(!ring->is_sw_ring);
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
+		if (amdgpu_mcbp_scan(mux) > 0)
+			amdgpu_mcbp_trigger_preempt(mux);
+		return;
+	}
+
+	amdgpu_ring_mux_start_ib(mux, ring);
+}
+
+void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	WARN_ON(!ring->is_sw_ring);
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
+		return;
+	amdgpu_ring_mux_end_ib(mux, ring);
+}
+
+void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk;
+
+	spin_lock(&mux->lock);
+	amdgpu_mux_resubmit_chunks(mux);
+	spin_unlock(&mux->lock);
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
+	if (!chunk) {
+		DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
+		return;
+	}
+
+	chunk->start = ring->wptr;
+	list_add_tail(&chunk->entry, &e->list);
+}
+
+static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	uint32_t last_seq, size = 0;
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk, *tmp;
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	last_seq = atomic_read(&ring->fence_drv.last_seq);
+
+	list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
+		if (chunk->sync_seq <= last_seq) {
+			list_del(&chunk->entry);
+			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
+		} else {
+			size++;
+		}
+	}
+}
+
+void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk;
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
+	if (!chunk) {
+		DRM_ERROR("cannot find chunk!\n");
+		return;
+	}
+
+	chunk->end = ring->wptr;
+	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
+
+	scan_and_remove_signaled_chunk(mux, ring);
+}
+
+bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_ring *ring = NULL;
+	int i;
+
+	if (!mux->pending_trailing_fence_signaled)
+		return false;
+
+	if (mux->real_ring->trail_seq != le32_to_cpu(*mux->real_ring->trail_fence_cpu_addr))
+		return false;
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		e = &mux->ring_entry[i];
+		if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
+			ring = e->ring;
+			break;
+		}
+	}
+
+	if (!ring) {
+		DRM_ERROR("cannot find low priority ring\n");
+		return false;
+	}
+
+	amdgpu_fence_process(ring);
+	if (amdgpu_fence_count_emitted(ring) > 0) {
+		mux->s_resubmit = true;
+		mux->seqno_to_resubmit = ring->fence_drv.sync_seq;
+		amdgpu_ring_mux_schedule_resubmit(mux);
+	}
+
+	mux->pending_trailing_fence_signaled = false;
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index 28399f4b0e5c..aa758ebc86ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -29,6 +29,7 @@
 #include "amdgpu_ring.h"
 
 struct amdgpu_ring;
+
 /**
  * struct amdgpu_mux_entry - the entry recording software rings copying information.
  * @ring: the pointer to the software ring.
@@ -37,6 +38,7 @@ struct amdgpu_ring;
  * @sw_cptr: the position of the copy pointer in the sw ring.
  * @sw_rptr: the read pointer in software ring.
  * @sw_wptr: the write pointer in software ring.
+ * @list: list head for amdgpu_mux_chunk
  */
 struct amdgpu_mux_entry {
 	struct                  amdgpu_ring *ring;
@@ -45,6 +47,7 @@ struct amdgpu_mux_entry {
 	u64                     sw_cptr;
 	u64                     sw_rptr;
 	u64                     sw_wptr;
+	struct list_head        list;
 };
 
 struct amdgpu_ring_mux {
@@ -55,6 +58,26 @@ struct amdgpu_ring_mux {
 	unsigned int            ring_entry_size;
 	/*the lock for copy data from different software rings*/
 	spinlock_t              lock;
+	bool                    s_resubmit;
+	uint32_t                seqno_to_resubmit;
+	u64                     wptr_resubmit;
+	struct timer_list       resubmit_timer;
+
+	bool                    pending_trailing_fence_signaled;
+};
+
+/**
+ * struct amdgpu_mux_chunk - save the location of indirect buffer's package on softare rings.
+ * @entry: the list entry.
+ * @sync_seq: the fence seqno related with the saved IB.
+ * @start:- start location on the software ring.
+ * @end:- end location on the software ring.
+ */
+struct amdgpu_mux_chunk {
+	struct list_head        entry;
+	uint32_t                sync_seq;
+	u64                     start;
+	u64                     end;
 };
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
@@ -64,15 +87,17 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
 u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux);
 
 u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
 u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
 void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
-
 void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
-
 const char *amdgpu_sw_ring_name(int idx);
 unsigned int amdgpu_sw_ring_priority(int idx);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9596c22fded6..b7e94553f4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -601,6 +601,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
 		return 0;
 
+	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
@@ -661,6 +662,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_switch_buffer(ring);
 		amdgpu_ring_emit_switch_buffer(ring);
 	}
+	amdgpu_ring_ib_end(ring);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0864801241f6..c8d454da01c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5615,7 +5615,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	ring->trail_seq += 1;
 	amdgpu_ring_alloc(ring, 13);
 	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
-				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
+				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
 	/*reset the CP_VMID_PREEMPT after trailing fence*/
 	amdgpu_ring_emit_wreg(ring,
 			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
@@ -6041,9 +6041,11 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
 
 	switch (me_id) {
 	case 0:
-		/* Fence signals are handled on the software rings*/
-		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
-			amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
+		if (!amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
+			/* Fence signals are handled on the software rings*/
+			for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+				amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
+		}
 		break;
 	case 1:
 	case 2:
-- 
2.25.1

