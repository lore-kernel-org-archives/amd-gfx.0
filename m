Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046B3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 03:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC15C10EED5;
	Fri, 13 May 2022 03:16:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0735110E791
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 03:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4LhMmT32WgS/1J75k3ZbL+sNFlxYoIHEDbL/94lSQgpePxJVLu63zoApbRmAy7bVXjZSKIwwsP3IKFQddvE4vyqya+4GSXgRPUyIm5gpNphYgHwXc9TMdlRKhg3vEJQsCcaDREHg2cZSBVosqF3JcZrtOjDub7qwYj1J+E2L2/l/63PfKr+T/c3V6IF6Wp4BJOzmjvykyWL8Yz74RFkcht188pLMQBNqtz4VZUMWDbzxEFQ1ZEIeik1ZmTSP6h0VmfxcVG/DG7D8/1Hcalf0xTCY7EWod4XuC3BODVPSW33LPNQp6GXKED8NZh1A1JuzZGkYRDoTK2Dauaa7k2d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foZblIjKlFB+19FmOaSMD/YpP9iqx0+nirUSwXjBWrs=;
 b=FdsVUEmGy/PePrV3En9myzN+278e7IA61o4e44l6M/0ba689RCkRrYIVX1I5Cjek1soXyA1fertrkBd/H5UOnmRN60EwQ1EpsTrLjANi//QMnEaDPhsmLreM2VJzp+r89UIlVkuV7H5MAWrwCyQ31wU1/vqsngvF+jY3I3GbY8TGghhpGdBSGhLC3W/6adhXMO4zH1LvUmq8/9qrp83tmMjLqYRHd2pcFaGHADmaaHvDzQC7RUcc3sNRiarcC/Q9k/bD3/AIDODWRWXHRBlmpaA5gPXV8st2iyPLCEAQyZGn8xZa6tXeSg2NjGO+QnRk9PYpLh6ISfGpk4zKrYHrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foZblIjKlFB+19FmOaSMD/YpP9iqx0+nirUSwXjBWrs=;
 b=VvbNwbG1U3CPOwtBHdTLV9R+5uJLmq2XxVkCrBkhtXJ7u78nA5pV1hSS2juSWRWkcjlyzoW8gRVzRD3HYOm1ewBmApXeHMwTI4/wXMK6m+7+YSDEBfuOZaoNxBwz9D9zOfW+86Yd+r9lpmQRHFBZMpcNumDeBrp4/qjoWkZ1Rj8=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by BYAPR12MB4631.namprd12.prod.outlook.com (2603:10b6:a03:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 03:15:51 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::97) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5 via Frontend
 Transport; Fri, 13 May 2022 03:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 03:15:51 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 22:15:30 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 3/4] amdgpu/pm: Replace print_clock_levels with
 emit_clock_levels for aldebaran
Date: Thu, 12 May 2022 23:15:05 -0400
Message-ID: <20220513031506.52099-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513031506.52099-1-darren.powell@amd.com>
References: <20220513031506.52099-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ee41d7-e851-4c85-0c10-08da348ee273
X-MS-TrafficTypeDiagnostic: BYAPR12MB4631:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4631A090E9CF5050F1B965BFF0CA9@BYAPR12MB4631.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lzrt0W6xXNLlEw2OXDFPdL7DWY94llVAAe3d8MI4zFocdi1azgsHA5T97KpHL0q7DPvrBW2FwERjvwirCYZjcRGGcjJUmx2rqwjFj+Y6dlawOi6tfc4fhaRrp4pHRbTXf9z/ugRGlFs/qrPvfkEuijlcMIx9J5wqUDnC97sg2t1YtGzBKJizSQxaJx2jTsKV2DXb3buKKYLeIEOXyQrWsYtMhkQu2FpKlILN94sCA/pI4b5JiWjG3efGL7KGQqV9GxK8qGgIx64GMl+UuiGRipB/eSE9MrBAinrVIWqSiBI2xSYAwGlqDu2qmQ1dhr66GLPcPJjamPDTcbme2gC4kbrGFg0Prqi4oW8DlaSAvntYdD7RDw41f0mjggnonaM3PXZUFjBiMqwNMNm6lejSmj+qTJEq7mkKGgSHDTVAhZJU7MKf65oCHDrkA/VDa3tKjNVSLvDhEzHZops6TCTM2JgCLiMxHefkeCBKeQReYfRH8x6qesIJGvwhp+kCa2DpZk4SLzWeQI6ewmNn/c/eOvM/ZgMJ0yuW3tnWAX+k7DgeXqrmwv4mWuXUnkM2F8j7aRF+BnwZFALCIGGoCw/lkzi5rS2lWucD1oLz8k0hUS7AdytTvG0BOBJ4P1kVBUUnzqtzSzc61YQypaWRWVEAZCSGHo//9p9uLT38EzSH+4tQQi3vRE1W3FeclT+qibixI/0LCm/Ix6JMjKbdU19ekA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(508600001)(6916009)(316002)(81166007)(36860700001)(1076003)(44832011)(2906002)(16526019)(5660300002)(8936002)(426003)(336012)(47076005)(2616005)(36756003)(186003)(70586007)(82310400005)(70206006)(8676002)(4326008)(7696005)(86362001)(40460700003)(54906003)(356005)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 03:15:51.3662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ee41d7-e851-4c85-0c10-08da348ee273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4631
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
Cc: kevin1.wang@amd.com, kenneth.feng@amd.com, lijo.lazar@amd.com, Darren
 Powell <darren.powell@amd.com>, evan.quan@amd.com, lang.yu@amd.com,
 david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace print_clock_levels with emit_clock_levels for aldebaran
  * replace .print_clk_levels with .emit_clk_levels in aldebaran_ppt_funcs
  * added extra parameter int *offset
  * removed var size, uses arg *offset instead
  * removed call to smu_cmn_get_sysfs_buf
  * errors are returned to caller
  * returns 0 on success
additional incidental changes
  * changed type of vars i, now to remove comparing mismatch types
  * renamed var s/now/cur_value/
  * switch statement default now returns -EINVAL
  * RAS Recovery returns -EBUSY

Based on
  commit aa93bbdd1492 ("amdgpu/pm: Implement emit_clk_levels for navi10")

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 66 +++++++++----------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..e593878bc173 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -729,25 +729,22 @@ static int aldebaran_get_current_clk_freq_by_table(struct smu_context *smu,
 					      value);
 }
 
-static int aldebaran_print_clk_levels(struct smu_context *smu,
-				      enum smu_clk_type type, char *buf)
+static int aldebaran_emit_clk_levels(struct smu_context *smu,
+				     enum smu_clk_type type, char *buf, int *offset)
 {
-	int i, now, size = 0;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	struct pp_clock_levels_with_latency clocks;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t display_levels;
+	uint32_t i, display_levels;
 	uint32_t freq_values[3] = {0};
-	uint32_t min_clk, max_clk;
-
-	smu_cmn_get_sysfs_buf(&buf, &size);
+	uint32_t min_clk, max_clk, cur_value = 0;
 
 	if (amdgpu_ras_intr_triggered()) {
-		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size;
+		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
+		return -EBUSY;
 	}
 
 	dpm_context = smu_dpm->dpm_context;
@@ -755,10 +752,10 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 	switch (type) {
 
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "GFXCLK");
 		fallthrough;
 	case SMU_SCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
 			return ret;
@@ -780,10 +777,10 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		freq_values[1] = max_clk;
 
 		/* fine-grained dpm has only 2 levels */
-		if (now > min_clk && now < max_clk) {
+		if (cur_value > min_clk && cur_value < max_clk) {
 			display_levels = clocks.num_levels + 1;
 			freq_values[2] = max_clk;
-			freq_values[1] = now;
+			freq_values[1] = cur_value;
 		}
 
 		/*
@@ -792,27 +789,27 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		 */
 		if (display_levels == clocks.num_levels) {
 			for (i = 0; i < clocks.num_levels; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
 					freq_values[i],
 					(clocks.num_levels == 1) ?
 						"*" :
 						(aldebaran_freqs_in_same_level(
-							 freq_values[i], now) ?
+							 freq_values[i], cur_value) ?
 							 "*" :
 							 ""));
 		} else {
 			for (i = 0; i < display_levels; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
 						freq_values[i], i == 1 ? "*" : "");
 		}
 
 		break;
 
 	case SMU_OD_MCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "MCLK");
 		fallthrough;
 	case SMU_MCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
 			return ret;
@@ -826,16 +823,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
 								       clocks.data[i].clocks_in_khz / 1000,
-								       now) ? "*" : ""));
+								       cur_value) ? "*" : ""));
 		break;
 
 	case SMU_SOCCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &now);
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
 			return ret;
@@ -849,16 +846,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
 								       clocks.data[i].clocks_in_khz / 1000,
-								       now) ? "*" : ""));
+								       cur_value) ? "*" : ""));
 		break;
 
 	case SMU_FCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &now);
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
 			return ret;
@@ -872,16 +869,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
 								       clocks.data[i].clocks_in_khz / 1000,
-								       now) ? "*" : ""));
+								       cur_value) ? "*" : ""));
 		break;
 
 	case SMU_VCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
 			return ret;
@@ -895,16 +892,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
 								       clocks.data[i].clocks_in_khz / 1000,
-								       now) ? "*" : ""));
+								       cur_value) ? "*" : ""));
 		break;
 
 	case SMU_DCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
 			return ret;
@@ -918,19 +915,20 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
 								       clocks.data[i].clocks_in_khz / 1000,
-								       now) ? "*" : ""));
+								       cur_value) ? "*" : ""));
 		break;
 
 	default:
+		return -EINVAL;
 		break;
 	}
 
-	return size;
+	return 0;
 }
 
 static int aldebaran_upload_dpm_level(struct smu_context *smu,
@@ -2048,7 +2046,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_default_dpm_table = aldebaran_set_default_dpm_table,
 	.populate_umd_state_clk = aldebaran_populate_umd_state_clk,
 	.get_thermal_temperature_range = aldebaran_get_thermal_temperature_range,
-	.print_clk_levels = aldebaran_print_clk_levels,
+	.emit_clk_levels = aldebaran_emit_clk_levels,
 	.force_clk_levels = aldebaran_force_clk_levels,
 	.read_sensor = aldebaran_read_sensor,
 	.set_performance_level = aldebaran_set_performance_level,
-- 
2.35.1

