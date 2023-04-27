Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E187C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851E110EAA6;
	Thu, 27 Apr 2023 06:28:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B461F10EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edWeFA7fxNW2KfS1Opy3OCto/ECO4zP7Vnwor0tvgoYQzZ/+7lzDGhptsaLaUm1pbVHVVIQM5xcktBi3lcDCib78zrQYYNozaOx2V/pXxPqEP+W4GnT2F310HXJFYQqNOz6atxG82ukGpdI8R+XOz8uxzWvBDgN3gZI7qr6dZbla77US/wWQ0iGkHKhoslglKpXV+/t2XXSWItpqnZuyQO2MJHvmWbh+70JadYwkgRndtbfveFhI2Up533jKyBcuEjkFBnZ+9CRzp9KVdqbnJ6kuMFoE9Dg+CHSnmLqKSb2rjZW+QJAmkoM1jsX9jYuuYcguWAI2u5fH3WOK6ErELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW+lMGu48M2lzRzK957XyJm0U4NUlHCrCV+VTgNffw8=;
 b=l0vlxjmFUbWBXVFfCpsQxoakSIzJ3wP/UgyELSnQkOTqy6TEfD8ZeTNnJvO+ScJC1XiSZ7vIlKgH7MphsUG0F16WmJcZtqYr4Wrphg3iHdceV1zUf1e1QLTmhbP5igNrKN5DfzVNwjYrhQj7B48XhugabbLsJZiMQgiknM5WOqTf8Z1lfb/z/sbqwHbVeyT6PtZixEDgeHX4ilyvb5qHqpold3nkjT1jWIAHmcQBcQjpjB/CYuOO1//AN6nOJUFAUP8PstVDiCnGSuK4X3aqdFuJos+jq75+xXXbWi1Bo9R1a6kl3WufH1vMUuQB9FJustR+6Nd25FQ7FTYUQnwT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW+lMGu48M2lzRzK957XyJm0U4NUlHCrCV+VTgNffw8=;
 b=kkgY9EOrBGyaMA2cii0Vfz4DSlWRn1M0DWFAplrcmwlICgFc/O8FPsBX6adcktkfzB5bA/JU7CAU14jJmUIRIcf7ZnPwYSenb7VdWlUTsjfyi6V1/yEshcg98ANC3mdzwlAXYFuFuP3wdjGlHltnf2yd8pAYrJCYe+lH2PClq5U=
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Thu, 27 Apr
 2023 06:27:53 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::4d) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:53 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:51 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] amdgpu/pm: Optimize emit_clock_levels for aldebaran -
 part 1
Date: Thu, 27 Apr 2023 02:27:16 -0400
Message-ID: <20230427062718.1172269-7-darren.powell@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f960d1-bb47-441d-27e2-08db46e88828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9gaKTqfxnFaF20TWa5hHL7czZp2fT+9SijiUOTA3VgWin7jZ6bQAWSDAEH15a6vCNtYwq6f0KRKwbpjyltgMEic+MWKBSWDVN26off+g4G2mWCs45xQFDLp/R8dhJ8iyE7wlcCOFUe5g32TapxNTtRYtAkDrSClmi3dTCyYGn7+lbmSxrcj3GDMfhdeHEfDPe0GQdmZwWmUrlGpzG3Nk9PYYLrDV39c6npp3b/pNZyjcN08g1tUxRllj38TDnEs40h1YCwTJZJojg978yHr+5TYZjT7+kA0yPHc+YdJMxbWbNtJjCCrygcgFoHMJLKkUCbAq5AA2GBJY/ys/WWY8EuTASChXi3jfpYpZ5LRtZJegIIWodoir31Pv1UbY412KfliVF3htLz69Vd2vcZkkWYBF2T0YBBH5+Ok84Ca6ft1mrmCCTpc4ridzyp0L0/IWvowuM2R3cMNIlncY0CMsx4wVPYXLZQLt6diif/mjMbDXCg41JMoz6nWP5a9mDk+uvZlcr0Xv6eZOBk8q+YSRYtczzx/Y92AP+/LGBJguZBx6yJg0o2swhqeme59ym4ls5WigcfQNIqlUD+O03gWlinFwWwfVd3Lo8pSXctDh6mrBCSQO9aQrH5/jYCSSr8D68hIJFPFlmw3c48KLS7iGhUxDFqyrHABwj5ybLa8QImQBoJB4Tw1/ZiNowhp8QU7cr8fhkCktU9H4gutd2RQR+DHc6AX5Tzp6pQ9+2hRJ88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(44832011)(8936002)(54906003)(70206006)(81166007)(6916009)(478600001)(86362001)(70586007)(82310400005)(2906002)(41300700001)(316002)(6666004)(4326008)(7696005)(5660300002)(26005)(1076003)(186003)(82740400003)(47076005)(356005)(16526019)(40460700003)(336012)(40480700001)(426003)(2616005)(36756003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:53.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f960d1-bb47-441d-27e2-08db46e88828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
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

 Use variables to remove the multiple nested ternary expressions
 and improve readability. This will help to optimize the code
 duplication in the switch statement
 Also Changed:
  Modify function aldebaran_get_clk_table to void function as it
    always returns 0
  Use const string "attempt_string" to cut down on repetition

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 125 ++++++++----------
 1 file changed, 57 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f93a50217239..75833bc3d4c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -551,9 +551,9 @@ static int aldebaran_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static int aldebaran_get_clk_table(struct smu_context *smu,
-				   struct pp_clock_levels_with_latency *clocks,
-				   struct smu_13_0_dpm_table *dpm_table)
+static void aldebaran_get_clk_table(struct smu_context *smu,
+				    struct pp_clock_levels_with_latency *clocks,
+				    struct smu_13_0_dpm_table *dpm_table)
 {
 	uint32_t i;
 
@@ -567,7 +567,6 @@ static int aldebaran_get_clk_table(struct smu_context *smu,
 		clocks->data[i].latency_in_us = 0;
 	}
 
-	return 0;
 }
 
 static int aldebaran_freqs_in_same_level(int32_t frequency1,
@@ -749,6 +748,9 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	int display_levels;
 	uint32_t freq_values[3] = {0};
 	uint32_t min_clk, max_clk, cur_value = 0;
+	bool freq_match;
+	unsigned int clock_mhz;
+	static const char attempt_string[] = "Attempt to get current";
 
 	if (amdgpu_ras_intr_triggered()) {
 		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
@@ -765,16 +767,12 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
+			dev_err(smu->adev->dev, "%s gfx clk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 
 		display_levels = (clocks.num_levels == 1) ? 1 : 2;
 
@@ -791,15 +789,16 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 			freq_values[1] = cur_value;
 		}
 
-		for (i = 0; i < display_levels; i++)
+		for (i = 0; i < display_levels; i++) {
+			clock_mhz = freq_values[i];
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-				freq_values[i],
+				clock_mhz,
 				(display_levels == 1) ?
 					"*" :
-					(aldebaran_freqs_in_same_level(
-						 freq_values[i], cur_value) ?
-						 "*" :
-						 ""));
+					(freq_match) ? "*" : "");
+		}
 
 		break;
 
@@ -809,116 +808,106 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
+			dev_err(smu->adev->dev, "%s mclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get memory clk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < clocks.num_levels; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clocks.data[i].clocks_in_khz / 1000,
+					i, clock_mhz,
 					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+					(freq_match) ? "*" : "");
+		}
 		break;
 
 	case SMU_SOCCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
+			dev_err(smu->adev->dev, "%s socclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get socclk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < clocks.num_levels; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clocks.data[i].clocks_in_khz / 1000,
+					i, clock_mhz,
 					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+					(freq_match) ? "*" : "");
+		}
 		break;
 
 	case SMU_FCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
+			dev_err(smu->adev->dev, "%s fclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get fclk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < single_dpm_table->count; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < single_dpm_table->count; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+					(freq_match) ? "*" : "");
+		}
 		break;
 
 	case SMU_VCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			dev_err(smu->adev->dev, "%s vclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < single_dpm_table->count; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < single_dpm_table->count; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+					(freq_match) ? "*" : "");
+		}
 		break;
 
 	case SMU_DCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			dev_err(smu->adev->dev, "%s dclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+
+		for (i = 0; i < single_dpm_table->count; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
 
-		for (i = 0; i < single_dpm_table->count; i++)
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+					(freq_match) ? "*" : "");
+		}
 		break;
 
 	default:
-- 
2.34.1

