Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97224EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 07:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2274210E23F;
	Wed,  9 Aug 2023 07:14:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A6910E23F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 07:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAR+i4047L7kL/w53CN34cMTiR3F2cknTW3shdvRmHZeRvyguKoywY3bFSlKUPHJczosh2sgaBE48c0LZpK+ayBrt7Y5LSAkvSASmT7TjycjcL+J+TSJwzW6tJvzNEpQHLR5Fir8y0cutoKgorrQR5afRKc3PTtxFVse+PG+rL9DnpNWSik/LA0YAj5wOJqiB3mty0cmLXONCBl2BgyIPw5xC4O01yJ7b+wC+zZkB8rduzHIff53Ro0N/ZZ5V/du5fFBeAjwVaXyAjz13yjp0z8G0Kt5IK0UhYuV5YFNstFheiNtgI+fCtuwG7/MvkOUqo7NBfD1eXe83uaF+24xPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PoOvxWvqbal8YPY+gHXnwdoAOHJ2ooWOgda/hG0doE=;
 b=dOPVejaaRQPy+FZNN0NDTPvDXqtjOzBXaF8i1Y/h54cR0NlvquHzRZtqxrMBzlITiZs9/ad30XYAU7y9GKk0UYiZ3VhHAvbeuKY0/YnAnWjd7c8vvlQsWQ7IQPDH9FR/OB2EAaLQFsoOVe6N6s9f8E283ziNbV4yOiCT5E/FeU4WNQJwRj8oLKCXVz4EG7n4/tA2CU+o4x0ahZDUNcofUjoN80KBtHIzT+m0PIPAVGyI9Bj0WXtgAzGTE0eZDZ79d8lUGRurE6eD9o3hfXsTgDQsIvjj2z1MtbiTj1PseHs9iiPgu/QH4WiYTS668UKOyDqf27V+8ympg2sejLv66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PoOvxWvqbal8YPY+gHXnwdoAOHJ2ooWOgda/hG0doE=;
 b=IdLtKLeqW8ad7Rgr4qkozydzsVguQYcZPDDkFBGJnymcp8DXnRYNjX0xU0QXPVvYfjZXMSvVA1MUqpB99A5C4bwt8zFAiVtDw52JV970uWIkE1LUa0udFTxDSWRiY++IAmqE2JuRr4JXhMtfU13HO7vje4Kwu3GusUqX9lVM664=
Received: from SJ0PR13CA0121.namprd13.prod.outlook.com (2603:10b6:a03:2c6::6)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 07:14:29 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::59) by SJ0PR13CA0121.outlook.office365.com
 (2603:10b6:a03:2c6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Wed, 9 Aug 2023 07:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 07:14:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 02:14:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/radeon: Cleanup radeon/radeon_fence.c
Date: Wed, 9 Aug 2023 12:44:07 +0530
Message-ID: <20230809071407.241915-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 551b7252-36b1-41fc-cf24-08db98a84572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTMpmkLukkkH0n54/MgrbvG8uSMwdBNGokUEdvTAaJ+Rr4sf44uXb24FO0Lh3RDfuGZdcNObTszfM1F4dpuUyt8gZPd7mpJc/C/QrgdWWiZb/XcPZymRaFJRmPim7eoEUi9OE/dGhSDiFJBmbufQ3s/S51YH6fmQkGrQ4mQrBc9eFFuBkhZyePeOkGh0zEY4tBTF8vHKvCaZX4qk1o0DYboo3ceLm4tCziTraCo7hcEZhVvJa74mXXcAgOwJ4dtXiIdbzp21q0r19dhKFGBbjOPysVSgceRZ5F/mTWYO7hfqhsTV6eLb5lMKwMHxCOWb+qf6GN+mQaS3FyIN8Gz+rw3JousR8xiI/s6qlA+1JgfeZcgkY2OIKFfu1Zq0chMIzfIsfSavg9b3T4sGzoCx8dFJVPN5/jh931izDGUs5zSN1u5NNL9kyaI3wDo6Fn4tj6OS5xK5eBNqKgKFzbTANkYTkMPUkbCc1xCg8j9Hx8B0CJz0sAruR0n33I/7Ojb5+MUbNs/wGJwEvuEXfHK5Ca3PCd14trc7qT8fHv3o4T85PrAW5BZB10STFg+wtZpNH+MEKgnXp+weDZrhAZo08wRUTjtuOLIOjGwR7V9R0UvNcYYMkC9P3GbRNZ7yMJDFssvDl4GfXJ7UaekoaDeSmsuVbuJNgcMXKZbDlRFm8cMfMfJeOT0KAMoNLYfjdU768aN2bHbnUXZ77QRtOBoautxY2d6kYBH5Gl40yjRQGmNtnVWtVj/U+zOnVvUUBnzp3chTY16HrCaZai5bsn2S4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(1800799006)(82310400008)(186006)(36840700001)(40470700004)(46966006)(40480700001)(54906003)(2616005)(40460700003)(336012)(110136005)(478600001)(26005)(81166007)(82740400003)(7696005)(36756003)(1076003)(86362001)(356005)(41300700001)(316002)(5660300002)(8936002)(8676002)(30864003)(44832011)(2906002)(4326008)(6636002)(70206006)(16526019)(70586007)(6666004)(83380400001)(47076005)(36860700001)(66574015)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:14:28.8730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551b7252-36b1-41fc-cf24-08db98a84572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: Possible repeated word: 'Fences'
WARNING: Missing a blank line after declarations
WARNING: braces {} are not necessary for single statement blocks
WARNING: braces {} are not necessary for any arm of this statement
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: quoted string split across lines
WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 111 ++++++++++++--------------
 1 file changed, 52 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 2749dde5838f..9ebe4a0b9a6c 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -45,7 +45,6 @@
 #include "radeon_trace.h"
 
 /*
- * Fences
  * Fences mark an event in the GPUs pipeline and are used
  * for GPU/CPU synchronization.  When the fence is written,
  * it is expected that all buffers associated with that fence
@@ -67,10 +66,10 @@
 static void radeon_fence_write(struct radeon_device *rdev, u32 seq, int ring)
 {
 	struct radeon_fence_driver *drv = &rdev->fence_drv[ring];
+
 	if (likely(rdev->wb.enabled || !drv->scratch_reg)) {
-		if (drv->cpu_addr) {
+		if (drv->cpu_addr)
 			*drv->cpu_addr = cpu_to_le32(seq);
-		}
 	} else {
 		WREG32(drv->scratch_reg, seq);
 	}
@@ -91,11 +90,10 @@ static u32 radeon_fence_read(struct radeon_device *rdev, int ring)
 	u32 seq = 0;
 
 	if (likely(rdev->wb.enabled || !drv->scratch_reg)) {
-		if (drv->cpu_addr) {
+		if (drv->cpu_addr)
 			seq = le32_to_cpu(*drv->cpu_addr);
-		} else {
+		else
 			seq = lower_32_bits(atomic64_read(&drv->last_seq));
-		}
 	} else {
 		seq = RREG32(drv->scratch_reg);
 	}
@@ -139,9 +137,9 @@ int radeon_fence_emit(struct radeon_device *rdev,
 
 	/* we are protected by the ring emission mutex */
 	*fence = kmalloc(sizeof(struct radeon_fence), GFP_KERNEL);
-	if ((*fence) == NULL) {
+	if ((*fence) == NULL)
 		return -ENOMEM;
-	}
+
 	(*fence)->rdev = rdev;
 	(*fence)->seq = seq = ++rdev->fence_drv[ring].sync_seq[ring];
 	(*fence)->ring = ring;
@@ -163,7 +161,8 @@ int radeon_fence_emit(struct radeon_device *rdev,
  * for the fence locking itself, so unlocked variants are used for
  * fence_signal, and remove_wait_queue.
  */
-static int radeon_fence_check_signaled(wait_queue_entry_t *wait, unsigned mode, int flags, void *key)
+static int radeon_fence_check_signaled(wait_queue_entry_t *wait,
+				       unsigned int mode, int flags, void *key)
 {
 	struct radeon_fence *fence;
 	u64 seq;
@@ -197,7 +196,7 @@ static int radeon_fence_check_signaled(wait_queue_entry_t *wait, unsigned mode,
 static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
 {
 	uint64_t seq, last_seq, last_emitted;
-	unsigned count_loop = 0;
+	unsigned int count_loop = 0;
 	bool wake = false;
 
 	/* Note there is a scenario here for an infinite loop but it's
@@ -231,9 +230,9 @@ static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
 			seq |= last_emitted & 0xffffffff00000000LL;
 		}
 
-		if (seq <= last_seq || seq > last_emitted) {
+		if (seq <= last_seq || seq > last_emitted)
 			break;
-		}
+
 		/* If we loop over we don't want to return without
 		 * checking if a fence is signaled as it means that the
 		 * seq we just read is different from the previous on.
@@ -296,8 +295,7 @@ static void radeon_fence_check_lockup(struct work_struct *work)
 	else if (radeon_ring_is_lockup(rdev, ring, &rdev->ring[ring])) {
 
 		/* good news we believe it's a lockup */
-		dev_warn(rdev->dev, "GPU lockup (current fence id "
-			 "0x%016llx last fence id 0x%016llx on ring %d)\n",
+		dev_warn(rdev->dev, "GPU lockup (current fence id 0x%016llx last fence id 0x%016llx on ring %d)\n",
 			 (uint64_t)atomic64_read(&fence_drv->last_seq),
 			 fence_drv->sync_seq[ring], ring);
 
@@ -338,16 +336,16 @@ void radeon_fence_process(struct radeon_device *rdev, int ring)
  * radeon_fence_signaled().
  */
 static bool radeon_fence_seq_signaled(struct radeon_device *rdev,
-				      u64 seq, unsigned ring)
+				      u64 seq, unsigned int ring)
 {
-	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq) {
+	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
-	}
+
 	/* poll new last sequence at least once */
 	radeon_fence_process(rdev, ring);
-	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq) {
+	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
-	}
+
 	return false;
 }
 
@@ -355,20 +353,18 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 {
 	struct radeon_fence *fence = to_radeon_fence(f);
 	struct radeon_device *rdev = fence->rdev;
-	unsigned ring = fence->ring;
+	unsigned int ring = fence->ring;
 	u64 seq = fence->seq;
 
-	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq) {
+	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
-	}
 
 	if (down_read_trylock(&rdev->exclusive_lock)) {
 		radeon_fence_process(rdev, ring);
 		up_read(&rdev->exclusive_lock);
 
-		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq) {
+		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 			return true;
-		}
 	}
 	return false;
 }
@@ -451,7 +447,7 @@ bool radeon_fence_signaled(struct radeon_fence *fence)
  */
 static bool radeon_fence_any_seq_signaled(struct radeon_device *rdev, u64 *seq)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < RADEON_NUM_RINGS; ++i) {
 		if (seq[i] && radeon_fence_seq_signaled(rdev, seq[i], i))
@@ -549,9 +545,8 @@ long radeon_fence_wait_timeout(struct radeon_fence *fence, bool intr, long timeo
 
 	seq[fence->ring] = fence->seq;
 	r = radeon_fence_wait_seq_timeout(fence->rdev, seq, intr, timeout);
-	if (r <= 0) {
+	if (r <= 0)
 		return r;
-	}
 
 	dma_fence_signal(&fence->base);
 	return r;
@@ -571,11 +566,11 @@ long radeon_fence_wait_timeout(struct radeon_fence *fence, bool intr, long timeo
 int radeon_fence_wait(struct radeon_fence *fence, bool intr)
 {
 	long r = radeon_fence_wait_timeout(fence, intr, MAX_SCHEDULE_TIMEOUT);
-	if (r > 0) {
+
+	if (r > 0)
 		return 0;
-	} else {
+	else
 		return r;
-	}
 }
 
 /**
@@ -596,15 +591,14 @@ int radeon_fence_wait_any(struct radeon_device *rdev,
 			  bool intr)
 {
 	uint64_t seq[RADEON_NUM_RINGS];
-	unsigned i, num_rings = 0;
+	unsigned int i, num_rings = 0;
 	long r;
 
 	for (i = 0; i < RADEON_NUM_RINGS; ++i) {
 		seq[i] = 0;
 
-		if (!fences[i]) {
+		if (!fences[i])
 			continue;
-		}
 
 		seq[i] = fences[i]->seq;
 		++num_rings;
@@ -615,9 +609,9 @@ int radeon_fence_wait_any(struct radeon_device *rdev,
 		return -ENOENT;
 
 	r = radeon_fence_wait_seq_timeout(rdev, seq, intr, MAX_SCHEDULE_TIMEOUT);
-	if (r < 0) {
+	if (r < 0)
 		return r;
-	}
+
 	return 0;
 }
 
@@ -638,13 +632,16 @@ int radeon_fence_wait_next(struct radeon_device *rdev, int ring)
 
 	seq[ring] = atomic64_read(&rdev->fence_drv[ring].last_seq) + 1ULL;
 	if (seq[ring] >= rdev->fence_drv[ring].sync_seq[ring]) {
-		/* nothing to wait for, last_seq is
-		   already the last emited fence */
+		/* nothing to wait for, last_seq is already
+		 * the last emited fence
+		 */
 		return -ENOENT;
 	}
+
 	r = radeon_fence_wait_seq_timeout(rdev, seq, false, MAX_SCHEDULE_TIMEOUT);
 	if (r < 0)
 		return r;
+
 	return 0;
 }
 
@@ -704,9 +701,8 @@ void radeon_fence_unref(struct radeon_fence **fence)
 	struct radeon_fence *tmp = *fence;
 
 	*fence = NULL;
-	if (tmp) {
+	if (tmp)
 		dma_fence_put(&tmp->base);
-	}
 }
 
 /**
@@ -719,7 +715,7 @@ void radeon_fence_unref(struct radeon_fence **fence)
  * Returns the number of emitted fences on the ring.  Used by the
  * dynpm code to ring track activity.
  */
-unsigned radeon_fence_count_emitted(struct radeon_device *rdev, int ring)
+unsigned int radeon_fence_count_emitted(struct radeon_device *rdev, int ring)
 {
 	uint64_t emitted;
 
@@ -730,10 +726,10 @@ unsigned radeon_fence_count_emitted(struct radeon_device *rdev, int ring)
 	emitted = rdev->fence_drv[ring].sync_seq[ring]
 		- atomic64_read(&rdev->fence_drv[ring].last_seq);
 	/* to avoid 32bits warp around */
-	if (emitted > 0x10000000) {
+	if (emitted > 0x10000000)
 		emitted = 0x10000000;
-	}
-	return (unsigned)emitted;
+
+	return (unsigned int)emitted;
 }
 
 /**
@@ -751,19 +747,16 @@ bool radeon_fence_need_sync(struct radeon_fence *fence, int dst_ring)
 {
 	struct radeon_fence_driver *fdrv;
 
-	if (!fence) {
+	if (!fence)
 		return false;
-	}
 
-	if (fence->ring == dst_ring) {
+	if (fence->ring == dst_ring)
 		return false;
-	}
 
 	/* we are protected by the ring mutex */
 	fdrv = &fence->rdev->fence_drv[dst_ring];
-	if (fence->seq <= fdrv->sync_seq[fence->ring]) {
+	if (fence->seq <= fdrv->sync_seq[fence->ring])
 		return false;
-	}
 
 	return true;
 }
@@ -780,23 +773,21 @@ bool radeon_fence_need_sync(struct radeon_fence *fence, int dst_ring)
 void radeon_fence_note_sync(struct radeon_fence *fence, int dst_ring)
 {
 	struct radeon_fence_driver *dst, *src;
-	unsigned i;
+	unsigned int i;
 
-	if (!fence) {
+	if (!fence)
 		return;
-	}
 
-	if (fence->ring == dst_ring) {
+	if (fence->ring == dst_ring)
 		return;
-	}
 
 	/* we are protected by the ring mutex */
 	src = &fence->rdev->fence_drv[fence->ring];
 	dst = &fence->rdev->fence_drv[dst_ring];
 	for (i = 0; i < RADEON_NUM_RINGS; ++i) {
-		if (i == dst_ring) {
+		if (i == dst_ring)
 			continue;
-		}
+
 		dst->sync_seq[i] = max(dst->sync_seq[i], src->sync_seq[i]);
 	}
 }
@@ -895,9 +886,8 @@ void radeon_fence_driver_init(struct radeon_device *rdev)
 	int ring;
 
 	init_waitqueue_head(&rdev->fence_queue);
-	for (ring = 0; ring < RADEON_NUM_RINGS; ring++) {
+	for (ring = 0; ring < RADEON_NUM_RINGS; ring++)
 		radeon_fence_driver_init_ring(rdev, ring);
-	}
 
 	radeon_debugfs_fence_init(rdev);
 }
@@ -1023,6 +1013,7 @@ static const char *radeon_fence_get_driver_name(struct dma_fence *fence)
 static const char *radeon_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct radeon_fence *fence = to_radeon_fence(f);
+
 	switch (fence->ring) {
 	case RADEON_RING_TYPE_GFX_INDEX: return "radeon.gfx";
 	case CAYMAN_RING_TYPE_CP1_INDEX: return "radeon.cp1";
@@ -1032,7 +1023,9 @@ static const char *radeon_fence_get_timeline_name(struct dma_fence *f)
 	case R600_RING_TYPE_UVD_INDEX: return "radeon.uvd";
 	case TN_RING_TYPE_VCE1_INDEX: return "radeon.vce1";
 	case TN_RING_TYPE_VCE2_INDEX: return "radeon.vce2";
-	default: WARN_ON_ONCE(1); return "radeon.unk";
+	default:
+		WARN_ON_ONCE(1);
+		return "radeon.unk";
 	}
 }
 
-- 
2.25.1

