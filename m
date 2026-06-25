Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77937CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AA410ECB5;
	Thu, 25 Jun 2026 08:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFaGEptd";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FB610EE13
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atUIJ8BeWAHaQgoS4eobZBh/jyvX4rVv3bQjXwBW+0bABiMztIZNjsdafeiLVzHfOXTJ0ENuKfgvbscQQOA4NOrxaL2aSv6hYN+XlLEfRNtqEueJar8d7cMnR+WuN3EZaSYxlavE4zcHBEbP8QZLVnObIxpLnT+S4j/FC2KZZ0jaH8wwjXlTanHjHutX98uDVzsIvekPW6bFcIaHRfa6N1nuAU15QZ8b8pgRThE0KTainJtYwXmiPoVgsyTWU+UOHXzXF6PtbYzty4VnBSoOmSDOhxEvJqqSR7MG3iVICf7rzGv9LVhbc1iGmmpGGglU5jCBKJVR04rtrPqKOnGAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd2EeHZX2t4bNV6SlOdtf7SOJ123ujJ0jQo+BuWruCQ=;
 b=fwvrgNNP66DxuE437PBPwaA4Xq7zCBGhYmoLDMGksbRtplFaNriN5yn22dAKnUHBdJ1n/FzcN1z8pEnys4McQvjzVCQ2NYkG4rE7sRuo1A+t2YlpSYgfRNUtglwt6GZW6of6rNdDPp5OXPLEVzc+OaAH4tmuUoYwRynceZwFOJrR/BUBR6GBFQkKYU8o3y6zImBKqAr9Bv6fbOGGDiCCT0P1c2s95wYHrNv7nsCh5vlsTk+AY0+6NnlgOSeT50NkQkOOzyMyJ+QfNPZLTq2F2ZRQTT62rjAqqbCOZz4ixofbPIz1qAXYUfnjXP1HmHvLQlmHDxKGbqJfQO/7pfOf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd2EeHZX2t4bNV6SlOdtf7SOJ123ujJ0jQo+BuWruCQ=;
 b=uFaGEptdN/8cs19mvlE1H8RH7e/zwe4yScTYx1JxqCkDCGD4/kf41eYX8uAhAg8Mu9jO/OeT0bxvzNNiwZSUez/8/SzB2Ax86po/OKrhTZFfgUxKic3R7gx6wc10CYG8ZGsQVOnrvOrahl1/yxRtvV/rkW/y7eO+k7mov8Y7jNo=
Received: from CYZPR14CA0023.namprd14.prod.outlook.com (2603:10b6:930:8f::20)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:20:29 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::6a) by CYZPR14CA0023.outlook.office365.com
 (2603:10b6:930:8f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:29 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:26 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 10/44] drm/amdgpu: retire mmhub v1.8 ACA support
Date: Thu, 25 Jun 2026 16:19:03 +0800
Message-ID: <5b7aef2ae685fb3f62223a48c4bd7c67285116ae.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ca4855-22e6-4d3d-8be5-08ded2929e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: X/gbMvqS5o3XB/fmzepVdopbCh4YYXOX8GURCB7px7jS/Oznr/vSy1xUhNrmkkO/9RItYb5OB34jS63LizIAR0gf5qs5cdRpvR6/Y9ta7CpmX3ndS7ZXanoJsfP8l3UyLnRdP0YvU2nLyWsDnsgXTJRiHJQcGyuXWhQThH4II793ryYsU+ZFTejr1Jl8vHgOM1e7QGMZk+Y7wiMMoZmNiNDYdg01io8xTSAzCOGe2O0WcjVMnVn9RgrGtR1sn/gZCdAhc4+cgco1n1qbdCKB/2KQEpNNc2CyrocB2Qiyra1vrAUYFQ4WqLG1h4LbJjW3QLn/4w5I5yV/mjRU8yBDUko3Ly22i69e2Y1Tim/IKYtehZuv1AZGzAqWJKTvBXYNOrptNGc5rgPoeyxI7nod6XBM5chIOjwyMAVKasAFcTXPXDwSi1ezF7AZf2WgLekQ5h0vtN49hcmL3QQFFXuL1heQlPbQ58+2N5QGmTsw81dGeNMaG6rU3xlXZjYs/IrIK/b0tmgREpxsbsLoRK2h57RA7fM1hOwO6LEZHAeYoolMqidvza1AfQLbwA9zrDxgNmgYnJIAkMNaFyy0zv61h9x3/tYu6Dih1daSWWPT7Xkwtx2EZUDTDBJaZJJxd6bjp+sJeYSaFL0njSwHrVZ06ab0L891mjL88JOYdlBqY6+t5QYDBZcaIWX0E+XeM5YJpmTxoBlaJrJv4Vz5uOFBTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SoZicDMnARLvqDoI/Hh86TZG0a1S4gTE4i3zVcd1BHV/2fzv7vUKDiVLr6m3cYxxZoehPD1wUu0C/V4xHTD3+gJ/mkUIs9cjbTWxBguOI1ZGv6jCMDFuytrbunlbpPTZgI3/GPNSjpO0fisY1HKW1PxuQGYxzddI9NzC2K+xdhUZQIKi6MtcgORii3ispiXLfYjZa2CPdjgviLXON4iG3z6qEB58rq/pHIylcJ48mir9qRJvWajguxzq1zgDS9bZI2TL+ZwT/p8h+cbcV4j/uGQNouO8uya/hqh7uDrCRm1sxjRMEYqwgMxwQOCQ9mWVZ/1LoaFha1sO/HfCbaLnNii6zlMk8NA0szK/bhxBx1Fb5OIJpGrp1sJr3ZSqOpTFjS3I6lEXdof70WiYY/L2X+xXe7kFRH3rxq0MHcqGnJ6SGxHaIs5LZc/WEgX59+yX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:29.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ca4855-22e6-4d3d-8be5-08ded2929e18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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

retire mmhub v1.8 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 92 -------------------------
 1 file changed, 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index cc688ae79e84..2a6a5ac4f374 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -772,100 +772,8 @@ static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
 	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
 };
 
-static int mmhub_v1_8_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
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
-static int mmhub_v1_8_err_codes[] = {
-	0, 1, 2, 3, 4, /* CODE_DAGB0 - 4 */
-	5, 6, 7, 8, 9, /* CODE_EA0 - 4 */
-	10, /* CODE_UTCL2_ROUTER */
-	11, /* CODE_VML2 */
-	12, /* CODE_VML2_WALKER */
-	13, /* CODE_MMCANE */
-};
-
-static bool mmhub_v1_8_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
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
-				       mmhub_v1_8_err_codes,
-				       ARRAY_SIZE(mmhub_v1_8_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops mmhub_v1_8_aca_bank_ops = {
-	.aca_bank_parser = mmhub_v1_8_aca_bank_parser,
-	.aca_bank_is_valid = mmhub_v1_8_aca_bank_is_valid,
-};
-
-static const struct aca_info mmhub_v1_8_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &mmhub_v1_8_aca_bank_ops,
-};
-
-static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__MMHUB,
-				&mmhub_v1_8_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
 	.ras_block = {
 		.hw_ops = &mmhub_v1_8_ras_hw_ops,
-		.ras_late_init = mmhub_v1_8_ras_late_init,
 	},
 };
-- 
2.34.1

