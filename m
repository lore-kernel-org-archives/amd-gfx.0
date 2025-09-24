Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE80CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCA510E7B3;
	Wed, 24 Sep 2025 18:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mswt8O7x";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2886410E7B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7oLb3JtRol917LWy1QNkATeiTTutPANm/FMkzI330KdyqzsyGeGKmGB0Quy77CZZjWAzinaZlmX9ZbriDpvq0OOGsRwANvYONsxf4NsGxB/wRmK4g0Zn1t2DRa6aErXcSVn1lnwQqGDcj3sEuA0qV+ov3bXqns509XKzHsokOMNTQwD/5zhnj9qApbCnKmOrQkYPGaWhW7M9lhCkfVvBC3qsvTaZovLXz7fvnY4aTFKG3btGgP/kdAFADSihhExgNjYjN9e6b+6KHJmiLy18yq6r6v6Q44rjMEjArLmT5QxKkT5ZSZZw7Xahmm9oqLoEQ54f9W9au+chpoQUN6VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgdHbWL41SDQ06IURr+hmMk7evuaHgwn7k5xN+hEggw=;
 b=WYQenLruAiRZlueW/8UQDnzBL+PRjZ44DA4H68/Lbp4ftgC70YNBDwaP9q24MXla/ubtb/VaXxfYwmQyjn02eEhCMnR6iZ+0t+6JG3rbXfrN9P31XOFQgjGiRliL0fuhyhr5saRRkhIMGAGW87LsR+fH2bQ/dmYsK0ghnHwtmc3DJplmzz6JiK3kY1xJ6dSm1Ku0yiI9l67W67pfF0aA29gtWroOClwJsBfk7ZWzQED+g4E6tM38jucqYmKFmA4Zw6DEa2Jj3NyQxM8awkHhuKHg1R2qzZOAQVQ0kNev/eA3osBh2KDbGmH6hr5KHnA3TUD+Ol3hgih+tdOVdCrKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgdHbWL41SDQ06IURr+hmMk7evuaHgwn7k5xN+hEggw=;
 b=Mswt8O7xJsWzdojNSJ1v4sgA6Ybzy/vlE/M1Q7OzVFmhX1+vmC+SNn6ABLbzR0zJR9pSXGDKMeF4OT3ESg41FqDl2k4oTEn4nXOacJTkK8vKVzJYgBwEmGgEhkcyvUB+5Q9+0tCfzUXra9ovqag99V650XOiOpICj4IQXUQABDE=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 18:22:37 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::a7) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 18:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:24 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:24 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Cruise Hung
 <cruise.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 07/10] drm/amd/display: lttpr cap should be nrd cap in
 bw_alloc mode
Date: Wed, 24 Sep 2025 14:21:58 -0400
Message-ID: <20250924182201.1049389-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: b4627731-348e-42f1-0d0b-08ddfb97571f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrDLSSlTO3w03v4XeUgoTKoJHE0IXpwtD7fnh+0hOiYbO+L16OY75EmQlDX3?=
 =?us-ascii?Q?KzAK7RObA5q4vrhULil2S6TOgPdxXXpzUnba0JVV1ZU6cUTBy+4A+Cx72oJA?=
 =?us-ascii?Q?zlFSIYuBq3URMjnEpBNUj2je+7ulBOasp7l05DpGUImA/MSn8/LFUPGXwkKF?=
 =?us-ascii?Q?8vbGamAfXW64oBaG/1uptYiSRJZEO80C47DMfnaG88ZzVaTpThm6/EqOka+d?=
 =?us-ascii?Q?3wuljHd6xHtQBK+OjwVN0XZESbCs9zr6o3wvgcd3nETa9IKn81ZE+RgAxRCV?=
 =?us-ascii?Q?qmAt1+pre9Wex+OESga+5JwYXkVa8MQOtwC2oYEkWKyjvXauV9wM8ExGnGSG?=
 =?us-ascii?Q?gTLJSRVfJOBtRvXmzzkXzA9Vr3pqvuQpYHKrZlOUCEokpzpgD5H/Gti9iKZi?=
 =?us-ascii?Q?ougIRrL2d/iBgszRe5lEe2lHmYptTQi7ofdx1FjZQ01u0Sq9F6jxQdAUp8V7?=
 =?us-ascii?Q?YKKtL8fxu3eUWaR8tGwsBzy/ji1i5aoDKVWSvQ0saWjjxMRuDROvHxBpIZZV?=
 =?us-ascii?Q?qha1E2A5hMe7INYiluzjXpmicDkrmg7BsMWZ8kZVyVDlP23jjhsyJKADSehO?=
 =?us-ascii?Q?djv2bqAdmn/tYa25in6KMWytgyHmsvcgNGn+q0n8MUJ5xW3gtlCD85MHoSvR?=
 =?us-ascii?Q?4C5y7ih/ktwdK1gVaeRlDMiQY8ojDoMsVGp/oMBVGWTfHbbpTQXQfRWB0m8L?=
 =?us-ascii?Q?dtww63Es7Um3JgG0eu8mnwZRKoE4fjGz8Aot1aY/TcAivKKTfwbWiUxJFI1F?=
 =?us-ascii?Q?/LJDdqhOfzplRP3Y26mayxRPr6WpasKt+bZq4goFuJ0u76dD7PAw+ca7lqWK?=
 =?us-ascii?Q?ieHnYbyHdX2zeSLRAF3Ea4eFp4MLD9QKo/a8MbqlA/GS4p+ukDGbwqNlMrWS?=
 =?us-ascii?Q?w8KscF3IoCpkmQXBg5euVcn6jCmKyoFQKrXXf0qIos+qcbdJFuYd1w+pX2DZ?=
 =?us-ascii?Q?8ZXh/tfO772G3ONWbrnsde00Urj3NtbVr4FkkPgwCJGfHeOmHDhixetpMerK?=
 =?us-ascii?Q?E+9bTto/t7lmkuS2uHIJHHeMat172dV3X4SDF6CUdEvUpHn5LHxtz+Xl86dO?=
 =?us-ascii?Q?AverPAIEQsBi+Ow6/KxFAv033G0bLvxEEbiU9X+1ergwCpZhcfJJ0d0oUL9w?=
 =?us-ascii?Q?mlj8H0nVW4JI7pgKMZW2ZmHJs+0kVlrc0KiJy/bDszU9KG08/wOlvEGkUFOQ?=
 =?us-ascii?Q?CjW5lCSFUvmWn3quL50GkltLhZzPVXd8ZE0TF/Ou27GLBP+8fb0W+lqB4WjB?=
 =?us-ascii?Q?k1cU0N6b6Eoi/lBMwoU1qyszTv61Ic/O2oawCuQhX7TP/OtaTbdLf4pFA4Vm?=
 =?us-ascii?Q?61fWnZlGnG3viH2mGeetHzyU2GNRsT+sbG/QJ5Kg7AxdE/2vatVmydbjD++y?=
 =?us-ascii?Q?8xUBIf9lu9f4hfVJstDlhX2ib8Gg23c4ppcT8MwoOGoUkUHUKOf7oZqlMArK?=
 =?us-ascii?Q?VLWAgx23c+UgQjZIKDEulKbTlA8lBvintlp6ktdkdyrzjyYRqFO9SjIV3Tgp?=
 =?us-ascii?Q?RcDmxkOzRPLVBP+k0v+VunVnbbJ6L3tSnE8L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:37.6145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4627731-348e-42f1-0d0b-08ddfb97571f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
When bw allocation mode enabled, dpia may reports lttpr cap with
reduced common cap. It would cause driver not start pre-training with
max available bandwidth.

[How]
When bw allocation mode enabled, use NRD cap as lttpr cap.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index b12c11bd6a14..c33a8c17c38a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -424,6 +424,21 @@ static enum dc_link_rate get_link_rate_from_max_link_bw(
 	return link_rate;
 }
 
+static enum dc_lane_count get_lttpr_max_lane_count(struct dc_link *link)
+{
+	enum dc_lane_count lttpr_max_lane_count = LANE_COUNT_UNKNOWN;
+
+	if (link->dpcd_caps.lttpr_caps.max_lane_count <= LANE_COUNT_DP_MAX)
+		lttpr_max_lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
+
+	/* if bw_allocation is enabled and nrd_max_lane_count is set, use it */
+	if (link->dpia_bw_alloc_config.bw_alloc_enabled &&
+			link->dpia_bw_alloc_config.nrd_max_lane_count > 0)
+		lttpr_max_lane_count = link->dpia_bw_alloc_config.nrd_max_lane_count;
+
+	return lttpr_max_lane_count;
+}
+
 static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 {
 
@@ -438,6 +453,11 @@ static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 		break;
 	}
 
+	/* if bw_allocation is enabled and nrd_max_link_rate is set, use it */
+	if (link->dpia_bw_alloc_config.bw_alloc_enabled &&
+			link->dpia_bw_alloc_config.nrd_max_link_rate > 0)
+		lttpr_max_link_rate = link->dpia_bw_alloc_config.nrd_max_link_rate;
+
 	if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR20)
 		lttpr_max_link_rate = LINK_RATE_UHBR20;
 	else if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
@@ -2241,6 +2261,7 @@ const struct dc_link_settings *dp_get_verified_link_cap(
 struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 {
 	struct dc_link_settings max_link_cap = {0};
+	enum dc_lane_count lttpr_max_lane_count;
 	enum dc_link_rate lttpr_max_link_rate;
 	enum dc_link_rate cable_max_link_rate;
 	struct resource_context *res_ctx = &link->dc->current_state->res_ctx;
@@ -2305,8 +2326,11 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 
 		/* Some LTTPR devices do not report valid DPCD revisions, if so, do not take it's link cap into consideration. */
 		if (link->dpcd_caps.lttpr_caps.revision.raw >= DPCD_REV_14) {
-			if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
-				max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
+			lttpr_max_lane_count = get_lttpr_max_lane_count(link);
+
+			if (lttpr_max_lane_count < max_link_cap.lane_count)
+				max_link_cap.lane_count = lttpr_max_lane_count;
+
 			lttpr_max_link_rate = get_lttpr_max_link_rate(link);
 
 			if (lttpr_max_link_rate < max_link_cap.link_rate)
@@ -2412,6 +2436,11 @@ bool dp_verify_link_cap_with_retries(
 
 	dp_trace_detect_lt_init(link);
 
+	DC_LOG_HW_LINK_TRAINING("%s: Link[%d]  LinkRate=0x%x LaneCount=%d",
+		__func__, link->link_index,
+		known_limit_link_setting->link_rate,
+		known_limit_link_setting->lane_count);
+
 	if (link->link_enc && link->link_enc->features.flags.bits.DP_IS_USB_C &&
 			link->dc->debug.usbc_combo_phy_reset_wa)
 		apply_usbc_combo_phy_reset_wa(link, known_limit_link_setting);
@@ -2448,6 +2477,11 @@ bool dp_verify_link_cap_with_retries(
 	dp_trace_lt_fail_count_update(link, fail_count, true);
 	dp_trace_set_lt_end_timestamp(link, true);
 
+	DC_LOG_HW_LINK_TRAINING("%s: Link[%d]  Exit. is_success=%d  fail_count=%d",
+		__func__, link->link_index,
+		success,
+		fail_count);
+
 	return success;
 }
 
-- 
2.34.1

