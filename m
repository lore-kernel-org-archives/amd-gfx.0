Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01313D2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F5B10E72B;
	Wed, 23 Oct 2024 04:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="koUGMCXc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D398010E720
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+xfMIUZbgADi57Q6bMbElijqDQN5gJZHq1WuuBNoxszyRhHhoJzci29p7cZQshnwhoTGzTNZifxGyBqnF5zde+ecioZmt9e2Xud1PONl8ZerUz6Y2n93shSLiBqlyTz2xotllokX91A1EMN1r9QOhSjuJ4IWBRcfzEzpYg5Z7rz6W3nRYWObip52iK11LxgTridKWEGR2K/v8ece0JV93D4yVezNgUDfNOC7adPn83MCWIxW1qPqfkfSjICC3H0LSylQvdJI5U9aUemeVSOVUqxk+ss2xnCDQVTE4Lrh9knA6BHNiMhgPzI6gBfszK0GOpsWKoJitLAEdduN2wBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6qA2x02g8yKhbnrIfQ6fAfdL4lPr+GFWdRmm/Z3aY0=;
 b=gLTMqr0p30XYPlOTqZ1uezcln47RfcneDh8zrfBGNwyz6K7IP5dIdoQAyhCpjZKYk2FuSIQMleoGI0t+MkJyYnBqANmkVndTEJUH7NnNj1EO3P1E5MxxmURglc0Oa7cIB/CnW6gFtM1ODHdFOD+ack7bOhDLhFk2j3f5AIVyKwwyCdY6tyMxZg216TtkkAd58PpHjkuluGU4kL0LqXUkKLMEnc/6vwoJEf1yeJEEdjn+ZGW8Mqhazf/nTmDKLHZdpdpngnU1mcBboCk2o6dXyJIgHKodwL52Vjxgxji9Ikc2qhVPvyioqXjzvCxqOa5DaUPqq1//Qk/riFazvzqPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6qA2x02g8yKhbnrIfQ6fAfdL4lPr+GFWdRmm/Z3aY0=;
 b=koUGMCXcdhIdCa1BddMQHYtvE7scIPJ/uLXnD7s6m3IgE22U1y7+1aFE4sOrHOyVYf50polwtqW3R8Fe4ShKEzcgTmxDO7idh9amapnqLahe7oiDf9uLO4kLUFuFE05HbWovcirFvgFn6BfCGjR/lbzAvyG7deSFPSoHQfEcurU=
Received: from PH3PEPF0000409C.namprd05.prod.outlook.com (2603:10b6:518:1::48)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 04:54:18 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH3PEPF0000409C.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:16 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:12 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Lohita Mudimela <lohita.mudimela@amd.com>, "Mounika
 Adhuri" <mounika.adhuri@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Refactoring if and endif statements to
 enable DC_LOGGER
Date: Wed, 23 Oct 2024 12:53:26 +0800
Message-ID: <20241023045336.1557443-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: e09cf093-829e-425f-02a2-08dcf31ec00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yiq8jsbnyxqQAt41oDz3qS3Pu4izEbMFHG/wVvA86Kbl/BBFjswB75ZVGnTF?=
 =?us-ascii?Q?ug/obp5bPjK8mpGSYejGUu3QK+BEs+SHi5/EoQh3Ve0n8MyTVVm9h5DKXJjN?=
 =?us-ascii?Q?15eSmPM5wSNuAA3x3bT+V2HMcB7LVVBsAz22YLRYUOD5kzDabepwDDDpCKhE?=
 =?us-ascii?Q?Muja5nhKAI+KmjjrLu2gYm6S+G2nZ6+Vb0kZ1xjzxVsZ6+OATkyMkojwVgTO?=
 =?us-ascii?Q?NfKEdH48tZBXRVFxRTnzlSWV8obgPqYf1L5wlEmfx+4eqFSgMxaKaUGmU8ae?=
 =?us-ascii?Q?bRxM/wraVPtSxnlKHguLA2l8qg3zxrGikjL/gcs0c/1A8uhL05XGjKfHGRFP?=
 =?us-ascii?Q?a1IdkRziNTUTLe0j412ymdGYh2bKyXLncYdH79MAM6Mr2Yq9t93KYA3mARwr?=
 =?us-ascii?Q?mdefZNChW9ZxuPzimL9/c1X82L6BorIXnveHvgER/zuSJFNUX86/Kc6SLhMe?=
 =?us-ascii?Q?itrxxDcKsa6HRrGnayd7TyLSxt34C82vydcqWT8l0QmUOJKtbZsOCzRRyw15?=
 =?us-ascii?Q?a+DyCKJ28d/602HxCOWzyv4aQYn0AQGtNFassSbTJKUDHWaLxOkpTruaxXkJ?=
 =?us-ascii?Q?aJTDThAV7CH83HfwvlwqmfmdWz3BvnbAnh9u6vGSQJqATzSr9jnhPeZd7+4B?=
 =?us-ascii?Q?PETew0LSpRQACrMyZUU1974dPOQXrN5WLeSRKs4z6kryBm3ZG64zIjL/YPhC?=
 =?us-ascii?Q?7IEoa5CqrrgiHfW8cXpppSmDokKVk9pE3YbZqBvfVmptWGAd2ruw/0jT5N/P?=
 =?us-ascii?Q?4GiWOWEP5+hbKgBIkChxy+3ogLReM54JQleynziVuVohcN3zzc38/4/aROrZ?=
 =?us-ascii?Q?PrZpHQ3hJTOYd3V8MP/0g5i/QNYCu6QipePgvJmTrFJaTPqKAU5CL1Q03Szd?=
 =?us-ascii?Q?iNoF1FW4Xw9S/Pvsf2oiV4p0/o7rPfvQGE29AyeyaDp+HTIEdM0DtpCSe0Iq?=
 =?us-ascii?Q?uNdASZfAtGHEgQm/xgJeeVddklOK9N9t5SXCK6a10IEGhL/1vI/1X0qBKtL5?=
 =?us-ascii?Q?BGNdv27FnQ2ymBL9oKQvs6araAQB7jiNe1v0hQ8mqcBWkuRnka8GmX39wp7Y?=
 =?us-ascii?Q?WWxLrpWEQYhg7YY4z9Gmpts5TL34baMFY//XWx9KT65nvnw/VqD0ZTRRAWII?=
 =?us-ascii?Q?+0vmLzfBMDAECyutrTyB3W+oocg3pficoNXOaVc15xnPAa7RT2M8RDcvgK9X?=
 =?us-ascii?Q?nj1SUGBKF6LUqWjN3t4x15hzbRF0hiEkBuMO+JC9n5aUobJP9dmA65ZMAFok?=
 =?us-ascii?Q?x/7upuovje8ZDKi1wmAiv+rJp3XpmlDnjHhoF+mUPRNgp0pCWvQT0LEDdhzh?=
 =?us-ascii?Q?4dT1lUJXb+tUtRyNkQOECzuYrYtSyf5g4/FW3Y/Ih35zOvDHweeuD7lFoLXZ?=
 =?us-ascii?Q?9egYGWsC7shk50rqiGO5VLw3DJghiKs/tQRY9zmXM079gTNbhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:17.4761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e09cf093-829e-425f-02a2-08dcf31ec00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

From: Lohita Mudimela <lohita.mudimela@amd.com>

[Why]
For Header related changes for core

[How]
Refactoring if and endif statements to enable DC_LOGGER

Reviewed-by: Mounika Adhuri <mounika.adhuri@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Lohita Mudimela <lohita.mudimela@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c    | 5 +++--
 .../gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c  | 6 +++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 1 +
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index e93df3d6222e..bc123f1884da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -50,12 +50,13 @@
 #include "link.h"
 
 #include "logger_types.h"
+
+
+#include "yellow_carp_offset.h"
 #undef DC_LOGGER
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
 
-#include "yellow_carp_offset.h"
-
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 29eff386505a..91d872d6d392 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -53,9 +53,6 @@
 
 
 #include "logger_types.h"
-#undef DC_LOGGER
-#define DC_LOGGER \
-	clk_mgr->base.base.ctx->logger
 
 
 #define MAX_INSTANCE                                        7
@@ -77,6 +74,9 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 					{ { 0x0001B200, 0x0242DC00, 0, 0, 0, 0, 0, 0 } },
 					{ { 0x0001B400, 0x0242E000, 0, 0, 0, 0, 0, 0 } } } };
 
+#undef DC_LOGGER
+#define DC_LOGGER \
+	clk_mgr->base.base.ctx->logger
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 7d68006137a9..90208a5096c0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -55,6 +55,7 @@
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
 
+
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index e05b8fddf2af..93b81918216d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -51,9 +51,10 @@
 #include "dc_dmub_srv.h"
 #include "gpio_service_interface.h"
 
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+
 #define DC_LOGGER \
 	link->ctx->logger
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 
 #ifndef MAX
 #define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
-- 
2.34.1

