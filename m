Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C40FC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE2510EADA;
	Thu,  6 Jun 2024 21:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NS8xRg/N";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8E310EAD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGO4pEylg3FvUvKRHsfPR19Jfz8Ysp2Hv3AoPbzJ7GB8FeWdaWlBXdyLV2wsWOoUKcrLzgEosgVNUeqHcRvH/gYN0/1xE6JWfMTAkro8LYiHzz59639Ne/mn/11dskDkl6+YE25hTtrTGl30w233W+hZ1oOtcC7Yy1AAHaEzgFvnLOc0Q/Axg3lXuRP55cvzSUUO3t8vcgnsuCq49xfZp9JFAqmwv1+f8HH0Z9FDI+jGNOoQWhDlXbTzPTU3Kmz37FFpqmme6O85thbOn62v3sSr8ysIubxX9kMXFcvHVSsx+cb77+65tddMkzLlRNjTeRP7HrXOeJeE5egCFXuaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvDnCR5V2lXcbUqPBwk6H8HIm+oR79N9TD1IurkU0co=;
 b=TxLOu1RVabipIaojzhfc9PrSEzQBC4QkroLCK1nMVmuP0xU6PCr+g/bAd6YGOsSFb5TZHRA/RYHQlA1gdQW9Pdvk9J9TFNWu0JLti1VmkiwkW+E6iXagPg+u8R7Fl1HNVofXXInezBoVjJC3e7k2woFDQn8vtRFD0KXV7WfVXgsSSbpDNOTr1DrHH3FVSzW6C+aYaCUvqvbvUOZKg4lZXElYL5xACy1FZ5YCxgrkswCyjwFRvPI1dlc/Fhn+hm3Aqosl9jvrr1ecoMOqRxNPn0t96SYK8Kg2jfmNnuDr4sG8fG4n8DVMvYNJLL3YANZIrxhm1OoHN8jAgZVvC5ME1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvDnCR5V2lXcbUqPBwk6H8HIm+oR79N9TD1IurkU0co=;
 b=NS8xRg/NuIB4LadJ1AmQDR2v1VvFKId+rIQKGEE+Z0368EMyeOMwvW6uiE44rHzeiLLhCQikFExkGDt5YTCE2dJANrLaJbs9sI6xd4d5DQi5JGoboTXNOc3ZbwaUgzakeQsMFSwrDVXXvbGgvxJpVCUa41WCSl8c8Ib1MRqsWR0=
Received: from BLAPR03CA0134.namprd03.prod.outlook.com (2603:10b6:208:32e::19)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:38 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::e9) by BLAPR03CA0134.outlook.office365.com
 (2603:10b6:208:32e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:38 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:36 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 26/67] drm/amd/display: Use the SPDX license identifier for
 dmub_replay files
Date: Thu, 6 Jun 2024 17:55:51 -0400
Message-ID: <20240606215632.4061204-27-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: f51021a0-71b1-456d-8450-08dc8673ae59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k+5CNet1aVIRcufmiDlAURA6hLw7i3jwpVjNHg1h13arFtb3Wxmr2CjZHSdF?=
 =?us-ascii?Q?08K6ynzDg+7xDTJuuPTtTmi2BZaXp2mEU6PW/z/z/T8IYAvGo1ZTiqo6tHRm?=
 =?us-ascii?Q?dK0tlSr76N+f+6phVaxKCZSV6xzlqfYqb59Ummnwk9PkaraTPUeasd03ZbsP?=
 =?us-ascii?Q?isswqiGwFR+Ew1BwlNroY/iaPzJQ1JRmbwNw82l7IVzkFvB+1sy6p5+26vZo?=
 =?us-ascii?Q?wtq4v2z+ai8yyUiwqGg9G308bUzDyLdX/zjmPf0bEi93pTTgU9DXYiUz9Idw?=
 =?us-ascii?Q?bj5SbXwgnBjVGN/zGkznHjrIIboTLlXu7pO8GRhGFQtbBkAWLVyxLOgWP8qK?=
 =?us-ascii?Q?QQSiv/Dep5cGfMg8WZtNbe5AJvZolqxKC3yVyspIV5nCNwfIykozi0A1Xi57?=
 =?us-ascii?Q?QDh5sfNyMVUw1UbE2MYpT91QVP5nG44PGsf7sie9IX8BgFA7ZqaehKanSNwX?=
 =?us-ascii?Q?wESTJQz1swq+NZLCwGgUHbe3nVxWlaBn6M60FLCBFqREYCh/p56ZTsmxvEBl?=
 =?us-ascii?Q?x/pIbNHp1WW+3YGyBst9AwMaOdmIvKmgOfcZa3SMK62qamce3/jr4nkgL+Hk?=
 =?us-ascii?Q?+AeBa3nWfoDY6EwnExWdlFLLo9JKX7pMrTiF+GTRZRN22Yh5pyu5nGwgZiqB?=
 =?us-ascii?Q?UzXfZFrBPFTttqwQ4uxy29sm61Y3fTC278kG+Q8JOdMEgGz41NzyklOwjand?=
 =?us-ascii?Q?X/RxaBQrDn0Dc3Oo4LdrfXLC2SHgNwZc7E3NU0cD7nkRWxTaEZHTBgez6nl6?=
 =?us-ascii?Q?CFYoX297IaDYYyXIiQ9uAgNh7wMllsVMvnd1iOK/sGqpW5EQajKGoOv09w1H?=
 =?us-ascii?Q?kqbdyW2b9KSDQf4w8ITRmvBAE1YojtSLNAacZfB2G/3raEIM3wxlI3nzdF7G?=
 =?us-ascii?Q?ZnwiD/hB54Pzysm7tNRRU+UIDkBq9zBWLoC4goY77x4KVmxv+nd0qPsXjJIR?=
 =?us-ascii?Q?cyEUuP+NdtwC+JAyR9bO39NAehlIIq8tZ2oekH4KcNm+7wxP8J0hZYG6bVW+?=
 =?us-ascii?Q?7+IiC4V99jHqRL17wujAhsQmUrvFFOhJvSIC/sooIkJEI83gqFQmZN8QtaJ9?=
 =?us-ascii?Q?Z/HLBFlEmUMDEx/GVFrvbvXkB+HDYdwDOCqQBU+LHOAZKCqNsH/msOFGtcNB?=
 =?us-ascii?Q?b67iMIyQKVg6PVDl9b9RtVYWLpPGbMJSkWvWsrXdRm5j7/KGHGC4FqgxFXic?=
 =?us-ascii?Q?i3CXjk/zn2x59APoET6+RbSBn5EfwLrV5avhcOEtwwEd01aCE5WJ5z9xrNj2?=
 =?us-ascii?Q?zMbkEw0KwaVABUx3H5tUaDoqXISp+bLZZVYd/TBUwZryB9WGTW/sPbD+RLYi?=
 =?us-ascii?Q?2feoRYV63cVtLi/8dO9lUAxSGDFi7ZdmPjYNOPSvALHXLt8kd1UOXyQZNV8X?=
 =?us-ascii?Q?ALmze8C2iKS3+k/FbsPObl6JIXrjjEMavaP3ZldVm2Ypys1EaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:38.3449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51021a0-71b1-456d-8450-08dc8673ae59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

Use the SPDX format for dmub_replay.c|.h files.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 27 ++---------------
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  | 29 +++----------------
 2 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 62e03fdf813b..5437ebd8bc21 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -1,27 +1,6 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index 63bbb1bb0ad5..9b20df9258bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -1,28 +1,7 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
+ 
 #ifndef _DMUB_REPLAY_H_
 #define _DMUB_REPLAY_H_
 
-- 
2.34.1

