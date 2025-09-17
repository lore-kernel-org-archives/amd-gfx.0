Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D08CA0EE8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 10:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A55510E189;
	Wed, 17 Sep 2025 10:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E1XHOzCy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B3210E189
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 10:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlQMMrTCWiDtHbmqw4lBLaRjh6p12aHJMXweTArzHLFulL+8O+JQaJO9mUS50YJqqFAiIFalYhbGm979vl6JW/fWm+lvm5B3KFmpfSip9LHsG0Pn4cwpYXEek6B6UMYRTd+pl1RxrlC9lIDiuiRBUQPgYjTiDTiQ7elhjvb2WT+RFfW1jyBJ3hJ9tu4tdNkl++RmZIG5whyb+SQQLYWtstrVL6n9iOJU+V/iWfJmrwohDKuJJ6HjwGhaJiAVzYYq15n61duuyjwV3XPsQaZEkRAmX/n23g+T3UK/fl25oj9u7G8lAuIoPhN94I8sRgb/Yd/TSDrtP67CbPipzXbtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahuaz0HKGMn7gHCrNk4whD4X7I9PhemMjPBNmkRhTuA=;
 b=OkMzCr9C8C8EO8g+Fvh1zro7qza7aWlmWjPLo3iy/PdZrByhVT0xZd4ovuGg02pcN6AxwZjQ0y8VFS9pSMCl6xuHXyVi2Tv2TvvYrLNRuDcfjQsGTlChfds55AzpsYlMrRMW4ITRg2621DEKo+vx1QP35RcXydj4c6KoNhFqBHjfNlRsyfstX8rosugfp5jgQyD7eHtqjqrWeCHzT2VkmmqcYonu+HjypTO6s94nQUl3XMB2VsMS8Qe3BIYHZbH+GOX7CiBulXZ3i4CQeONu0N0USwsOCYXVW6hxMgUYWxHFbuq+N3W0PWiCPDGWgrHd/YJLfmKZJCtK1blbI+GewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahuaz0HKGMn7gHCrNk4whD4X7I9PhemMjPBNmkRhTuA=;
 b=E1XHOzCyNlTbfFZKMtQJ5KYRTzSdXZKizYVWEsAIDkf7pGYVJUa7RVzFFjiNq25lISfNX2uKnLVEnkPvuBoLNhz/Lhi1yUCVoO6FagR+8kRBGsCod07v5qd/QjsCmhj52DXT0YS2To+0g21RN9XAdPPr1o4XUDhjdK1ykV2a/N0=
Received: from SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::33)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 10:00:26 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::bb) by SN7P220CA0028.outlook.office365.com
 (2603:10b6:806:123::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 10:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 10:00:26 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 03:00:25 -0700
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
Date: Wed, 17 Sep 2025 11:59:40 +0200
Message-ID: <20250917095939.41615-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6d7105-7cc7-4308-228b-08ddf5d106c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OSqPYceRp8PXAVUjofKASlGf0Jv81x2TU/oJ1DOTlbxqrX2JLMngVIwehJDy?=
 =?us-ascii?Q?/KLM6umL0lNEmO1I9h8b6xREe8zpyRcIv4/tKZkFAnHX9+IUMKQinW4hysNv?=
 =?us-ascii?Q?9tkEFxplaZsuInl/1DJtSd4NNhbWaSrHe1uJrmoAnBIj5hKYn5iB31YkGDhD?=
 =?us-ascii?Q?OFZ4Vbz8Fwl4JHYS1SlrFGO57B1uNApWfxY2bLuomPsLaJcBpouX7dLqAmSH?=
 =?us-ascii?Q?zLiSsXGSv0Dm4BvtLibQoZ1UBMVv7ivIUirVBmb2j+HAnTyXeRLWJLkuSjJo?=
 =?us-ascii?Q?stzcdjg6tQu6OglnROXd6YSDvaAPmz52UcpPC/3hYJZCKSTaozMIGbCoU4m9?=
 =?us-ascii?Q?L03c/dDwEEPbT8hvsSzj6x26zxykTVu/+EzseR/izcSbnFKg8dChtHNcKiaD?=
 =?us-ascii?Q?ZYh9opyki7gQOe7h8yrXSYXNeCljp57F59CWg3yb2sNhFQ3y+n72TcnrIq0v?=
 =?us-ascii?Q?cKDpsRAkR7O4iJQKMouulhdCfyPJJBLCTIUQZTBrdOU7Zkir1BzbKpgAQ0Mn?=
 =?us-ascii?Q?4wekI8K/87EkCkMeb1014MBb1t+jtqBTPq2mtem7Nofur1uhfMu2HRy6Wc5a?=
 =?us-ascii?Q?sziq0cecBXa4cvsjB0033JPFTrSKS0nKITJ6OsceLmtp1f1aW16H+k/syrcV?=
 =?us-ascii?Q?SVsuV8dgVaR0p96xNHCRbn+tI5cFdEnRNK4uLt/L+RkbSCg8G3PJrSCVUhyt?=
 =?us-ascii?Q?c0/sH1xFxoFMPSv5iLEyTufE80tLltC329mu8oqjV8ZD/PnmTp939BtPREi4?=
 =?us-ascii?Q?jVAm5iU4Y50Eh6SWo5gt7T+uE38BYW3wqx8SVkKeEGntj/UtuItFCmcgeFHH?=
 =?us-ascii?Q?b6+/rafkZqi5hk5dPDSHiXCq7KiB24rI+Mj1jPaI+Tddivk9DT/ztjWgEQ6J?=
 =?us-ascii?Q?3hkUZTri6qJKqPg0Kv4v7w7JwLPDgkvsVvnnOmK/nDp0aM/1rOUPjTMKh4IS?=
 =?us-ascii?Q?SX4RK3Lrcv+vvBNJg+LHpBlfgeYE0FuLbTtS9nOMbFlFj7Z4yvvzHOZk2SqG?=
 =?us-ascii?Q?x+mSaQ92oHme3Dy3GS1lMsLrhE/Qyj9/82s341aqMboNxpbu01x1T8Nl0XtN?=
 =?us-ascii?Q?vWoEVgGbHGvObZ5M2ph9mJymPMebSGzzK614v8C5T/nwKFktQpwWR2Kk5qpO?=
 =?us-ascii?Q?z2QJIGCxZcl0LWWdFIQHz76/0DfRDuDmhJLyWRra1oLW5xKSNI0n8cVQqnRH?=
 =?us-ascii?Q?b0xbeoBWHxec/n3IGryjxyvVwjcgKc2zYrhw0s8qvJM/4qU1/bVJcW/g+AYB?=
 =?us-ascii?Q?HxpY7VwH96wF2Tco0Rnghj0cWNn97F0lWLyqvxuqAyuCX9xJQ4JgwtRnMIFU?=
 =?us-ascii?Q?BI8VYm/o5s/3BXr0eqLTRSAo9gOYaeRy9rPU1IfbFPMGEQA1YrOoj5We6XBN?=
 =?us-ascii?Q?sis7LSIQOmPvSn2UFE9mEkwvFANJmZ9M5GBI/ErF+uatpPwJ9iaZiStYTGfC?=
 =?us-ascii?Q?NKabFvnpGF+CqN8TmalQlxVAnUJTRB59GGwzULmzA8uBoOTyJgcmBfXxx6uB?=
 =?us-ascii?Q?z220aFWLBjwi3VX4GBEINwb9DPXcYE38oRVA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 10:00:26.6542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6d7105-7cc7-4308-228b-08ddf5d106c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

drm_syncobj_find_fence returns fence chain for timeline syncobjs.
Scheduler expects normal fences as job dependencies to be able to
determine whether the fences come from the same entity or sched
and skip waiting on them.
With fence chain as job dependency, the fence will always be
waited on forcing CPU round-trip before starting the job.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2e93d570153c..779c11227a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/sync_file.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-fence-unwrap.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_syncobj.h>
@@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 					 uint32_t handle, u64 point,
 					 u64 flags)
 {
-	struct dma_fence *fence;
+	struct dma_fence *fence, *f;
+	struct dma_fence_unwrap iter;
 	int r;
 
 	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
@@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 		return r;
 	}
 
-	r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
+	dma_fence_unwrap_for_each(f, &iter, fence) {
+		if (!r)
+			r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
+	}
+
 	dma_fence_put(fence);
 	return r;
 }
-- 
2.43.0

