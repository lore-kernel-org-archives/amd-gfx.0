Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB6AC83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4319910EADF;
	Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnMwepb9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10DC10EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK/wzUCjsmpsMBX4jQC+lnWFbPLgruOZrhsr1lv6gvQVmIbyIT/YsDaU5vx3L8OE4SAllsMfZtGcXtpS7/ljmDAs39CXri2wOWdbUsd0+wV+RBdLflKu3ywgll6Gdir8MCYvmCOzgWs1eB3V1Mmg+wCKNaP3Buagjc+hhMxQve4XejoXKmt4fQAnZICbnv7k5XHsXqLwE1TED6TcGyHGJlDQ7GEEAnVZAXumVKRw2nh25e6B39eaZRDZASxchnh45RkURyvoOdEuejj9SMFRrtykGtwiUXht64CYJkMXhaT9zvmV3Mu/33pfn0dzw5EKMrEghvlALlz5cfuLZ4FNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=735qG+dIzLmd5GfdZCKUcoOLqVkTo53y0NHbnT9Qxbc=;
 b=i1taBXf2Vqe/cFXrw8JiRqIQNhqv6KhmsmAGfVv9J4BWjZ7mryQIyiUvAzp39lWn+OTg8WPubgc02Gf2TLD0bAtKsJ5trcfw2Iyf5knuqctIKWB3ZEbnOklAOZJ0NsxBEWwWnJH6LPaecN3FvqfBSH3qOKoaB412nfpQKOBj58ZzrWOHEwYaC7ETuB2pENGbjag5RRqnm1gaJSDnNud6zP+EEx2J9Gqe4HvnPc25GTH5glnv5kbR5tjNACPc2/MFSlNsSyEZZiC6JHMb6pYI1dG5QFagSM2iILKMTRZr+nGshe40IwgJOfMCwEDKzW1qgeCRVIWbkJ+9ZYB53i9aTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=735qG+dIzLmd5GfdZCKUcoOLqVkTo53y0NHbnT9Qxbc=;
 b=YnMwepb95KfTPn//mLg7hx+CJf55wbxDb4j2PAOi/gs19d7RmZ2BKBrOQsosd4V33vIf7LSweuZFAX15eQ0NuVyQODUeB3mlSWOOyPfZscmgT4zJ3XLw5PyL9t6Ol/mBH6mA18YNM2ntbo41EuPLM1qPjz0ZksmschbzK8gKdII=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Fri, 11 Jul 2025 22:40:42 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::74) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 03/33] drm/amdgpu/jpeg3: add additional ring reset error
 checking
Date: Fri, 11 Jul 2025 18:39:54 -0400
Message-ID: <20250711224024.410506-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 27aa0cc3-744d-4cd1-a8f4-08ddc0cbf75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UYH67l1NzAI/jb1ZmFTY2Py+hq+P/01JquyVFgRvNTk4e6hr3V89HO5H5u06?=
 =?us-ascii?Q?kITlvMR+bQT16so3jh+SCh1VkAHFDJgPSGlka9w4nSMC0rvtVBvYFoMM5uwZ?=
 =?us-ascii?Q?AU7MXj//ht6Z7C+aQncVTixLXl4WBJIeo8E/ySwyjPrLoHQiBbg+5CrvJVDZ?=
 =?us-ascii?Q?todco3jCtQyYpQVK3VyufyIZirnkpffEAAORzcB4d3rShrccri9VHKOJKz3P?=
 =?us-ascii?Q?6LbzduWTOuxTZ7snJxDi7XD1GEUB/J4y2kH+gx2CBptVm+tE2sr0myn45VXF?=
 =?us-ascii?Q?dOZqhrFaXpOqv1D80YwpOZXvJMWvRcy/ACwYSPfRqBeefGtm4y5sEBhpMOWj?=
 =?us-ascii?Q?YNGDITtkWkLNQJAXEQfQqreNn2p5lsB0xisgAqQxgJhhXmYAXslJB65rxWHs?=
 =?us-ascii?Q?TF/GHoNBRPqGphxZ0XyUjV5dX4JB92Jteat1jY8PU/jJveP9Q/jp9sJwFGV5?=
 =?us-ascii?Q?nqZM4c7CGGxjhMbHr8Zu+uHNVv5dinU/YA8GSJF2BOApNwLjATpF5RdZKwNp?=
 =?us-ascii?Q?FrE1r0LkcBk+TKib6+Kq3sUig6tcKu4mKoWrVpFcX9vKNE8sWExINL/6S0ro?=
 =?us-ascii?Q?GndMjr2mtlJfv89F9D3Dtu4BPdduJunphBLhO6+7BCum3rjYvuAA6B9xPqIg?=
 =?us-ascii?Q?CJ90itMGZq1rIm2u/10qg/txAgbo1gp71p/Nturln/1888EPsEupCKDzy10T?=
 =?us-ascii?Q?3Py/BUKX4U/FGsZlqtSXE5iKkGDMMAvLtYPd7VZAg2FTE8+oK5MEOJaRlMht?=
 =?us-ascii?Q?j3+xRsGG4m4xVsa9+JWqbvVwLHB7KbIN/50wT5yWVGNc2shk02e2X7jssUsF?=
 =?us-ascii?Q?6qg8RO9T2aBLqdfCOCXvalpmmwv2w0jJS1+fNtfcX6sJqeux/QEIKSKpieh5?=
 =?us-ascii?Q?KwOAyoNHC75xwe8ztisfB/7N2WXkqaawO3Dgcpaj2RxYR7etuBNxKc/keHTv?=
 =?us-ascii?Q?Zk78pVG6hWtddti1uQ7HEL4+D9XRl62gF2do5M1N4yaIQQcy98rnYFKCu4lc?=
 =?us-ascii?Q?gx35bZIS0WSwdbCZnTYc/AhF0GrgvT8o8Q56OY7eRYI+X2b5i2Kc5raNEZiI?=
 =?us-ascii?Q?EOo4HdxW5Xu5BcGYPLAfLBV1ZOR5Q2VZxOLRQQjYCD0yP5qlW/rYBAeyP19R?=
 =?us-ascii?Q?+QJ3AJYfizXGcafIJBF2ctY3Lex2amCsULU6UbWo1d1+bnfdX0Ok+oqIG1TY?=
 =?us-ascii?Q?7+5oyXKlboaroQaNA+U/uvc9fDLaH4baobOexHJ+MMgH8HK69u6bYQ8fYQCL?=
 =?us-ascii?Q?U3oKyF5rm8nv23uwoDV5BYXYGX8U3fkqNZSm8Fz5RiFedb6o9Oou7cRiAf8I?=
 =?us-ascii?Q?9Eel2zVfxeMdSzqz2tope+NwEnblQaqWkJOP61aTnjqNPgITqNkagNCEKSbi?=
 =?us-ascii?Q?NMUVHs63rIe5S/HBxrbVz1Ttr1n9h7UIQ0clb8FjCE8QCUHKF9ak+JsRsPJB?=
 =?us-ascii?Q?A6IzTzmc0ZcoVV1Ll2BOCbPPCxR49rTwrrqDqzzBMdqIgSiUja7/fqLmUqJ3?=
 =?us-ascii?Q?GpOyLFy2R/6Qoxdtr5ls/N3F5QEpM4CRQ6da?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:41.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aa0cc3-744d-4cd1-a8f4-08ddc0cbf75c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

Start and stop can fail, so add checks.

Fixes: 03399d0bff25 ("drm/amdgpu: Add ring reset callback for JPEG3_0_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a24bd833d6442..5428930eafa3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -562,8 +562,12 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 	int r;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	jpeg_v3_0_stop(ring->adev);
-	jpeg_v3_0_start(ring->adev);
+	r = jpeg_v3_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v3_0_start(ring->adev);
+	if (r)
+		return r;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.50.0

