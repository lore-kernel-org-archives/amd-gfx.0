Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A282C25B79
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C290C10E587;
	Mon, 13 May 2024 09:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YudmR82q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E53810E585
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMgARabLfVAfPXGT2VgRECKmZLOm5rp8yyozvyGWssaO8QGGw2DYJW96y2jXEeWgCzwANezaLAYcsJAzZALjGcCSOdNr4a5l5t5BddzIWENLRvaDDnaZ5IsH/utQXTiPkfr14smNnleGGDFZcU5JukBTqT5aRPtDE8t7YjggSQLhG8y3hfqXDzY5ueIxnF38SJsb1DvoMLGq//tcdOddT16/ffARrgClX7eaDi5NEmpL6glIgWGFmCKnYGPu5p38cGBOsMmoJPPUaGYqPnRDGW72tmzHh1xBbiPfshebsr1mcfoGZj9HGsLHyy+wJb4M7DC93za4y3C8Gnf5YEAeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsHNve9LH9wdbRB8e6uA5evmF0fD08MQIeXahs7+s5k=;
 b=Xll3UKJqEFvJbR+X1WDb2Qbl8PTe/pTtpwvtQ3uKJfiK34zz3O9rrzg/6qKwHgDbQFP4wM1Vk8WTeIHSBKymh5a2Pdx3XSyW17TXuZ9IIVmrbTkHBJVCRM26aVoVV+mb4xdo4jqPGoBAArz+ebCnjzY53mCjA+BxmSiDXl2Fl06zMSeRpyfeWGtm82Ormxw77iiYV/m76SyuAbfQcQxpwvLwAMkSuhOSwUJXo5AYVo0/qODV3hesWRlkDN14ISmIcxKCLy61gA7rKLKzzyH9OPSxoFfjMc9/vGmgIibDzHewbRvlzR/tWaHjjN7FEfkvZc9zz3CR/r/fZd+ZEcuhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsHNve9LH9wdbRB8e6uA5evmF0fD08MQIeXahs7+s5k=;
 b=YudmR82qgsGFw5ZY0Tj083US6Ly2z1tCfOzC1z3rL74ZYwOOfSLeEYv+132oeyQ8S18TdXv5GFTRk92slNZ/7TO0P7nxdw/5aedSWzj7pcNnWL1FbfhQDFI56RVUCHBInG/ak1aLQ+WPoGKOZ+OqT/B8BUFOn0enqwOb1j3qKxU=
Received: from DM6PR06CA0002.namprd06.prod.outlook.com (2603:10b6:5:120::15)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:38 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::2c) by DM6PR06CA0002.outlook.office365.com
 (2603:10b6:5:120::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 05/10] drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
Date: Mon, 13 May 2024 14:51:06 +0530
Message-ID: <20240513092111.341168-6-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 247172d2-1346-471c-0b13-08dc732e17fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HQbaTqhnYvARiDLkm/dLmhHQ2nvSzLgJUu8IBB67zFYMsqhiYIBFuxSkeTQG?=
 =?us-ascii?Q?ArOUgYZjLPRN4QaGGlILnJr7zq3hizAC+wTNBlcYDkP33MaIdEortIl2U+aj?=
 =?us-ascii?Q?o/EBQahmrFm67Bt2XTubNXpfdLOWCoEbAYv6on2ZIVRhI7L6Vlz8x69xF74K?=
 =?us-ascii?Q?ycdIaK6A+tGiW4XWCeuzX8cEw84C+f1v7cRBIK9awQTrx0m+no+0RYzr9tEL?=
 =?us-ascii?Q?dRTdnf2Gwm7M1JcZ8cV3OvvMCzDUNVFbE5mjkbL9v1D8EsqT6OAz5NEMUTdv?=
 =?us-ascii?Q?m65+BAaw0jf2aWWdDzgkOYvYdE8JTZo8rbeOCceob8Hao6Y5wpa1XHiJKayh?=
 =?us-ascii?Q?LQJJ8bVJPQ4oEyty2hQ1As5tu82XpyA6eWuNl5Rd+V13X+IqkMDibziIO0G5?=
 =?us-ascii?Q?QOdQhJEwZM+9biWX1XrS0av8KH2y8cIbeOBW3TlXGe2tIjfdRs7dU/9XmF+N?=
 =?us-ascii?Q?uKZTrRfCCSsY8aOEnI4EtZWgY1BI94ngyUTz85MAIx08d5t/nEvGlPaiOBGH?=
 =?us-ascii?Q?ce82Vma5ckixflF6I/1BY5WZ7YxekI3GArPP4zrb8c7t2W2p0L7+zPvE01Eo?=
 =?us-ascii?Q?ZFhzd7bzc5al+REwSz+mMXM9QGW/uCb17JvHYqMRKjhf74blyOldJD+BP+xH?=
 =?us-ascii?Q?aH15aOz85uMh+Ve+Cy6EiK/G2tYJioR/NCUtMdhTxJRSqPGnzH4M7meyo2lL?=
 =?us-ascii?Q?z1JjRhUSZms0bEDFK4Gq2g5vhBvgd8DL+QlarZiEnjVgV6+9QqeFX2qyinY/?=
 =?us-ascii?Q?hgt2Ht9LGdQaiexesvrC37dz+9gFOJ7+LwnNnLhZgeIu+/EARmaA0p4bScEw?=
 =?us-ascii?Q?6rhE06OjNykgZE1K1S/MJ3RyOBY37brO8kDllZgF+OAwoEJD29RlmO2GU9S2?=
 =?us-ascii?Q?Dg0wW2/e+8/rE1NO5fjFD67esCJ7+xeEh/taDaWb5Jzu71Jp54sqVhLjsx+G?=
 =?us-ascii?Q?XUV9ZDsV4tAp2wvZdynceT6McpINt8njj9ViYlR+OmFhQBmiGnpUWBu7zvwJ?=
 =?us-ascii?Q?Oh/6WbVpzD2RNAc6ysv5VUebFwjHUTIW+kfZByNQPdr/Ktgxxy0NgIEixwMh?=
 =?us-ascii?Q?pMbbIMSHHBBef1dnJVvHmYZvez3m4DMV5gXUZxqLM1E+QCT5aobjQj8dt0Wb?=
 =?us-ascii?Q?L8qBN+hlccehEaKrPRoog5gr1SfVxTubQIfRz1G6KPb199PjaDwOc9/TZfju?=
 =?us-ascii?Q?FrGJq0crUXo8zpMHbsXaMh9MK+9K6A+68mw/RioX4Rr8FwXtRyyl/PB88sCC?=
 =?us-ascii?Q?LpptzY0l4XIkp0ZNQkmnNlM6WvFsukyB6g/opT8Rm5gGa5suTkTEuOvU5kWb?=
 =?us-ascii?Q?Z/MCZl8nscRMgH/gXjcT7+zcf9FusbdLdR8cfPk8kIJx9BwwxvAnMTD2zzs+?=
 =?us-ascii?Q?+XaAZ78=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:38.7045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247172d2-1346-471c-0b13-08dc732e17fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838
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

On SOCs with SMU v13.0.6, allow changing xgmi plpd policy through
pm_policy sysfs interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 51 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 27 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index df9ff377ebfd..a8116ae4472a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1197,6 +1197,9 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 
 static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 {
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		return;
@@ -1204,10 +1207,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 
 	/* PMFW put PLPD into default policy after enabling the feature */
 	if (smu_feature_is_enabled(smu,
-				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT))
+				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT)) {
+		struct smu_dpm_policy *policy;
+
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
-	else
+		policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
+		if (policy)
+			policy->current_level = XGMI_PLPD_DEFAULT;
+	} else {
 		smu->plpd_mode = XGMI_PLPD_NONE;
+		policy_ctxt = dpm_ctxt->dpm_policies;
+		if (policy_ctxt)
+			policy_ctxt->policy_mask &=
+				~BIT(PP_PM_POLICY_XGMI_PLPD);
+	}
 }
 
 static int smu_sw_init(void *handle)
@@ -3555,7 +3568,7 @@ struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
 	policy_ctxt = dpm_ctxt->dpm_policies;
 	if (!policy_ctxt)
 		return NULL;
-
+	
 	for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
 		if (policy_ctxt->policies[i].policy_type == p_type)
 			return &policy_ctxt->policies[i];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 0ed0b5326d35..173c5599279b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -403,9 +403,45 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_6_select_plpd_policy(struct smu_context *smu, int level)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret, param;
+
+	switch (level) {
+	case XGMI_PLPD_DEFAULT:
+		param = PPSMC_PLPD_MODE_DEFAULT;
+		break;
+	case XGMI_PLPD_OPTIMIZED:
+		param = PPSMC_PLPD_MODE_OPTIMIZED;
+		break;
+	case XGMI_PLPD_DISALLOW:
+		param = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (level == XGMI_PLPD_DISALLOW)
+		ret = smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, param, NULL);
+	else
+		/* change xgmi per-link power down policy */
+		ret = smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_SelectPLPDMode, param, NULL);
+
+	if (ret)
+		dev_err(adev->dev,
+			"select xgmi per-link power down policy %d failed\n",
+			level);
+
+	return ret;
+}
+
 static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context =
 		kzalloc(sizeof(struct smu_13_0_dpm_context), GFP_KERNEL);
@@ -413,11 +449,9 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
 	if (!(smu->adev->flags & AMD_IS_APU)) {
-		struct smu_dpm_policy *policy;
-
-		smu_dpm->dpm_policies =
-			kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
 		policy = &(smu_dpm->dpm_policies->policies[0]);
 
 		policy->policy_type = PP_PM_POLICY_SOC_PSTATE;
@@ -430,6 +464,15 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		smu_dpm->dpm_policies->policy_mask |=
 			BIT(PP_PM_POLICY_SOC_PSTATE);
 	}
+	policy = &(smu_dpm->dpm_policies->policies[1]);
+
+	policy->policy_type = PP_PM_POLICY_XGMI_PLPD;
+	policy->level_mask = BIT(XGMI_PLPD_DISALLOW) | BIT(XGMI_PLPD_DEFAULT) |
+			     BIT(XGMI_PLPD_OPTIMIZED);
+	policy->current_level = XGMI_PLPD_DEFAULT;
+	policy->set_policy = smu_v13_0_6_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 04c87585dec7..2ee1862d1be4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1162,3 +1162,30 @@ void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy)
 	policy->desc = &pstate_policy_desc;
 }
 
+static char *smu_xgmi_plpd_policy_get_desc(struct smu_dpm_policy *policy,
+					   int level)
+{
+	if (level < 0 || !(policy->level_mask & BIT(level)))
+		return "Invalid";
+
+	switch (level) {
+	case XGMI_PLPD_DISALLOW:
+		return "plpd_disallow";
+	case XGMI_PLPD_DEFAULT:
+		return "plpd_default";
+	case XGMI_PLPD_OPTIMIZED:
+		return "plpd_optimized";
+	}
+
+	return "Invalid";
+}
+
+static struct smu_dpm_policy_desc xgmi_plpd_policy_desc = {
+	.name = "xgmi plpd",
+	.get_desc = smu_xgmi_plpd_policy_get_desc,
+};
+
+void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
+{
+	policy->desc = &xgmi_plpd_policy_desc;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d135d984329e..1de685defe85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -145,6 +145,7 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
 
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
+void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
 #endif
 #endif
-- 
2.25.1

