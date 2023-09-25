Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA45CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33B310E1CC;
	Mon, 25 Sep 2023 04:28:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C35D10E1D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQHA8/hzOVhz8MumolX8T7rgyZNAcMSda0lLL9ttZIF13EU5fZx24Gk8aj+NUHvaHbPTgx4qNjp1bd+USyueIXgYrMSHtKtir5zH/QsfveHopCabBaSeYWz9+L5+Yk8OJ+g08PVSU942Jr20VnlUPtXfp2zb+u+KA9m3P7+/BPEMzGXBD62YypAfJlYn/8PudXgXlKrI+mxKShLzoafWDoIhA9OQwaWt/6clghCaTdI5qlob9KCAxTGrDY6jp/x54JPjh2ic2i1OPzliScljtY1iOM7roV9EGS8MgT0ig01U6H62my4qbEOrjBQCewCn5oMXmAlRyvDGOCGtl/ZUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+zstnZubQ1cl65VRF1+bE34Ii3FYb0AKKzdReNvahU=;
 b=In8aoSu2jgubNZoTiFbZaYxB+lVpDnEolElkQsdGAeyOmchJbLa+Ce/bma4MgcNl7eR0vGz0+bgHZopyGr/7Bu2aEhw0dE0SBEwbY2KdSl7HgLs2hfq7kwjzoABS4FmHu9k+OgPKpBn6RZqa//3nKdbshq4cVTQ7osquNSDbF00Es5nw9qHP6UI4UT+kWxK8sL4atUcAvkLmfNsondMpSQiweZ8U6OIhIuMBdGQVpjl55c7bjwb/5Ge2tKiJqj4l3/35mutfm6kGaLdDcqUmrsLDR1rz6D4vagg/0qnKRcrCSvVXpLrt6fteiyno+McRph3kAYHroj7MKubfZ8O1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+zstnZubQ1cl65VRF1+bE34Ii3FYb0AKKzdReNvahU=;
 b=RgN8KgNguTHe2rek3TwjHVGWG+oNODId6f6Mn3H7vaWyoQNWcqXSYoUmbWNGzmD8Szk4WI3kOuTy8dHSgqRabfcMYb8iN9P2zl1MTMansdcfnw0dcj5K24LQgl8GUkUZObWpnkgyr5B2NxcX4isV0d4xsSVEi+HyNIQXC+jSjiQ=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 04:28:46 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::9a) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:28:46 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:43 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/pm: add xgmi plpd mode selecting interface for
 smu v13.0.6
Date: Mon, 25 Sep 2023 12:27:48 +0800
Message-ID: <20230925042752.3847-3-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
References: <20230925042752.3847-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 870b4f67-73ed-4f71-13e0-08dbbd7fe8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krJgewhCZs+XRJ44xEcEuMT6bIuH6P4Daf8RV41Hzd4jXnmScvXfRSRTg0HCKcQL93sqzSOSoPtUIZZl1giU8Xhld/jxrJyO1P089iAnwujnZVunh+MEZ5I+jG5tJHq/aD0vgDdAIvJ9+yqg0xcOZ5cpLP6yTTKtyOh8TyP1WiMqyGAstEneWvfJ6XsRCcNWS+G3G5oA34ElqGtqd+iy8NDF4Sy38DxKMy6YvPYUScgZAuOL5X8SBgXX+lZG79a3/c+wM9chM3Sq1w0ofJPEtlifvqrgADDwfLxZ4vbDZozJEdQP6R5FAjjDJkV0SK4pd3LOo+0KLmlW3A/m1u4bzH31mmckvYRJu0PASO5lXOwoM9Lk+4kxl98c24NeuGHW734ZIGyX+0Vtqk5xqEAB9Bsy4AMwnL4jdg3D9t7N1hAmRcxgUZKa0Ops2TOfsZ1yvtjoO1puoXKYMq1dVdQ2lmkXoKY6bStQd3FG/kvjXJW3IA+cBo++pG0JDZt4xYpDuV1C4XWOjulAZUzZFJ+kMoc/B0xq1a+TJBrcFXeWbar7/3lUtsjzZyiwi8uWQuLEaV8QhZ1Ukmi04Pj8gEI45d2WIWD73eHJFBYy6Qid68S6LXGFwxK8rbHooAdSnL75M4JBa//4b5eMAuSZen2+ZHkxlRXVYnDZ35U+YoXxOBLuOiCqLpTQiYgsgj4Zy4SCCnT0/eMghUTiolsUd1oOg6AFSA2DLGvw5Sdm9cGY0db3EAgybnGOu1CJO8QiS0t7h20ke2dyMKCclk4pBD5jNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(70586007)(83380400001)(36756003)(478600001)(7696005)(316002)(426003)(1076003)(47076005)(336012)(8936002)(41300700001)(44832011)(2906002)(2616005)(26005)(70206006)(6916009)(16526019)(4326008)(54906003)(5660300002)(40460700003)(81166007)(82740400003)(40480700001)(86362001)(36860700001)(8676002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:46.3163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b4f67-73ed-4f71-13e0-08dbbd7fe8a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Asad Kamal <asad.kamal@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the interface to change xgmi per-link power down policy.

v2: split from sysfs interface code and miscellaneous updates
v3: check against XGMI_PLPD_DEFAULT/XGMI_PLPD_OPTIMIZED and pass PPSMC param

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  9 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 31 +++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e6f1620acdd4..893359b26418 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3157,6 +3157,30 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 	return 0;
 }
 
+int smu_set_xgmi_plpd_mode(struct smu_context *smu,
+			   enum pp_xgmi_plpd_mode mode)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return ret;
+
+	/* PLPD policy is not supported if it's NONE */
+	if (smu->plpd_mode == XGMI_PLPD_NONE)
+		return ret;
+
+	if (smu->plpd_mode == mode)
+		return 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->select_xgmi_plpd_policy)
+		ret = smu->ppt_funcs->select_xgmi_plpd_policy(smu, mode);
+
+	if (!ret)
+		smu->plpd_mode = mode;
+
+	return ret;
+}
+
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_set_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 5356b91c6292..e17169f681e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -840,6 +840,12 @@ struct pptable_funcs {
 	 */
 	int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
 
+	/**
+	 * @select_xgmi_plpd_policy: Select xgmi per-link power down policy.
+	 */
+	int (*select_xgmi_plpd_policy)(struct smu_context *smu,
+				       enum pp_xgmi_plpd_mode mode);
+
 	/**
 	 * @update_pcie_parameters: Update and upload the system's PCIe
 	 *                          capabilites to the SMU.
@@ -1487,6 +1493,9 @@ int smu_set_ac_dc(struct smu_context *smu);
 
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
+int smu_set_xgmi_plpd_mode(struct smu_context *smu,
+			   enum pp_xgmi_plpd_mode mode);
+
 int smu_get_entrycount_gfxoff(struct smu_context *smu, u64 *value);
 
 int smu_get_residency_gfxoff(struct smu_context *smu, u32 *value);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 7c300b4d95c7..4850e48bbef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -252,7 +252,8 @@
 	__SMU_DUMMY_MAP(QueryValidMcaCount),	\
 	__SMU_DUMMY_MAP(QueryValidMcaCeCount),	\
 	__SMU_DUMMY_MAP(McaBankDumpDW),		\
-	__SMU_DUMMY_MAP(McaBankCeDumpDW),
+	__SMU_DUMMY_MAP(McaBankCeDumpDW),	\
+	__SMU_DUMMY_MAP(SelectPLPDMode),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..b137c37903fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -170,6 +170,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            0),
 	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   0),
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 0),
+	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
@@ -2716,6 +2717,35 @@ static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
 	.mca_get_ras_mca_idx_array = mca_smu_get_ras_mca_idx_array,
 };
 
+static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
+					       enum pp_xgmi_plpd_mode mode)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret, param;
+
+	switch (mode) {
+	case XGMI_PLPD_DEFAULT:
+		param = PPSMC_PLPD_MODE_DEFAULT;
+		break;
+	case XGMI_PLPD_OPTIMIZED:
+		param = PPSMC_PLPD_MODE_OPTIMIZED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* change xgmi per-link power down policy */
+	ret = smu_cmn_send_smc_msg_with_param(
+		smu, SMU_MSG_SelectPLPDMode, param, NULL);
+
+	if (ret)
+		dev_err(adev->dev,
+			"select xgmi per-link power down policy %d failed\n",
+			mode);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -2756,6 +2786,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
 	.set_df_cstate = smu_v13_0_6_set_df_cstate,
 	.allow_xgmi_power_down = smu_v13_0_6_allow_xgmi_power_down,
+	.select_xgmi_plpd_policy = smu_v13_0_6_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
-- 
2.38.1

