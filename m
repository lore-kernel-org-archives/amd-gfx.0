Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3AEC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 07:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A71010E391;
	Tue, 25 Mar 2025 07:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z5S8Cmgn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56A110E391
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 07:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBSIFhFfaxjff97zYBHhriPqVhb8zVJz1FyOsuKElWV6KbYdlTVbDTQawNWZiTCcqP4JpZSsQM5QoFPp9YtNoQfsD+BwoIOtg+3c+fgsaHc/xEBSIOMr2vYQ7IBvSmvY0LoSnMMSWdI8nx6ZCbfFoVn2rKoKJeCqHEKkVgnkb2scC5yxu/EPH+BBaPmn4PXeA34n1vHpC3iNS+M88zAVU3o/d74ZAoTp5/JsLAhXSSHmlOt8HiT5FzjKw3U8TRCr2kJBWZO532K6z9ap9aJbEksHIFt50uWrSg6gl9MZK5N9DtBkdOioLgRLy/4dxA6yjXtY5ucCfJZ4OWgrYBYZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3bl0Vs2gF7y/cXMafzqEGV4wEVeAAtpGdR7yXAfF3M=;
 b=DLNEycxb/wECFUTO+NX/VLC6XLlCo6YfGsnbcdUHx7x6VxD9L3U4hkNVBvwiuaZ+rbKHaiQY1VcI0HczSfyKYFS+NRYCqO8aO6lu0b4f9IppqqjhYbD9bQRlsZV2R6veRy/DDFFcTvOF/ZohhLt3Ic6ZZXbeL8saGf8BetkPdxcAvgc3FjnjdpH/rV7iqXCANO9B+iRpA7U13tHdC5WkDniad/giTkZiXtuftkz8QxAiuULlqD/vhhijL79lTHmz/erFOcSgNRbkJB+sznD0UxpSP5xeruJN7qHWjyAeHPjnItQwFi0InA+OCXkCzQP5HSSg+89jXF257p+2ye+TsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3bl0Vs2gF7y/cXMafzqEGV4wEVeAAtpGdR7yXAfF3M=;
 b=z5S8CmgnvSN9tEDoAdSsfElJXe0GYQgFtNilPj98CXdXMGUPgzGQ6LAe6kNgzMR2u7gBrPcLUrBft8pWPGM1uBpAFWOR5e2jX4yGkvrhNZUukJZ9dvHRDo/kMadySuaFiE86+AHwPQ1ZuZnnTlH6/+cULRPtKNGa+S9J8fwAcPs=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:43:08 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::35) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 07:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 07:43:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 02:43:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: test uq_mgr list before add it to userq_mgr_list
Date: Tue, 25 Mar 2025 15:42:55 +0800
Message-ID: <20250325074255.1628501-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: dd817015-6828-47dc-063b-08dd6b70af70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SajlJ+iDFEFuaI1y4L7EMoktzuvHsX9dyQbNZ9cJ2yflsJ/QDl5PXlA1wk+d?=
 =?us-ascii?Q?jX7Xl55FbtGtn6xG0OQoo7agKVzGTn6L4wK8/KwQn05U4FcswD5nFQFyzNMp?=
 =?us-ascii?Q?aXrt9LI+nc0yiBolBkjAA3xG4U3R2ImjrPx85SRqIiGmPZlG6gaBQHNVjqci?=
 =?us-ascii?Q?lXyUgcn2Q8AdkjhEZr/dX3bOKoAebyYBbvFZ1wRf9I6xWhseRBvFRLz/Qe8S?=
 =?us-ascii?Q?QBw7tVBbdLQpF1EffEuyaIg4DNucwgyiwtJZIOOtD1rbUmjOxmiP+OT2Lx3v?=
 =?us-ascii?Q?7gzB4I9d/YJJCp8FzQDnpZWMTSvWkWHBGrxZIezo2lUgWDh0oEH89OSqZIso?=
 =?us-ascii?Q?ABOJ/ChLw7MPV00Zu9Hg8L45sfyFO7FLJ1ihrQjtmOvN8/9PonXNZUiTG1nD?=
 =?us-ascii?Q?pHfrR3PXznmoIZ0CdwTIzyzXHsl5XVBwOR/cQQL818Ys+OnsK937aGi5KXyT?=
 =?us-ascii?Q?mkGcL79+sn+8KuXABQU2djJIq/2TLP9l4+dKYcuqsXUTMC17qmvSBOVb1AM/?=
 =?us-ascii?Q?HRHtuKe0uHPrkC5x16+Q6wVUqXxKvH+ozWHJwX84CP2KWRMavJf/4ohnS/49?=
 =?us-ascii?Q?D6an+jUvvqeYCQAsbqrAvM+zN/piNok16pXnyktfUaqeAgpFTEKfYuAH4cLh?=
 =?us-ascii?Q?Q35jlOmVOFY6leRb2vLTVeU/3WwLGiZRVmQP542FdW0E9T/1tPaNpMLsZwK9?=
 =?us-ascii?Q?HnbgLPlZWm0ghNZy9kbLVigXKDvNFfoQzQ57M23rQHourITY//uqRQD1Tou/?=
 =?us-ascii?Q?TJFQK/49DY2FnM9H+EgRChkGCrYjQnlc1zW7wZq4wbV9akIRtwKlqq5UTboq?=
 =?us-ascii?Q?a0Q3h00DUY1hQXyI6NzBXdUeCeDjKQXeW6rVeS1uKpVZAYpEzn+YYSmUuTgG?=
 =?us-ascii?Q?dagpk9h7oUoAJSSWa8h1Jx+KjcQb0eWdA98QJqIjNcCOkwHNAUICQMl/G76k?=
 =?us-ascii?Q?o/v4B8L9ex/T5cbMo5TMwtgYlGMGcAxDcZDpkCZzwiOXmXjpfkS+BJq7Mov+?=
 =?us-ascii?Q?bffC5sJiRP1o8g72PyefUjGC1wI3fTRz+Dtp3MNG4zmQfb5vwPoamKKoeDYU?=
 =?us-ascii?Q?JfdCBLEqgD188B6F0hzDHhv/KodIAaGPrn4gZYuiFU/VRCTogrPKS5VuNWvg?=
 =?us-ascii?Q?Uqu3TJYjkGCvQa01QENFBXf+l+OhOJp97M8IS2PzA1+D5ImX9+gxXYTtyjvB?=
 =?us-ascii?Q?sWZe8dzdZDuDp5HrJJ7DJiq3EuPYuppGsdxmiAFdMo5F78KqNAUyeZuuplea?=
 =?us-ascii?Q?cYExh7LvlMeMduI+8tMUJGLVuZnmoq+5nmaWIuR4eHM2PadK4BgoBpX2SLlR?=
 =?us-ascii?Q?COEvMPxOaJ97h9ag5hPdcT0WalIr7FopGyATXC0nmc6OzPdkSY8l1cCDn/IP?=
 =?us-ascii?Q?KHTtWFHTio2/gaYMKdiGEUIDImO0A2tepluJkBLNBX1ablt8zoi2Tl4GpbSc?=
 =?us-ascii?Q?EcGNM49Yjtiu94aa1+qgvqlVh3m6qzfQsAMaDTjvpcMaRw/EAzFbH0Yuvq4K?=
 =?us-ascii?Q?ld79ZfXlkb6FXrY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:43:07.8935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd817015-6828-47dc-063b-08dd6b70af70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
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

This test will avoid to add the uq_mgr duplicated list to
the userq_mgr_list.

Fixes: 4ed9e48f0821 ("drm/amdgpu: store userq_managers in a list in adev")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index b661b0474409..5d533d66de85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -366,7 +366,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	args->out.queue_id = qid;
 	mutex_lock(&adev->userq_mutex);
-	list_add(&uq_mgr->list, &adev->userq_mgr_list);
+	if (list_empty(&uq_mgr->list))
+		list_add(&uq_mgr->list, &adev->userq_mgr_list);
 	mutex_unlock(&adev->userq_mutex);
 
 unlock:
-- 
2.34.1

