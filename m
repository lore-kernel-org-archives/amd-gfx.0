Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F34E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E8310E094;
	Fri, 20 Dec 2024 21:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o3ip3GVW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA3A10F06F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaYdE+DOwYebOqYCX9uiT5K4HsSo0wDXDrj9Itv9BkppOAuzmCtTSr76hmZ/b5U9p4+sDCZH8Y8vNCKATa47XAKtUTrg4esrdadHf4BZALnn/K4bagFgUDYrC3kFq3bO24j/9tiLhs/GzLlqMGAYsPJmJfEelEJqGKV76XvGVP88mN3cATXlxrV4yFYHx6tkLwrbV9hU2JAzUFczOdKCJb9nEsrWMGM3YPcVVoJq8zPw+6/6fymXW5i9S0sJBhVRzg89p+ubiCiQX3erOdHgkgOMbYWAoFbxeb7Ac/eRFdlveqI0R6ycWYvKBnMXzV7vh1SiGqWtERtya+KWHUtYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F30t1sHz15Td9lb7ihXtHCX1QR+/7fuBphxuhC09QPE=;
 b=c8nWTTWPVEBeeJtWwnzJT1sLqim27wucQa8NIphi9BzvVXSFNebCcPUnnHU9jeqGx61fZMad6bgD1ZjJh46FpAolIUuXzem0zo8T+82OMszUXYHz8eS6yX2UMq7GgiDXEYj7F7NUih34l1qvZ64jlNN1iEyiNq30diGTzJ+KI5vm7m20wb7x2nhCGAQnxKm4sdwqsM9tFN6c0MYCd8cCThVJ4YczhimRPmyfJYni4jWIBoNyJ6u6wZBstLiCxOai4+dXZXm1NxxHJd/wWWOkZZ9QvDN1X1LL3tuVz7CMRtONNhgQoEc+DMbBDcOtB0YD3YjgylAjmFpqFGcNqEZSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F30t1sHz15Td9lb7ihXtHCX1QR+/7fuBphxuhC09QPE=;
 b=o3ip3GVWj1Bx3ORP6YCUt7xm7SCWEhfDMNyECBy89fDuxQMa4Cy45BrsBQ2Ag/l8YZgeUfpw20k2qzlQ3QcRA2exZHmhFe6tIA3M48DNwth+MG7OTUmTGbsFQIUza6SCiicHssE4LWSNKdfQssTUysLKA3PIel5oNmJ+bAcUnKA=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:03 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::81) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 21:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:01 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:56 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 08/28] drm/amd/display: Extend dc_stream_get_crc to support
 2nd crc engine
Date: Fri, 20 Dec 2024 16:48:35 -0500
Message-ID: <20241220214855.2608618-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e18736d-368f-405d-d834-08dd214065fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2kueI3Jv+6AwXBsn5WxLvahZAtuI2Q+QBH+qbq+lHc6yd0UdvmapPTGp5773?=
 =?us-ascii?Q?yNXk/HqraGfeOC1hTm8R1hgN3eBR9RlmHJlG7JLeYw1MbA0k5hQF4E7gaIlv?=
 =?us-ascii?Q?9OmNiMpx5dXAAA5cQTQnorjxHrLvzyaCVpO+lIsmkru9mWMUzBLn0Nl/wCb4?=
 =?us-ascii?Q?mYLGqu95l6hD0mex7bDJ1cVKXj5Ba20spaWb37oRYzPuD9Ed2WDhTICdmMvY?=
 =?us-ascii?Q?I0LNMGrMoi96YKam4juEmy6NHlv6KdxtFApEROMRE9dqHxhqzMew8opqJWIR?=
 =?us-ascii?Q?xF+GU7RKcefGyoe2KhJsrwvX/sfaMOSxEZseH9O83tbZBriZd6u/iyE02Uob?=
 =?us-ascii?Q?crvUmVbUak8TViNfZZk3GI7P825JYAJcEYOJFfowo7f/AwM+5N+rgDa4ljd7?=
 =?us-ascii?Q?87vLsoVVZOrdkEnEN3zKZaXpFjGxtDqQDm3Ylg+5ECTEATHvNvt3Qt0bbjlv?=
 =?us-ascii?Q?cQwkzy3z12GVQJT2uNTQ3sxCGP6X1w1BQTDQeb/dUxdLdLs+i8+6r7fcl+Fl?=
 =?us-ascii?Q?zwA2g/AbB2j07scgFX2NHP2wG4mIRzkVeh2KHOMtn9qzHu18g+EZ2iShn+D/?=
 =?us-ascii?Q?hLDtjJFubzFk9B1iXRxRplMYzVyW7l0637V+vciVBQiYhAutQgm5jjZpioq+?=
 =?us-ascii?Q?n5uBKFSwpHBlKJgVurPa3MkviYlBLF/oOqkuhFJAb0Z/kGf5CEKjYtdN9RlL?=
 =?us-ascii?Q?6ENfcv+tRKC7yI0Tr4AhWZKCV57sEoQ6CevZYNZmipI43TI+Ptk79nFNMsz7?=
 =?us-ascii?Q?8eSAeDw9CyIeAAZr/LvA0P41XCkMvE4MSs9yRcMh0tBqPmGL4RFx3lrOcUwM?=
 =?us-ascii?Q?JDCfbwN9Kn7T4hu1Ci2eMEQqNWlxL0eQSA209YUsFMgA6rNUGSEhtv/r+FDs?=
 =?us-ascii?Q?o8Y5334epCUJVtn28oBaHDKNipSsmaGpLL4tGSFW0b0/ni01PzYqxy0WrUyc?=
 =?us-ascii?Q?rMgQ0aYClizp1gHaglkY1I5m2ABxl/J7JhEt44JeWgVVBfwdzCc7i/utN5kq?=
 =?us-ascii?Q?R6WzhFFN23JA9gthIzULHrzeWHCWxYbqLzlmiK5SnYfw74NvafKz/EEJOOxO?=
 =?us-ascii?Q?AAlumPzanK7woQZZmnZWdclqE5WdwqMrI9jkB8WvJgKgP1wWxXmRJyavINeF?=
 =?us-ascii?Q?+C5BSkg2JIObNahrr917/vQm0eHkT9Twz+XvnKHf2bt+xqSM+prdAKa/SEAC?=
 =?us-ascii?Q?fSu6KJMlwvYfuM5IKaNyIH/4SDRhFQJquSHZC1g7KV4eDsQSZCHyVZ4ko8Vp?=
 =?us-ascii?Q?T7+9vxxZbJlZxY5iSuX5o2ITpTOC41UViHDI4q+rOrgOFYjGBedYzCNB0ROP?=
 =?us-ascii?Q?9IKDmHBIm/eOX1hsXP8f9EZk1u12e1DxCR//jU7ryEAgoPhG0SMkOItvX1iD?=
 =?us-ascii?Q?hBPsFbSoV97xhwTdc4hD14kZkV/z28H2Jpz9d0HbV/4IBBz71g6JT8dtwhSM?=
 =?us-ascii?Q?BmCeyRHutH0AD13zX2ddLuO3Y7ozOvMZZ0kcVEJMFZ8BY+sDsCp8a4pNOn2Y?=
 =?us-ascii?Q?xqesYL1/0aDfiPw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:02.7386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e18736d-368f-405d-d834-08dd214065fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Since now we can set multiple crc windows for secure display, add a new input
parameter for dc_stream_get_crc to indicate to fetch crc from which crc
engine.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../dc/dce110/dce110_timing_generator.c       | 32 ++++++++++++-----
 .../dc/dce110/dce110_timing_generator.h       |  2 +-
 .../dc/dce120/dce120_timing_generator.c       | 34 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |  2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    | 33 +++++++++++++-----
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 19 +++++++++++
 10 files changed, 101 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 6fdc306a4a86..5cc84dce001d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -709,7 +709,7 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 	}
 
 	if (dm_is_crc_source_crtc(cur_crc_src)) {
-		if (!dc_stream_get_crc(stream_state->ctx->dc, stream_state,
+		if (!dc_stream_get_crc(stream_state->ctx->dc, stream_state, 0,
 				       &crcs[0], &crcs[1], &crcs[2]))
 			return;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index deda18e07e9b..28a66df6abe6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -753,6 +753,7 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
  *
  * @dc: DC object.
  * @stream: The DC stream state of the stream to get CRCs from.
+ * @idx: index of crc engine to get CRC from
  * @r_cr: CRC value for the red component.
  * @g_y:  CRC value for the green component.
  * @b_cb: CRC value for the blue component.
@@ -762,7 +763,7 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
  * Return:
  * %false if stream is not found, or if CRCs are not enabled.
  */
-bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream,
+bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream, uint8_t idx,
 		       uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
 {
 	int i;
@@ -783,7 +784,7 @@ bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream,
 	tg = pipe->stream_res.tg;
 
 	if (tg->funcs->get_crc)
-		return tg->funcs->get_crc(tg, r_cr, g_y, b_cb);
+		return tg->funcs->get_crc(tg, idx, r_cr, g_y, b_cb);
 	DC_LOG_WARNING("CRC capture not supported.");
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index ac22bfe8c9a3..23dea4be9fa7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -554,6 +554,7 @@ bool dc_stream_configure_crc(struct dc *dc,
 
 bool dc_stream_get_crc(struct dc *dc,
 		       struct dc_stream_state *stream,
+		       uint8_t idx,
 		       uint32_t *r_cr,
 		       uint32_t *g_y,
 		       uint32_t *b_cb);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index fa422a8cbced..e32dd96a99cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -2190,7 +2190,7 @@ bool dce110_configure_crc(struct timing_generator *tg,
 	return true;
 }
 
-bool dce110_get_crc(struct timing_generator *tg,
+bool dce110_get_crc(struct timing_generator *tg, uint8_t idx,
 		    uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
 {
 	uint32_t addr = 0;
@@ -2206,14 +2206,30 @@ bool dce110_get_crc(struct timing_generator *tg,
 	if (!field)
 		return false;
 
-	addr = CRTC_REG(mmCRTC_CRC0_DATA_RG);
-	value = dm_read_reg(tg->ctx, addr);
-	*r_cr = get_reg_field_value(value, CRTC_CRC0_DATA_RG, CRC0_R_CR);
-	*g_y = get_reg_field_value(value, CRTC_CRC0_DATA_RG, CRC0_G_Y);
+	switch (idx) {
+	case 0:
+		addr = CRTC_REG(mmCRTC_CRC0_DATA_RG);
+		value = dm_read_reg(tg->ctx, addr);
+		*r_cr = get_reg_field_value(value, CRTC_CRC0_DATA_RG, CRC0_R_CR);
+		*g_y = get_reg_field_value(value, CRTC_CRC0_DATA_RG, CRC0_G_Y);
 
-	addr = CRTC_REG(mmCRTC_CRC0_DATA_B);
-	value = dm_read_reg(tg->ctx, addr);
-	*b_cb = get_reg_field_value(value, CRTC_CRC0_DATA_B, CRC0_B_CB);
+		addr = CRTC_REG(mmCRTC_CRC0_DATA_B);
+		value = dm_read_reg(tg->ctx, addr);
+		*b_cb = get_reg_field_value(value, CRTC_CRC0_DATA_B, CRC0_B_CB);
+		break;
+	case 1:
+		addr = CRTC_REG(mmCRTC_CRC1_DATA_RG);
+		value = dm_read_reg(tg->ctx, addr);
+		*r_cr = get_reg_field_value(value, CRTC_CRC1_DATA_RG, CRC1_R_CR);
+		*g_y = get_reg_field_value(value, CRTC_CRC1_DATA_RG, CRC1_G_Y);
+
+		addr = CRTC_REG(mmCRTC_CRC1_DATA_B);
+		value = dm_read_reg(tg->ctx, addr);
+		*b_cb = get_reg_field_value(value, CRTC_CRC1_DATA_B, CRC1_B_CB);
+		break;
+	default:
+		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
index ee4de740aceb..e4f5cad64f32 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
@@ -286,7 +286,7 @@ bool dce110_arm_vert_intr(
 bool dce110_configure_crc(struct timing_generator *tg,
 			  const struct crc_params *params);
 
-bool dce110_get_crc(struct timing_generator *tg,
+bool dce110_get_crc(struct timing_generator *tg, uint8_t idx,
 		    uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb);
 
 bool dce110_is_two_pixels_per_container(const struct dc_crtc_timing *timing);
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index fcf59348eb62..4984adce077e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -1137,8 +1137,8 @@ static bool dce120_configure_crc(struct timing_generator *tg,
 	return true;
 }
 
-static bool dce120_get_crc(struct timing_generator *tg, uint32_t *r_cr,
-			   uint32_t *g_y, uint32_t *b_cb)
+static bool dce120_get_crc(struct timing_generator *tg, uint8_t idx,
+			uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
 	uint32_t value, field;
@@ -1151,14 +1151,30 @@ static bool dce120_get_crc(struct timing_generator *tg, uint32_t *r_cr,
 	if (!field)
 		return false;
 
-	value = dm_read_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC0_DATA_RG,
-				  tg110->offsets.crtc);
-	*r_cr = get_reg_field_value(value, CRTC0_CRTC_CRC0_DATA_RG, CRC0_R_CR);
-	*g_y = get_reg_field_value(value, CRTC0_CRTC_CRC0_DATA_RG, CRC0_G_Y);
+	switch (idx) {
+	case 0:
+		value = dm_read_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC0_DATA_RG,
+					  tg110->offsets.crtc);
+		*r_cr = get_reg_field_value(value, CRTC0_CRTC_CRC0_DATA_RG, CRC0_R_CR);
+		*g_y = get_reg_field_value(value, CRTC0_CRTC_CRC0_DATA_RG, CRC0_G_Y);
 
-	value = dm_read_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC0_DATA_B,
-				  tg110->offsets.crtc);
-	*b_cb = get_reg_field_value(value, CRTC0_CRTC_CRC0_DATA_B, CRC0_B_CB);
+		value = dm_read_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC0_DATA_B,
+					  tg110->offsets.crtc);
+		*b_cb = get_reg_field_value(value, CRTC0_CRTC_CRC0_DATA_B, CRC0_B_CB);
+		break;
+	case 1:
+		value = dm_read_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC1_DATA_RG,
+					  tg110->offsets.crtc);
+		*r_cr = get_reg_field_value(value, CRTC0_CRTC_CRC1_DATA_RG, CRC1_R_CR);
+		*g_y = get_reg_field_value(value, CRTC0_CRTC_CRC1_DATA_RG, CRC1_G_Y);
+
+		value = dm_read_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC1_DATA_B,
+					  tg110->offsets.crtc);
+		*b_cb = get_reg_field_value(value, CRTC0_CRTC_CRC1_DATA_B, CRC1_B_CB);
+		break;
+	default:
+		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
index 03cbcbb36f1c..6fdc9809280c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
@@ -210,7 +210,7 @@ void optc1_enable_crtc_reset(struct timing_generator *optc,
 
 bool optc1_configure_crc(struct timing_generator *optc, const struct crc_params *params);
 
-bool optc1_get_crc(struct timing_generator *optc,
+bool optc1_get_crc(struct timing_generator *optc, uint8_t idx,
 		   uint32_t *r_cr,
 		   uint32_t *g_y,
 		   uint32_t *b_cb);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index b74e18cc1e66..4807b9f9f5a5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -291,7 +291,7 @@ struct timing_generator_funcs {
 	 * @get_crc: Get CRCs for the given timing generator. Return false if
 	 * CRCs are not enabled (via configure_crc).
 	 */
-	bool (*get_crc)(struct timing_generator *tg,
+	bool (*get_crc)(struct timing_generator *tg, uint8_t idx,
 			uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb);
 
 	void (*program_manual_trigger)(struct timing_generator *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 097d06023e64..d4ef874327ba 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -1510,6 +1510,7 @@ bool optc1_configure_crc(struct timing_generator *optc,
  * optc1_get_crc - Capture CRC result per component
  *
  * @optc: timing_generator instance.
+ * @idx: index of crc engine to get CRC from
  * @r_cr: 16-bit primary CRC signature for red data.
  * @g_y: 16-bit primary CRC signature for green data.
  * @b_cb: 16-bit primary CRC signature for blue data.
@@ -1521,7 +1522,7 @@ bool optc1_configure_crc(struct timing_generator *optc,
  * If CRC is disabled, return false; otherwise, return true, and the CRC
  * results in the parameters.
  */
-bool optc1_get_crc(struct timing_generator *optc,
+bool optc1_get_crc(struct timing_generator *optc, uint8_t idx,
 		   uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
 {
 	uint32_t field = 0;
@@ -1533,14 +1534,30 @@ bool optc1_get_crc(struct timing_generator *optc,
 	if (!field)
 		return false;
 
-	/* OTG_CRC0_DATA_RG has the CRC16 results for the red and green component */
-	REG_GET_2(OTG_CRC0_DATA_RG,
-		  CRC0_R_CR, r_cr,
-		  CRC0_G_Y, g_y);
+	switch (idx) {
+	case 0:
+		/* OTG_CRC0_DATA_RG has the CRC16 results for the red and green component */
+		REG_GET_2(OTG_CRC0_DATA_RG,
+			  CRC0_R_CR, r_cr,
+			  CRC0_G_Y, g_y);
 
-	/* OTG_CRC0_DATA_B has the CRC16 results for the blue component */
-	REG_GET(OTG_CRC0_DATA_B,
-		CRC0_B_CB, b_cb);
+		/* OTG_CRC0_DATA_B has the CRC16 results for the blue component */
+		REG_GET(OTG_CRC0_DATA_B,
+			CRC0_B_CB, b_cb);
+		break;
+	case 1:
+		/* OTG_CRC1_DATA_RG has the CRC16 results for the red and green component */
+		REG_GET_2(OTG_CRC1_DATA_RG,
+			  CRC1_R_CR, r_cr,
+			  CRC1_G_Y, g_y);
+
+		/* OTG_CRC1_DATA_B has the CRC16 results for the blue component */
+		REG_GET(OTG_CRC1_DATA_B,
+			CRC1_B_CB, b_cb);
+		break;
+	default:
+		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 40757f20d73f..159172178d51 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -86,6 +86,12 @@
 	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
+	SRI(OTG_CRC1_DATA_B, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
 	SR(GSL_SOURCE_SELECT),\
 	SRI(OTG_GLOBAL_CONTROL2, OTG, inst),\
 	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst)
@@ -315,6 +321,7 @@ struct dcn_optc_registers {
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
@@ -327,6 +334,17 @@ struct dcn_optc_registers {
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
@@ -482,6 +500,7 @@ struct dcn_optc_registers {
 	type OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN;\
 	type OTG_CRC_CONT_EN;\
 	type OTG_CRC0_SELECT;\
+	type OTG_CRC1_SELECT;\
 	type OTG_CRC_EN;\
 	type CRC0_R_CR;\
 	type CRC0_G_Y;\
-- 
2.34.1

