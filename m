Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CEC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6C710E8E7;
	Tue, 14 May 2024 11:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHHzmvRU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FBD10E8E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwSgIGx3kFsDnNIQLiUBYltDx8/j+ZJTuVlGj4PiL17OkPw96b6vs83Rowxq17G3FfDPzho7vb0ffgMF1a6iaXczxKA+TawRXrbaxOz0mgbvkFTGxwlVz6enIGyrKIjuMitOxIskK7uIT9bixpBstOoIyLC+1MrpuacVC9fCPElW7CQGxaziJQIuVJDvrOQPW+ssl3EySUKPBpD3y/LIjUvoM8OB4BWz/HKZqMg3LLJksJeHz66zIbyl3wpFTyZQwLtlw62fKxYtJoNYClJeoTpns4c6MAAt+RDGpWSyjScqCy2x2Nq/yHDoacWao+pvlirH2bUXuzDIdcQZzGaZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4+h/t8KDg8k/T+YRXzSMgkWsfVTTQIQ7TktUAqARFU=;
 b=lP+q41/gbbfnVaXaRscrjtG986HipPImhHzsNr1VioiSuutBeuq4i5wUKC5mVVTa2fQYQ4BEd9rtWCSoO/MPkO/G1tYYn4rpZCOdPhhU4IVI1tmIo8QjsN7cAF1RfW7aUP+cjmQwizwdaaBLyB8O5umpezVXlIxchOilP03KE564TbWlDAwOm7oyZGFQzDjXtC2fm3SRkEPwCDFknMppbYiJefeB6fxpUFgIVaW7G45xym5XXLo8M/sKrUAETaQH4Js2cZL8EgVb4hLTdq/FZNyr4A61jsvVqaXESBxBfQSOH5s/5yDoSXq+BeZ7uAnDWWX6J7kBLFUS1oVl02Q3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4+h/t8KDg8k/T+YRXzSMgkWsfVTTQIQ7TktUAqARFU=;
 b=UHHzmvRUizWveAdSIr/9cxMY2NRafxPS3XpGX0VosMOJwQILt15QUkif4MB3Fx3h8YeqC/P57ZDD85JV3rQVdyHWZbAwvW6lbF4G5z1gHHsc8zrcXeLWlvQSrxyQbT7SVAaR43vMgAUzkBAZQViMB3i1AafWpCbQ4hTRCZ6z5EU=
Received: from CH0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:610:77::19)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:06:33 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::c) by CH0PR04CA0044.outlook.office365.com
 (2603:10b6:610:77::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 11:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:31 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 05/10] drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
Date: Tue, 14 May 2024 16:36:01 +0530
Message-ID: <20240514110606.396234-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bdb5e4-1a3a-441b-2cda-08dc7405ea45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3KFyZ0RGaJTzLM7trH8bZHSdtVdXejXQ4MJfYnSBbPjHGHDW7h/1dg4o7C9I?=
 =?us-ascii?Q?dYJ3LcvnbcyYrfaSNVNXTGj7GK18Ajv48e8/vE9KBiRs0SKeucXQHzTBeiPH?=
 =?us-ascii?Q?ymao9aNY5Jvdij3ZpwJSq+zP5wRnqPf0rK+LRg8lQpNcvreSLsEBsOIDNWo7?=
 =?us-ascii?Q?zYEKpcIPRBHWqUE2MoaafQZb3w7Rsxa48eJxvJ1dX7g/0p/AI3aremJJXpk9?=
 =?us-ascii?Q?cDIz+r3yMro69y+nSS1tRyUgeL/t7+ZRCdztjbhbSGo/KF9he/k7Fs5O2fas?=
 =?us-ascii?Q?5lfsYBdPvSr8uGIxbTaZmvT4JIOl0z+gdJG9CoqQAnDLLobY+NP7UymR+llx?=
 =?us-ascii?Q?cIbqswVDzOANmB1XpoBT+zHUvwsNG9P6n7jDKMIvTnj0Jut9dvr5CrVrnOT5?=
 =?us-ascii?Q?2uudGRCF0xnAz5CWHdUqZcJokGZ9yuB8tuxjTIujJZKHZQ0FKlYWv03znjKx?=
 =?us-ascii?Q?K8D3B7t1o1fD5FZqdvyBclPA4VWWNd2JBZi4Z19byio4kFki+pp4Inxwul2D?=
 =?us-ascii?Q?bWC8fxvlPu4aWYZhe7bAYOpXMY9XRKA/j7q6dyz8OYaxg1jvvFjaaGe2+78e?=
 =?us-ascii?Q?EreJUGN2AcJ6VO1roeHE99AXg9TIOev2WEfBLwtxMudeSG9aONIjjAagwG3n?=
 =?us-ascii?Q?R5AHJoXrYkIbQMbPDhXHtdTa/GTfdfVbADixqkcLAdnk1xIJ4JAq8XbU/mfZ?=
 =?us-ascii?Q?Ji9MHbE85EN/d0a/oQr9XnIAKYNDwX7AEAfzadabvIzgWdhAin1DTHmCMlCW?=
 =?us-ascii?Q?RtYZdEuUfrygQ4VY7s60ZTE/G7o/b3bIfbNlyPHUWlNpsnLu4zBb49rT/9iY?=
 =?us-ascii?Q?d/HZFLLjUD6yG3XzrnDa3d0ZLvsl2AZ8kEw08HdcvfjhgStcJldrNZ8A4+lm?=
 =?us-ascii?Q?QVjOuIhg7AT4uBkCMJY/dBt265jM2teJJb30WjA4cc9Mf+Q8ZlR2f9povyy3?=
 =?us-ascii?Q?KNog0KTFJcEkuAeep9BFKptlxnmc+ykMR0Pu6ofEG0MjkKU0NaQVKHJ3+iXX?=
 =?us-ascii?Q?Ot3ispu2jU2gAMhOGtVaUlRXBmuOZptu1xCyz7gReJTGNH/vMrt/j9MDVqK6?=
 =?us-ascii?Q?TAihdod69oIZ8yg02KgAUZEl/S4ODCEd/DgjHgD5l+GC43CTwgwFSiDeCfpt?=
 =?us-ascii?Q?8fj+j+iByhERy3+Io3NM65lH0ryVPW9CfuAiLC11TYYOx97JPeRjarcLNb9n?=
 =?us-ascii?Q?9bB4nuApm08BWFOM89iAZMT5NkVxHx7oUN134QScCHCZFLH9OIZ/tXbYnBW+?=
 =?us-ascii?Q?/yywVGAah6qL2EnQv1+iGc9KalVq2LPoz0GxSjb613ujAPVcpPby+jv0JbYZ?=
 =?us-ascii?Q?vIimAU5q61jV9E0993KKK2GH6+WHzvcYjHO3ZrUbIRn3O84tBKKHVRhBmKuV?=
 =?us-ascii?Q?V4Uz0xE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:33.3359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bdb5e4-1a3a-441b-2cda-08dc7405ea45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
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
v2, v3: No change
v4: Use macro for XGMI policy type name

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 51 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 27 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index df9ff377ebfd..2a8d853e6346 100644
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
index 27e4a97411cf..5592fd825aa3 100644
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
+	.name = STR_XGMI_PLPD_POLICY,
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

