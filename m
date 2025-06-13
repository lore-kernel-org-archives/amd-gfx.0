Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C1C71150
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A1C10EA5E;
	Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjj+0kKv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA1210EA5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ4BFeHaQjop05MN0Mpcx/ILNH9Xp5KYuh3L9SiCh+nQ+PLKsW6QZP+NgiMehTac0DpFLehx50ixpKieBfjBRYoN5hPmAZ5QadigSZ9sPP/DxAJKIQg6YFYPdwmHEYHlvDfCpyB4ryc7LKtz1Bluj8she7ALOOpllJ3Y1RGkE2RVj8p5zTcwy0gCLHAciYNDDU3U1olCvMjO7vxn85fODmTWW7+UzLjnixPxRUGeeDD1kbJqdAVsTLjyfyjc1+wzygnRkDnJs2fadTXbHjHbrsnGMS2bcxQILyNxTBx81iMtogolsuSyjjXvkv/XhMwSupqySoLqQdCRas2z+Uy/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyikugk5Jdc528HZE9BRIw5cyqi+D+ptnbF+u1+UwXQ=;
 b=LIAnt2SvaDP05h1AJWt3DnGe/dnow+PO0rj7/p0F3fmyPENefHFuwkOHtBq3w1sXoaVZVy63JwEdddztmgX2lclXF1yWi+aMBesJEMlZlfbSQpU16tRjQWIB+6Xre5oRec7aRsayocs39I0IUaZ731SL294alBYnvbMvIZHEAcq/dMbeMhnjwwPPyO2mwC6oYzSqA10ooJigEksngRUxd7FpuEDLrpSEDl9hurwwu2E9XZqwtT0EqcNpXaW11yyLbRNp1YFs87OcBuTT2kLTWqFbETnQQSnhCwOXRwxIl+GOF2dNH2WbSAyZyEGtKGdQmljL4QhjDvYa2XRusl6NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyikugk5Jdc528HZE9BRIw5cyqi+D+ptnbF+u1+UwXQ=;
 b=mjj+0kKvK8mNbtS96VLDN2QgLEDaHitKrF4TW5kULYDqt9hcptIKLbdsEEBvF73ATAC+ZALeGq/BlhPPmLoAD7We0RWWTIKct8eBseIDpElzx51ZFwzFhPAZ19kuvHzNvKMtnvtKjlxnxuqpFPTCKh0zomICLmiAVp3a4BHH9CA=
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 13 Jun
 2025 21:48:11 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::7c) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/27] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Fri, 13 Jun 2025 17:47:30 -0400
Message-ID: <20250613214748.5889-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bd3af2-3278-4caa-dfef-08ddaac3fdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KDSkzQ+xlqedhN5xZDrrotoA26HcmXfttm9o7RvEZslLIRdg8k5TvhU3vJc0?=
 =?us-ascii?Q?n8HnjPylbhTHKPdFNcddrik6pq+Tvirl8Wx0aFQ0W2jonLhy7P+3PEVXCcnN?=
 =?us-ascii?Q?34M/BelXdTfY9dAQH8UNOemX0wo5QzdfABee0SJz4+s8rUpENAzkZiX+f6jI?=
 =?us-ascii?Q?M3Zifm2vtiETwFXu0An89IhknNBoCcwTLk4Hy4VSh5Gw0AHk0j6MxtQx1epR?=
 =?us-ascii?Q?7LZul3ISix5tk8SQ69tByF1eK5pQcMtEaE4Fjrso0Jour/gUroVMk+t/ALpt?=
 =?us-ascii?Q?+YfXmPM5UO9ULh2t3drWppaj341+ZxGhjWxLZYnutqMc6zCo/oArvh7HMj2J?=
 =?us-ascii?Q?pJmreCoBGmiMvKS+NERyd53Ed6+kSjiZrdJyVqM4SYHB/69OpFUDK5f3dCZe?=
 =?us-ascii?Q?8Q03NUm3qvFFOBTspDiMQ76rWj6T6mc5EuE3WSeHz5PQG27FMmtwDbwT5zxK?=
 =?us-ascii?Q?poNb7LHTThtgjYa8dp//i9xMjuwMCII9/HUhpKCrKza4YnuxUsUiPARdINDP?=
 =?us-ascii?Q?eXuyohYOmcGYCWkN/+o/3HY00GsY1Am/Um97ILVMiYjavnoiW/TNaU191NKU?=
 =?us-ascii?Q?wjnX4SitGs/LXM/ynrgBM7wSYBtgB9LFZupcxJ5420hmtfOlBD/EDCOLnqs9?=
 =?us-ascii?Q?DZJB8eDQiEXcZFme9PW7bCVtjHL6aGh5cR3V1GleCZoaSag1kI8+O40f/AHG?=
 =?us-ascii?Q?3FxeEhVg4xC4s9Xz+vYAvsOlCPkyjfQjLLlMxovjSSWgRVzhn2eOPNZm/eRg?=
 =?us-ascii?Q?GHKeVXVzC8MUQht1viSN5NTk5IuxWnkfCsSm6vSebfiJhI/cX6kTPANWh007?=
 =?us-ascii?Q?a1yjBV1EudOqXZq8ZQfLvfmh3iRSzOybs214y4w4ouEg1SAyQXlT9CDy+7O2?=
 =?us-ascii?Q?xa2EcxAlxG1L35MYbwbpkBFf2yxtpq4wpdqygV5vnp33SKK5tlKZsJlZxOTg?=
 =?us-ascii?Q?iwkEpqTv4XGhbE6o0tI9exeBPMm52nbX13qcmByqF0VvnDJpUEQSIGi34o7W?=
 =?us-ascii?Q?6lhdv1oXFMBNrrF3klQB32N7vEpMvYgZABYed1xmrUNzScgIsdXJjAAv6/b2?=
 =?us-ascii?Q?xrWc9O3FQ1eWtzFdd/OwQhPl7D0cXB900zZcW+9WEU/rgVJLjE7A6FhAc054?=
 =?us-ascii?Q?4e4WREYU9COaslmYx3ZMJ6MLmxgilFnQUqB+4xsvZ6BPleE3FK7XZrHoz3CN?=
 =?us-ascii?Q?7dglBU2FhyBRsHhx3+FdUyFRnFU90IyPbzrU/yG6KXx02mf7xlaPi6L5l1AU?=
 =?us-ascii?Q?jXTxJynMaeGUkymI7MgQH9jP0W2IElqAv5jAiWzbcY66++d+c3ZHPof9PAJJ?=
 =?us-ascii?Q?kVblgmz5xyuxxhIcgrVyXCjRRB5ZK0oLcVm8mtcIYyZl6jZX3qFFvFcu9PHS?=
 =?us-ascii?Q?UsiDxn62AsIcl46jHBUO90sK2+tX5SYYwZHJxb2HcTTsF4EyCFHp65oD4/LT?=
 =?us-ascii?Q?cqumVz9HLKuW0t1wmp4wQK2HrSQ7fMPIrf5SV7EVIbXWiY5iAxVa0JeDomme?=
 =?us-ascii?Q?A2m+O3Tsk7X5GA6N4aHTXSdycKGllyXerrdL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:10.9590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bd3af2-3278-4caa-dfef-08ddaac3fdd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1b767094dfa24..3b3dd98245dcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7168,6 +7168,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -7217,18 +7219,24 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

