Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C30AC54F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C65810E72D;
	Thu, 22 May 2025 21:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mCR+aCJ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4EE10E71B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSiIM73WPL3cI2dYiF2OUDTE2odARGjmLXC/DTv+3rOY21ZPhZMReRMffiPjeQeh9mNE80FYFwobHxYBM/RQ8c8MaWPqxbOiGgIludYwthUnTVbgBD7PGsdPnZjsYPk49yD0u8gDEkx0Vj7JpF9Rn/4FBzjUNKvHXWH8r5tBqyFD/t1jdNNFsqvUq30Q59YkbvCZmzKkTaA32tC7WXQo0In8ThZG3XIS6SqHLMlwM/xEFe84Issk/Y6+JLzbC6/Bayz86sPJDqgZIvpunP0Z/fh6u0y3PIsLDfGyedyL1w9uOTtroKCwnD5T73i+xBcbgUMKSkTyOyfY9YRjDFFS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHpnCAKPZJ4C+tSz+xPDFDWcLBWT5WLDl78wh2eWgmA=;
 b=RwbhCwGVweNofKwN+t2CEUe8RlGWq2OvURy7Pmoll4iHIsz9sW0imU+9p39v9RGFCyw+5F/yqWh8qn+idzFQpzWGTMe38VZOEcdQqaa5Byk8sTDj7nOW9fnWGpLRBJ50oPYjbU5ikrCtfUDQeTNdWRlQbY9Sh3VUc55m7/Y6tUzNmmJ+aR3sSjFgmpPChy1R4EK5p5oqLVeHJ+qG5CH5s1wfTnpNbrP6vPCwpkwXFiOYwLMdtFR9dab92mUL1o3xUb5AIoFWfVO/maNNTaaGZ+XYlWEdplQlbFJvpdSypcvtBxOlKkvLRp8FTAL901dFGQe0bUG2Mc92eKawbL38+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHpnCAKPZJ4C+tSz+xPDFDWcLBWT5WLDl78wh2eWgmA=;
 b=4mCR+aCJBup21Ru/YqmWV256uidXhdbdH/UVPeuQKaTsbc1DV/cqkcfR1KuWesnAFaOICFYbPgDdez+hOuV31s6Yiyvw6ZdP4HJcHc4iojivP3nsCOxDdevnpfgOjTHE2IAqHtky2QnDmhyeWTJMncSV7gn/ANkfg4Q6WY9qtwI=
Received: from MN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:208:530::34)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:56:18 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::f4) by MN0PR02CA0019.outlook.office365.com
 (2603:10b6:208:530::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/10] drm/amdgpu/gfx12: adjust ring reset sequences
Date: Thu, 22 May 2025 17:55:56 -0400
Message-ID: <20250522215559.14677-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: a118402b-9749-427d-840d-08dd997b7b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GcNeQdP4HKU2J5muLwiKJE2FDJ5XQ7Bpg6osr1ZmpvYVDopoOF7bRbbmtKar?=
 =?us-ascii?Q?iHfbUNufzA+iLbDleJaIDLCYkDpu4aOjz4m5R3Ye1Aln69/TeQh58O4cGwlC?=
 =?us-ascii?Q?bY9tW2X3Ni+53o/JrhzOQEURZgSo7f9ceYxDMdAS8WFknr7lZxp/XXMCZKpx?=
 =?us-ascii?Q?xJxyHZUInoiz0O1eYmBQRo3Fc/CdpL4Ua4iNSGg6Y9OsOHwiDwJZQqzgLk7I?=
 =?us-ascii?Q?ZS/uthl+ClKisQJaV7/0pwNCX53SahH+oROiWpxeIgAhcEV0vHg8Lrbr6j4M?=
 =?us-ascii?Q?H3r0Ht0LagGQT9e9YSqH6gX9iL41ySsTGUgnB8/h+kri+P+y/0WORIUrQ87b?=
 =?us-ascii?Q?Pw0GGM/+/wEEq91zpKy4bPZcvWFcO7DYDkOb18wONibfx+2wiJAFmUyus+Sk?=
 =?us-ascii?Q?Q5cznjrbPsOOIUHd5GTZlwvmipmfukvEqA1uDaKW7I+JN0Enkr3Ifd5SOV1o?=
 =?us-ascii?Q?KGVDlg7F2BzIPjJb57j8h+EwRaGay52b8FwJxAyx3nzqAowhMsB6WJDdOpCp?=
 =?us-ascii?Q?rOTop0RGmfsfHjVfuDYEkBMO3dkTo6aA5EVhOQsZH4xKUdrfVG6FeYG8h+Rp?=
 =?us-ascii?Q?L5RYLxQbiOBc4xIhxFFZqFHlhRbHfhs/u2gMeSqg6Gwfo+0iNygoiZZkX+qY?=
 =?us-ascii?Q?5w6UzimeCIGnuXhzki6gE0liFLgAI3FvlMd4CyG3SWS/vlWWZql33T29VuNx?=
 =?us-ascii?Q?/ZnnzD4wQfFtSCoSugSYK4ghLIFTVcth0I1CStLtGkb3KlAYKnAeC4FbWy9n?=
 =?us-ascii?Q?o0ExqkK0DsxoKrVggJxKpfKqdWch8QxCo1skWTxQliz/HDdBwy2hCwLH4kek?=
 =?us-ascii?Q?qu0RwxR2e2p+74SKx/4y5lEdw/69gwWrTlbSBl5/idztp8lWxpUyZ0xprVfK?=
 =?us-ascii?Q?FAZylxIoBktr3/3Hy/Rjei222Dg4hnBxYHsN818akyHj8CV//kSvVtWD7wEl?=
 =?us-ascii?Q?5k+SHJfXvausVEygb7iu+HYv8cYd0tP6lb8ydAO1ScMOxDa4RaB+L+vvKnmU?=
 =?us-ascii?Q?FDNsA+rhzTbvocHSZ0H6xOpz9twI5kIyueMqUWyhmbbFUHijNl0Pw+TTMK2G?=
 =?us-ascii?Q?7jBHeRBc+Pe5XUOf9bdjeGW6pAetn8odzdnQ9EgvQsglru5CaLYKIJFnVKxM?=
 =?us-ascii?Q?W9i8cdmFrRhXuvQbmzTfSnk5Q4aSoB21JVVZzC1s/WekIxOV2m/kMiy0JnK/?=
 =?us-ascii?Q?0wY5VGrnrVsIw8fAeR0THp+3AkiJunAzKFw3RVZVlHKJyDTDkLvzoPkeduxp?=
 =?us-ascii?Q?wh5KHHnFQibC9HVUsTdSW8hWKpcWi8WPlDr/8Xwlggs8EjtRYgbiGqyWv60w?=
 =?us-ascii?Q?loVHvT0sR8J/6iD1WULVL8COUZ/RFaQGwk8R8ycTfFHvXNqW7DIACcSikABv?=
 =?us-ascii?Q?s5dkKJRtYvOnaJSDG9z/NrNU/jtim+L/0s4y1H0KyOtOYeJaUh4wWE7i3KSl?=
 =?us-ascii?Q?VHGg6aS/0eX9nvAZ2YPgIMPdiQHmsHDAMp2F0N3fFtMHiErEcNJNQWqYfOZ/?=
 =?us-ascii?Q?x+VOXWkTe2LssU8ui4pNlUeK7g/KWsDwi+Cv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:18.3591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a118402b-9749-427d-840d-08dd997b7b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

Don't clear the ring contents after we issue
a VM reset just write the trailing fence.  GFX
block will reset the work associated with the
vmid and and then continue from where it left off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16d..c52669fb987b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4448,6 +4448,7 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -4455,7 +4456,8 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5) |
+				 (exec ? PACKET3_RELEASE_MEM_EXECUTE_GFX11 : 0)));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
 				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
 
@@ -5323,19 +5325,19 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 			return r;
 	}
 
-	r = gfx_v12_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
-
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
 	if (r) {
 		dev_err(adev->dev, "failed to remap kgq\n");
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v12_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
-- 
2.49.0

