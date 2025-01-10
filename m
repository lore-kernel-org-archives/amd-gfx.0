Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA1DE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 20:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0830410E524;
	Fri, 10 Jan 2025 20:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZyA9m40";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7029410E524
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 20:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cu82vgVYDpVxUU6K6lPKLknZsgyL/VGUFYeqwJzPCzERwRfPIndDISQiJHQBqi7gguQ+Sl4b+dGwHVYAidzOAq3CrFammyhULa1m4HY2tvVJ+Q+vi3LsydovBkFWOWQJBnfOxt0fOVrKLP+XcNDO/B5d47J43nnjs/3xolgZ+JY+QSoejieVhGgmuPdsmoIedS8FwPGjHenmwRkBN3/mnIMjJGWcRruxmkc28J+k8AVanCCEngSg4munynJDZj9qqKUD9CwRryDN8hc6wGWE2+p4Op/bLOgMEQ9+gy6tcotyST0w642mlTg8w9EcJyGJnt4Z1hoKpS0Yom6Qw6X1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJgUSCIK7AK11mWdpvUAEY9vQAsvrQ2By5iecs/dSPA=;
 b=cibP6p7RJrxpOK5Z3fQ6+KW+Oucyd5ZTtBAvztNduFkt+T8XzcE7YW5R1rWuETLlP5wA6v4pAJ7uxZiiRpghwwfoTuB0a06psWSVEqgVow7xbLH6g7ncJLA4YaKA89l2rRa7DswK9nJgOUiVqupOgu/WDqs2ExvlQ2pDS3u+/6eMH6agZfT9CAQmJ7eBnaOreWO2iJVIK0uOtlbj3QU6BR7s02QltAvmx4JOFZsFJr0xsu2+hZ7GTAijo9NuPxxNCtIN/DDZj/eBzUMHbjQj78uvM+zru7g9Izbf+/0pm90o0AQBJ3ug6PTuc3IbEPJM6/YftapKEqnRY2YnSGqXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJgUSCIK7AK11mWdpvUAEY9vQAsvrQ2By5iecs/dSPA=;
 b=JZyA9m40vzVxp8iAP35ZnEZLMdpVUZB0u4HTVblIiDc8KtHoeG8Ibx7gNmNng29JoDomg6kuPZiQ/uRYR+ogmj6vbhXUXNWp7v+4cfIe8Wd0JSbBmuHWxO1tFp1GoHDhasTfgb4nxNLk0pa5uiMYVPo2NK9XyMfpq3yjq5HnUdk=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 20:11:45 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::b5) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.7 via Frontend Transport; Fri,
 10 Jan 2025 20:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:11:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 14:11:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enlarge the VBIOS binary size limit
Date: Fri, 10 Jan 2025 15:11:29 -0500
Message-ID: <20250110201129.3826731-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 10aa2b32-7b42-4a53-86a5-08dd31b30137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwL1HQsU8muHld9QXm46bZpUjjkcwK8o4FhZb9rCbi3AcBiZbUAPMcAyTCg0?=
 =?us-ascii?Q?YbODzxozFeb2B2e0s9zDqjI89ZZEOEBCO/RC7wAeP4d9OYSgNmI82u7Uxq6t?=
 =?us-ascii?Q?vSjGE0GiD+RIeS1faGWqp2SOVhxPQx4Ce68XxnBeadES/6xMTnmrptFthF1i?=
 =?us-ascii?Q?bXXkaa48ixwzxRZaOjJu7fd2bHVAxV9iPDOdo/wAC1wglNjMZECs8e8KdyES?=
 =?us-ascii?Q?bozuk3IlHd4EhwRz3+e/8ZPYyx9ggJbTuUyRCQdzDDdvnvjYij16WxDqTU4t?=
 =?us-ascii?Q?ql8Z963IwgdwWG/KGE3IPBlAW9S9wBecLYwjh4VYpVMmJpzFFjCWygIYsSjf?=
 =?us-ascii?Q?ru15G03OGKdbnQN5JDRYmANVENKgnsYqoRom8GW7qVWwAuBV715odTNwh9Al?=
 =?us-ascii?Q?7PGmJ+D0kUvgcTAUNaxsiO7OhABT2JstGaFuS3l8V5ncQGERTLLM40/qDLs2?=
 =?us-ascii?Q?W0uk1IILl+RSRSITqjxZzCpkFBi0izrCHWRC41wI3UqZxs2RhynxB3ayu5nA?=
 =?us-ascii?Q?0vvQ8nIm5GscAFpCi2xlxJJtIAQZH8t2nlJekPS/ZohQqH5E0GZJwJLHLwOV?=
 =?us-ascii?Q?9+rdz50rnhEn7Oi9wrTV4YiDmY6Je5MO4+UUpKBNQ8QYaubY7ppGwMg+cHoM?=
 =?us-ascii?Q?DQziMxJHqY8qsbrRgSISYq+6cCgUf/S5y69+UQpUGuqi5sfyk9sF8+BOxTzZ?=
 =?us-ascii?Q?KqGL5NskN9TtbszNNI0ThS9uwJ/LxiGfKwYmDnNhQtGq4v3Hyr9vnUmyKO/0?=
 =?us-ascii?Q?EFF9c6aZcWLVFKKn9+z05Y2yf7t1TXBGTzH0GJgF2dMztPqOcwBSnxj0HVV2?=
 =?us-ascii?Q?Y72nLU4TCO1nY88fcv1gpgnWZYHkj9I3OcemR/9jpVygNMX0z4LhHldqyqMW?=
 =?us-ascii?Q?1P/cn5ivBpiGOUw8a+Ino1SvdeMiAnADGgw4zWmD63yYMQkNu4OpF0rCYWa+?=
 =?us-ascii?Q?qGZaBSP6Ydusr5ekseW3V1CZ1EeMq/Iiks4dkWSZIJp8vO1oUWkpO1+eIPHD?=
 =?us-ascii?Q?m86XmUwobNfPrR5//Zf1vZyUSKEWaLwYUJWvxOYB1uwKfQYaWBgISdN99AoH?=
 =?us-ascii?Q?Jv0xZI2C7mohFH80JGZQ0t3xJUCMDbLtIdF/M6BYeI3wl9ewU0FIkV1PFTT1?=
 =?us-ascii?Q?/aQSC2hr/+GyrvKHN2zS9K2QJHRSRRyIIj++713c2UrQTm3NEmL3uv87NCtU?=
 =?us-ascii?Q?iotIL6MW1WpWlxtm5c8acQWnE8jwWi/eBaq9DlokwDQXFYhzXc8d6QSVnDWX?=
 =?us-ascii?Q?yk/EsMjhTX+MiXwekwREBNjyDxbPL+UOqMquPE8DksL3239R8hwnCHIXuu4+?=
 =?us-ascii?Q?CBZUiPhdTZSVsovj+7nFfsXMBTBPBS9626M8xAThqjgeaZuFbcG/VjWhkl4R?=
 =?us-ascii?Q?vHnBspeAKBvbeT2cb1WY6zXN0ctYVml1mzqMPoX5Mv8Bm6Qygv6CMDKGfZ/X?=
 =?us-ascii?Q?bLfQ6eM8GlYJoGwC393lfbxR0+LJtqyy42Ed5S1DCp9jIrZ3XpIPLp9RwTbp?=
 =?us-ascii?Q?kxw+Y++j3lyMNPc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:11:44.4082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aa2b32-7b42-4a53-86a5-08dd31b30137
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Some chips have a larger VBIOS file so raise the size limit to support
the flashing tool.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a441dffca45b1..d237d46088bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -44,7 +44,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
-- 
2.47.1

