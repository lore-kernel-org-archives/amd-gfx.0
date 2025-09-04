Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FECCA1015
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C770010E400;
	Thu,  4 Sep 2025 03:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="apgY1pAZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5730310E400
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 03:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3n6uDSpMct/wyBpD1XMJfxa5qmUzXxGpx2K8cMx6xN/jYOGjH0e08FvZmi22B4mfSC1aQT6RGWbKL/Mr0juS0JtJI6MiAVS9iPfCPnDHo4Qn02XDAaGFMk4GYys499Q+wNZdwzftVDIkjNpsGrEBeDVP68N+pJggpuFJCL8hOItgLWsL/oABQsBbCeMn7W4hN8wf4cHYC5nvNOgRA+dn9x0jVhweZTi1U/7F59m17JgpLOVSNuJtps9YO5XpOqVGBFj18/FHcfj+HOUQm5FwLDugqEohGK/N+z1/NSydnAPy3dJg7kbv70961Mcx0xinArjbcLpYPr1cXs/A7N9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzF3M8ewOEg70AwKdeuAhwJ4ZIDOiRRZds9j9gn6bkk=;
 b=KakQTFuTwCEbUvJog8bHY4Sukob1m4kPO6cgKquLrJeGvDy5l3eKlu8VL3ptZcj9t/gzxVmV44VB4M+ueXay9Nn906pUh5BgYu11koR3Gkmin8v783/ChP9ntPqWEOqru+2J+m6LJfrE1tSOH/KSqtAcTECouVxbxSi4K33VlmEbVytCw0aVTuAz7Jdgef/WohL/GnXsYnaPFWTultg8kSyrx5kQQZW+VCt0/5rbrCX5diefl/IEdKzKiX9f/yjkmoODxPt73bumNDS2NQSKj1jfCmfwm/1UU5yXLepFOoBRfmB5q7/QpukNo+KBanMzPs1o6B4tZTWruWb7kjk1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzF3M8ewOEg70AwKdeuAhwJ4ZIDOiRRZds9j9gn6bkk=;
 b=apgY1pAZ0llN3ok1lC7jszgEaJx3JFKewJLryqo1DnVyGIwROKl/XhmmSaNefcTVrSXdtRxKLQ5nXMjOvpzgVatbk42tCFXD86Z+/vpTV26tsHCP+yWDz5nO4MG2dYol7+YnHiG/acJeukQRaaNadqWf1XirnaBmLEpeQ6bPWQw=
Received: from CH0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:610:119::22)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 4 Sep
 2025 03:13:28 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::4b) by CH0PR03CA0369.outlook.office365.com
 (2603:10b6:610:119::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Thu,
 4 Sep 2025 03:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 4 Sep 2025 03:13:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 22:13:27 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 20:13:25 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: unified smu feature cap for mode1 reset
Date: Thu, 4 Sep 2025 11:13:06 +0800
Message-ID: <20250904031309.2035678-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904031309.2035678-1-kevinyang.wang@amd.com>
References: <20250904031309.2035678-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 20651c3b-5059-4c19-979a-08ddeb610498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KMpNkdUeZxeC18nawQmUdqbaUg1haLdd5g2MT3GZQRUUIAg1fG9ApEm6Omq/?=
 =?us-ascii?Q?H+IbzhekrOI9tGf8/IprZeTii8zxLhHOlEe3pj9fMEfNoLowOpj+/0hR+/XS?=
 =?us-ascii?Q?tiDk81C/JOdskfJlnwy7Om8wxQmsHw2IY1nkUVydUc0k4S35RlqAn+llYgvl?=
 =?us-ascii?Q?o6k/f1sE1JEBAvmMH8z0D1NOLIJ5PndVLVDJ78TRftjpFC65wkeG5L3Aoa74?=
 =?us-ascii?Q?psUD+KXW71P8/VTNYlgIpGamKIB7I0+LUjC9tNSoJbXgiQDxyOk5oPJE5wU5?=
 =?us-ascii?Q?qlsN3oKT36mWk2SHK75pk6chgK/qZ8DomD9f7jRtD2RMrW/XTHRhiGhPjenE?=
 =?us-ascii?Q?vj+NZwu2BQiwVKo508WKcri0uF4YmGqvDcocwQxm/AAiFjcwhAUsAV5N3RMM?=
 =?us-ascii?Q?XhZD6Ejw2Skz0UuzxTBzogqV1q4f+AbxoAq9ThdEPwJkkXP1Utc/UKLM/mE5?=
 =?us-ascii?Q?gstcUyGSBPUy/IcGC5kXIq2b37yPAV8jjaSDT9v9CWDX82xAnHslTYDf/BKN?=
 =?us-ascii?Q?0HO3aw4T+kI+gFbTHIfkSaKehv2W/OZVMMoHF3JN7j5KR30N9/X+GoXRA/8I?=
 =?us-ascii?Q?kEiSAkti7kNUiHCKAyEqJ9s5vxYEVzyii6vlDtJRHjMaJ/HK/FdvbbhD65eW?=
 =?us-ascii?Q?kKKyH/D04Aw8naRjuQ+hFPQv1Y2TNLdJ0BmiWWzmiylGzACkHxYnCtv3KRpr?=
 =?us-ascii?Q?/jenanHDCgn5EjHzmgoPCzekCbPZG7l6i4D4OZZCqSMaBgR8K4vLL8kEDZWY?=
 =?us-ascii?Q?5fb6N/w8QM7mAyH4O3zyxoCnv8WSbWBJUSKShSaDiYcUvKNUnOCEFhDP8+IC?=
 =?us-ascii?Q?ciSEYPD1AQDWjM5mMlwqEZo3qf/LLlhN3GSLl3QvZFUMS5P+EEzKU6A/cvUU?=
 =?us-ascii?Q?cYiBThkSbuBhouX32/mP/rtA+JapPLVHTsfbU5y27Ef9vYTRgirJnTVXx/jr?=
 =?us-ascii?Q?yz/ktmPLkV9toSEODZF+e33KB6gRxyiuatnLmN8YELRnBq3fHz2NFzPIZ4mo?=
 =?us-ascii?Q?cDhfhYtL/OJ4R+ycTemkyLhoeV/Eee3sJZz7TPOAQ8je/4yB2ByPaPX1q3/6?=
 =?us-ascii?Q?VPN+4cpZCzt+P03pBP3HtY/Qzv0jEDhSuWlNuWcYqrf1xM5caQ+uh3xhmXkG?=
 =?us-ascii?Q?q9eB9vwURe88V33C28kRoWmzjNx+Zzjn01QVb/ziARxBr1ky9MD77xjVjFDF?=
 =?us-ascii?Q?MN38MutqAZ9eWu3v1gYXpGexkMTtXRwawdIJsOM/Fc7/c8CR+C+VMIUiO1E3?=
 =?us-ascii?Q?DGrz6cOWm886egq3NDE70FXTgTOnkQCdU7BBrJUdwuG+y1AORlyPoLDhle/G?=
 =?us-ascii?Q?8M6A1i30oz23RLYMHtCnhibQuJZ2Z1FbiALCV3DgXe0kgJ2QU8FA9be405ut?=
 =?us-ascii?Q?1b9UN2Doqb07LsQ2EwITMkpYYcDMGwu2s0eCzhHbIEbMPtRjKNHwVlse6gJC?=
 =?us-ascii?Q?horxOontGQNo0W10rX84aUvYj+3mDm8aJKb9b4hoCq23hB6kY7Cx4MlP5gtD?=
 =?us-ascii?Q?zJktvX7DkhFz5SZw9BX+qe8TYxs4ooHInw5C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 03:13:27.7392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20651c3b-5059-4c19-979a-08ddeb610498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

unified mode1 reset feature cap

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 +---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 +--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 ++++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 38 ++++---------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 10 ++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 14 ++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 10 ++++-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 16 ++++----
 8 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 52b93642a26e..41d568b91f6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3524,15 +3524,10 @@ static int smu_baco_set_state(void *handle, int state)
 
 bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
-	bool ret = false;
-
 	if (!smu->pm_enabled)
 		return false;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
-		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
-
-	return ret;
+	return smu_feature_cap_test(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
 }
 
 bool smu_link_reset_is_support(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b0f5790051d6..90ebe158940e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -528,6 +528,7 @@ enum smu_fw_status {
 #define SMU_WBRF_EVENT_HANDLING_PACE	10
 
 enum smu_feature_cap_id {
+	SMU_FEATURE_CAP_ID__MODE1_RESET = 0,
 	SMU_FEATURE_CAP_ID__COUNT,
 };
 
@@ -1275,11 +1276,6 @@ struct pptable_funcs {
 	 */
 	int (*baco_exit)(struct smu_context *smu);
 
-	/**
-	 * @mode1_reset_is_support: Check if GPU supports mode1 reset.
-	 */
-	bool (*mode1_reset_is_support)(struct smu_context *smu);
-
 	/**
 	 * @link_reset_is_support: Check if GPU supports link reset.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d57591509aed..01e7299eed18 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3136,6 +3136,14 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int sienna_cichlid_post_init(struct smu_context *smu)
+{
+	if (sienna_cichlid_is_mode1_reset_supported(smu))
+		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
+
+	return 0;
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3204,7 +3212,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = sienna_cichlid_baco_enter,
 	.baco_exit = sienna_cichlid_baco_exit,
-	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
 	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
@@ -3229,6 +3236,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_config_table = sienna_cichlid_set_config_table,
 	.get_unique_id = sienna_cichlid_get_unique_id,
 	.mode2_reset = sienna_cichlid_mode2_reset,
+	.post_init = sienna_cichlid_post_init,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index b067147b7c41..a43654e5604e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2011,35 +2011,6 @@ static int aldebaran_smu_handle_passthrough_sbr(struct smu_context *smu, bool en
 	return ret;
 }
 
-static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
-{
-#if 0
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t val;
-	uint32_t smu_version;
-	int ret;
-
-	/**
-	 * PM FW version support mode1 reset from 68.07
-	 */
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return false;
-
-	if ((smu_version < 0x00440700))
-		return false;
-
-	/**
-	 * mode1 reset relies on PSP, so we should check if
-	 * PSP is alive.
-	 */
-	val = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
-
-	return val != 0x0;
-#endif
-	return true;
-}
-
 static int aldebaran_set_mp1_state(struct smu_context *smu,
 				   enum pp_mp1_state mp1_state)
 {
@@ -2091,6 +2062,13 @@ static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
 	return ret;
 }
 
+static int aldebaran_post_init(struct smu_context *smu)
+{
+	smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
+
+	return 0;
+}
+
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
@@ -2144,7 +2122,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
-	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
 	.smu_handle_passthrough_sbr = aldebaran_smu_handle_passthrough_sbr,
 	.mode1_reset = aldebaran_mode1_reset,
 	.set_mp1_state = aldebaran_set_mp1_state,
@@ -2155,6 +2132,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.send_hbm_bad_pages_num = aldebaran_smu_send_hbm_bad_page_num,
 	.get_ecc_info = aldebaran_get_ecc_info,
 	.send_hbm_bad_channel_flag = aldebaran_send_hbm_bad_channel_flag,
+	.post_init = aldebaran_post_init,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e084ed99ec0e..20e554cd4fd5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3214,6 +3214,14 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_post_init(struct smu_context *smu)
+{
+	if (smu_v13_0_0_is_mode1_reset_supported(smu))
+		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -3280,7 +3288,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_bamaco_support = smu_v13_0_get_bamaco_support,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
-	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_0_mode1_reset,
 	.mode2_reset = smu_v13_0_0_mode2_reset,
 	.enable_gfx_features = smu_v13_0_0_enable_gfx_features,
@@ -3295,6 +3302,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 	.interrupt_work = smu_v13_0_interrupt_work,
+	.post_init = smu_v13_0_0_post_init,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index e37b7b5358ea..5b3341c3f82f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3115,11 +3115,6 @@ static int smu_v13_0_6_link_reset(struct smu_context *smu)
 	return ret;
 }
 
-static bool smu_v13_0_6_is_mode1_reset_supported(struct smu_context *smu)
-{
-	return true;
-}
-
 static inline bool smu_v13_0_6_is_link_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3219,6 +3214,13 @@ static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 }
 
 
+static int smu_v13_0_6_post_init(struct smu_context *smu)
+{
+	smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
+
+	return 0;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3881,7 +3883,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_pm_metrics = smu_v13_0_6_get_pm_metrics,
 	.get_xcp_metrics = smu_v13_0_6_get_xcp_metrics,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
-	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.link_reset_is_support = smu_v13_0_6_is_link_reset_supported,
 	.mode1_reset = smu_v13_0_6_mode1_reset,
 	.mode2_reset = smu_v13_0_6_mode2_reset,
@@ -3895,6 +3896,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
+	.post_init = smu_v13_0_6_post_init,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c96fa5e49ed6..e377d2272092 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2656,6 +2656,14 @@ static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 	return true;
 }
 
+static int smu_v13_0_7_post_init(struct smu_context *smu)
+{
+	if (smu_v13_0_7_is_mode1_reset_supported(smu))
+		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
+
+	return 0;
+}
+
 static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
 				     enum pp_df_cstate state)
 {
@@ -2862,7 +2870,6 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_bamaco_support = smu_v13_0_get_bamaco_support,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
-	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
@@ -2871,6 +2878,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 	.interrupt_work = smu_v13_0_interrupt_work,
+	.post_init = smu_v13_0_7_post_init,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index f32474af90b3..7c42f036a5f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1965,13 +1965,6 @@ static int smu_v14_0_2_baco_exit(struct smu_context *smu)
 	}
 }
 
-static bool smu_v14_0_2_is_mode1_reset_supported(struct smu_context *smu)
-{
-	// TODO
-
-	return true;
-}
-
 static int smu_v14_0_2_i2c_xfer(struct i2c_adapter *i2c_adap,
 				   struct i2c_msg *msg, int num_msgs)
 {
@@ -2861,6 +2854,13 @@ static int smu_v14_0_2_set_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v14_0_2_post_init(struct smu_context *smu)
+{
+	smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v14_0_2_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v14_0_2_set_default_dpm_table,
@@ -2922,12 +2922,12 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.baco_set_state = smu_v14_0_baco_set_state,
 	.baco_enter = smu_v14_0_2_baco_enter,
 	.baco_exit = smu_v14_0_2_baco_exit,
-	.mode1_reset_is_support = smu_v14_0_2_is_mode1_reset_supported,
 	.mode1_reset = smu_v14_0_2_mode1_reset,
 	.mode2_reset = smu_v14_0_2_mode2_reset,
 	.enable_gfx_features = smu_v14_0_2_enable_gfx_features,
 	.set_mp1_state = smu_v14_0_2_set_mp1_state,
 	.set_df_cstate = smu_v14_0_2_set_df_cstate,
+	.post_init = smu_v14_0_2_post_init,
 #if 0
 	.gpo_control = smu_v14_0_gpo_control,
 #endif
-- 
2.34.1

