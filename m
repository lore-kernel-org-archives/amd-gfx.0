Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC6FCAC59C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 17:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6357C10E520;
	Mon, 15 Sep 2025 17:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q4Zteei8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F18A10E51B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 17:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSiVzLnW0jxSfPxNzL1NzE3iG+9k3er0ouoTi5Xvl9/0SyvVOYq2FvIjpEXhDTgLxuyJcMjOc6wAgUTe0TXiRtQA4qe51W6CGD6gHo7fQfG4+ym+C7keU6ege7BDpepg5HdMgzkXzVhbYe5VSaijhx+cv3rLl7DFMowhOk9himQllerxE9C/ZLECT1LFYJ+pddqgo5M+KOwxkgbGpNIKasgW+SJaW+/7MTtsjhB2TARrADi7WS6XWQQiIFL8gdJouu0+WEnfNepq0tS7oegOoK5s18qRRZWxaY7r/fsxdb3wI8X2GO54TYVtnOIf7kb2umOKkFbaWCLJDAaif6U+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCMPJT3Dg2TZZtAinvefXPuXXCpIbpwd2/smRFWYkCU=;
 b=pI/KNPeVzuHwZML6lnM9W1JdQHdUO5/WmbkxVn8gm5vd029r6x6cSac+YQWBOQEOzeObLKdkSzmv0NFUsk5Y52340SL5xLmXFIzO+w+FiwDm2lGCnEiq6ddIG5q++Vo0Tzx4aRkkRhQMwx6doG2vWriGlSS8tLv/58SGvoe8Xzl2sDq0Hk0cSeS8m6RIpTXetEm2Z0br0m3f6hVBSe4Lo94UFeWPVmwfS9/usRTK7G48UOsT8af/pr1K5E1/8pK69T528EUHdR9fXHaE2O3wE8oCNL+P4kWnye6E5AdyCLCj+X4HFUzc+HS+fALqm4Y4ATm4vtIhM4s4Mq89+qGcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCMPJT3Dg2TZZtAinvefXPuXXCpIbpwd2/smRFWYkCU=;
 b=q4Zteei8IghTj6djgcmatR7CCMuKCPNiHxivq3OY5A/wcTQT3j7xcI/WyEkUcPbJ1AfJv5hcTfGf3owhNEh+pSRimW1DowiFA23E2DeMe8ZtsvU68ggs+xj4UpYr6ilrUzOhmoY69kgzGtlridRPkisF5CJ8YKsdLb2Tk6jAdwI=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 17:22:36 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::c9) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Mon,
 15 Sep 2025 17:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 17:22:35 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 10:22:33 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: handle wrap around in reemit handling
Date: Mon, 15 Sep 2025 13:22:13 -0400
Message-ID: <20250915172215.6872-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 4962845e-659a-46e5-3b27-08ddf47c7680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SokAiJi5q8wbYOoKpwjN1bbNtbeVWL+h9NAgq+T61zGWgk9zZZpElyhzkKmv?=
 =?us-ascii?Q?Euj50zA5BY2vNrCsToQRMbDsuVEEp+f7Hvi3C+V2OpabSa4kriXwopvG5hr5?=
 =?us-ascii?Q?YOEwLkKbyimo4VjTcbkEnIxO7xoIeGl+rleaXCkI65BfEFm0q6gzb7VBLLpa?=
 =?us-ascii?Q?mH+9WD8AiguYng/IPSrANI5K+5bAkeshdG9yZ0S+YuaNdAnoCvb+bX3qL7oa?=
 =?us-ascii?Q?WblB2mApY5iaeEQs8hEq58z5XRQyMRzNovoHWUy5kdF+4+XOEOVPYW1RTG8C?=
 =?us-ascii?Q?Q2xSikQSP1+HSlZGuNUffoC7jgwGqbFW4LfF+LR3KTV486yp9n1VDRezxGLO?=
 =?us-ascii?Q?2HpQDJtoxIwTCSlmR5v63SkVH6rUnq6qpTRK6U23xi7vye8Fm9Ann/hA7Lln?=
 =?us-ascii?Q?TxZzLO8noNlLMi1u8ZrbwKCq7Ox8X9XFItRS9OPqFzmM7SM3IHvHdnNUNUOK?=
 =?us-ascii?Q?OSnjIz9t1jWwEppz4D+vVUUelCOTUhORLi2xUhL6bE36sNW/USwsUo4uYjxA?=
 =?us-ascii?Q?a2lI8Csbk7/YoP6KJCO0Vizphxz4xcl3g3p4rRUA/DeuSJBwgs7dWFPyuA1+?=
 =?us-ascii?Q?cNAd+7HjtZVUMOyDfWCJlpK5RKVweYR09OTLHJgDqu3foegJ4aFKzDjTeUPv?=
 =?us-ascii?Q?Z/hGuhgrs0Wr/GVeJnJIXN/5TiftZJGvfV8M3rKiuKh1pJ2JssvkCdiFMViE?=
 =?us-ascii?Q?K5K4Ae8Q+jRk7uH2tDWD/+brQJzWkc0WNjO+AqBJTuek9G7A5JnjEHQcQj79?=
 =?us-ascii?Q?F7hDYnFPd0ypfVXTtTJtdLdycl2fLCBcyYI6Ngvrp6GA7Z4GVCKCDwlGNCZq?=
 =?us-ascii?Q?2JkNlwkXyUxwVBJ5Hy8GWhAkvyqkp+6F1FSEVb/o0OIZI84QxDAfXe8UA4H/?=
 =?us-ascii?Q?9XhHOOhW5iolQz1uN3l18EKt2vf6FknwiT4ZgNaUZ0kg1KsFoHh5cPExD/25?=
 =?us-ascii?Q?VH4/OQzuL23S+ZaPTvqF7B4zvqW16W71/7c6UZ29QlIqjcXqS4zShjYjoJTq?=
 =?us-ascii?Q?jAGlI4LLRGFlkpdpPTHZyf+y0tjDQA42NTvhPvdQaElm1Yke/tkKlE5oqXPO?=
 =?us-ascii?Q?We+B3oDfdvFbjUeukaUekK21lKkIFbSflL6OjUnMTflVH3Sg2gWHAcIqIelM?=
 =?us-ascii?Q?V3FXhUStBoI5PJnOCZrv8pfzGk+RMsKnDSdyMdar6cd8MzG3B85AQgOR2v5Q?=
 =?us-ascii?Q?N0JAIXjPaaEWINOYWbtwgSJwU7nzQsdORENUX/BL3B4vmeC/t2kgPrdEJj7x?=
 =?us-ascii?Q?ccGPbqHyUIEpJAaGau3/g1zokbt38PLQ0Rh7dWxFdJOSx9CFYMq0L0UeJ8TG?=
 =?us-ascii?Q?6QdJmpHYFfPMPyAHn6bRE0VIXG2bSeUka11pEiRLh2DdcckVbvgRcHyOw+Qh?=
 =?us-ascii?Q?P0A2BDhejRx0mhzP6H0+oAr2K36C0qTypfV61MdySepmVev1mmwQUIFSjs2K?=
 =?us-ascii?Q?tj2RUBCFe+cXf84Ufmkz5zDwu3Ou0kKp6gK24QZ1JFH4hkyYcBoYwRV33jRD?=
 =?us-ascii?Q?YKFUwUlOxth6h9oxI5hKHD1EARlHVNEpuOS3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:22:35.7301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4962845e-659a-46e5-3b27-08ddf47c7680
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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

Compare the sequence numbers directly.

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd8cca241da62..e270df30c2790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -790,14 +790,19 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	u64 wptr, i, seqno;
+	u64 wptr;
+	u32 seq, last_seq;
 
-	seqno = amdgpu_fence_read(ring);
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	wptr = ring->fence_drv.signalled_wptr;
 	ring->ring_backup_entries_to_copy = 0;
 
-	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
-		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
@@ -813,7 +818,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			wptr = fence->wptr;
 		}
 		rcu_read_unlock();
-	}
+	} while (last_seq != seq);
 }
 
 /*
-- 
2.51.0

