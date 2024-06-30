Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A93C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E57E10E262;
	Sun, 30 Jun 2024 14:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T3DsbuFi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6236410E25C
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMVW2VlbrHB6ypPFQ9GlrZH1q+jbFoGCbhLsffgzsT3XpZqaJtNrSlZVtZ36HYlUA5TykZ8N2nCsldSqGing95Fp4fltTEggZJyONkjgzaIfDNjMf0c7LI2C6q1OXwOGxnIfAizCvVjftMXO1RkUJKYyj3n0gmUgNHNA4dp9/VfmvZovO+rgyDof9nE6zu1H2cXrla5m+r3nnA94oxHAcp2dIloD3IdPZheQAnDcrbd/LbzQ6/mfZsk2hHf1eq5GL+A0Wem31gbIdKzVyrzx/Y+aN0uJCNgciaiNew/0hwyFvb+LOoi4wcXiGhJgTSppMIoBoGndKj1jMZK94JsNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAXJQlo5//W2E21atYVlXnVloWTMAN74ay4QrH6Aw+s=;
 b=AsGfFCPgKLnJo+Tll7d2qaUg21mXJsmi48GBIjF8T/RdYhlDAdBANEP87ZuSnnXfsjBlHnZrnlArlbOW1TF1Rlap3o+8wnATkhEI37EnrOpzCDhP/zJIpNFMizmD6aK8m4QGQkRaDfAmqa+6RjgnFxwcZ5xy7+OAANpQ05xK+47nk6sM5n6RtSAFiBoIFV9UhIqgg0GXxpK4FxL8zn9hJ6hLIxNzGMwlACfJL1AezmVr+9UTMl/qcWwuYxCskaG5gbhoh697n4Acg4MViW0KOahLhxZF0mSk1UGg8QJKRIpXxFMrsZZaQBF6lPjTXiugm30dapB7VaplYRQoUmiu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAXJQlo5//W2E21atYVlXnVloWTMAN74ay4QrH6Aw+s=;
 b=T3DsbuFis6iPPLKQ3ke7h6IzF7jX3mYaLcGVzB90Gq1bs17blKY7PiMA0HRJN2KbkIVahN5OJmZ2hVBV/JW4at0CcB92JDfaOvBJQIyz0ao2ADLe/axMv7FOMy4mSd1L7GsDhUDSMhfyuuhjZh97XGo0gv+OPn6UkKCAFmDsGLQ=
Received: from PH8PR20CA0011.namprd20.prod.outlook.com (2603:10b6:510:23c::14)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 14:59:26 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::73) by PH8PR20CA0011.outlook.office365.com
 (2603:10b6:510:23c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:59:26 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:23 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Li Ma
 <li.ma@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 3/7] drm/amd/pm: smu v14.0.4 reuse smu v14.0.0 dpmtable
Date: Sun, 30 Jun 2024 22:58:27 +0800
Message-ID: <20240630145831.2023399-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145831.2023399-1-Tim.Huang@amd.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: d22347ca-76fc-4c9c-db39-08dc99153c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XdSiCOEz3+Ru1HDqAQnO8eQLBrY/QYu+yy/DuZ7p4hYIuvUjaZwX94QxfdUt?=
 =?us-ascii?Q?P42yj2MupA769TSH5MSM9wTSQA30iJoQX6jd6zpPQjU03VDHlxDOyr3j1I5U?=
 =?us-ascii?Q?cavkWzwBljoE9pu2ks49TF3UwleKjmubmR5wHnkLXhsHtDtCJ0WVkRBAAWqa?=
 =?us-ascii?Q?dws1SP3uvufIW1APQ9b0kT6DWJNAl7VZ1C1/RtaFVynR81PC8ssCdbB5bylu?=
 =?us-ascii?Q?b1J9t0Aev2+EIAR2d/K2+wvjZY2L0xfPVSsBq970ogiLeHiGsCC2ZhfL6e1Z?=
 =?us-ascii?Q?4LLpicXf3njvJdu3KiwpIjMf+a33R0hSvrc7yCjndpDXk76ntmq1AJkvgUGI?=
 =?us-ascii?Q?hO1fhquOD3kPeb2vE/oxu3KockX1Xcnlhjgk5M2yZeBC6ZQI6ZQ2QwvJ8rzJ?=
 =?us-ascii?Q?UiVWOeBSSQKlL8k+oa78NyJ9r5LIscw/UXFAMoYauU+5WYmC4VXHwMMf34o+?=
 =?us-ascii?Q?7oDqMp1R7HL59Rn1XfK9URxow4kfX9fm8Ky6Q0Y9/ZZK7j1BsRJ+CQRv+8RP?=
 =?us-ascii?Q?Cj3N5phr+/4/2SqtwlU0jdwwLpxJYpxk4fLqdM8mSI9oeY54FrHwtw/rxTK+?=
 =?us-ascii?Q?VkElGUi3Sb67O234qNcrbs5LpXh31L55D9f5bAYJecugJra9hDHUPGUeE6AU?=
 =?us-ascii?Q?0uvIz8hAJGT8UpS2sF/l/LSgE1BEQz4HFfgpk5MYtrD12eKEzCBw3FMxwWK/?=
 =?us-ascii?Q?AT4n+++WAv6/Hvcrty1WV3qIPjjhS5mrrBdadbX3EDCy+uHbUd1SCFJcnyM6?=
 =?us-ascii?Q?i/5BEqpuREc5HI4Qo2C48rpYmeBQgQpEI/zlwwVjM8yqtUHDSPXv5ZeBrS+p?=
 =?us-ascii?Q?XrpKYw6C3sSJL4NKbDAJCVeSqcoTHau9glaSGhbgQzWl1SRdEuGvX+ozfoXx?=
 =?us-ascii?Q?QLB3lYnkLq89ktQNBrm799oJQEl5zg0+zAo5pofRyNijbR0jCLYMyKD8jXH3?=
 =?us-ascii?Q?YNNEDjzCjimn4EODBHguPr53zQqg/W5RWS45Euhs321OZ7hJ1hv1D7w6rqbb?=
 =?us-ascii?Q?NwAgPAjxL2oi2cazfrFNHDW9w5gJfRBhpQpT4R9u9CfsgucAlAXV992LGRUj?=
 =?us-ascii?Q?Z/QQILLKFILrMxKlkkxk5CThHb+nfh5RkYdDVblxrPoouL11MlSVutbAIlT3?=
 =?us-ascii?Q?QiBEgVtOGDmWHOvHzOKfxSKCc3gHzPHqVWlKisvZYeFbmk5CvzHZrR6nDQ9p?=
 =?us-ascii?Q?xYGzG3J+i60TSJjwe7o0lF9TmqjiDJxnbSwOFDlg0xM6vt/7Asc5k7WFzAwK?=
 =?us-ascii?Q?aAHcqfPJAFeLoDmpiAdUaLOn2UQooaR9LzfHSoFme22AGfNjH6XGJC34+ySS?=
 =?us-ascii?Q?U0g2nTZk0I1zeJK4ashNtRmIJQAer302MYfBrmWbdvlfmo1EwDyR2pWSoQB3?=
 =?us-ascii?Q?YxI2LTDTvMvlUB/5qbnr0Xth4ZGYItPgU3Py3TN3ycMQ0sf0xF5i7Wq4i2wu?=
 =?us-ascii?Q?+WWlICKdjpwroZm1i0kzSQGLtHupnimC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:26.2476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22347ca-76fc-4c9c-db39-08dc99153c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

From: Li Ma <li.ma@amd.com>

Replace IP VERSION with smu->is_apu in if condition.
And the dpmtable of smu v14.0.4 is same as smu v14.0.0.

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 18 ++++-------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 30 +++++++++----------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5ffd7144d99e..095ee7e2c4bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -136,8 +136,7 @@ int smu_v14_0_load_microcode(struct smu_context *smu)
 		    1 & ~MP1_SMN_PUB_CTRL__LX3_RESET_MASK);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
-			amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		if (smu->is_apu)
 			mp1_fw_flags = RREG32_PCIE(MP1_Public |
 						   (smnMP1_FIRMWARE_FLAGS_14_0_0 & 0xffffffff));
 		else
@@ -210,8 +209,7 @@ int smu_v14_0_check_fw_status(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
-		amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (smu->is_apu)
 		mp1_fw_flags = RREG32_PCIE(MP1_Public |
 					   (smnMP1_FIRMWARE_FLAGS_14_0_0 & 0xffffffff));
 	else
@@ -866,8 +864,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_ENA, 0);
 
 		/* For MP1 SW irqs */
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
-			amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+		if (smu->is_apu) {
 			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0);
 			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
 			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0, val);
@@ -900,8 +897,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_ENA, val);
 
 		/* For MP1 SW irqs */
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
-			amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+		if (smu->is_apu) {
 			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_mp1_14_0_0);
 			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
 			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
@@ -1494,8 +1490,7 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
-		    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+		if (smu->is_apu) {
 			if (i == 0)
 				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
 								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
@@ -1527,8 +1522,7 @@ int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
-		    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+		if (smu->is_apu) {
 			if (i == 0)
 				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
 								      SMU_MSG_PowerUpJpeg0 : SMU_MSG_PowerDownJpeg0,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 18abfbd6d059..3a9d58c036ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -723,10 +723,10 @@ static int smu_v14_0_common_get_dpm_freq_by_index(struct smu_context *smu,
 						uint32_t dpm_level,
 						uint32_t *freq)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
+	else
+		smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
 
 	return 0;
 }
@@ -999,10 +999,10 @@ static int smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
 							uint32_t *min,
 							uint32_t *max)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
+	else
+		smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 
 	return 0;
 }
@@ -1104,10 +1104,10 @@ static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
 					   enum smu_clk_type clk_type,
 					   uint32_t *count)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_v14_0_0_get_dpm_level_count(smu, clk_type, count);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_level_count(smu, clk_type, count);
+	else
+		smu_v14_0_0_get_dpm_level_count(smu, clk_type, count);
 
 	return 0;
 }
@@ -1372,10 +1372,10 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 static int smu_v14_0_common_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_v14_0_0_set_fine_grain_gfx_freq_parameters(smu);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_set_fine_grain_gfx_freq_parameters(smu);
+	else
+		smu_v14_0_0_set_fine_grain_gfx_freq_parameters(smu);
 
 	return 0;
 }
@@ -1436,10 +1436,10 @@ static int smu_14_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks *
 
 static int smu_v14_0_common_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_14_0_0_get_dpm_table(smu, clock_table);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_14_0_1_get_dpm_table(smu, clock_table);
+	else
+		smu_14_0_0_get_dpm_table(smu, clock_table);
 
 	return 0;
 }
-- 
2.43.0

