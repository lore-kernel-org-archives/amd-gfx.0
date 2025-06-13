Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB77FC71150
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268CF10EA73;
	Fri, 13 Jun 2025 21:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y+cWp8MI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2578010EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGnjX/qk7H+EScAh3VYIFBUvgbqQtDikn6hvfFaA3F/43XmYybR7yIE33xms02eYqBNZRTFmsKAsZjPNALzwZhlj7bm+6jLMKAfwFSxsPTDpfZt2A+IilEkN8zGrFBs5B/cKTuihp2TXZg1g+x+kmfNniuUiubn2odnp+hcAYL3pzx712kT+F7pUhO5fEMglgR4ouxUJo86keKI0gp7PkKtzBAYqOP2do5MazQSRqv+bF69n88/0hcAl+54101cbAiDHasqA7NIOulEIvSslNtvLtu0bcyAOxiezzCf03+tkaROELPMaLvo9VY5kA+ZQ55QDM1F4NJCX0953nH0GWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLNzKZ5eotJFAYbjwOXIDMKioHxue5zb9w0cts6MlUQ=;
 b=ogHO0hyW++s6zT0e8Ld0TR+Z1DYzzzRBd7QiiYddTKVmcm1eFcfqicBXle09JddVp/U7XhXcKwzfiqZShVU21JRSDqJsUL0pvQW293oOjT4pfmRfJFCFoWmYS4XNwHKI/qk6/eCjPenwbMdgviKbdPH/8aGkTfesgwdORk8/OjSDgGVT920lYEKOmjdPt3fSE5Jg17MiVn1zRKJ37VEKPIVeysKU19qMi9MJ29Tp3jpYB1IXkMe3+padyoINo4n2mFX+6peGG/+X0Id2QF38MGuDl/uFFwAooYSO1Xvfwk8jSvGIi6jtiIQrSoVgmRCCEOirZKTYj2VkGEgRjnZAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLNzKZ5eotJFAYbjwOXIDMKioHxue5zb9w0cts6MlUQ=;
 b=y+cWp8MI5fgzDXWecquhWNvaq1dr0AEwigzSKqTUmuMfco7Ywor6nY6dnEXmv3atWCryFg6ITpHrv3KYpkuSS4vDxyIBY7bsFJyCBfsWqkmZi5q+JdySHOI+vJzGuchI3XoU/Hu/xMf2QNH15m3YXsIYtXx6Q3z7vQTn0CZnZX4=
Received: from CH5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:1f4::10)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 13 Jun
 2025 21:48:18 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::52) by CH5PR04CA0004.outlook.office365.com
 (2603:10b6:610:1f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/27] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:47 -0400
Message-ID: <20250613214748.5889-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f45000-7001-4a67-84db-08ddaac4023c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vUodbWv3Koa3whJvmRG18Tz1MSRpCHIGYTk9FJ0piSTQOPx249owFzXlwEQv?=
 =?us-ascii?Q?gNhhuw3bapfB4vlZMW8GrV6oDVULAtzABTqhbTY8ZCqv8cnRvsaSkscXFHHZ?=
 =?us-ascii?Q?Vcp3UzfHtTZQikQ5noP3QU6qxZnFPgotDM1h+Eza6JTW1KSS5rPmg586+9Ei?=
 =?us-ascii?Q?wuCv9aKkRAo3f9qfhGTOpxxZLdxkMAygtociILwgkp6ob/NsZQYSwyFa0KHt?=
 =?us-ascii?Q?tO1hBrQWCOuSuTKAZM00XefxOLittTy4mKVJ3fc/xAaRN+uPgTTkYkBFw5kh?=
 =?us-ascii?Q?dN224m/dMfcYVcrYqFHH/D2K9Ogh2hMtlTWokWvvXfkXXiUF3/EWPxquWkIu?=
 =?us-ascii?Q?16uqNzaUEQ/v7MACvIzAvRVNvsdY6OeApd+7C9bA5CrvLGiPVVKojcy83h+C?=
 =?us-ascii?Q?QGhbResEjOw2qz2sd01Sf9FBgla3mGoEnFxDctr+y2BdRdPCulPMsAZQ7OsK?=
 =?us-ascii?Q?WevoNgAsXNKtBpLP9tyxPj/ZlSLOLBvchBWpFD4ButyI7I/+o4mZYex/69hv?=
 =?us-ascii?Q?TA3RwoBPBd71IIljD3oTM9bRKmT3hsXuJ6RvuM3xKefLhpWoYSEM1MjnnREP?=
 =?us-ascii?Q?SxNYLYocZNXKtFg/rFgC877wqufofm8y3tITEUBs/doRu/tBz3K63gLGMP3l?=
 =?us-ascii?Q?/dTNvAqOUohh/BU91FyBAtkL89aD4I16NEJQQfx+M/PxP6ob9gwPcWm0bXfO?=
 =?us-ascii?Q?KMwVVFCysQkcCESawwr3bc5t6nKfq3llrwtpPTQNVasuNgtImudkv7YW+M4r?=
 =?us-ascii?Q?Cifcu6fDrUkEYmleAebfCdFpkvovdz0HrO3Kh3GNzXJz0TxchV0pnEUhvjdp?=
 =?us-ascii?Q?TzG0sinX4iVmNh5Pbadsur1fIE5agMjpkRa46K2/7kTSPyrKyIMf+k5vShxB?=
 =?us-ascii?Q?xLfdxIUsY/agN/lzBF5K4ErYGtJ+AVpEBahOgXEZDKsxail67RDH8RK/uM8Y?=
 =?us-ascii?Q?MEae6/s9w1BuMhZnJRI36z+HDiMD//2qJkmRfZGmRPrsQNyhdGYDoI82jV5f?=
 =?us-ascii?Q?RrtQUHjCZ0RlTz2569z0UO4k/EEp1BW2X926GZjD2rG57WRnBfH+gO9BTgB6?=
 =?us-ascii?Q?jmhB2XR3sAJxzqRMykApAKAkwDNBaus+p5fDGYNccDQxcrgAxJre1JIDcFwH?=
 =?us-ascii?Q?2gBY9dxCJeY6OPf+QnV5ssg2eu8JWr529JN+Lir5WywX6PyrhDuBBm0F+UNs?=
 =?us-ascii?Q?QCfqMDshmgJ03mva34DhzK9f39eWpkqOaiPpl36oam4OLej2XyrJ22ActXYt?=
 =?us-ascii?Q?AQ6BHHZ03NJCHR3Vp7G7pVa8be4iyyyGe3q99NzJUXx8m+Gnu6dQCJAQLAqp?=
 =?us-ascii?Q?ykg5RwZuHeBPb+czs6nUDPg+heBg31jCOj5Qcj+0BA4I7RqLXdIodfouVUrr?=
 =?us-ascii?Q?FMNi+F14XKxOtnX6NZf1/8luqC5IazhTlYB+an8+ke8lX7uhRYVNtQ8B6ILc?=
 =?us-ascii?Q?Xa9qeTVkrDAcIgYtasYU32IUi9HIcvU7vt0IR6SiueoHwvpyoafpb8eFmcez?=
 =?us-ascii?Q?QrXre80LUj3veyZnd1HumQhIpoIAmMKOFrn+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:18.3771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f45000-7001-4a67-84db-08ddaac4023c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index af75617cf6df5..5cea5f0df6105 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1476,14 +1476,22 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

