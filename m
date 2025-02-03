Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C6FC02199
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D96F10E57B;
	Mon,  3 Feb 2025 21:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qyritqzi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D898210E578
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKZ9nKjZrj2hcw6ipkgRFQxdNstkhH/kW8dEfsUZOxIw9iRrLHOQcd85xpE2kAxj3z/ImWSqd8p0SpDhevXhGJaTWUp8uYGwFu2/2zKo1YQwtltLTHEnH4iHEuSWVbqxnhR2//zGggF+gtdeRmDc3QSyGrllh7+NZPO3oFgCH/TrFdUObL8I57WKaknw1tKvoqauZVN14xMCILli+Ndl6/D3HojlsBIHJeG1G9AmS0ExoHgzc5pgxgcAj7XRVwnN8ktOO6IY/wUNnDdCI1Cd344XBBsfoW7WZ0kbOJ33M+FGopE+fzvNekyt8nnyBsw9jozbIn257BIUreweQpjAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWiNrvPxf4yMuUbW3An1xOWvhWC4//nWfL0EeJ5iMlQ=;
 b=kBRiTtlA451AuZOA+R+Gk4LunQ4t4KEvKGGNtqi73tz03hlnTw7iYEkNzUDd5R9WPBx84sJlWT3YOdbFfuEx/arR+eOnIKGR0I8K94cFaAqiqKUYZavjl31gDWm3RwNv2Wa9vatq8rVUtWac+c4QsPsI66/cnuCpanwqE29Bc/ESBP3avWBi0vQEi6vNb95Io2MooUGiR//kyOCKykgLu2tLwjEsDZpDZwvEoeEB6t3p4ZF9vJhVHCbWcxA4i4zvPKaE7ykrtSNVAHFRSyqMe7R6+kqrvbLOFkVmUG3pxcp/dNu3g0vVjuQyA1jcAVZWOPRqlWcL0XgmNne/6bY32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWiNrvPxf4yMuUbW3An1xOWvhWC4//nWfL0EeJ5iMlQ=;
 b=QyritqziB+StVRUQMhe3+stHzrDNABG7NiW45qxjYzdaOFNj0cRXBv7AOkJRCU3hGVLCl05SyfRGsMsH8DAEZf7xh5t+ATEYMbKD63KOHMMghu9ReUD5FDPsqQx+/9M3Zvtg/FHiw5eqSEBH0dn37ZbHN3olPr/Fq6+u4489zM4=
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:44:08 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::4a) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Mon,
 3 Feb 2025 21:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/sdma5.2: use amdgpu_gfx_off_ctrl_immediate()
Date: Mon, 3 Feb 2025 16:43:42 -0500
Message-ID: <20250203214349.1400867-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2db256-7834-4baa-cee8-08dd449be384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cmOW4BYZPjClTfFWXM9IgrsKKErSdqeoEvUHXcSHD/rH06bxx0meYopiNB95?=
 =?us-ascii?Q?120FkfQa8U7HSGnlFMPc+WmuqGqoDpCQVVW2O0YXDQLgYstJxqwlijqrR+xt?=
 =?us-ascii?Q?2TcgPCOm043xYBWVq05mgR58ONBqoE326QEbsjqcJ1LeqQCxI4dDTbuIwUgl?=
 =?us-ascii?Q?upHEr+6HUHVCUbXpaviMHPIB2nuwu2UqCB8YvbEN8wF+y3WRZe+aBL65Xyz3?=
 =?us-ascii?Q?EKXCR4nExhUX8HaR8Lr4NTOos/NjR+B/h0hQ5vjB1wrsz61aLcl2sQE0Etmz?=
 =?us-ascii?Q?4Q/55ddHrq05wzn8EGCU9uXRVQUyEGB7pxJKu2kU9M03zX8Iyw/NgvH/IiXI?=
 =?us-ascii?Q?dKVPNNAVfw5d9VzyGFphy4VifIegi5IVHfcLK1v36PdNfgMuPnHECXOqXcBO?=
 =?us-ascii?Q?RvHqX9jtdR20yCcuMEFHxaBb+NPavBbh05HEA8+X6V2+gyykOA5YQaHe/XqV?=
 =?us-ascii?Q?BJEyODVO4nbXTqIQ3CRRJ4KjT3KKHcnDtHfudRAP7JbonK0wjfPqV7cvdjKt?=
 =?us-ascii?Q?C2joE7vdx8CAzFdC6I2LK7ebKrJx+UZ66A+p1Nef1hGOJaXq+kNXd5ohoA00?=
 =?us-ascii?Q?5KTTxeID5NiBKQrOAR7k8o14XSVh53xl3L1/WKFM2keOHo4+J398RncZISwp?=
 =?us-ascii?Q?Ht9LfLEeeXf6OHa6JDqsm2/Q4BjQUclYklA2bC+Y5CCTk/9FnVEYL45xHO3f?=
 =?us-ascii?Q?WBOo6ala3lmVyYQLINFrbvoIXyfqqn6wVY2oZagAPAKvMy15FT8kHDg0x4bH?=
 =?us-ascii?Q?n1IboLvJP9BcuoJC7QDk/jTiDS/lgc1oMxHFrRD/Uywt/MBaoo7huc1M1Rln?=
 =?us-ascii?Q?A041QRTH9T1P7CFZHhaZ14688g2qakywejMmIyJIn96jbH1uWss7d2eHQhFH?=
 =?us-ascii?Q?sKJmnWRw4fNyFlg6ivkhKvpZTX7EDv8oYjYpQ6ANbZA3fHmpJzp8NwL4s+aP?=
 =?us-ascii?Q?YM8/fkVIPYWQ25Kbrk7Ecpo2zLH6LmReGf/WA0bfs5TGHOIVCNLYeqEhsyPp?=
 =?us-ascii?Q?3AatMPFO3iDckgXPHEbAXb65/6tPCrTioUKd2eK9RsxSTIRdszApdYOoTxSw?=
 =?us-ascii?Q?4/GfSOjt7yK5jCCdq8MAm1TWAUisoPJMIxtLXSMyOcJ0WLoKqPU+LBt2GPbY?=
 =?us-ascii?Q?wT58gweL9hc6zHYQilKWuBRfQps2dUtuvQZZ3dMuWCBJ1Kz7BxDZJMiTdov+?=
 =?us-ascii?Q?fm6UqRw706lP/cednJDIYLhUSNECvJFdw+QTdBhUlUYX+MnHND9d/LZvnzOj?=
 =?us-ascii?Q?uTLYTNcGanRbCevHfWmR9UQkRK1BRJJz1hBuKO5EL/7stT/CUO59/SLokwXY?=
 =?us-ascii?Q?Bv5jXcquR6fk6DwXmakeV5Qk3bvv7thLcznyUIze+2lCt9r5x5iLs2jGcBNn?=
 =?us-ascii?Q?FMCFEYEsU/T0uSz8Mss+upVWntE0yAG1NTHQLkKB24T5pJePnOk/UJm8Imv3?=
 =?us-ascii?Q?NjPbc1zjncmWzdvnoz8xNogUl+kI5XHHGnb0lH7guitj+M6g8mXCHEUXvcYL?=
 =?us-ascii?Q?ZFtLlt1pZNW4xx8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:08.3604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2db256-7834-4baa-cee8-08dd449be384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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

In begin_use/end_use use amdgpu_gfx_off_ctrl_immediate()
rather than amdgpu_gfx_off_ctrl() as we don't need the
extra delay before we allow gfxoff again.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b1818e87889a2..7f2e1962b5755 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1882,7 +1882,7 @@ static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
 	 * doorbells when entering PG.  If you remove this, update
 	 * sdma_v5_2_ring_set_wptr() as well!
 	 */
-	amdgpu_gfx_off_ctrl(adev, false);
+	amdgpu_gfx_off_ctrl_immediate(adev, false);
 }
 
 static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
@@ -1893,7 +1893,7 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
 	 * disallow GFXOFF in some cases leading to
 	 * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
 	 */
-	amdgpu_gfx_off_ctrl(adev, true);
+	amdgpu_gfx_off_ctrl_immediate(adev, true);
 }
 
 static void sdma_v5_2_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.48.1

