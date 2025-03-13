Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78484C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 21:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0138D10E954;
	Thu, 13 Mar 2025 21:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0Vt5y/i";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E2010E940
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 21:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdKWrct/Bv1/6XFHS0MFW/NpL41aefW6OKTZEbsqgBxjm7FYpf+mA+O/DUfGMR/z8u57BvNDtc5rYRUxbz2N3KD6SNgMsgNaXbR7a7cAKEBTn00ZUJQ24sRD57kFbhNPlGI4dIxZnLn9iHqaVTlwZ57vpjCTlLyRSRueWtw8PNcndVopydR4cixLqaEYhOTjB2ptxZFx+w9L+dG/XUqaXwfsxux4B29WJ/boVZC03ZVTQ37/nRvDIWUo6rZlQAwK0OO+2TdWk3ejcJI1ze7MmdpnAqE2i3lDCDxUvmqB8oZ8M0Dy/KXAAN8Mu4MCZvDk06V+13nyxG86oRHcUeXKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT1z9RPo3QPJkAvqLjIcLHf8FGkHpDcR/ug64NheXhA=;
 b=o3FvOecmvOds2q62UtbipbGk0zf0SqSaQlhSox1j4M7QGxjFfoDvNiPdaMKmrSKSi8lgm/kZQzkJr7/rUWw4gLK7oSjE00UVoWZhQbhLjmCP2ZKAQbMn+I/7X7tI7o5cAUkYhNPPIWeKqhyh/KOzMTPdX9GeRdbhaSqIxtVVaRY0kx3Uz1Wq4XClPl4JKkGtmFww0bgwjgGW2t7T/f/7VkPw18TVsd45kj2FM5LSuut8sBvIXWu26SgYbrNGd+CDETK3JQYPtyXOJEphOf7i1EDMi17gO5dLkuuH39spwebDaiMyjflEUUVez9bt5zMoeqtDYi81D2upVuJIHe24IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT1z9RPo3QPJkAvqLjIcLHf8FGkHpDcR/ug64NheXhA=;
 b=d0Vt5y/i13jjvduZWb/sxnNazK+XD+PxZdyTdAvkf/9daJDqStzxzXrMGhj4xEUUJc/ZFDJOK/vSkjbB/1mRk7xufK305IEMHmb6K4/Ijh9nGZo7gF8pHeAeEHodBTldZsn44KsED9JibAhzDOhSY4ra+w0NFi76RS3yXRxJLNs=
Received: from BN9PR03CA0982.namprd03.prod.outlook.com (2603:10b6:408:109::27)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 21:05:02 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::6b) by BN9PR03CA0982.outlook.office365.com
 (2603:10b6:408:109::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 21:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 21:05:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 16:05:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop drm_firmware_drivers_only()
Date: Thu, 13 Mar 2025 17:04:36 -0400
Message-ID: <20250313210436.1380413-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d40db4-3f2d-4574-6b03-08dd6272b87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E8QhTaWsrcovL5BE98ebTwAzgWSbCMdCpVfcLrz+A86jUi4SerTu8eZ6z3DO?=
 =?us-ascii?Q?WKv374QqHkKpNKwCZKeaIhD3s/nA4cugbky6Uq57AXa2tsdO4beHlIsKBHcv?=
 =?us-ascii?Q?FHHpS2rITUSsKTT5wHWnBbWwK9mvt1il1OE/gJxbrY7tfAuLXKhVVRlXfzvh?=
 =?us-ascii?Q?TfY3zY9cBDmQfciWjpabKcpD3iOT78Ac2lgq5BllJMKEt3t8AS2mDme3jbmN?=
 =?us-ascii?Q?iFmcyjolKjc/C/NS+TnBdKW7hxUqvh5LByrNQRky2UKnLdChSIXr03VqgK5W?=
 =?us-ascii?Q?aHAZAo1VRexYo73jDopRU0wZQBMLlJehKSwN45HVZ1b597uHz62mwJcykPqy?=
 =?us-ascii?Q?20gkVQDNW5f8iPFGt1sMQ6DLwTmy1CF59L5BIFuMtMqC3rm4zIHhV7llcK4b?=
 =?us-ascii?Q?21bT9NhX8VIToaqxfaowQut1ge8t/y2YXIFU5RrIMI34eglKcgd118h/YYXg?=
 =?us-ascii?Q?tVKzqoqg46yMWxPY+COZX6QUMAzBFzplkW3jj9wGEhuE52BSgVlPjgdtPcW4?=
 =?us-ascii?Q?y87G4Ys/U8VuEz6HKWoK4e1riSXHYTolnQY7geoYuv42+aIDkTREpJ7Tx5or?=
 =?us-ascii?Q?L9+yodWRdBrbn8oyhfbOvkecCQJu/Pxgxw1Gr7gWn4B6Cs20y1Z0OdgNd7Uu?=
 =?us-ascii?Q?dsiw+grOZWHrbU5sWFGxuHic2cT6r98kLy69GZfZywrsvKkFBKCO+Kg/vh1O?=
 =?us-ascii?Q?RlMBY0QOXtW3eHgnVgX/2G/d/Z6p19OCnwbJGGKLXgY6uMh+wCDJKnqEMKHZ?=
 =?us-ascii?Q?547QGhDIBBn2RgIJp1AuTdRQm1e6goBF1RljIHD1ahJ9fm9nEZnZgc6tsEcM?=
 =?us-ascii?Q?/bIFToSqxwIEMb8lxq0P1C3OYum/P9B95u7hdnI1rfFGGEGvKnEpVu6gj5gK?=
 =?us-ascii?Q?pF9/Xn/CNDIRjT5n7qsBHaLgGWplOxdHlIjyqnfeFRMesYJkScuTVTu4BnLA?=
 =?us-ascii?Q?022fxY9/WelSzhlKBWr0SR3AFE90UUHMjgwTE4HLs5vdL9IWP9WRodZLWGHN?=
 =?us-ascii?Q?vvKPnQ2M6A3OxB+IOoLBbBKHnthAGtI/aW7pSAnOejRXzYs6YLdu/kIKoq2L?=
 =?us-ascii?Q?jg+okYFYRCQvKgWVt8s28ci/rJ6ubr9dvA3pX8iaoiafQvkkPuHaabFBZ9bH?=
 =?us-ascii?Q?VkbHQx9982wyUSVOhYRPXyxrWDt3xy/zoDwOrsRs2asHHWR9ys6bqMM1ouw3?=
 =?us-ascii?Q?QfdS9i0Z0YdA0y8ISQ39rvNTu17qahOqnSqmIbEN9GQK+nmYcSgPhBejtDpP?=
 =?us-ascii?Q?OdlLn77mHRBP0UesMJDGUSxVEvHYM7Tyyq10WIMq3u2rXDA37SUcVRMTe41a?=
 =?us-ascii?Q?XFcYBHRRTfGiz2mIgc1iEC1S8WWgM+mDfDMxUOWR4dAFkFZKXAHVqqav7AJZ?=
 =?us-ascii?Q?iwuIaE2YDTdDMUyguD194LiFW0TdUFFnqkpHFHz6u+AAstX9F6m8KlDnLkbS?=
 =?us-ascii?Q?7bPmj+d5aNmVBPvptvHbsS0FM2PGib1dHgLJuf8OHUf0be7rw3JLvOjPdkZo?=
 =?us-ascii?Q?BUAXIibNWZKJQ30=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 21:05:01.6834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d40db4-3f2d-4574-6b03-08dd6272b87a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

There are a number of systems and cloud providers out there
that have nomodeset hardcoded in their kernel parameters
to block nouveau for the nvidia driver.  This prevents the
amdgpu driver from loading. Unfortunately the end user cannot
easily change this.  The preferred way to block modules from
loading is to use modprobe.blacklist=<driver>.  That is what
providers should be using to block specific drivers.

Drop the check to allow the driver to load even when nomodeset
is specified on the kernel command line.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3b34fdd105937..dd86661153582 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3022,9 +3022,6 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (drm_firmware_drivers_only())
-		return -EINVAL;
-
 	r = amdgpu_sync_init();
 	if (r)
 		goto error_sync;
-- 
2.48.1

