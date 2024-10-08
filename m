Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15FFCF0427
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A1C10E5D2;
	Tue,  8 Oct 2024 21:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vCUtDw75";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256BF10E5EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD4hVCwR3SgZtNOl+yFixUqJL/wwXQ2jp2Z79m9vpSckzAQM+GYzoH47bTOSt8FfC2xrQNsaDyWT0LUmTnTrVmNZSLXlLShZ6zkeXbgWNRLgUBO/x3+sdDtFk79Q421bzyJ8X9hSEVRgkdcEy8khPWKQJ54TAJF/T2KziiitCyiZQy97aATJzMMvSNRVXZZLdk73rN6dGkOFLmglVjqh/6230HosOqtDOXkIioGGQT0EbTWrTVwRFmjYnsf42f/cRwIeMBSWqPFF6OPBBlG+woQUXT2mM+YYT71MvF4qNliGoW3XPZzQ2Swo9SGD1u6mjgvbplJ3MRmxb619hQtV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KCB8gXGK0POItLjW6YAirN1KLwLE/QfGGJT+ffoq1M=;
 b=l+huBLuxFbnxjoy70I+ejw77us/E04j6XWq5ktiYOH2hzr0WckVXJaahH52vCI+h5fU6IRBmX5XmP7TWOlpiYJdt4opk5mcSjB4eYV7XRy+LTEvvyTVcFLyyYg9KyuD7U/N+P5YYqx9atFExbkyJTn0WlBB4EFHrWLhHHP7LF558Mqr65Kikd1WS42PMERjBd2WP49ViD0FsUoLqBcdQ8yMoLAEbMvYuvAgg90x5Iy3+j/xS/50UAtCWD3xGD16X14+a3TyhzJ/vhcqFMAhY5YHJ5a/aqgZ4sFZv4fRdL0s/8dRiYOGYJnp8fHZGjhN1GIivA6Cu0Sdc54etpBXQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KCB8gXGK0POItLjW6YAirN1KLwLE/QfGGJT+ffoq1M=;
 b=vCUtDw75JEgKrcjsF4lx4npaBo0WugUPq/HqCYlf0ltKZe7YUy8VfZFPriafIYbT/qKIlsoRfVZoF4LN9vHhm3pF3Bpxe55+jBmwZtcj+L1zI2OHgoBE4OA2BDU8WvJ+GOSA0szwjlegYvASZ833TYjMNrocEaPWPEAg7ocr2Qk=
Received: from CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25) by
 MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 21:16:34 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::58) by CH2PR05CA0012.outlook.office365.com
 (2603:10b6:610::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:33 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:29 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 27/32] drm/amdgpu: set funcs for each vcn instance
Date: Tue, 8 Oct 2024 17:15:48 -0400
Message-ID: <20241008211553.36264-28-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: fa15f2c3-24e9-4f8e-d18c-08dce7de7cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sBihj0Jwp/EA2LbWgs3vKsiCl0IgYPpewIcgklbAZD7hYmY+AI0G2zCE8k2Q?=
 =?us-ascii?Q?wVVSXR02X8H3+BeAE0SyiC4Lh8ov2CO2FVC1v8cjIwD5xwXm5VGvfXGbPf+w?=
 =?us-ascii?Q?pDFCvMjyeN+Tmn44hJNTXgwUjoMAaykpKypTjDtzBtTAf8CrMmwkiaWKsPYy?=
 =?us-ascii?Q?iGcTozzhP7CJtYo/90ea2btjcuRs+qBIHVFrl+WwaKNKHKXVAQ1lWkYKeqqR?=
 =?us-ascii?Q?JnOapNztuU9iI+Dzwy+fB8MskRSgB2tacbNMEFGQFBidZdrXRL3R6knQC6pp?=
 =?us-ascii?Q?KKU20e+FbTzFkHGAeYZjhRKOGOg/DZJTzF3eM1/T5cXMRboM+/Fzk9DFpS8G?=
 =?us-ascii?Q?bgMNyix2wDOQD1IsgdGJd983lllzMFwQS1a5+BD/DkNmPLBcVog25CQwnsEd?=
 =?us-ascii?Q?w10mqyc+ZtxQERb7bsuHLddH9wzdaAujtPrzctiDLcst/4bjJMpZEKHKQqRu?=
 =?us-ascii?Q?A23mufb8c6Ijzr6PMtM6bStvKRFn8F4OCvOKREv386a7JI3/Jq8btVW1RWjF?=
 =?us-ascii?Q?dCZq0X3/oO04QixMYlKQjjbbkud4BCDm0DzYHde0M1oX/mThsMrxcW/VUAmg?=
 =?us-ascii?Q?T4IRqRg9mgokoiZrrxZIFCqly+ceoCTFqdd+Cv2c1UOpO5UvfkIT+u/IVFIO?=
 =?us-ascii?Q?/Z1ouK44WEjtIlmKQN0MTjxWqo7AzsnrjZ+NVrGgk1hlibtVjGCT7fJZuKR9?=
 =?us-ascii?Q?Jm2yqdQsgYuA3htT9R6WYjYhYm8r3O1fSKbSWSPKiQLK5BKQMbPfwhgT/knY?=
 =?us-ascii?Q?zvYvzBQdZzrZSqjHKeCsmlyo4HGc1BzhIhah8ghq7Bju/anPk+tPqnM0feHD?=
 =?us-ascii?Q?iehZvhZkTO6WrUa+a/4o0J2LLxKbLXOA4e/KFNOX4Jz4aiX7DL1+CUQZpHJ+?=
 =?us-ascii?Q?DSlyGlcwr0ddmqOR4oo2wOBw5sCAoX3Pd/kZahW0kb+wta5/P0n6zI8467Y/?=
 =?us-ascii?Q?BVZXBnTLuKCSVyzB8MRSp8z2OAtcfH6I4xjPoTMb00UsSkTjb8RboLNnOqQJ?=
 =?us-ascii?Q?OA27yxJGIbiVG85yq9e7pY+Q2g9z+4wZIr5xoXUV+8vpYBlTnl1umDTkLUL5?=
 =?us-ascii?Q?sQx38jZYMqycqcd5Bpt/plMKwNGWSYYXuxWCFMJ7c+Fp23s/QzmmGobiDYPq?=
 =?us-ascii?Q?yDKJPOMI5oLbfJiP/7n1l6TSSv6HiBCgD5gRQZM2osOULdP9llOKmXalrlql?=
 =?us-ascii?Q?/jOfurql14sy/d/JIYHjcFW7DQkB/XYNpMH+beBJTTvVie7E/w6EY3lmbiiJ?=
 =?us-ascii?Q?dIEEwbRMYZdlTOickWiO5EjOWRaX+dfJYKIAlDyTbxGv1M0EX9sPkqZFH1sI?=
 =?us-ascii?Q?TFUtQcSwarqSXown3n+kg0vRV555gkKnyNqXdJyQUeeVBgOHvGtQCSKNNHkZ?=
 =?us-ascii?Q?Z7OyVT0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:33.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa15f2c3-24e9-4f8e-d18c-08dce7de7cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to set_dec_ring_funcs(), set_enc_ring_funcs(),
and set_irq_funcs(), and perform function setup ONLY for the given vcn
instance, instead of for all vcn instances. Modify each vcn generation
accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 59 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 62 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 46 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 31 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 36 ++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 36 ++++++--------
 6 files changed, 112 insertions(+), 158 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d90aa2a9f94e..b0d14330722b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -92,9 +92,9 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
 };
 
-static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
@@ -139,9 +139,9 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.num_enc_rings = 2;
 	}
 
-	vcn_v2_5_set_dec_ring_funcs(adev);
-	vcn_v2_5_set_enc_ring_funcs(adev);
-	vcn_v2_5_set_irq_funcs(adev);
+	vcn_v2_5_set_dec_ring_funcs(adev, inst);
+	vcn_v2_5_set_enc_ring_funcs(adev, inst);
+	vcn_v2_5_set_irq_funcs(adev, inst);
 	vcn_v2_5_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1737,29 +1737,25 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-	}
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_dec.me = inst;
 }
 
-static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
+	int i;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
-			adev->vcn.inst[j].ring_enc[i].me = j;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		adev->vcn.inst[inst].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_enc[i].me = inst;
 	}
 }
 
@@ -1904,19 +1900,16 @@ static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
 	.process = amdgpu_vcn_process_poison_irq,
 };
 
-static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v2_5_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
-	}
+	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 }
 
 static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3547798ec335..9a9acec4c4ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -102,9 +102,9 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
-static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -144,9 +144,9 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.num_enc_rings = 2;
 	}
 
-	vcn_v3_0_set_dec_ring_funcs(adev);
-	vcn_v3_0_set_enc_ring_funcs(adev);
-	vcn_v3_0_set_irq_funcs(adev);
+	vcn_v3_0_set_dec_ring_funcs(adev, inst);
+	vcn_v3_0_set_enc_ring_funcs(adev, inst);
+	vcn_v3_0_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -2062,34 +2062,28 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		if (!DEC_SW_RING_ENABLED)
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
-		else
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-	}
+	if (!DEC_SW_RING_ENABLED)
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+	else
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_dec.me = inst;
 }
 
-static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
-			adev->vcn.inst[i].ring_enc[j].me = i;
-		}
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		adev->vcn.inst[inst].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_enc[j].me = inst;
 	}
 }
 
@@ -2231,17 +2225,13 @@ static const struct amdgpu_irq_src_funcs vcn_v3_0_irq_funcs = {
 	.process = vcn_v3_0_process_interrupt,
 };
 
-static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v3_0_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v3_0_irq_funcs;
 }
 
 static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9d4a0a0b9..ff256fb4d054 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -94,8 +94,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
-static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
         enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -127,8 +127,8 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_set_unified_ring_funcs(adev);
-	vcn_v4_0_set_irq_funcs(adev);
+	vcn_v4_0_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_set_irq_funcs(adev, inst);
 	vcn_v4_0_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1923,21 +1923,17 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
-			vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
+		vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
 
-		adev->vcn.inst[i].ring_enc[0].funcs =
-		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs =
+		   (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -2135,20 +2131,16 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
-	}
+	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
 }
 
 static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f78c006aec27..544c96e082b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -85,8 +85,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 		(offset & 0x1FFFF)
 
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
-static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
@@ -110,8 +110,8 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_3_set_unified_ring_funcs(adev);
-	vcn_v4_0_3_set_irq_funcs(adev);
+	vcn_v4_0_3_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_3_set_irq_funcs(adev, inst);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1525,17 +1525,15 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, vcn_inst;
+	int vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-		vcn_inst = GET_INST(VCN, i);
-		adev->vcn.inst[i].aid_id =
-			vcn_inst / adev->vcn.num_inst_per_aid;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
+	vcn_inst = GET_INST(VCN, inst);
+	adev->vcn.inst[inst].aid_id =
+		vcn_inst / adev->vcn.num_inst_per_aid;
 }
 
 /**
@@ -1718,13 +1716,10 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+	adev->vcn.inst->irq.num_types++;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		adev->vcn.inst->irq.num_types++;
-	}
 	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 31f05f377ffe..880353f75296 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -93,8 +93,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
@@ -116,8 +116,8 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
-	vcn_v4_0_5_set_unified_ring_funcs(adev);
-	vcn_v4_0_5_set_irq_funcs(adev);
+	vcn_v4_0_5_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_5_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -1424,17 +1424,13 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -1599,17 +1595,13 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_5_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_5_irq_funcs;
 }
 
 static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c0746684eea4..a4d1b9a086b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -76,8 +76,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -100,8 +100,8 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v5_0_0_set_unified_ring_funcs(adev);
-	vcn_v5_0_0_set_irq_funcs(adev);
+	vcn_v5_0_0_set_unified_ring_funcs(adev, inst);
+	vcn_v5_0_0_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -1151,17 +1151,13 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -1326,17 +1322,13 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v5_0_0_irq_funcs;
 }
 
 static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.34.1

