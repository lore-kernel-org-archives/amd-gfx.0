Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9063CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBC410E8D6;
	Thu, 25 Jun 2026 08:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOUB0AqC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF91710E981
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSs0Q016JvtDsh1WMLsrjinHe3YP3Ay7PITsVa5JuWItgcddD0NVXo/hRn+Tlj48i4OLdw7CQKPQkyf3xjMppHWUOAG6gxhOVOmEVIcgbfd/UbB6yyLPnfdvjIOuCAR3rESu0nZMNkb5ZIsKUKKgyIaKUuN1IvVb5QTy5u2UlySqI9I5Nyfbu1gGqCaGnvSLxcHd3Z0df3y52jSrHhj+G2sdVc5CM0r9UW9Cr4ZW7wOlXasJZpcOwMKCdtaMcU1qJi9bhhIUDBBiKR3Mrn/mkym8LLFZWhLEOhgAYOUSqaMEMwJizSY/5IojlYts/CbQiADXatNtT4vonQ2mnCG9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJIxIqEfRNWcVvFJGoZUlQsAtpszRexO7/fQC2N+OAI=;
 b=Rt06TeXHbHeZlHucFkTH9oUZeEYhO29AsDMgDf78ywc0l4eUMnCvVkjyG0F64GxIIt9gTDRvNlpg8hGNcRw7MvG7jTMA5AbPobPdEK1u1bDhllmWmc+UBwnWEL2TY3R9mf6KufC5c15XODxIDZcyq3e0vXeru7ZpN8syR/iIEgtjCEq42ntNnD6XZiu1CYZErZ+kjLmKsJ8P+undE74FxZIx1nOTMb064u9ahO+qcjadS+ZlQnFO67l57ySrZaEroNAfioBlareao+GXwNoDDM/p6k59GQ9qsTT/EEFAOjDkqU3gv/ybcDrPGjiN07Vzc/t5cX9Fe1d8hr74WlwU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJIxIqEfRNWcVvFJGoZUlQsAtpszRexO7/fQC2N+OAI=;
 b=rOUB0AqCmeo8Ofg3Ry4R74Cls4gFlXcKYzowgtH0884pdWPfcY91ATBN2pqweTzeLL3xb8oiV+7o4qXcBMtnvZoa/8LRmO9R/Rm8QJNOAjMMUIavtpZ9rucM0Sd1BKR36O0vHKatkolehoR9/1c9pEpjTeF4HcUkIpcDMjYRzAQ=
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 08:20:19 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::aa) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:18 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:16 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 05/44] drm/amdgpu: retire ACA support for jpeg v5.0.1
Date: Thu, 25 Jun 2026 16:18:58 +0800
Message-ID: <98a31ab2bf6e65c30323b59849cf526bcd433680.1782373701.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 005d3907-7a4b-490a-7be4-08ded29297c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0Oe5zoz2d7GLYj39kJOiwGuO0BgNjuocYda2aXhchbzU33+HMKfZtuW/I2LAipgoCaqiAbTrKy1lKBapx8PRg0ammdLgEC+WZSr7ojLwoJ/lKxmdyWQ/9PfgCsbQyBBM465m+go56+kE/TD9O5X+7QRHR5qA0pHYH3O2UKdk/Kx1kuuPLRfzO4k0kR625YjdEE9ncm6Kv7tnskMSvSJ6bjFLXECp6edEzxk9RfFNDkyhkV8OedgCoi5vmh7qp5yU6G37j/EekEIvaQo4qoDlEYcr+ELpinb8R4nEfIHfKWH4fmnlh8IhNYrsqMryZ+jHDYubcKMZ1WML0Zr9zclHE0ghSE6hWGBsBFwP7RygvDRholUGdZ7NVGzwHZgwwN6h1GG8OuUfQn0AGaGvdq5tW18lTTGJ9KrirYqMBv1RCWT9g0hdsWDJbTw8/Lyg48jOcGX4KbxuxP4p/VNnjrMmZ7/RSM4jXb8B7Nk7uJHTzGHF5xteG6cJIPXm5terxHoYabLPK5GanDhaqBrroVVJHG4NMdOGiOP2ZX6T8elUr9L0cahcxL+p6mjbDN3nOkUbBJwEImDa8w8bfszC0g7+5QAcFllleN3EwgQAPdxSSbT7OJ8LXVHLwEjgSPcJKRFbXSuW+bEC3Jc3ImbsxllJ/7OXV0VQFWg2CJTmMiDA+14XCZ6Iu6TJlEtT/1gd42f+V90zVY+E2EsGEWNnbfljcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aDShUL8gf4WCWopmF9RCGvmeTbURpYhwzWd2v6yYIQeKTkbzxSOPHPz7IqMxmMDzL6zdAF7/xNK36wULw+IzFBgfM7ujQdO4YzJNXS/MJBBIERoREDVd8FKkxBV2rFOFQr/GQL2weO2COabBUw1C6d5plkm+dy9pN5Ig69eYiGs6x9GMPrBj3MKITx/kf/yKT1ULoSBE3GnYwE10kw2PuEFR/ZVrDIbhLhjjBzgvwUonW4t4ef+YKGjDrl4/Au7/K9pTI+v2IhSHFmjJvXg4teU6NJ/oCM25970gs0iBOL4bbJY+DaQikyZ+fPUQQz5/HrQ++BuZP/GBcJeM/4G29RQNwChsDlbS/V4iT4Ah4OTmfHit+cHO/ZuOPPS8/llM3BYVpBDbcstV+vD4aa45rIFlopPBwNNibbmjpGsclBOYbUiWCuhHK83soAleUz7O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:18.6412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d3907-7a4b-490a-7be4-08ded29297c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

Retire ACA support for jpeg v5.0.1

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 72 ------------------------
 1 file changed, 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index a562369d2d81..324d5899bd80 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -1017,73 +1017,6 @@ static const struct amdgpu_ras_block_hw_ops jpeg_v5_0_1_ras_hw_ops = {
 	.query_poison_status = jpeg_v5_0_1_query_ras_poison_status,
 };
 
-static int jpeg_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int jpeg_v5_0_1_err_codes[] = {
-	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-9][S|D] */
-	24, 25, 26, 27, 28, 29, 30, 31,
-	48, 49, 50, 51,
-};
-
-static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       jpeg_v5_0_1_err_codes,
-				       ARRAY_SIZE(jpeg_v5_0_1_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops jpeg_v5_0_1_aca_bank_ops = {
-	.aca_bank_parser = jpeg_v5_0_1_aca_bank_parser,
-	.aca_bank_is_valid = jpeg_v5_0_1_aca_bank_is_valid,
-};
-
-static const struct aca_info jpeg_v5_0_1_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &jpeg_v5_0_1_aca_bank_ops,
-};
-
 static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
@@ -1092,11 +1025,6 @@ static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	if (r)
 		return r;
 
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
-				&jpeg_v5_0_1_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
 	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
 		adev->jpeg.inst->ras_poison_irq.funcs) {
 		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
-- 
2.34.1

