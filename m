Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467AD29C36
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0509310E49E;
	Mon, 19 Jan 2026 15:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZERJg3LH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B7B10E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm/2g9FVm/gHXKWTxxnblTPO9DWUSFgM0yO21hoi/+v859rrAWlFrIcv9eBNzvIHaCnDHYRPA3NvYzuhfwFspbrLrdEp0Lef4zNf8WLHIzJbcvARru/t8ltQHUHqh1D0htNNlgAGuZ2yKhva5vkVRy0Q3RtBQTS1bbruWbygpxQCPiAEpp1cjWK3SDE2FWZ0Rzi8EOkUE+/yPaJ/nUcpFVG0CySHPFijNedd2Vfdc1qXgC+LtIYGCM0OyElYU0vR+jNW8BX2sRwfVeY5cI8OHZ+Ox+pP6bwRxm/y5tzU/e0JHI1FbJWO4LmFvjSkG66LkEDSPKo6wSfFi66KpiDdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyZENtdPFbb1f2r1+MQMu0RX3SpyzEWd2OlcCegU0+E=;
 b=rrFxJcx1wSyvAr5ZdS4opfTa7AHRS0RVXcyBlWNP4rt5FlI4gly5NeOuZkR9aSHY4ybFRHbaIlpTvCVw4k4A32H2ki+o0wzrwHN+kD8XLYWzg3945Clq8Xk08nDCBe1b43PEDc1cCIy+nnC20wkH7nPDQGw38SMUC/XnOvFr30u/mlE0wafjsSlEFS9306miN28P+Aov6UMYRY4pfowOcWttehunaBGOvn8WQ3jUe8uSxi5DBbnkLUA3xOH1WyAJiChBm3XXZKyK9Ox3rWvguDT2S2Ti1WByc31n+r2ZfZbiLisCPJj5UdBzHI7mIuPYWNZyrfCyWNdfhOA7+a3Dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyZENtdPFbb1f2r1+MQMu0RX3SpyzEWd2OlcCegU0+E=;
 b=ZERJg3LHSxz3qdOE0LlDkP8TFM6+FbLiZ7A3NRg2bkF+3wIki/HyfeaXNeooVw9PDTGCtklJA9cHK8gu8tyy/Hz7+akwPfDk44Sv2TevgBEhT/CTr+K2uuV7/CaoHNTzj0ibj4ib9IKn3P3/pJA8Hf4dXUM961hpyeBYr3xrBsY=
Received: from MN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:52f::15)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 15:33:49 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::ad) by MN0PR03CA0008.outlook.office365.com
 (2603:10b6:208:52f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 15:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 7/7] drm/amd/pm: Add default feature number definition
Date: Mon, 19 Jan 2026 20:58:24 +0530
Message-ID: <20260119153309.1234663-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119153309.1234663-1-lijo.lazar@amd.com>
References: <20260119153309.1234663-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a45447-6d5b-4998-b6eb-08de57702461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GvG9RytnFhsfI6Nfpcjfeg523b6yOtsCe92xJmNFykRBaZ880uHUoKR9aUgN?=
 =?us-ascii?Q?RA6+a3AUIRaA02KdqJ79pQFZwD/y5cdUIuNBkd0An26tYT8nCWkIum9wncfd?=
 =?us-ascii?Q?ScEPhnjXaR7zifuS4tMC2vIn9gzSp9oKpO3Yj5ou+RGrvPo9TBXeppS39jWk?=
 =?us-ascii?Q?uiU6dQROMBYSb2KCAWARxonXAa1mnDl96T31lefT8EvipaT08Ka6Y+AswOap?=
 =?us-ascii?Q?KneMCsVmgOD08vMin+SU2lGKJobbxO48KtPdd82UBhDtFvytJTLSw6PSlw50?=
 =?us-ascii?Q?EREYI4EBz+YVLtcU0y8T5N4VBf9VkkZyQBTo/TyuMI6+kn2m1muEWRhKkzkL?=
 =?us-ascii?Q?kNqHUwDCBYjLdH6V0gMIaUIFnXMWKEKKIjm7jtFvPPzxyzqjiruBcxgp3G9W?=
 =?us-ascii?Q?FJ7DM6kja7n4xKhsR+hiMGoTWGEkR9+ngSEJtX5s5XGe4J7C4lLuDSvqZXeR?=
 =?us-ascii?Q?p4O3KrpFdHy59uUlL28NkglY0h3mNb9q6eWF6tF79XHt//Joku3KtxFrJeCL?=
 =?us-ascii?Q?b2feI8HYr2DCxuw12jpBuQaAWp8/eoJndoUmZWdiqF6s3zOJM91TqQdpMfJE?=
 =?us-ascii?Q?3coNIISLK/+wO0v1MNLuL6Dq/Vegs2A14RRgftMebFrRoxV1AzBPsx5hTEvv?=
 =?us-ascii?Q?/ExDiHLyxRB3qbw8P1T3iVLNMypWW0gvFsmvmH4dXobXhFxGDtLCNYzRFZ8b?=
 =?us-ascii?Q?dEX+urFdf4yN4FQa8bir+5/M3t08dWDp+KanBva+Gkm24cmbxkVjN1qS4ORs?=
 =?us-ascii?Q?iowJ/GF7pnEeAHWuhHQ95VSodaCi1nDHju/YDDNXT6sl7pDqGJecfvmO7RML?=
 =?us-ascii?Q?WUODn1RuVwlfHs1By+aziKRKbZL4hTLt/ZEJFkgF/QAl1OvBGjW+hNNy3bdW?=
 =?us-ascii?Q?JDZI7y5AEWXp4XsBy5V5WpkRYQmBLmiObNCA4JOs6rWYpRD2dwLfd2PBWnAf?=
 =?us-ascii?Q?YHM4UDIjlezbjVd0sUQEX+9fYAyeMEBUfaV6TEUp/TF8XGKHqpkN0mzpSst4?=
 =?us-ascii?Q?Uqo/erP0/e3gIOyspYY9TKZc3LZx5AeE+wpcd7jOO9jy1USiSKUvil9xZAwP?=
 =?us-ascii?Q?J/bSHsHLKrM7ERztMVOt+Ym30mn1NqwkMz6jcqRFW5/lKSCELsa0vHbONjcM?=
 =?us-ascii?Q?9hNg6IT0+2Ia753HPORWGcyjq2aYOdQvuM5JJrVBP2Yz4LZ3ixgdzLWKY2ov?=
 =?us-ascii?Q?cYFyGBrz6jfkRiPe8RNWuv6F6RAF83y0ylppnv7rxcmn65ZwlIK+JaJzY7T5?=
 =?us-ascii?Q?kJ3ScVjYk9GUQ4zlN7e87+yCe4Il9ltJdxnxMHOyoH9Q2cZGTE2gKIHTVuBD?=
 =?us-ascii?Q?CsND81LS97XEEx7M670JQ9EPKFGTXuwtuvyEde+4dRxvinoAHq4KoVUOsd8t?=
 =?us-ascii?Q?j2AUjwKcz1uLj+eZ4DiMFSKJxALYhFwVX0xL7r0Ht3RzsqozIiJwEwxjY5nq?=
 =?us-ascii?Q?1zMg7gkId1Ed+/+BqmA/6L7j6zOCNeX8jQGAF+zsaLOPHls4CANMjiHNPp/7?=
 =?us-ascii?Q?v4i2I4nwATMcPvTt7vb6BAQlvI+FX+02SgXQmNRazyHjshPovzMIg/7lyoPE?=
 =?us-ascii?Q?Pojg3T2OlXJJGpD8V7FufRlO2lQHNtduzhzjqblKYN01W5JynfZcYLa467sd?=
 =?us-ascii?Q?8fm9Tn18Wnte62gy5sTcwc2J1gUjTgRgo46nODzlHspvo4/KhzoGcRJmvEkc?=
 =?us-ascii?Q?ZfJq+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:49.1085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a45447-6d5b-4998-b6eb-08de57702461
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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
index da35d54a6e4e..a4f05082c1b3 100644
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

