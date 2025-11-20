Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B39FCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3353B10E7C1;
	Thu, 20 Nov 2025 18:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MhOTFuC/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C39010E7C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+wp1wcwADtmbZbpZkjUg/0NU/S04PckCKGl7Ltx886QgtKope3ucToYKqLK9SYF/kvL6T1rgKMc9CHinQ8Padw0YQD8SUfxUHRfSnL04BTkxxW5iKqmgPT944bBaBt5Qq/DPWmhXWc2ZJUMRXCfTU7Jof1yznevhW/FTXRuzPFIRTU94ZACMzdDVopMSoJZw/EU4yEwOUM2cBL34RMIznoAlcVNCHgqBqwwPoqgjUO+946h0HmMt0ai2H9CwoiBX3hNEWrTlLZ3Jt2Ytwf9nBBFE4q4dl3VG+YShsha/SgVXj7kbKcRWnw1BS2TUh+Qm1VIUdGaPfsNvo4qWsJdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlvqFbduzTGBHOKC/FJy7ckaFz/M1d4qOdDuJl3yq1U=;
 b=ZDrqGjKjsk+/dO16gkpWbmexxZicZlm9M17aQqT5U+ujd7A0W1i0RDS3xFhwbjY1dg+ZIXB5GbZ99bKInuph6M7HLIzeQ9JioGp52f9ZaPgoGCS4xN9z5Yq3s1e5keBiOo0JXt8uePSiccadLvibsfH17TH70/XW9NvOBb8w9P9JjjsqM5iD2nh38UDo/h5daQmRqHVT1smKyUVcYch+wlnMfGYKaxSM8e0qm68CjP6l5cg7twkgNfJfrP33QpVII5BdeZVPRfdrRHfRqMOTRDcPBaTOKK4l/GOWa70/ZV4LNrO2RTTHm0t+L9T+Yk8ztDcEwVrRBmq/o+Im1jx45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlvqFbduzTGBHOKC/FJy7ckaFz/M1d4qOdDuJl3yq1U=;
 b=MhOTFuC//sDnk1Lah6b1VCAXdVzQMFoJHk/EB9lLLZpEGnC0D93tB/ChrtQX7wiiO4SYfFZ/UQVXPvbeUAVBmZGxybnZk46cAxNt5cEz6o+kYcVJ2aQY7v9+Y8aVgkfXeaQeT98G7gBlqfFaqK0+m2c+zWdsc+Jim734yR1HgxU=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:22:15 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c0) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:22:13 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:22:07 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 21/26] drm/amd/display: Drop FPU flags from dml21_wrapper.c
Date: Thu, 20 Nov 2025 11:03:17 -0700
Message-ID: <20251120181527.317107-22-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6bb053-e55f-4cc5-9cc4-08de2861ba3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MZS2wkCFaiRlz2JVmZP9cm9ZPqlpOYZ4/r0ZFh1dRjptzYRhThAss/ul63St?=
 =?us-ascii?Q?6x3aAK7R4kAMP2rMDJlaUHixDa5PDYHcUMYNDWqtEV0lqpjxrLtKflgXS+rv?=
 =?us-ascii?Q?kPI5vrqssa4iLVmpKecVOwIw4HV/m+JGkTO6vPPwoXeytAfE2k/O7gZV78OP?=
 =?us-ascii?Q?AH3b0Fp0LHST957uuSXq2EV+cEFAD8GCXFOb83rZmdQfqB4edFsfHoMnAPdk?=
 =?us-ascii?Q?6b1zBiL7Czv/bVHxaGY0fL7TWoMqGy4ibvGz7VN+2Yp/3VRU1EzPIJx98bOq?=
 =?us-ascii?Q?c0NnY9QUWTsLN6uQs2+IphPuOyNdPkRfkrX0HzwS/08TfYSxbX2W27MKzgxL?=
 =?us-ascii?Q?UAtP9Y+t3FyceFUxCubi9P0r17H9ltlLhySJ+hEBHhSXZ6L8itmOhTRYmZnZ?=
 =?us-ascii?Q?+MhigJRy8/tZ/uiVEZyNK9qOUVIZFsJOLw2AdY/V50mai2keV/yk67uHBLrB?=
 =?us-ascii?Q?V+hWe42Kp4M4BSNnUg3GR45ISwqkwNjqDB0qv8nBskQPlJ1MbKeOb8TnKBKT?=
 =?us-ascii?Q?D2wAteYjZRixV0MYz677C49Q+/oBX6MbpGh3mFNu2KRjA+Ax7YbAEBU6DOLK?=
 =?us-ascii?Q?txcVsYX4bhT5wc5vW998WTF0Sh6T8Yr3onXsEWm5jKOm8FvBsP43CZO3VVbD?=
 =?us-ascii?Q?WgpROdBwOoOhkF/aeYA1/gLmy3BkRd6nORUH2f+FW9ETJsoWFeh1MV3Qloyx?=
 =?us-ascii?Q?fepj2KpYmFBR6fPJVyoV3uiO1Ab3oNbvJghnMUOmj0ujVDQ/KU8eLYKbI3zd?=
 =?us-ascii?Q?+oNLNsynRRt/D14F2BEGHELu1Qr3d3qi95slcpcK+VC0SGwIZeD/MaabwE0M?=
 =?us-ascii?Q?TWjVNC5Z0L//30RhtNgcy1EkMwbRC4H2ZpHWkgMnlDhRjdk6cXqHGzhPCZkf?=
 =?us-ascii?Q?9xATBtH2fQZJKZTxdLMCDgoYCGmGEcYEtFQkdBqypgr5LMbWXJfV455eX5Z5?=
 =?us-ascii?Q?CFI9/PhEiFyHigXMKz9tdzFjczxqCP/Odi2Bnh364eVwp5s9CSB6AUiNZKwR?=
 =?us-ascii?Q?8Pdir5t5nYlKBMfQeqCtPpQVP2ZLMk7qXu7jfJL1GviuAc+5KkwQ9UHR9xoP?=
 =?us-ascii?Q?wpDMHRaG8C+D/A64YWub8Ze1Y+L5+QwCfl/wfLyknUry2gqWFJ3CAlbUgtaS?=
 =?us-ascii?Q?Ku98dpyxaSprpV4p7ioaRu29qluNCRELlALxOkfDOGpVC3ZCA920XqxTCu31?=
 =?us-ascii?Q?wn2MScxAFuCfOIUrHbm+tfvN8qIyWJemewdybCQtg8VmOD/6wuWfOnTNe754?=
 =?us-ascii?Q?1pzu0PBroMcwqGQK20oTYjpIlsU+F46eddVTVFDIWgVRDmedLGWfU4OLCvZa?=
 =?us-ascii?Q?FEbLPhnDI9eH6D0ctQCs6DC7FKn9gFN5QNAGV6+ZJInPfTjWKC5glnI6Ekqh?=
 =?us-ascii?Q?29CIULC/tUN1ev3AHRwnMYQqW1jI4jfX7T8RNm93zUdmgq1o/88uHVCnfwWW?=
 =?us-ascii?Q?r6xc3WSQd1VUBKpj1quOXl0hULRgDNFERg3/l+80BxO3aXVwxN9jaVv2hAhq?=
 =?us-ascii?Q?Jf1Xz9KDittIIez5MwwLe/UcduwYpwerMcEMgGpeQq3phMKRbpyDrr1egLyW?=
 =?us-ascii?Q?UzAHxP59wuQGl4MHHeU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:22:13.3935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6bb053-e55f-4cc5-9cc4-08de2861ba3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
The existing CFLAGS_ lines were pointing to a wrong location
for dml21_wrapper.c and were thereby ineffective. This means
dml21_wrapper.c is not an FPU compilation unit. Remove the
(erroneous) CFLAGS_ entries.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 631ea04059a8..30cfc0848792 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -95,7 +95,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dml2_ccfl
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml21_wrapper.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_translation_helper.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_utils.o := $(dml2_ccflags)
 
@@ -113,7 +112,6 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dm
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml21_wrapper.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_translation_helper.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_utils.o := $(dml2_rcflags)
 
-- 
2.43.0

