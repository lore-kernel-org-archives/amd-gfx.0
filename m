Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10CFCA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 04:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DAE10E698;
	Wed, 13 Aug 2025 04:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oyQY5wYV";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4AE10E698
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 04:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcP3yE8skissBkEgwvBcvf1Mvt78lXSLG/ekS62x4y6CU6JOUIkB1JNgGq+MsW5VhgRneR3Z13254YNWzgZmZBdsyGPrjDt5XOpY4DfAymDZa1ARqveLIEVM5UComCy82RokLDrymmCPkoLYeBgAmvVW905Fz5EQswv1dRkTD5Ajw7zHHuvJV1Rq3UPWZ1x07ETukAQ/i/iDKNYgqT/Hh7AaIrfdsoBTMFeYsR08t195iFymZyZ98OsiI2CpEOhl/swhpN0OCjNZzmjpWw/iqGuNnRqNYSQPOAiT6+xkHNIcB7gLCebwIsky0fwNh0mLT4XVvtjSvg0LHfzFPBdV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOxulAweBoH2FONjd3cNfd1o6VaY4M+M3iQi5/sbZlo=;
 b=XmzihHiX9NRPMSesGbr53euirfCwdt5pWv1VuJXP+IHeqUdgrS7jrifrLQehGg8HPGJg2wDTjtRPd/asBPTXOTrdPzZikfpWgn844oQEcC+khG6/PXpRU9DEIzcDDcg0wkV2zmNkzLqYw44V87HEwu0QsKWsBwDKGUtGqHaN63u6brllXnf1/VrYtMfcSQNHitlFCWJErM6rt5FnYI+x8T+oqJYCXcEtrcP0wSkS72AgycfkHeGIxQAzcACX+f4+b8OYDp3l6NdhDcWzpnUakYgVYEowuVSUKDNNOc7ruccinSF5wNGerDRC1oWv4tItnhrlMuHrHhJxWntWfBhG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOxulAweBoH2FONjd3cNfd1o6VaY4M+M3iQi5/sbZlo=;
 b=oyQY5wYV62UdtJT3+shfbkCJeOs1wlc+/hL1how3UC27ZyPT6ZSoSgBozRJOOpZbkIwzawZ/sJfRD2BnaJke93hhwrQ3iH3xS0fHPLSXpo9j+oAPQ+acOoFOEpMx28/qrL0zKg2awSGb0MH5S8DanoNWYqtwdZwvTuVKhaa9nDg=
Received: from CYXP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::10)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 04:09:01 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::11) by CYXP220CA0006.outlook.office365.com
 (2603:10b6:930:ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:09:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 23:08:59 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 12 Aug 2025 23:08:52 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v4 1/3] drm/amd/pm: Add VCN reset support check capability
Date: Wed, 13 Aug 2025 12:08:04 +0800
Message-ID: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: eb51aac4-1f12-4522-4456-08ddda1f21c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1q0bOvjoyHQV/sdcCrg4mF+iVYftfJRRayixwCpuEM0SMzdZ+61QrgZx7UIW?=
 =?us-ascii?Q?j8rrDNEb/lC6Gle1en0Zpy33QbvSUZ1NDx4Tw9kpPo5PTgmI++TwzDHcNOtd?=
 =?us-ascii?Q?VOUn7R4xnXtRt7Tn5oHTn05ZHM2GUluyTNXQr2f8UaWtUs6cTGv/JJtH5vhc?=
 =?us-ascii?Q?S788o8w6tKuf0i/vQiOLJfeL0fCAE4kby+psjavk+ITXopO8mWQF0wJYKTda?=
 =?us-ascii?Q?/o6M4xIu2McA9umHhdilestv81CgVoTJkAMBTCDjoDwdGoh5X4yR95X/hZu1?=
 =?us-ascii?Q?3alAM7b3PReulNh/o4wQZMZpvFNU7csRtONuLr7SzUOeXxvMCvmw02aof4Bb?=
 =?us-ascii?Q?rnIgi39uZ1iu4jpcFRkS82Ech7YeNei3tHAfnrbied7/J/3UuX/MgeTtmq2K?=
 =?us-ascii?Q?lmlnN9V2iSU1bNaFp0tvv2qHsRnT1eQT5McX6oaF6vdA4aAgimLvzq0iMOHr?=
 =?us-ascii?Q?i/C5fA07y61h6PdtsJ1w6pWxA6Jfh+eCcb7VJBdZZLuSkuRYyw0Hyh3jkeOo?=
 =?us-ascii?Q?mS9TVu/V9cXyPYBouazn+MULEplPuGGt6HpTsQJbxvKXby9uSMlASbl3q/wz?=
 =?us-ascii?Q?84yh2LZiOv9Qj4lQt6TKR6YcpdVeKe5jGO4jeLXJP5wSx0GXzGMCKGlFMZR7?=
 =?us-ascii?Q?i5Or9E3wvdKCY++r2BoFQIvmdAWuIg0zaGQiB8qnQ/3juTs64QeD4B/wQiPZ?=
 =?us-ascii?Q?oFu6PanxgV86f715tNSWCTiY/V9a+lf/rDMVz79xiXoJvMp6UVPnBcYuhenS?=
 =?us-ascii?Q?RlR3rc6/8r1LeDiQHP/3mSeQOxJot+aW39cWZdyvMqeJrogOKoWX0LlrnWBX?=
 =?us-ascii?Q?DoPucgZfEo+e7SgDigVCcrKfwYp/xJ7qFRlo1GgBGs/uQfOr1dDnXdFw7s5F?=
 =?us-ascii?Q?9UK1us5uLf0Tj1Y6LHmT0DBbpRT8x+vsHBrLcdewHs1VM7G1w/SX5SnAfoVg?=
 =?us-ascii?Q?AS3kHpBm09J59hHAXaM/HWyutFbHeGT2iN9/JKcukFN3Z4e+LJb9Y9kT8BxY?=
 =?us-ascii?Q?Z9MQ6WiH0qqvV+k0rbdWm0kiS/7RYIzTb/+IG1m8B0mt/qUrsJhsm8psFXTc?=
 =?us-ascii?Q?H/K9WTnEG3hl5hGg5lMVphOyhUrtjFk6sG3q4KB3TKYsycAKPX1OT/fYmZRU?=
 =?us-ascii?Q?59XHw/DQyD6zffiPLpjL9+tatR/3pOrau+TZ5Z8vzmerSpDwU64QeFpN+q/q?=
 =?us-ascii?Q?DfBvKmWqWgWq++c6eWnjrLO3PTcvi292FghMozpkLR3uXBWpGrxcevgF0h2u?=
 =?us-ascii?Q?SxEbHZAxiGuIOZavQSIQAbFVo2FZCXrzEWOmIV6FHCKyB2SneQjAPl7STjLW?=
 =?us-ascii?Q?4gO515LDV0fOOs0si15xD5+gIa1Fz6DcvXg6xHma4Nx8XT8v177dMMrArZFK?=
 =?us-ascii?Q?y82l9F2RNXJ7k9n2qB55LBqAwvqRvDaYfqoFt/Hc5CaQPylQMy5eG1yXXXiv?=
 =?us-ascii?Q?H1EYH9CQN9n5Bq6bgdCBTNDTtKuXnefa/bT2KS+xef3xj48tzsDk2cPzBibf?=
 =?us-ascii?Q?6otGmNCgvZyrjsxiW/8rawbnQ0E6Et7wdw2J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:09:00.1274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb51aac4-1f12-4522-4456-08ddda1f21c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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

This change introduces infrastructure to check whether VCN reset
is supported by the SMU firmware. Key changes include:

1. Added new functions to query VCN reset support:
   - amdgpu_dpm_reset_vcn_is_supported()
   - smu_reset_vcn_is_supported()
   - pptable_funcs.reset_vcn_is_supported callback

2. Implemented proper locking in the DPM layer with mutex protection

3. Maintained consistency with existing SDMA reset support checks

The new capability allows callers to check for VCN reset support
before attempting the operation, preventing unnecessary attempts
on unsupported platforms.

v2: clean up debug info(Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6e0d711820ea..518d07afc7df 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
 	return ret;
 }
 
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool ret;
+
+	if (!is_support_sw_smu(adev))
+		return false;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_vcn_is_supported(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 09962db988d6..9748744133d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0a40ab817634..c5965924e7c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4124,6 +4124,16 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+bool smu_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
+		ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
+
+	return ret;
+}
+
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2edd867f203e..5dd49eca598d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1435,6 +1435,10 @@ struct pptable_funcs {
 	 * @reset_vcn: message SMU to soft reset vcn instance.
 	 */
 	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_vcn_is_supported: Check if support resets vcn.
+	 */
+	bool (*reset_vcn_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1776,6 +1780,7 @@ int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 bool smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
+bool smu_reset_vcn_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
-- 
2.49.0

