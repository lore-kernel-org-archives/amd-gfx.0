Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9F6C25B79
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF2110E560;
	Mon, 13 May 2024 09:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3PAEkCv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD1110E5AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0yeu1a2+poWns0Ew0mzdCG8Hc9hLJNnqm4EsRkJ83WV6v8QR4TruVQ3gqhOPqTdt0bG6kWyhPyt4vyiZhIPZze12q6mC7qgS7FatdU8vN7a38Q6BavS9AI+V8rrD0455dKMpQr/8Cju/HE7X4Zn+NbaiVx49MtrE1RoXdS/gmX9EKr0xdu/+Kt7GlFCDHVlPpvm2Nm2G8WxsrKKVq36L8kpZFte8yi4g3ciu9vmBAl5rppjKykX7nHOMKMLNkGH3osbHywsUkhRSF4aEGSSNNrAcq07iaWK6B09kH/hIzi4VyJcHWTTywiLNUU4hiw7XZLInu4J8WlyGVgOkEIbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFqR7F0HIHBgl5xU+74IbOwQj5BZKfpVgRf124fHHLo=;
 b=VpQOF0rvFGHts9FhkSIWLbI6d+Ajw2ODJEIxk7gbn3/eWkkt5OKLjkeW0H16iUH7yXMEb5WJNThApEmGUe22yJY566c1215Q7tzGq9voDIggkLoq+aoJ5g0Xy/DE3xbhKy+zjF4rCNsusAgiBYQQzNkvCNaZzlKFzAiaa9NfwjmsX8ef+LCfZUet90BuQgQAzzEFPdaRcc7InAVvRfHd1n3r2wuMvS489hGxVc52DtKSuH2lNnlPHVMKghD5TbisV82xB2Tj8oEHAt7xUS3EtQKasxNjUPLf7ITEYuy0JWtBpRlOhchV8BwPWF2RXgaqmUj7y51G6+PrdlE2B7FspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFqR7F0HIHBgl5xU+74IbOwQj5BZKfpVgRf124fHHLo=;
 b=B3PAEkCvnHmtVx8jOS85s6a3E2liKNXdCxc02uHpmA8FkV6RJHLtjWl+NaQNHaPLQgSi8g4UvwDgzRxARyvOh9qsxXMGhUQgMOlHKHoPQdfNiyXpIaxsF+ZL6FbztUjWwRnqiZVnxRr9STEQsn/hz/hWTVX56+sub4WLO4IczZw=
Received: from DM6PR07CA0073.namprd07.prod.outlook.com (2603:10b6:5:337::6) by
 SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:34 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::11) by DM6PR07CA0073.outlook.office365.com
 (2603:10b6:5:337::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:31 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 03/10] drm/amd/pm: Add support to select pstate policy
Date: Mon, 13 May 2024 14:51:04 +0530
Message-ID: <20240513092111.341168-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bcc125-174e-4c5f-14fd-08dc732e1556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nQ4MrjaJtBVKsQWwZ54OyQcMceplWoeAgVxZxBV6TJMFjJSLwUy4dABz0KKu?=
 =?us-ascii?Q?+8cOjnIMWuvU6OGX2a4KNr94nrmEy8JgqDahEHyK7rh9Q4h16FnnONvUfMJ+?=
 =?us-ascii?Q?aJczimLJPPP59hiHL/NgexpbbV9z2jwpTWwL58NlOlSB4OKWqLBqHlYxwoiy?=
 =?us-ascii?Q?kMf8iaI/Vhw9nJfJ2yM8a4uPIPTPr8KHG46AQ+f2q9o3f0whSo0QitXd/kcI?=
 =?us-ascii?Q?EaPh55VlvpqIR4znQin3WlZQjKRrCVKb2yVV3xoVpPETdYk2po+iGAXBV7Mw?=
 =?us-ascii?Q?ScESnSfzYgl4y19TmCAUEm1pxrPtHvXO5QgYRuKPEurjdAgvi8z/HDwLsZ+B?=
 =?us-ascii?Q?lknCDWw51d1aBa2gD78QfVQPG7ncvOribqOUWRV4EakFJMtIP22ndMkHNAbO?=
 =?us-ascii?Q?ZnxyT3Oe7De1pNAOnx24zmfcAma2KhNLXVpOTkwC3fYjxMqKrDq+StKs7rtg?=
 =?us-ascii?Q?BEUzKYJAmtQ1v9C92V002tzB9mjn+Q3TUdzIdWxogjc2avptjY+1tCkr5Gai?=
 =?us-ascii?Q?uvvfwPumEwF8m8eucIyE5+3B9VsfXwSi0ruz3V07k3DogSMq3XkfX1AUCxG1?=
 =?us-ascii?Q?UV9UVY+zs+DwuxGuIPZmSg8a07LJsE7wuJFz1FkkC8/lW1Vfl5Gl9I6du1yo?=
 =?us-ascii?Q?XDljWVbkfSdrwhSoFaX5TeTaQLXQw5HazitmBDyYjBRWFhSByqhEgVVezSz7?=
 =?us-ascii?Q?yl6m/LrJ1ywWIncDKf2fiihu4BARPvPxWomGNEzyzGgRSxdfs7+x9lmWyzOz?=
 =?us-ascii?Q?1SurEByq0hnNwatZ/cKO6yrrfv4u7s+t9dJt03UMfB+ieCgNc1hpgVs8IdE9?=
 =?us-ascii?Q?vS7Pw5gTGYIH51OLJxvzKFO75tH0XLtuYWOZheht5MauBtwjQRolOlBdSf6m?=
 =?us-ascii?Q?QUciWOS/hlItXh5G71tQMWW93oj1+75BoTyx56gcEmJ/K5mYi69B3zYK1FHn?=
 =?us-ascii?Q?eHiPGc4oxu9ysq03xmivpp8NNR3HR0qy9OcqhWTbK/ZjVd9QwqissjDL3jlU?=
 =?us-ascii?Q?cQyhUD0196OKV5PiOC3A1bUg6NEhx417g9oZUlAR4CJMZJLhqhFNJQZfrVLm?=
 =?us-ascii?Q?/47RD2G5Fy5Ha0NXZBD9Kc9cWcTjJ7QWSDRVvH/EYiqxu1ZMqtKxFT5v3Ibk?=
 =?us-ascii?Q?zM6bn3oHMmgCeHtA2klfdGakt0P1hMIWm3Hozf6axexIPCCFcPT3A9fTX0rz?=
 =?us-ascii?Q?P2bB2Atv2IFjC2zDHm+pbEwj7Z6sRS+2qN+NEcgIHoutWiywaYDDtcb5+bsJ?=
 =?us-ascii?Q?Y25/h+YPQT1HTcwvZnDQyF3raPh3EBZfwq2vCviTdb7yYtC/lp5YGNLBWfN/?=
 =?us-ascii?Q?csNiceSGLY2dzeNy/EmIscGwBPM7wgBuBwW1O5iSz53Pk11mCRhq8whwTgPu?=
 =?us-ascii?Q?s7LUQpQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:34.2483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bcc125-174e-4c5f-14fd-08dc732e1556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
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
index ed9c4866b6e4..0ed0b5326d35 100644
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
index 602aa6941231..04c87585dec7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1132,3 +1132,33 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 
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
+	.name = "soc pstate",
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

