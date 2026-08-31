Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAEAC624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D2710EA6D;
	Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJgrby8K";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C571910E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipJ6yitKwwpBwCfxif3ipDlQPnK1Vt4zqTW8xr8qL1MJmGpvmXaoqQqKZn7qPIwHieXraQJw1ILwTEO3kTzs8ONtQ49GWaZwSmFhmt7Z9UgW3Sev92KLyG7uzYX5oyciEWbxl5Ek7tOe3dvxPmBvwzUoaUHQ/Zu4514I5LaHBAz1covPMW99LsTtFjzk9+5uS45T5bVkoNYXDJThHjN1t0/en8Q/94RGCb3I3UYMkz2R1+LZpfCmwRT62sL/sNdNXpVD5FjVQk6MKdIljiu1+8vXzMlxMSFN8B1CrYbqJKdniePg5v/6xcav3yap1WqNVd83YUbdk9rljNGmwXbLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwzD5OUt5o5X+I38+rki93RHHgWjHb58c3fPpuw20tI=;
 b=RwQCMWd/1t84dDKAkHeiBOBcdHPXzSjIpv2EJoBvNpYMHwCUrLtlL5pQQTBmjBb4+lwmkbYSkoD7H2jeoi5/z1TeZbI2QtT2XyiuwfhM5/wQUZZOFDVn9F54wReVs9/C2eaG55tGX+yod7DOhmGjfXzG0igWj8Id/QTwND4fWp1YK/eKuX0MtKIKQY8ZYoCQO2+kozuEgOLYinOL0X1KO3PxtP9CYkRBusfuvt1dcdWpDy9pIZCP56NbzgPPNtaZEfOtWVMqTI/d4VlnybNlV1hv5pRNZK3+QlaRKTSUgi8auphkPqIEnsQaXCE77EpNzhZYHUYXh3pTa9P9Z6GrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwzD5OUt5o5X+I38+rki93RHHgWjHb58c3fPpuw20tI=;
 b=nJgrby8Ky8/0BkVe8j4G+RKUxgmeUlQ4Gs+qKVFPy4DqxmqfyboCeqFbqPU0ZHFhZuDzSwmajhIDZI80QCOr3enxUicG7mjhyEg3YiMWxMecLO6YPZaNoq/x20+g07T/PtdXIC1oa2mwjHh1LMOBDYECbopvsD/0AicHEGEV1tE=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 18:28:44 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::95) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/95] drm/amdgpu: Add UALink remote state structures and API
 declarations
Date: Mon, 31 Aug 2026 14:26:50 -0400
Message-ID: <20260831182754.1089811-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: df1612c4-70f3-430c-d6a3-08df078db037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Rv64+PD1W9191OB5tXxvwVGQPNn/pb2JCrLvi/1Li2y2W+Q9AHSDLEwmR2E4Qyr1diSC+ecaFnUrbTMX/IYf6Rm6E4WlYYALYHAR/zn0BLnXbtoQj/MLh0dX6yNjJ1QLt52Q3YDi9Ic4UyTxESc2OLBML809AV+jkpfYwcx70JzwB1bnS02WBvjNNkSdD5FzKLAZ5+xsXKdN0OWtC4IB4jzCW2m8B+qqeXtfpCsSTauSL/yKwQRWllQ8RZgd/0xGAShqIAOGmYYq/T+D5Oa91xxMDXI8rSj3k3hJq+7eLZvWsWntRRqanOcCVXpy0lEGDfaPcZQryp8E1YTOH06P6UZ5F1xUh0aJSx2rl2mnWBjhztA139pjjiW0BtrhwMvd1KzDSLtJAKSzROcDgRXvGHuvauiwff3v71fBdeT8Gd3KmzbuVhnc9xqVBMpzNJd2rhZyCR1MXzeShyUtS6QCh7Y34U71usPAggpMBrzwOXeXVAtjFMdwc74mfI43zbJmDq5K8nLyQPCLITkuYvrM4yTebDKbq+yoWWbKSfvqhhmRYxbsDd/ffUTAif28iQZV5wB0ldPGecEVQ9/kU3vfATPCizypUlNwLYMlWB9GRHj92oJ/9vBIucAT7WIg6zlVMGxhiPjntxiU+HtIpYks1+ansCk2KEWNzRoAJANmgjuABet1Voztl+9cePGDZEpIz3UxPmXJmZv+mGg2m/1Dyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y26D5vt8yd95PNq9UY62jeM1Yb635cprf82t2pWOZs4qmAESKa3LL9+MBjWpQxgRW8LemF3aadP20pfqmlYPcY3sCDcPGjEkvpvCeTdMmAgRvytbdhqEnzQiu+SbNclNpTWZXYsvao7fMffjn+bBoHdCzqhsZX7ajARTfJJ+YSe0wyWIS9GrHvW33hwCO+Et6vxRMe3h1YZisZ4zPZv6ny7sLtU9lpBlMjBd8QOeDdzBgClU7L+JNFn8+kZn7RICzKtV/RHgnnSY0/LpIVaK5Hx6+9YZ4N25hjmDcXVsaBbpc4jZ07ijIQox77c8cJfViFlBOutwcteVpqqWOQN+W5XbmsIEJrjr2ujxzw94EFuRJGoqsYeO5hOKML9PIMp/XBAiFbL3JmOcVfTemkV0fHA3lKAPb8fFtB9BjLeAVP/uHpi5biXB5bzK5MXyi55w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:43.7702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1612c4-70f3-430c-d6a3-08df078db037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
index c0478087b95d4..d08f45d07fae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1240,3 +1240,143 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
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
index c32b4fd3c3220..a75aac48604cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -139,6 +139,8 @@ struct amdgpu_ualink_connection {
 	enum amdgpu_ualink_conn_state state;
 };
 
+struct amdgpu_ualink_remote;
+
 struct amdgpu_ualink_mgr {
 	u64 npa_size;
 	u32 psp_if_ver;
@@ -147,6 +149,12 @@ struct amdgpu_ualink_mgr {
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
 
@@ -179,6 +187,10 @@ struct amdgpu_ualink_mgr {
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

