Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA39BCA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7428D10E08C;
	Tue,  2 Sep 2025 00:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZgJiUbE5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15D910E08C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQQC3YPtEn9P5cHBrMILyFZoeFGgvtOxdbbdv4jnZtl48/iW+G6wCltYiXJKHTG6XWsWwQbhQ0caJlsWQ14NJ23rS2f4wftJHvSuzNs42WymQwQf3LIcgiXktObQpAA8Yyz6Gg2+R58bucHYlv7VT7eVyTv3R8nw5FyEe3JQvdYQf5eaA8qw8KKjjKVGhBbcAJP/WWGDn3N0RNTfUF+ziXYkb/KUS+0Epg9WBjadn8qjvADRzQFk4NdkoFpxK02fNesjVrcScA5QVPsdmVuiWGKba6BYdrcKEm3cUht0TMO5Z44wtZIAOmEh5JvESIpR9gp5lK7Edu/7Fcwv3BTJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99kzFm8MZ6v0wQazEgHaPMmUq4zbCZQ3eta/WnemtHY=;
 b=Rk26TsgDbzhOs0CWQNn+1gBA5KB8nOfZ91shevusIeWMz9qddkJBbN1eCd2KsqM/j/qfksafSDTlEeV4K6NIV3PsEO3GSG0j+lyeAoXLX2yN0xhvwJY0reUkwo6MabCVx1sq1ZNfV9BBM2n7ecwfPldYiCpqYPYYRUpDntLk+At6kIykKAKI0GNhXxafu5MBOZYNKKR4Nhzo52eWjBrnpL3MCiyow8FakDCFwf5n89wr4pOFVyH7Gps7FC9pXC4oFtoHUn3linopeBEAkM72D5Ov3to62mHGKFqdFlyXPS3Ld/Ex3afjJ/tCrtSF8ryqBc9hTf6Mk/CqJpVcadiIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99kzFm8MZ6v0wQazEgHaPMmUq4zbCZQ3eta/WnemtHY=;
 b=ZgJiUbE50KcRbUexOZS/yz/6BmUPrugC14XAhNUwKIlW6Ekqa/y5SqzJDMMbI9rhZkVSkxOdbcnKrRtobYze3FkuuuxnPMT3pZeAw5xCugD3paMV3CH4h70C1UM6f6FijEQOZKBpxBkH4EnPG80Jx2X6lnrrT67rC85Vg4oiic0=
Received: from CY5PR15CA0199.namprd15.prod.outlook.com (2603:10b6:930:82::16)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 00:46:07 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::24) by CY5PR15CA0199.outlook.office365.com
 (2603:10b6:930:82::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 00:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 2 Sep 2025 00:46:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:03 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:45:57 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Oleh Kuzhylnyi <okuzhyln@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 01/11] drm/amd/display: Add HDCP policy control
Date: Tue, 2 Sep 2025 08:42:46 +0800
Message-ID: <20250902004532.1833436-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f4ed82-993b-464d-261a-08dde9ba1a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YzhDA8B9LUQT0aEEA+PJQnvC7JVhSLTCdvSdaWPtqEEiz9e7fftk43Xjy9nl?=
 =?us-ascii?Q?WbQ+IbwhE0WNRGppr+aqaWLaocLEsJXiM1BngkSh77Qu5o8Ow43Y7edyYvco?=
 =?us-ascii?Q?lPjcL+N59U03bW+1Zr5fBfQCrCvm7PG9O+n4ypIPkx05Fudk88WQERPLj5fZ?=
 =?us-ascii?Q?a+T/ubOa9Lpbl6YziLE+rbJClodjd5UGD0BFA49JlzUWRvew9vpQNyKATfiZ?=
 =?us-ascii?Q?hQm51SX9+409kFyRi7D42zyK/9WN64E44GKWaqUZaY0D/uIeL6rvDgHMk3WO?=
 =?us-ascii?Q?blRZKejsBDi54sLPxlZdHdh7OxF6Ji/9OTNYdqeJB+bt5r/6Lew53tNQeBt4?=
 =?us-ascii?Q?VhAA4tvSNHrCdm2tFBZwHuJNkwn4OcoiC46cUc3UXKVn/EF9aIs3shS2VyCR?=
 =?us-ascii?Q?O+7nNK4EaAEt5XMJTuGSlLddsKipk3IQhH8z2r4SsJtBV7QJaZoCK4B0xla+?=
 =?us-ascii?Q?AxhLoQi6geZ/RyV7Nfpu2C/oGkmNFrfkPyOMukfvQInKV3CuMv3CfsuPssTk?=
 =?us-ascii?Q?xGeXhRW68S+68ZhjBcXzK9uNDCSHW88RtFmM7rUdQNtv2OfL9zi4jsrEFTXe?=
 =?us-ascii?Q?GvB6tqLWF36klwWSrO8+zl+6tV4/Y9rakKsSLc3Uc9AhCC2xAD1fYYr6nNX4?=
 =?us-ascii?Q?1/j0AzTYiVifKJS/PpNYhYMeTJkHALp25zGSNdwJwwoRSXLZJGnynd3nCu7e?=
 =?us-ascii?Q?ydyZnDNwJjWiKUIUuORb7SjQseWjLd0tFZismZV0Q2X0jSiPxuLRF/NVaiIe?=
 =?us-ascii?Q?Jmh9FRiGCobnJQYrwjxVWDZYMqZ7DnNCdTaTdmLEkbHwpTsbeyfDjj2M8uQL?=
 =?us-ascii?Q?cT+qvrNpXyQ5sgv+LA590bqgWncmhnnp7JNEknvIINWqGKzr/Ry2e9EPBuui?=
 =?us-ascii?Q?QOYwzZn/q7p0Xp8PGeCp8BPQFVyGwqw+gjrNQumH5imRhjynp9qcQfr6Nqvr?=
 =?us-ascii?Q?ActyTaE/tWPuM1+sDHyEKtsgQT9eMlD5hK3HcRPZ+OdZy1YQCJ5+cZXJlC17?=
 =?us-ascii?Q?/shgB3z0NDIi+lrx/sfOjeXAcsJFV1DnKBg434YUhryGEVI8WuJ5wdrjhHik?=
 =?us-ascii?Q?PbTbnwwkoPLv6X0wnZtZ4uyY7y6SanE41DDtT/ePclIMyjx4TjGL4l10xsDv?=
 =?us-ascii?Q?qVQzqQaaP90G6T5Km/Wi956Om/pUIMY5OYa/p6sL5/IRGk1WlcQ5RTUiGDCt?=
 =?us-ascii?Q?canqxhatHV2gXyiygV//l+Mct6GVQokoQlmWVC9850ORicAjGQ+zyxXCBwO3?=
 =?us-ascii?Q?RIPzmUmb3wNtp6u5Qn+ndT5iQz/EA41Wa4KdA4bIeMISx7EYCO8MgY8AGkJh?=
 =?us-ascii?Q?aik/80VXivGaM1GZtYFo/gmFeI5u8VwPAPryk/pt7fzK3uyJiEr7ikobq0xg?=
 =?us-ascii?Q?gtWF9IxWm539tTU/qVgcP5Imk0upUxjC5V2fvZ+Fpd1WavWYfu+u4lbjQK/t?=
 =?us-ascii?Q?3m7N0REtg9GYWANFJB0rB+TSw2tD19t7VGvp6jTcZxWRl55XNwnzE/NHgiYH?=
 =?us-ascii?Q?otjM8S8NVnFDcIs6YfX7i1k6kDapSSVI/hwLulkjytgiSMoHC8KdWJVZ+Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:06.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f4ed82-993b-464d-261a-08dde9ba1a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
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

From: Oleh Kuzhylnyi <okuzhyln@amd.com>

[Why]
DM should be able to control HDCP retry limit via configurable
parameter.

[How]
Expose a retry_limit parameter for controlling the maximum number of
retries and lift the hardcode out to DM.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Oleh Kuzhylnyi <okuzhyln@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 ++
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c        | 5 +++--
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h     | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index d1c853732c2e..5aae5c25e785 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -223,6 +223,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 		display_adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
 
 		link_adjust.auth_delay = 2;
+		link_adjust.retry_limit = MAX_NUM_OF_ATTEMPTS;
 
 		if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
 			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
@@ -572,6 +573,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.usb4_enabled = config->usb4_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 2;
+	link->adjust.retry_limit = MAX_NUM_OF_ATTEMPTS;
 	link->adjust.hdcp1.disable = 0;
 	hdcp_w->encryption_status[display->index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 5e01c6e24cbc..c760216a6240 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -29,6 +29,7 @@ static void push_error_status(struct mod_hdcp *hdcp,
 		enum mod_hdcp_status status)
 {
 	struct mod_hdcp_trace *trace = &hdcp->connection.trace;
+	const uint8_t retry_limit = hdcp->connection.link.adjust.retry_limit;
 
 	if (trace->error_count < MAX_NUM_OF_ERROR_TRACE) {
 		trace->errors[trace->error_count].status = status;
@@ -39,11 +40,11 @@ static void push_error_status(struct mod_hdcp *hdcp,
 
 	if (is_hdcp1(hdcp)) {
 		hdcp->connection.hdcp1_retry_count++;
-		if (hdcp->connection.hdcp1_retry_count == MAX_NUM_OF_ATTEMPTS)
+		if (hdcp->connection.hdcp1_retry_count == retry_limit)
 			hdcp->connection.link.adjust.hdcp1.disable = 1;
 	} else if (is_hdcp2(hdcp)) {
 		hdcp->connection.hdcp2_retry_count++;
-		if (hdcp->connection.hdcp2_retry_count == MAX_NUM_OF_ATTEMPTS)
+		if (hdcp->connection.hdcp2_retry_count == retry_limit)
 			hdcp->connection.link.adjust.hdcp2.disable = 1;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index c42468bb70ac..b51ddf2846df 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -220,6 +220,7 @@ struct mod_hdcp_link_adjustment_hdcp2 {
 
 struct mod_hdcp_link_adjustment {
 	uint8_t auth_delay;
+	uint8_t retry_limit;
 	struct mod_hdcp_link_adjustment_hdcp1 hdcp1;
 	struct mod_hdcp_link_adjustment_hdcp2 hdcp2;
 };
-- 
2.43.0

