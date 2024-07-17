Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13F5C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D35E10E3C6;
	Wed, 17 Jul 2024 19:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zfmfZ6AE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A5310E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7aF5iyZgsX+kpzRhA+VqQ4HYa1NtSVaKdODKBCc9IPFq5NLEVftXN3PUVcnsvbznfcNbiGcXMBF5rxrFU7je3o2H0meMkU8lXzOuP5mwGzX9CWtznIc5M2Y+yarNoY5ajiWyL/OwUwPrqFgvnvEF5BVj4o2QN5baBCfhyqcCDj9VdeFUvz28az8ByXgIvOcGvCEWg4WlakgXCc3LUVE7G2Od7ZOALKPAXWAqjNLGLXJg60Ld1JPcZZVlqx33h1rWq2NzcmTFXedAQ3Q8PboagH6idt/7Aj9anU3PavD+iI2rb/lW7a5XPZsQn8n7Jkvwq+mEVdNu7XdEY5ZuHZzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdXW/FXRN4LvXRTz/4UxHzzQMNHLhwHb9FPmTubUkDM=;
 b=mq/IwkkE0yemilIpHm+NllXysq1DByfscYAoWxQ3mn07GRW7EOnOOQDyLYGz0iD0QwQ89DazzPwBZVA8/eYyoO2qSiXHAKkfLwwlMWAaGDlDazuwozhJrDdAjM9epzJUo85kPKap26lgniUgDggYEBXCqutaghobLOP9YP0uq2dCnc/Ytp5K6V37DuljAT2vniFmAC6Mea7T/4Tg5cB6rVhHeG3uz8pI5DehBZvr2XGVCZYStjrw5UvUkiltP2HqOyLw1RiPT8/YOofODmtjLyiHsJm1kFS6UC08TcbOGE0Pe4MWE2Gp8m4f7dEuHSj0w4obvcjiZQZbg+eWkPW8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdXW/FXRN4LvXRTz/4UxHzzQMNHLhwHb9FPmTubUkDM=;
 b=zfmfZ6AE5qs8sUDNgsHrnx5XwxPdVfEGSfiI74X+Kx7mW8u78Yhu+w+cHX9yn3lj/hDh2li7b3sWHfSKgQt3Eoe4oj0A2b+yCsK+zXXhRcJgqihTC7maR+1JePXAg2Ul+7cugKnT9STb4Uypxiokv3v+bMtyupoFIyB+fhTIni0=
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 17 Jul 2024 19:41:35 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::b9) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:34 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:41:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 21/22] drm/amd/display: remove unused folder
Date: Wed, 17 Jul 2024 19:39:00 +0000
Message-ID: <20240717193901.8821-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2a4dd4-e207-4798-483d-08dca69877b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUd5SWM4aUIvM1NsSFZzVGdQR0RNcXdZcTlTV01VcjJpK3kyZlduZU1MZDVw?=
 =?utf-8?B?T0ozVEJVR0M1SEZyZ2tkWnJwMVNVSE9hQm9QSHZCYUxEcFRFT1NVc3dwQTRL?=
 =?utf-8?B?d2dLZjkyT0hhVGc4NEZFcEFFMTVRYTJ4UTRqb29ucmxXcC9WL3ZJaENYLzJy?=
 =?utf-8?B?ODU5NWFnL0lNWjF5VjJiRno2YXppR0pJSmx6cERhM1R5MnFEMHQwalYvTHJ1?=
 =?utf-8?B?SlNhckhDcTZsVVI0QmJUNHdNbGhnNUVndmdqNWtNdDkvdFROMGQ2Mk1EbHBa?=
 =?utf-8?B?dUFsbHhpS0drK1kvRE94V0hpSW1OYkR5SEdPc1RMbUM3eWpOZDRPazlucG5U?=
 =?utf-8?B?eXpHM1JlZ0k1aGtqeFFvcHMzZGVpdE12M1E0QzlTbHdMTkVUV2dqeFBGSk9h?=
 =?utf-8?B?WG5zZmJmOVMzMDI1TXQ0Z0hoUFlIRmQvTlNGQ2Q5RUI2K2ZUOGRpQTZHeGlu?=
 =?utf-8?B?Um1qYXFYMmxSekVMOXA4YU4wd2tBblNtUnZFL2NVS3pZZUpKQU1jR0UvL1pF?=
 =?utf-8?B?ckQxZ2hUc0pqMlNwbXluM2dXbUpBWnZYK3hDdTZmWGxuaDJkczFmV3ZCUThl?=
 =?utf-8?B?NWl5cy84NzRjMDEvalFRTHArbmFWK2NHZkRJV0hvUUVRQmZLZE9ZTkFLQUVQ?=
 =?utf-8?B?bTNvbnJQSXArRDZ3cDlZOVJnemZ6Z29vQ0FGOXpPai9QR1RzTmVubWxzZ3hM?=
 =?utf-8?B?THFTSmVLZG9ITlVxTzQyYXdSaHcxM3RZNXljV1FvRDFmQVMzNW1LYjdpTWhl?=
 =?utf-8?B?clQ2UGJNa0lUb1lPc2d3S1I0VnIrZk9IY0M0R0U0T2Y2TU5lV1pSZGVQbFlh?=
 =?utf-8?B?VW1RK29NNVR6VktsZ2RuTm0zQUg3UGFCcEc1aXFEcmJRQzZTaThEQVJQbzBr?=
 =?utf-8?B?d3BFTG1sbWJtRUN4YktKY3ZMUjFCZVFHVGhERlZUN0ZpT2hnUmRTL0ZJQUxW?=
 =?utf-8?B?dUM3QXNFZnRDQ09LNFBEVm5MSmlYYUVlSzdzaWlNUTQxTDliZGxOTU80TXpO?=
 =?utf-8?B?MTh1Ym8xRHBDeDQ5a0pheTc2eDJncFVxNHl2TzE2SHNoMmUxd29TUGc2Z0NR?=
 =?utf-8?B?aGJ1RnRBVld1WU1ya0R2akdYVHFzVVFqaDZYMTR4VFhYYlhBaG5jeDBTWVJw?=
 =?utf-8?B?Y1QzVjdpdWh0dTNWbjBibEZKekx0Y2ZTajY2WEd2c3I0WmpsQVNtdnVldlhx?=
 =?utf-8?B?bDRyOXRDYXc0RFQ5dW1EVXlDNmQzMDdTMzhiQUt5V3JPb1J5d0d1NXpkNlFm?=
 =?utf-8?B?Z2drNEVBU1Ntekc3VFhNUmNHUWRjUFhISi9CT1ozYU9CWEEzVjROakYxbHJw?=
 =?utf-8?B?ZmNTY0djZ3JzdzVDMFlhRHlURU9Hc3liY3oyN0gwZzhoT2RLOFFyZWZnRGJo?=
 =?utf-8?B?V0RwMnVEd1liYVdkTGpGY3phL1Y5UW5Bc0xJUzBEUndLcW5FUVczR2MzY2Iy?=
 =?utf-8?B?U0lWMG05OTBLV1cyLzZ6Smg4QU1acGwrMUpFNGtnb0pyZmNwSllzeGtlRWty?=
 =?utf-8?B?N092SGRpVWZYY1pYejk0Ti9RODV4TmppK3BqWEdHa3NuUk8zay9SNUxxN2tO?=
 =?utf-8?B?b24xTmdwSE5UUlgyUnp3Y3RiYlhuSHFZK25WS2JtbjRyU3N3OVlsMWM2SUdr?=
 =?utf-8?B?UGdlbG5tMmZmM2h2ZVdBM0o4MjRRMy9VR1laSVM4SlU2bUdJNDJ1bUJuY1Qy?=
 =?utf-8?B?RlpjblZ2Y3pIOXhCNHE5bHdoSGdaeHp3WHB1UUNGbEszTGMxaXBodlgxRFRl?=
 =?utf-8?B?Uk5aZFdwZk04UFU1Z1J5TlIwVnhiTUswNVVldUI4eWgyZXZ4SGQvWGtjczRP?=
 =?utf-8?B?a3FjS2c0djIxWUZnZGpoZEh0cXpURStWNXJVcGJnemJtbUcwTFR3UzMzK2VK?=
 =?utf-8?B?UC9xU0hTNkRsMm5IWWJIelRXZkpYeDB2VHVuYW54OThuVms3WWZNaTRRUnNN?=
 =?utf-8?Q?OopIDyYvRDRQSHPBcjcKon9uKq9XF5z3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:35.2217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a4dd4-e207-4798-483d-08dca69877b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

dc/{dcn401,dcn303} are unused since the files in it got moved under their
respective new components location. Hence they are no longer necessary

Fixes: fb17441f8ce4 ("drm/amd/display: Refactor DCN3X into component folder")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/Makefile | 13 -------------
 drivers/gpu/drm/amd/display/dc/dcn401/Makefile | 10 ----------
 2 files changed, 23 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn401/Makefile

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
deleted file mode 100644
index a954e316aca2..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: MIT
-#
-# Copyright (C) 2021 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  Authors: AMD
-#
-# Makefile for dcn303.
-
-DCN3_03 = dcn303_init.o
-
-AMD_DAL_DCN3_03 = $(addprefix $(AMDDALPATH)/dc/dcn303/,$(DCN3_03))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN3_03)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
deleted file mode 100644
index ded1f3140beb..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: MIT
-# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
-
-DCN401 += dcn401_dio_link_encoder.o
-DCN401 += dcn401_dio_stream_encoder.o
-DCN401 += dcn401_mpc.o
-
-AMD_DAL_DCN401 = $(addprefix $(AMDDALPATH)/dc/dcn401/,$(DCN401))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN401)
-- 
2.39.2

