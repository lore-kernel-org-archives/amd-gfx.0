Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802FFC54E6A
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECFF10FABC;
	Thu, 14 Mar 2024 11:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZSxaxll5";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 215A210FABD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbKCELdIecn6l6s7oVFmRqKlJXAfn9OU2izjQCD1SpHBVs/QWA5sZa/qQCBTfIJubUPzy1Cc3MRJvk//SJC+3x/eEoV8v9l0wCyfrJht20QL4hANjKYLpvRpvLWt5g7bdeo8tq0t/TBT6TsKsBhQaClVyGatllEsuTSy+8EBQ+tSpwjUceCDn7RB4CzjuQ6zw6jBI1hedr92WWknPvNzSRNvYMt1Tdhnil3010VRhvLRiMNJ0D+vUwm8xRjovNpdvEsVJvwI9KRmAcvXussyMWv920LqOxAUUMlLDUopNDJDGWej2TtatBXveWoIutoZjuVAUZ4LM2IlWc5KjMGZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLxWPjc+c8cwaS55rcXC80dme8LwThU/ZPQE9BDNZHg=;
 b=hvQkKYfyvnlh70uhC2Xc69+hFjW2e9cRWqkr/hzh8m5Rrr4m4GVwC+xbvj3k6wPGeOXmqp57NHMIsPb2WMMJ38XfYlPRZmoT0Zlj6iX97gYFdZg6MVE/nGYNqIXvesYjrcLuJrjrYCTMdR9vHGG7Yf/OgF5sWXr+E9FDCAIeGJKHwQhdI/Su3+oLsa2OuidSc1ONPOVr8/eHkSOrRzXEGE5d9fFVZ/gPvphoIpClpykYCZVtPm/27N6M00DGNCeto6hmylNgID5CQrd6v+8ZBnVfnPON4jypurgPEYg+0qYR6v6AeJ9R298s3q49NshXpNysMmCebIJHVy2sowyXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLxWPjc+c8cwaS55rcXC80dme8LwThU/ZPQE9BDNZHg=;
 b=ZSxaxll5i48Z2VIh3PlDWbfaVo/uypEzc/7H0qPAGpEyq2Y1v4vWsRd/f62UOvDJDxb3GW7cp+qW8jw+RWiR4D72Ol7+qyTsDneAqOVKRj4DFVzDZ7Svv82Er0sSztV2doSyjYVpkYZKLZEn46YVV3xuphjo7DPnwNS4qamqH4A=
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 11:57:25 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::72) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 5/9] drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
Date: Thu, 14 Mar 2024 17:26:26 +0530
Message-ID: <20240314115630.682937-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314115630.682937-1-lijo.lazar@amd.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c6c358-493c-49b4-66cd-08dc441dea39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMtpxGc/6LJpALSPqRug1t4hLdEKJucblz30OwS6gZNC7h5MwHPmV4VZtSyEQKsYxR0VSo4JIXNF4UvXjKLfcRHYB1Hi4XXQElRj/gIOH1v2SHDPbs0zIAsqMsOUiGBMcrWL4vvdxroFOG/lyfIX3mqvJLcNJWaP9A8u+EpYqTEoNEacdjFxY/hTSEuKwnt4JqH5jZAzsvMZlneIgKGcnH7AnswfXWmD1f9Enfq2HKGv7m6DmmsOVp10lRGmdxiYXz5scyoRlpa/qb4piwvLqBpnIEUp4Lv/vMojP6TmssPrTSUYMjfe5PrHaIxj6syfJEIfZJphPIJFs+URylH/mSK+BDO++dvmDwZ7Qho2aQbT6kLV7puZfVPe2QZEeYG5j4SU1PAwqAPDUdkmwr3/YJTpSDoBTkOCafy+0WMFwQj1LX3DVbnnkNuK9jil9JuD0Kv7UY5N5n51J+Ft9h/+ENlwWWmZA5YK3xyrmbZhseQyA3tUP9ckkED/7JwiAtmE6A3cdq6QB6u3v1CoMb9uE/bA/ynDoZNvbE/kTrCF4FUDv25Lu9luVB7AFQn4QiXsQ24WHFHK6yaqexe0Aip8qx5sap5/xoIcK86JuNTgeqJ/KjTCijyfiSJVx1V5LbUq2a2QIEON+LmL4ANbCQp+UGAQ+XLBO4a2O/ZZGJlMuEOF4ruHmk+YI5HT53tG2obBsPBxiGnERq9MKIEohpuzSUJp6ntkj1zpyGrMrjs9mIhyUUdq4RRS1HKgU70ccolx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:25.3669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6c358-493c-49b4-66cd-08dc441dea39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 ++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 51 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 27 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c23e0985377..e5d5766ede9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1190,6 +1190,9 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 
 static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 {
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		return;
@@ -1197,10 +1200,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 
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
@@ -3520,6 +3533,8 @@ struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
 	int i;
 
 	policy_ctxt = dpm_ctxt->dpm_policies;
+	if (!policy_ctxt)
+		return NULL;
 	for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
 		if (policy_ctxt->policies[i].policy_type == p_type)
 			return &policy_ctxt->policies[i];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f227f05100f8..2d6428ca1217 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -402,9 +402,45 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
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
@@ -412,11 +448,9 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
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
@@ -429,6 +463,15 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
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
index ce14d94b9650..7b5bcec583bc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1109,3 +1109,30 @@ void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy)
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

