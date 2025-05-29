Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE27C5B552
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F2310E755;
	Thu, 29 May 2025 20:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BL5/o4AA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE7A10E76E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssl+6z0CyQr5Fn+xb5qLi0hewBKt0BgLHhqv2MKTM2RqffWrIQxMF1VU3Rv99T7eIZcSP1LBVPMzpeceI7MsVq0s5Px2aimfEcKGzByjWVR184xf7b9DfJyZx9Sh9X2Lrqsu1lOI2J1J72YNOgUhYDSMUzKtC7p9dqifPNGZIdik7F8BCiWKzvOKVuZI65zcrGia6MzxAl+PEc2OPMx8ElUACOzThWaaFAjmcM3YjZPuTZ5Ua92s4JMZC6VOHSxLL6duj3fE47ACbtlKzjNsF9wno6CnKOpkQn6fASCvvxz5dfXOYkBEOgbdwiMpc3lIsCWoXvfgxzbYhHJVVeI9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tikB6WBLg37YAG/QollEvSWKE3Vst5jGuzK/BfMVlM=;
 b=wN4krJuMhuJ6ENSjO7XyFU7j0xc1hVxNE8zn/c32PFsh9C6GNcJ1z66xHZdFWalqVKgy0TnuENvxyat5mGLSqSBluyW395Tfw5e9+e9fEEUXpps3x9flpuYoAjx2IDfO/8jKY3ZEUdO2/rMRA68DYz2MWxe1bpMDBphCOeKPTFOXNJ9F3noHUvnTi5Dyx5uZkMYJCMrq9dE8SKZkxQHKH5DG1mIMRYOA2cm7ZglYMBXo2VsKCOExYEYXbdtgf3aW0c40euCuraOVOKP1HKpHgii1CBbhjYtj3ZHIy7N0oRRuuwUZaj5a1gCSkkcohfoFgiLU1/PdtKelvjMdGPkGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tikB6WBLg37YAG/QollEvSWKE3Vst5jGuzK/BfMVlM=;
 b=BL5/o4AAZyjK8bXWSTzwumJ9HHcbAJd0EjINeTz0Ps+y6hiN5iEAphZ4CtCAEaptkEXHUudbGKzhIlezwwTIgIM8+IuFlJLAeL3VlItrOEJ3Cdw1NAlT1fAYJySxuTWLmF/TL2P2LC43drs4x8/aIo8ZrL+EFTRqHt8PWM6QBa0=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 29 May
 2025 20:08:36 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::e8) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/28] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:57 -0400
Message-ID: <20250529200758.6326-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3297dd06-03d4-4300-16e4-08dd9eec9812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?532OAEPEJ8SAAW6zE6330DBX1gF71o3cz3JzR1UZH8SgVlU933Yq0Y/S1eVx?=
 =?us-ascii?Q?4Vqo7RppcxFz4GljzO4TPArf/xKEQAXKv5sMS9jT3KGnw01CMGhfpNdprOTm?=
 =?us-ascii?Q?+o+X4GOQ+24d8J43hN4CBOQs27jhNx2/cPRhhgt9OPpwZz6GAiwcXD1+JhnH?=
 =?us-ascii?Q?fZfcNgyN/Ypt716HaNJZP5XivnZ0tREeCh58hNcEHzZhOEEI5IYPN80APIEu?=
 =?us-ascii?Q?B4FV+9nHCjqAVhba4bB/Ai0J1T6Q/CPwqGvHKJHuHMVm2qWTsWbVhehVoGzv?=
 =?us-ascii?Q?2P9XAYp6PC3m7mTxz0GfEahisTyTwvtHvOttRCc9AhfCVUcJQ1Xq9lTTJ2d6?=
 =?us-ascii?Q?ut1bnrq7HV/FbVfhtA8Sfm+S0/lpXq9J1npbDL6XcSuf4hhBOz1Qh6tXTCvE?=
 =?us-ascii?Q?Zw3CeQUdKXCG1ecI/eTZmg5x0tdLqRqXWoprztndfanIv/bIknK+CPbHOikx?=
 =?us-ascii?Q?0xvMBd5KHGjvWza7Osd+v8eoytcm9XoSUOa2J0YoMkFucD38KCgAP4dCEK44?=
 =?us-ascii?Q?DFjOK8pLQ8pSnC7vRvWzl7lGlt5SX8pEaN+T2zzxeHZ9uIUnbgJ0GH47UfrS?=
 =?us-ascii?Q?BFnnHqrmirBmi9V2pykj+chL4obdqjih7gzrVTpzA5UYIOM3qNp9gsGVdMJd?=
 =?us-ascii?Q?hL2E+k06hIRzmKAHKSFJqpT5IVaJzY42dEUlm7VNXRW1Szf71t9LBvpt1qBe?=
 =?us-ascii?Q?vfZTRcllclUlfc358evchHPcqLAjK6GjTwGnl5oq89jlmWJ5XMkOy0CWTAbO?=
 =?us-ascii?Q?Ads0Ij9LKM1jcSvlOLheTpFGo4UpY9H6bgkMy4SEDATzMV3zP2CxniKe8JCi?=
 =?us-ascii?Q?x2LwHaSPO7b+KV7SRC4YzHOiD0aZrqREuEaAM0ULxF3S6I2J8fY+mpW1E2bI?=
 =?us-ascii?Q?vR/HYYCT8EzOQ1lV75eWKrJYY+jQB4ztezArvkt31EQ+0+UMejzAkAYkzZ6D?=
 =?us-ascii?Q?gVggv5ohoEoqBUcOgUkbj2iTCx2JaE1zgdSZj0s131HrA4Uz6H6saMOpiyj/?=
 =?us-ascii?Q?Q771LuKYAfMASs34XK2iqMTDh9VwNwItUizNuA5gz/ywbwkshWA8RmL98yuX?=
 =?us-ascii?Q?z6Osn+u7Pn4PbvG0uO8RTSoViKTCg8+PLijP4NluKmg5xl6q6PacEGVkkZRj?=
 =?us-ascii?Q?7ewECIMAtLjQfpd2/vQYVGZfDI3gU9Jsvz3ypQ9GnECK2/NZZ/u6gBIlT83J?=
 =?us-ascii?Q?1HnoK18RDYBRifOACICjBNKDbTNr2I1yIeB0bIKXZM63EeyzSKRhVifeOo9H?=
 =?us-ascii?Q?qcCqf8gj0Ed7sb7aIyP1WPhQF3a4O/j5Ep7s0NQXcFRjEr+z9oJepcXDGXGo?=
 =?us-ascii?Q?aYPjUM2zy3sUWJ5lS4kQjdqyJo80w+0NiLr6THt8Kn9++fzILfHCEcgp/fRJ?=
 =?us-ascii?Q?yEtlnev2h/4LdGGcrOt2LUe/PRQiLDjvzww1V7Q3ORSbz8PsMg+V2D/+uSq7?=
 =?us-ascii?Q?qQSkXv0V6GBBvaPQgdzE6MBnd7sgW5CaR6CHyAt/E+EbkqvVZxB+v35GbchH?=
 =?us-ascii?Q?AYdidBP/z52zlOyVipWJEd71uwJilH68X8WJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:35.6009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3297dd06-03d4-4300-16e4-08dd9eec9812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1c13ceb3bed8b..311d44edff224 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1475,9 +1475,8 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-	amdgpu_fence_driver_force_completion(ring);
 
-	return amdgpu_ring_test_helper(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.49.0

