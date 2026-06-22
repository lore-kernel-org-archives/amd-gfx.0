Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95666CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB6710E46A;
	Mon, 22 Jun 2026 04:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLYkEc7n";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F5210E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYwdMiiQEmEH2IMpKRIG3bdlGHYnyRFogz23F8Xox6Uob5mWMeoC3AHHhrL+RnOxePmiwFfVwVuNRGQgGyXQfOw54jc4Yio0NP00lpjc6eLqvEgo2QRr7uf1oDpBqnrY12xgTVGKvRdKb+M8YzA/wvb/zlwUBEarHrFuz3WuFt5AUE7gwUcesoynRDmnOWzYthECrPRFk9yLGp/ohlxHQzRQC6NRrw6srs0gQU9zeqJSx6ie9o6aVFyjIDqSAdY1IcvgO9Rx0A3dOHGhvhGNrQ0FRuUA25OHCsWtHJquIhoGszXDFGbn9FwbieyY6WqPsjmwCqUkfK+yfwt4rW7KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6migk8y8J0hhhIACQBEDn9LEnfJ6nTNW2QTY4gQf18=;
 b=Ae0n5LF9MJKJ1Q3A4wuOAZxffJPzRnvPf3FaGO1T79PKjJsIWZQZnAhHRF3SlYWJvxVukj8DxbP/2ss2nojH4rq2/kttlz781lSfaURGe+LI9Pg6gj/FlYpOY0c22EnwuJrAxvF5OliObx86VGCAZv2pMzcTzD9qyhI7AGfTa5OuhYhO1C3olstUHepfTBkpZ0G/l0451M8HCWX77H6S55pcLzDel/zBrdR77AO+apdfHxhRWDSY8ROa6GXKtAXk3mekW/4R45hsOgKiCrc+KrvhNEUBQJZqKFuqpBWLvBzIRQLahteRPaEUIPJT9D0ABB+7yhpiJ7XvzyOfchbXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6migk8y8J0hhhIACQBEDn9LEnfJ6nTNW2QTY4gQf18=;
 b=uLYkEc7nEZILZT3SD2rr/2JdvwrZGeiX2nfCdxoBEgXtn2Mp7PJH1115Sg6HXxSlbSBeHpKRh9/Al3yfo0Qs616J0c7pdEV8TISwWx6h0Wx1Yb1RNTBSA79ce7SBoqJGgi10epiru7F5Ojyo9BRLWU+QPkrs9n0ajwfCgNafT/0=
Received: from IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::14)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::616) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 04:42:24 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::9b) by IA4P220CA0001.outlook.office365.com
 (2603:10b6:208:558::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:21 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 11/48] drm/amdgpu: retire umc v12.0 ACA support
Date: Mon, 22 Jun 2026 12:40:00 +0800
Message-ID: <dba6efc5fde50ced695af60c88613496c9635f35.1782103073.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fe51dd-0dca-442e-d947-08ded018a742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7njCmk4N4ULIQJl7VmMnn/MNSZMPSNaKlK4FBHISk2/4zWgAUt9JCh9+H2EptBkb5qGNSE14R+VavCSePf3E+rSQyewaXdvnx1dLqPDdz5gQzFXM2wq5drDD09u+nbACFD19gqmU+zMagm7giK5z8Y92SQLS3R86pRu8U8C/UqVN3QJqjyHIDsnmjFmO/v0JSVpPiOC1wWxF+HsRASsQJYOd+Rlw2B6dVq98RkIIwlGU9Cxrjps3DfG11hDLxcUarug4d+OqA6Nok2u6AF7V+08loU9Zlt+JTDgBGsWerR2zOn2GrQYdx3WaI0bxc96YZrFGG/LRbn4zFHlUhWUIkX8/yJDulg6c7uvvWhm79wUJSC5H6vFqyCHU8AbEvwqG/a9i3o/EBiKSEbIRMh+YHHLr1QptmfCbhK23MUFxyKTrGx2YeawOBrc7rqdotEVJGuWF4Nhj/oUd2BH6OP5CucOuWT82T0ELChiPZNVabEDxNXG10zxBpoq1Oy3SOFUL3iaWnNtnytqeBn/Pv+ZdT//qE6XESJN1PlgzNUczGmwKQzIkheR0arLyJTIG5yX4j7MdGVRLKWy25LDByCYAk3q+EPoLSqh+bv6hHfKqe3dARws77wohvWvS4RYZ9Qvah4OfP1UJWXrTjl+lBuoWls/h9v+PxjVx/MWGMaHzoximY9v/X/xD2+eNA2r5HBbcZxpCU3808YHma5ZABYhb4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m1+2c2VUovqFlhI4KHyJ32kwU9ulg0LOqlMIaZUtrpZ1AzPt5xD7c6OOJem2UC9K9J3Tpd9VlKKvhkh+/D1EfJdR9suFvFaGb7FDKr8WKtBOYmJUahXykb10J7ncVDFqzoWTbCzCyLbXUszJnd9YmKxbtW55P78wHsLfiNB2uqnXQ4J4CdX5fSuE06/SMui2K+09w8T+4eXunseTuuB2bZYR2NioWsAt5UpU8FPsrq8646riX18O/696gjBCaW3jgrVFLCgsHUjzRqu0T8Z1z1ADWyXaZRmH12GlEvC2ULMVOZGDOQTpua5NuBeka+m7qSWygbgHXE8PS5B8KPq13RAv2YTH+IO4QgL+pOs5i6OkqPBqxeWGmi8sWcbZaEsVURyVvDXmp5VyelW+/1Wx+DHU+2b/gV+BzxWHkiO5d97qplq7O/UvCkJK6fAs1tV+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:23.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fe51dd-0dca-442e-d947-08ded018a742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
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

