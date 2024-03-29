Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A02FC6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 03:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34AB10E2F8;
	Fri, 29 Mar 2024 03:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBWmhInB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E6E10E2F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 03:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWmhGZRmAXJ9uw+CFjr0vZLrZ66vw/veQf9EeMPOZkBlgi8AoOdFgcOZvsfavxIhmMY2k2YZeMhWdG5FuwrJrp1fQQqq5z86vp1jNBUlWDQQtJfnQd5zK1z5vtTPOmCEadS3UoxHYrfzNMgMpA5p32UtqGZJBwNvyiti0dEmbFjW/AO0U4839VmxlKtZSy/IQI5Xh8wCLLdf2sOwrrlZ/tTTNi0mIWnbhZMea378S+1HBuxkGYAzTeMLJZSzCljY+WJsgBIexFtz92UIoQnYveJwesOTvj6q3X/XKXZeGb5p5W/HHp1DjjLzuBb8D6DElvutnwqe2hDcAHDz020meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTHTUUk814GW43JEHSwBLPoYrl2AZltYWh8mEfzPKPc=;
 b=O6hKcxuE5ZVQuNZ5U4OGPBT0Kt1B9VcCgvQtA5ACHF0OpZe2Q34nrfc6N1kHYdz95avbVMdO6CBCiW0IJlolyVf7D1xQCzX3VqGzyF2YN/CU6lM7aSFqAI1klmf2rHFkUZb3GfkQyrzVrVk/ici7o/5YcPLkRyRkkf6NTzlrOSNBUhVOmPz2FsMzDNXubamopjbsKvK0OEmL3CciQyU0dzpLs8hff5isCPQoqnAY1LjR1NIf/ioV0Wi7jpEXtXtso04koCAwl9vvtlWkXVAuReAsCgL1lO6yfDdfOS9NEYzvP1EE0pJEg5MCJKHtae4UKPUrldU9jdN5NcIfxihaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTHTUUk814GW43JEHSwBLPoYrl2AZltYWh8mEfzPKPc=;
 b=LBWmhInBwofiU8t1fbG381tdxDo5gITtXpOw0sr73UkhSPLGRzkhHxAUO9pkoBkuVIGsWF6007twyWKzoxVLGw7RhiFhuWoyHNqy+NlAIGNIaSBK/qwJ6upZhJwnySyXhni8lTuMZkuAi4FJ2P6EB7C4w5bxxabvgXqqZ1bSYBY=
Received: from CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::30)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 03:10:00 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::92) by CH3P220CA0024.outlook.office365.com
 (2603:10b6:610:1e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30 via Frontend
 Transport; Fri, 29 Mar 2024 03:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 03:09:59 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 22:09:53 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Date: Fri, 29 Mar 2024 11:09:37 +0800
Message-ID: <20240329030937.366266-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 95eee791-b9f3-4966-a66d-08dc4f9db83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJw3Rp4Yp68wkq1w3lhCBZZmtBhAWUY6TRZlNJl+4ll6tZGaWlJ9A2WKAINbbJilwCbDiip6P4YrZndxNBpO0YGMv38xFnr3w1lTa8deI4P3GF2IXBcO4vHSuJVYqQkswDIGqZcQgZJwE1ISoI4qDoanwY8FU9Eo2CVpYTEbz47g5dfmNxfU25ZER9oXNZXPBq5bMBuA9fz0L1PxhO0k1i810XmnrR3eyHB/zgLuoTJDVLkndzBx8RHHOvisRMWUOHpr4KKX0eDZBvmPJ6zlalcpEgC3BPN5MczxC0x7LDw8HT7pSOgfdJTng6HCUuNL75GZqR+aqH8Gg1nuyx0mVikH2Amb9rKDxW5DuOHCeV5t+TSzHj+1uWodV8wyhgs8i5MuegUVPzGFNMg8i8s01F4qpFxJ913Hk5pxzK53FahI9qIpfSt5NZggFcZReXOmXFP875+nGHR/2z71753nE+LVmt0+lNPmi+FPMx/oH5xXQ+Fy8H9OHuFcm7fbv3LuU3QoWyxE+04X//JY7JhfNsVWNnGoWmDd1q6xWooTNHe2IGi8raH+WjTB7D1qVhPpFxTGPaYhGuhgzy869PplfuLC083BWA3Be2mynhPfafLfzECKJ595KVv+XZVFqDp/oZfL1SPDC68UXIvWXZ0yYuAnYNE5gSNVd/gBmaTLwWTXX11JPxf7MQSoethviyFzMG5VmX7kYmC70MPaldbt5uiuSZRIjHRLIps9b1njFXkbJ1Aaf+rtTH4xWGkO7cWq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 03:09:59.8519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95eee791-b9f3-4966-a66d-08dc4f9db83b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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

SDMA_CNTL is not set in some cases, driver configures it by itself.

v2: simplify code

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 71c2f50530cb..f8e2cd514493 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1602,19 +1602,9 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amdgpu_device *adev,
 	u32 sdma_cntl;
 
 	sdma_cntl = RREG32_SDMA(type, regSDMA_CNTL);
-	switch (state) {
-	case AMDGPU_IRQ_STATE_DISABLE:
-		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL,
-					  DRAM_ECC_INT_ENABLE, 0);
-		WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
-		break;
-	/* sdma ecc interrupt is enabled by default
-	 * driver doesn't need to do anything to
-	 * enable the interrupt */
-	case AMDGPU_IRQ_STATE_ENABLE:
-	default:
-		break;
-	}
+	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, DRAM_ECC_INT_ENABLE,
+					state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+	WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
 
 	return 0;
 }
-- 
2.34.1

