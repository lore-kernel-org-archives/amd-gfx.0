Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D9C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31D7112D23;
	Wed,  1 May 2024 07:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qMas5A3o";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CAD112C81
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrX9R74nV4yBen+70nzv/wW3bAwEsjc8SV6d3RVXJOVmWiC15xxmjUoJ1VEc7P2D6hzPmjWjYm9lRC/REf9J8j7RPNP17w8E+WrcSRMUJHB2NGNFzSEm6CEr0kd66/01G5alL3O5CrrfPTlQ6KfePt6KpXoCRFuxofSRCJR5hvOUmJqODklGqkzFG137Ghq8iiAIeYSFjAOoR5Zw7qaDVvUGMAKQDUx/gtizxLQAcy/JgYHuKC2ucCf2YyQrLcHADafkbvC8dyLBDDDeWSQcB2re734eZkR9334KucS38kwuYjFoNjiqqgnUAX4LQ1CO0MB6ty16isWF/F5Xhk37fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWS31NJdyPNGii+8iU9anqRCnoq3Twe9uME6tPd3F78=;
 b=mrfEkNss5nG3eKEe1xr+nXxBj9nnrgk65V38O2yU35iefvhpHJo9qNn29q1uwZoV5tE76hBmP7AP8FeFdOS1VSZdbHv4NlJZ/+6eIlKlFGAtAYOVW/1jB1LiedDB3vFzX91/7CSZBTOcq1spMMy2k115G9on18ezYEwsGy4FWwfq2tOQ5J3uLLBlk3iGuu5KZ0vYQt5tBWmMGnziLClg4L4U0PzuzL3YeS+X7axLw5a2CR0xlk5qI0SYMF4YWTqqW3pNSi4IprwQzf/wPGBfJlbBPXer1cqejGI315KFGq1vgnNlr1IXEL3p3tu/5Svz/xVTrpjLb8u8YGlo5yrMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWS31NJdyPNGii+8iU9anqRCnoq3Twe9uME6tPd3F78=;
 b=qMas5A3owf9XGJUNfgzWD8f3ej9uAeRi8cdLLF8d6vQFsgvl/cMuhsS38QlKUvObGgzCviGt4waoythmbTP+2UjxsLS+eB7yv8OTN1QJMykCW/snM/kFq56c1oF90T+RD0+UJ18G+PiPpRK32ccSr1zIXzNOQKzVlAgqwcvgMvU=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:17:01 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::54) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 07:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:00 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:16:57 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Leo Ma <hanghong.ma@amd.com>
Subject: [PATCH 01/45] drm/amd/display: Fix invalid Copyright notice
Date: Wed, 1 May 2024 15:16:07 +0800
Message-ID: <20240501071651.3541919-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: f69f64fa-81ec-406e-eab1-08dc69aeb226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUZjcjB1bmduc3MwOVBLQkxPWEVDZnY2SzB0OUpycXNuUXlid2Y1aXpScloy?=
 =?utf-8?B?VDdJb1hpNWk1S2FvekIrV08xUTZJNm0rSzRwSkdjZGVib3JuNENKdGJzdHJD?=
 =?utf-8?B?ZlNUM1RMUUs1ZWxlSGRlUHB2cnp2Ni9RNEdsYmxRQnR6VStFNUlEajdVWlpK?=
 =?utf-8?B?OTk5d1lQM29jOTZka01VZ0RHYkVYZ010dDhFSmM0b1FrZjdnUXh3cWhNYStt?=
 =?utf-8?B?eEhTclh6OWpzeWdNUkh0WXZiNmo3L3I2TS8zS0RzK1VNb2Q1ZytpelA2NURi?=
 =?utf-8?B?MTdUUjlmM1lWbGNTbU9sd3hQSXcySG1FQnJCUjB5ZXkvaUVQcllNcGdRYnU2?=
 =?utf-8?B?SUFzeEs2ZHZvS1EzUnVWSDdtZWwxNVhXWnpDRG1wYVMxTUpuNU5ubzNwdmhN?=
 =?utf-8?B?WVVSRVIvc1NKMmgxcXFidSsyc05LMnF1RDlwL0RsWWFFdmlZM2UwRThwdE90?=
 =?utf-8?B?ZGdXL08xT3hyUWpDeERuS3V6N1JmWEFzb3hrcWNQUUtpMkJLbUNqMi9MYzFp?=
 =?utf-8?B?V0JrUjZ1ZWxDSFpSeUl5bUptTllKVmgzM3kyWm5JUWIya1UvdzZtTWtxK3dI?=
 =?utf-8?B?WXoxcWRRUXVEYUpDdlBMMTJLUHhiaUpOZkwrYnhrR05mbEtHVU9JWnNaVWh2?=
 =?utf-8?B?amxQR0VoZmtlZjVZd2RjeUVQQVNkRkgvY0piay9JSVA1S1NVYmNNeEtib1Zl?=
 =?utf-8?B?aGtWS2hFdzE3YnV5dkp5Q0dWMENyYlF4R0JDRGtoV3lvbENkU0ZjUlYrUzRX?=
 =?utf-8?B?bWZkUjZObzd1cDJneXhNd05QVjBkSTR1bjNLZmsxSnc1eE9DRGRmK1BWdUdL?=
 =?utf-8?B?QUYramY2MVc1NFYyZG8vT1lGamltVkV0UW1VbjI2VlExSjlGa1ZDS1p4S2FN?=
 =?utf-8?B?MWhrSFFKTEZGVGlESzdHYlV0a2JjMERWVjhzNXVpRDVtTStYZlI5MUx4MnMw?=
 =?utf-8?B?WjdYTDU0WFkzN1dQL2t2Q3BIZG9mWktQZmVYUm5ZSVFObmxxNXozMGNsSFNM?=
 =?utf-8?B?TTkwT2I2aW4vb2VlMmxkbDlnNkJWMHBXRTMyVzJWcE9LL1JVZ0FiSUJyY0tE?=
 =?utf-8?B?SWtIdVJZWnFOMkcyK3dWcEpiRGJ5SkNobENmNmVtQVA1NEhuSlRCYTRFUzVk?=
 =?utf-8?B?dHRYZG4vUDdaTStuUjhKRFlvbFZ3bmRLQUFBVVhhbERTZmNGRE9RWVVWKzZp?=
 =?utf-8?B?MGlKTDB5UUFkYXhRajVVRGFFRS9RQUU3VEdNRFBEQW5LeGU3bkNSbGhOTG1P?=
 =?utf-8?B?UXdOaTl6L3RBWElhcFdNeDk2Y1BEMDdjMjBkUWJJNjlDYWE2RExyUHAvWVg5?=
 =?utf-8?B?Z1lsZy80ZmJaR0Vjell2Nm5mbmF0OW1uZ0RmMWxyUnM4L1pJNFRIeGZIeGNl?=
 =?utf-8?B?ZjYySnB6cm9GSVRyZisrWXlSb3c3WTI3RFl4dnE0SzMzVGpFL0Z0K09RcXdC?=
 =?utf-8?B?TmFXNXp0WjFzMk9qUkM0V2F0QktQdVp5eEtsaHR6eldWMWhKanBJR3I2bjVh?=
 =?utf-8?B?NTVNUDRoeVpPQTJSV29ZZnNNWlBhbnQxK0E5cVpZamRXbFFaN1EwU2NHemJC?=
 =?utf-8?B?TWpueWtnelExQWZLWmx3YXYxQ2hkR2VTT2xTek1PQzB3dXArK2VZSS9aaWxs?=
 =?utf-8?B?cnQvUFdNTkwycDZzeXFkSGtUOGF2cmFqMldWRUZoT3c2dDJGMHpQNk0wQStV?=
 =?utf-8?B?Z0swSFRreFNvTnNEdzJuNURrVkxvamZqRlVqZjVWUHRuU00xZTF1OHc4MGlN?=
 =?utf-8?B?bzFuWGdjVDBBNVpqM1NTeXVHNE1WM21GZVN2YmRHS0NrYm5GNDB0S3dYWFBk?=
 =?utf-8?B?YytyaVJEWE8zYnVXRVNhbTFncThXUUNBdXQ2L09SaDRScmJQRWJzdG9ZLzQ3?=
 =?utf-8?Q?ZEOQoRIg/N+JK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:01.3263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69f64fa-81ec-406e-eab1-08dc69aeb226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877
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

From: Leo Ma <hanghong.ma@amd.com>

[Why && How]
Copyright notice failed in the Palamida scan and make changes to
align with our guidelines.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig                           | 2 ++
 .../drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h  | 2 +-
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h  | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile                 | 3 +--
 drivers/gpu/drm/amd/display/dc/dcn201/Makefile                | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile                 | 3 +--
 drivers/gpu/drm/amd/display/dc/dsc/Makefile                   | 3 +--
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 901d1961b739..dfd48701a25b 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: MIT
+# Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
+
 menu "Display Engine Configuration"
 	depends on DRM && DRM_AMDGPU
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
index 61bb1d86182e..1bfd6f66f035 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: MIT
-// This is a stripped-down version of the smu11_driver_if.h file for the relevant DAL interfaces.
+/* Copyright © 2022-2024 Advanced Micro Devices, Inc. All rights reserved. */
 
 #define SMU11_DRIVER_IF_VERSION 0x40
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
index d3d5a8caccf8..8d54865bbd5d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: MIT
-// This is a stripped-down version of the smu13_driver_if.h file for the relevant DAL interfaces.
+/* Copyright © 2022-2024 Advanced Micro Devices, Inc. All rights reserved. */
 
 #define SMU13_DRIVER_IF_VERSION  0x18
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 6e5b7fcf8dbd..c78f3b0ff4fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: MIT
-#
-# Makefile for DCN.
+# Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
 DCN20 = dcn20_hubp.o \
 		dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index c5716ea5886a..ba688bce4951 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: MIT
-#
-# Makefile for DCN.
+# Copyright © 2021-2024 Advanced Micro Devices, Inc. All rights reserved.
+
 DCN201 = dcn201_mpc.o dcn201_hubp.o dcn201_opp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index b0803403fe23..81d565d84ff0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: MIT
-#
-# Makefile for DCN21.
+# Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
 DCN21 = dcn21_hubp.o \
 	 dcn21_link_encoder.o dcn21_dccg.o
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 026af72ca2c6..66ea5f104019 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: MIT
-#
-# Makefile for the 'dsc' sub-component of DAL.
+# Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
-- 
2.34.1

