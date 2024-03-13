Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0CEC54E69
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4190010F30B;
	Wed, 13 Mar 2024 11:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jErDDmLv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84FA10F539
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmrRp63xG269MSZyHBKo+T1pbuTIH7+qG4Po+eG5Tp9jIAA4ZsU6Rve9zDI1K7vxe6OBAEnIza6jvincqN2ga0q+rH3eorHmEl+qQUSoaCBFaetDVtPE4rTmmTUSYrzOtjsfZdwU9l9DBm+IYVSDli1fuLG8lXEpicvQtfKI0brpKOomE9tNu57HhJluaeW1tJ6+X9igLj1PB+NIDB99EQwIOT0Wh2wCdQ9n1WY/qltVk3i/APgqRhUSLSqKtgu9Ud2zcV9pMVmOgNoz/XjZWutnfv8FWFLP2GHZ7hOXQYIgXKZV5uvU2Jjm7cs1T4Ybrxqv64ESPK371/KxDdYy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q16MLgwLxEqdcIHPFpuNZv1C7PQAxKHL2Zvrkj+NL5E=;
 b=nDeE2vvbUjip9f8y4oYV9fXMyJQ3Oea/k9LlEeZjeBB46B/d5qg0u1jKdKTZgrgQ5yC6Y6HEVYHlduPSK5Z+ZfcX06OO9wylAZFelPydpuJZu3m7L61oiwGCd+BPmwZZctFPNgyMIov5w8B8w5t2c/Ks8MhC7+OOyauZN+P7S/DG4tIMRXMYxussmkWtAvolKehh8q8AuI/DJhBIYi4P7aB4Dr1INF2+di8tiL+DpvH55iRUdGtQrNkti7G0GNBXGEzTCGR6IQBKhpTnI2Z2cPbaESdZrCIcXcinrNCp6IuhztFzY8Ga7DuQmAy99ZBVE4hgRuznQHaZd0+L4vw4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q16MLgwLxEqdcIHPFpuNZv1C7PQAxKHL2Zvrkj+NL5E=;
 b=jErDDmLvoNEk6Qt3iTFe74OWZhMiOWxabHMD5+hVaLcGQdsOkDUfW62sn96GSHv4tJskLsYIMZ+OS5YVAX5xRXfTptAmu1F4A5PBOaqTyzbijl/fBzM+9qm+IrfdJiEoXqwnjsm/bzkTiOL5/A0E03avSmtdEE7tNlCepw/FiCg=
Received: from MN2PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:160::14)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Wed, 13 Mar
 2024 11:03:37 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::fa) by MN2PR13CA0001.outlook.office365.com
 (2603:10b6:208:160::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:34 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 9/9] drm/amd/pm: Remove unused interface to set plpd
Date: Wed, 13 Mar 2024 16:32:56 +0530
Message-ID: <20240313110256.669474-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: d56218b6-cfde-4be1-7808-08dc434d3baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UO6egWE32ARunzdtXmmtXG4joih+XFH+TvFwOzcubUpEod77TELFTL01c16jn9cU5uETOGilqXkx4Cvv8T09Esx8cFC8IMYnx7shlyIFUnVhTJ+pNus5ZdpucQT9oqXeP+nIH9LQAsz68VFJIzHqR+yvm+8XYXiU12jcAt6u5CBPDVOKq8d7QGJl9AIJXT5vuIxKceW1wjRcDromo9+2xGfRfCMn37TbMj3I3wH7KzBKX0ue9hld7Cjrlaelpa72qD2fK9VDHlGWLNLGQo22r/LSJJfG0tlGpEB9142HoMuWRC3hpMozBvS4jDjZXbFM3o+vz0nx7Tq/hTnoh1R0IwudoeNSBv267uO/GZpsOYwWQ1VwSX5PTiXV8e1SzfmUhtfl8Hvj4JO5TqvwOo6LjVMuG0yGmyg5ksYqXavl95E8g7meObgqhuLL8TUJNQmpwNwIuBGgaKyuj+okbZ0nw4Tr2txIWbT+WUBSwspTmUeJxSi2Ru6cGbL1bs6zhNuMQxnyM9EA+XSkrJsqEzmDeuqcCZV57bBqYqcx1Ce1uQS+eq/ULmiD0RdsUCRHuDpJEIXCtp4p4Xo7MQHtxqt3HhnDwUrGV9h5kgX0yG1Zkz3tw3KPnQfFlzsW+SpGaFNcMzekWqt2ajteDMfkHFvq+vNgi3vbnDT6kggnRb+njDo27r9huxyiX5dLa603AWCALLWW/VfV2+WV+Thw1kuS1/g13/wa2tv1ayQ6lUaC2ow5JaVe5IVZSmbCOtSchky5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:37.1869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56218b6-cfde-4be1-7808-08dc434d3baa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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
index 943c52d8d0b2..7900e1a84999 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2235,27 +2235,6 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
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
@@ -2453,7 +2432,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
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

