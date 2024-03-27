Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D876C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 11:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A0B10FA15;
	Wed, 27 Mar 2024 11:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ZbXwoy3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D91710FA15
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 11:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOYcFTflGEddtu97eimQID4SA8P+JUKThhN1A2bpLCwCJsYiGiN05DwC3s5VmnF7GfSk4qAcKGEdEiNodCZwzixMQ2UdHMLG2p9TU1U0fn9JYs7/QHxrweZOIrGdf8aiB0QU2VYFShs4ryU4WRYSjCv6xU1srEhdOagW+/sBA5+nTx7mAaro0h0r4I0Aokv2jF2lJr8qjyhfGM9zJcoknHY5Ey5n08lhPhoKZaZL4rTBrFAJzt3cmTvzlhFUxRHmAwOCfrqEMBcm5LGmihB6xx0z6WrJkj8bf4h6+z85AO3MMeGgOOdTQDDZwJOYjR41R3h7g4inR9UlI+iYm/dzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byo/IMsx6tJJVDfH1DgcAP+QBqXzMv7u3NUpL9nB7lA=;
 b=gLV5NtKA4YTGqH5hOzGbWmVxHnqV+42IHZGL7/Hq8bJ5/VDGRBO72nseigYoPYM3Vw7C+DghzlkRDOcSv5bqPldJ47ycvCYlwGOPfvP0ciOx7MmtEyKjZteDY59h5wR/WUWGqQuNQNkiM/GNofQtNVaQRxAt/rjxRl8dH7rOBerrwPsVHfYpVDbf0bJDOKTB7BDtwbpOuErnV6i5+dk+Q6ru/TKF6QjlGDSeXKHt5g0Dtw7YNo2R1+C9Yr8u9xxQzhDxSKL12wUvvFswOhObXHZHp+6dER2fXcn06dvMT1HTLCw5OvB2Qz8qG70mQyX6/PNPQk0cE1qwkuJvYvsYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byo/IMsx6tJJVDfH1DgcAP+QBqXzMv7u3NUpL9nB7lA=;
 b=2ZbXwoy3jgLSkWZBQYa8iHLw58eM0KzlnAENQVOFe0fwEujcTbvcVQdIQ6cZERME0I8N3RTlH32X5frhmEh5pTn7iK10eBRDXgd8O8/G/MFEVR5LcY6XkBB4rGzw8f16NRuNEmIShdgbUsQ90/I67Gr9cqIg+yT4uk5eVgPO6bg=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 11:11:23 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::6b) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 11:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 11:11:22 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 06:11:19 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v3 2/5] drm/amdgpu/pm: Change the member function name in
 pp_hwmgr_func and pptable_funcs
Date: Wed, 27 Mar 2024 19:10:06 +0800
Message-ID: <20240327111009.2994297-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327111009.2994297-1-Jun.Ma2@amd.com>
References: <20240327111009.2994297-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d553c3a-061d-4ae2-48d7-08dc4e4ea2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pJ6ThAj6fREJOseFzFJPPiFZnK9AC/SMBNk4TyNOTJvIy4RzLhKZGnRRM59K6vY+QIWWLgGsSyowKVn9vj/h+3kBi1cE8s26hEJP8y+wa7W+sGf9Fb0qTh0zF5OCazzGp8wWiwTGJQCjze46bkRh3jUSWVC4sTfP5s8/ESmOIdrGDhdHKW53xMhNKNxzhdVCcWLQC4S1Ur+L7S6FH7GIQyJ04pMsLfSveGFXOUGB1gFqPuW41ALQg/hc0mRk/ZtSY2ZmgQTrRiZbVshNtf6kf7IdhyPbmFNWZukBCXcwv2RRFOxdnqQrIL3u/ch6n7zxf+/h3MfOT2QrJAwQiaGRep+TNK5OMI+qZCEH+XmRbglKBNwf9Db0OacgH5+cW3bzOwMGDF/SgJoqv9L9hToqfkhnRkQ7fwVnL5J4Jji4e96Sp4YQ7NsTRtkk2hVPOADn/J0pgLDg0lHGtssGSogxbFNVebAtKiQqP1ZPmD43WuQkhl7Ri3fVhWG5efp1LzznW4UZr3zmHodQnV698fKO/SK8v1p/0kCm3p0GJWvxguolqEzuZR/JT8H4tssvncGMItrO40j1Z4Lbi7T1l/5SJfk4L94PzVOgrHzkIuJ6NHFjnJFyFvuHWbdAl4kW9VaTHaql7aWT0lBfXtvzJ0iMj+nPjH0OBFHGufYVQWisnQY5ztYkNfLBpHQEVTl/26VrB4+rt7JxwA2Q+MybUqRz94aMaJRl8UpRBo/l21sV5PAEaW5UJW0lmU5CUZOr6VY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:11:22.7436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d553c3a-061d-4ae2-48d7-08dc4e4ea2f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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

Use a unified and more explicit name get_bamaco_support
to replace is_baco_support and get_asic_baco_capability

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2->v3:
- Change the function name (lijo)
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c        | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c      | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h      | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c     | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c      | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h      | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h            | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h            | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h            | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c          | 2 +-
 27 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index aed0e2cefbf9..581dadfd13f9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1379,10 +1379,10 @@ static bool pp_get_asic_baco_capability(void *handle)
 		return false;
 
 	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_capability)
+		!hwmgr->hwmgr_func->get_bamaco_support)
 		return false;
 
-	return hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr);
+	return hwmgr->hwmgr_func->get_bamaco_support(hwmgr);
 }
 
 static int pp_get_asic_baco_state(void *handle, int *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
index e8a9471c1898..8490614e2d7e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
@@ -33,7 +33,7 @@
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
 
-bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool smu7_get_bamaco_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
index 73a773f4ce2e..93df1b9dfbd9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool smu7_get_bamaco_support(struct pp_hwmgr *hwmgr);
 extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index aa91730e4eaf..1fcd4451001f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5791,7 +5791,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.get_power_profile_mode = smu7_get_power_profile_mode,
 	.set_power_profile_mode = smu7_set_power_profile_mode,
 	.get_performance_level = smu7_get_performance_level,
-	.get_asic_baco_capability = smu7_baco_get_capability,
+	.get_bamaco_support = smu7_get_bamaco_support,
 	.get_asic_baco_state = smu7_baco_get_state,
 	.set_asic_baco_state = smu7_baco_set_state,
 	.power_off_asic = smu7_power_off_asic,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
index c66ef9741535..938812d6b978 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
@@ -28,7 +28,7 @@
 #include "vega10_inc.h"
 #include "smu9_baco.h"
 
-bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool smu9_get_bamaco_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg, data;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
index 9ff7c2ea1b58..67a5cec8e6b5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool smu9_get_bamaco_support(struct pp_hwmgr *hwmgr);
 extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6d6bc6a380b3..9f5bd998c6bf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5756,7 +5756,7 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.set_power_limit = vega10_set_power_limit,
 	.odn_edit_dpm_table = vega10_odn_edit_dpm_table,
 	.get_performance_level = vega10_get_performance_level,
-	.get_asic_baco_capability = smu9_baco_get_capability,
+	.get_bamaco_support = smu9_get_bamaco_support,
 	.get_asic_baco_state = smu9_baco_get_state,
 	.set_asic_baco_state = vega10_baco_set_state,
 	.enable_mgpu_fan_boost = vega10_enable_mgpu_fan_boost,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 460067933de2..c223e3a6bfca 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2966,7 +2966,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.start_thermal_controller = vega12_start_thermal_controller,
 	.powergate_gfx = vega12_gfx_off_control,
 	.get_performance_level = vega12_get_performance_level,
-	.get_asic_baco_capability = smu9_baco_get_capability,
+	.get_bamaco_support = smu9_get_bamaco_support,
 	.get_asic_baco_state = smu9_baco_get_state,
 	.set_asic_baco_state = vega12_baco_set_state,
 	.get_ppfeature_status = vega12_get_ppfeature_status,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index dad4c80aee58..0d0523e046d4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -36,7 +36,7 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
 
-bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool vega20_get_bamaco_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index bdad9c915631..a2c0f4e7813c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool vega20_get_bamaco_support(struct pp_hwmgr *hwmgr);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 3b33af30eb0f..f9efb0bad807 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4422,7 +4422,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.notify_cac_buffer_info = vega20_notify_cac_buffer_info,
 	.enable_mgpu_fan_boost = vega20_enable_mgpu_fan_boost,
 	/* BACO related */
-	.get_asic_baco_capability = vega20_baco_get_capability,
+	.get_bamaco_support = vega20_get_bamaco_support,
 	.get_asic_baco_state = vega20_baco_get_state,
 	.set_asic_baco_state = vega20_baco_set_state,
 	.set_mp1_state = vega20_set_mp1_state,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 6f536159df4d..5b3da41f159f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -351,7 +351,7 @@ struct pp_hwmgr_func {
 	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
-	bool (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr);
+	bool (*get_bamaco_support)(struct pp_hwmgr *hwmgr);
 	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 	int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 246b211b1e85..4aa0776a5b01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3207,10 +3207,10 @@ static bool smu_get_baco_capability(void *handle)
 	if (!smu->pm_enabled)
 		return false;
 
-	if (!smu->ppt_funcs || !smu->ppt_funcs->baco_is_support)
+	if (!smu->ppt_funcs || !smu->ppt_funcs->get_bamaco_support)
 		return false;
 
-	return smu->ppt_funcs->baco_is_support(smu);
+	return smu->ppt_funcs->get_bamaco_support(smu);
 }
 
 static int smu_baco_set_state(void *handle, int state)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..e791b846da7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1173,9 +1173,11 @@ struct pptable_funcs {
 	int (*get_max_sustainable_clocks_by_dc)(struct smu_context *smu, struct pp_smu_nv_clock_table *max_clocks);
 
 	/**
-	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
+	 * @get_bamaco_support: Check if GPU supports BACO/MACO
+	 * BACO: Bus Active, Chip Off
+	 * MACO: Memory Active, Chip Off
 	 */
-	bool (*baco_is_support)(struct smu_context *smu);
+	bool (*get_bamaco_support)(struct smu_context *smu);
 
 	/**
 	 * @baco_get_state: Get the current BACO state.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index a0e5ad0381d6..0e8fdf3bccc4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -237,7 +237,7 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu);
 int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 		struct pp_smu_nv_clock_table *max_clocks);
 
-bool smu_v11_0_baco_is_support(struct smu_context *smu);
+bool smu_v11_0_get_bamaco_support(struct smu_context *smu);
 
 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index fbd57fa1a004..bad7e73e9fe0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -210,7 +210,7 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
 
-bool smu_v13_0_baco_is_support(struct smu_context *smu);
+bool smu_v13_0_get_bamaco_support(struct smu_context *smu);
 
 int smu_v13_0_baco_enter(struct smu_context *smu);
 int smu_v13_0_baco_exit(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 3f7463c1c1a9..b4d7b4ea0c9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -159,7 +159,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu);
 int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq);
 
-bool smu_v14_0_baco_is_support(struct smu_context *smu);
+bool smu_v14_0_get_bamaco_support(struct smu_context *smu);
 
 enum smu_baco_state smu_v14_0_baco_get_state(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 0c2d04f978ac..6d334a2aff67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2387,7 +2387,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support = smu_v11_0_baco_is_support,
+	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 836b1df79928..5a68d365967f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3538,7 +3538,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support = smu_v11_0_baco_is_support,
+	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = navi10_baco_enter,
 	.baco_exit = navi10_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1f18b61884f3..e426f457a017 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4431,7 +4431,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support = smu_v11_0_baco_is_support,
+	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = sienna_cichlid_baco_enter,
 	.baco_exit = sienna_cichlid_baco_exit,
 	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5e5da9b16718..f6913820dbb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1557,7 +1557,7 @@ int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
 
-bool smu_v11_0_baco_is_support(struct smu_context *smu)
+bool smu_v11_0_get_bamaco_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0467864a1aa8..a3bf491eb8ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1582,7 +1582,7 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
 }
 
-static bool aldebaran_is_baco_supported(struct smu_context *smu)
+static bool aldebaran_get_bamaco_support(struct smu_context *smu)
 {
 	/* aldebaran is not support baco */
 
@@ -2060,7 +2060,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v13_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support = aldebaran_is_baco_supported,
+	.get_bamaco_support = aldebaran_get_bamaco_support,
 	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ce16f2a08a47..0193b81eab14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2268,7 +2268,7 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 	return ret;
 }
 
-bool smu_v13_0_baco_is_support(struct smu_context *smu)
+bool smu_v13_0_get_bamaco_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5a857cb999f5..27c81eef4100 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3071,7 +3071,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.deep_sleep_control = smu_v13_0_deep_sleep_control,
 	.gfx_ulv_control = smu_v13_0_gfx_ulv_control,
-	.baco_is_support = smu_v13_0_baco_is_support,
+	.get_bamaco_support = smu_v13_0_get_bamaco_support,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..739611215c8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2078,7 +2078,7 @@ static void smu_v13_0_6_get_unique_id(struct smu_context *smu)
 	adev->unique_id = pptable->PublicSerialNumber_AID;
 }
 
-static bool smu_v13_0_6_is_baco_supported(struct smu_context *smu)
+static bool smu_v13_0_6_get_bamaco_support(struct smu_context *smu)
 {
 	/* smu_13_0_6 does not support baco */
 
@@ -3189,7 +3189,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v13_0_disable_thermal_alert,
 	.setup_pptable = smu_v13_0_6_setup_pptable,
-	.baco_is_support = smu_v13_0_6_is_baco_supported,
+	.get_bamaco_support = smu_v13_0_6_get_bamaco_support,
 	.get_dpm_ultimate_freq = smu_v13_0_6_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v13_0_6_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7318964f1f14..e996a0a4d33e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2650,7 +2650,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
-	.baco_is_support = smu_v13_0_baco_is_support,
+	.get_bamaco_support = smu_v13_0_get_bamaco_support,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 9e39f99154f9..28f6312e1798 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1590,7 +1590,7 @@ int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
 	return 0;
 }
 
-bool smu_v14_0_baco_is_support(struct smu_context *smu)
+bool smu_v14_0_get_bamaco_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-- 
2.34.1

