Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AD4CD343F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 19:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B2A10EBDF;
	Tue, 12 May 2026 19:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GPTw0aIA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3455C10EBDF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6rsLIw2w4RNoDn1L4AaDkSYS3pDGG51F7KUq35aTlfzOvMhbjteiGIl6caJDjkmJHIgGrt0hcOprSna1Pn4TJnvo+qz7ckyQxU59i6IwNGm+9PMp9mfQlCavZU6QdMYoh3SifB1WLIgOFuwO2GISNdgTnRbxAEu63Gu/PIeWHJUPfuzmfwZD8XySNb9+XE2auiBGHtmhnOb2oO5sGzLWyPwOYCN1yRuj4g82Mw5vvnNPgWQtZvE9CJb/vYJJGM19Kn56T0761pmi+N5Zqct7w0nq/+6w+prfvibHl9U5TzfJJoK4Uulp/m5X6cgj+GlBBqOkHjQffexQybzIIjZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJITmfncZSLMhsWiYoPfe4b/eThvWxRFGNTOlkgXCEQ=;
 b=D9jgitexPiZNIO6GMTwt3XjZplF2XlDJEde2TL6dJbQAK8jjl56Ke2uhHrLWv3mmbXiLJEiU5Wd05LRfAUJKz4NFDScMA105HAZdXI/EsPZDlrXpp/jNhScHXt/2yNpp/Ahvrjgvh0PabjMdleedwM4mj8+PYRmln3X6lIbFDDoTL1y4zFS3H6lIfcXtiW29F4ONIpMBOBYAt1vZnkopMVbcBj86XXFHUSsCCoog8WwFzUrTDEx7UFujlblXbkV1Fo0HxOEMmu5HxDPCalcyIXE/sqjkL3NlJzmGlNyqKdJPRoOV4+2v3GAHde890wdE4cLfeeHNiS44MViAkM5lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJITmfncZSLMhsWiYoPfe4b/eThvWxRFGNTOlkgXCEQ=;
 b=GPTw0aIAc50wxdkxGEVPvrbrs0aVQoQzS4u8J/iC8/Rj2IvlyBGJ0Hxvxt40nz/uxSQmREyhEBUpFJW2eYshAkjqJYQM/LzEghnamh/EkF/YdSc+Gre4cypY8sRHmXPQ4B8sn7NGCljTS6q99Gs7gheP8irgRJdhxxp7Uu+M04s=
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 19:03:23 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::11) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 19:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 19:03:22 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 12 May 2026 14:03:22 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: drm/amdgpu: Set correct DMA mask for gfx12.1
Date: Tue, 12 May 2026 15:00:47 -0400
Message-ID: <20260512190047.655578-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512190047.655578-1-Harish.Kasiviswanathan@amd.com>
References: <20260512190047.655578-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8272ff63-6320-4f6b-b13c-08deb0592377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0q39hG+O9ha27ffP4+2BlcaK0lvbkzu9a15wFr78DjbUUTJzI67oKor4kAehudjQ3VeiBUb9+WerSztOwUCN/KnUC7YvL0PR/3aAQQly0/XIWRw85q6v1uCgYOiLqX/Z9+U14AT7z3IDOH+Ax9uT3gRH6G2VRmnuyeTUbif2kmAw/82DvaIDEysE/cIaWe6wQ9X5PtWkBDGb/FI4zje6hQ9hc5BCgTQ9udBs/zLsi8m4JYcwQfdOuiFtQfUMAI1u0dwGJiNuGkw51di74h0KVqy2Mgqa2g6jpsvzYlyBGpSWSTzoomXL7E7Az/RmRxs9JvkXCfmFCbdc1piTuR3MMruUiDoFvZkhDBbgvYilviT1jrj6Vt0L/HmaSi9J2XUNjlnbAxHUm6vb/xfQwH9HCddoyMGRqk+2oByCd68mmp+ibNuYmzXUCy1HvoEYVFKYe7XLHemf0ZYa9cUR5q0M+rZqJ7ltKM0HYHV/opvKmnoIQDTNVxAouFvciA9JKOFgtBT73vCBO4ZMLvr3vx303C2IngDYGlRT2dh8jxhxypD2x8yzMnRLCmMKrbIPbqYDgI5T4idOww6ehS3mF59HX3AlN7phmFa/EaFd6y6D2KWQkxWdp0qCI4izFnMNyfqGKu7MH5+LOS4EaTiK/xZQZLVrsaAr9qfQ1F4Bdfr8vPSmzAlRW+jiJOCHeEzlFGmq07OfxCDFxS3fMb9RkvcUy4MwieO/tLxnxKv5yhqgMLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gyumHEuDT6qXTO4WzSULqxS1YWav/qRGxbsqSmtriJB5jJaOrG+aeEpf6UKHQ77f/RANm6KuPtpClTZW+5e/mGNIxkHHmynHdJjbd90bmAHnJZsVDUVizlDRXFwoqUHSouHzBxl1Y1+Gzq9vcuy++dn4vIWVmgqXDAb91c7fnLbyvIplio619zrki/T5buHB87HdYr0I+U7AcCyRzob/8uq2b9LfWaU/Iot/ZOCg0uIqvLPvR4xhgzBnK+TA8GN9nMCo+oTiczuNOmCIMsq7ckP0dnPTQR2yv5oqUKOOx50M8LFizd0gTDdYoTywiS3UF8BAQXikCxkW+KN+IPORfxE8q8Hpe9JyxlpUMhKX8mDZ+B5nVw5raS0ll2jMqU9QFwfohh1P0wFfRd/EoOvrwCSM/cBRPNER8OTPp1ZUJiYHSdzjCf9wrAOe0Lkmun8H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:03:22.6176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8272ff63-6320-4f6b-b13c-08deb0592377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

Set correct DMA mask for gfx12.1

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index a921e4c007ca..59603149fc27 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -811,7 +811,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 
 static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	uint64_t pa_mask = 0;
 	int i;
@@ -844,6 +844,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
+		dma_addr_bits = 44;
 		break;
 	case IP_VERSION(12, 1, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
@@ -857,6 +858,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 */
 		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
 		pa_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
+		dma_addr_bits = 52;
 		break;
 	default:
 		break;
@@ -915,13 +917,13 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
 	adev->gmc.pa_mask = pa_mask;
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
 	if (r) {
 		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);
 
 	r = gmc_v12_0_mc_init(adev);
 	if (r)
-- 
2.43.0

