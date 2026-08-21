Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E90AC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32D710F459;
	Fri, 21 Aug 2026 19:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SMLfw4FC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D9A10F461
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/4I3aINLKL9i76EA254KxiYbX9fJx2bXrw5RlZVoEDKGLyMNjITMSiwlEynMVZ1ueMp362GLeOLjo1ruNgzADmBoObmDvNdG7aqOtWCtS0kf0+jQoB1dGPJsfYfMiBqT7A1IrlhyZjYawUP/ruJAPcjvEbHAVFVJ2fohI7Al/jn0XdMwKl4NIKU5sfFGH2UJ5HNGe67lVv1nTE8eaRqQQ8GauzmSFmeAG+DWZ/eQapP8GL36vmtHjDNqFXt8BBUjNcb5tuZ/JiL/3LN66deITYl2s7w9YoLNhYFMT7lCt5TQpAW/sZueZJR7A9CKyNvPShzCB9p7/RA9H/FfBzDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxXyLE1tQICv45rkgKyLufczuBAzSzo/E/zMQki8u3E=;
 b=g0HzGNuCD82HiNe1ZvD5JYBIoBBzXZJ9o9Aei4IAtL/rJX9oJhrENz7cYXp0sPyoGbLhGNQ/YnnCRA3S6RlyYMAgmN8Qtvw9F0R5DKLeIrbHlhQJTkRsdMB20/VxVmq0fdp2AW4sLby2YbunUJM+Wz4WkqZThWEl10JPY2RU7UAgka3G6bhwJjCzEePacYyY5rmcJx2omxPdH92Cyqwsp30W96lxod+gs8d5nBRUk6y1WQR/d8jdOq0j2u7cHNNHik0NOuzs5XE3vyK6xRYpIk4I76RfQsPp3SnWXofnwIvE8pOYbn1dd/mK4kM2qQy0xDbLW2TP97r4l0Kouhx+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxXyLE1tQICv45rkgKyLufczuBAzSzo/E/zMQki8u3E=;
 b=SMLfw4FCHM7LpvoB3ZziRKq057Q6CqJW7+JmlmkvuP9cmk+o1ClXMHRxyaJbrkARp7rcAjCTpv+E82EICpkZgpF780WySwWiSdZ1J5AG2qLnzl+m0zJG1H5FdyCXb+76xrdK1KDVO6v8tSf8rSa9LEEspW7gNClOX7zBtxdZM7A=
Received: from CH2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:610:4c::15)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:33 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::4a) by CH2PR10CA0005.outlook.office365.com
 (2603:10b6:610:4c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/95] drm/amdgpu: Add UALink remote state structures and API
 declarations
Date: Fri, 21 Aug 2026 15:33:54 -0400
Message-ID: <20260821193458.808626-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dcc537-4829-476c-642a-08deffbb5e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|18002099003|22082099003|10067099003|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: nNXrFwXRiSRCk2XzREnS9XZVCh+vAzFvO9Xy7deC/YEqXpioJVPeWII8wYtOUSa1Xc8F70ahVYJxHBxOcxk4Ju4VZk9S6ekA/OnWyrtsnoJiwJca6eO1I3NOstyZT6sTIxQZ9TiUDMBMgWRF/ZLOkXvQq6xd36NMbY9yIH/TS36KKlbk20JRtDgGZ/V6fCNir4reRsvq4wgvuiC87edAKSoSFdy9K3Z/wncp7kr7UssQaZ/Yu9AIsAQH/hTRFNQ3eQaUiqmIt2r0FXsxLU3WaeAGeUH4sdtHwVjb3kIj/4K5Mo5wrNgoITfNvQnMFXGDG7s/wEy+/c889sY5h+lVYUN852OckxzMQQzLPRKwHsrmscaboQNhTpnnSHvh8yL/sILtMt6UpPH8rI9GU3Vkgf/3UaFguYX1YWMeDNnTwRQhx14XhZRkK1MuOMSJIlruSFEXpHH3KBwKb34vp6NaYjtzRBKo8QZK9Lf1+W+ihx+w40mJ/q9AvEWbXqyS78pCG/nziS21AAuNaAafPE9fOfYscOj5K2MSTG0GKBETUT4pd6l0MmTi5Tkp0BNFum4uFfE2bz4KAp1Dl7PvFS3+yVyZhv1dmq8liycgceaO1rNCVBlzHgab55EpKQgLkL3c1L7IuxMDPJQdoXukVR0BR8/ZcCbsFijCbcO5xIuojNyTp+JTEbUkjliCr2PDIwfpByOE2c5MWnQi+m9mZP6uKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rrkciSmvA4wpOnH/B7XPp7YJP5q+y9vx7LzKSA2AwLxK4pmvZKDzli7PR0Q9dFsRbzqAJX281C6BrjGME/i9SGdi8HD7r/YBkgDhXc522H/sDv71r7VIdbp6c1NnjlX1fLUVLLcpiJlJXwLg+nyU/fpRXKsH+p6Rbidt1VF8QJOqq+cwbXzbVvaSfCd/u9HzV4adQhP805/bPvkVXjc9b2j+Awv/JQB3jNrGQChk+P74f9HoykhupHm/Jj/N8IE912jalZaeOzdmUjqlvJ4XO2cXxSiiiiZeuWhkgm+iz57x1mYtgNdxOo3GX8VwYDsk9Ofo0MiDqE/I3AhJOj3Hg27B4tjZkdZC3wccPGnbrhVBM3XnFf7RJIVTcvDSGDQJHwx1Xcfs8iTAR++uQg/lVfsFN9etpxl/AeKiFqnnUrc7FDQbhCYDdGfxCLSd7Waf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:33.6881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dcc537-4829-476c-642a-08deffbb5e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Extend the UALink manager with data structures for cross-GPU interrupt
and TLB shootdown: per-ring state, per-peer channel pairs, and the
top-level remote container.

Declare the public init, teardown, and reset APIs.

Define ring buffer capacity, firmware command and status codes, SMN
mailbox register addresses, and the metadata and writeback buffer layouts
shared between driver and MPNHT firmware.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 140 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  12 ++
 2 files changed, 152 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9bcf7957d56d6..511360335ed99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1195,3 +1195,143 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 	destroy_workqueue(adev->ualink.npa_wq);
 	amdgpu_vm_fini(adev, &adev->ualink.npa_vm);
 }
+
+/*
+ * UALink remote interrupt and shootdown
+ */
+
+/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
+#define AMDGPU_UALINK_RB_SIZE	4096
+
+#define AMDGPU_UALINK_METADATA_HEADER	0x4E485446
+
+/* UALINK F/W commands */
+#define AMDGPU_UALINK_FW_CMD_LOAD_METADATA	0x1
+#define AMDGPU_UALINK_FW_CMD_HALT_OPERATION	0x2
+
+/* UALINK F/W status */
+#define AMDGPU_UALINK_FW_STATUS_PREINIT	0xA0
+#define AMDGPU_UALINK_FW_STATUS_READY	0xA1
+#define AMDGPU_UALINK_FW_STATUS_HALT	0xA2
+#define AMDGPU_UALINK_FW_STATUS_ERROR	0xA3
+#define AMDGPU_UALINK_FW_STATUS_FATAL	0xF0
+
+/* UALINK mailbox registers via SMN, copy of MP1 */
+/* send command to nht f/w */
+#define mmMPNHT_SMN_C2PMSG_22_ALT_2	0xAE10958
+/* additional data */
+#define mmMPNHT_SMN_C2PMSG_23_ALT_2	0xAE1095C
+/* metadata address low */
+#define mmMPNHT_SMN_C2PMSG_24_ALT_2	0xAE10960
+/* metadata address high */
+#define mmMPNHT_SMN_C2PMSG_25_ALT_2	0xAE10964
+/* f/w status */
+#define mmMPNHT_SMN_C2PMSG_26_ALT_2	0xAE10968
+
+struct amdgpu_ualink_metadata {
+	u32 header;
+
+	/*
+	 * "ring entries" as unit. So the ring-size-in-bytes could be calculated
+	 * as entry-size * 2^RBsize. This would make the minimum size a single
+	 * entry and the maximum size 32786 entries.
+	 *
+	 * u32 rb_size:4;
+	 * u32 reserved0:4;
+	 * u32 vmid:4;
+	 * u32 reserved1:20;
+	 */
+	u32 rb_size;
+
+	/* ring buffer base address for remote interrupt */
+	u64 ri_rb;
+
+	/* tlb invalidate ring buffer base address for remote shootdown */
+	u64 tlb_inv_rb;
+
+	/* remote interrupt Tail pointer, write pointer address */
+	u64 tailptr_ri;
+
+	/* TLB invalidate ring buffer's Tail pointer, write pointer address */
+	u64 tailptr_tlb_inv;
+};
+
+struct amdgpu_ualink_wb {
+	/* last finished command seq number */
+	u32 data;
+
+	/* command complete error code */
+	u32 status;
+
+	/* ring rptr updated by FW */
+	u64 rptr;
+};
+
+/*
+ * For remote interrupt and shootdown
+ */
+struct amdgpu_ualink_ring {
+	u32 rb_size;
+
+	/* writeback data */
+	u32 seq;
+
+	/* local copy */
+	u64 wptr, rptr;
+
+	/* NPA gart mapping for SDMA */
+	u64 rb_npa_gart;
+	u64 wptr_npa_gart;
+	u64 doorbell_npa_gart;
+
+	/* gart mapping node */
+	struct drm_mm_node mm_node_rb;
+	struct drm_mm_node mm_node_wptr;
+	struct drm_mm_node mm_node_doorbell;
+
+	/* true if fw write back address updated successfully */
+	bool ready;
+};
+
+struct amdgpu_ualink_peer {
+	/* remote interrupt and shootdown uses same SDMA entity */
+	struct mutex lock;
+
+	/* SDMA engine to send remote command via NPA */
+	struct drm_sched_entity entity;
+
+	/* to select different DXS ports, cycles through different values */
+	u32 dxs_port;
+
+	struct amdgpu_ualink_ring interrupt;
+	struct amdgpu_ualink_ring shootdown;
+};
+
+struct amdgpu_ualink_remote {
+	/* ualink metadata passed to MPNHT FW */
+	struct amdgpu_bo		*metadata_bo;
+	u64				metadata_gpu_addr;
+	void				*metadata_cpu_addr;
+
+	/* ualink ring, tlb ring buffer, wptr */
+	struct amdgpu_bo		*ring_bo;
+	u64				rb_gpu_addr;
+	void				*rb_cpu_addr;
+
+	/* ualink rptr, wb data, statuss for address alias mode */
+	struct amdgpu_bo		*rptr_bo;
+	u64				rptr_gpu_addr;
+	void				*rptr_cpu_addr;
+	u64				rptr_npa;
+
+	/* address alias mode alloc npa address for shared wb */
+	struct drm_mm_node		rptr_mm_node;
+
+	/* active accelator id bitmap of the pod */
+	unsigned long			*active_accel_bits;
+	u32				num_accel;
+
+	/* remote GPUs ring buffer, read, write pointer local copy and gart mapping */
+	struct amdgpu_ualink_peer	peer[AMDGPU_UALINK_ACCEL_MAX];
+};
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 506335b56c3b8..0d1b46a53e97a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -135,6 +135,8 @@ struct amdgpu_ualink_connection {
 	enum amdgpu_ualink_conn_state state;
 };
 
+struct amdgpu_ualink_remote;
+
 struct amdgpu_ualink_mgr {
 	u64 npa_size;
 	u32 psp_if_ver;
@@ -143,6 +145,12 @@ struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_vpod_config *config;
 	struct amdgpu_ualink_station_config *stations;
 
+	/* For remote interrupt and shootdown */
+	struct amdgpu_ualink_remote *remote;
+
+	/* handle irq from ualink client of remote GPUs */
+	struct amdgpu_irq_src irq;
+
 	/* Xarray to store info about exported BOs */
 	struct xarray	exp_xa;
 
@@ -175,6 +183,10 @@ struct amdgpu_ualink_mgr {
 	struct amdgpu_vm npa_vm;
 };
 
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
+int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
+void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_init(struct amdgpu_device *adev);
-- 
2.55.0

