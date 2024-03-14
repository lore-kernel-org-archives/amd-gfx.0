Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C1DC5475B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2783D10FABB;
	Thu, 14 Mar 2024 11:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="unMWJ0Nl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEAF10FABA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxXk6TbvvhZjnsgm5peU1PkiML05AXjereeGx9wSpS7wjNyZ2vwpbiYIezbNY3UynmcfsY7y0u8dJ24DSoxf+5+KJ1HvSbsJ9TNTdmrxOiqFovN9KgKZP++gNVL4woivTIqGufFPp0y3a0L8jBPJqgtGCQxi81iaWrjFtbRqkrv33R/Ic2Z+AJtEJF7VzgqoFW4gV/DGKdx+FaV0HlJGm8o/vEvPPlDgWwJJAxiwLkAhW3busA0NbdgyuAMi6plYmlFhkLpR76UdV/GViFaeuALGdpTzpGuAqo6tiUgL1Vm6h2M+H/0l9jLymhDaTXkLVT+IF3PqYnzXfsyNqtOG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1XpBwkCsQ6w+Rzyy+ddhOW6xgp2b+fXxOawiCzBG/0=;
 b=O954USK6/b4A4r+8RvrDE3H9G4IHMApmAiRc/Ejza2IOArCmu7tOo6QURXnkffQocy9DztAfd+2yS2ZLH9FQSt+gZxdgs6ymBHgdBvisBtC39z4Uy7Ewj1GplUKJ4y1z0IeLleplD6RYIVyfgQlIWMC66QTRI6aDZUiioAwVGRlvjqlcgaOoH5CYcKGEJszc+wMuuPsb+lzUo72UwVMGXmPZDPPETIASLLgvV0PLOYBVz6MaKyxjTYl9pZsSLIarHNdVDeUtVg1VlRwn0CQr0Z35AlT+BjrDV46YMYTs9lzP+n3blZtk79tr0o8c3ocCV8hwV1gU61UBaOAFZR3PqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1XpBwkCsQ6w+Rzyy+ddhOW6xgp2b+fXxOawiCzBG/0=;
 b=unMWJ0NlDlsyOoYCL+iSI80qudNNPnsRm7fV43zgUVGKbmeK7rLkK5LN0cmJ1dPpfkLRv/eBZIrj7qpwaufciVsHvoXTss3g/abpsFrV/nhRzt5ipyBOzKzH2LqXWg336JtJ6t/MIlrmpE9rHvNZi8AMZhjnTAxVrcNums7j20g=
Received: from CH2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:610:38::16)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 14 Mar
 2024 11:57:29 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::3) by CH2PR05CA0039.outlook.office365.com
 (2603:10b6:610:38::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 7/9] drm/amd/pm: Add xgmi plpd to arcturus pm_policy
Date: Thu, 14 Mar 2024 17:26:28 +0530
Message-ID: <20240314115630.682937-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f550b68-3ab9-4943-9cea-08dc441dec5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueNDRkHpUAvHfFXetyUHzokBsFwdUjYA/66F2sZAjtfKt9f7Ys+nPvjDoQzIfKjrOqjjalR8n3kiWcGxigySxkddJbUsBmeISt1g7fFMh+WEbzXNCR4OxgSfk0TizseoatxXPxKcDP8Gcqt6eQmpQDA/IzLxealiCL4SHpf0N/q8fvaVfxPNLWcwWBeFehqvdrBif1eS+QsbUFGslQLye6tqEwAYbB3QvbJXXeYQpzG3OvKsdPZOq3C5daiZGY7qy/fmRyJrqN3LqAdGQsspMwwMxcIikSgML5hGZ9jWaqx5XPCuegdCmlVZG0Oa5Rt9i/hfeGGbdzSdM1pyrO1+OCA/hv3CIRe2hzyKtNoenh3U5rzfiPwOOAGzGhDYYCPLyYAQJ2tmP3oQwr2fKobS3fwMum43O5W7slrlas6d+IV88NRirNKHMwlPt0rOZXpRGo0Xk1ooIg3hxgJle1R/+qW1NAk6uQCRsyHaRejPRGLj/eWx0PHo1EIKddNxulObR9raHkfkyfaOT+4gbYe3k56qt6OWvsWUMoaQa/rf8q6VRFvU8T458VTRPGkPxV+qdXxO9zhday3MQ8jUQHwEQcAU561USgrZliECLqA+2OeAyX+igJWLnl2H5tP5CtpfSl+vs60IguM3Z7fapqMiGy8bZlj174lQriSvCNeozckOFmWCl3SPIBwsyZznQ11y1pgv1V8XGma5MpRhk4v9W2OqHHTqwGfsegZUluRJFuovWe/xj98VdNpmEk2DJes7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:28.9572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f550b68-3ab9-4943-9cea-08dc441dec5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
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

On arcturus, allow changing xgmi plpd policy through pm_policy sysfs
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 42 +++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e5d5766ede9e..6ec0734d34b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1192,19 +1192,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 {
 	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
 	struct smu_dpm_policy_ctxt *policy_ctxt;
+	struct smu_dpm_policy *policy;
 
+	policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
+		if (policy)
+			policy->current_level = XGMI_PLPD_DEFAULT;
 		return;
 	}
 
 	/* PMFW put PLPD into default policy after enabling the feature */
 	if (smu_feature_is_enabled(smu,
 				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT)) {
-		struct smu_dpm_policy *policy;
-
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
-		policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
 		if (policy)
 			policy->current_level = XGMI_PLPD_DEFAULT;
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 40ba7227cca5..c6ee2e22e6cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -283,9 +283,29 @@ static int arcturus_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int arcturus_select_plpd_policy(struct smu_context *smu, int level)
+{
+	/* PPSMC_MSG_GmiPwrDnControl is supported by 54.23.0 and onwards */
+	if (smu->smc_fw_version < 0x00361700) {
+		dev_err(smu->adev->dev,
+			"XGMI power down control is only supported by PMFW 54.23.0 and onwards\n");
+		return -EINVAL;
+	}
+
+	if (level == XGMI_PLPD_DEFAULT)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+	else if (level == XGMI_PLPD_DISALLOW)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+	else
+		return -EINVAL;
+}
+
 static int arcturus_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 				       GFP_KERNEL);
@@ -293,6 +313,20 @@ static int arcturus_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_11_0_dpm_context);
 
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+
+	if (!smu_dpm->dpm_policies)
+		return -ENOMEM;
+
+	policy = &(smu_dpm->dpm_policies->policies[0]);
+	policy->policy_type = PP_PM_POLICY_XGMI_PLPD;
+	policy->level_mask = BIT(XGMI_PLPD_DISALLOW) | BIT(XGMI_PLPD_DEFAULT);
+	policy->current_level = XGMI_PLPD_DEFAULT;
+	policy->set_policy = arcturus_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
+
 	return 0;
 }
 
@@ -403,6 +437,14 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
+	/* XGMI PLPD is supported by 54.23.0 and onwards */
+	if (smu->smc_fw_version < 0x00361700) {
+		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+		smu_dpm->dpm_policies->policy_mask &=
+			~BIT(PP_PM_POLICY_XGMI_PLPD);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

