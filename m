Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457E7C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 12:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE81112C42;
	Mon, 29 Apr 2024 12:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LI2tDyB6";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4674112C42
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 12:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC8YeobaaBfIjpJrPFfHgK6mmsIRwAfDyyAmO59B0JLh3Ut/FU81qaV/FWVaS38fb60Ci+9KF4wzqgVLaZmlgfXbHSDGM7kZN3BdjYJPmMmPk12RiKjfrklS3ZxQhJlUd4gVnQw7lEzdKx0UnMUoTEiyjeN80mrNV7IURzBbKvWN5KDOzMq/OMflAijfcBYuVJ1LSkWICllCmPGNgJ7JmXMkiV7VMnyngV0HZ77lTm9APMb0uns+8VDrJfVAY9Zuiiv4zDWby5OnTsOVVXJFRL3vcVDeil0/4BJkD0+nE1Q+bscJMsQOfFQJeySPWciIvFNrv9GKjfJjp5rMubbXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlB1b+BVc/CaJuNbwUjnFIY1DDJ6dfeMwNfDaLfFiFY=;
 b=EiahYHHEI7EQp0zUmnQbhm74K2dY5xobPXTylG9lOOrd6BGZ5I0d2aLihrJbn+eM3xmr9ro1CBrJAUWli+nLcEXB9Pw5/2TVmJBgMyvch++sBpVP7EYTR3lHlvyLGjU1O1st1JKJzGNSJ9OJGOQcOiyOXMe4zeOAuiadg8pPf2Ka73rYYY1hf1/U8fHRa3JbWvAoAa3sRVcIn4eltHesG+GOq3MNAqO0DPDsxTyF5erNkODqL79O1uN3dhcZZlU9KY68d+REq7eLsCuO9ZvQuXnB9HVPMtaXcOEn2eyx9eCCC4IXXx2BZYiZCOSq9ce+A97w00Fp+qV+xw4CyvFbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlB1b+BVc/CaJuNbwUjnFIY1DDJ6dfeMwNfDaLfFiFY=;
 b=LI2tDyB6Gt3qzegaHbw8Js6j3mUhXplZUoG5BQcCykO5gBM++0rgDeBD9IMQRgSEga0e2WM/eHqtJ4A3t4paraDFDGPU1MkbXbQ16p+eFSVfgenn55AxnxClyiSN+JelDN9MWMrntpfvPBIpP3cP/axcqgr93gMlPp5OsLZbYAs=
Received: from MN2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:208:239::17)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:51:05 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::cc) by MN2PR08CA0012.outlook.office365.com
 (2603:10b6:208:239::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 12:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:51:04 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:51:03 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Arvind
 Yadav" <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: fix doorbell regression
Date: Mon, 29 Apr 2024 14:50:38 +0200
Message-ID: <20240429125038.1308-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef35993-8536-484d-0bc6-08dc684b081c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jYr4UddybBOV5UFjdwEpQOn/PszwNKAx8N5RfsKIs4jK8ddxLG5IkNmrkW3X?=
 =?us-ascii?Q?ZEMMfr/SyfToUQWIvcvmj77hlAp37pQiQ/v+QLnVA4+onvsFa8NCtUgxP6OD?=
 =?us-ascii?Q?HK4/z2TaS/kENuG5MeyctekP9+xq85J2K6J9yKRAgp/0p78kmIpdlI2YFREg?=
 =?us-ascii?Q?kMuWKbY/OLKm1M3GXc7OuqvmarypCY5PmZmhQt7TpiI9FyzFkXGEXqRM0HcR?=
 =?us-ascii?Q?ShFUZBm9U3i+Vy10G3nXQjgN9dt/1c6dTuktyZ/7t4g1tFLVCEZiO7slEcb+?=
 =?us-ascii?Q?Ns83J05JoUAD2vghSjYIP+Dv9UlGa7P9/pieeq0CLipwAYY7DKunh1Mmzj/h?=
 =?us-ascii?Q?BWqqt5c5YmED2eSAK9k7ND1DC2EkuDP0UEbWgLPgNGH4cT3mM/Ykajm8QCjr?=
 =?us-ascii?Q?hcgOXntG7FUvfFf2T9z9Yfx0it4pZxA6KUpbMhuSpHPUxjDkwCYFflbRVORC?=
 =?us-ascii?Q?qvNu5QmkAZhiFjaUxEMd1MkBEqdzF/M4a9tZEFwKEfhMfNmZSrwtZVCYWJR+?=
 =?us-ascii?Q?0BagcoB/QLbY5SOreigimcwf5yXDyJ6tJKLVE9eJLRFxV49EquckVMsV3UK4?=
 =?us-ascii?Q?K2L4m4YPYd23n8mld8e8vRLgZlTAWznsV97T+cNrV5UHqUNlBS+xXICB0lpK?=
 =?us-ascii?Q?Lyf9tyP8eQ6+CbYWJ7NwJRKyzPcYaCTdDIG7o+CGs7d+c7qzB+MOD+TgWxxm?=
 =?us-ascii?Q?LGAnL4+VytvQSVjvoGyXsAS2P9lJKx5Hx16dP92wBw8eb/ku2PxY2fCjToSa?=
 =?us-ascii?Q?aSqTM2ZJuYqdX4hFllQ1g7alH8c2z7I6SmiLh0AKaBwoj8vusxFsOXCegK93?=
 =?us-ascii?Q?Mk7waIJI3AW8UIKDY9Lx+8FYfZp8AU+ere5MkDZkp2KSwmm4PZ9KAF68a83N?=
 =?us-ascii?Q?zlFb1EZtSxD/+tIdV9c8KcA2th0c4K6rTNHfm+nHOtOqdw9cmIyu6R8lOr40?=
 =?us-ascii?Q?O2qUY0tKn0xSBMfqBSG5zQfaYOkLuax7NQQNOnSJC5UmQRUchxotxvS2W+gu?=
 =?us-ascii?Q?auybF6Xcqxdv39Jz7wKufotN0dqye3gEJ6EA9D6YTIDiWVLmHoVGs85WhKjo?=
 =?us-ascii?Q?kC9UpF2TDWO9VaPyl4ERZPeA4ir9Q5DRhDrff5DBCDpw7ijPi1qLK7JkiKfg?=
 =?us-ascii?Q?i/TFlii8nNS/pOEzqVWqHBfBTuieJDuBWw3uPVmwkV55hj8b9Y0B5J0QPj+L?=
 =?us-ascii?Q?q8nnVPdN52KD85QuFWKupueI5A9t19zaCFlP59LPVVJJUyIAAwQlV2YhyLnj?=
 =?us-ascii?Q?n5B5VmoEmJJVNMGhBHvh4TbjX1iFx+pIrUCiHrdE1wCdMKwZ3ZMIVDGGO5nn?=
 =?us-ascii?Q?V5+YR8PgAYAckF6NIrrGi5kK9PvK9MRwAxH/2oaFTwER7SzSSHQohtgm18Bp?=
 =?us-ascii?Q?vERI2MsCrLnkprOa6YDSxLHxDxGq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:51:04.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef35993-8536-484d-0bc6-08dc684b081c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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

This patch adds a missed handling of PL domain doorbell while
handling VRAM faults.

Fixes: a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 1d71729e3f6b..c71eeb6a04e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -419,7 +419,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 		return false;
 
 	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
-	    res->mem_type == AMDGPU_PL_PREEMPT)
+	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
 		return true;
 
 	if (res->mem_type != TTM_PL_VRAM)
-- 
2.43.2

