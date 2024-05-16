Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE15C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB11510ECE3;
	Thu, 16 May 2024 12:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hBT+Md1H";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721CE10ECE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnoKVx+iHzs2ctcsbPbodm76JtSr3Vbg5zsLdtc1NGPBwF9k48VEObgpsX+5ZKj5D/R1+jV8+jkWbY3fSWkeXBuBf+mEDWjN5YyCoGeVcVqo3C5BeZYLjN3qTeCNhv4FjsyKBDRzUG8oGd4P0cdkEavVCHoSHFaxxtE1CzRJLCaR6ScNwgXc1KK9TjfuMZYo0ttlOxJA2AZPw1pz5hRHBsp+BxE7WQluuvmythR7/SJ9hecI54/YE0mDajaQRLPiueZJQQESSWXF3Dd9IOZ7pT1AlcvbrHhB+wGs0TVw5yLm9jtnqGlVab/qS8X0j4MdhofsqryG9/JUzB42ZN0n9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJPj5tlW3IPRDgJBu8C6wp67dmEygnfsj/QrP7wctQE=;
 b=WJHP+lV3gOWb5tLcz9weaWCMA2plcWuzvumhGKal7JU+KwSfc97te+4rcBuDprSwxa9isugIXfMSpj7A60oFFLFLe4hRU3g3+RPCTL2h+SS0o/jOCbtrOwHOY8hatXI1UKfyrIQBN/Yj2whw674yLlj6QGHvUU4XXaMUDSSpWxwK3E7XmbgiCMj4vnjQ/wfVfJnVFc1hM+vpWTf65NCBBFYvjY4szffEzkjhREw8sc3SXAsFueO1IWTv6IXrN1SmAToMj83x4vTei/40cEMI7OSXamJrxWinDRi+YpVXWOQimxEXANaFWLRDpK/sHLm8Atee+IHHq1gK6ohNdr67Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJPj5tlW3IPRDgJBu8C6wp67dmEygnfsj/QrP7wctQE=;
 b=hBT+Md1Hu4dSauNsLnCMMoiHXTr8B5knwrT/9DvOUuwhLqyMErLh+PpzKXJ+Y3wi56n6bcWu+zvjxt7Nqq9Z91wC7KN+ZNCRnSNBDPrB/fPMrPqFPV3lblBXLtWeXbfvO66y+F8qbxj5yrl6HkaVM1jeBftzGsiBfgpiuHDX+HA=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 12:43:45 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2d) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 03/10] drm/amd/pm: Add support to select pstate policy
Date: Thu, 16 May 2024 18:13:11 +0530
Message-ID: <20240516124318.508785-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516124318.508785-1-lijo.lazar@amd.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de2e14c-2114-4f75-0031-08dc75a5d2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B9bGDliYvlZv4YKzUSiDFZ0pv3j/k/vJG+BH4m9ENE6LIXZzmMXC9Ms5BXDK?=
 =?us-ascii?Q?4Jl8YiAdhF8+wC84yniECzZ1udA+cqzV9fhkcJsdgC17NBAViKkBhSCe/PVM?=
 =?us-ascii?Q?1dtoz9qr5LZ3H+9Uz8z6DFy0OKRA7lhbBHSmANjPIG3CrdoidLFCpO3Wdqm9?=
 =?us-ascii?Q?Yv+8DVAlKA6roi5hi7lyIktYykgLSjBB4CfIUfQ3Y/Qnbsira8mfOGlw6Ujn?=
 =?us-ascii?Q?qlkUQRigttJROvQmNyJPiLfjL/lTdZRWCUg7ujk6iWZAP+dFmvIAd9EmFDxB?=
 =?us-ascii?Q?fkw8KmsHxj2yS+vD3d8DvFzcDxQQEvk344ubChglgnPSZKjlzqFbcJCSlQVh?=
 =?us-ascii?Q?2lww+CbiwIIdukU21OpDrEx3hnC2nXNJ52BT6++PZlQYZIzXmcdwze4lPH1B?=
 =?us-ascii?Q?E7pSWHUUCE1QJDUIt/afj0vlHHE4zI3Q2gWcw0iKuHcsjS09/yuREK9kYMmq?=
 =?us-ascii?Q?iTMUw/AwMNXFaDDBy1IbdHTgMTfD8KHthBsYHr5GpKiCTEXOlcx/8K72hX6F?=
 =?us-ascii?Q?F0a094+mUO9m3AK6k6jGWSFW5VDD1yIAukZdSmlzm0ZmdTjjcRbD9OuubB0b?=
 =?us-ascii?Q?irVgxNoHe4ZlXg314Xl/dVFlwO3w2weyouVDLy5r2XjiSAI5POPWXCs0pTV5?=
 =?us-ascii?Q?E6jeHainfZfSfxlTm3KTgyOZr+xEJGWujuHi9GtUyg1hHXsD4fHK4iFrHw7C?=
 =?us-ascii?Q?w65o/66pzsKFThbarqPBPMLw/mI4CPCn/mm02GvIKQvIoHfG1dyaeCrQ92rq?=
 =?us-ascii?Q?3d0G1rAd9t8MStGaQxMBedp985oPTc0x2fGLWNROgESofBG7vysX+SATAYB5?=
 =?us-ascii?Q?vPOQOThLQNxfHvn9TJAvc2MS3ZG79O9CwY88RodYFVJb+k9mBML+67JG8lef?=
 =?us-ascii?Q?C0RkDoCTVzhxz2pbQAfYlz4oC1/1HoXPGblgH63R5PueI361M/wjJ8At7n2a?=
 =?us-ascii?Q?HXd/tQsaXnyWFtRYCDN9dM/omXu4/MbLNR2GXtbvIi6gK+Hg6MQ0kMT4Z03k?=
 =?us-ascii?Q?6yIZy4FWVsFPILsChWsf7MLRVbyx2b0HFskmOz/EY0tgQgzbecAT8XO+F4VI?=
 =?us-ascii?Q?0TWb1F7imUgEYfn7I1MBGtUC45Fs9RMGHdZ+6xgxXA0HZ5uDhlW4uBQGAmiG?=
 =?us-ascii?Q?zAfwpmfybhODa34hfLSL2fLh2EoM8N1mO5IRtUJMQxwHgwvwaszjWutXHZhD?=
 =?us-ascii?Q?2kOGMw/BBusrkwXha614ELjRc/Azs6R4DYFBShEi6NcQoMOqm3zM/yYcnPNB?=
 =?us-ascii?Q?56zrwisx2GgKoFrCV5O5P7Savk0XxMrdzDmxi6/YJO+lbRCc6sV1U5jk0Oiv?=
 =?us-ascii?Q?6+RucAzYu7xxWeyKOsx31GnGViwO1Il0nMkQKNJLXsDhgEXMI33gS5h1tSw3?=
 =?us-ascii?Q?zC8MK1c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:44.7459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de2e14c-2114-4f75-0031-08dc75a5d2e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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

Add support to select pstate policy in SOCs with SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
eviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
v2,v3: No change
v4: Use macro for policy type name

 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 30 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9c0445fa9f9b..3a50076e44f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -531,10 +531,12 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
+	kfree(smu_dpm->dpm_policies);
 	kfree(smu_dpm->dpm_context);
 	kfree(smu_dpm->golden_dpm_context);
 	kfree(smu_dpm->dpm_current_power_state);
 	kfree(smu_dpm->dpm_request_power_state);
+	smu_dpm->dpm_policies = NULL;
 	smu_dpm->dpm_context = NULL;
 	smu_dpm->golden_dpm_context = NULL;
 	smu_dpm->dpm_context_size = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ec1b7432c855..aebc7713ce42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -174,6 +174,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 SMU_MSG_RAS_PRI),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
+	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
 };
 
 // clang-format on
@@ -369,6 +370,39 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
+						int policy)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret, param;
+
+	switch (policy) {
+	case SOC_PSTATE_DEFAULT:
+		param = 0;
+		break;
+	case SOC_PSTATE_0:
+		param = 1;
+		break;
+	case SOC_PSTATE_1:
+		param = 2;
+		break;
+	case SOC_PSTATE_2:
+		param = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SelectPstatePolicy,
+					      param, NULL);
+
+	if (ret)
+		dev_err(adev->dev, "select soc pstate policy %d failed",
+			policy);
+
+	return ret;
+}
+
 static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -379,6 +413,24 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	if (!(smu->adev->flags & AMD_IS_APU)) {
+		struct smu_dpm_policy *policy;
+
+		smu_dpm->dpm_policies =
+			kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+		policy = &(smu_dpm->dpm_policies->policies[0]);
+
+		policy->policy_type = PP_PM_POLICY_SOC_PSTATE;
+		policy->level_mask = BIT(SOC_PSTATE_DEFAULT) |
+				     BIT(SOC_PSTATE_0) | BIT(SOC_PSTATE_1) |
+				     BIT(SOC_PSTATE_2);
+		policy->current_level = SOC_PSTATE_DEFAULT;
+		policy->set_policy = smu_v13_0_6_select_policy_soc_pstate;
+		smu_cmn_generic_soc_policy_desc(policy);
+		smu_dpm->dpm_policies->policy_mask |=
+			BIT(PP_PM_POLICY_SOC_PSTATE);
+	}
+
 	return 0;
 }
 
@@ -639,6 +691,15 @@ static int smu_v13_0_6_get_dpm_level_count(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v13_0_6_pm_policy_init(struct smu_context *smu)
+{
+	struct smu_dpm_policy *policy;
+
+	policy = smu_get_pm_policy(smu, PP_PM_POLICY_SOC_PSTATE);
+	if (policy)
+		policy->current_level = SOC_PSTATE_DEFAULT;
+}
+
 static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -668,6 +729,16 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 
 	smu_v13_0_6_setup_driver_pptable(smu);
 
+	/* DPM policy not supported in older firmwares */
+	if (!(smu->adev->flags & AMD_IS_APU) &&
+	    (smu->smc_fw_version < 0x00556000)) {
+		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+		smu_dpm->dpm_policies->policy_mask &=
+			~BIT(PP_PM_POLICY_SOC_PSTATE);
+	}
+
+	smu_v13_0_6_pm_policy_init(smu);
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 26d44a4370d2..50fe9feaf80d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1135,3 +1135,33 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 
 	return snd_driver_loaded;
 }
+
+static char *smu_soc_policy_get_desc(struct smu_dpm_policy *policy, int level)
+{
+	if (level < 0 || !(policy->level_mask & BIT(level)))
+		return "Invalid";
+
+	switch (level) {
+	case SOC_PSTATE_DEFAULT:
+		return "soc_pstate_default";
+	case SOC_PSTATE_0:
+		return "soc_pstate_0";
+	case SOC_PSTATE_1:
+		return "soc_pstate_1";
+	case SOC_PSTATE_2:
+		return "soc_pstate_2";
+	}
+
+	return "Invalid";
+}
+
+static struct smu_dpm_policy_desc pstate_policy_desc = {
+	.name = STR_SOC_PSTATE_POLICY,
+	.get_desc = smu_soc_policy_get_desc,
+};
+
+void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy)
+{
+	policy->desc = &pstate_policy_desc;
+}
+
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 81bfce1406e5..d135d984329e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -144,6 +144,7 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
 }
 
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
+void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 
 #endif
 #endif
-- 
2.25.1

