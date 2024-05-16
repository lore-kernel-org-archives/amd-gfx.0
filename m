Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7420C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5045A10ECE8;
	Thu, 16 May 2024 12:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SJjoaNjJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5319210ECE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRI3njwFNJl3ul42fWqurP6t7ZEN1vYIARrn8Qlgn9IdRGEVDHPdbB4qNA+yPbotPM7tWXvRLutizbQOQJkdQml2XCtoCiOpgXO9OmZktFQSdbRX5m/naXfjmSRT8oq3DnXVWSbXlAzjTNkJii+WLVE823+bdMFzWxmrE+T8z/In/qJlHYV4HGwxca9hEqmKQuilmuyF0qCOgJyjgAQ7QG4GLMlyGvk4uwm3E3LrjcPRX5gqg4RicsNuDkKZSCJvLARN7ga4Z37bJZg+LatGzqcDxX8j7gK0G3OdHNjba8c+73cF1bdr3xQIF5X08BWxUu0gbNpmXY/QiHaj2SyROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ilK3kZKdyuoPiFvRetUmsMx5STy3QSLobOj0jqvzM=;
 b=cFylZCqb43qaSa0kosyGtjSRsbk96fHeJTjLulivtXtgAdhTH9yfBChHTDqU+ILi8zunefj+0R1+bcbvCJ+bN733frF6RhQuzOrHGC5EmMbVHXc2PWIotZ3hECn5JSmty1JNzU+ZtE63IVbNZM9sMtPxAzcvCNgwa16Nx5RjyhcmSxpG0iwBdDsTK93//pf9A+fIVr0qRvnNCby6ajXDZVmubZgAWOJYwYbaFX5A8d9d+oF5v/4UUYxb5F0/ybgk9w0WBs+vafbUIcntPLLeBUdv9/se4C6W5st4pYWUJoPf9fJYtKUxapZFhEpr0uYGEVhxj6VuBQVGe1FN7ksrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ilK3kZKdyuoPiFvRetUmsMx5STy3QSLobOj0jqvzM=;
 b=SJjoaNjJ99Oe0Wh3A8SrRqM6d/V2gYYj4FQx3WFLIUy16z/WsD1iiCl+IX5BxRJA+kZ1VoPHTKNANxBJXE0AYjs19gcW5gI9h6EUS5Zn5y31I3San9yJADuEATSVfUXbIwhuFORAOJ+7xV8TG6TrrX3BN3GUMUCi/ejXaW41rA4=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 12:44:00 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::5f) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:44:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:55 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 09/10] drm/amd/pm: Remove unused interface to set plpd
Date: Thu, 16 May 2024 18:13:17 +0530
Message-ID: <20240516124318.508785-10-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b263f5-fcb9-403c-cafd-08dc75a5dc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVDQPQy9Pz/CUIT21ZXAQ0dn+pBvRGfS2wDcOqYQw5LxB9AvCiY6TeSLuVAU?=
 =?us-ascii?Q?XPzO9oegOYLqIzHJF6DY4VTVZwuqcfGRADcJulodnIgu1zrWgNz9sbRrJ3VG?=
 =?us-ascii?Q?uyeMy/o1L2F8TAIBT1A48wWJ/DybPgXAMy2Ig5/L4dPNtTy4kqHAMPEJZGhk?=
 =?us-ascii?Q?GIAZZTJ7t2DSV5G/rKuZxLTRv+FzuMrT/YqEkuuvjmFDNBak6SYEFknluFi1?=
 =?us-ascii?Q?yyJtlfeMw/uyBDFcUeXAUHM83z2sk+as8GlxryifGLMqZp2oCy13q/HNDV4p?=
 =?us-ascii?Q?6gBCjObTpzHF+rZmmPDink5ZLnaQldG9DT03es+3XiXT4uXQcGQsVCSDlev/?=
 =?us-ascii?Q?O/C0pCPDUJtCGg8gbwNUs11PTQPZb0sSoeZgfR/WaPo3r+I+qR8lhO/WEYIG?=
 =?us-ascii?Q?/lwNbwslSuxiZn/+CWBs9JaUyHqMpzX9lJPqblcOyPjusSfjeUVB1RR9XSGN?=
 =?us-ascii?Q?bXdhGc/gEHvOtOx7zKmsZPXfzCc6dFs5N5qL6Cg4WvPXmZoDkxgDXVHnjvXV?=
 =?us-ascii?Q?RpFmDIDW36GCvycP4QRVn0CiWfCbLqBlubU0ECZT4gEii/CA8ZtyNDoo/TtJ?=
 =?us-ascii?Q?6jNUBoW/ReAR+BbYzjJ5FlF3Ov4jZCXrUJ8cdLbxA/qqnr/Suy8qgIsUu/D+?=
 =?us-ascii?Q?x1mPcqghXQOXk5LxbeGzlLb0JZebaksI87Bi/AttxdLyn0B0hmEoWsf6rrzc?=
 =?us-ascii?Q?VeDxpeCfT08kxIfXQi+lfPAOZp9zanP4TuGHchdARQVUN06mrbf4IpLNzZeD?=
 =?us-ascii?Q?gS3hKTwChGqCOy82t2EFr/fQmKYPelebXFgBLCMlxZVxTwxNz5BsJLj/6I5d?=
 =?us-ascii?Q?gNvX27nIwEy00mqMoq7I09/Kh65GE2fEyDMQDHZCF/3/0ksKWGFN/Zgidmuk?=
 =?us-ascii?Q?PwGZxNgZQDk6Wifb61G/gmmvQZyJpjJGcxK+QkIJHrXxO0ILcPzVmxKEgRfP?=
 =?us-ascii?Q?s2h+PcTHIDddVA/nxZgUbkrlPmzN7V8vHRLhE9gZWIygvr4TlX3LeY3tdBTk?=
 =?us-ascii?Q?JiNVutPwb2FNO5sdRqceRFMRtzLpiGf+5odVzYj1SGJMXAEA19pR2EY1X0jA?=
 =?us-ascii?Q?ig5RB5Je2wBwVNyBlCsjTzDoyf3nSlQeZZqmyBrOz/QbmNJDVMod8QMqotZJ?=
 =?us-ascii?Q?1Ers7pxiN2JnQIkGJvnopfbqdyBqfk4H5Ue76jzToi8MciowYJHRrsDIu1wv?=
 =?us-ascii?Q?0pQWmngwTCpclTP0BMb+tQP+CJe5Yax5sDpjFoYwilSL7eJuIjyRlvPiaV7M?=
 =?us-ascii?Q?nTHJk2Xar8F3iXb04aCmZbj76PcM2A5aOKUlgOWRIXg7YZqo9kt9XtTgmpCT?=
 =?us-ascii?Q?qXO98FhKEKjaDJR1t55Hyjoe6BZHwx/mn9qSQ7cbLlGyU3dBtU+sWwQhFUat?=
 =?us-ascii?Q?byIVFOGXh+q8gNTvG+3nb/x7Q9Km?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:44:00.3225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b263f5-fcb9-403c-cafd-08dc75a5dc30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 22 -----------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 24 ------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 39 -------------------
 4 files changed, 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 7030bc008883..3f94c33df7b7 100644
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
index 66478cfb8b77..825786fc849e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1643,29 +1643,6 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
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
@@ -2105,7 +2082,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
 	.set_df_cstate = aldebaran_set_df_cstate,
-	.select_xgmi_plpd_policy = aldebaran_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = aldebaran_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3fe158e3899c..bf19810beed1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3250,44 +3250,6 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
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
@@ -3328,7 +3290,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v13_0_6_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v13_0_6_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
-	.select_xgmi_plpd_policy = smu_v13_0_6_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
-- 
2.25.1

