Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFACC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEECF10FABE;
	Thu, 14 Mar 2024 11:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i0a5r+8+";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2829E10FAC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAk+fMJ0IMH1x7E+dHB+jrU8bYXhhEgsvIMmLk8o5PEBCaR/QuwZ+3me7EGTkqUzJ58syLviMj6JNKVcIg8RogKQB6UxRSX2zs8ZUwLT4wEG7ZHnKPQQpQMatDVKz30d8vsO0sJXqA1+3vDFZ0rgOprnuMKVhtseQdNOp0FlKY7VaxMXI8qvnL4BlupCDY+KAlUVdkJrhyKBUQA0+M3g8U+YaZcCxVclYIZZFZMfJNazkHiWBHNIOJAjB0+cSSsQKoB4iZkHb38FmikGm8vXfiKo2GxfDdgrZXB/jJ6alitQRnb1vf90Z1v/Cq1tD8l0zYBPp2UO023QUv36Anbpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T3IJG+ZDt3R906KRcyLRGmPC8/C/zY3uT5cjqApnvc=;
 b=KuytfD30L+ReF3lpKU3c5AQLM5VH8Uo7TAkK8QVOuGVAz1QEb4MCtuoI3sgyKM5AnRoQg0kpoh28L/FSEgRWY4lJutUE5OYEPb1iIFBxnxQN2p/XqQVcBS0meEpyrEe+LRDi3/W4pkz1nsUW8tVYTs+SN8Krhe32eAqKdWQci7vVipDHmszxrb/oVMBjm/ecP1pGKqxzQJizEvd42s/dXE32HqeqLv+D21McBAEMQ7RUYycqUjRMom1zmOCGgjovqOwRJou2Eoe4zaqUsrsQwKTzgZYsPViyGDmtPPiZGzILFHPryUtWr5CfmzHnA+oV69o5EdfqYwqyM3zRNFDyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T3IJG+ZDt3R906KRcyLRGmPC8/C/zY3uT5cjqApnvc=;
 b=i0a5r+8+RJuZ62CzwoApyKgy8if0TTOUUuDY18+k5hwfO21OinMx14Z1GjyJeutDxn0KC67hy05Qh2N10mgtlFdgRIuZ0FttAel4cPWKahx1a7ThSLkFBpgF6X55Z3k23qy0B7zXE7znOsTPyyqK4rYb1TQcJaPJOKMXXWisIwE=
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 11:57:33 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::3) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:30 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 9/9] drm/amd/pm: Remove unused interface to set plpd
Date: Thu, 14 Mar 2024 17:26:30 +0530
Message-ID: <20240314115630.682937-10-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: be8cdd57-4ac0-4a91-9cde-08dc441dee89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYJK5XthPnVOFEi7kPpILSMLiK8hLdFnI1uX67mXqdJ4AtlSaHwZYeFVqsIqoHATqevj1iIEQDQfQ3D/FGJF3ofyHh9YWpOi6sIjlG2qw4UwB5mymaFMOJ2z83YEsbgtXG1Xgyh/YZ9vzchtCUUSDy9IFU+wSNOv/wUwgGFfDdtnsb1nD/qvxU+rOWEcyABWtXoFlzEtXTORdLI7s01RK8KMGss07VIARZ3oaHhMjL87771yOUh3L81YIBMoBDZkkixWECXr6mbrI6LOO0gHll7OWfibYe59J4p26O0qm2In06cgjbnyPaWIEJNJ+q09bYvpAwRq2esp3wXWGs40rdCE7cf31K54eUTuSmMoo1dScz+8e0Ay/fXVGy8SHszXXrnYOrS8KkFTDIK+3bLDxXtbAt3WM3UF0Q6JpL+uJNWKgvKNr4gK7LCEFMvaX2CCtwM2jxWdyFPPB8573Ujc4KH3O3LutXks8bkg24z74XSyGDrTeUZLhcEcUbNpn3ra4omdrM2S+rdNVoXPcPdV1NA3/UG5exzG3cdw6+8aJRzMH6eII3dboWRsLuMTWIQr2KfLzkN4drv7Zbmo/ZGrG/D51x6DI5Cofdk28RjbBtSLIXxEHgWdO9w6ZMXULkSqafyNQb2UYPk0EPi9RBX2hgHBuCNIk46y1vn1vRKSxQ6pfyAGzGvmXUU4WUzoGx/fi83Tn9xvn2kYhoa6dWqFik6sDRN5qFaPGJDe5BmvuCjfBZi+oU/E/P97ISJhBdqg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:32.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8cdd57-4ac0-4a91-9cde-08dc441dee89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

Remove unused callback to set PLPD policy and its implementation from
arcturus, aldebaran and SMUv13.0.6 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 22 -----------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 24 ------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 39 -------------------
 4 files changed, 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 5970b99c8f4e..65b2eb27582c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -874,12 +874,6 @@ struct pptable_funcs {
 	 */
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
 
-	/**
-	 * @select_xgmi_plpd_policy: Select xgmi per-link power down policy.
-	 */
-	int (*select_xgmi_plpd_policy)(struct smu_context *smu,
-				       enum pp_xgmi_plpd_mode mode);
-
 	/**
 	 * @update_pcie_parameters: Update and upload the system's PCIe
 	 *                          capabilites to the SMU.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c6ee2e22e6cc..41608be73670 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2240,27 +2240,6 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
-static int arcturus_select_xgmi_plpd_policy(struct smu_context *smu,
-					    enum pp_xgmi_plpd_mode mode)
-{
-	/* PPSMC_MSG_GmiPwrDnControl is supported by 54.23.0 and onwards */
-	if (smu->smc_fw_version < 0x00361700) {
-		dev_err(smu->adev->dev, "XGMI power down control is only supported by PMFW 54.23.0 and onwards\n");
-		return -EINVAL;
-	}
-
-	if (mode == XGMI_PLPD_DEFAULT)
-		return smu_cmn_send_smc_msg_with_param(smu,
-						   SMU_MSG_GmiPwrDnControl,
-						   1, NULL);
-	else if (mode == XGMI_PLPD_DISALLOW)
-		return smu_cmn_send_smc_msg_with_param(smu,
-						   SMU_MSG_GmiPwrDnControl,
-						   0, NULL);
-	else
-		return -EINVAL;
-}
-
 static const struct throttling_logging_label {
 	uint32_t feature_mask;
 	const char *label;
@@ -2458,7 +2437,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_df_cstate = arcturus_set_df_cstate,
-	.select_xgmi_plpd_policy = arcturus_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a0efc3c39e64..94a201f8a790 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1639,29 +1639,6 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
-static int aldebaran_select_xgmi_plpd_policy(struct smu_context *smu,
-					     enum pp_xgmi_plpd_mode mode)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	/* The message only works on master die and NACK will be sent
-	   back for other dies, only send it on master die */
-	if (adev->smuio.funcs->get_socket_id(adev) ||
-	    adev->smuio.funcs->get_die_id(adev))
-		return 0;
-
-	if (mode == XGMI_PLPD_DEFAULT)
-		return smu_cmn_send_smc_msg_with_param(smu,
-						       SMU_MSG_GmiPwrDnControl,
-						       0, NULL);
-	else if (mode == XGMI_PLPD_DISALLOW)
-		return smu_cmn_send_smc_msg_with_param(smu,
-						       SMU_MSG_GmiPwrDnControl,
-						       1, NULL);
-	else
-		return -EINVAL;
-}
-
 static const struct throttling_logging_label {
 	uint32_t feature_mask;
 	const char *label;
@@ -2100,7 +2077,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
 	.set_df_cstate = aldebaran_set_df_cstate,
-	.select_xgmi_plpd_policy = aldebaran_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = aldebaran_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2d6428ca1217..1ed7a55ebd82 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3220,44 +3220,6 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
 	.get_valid_aca_bank = aca_smu_get_valid_aca_bank,
 };
 
-static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
-					       enum pp_xgmi_plpd_mode mode)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret, param;
-
-	switch (mode) {
-	case XGMI_PLPD_DEFAULT:
-		param = PPSMC_PLPD_MODE_DEFAULT;
-		break;
-	case XGMI_PLPD_OPTIMIZED:
-		param = PPSMC_PLPD_MODE_OPTIMIZED;
-		break;
-	case XGMI_PLPD_DISALLOW:
-		param = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (mode == XGMI_PLPD_DISALLOW)
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_GmiPwrDnControl,
-						      param, NULL);
-	else
-		/* change xgmi per-link power down policy */
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SelectPLPDMode,
-						      param, NULL);
-
-	if (ret)
-		dev_err(adev->dev,
-			"select xgmi per-link power down policy %d failed\n",
-			mode);
-
-	return ret;
-}
-
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -3298,7 +3260,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v13_0_6_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v13_0_6_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
-	.select_xgmi_plpd_policy = smu_v13_0_6_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
-- 
2.25.1

