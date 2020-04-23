Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D09C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5812075A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TA189I2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5812075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC77F6E418;
	Thu, 23 Apr 2020 09:06:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5855F6E418
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 09:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCmGKB6PppD4e7XwbJVuoyMNRBwkQ9Z2SAiEfYEyENR0wwmDSPZ9oLSf8o5e1jPY/tfNS7l1NPEcy6P5dNgYm1Ezb9d3BINrrwmz5IY5w/HZGHbuUmdsnxRXeOmQcSR78XYtX9s0FibSgYgW9BS5gwFtZyPb2uC0McVeyXw8GG6rrfISxBLMbeOlFPiAVjqYHXqKGfp3J8nyz4b0Bd6Y65MaTFk85k1R093jZZiQy/9gTFytKa478kBPSw+Xy18Fr4uJCQOscW9uwCkeVOqsFOUXRRNsRaROFKutgWIufoYb2y0P1xyXGn17Etj9kSssmFRk0MDyHR0OwDNZk3SNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J19+OLH4bYYUKKwkTF0KXUyKvnx/TEkhD1ewUJi1sSs=;
 b=DKt0fS2QmPpswyHVsJLiGb98QZ0CUOV9dKDLkpcEqMj838ocR+bvhWUVWNkzFibqrUEi+ucfkppJacNEH6h0eDWeh9ATKp5HrIMSO7rJVz9PT2rAZ2DE8d/fPHUE6Mzd9EGHQL1wN8ZkyblLSVcV/IpECFTFrvlIPUiJnarCmoJXkEBQ//pNkCSsfN0w9QF7jeee0QCWhxGEke8GYWhkMm1y7CE8HEDrDgGKlinTgsunY6vZSL68+8Yg44DSNQqZu+noWUamhJjucmfnoNxJWUIxg/+nVU2ILRQHurA+NMwRvorXsZDm4+mRfTLYTnaWK7dciP9G3grX8VTp6FDliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J19+OLH4bYYUKKwkTF0KXUyKvnx/TEkhD1ewUJi1sSs=;
 b=TA189I2caGqC9Gsu/+Zd92dI+CninoYh4qLgWcK0BMfJ1W0u2h5tQc4N23ZMh8DF7FvwD2AjqIW5lWyJTEnG0kif7THIULq+Y7gKjV3X5eODI7Z+zNnT+B7S+6kVXRl5Dbzv+G5XFbg761XG/d0Zq92z7fu19dNSviDSJ5HdC3o=
Received: from BN6PR1101CA0001.namprd11.prod.outlook.com
 (2603:10b6:405:4a::11) by DM6PR12MB2828.namprd12.prod.outlook.com
 (2603:10b6:5:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 09:06:34 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::7f) by BN6PR1101CA0001.outlook.office365.com
 (2603:10b6:405:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 09:06:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 09:06:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 04:06:32 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 04:06:32 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 23 Apr 2020 04:06:30 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>, <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu: protect ring overrun
Date: Thu, 23 Apr 2020 17:06:28 +0800
Message-ID: <20200423090628.21199-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(46966005)(4326008)(2906002)(110136005)(6636002)(26005)(54906003)(8936002)(1076003)(426003)(316002)(81156014)(47076004)(8676002)(82740400003)(82310400002)(336012)(36756003)(5660300002)(186003)(2616005)(478600001)(356005)(81166007)(7696005)(70206006)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b769473-7f50-4df0-9deb-08d7e7659e98
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2828641461379B5B6788BAC7E5D30@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gy7FyG6rdq0aBJcuP2KXugyoW7g0LWpKjlrQ1TD5tT02IBXNQ7VjAqKlZDJR11S56IIEr9UvleaWgpIYYnl/ASy67PYk4gROwMKX9apLSD9GgvZyEjf+/Subi01z2YrK6WMZiYSWMHCAygOxHBITI5mymA/F7s3hzBVlXau1Y+limj5YgLLn+kKz2ah5N6tQ5AY5ioguKcjFhLf7SQJi+x1hthgfmpZYjT2zQCStJe35Rxu6mBreDyuK9qWPQBkciSVeWzsVXbDNdIVCP6UfFnVMOVla/VqtVTFvXf00D+8ltOt54BAPYwXshWuC9xpz9T6kHhIB+/8xtmV5C6/lcAyCdc4fa4blai8H19iIih9mK1VaclOByhdN+En1FreWeCRmm1o888NS7IHPyCuxNue/5A4vHUhBuo0/Ft5U37M6rV4m95k2lgA8aOEZU+4JOLpX+ks4OIA/RWBqsV2vo9vCE8QurX+dzHey/RAGD9t1sptLlpb8PojM4KEJ8UCSZf4i3Q2zlflDSCgsMYS9yQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 09:06:33.4289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b769473-7f50-4df0-9deb-08d7e7659e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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

v2: fix coding stype and remove abs operation

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 22 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 +++++++-
 9 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 7531527067df..397bd5fa77cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -192,14 +192,22 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
  * Used For polling fence.
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s)
+int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
+			      uint32_t timeout)
 {
 	uint32_t seq;
+	signed long r = 0;
 
 	if (!s)
 		return -EINVAL;
 
 	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		return -ETIMEDOUT;
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a721b0e0ff69..0103acc57474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -675,13 +675,15 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		pr_err("critical bug! too many kiq readers\n");
-		goto failed_kiq_read;
+		goto failed_unlock;
 	}
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
@@ -712,7 +714,13 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	amdgpu_device_wb_free(adev, reg_val_offs);
 	return value;
 
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_read:
+	if (reg_val_offs)
+		amdgpu_device_wb_free(adev, reg_val_offs);
 	pr_err("failed to read reg:%x\n", reg);
 	return ~0;
 }
@@ -730,7 +738,10 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
@@ -759,6 +770,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 
 	return;
 
+failed_undo:
+	amdgpu_ring_undo(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
 	pr_err("failed to write reg:%x\n", reg);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 137d3d2b46e8..be218754629a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,7 +118,8 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);
 void amdgpu_fence_driver_resume(struct amdgpu_device *adev);
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
 		      unsigned flags);
-int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s);
+int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
+			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
 int amdgpu_fence_wait_empty(struct amdgpu_ring *ring);
 signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..cbbb8d02535a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -60,7 +60,10 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
 					    ref, mask);
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
@@ -82,6 +85,9 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 
 	return;
 
+failed_undo:
+	amdgpu_ring_undo(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
 	pr_err("failed to write reg %x wait reg %x\n", reg0, reg1);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8a579ce8757d..2b6d7687f4cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7605,7 +7605,6 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6c56cedce4c3..6ae78b9e9551 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6393,7 +6393,6 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				    uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 09aa5f509bd2..be05ab221b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4054,9 +4054,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		pr_err("critical bug! too many kiq readers\n");
-		goto failed_kiq_read;
+		goto failed_unlock;
 	}
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
@@ -4070,7 +4069,10 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 				reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
 				reg_val_offs * 4));
-	amdgpu_fence_emit_polling(ring, &seq);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
@@ -4102,7 +4104,13 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	amdgpu_device_wb_free(adev, reg_val_offs);
 	return value;
 
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_read:
+	if (reg_val_offs)
+		amdgpu_device_wb_free(adev, reg_val_offs);
 	pr_err("failed to read gpu clock\n");
 	return ~0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 30b75d79efdb..b120f9160f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -427,7 +427,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
-		amdgpu_fence_emit_polling(ring, &seq);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
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
index fecdbc471983..0a6026308343 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -621,7 +621,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 						      pasid, 2, all_hub);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
-		amdgpu_fence_emit_polling(ring, &seq);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
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
