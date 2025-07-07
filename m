Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB8AC83F0D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1C110E518;
	Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePklmMvf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A7D10E524
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsYCBqgY40KS5onRnoMmNum8OkgDX8WPtCb0ryng6PMp/rb1psj0/09ANOAXk7vo7jlTFJPpEk3ts2OJGIZrog+Bz7Lj3Hf8ObeZEC3gy8WYV3JORCwk3s+gCI9DCglpmWgPRXC3pXcRau/fcEMfSR+TKo5Bh5pDWIqOuu9LjrZEgUMjcfCxJpwxfr9pWUU3ZNqh5RfxNHGpwW5LbA/KMBiWyKL2ZPeV76byw4Ay00w0TPEzBN2rcDiPefF6NDyMQ9CdK++uNwyqwpzv1ysrIeU1MIaqHA+0iZvn8iBos4cHr8R5Yy2CTar08RkAPb323v3V2qGvX4hEJwdLXeaUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6Uy5aw9ib53Tu/M1YW+A3jwoT86+uElwXtMsUMoO/c=;
 b=N2iCHDY+98sa0+83M9X+J/8Ts8boaDTm7kwFTgZ2QQMpK9iEdW97vk00Euu0qQJvu0McQf9FK6G+frSUniGgqwz6QWR6e5Jwm60d4vqTklV/NGZlNFZIt8rzLm6brNrQRJCmGnW46Z1TNvkrMUKblHY//3Y5WFf7VpZAsih/ZKVXCOiX8w/UNxSu34wq65j4INuJqwFgjLk0PjX2Luw7suamP/SMA+lhU5UBqJYi96IjXkt60hlA7sDmmy10dKRfjPs7o8fw0mg9y8lmmG/e8tiH3FApdq1ven03OuTmH2fJpyaiT4aBg3Q3AZMF2SEMmrgxcHsQhA9+fA3skrY99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Uy5aw9ib53Tu/M1YW+A3jwoT86+uElwXtMsUMoO/c=;
 b=ePklmMvfbbEwpDxmjYDOKmOoMOQ0S05uiQDyeNEfLBdoo9404CEF5CEdqwlKDigEPOOfpgpjJPyCrcMeA9keGwU+XWZ1QtHYwrWWkb1Z4sv0WhVSlikOicH0JnhkdrNsjQw8NDK3WfEzOodR4emOPcFIoRk03Y24lbjhzqiKGik=
Received: from DM6PR11CA0032.namprd11.prod.outlook.com (2603:10b6:5:190::45)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 7 Jul
 2025 19:04:14 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::7f) by DM6PR11CA0032.outlook.office365.com
 (2603:10b6:5:190::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 05/36] drm/amdgpu/jpeg2: add additional ring reset error
 checking
Date: Mon, 7 Jul 2025 15:03:24 -0400
Message-ID: <20250707190355.837891-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f85d12-3d16-48bb-e390-08ddbd89106c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zwfuT3egkaC82RwJHU71QSOrDnyQwOqK6rekSF+gCfFREXbpLITJEi7WMwwD?=
 =?us-ascii?Q?rzLK0KCvGTDLHxH5Ou4aCJLiCA6XokXu0v5xrlrOxJ94Ipsfb+oC5604YjLM?=
 =?us-ascii?Q?CH3MVtgF4kUZYIHohaUPYp6h8GKZl91g8SelF2Jqwlyr2/K86ErwoypXa/hc?=
 =?us-ascii?Q?9kVCX9IhZ8OBv3ld3d+M/zUUtCdVE/clWMguMKoLsiE05hQ9j3rl7IfIKAig?=
 =?us-ascii?Q?QKSmaB5uLx48fRL24HnKu+XZg5LNUf7Sd/PEgd7Uq5J2X/7VrDSfdRxBkgL7?=
 =?us-ascii?Q?w/vnni9SCbGtgTlx5sUbOpqx2LyGhfgc/vjX+baYMXFY/IlpxPtYprZY4xxN?=
 =?us-ascii?Q?jJxBBnJORpZZrsccyjkP6G9uHo1mqQjJqhigUZgYOECPx1TWcf78+PtZ9rcI?=
 =?us-ascii?Q?ZXUELxwVCIftfUZzR6oaqaMOD8s7ABFtTJXP0vrU0I6U/9lhUmEOORZrlDoP?=
 =?us-ascii?Q?OXcEAZzGKVy0alg5cJSdpJNXMqc7e+O7pLBQyNvRMIGEdEvNtF33rd/CnoV0?=
 =?us-ascii?Q?FykvdwgHmFPeoCMxtBDR/TOSjTkymxQgvkkn98yfp7scP5l1PqdigKVv8rJN?=
 =?us-ascii?Q?hsQZeUXME6sxaCLkBlBGe6/4aehJL9ytwiNDsDTw56V3FuGG+2bJ3nAGvGZP?=
 =?us-ascii?Q?rcuwM3cyL15Yq5oU3TOV9oHAcikCNwTFFQYEJuvDmuEEN3mKS3T/VtqFs2ta?=
 =?us-ascii?Q?UqP0iVoWl0R9BvBBexdO0k+U4wkNVQX2jmjU9cOuFS6Xfwk5FeGOxLmcimrv?=
 =?us-ascii?Q?dDB9Jh3Lzq6lojYw8+a5H1ushfUBg3S9Rp7SQX9iUGyNRUlDdEUCamym8sIk?=
 =?us-ascii?Q?GjNIAKIvxs+RpzyUn5blKtqkbQEOJ5cB0hIbFx/FuOuoukoJCRiuTh+T8SCG?=
 =?us-ascii?Q?HMvIBT/oCZfVbxrOwE3qFNqNmdaT5Bhx5osTiWwlpFSQQZ0Dxkg6R6gOe+eI?=
 =?us-ascii?Q?YxmdeKDmvk2QLDvPAse+cB8tD7RG0uAhbojkrHsI/PmxCEuL0dKV2syLPPDA?=
 =?us-ascii?Q?7LUBv0dvU48tpNmSV9k/AFUXZ6Eu1xaX9DYq9uuDjAnM93SfmvjdZiY2rV02?=
 =?us-ascii?Q?rg5XVO3Bdy9N9LjJ6ICpykJkrElMZN+c268Wr5Hro98AYr72roDBDOjYjmSO?=
 =?us-ascii?Q?qqtoz4o3oa4uXrFvr6HUiYIdgng9rqZvrxdfGY2vMQ/g/181iFSpXxpDiGOI?=
 =?us-ascii?Q?wD4HcvOLxiEVvp8tIMkqsOZ4iJcZwS4m+tIdch3D9YBjDK8VyZjefvFRBZnm?=
 =?us-ascii?Q?m/atjR4IMjw/MXxcAerM8wVTyb82uu1o+8KcTj8v9PdldzJm4pev48DXWvUT?=
 =?us-ascii?Q?dRB4FyXagU+b7X9hj+ctlC77kpJS8BcK8NdSi2OtsiK50BLDn+t/etb6TL37?=
 =?us-ascii?Q?VoC9GlMoGmlBeJ1GIJRYv1y28fe5ZAsa9TlBqB/zMO0a7qlr6GNC5C4BaqrD?=
 =?us-ascii?Q?s65LZChIesvAY2q+g0hRj3dGi/mlaZPYI1mPTVYe/L1If01okIfyaS0likcG?=
 =?us-ascii?Q?H7P6Kez0OCsz94ysuG2F+9v+dRvX0CCGVLxC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:13.9327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f85d12-3d16-48bb-e390-08ddbd89106c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

