Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380ACCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 19:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826FA10E6BD;
	Tue, 26 Aug 2025 19:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dgt2WiZp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6D510E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 19:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9XmIqlwVIIARvo4eBJlhPAdx8JdyjRALaoil5m3k6ii/NKoSQuGufh54RK2w820YLPT63QdGapxpC+QpivxVFFLvQaKm5KrZ3tNha8XmAQB0wwVvBlkk70Nm7MiuQavLOW/zpn+E34IrnBxdUY0yX06AUwNoeCszptlc0oW2LpBm14P+6Vg19OrF+/cqgAVGEWKfeU59c/ftgcFFgiv5PmJBfoKbOl4DCPNXza1WVh5vGuOvPqgfxBiwts6PErSPza4TMx3CS7kb3CY2aWEc9r9jSKi8G0cYnDCKGF7O0I342sONFnE1Nohv1bS91qnVEMzE/CYmjtq+91fNyp1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yp/FwiIUEbdRsnis3JFdRe607YhxQC4i81/pKiw5ZE=;
 b=o99dPAn9//Dw2JQg4Ax41aXrTrPc2DPUJdRKd0+JMz8I7hcwNorDhN40ja7OI4n3Wvw7M6CCiQ4ZuE5qhe6WHxqP/wlKXeSYPl2lw8zOsQ4gwkwztUfu6vz6RgMqE1jxOMNEb8LopH7RFKErmCi0MBhAmsNa2jHExnG6TJb3FBpMiPojrlvI34T3TgP8basbQrVlzqzID1BZibl2Gl4zsWAFNPby662J2WAySOWnflEYDMTZrzVFfsd/XuaxnJwho149EmU8RvYR2SFD+2C/kmZUj42b2wGFCUPzncZpCF2yKJWtc6dAG5JlC4uAZkpq+t3soVNJeUtx1o/8fzALmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yp/FwiIUEbdRsnis3JFdRe607YhxQC4i81/pKiw5ZE=;
 b=Dgt2WiZpu+dcDZoa56r64nPMWhKNnzqSq7bQJglMkz+Tjd1DGvVPldeumDfmUMrOFGzWYSyxPkmKSCPVd/X4JojOTVJDk2K7HkLR/u1ZVHwhW03V9tSYs4qD3/6W5WVu+n953TLwLItC0Dz+BF0tTqkLHFRYj1ZfOW70YBVGLW0=
Received: from BN9PR03CA0490.namprd03.prod.outlook.com (2603:10b6:408:130::15)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 19:38:38 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::80) by BN9PR03CA0490.outlook.office365.com
 (2603:10b6:408:130::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 19:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 19:38:36 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Aug 2025 14:38:35 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: protect potential NULL pointer dereferencing
Date: Tue, 26 Aug 2025 15:38:20 -0400
Message-ID: <20250826193821.869445-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826193821.869445-1-David.Wu3@amd.com>
References: <20250826193821.869445-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 612a55d5-81f7-44fb-94c0-08dde4d826a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CI0kYAg74eYpqbFqN5bxqM303E1OsuvHAM5MV1J+6wgB/x8KbydaIwYRKsrp?=
 =?us-ascii?Q?8VY+ipVRcyfHE6WqEnq/oVXTO3RrAqO/Z/wl+JvHHFCwfQGWZBAPOTnBl7GP?=
 =?us-ascii?Q?lke8I9NZKkIrtG7H3Cvw4HcjTcKvicGP7VwiyvWvksIJv64A6uFqeS+eGnwm?=
 =?us-ascii?Q?6gUO104SeAJY4xJkgP04CSN2/MnZTScfFoa60h6h93sL3juKt+0WH7HYTqhb?=
 =?us-ascii?Q?JO5Wfe9gLMhhuB2PwYTL9cHeFdpMZXhzdmmD4weGOyrieffYdRP3ogehSkqN?=
 =?us-ascii?Q?KJ3ONapMYx5ErqcvsRFVfbXeiBvU1P3shMniykrtV/XMLEwxG2i5c+I5cXOD?=
 =?us-ascii?Q?o0uo8l1Srw81VSJWDCi56frVoighG+vxS0qG5Q9sKBhjpCZG6WJ4dB1xTRC9?=
 =?us-ascii?Q?6+CBFxs0N2hERcEpKGRzhnvuAJ+bIU2Kq776bPfN/y1wbFr35BzcGZ48J4hv?=
 =?us-ascii?Q?HTLght0YrLGKi1fyFPp//DxKBTF9V/O24UvXUkUutqOkeFXZ/Z76CxjtYHIU?=
 =?us-ascii?Q?Rhk6LOkiR4g8XbgNgKZwN3v1nIicQPJBs9PeDKY0nX1o7oryXEd8LePdTe5t?=
 =?us-ascii?Q?qskdHezbO5iamJcqCbjeC/azsRPASxW27cY6Q9h5H85nsBZNI0R7olxDWzSA?=
 =?us-ascii?Q?mbyQXP8xQgmKK8FhPUe4bXhdX1dESwSOABqdS55BPfA67q13tau7XKHXWvTL?=
 =?us-ascii?Q?JueR9wFZkLGZZzXBmVEBVpIk+VKVrBnm4//uRsV7ep+xgvUjIZ4MyW1H5+ic?=
 =?us-ascii?Q?0n4zw1vpQpgeUaivZLJIc0fhXunUkfRJ5CNPryyHJov+W70tbrRzUTplVqNT?=
 =?us-ascii?Q?MQHbme2DSWKlMKgo8rsbK20jUc4ysDYb4zkKAJLI+9do4FhSeKLRqu39Muvw?=
 =?us-ascii?Q?xVnxpn4lk7L+LG8LbFmc8bv6J8Is5x/a5phBf2vjacNzX0ZxxraJLxep2WRK?=
 =?us-ascii?Q?96jsJSCARSbNT14VD3LsuzhgVqmBLBqNQXMd0S0ofvQYBF7/AiZb5ESNcJ5L?=
 =?us-ascii?Q?S7tfFOw5vGysAL+uizsbD9hpCQSAoWAmegYDZgdU9dlDn509005u/KZXWmse?=
 =?us-ascii?Q?1hNEHaEbw+9MOO77fH10PmVJTPFjJ2wLz4Ys1qQIyzBNppBXkR8VuRcano0x?=
 =?us-ascii?Q?HUnEEoXkxsHhcWFJntEp5Er/D7X+aBt1jBkcU+ICw8TflGrPakgIM0kr4Bjx?=
 =?us-ascii?Q?nkmPcqJDxsxksbeNe4rxyPe+V+HQXPp22AyfZEvIhAJcmC37aMgx3TWhoCX1?=
 =?us-ascii?Q?9/BTyOxyM07bqcaT7zWoPAfVX87MYvg8ru0ZynOVwRQhoH0jAeQWkmJ2s5fh?=
 =?us-ascii?Q?jU0kG9u4THFfqTqH0a+jqUnxsETkcAxBHscrw2fRNQtdEY9Ym852cnfOh+Y4?=
 =?us-ascii?Q?7NkgL2zvGACNP+m9Q3KdR+bAAhahCGpy7YUl6Mn/qIJhg61F9lWimMQZdnqL?=
 =?us-ascii?Q?uv3rLlhD3o/J8qQX/bfIuJCdPBCWKNatIgOhBcB5TN9+y5BSqv1TrwYcW7mc?=
 =?us-ascii?Q?88+xNe67FilSRc8XgeveusBpFqM3BP1hNZWq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:38:36.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612a55d5-81f7-44fb-94c0-08dde4d826a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555
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

to_amdgpu_userq_fence() could return NULL which should be
protected.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deeff..01d30544c30d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -297,15 +297,18 @@ static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
 
-	return fence->fence_drv->timeline_name;
+	return fence ? fence->fence_drv->timeline_name : "";
 }
 
 static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
 {
 	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
-	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	struct amdgpu_userq_fence_driver *fence_drv;
 	u64 rptr, wptr;
 
+	if (!fence)
+		return false;
+	fence_drv = fence->fence_drv;
 	rptr = amdgpu_userq_fence_read(fence_drv);
 	wptr = fence->base.seqno;
 
@@ -319,8 +322,11 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 {
 	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
 	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
-	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
+	struct amdgpu_userq_fence_driver *fence_drv;
 
+	if (!userq_fence)
+		return;
+	fence_drv = userq_fence->fence_drv;
 	/* Release the fence driver reference */
 	amdgpu_userq_fence_driver_put(fence_drv);
 
-- 
2.43.0

