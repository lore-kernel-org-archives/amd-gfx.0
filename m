Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF54C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3775A10F6FB;
	Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xyQRS21w";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BA910F6E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFnhoC3AYIzwjanlC2TEZOJpI5aakHNG2lnAOddoNq8G8lPNJ6xjvNapHYn2LBb9AndCh1jjhTnkFZnzvC/SeX9TB3b1iImh8o4oFoyBqyPKD8WV0Fpbd7lDzZGJjFwYQNvKaj2JTjy1v+hHnmS5vaPlhqqzWI/mIdOKyS4waH/HgIXsflXvF9Fk2FLDKwAohDSma7Qd/ThvaWDLT6C5pGcimxylsGkPcDqnP3RLkW3niC9nVWyPCpHE0lb+ZjQbV1jtRRuSmjmTyy8Utp8xscsT2PKLVuXUGbXlbmh9UROYPN6CM0mfx/fjAlHyjn/HZowl0BXUvZybH/t06D3mIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8+GUsH2ULUnwMH7ojtl81DwPF6xZkokam1RxsHG00o=;
 b=r+YbA8v/+V/wqgUutFI3dXlu/Xxo1NW8mUXZ+A8GHrvkMdy5bFMf4xjULwXu00tuU0Z1yKzjKooWhfYJLGoVn8FdoRBOAQwmwpYTH2SSLQwHI8T3k618mTYVdbIL25tyNZaLXEyUEhdXszP/wKvP2cUvgoVijpYvAQpoLlUNI0/TmzCqrH1ya+t7gIFB49X+ElhR4/11JqcENl0eTsELl4u6nhpUiDw5z370CHJZQPkw54y0xo3mqKPR+pNUkC+4h2m8HJGHEhDZSEAvAQwm8slYNmIscJquQXMbEJ6M4txUb9dSHQDqtNzyk4s+Q7jLmpzZI6NG5hCHUObivExA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8+GUsH2ULUnwMH7ojtl81DwPF6xZkokam1RxsHG00o=;
 b=xyQRS21wDDLpPyqTbd84fI5VHSjCRZiePMJ5njb5EQfrCzN9sU7StSXdJUe9yY0h3HaoZ82jUGEalAvWITDrT2kynjx9LoZHly9ZpmgGKcJLUQvOAPJJZqlNFatlZcWf8sHTWW/aPCWtBid5UoszfRTCOKSPTmCR2Fe9WnGVJXE=
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Thu, 9 Jul 2026 21:02:36 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::5d) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:36 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:27 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 67/80] drm/amd/display: enable hdmistreamclk_rcg by default
 for dcn42
Date: Thu, 9 Jul 2026 16:48:35 -0400
Message-ID: <20260709205936.5719-68-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c77b3-d8ea-4993-f4f5-08deddfd6757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sD9R2OQeT2lMKmOGkMXIFcQ+7Wb1hnGbptS8pAtUWDlbillhzY7IPL5gC0TfI25J+kAjyyyGnItVHkMiAh2SLOPtU+K58eNZ4Z2lv32uxRF0llwl04cRI0cu/HzY4mQsG1LhGTx2pKKRYeY8CE0/svt3VwuUsHWDhH+fX0ZWfmY1l8GOml8QdmqZU+bcHA2s+ONJu5gDpv2fqxO1BdAKScR2XKkLCe88XptO3Tify8W70sDtriQylXq6APPPAzLlwbW6oTUYspJt8tfwTCuzFTWBuc0CKr0G0wkcFLTA2G/diMf8D8rnVWBSlXADGUbkJgdhqPWJKvndANxrQu8luFgjNtJN/YHMvnAAH2BKCvDbAew7wEghtZna91s98uTl1hPepJpYap5Y+xwMj8IK/2N1ZgsbUSnYpzP3RspAUUVPxr/obosNhX6FvEv56vEMjUVmk5NroTREXdQE//fE1UcvvWwjJ0qfiO0tp/F7pLsTpHMVJObRtJCaFG4OHWBFJNT/1xchxoBidrKaCXJbsyt1kEzLnIe/IYTKGPESL+zeP1Ujqdk9UxMZFuP8xxOXbZAQRly7e61q78reMpLYpb6Xpcs44VVexamnzXkQtp1CDS7JJDCwv+1CZlkp0wwc0Tq9ikNp29Cp995SZWNx3n3DMez37NMMKRPvdafujzBvkiVdXkOw+NelIB0CpQtktp7U8N8zbDvuH/oHTEsBEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dHhFPZVPQcX7P3cw40qcomb7V0vIj8WuapRiphC/TJhPY0Ev/EeMskU3gvNUlScBkKtzWV4LH84oiDZ1bL8GbMla5Q9qC7XOx1cOKjv3YrhIQ5O4qDL9gc0O3p48dcfckHtMtXkDEV8aw7PwISvJJaf8w2Aoz0vvtSdLG4mBVeZ2f5n1Aj4vQUqX/MlUU7oNdMT4sQGulPXtTIsW6GcP8SzSDI2yP/4A8NtTv7FKNBKbc9tHC22EAEtAarHYxP4GntfrUtc3tNqhQtuQ5xBNjEEAc530T+yAvUiX2aU3ccwBGMTiRfHl1lkHD0EybcavAjUzKv/yx3fTjjTJ1MAfY+2zowcTbbjtDNm2fYrhW3sPK7hB99/5JUKXDE3FvYW6WXXsG6KLEzvtHw3lV8X3BxaxL3zPq+UkoMuMMQrez842uNmFFbu/BLSWJcGMITkb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:36.3100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c77b3-d8ea-4993-f4f5-08deddfd6757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
enable hdmistreamclk_rcg by default

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 8 ++++----
 .../drm/amd/display/dc/resource/dcn42/dcn42_resource.c    | 2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 85da247139c3..95ba9baa5102 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1680,8 +1680,11 @@ void dccg35_set_hdmistreamclk_root_clock_gating(struct dccg *dccg, bool enable)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream)
-		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, enable ? 1 : 0);
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream && !enable) {
+		DC_LOG_DEBUG("%s: HDMISTREAMCLK0_ROOT_GATE DISABLE = 0 bypassed", __func__);
+		return;
+	}
+	REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, enable ? 1 : 0);
 
 	DC_LOG_DEBUG("%s: HDMISTREAMCLK0_ROOT_GATE_DISABLE = %d\n", __func__, enable ? 1 : 0);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 01027d120cb0..f14c39a643da 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -487,7 +487,7 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 
 void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
 {
-	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp && !clock_on)
 		return;
 
 	if (hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control) {
@@ -498,7 +498,7 @@ void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hpo_inst, bool clock_on)
 {
-	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpstream && !clock_on)
 		return;
 
 	if (hws->ctx->dc->res_pool->dccg->funcs->set_dpstreamclk_root_clock_gating) {
@@ -509,7 +509,7 @@ void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hp
 
 void dcn35_hdmistream_root_clock_control(struct dce_hwseq *hws, bool clock_on)
 {
-	if (!hws->ctx->dc->debug.root_clock_optimization.bits.hdmistream)
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.hdmistream && !clock_on)
 		return;
 
 	if (hws->ctx->dc->res_pool->dccg->funcs->set_hdmistreamclk_root_clock_gating) {
@@ -520,7 +520,7 @@ void dcn35_hdmistream_root_clock_control(struct dce_hwseq *hws, bool clock_on)
 
 void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on)
 {
-	if (!hws->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.physymclk && !clock_on)
 		return;
 
 	if (hws->ctx->dc->res_pool->dccg->funcs->set_physymclk_root_clock_gating) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 7620da96ffc1..640a5a422f90 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -762,7 +762,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.bits = {
 			.dpp = true,
 			.dsc = true,/*dscclk and dsc pg*/
-			.hdmistream = false,
+			.hdmistream = true,
 			.hdmichar = true,
 			.dpstream = true,
 			.symclk32_se = true,
-- 
2.55.0

