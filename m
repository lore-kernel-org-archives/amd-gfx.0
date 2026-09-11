Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC68C88E5B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F6810F69E;
	Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JT1PpgkH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874AE10F649
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofz8sEwlvDPmghfu0vCbJWwyiUF+6IUqlK5U280AX7YvErqWTt1mKnxYXfdkBeUvoWCwX3sota8oqiz0hyN7C1xUKNd/W3zp5Cre7nfWmYwN35zGOCOtx5WwiHCXLHufqnFKr2xIjlzy7XXHOwecMrOP98YjraTQZdUIZmZz8nQwZmuFNBeW3lJaiMZUz0dgS8onYW5QXjnVgSIRaHxsvHp0VXq4adIzi2A9u7mTb07NahlK/r5X8KAMslBIVREETmb2EmHo6FsdiXdJmw1ayJqXLSgHmeH7I8sFAJgaFvlTlkU0oN+Ft4DtOy4RNbKcln0cY5DdlGHhFX6IsWwP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+dVTjphejXtKwA+tcS8e40PeWwAzfPxkey11/BGQio=;
 b=pzEX6rS89WDdMmJGHCKRsyIw8faV2lme5dL6JEqWU0jig1NkffoQBccApX9/SBr2CPW9i9bbdXUkGb99SsSXwiHSHRCOWtsX0jsahxDoh4Iu2fm48irZm9lzc2MuFadITfTQodrwtx5cgp1OsTrFVPUiRC1ZLmtUjsur3RSGqBS36N4G6y1lFVF0Ttoyj/6QpFCF9hFZVivLjaOIcwBUgURvDDegD/YyjpQDHO8sJlRq06wkrlsWRfIiql5dSOVll+swqq6dogRD66dmcdhfVjhp+V7Q3k9axkZMKr93BcaRwjuhdeTBC1jUsEtRt8YoJq9ttGl5c0ZcdJwPam7ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+dVTjphejXtKwA+tcS8e40PeWwAzfPxkey11/BGQio=;
 b=JT1PpgkHe3f0ov0iNTrWIDdsihItOE6YDZyfvKgW/pDVUAFKmW9hPtvORHlRNY8d3XuNCRawMidYdUipgI7KcVvXMo1QCbTvrNG7TXu6OZrqvBOfCX0sy7VCl1nwlI0ocbjqbweoD0k67JbkKj5CXT9Lexz23SiA7y0/YoRGA54=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:09 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::33) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/23] drm/amdgpu: plumb tlb inv method in
 amdgpu_gmc_flush_gpu_tlb()
Date: Fri, 11 Sep 2026 13:55:33 -0400
Message-ID: <20260911175544.1314467-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: a8356600-110f-4a14-f8d4-08df102df61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zP6gevpVDD3dBAiwxcGSmvd4f71hKexpZ4imPtaJas6fOe1Dd4fJEOGpG48hza5U94ZV8vydrv8a6Q9A2Nkr8AYnFYec5V8yM/QZXVODhh0VKoyY9WHkM2zKiEH8cn2K+Or+ZopFq8qpVN9M7QphPVOORThg1IPBVm5CKtOllIi1uN5mVfB7Rbj7WzK51+zvQU3caYIK9G5FzyT1AZ1EA2ZLPxfZGhy6o1Yw8Asl8AVoB0hPynCmcgKa1zVKe1gzpogM/2856vJzKYHtcpuIjp6Tt2XtxcNuLo5W5+ModC4jQ0/x/QyiBJjILM7+p01PVFxYE0Ml17dfBiubsg1imrCcIn0YgfHOZXPbf8bYtM+8kmwG/nubUjxtZyGXxKJHxl0utJLhShH1bdpLcX4q8RuOshx0KNYjnidFpxBi4EBR0wSz3AX8+yzv95t9bIz7k64C7srpcuzYmUh/UzB1FWYCRd3KP5f3CrsFnCskY7thzMYsm3V/dUCzSn0pi0RZEYxVc4TqcelfbJlV3dfH+jKydQCPuQNXjOLsN1+xfbQ63kYnC5786c/KYNe2bwRBzCZPr7zFQCF1YUKN1YhPo31B10t9XWK6uV+VYJH4BRYbFHb3l7Xj4V6BNphnsAgZ2Ls0diYuweABCVl9IQ4tUazkrB8H0Z3p3CUGOw0SHdIDOcMAc+ORYk52P8J5xaZrujEvxok6SBO2oDJyhQO/+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X8Qq2KkbjI7PX8pUXprco2r8Hxy5Voehc39ODVVT1cus6oB+IyokJbFnYE5y0MzYseGlM9exfcmeOL3RNbOClc4v/5pZ4amNkP5kBYPPdTGFSDVP3kKXykAT/8POMSiHg4934UhuN5HW5JPzqLiIXj9pwj//jgVaTeXSIjFgFHAV4VAT4z0I57/AlsxZT6nDxhZ65rSvMfwXmwEb9OYGupochqWDF+FTPhkKmkicc0ocfskOE22LPIoLKp3w52217ndlfiRgJfGMyux0hVRyvh2Jau8KWOKA3AtNQrHtnwM4/eRSxnXrYcasNq55mZzpLxla4Myyc1/3mr+PxOVQtS0JQ9dnwweVdusqYrynDI0zKAQC6VFWzERqvnTcuSjQs6bKgIjCFudK2xNZlgzRzjiSNjlWXwukCNbhGuHIyEmEz5d6dhXLTM1pCyg6tyA4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:09.8071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8356600-110f-4a14-f8d4-08df102df61b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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

Plumb the invalidation method into amdgpu_gmc_flush_gpu_tlb().
Keep the current behavior.  No intended functional change.
The MES/KIQ handling is an existing special case of the MMIO
path.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c05545063346..4acad329aee5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -719,15 +719,27 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	bool use_mmio;
 	struct dma_fence *fence;
 	struct amdgpu_job *job;
 	int r;
 
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
-	if (!hub->sdma_invalidation_workaround || vmid ||
-	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
-	    !ring->sched.ready) {
+	switch (adev->gmc.gart_inv_method) {
+	case AMDGPU_TLB_INV_METHOD_MMIO:
+	case AMDGPU_TLB_INV_METHOD_KIQ:
+	case AMDGPU_TLB_INV_METHOD_MES:
+	default:
+		use_mmio = !hub->sdma_invalidation_workaround;
+		break;
+	case AMDGPU_TLB_INV_METHOD_SDMA:
+		use_mmio = false;
+		break;
+	}
+
+	if (!adev->mman.buffer_funcs_enabled || vmid ||
+	    !adev->ib_pool_ready || !ring->sched.ready || use_mmio) {
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
-- 
2.55.0

