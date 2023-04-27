Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA99C7EE22
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F5110EAAB;
	Thu, 27 Apr 2023 06:28:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C07010EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpK2Tf6pckD/v5AchVIVhDPbC+3pr9ClLkoK4HOdSkGb8406bycB01bSilMPYVBxHHlXqONf6mj1hn1lw4N4RlAW+bAh1qFsL1BSenzHMeSMD0ZbqpcTfyOlszC8KqM/uIsf28unAPs9FdEWmhZG2BZG9Ysx8cYl7YUrdoKFAjawJtdyrntQwA476CcVRg+tcul7aXbbbrtJcgqWCM9bm4zUdNgpksETfd72+Bn8alPK+qZbN+DqF4y+v6jgSSSY0Dt6JJnRjBW7zuZH0uEWewp2CAV3QbKF9/xKvN0LRaLe6OhpfmR3sbc8UiFY4LYbWUtbzExN8bKmV96aPSN1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38YiZGPqSSGvQfIYl5LmmxV5qHUhgeg7ZoISu1UnoPI=;
 b=FBfPjpm575AkXt3C/v7U5451pAb90s9qs3qysTmRtb45ZNlcy367b0wOhUpKjFBly2S9UzyiXNUSVc5ONCxUiIGe/UYECAHmNFZ3/C2DlSSS7T+ROU2KrQCsc/bqmao5Mio7C3cuuoeyIrzKC2Tjhoq6y+Q1BCTEqD92sxt5H2CQ6YYd2TrTTCgnjx+hWUi8H4SY+IUpKEyuwiOTRQwxDIX94dovjbkHsb+Nurrwcby4KMihgqU/hxX2p8I9OIXPIOgRHiCPNiwddqxIGQ8kVlptHyl9D4X0qYrhamgZ4j2RZbz0tjNiN+txLYUT88q81Z6z9yfHkmjWzzI1LXkDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38YiZGPqSSGvQfIYl5LmmxV5qHUhgeg7ZoISu1UnoPI=;
 b=Iwz/WRprTwxZjruj2cuOQDo7TILt3L68kNUQiZ9lOVhGHv7Oni3zU4qwxDGtTbieU98WPdNJzQmbocczTh8vAb50gCyQG9B2At+9lXEo3+gGcp0YdhUBXmKbFGvctm8Z+dBDvUDjAhdmBP7S1Sjk8Wuzdh/kyGiAsX/kDK2cDQs=
Received: from BN9PR03CA0779.namprd03.prod.outlook.com (2603:10b6:408:13a::34)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 06:27:53 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::bf) by BN9PR03CA0779.outlook.office365.com
 (2603:10b6:408:13a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:52 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:50 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] amdgpu/pm: Replace print_clock_levels with
 emit_clock_levels for aldebaran
Date: Thu, 27 Apr 2023 02:27:15 -0400
Message-ID: <20230427062718.1172269-6-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427062718.1172269-1-darren.powell@amd.com>
References: <20230427062718.1172269-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 38924864-74e7-47fc-b93f-08db46e887b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHP7WV/FUfxE4m9y6rXnuvtAR2VUOvyAz1frHNus+5B3KbuqBgGpou0v6CPqK3SDfMujl0CcbnwrmULHgaJ2Kfwokfml+55cmcbPhHw/6E9OPBMYgo/grJSaoMAyx1hJeGs8frHsw8CoB2pfyFgq2ch6zN3HAxve9dd5bwYL/PVTPRTDcA1xq8qX0ZnSnaYXJMGvwZQYcY/VgzaOsLk9orjoJUDPFMrmumdg0y0pMYgPP1CzLplTM4bcwf46UGmI4OuV6k7QrmLNBBBAtXwk3MqlVEHuPrt6IEszGWeiSv8JtIEu4QTz+79apE4zTHMvViFMeSadS3oMEl+HTsZkeZ7OP/W0ZUIKDWjRoarRD8B7byWmvkZlVlQu/g472bxeiqdOv8OV53IhImPBPMy/oONvzZMHFy8l0XhLhxy17t3WUh92MWpVjiFCFZU2fY+9R3SPVsTvJHc/3FqKBLxq/pPLrln0t1/REh03CUdBLgIPXZRxA7T40hWtdgta3zWGbnAxqW3pHwsWX1fbtCU8nYMoAfBQ5704JiezhNvf/2e31PlT0BmLCm+6DcCGGsYc7wLp4MF9VlgOhiKQMxx4ukWhI5GH8/mt3MGkKiu/uJOzMBL2uwNDmBhkGBArMrvAP9P8BYQqbLyCNnhrUIw51/KfZf1IyP/pW2hi9gok9GED23DkuzpwvRMPahS+YHO/FFJAs7uROqRDUyhkjOYFzHdrkPxYcaslbjyGgBUaLvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(186003)(26005)(5660300002)(1076003)(426003)(336012)(2616005)(82310400005)(7696005)(36860700001)(16526019)(47076005)(6666004)(83380400001)(478600001)(36756003)(54906003)(40460700003)(44832011)(41300700001)(356005)(2906002)(8676002)(8936002)(82740400003)(316002)(40480700001)(70586007)(6916009)(70206006)(81166007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:52.5779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38924864-74e7-47fc-b93f-08db46e887b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
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
Cc: lijo.lazar@amd.com, ray.huang@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, lang.yu@amd.com,
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
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 63 +++++++++----------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d30ec3005ea1..f93a50217239 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -736,25 +736,23 @@ static int aldebaran_get_current_clk_freq_by_table(struct smu_context *smu,
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
+	uint32_t i;
 	int display_levels;
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
@@ -762,10 +760,10 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -787,29 +785,29 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		freq_values[1] = max_clk;
 
 		/* fine-grained dpm has only 2 levels */
-		if (now > min_clk && now < max_clk) {
+		if (cur_value > min_clk && cur_value < max_clk) {
 			display_levels++;
 			freq_values[2] = max_clk;
-			freq_values[1] = now;
+			freq_values[1] = cur_value;
 		}
 
 		for (i = 0; i < display_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
 				freq_values[i],
 				(display_levels == 1) ?
 					"*" :
 					(aldebaran_freqs_in_same_level(
-						 freq_values[i], now) ?
+						 freq_values[i], cur_value) ?
 						 "*" :
 						 ""));
 
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
@@ -823,16 +821,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -846,16 +844,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -869,16 +867,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -892,16 +890,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -915,19 +913,20 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -2079,7 +2078,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_default_dpm_table = aldebaran_set_default_dpm_table,
 	.populate_umd_state_clk = aldebaran_populate_umd_state_clk,
 	.get_thermal_temperature_range = aldebaran_get_thermal_temperature_range,
-	.print_clk_levels = aldebaran_print_clk_levels,
+	.emit_clk_levels = aldebaran_emit_clk_levels,
 	.force_clk_levels = aldebaran_force_clk_levels,
 	.read_sensor = aldebaran_read_sensor,
 	.set_performance_level = aldebaran_set_performance_level,
-- 
2.34.1

