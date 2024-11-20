Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936A6D60D14
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 09:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F68010E6D7;
	Wed, 20 Nov 2024 09:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nBuhPpvG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0506A10E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 09:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+7mds+nTFI64zYupTUeyQKgeHsrg4CsAQFKV5hqwE1r1SiO/zmpXfPBC9AkJXVAsywPExmi4zrl+ybrMkbWVW6zs4KyF761nwr8ZeMe8IW91lMY7gaL2d+1Z8NPncjtYiX2tBcDOaiEDABGgpkzG09kk3BsZkur9BHK9YRv08QnERNhAs93BvMahXdWMtKRes8Wwrnhr6NRdV8TwdZTUvQkhzldEEV8ZnSArJOB88T7d2XCLpfzj6lNF9hJqh2SufkB3F0uWWR2Wacbebj4sehYFiHKicLPt3Q3UDl0Lt+PD44cRNvcjWXhObBzBx7aygzFvyH4AWls+n2eIAMGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1iWyXjN2vikFGd64o36Fxf7mKY4/Fhl9RAuxcm+cjE=;
 b=iO6WPh5uWytd6AbXkXg7jscXMYqZ4QvaCq0nUfv+k9t3orEATkqVVyQj+4aKNr9YA0tUapGnfcR4YPkRVoKJeK1RcBBvwV7tvYo0qKoNgldhPgbE70DOyGi42xF/HjBI761ZFK1djbpBry7WtpXCnnYQawrf9rA+6CGYsI/QbOBoyr9F1B9zTw2JlZf5bvZxJIe8+StnJFrHmUl15YOa7rWyRExTWJiEQ+8ODrlSr/s0VXsfREzP9KAMCjQyNQRjDAburmvzjCLBZAMoHgS/xllJ1eJM6B7RFdYoBPi/RTmFYiw7weGmjKAYCcWsWMThGHnbjiI+DGkChmaagJV//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1iWyXjN2vikFGd64o36Fxf7mKY4/Fhl9RAuxcm+cjE=;
 b=nBuhPpvGyeKBvwqojw46+R0mcC7cO9RaKXDdWzBDKK8Tzfl3uTuqYxDN37bt+UWD6KhsC/M/W7/6Hl20/6t2DqbVGs6QlTBrHK7S2+LgINoBI8gBwUgDS3aLPggkQWVhnQxn7YmcKDCDOfyMOzs8NsNPjIDET55302Byh+/79ew=
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 09:26:31 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::33) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 09:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 09:26:30 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 03:26:28 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix dmesg warning from xarray
Date: Wed, 20 Nov 2024 14:56:11 +0530
Message-ID: <20241120092611.177202-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d4dc2e-e13e-4108-1265-08dd09456ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2CFc7q5TTmjlJU1EgqHwsrhclKWGJ//sc1uEDb7m0NAQbR2Vebk1yx5ThaKh?=
 =?us-ascii?Q?rLoB/1ZX8NrS6rq2FqG3lsO95gIBZG0z5tJmaiK194hMnXB1h1QTxHUwrSFN?=
 =?us-ascii?Q?TdSTS81w7EPsv56pRSFoOGffBSU8p9+VynaXV4HvNcxHMUG2bqZDHvJhg+Dy?=
 =?us-ascii?Q?QA1yIFBrMDNp3yuSo8zPyLmvu5kAiSEvl2i9pmGTqeI0FM/4ZCR0aMMBv8/y?=
 =?us-ascii?Q?YC+fzwonyUorxxajwAtPCWpwrIoi39gu8bKcqWTE9lN6nvNQV5pkkmXG63db?=
 =?us-ascii?Q?iVgEReirfKBdpaL46qn+cVZkrd+6WOm5Pv4oDr/znhq0UVqOtDvpfvX+WO4C?=
 =?us-ascii?Q?LAjGKKxjJekTw26pTaS24l1Qf4Q9hGxi4rkzyd7IztMR1hChzN7NXimVSXGw?=
 =?us-ascii?Q?E0vnRsk/Vb8azgAMVqltxQUKU5qeoA4s+Om1v7JHppTEsZDgLzWecTGqbIOi?=
 =?us-ascii?Q?OjBorRdVMzeDeMf9ShFDbxHfTLEWwj9fQ08mcWeS5fUIG7qmUtwrkno/HPBD?=
 =?us-ascii?Q?icpl7G00d4QrBerhtTkbeUyxZMaZjPSFRL2k6UrgosHuHfOF8FfUlA6nyqpb?=
 =?us-ascii?Q?B7T2ZsINuVM9BkbRWDGdtXiMZExGW3Hza4r4klWfl06M+h/1+YJZh8bX9Pax?=
 =?us-ascii?Q?aweLMoyIjYOuAB60CgViKgU/jKLGo4JYDXdoa1oc2HwV4GC5UAkGgV+vfHC2?=
 =?us-ascii?Q?VSSzyQBk4n5eu71UEL055rfXCkNobVtvYnTKSNHPJSwB+8KKC6PVjifPTb86?=
 =?us-ascii?Q?oM1PPMsZ1eurfNGsCpZhVG6lbrUfHqvID1cLnujAxhA24RaYPcG+5OLEiWdM?=
 =?us-ascii?Q?320SZ2Km20aiUDEffFVcgSji5H1y3RdBh53YJ9NqhMVAWGX2we30IbcZGGfP?=
 =?us-ascii?Q?hMxqQaujE6jY6sKbr/P48GVZiMTi8VHK3ck2fVYP9G1JHBcoALRrB4r29CvX?=
 =?us-ascii?Q?wpidHhK0OmKi4ZRmsI88ADiCocuyYVSBogpLi88iWs5sAUfnCmgkUpcpkaww?=
 =?us-ascii?Q?jkTe6UH1DMwdVgHXycGbLf6zJV/NW+E1ueZHvpA/h87DDHQhu5cmj9uiq5IP?=
 =?us-ascii?Q?mdB1TNxDxM/VXBNogeH/YXGXn7meSYx1PbRZeBkxz/cs9/IgtDg8zrLuD8Oa?=
 =?us-ascii?Q?3ijRsBYuj35jADWhq361XgS6GT3Y1XM23PfYVR3jwTdVAMPzWWd0WN/ly0AI?=
 =?us-ascii?Q?PC4QVLwGybhSr02tGBm9tf9lBzpuP716Oo/viC1UGTXYZCVb8tTN1rlhsYgD?=
 =?us-ascii?Q?j4p6GEUAqo9whxx1FZ2M+LT0hwwtbcGf9kWjZs1pXVOvDVOBXdUUVrwbCbnl?=
 =?us-ascii?Q?MaPBUYIaT6j100bGMPBm1a9v+mjyUzKlM7AS3P9n5EjQjVOhFNDKLT8lA2hN?=
 =?us-ascii?Q?zvddf0GuPGAG1+iOQIQbHc2pVWZcQqD/SH5qCHZbXQaovEZX9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:26:30.5288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d4dc2e-e13e-4108-1265-08dd09456ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

Fix the warning issue generated at lib/xarray.c:1849.

v2: keep the error handling same as before when the
    xalloc() call fails to store the fence_drv ref.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 76f7babd7a54..bfe7d1d139d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -842,8 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * have any more space left and crash.
 			 */
 			if (fence_drv->fence_drv_xa_ptr) {
-				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
-					     xa_limit_32b, GFP_KERNEL);
+				xa_lock(fence_drv->fence_drv_xa_ptr);
+				r = __xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
+					       xa_limit_32b, GFP_KERNEL);
+				xa_unlock(fence_drv->fence_drv_xa_ptr);
 				if (r)
 					goto free_fences;
 
-- 
2.25.1

