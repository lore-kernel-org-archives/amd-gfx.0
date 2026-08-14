Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC259C5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CDC10F71B;
	Fri, 14 Aug 2026 21:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iZwjbKGp";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2E110F715
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI13BzealVZBnIa8XOW8tyt4Bdix1Qqh1WTSEcFYkGxP8NyuC1MxqCOXESF+HIXWb20Ds7D3mTVE144GQ+4Admay+DcQkQyEpYKKDgLbM3JO/CO05/Z4qM8xhRDKeItDprYTKaqNb1NmNFGvdQIIuAO+ir66o6Ug8nlKYgz1vSoTv7EJ2mHsr8J1VizB1LKhLs0mlSR0bc28QCVR3CzghuY2sy1Q/c8BzQd2KseBLuNgHZdgaTX/orzG4uCg5zIn1BBph/7pQAPe408m7WnKPWj+ovu2oHdMzCNWpcA5VlbEE9KkQ0CC2QsUDWgx7BJzxKDG+x+PbkpAuauLdI6V0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxVn9Kft4kDIxYogB40wjTog+WHd0jqNwuQHqegE1ds=;
 b=bND0+Bub/Xif+4hKr56C0LTeSmw4/FtWC+SbFZmdbn8UhAqL+ehRsDI2hKaHGK4Uv+H2F8AFodnLx6B7W4a8TMOSWOGlHWMPKlvnRwZfm1Ol+VaFM9MDLr/+FGt2mHfEsVIl/KOb/eectGHJp9QVUt5gu9aI77sos8k7TFz6N2zyS3KSLJCL+2r0ZoqhbAXjiZhjVpRpinHDXIrtiaMSwn7KQ9dKXM11nyA3Eqf0/+sNR+5HLNsG5d9zlgfm/EAtGff54gGjHgoXLg7MfGT9f+x3XEIR4/NMl4uL/4/cEuMzPJ5neT28lRdSUoJv9UdD3h/gbyzyTmCO1Ll6yFtoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxVn9Kft4kDIxYogB40wjTog+WHd0jqNwuQHqegE1ds=;
 b=iZwjbKGp+zb7Ec4HfvZ4N2oMkK/Qtu9UzgyGPHaryYZGnyq77WpQMQL6pic22BxZIZ+Zkuwh7DB5gCHl6lksjDGikceqMoiBco1UvnLW2LrSQqOInpQBAgLkFVlecKSotxKL7a3ZycXeMfGlFa/LMESnE47PyA70RKPUFvDQ9nQ=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:03:44 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::c) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 072/109] drm/amd/ras: update aca bank decoding for A + A
Date: Fri, 14 Aug 2026 17:02:09 -0400
Message-ID: <20260814210246.3067612-73-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: fef1d4cf-b055-4775-9aae-08defa4786d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: FtCL73SClV7RJJQIPb9t1hmaVRo7jVfJJqhPUvJ6NFG5KOFV7D67XxlwpMY1UrT2tw6qnnRPIyOzjgBQ8MQC3TzWwK38DUCtg9jBXLf5Qr1apBG/oypmQ4RJJaEC1KpB70zUMXWjQevNwNsyBj0zPyrZmaM3uwLd3rv3dE/MPyC4l2mFLbmwYLh94pHutyFFI/7XtQ3tfc4qZ55W3Ix3+S+FOHB37jiSJDfCzv6oHFsUCslxQehmpb+RkWTz7aJaB92ZNsaZGwIZoxWcUr9tr6xNCpbamcA9nAS81lg1Luf5I5TH6Zp7dYr/BnlCi5rvEM1Nx6Y514iqlRAIJBEEAKjUX1I+8nOyYE9UMKc38jJTvxsMyapUnOZNHVC2SKAZYgHOcpKzqsKXT6W7ElOgPZjZRy2K201T6moHo4KAfEr+8m4NIFpr3DRKzCLmUR/5YRWijTq3h7HimMWY6T362kNqozn1V6aT+ppEcIewAD8GwNG+u222yJuRE8lxDfXmuGcbloFQHmJAHhTaPeTuqzVHs2G5mf3VNjsIRgxEznglDU/Siv+VGkJmp+1hwyILiOVIkRvvNiduPKSpXmbRbmql2mdDZB4OJIAAdqj2Uxl8BxG5NG2WsGLuhWopZLaywAI1vT6sE5oQ4giNUzdUvoiQdVlDFxGkSGFiMc7XKXFBun+4HIVWaj8Hi643noQYcCvzwlr1d2LUbcuQ9UUmNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nnZapxBgYXpRX4AgmrkA1opb/YBZ9VerrPECTNU1l2MYhj8lsbVI8TFdiYlELpYkXtaRV9tq49yLGjQyqHX344eZDmimfQnNJFObSynI/6klke90Z3B0Y/XH/AG+mWPPOaC87/lDSDaHclGMHPmX7oH5vZmxAlNAS+vnQ5O8205j5IyP8x7VmASrU/Bb64K7YAAZz1cBuHHXofKFAz89AIbIHDb9iZah1GXl4vIVJRoufZHvo7CjXO63V0ArbwrMCHJciaiFBk6FbVAcD76LxyMiQpE5qrOJ1YoNS5saixUGAaxuMNreDZltsQcefYtuLSD6c5F6OVpgR1VnP9HOTY/KAFfwezDOTtc+HdIKQeab1BBqic4U4qSag11GMTw+bVJJ18uHWJx3JRRBKbQEWsTUQUGqTnF1crhPNO25eWn+HFmWpIgLiltGZCecIWM9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:44.4804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef1d4cf-b055-4775-9aae-08defa4786d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Update aca bank decoding for A + A.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.h            |  2 +-
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c   | 44 ++++---------------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  2 +-
 3 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 22b12a036754e..d3e2e1ac7b6ad 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -26,7 +26,7 @@
 #define __ACA_H__
 #include "ras.h"
 
-#define MAX_AID_NUM_PER_SOCKET 4
+#define MAX_AID_NUM_PER_SOCKET 16
 #define MAX_XCD_NUM_PER_AID 4
 
 #define ACA_ERROR__UE_MASK			(0x1 << RAS_ERR_TYPE__UE)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index 3074f8c3f3164..41290ec3b49d9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -62,47 +62,22 @@ static struct ras_aca_hwip_v5 aca_hwip_maps[] = {
 	ACA_HWIP_MAP(MPIFOE,   0x1FD, mpifoe_aca_types),
 };
 
-static const u32 aca_gfx_xcd_instances[] = {
-	0x30000000,  /* XCD0 */
-	0x32000000,  /* XCD1 */
-	0x34000000,  /* XCD2 */
-	0x36000000,  /* XCD3 */
-};
-
 static void aca_decode_bank_info(struct aca_block *aca_blk,
 			struct aca_bank_reg *bank, struct aca_ecc_info *info)
 {
 	u64 ipid;
 	u32 instidhi, instidlo;
-	u32 inst, i;
 
 	ipid = bank->regs[ACA_REG_IDX__IPID];
 	info->hwid = ACA_V5_REG_IPID_HARDWAREID(ipid);
 	info->mcatype = ACA_V5_REG_IPID_ACATYPE(ipid);
-	/*
-	 * Unified DieID Format: SAASS. A:AID, S:Socket.
-	 * Unified DieID[4:4] = InstanceId[0:0]
-	 * Unified DieID[0:3] = InstanceIdHi[0:3]
-	 */
+
 	instidhi = ACA_V5_REG_IPID_INSTANCEIDHI(ipid);
 	instidlo = ACA_V5_REG_IPID_INSTANCEIDLO(ipid);
-	info->die_id = ((instidhi >> 2) & 0x03);
-	info->socket_id = ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+	info->die_id = instidhi & 0xF;
+	info->socket_id = instidlo & 0xFF;
+	/* xcd/aid are unique in die_id, not need per-XCD decode for accounting */
 	info->xcd_valid = false;
-
-	if ((aca_blk->blk_info->hwip == ACA_ECC_HWIP__GFX) &&
-	    (info->hwid == ACA_GFX_XCD_HWID) &&
-	    (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX)) {
-		inst = instidlo & GENMASK_ULL(31, 1);
-		info->xcd_id = 0;
-		for (i = 0; i < ARRAY_SIZE(aca_gfx_xcd_instances); i++) {
-			if (inst == aca_gfx_xcd_instances[i]) {
-				info->xcd_id = i;
-				info->xcd_valid = true;
-				break;
-			}
-		}
-	}
 }
 
 static bool aca_check_bank_hwip(struct aca_bank_reg *bank, enum aca_ecc_hwip type)
@@ -179,7 +154,7 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 {
 	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
 	struct aca_bank_ecc *err = (struct aca_bank_ecc *)buf;
-	u32 ext_error_code;
+	u32 ext_error_code, misc0_errcnt;
 	u64 status;
 
 	if (!ras_core || !aca_blk || !data || !buf)
@@ -196,15 +171,14 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 	err->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
 
 	ext_error_code = ACA_V5_REG_STATUS_ERRORCODEEXT(status);
+	misc0_errcnt = ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
 
 	if (aca_check_umc_de(ras_core, status))
-		err->de_count = 1;
+		err->de_count = misc0_errcnt ? misc0_errcnt : 1;
 	else if (aca_check_umc_ue(ras_core, status))
-		err->ue_count = ext_error_code ?
-			1 : ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+		err->ue_count = ext_error_code ? 1 : misc0_errcnt;
 	else if (aca_check_umc_ce(ras_core, status))
-		err->ce_count = ext_error_code ?
-			1 : ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+		err->ce_count = ext_error_code ? 1 : misc0_errcnt;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 0e41c005a1ea2..ccfa213816da7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -38,7 +38,7 @@
 #define MAX_AID_NUM_PER_SOCKET_GFX9     4
 #define MAX_XCD_NUM_PER_AID_GFX9        2
 
-#define MAX_AID_NUM_PER_SOCKET_GFX12    2
+#define MAX_AID_NUM_PER_SOCKET_GFX12    16
 #define MAX_XCD_NUM_PER_AID_GFX12       4
 
 /* Reserve 8 physical dram row for possible retirement.
-- 
2.55.0

