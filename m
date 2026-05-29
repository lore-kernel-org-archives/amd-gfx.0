Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88CDCD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A10E10FBEC;
	Fri, 29 May 2026 09:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SSpvO6vK";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B409810FBEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaarPzeoGNQsCRdk4QTP2hbW24e/PqPfXmikWu+/sLeQYx4M3Zu0H4atbwIaHt/tTmwje2u0LHnL1Znw5Y993pIUuC1dtuFlS44SNvjNK9wabAUg8c9FDU0NFJ+J2ATgqXp7hvVpxNAusmkBxszaJ+ykOjZLDlYZwvOIoXXPHLhcpPAuydTnqHM7imN7ePq8PVlCUhhppqgvhC/Zgr9qoRx34nXtQUHtPcqexrJpEvVL3tJnSKDDRyFOxISsFZ/Qasua5jaevjSmHl3w3LASe4TfyId1ippiyfQvDCGvG8Q0PzdAHrXDbHTkj7wTFFYhx06WAwWfKvX3BL58kzIDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze27ZgN/CGf2pkEtSKHe8y14i6IiH10WC+npjr+sQmw=;
 b=QkNHgH+Ut9XF8N+NYRKp0OpLaVqYb+C4i8tvU3h80ykSH+zDotlfOR4Z7uNVFfLe+rWFMTfM6WLxQIPNgmgz5P61e0ZYg+zWY0z//GvU7MdJIkf5dkDeoD0c4bLoQwtITU6vEK2l4Haw67o7AXEsMbOJFe+fImPERsnA6J45gse8anP/zC4duWJygv31F8jHdGcN5+VbL4uoaDeEeUEV0Gpticgc23QeZ/QvXSlKvyqQqAzBRoBAkiDhDTsrtpnjS/jkSwaC0eNddrI5b2G+afHuUVMrWhtXUwT0c0hc/JnQ/ubLTJo3Zs7xTTNOVPYpddJMyFpV2AkcxLgnxvNC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze27ZgN/CGf2pkEtSKHe8y14i6IiH10WC+npjr+sQmw=;
 b=SSpvO6vKxrq0HtgK+0jmtKaPz882FG8voNOISy36FvU6BWUnpIiIXGNYButs1dB4gcESQYENEpwNNc5KfOXkOzfalHJKR+ZAhR+vV/y+WAvSVcf4M1IC/ptugWBF6Yqc+9EIi5f+FZPOVNZMGSTOIXNbnvEgRxRGa8IDKr1HjVA=
Received: from CYXP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::17)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 09:41:44 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:930:ee:cafe::a7) by CYXP220CA0009.outlook.office365.com
 (2603:10b6:930:ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 09:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:41:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:41:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 4/5] drm/amd/pm: Use helper to get pptable in SMUv14
Date: Fri, 29 May 2026 15:11:18 +0530
Message-ID: <20260529094119.1134923-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529094119.1134923-1-lijo.lazar@amd.com>
References: <20260529094119.1134923-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df42b93-6eb4-4069-ee51-08debd667e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Juwyq3lRyB4LR8B9EnC0ehr8UJkp2zkjS3AgEZucUKma75W8S5DBYk7aAuKIJt5mD/qqj+qgGDt+fiqQKcJyCLJ5JEJjV6R/MjYPJFfY+eCz+Wtk7YGpb3j8QTdVwAJ8WZoTpKCMVsQ8r/BH3FWPh05h4VAGI8LAaOH40Qr+MjlaXiweWsVBKzviVwVIne6GWgI+7rmE/0a5DN/qEAsgYc4UsZY4rb6k7nUgFYYU3Z7wvuEqtvZWPddlDqQ/5/GFbEGCcakhPnkE/koDUVxf83mvWXjJNeUXeY3kz7QyU1X91fdVu4HIQoKGbduvANy5HtJD7ABSb/WjSw9GtyWheio0PLSj7saKzNvEO6sveeECGYVIsLtPSsfeNNgUrz2oZo/flmJtc2AKRedC7YzPqXQ6lf1YxFOitjHpCBLa1fXTuTGNBQKQzWVQ8jAbcYdpkgLoWglrt9a1X44BgiwN1D/XuHoGR+yjGzsRsOaMgQ/ennmrE/aCdeNhTcKi97fw37RpWMOya4vuz/zBwg06ZWBOm8wClKA+OwJKxYwF/MzrgnpA8kWFNL96Eeuo0H0gTtjg+H+xTSh2q+NBkypja9acjefHgd8yzpQPayypdRCXmkEx7Bx6JaffFhQTXj0ofQ8KKWBbLB1D1D9E6YqdVUXLFK3nY1uoTVLq+olaAfAxIt3+vjJtzOH5AAgJ40X1vRxQiO7S240ZErFkCkKeRDmgfPIRAxhxRR0Hnk+VOTY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AGfKROu2jaMQ63gWbWh54BCQlKBcqhskQ3xrL8ZkwvSQxa8U+/SyPJ/R+17xtzhXgwhnYrbgtXCV/qL9pZqKc234yCkLCboDqUJ2jyNxhJmbevta8O0ZaLVgTu1E703yG+X8JMz+CyLp2RYM8+dE4pLQD5wPRZ1waz5psv19LYpbY7owGAETZFN5HdZEXRsHmLD/CeZWkdJg3ZID4A4v3FfGmQ6Vh6AwrNQ3acyT+2l7dijdI/WERZ8hkg5yf1DMYZhl+NYvFa3kBDotcb2y8oJl80ZfLSjuvB3rB5sZIaPUVf209cCTRAb+HOcADWC7oMSnaE/fhxsmyrxVCLI+5h2Rlc82ixKgKNPFuSzbivR+uZJgpBaeCTR/Btbmf8+slTSULRUbSqThq0I208ePdJgwbzuKRZCamlku4UkeyZIXjIH2qePith7mkct2GlGX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:41:43.6692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df42b93-6eb4-4069-ee51-08debd667e58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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

Use common helper function to get pptable from firmware binary in
SMUv14.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  4 -
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 85 +------------------
 2 files changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 4eb40ff8aff2..dc8e13a7c879 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -203,10 +203,6 @@ int smu_v14_0_set_gfx_power_up_by_imu(struct smu_context *smu);
 
 int smu_v14_0_set_default_dpm_tables(struct smu_context *smu);
 
-int smu_v14_0_get_pptable_from_firmware(struct smu_context *smu,
-					void **table,
-					uint32_t *size,
-					uint32_t pptable_id);
 
 int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 			enum PP_OD_DPM_TABLE_COMMAND type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 61655841c2e2..22faa46a2acc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -194,7 +194,7 @@ int smu_v14_0_init_pptable_microcode(struct smu_context *smu)
 	if (!pptable_id)
 		return 0;
 
-	ret = smu_v14_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+	ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id);
 	if (ret)
 		return ret;
 
@@ -229,48 +229,6 @@ int smu_v14_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-static int smu_v14_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t ppt_offset_bytes;
-	const struct smc_firmware_header_v2_0 *v2;
-
-	v2 = (const struct smc_firmware_header_v2_0 *) adev->pm.fw->data;
-
-	ppt_offset_bytes = le32_to_cpu(v2->ppt_offset_bytes);
-	*size = le32_to_cpu(v2->ppt_size_bytes);
-	*table = (uint8_t *)v2 + ppt_offset_bytes;
-
-	return 0;
-}
-
-static int smu_v14_0_set_pptable_v2_1(struct smu_context *smu, void **table,
-				      uint32_t *size, uint32_t pptable_id)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const struct smc_firmware_header_v2_1 *v2_1;
-	struct smc_soft_pptable_entry *entries;
-	uint32_t pptable_count = 0;
-	int i = 0;
-
-	v2_1 = (const struct smc_firmware_header_v2_1 *) adev->pm.fw->data;
-	entries = (struct smc_soft_pptable_entry *)
-		((uint8_t *)v2_1 + le32_to_cpu(v2_1->pptable_entry_offset));
-	pptable_count = le32_to_cpu(v2_1->pptable_count);
-	for (i = 0; i < pptable_count; i++) {
-		if (le32_to_cpu(entries[i].id) == pptable_id) {
-			*table = ((uint8_t *)v2_1 + le32_to_cpu(entries[i].ppt_offset_bytes));
-			*size = le32_to_cpu(entries[i].ppt_size_bytes);
-			break;
-		}
-	}
-
-	if (i == pptable_count)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int smu_v14_0_get_pptable_from_vbios(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -293,45 +251,6 @@ static int smu_v14_0_get_pptable_from_vbios(struct smu_context *smu, void **tabl
 	return 0;
 }
 
-int smu_v14_0_get_pptable_from_firmware(struct smu_context *smu,
-					void **table,
-					uint32_t *size,
-					uint32_t pptable_id)
-{
-	const struct smc_firmware_header_v1_0 *hdr;
-	struct amdgpu_device *adev = smu->adev;
-	uint16_t version_major, version_minor;
-	int ret;
-
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	if (!hdr)
-		return -EINVAL;
-
-	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
-
-	version_major = le16_to_cpu(hdr->header.header_version_major);
-	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if (version_major != 2) {
-		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
-			version_major, version_minor);
-		return -EINVAL;
-	}
-
-	switch (version_minor) {
-	case 0:
-		ret = smu_v14_0_set_pptable_v2_0(smu, table, size);
-		break;
-	case 1:
-		ret = smu_v14_0_set_pptable_v2_1(smu, table, size, pptable_id);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 int smu_v14_0_setup_pptable(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -351,7 +270,7 @@ int smu_v14_0_setup_pptable(struct smu_context *smu)
 	if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
 		ret = smu_v14_0_get_pptable_from_vbios(smu, &table, &size);
 	else
-		ret = smu_v14_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+		ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id);
 
 	if (ret)
 		return ret;
-- 
2.49.0

