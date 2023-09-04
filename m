Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30C5C83F2C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 13:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46BFE10E1F6;
	Mon,  4 Sep 2023 13:10:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6FE10E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 13:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/etAxinKYcJwUPm4lHjkP4oYL+5JzzhqLyok1IuIqZ7J/Tfen0+C948V0CAXjWnPxuy6eVp3p/CfVqO5c5rDxKOV0L7pfYFA/XTZtQq/tvtED+HJNimuSmnoL9dyLgj9AS8qAbLVwsACLlYoHSDKs5KIWTbQWnWI4yWWmnY2ZuSAcqCwWigBDiI+3hU8j3elzegxgzZw33SxUJkcSPxD5A2oYeTgzBcQDuZSJg3m+V7oA43Dx7PYHX6Mv6y/EJeu8QYkIfFBI1N9Kw7NU0BJJ3dsgI5eAbNbDVJBVcrK9MN1I30kOp7fvVsRyElS4mG4PKQOK8slICv+uFHItUL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj6NgT1tdHOsXNEtggqTny+FguFKqO/BTaowcBrvcsg=;
 b=OrKQ8SXZeBF9yfYaKGTuFQ+aY++0sf9roDl4AOmTS66qypWsMkwKAvhGuqU5X+Hjao1FLogv1V7X6SAh/jnwLHAglCNhijp2kwYBfcr8k8UaWAVhj25bod4fPfn4YpUV6hPfNy8W51OYwPM7LoZU3mFrAHsmnBYOz75d2eMqxzKdS23k1N0Wc2X6T8WMU8Frw9YrlY17RQ6mPyMasQn4K9KvyZGsKIdz20BpWt7VUuxuDAY+wEjZTuxeP/tILHyMpHPeegAXVhGO5uRRHANY60MuzinNUtlxQskPsIYbxG1Ha//6B7rmKYZG3Zhoi7bS/lRX2ketjuD51yoKsPVxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj6NgT1tdHOsXNEtggqTny+FguFKqO/BTaowcBrvcsg=;
 b=Y6IprtO2eIlw5uneC+TEsdCMKfdCHCvdpFK2dXFwSNDodCJ7PEn9cqv+2YMgE2AUyWz+BSXYcjHCo+pEU0+7Kzj7h6Uf9U2l6b09LE3RqD5so6Kvqjawp3UE8EKxv8sXwFTC7bssXbaJ40o60iXplNw0D9Ci3IEzFm1e+ge35AI=
Received: from CH0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::7)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 13:10:52 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::19) by CH0P221CA0003.outlook.office365.com
 (2603:10b6:610:11c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 4 Sep 2023 13:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 13:10:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 08:10:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: Fix clock reporting for SMUv13.0.6
Date: Mon, 4 Sep 2023 18:40:25 +0530
Message-ID: <20230904131027.912234-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bffc42a-4d4d-4047-0825-08dbad485d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lUyol58yjZtF2RXWbmXQp+VP9rNIvA9PUVdCQxejrXMbPCc3XCzj/kQaxzSgCxndWZaeX8PxVK2CfvLahKljVz9BjjBnNTzbfYjdlKQZ8AJp3e02t2bj/g+LMWZPNCxQqz66wjlNLsmnBPB5XCy5SpU2pwm70vHyD7rVN8YU5Q9JJdF9EOK/TaqKoWamBVjY1ma9ty4/mghGSKnrER4DZi7bf4ywxBdqxWVM86qxV2lv75BZMHWbPNdhltA8QXxYcjwMgGwbBi8i67CfBMHV1jHGJbceg+hpR+oTQvQei4WPc33+6O2kX08FxbQZuhq4ZMs1Uj7UV960JeDo9KEoBlxktDvTTj16KHCSstTO5QGMAbB/EX9+zS4d1GYOmW42uHnoDjsUXKuagpY+DX6vwcjIQnfJ47Ak9otRLj+cSiB/2jj+TNKZV7WV1sSHIOzgcuQpkrzIajhiq0u0VyBvmADovui5TvIryh6/usxtEpAgfacvWiHSlSRTLI96zqzPk4s/ByMu/jbNo8O/gQpXkn+n59Sp+OR53GybQ3YDN/AtVWzEae6rs35oa4PIQuAVLwgGTyeAqvdyXqHGti3IRSKqHhN3sVvusk8CnvgfGu9LLaaGCOv+RCqG18d3poZinsMxoz7E/zUIszbWAo5JzjCHJG5h2JbH/QAfm6ayZs8CLwYvVcnr/lIemN4oGy+ttvm6OABRd2tMSwoH7nvAKWVblp7LsUmfBMYruwxVg0cwID0HTIqXVymhVFuj4IbTUT/CbS4KcPvccY85qa9ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(356005)(7696005)(6666004)(83380400001)(478600001)(2616005)(426003)(26005)(16526019)(336012)(2906002)(41300700001)(6916009)(54906003)(316002)(70206006)(4326008)(8936002)(5660300002)(44832011)(8676002)(1076003)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(82740400003)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 13:10:51.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bffc42a-4d4d-4047-0825-08dbad485d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On SMU v13.0.6, effective clocks are reported by FW which won't exactly
match with DPM level. Report the current clock based on the values
matching closest to the effective clock. Also, when deep sleep is
applied to a clock, report it with a special level "S:" as in sample
clock levels below

S: 19Mhz *
0: 615Mhz
1: 800Mhz
2: 888Mhz
3: 1000Mhz

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 159 +++++++-----------
 1 file changed, 62 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ff58ee14a68f..8fa01c5570bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -91,6 +91,8 @@
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 #define LINK_SPEED_MAX				4
 
+#define SMU_13_0_6_DSCLK_THRESHOLD 100
+
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -782,13 +784,61 @@ static int smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
 	return smu_v13_0_6_get_smu_metrics_data(smu, member_type, value);
 }
 
+static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf,
+				  struct smu_13_0_dpm_table *single_dpm_table,
+				  uint32_t curr_clk, const char *clk_name)
+{
+	struct pp_clock_levels_with_latency clocks;
+	int i, ret, size = 0, level = -1;
+	uint32_t clk1, clk2;
+
+	ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
+	if (ret) {
+		dev_err(smu->adev->dev, "Attempt to get %s clk levels failed!",
+			clk_name);
+		return ret;
+	}
+
+	if (!clocks.num_levels)
+		return -EINVAL;
+
+	if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD) {
+		size = sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);
+		for (i = 0; i < clocks.num_levels; i++)
+			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i,
+					      clocks.data[i].clocks_in_khz /
+						      1000);
+
+	} else {
+		if ((clocks.num_levels == 1) ||
+		    (curr_clk < (clocks.data[0].clocks_in_khz / 1000)))
+			level = 0;
+		for (i = 0; i < clocks.num_levels; i++) {
+			clk1 = clocks.data[i].clocks_in_khz / 1000;
+
+			if (i < (clocks.num_levels - 1))
+				clk2 = clocks.data[i + 1].clocks_in_khz / 1000;
+
+			if (curr_clk >= clk1 && curr_clk < clk2) {
+				level = (curr_clk - clk1) <= (clk2 - curr_clk) ?
+						i :
+						i + 1;
+			}
+
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+					      clk1, (level == i) ? "*" : "");
+		}
+	}
+
+	return size;
+}
+
 static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type type, char *buf)
 {
-	int i, now, size = 0;
+	int now, size = 0;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
-	struct pp_clock_levels_with_latency clocks;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
@@ -851,26 +901,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get memory clk levels Failed!");
-			return ret;
-		}
 
-		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", i,
-				clocks.data[i].clocks_in_khz / 1000,
-				(clocks.num_levels == 1) ?
-					"*" :
-					(smu_v13_0_6_freqs_in_same_level(
-						 clocks.data[i].clocks_in_khz /
-							 1000,
-						 now) ?
-						 "*" :
-						 ""));
-		break;
+		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
+					      "mclk");
 
 	case SMU_SOCCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
@@ -882,26 +915,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get socclk levels Failed!");
-			return ret;
-		}
 
-		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", i,
-				clocks.data[i].clocks_in_khz / 1000,
-				(clocks.num_levels == 1) ?
-					"*" :
-					(smu_v13_0_6_freqs_in_same_level(
-						 clocks.data[i].clocks_in_khz /
-							 1000,
-						 now) ?
-						 "*" :
-						 ""));
-		break;
+		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
+					      "socclk");
 
 	case SMU_FCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
@@ -913,26 +929,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get fclk levels Failed!");
-			return ret;
-		}
 
-		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", i,
-				single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ?
-					"*" :
-					(smu_v13_0_6_freqs_in_same_level(
-						 clocks.data[i].clocks_in_khz /
-							 1000,
-						 now) ?
-						 "*" :
-						 ""));
-		break;
+		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
+					      "fclk");
 
 	case SMU_VCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
@@ -944,26 +943,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get vclk levels Failed!");
-			return ret;
-		}
 
-		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", i,
-				single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ?
-					"*" :
-					(smu_v13_0_6_freqs_in_same_level(
-						 clocks.data[i].clocks_in_khz /
-							 1000,
-						 now) ?
-						 "*" :
-						 ""));
-		break;
+		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
+					      "vclk");
 
 	case SMU_DCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
@@ -975,26 +957,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get dclk levels Failed!");
-			return ret;
-		}
 
-		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", i,
-				single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ?
-					"*" :
-					(smu_v13_0_6_freqs_in_same_level(
-						 clocks.data[i].clocks_in_khz /
-							 1000,
-						 now) ?
-						 "*" :
-						 ""));
-		break;
+		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
+					      "dclk");
 
 	default:
 		break;
-- 
2.25.1

