Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E31E6BF31
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293B710EA34;
	Fri, 30 Jan 2026 17:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PsBEp5UU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3515510EA35
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHzC/M4V0oOKmemP3Jh+/A3xtuAmdk55PLhnfKFZ+/r+F5oe11WFOaGSiyA/Cx9r75/Flk6LJH2rHSQfrTtgGNfjY8Tx4e9xEKcupaLlXik942jZY0X8TTdoX7su6Wow/SK+pipydNycqHuopO8WE7jPredqRwK1L05WCrxLAe+w3ozamb9/FbAl6gdp+g9adA88chV3uib2OwvZHo2pbU+e5NXxI3Julmu4BoXFtCcuJ+ORH9Td6ORWazV1yJxhfGClyoPuu9ntwzWF8xA9iLJbJjRFuLJ08CUp13A2EY2HKadqf053W0XJTh1NtOp7HhD+xC9iv6BZSprCrIV5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBe+wMDUp28uodQObXujyqPUZdiHmYctDIriYl7IFoQ=;
 b=cT2eoue6OAUq+Y3i6Ebsxq91CXECezFquJXLk0WtfOjsK7eqpFpws/q8r0ipfld11LhAhSELrWicY1mZTXQ4OQL4DLi96qg0koljPQ6dIZ44+Em3zQQOIir8WBiDn5mP8W6zz4bYtD6VTEbzdHxqeCnL57PqLDL5gRZIP5XFDae5tecNZB4mzSoOXbOp3lHqvvT578KeEjXcwBDzjEw6GVv1QTcUjsjWD22hYU/vkQupSHAvzbLH/AZQzBYpy26wNZQJAexDrLEezXFEhH5wGNP4vj7Bap/H93IppmvNGcyjcI93kfgvTVXSF1SRxE8HfxPh4d51KTd0rUA7l2j/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBe+wMDUp28uodQObXujyqPUZdiHmYctDIriYl7IFoQ=;
 b=PsBEp5UUW52tc6irZNVucsald4tNZlwGXORrv9y8NjW38YPbTfjXXMsJuz6boIJiNiXWtVSOG3/iNWDwaXRou/6IWsSGYUFvplBQ5OVL2VO4Rrkj6YY0ork+pllA28gvAiaaTF7KDDm5Sam6lHqJNAHcm447Y4BVg8/5Mb5NEb4=
Received: from BYAPR08CA0011.namprd08.prod.outlook.com (2603:10b6:a03:100::24)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 17:31:15 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::4) by BYAPR08CA0011.outlook.office365.com
 (2603:10b6:a03:100::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 17:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:31:01 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:31:01 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:31:01 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/12] drm/amdgpu: add a helper to calculate ring distance
Date: Fri, 30 Jan 2026 12:30:41 -0500
Message-ID: <20260130173042.15008-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 040cdf57-521b-4aeb-7995-08de60255d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KH7w6ge4MlvzlCRf1hzsw14clfeA2jMzay7sxHcKCjkr2djflY64iMqjARto?=
 =?us-ascii?Q?RoOJ61OOX3NHvwzsSRKy0Kr4iy1LHYX7bq0hkqfURHB8ZQ6sqJe3do4Ml12O?=
 =?us-ascii?Q?FEhBJgymGxM0G5/iknRZ0K8r4hMc0zhJZXRq8rV5Ef3ugKDN82GeZOnBxv6w?=
 =?us-ascii?Q?EcUqUvzu5+Tg8KuthAXa2ZfElIc7XKNDE4YPXBPuGYWxWA/aByLNIXWc7+TT?=
 =?us-ascii?Q?ZGOEmW6BF8YBMoPwY20Fgl0CukSnIrR8os2ar2hVSXRxveJnoRjvr8kHmCI2?=
 =?us-ascii?Q?EecjOu3gOxOvvPLomAplokLoQNrb/iv4/dyk+ME+0xs7Nof4fVZLz53c/M8S?=
 =?us-ascii?Q?uxGdAKDNf1RsJXM2Y4GSNl3GDj/JnAzZmVvkm1PH383UYr+QsHBUdQCJP/kN?=
 =?us-ascii?Q?kaFp027xutJcHKBfS3XuHmRng8zeUDSSQi6bbdOTzVZkMROuOD14kW00hMkR?=
 =?us-ascii?Q?amG/daMA+kva9390jDLNbfMOgsczclXxGLjizkddH/RkmyuPq3lwi+eh7yFy?=
 =?us-ascii?Q?9vKnySdAKBkheqwoLvMAgkL7SGoAOxhRSU+woCWw55dBeHvokUtQN5a+0Ddr?=
 =?us-ascii?Q?NznYWgUW3Ktng43ZZLJ0AdS/GdyZi7PcaeQ2cCND03T2T+nRB3xeeL2wJi7+?=
 =?us-ascii?Q?6njesleMSlCx8ubyFByiIsik07msJBmYJfXCFjZ4/GOpNPctPyYoLHC148xH?=
 =?us-ascii?Q?DFZgt0jGxXuTkJ57ye7B/zfxSl7/DLcjTQm8C+hjr23NxnLg9C3IP54X3aWq?=
 =?us-ascii?Q?s8EALbDbAaKIlJrBV6S94gTfA8KMXOtooHMODo7Mn044WsV9vGZkg67cqcbx?=
 =?us-ascii?Q?S4Q5fCRONtZyJuMJaNHJUUuLxsynhBacKhdjfSutY3Cc1Rl8QJeE8om2AnB1?=
 =?us-ascii?Q?rllSrqvDkEV0pZA97h6UbbG+HUTOiU+zL3foyOjOzx1OUFxZuovqjC8Trt/a?=
 =?us-ascii?Q?lo+P0tLZAq3UiYRP6vJm04cpB7GOJ3iwcj9qw8IlR3uWW8O6VGtmWvsUS+0I?=
 =?us-ascii?Q?gkh6Ih0DJjHBiULqKNvL7BXAw5i39vkF5rs1ubGjyFXjkUcRe4oYDWbFI5FE?=
 =?us-ascii?Q?Ia6ef3sEs8QGdY9oELMEH36yt2b1X1bssuhsXaZTNx4qXxmve/LHIVj7LXy3?=
 =?us-ascii?Q?wiGlrrjyPzkEkS0e2t1Vd6OrP5r9zAMlfJVP0YcksotP6BncTD+BjSCr7Wzg?=
 =?us-ascii?Q?sxaJqzA2VpVZ4FdMxhyMWDSM91BCLqfCKc4pF+VYFu0Cl8uBvlKMUOb9oxEf?=
 =?us-ascii?Q?/fhzyW/K4lLHPFeKlT32NaUgDDoCBIT/uPTtafCp0WEreH/HNoynhU8CMsXb?=
 =?us-ascii?Q?MEPHarMK1xLiK9dPasZENb07x8RLqAC13XXzX1+PYgrv0tiU2mzHxgfOh795?=
 =?us-ascii?Q?BwzuAiltcVJrUqjHDC10ZN0d3AIEw5d5wNMvOEvyyyvGahK59fch7itgB1Te?=
 =?us-ascii?Q?QID6rKmsvSqdDWaeZd/BLX4Hy9wV5TmFGVa9+kCwReq2kGEVrRAl5GvoJGTP?=
 =?us-ascii?Q?MaE6w6Ss+nRgMO//PMshDq3DTbUwWNaDZxoVquGpcC+fdKTKiWQuv6m2Xo5j?=
 =?us-ascii?Q?1k5c7PV6VQ/vH64eGOUQPLXniENjIfkbNDcdsdKRFxPDjDsOcaO+0NP9YNj2?=
 =?us-ascii?Q?WqpaR6w5gwV44XDNXBB/yvWJxNoUmHemWzuvmCyQigc0VizoN0WhrDqq3SeQ?=
 =?us-ascii?Q?4q7dZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y5bqEhOadsVGmOP7d66iisYnJzTLnc6gWkq2vFBvORzRZJopi96ztfxJVlSsJauUU+dIoI/Guqy45wT70YUQRHPXyjOIAveXKG5mnFVPm592bPwuLXhDxec9mQ3MaY0VXVaAesH2qQF9p/io1JH5uikpj3h5YUTuPiWsOluVaDW5ohurtK86JC8jLH3uHddc6zI96DcBrde8KMFmq3nUJQorfl0c9MVPMKCJpGbsihE9rkhb+Df0Ll9jpilAON5eOZVV+pyLwssYzO41PxkumH4G3Y82bjKbx/Zc74Ozkzwo59X3L2HYZoN9AAMvB3pMtYHXhNJPVW6zr0ut7Ev6K/DwJJ44HOubBwnxGHJYWFiicrmvW2AiGW1bMAz+lPZ6mccawohOx3J+f5eLvCcNB7fYwfot00o2v+ZlFlN8RF3AkYk0P4vLeCQrA93vsAUb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:12.6298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040cdf57-521b-4aeb-7995-08de60255d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

