Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC87CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39EC10F949;
	Fri, 29 May 2026 06:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/ixunBx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B768110F949
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVgmmNv4NR0yIBfXbfOx7a0FO+GJnbW8mtpEGXIMoETW+vosIgFYdTto8o+QHiRdmPtVFIHQHMrE92QW56dbfAnQ/zM8c8oFQCE5s9OsjlhhD0Uyh+MEQVRQPntb+iRwEjHTf4ufZDBv3D6sebyYL/bDCc5MpctmD9KNcZ6YcHojtr3X+o8G1ZsXvCt5CgLfwGs7QAQTUCGLgYMHaOjCxyWskMNZ7bjchTnhNhNqJu7Jf0m9CUU9iwKVTmefzNmq1IH0m236hFFCQEkDz5mM8a0LjBljX+KN6DI5kezFX+8wz2OvlV7rcPsXtnvM+MNab/B9RSehRYBmka58ixt6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJbWnMOCDEDmJy6h8aCkIdf2ojPhzYPTQ8tUb5i2i9Q=;
 b=othHmjLgcWaeqjLWViBMrpOzHrow3iK8gdwpGJRDy1pvjT7YQ3OjwJmIkXRpylq5q8AHK+7Fi9mOVQEKaaIhokSYLxUXK+kdd5swX9cQsv25aF1GPTfObK6PsDjqGH515uwHHy+VSJYtw0oXRXii0WxFvYIQBcHR9gLZfS3RJ3dvwa+NI7L5mUFrkS5guMGrbEgf3cLJ7cVh30Q1gsWLSmf35PUC7rmHrFCEY9EwuDJkVubK0jwfxRkLdJTANh7A9eIKg08ux+V7QYS0+LzRlXbkwAFxYRedoUr3Smgu2av19KeYN+S62JOSEuBnZ1LWpYoTI1Y+Fre7D3TgxDcxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJbWnMOCDEDmJy6h8aCkIdf2ojPhzYPTQ8tUb5i2i9Q=;
 b=J/ixunBxr0sYdb40zWfXZzhCL4McCWL7d6kQ0eTg9kmIG1AQGtB9ebb5hrrfs01D5omIe6QuJau/p1jlGmXkGJdJf77g1kvHczf5JgsoYUKMsvTMJdgedF4UTYOa7Rl1WOnLawL00/3SchwNoBuXmNnSxOyPTrAzZ/gfJIIvj5Q=
Received: from BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:19:38 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::4) by BL1PR13CA0223.outlook.office365.com
 (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 06:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 06:19:37 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:19:35 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: Handle sysfs_emit truncation for smu15
Date: Fri, 29 May 2026 14:19:18 +0800
Message-ID: <20260529061920.357400-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260529061920.357400-1-asad.kamal@amd.com>
References: <20260529061920.357400-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0905294c-6219-44db-d55e-08debd4a42d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: BhbrlQ8CwfiSCC/b0Cq/k5V7SHtSosDT6UyQzZmKti3oPFjVdAHI3YLbj6/vGXMFAAvk8J51zAhMb9MAnTaZb7X4ChzCKM0quXMWctbzvacm3mjAmHbO5jCrv0qsGAi74C6uk5MecxNNUqc2NgVaA1Y0aBaIzuyfTbVpcquo6aqrE2w6iBXsTyukxZ4h92EfgwckhS0/H0Jjmbq2yKx+y4NMmYLKblCdtBe6DEZrEYwEfPPo562OVxKNXc6qbPR/JyC7XXu9DRXXuR42/RNXuTs1+xG/syoexlGYRrY9k5bq5n/hxgXSGvFhhvQmtx+zDdmfj52wHCHttyBrL5jhRUhVCsWbM2BySKsVyNyytioUjoirD9FfKWFTBirta3q/Pe82ND5oAEnpq4rZ6pM57gGds+8mwTNftEE0hNIPg1vdNlLDXViXXKxVMp/urlTXdZ66yGXhHEWkqSJqexsMKV3kuhsoq3qv3sf4P4Rl0UlPXIxnmkkvnsrEc1F5asGcmRcK3FWMRpa4qP+ETkfI8zoRFW9VW1ekc45bJoCg+6Htz0bIoaW45bhLMbvLivhtAM5KkP0jk7NBR0eaBf219By/4XKn+kaKl3lO1wk1mqTpnnIBlc3rgR8VMijTaq4DFucKcXpBRNNwPtL6E6yxh7w/b99uvGUSD80eSA/tIR7RpHMtceSc/zMMVih/oZY30faK3k/FPp/9l2N7sUtF2d+zkuE+kMzj5fK2ymAYJBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FTIR6w6xIde0gBruhFAol/vLoPe5FqQw7O+dbiN3sddVseiV9dNxAXnkFQFad1+pU+z8y6D9SDYtLP1C6QGQPYkGYtN02a963Tr6xGx6rOf/GUdVOHvUkQ4qazcHwuXMkXDW4PLeJER9ERGfsS0BRh5CoT97YVKVO9TOUlRmOutCYUhTb9YRM6g1aCkAcVKWpWTH2rvFwNuyHa1rrp2Bu1gMNO5ohUpr1bSVF+W/htCPvxhOSeBsJadwfPzXepXi/X13CD1l29DxbeorT+5qoLQvUhHInAGdWtyzVcMxG/25pBaiXJt4kB/uIXBSC2DMCEveJcV3YA/4kY1m8auAwXkibLoMCV1W4aSrjRlfmHhVYNIKJklfATSWxgy5/LxSWGJOlxktOx7syCBF2qAmvc2hyz86VVa47AQYCV7yEEnTsONVQh9uPYG13mBaUhED
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:19:37.9298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0905294c-6219-44db-d55e-08debd4a42d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
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

In smu_v15_0_0_emit_clk_levels() and smu_v15_0_8_emit_clk_levels(), check
each sysfs_emit_at() return value and stop further output when it returns
zero (page full).

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 71 +++++++++++++------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 31 +++++---
 2 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 4e7d6a602c6c..977ed70b8689 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -995,23 +995,40 @@ static int smu_v15_0_0_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type clk_type, char *buf,
 				       int *offset)
 {
-	int i, idx, ret = 0, size = *offset;
+	int i, idx, ret = 0, size = *offset, n;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
-		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
-		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %10uMhz\n",
+				  (smu->gfx_actual_hard_min_freq > 0) ?
+				  smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %10uMhz\n",
+				  (smu->gfx_actual_soft_max_freq > 0) ?
+				  smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_RANGE:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-				      smu->gfx_default_hard_min_freq,
-				      smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+				  smu->gfx_default_hard_min_freq,
+				  smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_SOCCLK:
 	case SMU_VCLK:
@@ -1034,9 +1051,12 @@ static int smu_v15_0_0_emit_clk_levels(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
-					      value,
-					      cur_value == value ? "*" : "");
+			n = sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+					  value,
+					  cur_value == value ? "*" : "");
+			if (!n)
+				goto out;
+			size += n;
 		}
 		break;
 	case SMU_GFXCLK:
@@ -1052,14 +1072,22 @@ static int smu_v15_0_0_emit_clk_levels(struct smu_context *smu,
 			i = 0;
 		else
 			i = 1;
-		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
-				      i == 0 ? "*" : "");
-		size += sysfs_emit_at(
-			buf, size, "1: %uMhz %s\n",
-			i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
-			i == 1 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
-				      i == 2 ? "*" : "");
+		n = sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				  i == 0 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				  i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
+				  i == 1 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				  i == 2 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	default:
 		break;
@@ -1067,6 +1095,7 @@ static int smu_v15_0_0_emit_clk_levels(struct smu_context *smu,
 
 	*offset = size;
 
+out:
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 2105a1d7bb34..e076ad68b66b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -692,7 +692,7 @@ static int smu_v15_0_8_emit_clk_levels(struct smu_context *smu,
 	struct smu_15_0_dpm_context *dpm_context;
 	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	int ret, now, size = *offset;
+	int ret, now, size = *offset, n;
 
 	if (amdgpu_ras_intr_triggered()) {
 		sysfs_emit_at(buf, size, "unavailable\n");
@@ -703,16 +703,28 @@ static int smu_v15_0_8_emit_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->gfxclk_pstate.curr.min,
-				      pstate_table->gfxclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->gfxclk_pstate.curr.min,
+				  pstate_table->gfxclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_MCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->uclk_pstate.curr.min,
-				      pstate_table->uclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->uclk_pstate.curr.min,
+				  pstate_table->uclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_SCLK:
 	case SMU_GFXCLK:
@@ -738,6 +750,7 @@ static int smu_v15_0_8_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+out:
 	if (single_dpm_table) {
 		ret = smu_v15_0_8_get_current_clk_freq_by_table(smu, type, &now);
 		if (ret) {
-- 
2.46.0

