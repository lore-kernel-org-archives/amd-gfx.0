Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620CEC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88B2112BFD;
	Mon, 22 Apr 2024 15:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="damVAmY4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F07112BFC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHkmIccgqxICOu9fxueRKgf7+aNp00/aWE0ldGs/fZI7jlR3+djoyhYfwkazHj+Pb+nVCw+rqs3T5BOiRSymSaZlVv2fArC8SNTnHp+VuIWyREouIVHPEqWGYweeQrkF3BuPt5/qCBQU1F082fTIJZt4MOzZcGe2FEYjmvpz03d5Gmiig/ipsj1yqesKodfNFlE3gbWSlGffcDcZ6dxUhfePK17HDTLEiUHnqmyDSCQ7eEJYYOErf7GjwpTc9lqoeOwF+I0z+GJlCkJUFLm1IyN+Icx0G+14Jyi3fd9jHzHjyo6TdsrKIVbDES801l0BZ3rZ8h35/OM2boL5Gbwv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACgUbfaiyGW5ctEzRB5rzB9/lj+mnztjhfcxV88mZK8=;
 b=ONc5gWfbPtVJfXRqYi6hRF2RWcjrgRzDONhF4RkqjtNoqqHzGsYj1u4ocY7WnRT+5qklVCvaYUGx0lJq204XdbQmUWIoTjchP42/bJMGUnFw2Z9kNppr1fiUYWOeezphdkoeOAiwjZpx+Otq3lurnIS3OFm+/djdikuZh6Rq3Q1VUDaD6VvrMapgkMOhpErEqoT9BJytPZNMKA7xau1i6kQpX4HXgOYso1jalssB7dEWGxxLZOhvIoPem0gCCbuIUmoAqvvrozRFIJ/Xw19ZhybAuNQva6T/fqRvN62nXXtgPLkr8kG6LJxUpeHetFCpK+hAAxlF9Q9Hwxh8bNxZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACgUbfaiyGW5ctEzRB5rzB9/lj+mnztjhfcxV88mZK8=;
 b=damVAmY4oNVtrzzlZRnwEOk+tQeoLSgA3IKEnzbaBRNuUGjQD7Yk4jmDa/EQDV00MLsAyTNMAe+j4xH3b0kNfzzt4tMtXezXQ8rTeZvfHAUaEcWCRMMM6ndl8NaEzHnqsjfqEPgh20FGVkGQP/rC+B6rMgBDzlB1mFY1qtxpEf4=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 15:30:31 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::71) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:30:29 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ethan Bitnun <etbitnun@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 23/37] drm/amd/display: Block FPO According to Luminance Delta
Date: Mon, 22 Apr 2024 11:27:32 -0400
Message-ID: <20240422152817.2765349-24-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: a90d1fe0-f7a3-4ddc-88d7-08dc62e12536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pPnCHliJnaT+iF8pC9Z58tGbw8+Y5cXxEq7A1JZc9ZdOzP9WapjaOerFgZX/?=
 =?us-ascii?Q?0AeDZMIsco/JLrOM3Gu+d3+6SS/NwCuhyZAY0/1s626dOcuaZbO1ESU3875f?=
 =?us-ascii?Q?z7AR3JsSaOn32PjpDsaftpUi0SlJfSePRPc1WabKoCn6She98bA/cjr2Yifx?=
 =?us-ascii?Q?spYcz8OVRdm+QEZu8JeivmdYwJ3EaaNKGQkf3h8oesfIK/+fztVaTHFBmQx1?=
 =?us-ascii?Q?VzFGU3qIzDG69haOmjI86TpU2WqHs9WbiqIzmOrHDfT1ikORtMdnvPwrMLNy?=
 =?us-ascii?Q?H6qGt+rRKlsn1+bid9gBQjhKUaGOSKltSReB1PZ5eWdKazxv6a5nHsTYy7uc?=
 =?us-ascii?Q?ghKd24VAUl+y8ocOZjPoiafc3B9uYDzJRLWJbhcatuBMGj7+eIMgDA9IC4l2?=
 =?us-ascii?Q?9gAc1N5L6nF/ZLYKgK/B7Dpshc/jHZmwC05Ds+nkguL1sI3tVcurJz0ipg9P?=
 =?us-ascii?Q?irmTKG1Itz0uEl7yerNVEpw5+DRJeM8NfGtKLEIzbpxL+wV195UiiGH3eJg1?=
 =?us-ascii?Q?vL/hbCHjZJx9YnDtKwEQeH+LdNT6LJCoKOyrcKWkG/IwkDYAYC1g5vYAZ4IF?=
 =?us-ascii?Q?2uv/v1C3aCZDK2OFC2xqP0UvA9+vtbReeSYbl6Qta3jgUvYO+J7z3tZrHPpO?=
 =?us-ascii?Q?U2+9P69YStcWFiUDjkYBnkN5FFaxL9tjfvJuAH2p+9sma1yEuh24qayzKA/B?=
 =?us-ascii?Q?k+nTVdIFe522b105W6vTePryDCymmW+gArgy0+7XvUwbn5u1Jc5cpm6NM6Sg?=
 =?us-ascii?Q?xaCARG5AiBcltkv7BPaP+0lflmgQdIMg3pKXVyGFS2PSnc4CFDuHcZ+Y1FIH?=
 =?us-ascii?Q?/pWIkc5fMGmotoEEtfpbnL3oTpSAiTqkPqq+xpTS+5z4KkMdpfTbffHochWo?=
 =?us-ascii?Q?Q9u1Velc63KKYHRntOSYwkzRXA1t6Ak+iWt4Qpl84eROhTz41K92oz5YW1VG?=
 =?us-ascii?Q?PgmMO4j75U2ET8eS/fofclaK/Kdi8SbVqPSLMsm3qoTjKpa6xeBh2B5P4FTo?=
 =?us-ascii?Q?mXnsPDFGvrp3qyk8Y4H+OOprokBpA21FnYZ5gHkQ4Zxn9GR75fOUChs7YCR2?=
 =?us-ascii?Q?pAtm7Ad6Soom2tayqzTU6jWL9XPwsvMVeEwTor4zWGUwdhFL5ks7vQJ3I3Bj?=
 =?us-ascii?Q?PWnIb70uyamVI+lzQ/YYgrbBoHr6Z4nwoLqatROnmEjiyEgxXMNVBet64+89?=
 =?us-ascii?Q?UCdhKOuXQE7KM4h0XD2SfduwvNadrZM0jlsDb0hydpzgMz1H91hkLKVsVAYc?=
 =?us-ascii?Q?Z0lJb8fn9McSP00BwiqtmN/Ths0oa8QFl6T6UDcFRz149E5uhoCKo80/Ezs/?=
 =?us-ascii?Q?lyxuhH5yYFSqZlon5ni84E8DgfMiYdgJsMcRwbT9kv5yON+MDDP9C5Vn2jyh?=
 =?us-ascii?Q?oqefeG7boNsMXzWTbwubcxvtI2IQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:31.0168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90d1fe0-f7a3-4ddc-88d7-08dc62e12536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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

From: Ethan Bitnun <etbitnun@amd.com>

[Description]
 - Block FPO if the max stretch refresh rate is low enough
   to cause a flicker by storing the maximum safe refresh
   decrease from nominal in stream.
 - Brought over various Freesync Luminance functions to dc. Use these
   new functions to block fpo if we will flicker.
 - Generalized increase/reduce dependent functions to reduce code clutter
   and allow for easier use.
 - Added a debug option to enable the feature. Disabled by default.

Co-authored-by: Ethan Bitnun <etbitnun@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 228 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  14 ++
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   |  24 ++
 .../display/dc/dcn32/dcn32_resource_helpers.c |   9 +-
 5 files changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 5c7e4884cac2..d3201b0b3a09 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -35,6 +35,8 @@
 #include "dc_stream_priv.h"
 
 #define DC_LOGGER dc->ctx->logger
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#define MAX(x, y) ((x > y) ? x : y)
 
 /*******************************************************************************
  * Private functions
@@ -781,3 +783,229 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 	}
 }
 
+/*
+ * Finds the greatest index in refresh_rate_hz that contains a value <= refresh
+ */
+static int dc_stream_get_nearest_smallest_index(struct dc_stream_state *stream, int refresh)
+{
+	for (int i = 0; i < (LUMINANCE_DATA_TABLE_SIZE - 1); ++i) {
+		if ((stream->lumin_data.refresh_rate_hz[i] <= refresh) && (refresh < stream->lumin_data.refresh_rate_hz[i + 1])) {
+			return i;
+		}
+	}
+	return 9;
+}
+
+/*
+ * Finds a corresponding brightness for a given refresh rate between 2 given indices, where index1 < index2
+ */
+static int dc_stream_get_brightness_millinits_linear_interpolation (struct dc_stream_state *stream,
+								     int index1,
+								     int index2,
+								     int refresh_hz)
+{
+	int slope = 0;
+	if (stream->lumin_data.refresh_rate_hz[index2] != stream->lumin_data.refresh_rate_hz[index1]) {
+		slope = (stream->lumin_data.luminance_millinits[index2] - stream->lumin_data.luminance_millinits[index1]) /
+			    (stream->lumin_data.refresh_rate_hz[index2] - stream->lumin_data.refresh_rate_hz[index1]);
+	}
+
+	int y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
+
+	return (y_intercept + refresh_hz * slope);
+}
+
+/*
+ * Finds a corresponding refresh rate for a given brightness between 2 given indices, where index1 < index2
+ */
+static int dc_stream_get_refresh_hz_linear_interpolation (struct dc_stream_state *stream,
+							   int index1,
+							   int index2,
+							   int brightness_millinits)
+{
+	int slope = 1;
+	if (stream->lumin_data.refresh_rate_hz[index2] != stream->lumin_data.refresh_rate_hz[index1]) {
+		slope = (stream->lumin_data.luminance_millinits[index2] - stream->lumin_data.luminance_millinits[index1]) /
+				(stream->lumin_data.refresh_rate_hz[index2] - stream->lumin_data.refresh_rate_hz[index1]);
+	}
+
+	int y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
+
+	return ((brightness_millinits - y_intercept) / slope);
+}
+
+/*
+ * Finds the current brightness in millinits given a refresh rate
+ */
+static int dc_stream_get_brightness_millinits_from_refresh (struct dc_stream_state *stream, int refresh_hz)
+{
+	int nearest_smallest_index = dc_stream_get_nearest_smallest_index(stream, refresh_hz);
+	int nearest_smallest_value = stream->lumin_data.refresh_rate_hz[nearest_smallest_index];
+
+	if (nearest_smallest_value == refresh_hz)
+		return stream->lumin_data.luminance_millinits[nearest_smallest_index];
+
+	if (nearest_smallest_index >= 9)
+		return dc_stream_get_brightness_millinits_linear_interpolation(stream, nearest_smallest_index - 1, nearest_smallest_index, refresh_hz);
+
+	if (nearest_smallest_value == stream->lumin_data.refresh_rate_hz[nearest_smallest_index + 1])
+		return stream->lumin_data.luminance_millinits[nearest_smallest_index];
+
+	return dc_stream_get_brightness_millinits_linear_interpolation(stream, nearest_smallest_index, nearest_smallest_index + 1, refresh_hz);
+}
+
+/*
+ * Finds the lowest refresh rate that can be achieved
+ * from starting_refresh_hz while staying within flicker criteria
+ */
+static int dc_stream_calculate_flickerless_refresh_rate(struct dc_stream_state *stream,
+							 int current_brightness,
+							 int starting_refresh_hz,
+							 bool is_gaming,
+							 bool search_for_max_increase)
+{
+	int nearest_smallest_index = dc_stream_get_nearest_smallest_index(stream, starting_refresh_hz);
+
+	int flicker_criteria_millinits = is_gaming ?
+					 stream->lumin_data.flicker_criteria_milli_nits_GAMING :
+					 stream->lumin_data.flicker_criteria_milli_nits_STATIC;
+
+	int safe_upper_bound = current_brightness + flicker_criteria_millinits;
+	int safe_lower_bound = current_brightness - flicker_criteria_millinits;
+	int lumin_millinits_temp = 0;
+
+	int offset = -1;
+	if (search_for_max_increase) {
+		offset = 1;
+	}
+
+	/*
+	 * Increments up or down by 1 depending on search_for_max_increase
+	 */
+	for (int i = nearest_smallest_index; (i > 0 && !search_for_max_increase) || (i < (LUMINANCE_DATA_TABLE_SIZE - 1) && search_for_max_increase); i += offset) {
+
+		lumin_millinits_temp = stream->lumin_data.luminance_millinits[i + offset];
+
+		if ((lumin_millinits_temp >= safe_upper_bound) || (lumin_millinits_temp <= safe_lower_bound)) {
+
+			if (stream->lumin_data.refresh_rate_hz[i + offset] == stream->lumin_data.refresh_rate_hz[i])
+				return stream->lumin_data.refresh_rate_hz[i];
+
+			int target_brightness = (stream->lumin_data.luminance_millinits[i + offset] >= (current_brightness + flicker_criteria_millinits)) ?
+											current_brightness + flicker_criteria_millinits :
+											current_brightness - flicker_criteria_millinits;
+
+			int refresh = 0;
+
+			/*
+			 * Need the second input to be < third input for dc_stream_get_refresh_hz_linear_interpolation
+			 */
+			if (search_for_max_increase)
+				refresh = dc_stream_get_refresh_hz_linear_interpolation(stream, i, i + offset, target_brightness);
+			else
+				refresh = dc_stream_get_refresh_hz_linear_interpolation(stream, i + offset, i, target_brightness);
+
+			if (refresh == stream->lumin_data.refresh_rate_hz[i + offset])
+				return stream->lumin_data.refresh_rate_hz[i + offset];
+
+			return refresh;
+		}
+	}
+
+	if (search_for_max_increase)
+		return stream->lumin_data.refresh_rate_hz[LUMINANCE_DATA_TABLE_SIZE - 1];
+	else
+		return stream->lumin_data.refresh_rate_hz[0];
+}
+
+/*
+ * Gets the max delta luminance within a specified refresh range
+ */
+static int dc_stream_get_max_delta_lumin_millinits(struct dc_stream_state *stream, int hz1, int hz2, bool isGaming)
+{
+	int lower_refresh_brightness = dc_stream_get_brightness_millinits_from_refresh (stream, hz1);
+	int higher_refresh_brightness = dc_stream_get_brightness_millinits_from_refresh (stream, hz2);
+
+	int min = lower_refresh_brightness;
+	int max = higher_refresh_brightness;
+
+	/*
+	 * Static screen, therefore no need to scan through array
+	 */
+	if (!isGaming) {
+		if (lower_refresh_brightness >= higher_refresh_brightness) {
+			return lower_refresh_brightness - higher_refresh_brightness;
+		}
+		return higher_refresh_brightness - lower_refresh_brightness;
+	}
+
+	min = MIN(lower_refresh_brightness, higher_refresh_brightness);
+	max = MAX(lower_refresh_brightness, higher_refresh_brightness);
+
+	int nearest_smallest_index = dc_stream_get_nearest_smallest_index(stream, hz1);
+
+	for (; nearest_smallest_index < (LUMINANCE_DATA_TABLE_SIZE - 1) &&
+			stream->lumin_data.refresh_rate_hz[nearest_smallest_index + 1] <= hz2 ; nearest_smallest_index++) {
+		min = MIN(min, stream->lumin_data.luminance_millinits[nearest_smallest_index + 1]);
+		max = MAX(max, stream->lumin_data.luminance_millinits[nearest_smallest_index + 1]);
+	}
+
+	return (max - min);
+}
+
+/*
+ * Finds the highest refresh rate that can be achieved
+ * from starting_refresh_hz while staying within flicker criteria
+ */
+int dc_stream_calculate_max_flickerless_refresh_rate(struct dc_stream_state *stream, int starting_refresh_hz, bool is_gaming)
+{
+	if (!stream->lumin_data.is_valid)
+		return 0;
+
+	int current_brightness = dc_stream_get_brightness_millinits_from_refresh(stream, starting_refresh_hz);
+
+	return dc_stream_calculate_flickerless_refresh_rate(stream,
+							    current_brightness,
+							    starting_refresh_hz,
+							    is_gaming,
+							    true);
+}
+
+/*
+ * Finds the lowest refresh rate that can be achieved
+ * from starting_refresh_hz while staying within flicker criteria
+ */
+int dc_stream_calculate_min_flickerless_refresh_rate(struct dc_stream_state *stream, int starting_refresh_hz, bool is_gaming)
+{
+	if (!stream->lumin_data.is_valid)
+			return 0;
+
+	int current_brightness = dc_stream_get_brightness_millinits_from_refresh(stream, starting_refresh_hz);
+
+	return dc_stream_calculate_flickerless_refresh_rate(stream,
+							    current_brightness,
+							    starting_refresh_hz,
+							    is_gaming,
+							    false);
+}
+
+/*
+ * Determines if there will be a flicker when moving between 2 refresh rates
+ */
+bool dc_stream_is_refresh_rate_range_flickerless(struct dc_stream_state *stream, int hz1, int hz2, bool is_gaming)
+{
+
+	/*
+	 * Assume that we wont flicker if there is invalid data
+	 */
+	if (!stream->lumin_data.is_valid)
+		return false;
+
+	int dl = dc_stream_get_max_delta_lumin_millinits(stream, hz1, hz2, is_gaming);
+
+	int flicker_criteria_millinits = (is_gaming) ?
+					  stream->lumin_data.flicker_criteria_milli_nits_GAMING :
+					  stream->lumin_data.flicker_criteria_milli_nits_STATIC;
+
+	return (dl <= flicker_criteria_millinits);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9d235fc3525d..1e28a36a76e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -456,6 +456,7 @@ struct dc_config {
 	bool allow_0_dtb_clk;
 	bool use_assr_psp_message;
 	bool support_edp0_on_dp1;
+	unsigned int enable_fpo_flicker_detection;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e5dbbc6089a5..3d0adf8838ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -160,6 +160,18 @@ struct dc_stream_debug_options {
 	char force_odm_combine_segments;
 };
 
+#define LUMINANCE_DATA_TABLE_SIZE 10
+
+struct luminance_data {
+	bool is_valid;
+	int refresh_rate_hz[LUMINANCE_DATA_TABLE_SIZE];
+	int luminance_millinits[LUMINANCE_DATA_TABLE_SIZE];
+	int flicker_criteria_milli_nits_GAMING;
+	int flicker_criteria_milli_nits_STATIC;
+	int nominal_refresh_rate;
+	int dm_max_decrease_from_nominal;
+};
+
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
@@ -286,6 +298,8 @@ struct dc_stream_state {
 	bool vblank_synchronized;
 	bool fpo_in_use;
 	bool is_phantom;
+
+	struct luminance_data lumin_data;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h b/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h
index 7476fd52ce2b..ea13804f7b14 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h
@@ -34,4 +34,28 @@ void dc_stream_destruct(struct dc_stream_state *stream);
 
 void dc_stream_assign_stream_id(struct dc_stream_state *stream);
 
+/*
+ * Finds the highest refresh rate that can be achieved
+ * from starting_freq while staying within flicker criteria
+ */
+int dc_stream_calculate_max_flickerless_refresh_rate(struct dc_stream_state *stream,
+						      int starting_refresh_hz,
+						      bool is_gaming);
+
+/*
+ * Finds the lowest refresh rate that can be achieved
+ * from starting_freq while staying within flicker criteria
+ */
+int dc_stream_calculate_min_flickerless_refresh_rate(struct dc_stream_state *stream,
+						      int starting_refresh_hz,
+						      bool is_gaming);
+
+/*
+ * Determines if there will be a flicker when moving between 2 refresh rates
+ */
+bool dc_stream_is_refresh_rate_range_flickerless(struct dc_stream_state *stream,
+						  int hz1,
+						  int hz2,
+						  bool is_gaming);
+
 #endif // _DC_STREAM_PRIV_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index fbcd6f7bc993..6472da2c361e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -29,6 +29,7 @@
 #include "dml/dcn32/display_mode_vba_util_32.h"
 #include "dml/dcn32/dcn32_fpu.h"
 #include "dc_state_priv.h"
+#include "dc_stream_priv.h"
 
 static bool is_dual_plane(enum surface_pixel_format format)
 {
@@ -459,7 +460,7 @@ static int get_frame_rate_at_max_stretch_100hz(
 }
 
 static bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(
-		struct dc_stream_state *fpo_candidate_stream, uint32_t fpo_vactive_margin_us)
+		struct dc_stream_state *fpo_candidate_stream, uint32_t fpo_vactive_margin_us, int current_refresh_rate)
 {
 	int refresh_rate_max_stretch_100hz;
 	int min_refresh_100hz;
@@ -473,6 +474,10 @@ static bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(
 	if (refresh_rate_max_stretch_100hz < min_refresh_100hz)
 		return false;
 
+	if (fpo_candidate_stream->ctx->dc->config.enable_fpo_flicker_detection > 0 &&
+			!dc_stream_is_refresh_rate_range_flickerless(fpo_candidate_stream, (refresh_rate_max_stretch_100hz / 100), current_refresh_rate, false))
+		return false;
+
 	return true;
 }
 
@@ -569,7 +574,7 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 		return NULL;
 
 	fpo_vactive_margin_us = is_fpo_vactive ? dc->debug.fpo_vactive_margin_us : 0; // For now hardcode the FPO + Vactive stretch margin to be 2000us
-	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(fpo_candidate_stream, fpo_vactive_margin_us))
+	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(fpo_candidate_stream, fpo_vactive_margin_us, refresh_rate))
 		return NULL;
 
 	if (!fpo_candidate_stream->allow_freesync)
-- 
2.44.0

