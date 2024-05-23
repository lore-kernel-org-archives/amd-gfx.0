Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374CCC25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C1B10F2AA;
	Thu, 23 May 2024 19:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WkPgA6bl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FA410F2A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxNsNEQiCrEO5NBKwbjevDOsA1i4SpWcDFxEQ4IdKW2LP6xzufemYGoIddJisCYJeEtna0TfSanUT1B/Y3ZXcl8a4Dl/8okpgV93sGuPmOwF4W5DjhaghSNLGl8djoqCdBuFsKMO109xwrpmjQpFT2aI0f54GdnjCY+YMtm8dOImMbFeSo8fQlU4npuiyTlmH3MMNvCGKmIPJQaWFthWv15GZGh1F1WQKGNu3An1GdiDPKmbceMSh+P1rR2cwjMJ73v4mWB9n/xm3ro8WbcJZpgmIR/tog2c0Rvv7TK9LLIUZx1gyqiwA+QxcbRCqA41dsDU5YSD3u5ROyLO9+0P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzrhtuBuiWFJNABqBrwP7F3V2k+sTmDJp2zuMKWLTY8=;
 b=KJhbWEaHskPmmtT1r/c0LUo1Q358NuRcNYX12yX9k3F2NTxD6mY9K5p9qyclvClMAW8ArDPaaSzjMp6THAzq9LXz/ieskzwquZDWETPCs73VpEbAI2zJ6/GtxwnAJCX5gRQkHnNbwrgsaLF78s6WyU71avyXL+JGiZKN9oRZ1SOaAAeZf965IttXnB7X2nyLuq6ti3qrVZ7Be51nhAm6pKypiWvLi3KMy++l6y54ts0dABSXBsOw1EC7UBor43PUuxGHcPUZONvjBN8UHNrQvOqqOvuzjrvt00pVacL7obVdZZLhNhJv2AhsHoCGFiCqQSv8VCUS1TWx+TQ0eYb8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzrhtuBuiWFJNABqBrwP7F3V2k+sTmDJp2zuMKWLTY8=;
 b=WkPgA6blidhUu5iJ9Wh6aMvLkcIo4RJjlogNx+Z7LxkOPOQt9PPEOMTAJBcTBARzcJCMRdk+zKeTrRDKwhXr9AMrVw2zuRxmnmy0u+o9N43U0hCFBfkoVvh46iKhY2NGt6mt+xIiaBffXZ0WoOpr2v+yD+Qm67iXJ1l2JH/fs94=
Received: from BL0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:207:3c::43)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 19:21:08 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::3a) by BL0PR02CA0030.outlook.office365.com
 (2603:10b6:207:3c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:06 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:01 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Use DCN 410 includes for DCN401
Date: Thu, 23 May 2024 19:20:21 +0000
Message-ID: <20240523192027.50630-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: f3528f7a-c991-4da3-581c-08dc7b5d7f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rvBFGiWRYOkD1/llF5VVMRx4aLd+rd2Hzy9xsAqcx0OIusWfvKZ84Mwhq6KS?=
 =?us-ascii?Q?kmLx7lyH3kC+3WjySxJ26tDgx73DHWmL1gBr+46IMtlMLKbPhXiqJB0XrUwR?=
 =?us-ascii?Q?rEdRxYrQW98wFJE4bcD87WLazZmOVShZY8BUQXLnWawZQm7EsiaeVDGHISpK?=
 =?us-ascii?Q?+D8OjKo9nyKE7fI01F2QjYj45bKbusE4pSH2jrkQG5hOFr+NyX+GUhJjJMjC?=
 =?us-ascii?Q?ECZ6UQSBha+9VL3qovDgV6MdYZa65nY3c6riZtAEefUE7ERq18hUHar3+4RX?=
 =?us-ascii?Q?B0VJIDSOtr4HO0+u4YKLARu49nTOPBF3+kpcWvG3xeyNFYBvqevUxc7v5VSD?=
 =?us-ascii?Q?ObzRHgHNzXhL5Ef7Fw/Cw4IRwI5scJM1S7MsCutSRTfdnyItn6+TtqIUNdvB?=
 =?us-ascii?Q?N/jX4wvFElPxsR/YwKv9syIBY/o4hcVWfTZ8lhfcpOEKxorN7BrDfh5P3mZP?=
 =?us-ascii?Q?fePCVuYuiULFOLxcHdmorV0rjwKEmYd/hvjqcIp/y4ibttahRBmk7gsciZVd?=
 =?us-ascii?Q?q8gigSW5DIDO5bFxW8r8rOgr6UbmU1HHCkMd/Lh4DixExVb9j9TEM5jACaYM?=
 =?us-ascii?Q?1k/Q2/IDzc289LYDkdLAlGNJDHjIQ+C8jgFh1z6lO4voybVEQTzKQMdCF7mO?=
 =?us-ascii?Q?AV0rn7ua2aIyP/aHSDlsR6SzrwNQ0By8CtwYexu34+wDHuOXq/JtwEKSHP5j?=
 =?us-ascii?Q?ZJPXG/OrmA3V9XNPh7nBiO+jRvDqD70LJ45DkRw57oicJpbv5fsROAEqkMqw?=
 =?us-ascii?Q?1ddls0QxSfd+kDVxkeKnJus6pO4fXiwHP2QXf1svfR6eL6+DEFkQvaL1dnD9?=
 =?us-ascii?Q?RvsE5XKKHLSoi9n7YYjQsmEkNKaJoMHfxtBSwRiCR1WTTd9FZcRCG1zpxdzb?=
 =?us-ascii?Q?WhVb833qwRGumY0mAyHl3fvBmmIWz56dNNComce125qb4s8v7HPXeUmeaQkH?=
 =?us-ascii?Q?jbjCH0EBEF4U1JwJap6uEw+rLYptDJlXQWPL7yJd44Ph6E6OeNEF5Ro1Ak06?=
 =?us-ascii?Q?3257ZpOP31ldGJNzUj77Yn0XVoDkF4/PVhV0ZsBJ5/nh5089Y5oXGBp0Mj13?=
 =?us-ascii?Q?umD9j+hC/vOlyKT/CZShDhXBqSyO7L0T07k20i37pdxNLGlcC15X6euGpafi?=
 =?us-ascii?Q?ocqBNNae5Wmk1EIAPuUgIfJBUIkfsT6/fnA51gOQa7k1l0UjhAT2M5HsJnoQ?=
 =?us-ascii?Q?iyZcLW3sb1qeDi9wIDzlyWKPbrathjyKhKLeeq+jJeDTw1iRf3NnUxOc3vzo?=
 =?us-ascii?Q?2396IdiWJ025CbRT/ncV0zQABgTR9/ZSzxMHPS5XzVuzFlVIaGu5rNr6C+yH?=
 =?us-ascii?Q?zhyyBrBKnRuG7oAQ3vkhCePbHWBezYQLQHp3l4YNhXj6Yl5SvtQmjvmZGqW+?=
 =?us-ascii?Q?KiPhniAUijtgSDcpFmlhLNZ0IW+a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:07.4627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3528f7a-c991-4da3-581c-08dc7b5d7f25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
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

DCN401 is using DCN 320 headers, which does not have all the right
registers for DCN401. This commit just replace DCN320 includes with the
one from DCN410.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
index 859d19360e9a..b43c9524b0de 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
@@ -6,8 +6,8 @@
 #include "include/logger_interface.h"
 #include "../dce110/irq_service_dce110.h"
 
-#include "dcn/dcn_3_2_0_offset.h"
-#include "dcn/dcn_3_2_0_sh_mask.h"
+#include "dcn/dcn_4_1_0_offset.h"
+#include "dcn/dcn_4_1_0_sh_mask.h"
 
 #include "irq_service_dcn401.h"
 
-- 
2.39.2

