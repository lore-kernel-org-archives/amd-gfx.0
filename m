Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65309C5B555
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789B510E778;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ly937R9D";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C54010E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFOQLVqrnBKNY5HLWdlaQTCd2Pj3jCIXh+AmAT/wqpmepbndZ+TeDUXjIyd2ud5g73eqp81fGU9Qp8ss+UdzrnL1/KMCQA6tNHtsnApKvh2Iv8zM4v8V1EAygHgmqOn+hFcyJ36xGulVLCbXSJvp1INz0l9R7n8ImRq+omWZslLDkJ3F0SXFf6jYWgAkNC8I8dgyw18oNtd1KwTxhs7XESGzDQ2ARIFshqa93Gl3yrrUBwQ2i6TCKiXKVbTrh0Q+H01esOB5qoWWHxVbcN+VNADlIBqTAAkojnu49aLLFkINP2kjANwxFoGRi5OC5ZRLPGM9tmmKr4vjgbRZ1HWc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU1zBItHic8HshKX9mnBPZqzsMHs4IzRCJuvEm5H00U=;
 b=TIWW2yzZta7jasHX84AT77qpWENEN3pntuxQky70bcElCK3R7bXjxHr6lpUz0ahzu0uS70g1A5xFz5T5SFTpiEwaBKmMFiPWP94VnGlcAZEZO8pg5IDXijkJXOqvueafGlx2rN6xrclpgLg9Xcn0as7cRt1vV/HCgZ0xOdB0+GNHzodZqoXQfl1YsytxR59MfSV0GcaXNib58LQ6uhE5pCPzgNCJis5IskunaDGNV/h51xAL24kNGi11Y1dqsGcnJkPcRlRWOZHWkRHgxH4ooAlgjPkvCdHeAcorSG/JC2p8hEIRA4Z+KE23HZnyXUFq6m8n+NpivH34p0q1OsdV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU1zBItHic8HshKX9mnBPZqzsMHs4IzRCJuvEm5H00U=;
 b=ly937R9DmE/DdLaNbKqqko+Z1BEKYHHZOIwS7K5KdfrXh3VJ6nMtPdCsUYDb+RyPmbsRVhnr0H8Nfub/LGxZQhI0gGzq8u2QDWXUXCuboyfrSHTeMnXy291jpHiVpMzVLzMvlJ4XYpwLNTFPAlufvWfo9xpAIG5RnxLkhimxI2Y=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 20:08:30 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::92) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 29 May 2025 20:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/28] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:45 -0400
Message-ID: <20250529200758.6326-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: ce478258-15d6-4d4f-32dd-08dd9eec9418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMHZLGvtXYn3OHul2h+vVS8QvYBLjEWWiKxL8X2oJq/5OGmFoAx+mmrNWF+J?=
 =?us-ascii?Q?BlQUVAOKxdLQpyVGmWXDHCKQgKcWlxICOLMH9QUWW1hsfmblE/unq++Zc8BD?=
 =?us-ascii?Q?dWe0RaBEEvQlQw5o5cX2HOnq2LU66FI5wkea6jPOOtuQJHixRaXGcTTN2oDZ?=
 =?us-ascii?Q?5B1tZ+v/8kQMxxfvHhErmfYF/v13L6BZOq3F2BVODNgie+0mJbo/bmVvS12e?=
 =?us-ascii?Q?rmLP86dkrYPE3TZCIx4ye0dafByRh8Pd3edt0qokqoIms+wL5SzQDSA3ohlQ?=
 =?us-ascii?Q?5uie6+dJ/5JCWPNwtMr0zj81hxhsf9QZRVOI0YIeqMhIfwxzIc2bcjwE4zuS?=
 =?us-ascii?Q?lJylASvkVpV0LfAg0xMpTRM3NRwlAXBbPbEYTyOk1OIbp1qUkfsNujTxLkkS?=
 =?us-ascii?Q?C4mP2DUWAgA7468VSZQbwJ3vx5+3Kw8wcFH1rV0VIM8mdYRS12bu9G7LDA72?=
 =?us-ascii?Q?GKZWwHKtM6+WUH2Otss8rjetLYrJZ0ruDY03kE2TDHRO8ZhCYd2MjTN++gBm?=
 =?us-ascii?Q?/aE8kqHfAM2T2KGBPmqFCM54/Sw/FocoZSpmisxB9Ced7gmTkJHw10JHcVk9?=
 =?us-ascii?Q?7GQjsbmWQQAZQ7l3LRoPerW2TgFRKCSXa9EO3q83EUqI3x2hHl9P5z4fS6tf?=
 =?us-ascii?Q?Tgnx/DJekn3hFkqN8haZeJsfvz5wqd9hCZAITNfpGTb2vpT6IW5EORbHiM+e?=
 =?us-ascii?Q?vk9JDanA0U1BMQ0kpcBhzSBbN6El/M8enGn03Yzs94wRl6w79s4fiavo/hhH?=
 =?us-ascii?Q?cMy4QQeAts83Zvpx0PrczYdZ9F+pr48HfAYoBP/oWgfXqJ3uo+s3OkZJlD+W?=
 =?us-ascii?Q?ga5t9bzG5bHQeIGBM1ULg8hwJ4Imfy3CVoG8M5SF37hnSjgIs6S6wZet/UHG?=
 =?us-ascii?Q?9sAqW+WNwH34SuhBn5UIIB9DjB6zFWfET3zruS7P11dfQc6tdadB3dGsoqkU?=
 =?us-ascii?Q?VBtHrKVlQENoqZn48RHKi5gS9PIZdQ/sCuAXgyihCGQneyYb8NsVI4Peh4jA?=
 =?us-ascii?Q?KEIt3jhdUsRjkQUo237fdcmFWMSBzri/FAv4yCqDtKk2FSkWwjK0DdKggpFd?=
 =?us-ascii?Q?r2g1jJNn3hA4cdneL7FLNTmNJrvgwEs2oiUbB/Al8gVkGB8Uyosnj0Y6EW1W?=
 =?us-ascii?Q?Ec3IyCgf/6QQtnrv7aswOBltuzNU6eBbgtI5oVDmjrLuIZrK/kR1lcTXrsot?=
 =?us-ascii?Q?t3B9TeeQCIaKMDfLsMgv/r2gfUZGpUASueF5XRHH+zxC9Qh2Y3kC+A2NpdCw?=
 =?us-ascii?Q?9BmCatVIklc61ty0LGFVuRdifWJWcuHt9OEK1/16BL6+niEWxKWTgOH7ydew?=
 =?us-ascii?Q?LdVPywHgaOKxceScdNBQHLYGHoi88pscfe/i4tIJeDJnoZLx1tZe7CyBxS2A?=
 =?us-ascii?Q?eIG+kF2oV1hh3hjSA3mqn3TaPx6WLp5/jfazR9KHNtADDZnLf86Nhxp2AXcV?=
 =?us-ascii?Q?Ssf6Qlj+3qK5amlP99WMmmprrowlUEZ6iqwtQQHXdMEiGDjVQVZirNsJVTt7?=
 =?us-ascii?Q?37VRRSAOYa9NJXsfwnNZnGOGOjY/4lAX5zWD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:28.9295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce478258-15d6-4d4f-32dd-08dd9eec9418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 86ef0e30a89e8..09c4e3b228632 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1559,8 +1559,11 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	amdgpu_fence_driver_force_completion(ring);
-	return sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.49.0

