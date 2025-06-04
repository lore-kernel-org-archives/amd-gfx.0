Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47892C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC1710E7A7;
	Wed,  4 Jun 2025 19:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nEj1+BLK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7F710E7A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtMMgySCYfnphhwsshlvROYtVw7HrlPc/FdKqyrvYwk1zO+z0NQCyx5OylivVsjCFzgVyikXAtK2cNiWsYxsMBTQzRC+cW//gujRqmCuPmzac/3ACS5Lsme+6JDCYjx/fLxeBZ7GTu7FYpOiwAPtWqrEQIzHVh0P0ZFmcl/dE6otaz7bFPw5ujOKArdC43OGVU17h8S71GcagHukN7YKcjRYDyu+QbKLLgNx3Z6kP7WPWWjEn6xj9xvhzqfpr3DanOXI3BLPRDN3qb78nDFnaPZmoMxxneKJhFgIEzFQFqJHYLD2aE+NC2EClur2WqIjVahb9X4+/17PdyzUSinCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcJYaozW1bt0UPh+NYrFBJvwW+nRdbuRYBa68kNvXnc=;
 b=R3alqPbU5+O/cGiijuvvDFDSRdO4G3n22kb+6usEUJAft7CcDm499Yhohk2HrfTdiuuwddXmLZALsfg0JDg+F8jQJMUJNGt26/K19EIFO6ebTbQpqxH6i/QAMJaFo2qVkXg8PFHL8AuAOHxPuI6tP2iq5jS/GMw7HUCSuEo2TPHOPehD7ZhbTSvvxG3SwJr6ZEjUEQbfQXup5PfY4g7+F5tPKfVmurhWQL6JTGe2miZ95t2MZBzKRuyx2ONjwqVnT0HZsDK+bmgpg2CbhK8PMupLrbS3hboKHBp4q0g799ht4UoGpWCzEXQ6vAXmqcTPGr5ZdoVbAdlG0Kl6ls5rLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcJYaozW1bt0UPh+NYrFBJvwW+nRdbuRYBa68kNvXnc=;
 b=nEj1+BLKG2RWRYRP+KjW8K7/KMhouQLp1LCHbdjsRLvMNJPKREch0zJTTxXsOwqeeUpYZwpmMIcV1Ej4pCJ8YPQs7ieL77rQa22pR1Rokdq2k7JM1aeKK7V/YDGLFAxzL2RRJuH8mr+AIQvV1zer+pblRW6LtaibLAqXi0brVe4=
Received: from DS2PEPF00004562.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::507) by PH8PR12MB7159.namprd12.prod.outlook.com
 (2603:10b6:510:229::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 19:39:50 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1003:0:9) by DS2PEPF00004562.outlook.office365.com
 (2603:10b6:f:fc00::507) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.8 via Frontend Transport; Wed, 4
 Jun 2025 19:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:39:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:39:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 11/23] drm/amd/display: Deprecate Loading Bounding Box From
 DMUB On DCN4
Date: Wed, 4 Jun 2025 12:43:22 -0600
Message-ID: <20250604193659.2462225-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 130430ba-dc5b-4df7-1ed3-08dda39f91d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sYumST5h+WO5fMRaREOjCJZO6A27S8BXSNfFtFX5DImUeyHvchCt3kHwSiTF?=
 =?us-ascii?Q?dxMr1k4mJApARmFrVmMp8qIflEBiSoxaUAk77YwgBidtaKseFgjPMlDTZpUn?=
 =?us-ascii?Q?d+tyQC16wndWa6mgXdLok/HAZT5fN/9OKHCET7yIrZsr5DigYcBhyCw0FOQz?=
 =?us-ascii?Q?nUd4kA1nT+S2056fmW8d2/SozZIDjW0pYXg+SjB5L6jffaieLH/K16HHfQPV?=
 =?us-ascii?Q?wDW7evyMP1cb9j3ce6uKM3CF3yqAWTrm9nSSoiJ7oHkgD9225m3wMCAyM2RS?=
 =?us-ascii?Q?zUEK+Hz7kZMxReRhpRdeseWVnfcAetN3wDMwvg4J8/Br/ssKXLNSnSJjboKp?=
 =?us-ascii?Q?c615R1MvYXDnhq/Dd9X4x3V83lndJIhhey/CbWVob8KBHm1XIu0WoMhs6cMM?=
 =?us-ascii?Q?zDCcXRg+cCT/o1TXwfQu9sXRxjUCKe1lnHpOtAL30v62qYOye1z8BHqvDlrJ?=
 =?us-ascii?Q?my7XsMAB3d1Vmn80nRAgHL4gsTL44eOLB5I/k14hSs/hfnfL45jRgWnj76Yo?=
 =?us-ascii?Q?m2cxmQYsJk063VdYePBJMakh+PE3tF/O+0UvyAqiKHAXQVBH4sDG45wx8usP?=
 =?us-ascii?Q?Iux0ZqcnRkbNO/mA+QqycSgmeXce5ruPlx14XgjdKExzYtT8Qco3TnUauxIH?=
 =?us-ascii?Q?nUyoSGG9HMsGVeppwFr6/RcbJ0ZCgODrtKBvQ0NU3I11zaKQBPNjjkEOYeV8?=
 =?us-ascii?Q?Nq2bfMXlyyKUu5SXYTsWr9HuS9hVclwKBPR0J4AkCf3UnxDTcXpMJTqIlzOB?=
 =?us-ascii?Q?3pxFl617LtczpdeXEsBCJOSf8rGXAZc1/WHFqeR/MRzV7Qy47/Uukzb1x5vK?=
 =?us-ascii?Q?6vHE4XZqJjXzU8GKtA510tE1VqaoNXHl4RKdkrdhrJpIoSHVEkkAzT8BSTUP?=
 =?us-ascii?Q?rgSMQMxC+bnGuvw5/2+ihEt8nkbtDV6uaq0/OOIdPMd1kTjQvlXDw92IaQ4f?=
 =?us-ascii?Q?9xM1E3v8Xm+K2+o2kDtcGBkUknk7eFOI+8Z/IZwmplhtLY/OdZw+zK8fSsVu?=
 =?us-ascii?Q?qvNk02kTk8lg4Ge6kYQ3wdGFINrftGMLhsO1Y1Biqrd22IDRxaLFPEUY82mr?=
 =?us-ascii?Q?rvdWpJPvKjNZwCt+n0iXss1mTE6kZb+99/mrHsY2bgkkE+Jv5nGQq/RO+38S?=
 =?us-ascii?Q?SvAPZj/NxxZgrYE+P2lM81KoUkevzPCdSqAlSiUCQkbu0U79WXRBWa9OMubI?=
 =?us-ascii?Q?p/3doxqrx1TnfXRwpFq020rMTJVeB+55F2cEz7aUwJtKsCfROpM8nyb+cezb?=
 =?us-ascii?Q?+G0KzrfI73g/zpPv+Vrkkj1lPnPVjGxB3MuEexwyzUCXK5O0P9PfL3fipitP?=
 =?us-ascii?Q?wy9Fq2gUsMfNLM9Ot7ZLUoTtyY0CEB/BHNHsDnpRXzbhHCOp0numOKAdkFc6?=
 =?us-ascii?Q?LsFmaANSHVYPF8fly/Ff859qyjFI7Kg8Wxo+FBSDXR0xakrI/b2zjCfO5Iq5?=
 =?us-ascii?Q?z78oHqoYCjeYPHjdudpf8aTj8hoJnnSbkfQfFhXCLlAP4Yr8Dz5Zp6Ys9fkp?=
 =?us-ascii?Q?NCaneQ5rOjVrp8za2+IIacn9ulr6ThoDICSr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:39:49.7264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130430ba-dc5b-4df7-1ed3-08dda39f91d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY]
dml2_soc_bb struct can continuously receive updates for future ASICs.
Alignment issues may arise since VBIOS DMCUB contains an older version of
the SOC BB.

Populating the bounding box with values from DMCUB is no longer necessary
since values such as UCLK will be overridden by values acquired by PMFW
anyways.

[HOW]
Use bb_from_dmub to store DCN specific bounding box parameters in DMCUB.
Add helpers to translate DCN specific struct to the corresponding
dml2_soc_bb field.

To avoid alignment issues:
Deprecate applying DMCUB SoC BB for DCN4

For future projects:
Create a flattened struct containing all sensitive parameters in the
bounding box. New parameters can be added to the bottom of the new struct
as needed.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 17 ++++++++++----
 .../dml21/inc/dml_top_soc_parameter_types.h   |  4 ++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 23 +++++++++++++++++++
 7 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 78816712afbb..6c23aec44295 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1758,10 +1758,11 @@ dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
+static void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 {
-	struct dml2_soc_bb *bb;
+	void *bb;
 	long long addr;
+	unsigned int bb_size;
 	int i = 0;
 	uint16_t chunk;
 	enum dmub_gpint_command send_addrs[] = {
@@ -1774,6 +1775,7 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(4, 0, 1):
+		bb_size = sizeof(struct dml2_soc_bb);
 		break;
 	default:
 		return NULL;
@@ -1781,7 +1783,7 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 
 	bb =  dm_allocate_gpu_mem(adev,
 				  DC_MEM_ALLOC_TYPE_GART,
-				  sizeof(struct dml2_soc_bb),
+				  bb_size,
 				  &addr);
 	if (!bb)
 		return NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d7d92f9911e4..b937da0a4e4a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -636,8 +636,9 @@ struct amdgpu_display_manager {
 	 * @bb_from_dmub:
 	 *
 	 * Bounding box data read from dmub during early initialization for DCN4+
+	 * Data is stored as a byte array that should be casted to the appropriate bb struct
 	 */
-	struct dml2_soc_bb *bb_from_dmub;
+	void *bb_from_dmub;
 
 	/**
 	 * @oem_i2c:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4f162905475d..33209e056a0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1188,7 +1188,7 @@ struct dc_init_data {
 	uint32_t *dcn_reg_offsets;
 	uint32_t *nbio_reg_offsets;
 	uint32_t *clk_reg_offsets;
-	struct dml2_soc_bb *bb_from_dmub;
+	void *bb_from_dmub;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 8b45b0bcc396..13a12f38eb3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -11,6 +11,15 @@
 #include "dml21_translation_helper.h"
 #include "bounding_boxes/dcn4_soc_bb.h"
 
+static void dml21_apply_dmub_bb_params(struct dml2_soc_bb *soc_bb, const void *dmub_bb_params, const struct dc *in_dc)
+{
+	switch (in_dc->ctx->dce_version) {
+	case DCN_VERSION_4_01:
+	default:
+		break;
+	}
+}
+
 static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_init,
 		const struct dml2_configuration_options *config,
 		const struct dc *in_dc)
@@ -21,10 +30,7 @@ static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_
 	switch (in_dc->ctx->dce_version) {
 	case DCN_VERSION_4_01:
 	default:
-		if (config->bb_from_dmub)
-			soc_bb = config->bb_from_dmub;
-		else
-			soc_bb = &dml2_socbb_dcn401;
+		soc_bb = &dml2_socbb_dcn401;
 
 		qos_params = &dml_dcn4_variant_a_soc_qos_params;
 	}
@@ -32,6 +38,9 @@ static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_
 	/* patch soc bb */
 	memcpy(&dml_init->soc_bb, soc_bb, sizeof(struct dml2_soc_bb));
 
+	if (config->bb_from_dmub)
+		dml21_apply_dmub_bb_params(&dml_init->soc_bb, config->bb_from_dmub, in_dc);
+
 	/* patch qos params */
 	memcpy(&dml_init->soc_bb.qos_parameters, qos_params, sizeof(struct dml2_soc_qos_parameters));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
index 5f0bc42d1d2f..1f5eaf79a8d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
@@ -99,6 +99,8 @@ struct dml2_soc_power_management_parameters {
 	double z8_stutter_exit_latency_us;
 	double z8_min_idle_time;
 	double g6_temp_read_blackout_us[DML_MAX_CLK_TABLE_SIZE];
+	double type_b_dram_clk_change_blackout_us;
+	double type_b_ppt_blackout_us;
 };
 
 struct dml2_clk_table {
@@ -130,6 +132,7 @@ struct dml2_soc_state_table {
 
 struct dml2_soc_vmin_clock_limits {
 	unsigned long dispclk_khz;
+	unsigned long dcfclk_khz;
 };
 
 struct dml2_soc_bb {
@@ -138,6 +141,7 @@ struct dml2_soc_bb {
 	struct dml2_soc_power_management_parameters power_management_parameters;
 	struct dml2_soc_vmin_clock_limits vmin_limit;
 
+	double lower_bound_bandwidth_dchub;
 	unsigned int dprefclk_mhz;
 	unsigned int xtalclk_mhz;
 	unsigned int pcie_refclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index ff52301bcfc0..c384e141cebc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -240,7 +240,7 @@ struct dml2_configuration_options {
 	bool use_clock_dc_limits;
 	bool gpuvm_enable;
 	bool force_tdlut_enable;
-	struct dml2_soc_bb *bb_from_dmub;
+	void *bb_from_dmub;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index dc4a8b83e6c6..4cdc75adadb2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -299,6 +299,29 @@ union dmub_addr {
 	} u; /*<< Low/high bit access */
 	uint64_t quad_part; /*<< 64 bit address */
 };
+
+/* Flattened structure containing SOC BB parameters stored in the VBIOS
+ * It is not practical to store the entire bounding box in VBIOS since the bounding box struct can gain new parameters.
+ * This also prevents alighment issues when new parameters are added to the SoC BB.
+ */
+struct dmub_soc_bb_params {
+	/* dml2_soc_power_management_parameters */
+	uint32_t dram_clk_change_blackout_ns;
+	uint32_t dram_clk_change_read_only_ns;
+	uint32_t dram_clk_change_write_only_ns;
+	uint32_t fclk_change_blackout_ns;
+	uint32_t g7_ppt_blackout_ns;
+	uint32_t stutter_enter_plus_exit_latency_ns;
+	uint32_t stutter_exit_latency_ns;
+	uint32_t z8_stutter_enter_plus_exit_latency_ns;
+	uint32_t z8_stutter_exit_latency_ns;
+	uint32_t z8_min_idle_time_ns;
+	uint32_t type_b_dram_clk_change_blackout_ns;
+	uint32_t type_b_ppt_blackout_ns;
+	/* dml2_soc_vmin_clock_limits */
+	uint32_t vmin_limit_dispclk_khz;
+	uint32_t vmin_limit_dcfclk_khz;
+};
 #pragma pack(pop)
 
 /**
-- 
2.43.0

