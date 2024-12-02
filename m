Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C3E69E8E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 20:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D9610E83F;
	Mon,  2 Dec 2024 20:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffI2fEq4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DF810E83F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 20:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX4ydarrOpGjSt+3w+8zgrdcg5izwW/8iBfowWKwnlkpWpaom9DgfaEFFARnyJx0TY3yjXtP9lipvZt6Xpzh/r8ouhL2nwH2jq6yJzHSPxbvUUDwvh4krGzeBD+qR0raN5sFZ1cCCAN1osGTCKmdLbn74uKibCC7mJKcpru4VADhiZLaq+phFcY0BaSUO0R1j+pLkyTHROmmmc1MuKj5N3bzMhGPcZ7RJYWKkXqKcTVJ9wCeSGQEKix9JQqAqn5DP46eeEYcgDOKAZDUJJpGWrVVuYbBFixL7UsxFDBv6QoZBpIwHr49Kdp8esPqJVDnqhjzNe4kxqotOpHAYpbHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJzOrM30Wl6aWOdN6xGhoYZZGdkiMi9+n4oV0f1pHjM=;
 b=NjKioQtMKF+/7tdYkistmlKmH5fKnCy8A/5iRDvH2Xpii/ZRwSRSdvsEg3XYpWMSDINwfKHr379nuM3FZSE2bOYef448hw+/DSI7gMjq2PNeIQCEXN80QNOSKjE67LVQN1G8zFNzW+YT+CZaKYtp0zy84UuJpH9di1AxGOx9PYekajXVBrkJvQmdit8gMwtFL7qGxXLQsMjwtGspPTz0Tn8A4dA6wBhZwKw9z4yWBfTPN3rpHUOL4yGjsRYmQ4y5jqDA+sFeSifYk4+yPuTcpis3sBdBKVZKmaGK05HpSwLM0/p6JGRBaXE+P0JBDwFbJofGIvJa1TOF9xpqO9o/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJzOrM30Wl6aWOdN6xGhoYZZGdkiMi9+n4oV0f1pHjM=;
 b=ffI2fEq4yY24rp3W21zD45ehVf0TulYXIo9zMU63SwPNpN3SQH1afDx+sdNvF7M2z+AqgvdZKL5katEEsxdycmp07YEMFMaxatP51+mieH9+3cQv3S7GXr8SckPAB6LeaCsatiA323Nc0DZGTmef4VaBFlwvVZmXtF2BGvn2bXo=
Received: from BN6PR17CA0048.namprd17.prod.outlook.com (2603:10b6:405:75::37)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 20:06:10 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::6b) by BN6PR17CA0048.outlook.office365.com
 (2603:10b6:405:75::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 20:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:06:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:06:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: warn on DCC in fallback copy path
Date: Mon, 2 Dec 2024 15:05:50 -0500
Message-ID: <20241202200550.1059475-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e345ec5-89e6-43d6-cf3a-08dd130cc366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zE/6XToJGN2VmFAATG1h/67L2aVLKfo3O23bdf1Sw5Vn/kVtu6BX8PoaVd9u?=
 =?us-ascii?Q?E10F7KPEBr7Z30DZLZUpjQBDA51+m9yA+QfndyS9XI++yI7MAg5YcEUvgWDs?=
 =?us-ascii?Q?qj1KfRvkpVHlJ2PHqxaC3ymMssqb0PvM9JAbF26FBB7uI3idzFPRGibkTKG5?=
 =?us-ascii?Q?jo4F9otBvw7vJrAveHYcWaQjBL5vVZ2ClgOqjhyzgdBZXOqZ/gzbEaG3leJb?=
 =?us-ascii?Q?K94woAg/t2Pcs2aEYJ4aiuv9AllhgBQaHHs++7pF548G2RUktI4Deeymdq+d?=
 =?us-ascii?Q?CEZcVa/9Vi5u1DqZ3YMv+kOPNHcX0qSjayU5UtDs5MI+O6khrzJtWTFSiC66?=
 =?us-ascii?Q?k1k3h4wEEmcTBEyCCZHlA+sdDFzWF9kWSjKg4U710zy2iHtbwONxzJS6Em6U?=
 =?us-ascii?Q?HMTI4f0dwxrIN3WPE6O2Hxok2Tl95DV32ECLw7eB9wqnM7tqx2RYqlzoXIH9?=
 =?us-ascii?Q?/kyI6gePsNz6waMRyLZQOskpCNgriNt22Co0iH2XgDRcB+RoJQh9PTYjsXVA?=
 =?us-ascii?Q?3Ie0Id8ZU104TiK1xfPIoUwrGvXLmzuOYqkD8CAlaN/lIDS/dTWorc5j8DKv?=
 =?us-ascii?Q?e9hjxaRfFl1JSM1ii8Fa1eTgXWTvehynBiCprZLHQLJ8ZfrjYQh7L5Spg8xJ?=
 =?us-ascii?Q?kozge7VMvKBiDSr9ZxxFkC59grXmBNM+EoSMYhW1yGY5juETEYjexcdEDE3y?=
 =?us-ascii?Q?yaCAcT8rqoGZtSGzNZRbaYkUu/q4n+SIfEe4S2hjc0mLPs5O3kfCvWrXl916?=
 =?us-ascii?Q?iTQApWPbue0G9IX5ebt6OP/AHJVZqldK8bkHfI9wCQtFVp5GhFpiSIe5o4iY?=
 =?us-ascii?Q?Z83c+KaxHyJ8aiITtI+UactrDIgilf/0J17do6Ow5/piFf1OKJJvLPJJZ839?=
 =?us-ascii?Q?YEf/QoRnwXtcXaZoerNVNEC6kGgjfR7rR5Ry1a5qtSpvueNdgtKh3dFeSUUa?=
 =?us-ascii?Q?4ZkdEuLM1bvHQZL2GVB27t8m/G2JTjJCXiwWVtuib+h7JyIcxcUs0JwZlyr/?=
 =?us-ascii?Q?HNUXe5pA4wPHzSqVg+PJU5gYZKB6mHYdpRGS097AsUfKV9v/Xln7292a/mdC?=
 =?us-ascii?Q?cVJT2O0LzkADIhAjH6bUKNqWyckXCph8jyd9/KgxeKMwPrbtKWAJDtZZh7jr?=
 =?us-ascii?Q?64m/5qwm48ilIwJiX5IPhhjUx0IKy8FBvlhor2DGXZrlkIOikAJSqSttTc/C?=
 =?us-ascii?Q?itoboGJx30cXqiBADyvp7/bXakD05UKBSNe6CkZF7ld71Zvpql39kVOf/OX/?=
 =?us-ascii?Q?RgZvSy1a03pxomtk0Xzobt9Pn+fdlxzIyslCLy7zyRCJK6uI2v7qa46/ZqjJ?=
 =?us-ascii?Q?r0vAewjvlzzSXeCvKNPhWwYtIhxejwqZP5GcRS/ssVQIRx/9N7StlmNHoWZi?=
 =?us-ascii?Q?3IeYxmzmGfkZRinWbmuznAA+9zrCi9ovw1GTVGibPtMRxJEfUEACWqB1c9Ek?=
 =?us-ascii?Q?r0EaLhhbK6uJ4D2bBZMphLrKP3D8LjAT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:06:09.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e345ec5-89e6-43d6-cf3a-08dd130cc366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

If SDMA is not available, warn if we try and copy
a GFX12 DCC buffer with the CPU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9f922ec50ea2d..884e6b6984619 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -565,10 +565,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	}
 
 	amdgpu_bo_move_notify(bo, evict, new_mem);
-	if (adev->mman.buffer_funcs_enabled)
+	if (adev->mman.buffer_funcs_enabled) {
 		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
-	else
+	} else {
+		WARN_ON(abo->flags & AMDGPU_GEM_CREATE_GFX12_DCC);
 		r = -ENODEV;
+	}
 
 	if (r) {
 		/* Check that all memory is CPU accessible */
-- 
2.47.0

