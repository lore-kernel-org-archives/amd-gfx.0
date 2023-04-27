Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA41C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9423A10EAA4;
	Thu, 27 Apr 2023 06:27:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6C310EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxndRruz22EORkVyk7tW1i63+OLLRSfVxY3WQ/NPAajQt0ZHpNeXVOyTYtujwsK6F7vX8Z+5FcWbRJTUZYokoiPgtC4FXOt9dNj/1Zn4gbYQozhqO6T2CQMcSo1ypyuZZZKJqACpTd2SEojXm7k5RqhtJnoAKm4ntyE2KlDh/PpQu+IZ31HkJPHWL9sFbnAFIaEaHqZNBbaLOiPyAfGRzp8ivMGkMaBJJgzV+l4XrzHXxaL1TOujvYNcp9Bt0YBNtfnW2kmlMPW3+pV3iGTyYOWua7X664/ei0mJBudKKx17ccNU5r+n0Gc9JUdOk6tuvBcOUHc8ZzYzsTgfKP60jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzTAw5xysB3ehmYtUPVEpOp/jLSvWJli/ON3db/8T5Q=;
 b=c6+l3Xhj6IfDF/Sdfau5f9kPtMZmGhR+MnPvcRqCNy0ymWS70lreUONsCCvqI17xBwOmsniW+SRoihUdn48uQxSEZZivfNCIgmyYIhQK3jAThygXlGy5JhRoSFQp4N1qdnNwPf61xsyq1lBm4wE28mBm+Qlak15xnOAQ+zSmNBxorzBL9beFEfUB0PSQ9Jolka0qYMvUMAT/Nn+SAtb3tUSbepR7Yizmk9O6i+dyPiaFzYwpujcT77g2vZVyXetDtXQie7H/lJHCpsSKEH1TzcE1D8ThJoEmj0A/KBfn2GSNIZbod0IoTvqwmuW9ZsfqGgmbUZwaM/Ph1r1rA1tP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzTAw5xysB3ehmYtUPVEpOp/jLSvWJli/ON3db/8T5Q=;
 b=3STynKKBiVBkAhWoB6ll2/6hak5YmWaPLCH2u+8ff5MlqhCtqFyGnXklkmDCM71z+7wqcSf5BGlDdc+mz2SLif1qmYzRfZS3mxmrSo7eljCpp50t6oufEXBNo9vCqqVivQ5dBkDCl0wEPNTai1ENgrrqI133V1bev793lwH+YkU=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 06:27:51 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::9a) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:50 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:48 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] amdgpu/pm: Replace print_clock_levels with
 emit_clock_levels for arcturus
Date: Thu, 27 Apr 2023 02:27:11 -0400
Message-ID: <20230427062718.1172269-2-darren.powell@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: af92c0c9-e143-4dc5-071a-08db46e8869a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irFHSoiCqU/kYlAmdwdE23tdaiZoUsryOY7FrJ1pqkFQ6VldeUxmF85bXE3bQ1DiS72TBx9q3eE2VOsI+DF3cZFsy/MKuLSG8V+i5+RZtbRLyA8+hATETkdFs2SOta2Vfnfr+r10iuzYFt/nFuM1IWUiRsPafFWrZnQ5GDR89g09P84rJdSfwmPEHWuWs9j+dmKUctsIVhoDO1bAvekeID4IzgXZrBjiL9F/WqgWDX/5jpTGiJlq/O4SGFTUkf6y4qn8w0y00g7NH+M1IxYLVpb7AGtRrXM5VAdVjNexwrHs+g3LVdWIh+A1T9Vs25httzxQU3Ciz6uvMnRlYaOfflrBm+CZ091kXvjjn2zeT8aM9s6XdGQnSEIC5zyHi3yXN8QfLFSzBfmNjiaOtG5Z1gx3dum8XybLsrcpw6nHj4k0rJu5otjtAx0HJbDLi3tY+BQ7NTrcqCNjUQ5iSjh+QvTaAO4UY5z/obIq1rHAXq8FEaIeGLwAJ4ZaZ61Q4orkqso+4fl7mbqdaWP0OtM7HpyfpbR1scrVpHT5kzxmb5b5l+Yu2iXWlldJpREzcPKBlVVdZBBF8ma13Ezv/5J+N2axa9amShO4BS4HP9y2Lld4LODQR2CoIOyNNYyQxVtjAMO/dcfl+vfp9lV+67AQC2ZjmxARQyYv6ikqo++azrZj7oaaxR28IXCn7FGeQwcUGwVV9DmEw9032XD9TuGfon4mcsrWfa76VEYWqZRw4tQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(40480700001)(47076005)(36860700001)(83380400001)(336012)(426003)(186003)(40460700003)(1076003)(26005)(16526019)(86362001)(82740400003)(316002)(4326008)(70586007)(2906002)(44832011)(70206006)(41300700001)(6916009)(81166007)(356005)(478600001)(54906003)(6666004)(8676002)(7696005)(36756003)(8936002)(5660300002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:50.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af92c0c9-e143-4dc5-071a-08db46e8869a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

Replace print_clock_levels with emit_clock_levels for arcturus
  * replace .print_clk_levels with .emit_clk_levels in arcturus_ppt_funcs
  * added extra parameter int *offset
  * removed var size, uses arg *offset instead
  * removed call to smu_cmn_get_sysfs_buf
  * errors are returned to caller
  * returns 0 on success
additional incidental changes
  * changed type of var i, now to remove comparing mismatch types
  * renamed var s/now/cur_value/
  * switch statement default now returns -EINVAL
  * RAS Recovery returns -EBUSY

Based on
  commit aa93bbdd1492 ("amdgpu/pm: Implement emit_clk_levels for navi10")

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 54 +++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9cd005131f56..0136e136e807 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -757,29 +757,28 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 					     value);
 }
 
-static int arcturus_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type type, char *buf)
+static int arcturus_emit_clk_levels(struct smu_context *smu,
+				    enum smu_clk_type type, char *buf, int *offset)
 {
-	int i, now, size = 0;
 	int ret = 0;
 	struct pp_clock_levels_with_latency clocks;
 	struct smu_11_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = NULL;
 	uint32_t gen_speed, lane_width;
+	uint32_t i, cur_value = 0;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
 
 	if (amdgpu_ras_intr_triggered()) {
-		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size;
+		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
+		return -EBUSY;
 	}
 
 	dpm_context = smu_dpm->dpm_context;
 
 	switch (type) {
 	case SMU_SCLK:
-		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
 			return ret;
@@ -797,16 +796,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		 * And it's safe to assume that is always the current clock.
 		 */
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
 					clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(arcturus_freqs_in_same_level(
 					clocks.data[i].clocks_in_khz / 1000,
-					now) ? "*" : ""));
+					cur_value) ? "*" : ""));
 		break;
 
 	case SMU_MCLK:
-		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
 			return ret;
@@ -820,16 +819,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now) ? "*" : ""));
+				cur_value) ? "*" : ""));
 		break;
 
 	case SMU_SOCCLK:
-		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
 			return ret;
@@ -843,16 +842,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now) ? "*" : ""));
+				cur_value) ? "*" : ""));
 		break;
 
 	case SMU_FCLK:
-		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_FCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
 			return ret;
@@ -866,16 +865,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now) ? "*" : ""));
+				cur_value) ? "*" : ""));
 		break;
 
 	case SMU_VCLK:
-		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
 			return ret;
@@ -889,16 +888,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now) ? "*" : ""));
+				cur_value) ? "*" : ""));
 		break;
 
 	case SMU_DCLK:
-		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
 			return ret;
@@ -912,18 +911,18 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now) ? "*" : ""));
+				cur_value) ? "*" : ""));
 		break;
 
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		size += sysfs_emit_at(buf, size, "0: %s %s %dMhz *\n",
+		*offset += sysfs_emit_at(buf, *offset, "0: %s %s %dMhz *\n",
 				(gen_speed == 0) ? "2.5GT/s," :
 				(gen_speed == 1) ? "5.0GT/s," :
 				(gen_speed == 2) ? "8.0GT/s," :
@@ -938,10 +937,11 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		break;
 
 	default:
+		return -EINVAL;
 		break;
 	}
 
-	return size;
+	return 0;
 }
 
 static int arcturus_upload_dpm_level(struct smu_context *smu,
@@ -2432,7 +2432,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_default_dpm_table = arcturus_set_default_dpm_table,
 	.populate_umd_state_clk = arcturus_populate_umd_state_clk,
 	.get_thermal_temperature_range = arcturus_get_thermal_temperature_range,
-	.print_clk_levels = arcturus_print_clk_levels,
+	.emit_clk_levels = arcturus_emit_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
 	.get_fan_speed_pwm = arcturus_get_fan_speed_pwm,
-- 
2.34.1

