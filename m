Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D69C83027
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FEA10E957;
	Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4xefm+1o";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEBD10E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO16cfpjH5u0Nnq44QjiklQN0m/RKJyTI5T0pW/x5oEVd46tB8CrSnnMIAMhLzHwdCUnkLUGzfQ0neGr6v5mT3TQ7qHzNQ3ATqTpiOmsvZlOo4wEei84o1v6V+JlJuI+labTxLlIQad0iNnXx57BH6yQ7WoC+HNx0Ev/+2t9X19Q6VmbgJhywpLThvMTotP1/dpJrZ3nKIZJm4c/vIJrWIr5/+T74QXNFNyXT/OvUoy/s4tmERjD2Qugq7Bhxq43dHlveKNdRgC6G6miPrA6Sah+jspMzJ+yk5vC+LJcF/cXoIe/Ow8pyyEqJ6Im23kGaBbEHYcVoZU6aC0RJa79WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXVpr+TQTOc/CNdusWJlMee9AgPICcF+8373axFJcM4=;
 b=qtuxe2Zd1njjTe1/jHQviygtRHt4oOeGzOqVKqL7V1H6E0eERFpK6LV4HR6PLbyMZNXmAOPs/QJBJcVTa+PEQnHJADIw/D1SewhMmku/FwCdFrtaIiEbXM1mGvOr2mYOJ97pyXnBY3wHqnr9deSTgzgII7EBxlj0FiELt1mzSz10EQxfyp7ginS7l2fcXyVTwTuH5TvxPIu1EMZIBTejLVx3+UEIT2UI6hv9JQZ/7KxhKSF/O8GOeMkZg93wc5BE1IbfqZEjKrStc8R5fnOqx0h3+tRjsz/mLvkYi8LH6SlGwYjN/bTJXcfPhkUD6VAk+ed+qpAzrx5koGvSmc0uBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXVpr+TQTOc/CNdusWJlMee9AgPICcF+8373axFJcM4=;
 b=4xefm+1o5AysQrZESdJ10A5eGPEjbFD4jzLN0iqSlTEzKLIiMly2axYpdZEwud5bd6edmjOZM1iVfyqEZ5h1wiEse9ISo1ZLxmzfaBJri1goIhiimzrty5qlVMjcV0LZ4TcQka3WdzhrCwewpLXW2d7kSLCWvWK4K2ObDqtyxTo=
Received: from BL1PR13CA0182.namprd13.prod.outlook.com (2603:10b6:208:2be::7)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 03:40:39 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::28) by BL1PR13CA0182.outlook.office365.com
 (2603:10b6:208:2be::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Fri,
 27 Jun 2025 03:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 26/33] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Thu, 26 Jun 2025 23:39:55 -0400
Message-ID: <20250627034002.5590-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: edc483d0-630a-4d07-f7fa-08ddb52c6243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YjuxJfLUsgw6rQZn/e7Am6ECgzCfeU9srUcyLUP9tTcRNpBxgCNzYk2B6yv9?=
 =?us-ascii?Q?ugljI2iEB4Kr28iwtvet/8gIaJxFlMVWHXPEpPGjVjpVRV5C/0KSm6W5tqf7?=
 =?us-ascii?Q?6i1u36Sso7sR/PLxcBgFHglQsW+cj6iIP2PB2fBR4REhWbRwun1aeayOt24p?=
 =?us-ascii?Q?FIOCrp6Uti3zAlM1EmahZFBWNi5E3NWh6PBX/0zrob82jTg7iufihwnGSs08?=
 =?us-ascii?Q?cCwQ9MVjdXXI8gpNIxQ++/MHT7NozkB3nKlOeDFnLHPUMaYTb/ffNoGos6NS?=
 =?us-ascii?Q?MznCYSDyJXQnoPdqqmF7HY9ggtY2NZcCHQfs1dzzvLKeOSzKQpCQMrYW7/xs?=
 =?us-ascii?Q?j2oqUvWDOkourw4C5o8HDEH3766A4tz8dUvhGtctixQMeqnF1TzVPgD32NYp?=
 =?us-ascii?Q?tMbYVdFLv7TLv5lTbHp2Y5vCQQ0HgCNS1PWfKw2QdYy0HjgH07SC5orFnXzP?=
 =?us-ascii?Q?63ilncnMaWNvLTteQfBduR1JnN44ojqVpKleRpkvys0HLdhnMTtzVlO0AaNY?=
 =?us-ascii?Q?zPxH+oXDVCZfddeb0t1/dLnucQmzlbB0NKNIzy9kzfiaj6i4O3nCtiErhQnH?=
 =?us-ascii?Q?tYLZyci24dBq/SYLMI5Rw57vwvt4L8h7ITTMMJnJoTN7FqiQ84xVZDJSmLT9?=
 =?us-ascii?Q?jkgfv254Vq32Q8ZHc81mqKo4C187mGzZJzMhYlwi/pz6GCaFTWY6ABDD3LiB?=
 =?us-ascii?Q?iCzjzjDImdUN61TJ9nkVtgxkYUPtaw26cnclSeWAdZeu77BS9Lp3ovQyUN9N?=
 =?us-ascii?Q?GhuiFT+f4FwdBaPA2kzq7yJe+503rQunMqkzAHbOpTUkATS74dg0XxU8qsiy?=
 =?us-ascii?Q?OAaJYGQ/B+nfjiLmYvWv9JmwBkHKqjZ+hmXGAVab9qiTeN5ebq67DJg/ds84?=
 =?us-ascii?Q?uplShhJWyXlzTjGe3LPJsO1mT0IbwI7TTNu3rBNS5/olBOZm4XYsaUpNo6wU?=
 =?us-ascii?Q?gT98BCNL6jCQvLGC6pvvIwtNvfZmnoHzWiThy0wq3Pz7YcMoKy0GUQMP3Dbs?=
 =?us-ascii?Q?rPLk0bI8ucHJxmMWBvWAFuPAxWBAaPsB6EzO6vFyvJqCEfUZPYjwEcRKrQep?=
 =?us-ascii?Q?L8xqKySjUAyhr6mqaGqmEYXz6Cr3mGjtLAxPpsHwlJGsXp+W7+gPj4awPWMA?=
 =?us-ascii?Q?GmmEgFwb4d3gaEFiCF48/WGa+9Rxjf8BtFMjWd8afQ0zi0/f1kttOYKsCARQ?=
 =?us-ascii?Q?AeUIaLJpgmcifoCOMfG15cKX9JCcWQonpCThkEigN7AIso9be4eW1UIkiGuf?=
 =?us-ascii?Q?rEAqPmnsRbBoYj2svuFlVy3R2jv4t47ye5R6l5g/LNXZo4sF1DhvUEnWlXm9?=
 =?us-ascii?Q?0YGvTUZaEdv8ztjOQrk7LWY2KPDyY6qTvZ1j7LyPCJDAwqAcbo0Gusc5mS+O?=
 =?us-ascii?Q?5yf09IqsAkTemw9DLe/d3VCW0c14CuanQM7W6JKqfF3KDUtpOb1LDpCEPSk3?=
 =?us-ascii?Q?GuT3K8xWNCGrf6cssGcvJRTEaqwN+Fal3Xj7WMQUX5a/s9w/j4Vn8hVBBjtB?=
 =?us-ascii?Q?If7yAloPyBKuVi3Sr/Vj/XJvKRGizb8z5vwD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:38.7790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc483d0-630a-4d07-f7fa-08ddb52c6243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9133e1b2c4..9bf1a345ac2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,21 +1973,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.50.0

