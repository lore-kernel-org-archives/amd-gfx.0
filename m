Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA7C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9A110E943;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rX3aA6Gv";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E16010E93F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJU4ocxpraxiqkTtPWcJcI2KV7KQlIAxgcWmzWBZhFQtSsHyRnzySOfnRAWujNnOeihrn2Ir1wQG6kA4gqiZ72E18KreUlOi4z24Vt2eLWNSyYqQjRe8Hj9iCpsRxSjt+M+r8KDU1wYj1/7crM67fiTFsVxZhOl8CSKPyuxhyQQvPIoyrT+hA5aPrU0CkkTEmUalsGkH9YuCu8DiZ+4AYh/RVj4lJR/I5UdR/i7aP+CgYWiXM4rEcLrCuAcYY78grn26thlYf/QFIVcN0qVmCJofvh1EUKhCgmAVPSINt0qy3G9/ejp8r4wVXRQowATIMQ0OawXEaHgsOQrCVpbPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3EvccLbvPS1ED9jhnJtEaPieN2D0f9AeRsD7gZl2l0=;
 b=aWeOWfxiR1u3ffAeGJ6BM8mRxn9mMEYeMgPeoqJmcAT5n3z9rQAcB62cFdDRbKLZ79+nB0pgGHU3Sr9Yi13IzzAgOT69J29zwLM0oMwRNfnCB2YAy0vZtlLGwhYj/3ox03ttzlswNP64JfMNQu4+QSmcXwUpd4OW2QAsU0sRP0PnjMqyojq6uOYfs2qv8YhlVXWlbv3Qfce6EvKEgaY8Kvn7WPbDvNgk/DveqGvmW7x8m3CORgbEdfp2lTPzPNiYJHaqZ6WTXVBrKN2RDvomYRtxjsZbitUS1ligXxhcRlyRuZ5AURpzqhKOcPfct46m9jKuUAnqkdYyD6uUUnJaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3EvccLbvPS1ED9jhnJtEaPieN2D0f9AeRsD7gZl2l0=;
 b=rX3aA6Gve5T7WKxstXTkwzOcjH4wKcUqSM1mpgrbCoQjf/O32g1+ns1ywNYN6zUgk3Lzv8auT/Mxti7fY3kG6oPQnHSr2bBlajxTdVo0Pq+tdwY+ALngeIfDBdz0HPbCtFDbHSkAfIDGpgy6au21FrdfWXLJBBJvJeHTInROWj8=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:29 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::36) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Fri,
 27 Jun 2025 03:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/33] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Thu, 26 Jun 2025 23:39:38 -0400
Message-ID: <20250627034002.5590-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 20708f40-b4ad-4677-452f-08ddb52c5c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKaelUVlxKRqnBCSumptwz/rLnM0bYX/JTv74heZtdB9WZmN+TgVVhXW3/wt?=
 =?us-ascii?Q?i3vgsIodAbcUj25EVrDcDQ871JwWp+4jnROooj6dcHo3AWUVxFO+pzELqnt7?=
 =?us-ascii?Q?qxXLv3SIqjD5agc/BC5VnBQJLDNMInTpnmHzw6liNKt3w/kcwStg4eYncl/V?=
 =?us-ascii?Q?fx6rF4hzIAeKhVf2VRG1Mrqh9RS5RFZnqxHICtbh63wlbg6y8jDTPDFrX9Pw?=
 =?us-ascii?Q?0LiOQYhWyb5M1dH0Cs9Q1jE/UQ5CtNuw1KghpJuYPRPg6+2VNTmRgREiROpx?=
 =?us-ascii?Q?FPEZZmAPO+CnBjl8Z83Gcf+C3QTpRll3ZkV90NUPsDoxyF6e2cjBe2iKhyx/?=
 =?us-ascii?Q?0RNmKxQ5qbxCOlnwVA4jaCt7PVKvtxzu1E3swhhVJW5K++qgiSSBcg+VDiNA?=
 =?us-ascii?Q?XZjcFwaUZR1Dj4KbihA5n12Pw+cVtexeT1QQ7QQFdoc3A1tHmFgpEIlaIKYH?=
 =?us-ascii?Q?32WfCBKFrhKFO2IxVY28VeGNW9k1MF4mv7TSJ4WeF0FXqRehmU/l+SMUyZkl?=
 =?us-ascii?Q?cy0bO5GiVAVEZf/91a45OP/YdWKD1NEzwVf+WeG4fXh+nWnrPqInoqyUBVNW?=
 =?us-ascii?Q?zaZ8TV7pmWQ4S8mpxaQDl6qrYoSlelw1rUAoc6CnOtLEZcuw7TuO6Y7sQYWH?=
 =?us-ascii?Q?Pi9woBzBlCsWz6m94qIoFy1NlXLV6eyBOMLYUjuDW1Q39o/wpkNHFC2W0LOL?=
 =?us-ascii?Q?U1pdmo7ILNivhFAtBZ2kaVVAFrGqVdRcOofOl4VknH2sX/pJr/XGwwG7SgE4?=
 =?us-ascii?Q?UJUJuTrhU6K5pAJOo/BCNk42kouaHd859lID5ehjiBnoYXPi5KPzCs7IdmeJ?=
 =?us-ascii?Q?yUtB2dYmha1teIAvAgpMhZhLbDDcRZBD79wE7Lqodgy1IgIiSjt60MhiAv7L?=
 =?us-ascii?Q?wyQLiCwT93zmuK9f3qM1DgNkzaLD49Qz99I5OTqIVxnMJ/X+oAD9i8eegwFG?=
 =?us-ascii?Q?f6XDigeAmPuqtQbAMFYl4GekU+zw38EQ//1w8lyFryGNcClEkvGKhsxyjiMf?=
 =?us-ascii?Q?BoZL7Nim15mGKmlY6pHEiArXMmb9BFiXlObj933s+GpKogXPICi26gj+sjHQ?=
 =?us-ascii?Q?HVb4wg5EbPCehvhXvpCP7Z4AKLbFVY0r0fGu5rdsYD4IQ6iShDMBN05/IdlH?=
 =?us-ascii?Q?yBjkSGg0fPXECu98Zb0TeDVWdh8SC+IkdKZn43lHsRz3LLqJXVwaUZ+BRZ5M?=
 =?us-ascii?Q?lfTCn6OJ/2Q4SA8Za5qIK19yXPwUeK68dfL1M4jkkAqI+BxRYGLjye75vSBq?=
 =?us-ascii?Q?YnY40vnVNZjU0gOxHxc7YtjBIX1EGohr3hD3ew1Xjvi8Al5Zy+19XxIn+G2k?=
 =?us-ascii?Q?/aECPPMrXMMghcRx57C/vAwZma9Tn1jEUeTC8VxpQZK+bwfJefJIL+dOFPLV?=
 =?us-ascii?Q?dgEz3cpOjEE35EUIM92I99Nmm2Nwv6VDO58SgYFhOcOykcYhpno+hwFqeDDr?=
 =?us-ascii?Q?+TcAG2AUuaSVPi8HqlFwLLPp0L30N+MslKCrmf7NkjZlkLC2ydh0/TP7ElTL?=
 =?us-ascii?Q?z79LHz3fuz/E4br002rWs7jDenDmZQGb1Apx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:28.7074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20708f40-b4ad-4677-452f-08ddb52c5c42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 76ba664efecb3..30f6b04cf82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.50.0

