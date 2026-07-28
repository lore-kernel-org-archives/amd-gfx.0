Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA2DC53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9178510E542;
	Tue, 28 Jul 2026 15:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rlT77qoh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3639210E542
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 15:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTBkModznSqPFVn1Rg4kud3YqmdhzHMXC3uwbju9wDi3bNtRFhvfzFLBrYqIAXUvQpWgjBBhhI2M4vIATE90E+hy11Vi+8gINQ6sbJJ0lJ9OT87KZkjFuiRTBC/fmiC10VfgEaaBtZEpjlrC5XNjV4zuAejaA148S+c56bKoAg1JjfGBW58De7nMtCh+iOhH6oCOK2ISjCru+n5GwsMvrGWcXnqVg2OMtL4vORB9PFIU8dOCec6zgVwzGss2SHH+QFviVcvwuKJqmMz/NAFXstYCiB/4iGHjMnIA1IU+r4NyVSP9J61v5+LLAux/yHzHtWYbfERbYcEDg7JsbpIgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c+ymnih6tGTAtMjjiYlQcYc8qrcdRvWEhsyl0s7i04=;
 b=RaoFZksrNdKhXDzuem0y2gn4TBDbgBVcW7Ng5xraDSma2/9u30HCS5rIL+hDD+HY9xdhY0FQW6/36jqAKpXQ/OXxR+4RJSfPkhSUZr49nXgjg7swk6yLgz80YaR0UT+1byCDnNSmZyBL9IEntseflXAbWcuQxcZdM3rl6ax2tFuz0X4r1WDVU3ms147iAVIdwANMt11p6UDKu5ZX0iebSEtn9kFXO19XCOYhCfF8gxnZgOOmKHGlipC2ij0uqeQYEL017fmlqMdfAv2wyMylKEYf2+qgWfLsd558QumZWnStSnXHIbK7vl1pz/u3oMFj5v2lNBW8j0ewXJtT4++miQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c+ymnih6tGTAtMjjiYlQcYc8qrcdRvWEhsyl0s7i04=;
 b=rlT77qohO6Ofvwq/BglcM3/Vq+0CO5brXL5S1WGm+w9SFfyRVJ7srhPoj/oA3ZtOagbAWnTmhIUM/oheoCwa95jmtmi/9N3VjlMnaDlyAwxsm0poB5kes396YtLkLweJ0zj0e3fFxkmBMG1PdJ0hwXMahkt+T3976iXar61YQGY=
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:39:47 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::2e) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 15:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 15:39:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 10:39:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 10:39:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
Date: Tue, 28 Jul 2026 11:39:30 -0400
Message-ID: <20260728153930.1531949-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 257ca3f7-1542-4fa2-5f27-08deecbe73fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: AD2pg39zCOVZ5Xvnl9iaVPxRoJGBMkzB0kpXUa5MGSobtPBOeWIXogW9mm47I8riUzyiFnBTfimfS+KWtvWentdTynqrmbegA2nJ7F4HftH9RdrTSYhn4A+9RHN0LJUm17Jpmdgl0YGFNayb4qmY5b56tbgvl1xJSjVcn+PFU8nbjn5Tzv3odAPozrikIu0Z1PeeKpAvkd+yzgtstNuS5bQOhFaFfFH5bY3OzsprMiedX8fYH7mOq+dGXR4yV7QTy7ioYE4FrHm3GKnChnXAcOhuYq6743dURNL3cBJdkJVysNjOEpEw3qiMUKC+/KYl6FztJ20NxmbtnNATYXYtcEb3StPdAmewrclQEnF4Mt9CYuPjDAGRsmmJ5xzEDsUeGIB3kCiWdSZJjk9TtIO61ZPkEJkk6TxUOhnF6iyIUE/hoqgft5R/dgT+LbdjAh1Gg8UN+UqG3Qfzh3lCmxDPs9OOwxj9T0PpdOtP975vw09UQfaDOxTfwXqj35LwS4XnmcLxJIPgK7CUNAQHx3+nqotAkh1J4UmOIsVKR4/Lg4fXEg/u9DwvAj6BrgZGnLllAcLiXayz7/BLIChAhm5JFS2bNV3qXgGCgZco0yW+n6wyABlO0UxtAXnofm+YYYZlsW0jy+/h6t1QSGBhdJyI4Tv+Fi6bPTY8gvhiyhqSe1Ws3kQgwdA4UrmH2i4B01bsi/QBN0CSXayczCZaykq5Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LNdQU5k6CHLm+uUk2IuYM063FcMPdVJln8mXMox6FpoM8JHacoJUiO/KhLt6mTYRcPcPxbE+H50NPg6I54hHkkrqtBYa6fCIi99Scye6ekCIQNY0brf5jAtfp0WwK5e+ojRF+YPZwuDDe09l0x2c5aPoJWjyIL+8adCwV9SIeCKmUnHrotig5K1azS5JMKWwmrmWMVEnMB4jaeW7Ml4uvDyU7+RHCURCcXb7GE8J1pceh9vwUwb7lqBwjteO/7Y6C8Eh5GLqrBwiemf+0iaRhzT6r3ZojVDPsfYp00qQUIOzbs1MOkf4LlmorzT6yUIUkegpL6Omk95lK0GHYYCrviFFrj5yhMB5DmUYU2Zhok6lFWalb9RruNOvRiT+HgAslJkHuQr0bB8T/vUqCMhRxPij0slbZNk3/LjsF3+enG2hCcetcVtF9RWqfB07yItK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:39:46.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257ca3f7-1542-4fa2-5f27-08deecbe73fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

Check for mmhub0 rather than mmhub1.  Looks like a copy
paste typo.

Fixes: d0c989a0aad3 ("drm/amd/amdgpu : Use the MES INV_TLBS API for tlb invalidation on gfx12_1")
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 855cd29cbffaa..54a5e64f53b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -396,7 +396,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		if (all_hub) {
 			/* invalidate mm_hub */
-			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
+			if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
 				input.hub_id = AMDGPU_MMHUB0(0);
 				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
 			}
-- 
2.55.0

