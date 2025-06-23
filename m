Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08BFC7EE33
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA3D10E41B;
	Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0RaqO7Ma";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E6B8984C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTZFSAKmOsUZsdtWplgs32cIiW3Bl6aWqtCa8JFb9Cuxmw2CDbWGVC2wn9uhX2Z1Q42pe+gDF1im+ooUe6mCtj0kVMaC26ntfnyOhZaqQZE8JYkJlGvFo96cFiMVBIUPBFIGY8Ju4uSaMSmndxdDJa2BHPnFzIS48n7ci8a1lsoZn2fQO46QzJVn41LiFHPgSfjOHYc0dpWdFcFN5EXGsMszymPeDlGKP8/Na8/yxk3+9jFs4Sz8UJ5Kd8PpabR8sV2dGQVkdzi6aBePowHjiamNIGpMZeSHwlWJK2H2lw14WlhFlNFObSQ43OaSR+ZJvVwe16ZmrDrIVbDqm6Nyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU+IUMG0uB+87HaHkIv1qRZN+6CdSt86KuGFx5V10xQ=;
 b=DKJM2Ey+9p4/sb61AGnTLpPhGTHObFTwQaeHx3xngo/4er0NEq2bvHmH//tDwXuAlg/E+C4yh3pkakr1OejTRbicXkdArA7VnSaaljaL1C+Kk2ELh1uXRmJvThTouuVt5OAQNSzFfpTa7a7QcD6YszxC0mkEEnmDIrzfto5VkoLxkn+3HJX8sHHY96YmMiUZOxkyl40A8jJz42TOsDlx4jwitHnl/TB3qQs58fqiRc2KAnQb+sCNSLbVJKnp99BkMnBv5ccODrP00CN0lAUfPE6uz1j9w6NhtnGa76bgdv2CzUjY+4N/IYMTQ3XpnjkFAbSqS7OAkxUm9JAxueWlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU+IUMG0uB+87HaHkIv1qRZN+6CdSt86KuGFx5V10xQ=;
 b=0RaqO7MaLF2nsUJV383iD757nUCHvj4cY7Jg89IoBqxUe3k8dxFp5kjsJwyWs4SIaXCcm0zulsI9prOkaHBNZ7ZVs0hxY2Fee8vNnNw6MP5zt3TWuUydvfRMzksjol/zM7KyDVjfNcViTbGHHWPhBx/SnQ1u5Rq1iK6vlcpbD94=
Received: from BN9PR03CA0948.namprd03.prod.outlook.com (2603:10b6:408:108::23)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 23 Jun
 2025 16:15:08 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::ce) by BN9PR03CA0948.outlook.office365.com
 (2603:10b6:408:108::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 23 Jun 2025 16:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 17/31] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:23 -0400
Message-ID: <20250623161438.124020-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7dca74-45a8-4735-20e0-08ddb2711f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qaXu0mwcftxXLGa6EqC19Fjfj18781Hyb9l4gD3uM2dWpMzxd3RpRaLngdBN?=
 =?us-ascii?Q?0HCIdqfaIL4992FPBny0Lz/6KsSAKQoCeuJU7Jo9cjmm3K1zAyWZfcSSaA/3?=
 =?us-ascii?Q?WbYhji8AqjDKSxBVpwZZ0WvDXmZIDQ7l7hfIZUWAzTESMTSYBMKq/XhLnZVa?=
 =?us-ascii?Q?x68uqsmw1OGgaH+rz9sxKiJQ04o6at9ICo2QUuLOKM/hcXUnDk8g/sPrnOR2?=
 =?us-ascii?Q?9AZfQcAuafwLyJ0+D52AliWoJ3or2/6RZCYeyK1oRi6C/QzANn6dtDeqfRWx?=
 =?us-ascii?Q?B2FFMgT4ETxQg/qa3GKa83xYjdz8f3EQtWIPqNunH1LFOFdSxuf4y3VEr+Fm?=
 =?us-ascii?Q?Mge6zbX7okgfgMOmSz7a+6txLwE0Par7rDxoK8Fr+TlZeVsDzUsw94aFPDl2?=
 =?us-ascii?Q?z9ZM3Z3O852YGVTeV56pxA4P52UP6Pw9ADeCeso/mIC7lWxmiEIANQzy9tIA?=
 =?us-ascii?Q?go5n7BvA4nZz1fvGfOrGMHK22s0iVBRc2VtYiMzb7eBl0CKsAr88p8R0IV8c?=
 =?us-ascii?Q?L2tHX6m4LJPqw9woJhZ+uOhqM/penINERIEFE0Hr4VW7zyZp7UAiNCdj/J0k?=
 =?us-ascii?Q?8BZKvX5UK0s3V7ihIjoZJekLzr0seRz2T2D8Kclk68DXpZRbaiOpSCSB0u4S?=
 =?us-ascii?Q?7KpDoR84VAwiMFa+Xry3vdZ8mJrxGZW27jJZjAgW9cJMZzuROILXUsRJraRD?=
 =?us-ascii?Q?LEPAzBEKZMqMlDm6QddPi+Gncn/WPR6gUMdj3hm8zV78U96NlqxBKTjLlKRV?=
 =?us-ascii?Q?Y7zESau9TLASZ1GB6z2ybG/jNsK89x/c/WXZ3ibWGHfjDYY2M3Tkxkj1Yblq?=
 =?us-ascii?Q?GGPINOdA27VB0bOtetfLR+dWRFtTYKLFyd9IqHtr+D9r96Jw8792KioAEOfp?=
 =?us-ascii?Q?qRNTBsJ05SBBrAINe8jVxhflBu84hwFXdU2fZ3Fho4ATc78//RQQemjPLKZj?=
 =?us-ascii?Q?E8YHJSjAypz6L++rY/83Mk+HSF4mke2IYuxPHkd40feXjQFqky5+FXNp7qth?=
 =?us-ascii?Q?3sKmOJmS0ZK8i6+OVTrQZVq0u8Q69j6q/uOMB3w2TCKlNKE1cuXv7veH5Ojw?=
 =?us-ascii?Q?mgTp2dgyCB63rMW6p7fThQo6KHmpsFuxa63LNOQuhRNyYH1zPyColsFJyRv0?=
 =?us-ascii?Q?GktLIuhixczH97jjBlsVGb9xhkcxU+aaMmHqJ0XSAge3C0AhvndPbaqT4Qi3?=
 =?us-ascii?Q?3LWRHKwjOMkDhm3xD6IgDie7WD9A6nBzRvl9/JAhvi8yZfrTgtVkVexCrz12?=
 =?us-ascii?Q?kx37ITDgtHic5U2tqTNEoTwCByPKVdVlsioSq1U/8/sjf/+3TrBcA51dAiWa?=
 =?us-ascii?Q?PL0XAm1TjGRkeqzeO7HC8I5Bvzveyk8hv/vkaKWqxHrEQC3LWJmZOWuUEotr?=
 =?us-ascii?Q?ePSqbCroM+yWuYhqaAG9rLQGw2nGMIkaxFNxHJjv7kQbAucI0sJ+OOywjdK4?=
 =?us-ascii?Q?Z9dDvQUTmuAAVeKc+ZnkZprT8rIDCo2bMx3F/LWtxABRvcvazgplR4b/kRVa?=
 =?us-ascii?Q?+pkI1WagnGxeZZQMifiq2WLJpmJDIfjTZbVD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:08.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7dca74-45a8-4735-20e0-08ddb2711f54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
2.49.0

