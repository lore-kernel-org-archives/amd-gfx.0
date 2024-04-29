Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FA8C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58864112CA3;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I11ADQxg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35415112C90
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQu/ZH5NyUy4tZwVOxzDetXUUYnPEMWxg1LfhfnFXcS2al9lRdkbOBwa/TtOyDAWYV07kEUnbn5lJNjTM3RBIkehQ96s6yYxbGI+c4/K2ysBM+sdySIgPSDUZZuj1y2WLxq3xbRZ1AxespZ85oMluK7MDvzsvypQU03esyOyC7tXbErzadfBZZG9vQtXROonrpxEUdeyvckx+4d6BgJJZBQYO2Kc3kH+TqP0SpPjGR61PPZpVycSq0a2iW1mPBcELk2mnpa3ELNBPeMKsLKIdXEQBrPk35ALS3Jhwor+dCjL61sjmsltpK3V6zngjOdVdFXsEjhbWjpRJ/25YoQ+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pzcwUtSDYNHr+mSpHSoOoXQjYO5Xfo6cCnynwvS+lk=;
 b=HR7U7FO1qs3dAqwq0Q62UrNKFbfRxe8ibAjAjdB14UE1h793/RPzJ6Umw3o1/CarlffvV2jhlX2wiouUf7PFupXoxEcuXy3t+BIZANlmRsi25kEVkjf+abpfUesY5Dgy/0brM7DIlsW0pRLXffWF4H/mDN6asnvlndvh742YX9DYosK2+V9zE72RWmQ81sNLVoX9DQessY+9LfCzRj363dCMQ1dA+MQFL7NuBlULj9QmRedITCUOlaaQO1BFR68ySRkT+++adhQZVnhC5fIs/jpm3J8KT27F8zsrl1gKQFL+Fdz47mXkACw+UH9SotsjR2TNQotRI3fKIq+ufaSxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pzcwUtSDYNHr+mSpHSoOoXQjYO5Xfo6cCnynwvS+lk=;
 b=I11ADQxgFqvdZrM27fvJGNOkOuvGGaJIK6r0NGg5lWiP61QX1KKJpRzcpXXJ08HoHHTSsgFP1nBiiVZxBX2Mi31JyliHfROwgVMwHJhX5enQrAvZnziQx+JOOhbCrsRDKq4c/dQ0naWXehioeDvZW/kz78FCujvYoVGGLLLI3dM=
Received: from BYAPR06CA0002.namprd06.prod.outlook.com (2603:10b6:a03:d4::15)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:25 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::33) by BYAPR06CA0002.outlook.office365.com
 (2603:10b6:a03:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 29/31] drm/amdgpu: Switch to smuio func to get gpu clk counter
Date: Mon, 29 Apr 2024 10:33:37 -0400
Message-ID: <20240429143339.3450256-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e850ce7-5ed1-425c-4fe2-08dc685977e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2+bGCpgxBYSrF64bWUhHqWJ6GFJraPLYHKhImn07YiFFxghsKbj6i0RfvYbJ?=
 =?us-ascii?Q?yYAPDr5nYywTVoNaD20zWI/jP8oZvzmEPyUm/UhMOKoVBBJv4uW1G/7FLKWX?=
 =?us-ascii?Q?rk8cV0a2mWPj3vgzRs9g7iovg8fefkBQ6yqWJpOV/GSElXhNj7w3aL9gKKvg?=
 =?us-ascii?Q?50sFzFpA6+iTH7TkWX6yCFJG+9gqw4gDBsxVnXT0CDIHNhCJt8p8aiA3xyK8?=
 =?us-ascii?Q?sEk0/id5PHvIvLuHeFlxB8ZkGjUAx9HOgC4WL497r46pzFUQ4EBNnaj4YRog?=
 =?us-ascii?Q?NBwQdOHTU17K9Zj9Jot+mz2W83vb45yP0lrTe1GpgHAapX4EekIrODKuXOoC?=
 =?us-ascii?Q?iDYf+jBCNTwTNtIEyqtsLf6YiBeb7zWGH0O0PIEus9Pj+bWkL5MKwRTl7M/T?=
 =?us-ascii?Q?KoVKayt26arj4UtzjqNu/hrS88aJP8b+UxQZ/DeQUZ0KbOJH+S7vJWmg0TlB?=
 =?us-ascii?Q?kWpZtI1xwgaJEOkDYcM8KSgzAbaqKXEVtHkN4QkdPxCgxvmFSWnBcJzStEen?=
 =?us-ascii?Q?9VZRewRDCLcUbx+HlM1xYi/6wCAEYMymEf2gB7tA69fQIp5C4eem2ixQ7u3b?=
 =?us-ascii?Q?olsnUw2mJVYDO4EAQWqzry8AndZi/TZ3MGOBSmE/lEbMwY9D9c979tqSqbDb?=
 =?us-ascii?Q?HOsZw2aSY4U7hbMPJjO/b4u+jbeY7ZRDDDGeD/AVV6cd2xgUxX8o3IibWxa+?=
 =?us-ascii?Q?n27HO11InzUTpMg95z/Ze3NDnLqTLpgplcvZVCfmt5deRm9wEVnB/Kj/9z9L?=
 =?us-ascii?Q?me+3C7jtp8kgmBpnh0CFr3oE4PVvmwoqXeE4UN42aDttax8ICKolY0rgwON1?=
 =?us-ascii?Q?7QMS29hOpPT6cYbuH+ePLCSzAD4IXByw9LNBd9ayL6vOqDz7pYb+MfgujflC?=
 =?us-ascii?Q?SJxP7548yICEqL8Jp64qa4d2yJRcOiOb9TuvdbRCgzri4bz04rvijuaY0xrM?=
 =?us-ascii?Q?J0SobOv9texNHiG4dnfT5p+x9iTZPxsHXAkY8N/0ztklowQ1CJNwLliXobBF?=
 =?us-ascii?Q?fgpxXdW2VFy4BVCPGREfj+Tmp/nU0uXDB2SxMtNoJF8BtnECkMFxEWrzdpjZ?=
 =?us-ascii?Q?nq69fMhEMomuWxBUg68zwVqZUXhTM5UvMWYbYxpuhlsxGci/9o8Su4gcw6Fc?=
 =?us-ascii?Q?OUIxXBJYhUDEneHajd2RqT2uxQXGauGsKkMRJdf03d3Wd/kEfbOxgU/QZ9m3?=
 =?us-ascii?Q?wzOSccR+ECmaWeGMuC+NDS8HasXHhvA1JFEtaCgwzlFo1BuEx4XRo5mHxC27?=
 =?us-ascii?Q?rBP3d/fsLevZVWuR13g3YbL21XmqnCvoELoIjLduNYeGpLxWQVAu5sRsqHTJ?=
 =?us-ascii?Q?pcIXxjx8L3DY1FfPpRzO2xRJcke40gAnuf0gVKXEoa06AJQcfQcK6QUaDF4M?=
 =?us-ascii?Q?KUFiT0KM6yVm8MghxdMctWHWNOYI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:25.1387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e850ce7-5ed1-425c-4fe2-08dc685977e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Switch to smuio callback to query gpu clock counter

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 33fe519e617d6..c94ed3b929cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -36,8 +36,6 @@
 
 #include "gc/gc_12_0_0_offset.h"
 #include "gc/gc_12_0_0_sh_mask.h"
-#include "smuio/smuio_14_0_2_offset.h"
-#include "smuio/smuio_14_0_2_sh_mask.h"
 #include "soc24_enum.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
 
@@ -3469,12 +3467,12 @@ static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
-		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
+	if (adev->smuio.funcs &&
+	    adev->smuio.funcs->get_gpu_clock_counter)
+		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);
+	else
+		dev_warn(adev->dev, "query gpu clock counter is not supported\n");
+
 	return clock;
 }
 
-- 
2.44.0

