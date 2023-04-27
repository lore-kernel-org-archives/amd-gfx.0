Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB160C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A38910EA7B;
	Thu, 27 Apr 2023 06:27:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648A510EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8LsQyOWbuf4e3cAObfAKGQot/o6MNgprEs4Lu/5wcg3HBMEBZhDFU8er9yFmXlsieYAUWMmUJpG3IQRdCijHTPxjUrZmBHHCDpXiflX4f8ZohxNSa9CuTaH5C9PmlL0XU2VjmxI3vM1WUP7byoG/+V8vyifrBRSmjau4VZHYDYFlMykXeh8n6Vo8XOkWsuKQ6ve3gdPkoY5lZT0rbb4M+xbhxTzt8QdgbtlFk2krjt1JSwpB12/AS4IW9RIIq1ay+yGgcJijhgNBsUqxLPp95RcJigGDKeDAgRUzeh4vNweMXoaVh3d3pMtgMJHC8/WkUl/2FeE2GldZXR8F2bmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfkuAeQrgdqmgtC/3mR3BNi4MGlLrh8s2f1+aKiGP1Q=;
 b=lloOh+1lO6qzNsMGPJczelP/y4A0eyLMAbz2zUQMzGalYem5OBAhO1ZfhQuFvXNDDQA5DW1esZUN2N5eNEHjqVVoYIP7s0QLFJxVoSHVGnSb3GCbCIdjuMQ1GIFbfj0n+ejuvgZm5JzzaJ0fh3O7IZ1B+YZLPLsFXlvClWUUav2K01tQDeK3OXcVZqLBncIt+8vbULWAHxr88pNAbg/CaG9h8zfIX5aCF+HXnDLGOholGL6ec9qwh1AVjWZ6e32rN4YVyAyc8BFl6wYNkHjr5BMZ722L/1mUH/1AnbKcbNkjqROotAFwLpvzN5FtnUHXAQI61jnKWNJ8+04sq8IqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfkuAeQrgdqmgtC/3mR3BNi4MGlLrh8s2f1+aKiGP1Q=;
 b=pYd2EfPXxFeGlqOnLUw/gOOCluxTi2zjOYrZ0VLKJEkuy/+q397YVVlKskMwSlaJ/0G0lLjjsLLKJiXvPm5sDXrfUk8zVlO1syNbXfaNQwqv17qzuKAdi4JFU7+AvWkx8SwAOUdSu7DkBN0Pmjxf5bx3rfC3Duo9GDFyQJzm3Wc=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 06:27:51 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::36) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:51 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:49 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] amdgpu/pm: Optimize emit_clock_levels for arcturus - part
 1
Date: Thu, 27 Apr 2023 02:27:12 -0400
Message-ID: <20230427062718.1172269-3-darren.powell@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: c806035b-f63c-44bb-d5ee-08db46e8872d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSLnRYZiGEL0HrcivrBgtD790norkch+ErllKLU71URX7jhNq4PXSvdXQNRArCxPWJiucnDvveBtAwZrjVZkdxqvlTdQmhcYzvq2ufYB2AoIE3g/JT8Qhl79dLP+dL43bks6z1PcnDrLc8+jKoz64cOvaQuUKa5ha1wfCo0g4n2+H+wbil+TkTBVxhrt+apD9y51yqzdz7K6xhIyeeQE8b82l99PZ7nKs1JhWIpqvgXVuEXQYNBeymBHOT8gYVTLkv5HOh3OPP1numuZjNcYUleup8UnTKI8bbRUu5BN5juh3seYEs4Cu+XrUB8L2/QNQV5jvxvYa8uc5wjRYXDJ1ReSj0EBNh+DCaUANQdylYlKZE8tEjGGji+440P225nkTXpVNDXxgU29MzIlE7e5Cof6PwrggxUTW3Le0EUPa4kggZUun6I35zhEimIsTLtkP/PRg3e7PUbicuRUTh7c6vZKXDt/MrLAZf5qQRYs9juBsQyW/9TftUd+mBT5SRkrNYO9KQLkqKZ3j9gUYIYzqSrcTGvFY4T7e9gpCU3ui0ITFli8XDb7aIPYt2vU8gKJWsE7u65bxhcj0qYM03FXYDCB4hIbjEUwV8YfaOSbxKCC36OPplgb8MFMfYTthKe9Ec57D8JNw4MIjC7yspkgzatNerEj9oKZecMvzvANj0OGuGJhJQrmMHjFQM/EUxVvgEsOYsRMV//R2qJ0Rh22O0OJGeF+ZOekh7eRrgssFL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(316002)(4326008)(6916009)(40460700003)(70586007)(70206006)(54906003)(7696005)(6666004)(82310400005)(40480700001)(86362001)(36756003)(478600001)(16526019)(186003)(1076003)(26005)(36860700001)(5660300002)(2616005)(81166007)(41300700001)(356005)(426003)(336012)(44832011)(2906002)(47076005)(83380400001)(82740400003)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:51.6873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c806035b-f63c-44bb-d5ee-08db46e8872d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
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

 Use variables to remove the multiple nested ternary expressions and
 improve readability. This will help to optimize the code duplication
 in the switch statement
 Also Changed:
  Modify function arcturus_get_clk_table to void function as it
    always returns 0
  Use const string "attempt_string" to cut down on repetition

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 126 ++++++++----------
 1 file changed, 57 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 0136e136e807..23e768aad6f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -569,9 +569,9 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static int arcturus_get_clk_table(struct smu_context *smu,
-			struct pp_clock_levels_with_latency *clocks,
-			struct smu_11_0_dpm_table *dpm_table)
+static void arcturus_get_clk_table(struct smu_context *smu,
+				   struct pp_clock_levels_with_latency *clocks,
+				   struct smu_11_0_dpm_table *dpm_table)
 {
 	uint32_t i;
 
@@ -584,8 +584,6 @@ static int arcturus_get_clk_table(struct smu_context *smu,
 			dpm_table->dpm_levels[i].value * 1000;
 		clocks->data[i].latency_in_us = 0;
 	}
-
-	return 0;
 }
 
 static int arcturus_freqs_in_same_level(int32_t frequency1,
@@ -767,7 +765,9 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 	struct smu_11_0_dpm_context *dpm_context = NULL;
 	uint32_t gen_speed, lane_width;
 	uint32_t i, cur_value = 0;
-
+	bool freq_match;
+	unsigned int clock_mhz;
+	static const char attempt_string[] = "Attempt to get current";
 
 	if (amdgpu_ras_intr_triggered()) {
 		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
@@ -780,143 +780,131 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
+			dev_err(smu->adev->dev, "%s gfx clk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
-			return ret;
-		}
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
 		/*
 		 * For DPM disabled case, there will be only one clock level.
 		 * And it's safe to assume that is always the current clock.
 		 */
-		for (i = 0; i < clocks.num_levels; i++)
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-					clocks.data[i].clocks_in_khz / 1000,
+					clock_mhz,
 					(clocks.num_levels == 1) ? "*" :
-					(arcturus_freqs_in_same_level(
-					clocks.data[i].clocks_in_khz / 1000,
-					cur_value) ? "*" : ""));
+						(freq_match ? "*" : ""));
+		}
 		break;
 
 	case SMU_MCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
+			dev_err(smu->adev->dev, "%s mclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get memory clk levels Failed!");
-			return ret;
-		}
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < clocks.num_levels; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
+				i, clock_mhz,
 				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+					(freq_match ? "*" : ""));
+		}
 		break;
 
 	case SMU_SOCCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
+			dev_err(smu->adev->dev, "%s socclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get socclk levels Failed!");
-			return ret;
-		}
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < clocks.num_levels; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
+				i, clock_mhz,
 				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+					(freq_match ? "*" : ""));
+		}
 		break;
 
 	case SMU_FCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
+			dev_err(smu->adev->dev, "%s fclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get fclk levels Failed!");
-			return ret;
-		}
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < single_dpm_table->count; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < single_dpm_table->count; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+					(freq_match ? "*" : ""));
+		}
 		break;
 
 	case SMU_VCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			dev_err(smu->adev->dev, "%s vclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
-			return ret;
-		}
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < single_dpm_table->count; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < single_dpm_table->count; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+					(freq_match ? "*" : ""));
+		}
 		break;
 
 	case SMU_DCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			dev_err(smu->adev->dev, "%s dclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
-			return ret;
-		}
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < single_dpm_table->count; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < single_dpm_table->count; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+					(freq_match ? "*" : ""));
+		}
 		break;
 
 	case SMU_PCIE:
-- 
2.34.1

