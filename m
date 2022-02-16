Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A62C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 20:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21DB10E3DD;
	Wed, 16 Feb 2022 20:04:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478F410E3DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 20:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftdTdiMX+Ew283HsIOe9uzR8OQaEVPGmaf4jd3fy6MDruFsSMrAYwiyxexaNMuygZK5l8DuopAfhQojFDShbQNdKdrGFbYysbpvl1oEIm4ozQTm86Rfxyx+agYiM7fULC2C8vimWDNEoCVdbMgYoKgn4kIWz7ly9UoOAEMl04j5K7gQrLsWsXqXUhI9nDzYxRrbcyKKmzQYYSf1B6qSYarc2NGk1BKmE5Yq43EswZ/Tn+3jLWq+rODTFHZ5mRQwHAYZDE7B9WEhl7Ouo48rvhlwMGrfJIyiEtHmbci7cYkLOi9Y0CxzxFoLpamaeQjrLvLrHJmN+FyHEABEIX+LR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ1F0mgC2yePiUK3gSklYuAG8lLMyvGUhLwl2bzzMcc=;
 b=dtYSxkQEhE0HwhcIUSszJu+tUy38zDpD4TcLxVdVUGuUP7D8iZE2wHlN1QEWRB996bkdBPH422hqwlOEIasra4RgK5T1ZBN/s6RShuT1Igluh02bEnEUHWwRwadlWZXcAqsGhpOdLFydQMfaeCn3V7VKCxdkdshcQFLA3hXn1yyNGRuW3Vp1KNlmPSYyI6cibu1gyrReMZ2FVJZoNz0W6rQ6PmfBoAXj5e/A6pNGmLwecgvwUP7UIeTvSvNydNDq/KA5OXgl8/X4sJIG3ahUoxeSSESLs9Pzy7fKhUW31jzvG5XYQueu/MQzOewv4dw8Mv1JH4e4I/KqgSwIUYThWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ1F0mgC2yePiUK3gSklYuAG8lLMyvGUhLwl2bzzMcc=;
 b=BhZKQqFsVkAXfUExrd6+vie4RT4jE6JARUBYCPDlnRi3r8wJywrix3Tn9X3INO+rNvIr22Sx951MHJtZy4xMYNv85pf5DIlEwOuElam5m2YebuPNrT+73Dcs1l6St45liUHa33Ka77oD2bzLzwDDfeE/pOj3jdwR6YMkRQxcwKE=
Received: from CO2PR04CA0181.namprd04.prod.outlook.com (2603:10b6:104:5::11)
 by BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 20:04:06 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::48) by CO2PR04CA0181.outlook.office365.com
 (2603:10b6:104:5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Wed, 16 Feb 2022 20:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Wed, 16 Feb 2022 20:04:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 14:04:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add gc 10.3.6 support
Date: Wed, 16 Feb 2022 15:03:51 -0500
Message-ID: <20220216200351.2693247-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d032cb6-c4ac-44a7-978d-08d9f1877c22
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3587FE26B502D537761C0DC9F7359@BN8PR12MB3587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1T8TC0kscflnWszgoRPxNS01AvuIeAbBIEmD9olo5hlcCOMcglKFzkOWdoeADlfaiFtbZH/Vv2shur+fje3xw4FOwNzrf8bUdm2/IIt7g8iOglWNVwPFm4yy8hgqTGiiC6htLyD/S3b1bjjVKRpe9G6dSDiFWEjyHJ9K/XUkflAezriqxiD9pa5msPsIkIJroSGHETNpKHNSflyceBBU5EehhpJle+7mjUn+IxHmNHg4dXv4k61qWspZB5pZh4sGcX15ZULwkhB30ORyJaW26i3VvVguBi8Bo5MTHzozzdNoclbB9QCrjdRdlZwCpDVUpGq/YwetL95lbnEjz35GizD91c1YIQJ8sfSr/fmnlO/GlYtA9GRD9SDeqXa1T2aiaTrN36FeXsv2072zQZbfEKxxge29Mnco952uu+c7TC2fA87YLf0ThlWW9VX3icMLSg4pHOZtWPRUIqaPA2QqjAo+wqwtUJIkO63uT3cD8oIv0MtriGYfP8jOVoi5M3s4apBL3+x4/bRUHIXDglj4rj9UfP2nwzKWFI9HOGH0XZEYYrE9/Xq7IuocBvmSMGmpO+fdWVXLo1nLT+/v7T241aJawfQ4nLFSj40Vsood6Og7/OWORuJrJ+Xf85DgEjU2hMG93nH1hC6kESCNd2QyaKI9kcOBGJrrR/8a3srXBcWHlgg02wavFS5911V/RBBSD4Xjijy/ax6COpHIvzJQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(19627235002)(36756003)(83380400001)(40460700003)(4326008)(70206006)(70586007)(86362001)(2906002)(7696005)(6666004)(356005)(82310400004)(30864003)(5660300002)(81166007)(2616005)(336012)(426003)(186003)(26005)(16526019)(1076003)(8936002)(508600001)(36860700001)(6916009)(316002)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 20:04:05.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d032cb6-c4ac-44a7-978d-08d9f1877c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3587
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch adds gc 10.3.6 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 87 ++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h                 |  1 +
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 56f89d55e593..5cd812cac052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1426,6 +1426,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
@@ -1563,6 +1564,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 		amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
 	default:
@@ -1769,6 +1771,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 		adev->family = AMDGPU_FAMILY_YC;
 		break;
+	case IP_VERSION(10, 3, 6):
+		adev->family = AMDGPU_FAMILY_GC_10_3_6;
+		break;
 	case IP_VERSION(10, 3, 7):
 		adev->family = AMDGPU_FAMILY_GC_10_3_7;
 		break;
@@ -1784,6 +1789,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
 		adev->flags |= AMD_IS_APU;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 95b8f76d0e7a..90158289cd30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -106,6 +106,12 @@
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh_BASE_IDX       1
 #define mmGOLDEN_TSC_COUNT_LOWER_Vangogh                0x0026
 #define mmGOLDEN_TSC_COUNT_LOWER_Vangogh_BASE_IDX       1
+
+#define mmGOLDEN_TSC_COUNT_UPPER_GC_10_3_6                0x002d
+#define mmGOLDEN_TSC_COUNT_UPPER_GC_10_3_6_BASE_IDX       1
+#define mmGOLDEN_TSC_COUNT_LOWER_GC_10_3_6                0x002e
+#define mmGOLDEN_TSC_COUNT_LOWER_GC_10_3_6_BASE_IDX       1
+
 #define mmSPI_CONFIG_CNTL_1_Vangogh		 0x2441
 #define mmSPI_CONFIG_CNTL_1_Vangogh_BASE_IDX	 1
 #define mmVGT_TF_MEMORY_BASE_HI_Vangogh          0x2261
@@ -258,6 +264,13 @@ MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec2.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/gc_10_3_6_ce.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_6_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_6_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_6_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_6_mec2.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_6_rlc.bin");
+
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_ce.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_me.bin");
@@ -3415,6 +3428,32 @@ static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000)
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_6[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000042),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG, 0x000001ff, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0xffffff7f, 0x00010020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_10_3_7[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x000000e4),
@@ -3678,6 +3717,11 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_0_cyan_skillfish,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
 		break;
+	case IP_VERSION(10, 3, 6):
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_3_6,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_6));
+		break;
 	case IP_VERSION(10, 3, 7):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_3_7,
@@ -3871,6 +3915,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.cp_fw_write_wait = true;
@@ -3993,6 +4038,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 		chip_name = "yellow_carp";
 		break;
+	case IP_VERSION(10, 3, 6):
+		chip_name = "gc_10_3_6";
+		break;
 	case IP_VERSION(10, 1, 3):
 	case IP_VERSION(10, 1, 4):
 		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
@@ -4598,6 +4646,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.config.max_hw_contexts = 8;
@@ -4736,6 +4785,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
@@ -4975,7 +5025,8 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device *adev)
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			bitmap = i * adev->gfx.config.max_sh_per_se + j;
 			if (((adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0)) ||
-				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3))) &&
+				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) ||
+				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 6))) &&
 			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
 				continue;
 			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
@@ -6249,6 +6300,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
@@ -6387,6 +6439,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(10, 3, 1):
 		case IP_VERSION(10, 3, 4):
 		case IP_VERSION(10, 3, 5):
+		case IP_VERSION(10, 3, 6):
 		case IP_VERSION(10, 3, 3):
 		case IP_VERSION(10, 3, 7):
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
@@ -6402,6 +6455,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(10, 3, 1):
 		case IP_VERSION(10, 3, 4):
 		case IP_VERSION(10, 3, 5):
+		case IP_VERSION(10, 3, 6):
 		case IP_VERSION(10, 3, 3):
 		case IP_VERSION(10, 3, 7):
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid,
@@ -6501,6 +6555,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
 		tmp &= 0xffffff00;
@@ -7231,6 +7286,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
 		return true;
 	default:
@@ -7266,6 +7322,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
@@ -7587,6 +7644,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 		if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY_Sienna_Cichlid))
 			grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
@@ -7654,6 +7712,21 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 		preempt_enable();
 		clock = clock_lo | (clock_hi << 32ULL);
 		break;
+	case IP_VERSION(10, 3, 6):
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_GC_10_3_6);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_GC_10_3_6);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_GC_10_3_6);
+		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_GC_10_3_6);
+			clock_hi = hi_check;
+		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
+		break;
 	default:
 		preempt_disable();
 		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
@@ -7719,6 +7792,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_Sienna_Cichlid;
@@ -7781,6 +7855,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 
@@ -7817,6 +7892,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 		break;
@@ -8271,6 +8347,7 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		switch (adev->ip_versions[GC_HWIP][0]) {
 		case IP_VERSION(10, 3, 1):
 		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 3, 6):
 			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
 			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
 			break;
@@ -8339,6 +8416,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 6):
 		gfx_v10_cntl_pg(adev, enable);
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
@@ -8365,6 +8443,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 		gfx_v10_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
@@ -9478,6 +9557,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
@@ -9572,8 +9652,9 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			bitmap = i * adev->gfx.config.max_sh_per_se + j;
 			if (((adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0)) ||
-				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) ||
-				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 7))) &&
+			     (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) ||
+			     (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 6)) ||
+			     (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 7))) &&
 			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
 				continue;
 			mask = 1;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 55fa660e35f4..1d65c1fbc4ec 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1151,6 +1151,7 @@ struct drm_amdgpu_info_video_caps {
 #define AMDGPU_FAMILY_NV			143 /* Navi10 */
 #define AMDGPU_FAMILY_VGH			144 /* Van Gogh */
 #define AMDGPU_FAMILY_YC			146 /* Yellow Carp */
+#define AMDGPU_FAMILY_GC_10_3_6			149 /* GC 10.3.6 */
 #define AMDGPU_FAMILY_GC_10_3_7			151 /* GC 10.3.7 */
 
 #if defined(__cplusplus)
-- 
2.35.1

