Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B04CC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 08:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCD810F04B;
	Wed, 27 Mar 2024 08:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGU3tc9O";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6DE10F915
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 08:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9bVK+Qh+guXXYhzQSdUvmJtkEeg5yyn2auG/lsZ8RIA4DM5ZdG9q4s6IfMxOwSwKgOOs/rFl6bjfMbQ+FXuexATtbaxo5AJdPMQ3OrEIeS3EfYX1eL2CNRIZC5tGXW9DNrJZWfJ4rzconX0LbhhSnWrhfArKvvjJ0eExBLTc+01wDz07JWBbM/Mnzt+k5cGDBMOBp50YyOp0wGMLPc2Q4K6msGxLSYDMGpoHexONOqzjwGj0pycfaDgeoFNkU9xae8S1TToNdM7JukLlgqTrN2FcgxbQ9tvU42lUk6hZt7S0rC0iHxMdg9UAroRNY3cPrzgW/gRA1Nwp8lx5iKRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4+qMwOHEhucO3IvK7DdlGZ1ecoO26fm66yUAwLt01Y=;
 b=esLhvrgy7lntwq9mqoAU3Hi5Sk8hTL058PFUGUkJvEFdnjYCrTpXZVrNO+TU6W0GciJV/4LrH9ax66BfcD5YQfAmB/CQ26/MldNVKWx5Bfe6SOrvgGKPRePEq9p5g6uaDNkDBHH4l4jfh7hKfIgTyqzct7L5maJcLkJbIdTy1MpET2CvoPqvCglrt4fjxpXBACIEZ2dvBqxw/ZPU+hVo31i0KwpKhzrHipm49GIf+a4eT8nlkeI4dyWU35T3hE/q98SZKDB1nHGnq7/s87nLB3VUsx/KcfRgjsLhyfo8QiD88G/BHO6su5fxHQ5X8f1JF/ZQ849IOv3zM4eq2rjTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4+qMwOHEhucO3IvK7DdlGZ1ecoO26fm66yUAwLt01Y=;
 b=bGU3tc9OcSuXUDIizCTrrFmRS6XlfaG3ixBOsr47aTl8aYSi8Kha8p3eYz4QigiP9eQdU0pgZb7ZZER0C4hbYSguQhLimB5EeBZthDEnhK8pDylo6UJF23sXcU6wpPkAXk67HY8LEqQvNQ5omiWBLG+88d7dBeZ3S9tij6z9J3Q=
Received: from CH2PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:4e::22)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 08:03:20 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::2b) by CH2PR02CA0012.outlook.office365.com
 (2603:10b6:610:4e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 08:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 08:03:20 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 03:03:18 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu/pm: Change the member function name of
 pp_hwmgr_func
Date: Wed, 27 Mar 2024 16:02:56 +0800
Message-ID: <20240327080259.2947891-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327080259.2947891-1-Jun.Ma2@amd.com>
References: <20240327080259.2947891-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f2f5a4-952e-44d5-cc6f-08dc4e345e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwiG9hO7chNlvtrhwP1bKWt77atb0Mjpt9Ccmks1IFN4tFOKoHX6R0UnOy0ZplTuWHffaQ09tseM0uKpZ+7qo5lDZN6HxnJhI0osoO3eF4d4Ag5w28C6mfynIPwFAlWqv4G2sHaASnEHVYGj1N7gNjqdF9DEWFoJ73XD/KFRGAwh73rA0zeEeDZEqzQ3SEXS6CJAjlDEGPkKZrmUGQkw7GfVavg+HcepdrddZM7MPjH50JlqxBUcQ44khM+ZqfQ2H8j/Y/GOdJU6VyZg1vsYLpE/YOmuRkGE744Qwepft2UG1j5v7HxVpTDdJ2IL/+5CxcPYtHip3qJA30/l+z3XnOAR36Ike2XinImOASUqP7MDjIaKKZWj6zjTYYkA+moJw/ew9I61NAUAACcuVnpSyf8IP/h2lXR3/qMY24nNPss0F314ksqXEOXcXalw63eNXW1TVOWa6Cm3NkQv+kFQZrr4g4+C10HGUJaQoy9CAkovF8d1W+UyZ7i2t6vbo/E1VuomF28+aUX73NnQdnGGNEAdITxDYRm9IvFgdv9wOT9Fr0o8vdP8e7mfr8MU+xSlQdPNCAOgtuORs+6wIucwDnrYHM//lIejfJP6qMB6bBG8bICoxrykmNxZB7i4/PTQhtSkTcycFPhkxJ61NHY6A5GOrxv9Klaxepy8a7QJP1bjsmQ9VpFLGUfGWZTod9jfoYxyy3ufDubZ+D+eeAtW2X7IQnznZG/munGp4u1D0S6q7/8bxWc1fm70s5SaeMbs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:03:20.6893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f2f5a4-952e-44d5-cc6f-08dc4e345e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

Change the member function name of pp_hwmgr_func to
keep consistent with the function in pptable_funcs

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c      | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h          | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index aed0e2cefbf9..fafd4e0b7908 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1379,10 +1379,10 @@ static bool pp_get_asic_baco_capability(void *handle)
 		return false;
 
 	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_capability)
+		!hwmgr->hwmgr_func->baco_is_support)
 		return false;
 
-	return hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr);
+	return hwmgr->hwmgr_func->baco_is_support(hwmgr);
 }
 
 static int pp_get_asic_baco_state(void *handle, int *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
index e8a9471c1898..1ab4fbfe0cde 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
@@ -33,7 +33,7 @@
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
 
-bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool smu7_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
index 73a773f4ce2e..df142c2eec8e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool smu7_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index aa91730e4eaf..ae7032d43169 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5791,7 +5791,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.get_power_profile_mode = smu7_get_power_profile_mode,
 	.set_power_profile_mode = smu7_set_power_profile_mode,
 	.get_performance_level = smu7_get_performance_level,
-	.get_asic_baco_capability = smu7_baco_get_capability,
+	.baco_is_support = smu7_baco_is_support,
 	.get_asic_baco_state = smu7_baco_get_state,
 	.set_asic_baco_state = smu7_baco_set_state,
 	.power_off_asic = smu7_power_off_asic,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
index c66ef9741535..687cd80ebad8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
@@ -28,7 +28,7 @@
 #include "vega10_inc.h"
 #include "smu9_baco.h"
 
-bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool smu9_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg, data;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
index 9ff7c2ea1b58..24461f1e3b01 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool smu9_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6d6bc6a380b3..e86f27b06f23 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5756,7 +5756,7 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.set_power_limit = vega10_set_power_limit,
 	.odn_edit_dpm_table = vega10_odn_edit_dpm_table,
 	.get_performance_level = vega10_get_performance_level,
-	.get_asic_baco_capability = smu9_baco_get_capability,
+	.baco_is_support = smu9_baco_is_support,
 	.get_asic_baco_state = smu9_baco_get_state,
 	.set_asic_baco_state = vega10_baco_set_state,
 	.enable_mgpu_fan_boost = vega10_enable_mgpu_fan_boost,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 460067933de2..386c1d7f52d5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2966,7 +2966,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.start_thermal_controller = vega12_start_thermal_controller,
 	.powergate_gfx = vega12_gfx_off_control,
 	.get_performance_level = vega12_get_performance_level,
-	.get_asic_baco_capability = smu9_baco_get_capability,
+	.baco_is_support = smu9_baco_is_support,
 	.get_asic_baco_state = smu9_baco_get_state,
 	.set_asic_baco_state = vega12_baco_set_state,
 	.get_ppfeature_status = vega12_get_ppfeature_status,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index dad4c80aee58..bc0ff417921b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -36,7 +36,7 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
 
-bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool vega20_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index bdad9c915631..006eb6633ce8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool vega20_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 3b33af30eb0f..bfecff6afc24 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4422,7 +4422,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.notify_cac_buffer_info = vega20_notify_cac_buffer_info,
 	.enable_mgpu_fan_boost = vega20_enable_mgpu_fan_boost,
 	/* BACO related */
-	.get_asic_baco_capability = vega20_baco_get_capability,
+	.baco_is_support = vega20_baco_is_support,
 	.get_asic_baco_state = vega20_baco_get_state,
 	.set_asic_baco_state = vega20_baco_set_state,
 	.set_mp1_state = vega20_set_mp1_state,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 6f536159df4d..83f903d8e994 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -351,7 +351,7 @@ struct pp_hwmgr_func {
 	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
-	bool (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr);
+	bool (*baco_is_support)(struct pp_hwmgr *hwmgr);
 	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 	int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf);
-- 
2.34.1

