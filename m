Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE3BC33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 10:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A562073A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ooZAmSJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A562073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21836EC7C;
	Thu, 16 Jan 2020 10:01:07 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690080.outbound.protection.outlook.com [40.107.69.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238B16E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 10:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h21DfqDaZWfeBKKnSILdz8t6nE8pfm0S7AALOnHAPq0Txlst85EkgeDocegq539P4u3V1qv8QkI+Go55UJK2nOpT2Y0ErlsotwrqInvS9sJmP+BzXy2lWaNBqURDExCswLqdwvu5XYEhQDzvsvZ3DGjagszkQJ1oTE3SI+KWdxBu8Oa6o7/PtySr0pgvCKLL2r0RWeyFfvTLPzR7Qp7lWj627xekse8QRbpa+ix8dB6tV1cndqFhek06y+yO3ip55hpDqwqmv1Y5Pt5MO/ZFXgmqOJKhAwLgEoFdSGwhNuWzLlL+dP/cWMgSRJatQZOt2Fs0SI3QL9Q/m6+ppvAxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX33/qXU3SxAtn+oiK3HqAtAJBdD4LrFsp+VxFKNXxI=;
 b=G4shgWG7Q3SJeePi0XRYakl7bk5AhrF3KhhEVFtdsw3YMgNy1dNxPlhhxqwvTR7uirzo4cYH8bHKTVL2uufqRmh70x0dJqIjXDSOjLSHfz5DOxfCvjBFFZdTfuhLyE2udoRvaO1ZdAbJwmVvxE86idSTK/1eE7IONYUi4/PI0Gmj+HODiqwArkoZSzjaK0i95Lgy+8OHu8jpXaKPy+A3I2iZt8LPnPk3Z4SVTYZNXCcWa8zM3O5HvaNou/9Nl+GmpSYSBIxFJehUZoyQu648UN0e4Tc4nQJ8UO0dIJc2nhrhC5FcqV/s5VPyK6PIhkFvKDhg/2gVkAUAUwwyXMmpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX33/qXU3SxAtn+oiK3HqAtAJBdD4LrFsp+VxFKNXxI=;
 b=ooZAmSJkFcR5qDdceU7x6tJI85sueR97oMLSEjqW0FxcJSgbJYmb2K219FzI0SS3P6bzFK2Yc0zaJ2MbAbIJmJlBemdJoYxj6IkQ+yNPj8v6ZagUzJCw0fixyLF5tSxg8b5DoMHkUTLLDNBicqBCaAhMkJMUbWDjwOJXlzEQPvc=
Received: from BN6PR12CA0039.namprd12.prod.outlook.com (2603:10b6:405:70::25)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Thu, 16 Jan
 2020 10:01:03 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by BN6PR12CA0039.outlook.office365.com
 (2603:10b6:405:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 10:01:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 10:01:02 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 04:01:02 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jan 2020 04:01:01 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: provide a generic function interface for
 reading/writing register by KIQ
Date: Thu, 16 Jan 2020 18:00:54 +0800
Message-ID: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(199004)(189003)(7696005)(4326008)(81156014)(8676002)(26005)(478600001)(336012)(186003)(356004)(81166006)(2616005)(70206006)(426003)(6666004)(5660300002)(70586007)(36756003)(2906002)(8936002)(30864003)(86362001)(6916009)(316002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3327; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6698a074-5cc6-4344-d54a-08d79a6afef1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3327:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33277CC8049103A6481906959D360@MN2PR12MB3327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktSDQ/Pf8IqCNt/Wo1Z3zhLRW+UUB9p+jgDb0P3WnmxmJ9Ls9L7ckLrJm7Ows4ZaY1TG6EgIZm5tUpv7x+EH95OKzgVQFpa78hzmf3AF+CD55mZYRfwjRZS+REGOY5sWj5pp4MLODEdIlkt7q2qD+jjnKVOU1unX7rCtVCQ/aTkoxfTUcjUzW6sFa/9/yGcpFfomVgK+MFJfao9jxT2hHcvAEnsPQrsnkchWo4bDAGLtRiRkN13q+82bk97uz9mUu24eU/BWE/6WnqYGznEksWaaK8gcK2PwUhy+yvM9hLZp4uaGgfgcyMQNkR2F9keHXSGhxRY7ltAfXuoUkkXSgrF5SNzpRklSlsz0B/OS5u0OHmItjdi/IqCMG8lprKD5gj00N8Kfpnd8LGIH9mjSGAwl5meKRxwbhNkqiihcPVvPfLST4pGxaXyDvh0nchcY0tGzTkEs6ta972LaodGZPTdnlD8L6UE3TCt2O2VxFW0Ebl9UPZCpmEFbA4QeA6UV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 10:01:02.9846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6698a074-5cc6-4344-d54a-08d79a6afef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move amdgpu_virt_kiq_rreg/amdgpu_virt_kiq_wreg function to amdgpu_gfx.c,
and rename them to amdgpu_kiq_rreg/amdgpu_kiq_wreg.Make it generic and
flexible.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 96 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 92 ----------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  5 +-
 8 files changed, 108 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c64d2a..963ea46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -218,7 +218,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 	uint32_t ret;
 
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_virt_kiq_rreg(adev, reg);
+		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -296,7 +296,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 	}
 
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_virt_kiq_wreg(adev, reg, v);
+		return amdgpu_kiq_wreg(adev, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b88b8b8..0f960b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -296,7 +296,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 	spin_lock_init(&kiq->ring_lock);
 
-	r = amdgpu_device_wb_get(adev, &adev->virt.reg_val_offs);
+	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
 	if (r)
 		return r;
 
@@ -321,7 +321,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
 {
-	amdgpu_device_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
+	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
 	amdgpu_ring_fini(ring);
 }
 
@@ -658,3 +658,95 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
 	return 0;
 }
+
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_rreg);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_emit_rreg(ring, reg);
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+		goto failed_kiq_read;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_read;
+
+	return adev->wb.wb[kiq->reg_val_offs];
+
+failed_kiq_read:
+	pr_err("failed to read reg:%x\n", reg);
+	return ~0;
+}
+
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_wreg);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_emit_wreg(ring, reg, v);
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+		goto failed_kiq_write;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_write;
+
+	return;
+
+failed_kiq_write:
+	pr_err("failed to write reg:%x\n", reg);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index af4bd27..ca17ffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -94,6 +94,7 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
+	uint32_t			reg_val_offs;
 };
 
 /*
@@ -375,4 +376,6 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry);
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 103033f..adc813c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -45,98 +45,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	adev->pg_flags = 0;
 }
 
-uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
-{
-	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *ring = &kiq->ring;
-
-	BUG_ON(!ring->funcs->emit_rreg);
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_rreg(ring, reg);
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-	/* don't wait anymore for gpu reset case because this way may
-	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
-	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
-	 * never return if we keep waiting in virt_kiq_rreg, which cause
-	 * gpu_recover() hang there.
-	 *
-	 * also don't wait anymore for IRQ context
-	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
-		goto failed_kiq_read;
-
-	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-	}
-
-	if (cnt > MAX_KIQ_REG_TRY)
-		goto failed_kiq_read;
-
-	return adev->wb.wb[adev->virt.reg_val_offs];
-
-failed_kiq_read:
-	pr_err("failed to read reg:%x\n", reg);
-	return ~0;
-}
-
-void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
-{
-	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *ring = &kiq->ring;
-
-	BUG_ON(!ring->funcs->emit_wreg);
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_wreg(ring, reg, v);
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-	/* don't wait anymore for gpu reset case because this way may
-	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
-	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
-	 * never return if we keep waiting in virt_kiq_rreg, which cause
-	 * gpu_recover() hang there.
-	 *
-	 * also don't wait anymore for IRQ context
-	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
-		goto failed_kiq_write;
-
-	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-
-		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-	}
-
-	if (cnt > MAX_KIQ_REG_TRY)
-		goto failed_kiq_write;
-
-	return;
-
-failed_kiq_write:
-	pr_err("failed to write reg:%x\n", reg);
-}
-
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 4d1ac76..daaf909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -287,8 +287,6 @@ static inline bool is_virtual_machine(void)
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
-uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
-void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t rreg1,
 					uint32_t ref, uint32_t mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1cfc508..e74ed06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4747,6 +4747,7 @@ static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
 static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -4755,9 +4756,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 306ee61..a46ec1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6450,6 +6450,7 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -6458,9 +6459,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 }
 
 static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0dfdc86..d9d7ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5221,6 +5221,7 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -5229,9 +5230,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 }
 
 static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
