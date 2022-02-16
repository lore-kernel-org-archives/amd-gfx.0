Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FC5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5489610E69D;
	Wed, 16 Feb 2022 08:09:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B973F10E691
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCjSS0iq7R8LIPXWAa90X/KlWFehc5ogxFJbhyms0cp3tBWwgIZAehJYoGJfHKyAfFk9oLatabXCQZmWQT0DVeRoUHfK274TBM+tvHeA4hyTu/oiRATK7pxNq6qeFN2lymdF1BYc8xBPu3Tre9AXd+aipPrTwyVQgAp+VBYsA4A469NkckoM+jREOP5U1jD1ZVELwt+6eA+559SVrn22F35+PXJ8tM01DYQofpp35ndH5v3cJ84Ojuv5F0zKr3FP7J+8ubhIm2UUPFpWAQa+8BHpJ4q8ViW0cuGqer/FvrRcKskt+XgLEL1uhc9mQGRy2IiR2A/UHfjTieyyQgyOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzgOHWFQr07/TO+juqwxQYN2zZmtBTSdYMicNFjPhCw=;
 b=GMCWTbqFh83e0Zn7cilz8q15d8DggL3vynyTN1CxLnI5CSspraR3aWDyV1gaDOu/O2UoUr0ud5fEEpLVQKqkHwQyGjjUs+DBClPbsXaaEV9qoCMcVaWZA0+8EZBotPEfqyW/EbvcUTf72VnglmZ6WTBA6MLnOqE3ecnP67YbKikh7r5GtE4K5QJuuKbxvzeewaD6jm5I3CMLzvwQLzOwk8sfCQ2Z/ObKxfjuGNiDY7BBAdIV1CTyqZfQA9o7O6fX60ZKtAt1FTh+xynsIrKeJ0+imRAI853zEq8lVzyIA0kzv8IRkJSxyRs/D/heACVltrPKkadezYzZOOVxU7ZQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzgOHWFQr07/TO+juqwxQYN2zZmtBTSdYMicNFjPhCw=;
 b=SS7Hw1SY1uIN2zaPrIqfBEQx4dk8lvHBGOII16xU1/q53XRbtBgG06OG7Pgnp7gZSguq8IvP1ZHkSqSA/wNXVCIqjWdSjpzjVPeG6XN4TQXv4Sy4SmiXUwgSQ9bi2HTJqSsxrpPMjscXK6GtQ2RyFsRHn3tXCp8JAuf+sbJlgrU=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by MWHPR1201MB0159.namprd12.prod.outlook.com (2603:10b6:301:59::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 08:09:05 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::75) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:05 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:09:02 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/7] drm/amdgpu: Remove redundant calls of ras_late_init in
 mmhub ras block
Date: Wed, 16 Feb 2022 16:08:00 +0800
Message-ID: <20220216080804.3560484-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b9d085-5f24-4c14-4fa3-08d9f123998a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0159FB0FCBE9C849A9A6E407FC359@MWHPR1201MB0159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD5f9SkkfKhmU++ErZPNPLkBrGdsNe2x0AXel5Hxw4WQ4b79e/bSNGnS/1l18zVeTotAngQQfkqvPBKijDtP4NA/8eWWD8HJbSO4kaYew95diQO2vV0/kOFWTXAgcjNB/ThhLKk1khILqWWveUSZi3BcVogS3XDhrx/VHTfHLVKdJRxPvW3uhp2XDkbHN+z3nb0saprHbmi8zvxzYLcmoF8XhqyK1jDUGhJ2TSbm3mbqKNVhwHRIfyHzPniMb/xVUGpj7HALGyDx/raPsBRXtQw4VBpy98xD99ixleRrR5ko1pqihQCK64CdKpyeu4HYDbJUIAvEBlQVFWBPiqlAcGX3cWmo/Zf/Q0Wzj2nqCVi3ylRyDhtB/Wh0SSbsYOt7bPo2oeI5jQa1CEkrJJhlG+aKiyGry0AUZl2xVOQrWnyXqFi1vLNY+6M4eNkLsKHbKRQG97rYxfHpCbALLWROyxVsENlk68Om0PN2G9pSfGizzyJRnbgRR/x6Iev+kYWVhVvJUNerRYe0DOtGwg9Bfx/Qf+LBySZdZmUvoKTtDXp2DzTETX9XTpAvY9Y5A/Iyzfkz39hDGGDWLTp4vRay43moiLmmLEUb0OwaLLdVABu9a+85J6a3senTI7h/lEcflef1Z1pf5Wcbcq7Y1DCXoM00SNoiRjUnEEKSLSZGygSimzTTzUt4kssH+wzzVherrBzqp49+9WMW5blHSEF5BwZ7JtrUWicT5gxscFQcsoc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(356005)(4326008)(186003)(70206006)(36756003)(54906003)(5660300002)(2906002)(86362001)(8936002)(8676002)(82310400004)(81166007)(16526019)(40460700003)(426003)(26005)(508600001)(70586007)(47076005)(36860700001)(336012)(316002)(2616005)(83380400001)(1076003)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:05.0044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b9d085-5f24-4c14-4fa3-08d9f123998a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0159
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of ras_late_init in mmhub ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 2 +-
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 67a7d1cb89d6..f443d1e359ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -458,7 +458,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
-		r = adev->mmhub.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->mmhub.ras->ras_block.ras_late_init(adev, adev->mmhub.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index ede98db8c126..42413813765a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -24,11 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_ras_block_late_init(adev, adev->mmhub.ras_if);
-}
-
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 75815106f2d5..240b26d9a388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -47,7 +47,6 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 94095b965e2c..b719d2c3003b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1293,7 +1293,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->mmhub.ras->ras_block.ras_late_init)
-			adev->mmhub.ras->ras_block.ras_late_init = amdgpu_mmhub_ras_late_init;
+			adev->mmhub.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
 
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->mmhub.ras->ras_block.ras_fini)
-- 
2.25.1

