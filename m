Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F30C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E0D10EF0A;
	Tue,  1 Sep 2026 20:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxYeZdP3";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 462EE10EEF8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3sDy/bu4auSw7sTcncP6Avwg6fAddZXK9M5WrMqxHPwST30IspjfWOsSauha5mHCjxXP5LanKdqtvdcsXUcaW1XaaXhfdCcwBdG+ASDS3bsCR3xjj4RiI1ijz4i1hqwJM8b2qZPXcO/alNTzUIaMQV3Zld8Wpmb7wa091hVSqzH/Fdnx7HGbNgMsxYu7qyATiagOkDrKUl4HC2khCoR1DPmqtU4eMkud6nIhC/T5LzQ3Q4FOqbsuQVzyj6+1T1Kwyn+IiXUwLt5ybnjeDgaSiZG+5l9AgA8PhzXa7ZL3OpNnCK/32GSIKxAyAz40ERm3ISeG69HlMIU8C+6fE5EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El3hYpMhTzo6K8vFpcD8Dzs2kzlTq9yJSbRUViReiK8=;
 b=pdjSHu4LIIT4DcWdael2kPvkwXBqnyGN6t08ilCpqjWnwB0XMKMWSjnCyAQPDhHHRLIzHMx8MN/lObUD4gx4GAp4eMdikMfNeD7r/qjy79PK1FlbyPiCawwYN/CZye9Yn1AOp+xtY62oRRa5NAbWJ2YzLdXLIlpYE11nRclQ8y6ezcEvs90QZW31opJCmbEq8ClcopBDrw7k9SeFND0PAYi9ra32JXhXma+F0eE6q3Cs5B3KzcjPBAgHnfdg2IE8u1WhBqw3X9VDoexHDYRhow5PacG32IBUrl1E2k+XKdbjclOfvl2hBFbG0C8VoVmEZUUavuiGT7n2QeSaKJRMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El3hYpMhTzo6K8vFpcD8Dzs2kzlTq9yJSbRUViReiK8=;
 b=lxYeZdP3nlsXL9ep/7PaOoE7omKYw5UOjb/bseFdESh71jhLJ6VEYu5+va/U8tk9FgikJZkbioOMGyxuF/I7g9sCn/aDoaT/nu21WLW1xFh7UnS/O/i+6V/gOpuOEe56Ez2i581qVvcDi2cxBUz/gMsaY83KMaDaVJEF3DVW0Qo=
Received: from CH0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:610:cd::35)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:05 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::6f) by CH0PR03CA0120.outlook.office365.com
 (2603:10b6:610:cd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/31] drm/amdgpu: uplevel reset check in
 amdgpu_gmc_flush_gpu_tlb_gart()
Date: Tue, 1 Sep 2026 16:10:22 -0400
Message-ID: <20260901201034.2960437-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cd1a9d-b74b-4a75-5c50-08df086526e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: R5Tt6/EfWuI2qVy14rOQwajiz/43CubummghwaRKH+5NafBXdkD/biR0J8yGUGFxCvyurMeWwi9tuz71DH2m24PxZ0h7BKDt/u0diKLXLB4SN5df8GdiC9gmbqPYN1geqIX4EUJvCUuOY+X4dN6KyWEXVjBUwt+y8EApoALnKOaWIjfwHsyz//OjNMjsBjIsERL6fNrwsimrdRZeTj6JQt6sFWUF+OYsu3xgYk306eL93mMr8HfNcehKQxx4tPIoPn8iBpfWzFdDiGilv3E2iQog3Jfw6L8lREK7OwcRKRRfrpxk2kgvBacQLjHwTzG28SIwr3Znp/4y6e/eVUPYHJurNNxC7w/gFXId0Ybn6pRRAp/cVkwkPtwiII5BEg7pOY02Jpzljy7VddBBQI1AT+WXQp1Ke6SEbausUtsM0wPhXFWdDX55Muc/5VGDFuRDPQYHpHJeyLGDXPwFohdKVxx9qDH1X18RVtos2x4rsDLDQuLUuazRsycLe8xc5p7HfmyIn2ByoNzCuQvcyd7zJ7BRfiiVEI8oJTGTpevl+DSO+CuJYDigINUHJV0aU2GaHIOLKh9KSYe5VKOHVp70gcB9ayIuBO3eKlkIB8p4unqxEKqf1ub2Rv/mN2IYfD0muYQ51fnFo6Td7TjIPPccaYqVaccsTayOzuhneFV9F0X/wiQ8pz5c0VjjIyjnoohvLYsVAmSW9m1ukWirbgexAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1NczizAiDCGFUxCLWKEszl5kWYZAOxmVJCV7pkKRErikEvGpiJwlXfYOmRREEw7hFStcJU25viKD1OvNYAig/0iSUwCv4cdAvbbUd3ENzyh4FXAVfKGnDxkHRozfri5XttRWer2Kea4jZ98inP26DOO7v/44Ud8e9AEHRNrGdIkq7ioMCkzgbJhDHf5HR4/5BDdj4ctwSonGNf6rsKmQkycTCT/PC4YQq9M7F9dw4ZWKgMHKIgqI6NUwwAdo3eCiI4Xigxc72eeIklY1e30lDPKhuAaksd8Va5TWKhKoXm/uKIOVkDvsIt9AuVch+d36OBJ1Dfoo8Xv8DdhVvMFR69Pr6trSWL0kPoHGrD392ZZmgRo7nTLrqQUro8oPyXkzZCMEBx/sZBA8we/CoMeruo8uuN70AsAleoEekNICLqqkjohRhu7UYlv8bt8lfcxe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:04.6362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd1a9d-b74b-4a75-5c50-08df086526e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
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

Check for both the MMIO and SDMA pathes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 779f9b0974d2e..8a975eddd75c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -724,6 +724,13 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 	struct amdgpu_job *job;
 	int r;
 
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return;
+
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
 	switch (adev->gmc.gart_inv_method) {
@@ -738,13 +745,6 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 
 	if (!adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready || !ring->sched.ready || use_mmio) {
-		/*
-		 * A GPU reset should flush all TLBs anyway, so no need to do
-		 * this while one is ongoing.
-		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
-			return;
-
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0,
 							   vmhub, 2);
@@ -778,11 +778,13 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 
 	dma_fence_wait(fence, false);
 	dma_fence_put(fence);
+	up_read(&adev->reset_domain->sem);
 
 	return;
 
 error_alloc:
 	mutex_unlock(&adev->mman.default_entity.lock);
+	up_read(&adev->reset_domain->sem);
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
-- 
2.55.0

