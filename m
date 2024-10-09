Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1AACEE343
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8398D10E7DB;
	Wed,  9 Oct 2024 19:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l2kRGLQT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C824C10E7DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXErGpHuLzkLHPZaMxlaEUXZ0MMYSCmBdaF8aITtzVxMzRpvd/L87iBBS+8GQZkCV9ZmVYJfRB59jOEeHtAc8x2zk7GmRX3C7ITubqWacF4esM9fpJHF5b8Qo5MTDkru5UsCx07pos/067XfwXROXzwhTKH7n25PxsL3X3ZUmFBcy0jaSamFbBPzAUx5HcF12T4Z2esPwLgvFsQ1ShXa/LKPZXKB4CrkUTVer4+6pXHWiKVHKAYlKCnTLW8lYmoKX262eCoAK4ORFX3som5eXoAX+3ebwSKiUnD0OMbJ3CheMsLYar2LIUaJuwj0SjiHbS8IrbnSV6A3bwrPs/EL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEtkil2fjSWileF5uWC5DBUjNfH5Dvop5T+GTa5icg4=;
 b=swKgfXw/bx26o8cugOzwKBSmgKlDRFj1wf9/a8pem5l6hraIeChdt1qNs+sWNXNb7A+02XNZ7MPNvhXtiHbLTrksoBltyCo7K/kL2NeTCkfmfGgJW1WrX8S8CNfM8IgFrYCBxBu9nx2wGHC2aAVJRzNn6UaiyhUzYjQhYx6pgbDoblSN2FOPt2d+xo7krIfeYHp94eSIWu4ffZTYYMX07I4QNUxsPvisPARiRzpqm7GmHeRz7AGLSb0wsJZBagEaIcYPRaeEmEAnGVf8g1fyfbXuEuU5TiMF/qyh/aWgSSbPcGELg6UGBl2w3ZoQ8oJYUOyEFtA4ICfHuIkj6uy1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEtkil2fjSWileF5uWC5DBUjNfH5Dvop5T+GTa5icg4=;
 b=l2kRGLQTclXaSCoj4ltER4dPU/FopnGWJuh+f1ql96AyE3HQgn5ep9xtfxWgu4nJQZRJi7pnikI+rceQ/Y+3yNhN0A1RTw4Hwb19eyDIBY0/8aaM/eoUnBz3/kuovTCVgxix2R1fN7t61ptSF9+7HvtM+S+2pAG4+DAxvh73/4I=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 9 Oct
 2024 19:26:05 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::1a) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:26:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:04 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Robin Chen <robin.chen@amd.com>, ChunTao Tso
 <chuntao.tso@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Read Sink emission rate capability
Date: Wed, 9 Oct 2024 15:23:38 -0400
Message-ID: <20241009192344.650118-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d190777-accc-4183-d39d-08dce89837f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h9C6M0lMD1XlAMI1omjZnaIHpfA2U+OSNaa4n8qBtTbaWyLrw10mZhJeKur+?=
 =?us-ascii?Q?dDp6gTyAtWNugsw1jvTyPYLhw1qsMD+6pgtnIsuGVuZhXFWJE5GkyivY9tpE?=
 =?us-ascii?Q?FU0gc1te6TxTkFCkWaL8jq03cHHEMPEBYfnlC1W5exwQfoZ86xtwsPvlZhMb?=
 =?us-ascii?Q?2+F2m+vUvCrvWOm6V/z2sbQIwj4ssZgPcw20oU2a9ciWmIpOsHk8Bd4ALmjF?=
 =?us-ascii?Q?DtvlTeszQuM/o0+Cg98HfDf0p0Cw0HcsOuAQ/svEMDxdW5Kdqdg2/vVoSIPl?=
 =?us-ascii?Q?gXbGHVJu+K7NwMNBkcdPIMCBSLybKmtBc9VAR9wD3o5SDvI5o7bC49okSwTn?=
 =?us-ascii?Q?DH1xL2fYVum1POGkAu6ZT9By/dIwi9LdTIq8oBVCB8i9SV10Y1CI3DxKzUcz?=
 =?us-ascii?Q?pbmF+YUOD/UCcdVMex4VSHQsS0BZT79GJhcUvkDa49lnxbnBv0SyXie6qR/g?=
 =?us-ascii?Q?5j6Z0KxTOeji0h7xj+/sHBZovrUQp7NzcmbeK1bc8ZLIUbUYPfbir2YsIL/b?=
 =?us-ascii?Q?VgDuXgTBn4SxvcXdcq5/Jql3H47m/jnjNoXMxGN2PZCBZSXv/gYdgUeoEG9c?=
 =?us-ascii?Q?rRw2ypSrdkr4IAvEenCvNzql2+6C0prEEl7lnMcH27VmQZZFogTXQ6n4MHLp?=
 =?us-ascii?Q?Mv+7CyUe79bkjFzl7xeDMwqM4Z+OkHzkr/h7GtY2Tk34+wXOa6ZXg/lHiJJ4?=
 =?us-ascii?Q?88CZ1ZUlEoyKPxUV+1N5ObpvcvqSfDxMBZj9by6tZA2gkT041dl3k6dPxJxX?=
 =?us-ascii?Q?L/9ADfxXVec+lF9uvA6hECRSklx5FDBhSPH7nBxzdJUXiI+NFzRMwrdivCkk?=
 =?us-ascii?Q?FM6WdqkHW8DcjV8gzoW5o1Jbsoj/JRgeUD9nHI388V2agQjr9JuSTDGYx8nZ?=
 =?us-ascii?Q?ZlILOa1wUB2n6Q1dHbE0ywJG93R6tcCWA4QRwv2Vvq03bPD4StekHsuK7mcK?=
 =?us-ascii?Q?yAcIooGsoQybF5Q8unO+mePQMHyguWbzb40PsKnuvHLqlqgBaClvMAKNnYDT?=
 =?us-ascii?Q?fne1a2YOdu6TF7fbe5Am1otLQBCqaVAkCFu92bpYcwpLq8iEDUrlycG/VIpT?=
 =?us-ascii?Q?Mljqc7lCpIV5BYMyibHLdG88p6ZG2lIJ1/8XstExxRj1dNUGppTCjD2suU0B?=
 =?us-ascii?Q?1gpPZLxq3PL15fvB1hqNTkw7Rq2vEjj3K9WX3oRDIAF4EqjHp5gJurgZFkaA?=
 =?us-ascii?Q?Z8rHi9IIfoevw0f4B+2IJeBpATV5pg+IljJIjwQbpc1nrpxjLV81iVa+qTxo?=
 =?us-ascii?Q?AojM02Iojo3UDHeX0N88IcYXa5ieal8uSQQi4y6Em+ARZsuPV0jIqQRki95U?=
 =?us-ascii?Q?dMo01sAYDEHsUslJemqf1lK8zQrTehkNh91TzIijj/43EQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:05.0738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d190777-accc-4183-d39d-08dce89837f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
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

From: Robin Chen <robin.chen@amd.com>

[WHY]
To get sink emission rate information for future
supported refresh rate calculation.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 ++-
 .../dc/link/protocols/link_dp_capability.c    |  8 ++++++++
 .../gpu/drm/amd/display/include/dpcd_defs.h   | 19 ++++++++++---------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 50fa8547d718..8dd6eb044829 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1192,6 +1192,7 @@ struct dpcd_caps {
 	struct edp_psr_info psr_info;
 
 	struct replay_info pr_info;
+	uint16_t edp_oled_emission_rate;
 };
 
 union dpcd_sink_ext_caps {
@@ -1205,7 +1206,7 @@ union dpcd_sink_ext_caps {
 		uint8_t oled : 1;
 		uint8_t reserved_2 : 1;
 		uint8_t miniled : 1;
-		uint8_t reserved : 1;
+		uint8_t emission_output : 1;
 	} bits;
 	uint8_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 2ec968f239f7..952e787493c4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2067,6 +2067,14 @@ void detect_edp_sink_caps(struct dc_link *link)
 	core_link_read_dpcd(link, DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE,
 			&link->dpcd_caps.pr_info.max_deviation_line,
 			sizeof(link->dpcd_caps.pr_info.max_deviation_line));
+
+	/*
+	 * OLED Emission Rate info
+	 */
+	if (link->dpcd_sink_ext_caps.bits.emission_output)
+		core_link_read_dpcd(link, DP_SINK_EMISSION_RATE,
+				(uint8_t *)&link->dpcd_caps.edp_oled_emission_rate,
+				sizeof(link->dpcd_caps.edp_oled_emission_rate));
 }
 
 bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index aee5170f5fb2..de8f3cfed6c8 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -164,18 +164,19 @@ enum dpcd_psr_sink_states {
 	PSR_SINK_STATE_SINK_INTERNAL_ERROR = 7,
 };
 
-#define DP_SOURCE_SEQUENCE    		    0x30c
-#define DP_SOURCE_TABLE_REVISION	    0x310
-#define DP_SOURCE_PAYLOAD_SIZE		    0x311
-#define DP_SOURCE_SINK_CAP		    0x317
-#define DP_SOURCE_BACKLIGHT_LEVEL	    0x320
-#define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
-#define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
-#define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
-#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED     0x340
+#define DP_SOURCE_SEQUENCE                      0x30C
+#define DP_SOURCE_TABLE_REVISION                0x310
+#define DP_SOURCE_PAYLOAD_SIZE                  0x311
+#define DP_SOURCE_SINK_CAP                      0x317
+#define DP_SOURCE_BACKLIGHT_LEVEL               0x320
+#define DP_SOURCE_BACKLIGHT_CURRENT_PEAK        0x326
+#define DP_SOURCE_BACKLIGHT_CONTROL             0x32E
+#define DP_SOURCE_BACKLIGHT_ENABLE              0x32F
+#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED      0x340
 #define DP_SINK_PR_REPLAY_STATUS                0x378
 #define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
 #define DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE 0x37A
+#define DP_SINK_EMISSION_RATE                   0x37E
 
 /* Remove once drm_dp_helper.h is updated upstream */
 #ifndef DP_TOTAL_LTTPR_CNT
-- 
2.34.1

