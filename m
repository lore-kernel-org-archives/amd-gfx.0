Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39973C369D5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 03:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C715010E1FB;
	Tue, 29 Apr 2025 03:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3/g0VTr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8C110E1FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 03:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX0+Hp2EpUfOi7orkL+vxfcixJpqcQ3TxVVNBj/hLze8Bm7Yq/rXVOuNLHaPyk84kXzL+TbrOjeSMqTxURCH6Fc4ri+GyWQnah/4v+jWtMzmoJPW1hY9/mlYd8shtX6/MDP/PbRmq4HVoOmjRxADxFXhzTOzCfwWwKnKBBNnweBdLdP6AEFHXIhkQ0pW+4o2WZs4KdgULG2cvAKhdKZq5Leyy2Is95IoAuJUtZvlI5mg671JG8Lzjb3yX/BXTREI3tYxdi5HDOJG7akp8BhmIDktjDZaxiD9kiVWKZrI+htdwLwvsulE7fg+iIshpz29dd+6AKq8g7BQ0soIEjCoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ui/Qzce+dAOSSnXHsvS6wGnNTrJWNDm8lIeRnJIIwI=;
 b=AYzNFeRkxzbSUXfBdkCtsN9Wws2BvVlWhWOxgysVK3+PxU8DZRZGm8M5l2xCHzUaMDB4rkRs2g5rgzkB7vQiqo3YB0wMK4QEe0FMxkwpOHlEBkT8iSMvkLYdtcjP54UpB2RB6Pv1pG8FfXQGk0hyUd4LdcdcjlBN3aVXiJpoM2htGFPcMbnl4cRNNGuzGcAmDo1hlHw6MAnarFEQDIcfbuxZ5przMdQTGsBkOVmypwMBM3TXR6VFyO2J8kWmVFHEbV2Vbz9s/H9O3mK8N5ziHXz+0ulAP2R5kXVL0qo22/q2tbqY9zk1JpdA/oCeXXUT4dqQS3MmLm6mfCfCFmkhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ui/Qzce+dAOSSnXHsvS6wGnNTrJWNDm8lIeRnJIIwI=;
 b=B3/g0VTrIWW9uQKFtICX+W468BKymoZ4aNEo2VlfviPD2hHuQ7OWD6HOA16GW743xzcfo0MAG5lXHsuw/w/N5wzqyeokTOQsCXfg6Up58qLJX5PMHkQtGl57OzrRJ8amb0vwpPRNbYNnzem9z5uzp8RagTEFKaElagBQC2et708=
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 29 Apr
 2025 03:15:32 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e4) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.17 via Frontend Transport; Tue,
 29 Apr 2025 03:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 03:15:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 22:15:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Date: Tue, 29 Apr 2025 08:45:12 +0530
Message-ID: <20250429031512.974183-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f27e592-9101-46ec-a81f-08dd86cc194c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y33xhgjcoyUDIc8SQ+jG5aXrIhxUASC9IeZYLBIc0uxUfmfRULKydip6DiOQ?=
 =?us-ascii?Q?tBOiQkBAIQPWKeEsnB3w61TTBizRK1/G4szRHEE1Qu3jgEFHy0RY/SN6vMaU?=
 =?us-ascii?Q?/Wlgq/OaY8auj/pRePcxLBoPWt2rvFbiKG9zxZ04tRGQfLIZjLLMMYEPUjLw?=
 =?us-ascii?Q?IkwEiXZo+wiE1RgL2uIkb61/nIg6Ht5c9nSk4JkW2voCXb3fJ68Vj7x8TgGh?=
 =?us-ascii?Q?QbnEupeMZx+Pak4RA2Zx2yO2vwbL/y77F5wIgNSTRZlAiY3gDvIuLPuaYem9?=
 =?us-ascii?Q?PhREzSNPakb29DtKpUPkOd/z45nys5XYDcASdl8Adkaqc+AnYnLSB9I4gA7d?=
 =?us-ascii?Q?pb1r8kDw8xSsMUGohb9/+g5D1Jas3weOXrM55pNyP54cNrn1wjDB+KF50pqj?=
 =?us-ascii?Q?bi3TYYNH+a4GN90gU8yq6KFY6u6LosSmumSCh0j8nwSJmd9BWJZh2sLt77Ot?=
 =?us-ascii?Q?jRLQL2TudfD5l8H1pZD5snICYONNAbPrn8xS6MnZbMuacKjanP7cva8aa2mw?=
 =?us-ascii?Q?vsPZBLcF4Dm4/OThyiyEDG83Iq7vU5nya7VS5lnKARpXWOnHtjEXx0rioJwQ?=
 =?us-ascii?Q?S3iRlpcuo9oW72AF4F3OGju8nvRf4zjci7Aa3UC7n7nF6CLBwwwkNvM3ZZxZ?=
 =?us-ascii?Q?tfgjug4keIjEQrKBBDaHx7l0MQTDJsgYohLRs2KxnvFxuNgGHihC3hvh0O5T?=
 =?us-ascii?Q?hR9lcm6cx1i/FVVHJxO79urGzP37NOiSdtTDB5Tib3m0f0/a3JekSaGBjipM?=
 =?us-ascii?Q?Co1eXM0SZXfhQXgUSJG6+zghsNRwQREUEw8ko+oeqpMoM/NyTTGE/kpywepM?=
 =?us-ascii?Q?hbRFKUtHX6mIgYl+ifZ//4etveT83xD+jv2rZquOJUgNmofSjtkBmlVK/mqY?=
 =?us-ascii?Q?ZB5CoyA3dRDdjnzQTpBR8VfG6rfIETHJ3LgMU91a4Gt/ZYELsOx4QdzRWzFY?=
 =?us-ascii?Q?/oR4DXPmmm8Vq95or27UxoO8DsEOUjm1Y7rYwctU8Wm8pZU+HSZY+w/VPgnu?=
 =?us-ascii?Q?mEXfTBslA4OLRVIpNmGXAkbMOGQxr1FPFh7y2dD6SaKtt5MklVQ996aRAX9a?=
 =?us-ascii?Q?u/rrZq70lirTIpL+lmVxSXE+OUm/z/Gel0IZ4nGX20Kc4iJVGBiC/XsX1WJF?=
 =?us-ascii?Q?dHF3y7hy4FNUlaq3j/67jDjV7URFdIJkWtRRLME1sSSyr13PD6GoeXroJqN7?=
 =?us-ascii?Q?arQQDTQkKIxn1gnszdY6EYlfgk6JuC4+7OQIuJbB3GmiPCR2p26wmoSFMGt5?=
 =?us-ascii?Q?7ZvX5AYQQXXATjSXrI/Tuwfcbx64WkBGyDLt4Oftl1av86cnxOjogXJpaVeN?=
 =?us-ascii?Q?4NysODnTibWps1lB6KxBRvgtaO6AVC/ewPxr+GXi4pztut8WLyRuPRRqiA9q?=
 =?us-ascii?Q?XhaJbeE6nVHtP5oLm5ROkfNwIVhSsx0x0kRDbPl14z714o3fbG1uQc6LH3sJ?=
 =?us-ascii?Q?3Z+10ksgsPwKAijqmh+roThN5BKFOZb8ds9f1+ZHaD2hbAcwmDJ7JrTqiQen?=
 =?us-ascii?Q?CQN1Aezry/D3aWHApaqKNiN5IOcUBzMkYu90?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 03:15:31.1055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f27e592-9101-46ec-a81f-08dd86cc194c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
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

Helps to keep a build time check about usage of right datatype and
avoids maintainence as new versions get added.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 67 --------------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 13 ++++-
 2 files changed, 11 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 80eb1a03b3ca..7eaf58fd7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1051,73 +1051,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *smu)
 				    false);
 }
 
-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
-{
-	struct metrics_table_header *header = (struct metrics_table_header *)table;
-	uint16_t structure_size;
-
-#define METRICS_VERSION(a, b)	((a << 16) | b)
-
-	switch (METRICS_VERSION(frev, crev)) {
-	case METRICS_VERSION(1, 0):
-		structure_size = sizeof(struct gpu_metrics_v1_0);
-		break;
-	case METRICS_VERSION(1, 1):
-		structure_size = sizeof(struct gpu_metrics_v1_1);
-		break;
-	case METRICS_VERSION(1, 2):
-		structure_size = sizeof(struct gpu_metrics_v1_2);
-		break;
-	case METRICS_VERSION(1, 3):
-		structure_size = sizeof(struct gpu_metrics_v1_3);
-		break;
-	case METRICS_VERSION(1, 4):
-		structure_size = sizeof(struct gpu_metrics_v1_4);
-		break;
-	case METRICS_VERSION(1, 5):
-		structure_size = sizeof(struct gpu_metrics_v1_5);
-		break;
-	case METRICS_VERSION(1, 6):
-		structure_size = sizeof(struct gpu_metrics_v1_6);
-		break;
-	case METRICS_VERSION(1, 7):
-		structure_size = sizeof(struct gpu_metrics_v1_7);
-		break;
-	case METRICS_VERSION(1, 8):
-		structure_size = sizeof(struct gpu_metrics_v1_8);
-		break;
-	case METRICS_VERSION(2, 0):
-		structure_size = sizeof(struct gpu_metrics_v2_0);
-		break;
-	case METRICS_VERSION(2, 1):
-		structure_size = sizeof(struct gpu_metrics_v2_1);
-		break;
-	case METRICS_VERSION(2, 2):
-		structure_size = sizeof(struct gpu_metrics_v2_2);
-		break;
-	case METRICS_VERSION(2, 3):
-		structure_size = sizeof(struct gpu_metrics_v2_3);
-		break;
-	case METRICS_VERSION(2, 4):
-		structure_size = sizeof(struct gpu_metrics_v2_4);
-		break;
-	case METRICS_VERSION(3, 0):
-		structure_size = sizeof(struct gpu_metrics_v3_0);
-		break;
-	default:
-		return;
-	}
-
-#undef METRICS_VERSION
-
-	memset(header, 0xFF, structure_size);
-
-	header->format_revision = frev;
-	header->content_revision = crev;
-	header->structure_size = structure_size;
-
-}
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index a020277dec3e..cd75fdfd6b4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,17 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
 
+#define smu_cmn_init_soft_gpu_metrics(ptr, a, b)                          \
+	do {                                                              \
+		typecheck(struct gpu_metrics_v##a##_##b, typeof(*(ptr))); \
+		struct metrics_table_header *header =                     \
+			(struct metrics_table_header *)table;             \
+		memset(header, 0xFF, sizeof(*(ptr)));                     \
+		header->format_revision = a;                              \
+		header->content_revision = b;                             \
+		header->structure_size = sizeof(*(ptr));                  \
+	} while (0)
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
@@ -125,8 +136,6 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 
 int smu_cmn_get_combo_pptable(struct smu_context *smu);
 
-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-- 
2.25.1

