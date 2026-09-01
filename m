Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C015C624D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7520D10EECC;
	Tue,  1 Sep 2026 20:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MNJ0aii9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9A710EECC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI7l7/nKPRuNSDKVoSr5P+aiOCKeqfQc8e6GMNvgJslvEcTDhJ1Rtm0oDkBGSRzToQtqg3a5+NgCtA47I7lzLTM0Ew1k3JkkTb6xjklK70dJysKdf3y7QOtJRxhaZ4dIBDsHW0YBmnb75gr4Ahtn/6O65esPsea/GmyG6+Cvilr3ztnX47mC5VjvNrjLIuVja/VJ8h4zAsmkT4/Be41zY8mi3gMAhnWPapfl4jkomXyJJsvnE/HA9BKGgy3UooxVCWoEko5yw6Icv2Fg6gRJdwMfh93H39/uDH1F2ww24vjBRk+u+MEui55Iy3aGs0U4iCvI7QkxUHnxDewemnx9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaBMAvoeWl2rOWMMZhy/PpaEL4j3LewJvlYyeHwyPlY=;
 b=MwyikTIPITmSfanPX7xUE7p8dRZ2nSiq1Kn2QDkQqPnSxOpQDI4zfGJoagtM77hbHMKdxBFJyPETyRYrtxWDJxRnPo85eQn2vkoOQFQRqbY1y4y4MJdTH+L7091t2f7xzpCOGEdPYXkeKn3Oq/1P7t5RgsVAsTDQASUUBL/uqu9q+Ex6vwDGVOA7+cxIJrp/wfz0Rdf2ckcrzOpT59mkXoL5vZBKjJVS4M+tK8f1dO2XV5an5R5KCAHGyfFRUOFSMK6uLlK+AdZwhNi08GSbEiOf+omnJztMKWU97g9Bussll8djvzaBZnK1Ka2B9oMIKGjpqGmIUY1I4MQdKTbLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaBMAvoeWl2rOWMMZhy/PpaEL4j3LewJvlYyeHwyPlY=;
 b=MNJ0aii9eNgiKMS3cIrDyPnpLWy2pLxmZ3yfv6xWwGhib2ZcL1sdfftMIwzpHeUV0Tv4hh0mrh5QLizzOay0zRIO+XaIvy7KK1xWVn5JCmh9Obe8W8BzWt0qKHqdWjKCnZy8h0o0jmFcFH3GO6BkDdJU0GHfmo8I80vBKZVDY5E=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 1 Sep
 2026 20:10:52 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::98) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/31] drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
Date: Tue, 1 Sep 2026 16:10:05 -0400
Message-ID: <20260901201034.2960437-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0e1be2-f943-4380-e919-08df08651ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BG6134wqthv21iEiv9e1f2r+XbQmqOY4gj0gCt/HKoVt28gtFRYo0ZIS//ePR/BZVIxgv4CUrFOihzTfuVXBnZIvK3r4WkobzBNF78M/vthCLcXPtQLMLOWDDzgyai7xwmjCy/atxo+J/d5um6NBDfCHxLgRff8trIdTTpYdRbotFWUA3vdeWY+enI4K2pKwdSpVv7KyxbF1sAz33pswJ6PsvyQLk0KOWIyy/LEaKShFvmlNOvsC2JpBSmXvRV2kRIfC52tghvmtmHIXOvuXqHRkn9drzeQaNDbfCkGbKBGrNt8Ro7qshHideXbO1tjTOQWza5451Ja72it6PVA86c34oYQUpIN8zkyaDU2feaf814iEtZ4sLNk+pSN45X5OZB31OOQjSmottOdr/LUe6pCdik8ZRAPUcF4MbpEM283ZiAIO7MxBs7ppKlAI6rdaRCfGnFrod/+smgmNbsllHgVxcqgKwFfpm9WKlDdldI0CDL2fnvZOiQNtFHRFn0pvmBb7pg9r/o1he35RG7uRnl+2Z02cwiC2RFY7tyfczI5cULh2eqZWmVkqo0eAsGrKX2SqHZy8r/QB0bc0tibzws1J6g5HFJ12grYOcw3VyXR3rDN3+Wk4z1W9JknmZw5j+wUbbu/dUTnVAS8C3eEMkW/ssRPTcIbeM1GXslVqRyeF6FymLZjSizc/Wxj7Xb8s0SnXPk6CPaVK7LzqgkJPAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B3+erXOnAfSE9sG1YomMMIxC8zMEZy20uqin8kzYJhRmCR3mPKeKDDIx4JSXNqpmI93EA2kQdczhJAFCiOUPMg3gNHkz7vHpN+HSlDTprrihyzhIDaM2u3XLfkeezbLuA+77ZvP2RH634u7Rqr1k7Kdzq+Fibb7uT2gJRDGgptgyWBwax1b9WFfycQRvnz0c5XGBqc/2dSrLuAM80FXo15oO0gys5EUg4ZfgUGAC5Cxda/a2CCPhqut0wEaBbjHkH1AvQaeg79wxhN8KeP4vqzPS1DCHxAhTAs7jMlIgRVzwcCI5h4z0fAhOUSHEupsAhJ13Wu0Kwjx+ibZtA4ihM4yqIqpfhhIoVjg+2CMKDcviZL+29AwDNfaAFTv3RVMRed+XT6uv6WG0POC7xz1cXMqOxaPnMoeDq7IbYqLtKa40aUkVk9BlfI82yD/BVh0Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:50.9972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0e1be2-f943-4380-e919-08df08651ebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 75a552782c979..8d88651b18ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,6 +265,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -313,6 +317,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
 			vmhub);
-- 
2.55.0

