Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D0C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D792110F34F;
	Fri, 21 Aug 2026 16:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzQ0wk10";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E0110F34F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIWsEE92bh0KcUoTxCl534OueV5jaLNusH98iHhILFNr2IjPRbhdQKg2KN+qAohKRD37elNOORLc5hy0a18D/6WBQ+TstYXlEfglwMlTY59AGs23kRV9alAJNsKK8fHGWn8ve2HSRkdcnTxMJdF3I+eTUqWy8yCw3a9Jg0n3thJCc5iNGj75YbnB0t2bYGHC5ftqDgg2ICH4g162DxC2Y3RAu0k8IYr473tgv7zm4tzyX8QFf2SDlrGi0fKUFMHERkJd4urZULck1vR/EOUpC4EEi+DIQFvn02HYuEnBKz/w5aLqUxAs7UOTNTLK26tAvgQpEwknYjI32thLshQaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OASohtW8a4qrq+DJosP195o22Ikv5gEqDMSJBYz0h7U=;
 b=kIJkp59zePOrVuo2TNSkqM/zqdfL4N0l+6MIE7FU1QNOKnNz7qm0KgA1WqP3X+l1ZGIdSNkq2DBX5kuHAekkMEO1awVoK45/TtKlCnPHFRGFGG9NI7ijDPLpIPqFkcHMNfBGAv/wOiaYoc//xtjEpQiYTFfGyhzE5Tvr7NGjbB5/FgANXsNz6I3bTRyW5wvHIN8erPjgeN2I2Sf33Jb1TY80d1fqwW64vQBWYSQCUZ+rFNJvdP9UQZUzMs0gYZEGaAkC2h2QrRwSnA8CgXn8YRm1Vjrl9V/Swmb1/SINwmNkSBO3DYILLJOtYHKEDugjrQTDy834vwpXG7N3jucB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OASohtW8a4qrq+DJosP195o22Ikv5gEqDMSJBYz0h7U=;
 b=CzQ0wk10W2KEx/5xHG0Z9Moq0ptUJPUg8x/ft/Hi5UIskWursuMnDWSZLSVasgYe4R5YqhXQcaIKb2QfcxpamOGtaG580gtQzwsTm2vuy2p2iMPIafSxF0Xp5WjdzNUlASoU6k9DSasssFbAcIVApBzlHBVFiojb7swmqxNwirU=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:24 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::3) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 02/15] drm/amdgpu/mmhub_v4_2: Remove obsolete programming
Date: Fri, 21 Aug 2026 12:06:57 -0400
Message-ID: <20260821160710.752459-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0bb01d-d9b2-4537-230c-08deff9e4a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GDwQYXG7qCz2/1tnzWydAv87ENVqGinbMGcHgQjmKM6VoWV1HlAVe3kC7iO0o8A5LE/6h5URzrD+LOkpNtYts3qVtT3ETEeWl9jefTRCKdJjnDQdYkQJbahWnEFuxgliffGueLbgRKt+fCEAwV3aMkkn1ve421NOHWw+dbzUf2CcAs3ifEsYKd8mHKBXpSJfvr/kOtOTaGo/RT1QL2ZQZVCcGjPbrM73qr4JgIPyus6BaKyvMnDf6OgFAngFDxTE/9CdHL1nE5569zmKqbdOAgRIpgJElXxiUNHovUNOzunbQ151DJMSxHUxgN9WWlT/FmpaoRQ7YzvHMl496oWxWxibaKSzGvaNnmfwhaXPnRoFy0GE7Raj7sHeuVx6fI+THPQLovwnu9u9mDAVUe84b0fmydHuo2YzrZCUZubq/lE3DxdYfOc4apdYBBgUFfscfI0OrQdSlA98fGXkDf49CTPEyBrePLTst9T7njH+hoXb1MRgRD2YaJWJ8GcyLo+aIcEvltkt6K351ui5zSqTMulEOmigjgDGrBGnDEJ5IAveS25NLnCuGliTzYjHOokJc3B4nkMUK1+csEHhgwxpMZIDDXd+AGHhBoM39rh6xYdFz/hp7FSwJyQg1lfpwvaN9azz1sE1Wlqh15j8FcPL9oEJAPwQ/AZ8ggkg7PM4eLrwYztpussX7hGiK754MO7h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2JuN98J9UVtjkGjiuxur9vljhOuJLBBp0NZHjIuyG70QiYTwr6BVeN5Do0Xfa2bD5tFKvkhX7fVqU4+hEQOj2UG+QzfFTIlsfEfsgbQILVJAhtPVSaZGEonQLQutcG1IJP+HyL4N3s44QwAdUa3225Cb4sNOzF0rrczwCT0EGkgoJHWqeHTrVXZ+KWyVUFaKUzvpZg9pGZcCD47Q+ESwPU6Qqi0DQQpbIs+vQq/WuzzIpxxBG592JI1XwtY8hCrcX9TW6/B/5hvspt7KTgjn1xfgFz0eEMFRwMCA7rnq3GxMagQDvr7t42KjXuz1VJfs2Svj3epY2nuVJ3X0KtRrNzssET0MIHOVJs71Z8S7jPz/RWgtvG4UVFzbj2UBD4IhM17hTHD/NEEWzrmmQe8Fi+cpo2bl9SQLHrqwL6Z7GHGcH6zBVsDKhMVYJGI0r1lv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:24.4201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0bb01d-d9b2-4537-230c-08deff9e4a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 5827c758b373d..5a29d38220ca4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -344,7 +344,6 @@ static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
 				    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 				    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 				    MTYPE, MTYPE_UC); /* UC, uncached */
 
@@ -369,7 +368,6 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 		/* Setup L2 cache */
 		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
-		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
 				    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
 		/* XXX for emulation, Refer to closed source code.*/
@@ -383,13 +381,6 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 				    IDENTITY_MODE_FRAGMENT_SIZE, 0);
 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL, tmp);
 
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL2);
-		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL2,
-				    INVALIDATE_ALL_L1_TLBS, 1);
-		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL2,
-				    INVALIDATE_L2_CACHE, 1);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL2, tmp);
-
 		tmp = regMMVM_L2_CNTL3_DEFAULT;
 		if (adev->gmc.translate_further) {
 			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 12);
-- 
2.55.0

