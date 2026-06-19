Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DB0CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8F410F5CE;
	Fri, 19 Jun 2026 13:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oajuhLTe";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A996410F5CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzT63XDXyJPnmwT9gtkO1Q12sUFDSDr/oPdSCRTq9kTaVxZh0dt4AF25YSK93F+KsP47PsI5v1zDFfuQUmDsEVaPEDvnqMkFRrb8gcqlHBracN3X++/CYpfhXvLWRR1w252lzj7hhpYdESeJRwfWGThF5LxokyHZ/8PfA7gOV5gpJdPz5xi+9KqGH3AwZAAt4bAXDfpKC9SWfDkzmvu/MA167yE+2a5spb7i+qtFHFlCG68wxSZL9CuKBlCniPcUfTOHg91VDbm/3AfU6BAxgulYfZMZb5eso+4WizWbBP10qNv9K3TBOw+nFNk8rPcxN2hAiZog5DxVnbfUiuDWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJWmHDnca1zgdd95ehVV38KyWGKG1nKUZyGGWRlDc2U=;
 b=QEQRBEqEJhqh04T9A1g8y5Dq3ot8Im7+loxn6cq4HRxE7O3bFjF01RnL4jYH/+ANCafl7jEDz+83bGgsCur0OcrA08MXILdtRKu9z3aTXASE4FuXriYpB3Dbypg2H7qgUA1SV0QGxClSlP4p8dnkTY90a9DFraqC2EwQ5G9in9hQaYx1j6jXgB3QKkfnA5AA1JHAI0soe3Jtj3cZDAQvnHIIil7FyOWAz4QA429z55J3KfedfoDWp731Me8dpSTkATUFWCgLyQda9v9jJ2sT3/x5jELNURuN9444EdQ3wlNK1t+L/O9JAiYC6/vIqwhM8Jt5tQcPxHNqRpBRDCR9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJWmHDnca1zgdd95ehVV38KyWGKG1nKUZyGGWRlDc2U=;
 b=oajuhLTeKNHuLwKVenHzalco+wKh88+ntoxx0XFNm7Lv06R75M4Mte1qYpbTwmP4/DDoGSQnjvtotaQ/ou79QrVzQ4QocOOhj9tMCCw4HeurtmyaMs4NNBsrYp4wdbCnM1fVyHBF9tUVXrB5foeGVU/r7y8rDKSqLP1L7rqJncs=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 13:32:21 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::86) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:21 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:19 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 02/24] drm/amd/display: Enable PSR and Replay on DCN4 variant
 and fix AUX instance
Date: Fri, 19 Jun 2026 09:21:17 -0400
Message-ID: <20260619133154.116746-3-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cefd30a-371e-4d38-69b1-08dece073105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|3023799007|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 599zvJtjBqYDSx0aDTdN3G1NlapzxvmEx2SN07FwqSwHqfsIFCDdRzk95nTo9U2vIur1teGour9CFWSYtyJzjx1CoJFGCegciSfRDpl7slZcUhYG9/LEbB0O7FmjehnJIKKHbojLhz+USEV2saUfUC6Lxdf7AaC1QcJfh+LzY0U/rFiUmWKj7gHFIdAt2ImRBUJ530jMV/BMmd2ir6WrWzj2SUJN4frlKdBtoqSeTndy9oaI8zxI66lctQZqxRji/njUqTk6JTF8o+ZNi2WU9E1g1nx4wZAc5knuTIiuDbth06KTxSQRo68FiKuUlwcAKkV/adfi5kH0BTCg3p1rh+KUGoVPRbqolqyaSOfLuCwxFXZhuWDGBIPFNX6tMpQOwInqmnElk96L68wkNbfutQVcagPYU8Z7e5SNerlkWgJyvSRbTJOpz6y7D/ByE+sA92od/qqIM3ChrlN8t9tQ8A/dNEW+G8Dm5hZN1lDUzfqGf0vfCZ1A+MFoHV2qkxLz10fMEINN63iw/4RyQUCS/RbWDpCcc1YjzM2CCUoVL5Tpio27Vl4bK5OlG40KgyGaIMu8WXn0ghRP/lieBk6VNjxZzdi3KGNIe4n141oC3LuzvWx8C5P7O5sHSyHs38nMA7pA/ulkBdLKxsDwjpXk4LP1w8tGZMP/Up/AQCmmaT+iO/eCDpTo/MnmwRJbBGuzZsCx8lV4usmcmsSLWuv57Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(3023799007)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ol4I8A7vuUVLZhXE5mwplCJ5IVulPymDjcee0R2yyD2/TgSHa48gbqyssX57Paq6HQG6D7MrpJmrvGZO6PmDS4I2j1xvaO9mRW5VLeklGVpjUsAR9HhLmxn5+b8S4OdETEF/F+WsTvIUZWomczm1XKzwyMw807dKE8kSI2tOmM++8jGqfJ7jc5+MWkkWbiudY3qH8VtJGU3YhsHuI0zWCMtnO9dMuCMrhpBwflE5n8YxzFjJhtVaRQvLPiCbQ2n5FpdyXyXD8OMi3nPiMeR/nyq523tQBc/zpkjfi5QeVKv/TrMKUbKZbPwoPigsKoh7qwa1yBrblGLOs05zIPHcav9ECaxMjcX7JFgCbdI1CjRO7Zn8uGiM7Xkp2b6y50e+SfXJgSCDc9mHCUnuVr1cv/ubjcx8eRp9P2Y4diHsnf8wHUAgab50+wLzRNNQWDZ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:21.5301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cefd30a-371e-4d38-69b1-08dece073105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Enable PSR and Panel Replay on a DCN4 variant for display power
savings. On links without native I2C (no DDC pin), the AUX channel
must use aux_hw_inst to avoid NULL pointer access during PSR and
Replay setup.

[How]
Enable PSR and Replay in the DCN4 variant panel config defaults.
Add no_ddc_pin check in dp_setup_panel_replay(),
edp_setup_freesync_replay(), and fsft_send_msg_to_fw() to use
link->aux_hw_inst when dp_connector_no_native_i2c and no_ddc_pin
are set.

Reviewed-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/dc/link/protocols/link_dp_panel_replay.c  |  6 +++++-
 .../dc/link/protocols/link_edp_panel_control.c        | 11 ++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index d87f87a02d63..465b9e53d311 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -119,7 +119,11 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;

-	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+		replay_context.aux_inst = (enum channel_id) link->aux_hw_inst;
+	} else {
+		replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	}
 	replay_context.digbe_inst = link->link_enc->transmitter;
 	replay_context.digfe_inst = link->link_enc->preferred_engine;

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 80a372ceaa51..1fda6e226e23 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -788,10 +788,11 @@ bool edp_setup_psr(struct dc_link *link,
 		}
 	}

-	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin)
+	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
 		psr_context->channel = (enum channel_id)link->aux_hw_inst;
-	else
+	} else {
 		psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
+	}
 	psr_context->transmitterId = link->link_enc->transmitter;
 	psr_context->engineId = link->link_enc->preferred_engine;

@@ -1024,7 +1025,11 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;

-	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+		replay_context.aux_inst = (enum channel_id) link->aux_hw_inst;
+	} else {
+		replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	}
 	replay_context.digbe_inst = link->link_enc->transmitter;
 	replay_context.digfe_inst = link->link_enc->preferred_engine;

--
2.54.0

