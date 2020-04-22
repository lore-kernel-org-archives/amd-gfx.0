Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64395C38A30
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 04:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08919206B8
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 04:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="20jh0EFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08919206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06CC6E02A;
	Wed, 22 Apr 2020 04:42:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD8C6E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 04:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7BUc57vmXrhjjjBB6g5QfcbcPYdgpzsn8t6sSmDbbCDNzFMhiYuh4QCUXJyazMzkaITYsgxekKSruzo6elEtgEoaN7IMzU0xr7Eds+a/tp1QIrwrOmSRmY8Anv+wyPxUYxQlVwJ8r28Pe8O9OQSpbet657o7qspbA5bGQTx7DNxYiPCAgohrPzl4lCaaY+zSin/E3NZUrN7Fquwjwl+zKDLmqQBLLZNRZO7L2A6DR3aPKISwdb7ZxHD1/3Rm0f5nxjjF7TBzbGDX7b+TKXzFftWHM0kiK4h1HkDcJZJs+je/q3GdK7RLSR6fNwjMdAz7GHmlXxaNqvyeJeKP+36jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLz1zEi4geKfE2YShA1EkAZoAAff88m0oVwVz9Yfi1w=;
 b=Bkmh4V8ueDL5o/76J6VWn1TllRRg9XH9HFsjG2jMfw1op0fY0n/ygASYk/0xn1DSI6cB49iDYD7XKfKpy718wBTaHAm0VacyJRYKaqHqG4y1nRDcwkF7hUlCpUnIdRyazmgeTk3pg48IzSELeYHe2lHwoXtUz4FQZDJ/hu+iaOcDNFquPAPBYdAYOF+vy+Kj4G8R0BfDe/clL66wtRKzwXRTQUip+OQE/60Z/B6pz4cgMPri6AbMTDnyPPv4vY53q17rGUOfq/xA3DN+jB24HpuSKnyIoWg+rPFHsqJb7O+jK+xUI3vKFtVrcMwWHEnsxHVJ2dCKg/2v+Hi8YHSxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLz1zEi4geKfE2YShA1EkAZoAAff88m0oVwVz9Yfi1w=;
 b=20jh0EFItHUrRaF00e3c/wSqIcugsjhNuY3jn3YY/ev/Hlu33esUdns5b7ryObbsT8v0N3dVO54JqjfXCt+94w10a/w287eL7jvPRDDU3cDCYH32tjIb4TRnhcj0Wba6yNeBONWEBLCJFxXqLRHcnVO9ZxCyaSIaJhFaEFjAdCI=
Received: from MN2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:d4::19)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 04:42:35 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:d4:cafe::c3) by MN2PR04CA0006.outlook.office365.com
 (2603:10b6:208:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 04:42:35 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 04:42:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Apr
 2020 23:42:34 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Apr
 2020 23:42:33 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 21 Apr 2020 23:42:32 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: refine kiq access register
Date: Wed, 22 Apr 2020 12:42:28 +0800
Message-ID: <20200422044228.20986-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39850400004)(136003)(376002)(346002)(428003)(46966005)(1076003)(2906002)(8676002)(336012)(81156014)(8936002)(6636002)(82310400002)(2616005)(426003)(36756003)(47076004)(186003)(5660300002)(26005)(30864003)(70206006)(70586007)(82740400003)(478600001)(54906003)(316002)(6666004)(4326008)(81166007)(356005)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9644a97-419e-4d41-81fe-08d7e6779372
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4415659279ADA16986CC75D2E5D20@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jc4k+A31cSXY0ohOWnd6Kp8zcpL9+rAqTjSQRXs2RUW3+Nc7B0bLiywDq0eygANEZGe0DW+F91lcOdpZAu5jek2ZORI9knxYnccw5r20yBiYWYsQ0PQRQpeJFixIOqXQbOZf6ABWFbNYSq3Z9AClCJoJnGGQXGn7qg7THgM4asndy+NYjv1csKDjHxsQawThyUTh55ojUDI/jylJvMUI7VZz2WvWPO+tXzo5XoENHt3gilfVtcCshHnPMnTCJvW6jVbx62jT7UWAMsPE8re7rh8lAmcNB8iPQPaE/JVu78kFEt+3C9f7G+Lmsnp38eXUi0nVxsnYvM6Uus3FEU6K9DYhGyMuuAOlN9L385ctbMQkKJYepECR/LBPtXfvic1YqRZ8zViluAbqjsqN24o85fQ7Qqwifm6VMyStRKGW7wDkYiPXPtmhbT07xFmBC2wRmd4LeIj+f1qus197+vhz8LHcBhGCvbppfedjCP/H/RW2cninK1ZTPdtNqRzAo5bMRchK50AS5ITJbdWr+qUaYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 04:42:34.5036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9644a97-419e-4d41-81fe-08d7e6779372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  12 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 129 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  34 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  12 +-
 12 files changed, 211 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e1d4cfe7a9f..4530e0de4257 100644
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
@@ -1028,6 +1028,11 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
+int amdgpu_gfx_kiq_lock(struct amdgpu_kiq *kiq, bool read);
+void amdgpu_gfx_kiq_unlock(struct amdgpu_kiq *kiq);
+
+void amdgpu_gfx_kiq_consume(struct amdgpu_kiq *kiq, uint32_t *offs);
+void amdgpu_gfx_kiq_restore(struct amdgpu_kiq *kiq, uint32_t *offs);
 /*
  * Registers read & write functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 691c89705bcd..034c9f416499 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -309,6 +309,7 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 			    uint32_t doorbell_off)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v10_compute_mqd *m;
 	uint32_t mec, pipe;
@@ -324,13 +325,19 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_lock(kiq, false);
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
@@ -350,8 +357,9 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
 	amdgpu_ring_commit(kiq_ring);
 
+	amdgpu_gfx_kiq_restore(kiq, NULL);
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	amdgpu_gfx_kiq_unlock(&adev->gfx.kiq);
 	release_queue(kgd);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..f243d9990ced 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -307,6 +307,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 			    uint32_t doorbell_off)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v9_mqd *m;
 	uint32_t mec, pipe;
@@ -322,13 +323,19 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_lock(kiq, false);
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
@@ -348,8 +355,9 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
 	amdgpu_ring_commit(kiq_ring);
 
+	amdgpu_gfx_kiq_restore(kiq, NULL);
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	amdgpu_gfx_kiq_unlock(&adev->gfx.kiq);
 	release_queue(kgd);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ea576b4260a4..c6b1c77b5eac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -295,23 +295,99 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+void amdgpu_gfx_kiq_reg_offs_get(struct amdgpu_kiq *kiq,
+				 uint32_t *offset)
+{
+	uint32_t tmp = 0;
+
+	tmp = find_first_zero_bit(kiq->used,
+				      kiq->num_slot);
+	if (tmp < kiq->num_slot) {
+		__set_bit(tmp, kiq->used);
+		*offset = kiq->reg_val_offs[tmp];
+	}
+}
+
+void amdgpu_gfx_kiq_reg_offs_free(struct amdgpu_kiq *kiq,
+				 uint32_t offset)
+{
+	uint32_t tmp = 0;
+
+	tmp = (offset - kiq->reg_val_offs[0]) >> 3;
+	if (tmp < kiq->num_slot)
+		__clear_bit(tmp, kiq->used);
+}
+
+int amdgpu_gfx_kiq_lock(struct amdgpu_kiq *kiq, bool read)
+{
+	int retry = MAX_KIQ_REG_TRY;
+
+	BUG_ON(in_interrupt());
+	while (retry-- > 0) {
+		spin_lock(&kiq->ring_lock);
+		if ((atomic64_read(&kiq->submit_avail) > 0) &&
+		    (read ? find_first_zero_bit(kiq->used, kiq->num_slot) <
+		     kiq->num_slot : 1)) {
+				break;
+		} else {
+			spin_unlock(&kiq->ring_lock);
+			msleep(2);
+			continue;
+		}
+
+	}
+
+	if (retry > 0)
+		return 0;
+	else
+		return -ETIME;
+}
+
+void amdgpu_gfx_kiq_unlock(struct amdgpu_kiq *kiq)
+{
+	spin_unlock(&kiq->ring_lock);
+}
+
+void amdgpu_gfx_kiq_consume(struct amdgpu_kiq *kiq, uint32_t *offs)
+{
+	atomic64_dec(&kiq->submit_avail);
+	if (offs)
+		amdgpu_gfx_kiq_reg_offs_get(kiq, offs);
+
+}
+
+void amdgpu_gfx_kiq_restore(struct amdgpu_kiq *kiq, uint32_t *offs)
+{
+	atomic64_inc(&kiq->submit_avail);
+	if (offs)
+		amdgpu_gfx_kiq_reg_offs_free(kiq, *offs);
+}
+
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
 			     struct amdgpu_irq_src *irq)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	int r = 0;
+	int r = 0, i, j;
 
 	spin_lock_init(&kiq->ring_lock);
 
-	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
-	if (r)
-		return r;
+	for (i = 0; i < MAX_KIQ_RREG_NUM; i++) {
+		r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs[i]);
+		if (r) {
+			for (j = 0; j < i; j++)
+				amdgpu_device_wb_free(adev, kiq->reg_val_offs[j]);
+			return r;
+		}
+	}
 
 	ring->adev = NULL;
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.kiq;
+	kiq->num_slot = MAX_KIQ_RREG_NUM;
+	memset(&kiq->used, 0, sizeof(kiq->used));
+
 
 	r = amdgpu_gfx_kiq_acquire(adev, ring);
 	if (r)
@@ -325,13 +401,20 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
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
+	struct amdgpu_kiq *kiq = &ring->adev->gfx.kiq;
+	int i = 0;
+
+	for (i = 0; i < MAX_KIQ_RREG_NUM; i++)
+		amdgpu_device_wb_free(ring->adev, kiq->reg_val_offs[i]);
 	amdgpu_ring_fini(ring);
 }
 
@@ -671,19 +754,24 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
+	uint32_t seq, reg_val_offs = 0, value = 0;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, true);
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
+	amdgpu_gfx_kiq_unlock(kiq);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -707,9 +795,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
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
@@ -717,19 +810,24 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 {
 	signed long r, cnt = 0;
-	unsigned long flags;
 	uint32_t seq;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_wreg);
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, false);
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
+	amdgpu_gfx_kiq_unlock(kiq);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -754,8 +852,11 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
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
index 634746829024..bb05594c27e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -96,6 +96,7 @@ struct kiq_pm4_funcs {
 	int invalidate_tlbs_size;
 };
 
+#define MAX_KIQ_RREG_NUM 64
 struct amdgpu_kiq {
 	u64			eop_gpu_addr;
 	struct amdgpu_bo	*eop_obj;
@@ -103,7 +104,10 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
-	uint32_t			reg_val_offs;
+	uint32_t		reg_val_offs[MAX_KIQ_RREG_NUM];
+	atomic64_t		submit_avail;
+	uint32_t		num_slot;
+	unsigned long		used[DIV_ROUND_UP(MAX_KIQ_RREG_NUM, BITS_PER_LONG)];
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f61664ee4940..b0ea4f67a6e1 100644
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
@@ -308,6 +309,7 @@ static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
 {
 	if (ring->count_dw <= 0)
 		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
+
 	ring->ring[ring->wptr++ & ring->buf_mask] = v;
 	ring->wptr &= ring->ptr_mask;
 	ring->count_dw--;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..dd54ea802a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -56,13 +56,19 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	unsigned long flags;
 	uint32_t seq;
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, false);
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
+	amdgpu_gfx_kiq_unlock(kiq);
 
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
index 84fcf842316d..f7dd1036986e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4042,14 +4042,20 @@ static int gfx_v9_0_soft_reset(void *handle)
 static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 {
 	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
+	uint32_t seq, reg_val_offs;
+	uint64_t value = 0;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_lock(kiq, true);
+	if (r) {
+		pr_err("failed to lock kiq\n");
+		goto failed_kiq_exit;
+	}
+
+	amdgpu_gfx_kiq_consume(kiq, &reg_val_offs);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 9 |	/* src: register*/
@@ -4059,12 +4065,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
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
+	amdgpu_gfx_kiq_unlock(kiq);
 
 	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
@@ -4088,10 +4094,14 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
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
@@ -5482,10 +5492,10 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
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
@@ -5494,9 +5504,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
index 30b75d79efdb..6b4dc0ed4fff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -422,20 +422,28 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_lock(kiq, false);
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
+		amdgpu_gfx_kiq_unlock(kiq);
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
index fecdbc471983..6238702c80b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -613,7 +613,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (vega20_xgmi_wa)
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_lock(kiq, false);
+		if (r) {
+			pr_err("failed to lock kiq\n");
+			return -ETIME;
+		}
+
+		amdgpu_gfx_kiq_consume(kiq, NULL);
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, ndw);
 		if (vega20_xgmi_wa)
@@ -623,13 +629,15 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		amdgpu_gfx_kiq_unlock(kiq);
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
