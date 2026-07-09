Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9101C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 12:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BE010F592;
	Thu,  9 Jul 2026 12:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2NKAbZCi";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B376010F591
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 12:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ5s4MKvnRGc0hsGlq7d2oxH/9JZni6uuLAzGlCSfupysWZTaXJ48UN4G1BVXUiB4CclxN3Uv8aInlp7hR2EbKCa9XSXFeYkeUnnNyP/cZrQ9PiShw8GbJKvmdRusbrUxt++2LgGEYup8g3Fjjzid4If/Unk69HvpapEax9sDhdI82E+AsVtBQQCNk8LuhQBsDNZg16R53MZUXqtg1BmDifke9itxxZkegSAT2c3RGUGOu+lFXqtaUSpqqS+x6Z/0QhKIUgntsJF5srOwHmSyhIgH2TvKgf4Od8mADlo2I3YHs7gc25edcRMVCP12gyTg1oqke9lRC7sj+BRSpuI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA6RZ1Y84tpEHLisvvRA/dkvTxq/HqhQG20fpkpTGl4=;
 b=XRznWiem8GMExSdF0P1fAu2WWHlXntwnbJNlrpaJzMFWGayR0Q1exW2C/v/ICxBXRj6QNPpLHt0M6+OLviWr2EKSD5cmC8Lne+ZrL/Rc/bM4gwhuA9NkqX1LPO+OgZKQTATWAzzpyQiJGXdeow+NsFzrKtMV2nRjCnMIFVEi42hpyVYiPd3Z+4HwIoc+/7sFCWkogc4eRz4racgJJNSJ3Kh/2Q0TcpCbYNT4Me9C3XJ5v3BktldcXHnZbHNx4291EMJvg+9KW8g/Jkvf4KVLhG24t2ni32tI/zcYT8uAeB8Ebl26SBLxSoNiyGFPxfmChek0URPI+pbZkUn7IGrAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA6RZ1Y84tpEHLisvvRA/dkvTxq/HqhQG20fpkpTGl4=;
 b=2NKAbZCiIy5p/7MalAD4e42Qp3qf0qxZRxBngOj1YA0jm8SdNRILRueJsbSyhT+aMGMH2fXMee2Ich+wTcR3vdHkEozDRYPHeoebgR/TbOlXXILNjenOHuE44xUMrV0JIMtpdArfOxwrjlCiVqVTZWLoq6u9GpyEMbrFgOd8xrI=
Received: from DS7PR05CA0093.namprd05.prod.outlook.com (2603:10b6:8:56::17) by
 PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 12:26:55 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::24) by DS7PR05CA0093.outlook.office365.com
 (2603:10b6:8:56::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Thu, 9
 Jul 2026 12:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 12:26:55 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 07:26:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: update smu_v13_0_6 acc gpu metrics
Date: Thu, 9 Jul 2026 20:26:32 +0800
Message-ID: <20260709122633.1788432-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3780d7-20d4-422e-a7bb-08deddb55d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: hX+0krUs2ktBbo7ab62hiBSM7idkLnAXMrNgSO1x4Q+y/lhjSt3Di45Yw5kUkmmvO+Uig/6ysF/YpqTQJFNa1FW1rMul8qaDQhUnNFEfd2pHma1g25d60H5yjXHZYD6HvVPIgY+AGB14ZNy5JxEOpDTLGbdbjX0b+mn+Ef3e3v15u6YmFKzcwzR3t3caOo2sC/Eu6KLpWQI3jGpvR7dDtLzataomEovZCBBJXZtx62JHjG03V+3sGrm5Z+GQGBhtgDGKOV7JVNTX81+YKTFp0gLxOanTbtLvRHRYJ78TJQBpJrQgJUZBhZPL+4Z1xQbDF/VcO6udPJJbW5lg6tqB+jNhqQzKMxLoJYVROt8/y8aFjoAGAL9OyLkDxPjfgCx4X0HylRotZktSzQQdphdxZtJE3lAB27JzTfhlIBP7IFdLahoC0yJuvMEXXLA1/k5bqdsCVKPL0NAgYSpLMJpqJlu+uvIW5z4YlBZQj+b+BfII/017mYoQrxlfK1aGpj8tJVMdaYChnjP/nkyXKQ9qb0RrKExQ8g1+IVQbzxF3HG0J3+o5jWZzSnsGZQfWh8X6L0ftuHzVjwqCALEwPEq7DCB46n6+6XFhYjNqIiHh3QSn/7pi3734hWZdAxH0BihzKbWDi8YhriRjEYEWW0lCJXf5MSYOjCOQmy50ruQj/QUaFN3fj6rnzlwBMoZ9Svd5j7r8gVz+TqtSo+HKMXpwLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LlTPEjqnChcqgTYtOV4D8e8eeyUY35ASlhGqCX44zlhzFIOp4hIv6q69BXDnWof9X32cEl3Z3/jCFgnlI8IqYzSZn2kKD+3SlvpFUP9jodTiigIm4AcEL0oCi3rMBmv8U6pXXW9T2NFUkaqYhWiiy4K9XjSjdzL8sWvlBI23XwwaA94zRLFunJZ5Q2ZeNhOOYnkFg802F8+NSiQ90bVLxogxyklScMXPU2yktR9+Q1FYKXB4n62trMXICV+Egv34dPb6i/3LJ+mVoLjfeKsLatGyUgW8BZUJwELQO6M3Yyw+C8/wFhYvCIO8G7m6xzDJflJpcv5+uxbVRETzcigwXO6J4uRmY72J4SG6LuUKrseNhFC9BodxnwLm+VORdudow0HKPuQ5L0wPsDDNJsl+X2Ch7/EG1q+Dn9/zLCrlIATdm/ryNDXV7BqfQziioxmi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:26:55.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3780d7-20d4-422e-a7bb-08deddb55d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

Update two cases in the smu_v13_0_6 GPU metrics accumulated
counter field definition

Widen the following fields from U32 to U64 to prevent counter
wrap-around and match smu_v15_0_8 field sizes:

  - prochot_residency_acc
  - ppt_residency_acc
  - socket_thm_residency_acc
  - vr_thm_residency_acc
  - hbm_thm_residency_acc
  - gfx_activity_acc
  - mem_activity_acc
  - pcie_nak_sent_count_acc
  - pcie_nak_rcvd_count_acc
  - pcie_lc_perf_other_end_recovery

Correct the unit annotation from PERCENT to NONE for accumulated
counter fields which are dimensionless hardware counters and carry
no inherent unit:

  - gfx_activity_acc
  - mem_activity_acc
  - pcie_bandwidth_acc
  - gfx_busy_acc
v2: remove percent unit (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index a66bf33dbb58..6554780afff7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -144,15 +144,15 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
 		   SMU_MTYPE(U64), accumulation_counter);                      \
 	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
-		   SMU_MTYPE(U32), prochot_residency_acc);                     \
+		   SMU_MTYPE(U64), prochot_residency_acc);                     \
 	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \
-		   SMU_MTYPE(U32), ppt_residency_acc);                         \
+		   SMU_MTYPE(U64), ppt_residency_acc);                         \
 	SMU_SCALAR(SMU_MATTR(SOCKET_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),       \
-		   SMU_MTYPE(U32), socket_thm_residency_acc);                  \
+		   SMU_MTYPE(U64), socket_thm_residency_acc);                  \
 	SMU_SCALAR(SMU_MATTR(VR_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),           \
-		   SMU_MTYPE(U32), vr_thm_residency_acc);                      \
+		   SMU_MTYPE(U64), vr_thm_residency_acc);                      \
 	SMU_SCALAR(SMU_MATTR(HBM_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
-		   SMU_MTYPE(U32), hbm_thm_residency_acc);                     \
+		   SMU_MTYPE(U64), hbm_thm_residency_acc);                     \
 	SMU_SCALAR(SMU_MATTR(GFXCLK_LOCK_STATUS), SMU_MUNIT(NONE),             \
 		   SMU_MTYPE(U32), gfxclk_lock_status);                        \
 	SMU_SCALAR(SMU_MATTR(PCIE_LINK_WIDTH), SMU_MUNIT(NONE),                \
@@ -163,11 +163,11 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 		   SMU_MTYPE(U16), xgmi_link_width);                           \
 	SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),             \
 		   SMU_MTYPE(U16), xgmi_link_speed);                           \
-	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
-		   SMU_MTYPE(U32), gfx_activity_acc);                          \
-	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
-		   SMU_MTYPE(U32), mem_activity_acc);                          \
-	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(PERCENT),          \
+	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(NONE),            \
+		   SMU_MTYPE(U64), gfx_activity_acc);                          \
+	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(NONE),            \
+		   SMU_MTYPE(U64), mem_activity_acc);                          \
+	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(NONE),          \
 		   SMU_MTYPE(U64), pcie_bandwidth_acc);                        \
 	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),            \
 		   SMU_MTYPE(U64), pcie_bandwidth_inst);                       \
@@ -178,9 +178,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_ROVER_COUNT_ACC), SMU_MUNIT(NONE),    \
 		   SMU_MTYPE(U64), pcie_replay_rover_count_acc);               \
 	SMU_SCALAR(SMU_MATTR(PCIE_NAK_SENT_COUNT_ACC), SMU_MUNIT(NONE),        \
-		   SMU_MTYPE(U32), pcie_nak_sent_count_acc);                   \
+		   SMU_MTYPE(U64), pcie_nak_sent_count_acc);                   \
 	SMU_SCALAR(SMU_MATTR(PCIE_NAK_RCVD_COUNT_ACC), SMU_MUNIT(NONE),        \
-		   SMU_MTYPE(U32), pcie_nak_rcvd_count_acc);                   \
+		   SMU_MTYPE(U64), pcie_nak_rcvd_count_acc);                   \
 	SMU_ARRAY(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),            \
 		  SMU_MTYPE(U64), xgmi_read_data_acc,                          \
 		  SMU_13_0_6_NUM_XGMI_LINKS);                                  \
@@ -203,7 +203,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
 		   SMU_MTYPE(U16), current_uclk);                              \
 	SMU_SCALAR(SMU_MATTR(PCIE_LC_PERF_OTHER_END_RECOVERY),                 \
-		   SMU_MUNIT(NONE), SMU_MTYPE(U32),                            \
+		   SMU_MUNIT(NONE), SMU_MTYPE(U64),                            \
 		   pcie_lc_perf_other_end_recovery);                           \
 	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
 		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC);          \
@@ -211,7 +211,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 		  jpeg_busy, SMU_13_0_6_MAX_JPEG);                             \
 	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
 		  vcn_busy, SMU_13_0_6_MAX_VCN);                               \
-	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64), \
 		  gfx_busy_acc, SMU_13_0_6_MAX_XCC);                           \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
 		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
@@ -256,7 +256,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 		  jpeg_busy, SMU_13_0_6_MAX_JPEG);                             \
 	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
 		  vcn_busy, SMU_13_0_6_MAX_VCN);                               \
-	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64), \
 		  gfx_busy_acc, SMU_13_0_6_MAX_XCC);                           \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
 		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
-- 
2.46.0

