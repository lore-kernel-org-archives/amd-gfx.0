Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3776FC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 15:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711A410E7A6;
	Tue, 16 Jul 2024 15:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZs9KHNX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F3A10E7A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 15:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZMEdz3vKfP4qIzl6CAUlWf05ww7KKH5FW+vyUMk8VwpYvYUTh0Hg9wKjlUKHU3Btl8DncFFVNVlhq2Xc4/cfNudkf9R5MBFc95Z1G2kbJF1tcW+CCVrCHpJL6/1koYbSLd+6INtlxX7pMEIrW6Y1eQ2zDWOh7UILxtF2lQGE9xNxIOs5GZMZlu1ru75u9JCflL1F74zTlzAeHcAAzwIw+xxxMrQPX7wIAtIZ3TFngjGekvzdwS/WwG8RVU1oZWyyOdIsgbIPB6g/WlpbIGDBsXVgEHP567rznos/zbtUdF+tqzH5DJ1/0QPSBvCYo6jvanAy63/d26mWpOoRtMK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWrfA0795q8yjfPriDLlJs/70Z4BgBxiTf3b3Po86io=;
 b=XD/pLBPCBBJHUmsBKPT7WPIdWaBMR0VhX8P6Cig1U2fcuUKnfz3htIVT4wHPcMNgwkoBOxx2IN/3Qu0sEb9SDO/n/S7OeckLn88ebxZztEpGL0foZDbJX0zeTR/LpiWQbiC0TTeFu3aCm32yXqrdhXzCSLe1l7mLhqV7eH6XKOn+BbEBJZ5qXwEmNc4CyDHjZG+NoTdYYHo0PqMsbew7p4t3lltmu/s2aEagcAGGhqE5PzN2g1hj2U/T/ZQ4+yzkCv1AKTsa1b2xdA5nMc+4myttCO/pltvtJvzD2yDP2vRiuJ9tRQ9iYo2WT6ZgJrXd7L7jSwPUxkw/rpULuDhPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWrfA0795q8yjfPriDLlJs/70Z4BgBxiTf3b3Po86io=;
 b=LZs9KHNXCHol+SrOgmgrG4S/4Kw0MeqcSdYxtq200v5d7FCc/0BqApteJddVd1a42C1/rGLwIqa1AwWfLGpqcEzne0YoO64Jj+AWCX9E/c9x92igkObk7ajehDG6ktfhde6riskVpTI258ytynRGxsTTAPJ9MARtM3WBtGuNtaY=
Received: from SA9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::31)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:55:07 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::d2) by SA9P223CA0026.outlook.office365.com
 (2603:10b6:806:26::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 15:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 15:55:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 10:55:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell
Date: Tue, 16 Jul 2024 11:54:49 -0400
Message-ID: <20240716155449.3203419-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: df4c7a38-5f70-4a1b-6e0a-08dca5afa8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hLw/UudnBVThPt/OrBJb1meRHtGjZgNyd4KtLgIjYJIiolqsbsQzmTxndXAO?=
 =?us-ascii?Q?Syfa55nTkekR73+jfCxghcQh4RbK8qNGC+7upuRKmONhMlYXzlHf3GfYPNLZ?=
 =?us-ascii?Q?msYPbFb5Lh9jCioDeRxzIpNh3bC3p2trQYtT5nIzbWz1DLOD16vGzBHtCuoN?=
 =?us-ascii?Q?tSqyzxKQuLQkKk6h8SEIR6Keatd/AbbUnx7scma3lQP+X4YVNfL85o+Z4tGD?=
 =?us-ascii?Q?PThtQ378ZA3sTNf0eXK1c2RtqjMq2a7zjB3tGcIusJKfBsB78RAu4XpNz4NQ?=
 =?us-ascii?Q?sc0bR0Fi/Qlx8W1LwdYc/WzJJCRIxq5onIuldLuGbc5fC+0KKLHqGWVyQ3h8?=
 =?us-ascii?Q?ib4cd8ZGTQ5Fx4RoBNmy39bxCDCW3XI/5uEAlUFCzZYrZP3nz6UMcQ1vRZuO?=
 =?us-ascii?Q?iFlezVKqGqcQ1Q7YgaYEZ2Lub01b6EjetaYTQ36i8le/OXo+CVtga8Njhn2P?=
 =?us-ascii?Q?P2HlBWz1dCbVdYipjMr69ZYerbAUmOr/nsEykBeecIPDjLrfKFz69tdd92ac?=
 =?us-ascii?Q?EW4Lm/HE70yLZVFHF7njb3GeAP22OC71ij6ciicBByJQJOFs+bMIOFTO83Jo?=
 =?us-ascii?Q?brbMHlkcQoAxkKfdmIjQ1cTmi6o+z1fS3/lzQxYFqpU7QPcYtkYSVhTWt1WR?=
 =?us-ascii?Q?O4qJlhf/gna0RNZqzilZ9JbMr1V3735v848YV234/zZRJ6LHbEdtXAWpu1O8?=
 =?us-ascii?Q?c5Vy169XTtrrl6nZrP89Hd/thCPOVteBqBN7aC/zrwdv4TctAaLYGcL+sByh?=
 =?us-ascii?Q?CMB5Dwdy8iHO8HAxzf3Yjiz9Ol6FSQd20AxqEtelou5DL0jX0SKMYI1ogAkE?=
 =?us-ascii?Q?LpBCBoFen8cy8jQAaxLPeGxmb6wgL7OL5cmgPSbpQBzmhSPh2++DbhKLOZeT?=
 =?us-ascii?Q?6XdJkfVZv4ZXLWNr/ptJ1ULBNBSN4Tr244sBucPuAO23ki7LzopIQtPd1p8H?=
 =?us-ascii?Q?ZwUUvGHDH/57S6BbTxKLaKMnHrSZJO4x2dXe3NO25MMy18Qb6otQ/Wv9bX8E?=
 =?us-ascii?Q?J4QNV6YFbfumY3lBlq657xAbFOQl3RGXF+WGTu04KAOTLtnqdWNACVz4GQh0?=
 =?us-ascii?Q?kVNOf3KwiaI7zx1CvYIEzUtqBMW1spjFstNdIJk6umXcDJzg7LnS4NyK4tag?=
 =?us-ascii?Q?3Hc2qjL8rDexMua6+N8ShxdkeaqCsVvglYjbXN74jXbGhfaG8Ghb7K/KdAgW?=
 =?us-ascii?Q?vIDat9hFMpmARcrTC/TQswQHnmG1TbBc7v3YSmVpquJPzRHsDSwWM2RsPp7b?=
 =?us-ascii?Q?3+bMi6uZUa+bCVM5uYvF19NVkPn2yBcNcVMntvnncpU+r0GKYelIh/sYHpkb?=
 =?us-ascii?Q?7GE+oaKI6izMKn0I7gQK54ocmsYQHjOJYkR0p4rB7Hhx4d/BgkYXzQzSQQPp?=
 =?us-ascii?Q?d+7EjUIdVK51YNlZIEpyPqc+FxSN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:55:04.8004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4c7a38-5f70-4a1b-6e0a-08dca5afa8c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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

We seem to have a case where SDMA will sometimes miss a doorbell
if GFX is entering the powergating state when the doorbell comes in.
To workaround this, we can update the wptr via MMIO, however,
this is only safe because we disallow gfxoff in begin_ring() for
SDMA 5.2 and then allow it again in end_ring().

Enable this workaround while we are root causing the issue with
the HW team.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/3440
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 7e475d9b554e..3c37e3cd3cbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -225,6 +225,14 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		/* SDMA seems to miss doorbells sometimes when powergating kicks in.
+		 * Updating the wptr directly will wake it. This is only safe because
+		 * we disallow gfxoff in begin_use() and then allow it again in end_use().
+		 */
+		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
+		       lower_32_bits(ring->wptr << 2));
+		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+		       upper_32_bits(ring->wptr << 2));
 	} else {
 		DRM_DEBUG("Not using doorbell -- "
 				"mmSDMA%i_GFX_RB_WPTR == 0x%08x "
@@ -1707,6 +1715,10 @@ static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
 	 * but it shouldn't hurt for other parts since
 	 * this GFXOFF will be disallowed anyway when SDMA is
 	 * active, this just makes it explicit.
+	 * sdma_v5_2_ring_set_wptr() takes advantage of this
+	 * to update the wptr because sometimes SDMA seems to miss
+	 * doorbells when entering PG.  If you remove this, update
+	 * sdma_v5_2_ring_set_wptr() as well!
 	 */
 	amdgpu_gfx_off_ctrl(adev, false);
 }
-- 
2.45.2

