Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09727C28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 03:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94E310E6E4;
	Fri, 21 Mar 2025 03:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DBIaGuU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52D010E6E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 03:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iU2eCPD90ALSgoGW3sykC7qoffYn4rZRqqGngf+TLL6srqA8Jucc0CK0ua22OWDLvnByA/tevXXMCyaLRAcIiYnAckRBQiPipRaVB6xrK+BfdLjKk+PZuwoRwMpPufShWOY/uB4g6qW87RzE7WlUayv/57WyJJAm+BNr0N3AYBbXz6LhoFVk8bOAYiPkwisJfgXAy4XzuWVc1xA7S1FbfH5n6xX+6lj/VuPwO99eYQsSHqbAz0/fXdwuYzg3kWGP36QWEi8gc/hIRwRXuyAfn4HOE964qmzBqdav4tqMBNwFmm9iO00bp0XH2lYzsjb/13Yt6uaubsUHsEpb1C8NOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln8veh7OqFODhq6grHxKVce7E3r/pX1vqul3Ob2RLus=;
 b=nxh74HClZQL45z9cTSedJoetnVc9+0xFhWdyXV2XNUgxTQhLehPmZXjIALtdpv2m4Xpt37pjPD0wtH1QFmoEgkFXBxmlZrAMVEcTbZuNjVy1CTRA3UuP983I5hSP6M0WYBXUmX0b5f+vUB4iGkacGq9f8Ug+UVfM7sDdL3oEI9zwx6rDGHsYUdbVWaltyNZ8XXF1K/gqDWpYtR58VLgX7mh2GBtXdEevARCyfAZ57JaAamniBlyWZCQ8mT20slPWxINV/CyKX7M58Onpzl9Ne33VQpB8oByuwnZHI0IWZJRveSgGBc0zCr2/CqdFjzKnlllgprdFp2s33QmUydgwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln8veh7OqFODhq6grHxKVce7E3r/pX1vqul3Ob2RLus=;
 b=5DBIaGuUcyqqYam4VPPqXN26KKtiB2B8EuRD61chP3gdTxyUE740o71CisHEOuG2EAjv3QBZiWT0ZUUgug63X0C5mCZt+Mln5L9CgjCg9RTrlqInYCIJ9TJrsHJrjSuULUnBcrhplL15lD0X50k074CUdBZjSY833nlYd1zDu34=
Received: from BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 03:25:21 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::73) by BYAPR05CA0080.outlook.office365.com
 (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 03:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:25:21 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 22:25:19 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v4 1/4] drm/amd/pm: Add link reset for SMU 13.0.6
Date: Fri, 21 Mar 2025 11:25:09 +0800
Message-ID: <bd6c41d3acd4ca1601eea88ffb8c81f99b5d4198.1742526761.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1742526761.git.cesun102@amd.com>
References: <cover.1742526761.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 359cf500-fb2c-4773-82f0-08dd682802f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GtqeTJjuMKjDqUi2zoVpGQJ1DLYiy4iJ8ENrevFcuPYz4eWdKGPmyKA7Pe+J?=
 =?us-ascii?Q?8FiPj+KHaq5SBT66mCutJoJ81aeBgKUETeefhyhk4qvMRwYDqwsuvIa9ukGC?=
 =?us-ascii?Q?7DDLs7DB4MTxhxE9t5UhW2dp+b/klhsQGhnQXaKVIBp0yhnXP06po4thtFIn?=
 =?us-ascii?Q?Kd2nEDWIAvoCy4QjUwPbO6NeribMbQ780guurIrTiRfQyNm0SktMHsb1qkyr?=
 =?us-ascii?Q?5PceiwyFA9DYXw9FR9ArItRB4l5SZYN/+duoly/CFym4OzibsLVW0WVr9hkL?=
 =?us-ascii?Q?GFSO77kT12aJ1t3VBh09xlKwddQuy9NV0/dmZMDjfkp3V4n7SD31fpWr4Tpf?=
 =?us-ascii?Q?aA2yT3rEdWNbvZXMA7rBStESnMaS24rNQ6SRAFPYmB0y7OyxS9Fu2mTuzgBD?=
 =?us-ascii?Q?hq9D2OiLTCMU4aypKwBGAU9tJeYT4080qV7vpNT0l7tmDmlcB4RitXSWHW1a?=
 =?us-ascii?Q?8ud1LLrzb8TVVvfjnqkH4/0gp7mx00y+isFu8ksY6UelYN+NP+jXRBWDsi5/?=
 =?us-ascii?Q?EY7xNfUPXu39HfyG//OQRk7WNc0ZwcQiScdggdUd/TFnd9+vi076vOjkqnqc?=
 =?us-ascii?Q?JetjzUurA8FRdbvgD0A8o3XQznjV0U8rxqr99XqXwTBFrh8FAX9yI0u0R0l+?=
 =?us-ascii?Q?pwDQF+oG/MBTvKNYTNy5eZCV93L3D4eHycyLkB72NHgowcpUFY6BfEBAiReo?=
 =?us-ascii?Q?xv/lEYnS3CMRoQirtM3ciJf9WFMqzxbPyN9HYFCBpF5qohfed4po2O+P5Axw?=
 =?us-ascii?Q?EYDvGWS1ZYu5TArhLVCQIdOXgiUMx3ZqoEPRQIh/+UkRTASo6fmDXMw/vU06?=
 =?us-ascii?Q?Xx1nVHzeOpQoe9PuTv5VmUctsq95TQzuUifiQmP5up9QEjE9b179Fszjsdfh?=
 =?us-ascii?Q?YCyM0vtn76TS9JHGs0qOwmVDl12r9ZGTXjQ2wrcb5dGzie4p+8eO9ar5Y1fN?=
 =?us-ascii?Q?JgZxFDmZpbQdtzDOQLAth3BOgKhauLnPf7TDauf8vtuiHnuuCFfYcbh7gyY2?=
 =?us-ascii?Q?tQyDL2kh2ZWjqY+UGSpDQRARd+br1Kwf0xPnkcONoMR/WXZGGuqLIrVTt/v4?=
 =?us-ascii?Q?BOqH5cisH0gKIFwsCc/iYnyojpgd5DKYNWrsUlQj5OJiKHnON6ZUxjOKOHTF?=
 =?us-ascii?Q?OdiqKoX4wmgn4ubyQnO5zOFSCr9QpqBNitRIlDqj11Ph3B90NQNG0E9ObyKH?=
 =?us-ascii?Q?zrVc0h/S7M1Zv26Nh/9CiqROVuo1wrZUE/abB/8Cdwz8+zyf7r9yfaaftoqw?=
 =?us-ascii?Q?9MYmoRlI2a7wiEYrP5OYlkVb0dU3VtksJ/R7jdBbTrr/WKw0EbiQ1PGHJf7y?=
 =?us-ascii?Q?XouRhi/dSMhlZ1gLCkiFkjt7yRZbUeQcnALyzq0zJUeXmOgIPK9c8Q4uBsij?=
 =?us-ascii?Q?gbKXoqQIKH/7ZQHZtvCrR3gLO7/lY/U/+pP9B6JACBAAfNNtLllE9JQZHWMH?=
 =?us-ascii?Q?d9kYFQtRsrBlalRSsIcAVcwzWBKHBkI5hTQzNbP3wWpU2+mrqN+0jgvw0sNj?=
 =?us-ascii?Q?tKhH4mzGbvHZGW0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:25:21.2893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359cf500-fb2c-4773-82f0-08dd682802f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
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

Add link reset implementation

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 23 +++++++++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 +++++++++++++++
 5 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index ddc65bf54d23..02f4f95986f5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -329,6 +329,34 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
+bool amdgpu_dpm_is_link_reset_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool support_link_reset = false;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		support_link_reset = smu_link_reset_is_support(smu);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return support_link_reset;
+}
+
+int amdgpu_dpm_link_reset(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_link_reset(smu);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 67f2522b2729..a6b94b9540c4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -413,11 +413,13 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
+int amdgpu_dpm_link_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev);
 
 int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
 
 bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
+bool amdgpu_dpm_is_link_reset_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 88fec8bbcd3f..f4554cfe0319 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3375,6 +3375,19 @@ bool smu_mode2_reset_is_support(struct smu_context *smu)
 	return ret;
 }
 
+bool smu_link_reset_is_support(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->link_reset_is_support)
+		ret = smu->ppt_funcs->link_reset_is_support(smu);
+
+	return ret;
+}
+
 int smu_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
@@ -3405,6 +3418,19 @@ static int smu_mode2_reset(void *handle)
 	return ret;
 }
 
+int smu_link_reset(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	if (smu->ppt_funcs->link_reset)
+		ret = smu->ppt_funcs->link_reset(smu);
+
+	return ret;
+}
+
 static int smu_enable_gfx_features(void *handle)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f540453cdbba..1c85cff4dba2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -469,9 +469,11 @@ struct mclock_latency_table {
 };
 
 enum smu_reset_mode {
-    SMU_RESET_MODE_0,
-    SMU_RESET_MODE_1,
-    SMU_RESET_MODE_2,
+	SMU_RESET_MODE_0,
+	SMU_RESET_MODE_1,
+	SMU_RESET_MODE_2,
+	SMU_RESET_MODE_3,
+	SMU_RESET_MODE_4,
 };
 
 enum smu_baco_state {
@@ -1254,11 +1256,17 @@ struct pptable_funcs {
 	 * @mode1_reset_is_support: Check if GPU supports mode1 reset.
 	 */
 	bool (*mode1_reset_is_support)(struct smu_context *smu);
+
 	/**
 	 * @mode2_reset_is_support: Check if GPU supports mode2 reset.
 	 */
 	bool (*mode2_reset_is_support)(struct smu_context *smu);
 
+	/**
+	 * @link_reset_is_support: Check if GPU supports link reset.
+	 */
+	bool (*link_reset_is_support)(struct smu_context *smu);
+
 	/**
 	 * @mode1_reset: Perform mode1 reset.
 	 *
@@ -1276,6 +1284,13 @@ struct pptable_funcs {
 	/* for gfx feature enablement after mode2 reset */
 	int (*enable_gfx_features)(struct smu_context *smu);
 
+	/**
+	 * @link_reset: Perform link reset.
+	 *
+	 * The gfx device driver reset
+	 */
+	int (*link_reset)(struct smu_context *smu);
+
 	/**
 	 * @get_dpm_ultimate_freq: Get the hard frequency range of a clock
 	 *                         domain in MHz.
@@ -1627,7 +1642,9 @@ int smu_get_power_limit(void *handle,
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
+bool smu_link_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
+int smu_link_reset(struct smu_context *smu);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 01689325c120..061183e1c695 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3013,6 +3013,15 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_link_reset(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+					      SMU_RESET_MODE_4, NULL);
+	return ret;
+}
+
 static bool smu_v13_0_6_is_mode1_reset_supported(struct smu_context *smu)
 {
 	return true;
@@ -3023,6 +3032,17 @@ static bool smu_v13_0_6_is_mode2_reset_supported(struct smu_context *smu)
 	return true;
 }
 
+static inline bool smu_v13_0_6_is_link_reset_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int var = (adev->pdev->device & 0xF);
+
+	if (var == 0x1)
+		return true;
+
+	return false;
+}
+
 static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 						 uint32_t size)
 {
@@ -3773,8 +3793,10 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.mode2_reset_is_support = smu_v13_0_6_is_mode2_reset_supported,
+	.link_reset_is_support = smu_v13_0_6_is_link_reset_supported,
 	.mode1_reset = smu_v13_0_6_mode1_reset,
 	.mode2_reset = smu_v13_0_6_mode2_reset,
+	.link_reset = smu_v13_0_6_link_reset,
 	.wait_for_event = smu_v13_0_wait_for_event,
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
-- 
2.34.1

