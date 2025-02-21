Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65775C021B7
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C85F10EAEA;
	Fri, 21 Feb 2025 16:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q4foYJHz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81C410EAE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK4bfB8SGMbEOowm/PVoacBVD+Da8AMJxYChG+vYeVICm4XGSB/Gxip4ZrhRliFzf237ehZ+CUpBSjw+ozMKfXcB3Zij0VhD1uwX2pEikhzPrea98QuhfI74Ajkp9ApEMz44D8l30/7nNyPB5fR/TK8gPpRxolbOPPqZdZKU6lm1Qnc0vUoOz/f/ImPBIWfFiiP4bPneRK0dnJ1WJkhl61VZKMPBlCAsR8r39DLicBHQOWTTx5dPS9FXCaYWdVwK3mK65Ls/3CTwYH2Epa4qXke/hj7zy8DcpmlzwfAZzHYCWcZe+1KS0DRggTFjHwGcDh7hrJgWr1MkrWYHH/r7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYltbgs8JKvcEd/Mr3Zic/+NzWV8sM6lKIgfIwZEhis=;
 b=mjCMejZKQrR9v1Dvqti805zA58HHBLvHQETYbaPwbhmshPql5Hl+CcG4uz5/V3ZqE54NitRe4b10NA25I1Hvo55Eg9hbLklXL38WGzPY+r9bhgLeYHmvJ3TgIepGr6OxD/JjDF7qY5bQVDVbIOVPhwXisW932cFXhJuAGwseSuQGm5mtQT2pjjbtOc2i50AUnvxeHWQ/UQAXvpaCUkFTTKQLE6UFBmeL9Jy7KFxF+WTNsgwOCMiTG509Y9L9ni4HcfYDhTL0+HSdUt4JpBXOSl97t5EbKHoayYYb7Rcz1TEj4dieXE7aFSRnRsT+k5ZASZXIsDLFCVhmBNbWsQx/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYltbgs8JKvcEd/Mr3Zic/+NzWV8sM6lKIgfIwZEhis=;
 b=Q4foYJHzwTo8EFMCCQmSXPbtrb2X7IYQd5HAe2Q6ulJMI2OJO6xinVukLgCtiOZbClVoeKJDDf1JaZjhQ9l/7TliUccZcoa6DlFeulZX2VXp0G+hStOwt5b8/6R5Ccuc3SAuPpD87zYKhyH7U+lxr80ls0nPmf142F20vklTIEk=
Received: from PH7PR17CA0060.namprd17.prod.outlook.com (2603:10b6:510:325::24)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:33 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::13) by PH7PR17CA0060.outlook.office365.com
 (2603:10b6:510:325::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 16:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:33 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:23 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Michael Strauss <michael.strauss@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Update FIXED_VS Link Rate Toggle
 Workaround Usage
Date: Fri, 21 Feb 2025 11:01:38 -0500
Message-ID: <20250221160145.1730752-18-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4bfb4a-d677-44af-cd25-08dd52912711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wRWFNx7YfnRZHKu6j1XewghOOOWHXngob43h7wv53NXlRAz++mW/9EWMtR2Y?=
 =?us-ascii?Q?4rMSRS75Jwc5/lPxH/gsipnrEx+IeEKjHZfBxSrOdp4yqMI2PKMg4lfjTrCL?=
 =?us-ascii?Q?RMIqRoY6m3qePysFPjb1lj/AhfX7ApVEKXvOwLmfAnyVb6zi9HTQUGP0pR5p?=
 =?us-ascii?Q?S7IXE8lnBtjhocEd7EZ8tXpEQIYLmozBWS9QDwHh+PtEHr1JUhkr6rVe0Oyu?=
 =?us-ascii?Q?jovD3ouMxBY24ZenRs3ThbN+x0aGQz38zSdaX3L3zArBoTjPnM8BIh1S3boD?=
 =?us-ascii?Q?umrVZjXsqnvqR3gCombkj0mfem67l/MTUIPVM5pzcZSbAdBw/FEzf2UZeDHb?=
 =?us-ascii?Q?9qlvczqfiS7OtkAEnuCRuGiwcawoyVPy34Fc88HeKVst3ctbAbLTzA8GUCJN?=
 =?us-ascii?Q?TxpUfR3d9hf9v37iSfQWYHvQEM30h7E9ihxVhFAjyrxfPFyrfoPo13tIAUQx?=
 =?us-ascii?Q?fZUmN+hlMUWRnn7BzO4c3m1soA+RKk4L/k04ZzMFWfBYiSEufAHugnZ2OR5i?=
 =?us-ascii?Q?YLC8UKesBQVB2TspbWcsOhOC1Q5S/j3BBa/RcWYeShrxZ8APIPG+rwST1HC5?=
 =?us-ascii?Q?6KrjKXUrJCUXHcgfqsHgKI4XYByQujrQ583DXn5MlAKb028LPFZyiI2fUAno?=
 =?us-ascii?Q?2rKZ6KVA8h5cXbGqa4YzGFcq0ZZ7x9K9b0pOBxutR3RCtqmncZkB/jsZBMdt?=
 =?us-ascii?Q?nFyVQWdwYKv/gyDThQVcwEQax+vIjeZalm5/T2jH7Rz4mj0FFeiq4Peryl+f?=
 =?us-ascii?Q?IoQrwA3fRouFleOobHRabj7WETG7bL1InM7S7oTavoo7Ku43OIp7OX/lR6rg?=
 =?us-ascii?Q?nba7MQuTIaxF7sSYJ7qOincSHPMDgkoHIH3iDxiqaA/XOLy5xzhgkMlBSe0s?=
 =?us-ascii?Q?9NgpUb1nslir/1l5rB3gf0UZgv5yGHuAg2RKwoAltn7A53IrekydOHKb5zIg?=
 =?us-ascii?Q?qz+wh55edRPatp3/jINWpw0BRtSXGkU1fDp9pw9r1xgmYcF4Ps5FP1LN33RX?=
 =?us-ascii?Q?4cO8vpC8wdAfFKi9f5REudDNDVY5ILYL1XH4iJn66c9uyC9y7dNaM+pqXqjF?=
 =?us-ascii?Q?Ck7qKsB2qIXcm1TEA1tpqN6ZAaEU14GdzfvLDHkFMomriMmEADRgH+rOe07E?=
 =?us-ascii?Q?NeCFFVtWAWCcPCLRm1Ui3z2NNA/jBlNt5IPIs0/BG13MHNT0a3YBQBljzQzK?=
 =?us-ascii?Q?zAVNieweqrz5FDqJ12D5rXbzCyC8aWH1g0dUTcYf2yy67BhrF9nCm24/p5t/?=
 =?us-ascii?Q?hhxKZ7jgafmY3sUon5uXjl5VdkhhdzVi+z7vo2dfDAIM0z9dc2RqIjIXhKgg?=
 =?us-ascii?Q?x4gipCerO1kMDitNrbNhnw3rmyL83AJRlZzTMXZCJy+GC1xmnvRgSjLZZYaZ?=
 =?us-ascii?Q?EsFguTRTXZgRK4SMR2C9qhpTFHUQTGTosdDbRrd3OzLUGP+T4AwsdkDELln+?=
 =?us-ascii?Q?8qQHPc7Vs7NJpZ/Ba37HEhoHf6+tO04HdR8P3bqZGkNS0V7HqjGoOMgJ4J41?=
 =?us-ascii?Q?Vta4ABpr5/xJEJU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:33.4129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4bfb4a-d677-44af-cd25-08dd52912711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Previously the 128b/132b LTTPR support DPCD field was used to decide if
FIXED_VS training sequence required a rate toggle before initiating LT.

When running DP2.1 4.9.x.x compliance tests, emulated LTTPRs can report
no-128b/132b support which is then forwarded by the FIXED_VS retimer.
As a result this test exposes the rate toggle again, erroneously causing
failures as certain compliance sinks don't expect this behaviour.

[HOW]
Add new DPCD register defines/reads to read LTTPR IEEE OUI and device ID.

Decide whether to perform the rate toggle based on the LTTPR's IEEE OUI
which guarantees that we only perform the toggle on affected retimers.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h         |  8 ++++++++
 .../display/dc/link/protocols/link_dp_capability.c   | 12 ++++++++++--
 .../protocols/link_dp_training_fixed_vs_pe_retimer.c |  3 ++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index ae6e2d8552ac..8bb628ab7855 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1128,6 +1128,8 @@ struct dc_lttpr_caps {
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	union dp_alpm_lttpr_cap alpm;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t lttpr_ieee_oui[3];
+	uint8_t lttpr_device_id[6];
 };
 
 struct dc_dongle_dfp_cap_ext {
@@ -1391,6 +1393,12 @@ struct dp_trace {
 #ifndef DP_BRANCH_VENDOR_SPECIFIC_START
 #define DP_BRANCH_VENDOR_SPECIFIC_START     0x50C
 #endif
+#ifndef DP_LTTPR_IEEE_OUI
+#define DP_LTTPR_IEEE_OUI 0xF003D
+#endif
+#ifndef DP_LTTPR_DEVICE_ID
+#define DP_LTTPR_DEVICE_ID 0xF0040
+#endif
 /** USB4 DPCD BW Allocation Registers Chapter 10.7 **/
 #ifndef DP_TUNNELING_CAPABILITIES
 #define DP_TUNNELING_CAPABILITIES			0xE000D /* 1.4a */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index f6e0868507f7..0785c030f6a6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1575,10 +1575,18 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 	is_lttpr_present = dp_is_lttpr_present(link);
 
-	if (is_lttpr_present)
+	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
+
+	if (is_lttpr_present) {
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
-	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
+		core_link_read_dpcd(link, DP_LTTPR_IEEE_OUI, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
+		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui), "LTTPR IEEE OUI: ");
+
+		core_link_read_dpcd(link, DP_LTTPR_DEVICE_ID, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id));
+		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id), "LTTPR Device ID: ");
+	}
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index ccf8096dde29..ce174ce5579c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -270,7 +270,8 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 	rate = get_dpcd_link_rate(&lt_settings->link_settings);
 
-	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED) {
+	// Only perform toggle if FIXED_VS LTTPR reports no IEEE OUI
+	if (memcmp("\x0,\x0,\x0", &link->dpcd_caps.lttpr_caps.lttpr_ieee_oui[0], 3) == 0) {
 		/* Vendor specific: Toggle link rate */
 		toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-- 
2.34.1

