Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0AFF3ED78
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 06:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C25E10E310;
	Mon, 13 Apr 2026 06:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQCGSqwy";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611CF10E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5CHt/d1oirJ/oOBvciqpRY+nzpU485BM4ILovIIapovrW7TuVteZCW3Vao0y48j51WmXl3IA97adS0sAH/JZbi1aOITjBgECsEegk51oX7DB2dvy2QHHxUUM9Pv96vDCLHo7rexcUueG8qJPEdGwz1p3soyNUw/zmuq5SWuTOxSXDCBRs75clXJm2MEg3tw7lYctUmip31iXTihkH+cPyITkxboaOFLBkMgEfH9kGUcD2KrjOLukPKaLil2PM/biohG3V5hOtzEIR3wO2aHI/hoZBXHRaoJlwxq/yqG4hEn6Nfm6tYov/mBZ1/2r4jKMsgUvuR0vo7Hh2XErSpBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAQAkKEZkf8uFUjM4nS2JBiCMQ2l1LBM3f3rT1vWgEM=;
 b=s4jryFCmhUgkjXpYeS2/txmuOqTEcbQkiZnnS8OINyUoJ2cvDhP0krsG2o6uoiI97rHu1gms18dzfgzvyBJpeNSq5XHqll2A+lwsj5n78ae7D1e29MEevgZyY1+q9T5EjYcJkUQqldo333stiEOm0JiffcQr4+lsYGtDSf29JwP2qsu+muCnphn2/MdeDMaPR2/bKBe7FrLQBIf+IS4ZtTBSklHdjSgJrt8xkc+Ir1Qgkp4Ty9ieCklU+kDpsxPjI+xsDHLhFzBJCPe5L6MhSMoAGx0BQG40gYxn6qXxzEQ3atkCypNglOK5Ad2Jis6eoo9vIn1KepStps6Z/90C2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAQAkKEZkf8uFUjM4nS2JBiCMQ2l1LBM3f3rT1vWgEM=;
 b=bQCGSqwyERzt0Q5k0qq4aMebbQFicwyMb88hBmOfjjpHT9C+Ccb3uXDVpdxux1WQeghb6V8B2cP5xhfOTZ0LCYXfbmJaSELT3r6pWrWIWRmbHO3AvgA0djBsinpVgWAtEz/60nxPMnnVDK5HqrwN4BQbsAm0n173+rZGVqoRJds=
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by BN7PPF9507C739C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Mon, 13 Apr
 2026 06:17:55 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::c7) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 06:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 13 Apr 2026 06:17:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 01:17:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: drop userq fence driver refs out of fence
 process()
Date: Mon, 13 Apr 2026 14:17:44 +0800
Message-ID: <20260413061744.3458370-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 19120d4f-3b54-46f0-f254-08de99246659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FyU9pf1vItWZoyDIs7loLlEB4WbF/85yiSV3AaIQWbvZ3zaFArYMDwNnIhFzqxQi4o5nhwBcOtfK4U9bG9AT3a1/2shgTRs5mb9YGn9uaVyIg8wuAv2RcUUsyznofBs12btqp0D3HDiTBzLgx3FvbuRw3UohVHsR4ZKP48ji8+BM0DpPzPZTPT9z3AwTTEBzJ+XWjxeBDGVdr0OEjeKRj7/hyUcEid3wKds9w8SMOHHAcNQQcVx5I9F10ui5sfNXUEYor8EX7ZdDBTBV0bwX68fDf/OVnwPODZxE5jBqbG3hfWqoS+Ailn5qq2NrcvnVQ+akmUDaQDNUxQWb1C1GBaxe8jH8g5c2difqA8WUnSSpOZlrrKEN3nlvKnUqnpf0owO5LQra3D/P1qi2dJAnL87HXnjl7igPcxFa7KcHz0TFx62GnX0v2eUb+5AezeXnoChF1oJy6SNon6R9gw8hqi/3R5zk6eHYkVgRvlK6g9titX2rr4gOl6rpEcL8dRnu/MX86gqTgqT44dp6Ap9m8x3sGGDbEFZhJH5CWT59swQGdO8pEfAqw/amCVOT/CLixuR2SSsEF2QUNlzVxCKJqRlH0uSWVUPFKoJaulDIHvQlSvtgD8zS7qrz67GlfjY5bnlcry+V2AzQTfdiBb6hUk0wXVjgkUY138+sehXGdDXM4gDW/JjEx3XcpiT35eaknsNpvRgxddMdcr30jrCfDGbwgfz9a+a8/jV8qnSankIFO0orkEnlPd3Nr9Y7SzwtlTtcnYb608kMRyAs1TwuwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X5Vee+77zK76+ge2Xus9mCbb4k/CvRJZYpfVmJET6fgG6hy7JPa/Tujsv/+VwyP7iwJIT8E5ismNQcCiA1dNYM9KvPmIIG6BHcgo14RczTUp1toNN5BHOhzgTCCBu0UvwAOuX8MH3vp8sTiOnfTW9C0J1gtuhcg0vSfB8TF1WL5TKsqglbnWgxQILAYjkqf/IvM7DB5qdubt0IKcZK49T3YmWvJX2yv/u/rECf3ciR2QsULQmX66eCyfG1xCZZmrSK5ub+PAhRy3CwX0uLtoK6eBAMkyIDEvVjtmKBz5c9nnafdqVsRi8WchVkoZSzgzlinhkYo0yk1lyo60u+3BMd1TFKk5I1+paVTkK4X4LatZ9t3DnXOrPPBCS16f2Z08/CSy7wqAZmzLgBugdRqOAXgMtgj9JOPJl5DLqnhYBqY1kR9VdS1IxBDKAjaQUMYI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:17:54.7695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19120d4f-3b54-46f0-f254-08de99246659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
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

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 54 +++++++++++++------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3be80a82788a..f132295890c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -145,35 +145,52 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
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
 
 	if (!fence_drv)
 		return;
 
-	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	rptr = amdgpu_userq_fence_read(fence_drv);
-
-	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
-		fence = &userq_fence->base;
+	for (;;) {
+		spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+		rptr = amdgpu_userq_fence_read(fence_drv);
+		userq_fence = NULL;
+		fence = NULL;
 
-		if (rptr < fence->seqno)
-			break;
+		list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
+			fence = &userq_fence->base;
 
-		dma_fence_signal(fence);
+			if (rptr < fence->seqno) {
+				userq_fence = NULL;
+				fence = NULL;
+				break;
+			}
 
-		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+			dma_fence_signal(fence);
+			list_del(&userq_fence->link);
+			break;
+		}
+		spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
-		list_del(&userq_fence->link);
+		if (!fence)
+			break;
+		/* Drop fence_drv_array outside fence_list_lock to avoid the recursion lock. */
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
 		dma_fence_put(fence);
 	}
-	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
@@ -228,6 +245,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence *fence;
 	unsigned long flags;
+	bool signaled = false;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -275,13 +293,17 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
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

