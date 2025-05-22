Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AB6C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3758F10E0F0;
	Thu, 22 May 2025 21:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DOE/4OMV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E4C10E192
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9wInDXySs7/kKbZon4gczwvzpDvP9wyodXi/fADOEoAmJmOqgVt1QYGE5E1zPCRiPY1L1Jyy9EUmO4LumoOk9P9nGbT7l83Ti8Z5oohHsQTs8KHaCWkBOR7zN9L/TEdnrq8GKf+kK81XcXN+sRPpXqctr62fMQx56jk/dPURlqHEAnjSCx2he86DwbxXHSQIEdx+ZSzj4nA4MKXnLtdvDnCHsiJHWm+Nrrnd/QossQLDwxHhz9Kt4p8R8h9832p0SUMUlpGpTCOUbA5IDC12hEjRzqPRvNU8L7L7vu6EoI5njQKnce7ttPoyYZgdI9eEw7jTORtN55kxi3EGjhoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNXbQm60X8yooP5pHhqSu+T3619V4OmyOVH6uuAKAUk=;
 b=x85Qqb0f9IVU0L7GNdX3h0PlusKFfdhkb/UBjNnsBpA4m83rOWhKpqwriiPKNYYUG+JIS5fTqMKum8ANSwyasDfsaV56qIMHUkok1rSX+7VhDTEpAf2uLQ8vFmgwYC97UACJtaGmxbTf1ZEvnYLA04xAvhtozv9BV2nees6rwnv1n1qiq4WROTAxU6h/sXLBsbU5z7zZ97flzVvQ9OKKL5qwbMrfG860XasWcMVcxnxPb409wzRbYBoYM5qzaQSgx9Y4J6lmSDgK6U6S2DaXQD23h69KU8CTEkvYKcDu+AnsYTHwXOck9Mltk9q+HvNUfG33KMXZWlTkiZvpMUNPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNXbQm60X8yooP5pHhqSu+T3619V4OmyOVH6uuAKAUk=;
 b=DOE/4OMVKlocvvPDiLFzHK7DDJ1mjGAkiWV43Wq1RSyRSkUu3KrFdPrkeiWjk+Tk5TsjZJM6Zc51e5GKlRiPx56QHsG3IPgvNS+/kqfhLj7hFYzQn2INP8izzyDawXFhOD8jzkOVktfaBd/8Hsc91cV5lwb1D33ie8nsq4MQGl8=
Received: from MN2PR22CA0016.namprd22.prod.outlook.com (2603:10b6:208:238::21)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 21:49:42 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::a7) by MN2PR22CA0016.outlook.office365.com
 (2603:10b6:208:238::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 22 May 2025 21:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:49:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:49:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx9: reset cleanups
Date: Thu, 22 May 2025 17:49:17 -0400
Message-ID: <20250522214919.11912-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: df349e16-c94e-4763-7082-08dd997a8ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ge83xyouM6WnouLfruHUhFTcPCh0qa7FTCUoYlCxvKK+RYNUPoip+sofU+aq?=
 =?us-ascii?Q?is/V04oW1aJEpwTsrrYFajuguYdWqEqXHXmvBEaCbkAfFG6To0QNjWfRbGNt?=
 =?us-ascii?Q?LGuQxu6FfuOtH/pBzp7kcg4GJKg4YdlIoMPjUa386sXWaXj02DQoxMz7gYc3?=
 =?us-ascii?Q?vTi7qdRpx5wKdui/YL8CS1vzsnDTd8DEg7mAA/I+wcv36Ydy/pRIN8S/ow1i?=
 =?us-ascii?Q?256OUvlt7+ecTgxTdwkkOGUc7SZoDfvDn+6XSZ4/3gC2DqIz9oVOrid6E+3Y?=
 =?us-ascii?Q?dBHlc3QHyxIxMhwd/Uh1d2U164mh5Tm7DM7kCkYR3VHKZBNLy5DVrBVC0/dc?=
 =?us-ascii?Q?aPkwSN8ure0kU1iGgDXt+jjYxFiyl7TN8sJpJM7s7bAi5FRO7WJle/EdDA0B?=
 =?us-ascii?Q?d9lPaiRhaq14UTBinNtiXTRT3R5ZSjryOC3K4W5ax3XtHUz+Ncj5BH+OKNlM?=
 =?us-ascii?Q?nFlYRobLDsLZ9obf4Mz/YTqnM5XthcNIx+O4cY/+6mQXDMp2xzXH++xOttzj?=
 =?us-ascii?Q?f/wncEzPzR7GXBO9AwhRRmkNE4pI3hGOlH4vDs5cORBLBtqMR66gTRR75IOw?=
 =?us-ascii?Q?BCjp20RTDmoC0GZkWkX20kyIs/NQ8KHqxzkSXCxGDFwI2NG1wC1Kd1V4X9b2?=
 =?us-ascii?Q?9WplMFndDFSE9rl+cnIp/c6yh1MxjS9N/+pwvAs4D5c5d2E7vkiV0ubIodpU?=
 =?us-ascii?Q?tJn6atMoMGSmMcrUjL/b6EJqLHsHN2h0dCX68B9h8PX578DobqT/owu6TE+o?=
 =?us-ascii?Q?x15xO6sHyNmnOCDyCmEmBEOJs3NqfM/oU6ylHnLhiCBWNLukX5Ipfwix6q1T?=
 =?us-ascii?Q?WU5iB5cpHXJUcjixkYTOKJCwherxhELFSR0Vp/uX64LFViVAvXe57gzB3rP2?=
 =?us-ascii?Q?m6L1Ud9v37OY997dxeTRq9BTN5xu+oZp7hk7VKu5K3Tm1A4RjTY52z3XbWpb?=
 =?us-ascii?Q?kqwCW4INQwCMP5/s7K2pSJvEwspZoVH/noe8hHJqmjP7f2s2AKrKiRM3qNjL?=
 =?us-ascii?Q?OoSIrOEG0bcIvxA3qbnxTDlMWKbd3/rpdgtnUBR9fViwtrVe6Wp61y/xWRg0?=
 =?us-ascii?Q?OtjEHAdv4vd9lbi1qw+tHvJoI4Mj8/P4V66S5jt5TeLBhGw88elCHCvvHQse?=
 =?us-ascii?Q?RGoJ6o4MAqMyrD0GXqorcpCUmGGsDHKcu/v6DpJb/pPO+UjXr6ITMO2ZLfMu?=
 =?us-ascii?Q?Nu1vqt9EBmwYJIAW6X5Jk1GxoZ/YbnbCiu1HZQPllvaRKvER5WRMuhEaBwvj?=
 =?us-ascii?Q?maMSv3xhKZe2PPu7QUcFVXJw6Sxle+47m1vmTOlMgLYWJpYzV2u6jU4lJCl3?=
 =?us-ascii?Q?x3QKUeL9cS+Z0MJhgJXEe5frD5mPlUARynwHNiKemeMfaLab/ElufauviA8a?=
 =?us-ascii?Q?M8tYTlWmNXIYO8bfHYYLe9lLpI4pmG4xfSMQnc3Z/KZPLucg4XoSUo3ReIaU?=
 =?us-ascii?Q?+u1k9JamLw51B8iTeVNBx62lr7Lo/zV6NsmYJkW6lgBiYKjzJDNCE6BtxXLc?=
 =?us-ascii?Q?fRfxkDTBinqyaGScNDFkRWPzzxLQQwCMoW9q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:49:41.5896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df349e16-c94e-4763-7082-08dd997a8ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Move the KIQ ring test into the kiq lock, add
the missing ring_commit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e1..505ae9b73932f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7178,10 +7178,8 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	gfx_v9_0_ring_emit_wreg(kiq_ring,
 				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -7193,6 +7191,7 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
 	gfx_v9_0_ring_emit_wreg(ring,
 				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+	amdgpu_ring_commit(ring);
 
 	return amdgpu_ring_test_ring(ring);
 }
@@ -7222,10 +7221,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-- 
2.49.0

