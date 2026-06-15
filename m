Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5571CCD98E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E8610E778;
	Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CUzc8zDo";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FFB10E6DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9OdKjfQ7Tp7hU4WXbrSBnGXitMnAIUgLJRQ7t443MBG3ulddzq4ZILgTscVoll5SDTJ9mcOQE9xhNFzJ+s6i6ekDePosbiI77JFc1P05xlelCvby9iLZMH2fXH2aF5O7lqK8GluMO3wDl4P862LXPl6trvtitAbQe73LZ5hhXugL787pJrxDZ264hyOTQY3QaV1mVX5ugcsVinGEkAXRpvZtuXX859Mq5giAMgsFRSDYwWWHk4fPAxe8llmBUPgwXDwgMVIygMleZzSf1juOwTiYR2gLuglPe9kAzfjoo1GuYp0rBl2XQwntRutkF8lhcTB0bfBWZqPh9hCaB0ryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGu5w9HoMd1fSpP/lfcNjeGoLlnz3UTPSL2vPJEw6+s=;
 b=hVlnWKDqpMAhaRxGlkGa4hVh7M/EB0mJ5wj7aAKSnSiSwTF8atbH7a8zVOPYZnNGlK3itBCfuqbaHlREJnZmdhE3Jpxk2rEA8w81ZeFAWQEjtQSoXCB7KtitfOixnCQtHrXxZiRpgthlge0/SBMm+mi9huYAZFYqfsIVDpj7huDZRahYBkcJ0XyGBTcnilSW+9pDsljRYEUOcPGDQXrPtsQytEtMxCVgvm7ZUltH6Hu1/b+4Xut9XpcCkwNNbqon0r4luzATlkou7m7CORzh2ChIDhiu8g/k8f8V3v/2dZJUphrMat550YUET7niC7WZ0ugKhldM4Qrr4QKw3NgD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGu5w9HoMd1fSpP/lfcNjeGoLlnz3UTPSL2vPJEw6+s=;
 b=CUzc8zDot/fPU+i5ecZEub/LGq0dKYcUEY25mMkZMd3FI7dIDuIJa43Q/ZFES8rMnB3ZlodobD/ZSSLpL/VtapNohphMb83g9zXyHaAtvVbc8Ap1ymP40jBYoH76feSx9QPSjhatFXyom+ET1NV16tAc4u6i4RZuaXgPjDU9n+g=
Received: from CH0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:610:cc::26)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:06 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::1b) by CH0PR03CA0081.outlook.office365.com
 (2603:10b6:610:cc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:57:03 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/43] drm/amdgpu/cik_sdma: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:23 -0400
Message-ID: <20260615235645.737189-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f9f43d-5c5c-44b7-6ea7-08decb39ce1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6hCjM6c7y35xAfTVPzBVe2ZUS2uRRVVN+hmb4vJlIHJ6B8fetiUu2WUDMJVuj09AAiz7pFffRKqdXA94ciel8N3uyK/gD2a1vkR7eqBsuyNYE83xUBmvp3e6rn0tGtiecjg/yrrwqm5IBhNyqlZ78iIa8daO40dUIULZuFSSFiRom/vpQdbLdjQptxrh1rB7yh5bFBQ3QVuBIN63Bcq73Hx9tXbgh19oRpaN569GIwBhUUp4CaSzyHu2GFvwC8U6EjUu1IRs7DAdmLaFpGuKPkNiAkQTIhnU/TkLzQEkMk1Hr1HYAbW69o0Qavp7anbQGkVpd6G0ElQ+QQHvozQ4eL5uTHz9xegi9AnKpuBXS1S2WgyBahhSQ7O4sTCVJOLSHjHAYtbpzz0yWinEauAVOrreTgz4Od8peNCOGy/yPFbJIV5cW8gU1Jmz1myLm0zwPVeCJRcqqKwUbyN9O7zSCoe4yb+Ijt/jwtZgig4/7RVJe/U0YZI9v+CiF8bR+0Rf1g9oZfGas8d+T+oGgqYD4XeDZd/yknvXniODVIvaF/12tzOEWsgsyO/z1+47lv90G2YdL9WHbXHXE+sdhhlKo+LuzTy1a7PiDvuXF/xtQND/4v3ChUakEyV/6jLDh5IsZsoLuSzFjNiLfVPkI12W6tFwV/AFhSiljqqlkg+5iQOqSaJEVXe6OM9NPuu3OPlAdvzsPg8trudDcVxpzgTbpRkhMbixEp5itNCemDR/3Us=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vj8nDQ8aDVxsJM5Lfe9hv1WBj4JrO8zOVqyxf3+21lqcjW8fsEVrw8rQB6TFgH8I8KDFixhgbtuLSHEgoOISijjngb01buuJtrWDAF15Kng5B7Tq6TSHBcnvuSwO+NoZ26ojF0iSmL5RJM+mdYOGggHcZwEmZ3YBSCt8pEpNiKbn/vpFaYl4FxIqZTyxwEM/l7/HhYXzjuA18ZSedXZGr/xqs1//Qh/amGPkq6/MzNbHWs5CoWN/PNe4/1M//wGB20PjRINUYmyvYeiGXOMqqMsHDKA/Kj2oKnRnsSfmnJT+8iAeA+bRGUaTx2HNWt6y8zZWuLgzXarv0VQ6gDOcpwYDb1pjVAoi8hae3aIjaZrsJ8DNEEw5MVmF3LvAxR8fOCz6cDQEetnQxbaXJwuzjDCpNJZOUrbUwKdT3cSTBDGH8LtByZomahZ1IO8Qn36E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:06.4489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f9f43d-5c5c-44b7-6ea7-08decb39ce1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 120da838ac282..45a047b5ed3b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -125,7 +125,8 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 	case CHIP_MULLINS:
 		chip_name = "mullins";
 		break;
-	default: BUG();
+	default:
+		return -EINVAL;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-- 
2.54.0

