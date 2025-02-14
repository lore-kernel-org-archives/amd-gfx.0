Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CBBC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D4010ECB0;
	Fri, 14 Feb 2025 15:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIcb5+LE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0377B10ECBD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5gNIYI/3wRDwK++R91raAMWWP5gq0Sstr+3nUyCz0eS+kF7YkmUKSwqSxe61A1DS3ZcbEBaUrX4QaDQOd+zxOgKKrhAYFRWmm0igLd6KQZNU9V8oldycROgIlfZ7MAe/6JXMMNP7aqWHVGc6W49uXAPQlpxJPaZuCt37R7MfHsxirF/rCErNq3KBS8GbgaG6cohRpgdKqZo96hcGuVJxJvcygBCtGYIlEJHbGxU3VdRq/us5MM6tPa89x74nt0/AWeqvxbl3i6WJzGIUDGrGVWtGDzeI5M9Glkq0oth6gfO+uuKYRDpY9i4s78H97+FI1yFJvuKWweY4Ls7tyDwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PKs9CkJmPHGFpGF+wDIQNMRP8mN2fv4pHAakfTBhHE=;
 b=c6ZrNH2dLovu0AGW1B24iJaS0Oq0DqGexIu/KYDkpWyR0Py4nVnGCxCSIsS/fBXsYALzHIhgls6iz75t+dNcrjmSXNk41hsVoB7rFH5TntQO9kGUR0U7lff6cBVm1toKHbCzCai+LetpFqeJXP/ErBYNcxYboNofbS19Z8aXQXQF4WZrmg/XmRWVQnLeU/6Mgg26F96YL3w71tBWXUMYNiUjhFRee56POER0F5Gq0N9TI9ryPbwouxVuRnbaViC5VoyA9+paa5mXgc8BdwBRga5WgvalX1CWwniRGC9/b4qN5vWGU6k5CiyOZUH9l6FUPR1+0U/2CR4qZMy33/0kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PKs9CkJmPHGFpGF+wDIQNMRP8mN2fv4pHAakfTBhHE=;
 b=cIcb5+LEIc+yHnKcT/Jd5J6C5EdNHNAHeWpYfNLG8HHoihZIcWtQUmd05tyw/kof2YnGKNJFkAQyGa8hMor+GY+DALTWq9F+N+gP8ojZyisguMXTly3ZmFqe3nu6q0WFiX5rk1Bdkz4VPoxI3VDRgAMPEjIK1Gs0sdoIAK8/9sw=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:01:39 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::2c) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Fri,
 14 Feb 2025 15:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:37 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:36 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Read LTTPR ALPM caps during link cap
 retrieval
Date: Fri, 14 Feb 2025 10:00:26 -0500
Message-ID: <20250214150033.767978-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: edc28e4d-c241-4824-dcdb-08dd4d087ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?admy9lStTiTqcEZnpMwU+rx0ynQ5o8nWGuct0PAz+qX030pshcsmFTasI+Me?=
 =?us-ascii?Q?y15nJyCi2HqhbGembh537xiz+xR5vM2NvAHHdFxmt7aeMMsmeSV53Bt/qJpw?=
 =?us-ascii?Q?p4b/AxN626NtW4yXcuitTK2HgNli2oixOJWY+kngBZEy1OKSKlSPwPoHeoYc?=
 =?us-ascii?Q?3NfSpoQN1X17mTeJ2cc/yP39ApsZnGnKjn82VvLJieuPfe5SSywr5tyYfxYC?=
 =?us-ascii?Q?HJ+6rWvsv95WS8TG/pSs4zopkdPFjqGf+bLTtLhOo+hUKf8DmUT+pkAg36Va?=
 =?us-ascii?Q?Rqzp7Iegeu7yAEGzyTcKnmQ+JFa6T4g3l7+ttNPL9RbuxovgNvX8LuD0Obc2?=
 =?us-ascii?Q?u60PvVxWBmmcHUuS1htQFdcIydaLoeWDs+aig+DFL/LIchCWpHnVBXMnfoX1?=
 =?us-ascii?Q?5Ilh1wAxBk28EpnoTsVUPaz9+1oHIBLjjt59Bz8AjnagZbZZL7aranBOv+kS?=
 =?us-ascii?Q?rumqLDNE3O699Vn+6PN8A6uw0qXZSxeY541eHFgG0v5XsEqCdYX+EwRkEa3H?=
 =?us-ascii?Q?JMwSpYwH4FjfxB6InzGRzFMybb0W/awtHV1B2qGOFoSkmmMvwrr60zaknuXP?=
 =?us-ascii?Q?Oascfz1R/w06JRwsX4JoQcvxEjnLfsmIYthlDBQZ7LkMktOJZ0dfeNeHczu8?=
 =?us-ascii?Q?4m+Y7XJ9MjLgPw8kh8nuH7EON9xY3zshiaugVhu4cM0nHYz/vCpEtx035ZyT?=
 =?us-ascii?Q?bpvXcx+25VMV4UwmTVa+OhX9gpL8Gs0xFuhrHWjS7E2PJlZUo3Z9jbYRqEk4?=
 =?us-ascii?Q?B017hllkAsx031T7r/cNy4NWrnsNblTOpBOesPZZqcJX0DipFy9beUa03eAx?=
 =?us-ascii?Q?muxUu+a8d4xmmQIgGLQDREhPLSjytrJNi0csbg45H+JvRt4r3GTMAo7eesGO?=
 =?us-ascii?Q?iPhczO7IEFbonPhTho9wSl+zusy6jxQjA/L4J0QeTBU/k7bmV4CqcQU10C93?=
 =?us-ascii?Q?HyIwoMKzB2IyJHPiXOt1Hlfqa/LE+GW53qjZQphusdM+tz98uXli+E+SxB35?=
 =?us-ascii?Q?0+Ea3CAgtS+SNq9jDYHmaIfrqRrHEFJ0UtRyu+XaRTPW70+izWcfZY3TPz9C?=
 =?us-ascii?Q?Z7F7T/q2AQLhqJ9ZECva5q+lMEcRnubkgSSGPVjLptsb4qKGbp9cxu9B8bgp?=
 =?us-ascii?Q?rDUmKuCIurreqoiiXFxskQ/KHVyv8Ww450iT4ygV6Pk3z8VzU66Wxp/R3Zyk?=
 =?us-ascii?Q?HcTYjWIzko55tsDE0I+rwYp2OkvNveJX+B/cQsb4B1gAlKdrpGtkfazGky0E?=
 =?us-ascii?Q?AYKdSNG8Suh/4fKveoaoNlqw1Kk5ExvCdcTGpmkczau5zg0ld5tsoofOeTL/?=
 =?us-ascii?Q?HkLZlIa+ZWUgtqu0+pBIDDTaL/vpQfNgrxNps6L2octR9+WFG+FDVF+RGlJ8?=
 =?us-ascii?Q?/E82S4w7H7si8TjfBp6WTIXrmvYMeIjMJac8nOziwgQE2dJj//GO+rr8D/2j?=
 =?us-ascii?Q?vU03t3hrrCJmTlAobqDVl6jQ0LfhpcvTtdomwj1nUcFFpdSGXyyJEHtSiQNp?=
 =?us-ascii?Q?fe1Mtta1uzYH0uo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:38.4823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc28e4d-c241-4824-dcdb-08dd4d087ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

From: George Shen <george.shen@amd.com>

[Why]
The latest DP spec requires the DP TX to read DPCD F0000h through F0009h
when detecting LTTPR capabilities for the first time.

[How]
Update LTTPR cap retrieval to read up to F0009h (two more bytes than the
previous F0007h), and store the LTTPR ALPM capabilities.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h         | 12 ++++++++++++
 .../display/dc/link/protocols/link_dp_capability.c   |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 94ce8fe74481..ae6e2d8552ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -959,6 +959,14 @@ union dp_128b_132b_supported_lttpr_link_rates {
 	uint8_t raw;
 };
 
+union dp_alpm_lttpr_cap {
+	struct {
+		uint8_t AUX_LESS_ALPM_SUPPORTED	:1;
+		uint8_t RESERVED				:7;
+	} bits;
+	uint8_t raw;
+};
+
 union dp_sink_video_fallback_formats {
 	struct {
 		uint8_t dp_1024x768_60Hz_24bpp_support	:1;
@@ -1118,6 +1126,7 @@ struct dc_lttpr_caps {
 	uint8_t max_ext_timeout;
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
+	union dp_alpm_lttpr_cap alpm;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
 };
 
@@ -1370,6 +1379,9 @@ struct dp_trace {
 #ifndef DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP
 #define DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP    0x221c
 #endif
+#ifndef DP_LTTPR_ALPM_CAPABILITIES
+#define DP_LTTPR_ALPM_CAPABILITIES              0xF0009
+#endif
 #ifndef DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE	0x50
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 44c3023a7731..80439224acca 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1502,7 +1502,7 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8] = {0};
+	uint8_t lttpr_dpcd_data[10] = {0};
 	enum dc_status status;
 	bool is_lttpr_present;
 
@@ -1552,6 +1552,10 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 			lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
 							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+	link->dpcd_caps.lttpr_caps.alpm.raw =
+			lttpr_dpcd_data[DP_LTTPR_ALPM_CAPABILITIES -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
 	/* If this chip cap is set, at least one retimer must exist in the chain
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
 	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-- 
2.34.1

