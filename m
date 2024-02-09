Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FC1C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 06:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF9D10ED0C;
	Fri,  9 Feb 2024 06:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQ/QEa2k";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BDC10ED0C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 06:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETG9zw5CATPLtC3jk9HQAq9OybUZPZ8lgE1owesvDJjIHejC7UL7b7/sLWEw5N3TiW8ZMm5QLaDnrj6i05NXUqvFv9PE62+y2tjk3hYdg2aMEAdGqBIy5kXt+4VizrP4g9miccvQ3pZ3KG4iqE+aArOAOZetv0tFtTJ4TaVxnVcogPS3vRlJs3sco7EAWz2AVwrSNxLDdqGIaV6r9Csu65M3fgOFrEFUnkhwi3fKvKKBBTMyurzyt0sa6b2lfU8jGlcGtBlmrWBf3+eQqx4Di5AtMkMEoXM71HXSJHZNctLQhWmt0hwIMlMBQyGohuKaGWhdZUXQQrA2syOLyEL1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV9+EJLPrprR5NQnkDYlU6vIlR+Q3dQ0kIWnyJ8tfgs=;
 b=gCkrB4+9O0RcpEqK1zmH7JHWOZd97rSEPPM960SOOdVKe5Es5+pC8f28TbnxHklmBcql+wx4SkE3ZHdCydiAOWFDblGvpPQ1UCJrg1cZMwlxc9Y1f8nz2S3MBoV9uHB7z6WdY4rBCDdmrCpmUO93JPoIL6qkLT8r8qUeHJspR8bFdPEnQsPYCS+8Qc1AqZy+iGhax5/4oN1JqmSs6FmXrROtLVLPhoAQ7WSU91eS1Ze3E3rf8PfgCkp1/Qj0r71y6uVRXC/Fw4VVKZ+VU5X1M7PDUNmRTlZHSJptVGRGFNJ7M/NeviYfMnnbkf3xBP6nyllaWByMy9fRrekLqBwPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV9+EJLPrprR5NQnkDYlU6vIlR+Q3dQ0kIWnyJ8tfgs=;
 b=EQ/QEa2kvZ/npkSR2OgywMxhOJvZgmR5qkHlumS/iLVTIkJ3MyzEoZEh8rNzm8aJDQNtREyrSj5JG7tOp6h1aHomXJUYb6lAq0AjwC6gR1GgN1xBSpyi8eNt0M4WxvmAtESm+ALESxDxIZ4VSP0+DPNyhx029yRiL+VWGOd+3Ak=
Received: from CY5PR22CA0006.namprd22.prod.outlook.com (2603:10b6:930:16::9)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Fri, 9 Feb
 2024 06:35:38 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::a8) by CY5PR22CA0006.outlook.office365.com
 (2603:10b6:930:16::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 06:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 06:35:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 00:35:02 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amd/pm: Allow setting max UCLK on SMU v13.0.6
Date: Fri, 9 Feb 2024 12:04:46 +0530
Message-ID: <20240209063446.330452-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0fc3e5-e106-4231-98b6-08dc293953f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oskfPW9MJEpNhUC7gM7KaADYM/fNcqfp/kUDIp9Lb8W+6iymxqgdBo65mXOMQMWrQtwu2zoqv9LD+9ActClPr+qJAIWgool+uYsRQ4TLFSDQHPt+GLhqxYh3VkPfVpLUNt0K6QA0HqtadxzESx5eyjAkYcuc0gUJ9nDEhEDms6RUKZHUSggnFKzfvvP9Dx1fSO+nXMtKMrNX+0x9t1RNzX5/MUMBFCDUuxWcL7E1sgfyOjGdURFkYOG87sP7Znzt6hb8NxNxYIbU7ta+dzr+p/xN9pKCdl/D/yhYj0XXbLRzHlmIpl+sPaahWouCvuXrU5ADIuDw3qU7TT8WrSJtmt2i4zhKz2wLkyCN5akC8VSncdWNW/E4py2QR/+zyVC+iFzXHHJhsOcu/LbhfNolyPkg9KuPoHVZSs0xycC3Ae+AzG2VXTHfzqhkAu71XLNnRBhrDooS23dO5hWI2Rkx6H0+REFvwE4cBNRg6Qu73tnWoSWXXaCmc3ZQPZtpIMtRcOehBO2rZkQsXTPBmSRuNifkUW39inwHVjnYQHc49zPpG4lWZBcrhHG+1X+fsYViNfJ4sdplbIALPoBxlhQiK7Yn9bRltP8wdEznhhTosYs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(36756003)(70206006)(7696005)(83380400001)(5660300002)(478600001)(44832011)(26005)(426003)(1076003)(16526019)(2616005)(336012)(70586007)(2906002)(8676002)(4326008)(6916009)(316002)(8936002)(86362001)(356005)(81166007)(54906003)(82740400003)(6666004)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 06:35:37.7178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0fc3e5-e106-4231-98b6-08dc293953f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

Allow reducing max UCLK in MANUAL performance level. New UCLK value
should be less than the max DPM level UCLK level value.

Ex:
echo manual > "/sys/bus/pci/devices/.../power_dpm_force_performance_level"
echo m 1 900 > "/sys/bus/pci/devices/.../pp_od_clk_voltage”
echo c > "/sys/bus/pci/devices/.../pp_od_clk_voltage”

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 103 ++++++++++++++++--
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 03873d784be6..9929981ff6c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1578,6 +1578,8 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	struct smu_13_0_dpm_table *gfx_table =
 		&dpm_context->dpm_tables.gfx_table;
+	struct smu_13_0_dpm_table *uclk_table =
+		&dpm_context->dpm_tables.uclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	int ret;
 
@@ -1604,6 +1606,15 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 
 		pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
 		pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+
+		/* Min UCLK is not expected to be changed */
+		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_UCLK, 0,
+							    uclk_table->max);
+		if (ret)
+			return ret;
+		pstate_table->uclk_pstate.curr.max = uclk_table->max;
+		pstate_table->uclk_pstate.custom.max = 0;
+
 		return 0;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 		return 0;
@@ -1626,7 +1637,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 	uint32_t max_clk;
 	int ret = 0;
 
-	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK)
+	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK &&
+	    clk_type != SMU_UCLK)
 		return -EINVAL;
 
 	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) &&
@@ -1636,18 +1648,31 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 		if (min >= max) {
 			dev_err(smu->adev->dev,
-				"Minimum GFX clk should be less than the maximum allowed clock\n");
+				"Minimum clk should be less than the maximum allowed clock\n");
 			return -EINVAL;
 		}
 
-		if ((min == pstate_table->gfxclk_pstate.curr.min) &&
-		    (max == pstate_table->gfxclk_pstate.curr.max))
-			return 0;
+		if (clk_type == SMU_GFXCLK) {
+			if ((min == pstate_table->gfxclk_pstate.curr.min) &&
+			    (max == pstate_table->gfxclk_pstate.curr.max))
+				return 0;
 
-		ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(smu, min, max);
-		if (!ret) {
-			pstate_table->gfxclk_pstate.curr.min = min;
-			pstate_table->gfxclk_pstate.curr.max = max;
+			ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(
+				smu, min, max);
+			if (!ret) {
+				pstate_table->gfxclk_pstate.curr.min = min;
+				pstate_table->gfxclk_pstate.curr.max = max;
+			}
+		}
+
+		if (clk_type == SMU_UCLK) {
+			if (max == pstate_table->uclk_pstate.curr.max)
+				return 0;
+			/* Only max clock limiting is allowed for UCLK */
+			ret = smu_v13_0_set_soft_freq_limited_range(
+				smu, SMU_UCLK, 0, max);
+			if (!ret)
+				pstate_table->uclk_pstate.curr.max = max;
 		}
 
 		return ret;
@@ -1740,6 +1765,40 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 		break;
+	case PP_OD_EDIT_MCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev,
+				"Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (!smu_cmn_feature_is_enabled(smu,
+						SMU_FEATURE_DPM_UCLK_BIT)) {
+			dev_warn(smu->adev->dev,
+				 "UCLK_LIMITS setting not supported!\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (input[0] == 0) {
+			dev_info(smu->adev->dev,
+				 "Setting min UCLK level is not supported");
+			return -EINVAL;
+		} else if (input[0] == 1) {
+			if (input[1] > dpm_context->dpm_tables.uclk_table.max) {
+				dev_warn(
+					smu->adev->dev,
+					"Maximum UCLK (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
+					input[1],
+					dpm_context->dpm_tables.uclk_table.max);
+				pstate_table->uclk_pstate.custom.max =
+					pstate_table->uclk_pstate.curr.max;
+				return -EINVAL;
+			}
+
+			pstate_table->uclk_pstate.custom.max = input[1];
+		}
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size != 0) {
 			dev_err(smu->adev->dev,
@@ -1750,8 +1809,19 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			min_clk = dpm_context->dpm_tables.gfx_table.min;
 			max_clk = dpm_context->dpm_tables.gfx_table.max;
 
-			return smu_v13_0_6_set_soft_freq_limited_range(
+			ret = smu_v13_0_6_set_soft_freq_limited_range(
 				smu, SMU_GFXCLK, min_clk, max_clk);
+
+			if (ret)
+				return ret;
+
+			min_clk = dpm_context->dpm_tables.uclk_table.min;
+			max_clk = dpm_context->dpm_tables.uclk_table.max;
+			ret = smu_v13_0_6_set_soft_freq_limited_range(
+				smu, SMU_UCLK, min_clk, max_clk);
+			if (ret)
+				return ret;
+			pstate_table->uclk_pstate.custom.max = 0;
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
@@ -1771,8 +1841,19 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			min_clk = pstate_table->gfxclk_pstate.custom.min;
 			max_clk = pstate_table->gfxclk_pstate.custom.max;
 
-			return smu_v13_0_6_set_soft_freq_limited_range(
+			ret = smu_v13_0_6_set_soft_freq_limited_range(
 				smu, SMU_GFXCLK, min_clk, max_clk);
+
+			if (ret)
+				return ret;
+
+			if (!pstate_table->uclk_pstate.custom.max)
+				return 0;
+
+			min_clk = pstate_table->uclk_pstate.curr.min;
+			max_clk = pstate_table->uclk_pstate.custom.max;
+			return smu_v13_0_6_set_soft_freq_limited_range(
+				smu, SMU_UCLK, min_clk, max_clk);
 		}
 		break;
 	default:
-- 
2.25.1

