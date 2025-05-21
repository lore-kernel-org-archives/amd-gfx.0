Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0EFC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 03:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F9E10E5BE;
	Wed, 21 May 2025 03:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECYQCsOW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3178E10E5BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 03:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8jG/oIV8GwCAxB1zv08LOmxTtnzAC4IC/jCrHJRGpQhrtHNionkxdXB3VZB1PaJUrJhzK39VxJDgbFc6DzyHGptNN1h68yXuPbgRPNAKLbHa+ZE2eLSA97wvto6jUZ0KIidQThjlEISadd+/NL/vLcCC5oOA3jx2pBE38r6efLSx9osk+0U3BeeRci0gEfbcK1Z9wE0SP0Er8ik2whOAlVmqr83QXOzu18saq8ZxL/J1/M183jNrWHfHePCqtvFX0IYglgWkHqWxzO4WxzaSzodei/2tS1z8dF2ZHWGFTHSDk9VOkIGOuy5+V2/dEAu3THlJt44gd3+bWUwkV2+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iufojUqvhEZnWc/5+9/9JrkO2EOalnOGaS/ZWvKVFBI=;
 b=T7bRMa12KdVev+6c5qznsvr2nf3KjLS6qlZ6hFmWeXDGgz7j1Veg5YBrf6k2ESrOlfsltcjwQthcKzWmIOh2Saic05Ds2DHePIf1UXK+eksn3+7qw7q1ITPn+SPyvtMgBTaU2dFzuipX/Qj2UzYySsRpGHh7npZqUe63fkF7NPS1Jdfqh69lkCQLjnbIOtOfq5rH6ZttJiTTbd3zOSro3w0x7srG6hmPOsMIo4gopvjHH8bn+399luesPNXu8ivPYxlz3OCzC1DaPTvw7EE0Si5kO1KIy0pcbIK1G/ZMSOOfcTGVN8am0QCwWoZS/YIq8CvqaZ7okOBLzaOcadjuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iufojUqvhEZnWc/5+9/9JrkO2EOalnOGaS/ZWvKVFBI=;
 b=ECYQCsOWZxjAXKQt2dt/UYYD9WJSwJa41kjx6RbYJ901kLAKjL0SK2T41uQCdI43q4fYatkPbYNJaFwWyYROG172w8Q9jPqzSWq4WxyZlvK1AGhK8gHXA7oBbKQgpLhmPX9cEUxA1ETIE6sv0KfYi9WTlnkSSZIFeXYZgJ3Ya0I=
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 03:56:58 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::ad) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 03:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 03:56:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 May
 2025 22:56:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 May
 2025 22:56:56 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 20 May 2025 22:56:56 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/ttm: Should to return the evict error
Date: Wed, 21 May 2025 11:56:54 +0800
Message-ID: <20250521035654.17581-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa67a50-1bd6-48d9-b559-08dd981b8867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+YNS3bmR2xk1LbCxl+UVpBEHLiO8w8A5P3FiK5qA4iUxrohZQfVJkbcqhY4?=
 =?us-ascii?Q?SjV+v9CnrSTlyZGdPDqcvdVqx4a5baRNUCaNExg689LxjUyyVvwrk14qQwqu?=
 =?us-ascii?Q?BOPS3axYGKfRKq1xYN2P0Zz6Ex9HA+6i4sfe9XTSJTE3AsDZU880hcW51UAp?=
 =?us-ascii?Q?4C3Y32uAxhVoAIEGNz11hRRENDTzXyORBUMgdO65Dctxeu/lKilAzwIpHHNg?=
 =?us-ascii?Q?vioUsFUFoGfOWT4uF5cymgLdQZBld9RFrJY26nxcuiDc9WoyNK2V5PAE/XUK?=
 =?us-ascii?Q?szmNifLe2hwOy9lhy9jDH+OVY910PqlGN7w51Fj+HCQ5SlM7vir+9VDYCYMa?=
 =?us-ascii?Q?oMd5HmL0FgdhELZ4I5R2Jx2gXR6Eb/Ey2H4PQ/uHFbd3AV70HvhvDwCUPUO0?=
 =?us-ascii?Q?rskex7rdHimTUMw+vN83LnNoe4czbwlYrnmKLhhffAIneysNwsKi5BTS7Fxg?=
 =?us-ascii?Q?UTk2Ak76Ya2y8sewuUbzFNF+S79evx3C32bfDUN3dINzgGkQvtoOueldHhH7?=
 =?us-ascii?Q?L0ePwAjhiJbSQxx2XoZkHEXUkn12wQKSFgQqSmIRRyyW+lv7i6szudtqvvDj?=
 =?us-ascii?Q?jCo/Uq/TAQRyHgZoaG9cm5zX4aS1wlcpILxNla5dXiHcIg315fFLe5utf3Vb?=
 =?us-ascii?Q?+nQ2DT1AiJwtpVZ7RxVxAlBQeVDKd4/wieuvBwa05blRvdDq72qgiKQAJFNJ?=
 =?us-ascii?Q?Ex8tIQq3Bw+Bvl7OW0bQi7IBdbNZ2njJkyKAhlEw4XzibsUNca59mj2TFArg?=
 =?us-ascii?Q?9MgEa5JzsC/zuzPNrNI9x+52s3z0faOnNl3QIZPzayGjsIdqX7s5qIrW1TBh?=
 =?us-ascii?Q?TvmNyg4QgodYuKT26Bci1DYS5cauiqTfaB/fKPsaXDEh8o3+j7hZ4dYjPKMg?=
 =?us-ascii?Q?2Tx+8aGVbyp4EDMsBR8dJC3c9ZO1vtYaKZvvC+LqLtL03CNLazEQ2ikHAT97?=
 =?us-ascii?Q?oEKKw8oTwSIwnI6o4ve0TmyGYtBqajZOFwA0RrNsOTGoXdvIi2UPUgtAQju4?=
 =?us-ascii?Q?AdFcO8zCkqoAtmNSNYagoseKkNQdsvO38VT8OxiDN/We28RdW72UPoLtVVLu?=
 =?us-ascii?Q?+ydY6uXeaU2O1oEdffdWaQ30oHt7E+gwv20wgjWVjF1+Ld6OIVy67ki+JwWu?=
 =?us-ascii?Q?O7SN7+DITkSxnXVnWriTgbrGiBB32k4W3QYjeS+0L/dBmUcB+RVDodT9T3id?=
 =?us-ascii?Q?XE9rpsKBmuFzC0wSI276Eow/3WS7upksWHtgXQCLdznZv9gJxUVv1XIfm54m?=
 =?us-ascii?Q?/3BSee0w9rbCIxYyTlHp90UeyntPI7SF95h6RqrNI2Tx9MLpMi0LryJae5L6?=
 =?us-ascii?Q?5WU+f6SRLJsdJ0yebq2oGSVC4y6peJgYDyAL5C4rHBaDOF/ctDutVK59sYFp?=
 =?us-ascii?Q?hO3XjYUiEtQ1DXRxEEZl29KLmhgYxUImZRFJ64NV2R+1irB+UHwUA4o0tcsB?=
 =?us-ascii?Q?Bqgzb5UbrmW8QJZRGKy5UVJcBHCdoAmBc7yj1A6PWXbf86aWlLW25nHS/n02?=
 =?us-ascii?Q?Zld1cZOKoYEBRG5VZy3nUH03Wk79O+FkRwE3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 03:56:57.6071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa67a50-1bd6-48d9-b559-08dd981b8867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
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

For the evict fail case, the evict error should be returned.

v2: Consider ENOENT case.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 097716bd248a..abf104ae9d35 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 		.force_alloc = true
 	};
 	struct dma_fence *fence;
-	int ret;
+	int ret, evict_ret = 0;
 
 	do {
-		ret = ttm_bo_evict_first(bdev, man, &ctx);
+		evict_ret = ttm_bo_evict_first(bdev, man, &ctx);
 		cond_resched();
-	} while (!ret);
+	} while (!evict_ret);
 
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
@@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 			return ret;
 	}
 
-	return 0;
+	return (evict_ret == -ENOENT) ? 0 : evict_ret;
 }
 EXPORT_SYMBOL(ttm_resource_manager_evict_all);
 
-- 
2.34.1

