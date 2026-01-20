Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85865D2ED11
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A0210E55B;
	Tue, 20 Jan 2026 06:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kvOFqV2d";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B80010E557
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuTFAsZAYEDdFB1NpvppOKbhCLgoZOwRoyQgUR0Z4l+v0+rvhyiO/A48GTDifihcb9U0ZIJwIICeHPjZ1F/DEK2agPMH+4QUfwXSsSgJRI2qrt5byTsZykKU43a5aHahv5nN5dpOaBI/rfy7zKJj/IL7sJMabvJeYWaQP/1H4sLbK7zo74BafATsFPz1wOniAwoBwNCrm14elEJQzJGrhz2OhuHbqFXkyxcp8uN2+RYbeva2NkOkuFq13Va2t7qRsK1iXx4uMw5SXnrf3PcS15qaxHcwVYHdCBMTMGp8rlmqocKG/5l7tgkdqOFBy2doT0EX66LrQ599fbWgMdy2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KTwaBYi3Qh9u/qNkMcNx5in16Kg9uVqdEzzP44jQ/s=;
 b=ocrcSw6otm23CqYH5k05HGTF/7/VT4gvaCgy5o33OzLrJZLTeS/6WKVTwyi25q+x8J32x5SBI68Qssatr0Z6X9c1OFNE5ZFv1a3WIwlNwYRdmrKZ3+OYyyuQuPpcQVolnqqxDJ/bxPBPYwLhdGyfIa5Q9GmeLSYCadUti/VBiwbUFR1c3WKsLyh/NKU4G9OLHWXFYaLUJrAIa8635wAjzBHhGcsIZFmxKz+SU0ZHwQhwOjgVv3UUBUvPG9tYNLvt+vlZuqO6DZGXeD5Cg1iVQV30xij3AQhb5TgvEYYECDqLEyQ6PKImyQnEtj1bIocq0ftL6a5DNSblCbeUjybLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KTwaBYi3Qh9u/qNkMcNx5in16Kg9uVqdEzzP44jQ/s=;
 b=kvOFqV2dAcHu1Y3rYNFss857i4ckWpUeqDLQNfjlHwqWqQkzx2Df//ZhGodDC8cxN2o1iwl7lPcvJ6YzkvcHY/ILXhtEII1M6PjzHCbRjQjkNrbbpDdRYdSoBxQTkEIli3bncV5sT2lqCYDLtPsly6Gv5IONzbn50eKlD+CN1Nc=
Received: from PH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:5::33)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:14:39 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::34) by PH0PR07CA0028.outlook.office365.com
 (2603:10b6:510:5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:36 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 7/7] drm/amd/pm: Add default feature number definition
Date: Tue, 20 Jan 2026 11:42:24 +0530
Message-ID: <20260120061402.1287680-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4ad8e8-9f1b-4a0b-8aa5-08de57eb3151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6NE7LgMt4ABRE+3l8Lhitjaw1QwarVF8TNr4mY+5XxA+YSZKztziY8uOGbD?=
 =?us-ascii?Q?wZUniqha9GY7q71qZrsaD6gli+uufg7MYwlbYt8IEaUlBgrX4vfwn5IYRUjR?=
 =?us-ascii?Q?ZcLY1YRYSVi/7YS2bSq1KFWBLzKjbM59Yeh7ofHLUx2sZ5QHLydsKy1LFX1L?=
 =?us-ascii?Q?KseYuW9LwXDulMwc603LzV3WkUxBm+UYf5p8icbkQxSZrm4ZA0TEA/u8g1BP?=
 =?us-ascii?Q?tdBqAMQ3XFuDNb/Gxd8HC3A4ALMJkWL/JIttInrK1qJMQ/O4eChJgdMQYKwA?=
 =?us-ascii?Q?xomfeAuczBbtjPepjk0qC6hWP4P+fW/J97L9Ora2kJqqbSts1vNaKuBgt6C5?=
 =?us-ascii?Q?I+Zr77kJ8GxroMUzSnGmS9dn7ARRB0BprJFCxxhcUIdqvRT/Wgd9tC5f3Aw7?=
 =?us-ascii?Q?0KkD7YvUbqZsbsZN15dK0mth9zjO9crTbIHc4MnuuvZlhigga7bup00SqzI0?=
 =?us-ascii?Q?+Z5bUENMJr1sij0f4xDY6FRLwZsESJ1ripIjfpGI48NnPMzppxixZxCFl01v?=
 =?us-ascii?Q?G6CRXMfP8MQ17IBJyoBvEctYOlWUnx12ehTm8JXlvXod1lkp4yyMmJdhIEr3?=
 =?us-ascii?Q?NOZUDU0UCea4VwfGUW6nFAnieRaszr/285eX335t9PT6l7HeJ1gez0i0tuAf?=
 =?us-ascii?Q?lvGqRZrREazJBTwczBb34rMVisM92SXejXwiyxvP9B2KUJaSPj8Sq2mU8SSh?=
 =?us-ascii?Q?iMRE330GMA1mJ2oCYBFbS2jR/gZXWC/DxkQ11hQi6XJJr+OF6ByfPKliEiaG?=
 =?us-ascii?Q?MQ1QTCZjwRYXuFpT0u0FkD5m/W42eXboAgZDaSbaXV9u784Td/Hn8SeoM1fh?=
 =?us-ascii?Q?PFbw4gHin0TAqLphKA08yCc7bJs6Vk/AiT+JQM4g8dl1gCoOolocwchtbQgX?=
 =?us-ascii?Q?coZczk3AYEQDYz+c9AhkAzhbfViyI98Inv7/99tfI2wQzc91vNMFTdGpZX0W?=
 =?us-ascii?Q?/MX7x+IHx2irr9V8B+ydOkcM44I80oG0Ej248j2R15fkcxJcwkxNZJpzs1iE?=
 =?us-ascii?Q?AhLGUSnF6T0EOVXElIVHNTWv8XdN7FfLsuOQJFhxMsH2WdXlC80ZgTHKV5CF?=
 =?us-ascii?Q?Ha7p4W6Ia1maUm0WuLOzGv2AtUS+4HovZLhgMXsDbKSuJBBeKDekbwNOeV+u?=
 =?us-ascii?Q?qA2/zmD8/LObD8kKrXABwZ5xZQoHWsMpbM6OR6gUa2Hn6jm3jpJc73v4Q6VX?=
 =?us-ascii?Q?xNgBaw/AP7G0CuefggWkekFvt/zlhzWii9v45gHh2ZRGZnXOpAf730CClu+D?=
 =?us-ascii?Q?1P6kHzY2hz7LiimyYun49T0r5ZsrE21GUct5N6mcEMw2I02L5M1L/YrLyBBF?=
 =?us-ascii?Q?v5olacxNlRUDslttfDJHcKlSCR8Kz1M9d9m8RPE7j68tJ6OLT2rQYGYWV/Vi?=
 =?us-ascii?Q?kUvGnRh09QNpCZmgAZpmxWNdMKwmcGaOQsroZFe454kWT5hNv2GZuUgxfVKb?=
 =?us-ascii?Q?NHtjCpv6ugKI/+yGIx6W5CGqVWMDMlnqoqvvMhMEaxlZMMGeTopN8fNPUUcB?=
 =?us-ascii?Q?+8/hIP9b+m1WM9eEpb+wOOcfNNwuLbB1kpwSGUPqIyTeh6hDUm1icBH1vDZU?=
 =?us-ascii?Q?0v5sW0zTfcs6IYwF62AEN7S24JQCnml5oDTrImmncmNEMudLxLYMxJg/9rsf?=
 =?us-ascii?Q?Ez6IjK0L2YWKcmZIOocxOnCR1Vth1fKFxCnxlvNK2lBlpi9aHiapaK/VQdmZ?=
 =?us-ascii?Q?U46WEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:38.9135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ad8e8-9f1b-4a0b-8aa5-08de57eb3151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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

The number of default features could be different from the actual width
of the bitmap. Use a different definition for it. Also increase the max
width of bitmap to 128.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 6 ++++--
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 62d34f69149c..5ea4c6dab2de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1352,7 +1352,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, ret;
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
-	smu_feature_init(smu, SMU_FEATURE_MAX);
+	smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4019ef859504..512493a8452b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -471,7 +471,8 @@ struct smu_power_context {
 	struct smu_power_gate power_gate;
 };
 
-#define SMU_FEATURE_MAX	(64)
+#define SMU_FEATURE_NUM_DEFAULT (64)
+#define SMU_FEATURE_MAX (128)
 
 struct smu_feature_bits {
 	DECLARE_BITMAP(bits, SMU_FEATURE_MAX);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 1d0f9f8ddf9b..56efcfa327df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -751,7 +751,7 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	uint32_t feature_mask[2];
 
 	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
-	    feature->feature_num < 64) {
+	    feature->feature_num < SMU_FEATURE_NUM_DEFAULT) {
 		ret = -EINVAL;
 		goto failed;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index d9b1725c3afc..c4a994445b80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -762,7 +762,7 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 	uint32_t feature_mask[2];
 
 	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
-	    feature->feature_num < 64)
+	    feature->feature_num < SMU_FEATURE_NUM_DEFAULT)
 		return -EINVAL;
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5c991e2e15ff..79ce32c4bb4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -747,7 +747,7 @@ int smu_v14_0_set_allowed_mask(struct smu_context *smu)
 	uint32_t feature_mask[2];
 
 	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
-	    feature->feature_num < 64)
+	    feature->feature_num < SMU_FEATURE_NUM_DEFAULT)
 		return -EINVAL;
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index d77eaac556d9..a2854d528bab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -716,7 +716,7 @@ int smu_v15_0_set_allowed_mask(struct smu_context *smu)
 	uint32_t feature_mask[2];
 
 	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
-	    feature->feature_num < 64)
+	    feature->feature_num < SMU_FEATURE_NUM_DEFAULT)
 		return -EINVAL;
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a9e0b52bc739..6fd50c2fd20e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -794,7 +794,8 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	}
 
 	if (!ret)
-		smu_feature_bits_from_arr32(feature_mask, features, 64);
+		smu_feature_bits_from_arr32(feature_mask, features,
+					    SMU_FEATURE_NUM_DEFAULT);
 
 	return ret;
 }
@@ -909,7 +910,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size += sysfs_emit_at(buf, size, "%-2s. %-20s  %-3s : %-s\n",
 			"No", "Feature", "Bit", "State");
 
-	for (feature_index = 0; feature_index < SMU_FEATURE_MAX; feature_index++) {
+	for (feature_index = 0; feature_index < smu->smu_feature.feature_num;
+	     feature_index++) {
 		if (sort_feature[feature_index] < 0)
 			continue;
 
-- 
2.49.0

