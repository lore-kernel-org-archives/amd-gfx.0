Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AD8C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9360610F342;
	Fri, 21 Aug 2026 16:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/7yAAtP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5F110F342
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj4P55wnngsyaQzVTaUqb2zQDLoLtiB11deTRY/vxgeHG9eZ+NEBjRUJ16kIc5iIO4qriUxr83oe3lHqX5LV3B+DamsGztUc9yYzmzrFLHPsYeEljuLWKu33OlxBIhiJvY0a4JxgQxp0YJokgbzWaTvOAuIv2sYLv7aS/I3IINI2fwNfjXsuYn23Xs3rYg03uY8rWow5IU+nbNqo2uXIcu6ymk/IhKODSwbbHpbfg4jigWcm3L9HrUJ2McGIA5CkqeLI3A8YLziC+odufSh86r+14fYLOfbMPKwUK2BmSAuqcPnPNMwW5USIMvT5cYDlmtrRc3FeGGGnese7kq11Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE1FqM+15FaHjUvQWfpsMhJCLGZLx9bdIpW3vVPuiLA=;
 b=X1cMIVhKiVfvPCE3sDh1UBOvg2M578qUGp8wGxy43dI5GPsHSZSlzr13eUzxbOBRDT1RLaaTVxEhh2e3qlKyiaibcntn24aKOcZp7viiDFWwA0R2f9yVFlQcrmJcX5gh97uNtznkOCzDtOB/lSG6Ghwlmiq167ATda0tfll7ry4pXS/0z746asj5JCCbw6PhP19+carDaP3qHDcJWUK0mIHbf0DRdMOi+uDf/zOG6CGhEoezgAKljx/Ln9dS7Tce7CcnX0PbcQ98p+CSjbqciPQgYvf5E8SXwG4cGKkI9gwakj5sIDiMKH7HeuJDUdF5RV/uRkTuY905eccDYLc5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE1FqM+15FaHjUvQWfpsMhJCLGZLx9bdIpW3vVPuiLA=;
 b=L/7yAAtPGpaKIq0203fSNwszwUzL5uTkaMUJxPBEOYbe4R9IAf6GY4BB+ThHPkj2nKIy62w9NSfahkEkKZcvcQIIjxR5n9n9lUIADj7Qfc2Dlwq13OS9t5H9ESjCAAwaXeA8UaRp3aqYP4ezXykPj01j0DEdIDUFa+NXbGz+AOQ=
Received: from MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:25 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::32) by MW4PR04CA0149.outlook.office365.com
 (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 01/15] drm/amdgpu/gfxhub_v12_1: Remove obsolete programming
Date: Fri, 21 Aug 2026 12:06:56 -0400
Message-ID: <20260821160710.752459-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 7611ac41-05eb-4bba-6820-08deff9e49c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +Q4m/ahpwLLcrGZ3mbuTl8+5zpy8uYZw5Cd3MDMxLtrI9viLlefpUXMX/jIBs6L5bJVKHNMkH5RX27HAcl36RngU+uJb/1M2FGfu3a+z4DH1hO0mebLWkqR9RspIGXIt2jo8CDRrQLuO2moo+Zi/XTurAsxSwpCfY331VxY5op4wJLmjiiG/naDoE3Z2MhGNHKaD2BBsW/XJVoF0DaehTshbiG8kY4I6BgAwJId+ze72iAQgzbA/XgBj/qNwew8QYT/IpXGEwUkl8idb6HiTEM0r3OlQCDGw5QonrakxzKJYiUKjUM1aq3QyMG3eIF4yGV216kukFzM7xoPkqkVl2XjQ1Krbv2zjPas4HW+noavIxbxcvsBSBReyFVQkOGVo9uydi6NqjhnJQJNe9hy5VSJRIvtWRDJw713qVJs8mhBDLoVZWhBLDqL2br7l5c7ej3BCuVb8IT/xndZVRcf+xVnv8DiHxeOFS3w3EmwOw4nqVT28+H+fQL2lnKE1yEKSx68usdrybwUKto5xAGGeQRKBajOhhEsEAo2Lj2lt7f5CCXBlgYbTzTWGEzrVPKDbQOmR5hmmv9O9XVjRfOubD9QHBRuHPSXRSsvPiZGeSJmRUenCJGmHPEpDBK3qbWOSlyYo8mIJMW2q3rehcJc2jfzaM74Eih46uPRQaW03ih2NgsOHIUtgpkYihvBccsKSHatAngMrBP58AAWVmGTsQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yHkE+/CNC+yp2PRwEzeVutJGFhkXic/Jfd4zreQlH573kvFNX5Z45x8BCguzXtJSBmcCwFviF7xTBon1ryFI1Z48eBX4VzA5RbdFeYuQvZxjpucJeM6NOxIb/jwl6kwnRdURo1vc/2WsFyzfx008f1dDw2EQ50SdFrDCmtVyRkHrGlO8eTvJH5usHLqojOiq7a/tGReqW19CEtjQUmS6WHTedJ/m6x6I0fFxhn4mtqYpvjXP4oTAc8yHT/Oir8nsP+uj6UvPniIX4jEQj+gRuiZQVhu2NYWZCSmWhgpCMe9h0/Bv3Todt8CBIEFhEW2r7YXEvf7uWzVwu0NW4+ewXp8dO4PFTE3uZSGLTVreCpPAfPal158T6890XWmITiYKx92kdKQIHAslnDDTov4coxu0Guk842thVoTv1QYgehA+JhA2+bq4d0u6LW3QHXQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:23.9080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7611ac41-05eb-4bba-6820-08deff9e49c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

The underlying functionality was removed

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e4..0d57c106f9d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -272,9 +272,6 @@ static void gfxhub_v12_1_xcc_init_tlb_regs(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp,
 				    GCMC_VM_MX_L1_TLB_CNTL,
 				    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-		tmp = REG_SET_FIELD(tmp,
-				    GCMC_VM_MX_L1_TLB_CNTL,
-				    ECO_BITS, 0);
 		tmp = REG_SET_FIELD(tmp,
 				    GCMC_VM_MX_L1_TLB_CNTL,
 				    MTYPE, MTYPE_UC);
@@ -295,9 +292,6 @@ static void gfxhub_v12_1_xcc_init_cache_regs(struct amdgpu_device *adev,
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
 				    ENABLE_L2_CACHE, 1);
-		/*TODO: set ENABLE_L2_FRAGMENT_PROCESSING to 1? */
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
-				    ENABLE_L2_FRAGMENT_PROCESSING, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
 				    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
@@ -311,14 +305,6 @@ static void gfxhub_v12_1_xcc_init_cache_regs(struct amdgpu_device *adev,
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
 				 regGCVM_L2_CNTL, tmp);
 
-		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_CNTL2);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2,
-				    INVALIDATE_ALL_L1_TLBS, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2,
-				    INVALIDATE_L2_CACHE, 1);
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCVM_L2_CNTL2, tmp);
-
 		tmp = regGCVM_L2_CNTL3_DEFAULT;
 		if (adev->gmc.translate_further) {
 			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 12);
-- 
2.55.0

