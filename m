Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E4CF8854
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E2410EA8C;
	Fri,  4 Oct 2024 18:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O+ysJbT4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC71510EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkQ4tjVYhjtFCK/rrVlizIvqiH+fAGiGYoRcN4sURDITVIBqukSmMCIqfqmi02BC6aarnruwCx8N19WeVtcNWPxOog4uBquHqhi+hxWzpp4YSWxR3q5pNma1A34ulwpRBvhdf6W2tWq/LsKWpeghQ5tAk79w/VaDTCO1FC/Qg4WnASiAZaoG5hEjHOxkGJFg0SsMTqmI8SvCHevmMjs6FrIX1tUGpM3pn1gPuX3DMD3C9ouRao2vLnAXqyaYfO7JZIAU9kixnGwwON3Cd191P6dkWCcuWmVPQaxRV+cjB0T/QwNE5vWUzyw/8i1nXy7MxwWF6OOAbKra8ruM4xJwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgkBqpyVzRvbotM2vtBMwNAu+SNaOFXTMe8fXdksaRY=;
 b=R58c3XdKemgw7bvrLRU3hg/9u6HOIX+Lj5MlFNDHTBLQ2ussS4o78wZ9P8WkHOM8nOCoiQ2bdVvA1Xku/nB97JaVbQkKyiVThJE8n+RsbmQHryopjdYBhMga5Nxxk3A1ga2DBor/KGv8kDJkg9zQNaXy2GpGFFa2XimV9HwThmEWTU18B009/ak9+eitcugm0lslvfmXNlFdR1Suq+MmmapMu2z5trFvIZA30P0YtLw0XghSlIoxBmWfxdZPklG7aYebtp1eqEEGRypn6m6/RkI/DaguT9iGxQbonXMfSXiW5xZXHL23Bdabm1DfZKnamQSkl+KyBJv7Klu0K+V7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgkBqpyVzRvbotM2vtBMwNAu+SNaOFXTMe8fXdksaRY=;
 b=O+ysJbT4tHC4Q1blZUl8qbyhiuEkeuNLRtq8GeADIrT2phtx1S7MZDKeGrOGQxN5c9g+6Cz/YEWK0py1qPpqOqgyxBF7xWxj6R9hTzNzMP7Qzp8kl2i4qBbNoRaUUNRxpocn8zl+slY7ZX1KfkOM/U5FitFxiAgILcgk/JiLxrU=
Received: from BN9PR03CA0615.namprd03.prod.outlook.com (2603:10b6:408:106::20)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:45:05 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::a9) by BN9PR03CA0615.outlook.office365.com
 (2603:10b6:408:106::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:04 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:00 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 03/18] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
Date: Fri, 4 Oct 2024 14:44:29 -0400
Message-ID: <20241004184444.435356-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de8be83-cfce-4c88-080f-08dce4a4a938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QHH+CaolN/+gRfnUXOPTChef2ZbeLI2akXs0yHng3A7qXrPZOKq8ifT3tiNT?=
 =?us-ascii?Q?NEO0sqxmpa2MVs9y5fe0SsK0ImVjZKVOpzHQbJohDp2YYBvIdvl859zwSo8i?=
 =?us-ascii?Q?fDyPQFovzTkKe+ZicXr8a5vdLfOBi/VEwNucKmI3lyBe+uhHDeZbya7TI0Gb?=
 =?us-ascii?Q?KNrUa0mmDAMNNYZnIdQhUTHalnJJiIhVL1jJYsfKEiRhkZoCEEAHStwUE3P2?=
 =?us-ascii?Q?3ELtBRJu00QEMpBxtm5jRPzdOOR0ree1Lu64X42BlRQcn9lG32nyEJf9NnaG?=
 =?us-ascii?Q?VEyTzAH+HM72mLO4UFH9ihGndjb0p3cTo5JQoEbwcbwZ+FiJo37e4TF/zP/l?=
 =?us-ascii?Q?9lRF41awMEGkdEuI0oBb2TZmhJfegA0h1Z5pH/FF+v0nnZ7aIfhF94EH9FtI?=
 =?us-ascii?Q?AFfiMrlvra6QxkhvhnBE3XlIny0MiO1Tb/oUlrvzosw84MDuBfi9I9NNtFfn?=
 =?us-ascii?Q?fHsg9km5Rp0gQrlbLpDlk9bLrPGMl38TRA8sJlkhW1BoiNORRhFCttRZZCzH?=
 =?us-ascii?Q?NnkU9wvEmlNmCBapcxUgZWJ/+SW+788ZhhZvEmQCANOLQMH1kFnv8GYL7UA0?=
 =?us-ascii?Q?gf5bCAfj3EdN8ikIwptrjrrGgbOuDtXSGF4beAwUtCz027xdmYyDcbaZcR29?=
 =?us-ascii?Q?jx6z6+W0bMqn4R47Ds4V8S0ztLw0okv5mLy1t+23BzUgHznZlircsxW6+o8t?=
 =?us-ascii?Q?fk/vG1ltiU12zFjzX0GrYhbMjTH1NIIEKlqO2U95DrkMH0AeNuBIO/pN1yO5?=
 =?us-ascii?Q?9fgYjJo2UZyvFwGDJzzaXrTIVYEnzoqLjHkTecrv/LQABkKC9wLy1MQvkmoC?=
 =?us-ascii?Q?xvjAi1yXrrU/evGYQPkC/PeTG7OGi7Sk+e4v6TnUxmcrOHWdT068U+E6LVVu?=
 =?us-ascii?Q?Qpm/z9SXZPXVvWgtazl0HYHnfCxi45LM1F4MasAgadbANl9idpPCsraMfN4G?=
 =?us-ascii?Q?0Q0l7mLkL4NguJ1KkST7HnrQ1VL/Ew4S2zdFwxjsFA4PEkKh6HnOgxx88xJP?=
 =?us-ascii?Q?at4qXQoOk7mbX3U7nS6HC9ZNTog/fMhTZLLZKE4o92SN16CFnUDqfBX6w/pQ?=
 =?us-ascii?Q?QX04Q+ICAX+yjEqMmsm56ldCySXLC4F88vt9UJ7DhYXnhT8mquCRAYKLlFUe?=
 =?us-ascii?Q?KQCe644xwtHCPXpvVMd28t2w8IKmdaEGTWIFp7cRSLtIfSbtHyhPx2i+3T8c?=
 =?us-ascii?Q?lUC4j85XZwSzg3mBKjTKlabGbgEw0ogCtbKb0FjSDJppdP75+9/9NPJYFbrc?=
 =?us-ascii?Q?zXZ190tJThbIgpZfXmAMm/YEATxVVoK+dLknDbRa5xvIZM33+pI8tCxD2lqi?=
 =?us-ascii?Q?ON16IJWN6vVE5oPRQj7774FwoHEXuXP8bbU9osh9duFq1lBgvG1VxijQFIa3?=
 =?us-ascii?Q?uG93rww=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:04.3465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de8be83-cfce-4c88-080f-08dce4a4a938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

First, add an instance parameter to smu_dpm_set_vcn_enable() function,
and calling dpm_set_vcn_enable() with this given instance.

Second, modify vcn_gated to be an array, to track the gating status
for each vcn instance separately.

With these 2 changes, smu_dpm_set_vcn_enable() will check and set the
gating status for the given vcn instance ONLY.

v2: remove duplicated functions.

remove for-loop in dpm_set_vcn_enable(), and temporarily move it to
to smu_dpm_set_power_gate(), in order to keep the exact same logic as
before, until further separation in next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 65 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 410d5baedfbc..786241fa8d2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -233,11 +233,11 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
 }
 
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
+				   bool enable,
+				   int inst)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -249,16 +249,12 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (!smu->ppt_funcs->dpm_set_vcn_enable)
 		return 0;
 
-	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+	if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
 		return 0;
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
-		if (ret)
-			return ret;
-	}
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, inst);
 	if (!ret)
-		atomic_set(&power_gate->vcn_gated, !enable);
+		atomic_set(&power_gate->vcn_gated[inst], !enable);
 
 	return ret;
 }
@@ -360,6 +356,7 @@ static int smu_dpm_set_power_gate(void *handle,
 				  bool gate)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -376,10 +373,12 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		ret = smu_dpm_set_vcn_enable(smu, !gate);
-		if (ret)
-			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
-				gate ? "gate" : "ungate");
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
+					gate ? "gate" : "ungate");
+		}
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
@@ -781,21 +780,25 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int vcn_gate, jpeg_gate;
+	int vcn_gate[AMDGPU_MAX_VCN_INSTANCES], jpeg_gate, i;
 	int ret = 0;
 
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		vcn_gate = atomic_read(&power_gate->vcn_gated);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			vcn_gate[i] = atomic_read(&power_gate->vcn_gated[i]);
+	}
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		ret = smu_dpm_set_vcn_enable(smu, true);
-		if (ret)
-			return ret;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			ret = smu_dpm_set_vcn_enable(smu, true, i);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
@@ -812,8 +815,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err_out:
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		smu_dpm_set_vcn_enable(smu, !vcn_gate);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, !vcn_gate[i], i);
+	}
 
 	return ret;
 }
@@ -1258,7 +1263,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
-	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
@@ -1820,7 +1826,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
@@ -2023,7 +2030,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		smu_dpm_set_vcn_enable(smu, false, i);
 	smu_dpm_set_jpeg_enable(smu, false);
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
@@ -2937,6 +2945,7 @@ static int smu_read_sensor(void *handle,
 			   int *size_arg)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
@@ -2985,7 +2994,13 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
+		*(uint32_t *)data = 0;
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
+				*(uint32_t *)data = 1;
+				break;
+			}
+		}
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 0f074b6c8b58..427441b469e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -399,7 +399,7 @@ struct smu_dpm_context {
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
-	atomic_t vcn_gated;
+	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
 	atomic_t jpeg_gated;
 	atomic_t vpe_gated;
 	atomic_t umsch_mm_gated;
-- 
2.34.1

