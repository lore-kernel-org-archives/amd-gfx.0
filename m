Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E97CD8C85
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 03:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1D810E071;
	Tue,  9 Jun 2026 03:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VcdT0V5j";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7ABA10E075
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 03:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG6QooE4IdH3v/MmR0jfL7wuuF8vg4igCCahwhOw2NqyfWj+CZQCqlN1XKvuAI5lHtnFF+1UukYIHswaHMsXXYRN4kp0mls8gSfYIAc3yYNPKihEZb/s+odhn+rlcCKZnLhPoYxuQPPyQc4wTwzkxrOZ4HUD4JRyG2Ij0YCKo6S/8uIad4SPUmqWBNMZjkuxxNm6n+ONno5nJmRTjbkm4ve8oR4ulq2UdTuS9lOzl6u85obuzPXBFPcKlms/ZDwIW5olDKu/3eASLDImBN9t+CxNWECM0nDwIQAoZ4zwwJRkedBQ4rzwFO2tWnu2e6x1bER1X1LP4FEBtCXMFdzsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoSzs+ialsfsxPzkHARGoRfxyUbYkK64wSRZ/tEI/xQ=;
 b=JkhiURtJYCodVseL8k//7fxSny9veklMJh0RFC5rSsbi6d2kv6NVeWSYP+z11SUAktEsYArfjUj5IJ29XA/IVeKpWDMirRFrwtDHzfDVDGyouV4EswHhpbbCecvBcX6S4aSfnE03OlcVanpkCKsjUmM2LIWqnlRHNSfzt8is5Ae+FADQov1aAgN7TQPF2onoSwT0QDQKKUSmV3VJ24UOEMFeUm27zvm+PYdwyC0ffCTcYrAJh02F0jV0iVtZMpydorHKwBJDsHrvjpynPWMMBaizN8cbjc4w2PzqDUMhscRv3OP1qr7Iz4Jfk0XWmGQw33VLDWNxPMeUBlzuJMfx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoSzs+ialsfsxPzkHARGoRfxyUbYkK64wSRZ/tEI/xQ=;
 b=VcdT0V5jKq5hDUsxQ8Xzt0dI66mnXxN0eijFpGxovKS7HNJTufyDWvJKHatfGRohcWBwcjK8N0vBHovC2hj/Ph6k6lK9lK9oSYmvg4gIlWgDkg9OhhThrb2o2Wvo1YA+2jUHWDwjvAQkl2N2QzNXBZG7e7W+LWE9g5jAI9aBcNg=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 03:39:08 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::8) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 03:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 03:39:07 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 22:39:03 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
Date: Tue, 9 Jun 2026 11:38:50 +0800
Message-ID: <20260609033850.1672695-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa242c1-7018-4f82-05ec-08dec5d8a8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: mEqPwooqxyDH17wD5Sz7JeA/WzhkemLDO9Sq6V99wQqBQOUwL/AsScU97z2Evcv/OuTv1tjmifZ8lFXNSUStgIPZKJw3AGJZKm7Y7CPSf/I6aFhfLmCfMZtQKiN8kCgiOiqY2hkU0ysYdLANWLpykknUizIJcyfkWdFWOxNBJDhYuyF9TcqUOw3lTeL2FsuKgUK8OrbJ0sAQWUE+2SypLl/1pmTYw99QT3zOGI5rchUSZZ1qDOHOKnes/zdGxoe9IbdhQPpfZW2MMKXxP9XsObIKA1bAUaa7frkFmpmvzux9S9thguNJpJq7S5QIQ9JMq5/8m8xatH13hmXbjM3D7oA+sLnKB7qK1ceBgkoUUjJyb8WqG+T7MncVJrJTwzX7Yczhfua0s4lagiE4HB++O3RG6v+iZLygKPp8RWgCYlVb87HH6kzOXB9EoQzXL1OCv4rSoZ1GkH7q3/E4h4q9K6CBcb6yhFHTWRoto5VdS/ZElqA7dIuuzopH3jBmgREwbSihjDismAoLosm27Tobp5nGCljvZTNajv/7cgK0ucmoPGsk5C5as0PyiKvSSvCFoaZzBtRQ6StiW8VuH/rkGqG3nG+P70QGPAHor5erQzBfVFNG/zmFmrFEZHR+bJLtJDTyozI/Rw6uIYL39qTOca85hhbflAQYGs9CXFvZUrvkbfCjchRpCRGbp72dxIuefRsjQRx/6p3J3gNatY5MyS+awNjUMptk2x6vCLv95Kc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5yPkcK8V5GNZwHV95rlHuvRGqCN8n5YN5dGHmCi3MYLvmts4O1ttmPSs25r9tCpa+D1hoRxJQntcIjbcBkbNyzZ7GObvuJAKynWvb66drki8nAB1dEXVx5xB0iDZ8JxGCBiRmlAO50N293zjpPS31f47vvwAXOoz5AkXF10jU+CA+obmArXYaZt2kdFSM/7B1wXS7XY5mKDDnQ2CqVLLUESPWm5YmPq3tJHjSzQ8ex8Cpj8+dKxgZ9OS5VgnvlSK8GkqqBgTz2GMgq/kAYD7Ex+pKmi6jW8PF6vP91oDq6b4a8TPJzva3zAba5KEooNmlzSxl/qHllvVMvR55xGxlCM8x1e89909nAMX268z8GSuU1jEhWFaoHEQzSAD9ySoYlEPHbIpxzjcd+EEyGHBNYxJteGz+bs+IJY1UZmglOqTXk4wmdbWbpq/WB3/50tp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:39:07.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa242c1-7018-4f82-05ec-08dec5d8a8f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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

The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
kernel page fault.

The IB only needs to be a minimal NOP shell to schedule the job; the
cleaner shader itself is emitted on the ring via emit_cleaner_shader().
Fill 16 dwords to match the allocation.

v2: Use ib_size_variable (Lijo)

Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ff5a55f5f3c9..bce1acf197a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1689,12 +1689,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	unsigned int ib_size_dw = 16;
 	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	void *owner;
-	int i, r;
+	int r;
 
 	/* Initialize the scheduler entity */
 	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
@@ -1712,7 +1713,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job,
+				     ib_size_dw * sizeof(uint32_t), 0, &job,
 				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
@@ -1722,9 +1723,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	job->run_cleaner_shader = true;
 
 	ib = &job->ibs[0];
-	for (i = 0; i <= ring->funcs->align_mask; ++i)
-		ib->ptr[i] = ring->funcs->nop;
-	ib->length_dw = ring->funcs->align_mask + 1;
+	memset32(ib->ptr, ring->funcs->nop, ib_size_dw);
+	ib->length_dw = ib_size_dw;
 
 	f = amdgpu_job_submit(job);
 
-- 
2.46.0

