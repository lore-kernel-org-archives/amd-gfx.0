Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64C9CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC3310F94D;
	Fri, 29 May 2026 06:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q7gMNmjY";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18CC10F94D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dySaGH5g721BH28NvEXZQeFkQvHYMkvSEFqDZHM2qvfl1kIL1+VRU8Ah5yYewbC/4rBbbGQQgyRy/wgKU/AiYBAI0NpJ02Hb/bpXEas9szuoXgZyWLreLet17Gu8zIXW8PCiLVOD+p1xhQYBRYge2/eHUPpts+AvPsYhhsCt/QkLT65RId8knWVBDi0QVrScsMlDv54BgmqJAOJ26J4Z5zN4vFiKg+x67A0jljslJ3qa0x3SwvDcsoqWyxZ91mVQLEb+dcfNGpb7dUUMS/gdZVWgufV28oWn6AMUvKiKzCUhXHl2QvV95EqbOEeJAI7U0tyBWQNYbEV6icyLSu88NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyC8ihgf5AsHqyM9XIin15COcZQfAb7sCgF47kD0GrQ=;
 b=pH11kxDaYa2y26YedIoWDFecru8mvnp4ShSuRnNB10/4ZiLdBEMoGRcJ+2XVQ63a+F/o1uM8IudvaH9OkHD/QL7E0H7fYTv+Mc/TG8ehSpjgnPhIM9wi5kmD7WGIM4oiGHnpSUnHo0uiwOF32cmwew7IO/jqKrHN7NhMtx6Vu6QJ/vMmO0DPn3gCYqb1Sn0j6qnUDXkuuPlQ/Krwwy/F5wHp37VOJvP/vgh/U9fbFk0PZZSgN8ldUzO79/lpL/WN7chG6AeKI2f7Frv7u+NkWVNYxomNtXaFROqI890u3OEAs5FDXEdKmQiBFK7zNv8XrT3y94rNOV4PLGHUEqrlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyC8ihgf5AsHqyM9XIin15COcZQfAb7sCgF47kD0GrQ=;
 b=Q7gMNmjYenRy/6SZs2lEKE1oeFr9miSbOS+itwwFJ0KJ5Dl/OUHEzVEC2kexet1ZxVRgosfMbk8NEcmShM98PwYll9D0M9jP9kM9806uaT9CDRHycPDATtcXxy9yIDSyGsl3EZwOVhSpcnwSteBmrS14q9jlyAvELF4c39/x290=
Received: from BL1PR13CA0360.namprd13.prod.outlook.com (2603:10b6:208:2c6::35)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:19:43 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7d) by BL1PR13CA0360.outlook.office365.com
 (2603:10b6:208:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Fri, 29
 May 2026 06:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 06:19:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:19:40 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: Handle sysfs_emit truncation for smu13 OD
Date: Fri, 29 May 2026 14:19:20 +0800
Message-ID: <20260529061920.357400-4-asad.kamal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: b43f5602-5251-437b-be7f-08debd4a45ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: veqpaUWzXTZzAKOAQek5hWK9DLJ+m8qaCXsB6UbgJ4Vgv/aM933qbaMCEsVxf1TzKG2fMWcu2ap9p0mXJt44K9jg3hj74IRTAnY2eSHEHYNKLwVJnY0xpOdi8SFCrtqK/36LPNoVSTC3nykgbvh340r8WXj/Hqq10+7aJ8jEldimnLSZY59N4L8ffao+M5+lVT+QfLM0K6yR5229FNs7lq8nzTGtYcVUodfAEUbTqIcOA+pxPvX0yavNKQDJGp68LSdC1DqBXVZEy0CBoewREnRXmPDiRQALypcaVZidy9FPNOE5VcoWzBJKaJJchU9RuAMHRUMCUp2ivI1AEMX9drhwGfhe9iUF70MsYtenYwfOSU0XCtw5FdSgipO97/2p8+uMQA9gIl8vOMIrUV4uctXtmPfjcuGHodYJmNQ5NAL2cYtMkkk+1+Kw8mIpWndwAcW1aLHq9HBblAkPYZ1d2aW0JyfyXKIdl/FRizGnK6euaym9GFhvplhyZ64ElPU1Y9s9wrD33DRMBfw5Y2arVdsZZE3Xlt5i4Blfg9oYArzoglJFWEXiu7qB4btwgsI4CEL/MwjmTYARJGQZZRwABCKabtviM1TVdd/H8wwd1Bv3aG63m5qSn4+vCwUVHel5aRfL3zuSMvom9d7gHecsugMX8kOxRyBG0eCdTEpkegiPt5JTB8EZSsOGTkeubWw1Ah35z3raxGj0jFOskUlyKcf36xGizBfc/gG7IMMVptA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WSFBv+l7epM2i0U6jZHekWHPxE5pbLvus9LJiWcais63uNrvMPVuP9OW4lWEQR2jOBWQdTWD14yquSvrJRB0UeiO+6BuwBPA0mTJpnKSVrv9FsL88kyU2oAAf61/udLY89wM1N2V7qRHzeQAsISxcrw9D8uYTwREQ71njVm1TPuF8CM8jWQtt8shGSdBCRKEx7bukEyTulu5aap9e0oChMMJ+erfPjjTlKoL9cE1GKneS7tDEEoIzurohGBxxCJoeLHwsfdU+4cCcCyHTiIJzTVBF4ugXbRzxC+20ynBltCnlhHUSlcQOMRwI/dX79NnaCRuLOSbfHei+HEGuwVjqo7RrZtvnUOTGqoH7IJtJyaK0FJgF4qjEoaFJjWXvX6lCRMcTslCf5xs0DltlJRGWZ3j9XsrUSAGEPrwHhKbGBaVlz1l9U+GgnSpz9RlyrYH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:19:43.1190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43f5602-5251-437b-be7f-08debd4a45ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

Check sysfs_emit_at() in smu_v13_0_0_emit_clk_levels() and
smu_v13_0_7_emit_clk_levels() and stop emitting when the sysfs page is full

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 263 +++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 251 ++++++++++++-----
 2 files changed, 376 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 30d9cfac0d89..fa91837f7024 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1206,7 +1206,7 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
-	int i, curr_freq, size = *offset, start_offset = *offset;
+	int i, curr_freq, size = *offset, start_offset = *offset, n;
 	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
@@ -1265,10 +1265,16 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-					od_table->OverDriveTable.GfxclkFmin,
-					od_table->OverDriveTable.GfxclkFmax);
+		n = sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  od_table->OverDriveTable.GfxclkFmin,
+				  od_table->OverDriveTable.GfxclkFmax);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_MCLK:
@@ -1276,10 +1282,16 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_UCLK_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
-					od_table->OverDriveTable.UclkFmin,
-					od_table->OverDriveTable.UclkFmax);
+		n = sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
+				  od_table->OverDriveTable.UclkFmin,
+				  od_table->OverDriveTable.UclkFmax);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_VDDGFX_OFFSET:
@@ -1287,9 +1299,15 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFX_VF_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
-		size += sysfs_emit_at(buf, size, "%dmV\n",
-				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
+		n = sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%dmV\n",
+				  od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_CURVE:
@@ -1297,27 +1315,43 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_FAN_CURVE:\n");
-		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++)
-			size += sysfs_emit_at(buf, size, "%d: %dC %d%%\n",
-						i,
-						(int)od_table->OverDriveTable.FanLinearTempPoints[i],
-						(int)od_table->OverDriveTable.FanLinearPwmPoints[i]);
+		n = sysfs_emit_at(buf, size, "OD_FAN_CURVE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			n = sysfs_emit_at(buf, size, "%d: %dC %d%%\n",
+					  i,
+					  (int)od_table->OverDriveTable.FanLinearTempPoints[i],
+					  (int)od_table->OverDriveTable.FanLinearPwmPoints[i]);
+			if (!n)
+				goto out;
+			size += n;
+		}
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_CURVE_TEMP,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_CURVE_PWM,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 
 		break;
 
@@ -1326,17 +1360,29 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
-
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
+		if (!n)
+			goto out;
+		size += n;
+
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_ACOUSTIC_TARGET:
@@ -1344,17 +1390,29 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
-
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
+		if (!n)
+			goto out;
+		size += n;
+
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ACOUSTIC_TARGET,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_TARGET_TEMPERATURE:
@@ -1362,17 +1420,29 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanTargetTemperature);
-
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanTargetTemperature);
+		if (!n)
+			goto out;
+		size += n;
+
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_MINIMUM_PWM:
@@ -1380,17 +1450,29 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanMinimumPwm);
-
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanMinimumPwm);
+		if (!n)
+			goto out;
+		size += n;
+
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_ZERO_RPM_ENABLE:
@@ -1398,17 +1480,29 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_ZERO_FAN_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanZeroRpmEnable);
-
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanZeroRpmEnable);
+		if (!n)
+			goto out;
+		size += n;
+
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
@@ -1416,17 +1510,29 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_ZERO_FAN_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanZeroRpmStopTemp);
-
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+		if (!n)
+			goto out;
+		size += n;
+
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_RANGE:
@@ -1435,7 +1541,10 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 
 		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
 			smu_v13_0_0_get_od_setting_limits(smu,
@@ -1446,8 +1555,11 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFXCLK_FMAX,
 							  NULL,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-					      min_value, max_value);
+			n = sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+					  min_value, max_value);
+			if (!n)
+				goto out;
+			size += n;
 		}
 
 		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
@@ -1459,8 +1571,11 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_UCLK_FMAX,
 							  NULL,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
-					      min_value, max_value);
+			n = sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
+					  min_value, max_value);
+			if (!n)
+				goto out;
+			size += n;
 		}
 
 		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
@@ -1468,8 +1583,11 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFX_VF_CURVE,
 							  &min_value,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
-					      min_value, max_value);
+			n = sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
+					  min_value, max_value);
+			if (!n)
+				goto out;
+			size += n;
 		}
 		break;
 
@@ -1489,6 +1607,7 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 						    curr_freq, buf, offset);
 	}
 
+out:
 	*offset += size - start_offset;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d253ce367476..25f977a42a1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1216,7 +1216,7 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
-	int i, curr_freq, size = *offset, start_offset = *offset;
+	int i, curr_freq, size = *offset, start_offset = *offset, n;
 	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
@@ -1275,10 +1275,16 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-					od_table->OverDriveTable.GfxclkFmin,
-					od_table->OverDriveTable.GfxclkFmax);
+		n = sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  od_table->OverDriveTable.GfxclkFmin,
+				  od_table->OverDriveTable.GfxclkFmax);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_MCLK:
@@ -1286,10 +1292,16 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_UCLK_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
-					od_table->OverDriveTable.UclkFmin,
-					od_table->OverDriveTable.UclkFmax);
+		n = sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
+				  od_table->OverDriveTable.UclkFmin,
+				  od_table->OverDriveTable.UclkFmax);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_VDDGFX_OFFSET:
@@ -1297,9 +1309,15 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFX_VF_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
-		size += sysfs_emit_at(buf, size, "%dmV\n",
-				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
+		n = sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%dmV\n",
+				  od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_CURVE:
@@ -1307,27 +1325,43 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_FAN_CURVE:\n");
-		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++)
-			size += sysfs_emit_at(buf, size, "%d: %dC %d%%\n",
-						i,
-						(int)od_table->OverDriveTable.FanLinearTempPoints[i],
-						(int)od_table->OverDriveTable.FanLinearPwmPoints[i]);
+		n = sysfs_emit_at(buf, size, "OD_FAN_CURVE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			n = sysfs_emit_at(buf, size, "%d: %dC %d%%\n",
+					  i,
+					  (int)od_table->OverDriveTable.FanLinearTempPoints[i],
+					  (int)od_table->OverDriveTable.FanLinearPwmPoints[i]);
+			if (!n)
+				goto out;
+			size += n;
+		}
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_CURVE_TEMP,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_CURVE_PWM,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 
 		break;
 
@@ -1336,17 +1370,29 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
+		n = sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
+		if (!n)
+			goto out;
+		size += n;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_ACOUSTIC_TARGET:
@@ -1354,17 +1400,29 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
+		n = sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
+		if (!n)
+			goto out;
+		size += n;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ACOUSTIC_TARGET,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_TARGET_TEMPERATURE:
@@ -1372,17 +1430,29 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanTargetTemperature);
+		n = sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanTargetTemperature);
+		if (!n)
+			goto out;
+		size += n;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_MINIMUM_PWM:
@@ -1390,17 +1460,29 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_FAN_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanMinimumPwm);
+		n = sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanMinimumPwm);
+		if (!n)
+			goto out;
+		size += n;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_ZERO_RPM_ENABLE:
@@ -1408,17 +1490,29 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_ZERO_FAN_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanZeroRpmEnable);
+		n = sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanZeroRpmEnable);
+		if (!n)
+			goto out;
+		size += n;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
@@ -1426,17 +1520,29 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_ZERO_FAN_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
-		size += sysfs_emit_at(buf, size, "%d\n",
-					(int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+		n = sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "%d\n",
+				  (int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+		if (!n)
+			goto out;
+		size += n;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
 						  &min_value,
 						  &max_value);
-		size += sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
-				      min_value, max_value);
+		n = sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
+				  min_value, max_value);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 
 	case SMU_OD_RANGE:
@@ -1445,7 +1551,10 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
 
 		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
 			smu_v13_0_7_get_od_setting_limits(smu,
@@ -1456,8 +1565,11 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFXCLK_FMAX,
 							  NULL,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-					      min_value, max_value);
+			n = sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+					  min_value, max_value);
+			if (!n)
+				goto out;
+			size += n;
 		}
 
 		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
@@ -1469,8 +1581,11 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_UCLK_FMAX,
 							  NULL,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
-					      min_value, max_value);
+			n = sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
+					  min_value, max_value);
+			if (!n)
+				goto out;
+			size += n;
 		}
 
 		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
@@ -1478,8 +1593,11 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFX_VF_CURVE,
 							  &min_value,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
-					      min_value, max_value);
+			n = sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
+					  min_value, max_value);
+			if (!n)
+				goto out;
+			size += n;
 		}
 		break;
 
@@ -1499,6 +1617,7 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 						    curr_freq, buf, offset);
 	}
 
+out:
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.46.0

