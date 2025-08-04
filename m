Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B6AC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A9410E534;
	Mon,  4 Aug 2025 14:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gvJGoYig";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4046310E522
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdcwozKry39G21V2Y1obN/QevLjC20cNceJkNi3mTdaRhCgEyYWm7npElyouXpjzj8Gj9/yrbJBkCp97Zh8dwlwDbqiP7rkiVZaXWUjKCESV3laFos02nlnmffDczKYeM3rGrvt8WXQXv24OIqF04hGansj44VURwb4Ug7nh9TMbK7/vgW6o0UKfF4bucGq/+dv9k5UyBZ2Wm7uX/0rc3UOybkRAayusnafTyYW10tLJUwa0SAF5BWey4hTAcS/n44QORtl1byzgFXYayMZh4H+UEFvH12nDar2BHNURkHwBFlxaYHUB1gNOI2jL0DxeYB5vui/UoDiwXD4A2dTFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMaJzbM6my4HLCzC0xUCRvpMlom9siPsEQ5Rqq6i3SY=;
 b=d2UPiaZWb7nerBy31313wcPFrphx3YHV+tduK9AfeqXOzYWHgHKQCPdYo2/xkwV80hEO7K+e5Cstmrlm3Pr5B9XDaimpyV9784BzX4vLGHchtxqdncpzLKNQlCbHFxDbwjIKZWLnqrGyboPyIHuvXakVPX0kgR1EVkv3+SaunEDIG1E2Qs4nPxlXY45g50asrs2aDPy2fuYcw3hXjBcp0ULOv8cMVJO2fLrYm/jRhDYX6zC4fg1/8YcIaD5qxYsCiqgcLJ8mI9AnYCJ27jz1LAPurS+muwzfDF1xxTs7SkdDTV7vQWYku323CaNU3U4XTHZ1NQQ0LPiR5HDjOwgcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMaJzbM6my4HLCzC0xUCRvpMlom9siPsEQ5Rqq6i3SY=;
 b=gvJGoYigSN0U18dFIU3WaGTpdUpWqRSrN/L5gokOfc6FN2hZU+/xp0dObEG2bxA1Nbpr09/lB8JiCd2MhcUvj83oS7KzyhBaTFV4v+qIrhmKBmCH3ghV5WvrMlnwvuPYhjMd4HSoZhFO97tzArj6h2zjmzBVEYH8kyYUVekoE/k=
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:18:14 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::2f) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 14:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 14:18:13 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 09:18:11 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v3 2/6] drm/amd/pm: Add smu interface for temp metrics
Date: Mon, 4 Aug 2025 22:17:53 +0800
Message-ID: <20250804141757.643501-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804141757.643501-1-asad.kamal@amd.com>
References: <20250804141757.643501-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c48c68-1960-4c4b-81a7-08ddd361bfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eRnnUyPMXCP1KAP9LAMx23Drm4rOiWQLfaeZeJlGPkl01dx5adCrTX6I7Dbw?=
 =?us-ascii?Q?2+1HLD1cuHZPA0KeqNXNBFclqIHshHjGXMqF1CwzSdyA0LlSDw4qzk6NTOi1?=
 =?us-ascii?Q?63JaJpMGMhPbC5klZvRZRBh8LrNsXd0TZLycRea0mxJ+WtUrZZfmgeEDWY6g?=
 =?us-ascii?Q?x3yzdmGiuW38WHnOZ3sILK+XOnqudMH0PTGNogqYd15uLNt5shi4g5sD3F3L?=
 =?us-ascii?Q?SYDWiY/NblFcy/QX3/40tCiahA7I6Ntwqfn0ZSBriWdKdhYq8EAQi2buwGSf?=
 =?us-ascii?Q?qxGtWAbv1UPFx5lFikAk9oYpuwLkQF8Ig+mPOL8kxzHDZXbd8QzTl3bfC3Rh?=
 =?us-ascii?Q?nWWVQTwJWFF6S3OtBBxuyjTAwcI+ZFg4INZsr3jRJrPuLyHq05cQOfYWmj01?=
 =?us-ascii?Q?qPthO2MGWrhVmctDB+yy8imxp0S39MVcO4Jiza1cBDXSh7AFYe/tN1tMLrWz?=
 =?us-ascii?Q?mMBdRPSQq13RwWtKUFBz2/x0k4aywdFvvl8crz1ernvei7aiMPx/d6t6ebHv?=
 =?us-ascii?Q?OxDOTWZ2RAPNwyK9tGq8IviRWwfcRhT9/9gGFDthnO/3PLND4Q4bjo5gw+uF?=
 =?us-ascii?Q?eKihqEtp5ROAn/mFyIibEYgH/Cpf/srHr0m5IT/cZwXRRrIZafbFX1MX5VFo?=
 =?us-ascii?Q?cJ4hU2q3C4uvz2FG2aTGBr1wmFqIJZyY2H01tLDsfvoOv5jfdKO7Bs5kSodA?=
 =?us-ascii?Q?7KXcWbWQkIKC8NzgDem8EleXX0hk5wmJOoyZwIU6F8izthWuSEVH3zoPjVCi?=
 =?us-ascii?Q?ct+5nMtXwHrwBJfMJKz9yi2O9bRrawrgOAQxZFqRj2UGC7R8r0/UNkWkw+NR?=
 =?us-ascii?Q?jI38ZXFbzNPXBeUCvm7umdi4c1BvvJj7jsuaLJXDvGZEs2cXppwDaezV2FCG?=
 =?us-ascii?Q?vBg1RsMFqQOx0autyGB4xXzgLRZ4TrRDbgMjwHZ/KYP9TlNoiDDZRG+GTFR0?=
 =?us-ascii?Q?BSkbivj71yOthfypU0pxKIFLd/vPknkfIGlr6x6xgIIKeYxj+VKEHyUhdwTX?=
 =?us-ascii?Q?yLbGTviJJVlYBDhB7KrhicK/HV0b+6E/tegl2RvlMa+A1ZdUzLLy8GUqJ+Mw?=
 =?us-ascii?Q?Dg44EhcIoPxkT81bKQ5fTgmxxNVd2NkFFiYRxWJCp8gtilKiBSYPyT+761ru?=
 =?us-ascii?Q?g3bmxCywTmdhkDMnvEwIdPCXrv588GF0dx+DNeQ1FOSqSSax2dRFcaS+H7b4?=
 =?us-ascii?Q?XkeTqDqw2FzltjdFsizyKNOMzM9BprLxSu+X4eSSrQBXq5EW3S800kflXkrr?=
 =?us-ascii?Q?/vcAGv75Bcpp0iU7hpNfxh5ASn/DS+F8i+7iDc/ZNNyRO8zDPXzqSZF6IWA7?=
 =?us-ascii?Q?owL7QCmd4fQP+lPi+E+g/RsYqurNMaXOqG+sjY9V2wQYmN8uovkXktZ0a8oZ?=
 =?us-ascii?Q?8LOhxiN5HCa0cVR5Os39s1CyVAY5B08zrgpFfxGFSBAYSPDr6i3vZH4+JEy8?=
 =?us-ascii?Q?k3jE+PqGetJF7x0i1EFUxjKGUDsriO4+8eyBhzJgao31BdCipHtphjlt6FM8?=
 =?us-ascii?Q?4IfnzEpxt0p+tfWtUfJLhY8qvHW3IoKTia2E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:18:13.7337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c48c68-1960-4c4b-81a7-08ddd361bfb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

Add smu interface to get baseboard/gpuboard temperature metrics

v2: Rename is_support to is_supported(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 27 +++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b47cb4a5f488..8b015107f761 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3831,6 +3831,33 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 	return ret;
 }
 
+static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type type, void *table)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->smu_temp.temp_funcs || !smu->smu_temp.temp_funcs->get_temp_metrics)
+		return -EOPNOTSUPP;
+
+	return smu->smu_temp.temp_funcs->get_temp_metrics(smu, type, table);
+}
+
+static bool smu_temp_metrics_is_supported(void *handle, enum smu_temp_metric_type type)
+{
+	struct smu_context *smu = handle;
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	if (smu->smu_temp.temp_funcs && smu->smu_temp.temp_funcs->temp_metrics_is_supported)
+		ret = smu->smu_temp.temp_funcs->temp_metrics_is_supported(smu, type);
+
+	return ret;
+}
+
 static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void *table)
 {
 	struct smu_context *smu = handle;
@@ -3903,6 +3930,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
 	.get_xcp_metrics                  = smu_sys_get_xcp_metrics,
+	.get_temp_metrics             = smu_sys_get_temp_metrics,
+	.temp_metrics_is_supported      = smu_temp_metrics_is_supported,
 };
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b52e194397e2..b490c39e313e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -396,6 +396,10 @@ struct smu_dpm_context {
 	struct smu_dpm_policy_ctxt *dpm_policies;
 };
 
+struct smu_temp_context {
+	const struct smu_temp_funcs      *temp_funcs;
+};
+
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
@@ -529,6 +533,7 @@ struct smu_context {
 	struct smu_table_context	smu_table;
 	struct smu_dpm_context		smu_dpm;
 	struct smu_power_context	smu_power;
+	struct smu_temp_context		smu_temp;
 	struct smu_feature		smu_feature;
 	struct amd_pp_display_configuration  *display_config;
 	struct smu_baco_context		smu_baco;
@@ -623,6 +628,28 @@ struct smu_context {
 
 struct i2c_adapter;
 
+/**
+ * struct smu_temp_funcs - Callbacks used to get temperature data.
+ */
+struct smu_temp_funcs {
+	/**
+	 * @get_temp_metrics: Calibrate voltage/frequency curve to fit the system's
+	 *           power delivery and voltage margins. Required for adaptive
+	 * @type Temperature metrics type(baseboard/gpuboard)
+	 * Return: Size of &table
+	 */
+	ssize_t (*get_temp_metrics)(struct smu_context *smu,
+				    enum smu_temp_metric_type type, void *table);
+
+	/**
+	 * @temp_metrics_is_support: Get if specific temperature metrics is supported
+	 * @type Temperature metrics type(baseboard/gpuboard)
+	 * Return: true if supported else false
+	 */
+	bool (*temp_metrics_is_supported)(struct smu_context *smu, enum smu_temp_metric_type type);
+
+};
+
 /**
  * struct pptable_funcs - Callbacks used to interact with the SMU.
  */
-- 
2.46.0

