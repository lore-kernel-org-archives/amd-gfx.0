Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F05CF0429
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E723710E5C7;
	Tue,  8 Oct 2024 21:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P02AUInz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B038710E5C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjUVLEgCLWyUkGv8waQPF1fU1VawnEDJk/8RXBSrePR/sku2MaXi7ko0bhKFXJUDnsROpTh8MYpxiUWX/HkYyCTB+dE4auwVbgn2J2hZoirrTwYXAYNvG+sW0XAjxDdnIwIKnQaa35BpldZzaLBnhm3Wq9xyLfANCggaxaSQdcXyn13626qUPkLSmmJ/iVLiwDkF6hHSCPB0RIJ36S62kyUUaBLXLV92tbf8p6WGwHTDIENq33sZGSvXElqLo3igMJTp5e6kcOzG92KMR0BtQ+jzkg26J4SqRUi4BH7GymYHj7YhnsHQD4uTALyEUEBBVAvmcM3iqnMoK3wHugNdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNsDGILsOCaOO0XkBAToBz14jS0bM70Ovx2pOoxGJwc=;
 b=K1yHn/58AstX3zAV+TS02p7uQWQRsoSPobkI67n8AebvPjgawJDnhM9S8ZAW7GBfFRKvifcNDbs2vZyUp80xNFzSU8P8KfRDiBkRbuBQe+72iohQft2RYcp0H5spKBVFgLIqn32mSHg9LmI1QcqrMsnHNKG86usJp9VnOytabeK3ZqfeDHRrbzlQhFmpulIcd8deZ7TkLjE7V02pS9GhAFgdy8++rcJomXv18JIwsnKmRL1tUo4/5KYb0wgpsusEGNlEZvvcvkBsbgxOPIfJplZSZgyDc4a3prplLWcMRXSxZ33cq9d/+TVcbM0/kB9yc+U2RzsMZBgHWFQLDDlb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNsDGILsOCaOO0XkBAToBz14jS0bM70Ovx2pOoxGJwc=;
 b=P02AUInzgNyuEBgFc66h48kI+xUmpeGPm9q/sSGnGuLInSkjfbPgUSE50hboiMcElyD33Grh+3dHJA1epoAG95PJDDpDNA5qMqZRtotaK8btmaqbxYY6HgJeWU3XIq0nt6gzChDvaUL8g3NX2Xcu+g0jH3fP2zC5FS+mLvBYcPU=
Received: from CH0PR03CA0399.namprd03.prod.outlook.com (2603:10b6:610:11b::18)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:16:20 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::22) by CH0PR03CA0399.outlook.office365.com
 (2603:10b6:610:11b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:20 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:18 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 02/32] drm/amd/pm: power up or down vcn by instance
Date: Tue, 8 Oct 2024 17:15:23 -0400
Message-ID: <20241008211553.36264-3-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea23ca5-8acb-44d8-71a1-08dce7de74c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VicTroaE7urzEIlUD/OjOr2uPxlllhgDsw8QNGyx0GkBwTN8T4Pf8olaNiV6?=
 =?us-ascii?Q?dj77oE0IqYaYFcHvCfcz4VsuJXAr/ggY/JztezzQvj/eDgLGWq1fnPnO2N4g?=
 =?us-ascii?Q?JdPHlBpotKztpZ4wiaNQE/q4b/D/p2DGBIrnIMQ0VANXdVV3gGRvW8uTSNEA?=
 =?us-ascii?Q?jrPPWltjDMIcvMx5VvWNurfte5u4TNA9+RlkNpAQCpkFPrGnsfQD4qyNJbsy?=
 =?us-ascii?Q?BlftzjnHa3w1dneA5JMxYER3UynUyQHc4P7FyZLo3iEhF+ITtmp3dIWzecQv?=
 =?us-ascii?Q?f86LCFFlJaCefMNNUA12xGOO+H83MFroI4o91EHeKKjXM0OzOJEVe/ened3j?=
 =?us-ascii?Q?LEG43w+xQvSZBtnZBJPyWiR4O9JBfZTiMtcrq6Xl9PXVtdHrSC3Tcr1RwVL7?=
 =?us-ascii?Q?8YYmUpq2GTKzRsryF3FL5Zh+kEN6WJ7bWO4X6BHeYe7iDTzSReyU5Uecllom?=
 =?us-ascii?Q?/59xvsGLGuawb6VbCDVg/qo0003BaaXFU6ORMQIiHWQVlcpUkcdkNagDVEvT?=
 =?us-ascii?Q?t5EnylXxBmGbirsICkuuYS6aZFOL+FDJUQPVMiz0/lJtWqYDy/cMU4KahiWQ?=
 =?us-ascii?Q?fDW2mpCyZJI8R3OcgM0BnlEEC0Zk3AmPhju0dH2mDM8RV7nbK/XQhTmF9zsv?=
 =?us-ascii?Q?JQd3Sg6MXfs+ogBJPx57541koPPmqUfy3fQri4RuDxm36ninqZzC5Qv95mVD?=
 =?us-ascii?Q?TTHdLnYtk4WhGppZyzS4Y7Ynk/hwLe1ugTIiRtOTPP6Poiry7dWyzfZPlsNw?=
 =?us-ascii?Q?SJWdGePEOASwaZnKMtUc9kUhEU4KWaB2WbqcFkLnzJO3uvf8RT4W0+Xr7G7P?=
 =?us-ascii?Q?p6vQn+kBi0XPAAr6GojYAv0tAwrskmIHxz26cG9a/tFifLVN36aAQIeLhwMS?=
 =?us-ascii?Q?grxnZUxVG5xxQZTmuWt0nQMgcEPJ8Zgjuaecnz7nVDN4UEmzSjsYo/iAVlJL?=
 =?us-ascii?Q?0wjjkNuUhwomRuO8UWGHtoqjav61sN10jmT9tq/sTnvDcDFIJXko5/osifW0?=
 =?us-ascii?Q?NgAu0R0x/Y/KKoau/JJqUUs2dwhzLeZ0tmkFZ0swJozEyKo/Jr0e/6rlu6W2?=
 =?us-ascii?Q?f4+HkSYJkudWqadDrqLnfUky44XcHMeNBbGmoF8nelQkRW/ue52X4BLl/NZd?=
 =?us-ascii?Q?h8C77lWMvdFEuqboud1tP7BMyDlinh4E744g5dwWF5BZD/QyMzDDWn+xpy8O?=
 =?us-ascii?Q?QZVVNX/L9RRLAJ+qbaMYFi+qeo5vln1Yh05C34oIskPagQHb7W+TNQChiH+U?=
 =?us-ascii?Q?XkTSvk0gudgAK5tiD87J0y5jwG8BMC2x/wJAsRxEqpcEimQxQmC4QRZNej0A?=
 =?us-ascii?Q?kqtb0bV9Kqh51E/ME4kBCuw9ATAK7SD5HBcPivQjrkFaqMRporq0PyfxaVPz?=
 =?us-ascii?Q?2kYmbaZueP/bP2qyubm4/fDvPqlT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:20.5614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea23ca5-8acb-44d8-71a1-08dce7de74c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

For smu ip with multiple vcn instances (smu 11/13/14), remove all the
for loop in dpm_set_vcn_enable() functions. And use the instance
argument to power up/down vcn for the given instance only, instead
of powering up/down for all vcn instances.

v2: remove all duplicated functions in v1.

remove for-loop from each ip, and temporarily move to dpm_set_vcn_enable,
in order to keep the exact same logic as before, until further separation
in the next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 +++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
 4 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6305fd7d2573..410d5baedfbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -237,6 +237,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -251,7 +252,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
+		if (ret)
+			return ret;
+	}
 	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 2438f813d6db..f41d8fd09bce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1157,19 +1157,15 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
 					      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      0x10000 * i, NULL);
-			if (ret)
-				return ret;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
+	/* vcn dpm on is a prerequisite for vcn power gate messages */
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+                                            SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+                                            0x10000 * inst, NULL);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1d37b9e251d4..e57d4926250e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2092,18 +2092,14 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
 			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      i << 16U, NULL);
-		if (ret)
-			return ret;
-	}
+	ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+					      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+					      inst << 16U, NULL);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5e1165ecdf7b..20822ac623c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1496,29 +1496,24 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		if (smu->is_apu) {
-			if (i == 0)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
-								      i << 16U, NULL);
-			else if (i == 1)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
-								      i << 16U, NULL);
-		} else {
+	if (smu->is_apu) {
+		if (inst == 0)
 			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      i << 16U, NULL);
-		}
-
-		if (ret)
-			return ret;
+							      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
+							      inst << 16U, NULL);
+		else if (inst == 1)
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
+							      inst << 16U, NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+						      inst << 16U, NULL);
 	}
 
 	return ret;
-- 
2.34.1

