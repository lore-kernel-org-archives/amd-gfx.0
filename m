Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25566C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 14:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94B22076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="chzR/dqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94B22076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ACC6EA0F;
	Wed, 22 Apr 2020 14:50:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3E86EA0D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 14:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWBcYLsv8ezUI1jY/MXBXH/EGJ4my6PKo6JaUhHCLSmu2UUOYTwbDenBR9LEIRGh/o1P4ramK1MmHhMAYf52sy5mSsk15i/zi1pvZHwJMY6/q4zUl+iCxk9sWXllyRo2rQgL/G7H3tRDXj65WQ3fWnpiUvn1AWAiG+ZCDC4A8M9w2b12crrv3EeHxUmA8BLF7bDeNUWS1hFOwAL8ffEJcRInOq66kO/sdNLMh2+zJgiZWXwiSzsy0uciJdOPT0GHPwEprCvItbOoeU8gONh4M6NAmYPFygbr3Y1EQaj8wnjl9F6QrsnlgFLjM1kCTmkhDcqrtLGcjC6e7Gtsdlv0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+kpIh9a4CoTj0DFpB+YMQkdnET69i3Z55C1KIVWEPI=;
 b=cdQJXZ5Fl7FsDTguqbzC1j3yFr2rghgtS4Gb4/rNNbjFcBdW9g4skDrauwfb+2GnIS7GchC/ppUMNDH16w/BhwQaUxs3J7ZgWknY/Xk8tFhvOrDvC54HTHXob7A9WSee6F4xvTBu+G6y4LlzKkSsfvfT66tiNaimqpz+HcWfTctkP1xykh/VHeuRkHsAupeEKV/u6lvbBdVZ6udswFpezEsiFzPObLHQmSFyJvcPOygusbKGqcDp1IiaVK9rU2l4h0MckQS92gCqmNcw+tPYjU50pbV7Ul+xqQQDki9y2TKRfGF5E4T/MzrfTeekrSf7m1LFmeby4nlYXbLlt5boag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+kpIh9a4CoTj0DFpB+YMQkdnET69i3Z55C1KIVWEPI=;
 b=chzR/dqViyiAQqPl2ZdKt6DF/gRHxxyvBc8Uvw90ivAEVdVmZuyeSWXjc1bTuzq5d1dBuCBBjSRv1FouLi9vc8olvEwUPfAU2P065K1+7qeaW0DmiLOyHkiJp/Mtpd5EqSiLxBjquNk/E6pAWsZ3pR9a9sPEd5epE9hA3PzMWDc=
Received: from BL0PR1501CA0016.namprd15.prod.outlook.com
 (2603:10b6:207:17::29) by BN8PR12MB2962.namprd12.prod.outlook.com
 (2603:10b6:408:47::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 14:50:31 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:207:17:cafe::88) by BL0PR1501CA0016.outlook.office365.com
 (2603:10b6:207:17::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 14:50:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 14:50:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 09:50:30 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 22 Apr 2020 09:50:29 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: protect kiq overrun
Date: Wed, 22 Apr 2020 22:50:27 +0800
Message-ID: <20200422145027.2209-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(428003)(46966005)(47076004)(110136005)(2906002)(6636002)(81166007)(82740400003)(1076003)(70206006)(70586007)(26005)(5660300002)(7696005)(4326008)(36756003)(2616005)(336012)(426003)(186003)(316002)(82310400002)(54906003)(478600001)(8936002)(356005)(8676002)(81156014);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a2a4e52-3c72-40aa-34e7-08d7e6cc8139
X-MS-TrafficTypeDiagnostic: BN8PR12MB2962:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2962B1C4971BEB93FA24CE92E5D20@BN8PR12MB2962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmPVi9kOxD6w+QM5prjpv3ioYy3l2s3wM6i9xpAaZOPlezdRL09n3f1mMRZ0EMvh7nk+e0XJajxE6/6qgGfo3jGyHZqFrx4G2/ABwLcmkQXaJsg5MbKKGbTXxmYzGbCeNODguE6dHA3hWQI4lKgxhdU2X5RyCPL3GX2wpDW71gqrXUNwNLp7wOhdtmEitHJWmCR7onqww4um9KRk8qvEixCN0GDeFZcqLKeYx1nrxuHqT8O96kz7Cm2oRhsEWuOEMMpDGtHYmkZibXOJjWd/1qJFSwkgNgddrUgJsvfZpKTabtzYexQfdQ82Szs6QT4sNNd+pGDpWLoJIun5BTYd01Ly46pk1EPxTbGqrww+nL+WG9VX0IqOXm4f3uiY0iPBMh58CrbQYmh3zJ+zsWmaAFPFnhIJOMZoPE7/r+Ug1NlLkDoizH3xmhRqsD0S+3nDuiaQTLTxje3XaPSJ15D9K0Qbt2+D0YQ5gFfzS9YaX7onGqovtM2An51GY0ATI3Ri/pT+RnK6zX77saCoXM0qrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 14:50:31.1501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2a4e52-3c72-40aa-34e7-08d7e6cc8139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2962
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

Wait for the oldest sequence on the kiq ring
to be signaled in order to make sure there
will be no kiq overrun.

v2: remove unused the variable and correct
    kiq max_sub_num value

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  6 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 30 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 +++++
 8 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 691c89705bcd..fac8b9713dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -325,6 +325,12 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 		 mec, pipe, queue_id);
 
 	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		pr_err("critical bug! too many kiq submission\n");
+		goto out_unlock;
+	}
+
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..fd42c126510f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -323,6 +323,12 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 		 mec, pipe, queue_id);
 
 	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		pr_err("critical bug! too many kiq submissions\n");
+		goto out_unlock;
+	}
+
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a721b0e0ff69..84e66c45df37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -321,6 +321,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
+	else
+		kiq->max_sub_num = (ring->ring_size / 4) /
+				(ring->funcs->align_mask + 1);
 
 	return r;
 }
@@ -663,6 +666,21 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq)
+{
+	uint32_t seq = 0;
+	signed long r = 0;
+
+	seq = abs(kiq->ring.fence_drv.sync_seq - kiq->max_sub_num);
+	if (seq > kiq->max_sub_num) {
+		r = amdgpu_fence_wait_polling(&kiq->ring, seq,
+					      MAX_KIQ_REG_WAIT);
+		return r < 1 ? -ETIME : 0;
+	}
+
+	return 0;
+}
+
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	signed long r, cnt = 0;
@@ -674,6 +692,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_read;
+	}
+
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		pr_err("critical bug! too many kiq readers\n");
@@ -728,6 +752,12 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	BUG_ON(!ring->funcs->emit_wreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_write;
+	}
+
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	amdgpu_fence_emit_polling(ring, &seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ee698f0246d8..1ee59a927bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -103,6 +103,7 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
+	uint32_t		max_sub_num;
 };
 
 /*
@@ -387,4 +388,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+
+int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..4b027006d072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -57,6 +57,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	uint32_t seq;
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq;
+	}
+
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
 					    ref, mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5b1549f167b0..a136e2229f7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4051,6 +4051,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_read;
+	}
+
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		pr_err("critical bug! too many kiq readers\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 30b75d79efdb..77d8bc9c0111 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -423,6 +423,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+		if (r) {
+			spin_unlock(&kiq->ring_lock);
+			DRM_ERROR("too many kiq submissions\n");
+			return -ETIME;
+		}
+
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fecdbc471983..c429a2a5fe3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -614,6 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
 		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+		if (r) {
+			spin_unlock(&kiq->ring_lock);
+			DRM_ERROR("critical bug! too many kiq submissions\n");
+			return -ETIME;
+		}
+
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, ndw);
 		if (vega20_xgmi_wa)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
