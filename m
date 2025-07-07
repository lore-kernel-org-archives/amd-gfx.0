Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7DAC83F19
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE42510E511;
	Mon,  7 Jul 2025 19:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LQ5ZKYhy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D2310E541
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZfMXMG0kvH/rg58xexJzkVFidQ9bDTYLOq+WVkYFrNWCNfz9/N45gKqjir2SwR8BCz5jufCrGWGSwZf9AQI4l3HyEDc+m8Avb6KJ1B2flnXc4FYeLFoP6fuQDBxnCh4Xxxk935xgIHQragqzJPp4sPU6AJi9AR/hQa7dS22c9RKVYqZ2wKUqbBxrr4S958dny2v9V5q29Kb5MpJCgTtHp+piiswmb95YJaPtKbFq41e/1rjwo/sbxqOpNOHQ0avyntDgq38X4jZzpn2hAiKjHrAxn2T9VNjO5hQpbElLNtpMvLg5DNjmfKvASd2n3fAvsX4+J8a+Snhk9Ov13rRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQXPA60mpkvhFqBxphGcYT4gGr14ooRhc06PsaWx9NA=;
 b=K/w3OThC9dlAH2ybc1n+LMFlYq5Gi7BIyVmxsNAIoqbVvSz8Wnc+nAnqhjoRLX3CkudC8r/emvyPdMtInAupJ7a5cZJjJF+CEaFWHZqHiOMEwXifzl5gz/jtpQ0m83qh8TSNAQH4Iy3QK/ZZJ/iKbsj2qdDY+uE8SMV0370sxyQXQlLrSPz3/fwKwwlwakt5vF4FF1XPiiV86pee6XzuwoLq/nYnYn3sy63ss0AlLjuUIjU3/4QuonDbTj7tg+RU0dZExICMpuFbJ66wHRmOBC71x6JpVxdp5rSkLCMP4s4JfIjFJPLTNBWRaMWzYBl7NY7inDnZBMCWsy900n3NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQXPA60mpkvhFqBxphGcYT4gGr14ooRhc06PsaWx9NA=;
 b=LQ5ZKYhyM1FnV77naB1dMdxkClqbX5eg74fwSMDEjfdnwvqPNu0QTKmKj4ZCIj76TB4UZSOlNQfl2Lj5Y5Au4IcXgxFSKdo7G7oaA7szUF2NMyLeZClZ9dPa/i7h1mKyo2S4gae9rjbY3bVSMUjUnjn8REGgsCEZusCQKgt8JbU=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 19:04:24 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::e5) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 21/36] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:40 -0400
Message-ID: <20250707190355.837891-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7320bb8a-9c6b-40a6-079b-08ddbd8916d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?59yIZMjNFIKloTpkEHHe/uXlg80GDpLZfc35p9850asSJkA/nLJRzxY5Aw6T?=
 =?us-ascii?Q?s4wNP0ShtrCTY+ywYr+dxyNJ5bvphMixN8DFCvB50ZPIxiVjwREwjloC7LQ/?=
 =?us-ascii?Q?pF0/XYRM1osNHm3JrhZ6h4cYBFjt0FAk4xCVTrhf1rHRudYFLFnFeE4qNwoh?=
 =?us-ascii?Q?yKX/xc8vHIfG7fSjeABo/zTxpUPQCBuE9lqCri4apz2n2S2mehHVil80EbbF?=
 =?us-ascii?Q?IyZDTdQGiPaXcV5jFSqiV4YYX8FBWXX/VmXD9vcZ6oLuk3WFWC7ho5mGVWpy?=
 =?us-ascii?Q?VljxFPP/vWNcb6F9TEH8Fp/HkqHrW910/jSzCzZAoVi1n3wXZlYGxDXaFC2T?=
 =?us-ascii?Q?croCwfxYjWagLr5pOnqZgT0+s/lwE4MyiDUiG9AhaRFLdGs+LhZAnL6l1ibY?=
 =?us-ascii?Q?Jw7MeIf+dei1+wLFNDfwpaOGcGJOPRsfMIJNPyi2+o7NTuXcRnorojbaEZCb?=
 =?us-ascii?Q?GnzaNGhfGU/NfjQI4HB8eD1xx7xturMXnD6ETpCQm71y/gc2M9T1DUTH5wXF?=
 =?us-ascii?Q?i8XAykFVbLl4roqU2/klyOjUCTKWmEFC5GZnhbKHp2an7rmnsporjzqvonBr?=
 =?us-ascii?Q?Q6GX4ap0TqyKYAwgkBZcKLVrROGM35SlMf63SPhO71snvt2kb680Em2ZGh+Q?=
 =?us-ascii?Q?Tp/lCRR0L1uCOeorrb0VEasYsEq9qDkNVjIB9KQ84SQ3+tOtFFhEOwIfkMcj?=
 =?us-ascii?Q?sVGk1G0dWVRK7JAPfpsaES93h3/5cNH7XU348dDYoRiASDQZTxgEraV59MQg?=
 =?us-ascii?Q?gFZZaHLgmRW3+U2xlKgOClPXQEgkDLISrfBv0cl1altOckTY7P8K0sf2RE8/?=
 =?us-ascii?Q?hCxkNMPkIo8ZL1TcG+9TdgsEbujXJhzyr8rS2xmA6Y2ZwWw3GY/i8JDfnAA4?=
 =?us-ascii?Q?mx7x02Z+QpGwJTM6T2/p7r3GW5V1NDGb7wGzBIp9Gfjuk7+hyuY09v+Xi7PS?=
 =?us-ascii?Q?cmf7g/TiljYuq76E+AddrDjEUSHWPjmbhkInILec9Fl2ST51McNj6xL686qE?=
 =?us-ascii?Q?Lqziegj1R9viqvdB1XTAeLqp4GRVBnUrlunVVZ2ZVUg6TDrlYJCmfj2oZNuz?=
 =?us-ascii?Q?jMhvpAMGFCYgUsSis2b4gNKztuz9NNQkUzLfRMk6Gmu7Y0IEfcRZhJBnmwtm?=
 =?us-ascii?Q?6WT1eOPq1NSdnNGrLx8jaQUE7/GrbP5Zv2o/26E/xfZy/IZBUS1gWMyai8yg?=
 =?us-ascii?Q?tyJn83PB/gaQM/dpbCUkmc5Au+KyIsBDQcIEMAII+txH60RJDmjrczk9EtRO?=
 =?us-ascii?Q?5kgWJ3vXQ8PlhFksKuRU/4Vlx19xJ9fP4KBhP1VsgPUwFDVXf4omxxVqWzbQ?=
 =?us-ascii?Q?Qm1VjFvezOeC9SUFoz5Bnm1h1XFTWS3VDZFniK0GeaAWp54Qta59HE92AF5K?=
 =?us-ascii?Q?lE78Tx/70CUwCGuWjzeYzxnoQWPoVEMfbM54tNWIoEWFWg+HupXS5FkbkxLJ?=
 =?us-ascii?Q?ymAqK7ySQHsz9FALirLG8COv5y44Pwq1H4KUFXHxMVx5xb4/GmBIdW63PQoI?=
 =?us-ascii?Q?zhPWxzq4neKumdyHzmTNcCVsS6Vu7c42vtI/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:24.6555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7320bb8a-9c6b-40a6-079b-08ddbd8916d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 5ba1c5ad9a5e1..d4c47c4a14308 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -770,19 +770,14 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v2_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v2_0_start(ring->adev);
 	if (r)
 		return r;
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.50.0

