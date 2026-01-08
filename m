Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959D8D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5E010E759;
	Thu,  8 Jan 2026 14:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3C9BNBTJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A7F10E12C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwSumZMgPBQNd+vASxx5i7+dtJ+/12xWykfOnhjJ9w7qRNKQh5H+rbWnZSSNvb+lQFp9xaOOKOn4xf4kYFBMgo4LKh9D77c5J8E/yau1/6OsUELE5Ew0CQEohCto4HvkqyN/uS6QnmPhYlehnCiY7iguiyUuKLJgTnMegwLkrmPpbGb8s0HgofJCWSaR857td2Jifoeep2U/EPM/aVFuBAUghm3nGd1IMReSrfhs4HD5dVLskH2ukSmXx6vsZz5dgMKTgL3C4P0/3T01PGy41hC40GThZJeJj0Fzv39z3uuiwuxagCM+cAnOBcTq3ugpmZFYwCOQnXBJnkoaRCMGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cICRdvIpgg/Z4PUyrSEjyXgj7HXC+SRNHSv5JMo0vCE=;
 b=cxB5yMHEI/PumK4h03tZYyVO67fGFsfT0d6sUFxral6QgHQG2JiLSFEbGvGD4WIkLuhMSfoJBj6do6qMYwmAmWH9Rke7qGv4nYrFFQ0gv/KZrIQ4CXaGUS1nWsIXe0DWBzbcN7MhSLH841FfG43WuG+1b+HpaXpU06I9uZOYxubrScvnIqLKxzCvxBq5rN3i2zZDBuWkkrESn3URdGrEhkq/osuQpicf6vNzMIM/OcG5i0ZFbxfWF1sNN0y3dYNY4I32/SPEDfa/w4jMwJzVFnd/ECyRPaVe8s4UVYBLHJoIFtSv9Y7dh4/By66gUrFbSlzuUUAfZndkoyPflgxSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cICRdvIpgg/Z4PUyrSEjyXgj7HXC+SRNHSv5JMo0vCE=;
 b=3C9BNBTJfj0IFdDP+YSmU57ACoa3IdgJukW55vgY8G3ONNlq7E/l91WPPWC77qhHG3pHhZ07ZOpqMKEuKgIhL4C8+a1++aSftMuRlNw3GrNvSi4lD+4SXK3+0CKmarmhDcFP0MOjDdX6GsSP+Vihqx+IuxF8Rcjx7rIDqaWWo4Q=
Received: from SJ0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:a03:39c::8)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 14:48:54 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::26) by SJ0PR03CA0333.outlook.office365.com
 (2603:10b6:a03:39c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/42] drm/amdgpu/gfx6: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:06 -0500
Message-ID: <20260108144843.493816-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: fab3c719-2f70-46d8-afa1-08de4ec50ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NEOkELXCH6FTdP//q4GwecjI0oh2odB9ocsfvqGknM0IZG85PNn9IvqL8AyM?=
 =?us-ascii?Q?bY34kdzkkC9FWy8RwXUO5MdacFVesriCQZC3yqxyW2ldn2/SA3OtYywFy8sJ?=
 =?us-ascii?Q?Cma/btbQIVpiOlshhMoJzr/jQWqM0SoJSojvTjtBzRldYBzSfS1Js1xeEIVE?=
 =?us-ascii?Q?aGzkz1wQWVZINt35WnCQcZOSwM25m2ExUdwB1ZouwfT0R9Tluev538oXKxN7?=
 =?us-ascii?Q?oOf7DDnq9fbz3mHE4q9NE5Mqs8AGAjyt2XMg4mvAAu7CavroKo9sEXguwwX5?=
 =?us-ascii?Q?2Xzy0sGjWrDYfc76N7to1vwkpCTUrVPeGa/DLvmeP3Qj/J/5ah0OYbafpc33?=
 =?us-ascii?Q?GZbzXYstqBAfeGjqomxspsN8m3g1RWtQU4xAlXh5lpCrLS9AMs7DPmMKyPzC?=
 =?us-ascii?Q?ye5N748mkn+VJ24UYE6355S8nYGZeHF7luzKu8VYiX3J33p61QrblKyeaKZG?=
 =?us-ascii?Q?bnZdG/7PlaB56fWpZ8u25zAGtc0RRF+rAURQasUaDXwuUL2PMf+QxBINUzuw?=
 =?us-ascii?Q?HnZXXu/KW45Lo8v9VgKiQEbsrG7TDkzsP6N4QGcJH6EcrUj8ZnCU1EN6NFOw?=
 =?us-ascii?Q?LqCLtVFG5FLrVFAiNmvbHgmkz6THfbKN1FvChH3qwq9iZwA9KJkmDR02swkq?=
 =?us-ascii?Q?gpzygzLWSiIQj7xC8wAVs6tAnh9gW/iLVmKTt2A6goXpFO7ab3fAdIO62lwl?=
 =?us-ascii?Q?/gu7OzbZ6OHyiQ3Rr2pig73FvM0lrnpSspeGq+b4DNWS/bpQPSGjuEH7wUjT?=
 =?us-ascii?Q?S885nOEAGtiQPZcsm5NspVBjPMmEh8a6Rl68OrUlPyzmM99hh04q+XSOv60a?=
 =?us-ascii?Q?nPjXLL20muVksEi23YbYuzrb0K/oBR0oViM/Mk7f59JYA4YQD15KY3zkPP39?=
 =?us-ascii?Q?Nfcl9SNQmyuf7J8/IPOBgWNITbEbSSRUOpxL1GlPicP9NR6/SCBRQ0gMPuVL?=
 =?us-ascii?Q?fd546FHq3ggrq1GAkn7oAddngnmuqdSusQkg9Gdd2ddB5bQzs9a7E1A+YY/6?=
 =?us-ascii?Q?gQLpjOhbYBKwlCYtCIElEnTJCPc1oBtTfQbXIMRtD0uC8cQXBjRVTZVBaFZX?=
 =?us-ascii?Q?ZOpcS7ftSrE3HYoUr/epMV4e0+GcUpqPJ6TaPhW9Fdy/d2YbU/p9NfnK1muH?=
 =?us-ascii?Q?FaIniNX08vwQj3n3Dg8GySgRCSNR3srRRIrIbbNQnoVUt/Gos81Yscdx7yyl?=
 =?us-ascii?Q?onIOyuGWzdrcqI2932HM/HU5qJcFbNYVgr/zHYsXvH47v/ZyNpCP17MGv24d?=
 =?us-ascii?Q?7Ze7xqIJX5E8S4Il0jXryTxQhw9yUJMvOBNpZqfBwoR3YF9PsdPs/5FIDjN3?=
 =?us-ascii?Q?E4VVOaIu0Ii26qqhcrFx+GzhMMQA5M1+ngbtvotWd0mMu13foQG00rgcTe61?=
 =?us-ascii?Q?Nx/R/+5qB4fjREB9gOs9gbYusWzB/RdvYSY2YHM4gL7Iquxlwm0NvKP7eUum?=
 =?us-ascii?Q?OwZoH2fI/Tvw/Hopyub5k2L0TZLzJB0ZZ8oYlzTQS+JeWc1glxxAC4ox08OK?=
 =?us-ascii?Q?HB2UXva6fT8yfkExL7ODFID+gefBsQhzQbSLQiPfFOL//PGQvoCCQMEwCFwK?=
 =?us-ascii?Q?fieb8/yIU+/xlwPuaDk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:54.2625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab3c719-2f70-46d8-afa1-08de4ec50ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 73223d97a87f5..2f8aa99f17480 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1895,24 +1895,29 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	uint32_t tmp = 0;
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		return r;
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
-	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
+	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
+	ib->ptr[2] = 0xDEADBEEF;
+	ib->length_dw = 3;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto error;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1928,7 +1933,6 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
-- 
2.52.0

