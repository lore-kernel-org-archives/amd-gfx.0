Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37954C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B87D610E6AD;
	Wed, 28 May 2025 17:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PDmrwShK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6C10E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdoXGKEEBWRT7ypwRyyARH2peRv4hdYO2ayCPrsbwYLa86NYOyj2+eSKqD3YLDMVupqSCVcwt7kQM9WSSYNPmuFuyEuJ4q1awxuswfVqi+HvOdyzXh+B/RjNuWf0wN1njIp27S9zmMj1lJkbt/Nm1Exp9JoZ88LfKzLlMLzHoSFHze8sj4CWWAGtbu7LaWHZxi3AfNALJyj58ApZC+erJ5JpvF0ZM8X4XbfU/AwzaPVG4PH2xsZwpm/9jqrdU0iHiaBHorCyUzi8FcTBXk+XPBdfMwNTNNNtRp9t7tT3aKxk/ePN4Q/y9l6gdo4VwZdjydZzQttHwXDdwvEMkJyyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs0sKwpVKNfA7zpf0zO/cG91hGXwWQRsMxZHvzmqmyc=;
 b=g/YrT2v8RuMCn7EcxW1vJ1noauab3yUg7BTg7Xrjoa7e2WvCv6acyLzycO4cEPdqpLVvcXTog+4AN2rFsF/zsnJgULhjhrvHZ1FYejq1ChUhUVpN34iXR5WfYbos9vYppMVsObWo93jiftowCVgUZDJCewTJqMlRZY5R1ku5i4/3q6QGN2m5KKh1iq/gqy8QiijZrM2O7/f0Obge4401TyPDk/ht0qgYItObS7BIWro8hHTr6dIY53lNUzSCKBtbAtqo2v5Ics+UeCsVDYY5UlPL8CxTxJ4sqvit+BgbTaBZe8XtPpYigJFLkOyJe1sR2IcZhVa/2UigLk1T/VYRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs0sKwpVKNfA7zpf0zO/cG91hGXwWQRsMxZHvzmqmyc=;
 b=PDmrwShKxeIcohr081d9Jbi+5+VmKBztuiB3BSx5gVPxJMZ/0iaFKZiFAPd3yOOu+kqcZ4+SGp2vIau1dXLLBa91Do/LpO6UBYkCNXpbxfybFE2L+reVRvUW+B05HEBl4gr3JA5HGgk0vom07wyqTZwr+BnhakZI3fXku9zkB5I=
Received: from BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::16)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 17:28:18 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::3c) by BL1P222CA0011.outlook.office365.com
 (2603:10b6:208:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 28 May 2025 17:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/16] drm/amdgpu/gfx12: enable legacy enforce isolation
Date: Wed, 28 May 2025 13:27:48 -0400
Message-ID: <20250528172801.34424-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 75edbfcc-4cfd-409a-2520-08dd9e0d096e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZltUykAkTbhiTgz2lOpZxvg4faZsBeQ4az4rKLEoiHd0JUtadvXNdmcQpzuY?=
 =?us-ascii?Q?IOug8/dQmMqqP3VFAWVPkmBEs4B0YhiHFrdEKU6v+zy0BpaEJextEonIQaDF?=
 =?us-ascii?Q?77/NHlOLlaZfzPRrdzRAxKCulsYi+UT6KrcamikZi+9+OsMijs66lvqT+ee2?=
 =?us-ascii?Q?lIIBPsVOcEtTw2c8ZUlDkxdTWXeDGvbHqbT1vO/bD70q+n1DDrBHmrnkrB4V?=
 =?us-ascii?Q?8QaYTezapFZTox2busT2Y9YrODKgvRz+tbMU1IBvLWQXa9SLR+uM5JHRIOLm?=
 =?us-ascii?Q?/stJWJbOx556ZOlYsokn+oyxZrYLztAnDJlSJhxYoEuS+yKWmOH6p7ui0bf6?=
 =?us-ascii?Q?MieWtfLdcRlOsdFdDRztw78oisYra6bCsWec/76PdHiqk6n6ZiwjNpS+V1VH?=
 =?us-ascii?Q?OmNXmrwQuerpnpV0q82Nyv5fzbS8ZT+TNYi5reqYbXfvFUK1vv/Dm3YHpRa+?=
 =?us-ascii?Q?0N7IOO/ZLevLt5XgscetDyYFXz6pxb4Qs4jN1WDavMbzd1PxO0NmiV885WXt?=
 =?us-ascii?Q?Z7hA1+l80Ena9+lQvUPhEX2YG0EJ/hoIjB9llQgZSFzbRAfX7ZjwiqsvX84n?=
 =?us-ascii?Q?h3bpZuDCEIIfiwRE/fov43pyYeO1xt0vgWCs+aN+F04+5MZNxfXCoKeZIINn?=
 =?us-ascii?Q?kGuTbUa1yBCoZ+J3Sjj8vSEsNaF9Duqt80nPOA6NnWsrkFN0o4JnEO671xdK?=
 =?us-ascii?Q?KgAWwu9fXJzgmty9CpAT41DI0BgyqKinCQSa6oGLvb/MhF0Rkv9CgvGzSNAX?=
 =?us-ascii?Q?eFE4u2Vtr5hSgU5QhljJYXc2udsQvP9sjyKVm/Dm7YFjb82AlmeMExLSjmIX?=
 =?us-ascii?Q?ig4NShT7yhE65Ll3v6IiyaJ6fYQtyr/PHfkXXyzVusmnlQOsLIbQTfXlayNC?=
 =?us-ascii?Q?1L/WAFI3RENE4JM52ZW7RctRN/SXEiVdeo0arfJLyBBhgq+hUF9vzsIS6Gpe?=
 =?us-ascii?Q?wTSnnf6fInIrFPfZcNYeKrtO9zRnrMONv0ttUArB0uNcYfK257ukS6Kbi1w3?=
 =?us-ascii?Q?3HOC6W3A0ERmVckafYdnxpzKYkjJWQAnWkqx16TkKDvArK3R6z2LJr7icFp9?=
 =?us-ascii?Q?/GTvTqgosI+a63TjPUWRDWPbrSbEXgL5VoTXWw25nXtxGWagFpgf9noONEhv?=
 =?us-ascii?Q?gPuzlUkNbXZK1wIc3NejqJXjOmq7uduucMOG4tGdvzPlbCLplYEBB8v4kI6b?=
 =?us-ascii?Q?cyQCUbfsrFwm0wfr0z2Lfphe6zmYTclE4BHoLNO/jju2TJjD8WXH7TMFmn7m?=
 =?us-ascii?Q?/FVaq5NjhXuEjQ2DiV1fp0KEktvoo0nfNhfSdfjXX8GQqGk/6ZkG/LzJODQS?=
 =?us-ascii?Q?Psabit2TeyEVhTdOww7EVm8j1QS/PnfDQGZgMhRDIO2d8whWodhrjlfnvviu?=
 =?us-ascii?Q?FwWTC3w+0uWRw2YH2u99ECfXDrAmvTMjLBd8NaBhM5iEFJEzlbsnoat6Ej+Y?=
 =?us-ascii?Q?wz9iwQbD9VP+vTnAlkgxjt9oJ/H+i11CSsyjEW6ncZE5m+i52TdR3g6ma2SS?=
 =?us-ascii?Q?RuwY2QhMcy9WXw2YjZkvzOzK1kGYz75ukFZE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:18.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75edbfcc-4cfd-409a-2520-08dd9e0d096e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16d..855aeb7b1a89d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3823,6 +3823,15 @@ static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	switch (amdgpu_user_queue) {
 	case -1:
-- 
2.49.0

