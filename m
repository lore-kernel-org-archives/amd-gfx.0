Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EE0C83F25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0160710EADE;
	Fri, 11 Jul 2025 22:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWUrAB+o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1CD10EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvHKniTWuuqUeex5w680v15j/rVD1jHxR6pJj9EUAbdRy/ZkwQJtZGTSkLZ+kDSDNcTE2WWuDatb92Ha7lCYK+4m8x/Bhd8bIG9D/XZLtMWDHVLs3s/yOobKjml/oh+Cc3fkVIxOr5aNTu+btsWr0XTC8/ByFTpBLkg5qeiLHom1GpLCTjlHOeSvdVQJa0qXQXC/zUAAdogqlBW4LrjcW/E1NlktKrZMqqUmqwoyzaX3YLQHKsqXQDRLf7pJch8GQaU5wllIucmYSkunULUWLvf8s1KFrxcW/HUHUQodq76lqjVJ+ECKq6sjpiju/tawtX4ommgxwhQp5tXfW5GVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6Uy5aw9ib53Tu/M1YW+A3jwoT86+uElwXtMsUMoO/c=;
 b=EMmnFn7DH0BAlHPBN84MsazGndNGV8bW7DqthXzBRZ1XIKGz4wwkwQ13NLyYZXPp+gy7syIJVAdRfbkelwTq061c2COgCSeD/qnDoczrGtU9hnD3D9TOf471HnURMlf8XU0kQksl1CtUaM8L9ErFoNGAyRs9+orQlBwluzdum99zV5y4sPg0aFAoVLV6HKNvU0UykfaoKc3lVN94K1dMa/Q/45boHYnD9ZfprXAwFZAmqkljulfzuKdN93Lw7VarMFkdg3J9v0JdlVpQSLi1Ud4gZedeJU7fSngH9REBP1tbX56cY2ARcqLqlSH+W0CShA25wX2wHeR1MF77hWV2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Uy5aw9ib53Tu/M1YW+A3jwoT86+uElwXtMsUMoO/c=;
 b=NWUrAB+oE09iRMxhCeyJ2LNxtQZO1mMLnr00WswFC0OH9zR2qD+qR2F1yIfM52hP1y/72eaEBRDbNMDWIvPmohWs7lXx0felDk5s/bEo5dN1goJpEP2vN+hQwV2nuvDXxY99GfOKYLSL5M0MSStjzgOKoPzjdfRk5zduLeDG1pI=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 22:40:42 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1a) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 02/33] drm/amdgpu/jpeg2: add additional ring reset error
 checking
Date: Fri, 11 Jul 2025 18:39:53 -0400
Message-ID: <20250711224024.410506-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: ed519157-12f5-435d-8c7d-08ddc0cbf77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVFwjF0iLJBMuvS9du40R+wAbFgRqjVTU/An1UsyZd+KUhF1EYIjeILkZ5SL?=
 =?us-ascii?Q?/XF8wZCbQIyv3PWotxpahkJ1ssjQeb7c90qEB1B1Lh7qvKz5S7B27PaMg6ed?=
 =?us-ascii?Q?nqviFU//L7pedSlWQQf17nwtU02TqYbP5WFgsA6kui/lj5+dJKxKR0ZzmDAx?=
 =?us-ascii?Q?pGNwzx6ljl7ps2W4U/ylwqD5/ILyjGq2FXQxRbb2jq9FtlXr1XE3pRkE986j?=
 =?us-ascii?Q?8Y+VeqasV27bDjWbMsLNLm/sAkTjS7p85HdV02WxJ8xLg81yV2i6USc8bAcs?=
 =?us-ascii?Q?TrDd+xAGoXWQNG5OwU6LYYYnGrlVDbnplcqEZHaWBySW55k9Ki7Kmya0Xp7v?=
 =?us-ascii?Q?Vcgbq85tI4Rdi0BK/UyKtDtfwc9105NJEZK+twbSNjLw2AviOfV/zLJWRGjM?=
 =?us-ascii?Q?7Wfx+vMKQhHyKA8l7UqSjTUALnbgOffjH0yLalGrPY7/VLrhLWtWkmLcXer4?=
 =?us-ascii?Q?gR0SplWLQbHg1zwtGXC3bYwBI51T+nEvBoqMuuzuSlOFAzYR7Deh3yxq9Juu?=
 =?us-ascii?Q?4kWPsjVHeesaJutzAocvFcW02ZiskULJX7dMUMqOvKsB2MWxAcfe5/mThr6A?=
 =?us-ascii?Q?wF+GytpVT3xHT4V0rmu2gtY2aZeF+EQOYeil8Z2yqHnW6HLGbbUboEMCikos?=
 =?us-ascii?Q?2l1j8vXdnkyZmqBaKOU1f+HKJmGkRIt6ccuDMBOqncTZBBYfiQuN3D4jsVaX?=
 =?us-ascii?Q?/H3k3Oq0x5RMzzGSnJLeNIajSRLJSNOwhz1VMTQYrekUMvjYwRwcJPpEedz7?=
 =?us-ascii?Q?wUlua2Bw1DUi8QqseLZQOG1uA4jCh57NkZUT2kE2yhnMSZ7dBcvh67IwE4PI?=
 =?us-ascii?Q?h/nWreGpbCFwDkKnctx6qgwqC60PH6ep0yKZXq+Y3hmQjPChTRpJYhR4Ufol?=
 =?us-ascii?Q?eZfBLJAQu9MPhuiUblB2mbGew/qE+jgBXUv1ob+H0K8c8y7qOrB4Ejg9C3Dz?=
 =?us-ascii?Q?9oOJHaffmPnf5pdmkHYvceRpQOBwpEgDYMTFoZZxjeJunEGu33cErPOx2d4X?=
 =?us-ascii?Q?tQlNA2XAzW1436kbKvagNOyANH0Q6LFAhsqyrEekD1JKnW+MU6nwd8bpPAK+?=
 =?us-ascii?Q?cxr2QjZrKTuG5E/arm0BfUMav2MqUwP+YzIk8Ehg6StG9/6wpyNHWwXSOvjU?=
 =?us-ascii?Q?HWoXRcsUPjFpMPazd8Q2fov0U4xp4eA/e8LLTtsvBvTOKWWtiulb5wqiZEj3?=
 =?us-ascii?Q?LYjL6ND6xJS7c5Tu/bRkTT2XA4Z8AN39C//icEojx8J1C/1Xz3s95EB0x+eg?=
 =?us-ascii?Q?D/zaSJyLKMPczTe0zJfj/vJsAltLdVd/nUF9ez5V9nN38cOK6SG1tTYtHEi/?=
 =?us-ascii?Q?816+3sj5i8dXOHKQ+UW/YYfLoG+83s5DknVGnzqgDYQBp4FP20LykLX+ymIM?=
 =?us-ascii?Q?IBtZKSOo8xfg088q9N9Z3RnvIxxSj+KGdHZ03i0NNw4iNceWtDn8Pn2iIJ0S?=
 =?us-ascii?Q?3E41LpNbcON2EnFooh3Kg4/IuqAm7kb+ap/7UYigxeeedrMSoBMINS5w4YaY?=
 =?us-ascii?Q?8lMcpX0MIMBpIsrETK65e/rTSGJ33NCbYItP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:41.8772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed519157-12f5-435d-8c7d-08ddc0cbf77e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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

Start and stop can fail, so add checks.

Fixes: 500c04d2a708 ("drm/amdgpu: Add ring reset callback for JPEG2_0_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 781a5a8a83614..5ba1c5ad9a5e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -771,8 +771,12 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 	int r;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	jpeg_v2_0_stop(ring->adev);
-	jpeg_v2_0_start(ring->adev);
+	r = jpeg_v2_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v2_0_start(ring->adev);
+	if (r)
+		return r;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.50.0

