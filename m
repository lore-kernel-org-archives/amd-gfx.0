Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FCAC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF30112C06;
	Mon, 22 Apr 2024 15:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1ml20WY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1220112C07
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz/NGK8m7tLvYspxvc0H0pax2GbXfgw3mRvEeG7gIrvS/k1ZMoVG0r3nDB+KAmwLPv04jnN6t+gEQBc5Tw1FuQGdQ8atMSGKwp15/0LL0xBLTvpYOzrdikxZTCViQNaS37e1IlLxV49PddOxpToajkC5aMOJVFR9keOSB3rxdtMemx8EcxziXvGYn2dMnN9IdGBVEdB1c1HtHCm7161lQQC+gS0w/J+K+95MKX6xgQ/SoEy6bNlTj1xqoyaKAx+iNa7V1ZIEJGBF7eolbeOwv6VMOkjyCDEcRV5V3cTEWD4P82hDGkzK5fOdb5BRRcap1yonR5YFLUGhWBIn5pE78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g1EFaaQeXrQwmsk7v+5FJoxyn7yeJNlMsh9ixP+UR8=;
 b=fIKK2oP7mqeHv1NKKRfU0s5D+6Vfb3u0m0LvYXNflFVB6yd9F5EW25FrZetUBHBgsWuHY0vAE35IocEcwDhW4d+tNW2Oz+W/KLiaOHqRKXqEVPgiyIHNQ9+wJBLia5VznURTw3Zz+apNdzfvWtATBFG3WIu6m3bQBAXjlRmu/glnSbJZb1ZfRzV5YC1x7uu5D86TNxqNqj7MDHUE3mhs47wBN7Bx+uStwTguorSG8pP1yAj7BZbVcrlDE5OIOT93xWOW5xRTLsIho+f7YZBsJNzlLX+ZsVZyDRLIFXe+YY8/xKBjJbPlYe/yeI4Rl11jS1vuYhxJ8CpY/QFnufIOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g1EFaaQeXrQwmsk7v+5FJoxyn7yeJNlMsh9ixP+UR8=;
 b=g1ml20WYuIooQyARCO5t8SvkAvaTrl+nYtLrJ0rQ3xIqvt0zAuHT5X72fHK467OX+ea6la6mzhEib2yV4vCRbv/yciZkhCERL3SHKsXLbRcPmPd2ACy6Ik3sJiInY48V7hLjoUGiTnpSr+PDRlI5inzlONpvzpbZATwHqJNGY1c=
Received: from CH0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:610:cc::14)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:31:38 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::c6) by CH0PR03CA0069.outlook.office365.com
 (2603:10b6:610:cc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:37 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:31 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, yi-lchen <yi-lchen@amd.com>, "Jun
 Lei" <jun.lei@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>
Subject: [PATCH 33/37] drm/amd/display: Keep VBios pixel rate div setting util
 next mode set
Date: Mon, 22 Apr 2024 11:27:42 -0400
Message-ID: <20240422152817.2765349-34-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: aeff6c92-d784-403b-a61d-08dc62e14d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cbo6xeyUZhuPn89E6TIMBwdvYv8E/FInnInrpOZhvHoCnsMg9h/d9xonao5V?=
 =?us-ascii?Q?zRJdGx3G1JoEyHOgCNyRgnQXtgnWGA+X4pf6k5OcdAklgOLrYWgYJdUbAWV8?=
 =?us-ascii?Q?rdpjo64AkUnMFZ42rPqsgTdWck9brrtmTgewxlaR73wtYAnwMA8wJeaG5Fip?=
 =?us-ascii?Q?O2ibzXaH3nYg0Lk0GyEgHrSq1RIUF6FnqQNhEzR6JWSRwvJspBA+q7mswcFS?=
 =?us-ascii?Q?ZFNM7dQWCicqeeL7kujqKYp++rE1qFyAjgzO0TMYHeVERYSED9CAG8yUx7xs?=
 =?us-ascii?Q?5D84uM4prdx1qEBZ6yrp/yIDRGaSN9dGOVTJpazohVRKN6gs2DxTchwNCR6k?=
 =?us-ascii?Q?LzIssNpBBAOljFlQGm7i8njBwo2oQsGc+5CoZhB2TA6n5B5Eq1aZIlxVWiC4?=
 =?us-ascii?Q?RiamyY62XWsJ10Q2WJkjRIB8GH0B4+7+xa6gR7pqOsGORLxl3vrLTrevo/il?=
 =?us-ascii?Q?DEPa19foMudwjAAhhwmJZNLQ4Wihr3MGAL+FhI2RLtoGZ0cvABQsYgTCIweG?=
 =?us-ascii?Q?UP0daCzh/GXhCQ4u2q/Mta6m6JGcm/SsgIubGRhQ+Cp3N801nz9l4HhuuKTp?=
 =?us-ascii?Q?1ptFgmvywDFllJJ1ESZ17XCxUKSpXr+2+HuBuJ7SFIsvdb+PCHdSeArMALq5?=
 =?us-ascii?Q?wQqDohg0DnSslIvY0hq7J8B0BeeYBvKqCQ7BHQGCYcINT8GnanVQKsMx8eaW?=
 =?us-ascii?Q?lWHXyGOZiftD7V/69sKlTKdp2XYOa26irD+zWClWOu+js+aN5Ne7RfssfMqX?=
 =?us-ascii?Q?1nuX+sixuXdde1gQVNqY3+frxZlZwTZFjjJcDukAnLJR+gwh09Qlj4Q9n2/j?=
 =?us-ascii?Q?nX8qe3/oTK5A2dkWI0MyYWhClCZDL/1ib+Xqpx0QG5EW08Eafm19pK0pOKLH?=
 =?us-ascii?Q?WOSmv0u7bIjUSnBu2cWN6F+vzd6T0TUrLnDQo1bopiYKc5dWz678GbBQs8fd?=
 =?us-ascii?Q?BROlJNKC+Ux3nUuVnya+tx05MJaK0oWqasqbRplSlIrmm6mnkOcgsj6HpW8f?=
 =?us-ascii?Q?ILpjeDiiDS+jB6iw/esbHBeFuB3NckPT8f2AlF1T9LHlWxsokzRHncdsFJiR?=
 =?us-ascii?Q?yuB4zB5qrnE0v1eOIJY0Sn/KB+Llix8cfbJ0B96u4vKbhzvvFW66PzeTl2Tl?=
 =?us-ascii?Q?5SJyxB0YR90D3ARLrhlG6Hpx0wQKRbchpNoDd9/BoMOY0m8KbxEFp81KYS0C?=
 =?us-ascii?Q?PfbBxdnBqlwxAN/Rb6Yk2lfPqijRQ1UXP5HxjtTxQRiY7NlC+4mJL553/cb6?=
 =?us-ascii?Q?HSmiqPIZWkZOJmsc7GgCX6cxNRPfjNhk75mzxxNs7ybyDM6Bv8baIpeprjue?=
 =?us-ascii?Q?dE3n/ONr3/LJcbSmLDB6lzZeSUvvKbMWPWLitFcWWki0veCU877ENCg8+oBQ?=
 =?us-ascii?Q?u0HnUN9pExxh0nQA7GjkEgNq931a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:37.8194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff6c92-d784-403b-a61d-08dc62e14d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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

From: yi-lchen <yi-lchen@amd.com>

[why]
VBios & Driver may have differnet pixel rate div policy.
If the policy is not same and fast boot is enabled,
it would cause the pixel rate is too high
after driver only performs stream blank & unblank.

[how]
We would keep pixel rate div setting by VBios until next mode set.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: yi-lchen <yi-lchen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 ++
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 12 ++---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 13 +++---
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 40 ++---------------
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  8 ++--
 .../dc/dcn35/dcn35_dio_stream_encoder.c       | 36 +--------------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 24 ++++++++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 21 +++------
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 23 ++++++++++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  4 ++
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 44 +++++++++++++++----
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  4 ++
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  3 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  7 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  5 +++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  1 +
 20 files changed, 141 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8ebeb012abd9..fa93d6d6563d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -49,6 +49,7 @@
 #include "link/hwss/link_hwss_hpo_dp.h"
 #include "link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h"
 #include "link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h"
+#include "hw_sequencer_private.h"
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
@@ -3892,6 +3893,9 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 		if (res != DC_OK)
 			goto fail;
 
+		if (dc->hwseq->funcs.calculate_pix_rate_divider)
+			dc->hwseq->funcs.calculate_pix_rate_divider(dc, context, add_streams[i]);
+
 		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
 			res = DC_FAIL_ATTACH_SURFACES;
 			goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 17a1174b8d80..8f6edd8e9beb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -58,8 +58,8 @@ static void dccg314_trigger_dio_fifo_resync(
 static void dccg314_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *k1,
-		enum pixel_rate_div *k2)
+		uint32_t *k1,
+		uint32_t *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -93,8 +93,8 @@ static void dccg314_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = (enum pixel_rate_div)val_k1;
-	*k2 = (enum pixel_rate_div)val_k2;
+	*k1 = val_k1;
+	*k2 = val_k2;
 }
 
 static void dccg314_set_pixel_rate_div(
@@ -104,7 +104,8 @@ static void dccg314_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -373,6 +374,7 @@ static const struct dccg_funcs dccg314_funcs = {
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
 	.set_pixel_rate_div = dccg314_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg314_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
 	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 036d05468d76..21a6ca5ca192 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -58,8 +58,8 @@ static void dccg32_trigger_dio_fifo_resync(
 static void dccg32_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *k1,
-		enum pixel_rate_div *k2)
+		uint32_t *k1,
+		uint32_t *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -93,8 +93,8 @@ static void dccg32_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = (enum pixel_rate_div)val_k1;
-	*k2 = (enum pixel_rate_div)val_k2;
+	*k1 = val_k1;
+	*k2 = val_k2;
 }
 
 static void dccg32_set_pixel_rate_div(
@@ -104,8 +104,8 @@ static void dccg32_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -344,6 +344,7 @@ static const struct dccg_funcs dccg32_funcs = {
 	.otg_add_pixel = dccg32_otg_add_pixel,
 	.otg_drop_pixel = dccg32_otg_drop_pixel,
 	.set_pixel_rate_div = dccg32_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg32_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg32_trigger_dio_fifo_resync,
 	.set_dtbclk_p_src = dccg32_set_dtbclk_p_src,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 2fef1419ae91..1a9bb614c41e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -52,11 +52,11 @@
 
 static void enc32_dp_set_odm_combine(
 	struct stream_encoder *enc,
-	bool odm_combine)
+	bool two_pixel_per_cyle)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, odm_combine ? 1 : 0);
+	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, two_pixel_per_cyle ? 1 : 0);
 }
 
 /* setup stream encoder in dvi mode */
@@ -241,46 +241,12 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
-{
-	/* math borrowed from function of same name in inc/resource
-	 * checks if h_timing is divisible by 2
-	 */
-
-	bool divisible = false;
-	uint16_t h_blank_start = 0;
-	uint16_t h_blank_end = 0;
-
-	if (timing) {
-		h_blank_start = timing->h_total - timing->h_front_porch;
-		h_blank_end = h_blank_start - timing->h_addressable;
-
-		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
-		 * divisible by 2 in order for the horizontal timing params
-		 * to be considered divisible by 2. Hsync start is always 0.
-		 */
-		divisible = (timing->h_total % 2 == 0) &&
-				(h_blank_start % 2 == 0) &&
-				(h_blank_end % 2 == 0) &&
-				(timing->h_sync_width % 2 == 0);
-	}
-	return divisible;
-}
-
-static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
-{
-	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
-	return is_h_timing_divisible_by_2(timing) &&
-		dc->debug.enable_dp_dig_pixel_rate_div_policy;
-}
-
 void enc32_stream_encoder_dp_unblank(
 	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -291,7 +257,7 @@ void enc32_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
+			|| param->pix_per_cycle > 1) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 			pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 58dd3c5bbff0..4c53e339e325 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -137,8 +137,8 @@ static void dccg35_set_dppclk_root_clock_gating(struct dccg *dccg,
 static void dccg35_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *k1,
-		enum pixel_rate_div *k2)
+		uint32_t *k1,
+		uint32_t *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -183,7 +183,8 @@ static void dccg35_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -1054,6 +1055,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.disable_dsc = dccg35_disable_dscclk,
 	.enable_dsc = dccg35_enable_dscclk,
 	.set_pixel_rate_div = dccg35_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg35_get_pixel_rate_div,
 	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 62a8f0b56006..2595cbef5942 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -273,46 +273,12 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
-{
-	/* math borrowed from function of same name in inc/resource
-	 * checks if h_timing is divisible by 2
-	 */
-
-	bool divisible = false;
-	uint16_t h_blank_start = 0;
-	uint16_t h_blank_end = 0;
-
-	if (timing) {
-		h_blank_start = timing->h_total - timing->h_front_porch;
-		h_blank_end = h_blank_start - timing->h_addressable;
-
-		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
-		 * divisible by 2 in order for the horizontal timing params
-		 * to be considered divisible by 2. Hsync start is always 0.
-		 */
-		divisible = (timing->h_total % 2 == 0) &&
-				(h_blank_start % 2 == 0) &&
-				(h_blank_end % 2 == 0) &&
-				(timing->h_sync_width % 2 == 0);
-	}
-	return divisible;
-}
-
-static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
-{
-	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
-	return is_h_timing_divisible_by_2(timing) &&
-		dc->debug.enable_dp_dig_pixel_rate_div_policy;
-}
-
 static void enc35_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -323,7 +289,7 @@ static void enc35_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
+			|| param->pix_per_cycle > 1) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 			pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5920d1825a4c..43200f8b1c3c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1782,6 +1782,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
 	struct dc_link *edp_link_with_sink = NULL;
 	struct dc_link *edp_link = NULL;
+	struct pipe_ctx *pipe_ctx = NULL;
 	struct dce_hwseq *hws = dc->hwseq;
 	int edp_with_sink_num;
 	int edp_num;
@@ -1818,9 +1819,26 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				can_apply_edp_fast_boot = dc_validate_boot_timing(dc,
 					edp_stream->sink, &edp_stream->timing);
 				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
-				if (can_apply_edp_fast_boot)
-					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
-
+				if (can_apply_edp_fast_boot) {
+					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot Enable\n");
+
+					// Vbios & Driver support different pixel rate div policy.
+					pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, edp_stream);
+					if (pipe_ctx &&
+						hws->funcs.is_dp_dig_pixel_rate_div_policy &&
+						hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
+						// Get Vbios div factor from register
+						dc->res_pool->dccg->funcs->get_pixel_rate_div(
+							dc->res_pool->dccg,
+							pipe_ctx->stream_res.tg->inst,
+							&pipe_ctx->pixel_rate_divider.div_factor1,
+							&pipe_ctx->pixel_rate_divider.div_factor2);
+
+						// VBios doesn't support pixel rate div, so force it.
+						// If VBios supports it, we check it from reigster or other flags.
+						pipe_ctx->pixel_per_cycle = 1;
+					}
+				}
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 26b19de687cc..e5f864ca5204 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -828,17 +828,14 @@ enum dc_status dcn20_enable_stream_timing(
 	struct mpc_dwb_flow_control flow_control;
 	struct mpc *mpc = dc->res_pool->mpc;
 	bool rate_control_2x_pclk = (interlace || optc2_is_two_pixels_per_containter(&stream->timing));
-	unsigned int k1_div = PIXEL_RATE_DIV_NA;
-	unsigned int k2_div = PIXEL_RATE_DIV_NA;
-
-	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
-		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
+	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
 			pipe_ctx->stream_res.tg->inst,
-			k1_div, k2_div);
-	}
+			pipe_ctx->pixel_rate_divider.div_factor1,
+			pipe_ctx->pixel_rate_divider.div_factor2);
+
 	/* by upper caller loop, pipe0 is parent pipe and be called first.
 	 * back end is set up by for pipe0. Other children pipe share back end
 	 * with pipe 0. No program is needed.
@@ -2899,9 +2896,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dccg *dccg = dc->res_pool->dccg;
 	enum phyd32clk_clock_source phyd32clk;
 	int dp_hpo_inst;
-	struct dce_hwseq *hws = dc->hwseq;
-	unsigned int k1_div = PIXEL_RATE_DIV_NA;
-	unsigned int k2_div = PIXEL_RATE_DIV_NA;
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
@@ -2922,14 +2916,13 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
-	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
-		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
+	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
 			pipe_ctx->stream_res.tg->inst,
-			k1_div, k2_div);
-	}
+			pipe_ctx->pixel_rate_divider.div_factor1,
+			pipe_ctx->pixel_rate_divider.div_factor2);
 
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 093f4387553c..5bfe08a7fef0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -332,6 +332,29 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	return odm_combine_factor;
 }
 
+void dcn314_calculate_pix_rate_divider(
+		struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct pipe_ctx *pipe_ctx = NULL;
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+
+	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+
+	if (pipe_ctx) {
+		pipe_ctx->pixel_per_cycle = 1;
+
+		if (hws->funcs.calculate_dccg_k1_k2_values)
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+		pipe_ctx->pixel_rate_divider.div_factor1 = k1_div;
+		pipe_ctx->pixel_rate_divider.div_factor2 = k2_div;
+	}
+}
+
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 {
 	uint32_t pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index eafcc4ea6d24..fb94e327d4ee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -39,6 +39,10 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
+void dcn314_calculate_pix_rate_divider(struct dc *dc,
+	struct dc_state *context,
+	const struct dc_stream_state *stream);
+
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 542ce3b7f9e4..934203ef52bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -151,6 +151,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
+	.calculate_pix_rate_divider = dcn314_calculate_pix_rate_divider,
 	.set_pixels_per_cycle = dcn314_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 9f1a86ddadb5..7222055fa854 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1159,15 +1159,14 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t pix_per_cycle = 1;
+	uint32_t pix_per_cycle = pipe_ctx->pixel_per_cycle;
 	uint32_t odm_combine_factor = 1;
 
 	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.stream_enc)
 		return;
 
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
-	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1
-		|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1)
 		pix_per_cycle = 2;
 
 	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
@@ -1213,8 +1212,8 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
 	struct pipe_ctx *odm_pipe;
-	uint32_t pix_per_cycle = 1;
 
+	params.pix_per_cycle = pipe_ctx->pixel_per_cycle;
 	params.opp_cnt = 1;
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		params.opp_cnt++;
@@ -1230,13 +1229,14 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				pipe_ctx->stream_res.tg->inst);
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1
-			|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
+		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1)
+			params.pix_per_cycle = 2;
+
+		if (params.pix_per_cycle == 2)
 			params.timing.pix_clk_100hz /= 2;
-			pix_per_cycle = 2;
-		}
+
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
-				pipe_ctx->stream_res.stream_enc, pix_per_cycle > 1);
+				pipe_ctx->stream_res.stream_enc, params.pix_per_cycle > 1);
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
@@ -1257,6 +1257,32 @@ bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
 	return false;
 }
 
+void dcn32_calculate_pix_rate_divider(
+		struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct pipe_ctx *pipe_ctx = NULL;
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+
+	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+
+	if (pipe_ctx) {
+		pipe_ctx->pixel_per_cycle = 1;
+
+		if (dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+			pipe_ctx->pixel_per_cycle = 2;
+
+		if (hws->funcs.calculate_dccg_k1_k2_values)
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+		pipe_ctx->pixel_rate_divider.div_factor1 = k1_div;
+		pipe_ctx->pixel_rate_divider.div_factor2 = k2_div;
+	}
+}
+
 static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 {
 	/* There are use cases where SYMCLK is referenced by OTG. For instance
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index f55c11fc56ec..d6345a2408be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -91,6 +91,10 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
+void dcn32_calculate_pix_rate_divider(struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream);
+
 void dcn32_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index b1f79ca7d77a..033dca8b9a47 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -161,6 +161,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 	.populate_mcm_luts = dcn401_populate_mcm_luts,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index df3bf77f3fb4..7ed5de5c5ec1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -159,6 +159,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index c4944478ed91..3a5352c57c05 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -158,6 +158,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 3a23d05a615e..939832372baf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -173,6 +173,9 @@ struct hwseq_private_funcs {
 			struct dc_state *context,
 			struct dc *dc);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
+	void (*calculate_pix_rate_divider)(struct dc *dc,
+			struct dc_state *context,
+			const struct dc_stream_state *stream);
 	void (*reset_back_end_for_pipe)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 286f3219b77e..634d52fe111e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -399,6 +399,11 @@ union pipe_update_flags {
 	uint32_t raw;
 };
 
+struct pixel_rate_divider {
+	uint32_t div_factor1;
+	uint32_t div_factor2;
+};
+
 enum p_state_switch_method {
 	P_STATE_UNKNOWN						= 0,
 	P_STATE_V_BLANK						= 1,
@@ -464,6 +469,8 @@ struct pipe_ctx {
 	bool has_vactive_margin;
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
+	uint32_t pixel_per_cycle;
+	struct pixel_rate_divider pixel_rate_divider;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index d4c7885fc916..d6248a73c7c1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -176,6 +176,11 @@ struct dccg_funcs {
 			enum pixel_rate_div k1,
 			enum pixel_rate_div k2);
 
+	void (*get_pixel_rate_div)(struct dccg *dccg,
+			uint32_t otg_inst,
+			uint32_t *div_factor1,
+			uint32_t *div_factor2);
+
 	void (*set_valid_pixel_rate)(
 			struct dccg *dccg,
 			int ref_dtbclk_khz,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 75b9ec21f297..60228f5de4d7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -99,6 +99,7 @@ struct encoder_unblank_param {
 	struct dc_link_settings link_settings;
 	struct dc_crtc_timing timing;
 	int opp_cnt;
+	uint32_t pix_per_cycle;
 };
 
 struct encoder_set_dp_phy_pattern_param {
-- 
2.44.0

