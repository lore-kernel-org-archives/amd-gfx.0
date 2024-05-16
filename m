Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249F9C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9625A10ECDC;
	Thu, 16 May 2024 12:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PoYjVVEM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E8F10ECDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKSHBk5BVduoa+n7kCf6pF8V1rC/ZeHWJpgunbZlr105SO5ckHJIV36g9jJZj8ZSLeTii4X+WFCqjanLvXyIYrvVYViY2Ybn8wNNa0nCKQ9mj/XNMN+MRfEhNpvK/fEjOFbkuolxerhN+iT7VaZ5L/NVTwa9P+BhfmM2HpWR0xrWitO2/4I3qMtYXX52X1c6Ijod5rVNzkbrJtovh24LD50bV0BOfdGnZHD3BnQJvYTSstGvqcprgq6HNbU1x4UcPuwmF8h4n91d95LdJdIPORNEHr0gmqD256oMpxHwXK9oXlb+5c+zoN1Aa5rp/0YMevIjHkHmch/oKuUjXTX7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Y/nTldDGX9fpQmtFjNmnNaWST/kp71UF0kDfL/F20=;
 b=VbIfkmPz+QvVQqGUqjobSRswY807hSF8RKIIdgGQzgN1ZYT9BW/UoSmLuZEz6cJJWBDbyFKXNPtGDDyCwy2cZN4gUXpvxNQYDt56BSYpFupY6DgnxS1T0XjAuHq0LD6aYcgxcsIQFxuho5l+U5aUElGYtv+rfEqFXrwIx1UyxNYj07WV2SsCmOlt8q0BmSWGeDwuCs2/OKL4wBfHwY9wgGGEssh3S3jnAotTwKUyPpmi4EzuKz+mhgJVH4U9vZuNSiHBEiXw1BTVsHg2rr6ejpTxvK1oW+VulOIPOE5jE4AC6WNQCbcdb++/0Cw086FbWj/G3FCV6g1+g8WbhyEjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Y/nTldDGX9fpQmtFjNmnNaWST/kp71UF0kDfL/F20=;
 b=PoYjVVEM6jZlHpWvh4Bq8H8sHKnDcqQ9ZBKQigpUd1+gzWbAADiugKV4UdbIzXtAQEPnzfITGT2rziPaNW2hF9vbS8UJ9nFGQ0Ppt4aSBse2/fK3eC2DKGP/DpdrxTZZIA3VWWn/Mx1IF35tJe7hVsqPpBx3lIQHWCr3uf48TOs=
Received: from CH0PR03CA0411.namprd03.prod.outlook.com (2603:10b6:610:11b::27)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 12:43:59 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::61) by CH0PR03CA0411.outlook.office365.com
 (2603:10b6:610:11b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 07/10] drm/amd/pm: Add xgmi plpd to arcturus pm_policy
Date: Thu, 16 May 2024 18:13:15 +0530
Message-ID: <20240516124318.508785-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1795cb-e78d-4444-0b52-08dc75a5d845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qJbZgpzMEA6VGvQpJVwx0otByEWyNpLZP4zMufs0iNyLT0yePXrpxG9wHV3t?=
 =?us-ascii?Q?sSY1yPQDoG42rTnHsTehTRLwGEEd4K1j0w2veYaWdaTUYdXb9uLwddfGRUs8?=
 =?us-ascii?Q?R/BnDxU6TYGF9f0Z5aIen60nOr8Ihny58G6tdMud/F76qim3w7W6W0RfCtkT?=
 =?us-ascii?Q?YMG5opNqDaVQlGr+J2yieJ0HBTvzggfiZEYzxlGFV0/JmhqYebdpRZ4KYwKD?=
 =?us-ascii?Q?AggbrNZ1BuFG8mOjkPKRdf2OjReanXAfkRdWIe1OOFtqS1460xOdBeraGEdy?=
 =?us-ascii?Q?mwT3I/qYGVUr26oYv2NxN3He2nAzM7AKG2jQpB8LK2kGCigRVnot0pmor7oN?=
 =?us-ascii?Q?zp/y+uMv8rbn5+lCUS/0vY+760hFry+qOSv1B4oWpS43RZPu5V3hPKFGzs9D?=
 =?us-ascii?Q?OFliy9ffTp8Uf2nErf0ISRzrijCUIzgQjqSjJM+gxG+iQ1HfkAhgcHhYgtlQ?=
 =?us-ascii?Q?bct44xT9jt37sb2E7YkeAPez1CyBaPLET9141z6DV0bFVyAj2XqR/1/Uo3P7?=
 =?us-ascii?Q?rL+IxIuPZdLGzCNyD2eTjlU3omjmtCNF1zutnjuUm+bDVp0qzpyioQSv+zRP?=
 =?us-ascii?Q?ITzYB+SjzRyr0Wf78YrJgBJUpysk9UeW+MxXV2vX/4Ldnr6cEPLwle5432FX?=
 =?us-ascii?Q?XCMvdwRqByaYJQ74EYcaoCQPFAeyu6uarPa3tCJHuUlNqOeb5kXBQNU9U9mc?=
 =?us-ascii?Q?LWToq03jOgFEzKHytUtBQ4OgDh0Sda5GRPncSENffcA0XXtIoYaDAcTZ/fTO?=
 =?us-ascii?Q?x4PuRJ94V5tz/ozBVgm+piCA7mfD8CFrfNiUodmaAs2iRSMp1CLsNkH4vEDV?=
 =?us-ascii?Q?ajk6ts6ysjfO2PccgEw9j8zy4Her3F1Rv12ERPPFljvmQ6Dg48i1jDRQWB/S?=
 =?us-ascii?Q?h+Hgv5fYfq7u/PevSr4gHM5s6jt+EepEmoRVhHTd5ku7dNbWsRW9if+3X5/H?=
 =?us-ascii?Q?HAjgbx2MG7YrEJP2dq71mRlEmiohkK2TRfzSHuTsP3a/bICoN8xkoNMxzO/l?=
 =?us-ascii?Q?fDue/kOQW+2bOo1x9jYpYtaLtWUViyPHCwIviPpZ13/ulOsj9cWbIUVrBdqY?=
 =?us-ascii?Q?uia1/Wx5ZLJyMpU4/F5pZ2l/+JwNnrMMOft5zcZSRtVYs+GzgcI3WTQVccEy?=
 =?us-ascii?Q?fgz2T88gpIQiv2oFzIVlIjpBVcM6J4pxvgHfVL3JJu9TODfLEtwksVZ0ydyg?=
 =?us-ascii?Q?4Y40YXH7mL30tuk9dZp8ujiS0bjoEbKadRAiU5fQpC38wGRyekhvD1asF42g?=
 =?us-ascii?Q?tsZYR9OPskg1UcvWTVTO0t5mUb3fmxKDDoiiUVwcfft3Nnn1EibSWyAFtQa/?=
 =?us-ascii?Q?i8XGg+NGxAdXBO+gTjfKYKNnxWdYXR9H595KWjlYd1a0EiVmaLDAFdveDlnP?=
 =?us-ascii?Q?IP8oxxnqeuCuxqEgOxEl9ACp4tNL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:53.7287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1795cb-e78d-4444-0b52-08dc75a5d845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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

On arcturus, allow changing xgmi plpd policy through
'pm_policy/xgmi_plpd' sysfs interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 42 +++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 14d712b0454d..51f78e6ccf07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1199,19 +1199,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
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
index 623f6052f97e..84f7d4139bda 100644
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

