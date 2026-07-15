Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF1FC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FED910F0B7;
	Wed, 15 Jul 2026 13:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEwg48vx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DE910F0B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsMcZhPTJXffazTHcHMPU/2f6GYaol9nhgCGwRTnLGZJsdtbtMfDSXLWK3jR3uKfWVQ11old0t0No+Rif87+8cDZXdduJYDdQmZGDcIAIjM42c7NzLZCv6PhJ9GQ8q3Mx0Yx36pgCfGYoDQrLTjBUvhWvzdF0n4c5KFiXceBr2yuuj4hvKQTBAynghPgbCuJTsNdAFaI8roxz2UrAd7olNtHlVx6ZI2PYEFmbRrvsiiwoYwukIUK8zZ3aPUpM2Oat7SderEliiqzXnh1dDLAFx1YB7J2DdvIO9zN4by6UnMHighgEeKUf/BUdxOsZRcGRP3jdf2wt29VCzn3XIwKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WomUek6dDXyw15Y4OGjYaJVd0JZAnhg0cBdGiLfby5o=;
 b=JeP78d2tdA/8mGFb9Bw2NjGh+I74KaQWj/0oS5nYCmW2csqIfR4O7BTux6NL/OJuCUzdsmNf65c8mPsyIFRDUZCRCJT8T9xX4v0rwoOOVoSB41J+ZyEH8OqBbb/2DLA7q+/2/FwefS7a8rddEHDTR6jSUT8+xpQHat8TEnxsxi7uXMDaMpqYnCYRxF0zwnKbyfn5rAtm+L7w+pQ/HrpjfNBwJs2wZbIa5fXqK2dJurV3QWZ22ZH2VCL+bdxeMZTrdS43hf17evlr7Y6IxMElHX5MidguGCeMad3+y0+qwV9LWTEOJkM3mioH4kmlQLdcj2qvrTK2/l4VFoNAK4yvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WomUek6dDXyw15Y4OGjYaJVd0JZAnhg0cBdGiLfby5o=;
 b=TEwg48vxlC21mnbCRuJZ4dv0vmmCf9zJq1LSrBuwMlwhaAalTHL/GzBLOXR+A7l2FwXLA9EYQdJszP92FjJHgGc9ZZ1XyaFESsWM1OwgTshvbBAtnvDDR3lRh+VKy/afTD6u2lUsjCjE1sHPmlW8ktL0LaaptwYFjgeQE8zSNLw=
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:49:13 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::6e) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:49:12 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:49:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Geoffrey McRae <geoffrey.mcrae@amd.com>, "Bhawanpreet
 Lakha" <bhawanpreet.lakha@amd.com>
Subject: [PATCH 68/70] drm/amd/display: Flush IRQ workqueue in schedule-work
 tests
Date: Wed, 15 Jul 2026 21:38:18 +0800
Message-ID: <20260715134432.1975118-69-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab72152-7ea1-4471-5aee-08dee277dabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: UmvbUzhfVu5m2otC8PgDFa+ffHOaCwUk+5V8Q2NcV18beQxgA0OTFRmTUP86fE1aiUgNC1u8tpvnd75QbvmIeunWvQloSECKip0IVloB7JA44cJIFVZWXRFrDjpqAeN452S5Us+nhr/aWMyGuLniQjyOj8r6m1sJh/AwQ9j8nN6ksk3QmCCe3Sx+6ZJ8sd5bLNWA/5JeP7rl9rioguJ4D0YUBPOOMHVtoMSLykms0/PV5iQ3TDDZdt8wu69H2MsAI7S64lFtiWKwwbSgDwfqhKveqM+UZSmShTgS8O+zDJGG57GYXYFMDGRoWYrzIu3MASwFzkyH9E9iFae6uMdVPv+RXkA6xGyInyaw53SXpv5IivsI6h0GcHduKh3cp9ffbGqHu4COcDiVEXosDczvh2N+fDs036b9EmIXOcp6MZjIwwhxfLFx1K/dY/KYLKqPWyPZ54bu3CEellKmHA/3Ihh1qg5pdhBtmtgKX2FltEeDJOqfnzoFralqqOmF7TnQv/oG8evjsWr2+NNA6jXXKy6O5E/CVckQCRwDSV2OI4CCmHKV+DMc9OsBrVzzakiTcCUAcCwICilZFhU8QrKwC5AObR4M5ukoIGNTJJN70152RjZz2UtbO8fB6mARXWeO2QVGAxCbk8Vbb5TcgllzTkm9RiN97tBrPvwQnC9TbiWFPK88ZFiRZBqIBSilNEUI6qKJ6qbbTcaIJcxdVGVsmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AERD8vhX6ozYQ1FuDcNJ+HSmTPeDc5hqzdYqOQFhbSEb03mqME5GkKtxDgtSoZ/ndBiDnltarWlhNwvz26gzk+UIdvx0RaKdDyCFlTTVbP1tc7+4+2ZpuDO8o4duBmgyrRhRRDKnw15EV0cvKSEqLdN39cYZQbpW5rT/A35C/McNdyoUZ/5cUm0DsR9oEHPT2awf9910W4CXhtKxSloWrjWyDKoyw+e6bPo4T8dPQw3RrPAJ3X2mNbHw/cX23OCelDrq77dfluhe4NAvQlfoeLx36RO3CSSOmcAu5feLbvqV2Ma1Y/Hd/6L3qMaUObud6Ye6Twr1/sJYIYEr0S3unHjkihLAQuC1ecug6iV1HbFpKexpyM5V692CbJpEVP1Jrl6Xd/YKgAWIXdDzyEG8qWzqwkfH/+nReOLaS+bJT7FbSW5eLXnkht43MyP7dwFO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:13.1457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab72152-7ea1-4471-5aee-08dee277dabb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
The tests dm_test_irq_schedule_work_queues_handler,
dm_test_irq_schedule_work_requeue_fallback, and
dm_test_irq_handler_dispatches_work relied on amdgpu_dm_irq_fini()
running each pending low-context work item before freeing the
handlers, and only checked the handler counts afterwards.

amdgpu_dm_irq_fini() now cancels pending work with
cancel_work_sync() instead of flushing it, so work that has not yet
started never runs and the counts stay below the expected values,
failing the tests.

Flush the private DM IRQ workqueue (adev->dm.irq_wq) so the
scheduled handlers complete, check the counts, then tear down.
Flushing this driver-owned workqueue is allowed, unlike the
system-wide workqueues.

Fixes: 258df8e4f860 ("drm/amd/display: Fix DM IRQ teardown races")
Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index ed20e278742d..dc7ef0523b8f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -1842,12 +1842,15 @@ static void dm_test_irq_schedule_work_queues_handler(struct kunit *test)
 	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
 
 	/*
-	 * Low-context work runs asynchronously on system_highpri_wq.
-	 * amdgpu_dm_irq_fini() flushes each pending work item before freeing
-	 * the handlers, so the handler is guaranteed to have run afterwards.
+	 * Low-context work runs asynchronously on the DM IRQ workqueue.
+	 * Flush it so the handler completes before we check the count;
+	 * amdgpu_dm_irq_fini() cancels (rather than runs) any work that is
+	 * still pending, so the flush must happen first.
 	 */
-	amdgpu_dm_irq_fini(adev);
+	flush_workqueue(adev->dm.irq_wq);
 	KUNIT_EXPECT_EQ(test, count, 1);
+
+	amdgpu_dm_irq_fini(adev);
 }
 
 /**
@@ -1858,7 +1861,7 @@ static void dm_test_irq_schedule_work_queues_handler(struct kunit *test)
  * schedule before the work has run makes queue_work() fail for the
  * still-pending item, forcing amdgpu_dm_irq_schedule_work() into the fallback
  * that allocates and queues a fresh handler copy. Both work items run when
- * amdgpu_dm_irq_fini() flushes the queue, so the handler fires twice.
+ * the DM IRQ workqueue is flushed, so the handler fires twice.
  */
 static void dm_test_irq_schedule_work_requeue_fallback(struct kunit *test)
 {
@@ -1880,8 +1883,15 @@ static void dm_test_irq_schedule_work_requeue_fallback(struct kunit *test)
 	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
 	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
 
-	amdgpu_dm_irq_fini(adev);
+	/*
+	 * Flush the DM IRQ workqueue so both work items run before we check
+	 * the count; amdgpu_dm_irq_fini() would cancel any still-pending work
+	 * instead of running it.
+	 */
+	flush_workqueue(adev->dm.irq_wq);
 	KUNIT_EXPECT_EQ(test, count, 2);
+
+	amdgpu_dm_irq_fini(adev);
 }
 
 /* Tests for amdgpu_dm_set_hpd_irq_state() */
@@ -3855,11 +3865,14 @@ static void dm_test_irq_handler_dispatches_work(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, high_count, 1);
 
 	/*
-	 * Low-context work runs asynchronously; amdgpu_dm_irq_fini() flushes
-	 * each pending work item before freeing, so it has run afterwards.
+	 * Low-context work runs asynchronously; flush the DM IRQ workqueue so
+	 * it completes before we check the count. amdgpu_dm_irq_fini() cancels
+	 * any still-pending work rather than running it.
 	 */
-	amdgpu_dm_irq_fini(adev);
+	flush_workqueue(adev->dm.irq_wq);
 	KUNIT_EXPECT_EQ(test, low_count, 1);
+
+	amdgpu_dm_irq_fini(adev);
 }
 
 /* Tests for dm_handle_vmin_vmax_update() */
-- 
2.43.0

