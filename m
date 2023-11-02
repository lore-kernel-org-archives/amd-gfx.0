Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23919C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 07:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75CC510E823;
	Thu,  2 Nov 2023 07:59:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D6210E822
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 07:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLMY5Rltg5CFxvN6Ph5aFpcRvXwdpC3y8Y5PX+w/hIjbBY5j4pOE3Z3OMSteH8SbXqtFXKSV26UtkiLF8tCuDAHNqqJDebe8fH0F80ygd0ScoZEWosi5ZGLRp2GtPqUmot5s7qvB1yU8jI6LcIj82IW+sV1tEW+fRkj/VqyE2aGZ7Yzqg//4o64rFtj3Px1t+9MclV4Y3NlBXYPdVDNhO/sjx2NEI6kjnWVVUFpTsjJVDXDnnB5OUCHvGSczp2qhudFaTE3knflG9KG2X11uRdRhAtyr+S8H3+SP+2Fn8DtTdAMZrpwPKfqiIxjy9FgbeniXkyg56Lg1a0DLtg4oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StEmFchsVtND+I6L4Q29Au+heFjhuGgOrr79azL0dS4=;
 b=NG9DExqY3Pe0NF/Po8VLF1RloA5m2kcLcaLrES2SmPwZAVDfI7TrJl8j/YBWjwftC3gVcGrWgzIi6Fu98eRrLX0duXEe/tEuDBKXFRJdXwtNCNGL/3F7re+J2NPHVgtg1h9l3Hd7c5tNLs864foseGZZJe9vziJOQcl1uVvsSm+ks94wBGlIAH/akQN2MJKrsYCX4WDsaG8FvdNvNUigNb8nbKSvHoft1A1Dwr7JBKi7Er+/Z6QOLSSPc0ToQutAiWMHQs80W5y5dVawcRs1e7spORN+k0rN/pyaXl7I5Jnqk29psFgZPpoe1Rp+dELUp5Vq6DztT9fE0AEHW4IQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StEmFchsVtND+I6L4Q29Au+heFjhuGgOrr79azL0dS4=;
 b=5DyTMpxSwW2yIsGLDYTHJVEjCWtA442Hd2VHBRxfg8N7bynQkNwF8FRjgcCQ2TiGnRT+8U61YHfCYf3G4ci/Xcm4hrBfv6lPMA3RvEIRn9i2W3bghENL+FFyKvRc5vLNDDkrYbrPQ6P0I1E3yUl9UogcAO+9MxcUqVoD4z3Ww5k=
Received: from SN6PR05CA0013.namprd05.prod.outlook.com (2603:10b6:805:de::26)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 07:59:54 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::ec) by SN6PR05CA0013.outlook.office365.com
 (2603:10b6:805:de::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 07:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 07:59:53 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 02:59:47 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm:Fix return vlaue and drop redundant param
Date: Thu, 2 Nov 2023 15:59:16 +0800
Message-ID: <20231102075916.2701221-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cfd78f-8ee1-406f-6ac4-08dbdb79b2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIziuVTfr7hGsGJh9mArCFkY6m6hHRmKeHg3jQF3TU7ICkFmqK7Bcz1za66S00gcVD2hNF09q+xzEXydMgSa/rifjcv7J/6hZVm6NobQC0bb9Sa+V33cbesHe3MZ8S9fIi+6hXpR1wXjf89kC1TVLKxjgBX/xw6mxntiWyiTn15Kcfh891JoIBySTMQTlt9SHhjelExJjm2LsDRaS9MaPj7HaFRB6jg+nnARuDGEOHOqMgkl+nuqez8mT/di9f0Jmqtu2TQQrDuqzflcEU1hKGQFqGPMnuXAl42mziDUu8g49vmfmMCBKDSV5svQkP4s89U/JWubDmNzMubiKIxmCDI/5zEGrv562FdiQL+lP9IIQicS+JVf02dD0PK84iWjGZquf3mx+ef2gGTfOzgT20a+zWonTEBHT2OsVq2nR2J96TTv6yjpnZFxv4zyQIq8xjmr8+jBXi8rQ/pTrhazX1FnDNXXRJRRvGYCnx1udzCBFVW+UE29biUPTe2EEBa437tt96hFmeBrQjoTEHvYh7EbQI09MpHkxhrmH+t0st9jdHnjIFZm8WC6VAbYEOtTiXP8I1nt33QfL7f3rTLQvfggGgCiPKfvZb+Dl3Bb6YKXhkjmJirUSSH9QU9NG2abiHQXkH2NDWSbBPzOVaAxKe97ttdcy+/i90ubcj5VP9D6rmFELF+JbyjJOkxoGEieBH48xCM2rT8dPNYU9n9FB1D365zAncbTi3hjyx3gf/fqLKg66X0SG/aB+ya5/m/HDTgybNsvc1dZvtwCdtAGNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(40460700003)(16526019)(26005)(2616005)(426003)(1076003)(7696005)(47076005)(336012)(8676002)(6666004)(478600001)(36860700001)(5660300002)(30864003)(83380400001)(70206006)(41300700001)(70586007)(110136005)(8936002)(316002)(6636002)(4326008)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 07:59:53.8075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cfd78f-8ee1-406f-6ac4-08dbdb79b2b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the return value and drop redundant parameter of
get_asic_baco_capability function to simplify the code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h       |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  8 +++-----
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c     | 11 ++++-------
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c   |  7 +++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h   |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c   |  9 ++++-----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h   |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c |  9 ++++-----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h         |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 12 +++++-------
 11 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 3201808c2dd8..60e6b82077e8 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -421,7 +421,7 @@ struct amd_pm_funcs {
 	int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
-	int (*get_asic_baco_capability)(void *handle, bool *cap);
+	bool (*get_asic_baco_capability)(void *handle);
 	int (*get_asic_baco_state)(void *handle, int *state);
 	int (*set_asic_baco_state)(void *handle, int state);
 	int (*get_ppfeature_status)(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index acf3527fff2d..24fd036a15c0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -185,8 +185,7 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	bool baco_cap;
-	int ret = 0;
+	bool ret;
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return false;
@@ -204,12 +203,11 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->pm.mutex);
 
-	ret = pp_funcs->get_asic_baco_capability(pp_handle,
-						 &baco_cap);
+	ret = pp_funcs->get_asic_baco_capability(pp_handle);
 
 	mutex_unlock(&adev->pm.mutex);
 
-	return ret ? false : baco_cap;
+	return ret;
 }
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 9e4f8a4104a3..e82c2b2fffb5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1368,21 +1368,18 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
 	return phm_set_active_display_count(hwmgr, count);
 }
 
-static int pp_get_asic_baco_capability(void *handle, bool *cap)
+static bool pp_get_asic_baco_capability(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	*cap = false;
 	if (!hwmgr)
-		return -EINVAL;
+		return false;
 
 	if (!(hwmgr->not_vf && amdgpu_dpm) ||
 		!hwmgr->hwmgr_func->get_asic_baco_capability)
-		return 0;
+		return false;
 
-	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
-
-	return 0;
+	return hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr);
 }
 
 static int pp_get_asic_baco_state(void *handle, int *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
index 044cda005aed..e8a9471c1898 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
@@ -33,21 +33,20 @@
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
 
-int smu7_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
+bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
 
-	*cap = false;
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
 		return 0;
 
 	reg = RREG32(mmCC_BIF_BX_FUSESTRAP0);
 
 	if (reg & CC_BIF_BX_FUSESTRAP0__STRAP_BIF_PX_CAPABLE_MASK)
-		*cap = true;
+		return true;
 
-	return 0;
+	return false;
 }
 
 int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
index be0d98abb536..73a773f4ce2e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern int smu7_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
+extern bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr);
 extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
index de0a37f7c632..c66ef9741535 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
@@ -28,14 +28,13 @@
 #include "vega10_inc.h"
 #include "smu9_baco.h"
 
-int smu9_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
+bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg, data;
 
-	*cap = false;
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
-		return 0;
+		return false;
 
 	WREG32(0x12074, 0xFFF0003B);
 	data = RREG32(0x12075);
@@ -44,10 +43,10 @@ int smu9_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
 		reg = RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);
 
 		if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-			*cap = true;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
index 84e90f801ac3..9ff7c2ea1b58 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern int smu9_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
+extern bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr);
 extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 994c0d374bfa..dad4c80aee58 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -36,23 +36,22 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
 
-int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
+bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
 
-	*cap = false;
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
-		return 0;
+		return false;
 
 	if (((RREG32(0x17569) & 0x20000000) >> 29) == 0x1) {
 		reg = RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);
 
 		if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-			*cap = true;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index f06471e712dc..bdad9c915631 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
+extern bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 81650727a5de..6f536159df4d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -351,7 +351,7 @@ struct pp_hwmgr_func {
 	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
-	int (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr, bool *cap);
+	bool (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr);
 	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 	int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 23b00eddc1af..82be473a3fc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3004,19 +3004,17 @@ static int smu_set_xgmi_pstate(void *handle,
 	return ret;
 }
 
-static int smu_get_baco_capability(void *handle, bool *cap)
+static bool smu_get_baco_capability(void *handle)
 {
 	struct smu_context *smu = handle;
 
-	*cap = false;
-
 	if (!smu->pm_enabled)
-		return 0;
+		return false;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
-		*cap = smu->ppt_funcs->baco_is_support(smu);
+	if (!smu->ppt_funcs || !smu->ppt_funcs->baco_is_support)
+		return false;
 
-	return 0;
+	return smu->ppt_funcs->baco_is_support(smu);
 }
 
 static int smu_baco_set_state(void *handle, int state)
-- 
2.34.1

