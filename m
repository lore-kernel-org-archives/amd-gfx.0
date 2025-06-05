Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8896C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371CA10E9C2;
	Thu,  5 Jun 2025 01:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTUzD5f3";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4210E9AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx2lxgotNhsD5OOgwdsVZGl94yZ6yGgjDSkLqruKw7Pt/BW+pLrDvUOwnQmxjsJVNjA8dpitLzeAUUWrsTG+l84XGUSw59oBz5VxGHWvLDm/XQK90aEAW89XWdFe35GQB78Ckv8B2oCU+J7fXqJT86JOqBsZbsZvzzuUaIbJ2OTDMkKxCjI4QV5CAZ7+JUIVxHX3abunQvjaQiLNJ+AHvJX+jQZKUQcNAfiCvPJYNbujVk3GKPsdMLzILObu93dht7GhScu0S9O7aoPcnZkenN0lty9duGxlg2qIpbqCTYcfvizajYWxKlqxX2l/Wy0QU7qjsGhIPe2FFiNbvlEyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4hGaAp9RncHSnC6qi8FJ/DUhNpT4x0n6TZ8NmQNmD0=;
 b=Ex0LxTbCrrqgzaoYI1fTWTXywTsiCoscbJP0gBEJ+QB8Kq4Fd1c5LrYFjSWPCCzOFcG77SKFsi493zvlGNPvDwMOLcmNCmaWgf2GDYWIBs4lqe+JgaQThFuL+irMeeceYIZKUwVfbzSm7xdys6W+CDlKNYqmxTWxrNfcggEPfwNGift4evu1YWYFmp/NFGse4qN2IvRa2Mxx4YuSbPGTUHYor2UcEDdQ4zfqFACFYRuOJdMbI2a/pS3/uvrYDooX4peKisTiU29g69IIpYVpJGYRgrJ26XpsNAh7mFhwSx8mB67FYsH47rm5VZarB3F3ifmNVVdxIVa/YWKMO5gq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4hGaAp9RncHSnC6qi8FJ/DUhNpT4x0n6TZ8NmQNmD0=;
 b=JTUzD5f3FihKcWegDXN3TBYHJTlCXSJ9wfZrNuVT2fR61lZyvgKAZknhcYWrBWbZS/kpMaeK2ZzOWJDJPIHwcf0aGF9BrkMjP7F+Enw2yZYiy/iXqcexSyY5c2YNTzSXK1bbKe6Kl33rS6fUqr/AlfovjqWzz+n2kRO+maWm7W8=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:34 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/31] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:52 -0400
Message-ID: <20250605014602.5915-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: ad11588d-6e83-4a9c-6e57-08dda3d2cd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9YFNvrEzFJ0M5/Ct1q8aQ2PIGdbNWyIHNPbNedtKaE0UkosIn3kPeFzJh/xA?=
 =?us-ascii?Q?wx9x5Sv2MrQ3uCR9DKnNcWiTR6g5t4SidxWy5x9erLy4CBSK9V28vHi9jWSK?=
 =?us-ascii?Q?KWeeRGhEI/kKawlu4XeZgq3Rxp/4uN5+4p1AmmO8uX0yycr15c4HbBG8mqZ2?=
 =?us-ascii?Q?YsinjM/srx+I0lARQUzYC7qXF42CSw1ZeI0NdhGGz3i+C6WmvU+fAieqceDZ?=
 =?us-ascii?Q?Sio2QQaegt3JSktXo+MxnNg7Sx/WMUp7oDhspdZ2Y/9ftKJ4wLdGyAqsJ4jP?=
 =?us-ascii?Q?OUOpYDx14noVqnjjHDWImWPWYRrEWFAOWcPPFsF5C0c9kVuB/RTLTnFjAGdb?=
 =?us-ascii?Q?EivHehs+YDg4meMy8podcMKtF+BcOEzjYR+9sT+0xaLGZ+2KSrPFD5RL/e/E?=
 =?us-ascii?Q?2IsbLd8PAwcRaW07O0fDSC8PMD7H+TMors6rSJ6dmK+7/IP+KE3d0CQQ6YYJ?=
 =?us-ascii?Q?4hdPNh45oFobbJ8qJZjikOjSo8PNmd13fjalMt1V9YrhUIt2Uwuu1eTeY1C2?=
 =?us-ascii?Q?ARsxE5ExyNC0XdpXkwOXNeE7uxNowwLfpF1wUx792oN+4laS2F8IKnitWeC6?=
 =?us-ascii?Q?gq9Wi++NeldcxxE4Xqgdp1xzZvp4lzIen7guB530L9zdupUPjQ6N2hzGkFuc?=
 =?us-ascii?Q?EpDoX4u+kvfYva9ueIqL7Afgix8NOsM0bpKpUSU2V/Xwh6y+1x+haRax+DJA?=
 =?us-ascii?Q?oxTENr/nOAewgv3tmeXUBL5LuB6zxRyXXicD54pdG8nBdwnU/61b458dnHe7?=
 =?us-ascii?Q?ZIYmqIYh+8+/BXWgrlz9KmkAMRxcGV/GcST+rT/1FoWE7mqcv/sKxqkS9V6n?=
 =?us-ascii?Q?JZso1/YOj9XIFVjZAEhPaiN4VpmP5CFll8VCVTpeb86IQk9sMWfiCHIDun3C?=
 =?us-ascii?Q?jzx4ZhNylYiWKRL4F3TYoiechuf+xQrqLffmRYmXFcManRSWSC5RIT6p4BiU?=
 =?us-ascii?Q?B51Y1FrkJXB/2RcMJbHf2IUD7oJU8pOicrpu0+bf/+yqxUK0CKSwJjvURgr2?=
 =?us-ascii?Q?o0AFqf90oAgGFBpbUsBLyzdFNvSYBVswZMXC8pe07l1kYUEpb3aaml2kFWF7?=
 =?us-ascii?Q?16dluw50lfrnqRoB2YcKl3l4ljBPmZjqiTDSZ9ufyNtczjbOMYY4ce7VeCbK?=
 =?us-ascii?Q?5/NiFBPnoFyIzclvoqjTu44w+tdBvMZfnhU9mjygVtJEnZpxq1uvBPozWS6I?=
 =?us-ascii?Q?r2H89h+8QvtB4xClHfKIaGHhonJkSnR0PYx+bLEcdpTdn+GH7trYd5fXjgQl?=
 =?us-ascii?Q?iVx6fmOyfE/ZXr2Wb/Ykj/l6JT6z4ccr82thijsp+qEFn1NOFsKlg8R/4fYN?=
 =?us-ascii?Q?CJOl1BEYye5fWmPe5wZTFgFgwMxfbiD32GMvvQk9eXJWPLOffUFm0vbIDbZ9?=
 =?us-ascii?Q?66g3Epnh02COMtSuL4XAM9UH4IUej9PqdkP1GnChMkAB8ktrLB7zJAHg7tif?=
 =?us-ascii?Q?EMMNBpJc7p66V9fSzFu8hICvCypoVW57gw1g2LLJ6oYULPyKixVz848v2N+c?=
 =?us-ascii?Q?p+zd7+KYnVLR7Q7p0CgPgAT4NNbFwl5ftX9I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:33.8283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad11588d-6e83-4a9c-6e57-08dda3d2cd48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 7974d04c15e92..382126f3caae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,8 +559,8 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.49.0

