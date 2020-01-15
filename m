Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45224C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEBD24679
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HmKgm7Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEBD24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB67289E23;
	Wed, 15 Jan 2020 09:41:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F89589E23
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdkhUBUpk0vFFBx1S7u8OcLJ5ue4ZihiVdUOsn3bvsF5ozrkZDf3oDIZ1aNg15i4TyJjdh+WTpgu7R1mWU2IvuVmVyQJDmWoQbpm8KW0uWmBjBEyT9IwqpGy4wy2yKYEkJ9xypUeMGWuJJsLtaYHu67CO5wGGAsBYc5PA2+jogDGvpubaBb+QTFepk0a3SQxsuyWszsrSYHTbyTW6gENEjd3CsxtILuVD+22/UMgVyhUePb+ycPMyzaMHNtvALe53XJppbxiPrt+GWCC2O0Z0mVGYIEpCIsFf6n3aD/RElvb2vin4ztIoRvJwZyXet8nzFWcGUNewTYzl8UI5FhGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM/lX6R115rhcwZB+78fHLAsd8U1j7LHHZ8EIWCPfJo=;
 b=cJ9X+KdW+et+SlQ8wNgIMBDV9tYv/yfcJegLx/ch4EtpbeaSA2g5Gdx3hDY5WEL5GWbBRYbhzfy4qiiAB4ZzrbKi0Clw0veEi8PTs9mSVHPlBH3/4SYDvCbE23RdgzmO1S69tMhOne9AYAyJlzyqF+54YSP+GZHdYXRrSsdSIHmCl7A+Ptt9YCY434OnVMiSR5YD7J5fPheb4RNzW1lWPci//LVTgSOzeYq71voNwdUbR8HY1Butr/d+PLGvqi2+IGpneiX1kAm3480cNouZxZ14bigvoRsvwW8T0o65jhEfICoji18MeK/HHl9OYyqYROvqYaBmtMaA+yYoLp9v6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM/lX6R115rhcwZB+78fHLAsd8U1j7LHHZ8EIWCPfJo=;
 b=HmKgm7Z4othP8iftHK/obJOJqcH0RqzFBF5EJeBM4k3BoW86AJ/VV19q+v4X5cUOldvDjUb4wLsdXpFMztNy5T46ppzZehzj5qwWE1lHFzBGKTUT0FBvwcT6Lk+yNBhKjkaOvyiGtBQGUiD3va5Fh0oLkkP9SZGX3QEuM8Xw0XQ=
Received: from DM3PR12CA0076.namprd12.prod.outlook.com (2603:10b6:0:57::20) by
 BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Wed, 15 Jan
 2020 09:41:31 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM3PR12CA0076.outlook.office365.com
 (2603:10b6:0:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Wed, 15 Jan 2020 09:41:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 09:41:30 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 03:41:30 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jan 2020 03:41:28 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: provide a generic function interface for
 reading register by KIQ
Date: Wed, 15 Jan 2020 17:41:20 +0800
Message-ID: <1579081282-659-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(428003)(199004)(189003)(8936002)(86362001)(316002)(336012)(426003)(4326008)(36756003)(186003)(26005)(8676002)(70586007)(81156014)(70206006)(81166006)(6666004)(356004)(5660300002)(7696005)(6916009)(2616005)(2906002)(30864003)(478600001)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3762; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58974b2f-678d-4c6b-fe22-08d7999f19d6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3762D89362E4F99C7EC961AC9D370@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-Forefront-PRVS: 02830F0362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQGF8OhRKzuacJIYBi+wS8B4Z8H9OJLjyasfefheqeBkouTR06IQTcLVblcDAS7KrFxAOgeYBk5SURz9Uq0eGp5YVPkhMXOwLm4DG5va3PRJi6iIDzYghYWjdqM1PziDSLTONGUZMJrJCuqAIPdtq1cJLcEgybyZWB4AW8ZJ8uOqf1MWN2bQApZ7F6irr3iyoicrdpNjXAGxg4Zpzq3R8U5gOtK/3Rq7zI/9QifYTULovJWcMZDk9fZA4auQv1x9gnqhXUFEMze0qaPyQAg0HYF1z9EKbk/ANxT0qRm5bqDg0CpkKBlT+/+YJX0sZx3Lyp+Cwr5xT3O+7WbsH0pYkZ0yy7gsf6fpYg1MyioYA/hXmSJKZR+dX0gxqg8WZx7VqINgCnpTrLZvYg0CbRLcBh5Szk8Nvf3/dBaIQlF7pvXg60nkJjYw25UzxEN/B565ikSV9ep0VhW2J9Ix49E0TaEwPVRYzyJy60MVDCBHPjdbLphEhrKGiCFODw4AaF0E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 09:41:30.7753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58974b2f-678d-4c6b-fe22-08d7999f19d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
index d72b60f..353ecef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4743,6 +4743,7 @@ static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
 static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -4751,9 +4752,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
index 8b9f440..d6dd8a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6447,6 +6447,7 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -6455,9 +6456,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
index 44cdb6f..425762a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5218,6 +5218,7 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -5226,9 +5227,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
