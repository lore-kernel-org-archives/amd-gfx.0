Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EE104C007
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 10:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B56310E0BB;
	Wed, 11 Mar 2026 10:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ByrGpGrK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B90F10E0BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 10:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3h5F3TYG14y0XSVtwl5VuSF+XYhOAnVupMMzfkJqSvSLJ7TRdZI5wSEoBPR3pv7Es2zFHmULCsc7ykGvhPpxcsstMz+QT7aSFVv11nWfWg5+KiPO2Vc3aBQIa+MBG5HFaYpqtLv1fOTDyZYT+m9SsGeaaDolzrgojOqhQR5rIRDfdVC/gunRA3J/1/DklX9GIXTzFKIP5DFVmGhA2PS9lkceM3yYaUhFHOGHc0E06YDmpeRgQdt2VVIt+5LjycfmFD+4yHx/Qm17d4TTSY17s1ufDqXgCBzYcs/g3nt9lvFSqws+05U/83TXguEYJzdZybpmcD3Cde1XChui279fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f+rJEpP51czw66Qdbqv+VlwBrj5K8xBHCsKIIWiU9Y=;
 b=sL+oleV1edngIC/Ra5KFRJJJPiBoXY5VSkE2OFcwslwXDg5FboLiWTcvyeCR+N8l1ujwe+7T5MHgHt/+ZZXuNZfKFlLLS/AbUScdNA5MWvYbIFvVuSnwHI5cFSjp4VHe/yMb1Tf4fz+cQWq32uJDYXNsveCJ6AezkWp/IN+uzoRETOPNn0ji5+but0u4qxHpj8e3geKcloLipk60RBnS7V6eXpeLkW1SivgHB2RcV8nlXEg9sOok6w9VN7chixg0Ge275Z498vHpgh2YIqmblJ12YcJtvMS8JsX/ipalxA6L5fxh1x6Hxz/y/KytoO3s4H1KvQq9n57FpA9GMczglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f+rJEpP51czw66Qdbqv+VlwBrj5K8xBHCsKIIWiU9Y=;
 b=ByrGpGrKj+0RiOfwOX1EEVSWXOOd9bA8c163ejZ39xroWFt4P5DhP/RZLIQ9wCNCjQOQFs/bfrzUppz4UiMu1uUNxzKbpPxNm3ivIRGoNri+JEwdbK8zG7PfWBdSzcWOwBPeaSMkogPsX+TqmOqt3zIDqZHDynpbiquIp5e5/Fo=
Received: from PH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:5::25)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:57:42 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::5c) by PH0PR07CA0020.outlook.office365.com
 (2603:10b6:510:5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 10:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 10:57:41 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 05:57:40 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Date: Wed, 11 Mar 2026 18:57:24 +0800
Message-ID: <20260311105724.477408-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 7326bdef-1eb7-4abb-48a8-08de7f5d0493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KqwQBSugpUOZUvhChkb3rGUJA/HFYp+v1e0oDZqtaU2edWUNtLIHh5H8ZI31FsNTg9xDVCymWCPbzCMtvQktmdz/Zk/tL0t20vRurJs+CUjnH2e2V3GUrbwrIQsjBn3q6kL/Sr/5cbx63Ed297uC3wCUDatWEzCc6uDuK4B1dVXIEGhjRfoIR7R8tL4NAZ8JT3YOf4eiK1cKo4dv3e7mnUjlFYyhBuCyPkI7TfCGcHiP6Z/2QENZa30GOjKB/8p90UG/e5rZuaxQEWHbmk6ntYsuIzQ7jlqC5iuLxIvB410DHnDVOftrJqyCULtWCTePzB9fpUFb2SXzf90KK4M1wTTrYYtToPzE4XV6ZqQ6x3/b7f4/80ic1V+BU/F40rwo0z2zUnEQ80I8AnjwOKnJiHlR1wIJYdTNupOoqhEfTOEO3M9HRSgEVbbkEdqJKkg8DcWEt8lGvQgT5kDYSDo1EZIqXmwJ+ac7ZLLV2yy+9FZxROoKf5CKVYqm0INi+2a3hs0I3r8x/028IZIxtg6ikG7GRRk1A3mj31U/tj/NpFWWLpH1wD640+M1Bji7AKljl7ujKRuKUdk+VfRPPmzgCuaVVxAghP2FHPHT9b7JJG9hDwvoIA12x8NmaxNEMmFVF1BpHOCaiZzSEqWDldz2BDAe6OJg3hPXs1RUREO48Lyyia/UetpoYXC/2mg4mWPmSmIzvDpcXCN+Ki5Wd1h/zSHi35RMXqr1qCJqtpyuysLlEV49xiWdwBrhReKMmU5hrUQFCKcYP5TIlrRzCl/MLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qARNkQHc8L4Q2sTp0Z8Okl94X+bArIBdquidCcnvzqg48MQCDQsXPowfhow9C0OghWgf4Ay6P1QcRqEZ/OF+UDab2C0gHBRKyOM6kLqZd+eSzexhoPsvJCO824WuZso5VvaEMqRVhbBkYPIy/HENN0yxrEAu0+7zn6bVoNZAqQlHVhKRWd2jTSlBgyJEkyg54Go9j+WV6UMgW1H5oXQ9HUdyIrNTCNwaFlvv3rYnqy88Svdz8kTpLQV/RhZqY/3OiXhHc0Y1LTlDItPmAu1rJNTUSGAhMjfxnro8L9b+iMM6jfJv0+AehQt+jR2HmfKvuPXdeAAMM+ogZZZijcpWsLyuipQqE4NZs7Lqcuq47/hjIsiDiGfiojhrMdy0rFh2/c3XCpR5BkgbfoFI4kSw1Vafi1SySD/N11/wT6IrO6N+UISEFM8vyPQq112SyXNE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:57:41.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7326bdef-1eb7-4abb-48a8-08de7f5d0493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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

The flip bit setting is different if umc number is half of original
configuration.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 109 +++++++++++++++++--------
 1 file changed, 75 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0f5b1719fda5..3d34592e8ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -183,50 +183,91 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 
-	/* default setting */
-	flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
-	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
-	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
-	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
-	flip_bits->flip_row_bit = 13;
-	flip_bits->bit_num = 4;
-	flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
-
-	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+	if (adev->gmc.num_umc == 16) {
+		/* default setting */
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+		flip_bits->flip_row_bit = 13;
+		flip_bits->bit_num = 4;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
+
+		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
+		} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+		}
+
+		switch (vram_type) {
+		case AMDGPU_VRAM_TYPE_HBM:
+			/* other nps modes are taken as nps1 */
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+
+			break;
+		case AMDGPU_VRAM_TYPE_HBM3E:
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			flip_bits->flip_row_bit = 12;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+
+			break;
+		default:
+			dev_warn(adev->dev,
+				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+			break;
+		}
+	} else if (adev->gmc.num_umc == 8) {
+		/* default setting */
 		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
 		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
 		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		flip_bits->flip_row_bit = 12;
+		flip_bits->bit_num = 4;
 		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-	} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-	}
 
-	switch (vram_type) {
-	case AMDGPU_VRAM_TYPE_HBM:
-		/* other nps modes are taken as nps1 */
-		if (nps == AMDGPU_NPS2_PARTITION_MODE)
+		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+		}
+
+		switch (vram_type) {
+		case AMDGPU_VRAM_TYPE_HBM:
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
 
-		break;
-	case AMDGPU_VRAM_TYPE_HBM3E:
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		flip_bits->flip_row_bit = 12;
+			/* other nps modes are taken as nps1 */
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
 
-		if (nps == AMDGPU_NPS2_PARTITION_MODE)
+			break;
+		case AMDGPU_VRAM_TYPE_HBM3E:
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-		else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+			flip_bits->flip_row_bit = 12;
 
-		break;
-	default:
-		dev_warn(adev->dev,
-			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-		break;
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+
+			break;
+		default:
+			dev_warn(adev->dev,
+				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+			break;
+		}
 	}
 
 	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
-- 
2.34.1

