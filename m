Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC18CCA476
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283A610E6B0;
	Tue,  7 Oct 2025 13:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wk/LeX0R";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629D310E6A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCGxxtEdGh8APji8WoikcUJhJORlymm39VtiQBe8lxgfiQ+Gx+FaX27DWniV3XrBKWuWBdpyCod/KYMD+dQ1+kilcIMfatVTzI8VWx05AHmG7Y3ayIQAKKGCIBWHvA4trBVZf2wq1QUtI9lLtG03o8Od8MAqatUJOgvmiwoiW1PHquYMXXMcgSRQhKaUfYhRRTG9lQAlGHmSlNHMqOsP6TLnwOsKT30H7lu4uclD5UU+YDTBQGk7++9W6KB+21PhYKylQU0PV0titvZij/eDSAQuGmhDubPiNSDQ+0Pumz92JTADsFhlppt3zDCYKTyfPcDeUWlHxePoJVv62zoVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxA4w/zTI9hvpu3IZRmNQ9RF8bgBVRfmNQkMjtwtG1s=;
 b=gP5que66Sfm3qsZ0oCTSR0TLPbJJy0AH8Vt1ywrVLhpllkrIU6YTcXnyN9pwiu93+pTLxhgc4YMQuiZkRFGSYRKEN2qQDmGYOmYdq0p7GcfdUrBe0P0Zl306Gv5c+YddrUPm8YGzbXFeJ3deZ1iuUVQFOWXF1vyzBFcmoHmbZ/cYgzs/TJF3xVrXRvEHUTjZzvmVpg7BppvjMhRS9qGZmw8DrILJHUSLjpR+r1TFUJiv+UwU66lzgLHsMFpbMSpwLsyqQpz2z9NUMo6Yb9OzdepFt+uKVlyCgAcwWgZnyd1ZaGfIXPcZbqFtmhXgj9L1LdRhVyKHSQzVWxezqTf8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxA4w/zTI9hvpu3IZRmNQ9RF8bgBVRfmNQkMjtwtG1s=;
 b=wk/LeX0R7giob2i6hRhNxbkP9yk/J9tn1EZ6btaemjbcHyKqKUkZbDv2IGR7QjWE2IZUFlTnXEd28mFOHU6ygllFpzCAskjPtCQH3RV7MZ2SnSWZ8mHMlF14DBT7xPr6dnFLqSyN9yNISazA+0Pd21pHYh6v5KTlfRawHyq4CB8=
Received: from BLAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:32b::35)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:34:52 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::db) by BLAPR03CA0030.outlook.office365.com
 (2603:10b6:208:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:34:52 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:34:50 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v3 1/5] drm/amd: Remove some unncessary header includes
Date: Tue, 7 Oct 2025 08:34:34 -0500
Message-ID: <20251007133438.39411-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007133438.39411-1-mario.limonciello@amd.com>
References: <20251007133438.39411-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e912d16-e910-4125-5ea0-08de05a64b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QcpxP9BBLUbBzHpbh4qBUMT41ScQPqVHwJjqK1h4bJ7Dd252DuhK0HzvVZ1R?=
 =?us-ascii?Q?loNaaGeLX0F0PjiwrkvpqO5W3ihbFR5Jgk8XtxgVGcLr3Zl1BLaF9XTQ5Ove?=
 =?us-ascii?Q?OvS9sD7bOWXBBI7lzV4zRlB4v+s403idHpMiux0hL1WjlDOcwp2RrFz8Ikda?=
 =?us-ascii?Q?1GAF/xaHaijrrtm/jtU4gbdjnKrKuCQ6wm6Y8+6SE2Zb9hUMWJiumb076Ymb?=
 =?us-ascii?Q?mcaCI9+l/zSoVVulLqr/7rkNP0Miwxeko+Vzgcb2FklXgPyLi/XSCBqyx/e7?=
 =?us-ascii?Q?p0SyQBU4wrfe5J4+SyJv0fpnwWjOzCe435oLzjpD3nQcm1ui307ko2H4im+a?=
 =?us-ascii?Q?M+DxzADVyW/NRsoys6nr8zSAKxmPhzDMILMa24TYqQcj09Kb/2hQWhRvyaMm?=
 =?us-ascii?Q?hD5BeHEsI7B/Kl4Ag23h9djTy8IYGkYITd2G+hkN2oySB+5dEdvfLyaJuVax?=
 =?us-ascii?Q?a/RHtNqWSmA4StkIBmHGyRGl/YnrW1dUVLMEAl3Xw9D9nfaFD9rZzWY2kJmj?=
 =?us-ascii?Q?+WVkM3DqPzzw8oU9S9Ff5fA4QkuJdqlRN4PXoDyeHmxaYOwkeRhvPENhxuip?=
 =?us-ascii?Q?ckz+9EdNgPU96HjepJLtKol5F28qdnytJef9um7kuwt5z7ftiAag9Pom5nEU?=
 =?us-ascii?Q?/I5kk8bS/KyBe2/UwOXsU6FW4f9YUc2b/GoEQwaHd8PRCYutZR2Yue+z4kEa?=
 =?us-ascii?Q?g7t5BzTbRgs0e+X5Smh7L72hMQQ1FemFARGI7R+JOcVLiOryGo7rBnFj3OOc?=
 =?us-ascii?Q?+OV1eu+tLIyOOSxHwD471Xw9Hz1X4wRj8gBo1EJ7dmGc9Ha/uftUqh1in8tf?=
 =?us-ascii?Q?VKt1YRfj28xtUReW0uVmxDLxUimJU57Ac0TDeY6/KrMDDp2tB20gWiV8HNzJ?=
 =?us-ascii?Q?Dgvn+U0cuIq1kGZntXBevSaFw9PzTe6AnGtEIcZG1yH8HoPjeejtY918QXH4?=
 =?us-ascii?Q?qp8cadGiMMPbXozk0LZBAWTXbsDuUYEoHMJds5HfC9v9XqGD2GSEBFNuu3HA?=
 =?us-ascii?Q?v34dhQhgDxsetAp1bYq8oHdDbpwIoPzhaRqahNBIyKph0stcz7LK3/0CXcdS?=
 =?us-ascii?Q?EJ3t4k6nMl9zfVm3MXxMI/3/iJlDzsvnxD+D6DSuNsdl+nZ5Fu6oxwAuNi3C?=
 =?us-ascii?Q?gfHbITw9kxNLGXYX+jPEM/tT+ASlx4tLQs3UweQcPTbs0Ub8yYBmfi7PKl+F?=
 =?us-ascii?Q?KJ2gOz8Tc4b7xnp8ZvMfufZjuOsZrOwLTL1+pWkmCDcKhIq46W99OTmTrASd?=
 =?us-ascii?Q?unh7r4aii20roS8ccd6UzWU4La8v82f8ggIiIvqWSXKLAHyVfyMGYE0J31Q+?=
 =?us-ascii?Q?TKgUHYeAVwNK2kQfeM95MdM0a15f5PpllMe4dqgNW4PbBDVR7GnyKXrk9CJw?=
 =?us-ascii?Q?gMsm8Ji1BXxI+7Ao9hjF4TRKtTiJCXXn12FLaGpXxg68rR2Z1iycU2EOiDVV?=
 =?us-ascii?Q?oW3JZ2gOlKiCLL6KIfWD59qwTbO57FhrNFIxFcMJ3vs1JTnDWKUgTgWahMDg?=
 =?us-ascii?Q?8uLZDllaPQnv/rjg6h+OIYT2WduqQJ83sxjseSbUs69oH5bSEILPwRjpO8Hg?=
 =?us-ascii?Q?EgaGynxi3gKfYak9BYc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:34:52.2506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e912d16-e910-4125-5ea0-08de05a64b85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

Unnecessary headers can slow down the build, drop em.

No intended functional changes.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 554492dfa3c0..fb595a70bbd1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include "pp_debug.h"
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
@@ -28,12 +27,10 @@
 #include <linux/firmware.h>
 #include <linux/reboot.h>
 #include "amd_shared.h"
-#include "amd_powerplay.h"
 #include "power_state.h"
 #include "amdgpu.h"
 #include "hwmgr.h"
 #include "amdgpu_dpm_internal.h"
-#include "amdgpu_display.h"
 
 static const struct amd_pm_funcs pp_dpm_funcs;
 
-- 
2.51.0

