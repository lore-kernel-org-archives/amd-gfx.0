Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CAEC55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 09:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4583206B8
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 09:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CKSDEaxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4583206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C396E392;
	Wed, 22 Apr 2020 09:29:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA2E6E392
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 09:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4YZXS0+3y8H1S/KgHX1x1vhojcDOq5etv7KotlqB+n02Rm2xE3e6cj7jpElA1VEpBFO+0zgodxQ8Y17jBOXHaZX29t9tcbaFikjcJhlWRcBBF51KGDl8assY3bMNkl+VpXpRLUCLI0GZapS9zpl/iDL13WU2Xi13Em6kdRhlEqDbq9AAWf78Cu1gv5tMIwM938WIc3btKUAwnl9jR0IuJA8j+QfE8vv54kEiYNxKwu5XZz49K+Yn7huorQPYH4LKKOpaE60EEHMDRIO0BrgPHj2CfQPxT/7xQx1wwcwyaW3eqeQJQQZyKa1uaNX6qTDYKYWQNrYLIx30giCSaDLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tvzoxPdFXGAXEK/TFtMVYiA//T7KZbALeLrNgCRkrM=;
 b=nWxNY66cRDIRCnL2N4kxdB1tfOTe15mOkaSExxM1P00hy8LcUpej/wtSVpQNjaLbsj3AL8NDHVXE/0w9B3dzegL9N8g0FeVs0dJQ3zIhQi5Bp03Q8k5pZe1faGZOeoCtm/5S0QlFzvK23KZP/sMKn2Mhj8TPXqcyJqwQnhWHbOJdGzYt/IwWRvWYxwOteN0IMiP/pUP5gLJOjnyWzOvJYiIaW7hfTuGX3GOORv+bEgNuWhsI+0KF/BG+39Ml+I3KrGa17xzKHOfXyT1TS/bkKfGzEX3lLVTK8SREpxT7TrSLIzK4ph8DMd/mOOtE2NrOqi2vFI+DDhgAYbOkpPcenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tvzoxPdFXGAXEK/TFtMVYiA//T7KZbALeLrNgCRkrM=;
 b=CKSDEaxaLhrI7S7T6KINM7iG01Y7INC0GMcjP4rlMigRdVJD8Aduiw/LOMjKITDY6S+tFdkVkRf6TLc9sibu3B6JmFtMdZ9Q4dBoZQrLCQOsl+7zLEd3L5Qzzzt9lTSneKMF0JW3Kz7ojbWCk4fyRe6Js7nQ697Quhs8f69NePs=
Received: from DM6PR14CA0054.namprd14.prod.outlook.com (2603:10b6:5:18f::31)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 09:29:13 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::c8) by DM6PR14CA0054.outlook.office365.com
 (2603:10b6:5:18f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Wed, 22 Apr 2020 09:29:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 09:29:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 04:29:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 04:29:11 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 22 Apr 2020 04:29:10 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: refine kiq access register
Date: Wed, 22 Apr 2020 17:29:08 +0800
Message-ID: <20200422092908.27434-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(46966005)(54906003)(336012)(6636002)(8676002)(2906002)(316002)(8936002)(81166007)(478600001)(26005)(5660300002)(426003)(186003)(110136005)(7696005)(30864003)(1076003)(2616005)(81156014)(356005)(4326008)(70586007)(82310400002)(36756003)(82740400003)(70206006)(47076004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e653a6df-4420-4284-5071-08d7e69f9e5d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:
X-Microsoft-Antispam-PRVS: <MN2PR12MB386936E7AA2EA4BAC142BC40E5D20@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJIvej09N2mqigYlhAgCtw3qE/aBThyUg/yMSLtUBkcrIQW87b1T7sjkm4MczqmlRNucP3EDk6FEUEPSa7uHBroUwGuw7zuRZVdokmtqpgcn3Y/smuBQWICAEvvlWn2hG/+YMhOtRB2ep60CHljlC44w7HOHkPclNuKbxBoPYsAEIM88N/3tw9BTXFuViw9Mgd3uOtldnl+S71KLdOsompbQwea49VDFYIjhLRKUO3oA0vwk33KwIA0ghQ0O3tumKuUGj1OjnbYq53XCh3brjN4ZD5cb1i75SsGXL/e6PlJPcKDBznYr3M5+E4t8GpnkbWvoUnViTiXhfaAY1WydA7W+5TObkQQWWAVJfMvCo2i+GREMz5043UNyaLaAFbjzppW9CqJn2y5O/VVjhu0eO+LNWMls4owR+UYCPjG5btoWoCIf/v8taBtbS/dagoiLcYNpPlKBSWh0oVenkDZr/S30U4lskgG6yGCi6qECwn7N4ryIXg+ZVnIiq7KrOUZcKdLwQKj5Nymwc3HX6c75dg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 09:29:12.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e653a6df-4420-4284-5071-08d7e69f9e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
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

According to the current kiq access register method,
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

And if there are multiple clients to frequently write
registers through KIQ which may raise the KIQ ring buffer
overwritten problem.

Therefore, allocate fixed number wb slot for rreg use
and limit the submit number which depends on the kiq
ring_size in order to prevent the overwritten problem.

v2: directly use amdgpu_device_wb_get() for each read instead
    of to reserve fixde number slot.
    if there is no enough kiq ring buffer or rreg slot then
    directly print error log and return instead of busy waiting

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 13 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 83 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 13 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 35 +++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 13 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 13 ++-
 12 files changed, 167 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e1d4cfe7a9f..1157c1a0b888 100644
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
@@ -1028,6 +1028,12 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
+int amdgpu_gfx_kiq_lock(struct amdgpu_kiq *kiq, bool read,
+			unsigned long *flags);
+void amdgpu_gfx_kiq_unlock(struct amdgpu_kiq *kiq, unsigned long *flags);
+
+void amdgpu_gfx_kiq_consume(struct amdgpu_kiq *kiq, uint32_t *offs);
+void amdgpu_gfx_kiq_restore(struct amdgpu_kiq *kiq, uint32_t *offs);
 /*
  * Registers read & write functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 691c89705bcd..a65d6a1abc04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -309,9 +309,11 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 			    uint32_t doorbell_off)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v10_compute_mqd *m;
 	uint32_t mec, pipe;
+	unsigned long flags = 0;
 	int r;
 
 	m = get_mqd(mqd);
@@ -324,13 +326,19 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto out_unlock;
+	}
+
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
 		goto out_unlock;
 	}
 
+	amdgpu_gfx_kiq_consume(kiq, NULL);
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	amdgpu_ring_write(kiq_ring,
 			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
@@ -350,8 +358,9 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
 	amdgpu_ring_commit(kiq_ring);
 
+	amdgpu_gfx_kiq_restore(kiq, NULL);
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	amdgpu_gfx_kiq_unlock(&adev->gfx.kiq, &flags);
 	release_queue(kgd);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..4435bd716edd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -307,9 +307,11 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 			    uint32_t doorbell_off)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v9_mqd *m;
 	uint32_t mec, pipe;
+	unsigned long flags = 0;
 	int r;
 
 	m = get_mqd(mqd);
@@ -322,13 +324,19 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto out_unlock;
+	}
+
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
 		goto out_unlock;
 	}
 
+	amdgpu_gfx_kiq_consume(kiq, NULL);
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	amdgpu_ring_write(kiq_ring,
 			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
@@ -348,8 +356,9 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
 	amdgpu_ring_commit(kiq_ring);
 
+	amdgpu_gfx_kiq_restore(kiq, NULL);
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	amdgpu_gfx_kiq_unlock(&adev->gfx.kiq, &flags);
 	release_queue(kgd);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ea576b4260a4..c0dc7f1849c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -295,6 +295,43 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+int amdgpu_gfx_kiq_lock(struct amdgpu_kiq *kiq, bool read,
+			unsigned long *flags)
+{
+	struct amdgpu_wb *wb = &(kiq->ring.adev)->wb;
+
+	spin_lock_irqsave(&kiq->ring_lock, *flags);
+	if ((atomic64_read(&kiq->submit_avail) > 0) &&
+	    (read ? find_first_zero_bit(wb->used, wb->num_wb) <
+	     wb->num_wb : 1)) {
+		return 0;
+	} else {
+		spin_unlock_irqrestore(&kiq->ring_lock, *flags);
+		pr_err("critical! too more kiq accessers\n");
+		return -EDEADLK;
+	}
+}
+
+void amdgpu_gfx_kiq_unlock(struct amdgpu_kiq *kiq, unsigned long *flags)
+{
+	spin_unlock_irqrestore(&kiq->ring_lock, *flags);
+}
+
+void amdgpu_gfx_kiq_consume(struct amdgpu_kiq *kiq, uint32_t *offs)
+{
+	atomic64_dec(&kiq->submit_avail);
+	if (offs)
+		amdgpu_device_wb_get(kiq->ring.adev, offs);
+
+}
+
+void amdgpu_gfx_kiq_restore(struct amdgpu_kiq *kiq, uint32_t *offs)
+{
+	atomic64_inc(&kiq->submit_avail);
+	if (offs)
+		amdgpu_device_wb_free(kiq->ring.adev, *offs);
+}
+
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
 			     struct amdgpu_irq_src *irq)
@@ -304,10 +341,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 	spin_lock_init(&kiq->ring_lock);
 
-	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
-	if (r)
-		return r;
-
 	ring->adev = NULL;
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
@@ -325,13 +358,15 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
+	else
+		atomic64_set(&kiq->submit_avail, ring->ring_size / 4 /
+			     (ring->funcs->align_mask + 1));
 
 	return r;
 }
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
 {
-	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
 	amdgpu_ring_fini(ring);
 }
 
@@ -671,19 +706,25 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
+	unsigned long flags = 0;
+	uint32_t seq, reg_val_offs = 0, value = 0;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, true, &flags);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto kiq_read_exit;
+	}
+
+	amdgpu_gfx_kiq_consume(kiq, &reg_val_offs);
 	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_rreg(ring, reg);
+	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	amdgpu_gfx_kiq_unlock(kiq, &flags);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -707,9 +748,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return adev->wb.wb[kiq->reg_val_offs];
+	mb();
+	value = adev->wb.wb[reg_val_offs];
+	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
+	return value;
 
 failed_kiq_read:
+	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
+kiq_read_exit:
 	pr_err("failed to read reg:%x\n", reg);
 	return ~0;
 }
@@ -717,19 +763,25 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 {
 	signed long r, cnt = 0;
-	unsigned long flags;
+	unsigned long flags = 0;
 	uint32_t seq;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_wreg);
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto kiq_write_exit;
+	}
+
+	amdgpu_gfx_kiq_consume(kiq, NULL);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	amdgpu_gfx_kiq_unlock(kiq, &flags);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -754,8 +806,11 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_write;
 
+	amdgpu_gfx_kiq_restore(kiq, NULL);
 	return;
 
 failed_kiq_write:
+	amdgpu_gfx_kiq_restore(kiq, NULL);
+kiq_write_exit:
 	pr_err("failed to write reg:%x\n", reg);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 634746829024..ff7597ca6cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -96,6 +96,7 @@ struct kiq_pm4_funcs {
 	int invalidate_tlbs_size;
 };
 
+#define MAX_KIQ_RREG_NUM 64
 struct amdgpu_kiq {
 	u64			eop_gpu_addr;
 	struct amdgpu_bo	*eop_obj;
@@ -103,7 +104,7 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
-	uint32_t			reg_val_offs;
+	atomic64_t		submit_avail;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..a4c3f284691c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -56,13 +56,19 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	unsigned long flags;
 	uint32_t seq;
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto failed_exit;
+	}
+
+	amdgpu_gfx_kiq_consume(kiq, NULL);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
 					    ref, mask);
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	amdgpu_gfx_kiq_unlock(kiq, &flags);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -80,9 +86,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq;
 
+	amdgpu_gfx_kiq_restore(kiq, NULL);
 	return;
 
 failed_kiq:
+	amdgpu_gfx_kiq_restore(kiq, NULL);
+failed_exit:
 	pr_err("failed to write reg %x wait reg %x\n", reg0, reg1);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0a03e2ad5d95..7853dbc3c8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7594,10 +7594,10 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
 	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
-static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				     uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -7606,9 +7606,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
index fc6c2f2bc76c..bdbd92d4fe45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6383,10 +6383,10 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;
 }
 
-static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -6395,9 +6395,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
index 84fcf842316d..293219452c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4042,14 +4042,21 @@ static int gfx_v9_0_soft_reset(void *handle)
 static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 {
 	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
+	unsigned long flags = 0;
+	uint32_t seq, reg_val_offs;
+	uint64_t value = 0;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, true, &flags);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto failed_kiq_exit;
+	}
+
+	amdgpu_gfx_kiq_consume(kiq, &reg_val_offs);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 9 |	/* src: register*/
@@ -4059,12 +4066,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
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
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	amdgpu_gfx_kiq_unlock(kiq, &flags);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -4088,10 +4095,14 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
-		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+	value = (uint64_t)adev->wb.wb[reg_val_offs] |
+		(uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
 
+	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
+	return value;
 failed_kiq_read:
+	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
+failed_kiq_exit:
 	pr_err("failed to read gpu clock\n");
 	return ~0;
 }
@@ -5482,10 +5493,10 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;
 }
 
-static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -5494,9 +5505,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 30b75d79efdb..ab960b052c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -415,6 +415,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	int vmid, i;
 	signed long r;
+	unsigned long flags = 0;
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
@@ -422,20 +423,28 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
+		if (r) {
+			pr_err("failed to lock kiq\n");
+			return -ETIME;
+		}
+
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
+		amdgpu_gfx_kiq_consume(kiq, NULL);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		amdgpu_gfx_kiq_unlock(kiq, &flags);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+			amdgpu_gfx_kiq_restore(kiq, false);
 			return -ETIME;
 		}
 
+		amdgpu_gfx_kiq_restore(kiq, NULL);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fecdbc471983..d14fd56a959e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -589,6 +589,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	int vmid, i;
 	signed long r;
+	unsigned long flags = 0;
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
@@ -613,7 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (vega20_xgmi_wa)
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
+		if (r) {
+			pr_err("failed to lock kiq\n");
+			return -ETIME;
+		}
+
+		amdgpu_gfx_kiq_consume(kiq, NULL);
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, ndw);
 		if (vega20_xgmi_wa)
@@ -623,13 +630,15 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		amdgpu_gfx_kiq_unlock(kiq, &flags);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+			amdgpu_gfx_kiq_restore(kiq, NULL);
 			return -ETIME;
 		}
 
+		amdgpu_gfx_kiq_restore(kiq, NULL);
 		return 0;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
