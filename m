Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB2CCDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5767210EEA4;
	Thu, 25 Jun 2026 08:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fQ7Jb00z";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120D010ECB5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW0m/WuKDgdQsvaMsy6x5xuZO4cRzfjF/2SDZSZUy412WWayuzm93Njy7ifTgBx5F7nxTne8uMDrnVynAEGQhxg/QhFkCYTXKq6vcOXrr0PwUCAqWSQhpNvykhhWes59Hvq674OEk9T5X4+ppGOG15sRyp+4Ha5+8Lg6lQIv4fHIdxe8QQdOG21e7pHSWqzol0x923a0sr11Jfg9nIAHbOzykx4eCpyu1msaNU5fIu6rd+J0HzuV+B8PQ1sKyHwCYWWs04emM6Lj3RbtMzjFiUOyLu4j9/tNeiN8wz6eavWKkYSBWH8m4EnEYIMFTiiarwooholovaYHLTXxDmPyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnA/vfR18tcCM0/EXtmQRMonq0HD1GrUIiiRf/iJPt4=;
 b=a3Cqe/6OcSXy8Ggrn9xgPBw7gRp47ZOAdm9P3XysVYiIMW0v+etVdtPhSxprgtL2uXTJY4wsdgqJfohIgFbbJcrFk5zd1O8TOHFRPqVpSfBasF5lO32fuOqCCZGbd43n+Ha46fZEm0v7vgUZIk7AWYRCjoBwQ3+SEHryQiO6fEgBN7qbiZ3IaWBhBTYMtK78xUZyMbZ+UUbC6Nq33kttS5PuajQ1KQk8iI/GfO58uYummirUc+dJtm43yyOswRba59NrBXAEmYFb4NiiQEqlZcKONRabyH3Mx8QQ4nfo3LfqG5SDBFP9FEYdIUnHQRkjJTn7CZsXV8vOiIpEBMILNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnA/vfR18tcCM0/EXtmQRMonq0HD1GrUIiiRf/iJPt4=;
 b=fQ7Jb00zVNDW/AxbPON8JcvjsfioQJ0pN7xoD278odyNd/+q0GpH/uXi1oA9bA1LhqmKyVj7XkPk7zDsQuOseBous6y4bEBt1I/2VWzDjmT7sNGulLiBMDxq1FypEyQxyLOuZHgcoMIt4lLXabI0ttFMuJXA+dZJlxiO07afTyg=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Thu, 25 Jun 2026 08:20:29 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::95) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 09/44] drm/amdgpu: retire sdma v4.4.2 ACA support
Date: Thu, 25 Jun 2026 16:19:02 +0800
Message-ID: <ee77ca64973f8c24a67bab4f8aed4ade17199eb3.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 32466b74-157f-4c6e-6c05-08ded2929d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RyPeVogyuWIcbAbiTy/VAmVpNDYUK1+gDZ5RT5nbTOCpIQ+UV7NGeVR7dkFgrvwcEHVm7Ay1mk0iV9MUrBV00Bqkc/T5XMyyqZzbnaj6tcINVUSYZi62CM/NAgHDVfUsEwMcETs+iocx9PjkhQosTJRuo0wZZMSpG8DPKq5TLQSmzMozPpSVNE3XtpKl6x7WoccstnRKZDJTvoH+PIVcnxPsFdpqqN8ZdOKTb68ookMApkmnxPbZON3XiwFNU68hfCw9PGYAa/zJFFg4mCX3PqF1+OUWkToONQ3//nghHxvJycaxnk00UUgc1aA8OUh4KRRZrT+hGFHSCvble9tYd/eo+QtzCGA/d7mnQ8apBvwUc9Yml398hfCuAJ+KDLdDMtUCvg7X8UdLbj3R73bpxEs/50c/H8QMLfhaos3MTIofEJlL1cdI91dmtGOW5okb6Vw1LG1UHbeG15/JLcVxABeyKNVns12k1sMN0nAjYJhT7ME8aCAFLJX5xXgnXbDbAmAnt0583+jCHQqnCtuFB3+up7iAR9pd1spA2OCtfRKJp2tjjgLQtBCWzqGKvXTll6+5EJBv2eLkEZGAeaHF4dc24fwlt0s0p4vwU30+chbgPGq/JJCwOntOpiz5em7dFCnQ+OHpHwsrejfnZ3xew6JVWHka84yDdNXsWqX2s5KnDBpEANvou00NztVaEdk36luA6aTiYj8TK3MGKj4UUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U78eLcmrL4dPEkGgddWxOYjAS939Rs/5w+EG/Vbw1hy74NZvsYddvyVDfshQ1InoMrbyXirmAX8VIv7r8JQlg8+oQkeamMrj6VlLCTzUoHNLS2VJH02JeLQZA22dvvJ4CpOhQzVRxlCKolLuXnC0JeVXAFxUivGyzQll0o2tkprnlqEf8e13y7Nu5LALm+1CmOCeeLcGO3Xv7NOKfhquntOdKD4D6sF1oKBVMaP7pzrHmmMRfM75agFJGjfcg0aCMFRE7q6dGTGy4irfWvHS0kEdQV7LYOLEp30foBNYuijoqAJsO75mPCu8mzLGLrZJej1H9tSEfaEcLy2LVE52mPeQjmEm/VHRqml5OcxkKdgE+HxrScS0Buok4BQavebdwgLdPvNyWuf+HHxbMEgTz7ZvtG3Bu/8xwg2djYGSvoLjY1JcB9Th9ExtntkIDCqe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:27.9443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32466b74-157f-4c6e-6c05-08ded2929d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
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

retire sdma v4.4.2 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 78 ------------------------
 1 file changed, 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index a7685b516f19..0d7e22060a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -95,8 +95,6 @@ static const struct amdgpu_hwip_reg_entry sdma_reg_list_4_4_2[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regSDMA_VM_CNTL)
 };
 
-#define mmSMNAID_AID0_MCA_SMU 0x03b30400
-
 #define WREG32_SDMA(instance, offset, value) \
 	WREG32(sdma_v4_4_2_get_reg_offset(adev, (instance), (offset)), value)
 #define RREG32_SDMA(instance, offset) \
@@ -2520,85 +2518,9 @@ static const struct amdgpu_ras_block_hw_ops sdma_v4_4_2_ras_hw_ops = {
 	.reset_ras_error_count = sdma_v4_4_2_reset_ras_error_count,
 };
 
-static int sdma_v4_4_2_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				       enum aca_smu_type type, void *data)
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
-/* CODE_SDMA0 - CODE_SDMA4, reference to smu driver if header file */
-static int sdma_v4_4_2_err_codes[] = { 33, 34, 35, 36 };
-
-static bool sdma_v4_4_2_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					  enum aca_smu_type type, void *data)
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
-				       sdma_v4_4_2_err_codes,
-				       ARRAY_SIZE(sdma_v4_4_2_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops sdma_v4_4_2_aca_bank_ops = {
-	.aca_bank_parser = sdma_v4_4_2_aca_bank_parser,
-	.aca_bank_is_valid = sdma_v4_4_2_aca_bank_is_valid,
-};
-
-static const struct aca_info sdma_v4_4_2_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &sdma_v4_4_2_aca_bank_ops,
-};
-
-static int sdma_v4_4_2_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_sdma_ras_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
-				   &sdma_v4_4_2_aca_info, NULL);
-}
-
 static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
 	.ras_block = {
 		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
-		.ras_late_init = sdma_v4_4_2_ras_late_init,
 	},
 };
 
-- 
2.34.1

