Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D10C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 05:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4125A10E350;
	Wed, 11 Jun 2025 05:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ie8ytXVK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E648410E347
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 05:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOWhuIH8y2NNS5DavQ8AvcMkYL6XHZHkM2m7gRSiq7UxGuHE/80GBnJL5jdr+OmCQXy3u0Pxbwgif6R5J5S+sI1nKkeLumY4PYjCuXDQ+KDkqhBlCkOlPjJbhv/zbnfvHyKDHQ+U0xEq/suzT+iVgrnmZhNGhwH+sI5qKps2hQwPTiIQ/m3oBwexJCH50bMMvBtm8jPyKlZ07twB2aD/AJzW5eIWRjVuCpGTuoJWSMc/rQTge8d3buWmEgK6p1gmgp+IbghKWPNoN/+At8gmXcH+9s2BStnUgA+pCnvwnX0I5Vtw7FgFXhWEnbi/WuqOdgpwZuPcpJ3rw1q1RZdWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzxKWYwK9xD8qiJNN6kRbEHWv3T6V1iFtbTx2aoGeWk=;
 b=IXCEGecIFsNxtL0gVeQBu2tEiMOFPWnzE8ISxAOnMI9DegmwfynqBaUNggIAy/HeATnJ0yfvvq+QKcry/HxwAb0DNVAGl+3YekiIXQlEeGcfgK4E8kex9vMcsi8FRZ3nJuZyiDdmFnjxAZNlvRGopVve0bULhIHzeJRrtorqpjK1gtMRpoOAocCz4DuFFBlMjnzfD5G9WdJ+V/udcsgtyvjL0jZFOuCZ5N2k1xWj0cbv2NLcRwowbjUunkj8UEvMiQ6SGyfRUbbrcCcy3Co2g9RM1bbl6rIadhvjkfuzL+omjYdshHUqDbIvl7S3DYk3RpgrcRti7rE7jfkqqsh+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzxKWYwK9xD8qiJNN6kRbEHWv3T6V1iFtbTx2aoGeWk=;
 b=ie8ytXVKfoWtQHzUGV+faE20pQKQ60J4yNV2m7o2J4lpFN7Im0vhofvFhWqxABue/l/+E54KeH1wDzc+oar9h4EnKel6+8q21FgxF/ezUybMNNrJr40+DVlKe3WPRCYgM/SaikNgEICQb3sjiHxjAxd/Ok+Zh7OkirqFcwPoIMY=
Received: from DM6PR02CA0125.namprd02.prod.outlook.com (2603:10b6:5:1b4::27)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 05:56:21 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::1c) by DM6PR02CA0125.outlook.office365.com
 (2603:10b6:5:1b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 05:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 05:56:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 00:56:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 00:56:19 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 00:56:12 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix SDMA queue reset array out-of-bounds
 access
Date: Wed, 11 Jun 2025 13:56:04 +0800
Message-ID: <20250611055604.3303818-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611055604.3303818-1-jesse.zhang@amd.com>
References: <20250611055604.3303818-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd9a365-e0b5-45ff-da90-08dda8acb062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gPScBC2/nqc3pNxLivYN0F8fY0bti/Hbk44HnQfgDvvqe4kbaAZ+wNElGex/?=
 =?us-ascii?Q?KOS5SVCVjEcyViyL3G5w1NGvecjfqzl5yYSbwEcyozk+8vmnQYNGtEmzja76?=
 =?us-ascii?Q?ZeQmu3akWmUEWt9oGCk51T+vu6iDk63jP4H7pworMpFzVPRYJLjUo+sccfdQ?=
 =?us-ascii?Q?3OwLeKJlUXM4liUJxdmblru1sks49wiprlH9Nj3b8BH3+YJhyRxiwOIp7OUm?=
 =?us-ascii?Q?KXJx38aAri9Z3eDSSwFfT4vwGaeIacYyWP+StoxHiWcQcxr9JljkQo5nSRZL?=
 =?us-ascii?Q?0PCz62tPoLrKqrlv5rTKEIn5T3yH7xdQHPYSXKcSDEAI06CjPTmakkijz4Ze?=
 =?us-ascii?Q?EFraDrfo9r0wb/rZscAsR2B3DEjrPiHaWL08VWRMIxlsTyQpAFAtOvB1wqAO?=
 =?us-ascii?Q?EO5AkHa0QA+hZO9OsPB3BEQfqp7uz+XeWKuuJxy40gaoSHTV5cIQf0+Fx1EZ?=
 =?us-ascii?Q?5F0f6roB9cx9xNBKg4644jRmiKZUkTafPxR9tPrsc2l++P0BePgTYel+tuyC?=
 =?us-ascii?Q?HD2KIa/vb5UVZHMdjtiMTzb8vy65bgz1tR8j8bxsBH+iZZDrnVJXwHBmqW1R?=
 =?us-ascii?Q?dG3pkEEEolX0paIWy4/Xp6vZuScfrebP6xFqTorTCYDxGV630tQfkKGlSsWC?=
 =?us-ascii?Q?u651CBcS5kUqmwBokExR37ThUmCnRUPJp4suoQz0WZgtdzSNzTjPJlIGWQJF?=
 =?us-ascii?Q?aIkpHhAfpxgFCZJc6D9VWTYuQy4vt8UPF5c4p9QmW6RvXRQi8JC86cHupolP?=
 =?us-ascii?Q?z+hH9LwQByCGyNW4rfurFRj9QZ2K25IL9o9f044Kn09tYd/kv4Ri6QxZA0DH?=
 =?us-ascii?Q?zxMc4T81XXFKL5KQG06fX4xzrH3Po10V7GNxmeM85RwgWTmLHOEcry7g2XKb?=
 =?us-ascii?Q?1JBJvQ81KeFMQZB5pKsqGlXUVT77p/TSRSchspehO0wkg+nIN0hLTLBF0n3w?=
 =?us-ascii?Q?G1z/rCGuvUlC6sLhQq5LMfGwTb5mvex9HuNw3bp7SDiQa+s3dLXAFPzVaOkr?=
 =?us-ascii?Q?IU9RHWnexG8XzCTc51RlemChvGKrHsotB0qEuolhVnDyq5d9zs6LQf4iGbTl?=
 =?us-ascii?Q?ivCBlxXneCZhpEogHphCotL42ENyl3UxSFfQqAccqFviI+RI0BgrqLdJxO/W?=
 =?us-ascii?Q?LDPGOeNgq+BUrAqV7mZCWqo9vOxKuyRDRxQ2D2IZcThM301g5Jsp5FXYhjlo?=
 =?us-ascii?Q?MiQQHT9s54S/6SQKW76ss4wfxDPf+LeL5UcUjRdBw28o7NFkv9o/m8cMNN9I?=
 =?us-ascii?Q?Jk9Zmo/foaIww9AJ/eNkEPUL91DK8N4leiP+gR/pPUV+EFWYaGSrGg/wH1/b?=
 =?us-ascii?Q?riE8fU87i34XgXz427XznW4Lj+NdnsCWny4RrnYVI4uGT/tVIWRV6iTU4xj0?=
 =?us-ascii?Q?JZm3uBLaQrk2WVzJQXjh9LMi+neLYwjCcEJx+eNlnbaUmh6SCTnXwCepXVfv?=
 =?us-ascii?Q?xYGaskCxt6Gr9RmGUK9eg0YAGFpgjboWxw2J52ENkxHAcGjPcTaH5r8ftJxr?=
 =?us-ascii?Q?a5fam19xFiDu8dYsHLsX0kqYWwLCnmXKdFvw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 05:56:20.2796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd9a365-e0b5-45ff-da90-08dda8acb062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

The current SDMA v4.4.2 queue reset logic incorrectly uses GET_INST
macro for queue operations, leading to array index out-of-bounds
errors when harvesting is enabled. This manifests as UBSAN warnings
when stopping queues during reset operations.

[  306.871518] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:118:38
[  306.871538] index 4294967295 is out of range for type 'uint32_t *[44]'
[  306.871929]  amdgpu_sdma_reset_engine+0xe4/0x320 [amdgpu]
[  306.872115]  reset_queues_on_hws_hang+0x2dc/0x4d0 [amdgpu]

The fix ensures we use physical instance IDs consistently for queue
operations while maintaining harvest-aware mapping for register access.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..3de125062ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 id = GET_INST(SDMA0, ring->me);
+	u32 id = ring->me;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
@@ -1686,7 +1686,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = GET_INST(SDMA0, ring->me);
+	u32 instance_id = ring->me;
 	u32 inst_mask;
 	uint64_t rptr;
 
-- 
2.34.1

