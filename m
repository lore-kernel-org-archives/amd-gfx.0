Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F3FCA5FE7
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8042310F9EB;
	Fri,  2 Oct 2026 19:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/r/IP/m";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5022610F9D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjkhZLeW4MqGiQARlkJTpFXz67rvQZ+kH8m80lDfqABwUR7Sk3Zf+2/9QE0UFXd4KAitF3WFiHRD8RYm9p2Tuzzru95A7z/i92cXYlapk5PZAaoBWz9Akpo/RExhMYeEkG9e9DLjho6wGL/mGvTQBlxmGIiKjvtEDgvOaqWw8DAvjDonKUNp2SFWL96zlIcwZYuCZmssHXkNKffzgj54QHL1Q1sX2XVOzmo55IH+4pxeIJK0HEUg6jQ1ouRuTmkxgjKmXtUMpo4t8ez7o4c8PZBmrjv1G/wkUUdw6e3d8X9uY5C576OPn79QZ7Cw0LaBwEdcGqYU6xFF4UbmtHn6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYEc+U+oflCyegO8pAMcv04NVgy1hhcljVBmuuayqk8=;
 b=MorDZ1YMt7Wx/7Utv18q4CbZbWc1tSDue20cVUR8DJ+CByQ+Iu4B8yrji6dtuVZ1Ua8/B3K5SDA/cpuc4C5YmZOmZEh0O0U9fzmcnEPEwKTQVK5rAvYlO8Tz34OqEQrqDXM9vAeW/4LydVmuuvppia6FjJgxW9mB89ayQA9edKCVW4Lx/tduhPSlv6iBHxdMRUemWM0QqAehj/NwVggt/aWsCt2f5PTZfUGP9L2jEB8OYc/Y6SKAuETpsQ/48DOXnZTDQI1x3UMvVHR5CNnLguv5o1kd3IXiVvDVZZ4oagrrnypzh7wATRHDd3MJi8v9n1LbG8qideTVHNX0nqjVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYEc+U+oflCyegO8pAMcv04NVgy1hhcljVBmuuayqk8=;
 b=j/r/IP/mB1Dj/06GYOOPwhxyxfahEtVJe06xoMRsTjjrLJjbffxta4YplyrIND4xdQkcp+UWkbUrOuyWYqxZp+UVFqebuyhiINH/uIBAbRSqLjro4AuE4CgFpQuDMNhRn+oC4joHqz8YEZ4KHIWZaHDqdiPsKVzvqp9LaHuu/jk=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by DS6PR12MB801076.namprd12.prod.outlook.com (2603:10b6:8:417::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:33:16 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::a3) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:11 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:10 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Martin Tsai
 <Martin.Tsai@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 08/17] drm/amd/display: allow skipping link bandwidth clear
Date: Fri, 2 Oct 2026 15:32:31 -0400
Message-ID: <20261002193240.3441018-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS6PR12MB801076:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4e10da-0d24-4052-4f0e-08df20bc01ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ogr2YFQHc401ZfC0MGPQ767UrRivHWezANgKuZI2ZGn7b+c2xp5z1FKo+Cn+Rl18mAUcFa5s9YcArWWExtWvdlpM1shdvR9Iqq+XcjmcEGQCFv2Fg4WmpXqwzLqUmS+jWfhvHFbMS4PRyi1DrIXA39cm16LaAX+Y3LFGy4emrRhMHtQsh+xqaGjedzaj5x9DagU6L2Z0cvG6SA6B0hEQKNZfTpSEsz9ajayvT6+Zmrr9A1fNtnFJy9l4HxZ9A+tsqbXxu4bF7atLJ3qQk/DbO1/oXs8OtzKrdSlZUMptcCeH8u8bO395WrzJDmgV8vkigroaMBAv6y9HEzRveh8CMnE548zUJzQZZ6bBvh4lUzJduPN4tc/nOhilq2r97G6S2z4HQCx/BXCTFdsjTjN+PT3RhftkikmVslZNrKLIuR1jXBUJQUNTnjMesjz2DN7y1E1iw0BOGFqpkBKiA6lde3IBFwvQ+ULCEUEoq8No2iAhq+4Xs1V27nD0ZZdbib3TGz99O7BWW2pYhCaS86esSHBOMCkpHvGlGGTCTy7fjtP5r9LNGmSxe3kNNy2uNYdyh+7tHtCm4aeiGyYPtuck0L4UBws7M2YschMa86/HhfeB66WTbE/htNtlFdk7/wsr1Kjhuy/r21B76mWMhwp0csKcIVAcDYCHnobMTkNIhivL9J6V1MP1j7kFU+G9wOCj+oE9INbs4iNzyYKTwuDJog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LqOJidgNgUDarBV6uQk519YUY5JVIxgrFxW7WITAougQj2Whi5qox/qErXH0B/JxhGiEssiyJX4W7vLIcNVk5yWtclmAbYNLDXuy2pE9oLQQhOiO0WJrDFX5HnItpl3zzMd6dfByRzrRuqTNtIh6kUU4O9O0I6X9OvJwZxPjQBzyhGLN1o/w5/NP1YCJrWXZXi0VFL2PDqB9PawqlNs03zcKminUxsnVXEoJWf4DSVan30IDvmoaDLI5xI68M+Ak0d9l+SuE4ln1RUM9aPOEMOlpqrXYxnLShYmDIQxQ48TavUtJTAZy+zXAyW/rYcKkSTI58cZaHYGfFObNmSzgNLVNT/mc7ccZVbAPv7wJGutjT+tcIYUXHExee0Wf3xAAmfD5aKaGB+xTBYWUEzuJ5/SuSWB5EA3QkxyHCaejM8W+Zons9ryIiIrl6yeAdazy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:16.5280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4e10da-0d24-4052-4f0e-08df20bc01ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB801076
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

From: Martin Tsai <Martin.Tsai@amd.com>

[why]
To set link bandwidth with zero could hit error protection
from Sink panel to fail link training and cause screen
corruption.

[how]
To skip link bw cleaning in two conditions:
1. eDP v1.5 or latter, because the last write will take effect.
2. Sink requires not to clear it.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Martin Tsai <Martin.Tsai@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  1 +
 .../dc/link/protocols/link_dp_training.c      | 20 ++++++++++++++-----
 .../amd/display/include/link_service_types.h  |  1 +
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index fef857c7336b..5926e8a4f95a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -263,6 +263,11 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 			lt_overrides, link, skip_immediate_retrain);
 }
 
+void dc_link_set_skip_link_bw_clear(struct dc_link *link, bool skip)
+{
+	link->preferred_training_settings.skip_link_bw_clear = skip;
+}
+
 bool dc_dp_trace_is_initialized(struct dc_link *link)
 {
 	return link->dc->link_srv->dp_trace_is_initialized(link);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d2256c454424..957e15e4a84c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2869,6 +2869,9 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 		struct dc_link *link,
 		bool skip_immediate_retrain);
 
+/* Configure the sink-specific policy for future DP link training. */
+void dc_link_set_skip_link_bw_clear(struct dc_link *link, bool skip);
+
 /* return - true if FEC is supported with connected DP RX, false otherwise */
 bool dc_link_is_fec_supported(const struct dc_link *link);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index d0ba9ad67a3e..b0e91b321f43 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -203,6 +203,7 @@ struct dc_link_training_overrides {
 	bool *enhanced_framing;
 	bool *mst_enable;
 	bool *fec_enable;
+	bool skip_link_bw_clear;
 };
 
 union payload_table_update_status {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 04eedec8a230..3be36d1063de 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -724,6 +724,8 @@ void override_training_settings(
 {
 	uint32_t lane;
 
+	lt_settings->skip_link_bw_clear = overrides->skip_link_bw_clear;
+
 	/* Override link spread */
 	if (!link->dp_ss_off && overrides->downspread != NULL)
 		lt_settings->link_settings.link_spread = *overrides->downspread ?
@@ -1095,7 +1097,7 @@ enum dc_status dpcd_set_link_settings(
 	struct dc_link *link,
 	const struct link_training_settings *lt_settings)
 {
-	uint8_t rate;
+	uint8_t rate = 0;
 	enum dc_status status;
 
 	union down_spread_ctrl downspread = {0};
@@ -1129,7 +1131,7 @@ enum dc_status dpcd_set_link_settings(
 
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
 			lt_settings->link_settings.use_link_rate_set == true) {
-		rate = 0;
+
 		/* WA for some MUX chips that will power down with eDP and lose supported
 		 * link rate set for eDP 1.4. Source reads DPCD 0x010 again to ensure
 		 * MUX chip gets link rate set back before link training.
@@ -1140,9 +1142,17 @@ enum dc_status dpcd_set_link_settings(
 			core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
 					supported_link_rates, sizeof(supported_link_rates));
 		}
-		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
-		if (status != DC_OK)
-			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_BW_SET) failed\n", __func__, __LINE__);
+
+		/*
+		 * It doesn't need to clear 0x100 in below two conditions:
+		 * 1. eDP v1.5 or later, because the last write will take effect in Sink.
+		 * 2. Sink requires not to clear 0x100.
+		 */
+		if (!lt_settings->skip_link_bw_clear && link->dpcd_caps.edp_rev <= DP_EDP_14b) {
+			status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+			if (status != DC_OK)
+				DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_BW_SET) failed\n", __func__, __LINE__);
+		}
 
 		status = core_link_write_dpcd(link, DP_LINK_RATE_SET,
 				&lt_settings->link_settings.link_rate_set, 1);
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index da74ed66c8f9..798d83238828 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -73,6 +73,7 @@ struct link_training_settings {
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
 	bool should_set_fec_ready;
+	bool skip_link_bw_clear;
 	union dc_dp_ffe_preset *ffe_preset;
 
 	uint16_t cr_pattern_time;
-- 
2.34.1

