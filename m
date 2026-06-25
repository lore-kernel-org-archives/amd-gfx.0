Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A95CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF0A10EE13;
	Thu, 25 Jun 2026 08:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UePcIzNI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E7710EE13
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMFCYDW1f4qz8e/OT3tMZWSTvyk53GSmuFa7OpnMnIO6oFity9elxXPEPwLYGbZzXWt6F836GesCjFYSt/nhCu3MLvU3hOGXiQm2iR+NZR+eyhpCUA0fYlVCu+5J6wdBlsxmcmHYGY831y2HDnh+7CJ9bmI2jNKqSEIvx7X6NHyw162NA/MS8P4VWzewxfvlbbtZROwEWtdxTtosYcoFKB+9gz2HuLJ5o/bcXGiaGQdTg9vVy8Dtms0wllaXSl4BK722pu6fAehzrJuVfsrJgzpVAKALkSpwmFawPl3ZNrUCxCzWSIWgsYs6NEBiqqanA8cEsC25UclApVHGHnP5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQenUViJ1xddLyQ5CMWg3UzQYUEOtiLXuLYShPniFA0=;
 b=A+kzKmxZolGUS2kls4EUjPwy5S+5PFfoBY8gsUYn5zipDZAsWOuSSMN04JOc6m2vSetelsnfU8E3fBFN2zprun6upv3yCTleQLH8yfVEDkQbb7OjMmWNbCZ4OTCoUTGucCbxNk8qRSIBi6wEo4shMfOzGdycPwXVxzinqW6kkEpZ66ZL8kSqhuiS56x9BEjEooITw7a69+wt9ZY+bV6PLrwHXP4SoB5oi/5EmZMXSSlYECcIofH9748qRLpvsL3HUg5UgVqTiakqd+CY0TH1AawXKkoSfblGEZzS9qOr4XpKLdLJtE1twxzJu/pGYR5u6S8W4ydctEzN++hL+XAWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQenUViJ1xddLyQ5CMWg3UzQYUEOtiLXuLYShPniFA0=;
 b=UePcIzNI0+q71aP4P0a6ixqV3pIOYhSi30RqKHS7hsr5ZwuG8PAo2VGujZ3z8shjjMaAcG2xnDUWSnnLek5ieWHuJNubeCpajrAvUWacEKPGDyccbqVT90zPqO5a82/6r3AsFf+fbDK7Kz5Ly08z3YF12VphrAZbGuMR6VVsMn0=
Received: from CYZPR14CA0023.namprd14.prod.outlook.com (2603:10b6:930:8f::20)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:20:25 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::4f) by CYZPR14CA0023.outlook.office365.com
 (2603:10b6:930:8f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:24 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:22 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 08/44] drm/amdgpu: retire gfx v9.4.3 ACA support
Date: Thu, 25 Jun 2026 16:19:01 +0800
Message-ID: <1c671b2ec24a42918a550067beb836f96a76a870.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d34c2b-f232-4cfa-9ce3-08ded2929b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dqLfWwvC4RnaxirXfepwOhdB1M5Rdjgm1jkIStXya48KuB+vlAkDS3VenvGbIHOz8HzWoVT/GzptWNXBQm/j0SFQBDKX0FtzJg80/QuWPgwNqea4P+qCHJdcG6ZYDIEXaxLjuvzBuqZQL0RmtCZ5KJPflIrgRFidIzhp1FsFAej/o1OBT4jzYCbgoYp2fusUwEsfq97Dkfvuh8KqLEdJP32Eegd4/u+3qQKAQSvoW9mw8im63z02+zaM4U7TvWJlMolgrML54uN1yCMPy5Mf0NHAOC/UsPo9AXUByjdVXv0ZqDhHUy8qQJYR2t53kgENOyErSrgfnHeabKyNu/tDnmocH969JDWoWydXocisN75zScTGxu8OsvWXriRjLggdRM0A7VWlqoIBjozixf3f5G9F1Az58JlRMLXN3yk/7M++tZdhCZ6DbAMImsKLJekfAc0/W4T8cocFthGe1blxV6svayPHPvFM79QmOfrF3BF/iTCRBZ0saZPYNg3Cy9rkjygxBDFjMlXsq3mQz5RAI+N4oNjxg1ILk0RiMYoXa8/HIfHJ73kHzWRUrq3xiMpLPGOyGs1/rOrwRbUKxNHn+Vj7+PAu1OwtDbN2a/pR5yes3Nqxens6qFSSAKDmU1oL0yZlij/XD2bfZTXrbTUPjOoynHsbZr67Karqj5dYJeCtUtFrFyb237K5NRbHLrOQMj6L/k185IaK7WfcdFfMMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 96cDiLbTTbTxUewA+LCoVGO7aShjC0zJ0z2Hquc0VLRi7ajXNf/oPHF1zxs3qZi92xmM2h8f1bZrVthy0X69N76GRXnYe4tUCn2Zqerx4lwpA9ktcFnOM+bePAVFVZO9xUH7UYJdyiTkrEcrE2Zf+1xOhVfPaAp3QOzWYype6rh2jr97RiOCnAUqkzr/m40cgfQrJ33RXeFwiEIh/WboHdrwcYnmjJjdHrfENcX4MVqoEZfr2PAQV2eLs/08sajFwMhD8EfA84H/EHXOIm1cm70/4htdYKth1Bmjhz0AkMgYhDXvp7DEh8+rXe1p25IIGBUm0wZJJFwpV3Pymr8bWQG2dJDqjmYOvP5sKPaidpymYNS+BblstizHDx3ptnOrG55jNFVo1TnatzJHw7+4pRBXdGsf99H0ilqaVdESHV4cAAfTagohIFab3EUhzb00
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:24.6506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d34c2b-f232-4cfa-9ce3-08ded2929b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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

