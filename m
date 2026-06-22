Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EB9CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0976210E464;
	Mon, 22 Jun 2026 04:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AI5CCyc9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9184F10E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRLWJkeQ9foNVerD6JqfLESnMKFmffj+eRNf3ehED0ZoH9gmSTVzhaL+UGwFVZhxoHG5k8GXjEdsUlwBuleB7+vwNuzselc849hnvquCmH4pdIVJO+HiOWvRsL27F9PSCAx2xDYsMPAm9enJAANpf7r2JCT9KzGGWsx8W9OwsBamBjO8V+lBNDF69xnx3uEpTgqOW1Md8qsUB1qSSxEb7hjaVi24lLIXDbANFrzboqjI+tCaFxHNFC2MPOl3mdahYgFbGSfl0+ZkQbDtdxi5aa1zGURAVFl9WHVT4n6ymGsjYTK+kBCF5VdPeoCc3DwxyP/ePP/cXVhsauTcwjzYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQenUViJ1xddLyQ5CMWg3UzQYUEOtiLXuLYShPniFA0=;
 b=pVAtJHHnBW9QV3rSqIdppgtep5/imu3KbxKzjD1TAY/MAn8Dch77W+QT/fmFOien5ddmd5nFM60D2ZhE97mUHaruJ8I0WdBVsVVBKQJdlxff7JmUBe9jpZMX69OA+4qrccDaozzOxU38MxCFd5ikADwAWsSU0JjffZJP8+iCLD36yxFAWSf1JkRCu1bFKRjdaNwbxljrMEKqmVXi1OMg7mHMICACLQPc9mqcgFDGJCol82bv2h+DQuoJfktu3Glc/Ro2QDsu7qpNOZDzFFPn0Gz5PGkUUYp6I7OiscpxG3ScT4HAnjhOyH+hpUxH+7/xHzAOjVy95W7p3IGCJIl52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQenUViJ1xddLyQ5CMWg3UzQYUEOtiLXuLYShPniFA0=;
 b=AI5CCyc9M+pDl+c3aAK57OH83SSeccLbIFipt203w54Inmf/JokIPPBQNHq7AP+ySTcWh+Tg8aP65aIzCJFskcl4kGVsMifGc0x9CDOP21bpJqotch/UQwNWGCjcIbWNj6XHmvBdJEOVFWdi7O7t+FxKIb012klAANwyOa2X4CM=
Received: from MN2PR20CA0058.namprd20.prod.outlook.com (2603:10b6:208:235::27)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 04:42:18 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::6) by MN2PR20CA0058.outlook.office365.com
 (2603:10b6:208:235::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 04:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:18 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:16 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 08/48] drm/amdgpu: retire gfx v9.4.3 ACA support
Date: Mon, 22 Jun 2026 12:39:57 +0800
Message-ID: <b024dd2dfacd1b4613c29b399cb9d967f1e6e43b.1782103073.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 31aecfb6-66bf-4900-9ca3-08ded018a41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ES4FoqSnFg0S5DDijVf9Z/8IIsE8Je9Hw4MqJxMlQHGJKF+qSUEdUVnV1K5dAorBNoBsovPspJwauCtHbfK889M6OvWMDYKWCKJCQDglZqI8uCbKCgAhMl4aCKuW94E+zW+Z0RTdNPml1CG5TcfuHQ4XasvAuLJfDpZINfFBPq5qOJy7VDGlIlCg0gpy1kxICHYCZVhMQRKIvrVPuOPSWfTt8wfwqTbtmUX20TF+UIee5m/KWgsYqT3PZze6hWETuP1nZFw0ZQGSYvRsBrvGtxQ3FrpK8SHYf7wYWyOKVQUI4h+fQtEU9E0v94oy9Vaj1bi+rLbyD+tTmrXYuFgHPLQGpsld5M/fwM+RpJ4Ul0McV5ZRe1fGydOwu4IexHh5BjXvdLRu8Q3SCV8chJz+6oNFkGBMtorAXb/X2Tp74MQDI6vjOnyIDVV8l4nCm67BixJTPaZhGF/EtC4XzdAPq9IbVGYSnayKJ3whZmtZfdXKxhAWDYSAG7muZMnjxd+MjU2z7gv25471D8ahbHW7MU9hMaFlZIiIg8tR0wFLkPB3VzyBOnaTfVhw0pqnuiKfDciAiMjF4+ZyuWHuqDgm8FtoIdptPiHIdY6j6IhDyKCDIbHpLGHXh3wwRmV/kAsPFWX9y4VtcIixCqnVuAvtepvocDMIyRgBqC+oLY/1BXqi+TsyY5xmiuSGDa1jMnMgqhoPT55lJ+dulecEzeJ74g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x7Bd7TKQM04cCAtwxhE6rEYit0OfREk+CYLVLmfGGE9LVRz7H7CQeFHt+Dmsdz70/ftf9uALys7qGnVF0i8Q/RnEqybruWXY1czfB0V4HEL/P/Ti1+4srzmwvW8VgshNjyvtK1qSzjkt0NA1xSvPv94o3fowUpHyT5njMbWDLZl1dnHMQYSUiypCEymXtCnX312Yiie7Nvmz9605xUXYZXCg+VrEz2bac8XTP6miQzX62sRVkQdhyHBdN94ryHz52p4yR/cwd7ah6UPdOy7xkAsw7/I3PSw+9RMZ6Id1MK5bZ1wwhS2uSb1jsLCU9uQVyFP0W6uLPgoCgZibx3xDEZByAsts6+A9/ZjgF7rVP8NNoQkSXivLLx2DBQ44GIAU8kKmhsM9BDSTtOaagKOUIybl5kEtkUSOC9d/VaqcpPWA3sBVF6qNlJo8/ipuGZo1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:18.4040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aecfb6-66bf-4900-9ca3-08ded018a41d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

