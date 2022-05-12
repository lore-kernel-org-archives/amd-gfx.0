Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54018C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA9C10EB13;
	Thu, 12 May 2022 03:09:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3EE10EB13
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1vGAquvQUDw9zeTf6Qq+auM+ODtMzILl6UGVO4WpgykXmjlvSDyPQJoyK+pW8q73LRYFVlveRgPyp6w4jbFpHaxSnimZb2n5DEVILscWCsZvDkWRvtos9Y2xNLOjTddGcCxQQ1rTHiC/gMGuTmTg2UmEMhZivM4j8SyfwivnWZD7qZ/VtjRDJx+TOqYE40jtPiSi9mnMlLTyHM1WyORfEbELmr5rLs6HiTVornDxUpjPgghATcrhwiJjBN4hhAj9jLMDWyZY/sBcATgbn0tSguCXiXFp/svURVUBdVwFRs7MHyf9UKTN/IqS9rus0eHOHpHE6nkECxjcZhoHH5Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAtA6VcfThK2gwcmp+xuxyWi4DkjiK7r93yQZd4CwHc=;
 b=Jz3banmdNLUulWONaeJQV/96ishcbUHkoBRsLFrLLABCC2Y+ChKucJAkugBp9AeGf6iL1OWtMgN8+4uRMUewLryFdRCMpbnMH2Gexow1jhp+t5HBNShalrli5Ch9RxAM04qT21f0Q72HInS7h0qMqAu1nZAhzFkQVjEW8eiQv4peHteDMZZjLBs8LYHSYdxxu1/Kjcn9H03DEZfRTt64sHW/50hgVSRurDKSRQtT+lptmE+UqaRpihkpCQn+Ivp2lLvFgCbBTLD8Bg7ZlrJs8+sgPssOE18CBVveA97eePWHkHNMS6DxNghX9sNxWXsO4dS3Dr28ry5UfzKr/08X+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAtA6VcfThK2gwcmp+xuxyWi4DkjiK7r93yQZd4CwHc=;
 b=3XjXAIUl3zZoSv9lDQG7OII9qSvEtQPxdO/Rm4EtwC0V5xi0JFCxPP/LWVeufcbksfA9fuWPHZqDMUR5SpbelYOfpSxXUtoQpGtwEZ8MhjCEtLg+ZbmmMSyl8SwooVWupXYjp8ZhKt5F2/54IW/7fq3Rv4PjUBu536NIz1R2Xxc=
Received: from DM6PR14CA0066.namprd14.prod.outlook.com (2603:10b6:5:18f::43)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 03:09:14 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::f4) by DM6PR14CA0066.outlook.office365.com
 (2603:10b6:5:18f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 12 May 2022 03:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:09:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:09:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc11: avoid cpu accessing registers to flush VM
Date: Wed, 11 May 2022 23:08:57 -0400
Message-ID: <20220512030857.525411-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512030857.525411-1-alexander.deucher@amd.com>
References: <20220512030857.525411-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 969d203d-c64f-4b47-2193-08da33c4cb42
X-MS-TrafficTypeDiagnostic: IA1PR12MB6282:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6282B746B65D5C152A7E82B0F7CB9@IA1PR12MB6282.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/34HdQcHREYULkm0wW+qOONCQ3ZxFrehELslJNIR90MESogxme/WaOweOF4CtCYJQ9Yk3SGtAl9FfxsIL6deMVrAVb6KlhIFmTWQ6qegLInJoOyIw6+e+zNjj4ah4GiQhY9OvCX8FGwp+xL5H9KWtXUPx3NjRiECuRw36EtgA8obGVZHaIbxOlZSLWGwVbX3eArOVnzP0v1oEOE+tepqlvLsPUSQ5rZ9hZPcWH+teLRYoATiGip1DgoWDL3jv081zQAUAGksTq6C3QYTib43s7pr++VWXTud58Kn6eIQBS4c0EiRFjiXD4fq5Y+GGwS4MAAd2PHG44L2CzxjckWYMBYnPNnq5QuaAO6HjTg/WZEDEYK9NMVOTDSYHcJNcYz1Zwkzmi9JFw+xF1HOrcT0bPkcNXEJKxCwNlZgCjry7PVlri78RHNZwMSawiS3ijFo6NEhajRPYFJhqBEzW5E5vvXGhTzAgbj5aJkJUw/DFA7wMV//jZeHhvVGNqKfrk8eSgnE1RFanmjqB6nAmKAlGDQtlr2/JOikKNPSBSIUZ8GaYe/XJKQF9dpos0+lxUv/touHC5rrSG5luxtIAlfqPAWJ1bs+VOZ8irLRpf4VoG207eoBfr9atGJOfm0m52Ww5yCFVenvqidd4F02MHWb/1FssxpIaav8RM5+/6zPj9/Ky33hm8JaVT/yAGNVsa5uTys5W6/NlEiWnj3rP84AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(2616005)(1076003)(86362001)(316002)(426003)(336012)(82310400005)(47076005)(16526019)(26005)(5660300002)(40460700003)(4326008)(36756003)(36860700001)(508600001)(81166007)(8936002)(70586007)(2906002)(70206006)(83380400001)(7696005)(6916009)(6666004)(54906003)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:09:14.2124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969d203d-c64f-4b47-2193-08da33c4cb42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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

v2: remove bug-on, fix the vmhub check

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 49 +++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 477f67d9b07c..63f3fc0a1e7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -258,6 +258,12 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
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
 
@@ -281,8 +287,49 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	mutex_lock(&adev->mman.gtt_window_lock);
-	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
+
+	if (vmhub != AMDGPU_GFXHUB_0) {
+		gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
+		mutex_unlock(&adev->mman.gtt_window_lock);
+		return;
+	}
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
2.35.3

