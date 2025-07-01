Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACEEC7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F0410E626;
	Tue,  1 Jul 2025 18:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CDskrnW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2789C10E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvW0qsAbSJZMzUY/bJXKzqYUGWJuQ6P/0lQtusx3RUEwFhHG1nkSueDk8m/vVCs+PjF5OpGvDVfpbh8z/YfQEel7XZb9mOCnPoDMuIVYyGNcZebO/l3JOcXqtJHc53ZFZ15rJB3YMb3y04+G8PUtDBNhTJuWAVf6T5IhpvjyFfI/4Y6gvkepmlU5vYlCTK3zu2ndf5XxWGFhNks3YL48Ge2V+/l3H2aDASVTci/vHJzLRSOaUHny2nEVNBm1nWT0QSwzDt376gUoAhq+YH1IkmnPPaoz/vLMm0zMedpC9TWj61Js1Q/0Gi26pliG8bHtZB65L4btHXbthIjP5IlIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=aMqh0PqhS3MZNB62gptu3dXPOaYn3FkGWqNbh5CmpHXYgqpgIRJJYK0wr2QsbvuVzN7JCuu8p0fX14Gy+tcyCMUQD6nPCagaSCvCD91Oz4aTt7Hqf/owiO3bRhYhNC3w3oA9hz8gbLQfEwyIqEMrG8e5NLEO/FDaWnrb0PPbc7AgoWqWg45t6EGiaWzMGzEKEy4frYREZYyMfhdYOSKRb4qQfGRgrmp8pHOvr0H66SoSqrO4l66sKZ98n1Nx2GZrWfkNqWd4XVrxeJw01MZ47kNcj3EC86Rg2+MSfytcl5nYTzZcwuCqRgW1JmC9UuYmGNYsOdTzKtpbyyX4Mt/ZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=0CDskrnWF5JhNf6q0d0Wg7WQCs/8KqCHp284AYJNoqkC1KPyI+lYYG3ek6xrhEBfv6h0yZvD+/GqOv/jSqxxN5fC6nxBp5Ofw9hVyacxhfSdHAK0QesUrVTLz1DHTurjEyLBcPsA2R/uZXR8/nlXKm8qMq9ydRK/20BvhV+264I=
Received: from SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 18:45:14 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::2c) by SA0PR11CA0008.outlook.office365.com
 (2603:10b6:806:d3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 18:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 14/28] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:37 -0400
Message-ID: <20250701184451.11868-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ecb83e-36a7-4539-d3d8-08ddb8cf6a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oc1v2lFgcCd/gFnW5VP8DqGUbyc2eg5ojdA4CLdysl+tOdgwH7f47Nls+AU0?=
 =?us-ascii?Q?PVmjGqgFxopk1uwia+xV/xwqoLyToUP6CPMBrA9od7pMCE4P2xUq6+dI85HA?=
 =?us-ascii?Q?0GdL1vQHUpWUGAT287L/mm6uPMAFknWZZ7rabmnCrqduBzfrMAiQS0vnByu7?=
 =?us-ascii?Q?ToiyGDcjl8BLJPblp74vaGbjkrIav1dN48J1J0nYvvxqODsMjzTf3R8LXqke?=
 =?us-ascii?Q?HGk8LjSr5aQPVnl6alLlQkifzd8mwvfZXeubTyT9d9uxn5dXzrC61YnFfLsQ?=
 =?us-ascii?Q?7tIIy6lw3hAt22xuZGUJi2T8HrcemoIJ5CWeK2uLOeqtBKYaQfx7k/1lY4QC?=
 =?us-ascii?Q?4eYs0kkmiOZO+PWHG6o+lzPY79bLlNx9jlBPA2Sv0GYNi3nxtJKiBqpZXkoG?=
 =?us-ascii?Q?AVLbYMGMz5MNBwt0Ech1ifkr2rTkiuJ5V9uFW6jnr/PU1oqF7fxbcA2GBGZu?=
 =?us-ascii?Q?SpDI6dLb0QMl9mtI8B9xWvI94/5y0v7oQ1EEWeTpiRVDyNjffA1pY5vEw8lh?=
 =?us-ascii?Q?h/J9I6LolzGjW+RHN92jANRNT5drYDhxCJglRNYsVnCXrSW2qai3hzASXGWy?=
 =?us-ascii?Q?hHsCk8ccs0N44xIK/lRUlNYYt5jMGXM0R5v/9PK7sFiT+PWNvji8k+cQRm6o?=
 =?us-ascii?Q?O8HRToxZGzEuxxPGzz4OLVLVsZvbEtE8MdI3be9RxEoC9AcfD+W+mP4yzWBO?=
 =?us-ascii?Q?YULGbOTwQvS9bheNoYzPDFUA/9EjDbrmNIpzh1xEALBv3HD7svt8nuLR1iDY?=
 =?us-ascii?Q?hRBMnLbuF69rZZB4rHO7rhwaM09fWvUEOT6uPcv7fonC5mB6JxXn32FHDxcn?=
 =?us-ascii?Q?GKh+Q3sCH//81H/ZP6wIHDsxT1ai19/2zJm9XakOivMBtgvzDlme24mhG8+B?=
 =?us-ascii?Q?l7771cloqYFD/7YyWZcVT0S2lqWwKLxhtPeonYL5Nmtzusk8JOuX2Bful1qG?=
 =?us-ascii?Q?njWVHxSo5IjvNeZeIKkbjWN8GrVf4f5PCup8+5tY+e2k5X6VpZNLucGJ8+g1?=
 =?us-ascii?Q?E5z7d59tOlRkBlIpLRKOVhF2ISUTcKa6HC0BPFglIyJxauypSYd9ZB/J7XLX?=
 =?us-ascii?Q?RoFb1h8t0WS1GZQ4nXWjLvGxRLT0nkdRqNt/iST5RDBwQT4AQ0LzEeDGBylN?=
 =?us-ascii?Q?GnwF8J8g/2phXVrpE4K7oJU9PjjKtGyfLs7sWW02X+v1C3hgaPGdped5MxLZ?=
 =?us-ascii?Q?8kRQicnnkiIvt8N0oFh9zaGWvDnuKn5XoVSPzxCxG/BSgONiyJwpZE6fY/xG?=
 =?us-ascii?Q?7HrWVpE3zMRd5Jd9pfj7Mm9wruFLsSQbHbXGhZdli+3AmTPHF+82d2MUSh5r?=
 =?us-ascii?Q?qWWkXdeWrhnH/K4PqSMJMobbUvF+a8LOQOvjjDRuuU8ugjTpabI84k8uESgt?=
 =?us-ascii?Q?CFScJbl3uCPQpVTQAUPJhgEDv3Uh6zHrZhCYDnY/oFCNyDYq+iWa/yUxZUYn?=
 =?us-ascii?Q?0fm/YWJOcLc7iJG58HhgRhGKwMwtdKVl3SIJ+5wl6EZN4zve1sxMGkDUr3eH?=
 =?us-ascii?Q?MNwtqhtir3rtlFmFi3kJfyGtMT+lEVxuPwJF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:13.8684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ecb83e-36a7-4539-d3d8-08ddb8cf6a66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5be9cdcae32c1..7432990f77507 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,17 +647,10 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.50.0

