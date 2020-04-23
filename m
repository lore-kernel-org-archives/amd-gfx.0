Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95260C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 04:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648E62075A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 04:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648E62075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB2689AEB;
	Thu, 23 Apr 2020 04:23:05 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983DB6E03F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 04:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmHYFWKFjtG8Jac+bTQMBc6zeNWTxfRSJUVaD1aL1mGLr4ebEMKs1fMei9JttbuYJ17xm/d8e09L62HabopXG6d+aTiQTVTu3z8FUSk2WWFgJju/fKiOydowjYYrgltb2g7VKMS4GArjiy1F+R29yC1pErNnGUFNbHuCH6sg+nGRC9WQznwF/JSooD0meR8GYPMOaDT+7E7/8239R8bIs2FG+Y2ji//D+bnMX9EnofIs8+0bvmWHWaMEmyO/ZXqbJxCiHBSTFjeZCs9eFy7mK+aZy6+x9Uin0vgb6GJGkgR/xVq34kO/+E25PuQpMuFRqgZyAuQ/8mOvIBOy2IQJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9XZWEWYqysGccZN940Ba6oTvsgbP1/9qAjEzI7K5G0=;
 b=X4rSts6PwCaTkJ0E/ZPqaJiqZ2kaOIQSYvfJ+mRXQsSVB7m9KZe83LD6GV+B7bL7nC1iUevnRynNaO7xDSBvZvb4fF5oOp+dep7NPUmWZqP7fC0jM34TFIN0lXcviiYyDNviVqtz+Z9Hp6ydFIRlwxUcSd3S4lU5EnsUamRE+v/yAy0H0jpJRPKyn11s/Q53HSTECEWikaK+dvz8Q3CXZLWlUn9cw8NSGZwa0+MmA9pR2LA8aPaoVM9M5GTErrdn0uGI8pcAandZvlznSCn4gWbQwNxSjUmIOt/6YzhHhM230i99Chdb6Axr3vmr6cBHVFjO/0pM7TSH/H51/YePbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9XZWEWYqysGccZN940Ba6oTvsgbP1/9qAjEzI7K5G0=;
 b=rISkaVsIQuaXxEr/Mv2712rvh9Ai0AEMl7X2WohSD94zH7Gf5XGxJE3MPHb6bJ5Y9NxNKMm5v7WckFA0JyQRx5AGGBMRr+75PdJIdkogEEOsslcI3ad7K/V7JS1Lx3zEh1o5hOmJvK1CFOIs08OrxDtLM4LiWmNiqPGUvjdpPMo=
Received: from DM5PR2001CA0021.namprd20.prod.outlook.com (2603:10b6:4:16::31)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 04:23:02 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::88) by DM5PR2001CA0021.outlook.office365.com
 (2603:10b6:4:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 04:23:02 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 04:23:01 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 23:23:01 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 22 Apr 2020 23:22:59 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>, <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu: protect ring overrun
Date: Thu, 23 Apr 2020 12:22:57 +0800
Message-ID: <20200423042257.15688-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(46966005)(426003)(54906003)(316002)(478600001)(6636002)(2616005)(8936002)(110136005)(336012)(186003)(4326008)(81156014)(81166007)(8676002)(70586007)(70206006)(7696005)(82740400003)(47076004)(356005)(82310400002)(26005)(2906002)(5660300002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7b4dcc-5af4-4d15-a6ad-08d7e73e02dd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4413561C78FBB6EFBBDC21F7E5D30@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJl+nHZ9tuOC7xiU+DV5lbImRnXtJ9c72tTF+F68iktfulA0tl4G4HAYxQW46fOQDVe2NLLXP44f5Nx5n4UBudq1Vb2lDnOic6ZvrXCG8NqvT4RpEt05/n6Q1few9kj4/BYknnuE/I/KNdsqLuyW8sUkEFFLoYLjq/8+oYKG+uBEgq2h1DGhxfcWobALuTLiKooXBpm0eeQrebtVr5AsMCEINucvhqxm39iOUYgR6ucZjWYcWpDi2V/KpTjTuDEUOXzGt4p1Jk0yuoE/mrZTY7lxAjLRrZwtRon4LAh47wiJH2FwzK51EJCZolgSW6ehO1Q0/17JFI4DkCQ8OlzUzEnmgHT3Qo96UiX6xJtJuKNggkIghidi/HiGMHjRgvOAcycT9uHPWu9ruxATcez395RqdExces4eAyZhDItJRA4rqVAZPemyfto2CztX9MsaiXsdiEnEJEuXeVU+dNlpxvC596WkbvgFILVsJZSgAXZ9dTqN3CiAMjDXQ38zIEKKI5g3GWffC9/96Y+g8akWMw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 04:23:01.7384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7b4dcc-5af4-4d15-a6ad-08d7e73e02dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for the oldest sequence on the ring
to be signaled in order to make sure there
will be no command overrun.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 +++++++-
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 7531527067df..5462ea83d8b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -200,6 +200,13 @@ int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s)
 		return -EINVAL;
 
 	seq = ++ring->fence_drv.sync_seq;
+	if ((abs(seq - ring->fence_drv.num_fences_mask) >
+	    ring->fence_drv.num_fences_mask) &&
+	    (amdgpu_fence_wait_polling(ring,
+				       seq - ring->fence_drv.num_fences_mask,
+				       MAX_KIQ_REG_WAIT) < 1))
+		 return -ETIME;
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a721b0e0ff69..7087333681f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -681,7 +681,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	}
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		amdgpu_device_wb_free(adev, reg_val_offs);
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_read;
+	}
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
@@ -730,7 +737,13 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_write;
+	}
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..12d181ac7e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -60,7 +60,13 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
 					    ref, mask);
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq;
+	}
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5b1549f167b0..650b7a67d3bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4068,7 +4068,14 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 				reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
 				reg_val_offs * 4));
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		amdgpu_device_wb_free(adev, reg_val_offs);
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_read;
+	}
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 30b75d79efdb..71430f2a2374 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -427,7 +427,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
-		amdgpu_fence_emit_polling(ring, &seq);
+		r = amdgpu_fence_emit_polling(ring, &seq);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&kiq->ring_lock);
+			return -ETIME;
+		}
+
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fecdbc471983..a42a95675e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -621,7 +621,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 						      pasid, 2, all_hub);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
-		amdgpu_fence_emit_polling(ring, &seq);
+		r = amdgpu_fence_emit_polling(ring, &seq);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&kiq->ring_lock);
+			return -ETIME;
+		}
+
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
