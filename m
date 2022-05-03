Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4244C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8313710EA27;
	Tue,  3 May 2022 20:09:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E26310EA1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfVBTFaCpEiCD2HjIkpwgI2euHR6p7KTL5QhCrsoPuzqLNtPrQFILfZKNpBA9ISVuRBp1HIYGLUBM7JmPtr16DTYewIkhVZg1OkZOk+OHHDsI+SwFSR469ZDOUJMexoCqXnD+ZUC8q8Pqd8GAUec5F1AmC7r2VB9svCqMPfKsoNEaFmpC9S61x8fV4HF6MV9s4x6rIb84LZ14w7d5x3spg+Wv/DfjCW/3vIFzYOPM/JclB1e0lXcE2SVMQ0VeG88Snlhp5YxjRyTOYQJPl5d/t+tZJLI9zGNC7YMvg/drmbAfs7B3LEFYGu3KICp50n2o1Ppu2T9lNqp7wR3Y1t5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huc+BI7vtj9MB79geBF7TvmIW50kNmRf9eNW+VkGcp8=;
 b=f1SbkZQLbPO5/1xys8hKJ30IN5/zbIv0V80IqAN8kekaa7dZxIbHd2GlHe0zEZTdJrU4xA31OGa7nF8ozbzUaZG5q3JhMuENOVEkFqW+lJp9eMAjyARF51G0KShltLFUDvDpqoRlJ/MAHP69EHRdJpNryuVg1lu5974SWR92UfuvUaIaw4XPjR9zHNteNVGJ/YRSRamrxK7KB/sMYrVZfKZU1xrJ2nFEZMPjxNHVLAEuujZnvOS7gA/ej93iZTC8CrN0DFOlVFN7wBu5kspySLtVIV9f25JgELSL/OCeU79urygQ67tnjykJl+Jiyy9DLQNyBZ+rmn0IyBBr+bavzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huc+BI7vtj9MB79geBF7TvmIW50kNmRf9eNW+VkGcp8=;
 b=bqaDLB2UWB1d0jTG5uMOo3ZS2mkuqKRa1xiLsw16HX+4FB7FjzOuw4+ab7GOgMTx/NH2B6ehy7XcF4qJS9IK10dMexY7Va7V0MeQu5XzcsssEYlKA267wn6Rop/+wd2Y+RVQoekOIdFABAPpvHXOdgGyhPNlzLqS9u1CVaXU928=
Received: from DM6PR06CA0050.namprd06.prod.outlook.com (2603:10b6:5:54::27) by
 DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:09:19 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::96) by DM6PR06CA0050.outlook.office365.com
 (2603:10b6:5:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:09:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc11: avoid cpu accessing registers to flush VM
Date: Tue, 3 May 2022 16:08:47 -0400
Message-ID: <20220503200855.1163186-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa64aec-364e-494d-a03f-08da2d40ce85
X-MS-TrafficTypeDiagnostic: DS7PR12MB6264:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB62644DCCF4EF5ED58E825245F7C09@DS7PR12MB6264.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+JrpG5/0RMocGJFsWCyiWN3+AXOQ29hFbECMrC6gfwLg/QtlosGtxOyIyqyb70eTwqZJAthw9hYqk4gWEg/W543/C4kc0LPkO6AxosFHjRUdiXfhrSl5NK1jsKqdG/inoqIi8NW//hOPSKItq+OMvK+dby5Y6VL2NCV1cNPEGZhdmPVb5Mt82OFyLh6SKvcwXocVdJ1ZZDIlPv4AJ5Gj2C+ny5+5PQJhhB9o++ZeV9lrFqvGcFrRji0MPFkFxZ0d13fTJJ126qhUy2/pR79P4gDKgUYDv52Eu/arTuj5fyDXqbH15tfLZDBtwZfyiJm1sQtZLLNL1qQhdNuwXoXlWH1K1j+4vi02m5eaKLDBlAt+BzFu88hZlUV2wBqraIpf4CxSd39QtT6coIYDSnCGnxz9c/MsD8ZjO5kxW66lslIjwQWmHI/IRwJ+auCpY7yXJ0IGjAvU0+7zvl6ryxrgqjtBlaO3q072c/+oDpPKmjzOEqQE4qnojZevwEFKWI5egGEK2Vgj4NcInKe8Z0PlEMUwCFtqir64b0vbqjUCfod61LLk0WfWhfypvDbxI+viGC/NxwBCToeQ57d+5FBdpWHKMcw7+fpV05ZrjrgRg27ftMCUQOA4Eo2PtIWuOXkapAtZkmzV0OvaEDuvW/sTawcJdDwC5nx3AlTKElrNoSCZ6OBB65ze4tTRcfpSf/jpI2NIpF6RALiwlGk9yJcmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(336012)(82310400005)(426003)(83380400001)(81166007)(26005)(2616005)(47076005)(40460700003)(356005)(316002)(86362001)(186003)(16526019)(36756003)(5660300002)(8936002)(1076003)(36860700001)(4326008)(70206006)(70586007)(6666004)(6916009)(8676002)(54906003)(2906002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:19.1273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa64aec-364e-494d-a03f-08da2d40ce85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Due to gfxoff on, cpu accessing registers is not expected.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 51 +++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 61db2a378008..032414d7429d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -265,6 +265,12 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+
+	int r;
+
 	if ((vmhub == AMDGPU_GFXHUB_0) && !adev->gfx.is_poweron)
 		return;
 
@@ -288,8 +294,51 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	mutex_lock(&adev->mman.gtt_window_lock);
-	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
+
+	if (vmhub == AMDGPU_MMHUB_0) {
+		gmc_v11_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB_0, 0);
+		mutex_unlock(&adev->mman.gtt_window_lock);
+		return;
+	}
+
+	BUG_ON(vmhub != AMDGPU_GFXHUB_0);
+
+	if (!adev->mman.buffer_funcs_enabled ||
+	    !adev->ib_pool_ready ||
+	    amdgpu_in_reset(adev) ||
+	    ring->sched.ready == false) {
+		gmc_v11_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
+		mutex_unlock(&adev->mman.gtt_window_lock);
+		return;
+	}
+
+	r = amdgpu_job_alloc_with_ib(adev, 16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     &job);
+	if (r)
+		goto error_alloc;
+
+	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+	job->vm_needs_flush = true;
+	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
+	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
+	r = amdgpu_job_submit(job, &adev->mman.entity,
+			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
+	if (r)
+		goto error_submit;
+
+	mutex_unlock(&adev->mman.gtt_window_lock);
+
+	dma_fence_wait(fence, false);
+	dma_fence_put(fence);
+
+	return;
+
+error_submit:
+	amdgpu_job_free(job);
+
+error_alloc:
 	mutex_unlock(&adev->mman.gtt_window_lock);
+	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
 	return;
 }
 
-- 
2.35.1

