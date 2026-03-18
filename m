Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85FD103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AD910E83F;
	Wed, 18 Mar 2026 14:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1sEPRmcq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34DF10E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0wqASgDC0t/KOJmVDXViMzmOlL0ej7pRWgXq9Dx2z0DCzm/jc6Q+yC37jsU5V7AnQPjDbfDBoe89XaWFh7M24w352TuLHaYKW0ocLbekA9yhHy760ytubSeV+JqChnohGG6xkV7FjPlMei7GPg+GKTl9kZe99TTxjuAgLXpQdijG2pXh4GmdtDafLY32jM6rdS/xvSauI2OYAeW+zsF8Mi3YRPMqWAzNizT/wDE5P4jNz8ci57p2Y/mxKYo5wCig5aCqcvGLVuGiSHJ0mtROM44FUJZnfRnkcT61kGLSNAmdBecY+/ss/HteSjVJix9diyrO9iJNRzcYUIzIzw1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx8u4sd+06ap8KLB+7B4NWSipi87tiwJo4i0uigvp8c=;
 b=GkZ6orNlP/K6inh0pYLbDAfLMRcTkjIFHeEnEw2qCklzmNhPu/zSL88pEWatzPgcPlbrOFiju8wZL1hqmSs7fren6jzWGR5sR6tPRI4348hCg4YTwgcsnblSwtYiK4nB26TGCOQNYqCoc5qZXB3rFjGqjtAw+DEdmeSOlHFouJMK4YRpsWlaTjM9T395ud7LKv7YyWzHkEN/zrfEMRbRXpYmRxSFx/WuPZbJFt851ussl5fgSwNp1NzQm7YCkQ+ywEE1sJInCfSHRZUoEsQ/Fo7DO1tt2HQgAl0yEb45CSTJKkpZHdwWlYFg/mqT+npX7xiPQ34ktobOzxWc8px+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx8u4sd+06ap8KLB+7B4NWSipi87tiwJo4i0uigvp8c=;
 b=1sEPRmcq7bz2QJtI0i4vUV7qY7Ffv0Nv6yOVEA6ibYGGHYZI2PlHUAOmh0uXvHgtXwI669x61Sgbuq7p1sVKFtqBMg8gzN03pkqyPiwpN0D8tP6KxfMFIX//3b7QzRZkAoSsnaZjPqVXUYX8lhJ1nu0yJvU777J20zocqmU10AA=
Received: from BYAPR07CA0051.namprd07.prod.outlook.com (2603:10b6:a03:60::28)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:11:48 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::e5) by BYAPR07CA0051.outlook.office365.com
 (2603:10b6:a03:60::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/sdma_5.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:27 -0400
Message-ID: <20260318141129.583333-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ad76f8-b3bf-411b-165f-08de84f849ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CzxawiNaMYVn1RMhOJqIpC3Vn/ofwkwf/E9iL+9ll4kphWG8uQdQaMFeP/OJPzmGNPI0E7yAtwyNMXPiaPPHF6rScpSYgF0gBxd0ffqXEzfOE0hu51c/S2+jgBcANJTIiFWNyHFMIEIb/u2gA6Ea5f95xFgqIlDuOI0r0uN7DcXbDk1up9/bmERUTZeLwSkKql+WGuKmzeSgqlZYOPKv5WndFO4joPlmgRP7s5Gi5cYWDSl+5CT2R1q13xY/T9g5hFK0+wkJK11BdKV9Q3YX7Aw3tyl8YkUo6GtRaLCJtvHoZeS4PkRtTHeBSimc5Ldaf6XWiFSio3h5Uwh7Hi2zxgowrxnYZlAvMAYoSdHJeWDUpLsfKwv0yK/sZoMMHqSItlSLNgGgnsgqGMs+9BFm9f2jOKXKeuz2dXZRzKUj/vkvpkihl5iSxs8xk7OYz0hO9xBz6AgBbWmjkgkBpBbM6fLzRnetEkP6xnkgNbYglKnfKNlkcE5yR0BInFLH3x7vTZKBmTCBUXTufEFU6DyyoL7pAgKLC8j5+S7yJprOnKW/Wsn7lr/rF/HE5JbfqUA6kgeTOxb3FHcLmIIPQV5v/mGVZJQUFA4Ab0QL6SHe31U8+KV1dSJ29qDc7WZ4WgTrW6mJ28quFXy+0+b0K3mrfcFqZYMlLDt9Uxiz30dvpfy/zr1rgkMJJb17giaV5Yh95dH4d/6dptOKoCszv28tWPQVtfpeE9Q9IYdqrISXP3iZRQruVmObZf3lzaUGOAQwy/VsWAvsEZfM41jQv1+Spg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TC5/MumcK0szcusghADKzW91Vh8Y0EkTbnlJe+FfGtFlT1wZhxRbq54MAX8m/G8nLIYgBtIJHA+OEjwg+3fZcVQiEWjuq9Q01Mu4+v8kRLJytud2NnLfX2I9cKvbHQcFaHszPETs5AJ3tSqQNAxkxfDSXyegvMXsBXxY2GcFRwKIe0J5g+WMnCjhu47GXnOUeLiiB2YqkEdjPTkgLMqAacsSPw5DvdEXHUt0aOUsc5+EP2ngHxd3C2qGzn4MHImvUcYCF5HfecDxoHT84VhWs45l5zkk6YzXRiqVAJCwdCewGUsgZsHpj9VO4sP+0EqI5V8JODRZu5Uuws1XZ7c98LqECJse9bCq0qfP1FDLO9BQ6XI/LudV3eFKOKFiAzxO630EkNt05oo/D5gecUmB0cOHWEormHDrHAemCPjTrKnAoU88Xz9C2gznA/6aAWln
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:45.8622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ad76f8-b3bf-411b-165f-08de84f849ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 52f4e9e099cbf..a1283553f0a33 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -698,7 +698,7 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	ring = &adev->sdma.instance[i].ring;
 
 	if (!amdgpu_sriov_vf(adev))
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 10);
 
 	/* Set ring buffer size in dwords */
 	rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

