Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7213ECD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 22:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19D511AB88;
	Fri,  5 Jun 2026 22:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gSJQZZd";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895F111AB86
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 22:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtaHyzaW/T8K9fBhSA9Mi8Tp+TWofDOl9cg16b1E/Q4nzgxN10hATu41M+rHoNkBknmhudIPCREl9rp4BvKbRTOZidt7rZ8vwEg6DHmFSOBng9FGRF2tS3jgO0FdAPZlOD8iE85sFA/uXY5HMxefX2yvTNs8eAGx0OMnJ4SUBn5wi4adGd31+Lq4mJ17LNn1XEzxGcPig5axXlAg4KemJYUTsZAeg/xzK40r+piGWilLA6M7ceHyRhDdlDIHPD95g8t062Ok9XRM06roShuF08u/bUfEzH24C0wT7F4XmM38NaTzzsqBSUmJ2YuhAKqO7ytMgE56VWtEG1lximDr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyrdY/QPzN75CDx1+XGLImVXnTKSPjeaK2Rw/Nlq7sg=;
 b=br3nUDUfxUyUPaa4PPkmMiJGCRNS0hqZvPuRAvSe4jeuVNk53ivA1nRUIJjJUx+2oS9UQ/wG6KUmX+E4l/MxDAZjI6+v0unbAJplwI6u1lwivRcceUctcsgP8ImUz6gQsJsN3PoA5X8diCvfQ546txgg0j/R9WUpL0a0brcFQeeAivbnIoCP9cPbrVfqKqac577R17SKXVhyMXaJ9aBA6tsKH6fX3/RNocDAE6WsMIRzsH308/7ELbgDtW8ZURb2xuUY+UWTKlbXRMz0AyM7qJrI37l+zCjPfntX8sMclBYub7NEtLZHW80YbZFy94496e6RSic2M3tp707V1qbVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyrdY/QPzN75CDx1+XGLImVXnTKSPjeaK2Rw/Nlq7sg=;
 b=4gSJQZZdBroiZ8z7+XPc77xjOFzZJKyeOuxPmbhfQuo1KTM7xkXedubVagX5WYOpg7QvQ8vp/NF0EsZXyZkmE9ocEe70xPUv07kLLEZHsf53Vj3EopSc1yUw5BgKSgaBkH817y05jylr66F6A3+3cmnx6z26xtMWmMZaCiWzEtE=
Received: from BL1PR13CA0108.namprd13.prod.outlook.com (2603:10b6:208:2b9::23)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 22:19:06 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::9a) by BL1PR13CA0108.outlook.office365.com
 (2603:10b6:208:2b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 22:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 22:19:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 17:19:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 15:19:04 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 17:19:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <timur.kristof@gmail.com>,
 <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: always emit the job vm fence
Date: Fri, 5 Jun 2026 18:18:51 -0400
Message-ID: <20260605221853.903153-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: c184f04d-5e86-46f5-72e5-08dec3507482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JBj77shC41fEFgCyRoy2p3VqvA3bYlOuY2tYknt+RSwQ8N1A4rfda8fXCuaO46dor/uZWNRqCkBURp5veMqM+giTc+Oyiazcv58lS1ECBRO1xqZ44aEYxIv/r+wg4o3QBG3/fV4WERU6dHtTStJaLVXJWLfZj+TEG0fP7a7Lagg9phPf9DQp6svW6D0c/4R5YGp6B3U4OcSYUWEQ14uVZpzPLn6iMoJ5vrme1DVTWVN836JIG8vxuTXsbotIxhJn+LBRCTaCGreK+KrocbrKosqukd4CB53DKeNQ3xipk/GeJ+KcZ7Ur06yaUEWZJ1BwFSNVjooohnj+XwelGra8o5qhrNv/YXTP3cyebk9p2kZUqSQTz0gGQGK2e5V7Uzso3Zq8nJywuLj1hdnf5gmrYuDcatUt3FXi3iY7nTrIeP/+hf46Vqi1l+GEuNWWWLUkyYdTLkRr73XzKNgK1DiBF7TjwS+5tle3/UNBmrN/MFbKoXJaFOIz4V4MswbLeXKrXxuQ/vt6MyEIb51kEpNLQ7azgW18FdVuuVnQQUvD7O2mugRCpg0h03S7ssOoQKtrNs5id+GQDfou2JZxh2lTrksW9/MjFoIRxmrIsr4GyNpANY7WVEvZeo8gbkpmqH+Ju1ICw9iMN734+z04QuSW9Uts668+3kxiQng3Lpt7mAaPzpYU//Inw86og5T2qtwh0rnxbdrcAbYysgBZk1QUbwuOuX5jBnIsIIgEYam7w/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z0DwDaQCHvBDsh1qvzWhUBEYvL9Q9tn6gk+8aDxuxC/X4JiN8PrNK8Lk16Zrv6/029WdhejwgA4c4PyFioeJZBKrwIhgmBqOglsXTeerrQQnl/LdVeV0QtUzf4VijSfC0I8uP0BxBmzKZjTaDkPY/BobnGojN3wzrp0YOgufBoXzz0JBS9VNtTXEkfezos01LevRnyXfqVQBO3DophrgIkhTT4orZjAhQJbWfGl0/+RdflHSHU78M3SC/hUtPVdqAjD/Itjd6Dk8HZEm3eieLrs0WH9vRhXLSXYQ9Ir9rdWUI7A+Emrq+gi2Hl28k6xAH8RmLei8aznNv/Lpx6/mUYIVHSazVX/ynI22VdXedTfoXOogjp0K5g5uclj85kMJGkXFvyclPmEsjA4hSCF6cX15vla8G7a2ZAvCX37/bFpxbMgiCgC4iEZy7UmCa9IT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:19:05.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c184f04d-5e86-46f5-72e5-08dec3507482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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

We need the fence to reemit the gds switch or spm update
after a queue reset.

Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v9")
Cc: timur.kristof@gmail.com
Cc: christian.koenig@amd.com
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2f3470208829e..7e0e2281719b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -853,12 +853,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 					    job->oa_size);
 	}
 
-	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-		fence = &job->hw_vm_fence->base;
-		/* get a ref for the job */
-		dma_fence_get(fence);
-	}
+	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+	fence = &job->hw_vm_fence->base;
+	/* get a ref for the job */
+	dma_fence_get(fence);
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
-- 
2.54.0

