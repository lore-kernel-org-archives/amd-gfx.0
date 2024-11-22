Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2E3E6918E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 19:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3994510E305;
	Fri, 22 Nov 2024 19:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pHeOR/c";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E2010E305
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 19:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eibQKGLV5cyYsKSUIhxQ4Zfj3oDK3h3co5ghmGcjd9XKjd803lTBNGNSpjbppq1OvMP2cmgP6h9bVO2cWprKI/XYqAZsvuN3u54ePn1w+Q522ddxRFoakOO0yUbhsBgTx3/bF9DCnomlOEn5btqnMgFeZELoLdY5W7zfr8pxrWLs8km4LnxjIAk8USn+ASc7yWanUYX7RRjcUYzlAoi8SrEk/WNi5YU5OJ8ZbaAHlTWJllCOjf+GnzgJqDys25nkGN/fZUswCNYUTCSzJE17rLi86k6CSboOOSWnuy4l00WbfyJv4SOE2B+OJrs0mcpFcbRJRSVnaIMPvpC+ek7rtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM/TayVw04AvmIftU4Qr2qD2HVg43Eq0ZnqpvvYwFRk=;
 b=VOXleG/ElISTlQ1hGv6Q0WTXcUrFWM+UFDjfxDFq9F5nO5tL9hWHtBIM7qezaKMGnI7gOcu8inn38xBQwqxgyE9S9NX0OC8SGLE8qOPo3oXTt1Vc5HHETVV3Z2RmFiUAM27et+4GGCSKlfodbrlcmlTUxRmEXkDK6VL+npUjSnF7y6Arwy8kUsR+VMvqo0FaxjdN0FilSG23dxB3mI3mZvYX26TGgJcgyO/E/FCE/tN9IYvv0hgjTu6iuLsA9AlpQnveAz4txKTydtg3WPw/dQZ+rJE+UiSJJC0d+Ftr2+49ylEogmi86HSAHHfFzkGkXtc/TIGUJS+3/UNh+E/F2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM/TayVw04AvmIftU4Qr2qD2HVg43Eq0ZnqpvvYwFRk=;
 b=2pHeOR/cyG4VIe8sCtpeJOAq81k43gGIoquHEUIBlX2c4SSq53VnlQKVunPcAsnuwYU5lMRVHY//Gr7MzBdlGHKSHK7nzjLGXZnMsTEZn7d5ryiLbGmj1Cx6KLFpMgaqYv/DqeCp60lSeV+QF5OuUgdQsgxCbWTNUhAxD8EzC/c=
Received: from DS7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:8:54::25) by
 SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 19:03:58 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::9d) by DS7PR06CA0043.outlook.office365.com
 (2603:10b6:8:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 19:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 19:03:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 13:03:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg1.0: fix idle work handler
Date: Fri, 22 Nov 2024 14:03:37 -0500
Message-ID: <20241122190337.1145702-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0944b8b1-500d-4d3e-57a0-08dd0b286ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?36gukKHZ0CHLW+s9md9eMuoWO/mbBrPc93Kb8L33KdTP+Mb1YQeA4P5Z50rp?=
 =?us-ascii?Q?keMi5IfFnxA5jGJJBXRpHrxvgJgmzto2RicShBvWA5yfDkSLVY1H9rb0kVcE?=
 =?us-ascii?Q?W9FOtAICXOBu4UbiW3ez3efnjR4a9hCjTqdA4zT51pvT4cmi227ZSU/06ywb?=
 =?us-ascii?Q?wlcuEbUiHNNbb/sVd/VeOuNm4piXZUV1nelNAnfuQDcFTDzgzWpdjnnlPFw/?=
 =?us-ascii?Q?tuDlJZHqA2D/vvcFOPjSKv9oOpZqaOZ1dsGacOrvp5KjOVplrQnOHMNPXFqD?=
 =?us-ascii?Q?h92d6Jd+jUxSTxzcg7Lk4CgVaVAvaAnOailXUTdiUeUP8ddLbbw8396Asm2U?=
 =?us-ascii?Q?V1OdSzmq8sT/Z2qnRDWJ1WCbNrLAlkQGxnKh6Bip5gBwctdXq/R5hzPXeK7e?=
 =?us-ascii?Q?SPtEX0PiMIL0WjjVsrvQi7MXSQ/fax7TKo9t87Chw/nN0AQ5xfybtFq0BJTR?=
 =?us-ascii?Q?rS0HSHzV97qht/Xz8I3E5JrvFKKR/YRgfIyJUyD57takPBGzumFewpnHfvIY?=
 =?us-ascii?Q?VdXu2Kuh5gES/GjzNdEw8iC5HgNygFivKVyLLxFKJilHuiNk9ymdHq6ooWpW?=
 =?us-ascii?Q?3M5EC7y3zxuTxoiUICpyIMYshWkd8gGAFzNkGQSe9MLHee77GI6ndgmohiT0?=
 =?us-ascii?Q?EjsjTxF4hN1AOCj2S3zqk1dpz+ykhvb9l/060IhUV3KSe1eVaX6ntTke++EY?=
 =?us-ascii?Q?0nCOfaui1Ji31RsAGiCBWMDjy8rWkKnJ0dapQ+9OzXMLp9G0u2AvCw6PuCsV?=
 =?us-ascii?Q?n6rcfK0yFJr7aALdHL/RF0fmQ1VZVwFgmubKr49l/81LPgk0qzGZvervC4wc?=
 =?us-ascii?Q?SdVnGJZCF+nfzXkbwshAOy8Lk9+NqJ9xgIygMFuAeNhQW1beo78+SFIxPV2X?=
 =?us-ascii?Q?8UichAIamHHbN+BfGLRteDiDdlP8lF4RAAQ6sEzDzynbvYIpwrhtDNFEdSNZ?=
 =?us-ascii?Q?NFG6SiLS9xRkd/xKs4YK/E7Icb3BinLwMkIiJLtweiHI1Pe6Ezpmwuumy2lH?=
 =?us-ascii?Q?ecQThni+siIQztYt2V1B+N35c6YbgOwn3QhpRi8OKMPN06n7Mrx0HMjqUpVv?=
 =?us-ascii?Q?t7UB8AlbIjJKfxOow1M2vvqvd66vCYv+646D6ddoTxmXX4OSVFQ0y4IxybTM?=
 =?us-ascii?Q?b0DZasuz+b1JfPdDjuRSz0xB+xRmr9DWp7eNecWajiaKfpvdE3GP4vvXFRnV?=
 =?us-ascii?Q?hW/picWuVRPU9Kz+aTqULPykbi0jrUA5KQYy1/OwVFpZ+tWC4tbPSqgVc8Bw?=
 =?us-ascii?Q?CTwYXGaKGpJnuuc13X8abIFS4xp14Ofn12WC9Xord5qsFiFJ6a/6l+/qZSGA?=
 =?us-ascii?Q?kxBGBffo9vQxIsGiivJ+nObhcMmDtERzuVKuOkNFSm4695wy4xb4vUAIbUDc?=
 =?us-ascii?Q?A96Rl9cMz/nB3ZbgtbKSX40PLKr/EAQkYZvh3mMAsH4BwTj8dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 19:03:57.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0944b8b1-500d-4d3e-57a0-08dd0b286ac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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

On VCN 1.0, VCN and JPEG use the same worker thread so cancel
the vcn worker rather than jpeg.  On VCN 2.0 and newer
there are separate workers for each.

Fixes: 93df74873703 ("drm/amdgpu/jpeg: cancel the jpeg worker")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 7319299f25ae..03b8b7cd5229 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool	set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 	int		cnt = 0;
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
-- 
2.47.0

