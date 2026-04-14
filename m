Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B03F531E6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 02:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF52E10E559;
	Tue, 14 Apr 2026 02:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uP3evgo3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C2910E559
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 02:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct+wGzL7uECXwbHHp8rb4YYLy+TsRMSZCmGtmoJ7QHyVsbrtbI/A9k4y6bPruFP1HMcev3MienvFoW77xybdXFWBBIfENdNSlgiuB8RltM9rqBdFafrGmvEbP3Ac0nIu7a1AOVA+D99EGIdk3xrm+cklHAP508asvUMjyVUv7OomiF51HocMNo4UhH5pSaVgLLEA7JzzYY6dwUVRBzHFhwl7BIeAoxlTAvFw3BIXrgX1znnt/MjZ5ybxVc2QNPLGoze+4KirusKP0oxh08tUAxnzwb2SaoJ3ISXLX0+Otuwu5R79CQQoSUrX572UY91m4fA9az5oJtYzEjtEjQcNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etIL2v1NFjVA9w0xpMxVOO3yYfj39X5j1xLk8HeoUA8=;
 b=aP7E2lfuKXhZTJUW7fPDS1QtYr9BSJ8oL3l3RPzsElIvI5+gHznKR0sNtjfRSvawaafS+zks4ed3cYrF8/csS+KYU8mbAiZxFeneYtfUOiuRAM/7STmqUtg04pe0oTCu22YEmMoxcMkGTJLaTscD/FYq3cUGlIBgTcdQ1vdUi4/j4bgRNS3WsP4dNiabPCH+SCBiUc7er/1SzeIBeGEP39FOe04kiPgIdMj/0umaBqhAHQS93H/f389fzQ+jWyEHtISia6BmWoHVCnKwilbJ4P47tWHIe+ASqUQA6fTjC5P6kfA+Lsjrh7B/41x43nzAZs4mRpCGxkv0H/Sa6Mnr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etIL2v1NFjVA9w0xpMxVOO3yYfj39X5j1xLk8HeoUA8=;
 b=uP3evgo3/+TzZG+W4h+/zWgVRgTk1MHagBkJB2mWJfl3ppD5kXYJRzogRxWG0EySmq8qZ9kX+IO5LIR79QqUOHROq4TJZwVRCejjv3etxMNk7ep6ggrxI+K5r3/yhnaSCjlq/+mYzRoRgMAozmmur+cCBUJuUYvjW6dJ5rw9Kio=
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 02:26:54 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::fe) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 02:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 02:26:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 21:26:52 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3] drm/amdgpu: drop userq fence driver refs out of fence
 process()
Date: Tue, 14 Apr 2026 10:26:43 +0800
Message-ID: <20260414022643.3469481-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: e867529f-342a-403d-83f3-08de99cd4b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xACZ8s0NCmSrkvMSD98HGB1c6+k9e3PX8oMBAWpTxXClS+TiY8+Z0IpMHQ2b5AQ1qDxnCHpsQ3dQ+U/0QVED4wakYP0WQdpgCQRhYHU55SnkMmW4Qpkz6sk9cw/qXm1kuGVp5++jxfpGRUHE2fa0bol60ah4CxTyNUBzVSs89IApsr3oStkhEIdUv2Q5Q4gt+QLAaVke8K0Q8/6zWdbjklqTAuiK7SZQvCv8f4q0pwIy8UbIg/oTWcxMPbdhS/Qqe6wKIg9f7gSEc3kMvJ28PDConPizY+3m1SQ8kWcaP1RZ9EZJe0ZZWk1rYM90gOT7bSyf8S+/7P1M5PVBdnw0t6uEPbDx6aH/eE1ttaq1pxwmd/RFIkWdTF0lox2A0rOkkd/4wiighyISWJUwhCt9ulM1JokcedT0OMmw90r2jvlRVYUuJpq0wKKP9w4032DG3Il222FbsNCiUqVuFO7jSpgQA88cBNuA0jzRaS7kwCODXqL/HW5S6Otxq6punOtS2g2mYbctI8juuN7y7iPF45D6xtCU4NSvszhaXFR8mTTL0/L8ehCfOCMfeQrq4dKTW3V0TLIuSm6RQIc4fbX6qAbtfQBgV9y29F7Q6WRW4Ng82EBxMOPh0fPghIRHiYM2qhJxHZz7qY+bJYRch78K+EepnsVMB/9G1IGqwfA34MiPJaHr59d8TZp0Q7EdCT8B5O+GuW1mmBBOFKIi+e9ZQhTrH8wVPTjhpOkJO8Bg/9s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rKc0bcNFxoMZVTgzZK+Ikb/26c3JY6yD8razY2Mou6fduADbnKzfWXbTVn3zv8K9LEeYQAla3kHGwIQBTsH7fNHB9mWr6QxbVlj8Oo9bZGDTV7upnKCKpYnH0q8A0N1Tf9zmErVNqRCfMlVNo78Hx9wwIBTuAew4ES/k6f1PoJps6MJ2J/i6elmQiR1NhXHGmWdtTQtyc5qfb0trekwy+rkfWC7lxnL1NU8CAMq+ooLZ/B9KcMunHDR55LHzEl7nizRSEBOuNgTmavHy85yn4DHEkFlwq4KVasvhVptz6DeNQFfZag/bS0sCCHywAcF/2zFh/VuNkP9NPJb7yLxibd29DVpMmu12gcXKk6ITu6QmkriZASvXK8GiwC4Yat9G7k+LSHScncd8JDgo33f6FuZIUWIfTXlW41/51UBZeMilyNaS8zSLBCG/IoRx5WWs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 02:26:53.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e867529f-342a-403d-83f3-08de99cd4b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
created, those references are transferred into userq_fence->fence_drv_array
so they can be released when the fence completes.

However, those inherited references are currently only dropped from
amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
such as it is already signaled when created, so we need to explicitly release
those fences in that case.

v2: use a list(list_cut_before) for managing the signal userq driver fences.(Christian)
    Link: https://patchwork.freedesktop.org/patch/718078/?series=164763&rev=2
v3: Doesn't cache the userq first unsignaled fence and use the cut before list
    head directly.(Christian)

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 49 +++++++++++++------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3be80a82788a..d4dd0cab7dce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -145,35 +145,51 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
 
+static void
+amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
+{
+	unsigned long i;
+	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
+		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+	userq_fence->fence_drv_array_count = 0;
+}
+
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
 	unsigned long flags;
 	u64 rptr;
-	int i;
+	LIST_HEAD(to_be_signaled);
 
 	if (!fence_drv)
 		return;
 
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
+	userq_fence = NULL;
+	fence = NULL;
 
-	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
-		fence = &userq_fence->base;
-
-		if (rptr < fence->seqno)
+	list_for_each_entry(userq_fence, &fence_drv->fences, link) {
+		if (rptr < userq_fence->base.seqno)
 			break;
+	}
 
-		dma_fence_signal(fence);
-
-		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+	list_cut_before(&to_be_signaled, &fence_drv->fences,
+				&userq_fence->link);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
-		list_del(&userq_fence->link);
+	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
+		fence = &userq_fence->base;
+		list_del_init(&userq_fence->link);
+		dma_fence_signal(fence);
+		/* Drop fence_drv_array outside fence_list_lock
+		 * to avoid the recursion lock.
+		 */
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
 		dma_fence_put(fence);
 	}
-	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
@@ -228,6 +244,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence *fence;
 	unsigned long flags;
+	bool signaled = false;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -275,13 +292,17 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	/* Check if hardware has already processed the job */
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	if (!dma_fence_is_signaled(fence))
+	if (!dma_fence_is_signaled(fence)) {
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
-	else
+	} else {
+		signaled = true;
 		dma_fence_put(fence);
-
+	}
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
+	if (signaled)
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+
 	*f = fence;
 
 	return 0;
-- 
2.34.1

