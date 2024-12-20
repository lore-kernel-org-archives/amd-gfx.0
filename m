Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81852E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EF510F076;
	Fri, 20 Dec 2024 21:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgcrDcmM";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E6610F084
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHN3cNUllK6wryM2wW5/NGIDkerRo0ndXbnRU4LSswAoJx677CfylQA/UqIDVIEjK8cP+u06Vy8m6d29JssNq/ZGhv7qsZzi3Y1PnUMsrSYgWNjSigSJMn1XXe0wUPk51g0k/SIl9oqRQicMNglD21KvfgW0Bk9AXhdUoe6RTEKPsvBJDAHUzhXl0SVbC37/sUpSCg+qMqSrCVbdHSlUiVKsttfeH/gUZGkhcQrDERckQiysCfwLfa2hJW21izyvwfN+HIIxTcdOgYZxwfKc8cKGfLLuTG18p2AjZiei5Fjl/erzXlvJpS5kqg9iw07e7UKtCZQ+jVOXRQPEud/Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+wGCwwiwFJrUAZabTOi5d3ImNnhvVX17kwd9GNfIzs=;
 b=mkAtl4D0NB2hQXII9YQQVcsVm0hJZGM97ocg2neljQpuQuPe0RbFspV2EGFsjlkF6KKNML/7Rucer6nwtspcb2f460TKZ82WvZlmMQxx4zcsqHWL7rwGaG6hnCjNdouJK7664/s5TFpH0GkKr4gLnrOyGTK+su8uelf/vV2DVFfFtGgagoC8Jh41UgrVJWrnSQ3ixO46f9p9TlB13m21M74o+0/dFq36XlYyftE9GaQlh1xS7Vb5Qb5ozkcKLLhvMM0ap0D+P6JClJzz26rb+92Q5BvvjuOAVYr+8iBx/jFebb7h3QvY3QWDR3bs4txLnGgPKELG5C+IIbyv7Onaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+wGCwwiwFJrUAZabTOi5d3ImNnhvVX17kwd9GNfIzs=;
 b=vgcrDcmMB8ZzM5e6lcxo7D3vjJZAsIwDus6mZU1z8wFC8zXPSfrxtdqH1Hh05j6q/VJ7pqx8N+/cxpqfZwgzsrt3uwZQGSEj9kiDM31YQqhFv1lpJK94cBdByNtJRHIcWSnPcWSu7ePAi/GVw/pr9daUSc8u4OMSgMCxui/uVw0=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:21 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::a3) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Fri,
 20 Dec 2024 21:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:19 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:18 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 19/28] drm/amd/display: Optimize cursor position updates
Date: Fri, 20 Dec 2024 16:48:46 -0500
Message-ID: <20241220214855.2608618-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 352c76bb-e0fa-4027-fdf4-08dd214070e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vYIkloScmbfomiVpDL1FpiiGG8uS2wnzQ8GymGWfsFUBa9Q+izbSOzOUFDBZ?=
 =?us-ascii?Q?tmibI+2WBw0cAHEZe9FibfUNZ2JZW4K0ERJ1G714uNUy/7SB9E5XYzhiBU0K?=
 =?us-ascii?Q?G+ScOsq9eK0FbzhFssHZKMznXdbfKf1Wao5aY4lX5udycnCEPQnXxnTq41Sg?=
 =?us-ascii?Q?X+BK+oXI0Pa5s4KtfZIi4nqM0pGlgAv+xvYBvfPYb0/hwHukYVyaEHBLInLD?=
 =?us-ascii?Q?bMZthFRFF6E9VP+ZZ+jB2lv+hh//Kxb8VZ9yT6GGjNf3D18AXr+j32HZSo5Z?=
 =?us-ascii?Q?7Jga8EglUqNEcT3htWKFKPyL+Hd8od5JKLr+FJB28YTcN6UuxRe2CSK1QRnm?=
 =?us-ascii?Q?XQvJXooBAxlB1Mhgy6D9xtCLQd7ujP8BB+YwN+CVSl1J1uA8BHRgwMfHCHfs?=
 =?us-ascii?Q?3Kt0eHQxCT0Y16duNRx17xvFbgR2ZODpstGc6Vwscg1Xxhk30KsoblWRLALm?=
 =?us-ascii?Q?RAUoHysAjizC0fSe3F8MeFA9JbTTHu3ad/jggQOqb9gpfZp33KPw6B0rxryW?=
 =?us-ascii?Q?axrKZP7PfpJRrlCZJTMBl9ofUWWB9mFh9+vZbChZA5LIIntEhuF1x59uSXIL?=
 =?us-ascii?Q?HssoDkn1rVUdylGKAguLntCn/UF7k7qIMuTBmB6Lk/fodFzw2fo9+5JdOI1P?=
 =?us-ascii?Q?2JMe/VGUr27fEU0FMAvfihg+Zon89jeVz46TFzd+eqL6aYYB0AyGzWZWAHD4?=
 =?us-ascii?Q?yAlEtVcL5SNwta6MmooTfKFuJCSFg0k+kVnkxmMAU+1GUA+Af9ne6qfADLs0?=
 =?us-ascii?Q?WcqExudaY1u00JM8Rp1Tx6gu0aQFyecjgXxvjB0y4pJJbKahF71Gt9c0c/7l?=
 =?us-ascii?Q?V13fUHdfvIlyzhW5RGuc7sZ+PgFpbb1ypP9AFxHA58w6Cb4YqfF/Gx5logx6?=
 =?us-ascii?Q?POGCyX0TPpE0U8NWc5Jx/m1a6hyrzC/wepdpWRYd+XAPul6V9cUurWt2E8P+?=
 =?us-ascii?Q?CbADsGLPx5Ak+Em9he7cxxYZyESmjZp/Awx/eUL3RQ0UaQgStChmEek+E+hT?=
 =?us-ascii?Q?+mcExRntUaP8JBtgDOzm0dTwoyv4H+2Wvnmco3f6sxjIDkaB0Itza6sRuNh3?=
 =?us-ascii?Q?gRs2x/S+T48II6PD1DNjOGSBJOfqLWnGwgyauEHb/wLTI7+udi4R3XEnMC0u?=
 =?us-ascii?Q?GVua9pumwCusBVj8PzJVIWOFZWagAg6s/kaJCk/HsPPe/3U5J5xauzI9abr0?=
 =?us-ascii?Q?jqtK4paUM7KIc+8Y4wrUhuJ4JwvWY2Jr+L5snbw5YQojHj3CasxNIkyabXSH?=
 =?us-ascii?Q?JyyG3tafSpwduBMxlc8rUOJi52+IdShlepIqMdkZwiSRVGyXW8Rp4Y/O/sPA?=
 =?us-ascii?Q?66ljX931CjBgpPG5LTUGPGzcl0/3p7HcnLyUX0F7qfO3s7nroBowtm1bvWEH?=
 =?us-ascii?Q?rB6Gu6bIllgNBCue3O3sFcGGE9qxjk/w60UaKnhQcyineb4VykjbblaMH2ZL?=
 =?us-ascii?Q?rKMcoXuoFPdFgy12IgCvhnejVu1fNqlx2mdhN6uNNgELVF8DXyexPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:21.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352c76bb-e0fa-4027-fdf4-08dd214070e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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

From: Aric Cyr <Aric.Cyr@amd.com>

[why]
Updating the cursor enablement register can be a slow operation and accumulates
when high polling rate cursors cause frequent updates asynchronously to the
cursor position.

[how]
Since the cursor enable bit is cached there is no need to update the
enablement register if there is no change to it.  This removes the
read-modify-write from the cursor position programming path in HUBP and
DPP, leaving only the register writes.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |  7 ++++---
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |  6 ++++--
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |  8 +++++---
 .../gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 10 ++++++----
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index e1da48b05d00..8f6529a98f31 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -480,10 +480,11 @@ void dpp1_set_cursor_position(
 	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
-	REG_UPDATE(CURSOR0_CONTROL,
-			CUR0_ENABLE, cur_en);
+	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
+		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 
-	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+	}
 }
 
 void dpp1_cnv_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 3b6ca7974e18..1236e0f9a256 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -154,9 +154,11 @@ void dpp401_set_cursor_position(
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
-	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
+	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
+		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 
-	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+	}
 }
 
 void dpp401_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index c74f6a3313a2..d537d0c53cf0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -1058,11 +1058,13 @@ void hubp2_cursor_set_position(
 	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
-	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
+	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
+		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-	REG_UPDATE(CURSOR_CONTROL,
+		REG_UPDATE(CURSOR_CONTROL,
 			CURSOR_ENABLE, cur_en);
+	}
 
 	REG_SET_2(CURSOR_POSITION, 0,
 			CURSOR_X_POSITION, pos->x,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index d38e3f3a1107..3595c74a3a2f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -730,11 +730,13 @@ void hubp401_cursor_set_position(
 			dc_fixpt_from_int(dst_x_offset),
 			param->h_scale_ratio));
 
-	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
+	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
+		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-	REG_UPDATE(CURSOR_CONTROL,
-		CURSOR_ENABLE, cur_en);
+		REG_UPDATE(CURSOR_CONTROL,
+			CURSOR_ENABLE, cur_en);
+	}
 
 	REG_SET_2(CURSOR_POSITION, 0,
 		CURSOR_X_POSITION, x_pos,
-- 
2.34.1

