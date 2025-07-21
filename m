Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ADEC83F25
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 13:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E9810E27C;
	Mon, 21 Jul 2025 13:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQwZYUTr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C62A10E27C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 13:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXO/UWvyfkfXks4IgDdzn6takXzF8qdhhMl6Pik2Z6oKq2M9HyYFiDXtgvQtC8BzltgBvr6kQOA/G/jJH5JCSu3eAEadxJrQDVpR/tYhc2MXP6HVcwuDYZ/iFDuUO3D9zzGvdSl1Et87r7pWg8A5K/3Ku9VBzHbe/yTKO375SpL6zRhCR20f8IEDZxaPhQGS1VjTX7EVpyPGZ/ldT9LfIfg0aiPRr/4v5qnCYWP3TKvZ2oajoRsFvkU20DG0uyDbz8WBPfBxEgDLJX4RXPNMvACGFDo5SEgyGIpot8E0yk7M7yGRt407LkzKPHEWUSoIowsmo77GJFYoggoEugjRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXAg3UpUWbz74wHNfz1IPRS8RQqHfJxI5LL5j2lDNzQ=;
 b=yc4irvHpKjm/MnnvPhZzDnvKeqEO3vgcAajhd6tE3Siacp2yIqgwR+BLajySFqFO03/gyaTQJTdYcw0oEGuF/RTYmDF9h6AEDopaJtDPZgwg1qEKq2KHt3Q3K3R6eFs8o3PcTNc5wzt/kJDLtNXt3Klo25N0wZhg92/zjXUhvNNe2+JJvn0d7xkBf12/2f9OczojqR9zSXSxn6eWTHl6LTWOGDXUjjzXwQV+vQ5BSdtL66hmVWrILSeP7dwaNa0Z0C1rZdOC3X8n6AcBUH9l6u+uEoixGnwtnpCDjk6sQ6h/YZ5sFqH8JTBK0uulVACiPekNOYWGmxXwYPxwJG33ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXAg3UpUWbz74wHNfz1IPRS8RQqHfJxI5LL5j2lDNzQ=;
 b=hQwZYUTrxkqcmhLPuQ5MdSRbrLx7fDcEl+erpAXhMxH0nKKJsk94K4fAn0gDioIBpyumZp/oHO50dHcrAGMfI9dLCHOLQZf8nEC+QeAB3ocwuIxy8x0l9VWxNEWWk96yM6FT0l63iBqNi4XedNSBcBSx6y08YOK/6g5gfZRmaMw=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:06:40 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8b) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 13:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 13:06:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Jul 2025 08:06:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wayne Lin <wayne.lin@amd.com>, George Shen
 <george.shen@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Mike
 Katsnelson" <mike.katsnelson@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Ray Wu
 <ray.wu@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH] drm/amd/display: Reduce Stack Usage in
 'dp_retrain_link_dp_test' by heap-allocating 'audio_output'
Date: Mon, 21 Jul 2025 18:36:13 +0530
Message-ID: <20250721130613.1291563-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b8705d-78cf-45a2-282c-08ddc8576ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtM2ganLQ8mDfnu63gnplmbqZNhbXlFc9QLEwcGEH8h95gm+gakvZHgZP7dI?=
 =?us-ascii?Q?GfCFkRp4SBL4qfROSZWFXFmlD+pKExvPWxhoFkhdKttjXkP9qe3L5wEnFV9H?=
 =?us-ascii?Q?q2fq5F2Y0CZEGqX0WP74IWQXItldYTEgHxxhOSLv3O7ToNGddtOfCewpRbBn?=
 =?us-ascii?Q?MR/eML8n6OY7jcT1LnPxTMMwP7t6+sSQjeW3znlCE6jqTDwaXdrMIY7XL2Zc?=
 =?us-ascii?Q?ppmJ7Ultzv+lLxUTKQj6b+JvF0Nd8hxwG/IsAmmkMSDQvcxoPiRNFaetbP/N?=
 =?us-ascii?Q?MLo6u387EkrMOBf2M+QeUxrinWKvWGX/+LU8jTb6d10gXajLSEpYOlu1gclu?=
 =?us-ascii?Q?UwICkvucvX7EH1SzL5hRK/gD9AKG39kayvN9IB85Xho8M4W2BSqaydAwlWD8?=
 =?us-ascii?Q?9RmzOl86FgKsGfNDXzbo57hg1duqXSivBZobG10MJ8/oz3VinffO4OBm1HKw?=
 =?us-ascii?Q?vhTCkcJ06Dpougt08lpDOuYYmHhMkfZT3zoYmPDCodP2/7MKl6lE9nZUKiz9?=
 =?us-ascii?Q?rDgcFESTYa/p/gbVSdR2KasuOlByuh8oAU4Isf0YX3MwTytftbQyYGdVV4Pc?=
 =?us-ascii?Q?zM72VjWqX5gaqMJs2/P4V7ZHFBroULlMLlAgN6M1sP7oDRli9o45w88GCqvz?=
 =?us-ascii?Q?ISrdQPRQZZoqSpsaDoS8eD379KRiZZDbNr82krwQrYkjpfdFs1Wc9LVu7BHG?=
 =?us-ascii?Q?eETzP5/W97hMee+Vkx0ltX13CIWniwIEQhh9gE8dw9eNvtc7Lnn5tWoUNO0y?=
 =?us-ascii?Q?Ecz6ghw0VYHZRJK31ikyOi8F8RU/03SWlH6rPDYJYf3Dov9feng/greeTLtT?=
 =?us-ascii?Q?993oH+63xuclNbZIo41YiI1ywcGXTP3N4HXXCVE/+vOx/bIRMCImU5Q94KHe?=
 =?us-ascii?Q?KNhMRbKpHbgGI1w7r2jmCVAw2iwrEupf6twd0XeBEbHIBYL6PzfFN48OQo+s?=
 =?us-ascii?Q?7+yr6BFUV4Xg4CElNpszs02PGEwiedHqbFzxBCfNCPYjCZEumZZvzIP1IvhZ?=
 =?us-ascii?Q?B6g0XqleSielDO6JrBGtduTQTqY/gA4CURPEMCsyE17FAyRDbP3CFC3s/bPV?=
 =?us-ascii?Q?fdV1OQTBb9wSuQDg54fu8wsXo7WWeyIDyGfrzKdFkHiydO9Fui3Faex5mDed?=
 =?us-ascii?Q?pAXX4jCmWhSaH+VQSS/PooG5zEsC2SRUvTvenKnJv6dtZhvBFs1EAJvH4ysN?=
 =?us-ascii?Q?ICKRRjFMRWGBvv/LgnpL19GERaPit9TmYJ6fDOnpq0kvFDlQaWJ2rp42Wom1?=
 =?us-ascii?Q?/Xt/MCMvvdxJOK3IcjD2IJOPiw3plhU3P3GEffYNU/Q9lladN2ZYz0b9nbAd?=
 =?us-ascii?Q?UG7BEnwnANBrMYt2l3g/qpihaRsMwCySR2cCLD+kufU/OW/X5954ByqoRQBb?=
 =?us-ascii?Q?YJmz8LEN/A52YjTlwsJ0riUPaH+vO5FLW1S+tIhDzu5kuywTKAW7vheaxGrH?=
 =?us-ascii?Q?HMANXyB6g9N+xkVuFb50nyBH2tDZX5Dfmf+bnfvapb5RwTbPK7gBeocGsq30?=
 =?us-ascii?Q?aFF4iI+2KSMbO6xBsm909GliRggBe1lOwpTP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:06:40.3223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b8705d-78cf-45a2-282c-08ddc8576ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

The function dp_retrain_link_dp_test currently allocates a large
audio_output array on the stack, causing the stack frame size to exceed
the compiler limit (1080 bytes > 1024 bytes).

This change prevents stack overflow issues:
amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack frame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe-larger-than]
static void dp_retrain_link_dp_test(struct dc_link *link,

This commit refactors the function to dynamically allocate the
audio_output array using kmalloc/kfree, significantly reducing stack
usage.

- Allocates audio_output on the heap instead of stack
- Adds error handling for allocation failure
- Frees allocated memory before function return

Fixes: 9437059b4bfb ("drm/amd/display: Fix Link Override Sequencing When Switching Between DIO/HPO")
Switching Between DIO/HPO")
Cc: Wayne Lin <wayne.lin@amd.com>
Cc: George Shen <george.shen@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Mike Katsnelson <mike.katsnelson@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/link/accessories/link_dp_cts.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2956c2b3ad1a..c4db61cb5079 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,16 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
-	struct audio_output audio_output[MAX_PIPES];
+
+	/* Dynamically allocate audio_output to reduce stack usage */
+	struct audio_output *audio_output;
+
+	audio_output = kmalloc(sizeof(*audio_output) * MAX_PIPES, GFP_KERNEL);
+	if (!audio_output) {
+		/* Allocation failed, handle error gracefully */
+		DC_LOG_ERROR("%s: Failed to allocate audio_output", __func__);
+		return;
+	}
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -144,6 +153,8 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 			stream_update.dpms_off = &dpms_off;
 			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, state->streams[i], &stream_update);
 		}
+
+	kfree(audio_output);
 }
 
 static void dp_test_send_link_training(struct dc_link *link)
-- 
2.34.1

