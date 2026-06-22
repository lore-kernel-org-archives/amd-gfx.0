Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7F3CDB477
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B9910E55B;
	Mon, 22 Jun 2026 08:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sH7lQOgD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1651C10E55D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDRzsV49UqXfMamaiqh5qF7ku2zX5UmKiTOPdQ4ys1O6xr0TKcfCgCzfxOsuaUMMeFNGhDhMwmEKvVDvIAo4mqEwHJUlIEE8DEzOR39wpKyXak1s2Oa2l9atdjVwbZa0KNNK7X5k9jgaGu4SRzv7N1anPktKNI8AMYFsVkcm07IsT3f/O7orM0J5VOBZR3DLJew1opyF7/dLrVx6k5+z0SBsBnhF1YS/3IMG6l7neYiSiz3CaHyRW56M+qgmY0SyawlA4Ca6tVt8DkKYHGgc+YhkvNQnu01yMffdXi2EpSRjqJYGtb3iGV/hTkwtyYraBy1otGQ7Fxed4gUdqSFE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6migk8y8J0hhhIACQBEDn9LEnfJ6nTNW2QTY4gQf18=;
 b=WEoQ9pOE4mi3P7jjEDuK3hX4/qfMMzM1DQrcQX8fS1EmR9aB71UcowEu7GWI+58CA9gzM0lcOMudWXNTRkprlBk1jfd7Wn9En/PpwMjlSA4SlTjp0Us/ZBI+EcwWquqWb9xn+bVQqTMyYYl4R9lg3JmPQcxUjg/FCYAwTYQ7S1YMzxxMkGqv3zCUYfOlqN1UE2Lnn/Wu0mMy/zJfgH35br53i+5Onah84qHYX9nT2NJWDNeT4Si7E++wHxTY4dqxFq7tVLMdkfvY2l/hrwO1q1d3f40TfACuq79f/9HRgA36UWWh0ms1Ds+/vUNJD80kqy8O7tGHEO7yYl5FhwdRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6migk8y8J0hhhIACQBEDn9LEnfJ6nTNW2QTY4gQf18=;
 b=sH7lQOgDqErKiuE6xdeekv9KW9O3qRwvhuFb3Q384AVu/4gx5SstliLrgZrSt8pzMkqHCBd/vhenvAvn72hPhOq1T++JafOKMmgYsHgL2Ii7i2IEIgpoF19qQJS3PBWScJiIzT+iqo2f4JJxdMqJCLAlG28tKn22H4uJpeIeSVs=
Received: from CY8PR19CA0027.namprd19.prod.outlook.com (2603:10b6:930:6::12)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:45:31 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::41) by CY8PR19CA0027.outlook.office365.com
 (2603:10b6:930:6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:31 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:29 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 11/48] drm/amdgpu: retire umc v12.0 ACA support
Date: Mon, 22 Jun 2026 16:44:13 +0800
Message-ID: <8b05d98ae3e96b25b9376a8ba082d27093afb436.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: e7be293c-6223-404e-6132-08ded03a9e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bQKCoor2ZGhJEkG9xvduIzZiCTzMNgWj7RQpOomFGyHLT0ACt9CSYMZJLa7EzCnNy0fSREZiQBvigGtsnTY46U50ACwyI3+Fg+9gsy60Xv87d+fRvDZEV65k8rJOkyOnHzHY3OM+ZoF8woaa6Nt+EMqizQt88voPuDQVg+u06JgS0l7J1oHpT+z2QI3cY7hLunbPRqX6Dh7gyXQdCd2FbaSauLsUrvqnb8sxQ5bgsjEW2kkal42X/q50zC1fxDhSFEnW1qqIQK4qrj/C+z2cg+2rXRgvGJnyyzlvCBOBbbZgm/vHwCTsxqpp5rm5Ajd73TWERULmgaGg8ggq7Ds9TTTPeV/TYgHgmj0WCev3AYmbD4WQkzklE9kwnudGCdedsMMR7q+HPRGkdZKrkTSKpaEWH5ug5p6M+LBjfoZzF/DpVrV9egCV41avqHTKprO94FJhAnwcJzXtXjiWlBs2xeAd7tI5HzShbAyjUMH5hUINDw+dsDv0X9DEspTVmCGak9T2CJQQgamb3ffjvqtnM47LhkO9iPLs+H9SW34h8+XXUUef1wSPB6AaV8w5YGNacaQvJ0wIt63JfmIK4KbxPpxzncBCQTBzg7iZlOLL92TrPS0gErDWBXc7bHufxe2e5OLz8vOC9OKW6sIr6ENz+DGpEZKlSzZph3QkGdcm2zDGeR2vjhvSOQPxDOf+n2UPTxy2bbncpPz/+G9GAUZj5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bKuQejORReGauqOfmGIgOzboe8sT4o6OWbL5wPZt4u5gbL2WkJ1mzUDv1jSX8LBPgMldem+Y77OkskcvWQpYu7HkBKEspt6E2IhxLMjRHnethHS4I1A2FIcRQVb8CAke+BgOf8k0oQq69KwXmJuXFgsKm3BMWDvyWM6qHJwwfhNAKg/9/fqFLp9OkoNCDgFNNPP2d4gN/PXRud0kTMbZlDy73eZGTJ0qSuKUeQmos4xallFGXaswUa10f64cEd3aU7eaoiFQC4HGCFK3mbHYsG9oa41j28/g6P30jphj7oTBpEzIK55BwDZYwbwHFH0inzvPDZON2NykCuNOub49VytJgejHO6/oCceQ6mZDVhaQvP6a1yiOs1no+MnZ9gT1r+TUFIbkJ2pFe2BTjjHuoOEexK8qxcPOM1A2rY/xWIB4ze4hwFQC4vipFTGh0AUo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:31.4015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7be293c-6223-404e-6132-08ded03a9e40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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

retire umc v12.0 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 68 --------------------------
 1 file changed, 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 749c1f845ac6..328dd2e8d328 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -502,73 +502,6 @@ const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
 	.query_ras_error_address = umc_v12_0_query_ras_error_address,
 };
 
-static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				     enum aca_smu_type type, void *data)
-{
-	struct amdgpu_device *adev = handle->adev;
-	struct aca_bank_info info;
-	enum aca_error_type err_type;
-	u64 status, count;
-	u32 ext_error_code;
-	int ret;
-
-	status = bank->regs[ACA_REG_IDX_STATUS];
-	if (umc_v12_0_is_deferred_error(adev, status))
-		err_type = ACA_ERROR_TYPE_DEFERRED;
-	else if (umc_v12_0_is_uncorrectable_error(adev, status))
-		err_type = ACA_ERROR_TYPE_UE;
-	else if (umc_v12_0_is_correctable_error(adev, status))
-		err_type = ACA_ERROR_TYPE_CE;
-	else
-		return 0;
-	bank->aca_err_type = err_type;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	amdgpu_umc_update_ecc_status(adev,
-		bank->regs[ACA_REG_IDX_STATUS],
-		bank->regs[ACA_REG_IDX_IPID],
-		bank->regs[ACA_REG_IDX_ADDR]);
-
-	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-	if (umc_v12_0_is_deferred_error(adev, status))
-		count = ext_error_code == 0 ?
-			adev->umc.err_addr_cnt / adev->umc.retire_unit : 1ULL;
-	else
-		count = ext_error_code == 0 ?
-			ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
-
-	return aca_error_cache_log_bank_error(handle, &info, err_type, count);
-}
-
-static const struct aca_bank_ops umc_v12_0_aca_bank_ops = {
-	.aca_bank_parser = umc_v12_0_aca_bank_parser,
-};
-
-const struct aca_info umc_v12_0_aca_info = {
-	.hwip = ACA_HWIP_TYPE_UMC,
-	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK | ACA_ERROR_DEFERRED_MASK,
-	.bank_ops = &umc_v12_0_aca_bank_ops,
-};
-
-static int umc_v12_0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int ret;
-
-	ret = amdgpu_umc_ras_late_init(adev, ras_block);
-	if (ret)
-		return ret;
-
-	ret = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__UMC,
-				  &umc_v12_0_aca_info, NULL);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr)
 {
@@ -758,7 +691,6 @@ static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
-		.ras_late_init = umc_v12_0_ras_late_init,
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
-- 
2.34.1

