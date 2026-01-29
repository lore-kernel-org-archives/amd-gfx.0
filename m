Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F0BD73E89
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017A310E8B2;
	Thu, 29 Jan 2026 20:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m0lxjpzS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D17F10E303
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f83Cy3y1JBuGNaHPwf9/yl84dIwggTZ7L8J+JozPju2kjTHa0ni9kMnedqcoiCmLba5YoA6VZJeuUfBI6aEKOiTBElMwM1PJWkqQ4gIyo2+b8Ww1TlfHsNypWBdczVgnTsHqogbpWlwF678gBe7hykdVDIG51QJQNmZZ+9+aBcZf83asJiFuJcJfNdvxDQgTscgn5MsUh5Kb4jJgwvN6fjOGl8kAInmuBLGkHWf7uOSxDh+gCq8VKE4YQ+knfp6EJZENv/VaCgSE5WneVD6PvemgaSzodbW9omTU2v4a6C0uahLL3MaYhj8YLqrjpUYLzCRzakT4bXERqw2q7M6csQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBe+wMDUp28uodQObXujyqPUZdiHmYctDIriYl7IFoQ=;
 b=XOioi+7N1TmnSz4fvIB7yDEi8bjzwtRFHZqWa3c9kxoWvB4X80eJP6XS51tcYJ4v0N1Ri89FQUDIYYWPHvxI/XapG8fTLCuc6tSUKMPFU2l5aEflfPdRn4gptOljTK8az7sII8v7udbOzE7WgvUWw01rePKwumQjVVSpMu9Mwl/VCrmO2GJZvBn26cnUtCI7AAbLPkCe85ZwVq5/bqGzGZwK/854gs5G5DjcA1to2TLnZJPEc4qKTWmPXjdxaN+olZpnf+Lp9fgFs8VTjq/nfrXR5Rn0bfGHNRammzlSdg8KDL8MJ/7XaWW2uno91uLxP/q8+Ko3L1A6DrFKzfRzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBe+wMDUp28uodQObXujyqPUZdiHmYctDIriYl7IFoQ=;
 b=m0lxjpzSG14HHBi91QAn/hT0ulG/qGoK85t2a7EG6Qfy3ffFUdexx4sdgGczyvzSqGXuQ/fOoYGtGG1ibl55DclqkEt9v5nVUWAplXDIiHvUsQDZL3DWD9m+O5dElP59OqOBpNVKmlqzEckrY+9NMG4AIsr/QS1ErwYbLke6O8Q=
Received: from SA1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::25)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 20:37:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::a1) by SA1P222CA0009.outlook.office365.com
 (2603:10b6:806:22c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 20:37:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:55 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/12] drm/amdgpu: add a helper to calculate ring distance
Date: Thu, 29 Jan 2026 15:37:30 -0500
Message-ID: <20260129203731.21506-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bd7114-0101-4d4d-52d3-08de5f7648db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kV3EjJYx+E86w/xFBXGPJLp1VNsYLWDTfU0w9Hef+GffdFcM5p4LHraY8Yol?=
 =?us-ascii?Q?t6OU8Fh1+YO+wzld2hNbzbcxd12mREH77gXoklgDScx/Wk4JVacZClDGXjtm?=
 =?us-ascii?Q?WvNvyJBPFvWwvXAbIx9LEE3ObEAF4PV2whxhwfKCtAKrgBkiL7J8vq6z0KiB?=
 =?us-ascii?Q?MXLvxxdlOaeZPgmF0s1kuRoSEZ8tMpssJz4gVuHGBIgldgjZyI2pghG8512p?=
 =?us-ascii?Q?YBZyP9aL3xCmQ8IfSQrTRosGpiR+VQYL0PzLF+GUqIk2yZKNZFdFUd8rn8a8?=
 =?us-ascii?Q?gAvvoBn0GM3kQg6i6gE7AgVAX7pKNcncOHspeULJ7ZeUoDVShnBg4WgIfmyR?=
 =?us-ascii?Q?NchDyEsrG4VKaPtwk55YVY3+zOHQtTtJX2neTPufSu7qK63FIear6LvNtMF2?=
 =?us-ascii?Q?DW8jzsip2kU5aj+hwVWDvpmydWp70xaxTP2B6LKeWRvTOuNvyXE3lZPsTJ/0?=
 =?us-ascii?Q?+SqAlHFC/7o5G2CURnsbJek8tXUDn6rVtnM8EgFBEmlMACsQn9WQuqk+c2TT?=
 =?us-ascii?Q?5KMxDyeY1p3vSilDlD9W4BGnvv0IBvyOfiUEgGEVPeRc7sjX9SBfPxMAuekw?=
 =?us-ascii?Q?CU4FNaGqSE57XIV+dm/BfFphSbCfGN/LRXQrm4gS/AN6hr7J0Qq8gd5d/EI5?=
 =?us-ascii?Q?f6I1gsmYs6QAvylAhrPxEwktyoCaqyEd0C4UBHcZHbSuNcMS4tTouYXvj2zd?=
 =?us-ascii?Q?kphDJIqNtPsiS/KCCnB0+rbuxiK28wovQGP/MenBgxjZ2pvbsLf0wYtNBY6k?=
 =?us-ascii?Q?jzrCA15jn568UV+92HoH1AdPxhcjsF5zjXlYK1X1CO+H3kJxTbcD/9gctb7R?=
 =?us-ascii?Q?Ud0xvDdUx4SQq1VdjJE89jHZVq+YBPNH5HwzvsCGdt7zsdUdlAl/VT1s/ZRM?=
 =?us-ascii?Q?Ab1UbavCVHKJ74x+0NbUlQWp5h0LtKh7PKzP1+NAm2IZrQHPROUbF3AMpC1o?=
 =?us-ascii?Q?KhHcblyEUXo33LXOpvbS4nG9zBDR6o8j3C9DhkrPA7yP6Yh8TRN+CKc7FDIU?=
 =?us-ascii?Q?7uWugXujj/KTDRscDobNBt5NE8stWPYMoTTPIZ8Qq6jYEWLTbonPZBbkbD8I?=
 =?us-ascii?Q?/EJ6UXcefhqAIsVsyX3KiZJx3/4NWoVlD9TLiia3NT1OLJGdDLBmCHav8FAj?=
 =?us-ascii?Q?LOiq+sq37s51hPrTfSnfcSBzSVSk/Ve+kRHZXb3RfQ4C+sX+vpc/NOcJpRjF?=
 =?us-ascii?Q?iQtszGv9QdZAPjl+XZX3ESulb0qyjgTDriROaNY8S7v3HWB9dtSlO4J27SqW?=
 =?us-ascii?Q?8l9Ucfi5o4lPQCYkoi01YkLF5sn4aowzRwuQraR8quyMXZePcoobGaPJB0M8?=
 =?us-ascii?Q?KNiKxqf9M3jkTmScxJTfT3kpiwA9sn0HoV9ma1bAh1hln/l5a8zRzOk1doDk?=
 =?us-ascii?Q?r950mx8eQSFIgwHprW+X8c8Yfwp/rE5YGXNP8EgWPl4eVnIzDG8LEbxuZHu/?=
 =?us-ascii?Q?UdSp9nf+MBq7GBmM4osnPBN5Epe2fezqU72UGyqFNJfFUXnQkFzMelIUfV9r?=
 =?us-ascii?Q?S8bJqX6cWgOEoM8Lh6Lo6ffIqtvFp2gmuneRj2gj/h7RgnjrBf10nQqyKQIW?=
 =?us-ascii?Q?79/5XI46tBg1znwP4k4l8eUUPHSDmqW/QO7oaeiszOz2woPsMx5glEimOv9R?=
 =?us-ascii?Q?a8uQd1CDOb9/6np3r72tY6Y6ATfMDJlWbDNueUd5m+jHoSY9nCqNpaF3FtsZ?=
 =?us-ascii?Q?Tovefg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y8h+EBbS+SZP3HPZNsWHW80gOqNzcuL0qBTbg+0eu3ixF/zYyiWKx7kzgWbX4hMAKydJlFKjknfCNxZAUGEVHgRapmVlvK40QZl9ZAxWbgcxBtYg78BVJ2XZtcXLwYzRkTZiJL+r5WE7UmAEuSP/yMn622wVejS8kfSMY1wapvJ6E3QLxdbPo8Ag2Iam1Dh+/XKm7Ccwuly6TP93HGILkXvT7gdf2f5VZrVv1s1K/C9MlyxCabw96ge4rJD7wp+kBw3TpulAFRG69PcSQDJqzDKoXya6LtlwoIqmJqY01G60OesWmmeTviiO0LLtYLSJYB9Sj7AAW0kYXIWxzfO1kzAUgkxis/SmGzvkdR0fxAqaNaeE+TmguXzTic4xEzEVJE8+F9VoXwPq1APFgJWdRtlhCml/kGe0GY5Jm3KpL/vhQadqr1Lxl6DQ9tQxJAoF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:56.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bd7114-0101-4d4d-52d3-08de5f7648db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

Add a helper to calculate the distance in DWs between
two wptrs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce095427611fb..e196ffbdd1f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -523,6 +523,17 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+static inline unsigned int amdgpu_ring_get_dw_distance(struct amdgpu_ring *ring,
+						       u64 start_wptr, u64 end_wptr)
+{
+	unsigned int start = start_wptr & ring->buf_mask;
+	unsigned int end = end_wptr & ring->buf_mask;
+
+	if (end < start)
+		end += ring->ring_size >> 2;
+	return end - start;
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
@@ -533,18 +544,13 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
 					       unsigned int offset)
 {
-	unsigned cur;
-
 	if (!ring->funcs->init_cond_exec)
 		return;
 
 	WARN_ON(offset > ring->buf_mask);
 	WARN_ON(ring->ring[offset] != 0);
 
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (cur < offset)
-		cur += ring->ring_size >> 2;
-	ring->ring[offset] = cur - offset;
+	ring->ring[offset] = amdgpu_ring_get_dw_distance(ring, offset, ring->wptr - 1);
 }
 
 int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
-- 
2.52.0

