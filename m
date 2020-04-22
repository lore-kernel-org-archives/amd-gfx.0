Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A62C55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 12:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EEC20784
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 12:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pZ655jCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EEC20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BAB6E9F2;
	Wed, 22 Apr 2020 12:34:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63E66E9F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 12:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U84wDVBEDlbZKCNWXvFZts/nzoqd0c+0X584bzwDaLiWYI1HhdMeQx0Z8+z96RVBt6wx4HfUZBdF5ofXriVmlvNni/luNnwCe5/kpo8yh/kvz9jZn6ACxSL73XiM/R31dXgTJ9+TKOGiYy5PtJyHuy7tUXo7ZbHz4M7ediR3dFg5Fhqn2yiJqMI6bKlfUiXbZsK1r4g0kbZSLt1P2yTdrAKGzFmq2aKLTWq0PYuHQ5as0PcX+v4SYN03FBM8n4B5YgaTB6FtayxycRKbLDZfEGL0RWzBJzraAk1jusVaj58e72l/I7q3wkiXZhdrSYt4HUs1QnRRnZwzHcFhnVJ6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnkVuXpW4SLDfH2X3e0avxhTK/a8xNiRbg8QCfh0uC8=;
 b=HO/MUXjmkElSIhbwHjQXxPAmPab5Na/PQfQOLjMy5w7qjv7DzbbSU52kYFwywhWazubYh9PXVGrLWpguo7bQ7z0CpzS9sWsOaST0f9+l97r3R0Z4CJGl3NRGfg9fp7m1XNd9rCWT38R8CE9PTvB8fKYeN8fUSQ2r5oxBm3qyq8mCyF7EKtU5tqRqCT73FVYcwTb/4Wt40xkBKZKSoqBSWh3bcTlckHcN0tA3khMupSB3bEQ7m7m/LbVuhBNbQkOv1I4rXRzPUNF/pGeTM8jQXuxffBtykXYQyk0BTCDyqRwfKs4WqciP+Ov1rxAcUi6Zc/W8p02LJBAChyV1ONn+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnkVuXpW4SLDfH2X3e0avxhTK/a8xNiRbg8QCfh0uC8=;
 b=pZ655jCknOOSpPwgMsm8XxIyvQhd0gFiu5Rw2MKWrpT00TUT9NTYkXyg+mtQTaCOm+cHOPDHw1DmCu9fgfVB+h5Auq/teeRfFwxFXIs40hkegUpMOotSPAVw7x+cSvv5mL6GKoRl3GV0/fofU/os5hLNfasUqyc3LY6yzGHgtnQ=
Received: from MWHPR15CA0050.namprd15.prod.outlook.com (2603:10b6:301:4c::12)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 12:33:58 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::3) by MWHPR15CA0050.outlook.office365.com
 (2603:10b6:301:4c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 12:33:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 12:33:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 07:33:57 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 07:33:56 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 22 Apr 2020 07:33:55 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: request reg_val_offs each kiq read reg
Date: Wed, 22 Apr 2020 20:33:52 +0800
Message-ID: <20200422123352.30258-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(428003)(46966005)(186003)(70206006)(6636002)(70586007)(26005)(82310400002)(4326008)(356005)(336012)(7696005)(426003)(2616005)(8936002)(2906002)(82740400003)(8676002)(1076003)(30864003)(36756003)(54906003)(316002)(110136005)(81166007)(478600001)(47076004)(6666004)(5660300002)(81156014);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e49e57b-555c-4524-e1a1-08d7e6b96dcd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:
X-Microsoft-Antispam-PRVS: <SA0PR12MB457466D50FAA6794B3736706E5D20@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQfEwS6XHN8xH+gYmN982kdAocCslE1iuQdBpsA/5F51GTsof2SzIaCtgP7WyRIFj/uD4Tzg6s3tCrTyEKxjcdzYcbQR/Ws64kfgcJoCdurd9SuNkRehFuCcK3pVOEGXHsdQPHv9OYZUx/edzbwlIEQfB4oSiv6qf0/R9/O6mynRXqbFAY0XFpvqyw+IMIhcoFGz+aKaVvbdzpfeu+8jyxSk23nANRS9mDnr2zOa4rItwuIBazfuPvf76VXbgydLn+OdussM+sEumii9m92ZsIr6PFnSoN4Inbng3IDd01k/Pb9H4JmSRc7VU/D/dxeo+V9G/i+Oe8+ufoZan/gIiCo9s7l0kDCHymtUzdbwG4hOXU0R41L8UHNcwi16ART50TvfDf8RN8mlda5hL7ouWFglETDHAa9VY3BQ4SfXHmQU9xfAFogmnvXC6WvSzqI9TCj7DuwWlIbUd2RDQ1AFKTpPtS3iVCVS0bwCk3v/XNOU/o1fC1seHFUsOI5WnMhC07gED2mMeA7MIkogWQg/xA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 12:33:58.0132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e49e57b-555c-4524-e1a1-08d7e6b96dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
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

Therefore, use amdgpu_device_wb_get() to request reg_val_offs
for each kiq read register.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 19 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  7 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 27 ++++++++++++++++--------
 7 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e1d4cfe7a9f..7ee5a4da398a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -526,7 +526,7 @@ static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
 /*
  * Writeback
  */
-#define AMDGPU_MAX_WB 128	/* Reserve at most 128 WB slots for amdgpu-owned rings. */
+#define AMDGPU_MAX_WB 256	/* Reserve at most 256 WB slots for amdgpu-owned rings. */
 
 struct amdgpu_wb {
 	struct amdgpu_bo	*wb_obj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ea576b4260a4..d5a59d7c48d6 100644
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
 
@@ -672,15 +667,20 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
-	uint32_t seq;
+	uint32_t seq, reg_val_offs = 0, value = 0;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		pr_err("critical bug! too more kiq readers\n");
+		goto failed_kiq_read;
+	}
 	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_rreg(ring, reg);
+	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
@@ -707,7 +707,10 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return adev->wb.wb[kiq->reg_val_offs];
+	mb();
+	value = adev->wb.wb[reg_val_offs];
+	amdgpu_device_wb_free(adev, reg_val_offs);
+	return value;
 
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
index f61664ee4940..137d3d2b46e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -181,7 +181,8 @@ struct amdgpu_ring_funcs {
 	void (*end_use)(struct amdgpu_ring *ring);
 	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
 	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
-	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
+	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
+			  uint32_t reg_val_offs);
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
index 0a03e2ad5d95..0a3d3bc9d441 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7594,7 +7594,8 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
 	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
-static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				     uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
@@ -7606,9 +7607,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc6c2f2bc76c..ccfa65c3cb5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6383,7 +6383,8 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;
 }
 
-static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
@@ -6395,9 +6396,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 }
 
 static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 84fcf842316d..e4777c37d7c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4043,13 +4043,18 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
-	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	uint32_t seq, reg_val_offs = 0;
+	uint64_t value = 0;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		pr_err("critical bug! too more kiq readers\n");
+		goto failed_kiq_read;
+	}
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 9 |	/* src: register*/
@@ -4059,9 +4064,9 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
@@ -4088,8 +4093,11 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
-		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+	mb();
+	value = (uint64_t)adev->wb.wb[reg_val_offs] |
+		(uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
+	amdgpu_device_wb_free(adev, reg_val_offs);
+	return value;
 
 failed_kiq_read:
 	pr_err("failed to read gpu clock\n");
@@ -5482,7 +5490,8 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;
 }
 
-static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
@@ -5494,9 +5503,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+				reg_val_offs * 4));
 }
 
 static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
