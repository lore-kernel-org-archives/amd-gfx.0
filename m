Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1412C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E7810E91A;
	Thu,  5 May 2022 20:08:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC57310E705
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF7u/FfeytJjkoG1bAnKWpNsNHTQNq98PknTyTbVV2ush/zBqhhzy1glKMiv3FgcT1hRxYfnXAl8iET8BE7hB+uGe6BOCiu7IrGyHQ0q7iD/wSMAJrMMPJUshY2ZpO10Gk36xi5QJfX2Hzz3d/YfalmfIuk8CmHoKmjAB9P6aHNLukM0WhPz2EG39rxjU1JCheSdkIKdIEiQIBZYpXHTo67PJfYw6ewf0C/2wwjKNreF0j+xM3Pxu4fON29QCI2Qm4DU7/s9hvy3PLO2++23VvmKyTzdd1lAaGPohlaBtBFszOpPpEHMBf4cisWKQS75sUJ5NU3qng4l4q94Wb1QPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPG9Jk/P5WGoe5NwLDz4UuIa4mdF0Hk5goS2Vcsk0mY=;
 b=Bxu4LXg48aftVTam+9cDjkUPftI7D2ItEUWgMDeYS9J6n3EL8a/VsUedDzFSbioJIlk20Eb/Kefr8u5g3UNNm7iZJBf2njGZQgPiwesVU5mydw/b773hFiPkDvJY/VJ9rlh8Njjvu3qfYM4wN4mkx22F6qsgZ8UtZhhbKTI3TP4LyGPo2tfNDAuVp0VHfwyOHRHsuNaY3YHKtmoLoPMd2vZ5Op0D3CBr1fGu89NzfWpMsQUt9qXF8eYGS61ddpmSJuyaMaF2Z0iqW9kxZH6irV3t+ZNFzSKZQeeaEUWA45b4Z0Cz3BXiupI1GI6YFcs0BjA2oB13XKsJgs3e4Qs+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPG9Jk/P5WGoe5NwLDz4UuIa4mdF0Hk5goS2Vcsk0mY=;
 b=3mURdCXbKiftLrsnlV5Mx70cZayDnfXBdgP8LGZFYLqrQjlAUjdvpmSsO9kwCNcGymIEnEGEq0Z842oWQLgM9+AXHB7Z0ameIlXv5TSOSaE0tuRCeSJDeIcmh827/5aIB7kANXhhqM5GMDAvsU/SEN+9Zko8M3hFFyxf0OuQWGQ=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:08:38 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::c9) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 20:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc11: avoid cpu accessing registers to flush VM
Date: Thu, 5 May 2022 16:07:50 -0400
Message-ID: <20220505200750.1293725-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece5185e-5eeb-49e7-b449-08da2ed30ae9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5165F65FA8898D2EF84354DAF7C29@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfqpOLNSMI+H3RQV9Tq9m1ZhyQ1qIxuWexhMs2uA0R5FAZ1ZzkuYJQo06K14aoxZnIE0LbmDeauErn8pKFwiRSjUP5LJF9aCIPIVdsUtntE9R1yv2UjBAq0fq4gDt9k7xOKFQQLGH4wZWwyxdTD2eNuVKAbFLIQozilzcjuucqvALd+/idmH5TJpod35e9lkmc6bR4xtOeojWyCc4Jxi6Cu29mva6IlIyqLPlLw0RKrjOhWzy8reXEbqke1vABaFUVQw+nIrdAZxnmANy1yKAO2BOPTWZo0/mF24lzTLWjTq3AgZGdFy7XYw7T5+MZLxcRqZ5aR3dN8hxn9OLvSF/r0B4o9ojAevRwXVnT03AMb+ugJirxG7JafY0pDWUEt5cqO296Pg2qa4e35vNHRm4nj4JIxgWBG07yjzkOIwD818q0Q697mfbwQCs/PP5RtR4F9lwP7ot1rZhCr2sxieYlUQjraHDt5H8EdtJGyVZb+CA9eS/skIv6Ym/UMh1AbYImxai/nrS1Vy0kas0xlQrailHB88O9oFBoAwz5qu37XYZchcbnzB12XrdTlaMuOIUELZA8UIKMejj4+pWxmg6XNtbrG3mIlRwmJivwSa/bNqihcssFSAAydm+tfOeYfMRYPz6DBN1HU6433yOSW+ux7c918d5g1l2eeIBvcr+E6txu++qu+1JlJ0zLqwpzAx/jyfMuBq/yzAisigHrYpLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(82310400005)(1076003)(7696005)(356005)(86362001)(36860700001)(2616005)(8676002)(6666004)(70586007)(70206006)(40460700003)(81166007)(4326008)(36756003)(336012)(426003)(8936002)(16526019)(186003)(47076005)(2906002)(316002)(5660300002)(508600001)(26005)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:38.1474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece5185e-5eeb-49e7-b449-08da2ed30ae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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
2.35.1

