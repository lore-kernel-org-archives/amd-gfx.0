Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D3C48297
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 07:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0BC10E8E4;
	Fri,  9 Feb 2024 07:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5kYrX8Nw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B25410E8E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 07:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/orNNX4tgK7mN5iChKQkFkIYdreH0ogj8towFpG1udLa0IGnXuvZLmPp2MzrHwLdy8d7i4ZJ0PkEXhH341RRLxF6ZZBRJsX4DcqsHkdOHHturTYKrZc1BeTejIJRm6fm2aprrb2l8V/PbDX91U4Cyd50WQzW2gRpnIdKeFwSWC9SmiZ1Vw1hOESy5L0rJjwNLwxRiAJV7th//lMphpL38XWrFfKBh53gCUuTj7wd7Xh8iCMyEKyR07h7938VlEZS5bnb0i6lqEtfcK/FpfnHIuwMhnyd1V3c3gFzkYNAaOeb3kGfkscfWvvlL4whbgPTnNmdWwIcy31oEO3/ITwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21D0oYfB5YA+z1j+WglLIkk9livRgB90KSVfOCaCuL8=;
 b=TmEBqnCEL+WojeJib6EcfCMnMlFSku/ntJeoQL7XC8VIio0vN8lX94Fu45vO7OjimP2UghUp4bw/ifsiqX2Swqi6Vza6lSF+LQexu0s+wYbFO7oe+SJn0QPhrxZYwMQ/1327gUhQB9isNU/4318PsDIBj5B4Nl2wJpfr7po2dkv1Wkjt9V5kIivEGBdQMM3oHVEpb+WA6xgYocun9NeSjAt/iyn4Gq0yMrghXcpCLOkb5b6taGQ/BCyMoWozcRAVtHBgcvWALv80QHxRwM9t8sc2XfvcSUonxVkGBxG7ytCqArKfTv1OzZhNRVC8nAWMuBfZ07Sup2yOXt5DwyGjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21D0oYfB5YA+z1j+WglLIkk9livRgB90KSVfOCaCuL8=;
 b=5kYrX8NwDNoFCpESzIo98dScQMYXaPvCUyK0qbDdnYYV463TvqgMfPOcc5JHJIjXTvpH0hcrJ8SWNbU6JyofpszCpEQVskEOx+BFzt3crWi2hQ4BWVGbn8HuRnOUn/VOPkqEYbhEKJxURQIt5I1pJHWc3708pOAl9lzZrIYgGFU=
Received: from SN6PR01CA0005.prod.exchangelabs.com (2603:10b6:805:b6::18) by
 SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.23; Fri, 9 Feb
 2024 07:50:59 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::87) by SN6PR01CA0005.outlook.office365.com
 (2603:10b6:805:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 07:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 07:50:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 01:50:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v2] drm/amd/pm: Allow setting max UCLK on SMU v13.0.6
Date: Fri, 9 Feb 2024 13:20:39 +0530
Message-ID: <20240209075039.1887-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: df1b8ad3-a776-4749-a521-08dc2943daa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nomiEZxGUvZn+JVY4akAtzqXk4uaSKvVVGw3h24wgWjL4g0+4L37OECpRDUqu8DqKMT6yIpAEAXVBdiRqU4sBYbduEL5YVT8o8B3s8qv8CW1wfXHXBAgsi5jjfjfDnnRoNSTBbH8nqejuq5ZL2LU9zLjtKkTJvJXgeyPHKOuU1NUO7CRKLiI4SKcGmcH8uKKnbG8SOSKy8QIrog/6BFhGKCKsGqbSET3W5CD/9Xqi70OeSVAAZOebIUdwVabI2qg0etW9cnBC7tmRheuTKgqkvjmv+h31qJnV7z5iv2LLB/ut5tWEcZJcXkcvM0sfq/+FyoBNSFXCvy93hveq7dkYIktsMTlworAbnDpHdPDaiWHiSjTD6wgB0Tu5obgzh+jTNknnAW4/+blEoUQ9XVACV63lcTKnTeaGoXiqWXBNVjdLlfaDjpjCGnOeTa066xee1XlmxB338IMBnr0P8ZeXQnWeU3aF1X6mUFGGByUsajazBEJM/ZscdblunybV7MdoUX8EsLUOYcUSsbC/9xy8K1rAWSnMT3yMacMc+c/kefY/yg4BYYSBgyPl5PN9sqXc3c9Liosw8pWxQddjMvr6fbPHzv9b96Q66hXowWoF78=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(478600001)(7696005)(41300700001)(54906003)(2906002)(44832011)(5660300002)(316002)(6916009)(36756003)(70206006)(6666004)(70586007)(8676002)(356005)(8936002)(4326008)(2616005)(336012)(86362001)(26005)(83380400001)(16526019)(1076003)(426003)(81166007)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 07:50:58.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1b8ad3-a776-4749-a521-08dc2943daa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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
v2:
	On switching perf level to auto, restore GFX and UCLK levels only if needed.

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 122 +++++++++++++++---
 1 file changed, 102 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 03873d784be6..6e8a7eb1864d 100644
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
 
@@ -1593,17 +1595,27 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 		return 0;
 
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		if ((gfx_table->min == pstate_table->gfxclk_pstate.curr.min) &&
-		    (gfx_table->max == pstate_table->gfxclk_pstate.curr.max))
-			return 0;
+		if ((gfx_table->min != pstate_table->gfxclk_pstate.curr.min) ||
+		    (gfx_table->max != pstate_table->gfxclk_pstate.curr.max)) {
+			ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(
+				smu, gfx_table->min, gfx_table->max);
+			if (ret)
+				return ret;
 
-		ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(
-			smu, gfx_table->min, gfx_table->max);
-		if (ret)
-			return ret;
+			pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
+			pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+		}
+
+		if (uclk_table->max != pstate_table->uclk_pstate.curr.max) {
+			/* Min UCLK is not expected to be changed */
+			ret = smu_v13_0_set_soft_freq_limited_range(
+				smu, SMU_UCLK, 0, uclk_table->max);
+			if (ret)
+				return ret;
+			pstate_table->uclk_pstate.curr.max = uclk_table->max;
+		}
+		pstate_table->uclk_pstate.custom.max = 0;
 
-		pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
-		pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
 		return 0;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 		return 0;
@@ -1626,7 +1638,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 	uint32_t max_clk;
 	int ret = 0;
 
-	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK)
+	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK &&
+	    clk_type != SMU_UCLK)
 		return -EINVAL;
 
 	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) &&
@@ -1636,18 +1649,31 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
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
@@ -1740,6 +1766,40 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
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
@@ -1750,8 +1810,19 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
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
@@ -1771,8 +1842,19 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
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

