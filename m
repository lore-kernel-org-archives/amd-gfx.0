Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B592C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC03310E83B;
	Tue, 14 May 2024 11:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RVtXmcyJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6F510EA06
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To9qzuUfU1ZjyumHEwlPk+eMj1lam8dzfiv0NxeAy2/k3s5grgS1Er+ZATJdNjaUU8p/Yr4huLpDPp5yJ9TKWe3ASP74vgymoQpYGKqJl0fdl3UtD22UMzzA0Kh6R3oUkO6aTFn20r+GFRLIe6qRxAjzTeOGOu4LPQ6QxHa+THMjDPxIxueKUVXlGqItwb4Z3SkRinaoVUkLpO5f+lXyVewyN5Ggxm4tlr0bpJcfVKLNtC/eNPlKTYDyRvBR+Zu7ogBFRAySjPEBjx31q6oRo8HYkCzyHFIxDgkXyyZG8KIFvDkV2nJOWNVNykhoUWJsXgcIynWYGXMHjDl0EKohmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UlFLk6UgxzpK4Wt6n+IxzquGECGP5/9K6BTrhObtM4=;
 b=mWSFu1G0MT0BkUnr935sVU9lsn99TcXAZgTNtrIwJqQfLTXI1Ph7Z9nLiDWRUHdPipp39/m7nu0Z+jcayqBvRzdgj7l57Yw5o5zOninxjTWf372w0yONptb3ODEFdyLjwdSqBpcwEnXsIL8KgzK1KL93IuHGoiJpHMzDkL0r6q0uweOmZAUO5xZLPbB+vWmYqdxtDJso3qr7gefLujC4Yr/u8Fqtu4IogM1GRgzpS5bO1glPMeSK9S40Pzg6lpwvWyRkxiuQ4I9QOmoc4IoGFczykm/dBcocjJuaZOyNxsChxnq8a4enXzNiCnouF/50Q5MQJvuH4Y8jUsrUC+4bdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UlFLk6UgxzpK4Wt6n+IxzquGECGP5/9K6BTrhObtM4=;
 b=RVtXmcyJLOQQtzzQEZZ8BWp0xTCZo6PF3YZUoYeiNkrpfkv8R8Dk27f7jp8qiIZPOfmGIaCPHJ6+kkZRH+N1P9hgg7EkKLe2tX6bAgMSoSqCjmgOCRBOc6be7PT1ffpZtASbGNtp2vMI20wfx4XgZ2qe8/e8u155/emgWdZZvT4=
Received: from DM6PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:333::35)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:06:43 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::14) by DM6PR03CA0102.outlook.office365.com
 (2603:10b6:5:333::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 11:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 09/10] drm/amd/pm: Remove unused interface to set plpd
Date: Tue, 14 May 2024 16:36:05 +0530
Message-ID: <20240514110606.396234-10-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: ae591819-54cc-4e73-5b70-08dc7405eff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HvgVGleqiJ1CeDp/zKjlqTbIXAT3EI8YPKGUUDckaVxuGzI9fl1Q/CHgnQ3L?=
 =?us-ascii?Q?Ayai1wndH08PlcIqG1/g8DCPxe9rc0momRnfTzCSROmBNtVJ2cbc7aoMTDHx?=
 =?us-ascii?Q?974qoOfbjiMUB0Cc/Fy2nco5OWFN2mr7sVW1iI0prnvZeldPW5rP8waHD+VV?=
 =?us-ascii?Q?D+9J2t5BO7d1npdCHdkzxp+9ekLxYmTHhihYh/uq/rSqs5sqmJgQhB+2MNsr?=
 =?us-ascii?Q?ZbQHN1JNWZOsWPKt87fQ+6kRUMvPy98ywqvwy8iVkotn8QR0MiOhbUOaMgf+?=
 =?us-ascii?Q?pIylqJuc15uNM9AygmB6OzJ7A9TQUchsu+4iMnpomSC6IVl1puXAtHQP2mQl?=
 =?us-ascii?Q?VEgTqP0Dgq7rVPkFU82OfLwoYbzwEG62llgsqDv/n+mPFmMNcYQFS+PqbRpl?=
 =?us-ascii?Q?gyODBmTAVx9/yVDgpUGvtq6FWZhNjoWr2H6eaPA+XtOUc8Pbp5GZbJ00sCkF?=
 =?us-ascii?Q?mb2NXdPRmYhM0efdh0J7DO4icyL9qr0KFlZU81goSS7vumaGZAT0rmUMJdNE?=
 =?us-ascii?Q?VJr5NMBe8YaE7Tm+RXKubve6R/8TqlkuMjB3p6i2NUSdszcJd2mFIpTJBx0K?=
 =?us-ascii?Q?9pQ0EmHUmGWN8X4/jm3TbOQyBGM1NX6ET3iEFS+yrKfe14n/8Dul/rPyjD76?=
 =?us-ascii?Q?8UN9qy4E7lSMGNqSHc1UDQ87UCdZN94lqNh++337wTkfNEab21OftumlPdho?=
 =?us-ascii?Q?8+gNLKuunoo4PEKF+ErlqKsaYVGQ+hYDoVokawh87bdBkWkwNEdSTHfzy6yx?=
 =?us-ascii?Q?dmchGQV5EPpBtiRPYqKPgU4hUacAoNtni8LQ9oWbSjU2nppfSNczyu0RdT0g?=
 =?us-ascii?Q?CmoUjc6IZ5WYmxHbV5pfsoq4mbsg5RztsSopD+n3Q0jBh/UVDKG3t/KJkLz4?=
 =?us-ascii?Q?hpF0rJRpvJm+1bx6vBdqYNd5iAV9ltQfwRKZXiEJXJ6j6sJYyWYL6gRPfbLT?=
 =?us-ascii?Q?oO/EgZTwbLx4HGn5o3cppwdRKf9rQsXKLrLMxcI3nqykLjwixDLt6c7nqXCB?=
 =?us-ascii?Q?2JWJu8cQvBrc2H7hom/+t5iupsPBa90kWKA1K06LdkTfNsxdtvsMinsA8WNz?=
 =?us-ascii?Q?/j6qOfkGbqNuOboNwdnGWcKrklo/OD4631i5dcvHajpwSwvrgGiFkoJYIe7a?=
 =?us-ascii?Q?J//owTmq0Lxi6jWJywzRKrgm3bYZEnO562VmGvl9RrHKHmapEDsu9OAV0hWl?=
 =?us-ascii?Q?VNqTQ8oTY3pl+EJLlvjIkdev+hXiANJAjaHHla1XGaIHDgNxKzmW3itamf5s?=
 =?us-ascii?Q?T1I1bvr6xQg3t83K7+2VBeD7bmc67YT69uqkvUUtSzVMmoNUpXKBaXcDJYGS?=
 =?us-ascii?Q?LuVZXNBRQbndeIQhxriMkzqHW44I9Wp/ke59LsfSTqZlHg/p15CsVGi/bYnB?=
 =?us-ascii?Q?bcdTT/yTjrEaoc7NR2EpPSiR6YZ7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:42.8766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae591819-54cc-4e73-5b70-08dc7405eff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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
index 356231fd976d..ba457d15ea14 100644
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

