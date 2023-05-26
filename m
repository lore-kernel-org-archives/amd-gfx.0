Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BE3C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 01:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D24F10E0DE;
	Fri, 26 May 2023 01:19:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6149410E793
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 01:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE67u4sKREipwLFnS7uRuZbe0hAzpBke7Q8JZIdNMv9IebzKfIH3ydzp2LjK6VuzAmrxMkr4oJdp6MfMJWLTCHA72qTXL8aJEPZKVABiCA25POEqEPvCMrGseq3xRG5gts/7khhnUAW0kP/ug8XtnhkgCwT75/1bjxU3c4etwIzHSCEEfkvzTT0yM4XnRT6sUeqzgseYXjvpkT4ARmjjeWJKRb9jbKiPFKGBxJEilOSwGEtZbmrYcpJz9a5ZYl5jofG9qTh3mjKovFWmXD7tcwzngMQZLB5Z343KEPexUF8P+ITR9KLfXcfBSyj9ZMHwt89emH5qLnrED0Oio+fLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu/Fd56uQSFEBHQFaj3wcqjdBbfYjgBgKXbL9d+dkq8=;
 b=H79kNB4p3I4XfeDAXAI3/q+8RO4/p9fX+xLhzdTCTj9wvTIABimFzCa0miu2TGWn9NifVyW/a1XXydmq9i/UAQmDaOrvHaeUjsDK1Wyqf8TklYGwMaNJw30IPRZMH5UU9NdzBbco976W5IlmyMnudYmX+KSZLGsDYNrh0/oPA27Tv5J6M1YOMTUqj5s6rdJcMNqqKFFr83VfOG8cFCgvtLNnOOP/9TMyp1u5e2e5J2Ca8WMmGDnLXvE0U3iAhgd02qXn7OES0tmL1W2BZLCaM0aUa9HIKM+ZpsuDiAR8/YMIGcgcga8Da89pKDOW5eYKDnLsfUtoXqpYH0f7wQJ+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu/Fd56uQSFEBHQFaj3wcqjdBbfYjgBgKXbL9d+dkq8=;
 b=wJiSz4cuS1BLtJ0HW9bFIpnRK3rOWI4zQ0KJsU0hdtAzLJx2ns4h9LxTDhP4gzgXUHnD8k45cei8/zrRDQPbJdlvkUPw7RrQ3zJAAt4UU+ReUYtgtw/700HlFpxUmkrD/Gx8aRnu2nysac82swvpTt8pEmynjoOwR41rowrsSZE=
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 01:19:26 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::36) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Fri, 26 May 2023 01:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.17 via Frontend Transport; Fri, 26 May 2023 01:19:25 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 25 May 2023 20:19:24 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Modify indirect buffer packages for
 resubmission
Date: Fri, 26 May 2023 09:18:45 +0800
Message-ID: <20230526011846.3331119-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e0afa2-b48b-4040-4200-08db5d873ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGwhAxOFo/moCv5VsO4SL2JjFx71kp0H9vgotLt9hwxVbTEsmZSSU+C8IaVXRZiIlIRM6pc29HxeD5h8JrN5JLCDysIrpG9Njaf9wZPIZL4pxhyLUSC/pGfyDLRjc+o05RhepXlIxxZJbCZJjHMnPbQhu10vrtRWfO4XCUaUPBliA9U6j9Z7o+rxd2Zet6hyHcn15BiVBMvQIHs5tbn3dcuSG7CdTVxIuasIK4VQ7+tLyuGb3vAVvdTYEe9cgTom0WtbSdNIptpgPUbJLcuOGCPsJQ+0b3ET43ZcZCz7+HM+xWz0/6qGbMr+TyBmD6OtqGqADfBQiZmxzmAeykm9d9q5ULTb5xX/WvBnkxa5qk7Ecaj7Nxix0r546KZzh/K7EvdtkAv52gLpVUfUZOjAktdhnLBnJMPLxDn35+d0QTNuuR9+ZuQA6l5gAzkILMcjtM1BNMFlssPK3yS/YmgsqtJAyPAmB5aGzHV9hSqnTSx3iDlDCIjVTHSUJqH7hFVSS6w52XMJX5KZdNxOkvXdG9xjai6wx2cLd19HNRw+tFqS6K43CJrVnELB0Yxo5a/VFxvAK8365Pm4ZKdugDlSA6jJbXlk4M49S1rSeR6tKaQWo+xHhEy5BElqr0T/z0dGSMwxgcuD8n4NAEUtF1rzx0ztbOoPR5sbLZQC4Q1ut/SoS+FKR9G1MpOwuentyEFXQJ84Tv9X7pOuWqK1m6k9HEYlCI591n6JMt6K+sfoLFW1G46SUww5Ydb0sj4D7rJs3s+Qpojv+1VQ5LPmUbv9Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(2876002)(2906002)(5660300002)(47076005)(36860700001)(82310400005)(8936002)(8676002)(70206006)(6666004)(40460700003)(41300700001)(4326008)(70586007)(36756003)(478600001)(6916009)(316002)(7696005)(40480700001)(81166007)(2616005)(26005)(86362001)(83380400001)(186003)(16526019)(356005)(336012)(426003)(1076003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 01:19:25.7817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0afa2-b48b-4040-4200-08db5d873ecc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

When the preempted IB frame resubmitted to cp, we need to modify the frame
data including:
1. set PRE_RESUME 1 in CONTEXT_CONTROL.
2. use meta data(DE and CE) read from CSA in WRITE_DATA.

Add functions to save the location the first time IBs emitted and callback
to patch the package when resubmission happens.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     | 18 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 60 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h | 15 +++++
 4 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 7429b20257a6..12ba863e69f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -692,3 +692,21 @@ void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
 	if (ring->is_sw_ring)
 		amdgpu_sw_ring_ib_end(ring);
 }
+
+void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_CONTROL);
+}
+
+void amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_CE);
+}
+
+void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_DE);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index baa03527bf8b..702ce55b962a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -229,6 +229,9 @@ struct amdgpu_ring_funcs {
 	int (*preempt_ib)(struct amdgpu_ring *ring);
 	void (*emit_mem_sync)(struct amdgpu_ring *ring);
 	void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
+	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
+	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
+	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 };
 
 struct amdgpu_ring {
@@ -323,11 +326,17 @@ struct amdgpu_ring {
 #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
 #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
+#define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
+#define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
+#define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
 void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);
 
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 62079f0e3ee8..73516abef662 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -105,6 +105,16 @@ static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
 				amdgpu_fence_update_start_timestamp(e->ring,
 								    chunk->sync_seq,
 								    ktime_get());
+				if (chunk->sync_seq ==
+					le32_to_cpu(*(e->ring->fence_drv.cpu_addr + 2))) {
+					if (chunk->cntl_offset <= e->ring->buf_mask)
+						amdgpu_ring_patch_cntl(e->ring,
+								       chunk->cntl_offset);
+					if (chunk->ce_offset <= e->ring->buf_mask)
+						amdgpu_ring_patch_ce(e->ring, chunk->ce_offset);
+					if (chunk->de_offset <= e->ring->buf_mask)
+						amdgpu_ring_patch_de(e->ring, chunk->de_offset);
+				}
 				amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, e->ring,
 								      chunk->start,
 								      chunk->end);
@@ -407,6 +417,17 @@ void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
 	amdgpu_ring_mux_end_ib(mux, ring);
 }
 
+void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum amdgpu_ring_mux_offset_type type)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+	unsigned offset;
+
+	offset = ring->wptr & ring->buf_mask;
+
+	amdgpu_ring_mux_ib_mark_offset(mux, ring, offset, type);
+}
+
 void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
 {
 	struct amdgpu_mux_entry *e;
@@ -429,6 +450,10 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 	}
 
 	chunk->start = ring->wptr;
+	/* the initialized value used to check if they are set by the ib submission*/
+	chunk->cntl_offset = ring->buf_mask + 1;
+	chunk->de_offset = ring->buf_mask + 1;
+	chunk->ce_offset = ring->buf_mask + 1;
 	list_add_tail(&chunk->entry, &e->list);
 }
 
@@ -454,6 +479,41 @@ static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct a
 	}
 }
 
+void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
+				    struct amdgpu_ring *ring, u64 offset,
+				    enum amdgpu_ring_mux_offset_type type)
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
+	switch (type) {
+	case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
+		chunk->cntl_offset = offset;
+		break;
+	case AMDGPU_MUX_OFFSET_TYPE_DE:
+		chunk->de_offset = offset;
+		break;
+	case AMDGPU_MUX_OFFSET_TYPE_CE:
+		chunk->ce_offset = offset;
+		break;
+	default:
+		DRM_ERROR("invalid type (%d)\n", type);
+		break;
+	}
+}
+
 void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
 {
 	struct amdgpu_mux_entry *e;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index 4be45fc14954..b22d4fb2a847 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -50,6 +50,12 @@ struct amdgpu_mux_entry {
 	struct list_head        list;
 };
 
+enum amdgpu_ring_mux_offset_type {
+	AMDGPU_MUX_OFFSET_TYPE_CONTROL,
+	AMDGPU_MUX_OFFSET_TYPE_DE,
+	AMDGPU_MUX_OFFSET_TYPE_CE,
+};
+
 struct amdgpu_ring_mux {
 	struct amdgpu_ring      *real_ring;
 
@@ -72,12 +78,18 @@ struct amdgpu_ring_mux {
  * @sync_seq: the fence seqno related with the saved IB.
  * @start:- start location on the software ring.
  * @end:- end location on the software ring.
+ * @control_offset:- the PRE_RESUME bit position used for resubmission.
+ * @de_offset:- the anchor in write_data for de meta of resubmission.
+ * @ce_offset:- the anchor in write_data for ce meta of resubmission.
  */
 struct amdgpu_mux_chunk {
 	struct list_head        entry;
 	uint32_t                sync_seq;
 	u64                     start;
 	u64                     end;
+	u64                     cntl_offset;
+	u64                     de_offset;
+	u64                     ce_offset;
 };
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
@@ -89,6 +101,8 @@ u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ri
 u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
+				    u64 offset, enum amdgpu_ring_mux_offset_type type);
 bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux);
 
 u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
@@ -97,6 +111,7 @@ void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
 void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum amdgpu_ring_mux_offset_type type);
 const char *amdgpu_sw_ring_name(int idx);
 unsigned int amdgpu_sw_ring_priority(int idx);
 
-- 
2.25.1

