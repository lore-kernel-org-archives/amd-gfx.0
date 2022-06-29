Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE010C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C8310FC7C;
	Wed, 29 Jun 2022 03:22:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3750A10FC7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEQEtDK9mVqfxW38p4kcUWWZPHmpvlA/JVPU2CRzDQIIFkfqjFRm0Arsk4IOVEvbdSRa7UpS9HGTjyN63WRQtb16M5GKZGNqSDncyYR0LY1LLy3Enkd2dyehkTKSatD+JVRPhkNfyEWh21ueVnFlUCfCfdFj0rtANl3b7wiWc2Mun64qoyTnHDbH0Er3uieU+nZ/99oLFdXNZXrUJjSiN71DbXfNLpGMNGcBJGSVqLJD9VvkB8QVzZfpUR+N9tQUjciWIXSqllkWZM0eQhigljEVy8EWh2olvI1s1BExBW8dMmxZxQm9ewBsI/hfeBqqJP7WBMBMdxk/0DzkCGN8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2Lo0ZStHSIe9UuqfcQ09OOsH2Lq84lWi7j7byu4CtU=;
 b=jOGYFtFTKiWTfyULr4wYWo1ie1xAVJ4bvHaYLPVC4Ytp/b/Io4r5NHLenF7uZ6DR+9LuV9ujhhzsByKuvC2OiN3uLDgMMxHsayL2Hn9bKZMWYIvNPfiv9U3BSzJkAp9hqjrjKp3LEo0HamE6bIrMQNRyZj3CqB/7L0bTLezAbeqlggS1XzhQE5AB8TOPoFQpWbwazd4GS2kEvdRnTx4OTld1HMKqMB6fvGtxC8ECQH9CUKP2W65cZRwrffj+2MQJl81A2OspWjHBVkseaxvzs6ZBOHQP/E4lhqouhLpnVHaSplSDePiAf8ja1K8TAp+rXV917ktF6bSRAsvT+BoqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Lo0ZStHSIe9UuqfcQ09OOsH2Lq84lWi7j7byu4CtU=;
 b=wT/E6BZwYG0qlVLUsnjH/18PMEXzG4fSy9dIctjZFpECnjZecjdTyig6GnnrV1B2BiZUAWMSLILe2OTplaT8r6z3YyG4sKRTlG4Q7sIMPhWXXzs6Ct7uBl3LXVZoesTLe/cIqjF6e+aFoF02i3JMNgXnChCgrs9/4MR2p/ISdd4=
Received: from DM6PR07CA0106.namprd07.prod.outlook.com (2603:10b6:5:330::15)
 by MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 03:22:22 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::10) by DM6PR07CA0106.outlook.office365.com
 (2603:10b6:5:330::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Wed, 29 Jun 2022 03:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:22:21 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:55 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] Revert "drm/amdgpu/gmc11: avoid cpu accessing registers
 to flush VM"
Date: Wed, 29 Jun 2022 11:20:34 +0800
Message-ID: <20220629032034.2994328-7-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629032034.2994328-1-Jack.Xiao@amd.com>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 990d1126-c1cd-4968-3c9b-08da597e9481
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7kWjM9jfviJ80z+3vytEMef9IMxpkGODL3XpaVZK4J2gISxNPfHznuRa/prnGLteiObpImq0aQLzfIE10rHh/4HGWILJOS0n9wuNpFwwrY+qEcm66F0KKg/u1tEjIK0mBwNq4ONsXzNs5XXdJAiZ6Ia08ivRTX3JmkW/ozuvIL3aYc50W7W3yWOaM5SsWqfOgucut1d/teHf/wl6QIbomfY7mlyoDDc8h/j+OLULVempNDO/ZxKDHe5zafqkK9n18GqttNiBmRlxuM1JroiYL9eI+mJKXBy9cnPHidEGjHjscW4Z/AjtxV7Ew0Oy2FxDOYHLuY8Y/2EKqO2qrwSeclgFvkLyaGW+DiqYH1XdXRQ9xsERE1+HKNNx6HXdhC+z7PDbUaVcgVchQji0KGNKd/s40kj51CeJ6ZLkRtM8uauIC8913byzFzmhEwxqhwMUDntEO0vNFAN9sxoOK50HSl0OVmPxPKSJ0/iluZyfVBh8LrEfV83QzzbbsEOvGAF3k05VMgAMIl1U/KS9V2BH5Yo0rxWDQPXOJQ+g/q1+yXii24+VTDWLkUJpztLS+lmLDy5pZ9mb+ys2YPxJB5GUIc/kECcS002v8+pJQP1lhiidzpPROHTDPWTrAhPebs9PGxenOGp+fl7C9meM9fsBImqIg18a2pe1D8ZOE1CiRzakcZAw5J0RBSpbAG1J/yrb8UZKN0U3I+kQ6WiWnfCSxqlH9jyvhrNHxyXIlCK+Ah46nCXBuFu1PikmtII46yie7sTcuvPFpNRm7DJxlVB7NEoidRv7ncuOynV4CvRGwiJXpG+AJF8q9G+A6j7tUREmCWS8XuP44jubGKu7nzA+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(40470700004)(36840700001)(1076003)(36860700001)(336012)(41300700001)(8936002)(81166007)(8676002)(426003)(2906002)(26005)(186003)(6666004)(478600001)(6916009)(83380400001)(40480700001)(82740400003)(5660300002)(356005)(16526019)(2616005)(40460700003)(82310400005)(7696005)(4326008)(70586007)(36756003)(47076005)(86362001)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:22:21.7658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990d1126-c1cd-4968-3c9b-08da597e9481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 5af39cf2fbadbaac1a04c94a604b298a9a325670
since drv enabled mes to access registers.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 51 +-------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2be785cfc6dc..cd6b97d7184f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -261,12 +261,6 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-	struct dma_fence *fence;
-	struct amdgpu_job *job;
-
-	int r;
-
 	if ((vmhub == AMDGPU_GFXHUB_0) && !adev->gfx.is_poweron)
 		return;
 
@@ -290,51 +284,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	mutex_lock(&adev->mman.gtt_window_lock);
-
-	if (vmhub == AMDGPU_MMHUB_0) {
-		gmc_v11_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB_0, 0);
-		mutex_unlock(&adev->mman.gtt_window_lock);
-		return;
-	}
-
-	BUG_ON(vmhub != AMDGPU_GFXHUB_0);
-
-	if (!adev->mman.buffer_funcs_enabled ||
-	    !adev->ib_pool_ready ||
-	    amdgpu_in_reset(adev) ||
-	    ring->sched.ready == false) {
-		gmc_v11_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
-		mutex_unlock(&adev->mman.gtt_window_lock);
-		return;
-	}
-
-	r = amdgpu_job_alloc_with_ib(adev, 16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job);
-	if (r)
-		goto error_alloc;
-
-	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
-	job->vm_needs_flush = true;
-	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
-	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
-	r = amdgpu_job_submit(job, &adev->mman.entity,
-			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
-	if (r)
-		goto error_submit;
-
-	mutex_unlock(&adev->mman.gtt_window_lock);
-
-	dma_fence_wait(fence, false);
-	dma_fence_put(fence);
-
-	return;
-
-error_submit:
-	amdgpu_job_free(job);
-
-error_alloc:
+	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
 	mutex_unlock(&adev->mman.gtt_window_lock);
-	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
 	return;
 }
 
-- 
2.35.1

