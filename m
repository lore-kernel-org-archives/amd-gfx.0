Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D74CC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C669A10E9C9;
	Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M37awWzT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1D610E982
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4YMEwYg6EC6f5g+bYUt5Gjw58dHje6r3KoX5jELZKtVQAmrRV4246LyuR+AgXDdz+uherdsRwYucyU3ach8on+0xAPXSjVFv+r8vft0iA/k6MGQ0VbeQYB/MH1Oxypkql8/Noe1UPrGuKAnCkmeKUeTeu7u+bTYGXEJRtWqgTtGTMVRv6IAVKQJRmbAklAOpowBjK9GIKYWfSDEZjtv+bwkcTODTn5EjivVJxuz+YB0gIJqnrJiOR8Th43w2/xUg4Rg6bRrHv+fS3Au38sZ55xkJFck2jDmAvF4Q0ehlU8SkQyF5XZHDEcRETdAKNwifVQZVHQmEKFFQBk0yznqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIXWsv8ZBBfgjH5EctXB42vLTzeeuBuk4YkR/bPnXfY=;
 b=qrNXnrtji5a/JVlWZa3M8l/NUxQ12pLtF7E59rqlvpkSf9Le8YWOBZ/4fF6lCJU/3/DMGPcDdEHOjtQ0G8l3LeRfVzwvY6uq7Q9A49M5XXsqRAFpV5XN5Y11fQrEdwJDC7qiJY1C5m7a9CWSnxzAXngTuSv1f5ryiD2i3qTwd1PQg9L+ivLAQqH1efv3apOiO/SSMDuuDU1bXcj4ReTE8ebfXjFPUS7uGHqPiifOWADnYNdQjUuWe9bpawbuUxU5Q6rgoPc+ZQDeUYYusZxyD9orl0TmTmR5HQkgaoBvwUGFyob1b1X4093P9MwR8PQaHZc+3wpd1/gs2YL/ufPDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIXWsv8ZBBfgjH5EctXB42vLTzeeuBuk4YkR/bPnXfY=;
 b=M37awWzTHlCdYnQur7UNkE83S0IB3L/pmLSDTehFbNatXgvGjSrSHy9QyU6mZKBYunzF67NiWUcAdSNTCm+WWjdd4RFghSiUPmGQPzpsQ2MCy+wcnBo07vvfqW9FZHW7Bw+sVHVmpB7N9KJAp8X0Dihdt8s+lSBXAu9bWq5Qf6Q=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:26 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::2e) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Fri,
 6 Jun 2025 06:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/29] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:50 -0400
Message-ID: <20250606064354.5858-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH1PR12MB9598:EE_
X-MS-Office365-Filtering-Correlation-Id: df6411df-79c0-447f-a12e-08dda4c59456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sPGcT19b+ds3Vu70YVQVVpatQJATevK2Nv3K1XRDPIMJhfhSyjHnxPvaTjnv?=
 =?us-ascii?Q?9jMOYACw7h3aEAQ9tbRmXAjJi+5fhtK8Pl1Rqe4a43Ndfatib5SAj1AjMhRt?=
 =?us-ascii?Q?9vl2L6ZILmGFeE9FNTKdrtPBABQKwm9HWXBd/eWQ0B0XDg9q2QG4C4f/eY9h?=
 =?us-ascii?Q?rCImbFXHxrikeDbtAYX4qy6fuaf5OcUZ9MtB1JNjK1gFqpJJmv4rWHysz76b?=
 =?us-ascii?Q?ZDo5ptWMWJ9sGcFZa297RgRNAne7Kqld2jo8agFcZknb6AGaAfVK+QA9DCqp?=
 =?us-ascii?Q?1EStknamWSMQCgMZGDCyN9NYzcj2GjrV6rgYjVoEyt6tZvvKoquZgMzMOwQU?=
 =?us-ascii?Q?z+nYu22PAA8vqi9V8wbt5qmLdVa6Iy5sPrCUbOWJY1tPk3508Ch3ajudYE73?=
 =?us-ascii?Q?18fYoMIZILyETG9YnX66CzR9ABc1LPWgxo5FQ+JwWjgPdRx5v3V9TJ5vxOfk?=
 =?us-ascii?Q?sktf1f4bAmi1+Ic3CfnNI6vyDEUx3ext6gWrbufRAelkRUWrQrUy13Bz9U6X?=
 =?us-ascii?Q?rCl7wXWyLIwZoDoSHxJD7BCmeiIjoxpwN41ayGx3nP0LMpka+j6D8e+Ufc1W?=
 =?us-ascii?Q?8AVRC2ClMMdJd4LIOwqi9jvZhMiFDiHC4FNJMnNVBCpQRDEs8xp5/gJYNIqX?=
 =?us-ascii?Q?4fCw1PxOK1TTUMGP6CT8KoUbhkGAyjMWnmUeU15IhkzfUvkQ2zWJbUngFw0j?=
 =?us-ascii?Q?FFwb1gPPOuadRRxgiA/79BhX2ut4zfoAsmEdxnL/8udwSb7cgN55aYkyoLT5?=
 =?us-ascii?Q?dczkjeLLvaEGo5SQWNE64fuL80Jg37QQbOThysWpN4pvCrQCnPeeYKLtHypV?=
 =?us-ascii?Q?9ux5ZWhXnc9v02d7N6D6F4da+Q0eyHi6cyn/K/yJ5c9Xs+P/IN4DP0bR75sN?=
 =?us-ascii?Q?+C6mRdM5Z7ihu1y4l8Z/bf1JB3oKc5ee2YXVZMV6CvHpUbcocrZ1GWT4hkDL?=
 =?us-ascii?Q?DEcmM9TZcUee4u3NnbwHOPT81D9+fyoYB3DOmI+tADxgKSOgbgAmYAagwOZd?=
 =?us-ascii?Q?tqgmCWJY1j0ClV/MIuphsR8UdO0C+7hcXfMb3iTSpnxhlriYTScGrh7vkitF?=
 =?us-ascii?Q?W2e23+5chFXeI6fWN5H7YaKkIuzgBsnpg6RtXWpZzuDLJAbFbuWjRDmqM+6m?=
 =?us-ascii?Q?wLPsYEuP+GHzznWVzSI/pqqOnAEyahzOKkrcOLWGKD+NVPl5bj+02qq/oNzh?=
 =?us-ascii?Q?PgvmmS+WPe2AndYzN5ITnWgIHmEe5zVlpvKDJ0nt0axjsgiGRYyiImdoU6K2?=
 =?us-ascii?Q?0n4rUjcFFVxm23hvb5uvkJq9NW6/2FlbLgpJjzmSQyebLxGBpB2M7O3fn77X?=
 =?us-ascii?Q?3bCfIzeJSplkGKH1taSkPrYnqLr8mQdJGG30zpTgOixeZ1D3sRTSYiAqyNKD?=
 =?us-ascii?Q?llnJqY3yv2bUOLeSrmk+S4LiuEiz4Jr6gImABslUDcYZcWJPYVghKUgLzE5+?=
 =?us-ascii?Q?X7zlN36OdjJVrnSKD2KLaEZW2UtJ8LbL5F+kBY3MtanKUkL/DOBOmJJ8wsJ9?=
 =?us-ascii?Q?xtbfGvV5SkzPA4hZuazfNjsBRWP/yPN9VdaT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:25.9441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6411df-79c0-447f-a12e-08dda4c59456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index ef9289f78a46a..ace6703c7677b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -842,14 +842,22 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
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

