Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498B1D1A427
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Oct 2024 02:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF33B10E1C2;
	Sat, 12 Oct 2024 02:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3clUBqIz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3034C10E1C2
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Oct 2024 02:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmtVmb2vSt3Ak7WVrTDJmPVRPY3alP2OYBdV9ZzB+pm05NWQ+CqMLfyZ883HT6o5rIlG2e3uWx+j6AAl/cLhXuavz3CLewfD/ol2qViq61qezHyGqurjrsuqu0kXPepwIiuv0JnQgJteZw5vQq0qmIoapDSYBodZ7lP0UciJCjTH7zFW3PtNUU5zDBtHD1H1Uy9C9aY+0yQNwOSsPH4H1TXRm7L/k7m17SJgjWdTdzxbVfjn5YeKFZs039FK9rKxFxLgjIsKfFLgQCpQ6upWx1YdnKDchCXwDE3ir1mzQzIqGW0Qeb1FF6yERP62g84bpl39AI/B0cOFWPUXXLtTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh2IhJdKyVC3kHjWOw7qesdvFgrolHyY1qx06+sOWQM=;
 b=SbnGTWsOnPBsXUzl6E2e1qKZ4WetCtVULQaBbWTUdOLuq5LZAqND4fTdIA41+IjnOtdP3qmRAK4JiaicuSg7Xy0AgKI5aNzZN2Ewd/Womj2GPOvQ1POzNhEfWOPZwgUyTUKV/+VeqfvUY182J0jDm54Y8vfBZFXHaKoM9RyFpykwwPYSwwAJDtVsOmx5uaHQh7pA3Pz3DLa22Wd0l81NiKF1ZuxO3YI8Qi18QgTrLwfuSZWEa9f6LJ6QvQPH7u8khrI0uYxMQvjPC3CV7h7+VcIu6fvi6Fza4OKJYZ9NHGgtfR19eY/mEzhNy9bLrcYyOiyHIpxmiLUmWhwQFZ+XfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh2IhJdKyVC3kHjWOw7qesdvFgrolHyY1qx06+sOWQM=;
 b=3clUBqIz1RsSYJ+dySphnca4IV1LA6HKkX00nm/2PQNgzSoBOgwDLFBYzWf8K+E665NyGEZT0NYQX/1KJp/h+3G+qSnem/S26rc3A4rEF1za7q6Lo+ETbMEaEHAjzRPQh3EzvACQBJMW9EObSskqNV8luMeXekWKod35F3A3sBI=
Received: from SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) by SA1PR12MB7410.namprd12.prod.outlook.com
 (2603:10b6:806:2b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 02:00:05 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::b5) by SN6PR2101CA0004.outlook.office365.com
 (2603:10b6:805:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.9 via Frontend
 Transport; Sat, 12 Oct 2024 02:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 02:00:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 21:00:02 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 11 Oct 2024 21:00:00 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update overdrive function on smu 14.0.2/3
Date: Sat, 12 Oct 2024 09:59:58 +0800
Message-ID: <20241012015958.2120967-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 18562589-5079-4d54-13f8-08dcea619740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1alY4Ka+8HCXc/T2EaltHRze+BW/DP28Sqa9NDL8OPvob72JVRmc57Jv+qP1?=
 =?us-ascii?Q?6zCQnpXZG6wr2lIfv+GXxRqkav1jy4sAbBtvMPFQp/Ip2RujG3RRZdnCpWER?=
 =?us-ascii?Q?GRLx3S1XEwXPh/L0KkQdz+L25XlSXJ4yDg+3OYtaLWFquxH2tKzQTyxbQqMI?=
 =?us-ascii?Q?4Xaaald+t8Kl0oMiJSLZyvE0TANT+Dye4YNHP4rLcdMM1snV12xMbEIGS0uz?=
 =?us-ascii?Q?Cp2s2B7OD8mtmgUH0fYDSzZ6fzX4YVEWwdOxEyuV6oPYTHQNHAgQNJCXSBRN?=
 =?us-ascii?Q?CXwxRH3YS73S4U5g5iF0ukQ1gHrviVhzSVtSR0gSg58sYqWMSSUEZihhQp/j?=
 =?us-ascii?Q?dMvKSbsg9dqzorLhfc53ajrpR+UnO01Skm5/LDozehJ5dYS136nPDW++mIvx?=
 =?us-ascii?Q?MSFneKt3zNqx4Ih44Bpm74tH28mvmabX7zcToZkKsYSF8dfcAorwJ+e3ZMYO?=
 =?us-ascii?Q?VoMwpNaVuQHjp6lRqn6xV8YPy0jok/v1/PCCRVq8rR7FqAoJ68LnIC46LsnL?=
 =?us-ascii?Q?MGtMlrt2lqfE7K380ew03zXwDYIw1TpoRkb/aRKVCvheuZX6jyt6OxO3N3AN?=
 =?us-ascii?Q?lNM9gTolw+OiCTwAkCq2Rpz3SS2pQ0/7pFn+udPqzdIOq49vZ7hAQsSp3opO?=
 =?us-ascii?Q?HMkXWpjc9l+z4tWaz+mz94Eipxb6EzqRJVHkPIk2+27/us7yxYfuyw8eyqUK?=
 =?us-ascii?Q?wS6n2ijPcX9wjlMiXBlHvkQ4oMkRRysisgFWzvJpeoA4fYglpqcbzN4wLueA?=
 =?us-ascii?Q?0HwcioYoN0BwBGaOFA9HBrQQ5ZMDugFyIp6esrUhIig2soFrDoxLGSkb7a8u?=
 =?us-ascii?Q?DtdRwKtRedEEnsl+v+fVxiHUXexGlaZ5qeAm9L+UcJ3JzU/XbFIcMufmFun3?=
 =?us-ascii?Q?k3PmmUmv97ixFLiJKhJHvLtPbEac6Gg+luueEF0m7E4nEgVJK0tecZesk0Gx?=
 =?us-ascii?Q?4qzEKeTcKk+j0lvZ07JSrfxTRUGuUxokmcSM6Xwxk763pwp0LhZ56OIMEXXO?=
 =?us-ascii?Q?RUclAQ2YMvQyc/j0R58fCZ42EYiqxLgt5VL+N7xUZWWPbtGOP+cnIv+XGM1W?=
 =?us-ascii?Q?Bn1rnHDJ1HW0jJQT2nkQhKSZLeOvXMMONWdGEmGuTAD3kI9vL8g4uvbk/7G9?=
 =?us-ascii?Q?DtVqMKFPSrvgki5/7YUxc8Zfg4EUoOiBhEPWBhw2bUtBlByixvRpZA3rNOCZ?=
 =?us-ascii?Q?I7Q3bt0kw3/vLiO8VgaCxMEcbOf9it4l5U6jCYGLczQMao5T8Cc6hrugA5jX?=
 =?us-ascii?Q?BHEhaFUzZwkj0ICS/2zP8JmA+JKhQcjeO0OFadgyO1EekSxTDFVsaTcXu/nd?=
 =?us-ascii?Q?rUGYWGaxptEwVzhXZmx1OcHASNdmfTk8CdeXpe6rl2O65/3uMP3QatPEjX9r?=
 =?us-ascii?Q?Lbz9jfc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:00:04.9272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18562589-5079-4d54-13f8-08dcea619740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410
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

update overdrive function on smu 14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 61 ++++++-------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ade3ee398e3d..7c97a4d34377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1064,12 +1064,9 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 
 	switch (od_feature_bit) {
 	case PP_OD_FEATURE_GFXCLK_FMIN:
-		od_min_setting = overdrive_lowerlimits->GfxclkFmin;
-		od_max_setting = overdrive_upperlimits->GfxclkFmin;
-		break;
 	case PP_OD_FEATURE_GFXCLK_FMAX:
-		od_min_setting = overdrive_lowerlimits->GfxclkFmax;
-		od_max_setting = overdrive_upperlimits->GfxclkFmax;
+		od_min_setting = overdrive_lowerlimits->GfxclkFoffset;
+		od_max_setting = overdrive_upperlimits->GfxclkFoffset;
 		break;
 	case PP_OD_FEATURE_UCLK_FMIN:
 		od_min_setting = overdrive_lowerlimits->UclkFmin;
@@ -1256,10 +1253,16 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-					od_table->OverDriveTable.GfxclkFmin,
-					od_table->OverDriveTable.GfxclkFmax);
+		PPTable_t *pptable = smu->smu_table.driver_pptable;
+		const OverDriveLimits_t * const overdrive_upperlimits =
+					&pptable->SkuTable.OverDriveLimitsBasicMax;
+		const OverDriveLimits_t * const overdrive_lowerlimits =
+					&pptable->SkuTable.OverDriveLimitsBasicMin;
+
+		size += sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
+		size += sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n",
+					overdrive_lowerlimits->GfxclkFoffset,
+					overdrive_upperlimits->GfxclkFoffset);
 		break;
 
 	case SMU_OD_MCLK:
@@ -1401,7 +1404,7 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFXCLK_FMAX,
 							  NULL,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "SCLK_OFFSET: %7dMhz %10uMhz\n",
 					      min_value, max_value);
 		}
 
@@ -2145,7 +2148,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
 	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
-	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
+	gpu_metrics->average_mm_activity = max(metrics->AverageVcn0ActivityPercentage,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
@@ -2204,8 +2207,8 @@ static void smu_v14_0_2_dump_od_table(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFmin,
-						     od_table->OverDriveTable.GfxclkFmax);
+	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFoffset,
+						     od_table->OverDriveTable.GfxclkFoffset);
 	dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable.UclkFmin,
 						   od_table->OverDriveTable.UclkFmax);
 }
@@ -2296,10 +2299,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 		memcpy(user_od_table,
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
-		user_od_table->OverDriveTable.GfxclkFmin =
-				user_od_table_bak.OverDriveTable.GfxclkFmin;
-		user_od_table->OverDriveTable.GfxclkFmax =
-				user_od_table_bak.OverDriveTable.GfxclkFmax;
+		user_od_table->OverDriveTable.GfxclkFoffset =
+				user_od_table_bak.OverDriveTable.GfxclkFoffset;
 		user_od_table->OverDriveTable.UclkFmin =
 				user_od_table_bak.OverDriveTable.UclkFmin;
 		user_od_table->OverDriveTable.UclkFmax =
@@ -2428,22 +2429,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 			}
 
 			switch (input[i]) {
-			case 0:
-				smu_v14_0_2_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_FMIN,
-								  &minimum,
-								  &maximum);
-				if (input[i + 1] < minimum ||
-				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmin (%ld) must be within [%u, %u]!\n",
-						input[i + 1], minimum, maximum);
-					return -EINVAL;
-				}
-
-				od_table->OverDriveTable.GfxclkFmin = input[i + 1];
-				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
-				break;
-
 			case 1:
 				smu_v14_0_2_get_od_setting_limits(smu,
 								  PP_OD_FEATURE_GFXCLK_FMAX,
@@ -2456,7 +2441,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 					return -EINVAL;
 				}
 
-				od_table->OverDriveTable.GfxclkFmax = input[i + 1];
+				od_table->OverDriveTable.GfxclkFoffset = input[i + 1];
 				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
 				break;
 
@@ -2466,14 +2451,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 				return -EINVAL;
 			}
 		}
-
-		if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDriveTable.GfxclkFmax) {
-			dev_err(adev->dev,
-				"Invalid setting: GfxclkFmin(%u) is bigger than GfxclkFmax(%u)\n",
-				(uint32_t)od_table->OverDriveTable.GfxclkFmin,
-				(uint32_t)od_table->OverDriveTable.GfxclkFmax);
-			return -EINVAL;
-		}
 		break;
 
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
-- 
2.34.1

