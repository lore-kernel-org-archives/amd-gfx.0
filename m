Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11834C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25595112007;
	Thu, 30 May 2024 21:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0NkhqLJC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F2F10F804
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzcFHbympzxxjqlmhWwhOXjyewc/zf7+J/Y7G9nYHAtj8557HcuwIw9cPm5wjjmM7EMR/ta8Ipebr5lLexjByjtg3ai0xd0T/3x+t7oPjOl6UypgJIHS4cy+gNKBGzBNzlvVL77YrGo9mFYilBqK5NK4SCvT+y6vXVKXtSKJh7w6PWMjV1ypE6WXDKPhVrQbA+8Qf8IASM6qWVpbPiDKxRdWsmNRPI9DdxJbm/ql7skakAWEhvGrhQ0GDQPuihxX0zY1LonAwkZFoTi4fNZq6YAd2FakCci86MvfBS1FqpXAg7NQaKi0K5qe7MB25J6eU+z1EE4aRqPtRjcf5COfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zdd7IexLGXVvOrwl1XmmhX/teSAUJPyvs+gYKjw0Gs=;
 b=hn29do/2sShMCuFZz120wuK6YmTFP52rjGTZA/xb0JMXP/P6zBkYSwvPag/hUBU23QOtaGEj5XJZwLfDe1xasDC+DJdOougJQRxgewfSIRMZI0zII7yHxZfhU6pXoyQALGDAHiIntqEukvWA4ATAI1lHLOcB1hz9EICcI7Y4JfxICAj0IkmJRjJw2xdJzCcm/9v8T97ppNdr7cXyWti2DNtuqCn8ocZ4mhumAWD+9NJoYe491BJuCz8ZuflHTJcfgyT8vdoEF9avtXPU9GHy32DWKyuujf70daP2X4oWODVhSki6v4at7XiW4zasJnd7q1odbV6JcASwQzHhb/6RwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zdd7IexLGXVvOrwl1XmmhX/teSAUJPyvs+gYKjw0Gs=;
 b=0NkhqLJCk6sHow+0AK3rJaysSh6Ry8T1n878PvlSknD0H+KerSg33+XQjlfC7wZ7y+T1WdJeLLpFsgucKNzucnrafZAMvmL5IAgdaAxxXP5fWkPUy4EhBkzrvlrfSSAmucnTo1+6IudZMrkJQc8/gWWex5Yc78LqOgHn4BdWdyE=
Received: from SA0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:130::26)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 21:48:32 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::76) by SA0PR13CA0021.outlook.office365.com
 (2603:10b6:806:130::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8 via Frontend
 Transport; Thu, 30 May 2024 21:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:31 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:29 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>, <felix.kuehling@amd.com>
Subject: [PATCH v3 8/8] drm/amdgpu: fix missing reset domain locks
Date: Thu, 30 May 2024 17:48:05 -0400
Message-ID: <20240530214805.40970-9-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530214805.40970-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd4e00d-b190-4b8b-ddbe-08dc80f23fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?puBOcpY7lxcIP7okK2feyIsZpI6r4rMz+mpxmIourrWY9NkNevMIvzBkxIZS?=
 =?us-ascii?Q?NXjA/yRKgZwyBWcWJUY3KK63SBDGKD1g+AVqW6pQYeWEoJkU9OHnG3jhCcaL?=
 =?us-ascii?Q?EteJRcFFTySYFJPrc/8mTM58LlyVaK9xBYiYG0eH2rqlLZGa4m1sbR0wz3EY?=
 =?us-ascii?Q?cmXQ0akUbKhF1fqKVvhOWfrCOqQ4N8A1vAVJX6rbTdr+dOTfl/z2V9hpbzot?=
 =?us-ascii?Q?n4kfGbLplUKzBp5rWWNkjiwkqkTC49wBiXNeIBIYemPFrt1GPMZB56D4ZH4B?=
 =?us-ascii?Q?UIuvKRHSplpVOzGDwtvoMxztDJdUUe5uw28otKAVAr3aNZXUT2j3UOYreEGQ?=
 =?us-ascii?Q?SfjAPoQ9MQF5IqScP57VAHU7gURO02iRqboScazRtFn2z0MMhlsQ1b8WBqrL?=
 =?us-ascii?Q?S8JCPfBlhO5vL5/teNj6VppVd5II0fvzK7jPU1Ff4pd4f/yyz5KK2u0gDgRX?=
 =?us-ascii?Q?Vw+4xD5s8WjnrhBxwvwcNhOAot0ZAXLTftXWQO+eYS1rtVGoDi69Emm7tdJG?=
 =?us-ascii?Q?jcNpO74JfrsiB4hBVzf7kU6+M+cGQs5iCJl2dN1AeeIfK0qCoMVmpUz/2CRs?=
 =?us-ascii?Q?uEn7iBIECjG0UNslZU7M7sPiixmY/wK8YCk6UZNQO57JXRCMto2FVI72T2t4?=
 =?us-ascii?Q?mU6LLDEnHlVuOiEvJ5kbSsABawoEB9jV2nV7TzqroBuhda6Q1xZA5ylZo4GV?=
 =?us-ascii?Q?GnMZzDo+dsIjW1hoM888leziNSQ7GDvrdEWSRGPczlajv07wYvRqw7A0cwa0?=
 =?us-ascii?Q?0YMM02nnZ9fuNPWdQY9T8sH6l1wUX71IUJggUKGFihjuXVM2qPx7eCRQUD/p?=
 =?us-ascii?Q?FrEesNq6LlvZam4BoVbmF7Chp3OvHsUV11nwllAZBp8VsOu43WtDHv22JKHZ?=
 =?us-ascii?Q?OZ1ToDSqq4M13RdogrD/9Cra+qmrq+crvJKuGtkziSS+glH1pZvGtiNosbaP?=
 =?us-ascii?Q?iNe+WntRy7oLnRP06hc+RNk1eIc7KGQS/XMS6UNZ/acG/IN5dSOQdSs+Kc7e?=
 =?us-ascii?Q?U7Hl4q6B/5Y5+KAvcUlUj9tGtEKpcFNcggoCIbfRPC9PAC7dajbOy4a1+F9U?=
 =?us-ascii?Q?igexTE3GLJhiNvWiART3phaT/+mdnECTmzqslsI/oeXckg8S6JyM6kpq2h05?=
 =?us-ascii?Q?p9gSc567v3wfQNjjhAj+BA9SBWX1rPawqREk3HFTMQFR4NyRkh7Aup1xSLYY?=
 =?us-ascii?Q?yckqycbFY02qsz2r4oRE8b6TL2ZRiC5ITZ3e7y2PaCYyB18bD2rT68d+PTC0?=
 =?us-ascii?Q?3Yf4EZr1KJHi3kAX6rhdJnj6OIKcG9FJ2KVZsEK0rUbtsO24zAkpl2qRtBU5?=
 =?us-ascii?Q?W3Xez6gaYC5IzNTaH8D4GOaiy8pl6VYXTp6YxxMcnzrGNjNhkxW2iDfn3wuZ?=
 =?us-ascii?Q?rMj5LYo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:31.7393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd4e00d-b190-4b8b-ddbe-08dc80f23fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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

These functions are missing the lock for reset domain.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v3: only bracket amdgpu_device_flush_hdp with the read lock,
    amdgpu_gmc_flush_gpu_tlb already takes the lock 

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index eb172388d99e..256b95232de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -34,6 +34,7 @@
 #include <asm/set_memory.h>
 #endif
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
@@ -405,7 +406,10 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 		return;
 
 	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_device_flush_hdp(adev, NULL);
+		up_read(&adev->reset_domain->sem);
+	}
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 86ea610b16f3..21f5a1fb3bf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -28,6 +28,7 @@
 #include "kfd_priv.h"
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 
 static inline struct process_queue_node *get_queue_by_qid(
 			struct process_queue_manager *pqm, unsigned int qid)
@@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
-	if (dev->kfd->shared_resources.enable_mes)
-		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
+	if (dev->kfd->shared_resources.enable_mes &&
+	    down_read_trylock(&dev->adev->reset_domain->sem)) {
+		amdgpu_mes_flush_shader_debugger(dev->adev,
+						 pdd->proc_ctx_gpu_addr);
+		up_read(&dev->adev->reset_domain->sem);
+	}
 	pdd->already_dequeued = true;
 }
 
-- 
2.34.1

