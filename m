Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E45C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F395610F345;
	Fri, 21 Aug 2026 16:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jntohv6I";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD04810F345
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7VnsquetWI0EH1TMRuiUANlLnylhyq7pyWCNzFghwwpigl4jJOvhe7Elu/7Rjyo4EhYWpYLtK7l7hhznEbahifAOgWHrYUirqVaTkpYxIDsWfaWHDNBqQysgRO6SYa7s1yXE6r2qWJecMObA6jb28nuFBXeMDodvzZylP7rc3CtavGOsUVYyp/6A+K31qtteLdB82p6FdnRy0YEVwcwc6HlWW+GtoHB7f6I6iFwpGVTbnWtRWqv4IXqdtQRFrGkEyRYaNFPjcaM7jOr/Cj9Eci542IG1SMoMCkYpfyfWKY1lFpBs4H4CEEUAF4GgKpzRU0aiSnwVq8XwKR3WgJkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9T3gxoyumLpB9JeV7L0O5a2Pg/V0fmQw4B5V8PJXrw=;
 b=RPTdYhjj16TbTcv/Tvj5SHV8UfakfgHI1OqNYLkcoLVtm4fLfBiKbYYWObs+yDq0gSPzlFkrMyNREK7faVDo4mPXcz8A8E32bgFCt/vR2pshe7EDt3/A3QgFiHWt9HXQWS6aUKknH+qF2o2wSJ5W0I2XdG78lX+GGLQeo1vrC7Niz12+H4g0m0STq+LxdlIcD3ndCfwgnsxTz3CN6CXw+Tk3n11N9rSzfz4BWQbdvp3X6ySIBc6Y/I8hqr+WGpjsJ7Kq9ezyxq6Wbx4Ya7sEa2/Pmkhwf59Rhf0IzcpvBSOyhfDBMCj5CfKsOoqVIP3FSF0jAqtmBNHkeELptOTEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9T3gxoyumLpB9JeV7L0O5a2Pg/V0fmQw4B5V8PJXrw=;
 b=Jntohv6ITW+dJ+KePhEiVqV/ypur/UFajq53P72vdpXT19KvdVmDvukrwlZz2YoWhfyDBBCnlMXcuOVtDwSezpxKmxOzpwz7x2q1Uaazqy2seZNl0NDrt/5drgK5O7QkwJ9Dud7xhqtBEWSy2DGWKjdoXGU+U9KcQq/vzbv4xTY=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:05:50 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4c) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jinzhou Su
 <jinzhou.su@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: Correct GFX_IMU_PARTITION_SWITCH value for gc
 12_1
Date: Fri, 21 Aug 2026 12:05:36 -0400
Message-ID: <20260821160541.752029-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160541.752029-1-alexander.deucher@amd.com>
References: <20260821160541.752029-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: d00ff798-e8e5-43ad-21ae-08deff9e1124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5l/IAYn8N8VX/aa+wE/CcLScPR73sWas0PPZXkgsfF3CaN2F6yvmU5RCP8xtTegwQez1Lrbu8lmiGfgtpB42HSgHiU/qZQq4i8YnSE9g4BG7bzjEQUhnQlipmPBo72IYtvLMMNjsfbJP9DFbEASipF/4gb1/rdDmSY0YW0Lj0sZy9CRrJ8tFd1bTcpevGp/oyQ3to4Ga6KHtsSbX2xohxhLNxsHOO2wWst6D2wR8H6fORwQaEsmvMoptEWg9nvMRCaLqMqN63lNFSYfT2hnaoHERNhMCBk7PeWsxEmMDEHbbsTQ0NUN+xtzra5yxX6RCnHCoCRbtOYYCIp6wldwH/SWSMG4GMr3LJNLbZSdFpD2AVrs0udz1KvjRNwJ6VY4pqaEXkHJkyPZotaGAAuVilQmXlSmKlTP747OvPCGQaBEdkXzm8HLIntUZK/RbW1IJNmA22KICVpqijkzM72Ndt7AQyltsHr2XHPXPcL3ngMK3HYo7sWQibtjqVmUYYA44LEpRv2nKxl9hYSkmVI2WApc5dxU15oQvRbaVVDLCL53FXt4kFnw+pw0FId2HRyrsldX443tGEjDlXwR29a0kSntMFY4EaQe4b2zWQEhJ4X2eQyGVIQ7nJT1dh1KJYNh5Gi9HCNhVJWHwopqTS8NnZ5KPfvGRlOIdjvwArE1rcaZ7t8Ix0eilej4jtzih9PklIR0kXDVdyaFtEbDGNwKXng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jEoqZ5l43GW0jJQDTbI2J9CuK7ZSWLtdvnoQOCnUJmpSWwk1SxXokbaVxbAZij0VLm/wMtHXejR+ydqFJ8/wUtpuBJ+szcRY2STZgz+vD7R4AAG85pchBmHsPHdnbXMMwWmeXzn9aWGMw99wG4liA13DYecyjbRrvrp4tKZXHl2M3eZ40jdCUb4730xdI975fLgWp4g1NiFWvKDngkXhk9LNbCjdDgH6oIpmW4SYnjfSsC8676+jnud3K0jVTAwmRqD0PF4w0ZHdRnpVMI8fDS2iTKfuNfXt6Ti8GHqOJDUOxry8XdkFOPkLYvRqeyZO5r1YTu7Gei5TPuoADadU3xLFjaYGQyr66+uDsdtbcAx+4hs1QLYsU4CFHodm/2jWqYS18rD5jDXnwXcmPy9GUj14jbs/BF9ri5GCTT1ImZbV7tpAQ7uAaDGa7f2/TR3x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:48.9338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d00ff798-e8e5-43ad-21ae-08deff9e1124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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

From: Likun Gao <Likun.Gao@amd.com>

Correct regGFX_IMU_PARTITION_SWITCH value to suitable for harvest
situation for gfx v12.1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Jinzhou Su <jinzhou.su@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index ed9c5b3f76b6a..71e35e16b683f 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -149,7 +149,7 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 					      int compute_partition_mode)
 {
 	int ret, i, num_xcc;
-	u32 tmp = 0;
+	u32 tmp = 0, physical_xcc_mask = 0;
 
 	if (adev->psp.funcs) {
 		ret = psp_spatial_partition(&adev->psp, compute_partition_mode);
@@ -176,7 +176,14 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 			return -EINVAL;
 		}
 
-		for (i = 0; i < num_xcc; i++) {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+		for(i = 0; i < num_xcc; i++) {
+			if (i % num_xccs_per_xcp == 0) {
+				physical_xcc_mask =
+					adev->gfx.xcc_mask &
+					(GENMASK(GET_INST(GC, i + num_xccs_per_xcp - 1),
+						 GET_INST(GC, i)));
+			}
 			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
 					    PARTITION_MODE, compute_partition_mode);
 			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
@@ -184,9 +191,8 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
 					    VIRTUAL_XCC_ID, i % num_xccs_per_xcp);
 			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
-					    PHYSICAL_XCC_MASK, adev->gfx.xcc_mask);
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGFX_IMU_PARTITION_SWITCH, tmp);
+					    PHYSICAL_XCC_MASK, physical_xcc_mask);
+			WREG32_SOC15(GC, GET_INST(GC, i), regGFX_IMU_PARTITION_SWITCH, tmp);
 		}
 		ret = 0;
 	}
-- 
2.55.0

