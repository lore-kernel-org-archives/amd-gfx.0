Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7CACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C93310E555;
	Mon, 22 Jun 2026 08:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C053Ic7I";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6678910E557
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVzlhiLEO+kKXbfKS9/5dff+9baVzTIiS3qXZOxpprX+TpjfHmXrpcnApPyoYbrRJ6OM6z9CAHeWyqBdDgX6b/TC4Bx/YzEpcjUvsDi+DH/qZJHhiqm1KRRfcKu9teW/m0hJr8Ds2Ja+gSe0tYaFV9Ge8/nDuaQOPPLKtXN8kWryOPnYEgrg3A1yYnNELoUWA/oQxjrhI7tSmqirMK7f/o5Va2TORJIcnNk4RBBsaoj/65XLbOUugI3DNpBaVA5IkMNrYutLB8sIjCqhBYEg97KMKv+er3dZphldPECdfQzANsFdf/sK7j/HEI2MEmWvFr6MXTQldU9wiWxi6ICVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQenUViJ1xddLyQ5CMWg3UzQYUEOtiLXuLYShPniFA0=;
 b=rXCzyNnq5coP/aFmP6uyQdnNdeLAEIavU66YqeT1a6g19JAk6EXsUbcxsgEK90XvuaReq1Nmrd7Ughhu5Jh84wKCSLRgiL2UP9JliEp0YTbJ7FyqnsX93p3oeaDtqVnN0q4XUThStPYSPkwk+ukkv6fKesgs/mCzeBYLqygo/R0b9AIqgU1/KaNqGeBrQ1+yfK+u/Oyn/XRs+FrH1TkUFfemEDAiK+JDAKsa1ugCbj3FWH2LQtGGjdiMjblJyC7S/4JEKr6coZHIIET5PJFS3hh4iD+jGRLUpvlL66swb58Tg9msa4XjuUr47NZJtImtAXLlRMb5/79tN3RTyS3zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQenUViJ1xddLyQ5CMWg3UzQYUEOtiLXuLYShPniFA0=;
 b=C053Ic7IoZG5xP6tNGhh0hW5/fmIUGxaj89zb2vGeKqSclBvNkwx/RCYcQOaNUoaxwm3/2GoBDBZbDrVkXNPwBxnL3Dop9LdiMctmxxJXgyGt5ILUKSbLcGNkr8Co9XWNpdP+OlD/XwBS7ADEXiK+4EVTub1Uimx/EBxjKinsEs=
Received: from CY8PR19CA0046.namprd19.prod.outlook.com (2603:10b6:930:6::10)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 08:45:27 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::44) by CY8PR19CA0046.outlook.office365.com
 (2603:10b6:930:6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:25 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:23 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 08/48] drm/amdgpu: retire gfx v9.4.3 ACA support
Date: Mon, 22 Jun 2026 16:44:10 +0800
Message-ID: <0608dc3efd55857eaff5dc21699764c80f9c71a6.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: d007c04e-c146-4090-f6e9-08ded03a9a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cARWI9dnz9fecazzTlrLIo3XIdGz86jRk2+83sl89Q47EeiKUO27+TekO5ik3CtQKeJjcco1L/7ZP4ODOWrPle+9RwxmtSSmwrsfDr7KWfCuKGOaIWCl3yX1Z1MahxFAiGY/Hb7K1blXLS8TsHRzQBd5xi/thP2TyfqPd20HlCBsBH+scLrNfEwYVRHNoIVbNnr2GDiURap9lcfsLpFneRKxmi32Bf34ArGb5NDrKqoDUgHcCyZrA/0HwlFu08XamAffORhfNKc2fzX4yPOHurZ5GaNzzZQvmFmwWm8kz1Q7BYZgJu5n0HmagJwDjr+giRgHJtXCjXlBwhyJ4C5Z1ggX7QW6fFrIkP6ml4Cheu42Nh88eN1Yq8I7EErQk60jY8Q0NezO4OCAEvraRlOnyiYBpj5B0GTxZ4kkHUBME+KLLxSV8CoKCBZfu3It6T203yqV7bHXWrRf6JPH4SLBNTFPP6oWAeXsgLnOXX30VScouXLVGfmnXvgKYZTPKjR/YwleJA6abUDlHXr/sVrRRgsq2AhHEF0tcPPZzYO0Bq8MJsM3Oa4n7D1FPi2GW2b/gpU2efWKeEWN3UBx+kMCD/LEkOBZTCCc0R3QZGrgs8m9Fn2uzwWST0X8xqdRuTr1pKCiM76Nb76+BINw8ubAw/OUnaGc83svMXGBlfIKxhvOhji0DbkfwwxPV090FUpy5q8FLT4mZP76I/nRCbSnEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vETIVu7pBrxTTfC+Q0a4t8k3BrUvs3uoMyUkVOXyh2WjrruBqIta6sFVYqAy7TegW8iXpLmFzfXoMT2aEUiKs6LkxrPLa/LP1EebERwQMSAPZ6YocwP4B9mwfa3eUkEn2lZIwms4SNMA5X1APtZHHMPZWp+3Ul9Rc4NXL+jnIakTth+TuUWNZi2I4VNoGvLV/uGmX+qxO8fLH3aeh6z0XqQts1GewfhCMsw1QhaivtS9tic25wk8+ix6qO9f8ocpWN2W3HwGd50bkfnCCJWITbw3Sfx+fvkdLEhy4X9fRaKFWNhJ1T7Zsz4u09VWnuDbaqZYExeDYbBOXiXkgbYMS27CPqYyZ7fLncOBdHSP40zGUfLcU78AYIUZE+T53VNCtv7o8Dtn9iwv9ReXtVOnUFbLk4DW9GO7AH00TT/GmaQ7U7Xypizy1ruO817AXw2b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:25.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d007c04e-c146-4090-f6e9-08ded03a9a95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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

retire gfx v9.4.3 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 91 -------------------------
 1 file changed, 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 5f5577f52a98..d67ac6f96481 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -39,7 +39,6 @@
 #include "gfx_v9_4_3.h"
 #include "gfx_v9_4_3_cleaner_shader.h"
 #include "amdgpu_xcp.h"
-#include "amdgpu_aca.h"
 
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
@@ -851,73 +850,6 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 };
 
-static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
-				      struct aca_bank *bank, enum aca_smu_type type,
-				      void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	u32 instlo;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	/* NOTE: overwrite info.die_id with xcd id for gfx */
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-	info.die_id = instlo == mmSMNAID_XCD0_MCA_SMU ? 0 : 1;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, 1ULL);
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
-static bool gfx_v9_4_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-	switch (instlo) {
-	case mmSMNAID_XCD0_MCA_SMU:
-	case mmSMNAID_XCD1_MCA_SMU:
-	case mmSMNXCD_XCD0_MCA_SMU:
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
-static const struct aca_bank_ops gfx_v9_4_3_aca_bank_ops = {
-	.aca_bank_parser = gfx_v9_4_3_aca_bank_parser,
-	.aca_bank_is_valid = gfx_v9_4_3_aca_bank_is_valid,
-};
-
-static const struct aca_info gfx_v9_4_3_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
-	.bank_ops = &gfx_v9_4_3_aca_bank_ops,
-};
-
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 {
 	adev->gfx.funcs = &gfx_v9_4_3_gfx_funcs;
@@ -5189,32 +5121,9 @@ struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops = {
 	.reset_ras_error_count = &gfx_v9_4_3_reset_ras_error_count,
 };
 
-static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
-				&gfx_v9_4_3_aca_info,
-				NULL);
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
 struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
 	.ras_block = {
 		.hw_ops = &gfx_v9_4_3_ras_ops,
-		.ras_late_init = &gfx_v9_4_3_ras_late_init,
 	},
 	.enable_watchdog_timer = &gfx_v9_4_3_enable_watchdog_timer,
 };
-- 
2.34.1

