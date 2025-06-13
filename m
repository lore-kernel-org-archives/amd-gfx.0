Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD454C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F8810EA63;
	Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQ95QgXc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB3F10EA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekjLvS74JQkPcR7ZeBaW0HqgwGLAFhFs+IO9+fyMxIpMXRdYsmS7LJcuFmNsvz+nxPgPI//vWQhiYW3YO/5MFxj3ExryH2UAxCgEyUuz7Y1k1Hngl8FeCL6kF0U6GAp80wBsp5L7KPr+Sw7wGopy22XXjN7eLLjttiYInLgFwd9Zk3q1K11V3E5tYERBkFHan8Nda7WcNrpMuRAGcPOzmXjQRKAAFiVqdQlpfWJR3T/aDH46sLkuZLUpm2mkkX8xy9AKcluxF7LmtR0iZQeHhUrFp0NdU5YQKvIxd4XyM+0MFduZ9TwLrDdijJnOtov6zYjBP5fN56JhgIvlHwUCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Sc1IlTYnknVC5oT3mzJpRVqhXPPsoS84B3q4SbFv5U=;
 b=OQBTtZFr8loC/0WUro4bILBnPdBFWqQl479VISx4cKji0G9TXw6iZIzfwAQoWiWoGiLSVQHiM8dczFLFTUDupIxufc4g1DI7CuNTKqBXBdhL5Zp8HjOo8ZLKWOyZi7Kg7bDhy3ngQaWFvsw1Kaka0ae7VgDAgn8YHOw5ULpq9dwpW+SzhZvjibqtcNccfOwjOCwnUu5lJf7MZQIVK5G4p0YiA7WvO2xhiE0H6WMRKOZdGRSN+jNvJHI+AeB8hVltx2jIdYy153mM/4v2dAddl/StITounLQXiw0vBuXITSVglDkFUC4ARoQ6z3uIXy6tgIHsDhwQrignjOppOu9b+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sc1IlTYnknVC5oT3mzJpRVqhXPPsoS84B3q4SbFv5U=;
 b=MQ95QgXcLAwE0+HcXSF6E1+qV55sRMztOtQ+OagYggkXMi8pYv9o6CHX11yujMF+8MbYzyE+KEFo6PVMuMIZJUhHqCUOpaIB4EXWpA+IB1RWZfg6NzWNbUS2dOwOowr4xx19XB6tA+Js32xH0z2RBY6GqCbMX5W5ZpkwTeLfHRs=
Received: from CH5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:1f4::10)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::85) by CH5PR04CA0004.outlook.office365.com
 (2603:10b6:610:1f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/27] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:36 -0400
Message-ID: <20250613214748.5889-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: b2167342-36d2-4e74-a41c-08ddaac3fece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/YKL59EQ8lDTon+haJAc568hwwBT0aMB2EN7/P22toOjk93YLLxDOkur1Yo9?=
 =?us-ascii?Q?YWOfI2Gu5jGsV4r6uuNrUb9WybRDPRyFrMuEpa+B58agb5zvw2T4N1o1Ac8D?=
 =?us-ascii?Q?YOrf8uqwzUhF5ZOj4vk/2VPEV/MTdDtTYFNydHCf5Ua2o2CpZkwbpAfse7kS?=
 =?us-ascii?Q?fg1crTblLTlJni1RhINF8oglnkcC0klJWXGf/pnKMUuIktYgsqFQfWZa56NH?=
 =?us-ascii?Q?unwwiLI5W0srIL+C+eK/roJ1Pog7dRbW98O2Maqk5EWojNLZDDrFMpbGCDfE?=
 =?us-ascii?Q?X1ykeiTj+0lmpMrtBWlGs+dzWi1RUmwb1lR56dfgajRrnJv+CmJhf63SBrmD?=
 =?us-ascii?Q?X3VYY4NLnRB/nFbKy14eQzZUyqx6ma4f35BzICZvv8/NxUTL0BCnrC7S0Io/?=
 =?us-ascii?Q?yw1bEK77f+t3j0G3z/SzCvL+Zse2giPaej5O+KEMBNowZ7jVQh+eOWItNa5w?=
 =?us-ascii?Q?iXKXDxE63w307uPtjT4ek4q2ynUHZrrWGHzkC+xcAWw7+/zeQs1IRi8m11Wz?=
 =?us-ascii?Q?Ajt/ZR0e+pr34nG/gh+SX4gxudC0TW93Oi0uYyMqBzdLesh7v6gLkr2K6azK?=
 =?us-ascii?Q?8tb/yPq9cY1jEo81SxZ2uSIZZ7DtaMBUP9AWmu83r7B3xeXI4QyL/YKcDppl?=
 =?us-ascii?Q?7woSqInuinPsCda4392jDNdG5uFVTyhUBRHiY3VSzr44AGa1NtbMq1veQ698?=
 =?us-ascii?Q?boloJ7/h3KIvHnQ2J0ruNTxEGpXvTc5jFhd1NrggrvEpqzqkdJLq9o5pu5No?=
 =?us-ascii?Q?hGBjmMFPEoyOGkZpijhCOs1jFYAIHbur0ALs6mTLzdt+QN54p7Oo9uHyyZAv?=
 =?us-ascii?Q?0Vyr4BuK4HgSkqCndcu0aZIDENWRdT55fbSHIqe33CZFiwK6e0TtjcXg3Wt5?=
 =?us-ascii?Q?rZQdqJdJ8+iq1QMZQdszLGKcPcUJXMx789/Sg0v9zXKJia34FkaQnwtLC0EL?=
 =?us-ascii?Q?Cyo8werheGg+TzojrmpFxCNp7t+s3enO2MyMCREvtRS/Y2ki+RkAJgC3Oq35?=
 =?us-ascii?Q?JYy3bMn8C2qh1lAkdtr/uUm//V+zQ6ctpRLgQLMhdaBV1/t+qvYWnSKU+5+1?=
 =?us-ascii?Q?Oln//3/hjaYY/uOW0thuJcj+fJmSVMg9huhtvlk3RUVIgQCHBfJeRX9Zw2vY?=
 =?us-ascii?Q?YV/bz2hoYqvXvEfMMbG1JkeHSn2fFWpRKVEu+i/URjvMW+bu/gceKBd52wyV?=
 =?us-ascii?Q?B1hebQeTcjvQS1bdqKX6XjFAFBP1Y7wIRfqV0gXRlYYL8fRMnrqaLDoqmJxp?=
 =?us-ascii?Q?6HF+o4ndEW53bdIMnEFwF2Mogw+Id/UWkWQdLJBbLptukLTXp0FxbLbws/LD?=
 =?us-ascii?Q?ByAmRdzrGb5jww5Q2Jh81SSvvSfQYOJEke60/mhjiuPEal+8IlkN+GkSKYxc?=
 =?us-ascii?Q?Zoy0V/upXr4creGoy94B1anPcmKYEWTIIBre5ZnO8Q8OrognxfvEukSEufEH?=
 =?us-ascii?Q?NjBrchkf4tjMhr3KXyVLYKQEdv2BietF8aMOLHWXTtAbRaz3VQcR+YpQaQbi?=
 =?us-ascii?Q?7eGgJl8+e7s1nNctLNQaKGbrmZZ9b58HhT1K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:12.6215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2167342-36d2-4e74-a41c-08ddaac3fece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 30 ++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 3e036c37b1f5a..9d89bd1ed8075 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,11 +802,23 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
+static bool sdma_v7_0_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	/* we always use queue0 for KGD */
+	u32 context_status = RREG32(sdma_v7_0_get_reg_offset(adev, instance_id,
+							     regSDMA0_QUEUE0_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_QUEUE0_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty;
 	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -822,6 +834,11 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	is_guilty = sdma_v7_0_is_queue_selected(adev, i);
+
+	amdgpu_ring_backup_unprocessed_commands(ring,
+						is_guilty ? guilty_fence : NULL);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
@@ -829,8 +846,17 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	atomic_inc(&ring->adev->gpu_reset_counter);
+
+	if (is_guilty) {
+		/* signal the fence of the bad job */
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+		atomic_inc(&ring->adev->gpu_reset_counter);
+	}
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

