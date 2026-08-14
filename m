Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C4C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 03:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A2810E524;
	Fri, 14 Aug 2026 03:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1qyGYFC";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B047510E524
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 03:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHM62eQoXlQ4AH3OUIXQPmQQLucY0Qg/vlkIaASC/w8yhmmaFLMsL68lQ90QGydMMn7XJyojSD2SHhO8qKVfwqFXVPOEIa7sSZ0YJsRfUUNGTRYK0JMsEIXIP6hpgOu14jNgf9PZeZjOS2/BWeWUwzImLZ1A6HmdKx43DgKOKHbcaMNHgAYU8SvScP7JPjjYndRfJ4xn/+FZzZuTxEZK+aHkZQpONDPZ/4sfy33G9RwnbZVcQGLFuMbWlhJ4t0RMdfCGtEVitkIIHUT6AODJD0TE6E5T3AZJgD6A/xCHJLNGRz+mXOouu8FvYKrpw2QCFgN03BBaQQoH0v4Xo3PYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI7SQSUtoBjP1TFcxULun4s0u+gWEPKn/k94OmX0lkk=;
 b=LdV+g697DW7WCkPN8aYYVZwqFE4YTp605d7J+VsBPscYouWWvXZpJlOIQdVmYGp29/7tsKJc8fBl0qNtovvsDO5EQO0ZvkcJyHyaBs6sDfw0MSaYhpz2tiShQlv1u2WqqPyuRwY68VWg/r4Ic85Kykr/Q9azQmtHq1WbQQUg8hHTl5geUc62lZc54HaGFIW5NvzDfz69PClqA3H95La6U52yVz9MSy9ZwK0SZdZT7QC2RRziaMrb0DvcF6tIYH+hkzC9WbxIFt5pW1/wv5MQCMo6r6eAJe3VMUYO86ETx+ysRAvC89bEhaAly55W+XH78G04c+3Qfszpc9WNdtKEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI7SQSUtoBjP1TFcxULun4s0u+gWEPKn/k94OmX0lkk=;
 b=v1qyGYFCgVLK2rgC+kdXNG9vXckciSmcsnLnsiNsbEdoMQxplOoyNf4msxCFW34ZKswrkM1iwFr8XtO2a8HWRd2pVppAfR3Ha24vMRa5zVgse3BmjfRi4mTfXNspElURU2+ZA184kYpueumAj55DBxObV7FP+t0smBCh3J8C7sw=
Received: from DS1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:8:450::12)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 03:44:05 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:450:cafe::5b) by DS1PR03CA0004.outlook.office365.com
 (2603:10b6:8:450::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 03:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 03:44:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:42:12 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:33:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence error
 set
Date: Fri, 14 Aug 2026 11:33:02 +0800
Message-ID: <20260814033302.406402-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f902baa-d809-4348-8f62-08def9b649cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: FJU9AtReWNa5aZQEFb4U9Fh3qkfDnXsEVkBp7X9tp2kQAq0uml5zLnACjH/uCe7BRY6Ygv5wO5Vc4hzBQGjZZmjoyPzHMZiGPoIR+Os1XlT2D4Vb1ZwveE81a1ZGzt958ipEVj5KELERtGxiM3LUjyWLJ9z2TM5o9u2xFsmBAx3q2sa9zQyu4ajIN7wKzAyfy9AgrMWyulJfdIMj6aa0woS8Q4ln9Ez5UvhLB5qkEzsBTQU4BBgHWA6I1QKT55r/zA7jm5xepl3Nz+lcEpgxo7lchK07AnAAKVaTpWO7YjIeFSTA1f4Y+0EMijogvDPuDZboqJTUPoLpYaRnIehwxBvTYl4eVWZWtVY16rwA0WIZzwjwj83Lc0bCqx9sGq9e5GsDuRNGfON4vQa4p9OlA07jsmrIRVQc58WEMzCSG9v5AwoxUJ2D5RkPaf7wVzR/9DIB+hz1FKeiFncECrRLez/CcjhGJr+QjHkWVfyqmX32coZqAftmEHGb8lyTS1ClFJlFLOMuprmCcWXEpBc5qGOwUItdxOwRwRfewuxshJ3gLvSMs5mHKVgYQ3KF6/rkSQsxBSYGzOyzDd6l+fLZDZLmwv0iO/+RFCW/kvJBsA/dvV002xpdLqsZtIzZouH1BEcwPZs6/24xNAFyfIApTmYnZlckNm+yAFdF4S8A/1SbdUPtNAJ03LpT4QgpH+30OHt2AAQJAsKAEaMP93UgZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(18002099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p1c1DQYAN8jdYL6lZ3r4doF+zr7qEtcuZMCe1VUmpdBx9m4e4WZV9uJbci81dXlIAfZn2cGANda/5P6Xw+SP9E2aURkOP9kGeKUhkDxhFP5xFXqmyJEaoX3Vobq0FIE/q1s7vnqXYwnb8lsnwwPbrgtdoo2LyQgrLkFmQ1wZhj8o8/Csc3mshsTDl72viKNessEWUVJcpAj0M8zyFJrzB7f/XGZNPVHXxBXoGxekRLRfjM8ZRFnppcuI713cNTQL3kVn3Nc+HqljF0o1gzhs4zy2bWlabAXcBkWOS3rFPraSjtrQ0DYSrNuVUVK7sB5MvZQFWWYHBPLLllzNUyqeq3MxLgU/0GADWefHrtqMlAx23IFNmKzJgvUo4mBGZfYMB/SuiQmZ+S77pHolEbVpkAViih/DUH8M5nA9svKLLKPdncSuD/2jdWJYD0Em1yj/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:44:04.9971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f902baa-d809-4348-8f62-08def9b649cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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

amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
don't acquire the dma_fence spinlock, so locking the dma_fence lock
before test the signaled state and set error state.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 19af1adc2921..09e2079cfdbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -191,14 +191,15 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct dma_fence *f;
 
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	lockdep_assert_held(&fence_drv->fence_list_lock);
 	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
 		f = &fence->base;
-
-		if (!dma_fence_is_signaled(f)) {
+		spin_lock(dma_fence_spinlock(f));
+		if (!dma_fence_is_signaled_locked(f)) {
 			dma_fence_set_error(f, -ECANCELED);
-			dma_fence_signal(f);
+			dma_fence_signal_locked(f);
 		}
-
+		spin_unlock(dma_fence_spinlock(f));
 		list_del(&fence->link);
 		dma_fence_put(f);
 	}
@@ -423,11 +424,16 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
 	struct dma_fence *f;
 
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-
+	lockdep_assert_held(&fence_drv->fence_list_lock);
 	f = rcu_dereference_protected(&fence->base,
 				      lockdep_is_held(&fence_drv->fence_list_lock));
-	if (f && !dma_fence_is_signaled_locked(f))
-		dma_fence_set_error(f, error);
+	if (f) {
+		/* nest f->lock inside fence_list_lock */
+		spin_lock(dma_fence_spinlock(f));
+		if (!dma_fence_is_signaled_locked(f))
+			dma_fence_set_error(f, error);
+		spin_unlock(dma_fence_spinlock(f));
+	}
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
 
-- 
2.34.1

