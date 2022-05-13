Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 03:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6EBB10E89A;
	Fri, 13 May 2022 03:15:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552A710E791
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 03:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be6zMFMx5fySglLyqL6yz36wkTqWbbzMvS7+92Y8P2QaUYooNzbyE9XTEN0HEqboBl3THa9XgtM5LBiBR9UDV1JkD7sE7hWoE19BIpaEyWnrOe3V6j8bwS7Rb6PVIGLTXsdJl0ZRmZsH7D5rXQn5gTyWmSRqiV99cOb87B3tO4yfOzn95GT3BIdSg1Mr3rSodpzTnQDrUVcZXWiZO3pYmpP4lGsayrBc1G4OTOcdasHLr2roQizjk7Crxhlv3ktWNiVFL+FWxINghvV4Ku0hZtVaD6y1i3KcTqnvo6gAnSJROSFfPtPghwNg5WTjYdxH9N9NwSm5Lof92YfDf19XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3lWn7jexV/jPYJ3nRTN+yn7z9hqMXBxT/qs8BBC67k=;
 b=QH2QIUjils4sdSk2GqIqnA0hoVsWZEyEDv8i7bPvE6U0ekMawfpjZzTPWXcdaqldFQpwP/UA1dUSRZaMzNoDkmOtDyETFt8TVLnzCqaLSEFcijAN7nAkRAdpB2f35hbt5sh6PZmKcy7ZqpPWC3c5QyLETQERKO6ndw2hBffBXcUMmmN8YdkRCAjPFCkSdYOxxkAZfW9lIAdj+3J9WI/VnljU8SzGP3aW2s8p9APRN+st9VIB6vXNEa+ekK+cggZ9AZ6BZvK7Plj+df7pPXd7B+o048GS5BlHxkBoW3sSmZfVc+j8pk+nWlHMiBIzlbJ/ZJfTOQakSFXp5h6VKr6QYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3lWn7jexV/jPYJ3nRTN+yn7z9hqMXBxT/qs8BBC67k=;
 b=lGKQ9FjeR91j3JgqnlImPqh3k3p40zy+RMCSNcoQ7Igxd3gDofA3ujILpvMYZcpIjfFVSHJpNaxoskp0S2jeUSElJXQKyzoV9zzLKxHSZYIBPKSaI6n7bwlJF8fHpirjp3k64OWOozaR4upgak3cGdnRBGd+A1oKqcAD6U+yQoE=
Received: from MW2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:907:1::39)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 03:15:52 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::ff) by MW2PR16CA0062.outlook.office365.com
 (2603:10b6:907:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 03:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 03:15:51 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 22:15:28 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 1/4] amdgpu/pm: Replace print_clock_levels with
 emit_clock_levels for arcturus
Date: Thu, 12 May 2022 23:15:03 -0400
Message-ID: <20220513031506.52099-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b21aee-8f23-4669-72a1-08da348ee259
X-MS-TrafficTypeDiagnostic: BY5PR12MB4083:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB408364D5FD4EEA422D552BCDF0CA9@BY5PR12MB4083.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmVvtW0brkIsRlN9QtX9EZWOvuhU4/u0V3aCitukiuWeUB6/XIIM4sGPbDZBdIWgbIZUZn3OCGFsASmEExC540F32sLJz6eYBHfjh6xrtu17L0lJXzoLB4AZzg4hLWvSaSpPszIcBy78RTYc0qEyqhZp/fOaBKMGX5Fn0fe1jKpYE7ai6UmwwnnIq/Z1gZGnYRAYFp2MM7X+uCTqnHexHIrzjZNyE7+zwedz76G+tkVwLdpJiuKn2dc6kdHyjxFThaVDsJUb70AxdnDedcgRsLADlFH2/M9TbIIHzQd0ZsJ8958HOneeD9c9ZO0IMOK7gEtHvAGOEJV2L9Cc0EZsGZoPY+4AmC0R2dxf8hnxDB2bAkFNQZAEvob9FH2OD6pxdjw/KBA3Xg9e2Rtfqrq4zLePcag4BqQpp1eN5s9mauYZ4AXbB2AClJt6wsYAI//TokSMAGgy7U+EOJ+3jSiVRya4AlVcpEtxG8CoFO+IFm2EaqNwjX1e1clbJpvpIdyVNR+oKedYEqEo2TKAWb/VMSQWLQ/faOAlsmoySQg4g8Lw5KulfNPXa9SqtTwDaY7VRxzHen2JoIUbPDz3A3mIkZ6JgshRNPFZgqmoLTLmLiX6zVkpJfZbI+izHW0V/6MNuvioWw1g6DRzjh4E8iRKp+NBU/m8l1P1GaUjsGtg8JlkZmp+wZYBu3yDqIGuME1GeYodvaywVQvXH9vcuOhc+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(186003)(5660300002)(47076005)(83380400001)(1076003)(16526019)(2906002)(70586007)(426003)(336012)(44832011)(36756003)(8936002)(70206006)(86362001)(6916009)(6666004)(81166007)(82310400005)(7696005)(4326008)(2616005)(8676002)(26005)(356005)(36860700001)(316002)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 03:15:51.1984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b21aee-8f23-4669-72a1-08da348ee259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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
index 201563072189..163adab2843d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -756,29 +756,28 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
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
@@ -796,16 +795,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
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
@@ -819,16 +818,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
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
@@ -842,16 +841,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
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
@@ -865,16 +864,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
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
@@ -888,16 +887,16 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
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
@@ -911,18 +910,18 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
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
@@ -937,10 +936,11 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		break;
 
 	default:
+		return -EINVAL;
 		break;
 	}
 
-	return size;
+	return 0;
 }
 
 static int arcturus_upload_dpm_level(struct smu_context *smu,
@@ -2423,7 +2423,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_default_dpm_table = arcturus_set_default_dpm_table,
 	.populate_umd_state_clk = arcturus_populate_umd_state_clk,
 	.get_thermal_temperature_range = arcturus_get_thermal_temperature_range,
-	.print_clk_levels = arcturus_print_clk_levels,
+	.emit_clk_levels = arcturus_emit_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
 	.get_fan_speed_pwm = arcturus_get_fan_speed_pwm,

base-commit: 8bb14fbec5ae45c31cbefe217db2418cc683612f
-- 
2.35.1

