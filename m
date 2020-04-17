Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1519C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B440121D82
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 06:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0NiXc2iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B440121D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FF46E343;
	Fri, 17 Apr 2020 06:53:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E3D6E343
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 06:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnOV12Tah15Vm0X6UzLm0o3bUUxEfHej9gY623RzHB831LF42BhVJw+xpxTgpBCK5ERX5uBkdUWLXxMaxZ+oMaV6g+daRiV4EQ63T11OoSfjNzVOStIgcIebIRxnzpfL+ODoxhCytRj2sLXorJXsH6O9fAmAwUoQW9TnNRgvQWbQAEuLfYYL54gfxqtHabQGgr2xIlCQlgZ+yVTroeSSSZuROHiodVEmXui8vl6g1B2iv/YyqytjIUogPRYXibkgtuQl0eoV0558OCIT6qc60xj2lutdHeGqYd6xpPgGP5wYcoFYa0gQIxAqZQ+uRGpRyjk8mKFM5yhy36Wm8xlIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfFY5LYg4s8Juucl3loNYOhfipPi1QZ7kd7toq7smTE=;
 b=AiAPn9s1MXr3LlQGsB9cWmmDNCzv5aNmxH7cW0FW/RYG+l+GFsFmPYxpbS/nbPE5ChNE0f0hkr8Ow+7ciqPLIHKXRnS95Fi0G9XHYIgS4perYu/HaYH5YJlZiG8teledlZTptvKB24z+9yD+SY7W4alCEqDT3BsmgA/LM8W0V2upgWvJE3ggj64B8vpxffjZ4YoIuSRBq8sJ5dTJiuN2wxdHQYdh/TzTHNs54cp6WCEEpOis+sPO60DreJ57KIK1aozjzF8F9pi3dgAPcvPXJwq8/hOtIE1RvoI6ocvuKw6CsDKK/9xVQmkvzgKyGgiiGQrKnwYUB7CppC9olYhN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfFY5LYg4s8Juucl3loNYOhfipPi1QZ7kd7toq7smTE=;
 b=0NiXc2iDGketSWQQgMWYrtHCrPwlTFZ3oOxcgqSzGm0bcAqHskF0wW0lk/HoGtMSHmo2EZgX71fbewm5qxMjLV3DA3eGRzF1APyXOHI2sqqyvUt8k0MglznAjLH5QTHB0ZfpmkpzNzswIzORmUENC0qg4H0JnoXri9PQ+pXv1As=
Received: from MN2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:208:234::31)
 by BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 06:53:15 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::5c) by MN2PR16CA0062.outlook.office365.com
 (2603:10b6:208:234::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Fri, 17 Apr 2020 06:53:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 06:53:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Apr
 2020 01:53:13 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 17 Apr 2020 01:53:12 -0500
From: Yintian Tao <yttao@amd.com>
To: <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: refine kiq read register
Date: Fri, 17 Apr 2020 14:53:10 +0800
Message-ID: <20200417065310.21108-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(428003)(46966005)(82740400003)(316002)(47076004)(70206006)(70586007)(426003)(26005)(2616005)(478600001)(186003)(7696005)(336012)(54906003)(37006003)(81166007)(6636002)(356005)(2906002)(8936002)(8676002)(81156014)(5660300002)(1076003)(36756003)(6862004)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 888542a2-5e24-4ff0-54a3-08d7e29c009a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3318:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33181A3A37A0BBE301888934E5D90@BYAPR12MB3318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGC8EWWDV3TXk4EpLJuGRo1XxsKFxRhOKRqykwpKhmYcWPaCNExn+NQfeGa1B7aQv/ZV7CmhgdDsEsUe6JTzq1QQKrncEzM82PhFmoXLCJQJoNcyRv8lHG0ZRUJcHNkGqqrXZd5sCI8+IlPfaprVLeZIbfuK0qwntuJGYONS9+igoFxOJxhtRSENRZGugZ/kmsZwvK9ZFqhs2zqRS3szTqgfz7GRRy5UxM4dLRUQ2VKu9I9ZGW/L7dsyjkiQLao+zluzNYTRTmgmt4cku1ClRcopY1NESmkQK6bo34HR35iMxlWF4+e+Vox7NUm8S1PxhX9VTY6yFCmSjJvS2yJaWh8RMw0NfG/49pKkZzQy2+4iJdREOu2CUpM8nzl5UwreOIMaWCQTZPrs5ICWyxrmfc/PGlmdIiZloRzKnB29NpRpvHK6swGbly3A3YBTJxOIjzQwOQD2mA8wjNKGHMaTY0E8QW1n4lrLbTr/ppm2RtqrtOes+zrFrq9KyDaRVGJN/FK6Yqnz6VGCI79jLn9BvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 06:53:14.8674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888542a2-5e24-4ff0-54a3-08d7e29c009a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3318
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

According to the current kiq read register method,
there will be race condition when using KIQ to read
register if multiple clients want to read at same time
just like the expample below:
1. client-A start to read REG-0 throguh KIQ
2. client-A poll the seqno-0
3. client-B start to read REG-1 through KIQ
4. client-B poll the seqno-1
5. the kiq complete these two read operation
6. client-A to read the register at the wb buffer and
   get REG-1 value

Therefore, directly make kiq write the register value at
the ring buffer then there will be no race condition for
the wb buffer.

v2: supply the read_clock and move the reg_val_offs back

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 11 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 14 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 28 ++++++++++++------------
 6 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ea576b4260a4..4e1c0239e561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -304,10 +304,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 	spin_lock_init(&kiq->ring_lock);
 
-	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
-	if (r)
-		return r;
-
 	ring->adev = NULL;
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
@@ -331,7 +327,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
 {
-	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
 	amdgpu_ring_fini(ring);
 }
 
@@ -675,12 +670,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	uint32_t seq;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
+	uint64_t reg_val_offs = 0;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_rreg(ring, reg);
+	reg_val_offs = (ring->wptr & ring->buf_mask) + 30;
+	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
@@ -707,7 +704,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return adev->wb.wb[kiq->reg_val_offs];
+	return ring->ring[reg_val_offs];
 
 failed_kiq_read:
 	pr_err("failed to read reg:%x\n", reg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 634746829024..ee698f0246d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -103,7 +103,6 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
-	uint32_t			reg_val_offs;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f61664ee4940..a3d88f2aa9f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -181,7 +181,8 @@ struct amdgpu_ring_funcs {
 	void (*end_use)(struct amdgpu_ring *ring);
 	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
 	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
-	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
+	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
+			  uint64_t reg_val_offs);
 	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
 			      uint32_t val, uint32_t mask);
@@ -265,7 +266,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
 #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
 #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
-#define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
+#define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
 #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0a03e2ad5d95..7c9a5e440509 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7594,21 +7594,19 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
 	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
-static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				     uint64_t reg_val_offs)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc6c2f2bc76c..8e7eee7838e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6383,21 +6383,19 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;
 }
 
-static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint64_t reg_val_offs)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 }
 
 static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 84fcf842316d..ff279b1f5c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4046,11 +4046,13 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	uint32_t seq;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
+	uint64_t reg_val_offs = 0;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
+	reg_val_offs = (ring->wptr & ring->buf_mask) + 30;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 9 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
@@ -4058,10 +4060,10 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
@@ -4088,8 +4090,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
-		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+	return (uint64_t)ring->ring[reg_val_offs] |
+		(uint64_t)ring->ring[reg_val_offs + 1 ] << 32ULL;
 
 failed_kiq_read:
 	pr_err("failed to read gpu clock\n");
@@ -5482,21 +5484,19 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;
 }
 
-static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint64_t reg_val_offs)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 }
 
 static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
