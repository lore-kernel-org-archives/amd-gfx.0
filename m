Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7282FC25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DF410E585;
	Mon, 13 May 2024 09:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rf0s6NTy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E4910E582
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T41rtIeTgicAFWuC1B/UjEr+yQA+9UR77xZGQLSuV/rTyrYgBCBtLywGty1dMtwgqZbHm4ChRV/eRQ83sMDsijDZu4IL8Fb6Vxg0b9fm6awjoh4Wi24cwpBdHDJVkMBAeSrImoypPsRlIpMEN76GAuwb5TSUXQoca8594PdNmN9e39DlPD/0yLtQvn6rRjHFgTWfSEQ4PbSsiqR8+C/6ArRMG1QWG4/NjPdpXuLNfEQTfmf+f8Q6xMjf9qqr4IJU5sujDHPkNG8/NbzeJx4gHq0AIUfxvX/RQ55RGL++3frsoQySx2hthNtqejmE2sQoJYfVSL6cVe59XfcXjCX4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stoeZIq36qpkexTOhGaF/I7mq/zYF80QlPHZFIhs4ZQ=;
 b=F8mJIMA/CvIo+njCBEIleNr8Dwi+o6MIWlaRnPnmxONG8M0Bb04fu9tuAM03iLmwC8zfuTZwteheeL1OMkX/dBYOkvQ3o0NfJHlCDIdUxezqR2lgxJWUBbatwBqJyH8aKP7k8+R4zGrmz8X/7M59AeOtarUICrn21ghoA3JMvbeBxHR//uHVzIM4zVxoIpFIGP9I0VJ5EGkQzUjtMaL5niC/4kH6nvGIZteyb6r8LlUq8X4kp1GMVFa2rf8wDtGwvG9maELwBe2Ug8O+iV33/C7zJsxsSv5XGoNIHr9CunDlMWRbKYhJ+JOfyqj3bTFZ4wSF1BxF67QwjygMdlufjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stoeZIq36qpkexTOhGaF/I7mq/zYF80QlPHZFIhs4ZQ=;
 b=rf0s6NTyRPq/+3BeesEbSgliatN2COXzxXJFhJG6086wPR+kWJlDVN+dY2xGFzQGwQ7apWjpln9L+MyJ94aQ7NvQvay0wPZc0dVuJdK++vVvq6NglrhGu9SqlOiiEde80mLH8G5MOqm+R8ZX4VlWT/MRllQUHvENL4ICzY/RkiY=
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:46 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::ab) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 09/10] drm/amd/pm: Remove unused interface to set plpd
Date: Mon, 13 May 2024 14:51:10 +0530
Message-ID: <20240513092111.341168-10-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bdd510-883b-4b7a-4efa-08dc732e1c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/qLgckVo9XDCXcVx1bUsCHV+uI2ib2rVJx6MWuxfzTU3J3CjQ7EhvXPZcRpB?=
 =?us-ascii?Q?C3aG9BTp1ttrfreXQddmE9lG5Axo1595lQs3JqbkUcig+bygwg5/+qkjwCfT?=
 =?us-ascii?Q?W5FaZc7czuUwG2gVOfnT2PklRiCvMHUHiLAOEe6s5eRLdApfuhceQE5zWXmJ?=
 =?us-ascii?Q?KzNd6kw2qg43Cydf5z/WpTXcq4WgsPOGcqW/Ayvq2vrQchTCKvlJ4KrUxTEn?=
 =?us-ascii?Q?2PrmRwlNnkhpWDBTKorPDVtUYv8PTF33XNw4KqUqoglkc+1pJLedJDRmBHhK?=
 =?us-ascii?Q?WFVpDmv6untmqScb41AYpB9sRkEhqWQ73qa1RK7paKHCRgSEYaUc6yWnsPKh?=
 =?us-ascii?Q?se9piDp2RRVXpGgKg+NQiTP583M10kvOcV1XhMOs2gi9dRutCK++sM5NyI76?=
 =?us-ascii?Q?3pBA6D9fnc1tgolDV51hOIbGWPeMPV9KLfxTWcw+7MMF5rtUZ6YEwBDbppTR?=
 =?us-ascii?Q?6+n24CMB7YXp4D+UKk8i4rgIKmhYubjuoP9EqzEwWU2gyfb//NnxsIVWJ5BP?=
 =?us-ascii?Q?9UbVcvMDlEcoeTOd21/IE3ZkdPqCp0jHhcx/gLc00tnlzRhawPMsYc0HoeeP?=
 =?us-ascii?Q?w6+Qir8qzfqAJWW1QjukbfVKfnfYvtJDAn+Ynl4PhmuzBOQjj4NdosTbh3hE?=
 =?us-ascii?Q?7wo+lnjgOpVC3pE/IRUkMDvh6jmyZjoCClF6XnQ6RjlekmkttIDRV2Uojl+m?=
 =?us-ascii?Q?GtPaauXz9N1ND5XYiCdW0pxhSw9S8+Tdxk2cfWrHm9bGuw9WXB2efIWpFDuY?=
 =?us-ascii?Q?M5Sgv3ZM3laYG5TF2uWGQ/ak8bUKxHvu2pbRBTX73iTk+xOc+eDm54H2+Io9?=
 =?us-ascii?Q?KotAktitULTb4RJk+ycct9lX++K1twKfCSWrlmCP01U/+/dGRqAN1wwK2E22?=
 =?us-ascii?Q?B7czN1wKqEqaelpMVbF6cU/EZV43FyZACAIyGka58Rtb/Q29IDICOrXULGNK?=
 =?us-ascii?Q?LUfKuyXt9vDczHAjmRCxCQwpjk4uYN9RbNFroIp/nykur/0F0wKNLmsZU82p?=
 =?us-ascii?Q?b9bFIKUne9M5z/n6u5rFjNr9aPaQGMJQfceBKejQg2r9PF8Dn3kgW6IScm5+?=
 =?us-ascii?Q?xEjxKgp8wJPqwm0vHmVpFAvye9qZUKxcf6zK/u0ko2lky0ALWaQMi0sH/4Zf?=
 =?us-ascii?Q?xf4Vt4whAD9/VediRkJAwyqouMzb2ni76w5ggYDOKHZDNM/aofJK/yO298+O?=
 =?us-ascii?Q?7aoD384/6O+IHy0Zn0TWFj2qKggzER9/klN+w5PpLpSfxym2Vqt3YeGAq7Gx?=
 =?us-ascii?Q?prDOV23cAu8aJCid58f724Y6JCqbVqoxZypnKHnfN0Ih/Eh1uLqD8GvLmO5B?=
 =?us-ascii?Q?VVd+LkyziXeSW8kQN2thh99uxNPj7TulDZUYicFfe8vDdwboH19wmnE/0tUW?=
 =?us-ascii?Q?W8DhN3Eh4JAwqziUvMh8WPZTzuWy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:46.0225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bdd510-883b-4b7a-4efa-08dc732e1c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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
index e460fa9aaf23..dd9356c7428e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -876,12 +876,6 @@ struct pptable_funcs {
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
index 84f7d4139bda..c0f6b59369b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2222,27 +2222,6 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
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
@@ -2440,7 +2419,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_df_cstate = arcturus_set_df_cstate,
-	.select_xgmi_plpd_policy = arcturus_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 66d386ef1da9..e584e53e3760 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1642,29 +1642,6 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
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
@@ -2104,7 +2081,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
 	.set_df_cstate = aldebaran_set_df_cstate,
-	.select_xgmi_plpd_policy = aldebaran_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = aldebaran_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 173c5599279b..386b2f961349 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3240,44 +3240,6 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
 	.parse_error_code = aca_smu_parse_error_code,
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
@@ -3318,7 +3280,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v13_0_6_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v13_0_6_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
-	.select_xgmi_plpd_policy = smu_v13_0_6_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
-- 
2.25.1

