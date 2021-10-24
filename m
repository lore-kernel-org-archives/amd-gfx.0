Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39767C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9B56052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA9B56052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA9189E35;
	Sun, 24 Oct 2021 13:32:26 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E2B89165
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnd9jb8mi4rzLZ13eZVI+FD0bPhX8W80jNb4xzwDNGlxk8NLvOlblbzoAqfJm2CSn8dKqxDxgQUAARlhsZwGnROlTf/vir2rXgC2gFhme5RIEg1hXIXPTc5+sMUrcXscWuRRylEl3+MaWp4AIkWxf8NlPhEvUHuB4MlTWHqZmLZZq2yc3X7FtTl1850KvanCDMd8TAFa8H4cDRlwSY7fJU4fKHpA4AaScWG8FeMomBc1phACbYpkOFuf0EC3w0MzkuGgHMqqP2K8Iv6MU9Zak9OqBdnpGyQg5usoUGyYW+vsEQ3oCu+KfFGcI6d0hGLI364xt9VsXhehGH4BEYM8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWdz8D6kdTYxwjl0dFfIt60A784kwOgIYNOxpkna2KU=;
 b=nQw7ll4bT/FlVflnPmrzbulMp3DelZE3reGh3MbJ8fv2HM2atXnfUMkA3kh5GgUpKGt9tWs9emkcmuF0Om3GERbsyB10g2gHvgZF+cVsJ7Mrgnu/0eLrqyBLOz4lJdSBwRplOL54TTSvm3JK4NpTZ5dF80K6PrSMhs21YtJn3MKyMiC4dtKjBK2i3kitm/WBf7hirFcC9caNMwbGoZHbhv5XXfVpcgpFyqVWuVe+SQrIKDid5vCi8wM6atqq6k5ua3izIRB8L8g7UinymUHuX2gxyKXss5wmfuXiUKM7OSTfAr8RzfDvQlk8/mVF0xfh85OCnPfZXTEY/hlyhTdSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWdz8D6kdTYxwjl0dFfIt60A784kwOgIYNOxpkna2KU=;
 b=5BYs4Tgpe6955b+ajFB2Ce2/GSdvf/1d07j32DOLbhFcs/OGq35MGbSfo1cOJaIH+CUlVOIyl/hiZlDugvkY+eXmqPqoRDm/SJPk9puMG1TVlpPvlt8UCRGOc/un/bJvgNVQAayq/lplgedRRrKoSp6kOH/aUMD2QVfzH1Fag1c=
Received: from MWHPR1401CA0017.namprd14.prod.outlook.com
 (2603:10b6:301:4b::27) by BYAPR12MB3157.namprd12.prod.outlook.com
 (2603:10b6:a03:130::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:21 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::eb) by MWHPR1401CA0017.outlook.office365.com
 (2603:10b6:301:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:20 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:18 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Michael Strauss <michael.strauss@amd.com>,
 Haonan Wang <Haonan.Wang2@amd.com>
Subject: [PATCH 09/33] drm/amd/display: Defer GAMCOR and DSCL power down
 sequence to vupdate
Date: Sun, 24 Oct 2021 09:31:17 -0400
Message-ID: <20211024133141.239861-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14701397-dc59-47f3-cceb-08d996f2b4bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR12MB31575922D4496B9FFFC2E9E198829@BYAPR12MB3157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCwM3BYgf4zbjvE62UjLGZlCA89+1LgX2CvmlZxOHJYDHOOXkUWmmq8LGwSBz0sIMZJnabM+UVIkob1YjohxIGk/4dvJqChcl5Qi7hyHb9eybesZ8v7kdACPMu1NG2zEcuA6W9GAtsXNoGh0YP+IU4M696PcLqkWDu4eeARS8eL/WE7070KzRZvyoEy0XOa4YnhVItQIbVwZCuydSfWGE9HkLfgNAfkoSNyDfvXVWfwlCw5kTqAVEFf6+HFYJRBWP+STjQIuHDl9QUZ6fpYwlEQ12/Vj8nMF3CRwNfNW/QxfBKnViVCiBAzp2OzIEZIoc04GWCOI9AscQ4URp5Mls7+hfFIMJO/KMOMGFZ5d+07nfQ2VP2+8xCwMm3yIFSPJ+x0Ro6TCyi3czmcaDTrU4wM1seUmoghh9WDd5jgMZFrBmljoi21yktSniCItlelJ/PMa9diyabYXAJ3lPXxnIsrlmTxcC/NfyptdglWqEcbAgIyBX1C5szeCGxaTZGWIsXIg18hmIs42auThZg4Tz7F2mDqVR4FtxCN6ec6p3DjOgP/mYuj0J6mwZi9DOjB8v1JlmsveI0jIl5sLlSNkMtkbW+fYoAnoO8R8nRgv7DF+zrzRibVLiziaJ4my+35/GHvJ0vb6Do5pCYzjjGSJm07WS2L4k4Arw/0mb+BWlFQmml9zEEGjGdoOzbv1pmSTZyxnI6XYW19iRdZ+HbQ0xOVN7UioaoXBaNdVLWbb/dQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(316002)(8936002)(356005)(2906002)(70206006)(36860700001)(86362001)(54906003)(47076005)(81166007)(8676002)(83380400001)(508600001)(2616005)(426003)(36756003)(1076003)(26005)(6916009)(336012)(5660300002)(82310400003)(186003)(16526019)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:20.6535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14701397-dc59-47f3-cceb-08d996f2b4bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3157
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
Every other CM LUT power down sequence is deferred to next vupdate as
memory powerdown updates immediately while selecting LUTs is double
buffered.  Previous update to defer LUT power down missed GAMCOR and
DSCL, causing some visible flicker when entering/exiting fullscreen
video playback.

[HOW]
Update dpp deferred update loop to check for valid DPPs in res_pool
instead of referencing dcn_ip which turns out to not be populated during
runtime.  Move GAMCOR and DSCL powerdown to dpp deferred updates.

Reviewed-by: Haonan Wang <Haonan.Wang2@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  6 ++++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 14 ++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c    |  8 ++++++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |  2 ++
 6 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a575d372ef5f..6dbcb1b1eb5c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1897,12 +1897,14 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
 static void process_deferred_updates(struct dc *dc)
 {
 #ifdef CONFIG_DRM_AMD_DC_DCN
-	int i;
+	int i = 0;
 
-	if (dc->debug.enable_mem_low_power.bits.cm)
+	if (dc->debug.enable_mem_low_power.bits.cm) {
+		ASSERT(dc->dcn_ip->max_num_dpp);
 		for (i = 0; i < dc->dcn_ip->max_num_dpp; i++)
 			if (dc->res_pool->dpps[i]->funcs->dpp_deferred_update)
 				dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
+	}
 #endif
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index cb9767ddf93d..44293d66b46b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -205,9 +205,17 @@ static void dpp1_power_on_dscl(
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
 
 	if (dpp->tf_regs->DSCL_MEM_PWR_CTRL) {
-		REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, power_on ? 0 : 3);
-		if (power_on)
+		if (power_on) {
+			REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, 0, 1, 5);
+		} else {
+			if (dpp->base.ctx->dc->debug.enable_mem_low_power.bits.dscl) {
+				dpp->base.ctx->dc->optimized_required = true;
+				dpp->base.deferred_reg_writes.bits.disable_dscl = true;
+			} else {
+				REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, 3);
+			}
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index ef5f6da5248a..c1d967ed6551 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -494,6 +494,20 @@ void dpp3_deferred_update(
 	int bypass_state;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
+	if (dpp_base->deferred_reg_writes.bits.disable_dscl) {
+		REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, 3);
+		dpp_base->deferred_reg_writes.bits.disable_dscl = false;
+	}
+
+	if (dpp_base->deferred_reg_writes.bits.disable_gamcor) {
+		REG_GET(CM_GAMCOR_CONTROL, CM_GAMCOR_MODE_CURRENT, &bypass_state);
+		if (bypass_state == 0) {	// only program if bypass was latched
+			REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, 3);
+		} else
+			ASSERT(0); // LUT select was updated again before vupdate
+		dpp_base->deferred_reg_writes.bits.disable_gamcor = false;
+	}
+
 	if (dpp_base->deferred_reg_writes.bits.disable_blnd_lut) {
 		REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, &bypass_state);
 		if (bypass_state == 0) {	// only program if bypass was latched
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 72c5687adc68..387eec616162 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -136,9 +136,13 @@ static void dpp3_power_on_gamcor_lut(
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
-		REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, power_on ? 0 : 3);
-		if (power_on)
+		if (power_on) {
+			REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, 0, 1, 5);
+		} else {
+			dpp_base->ctx->dc->optimized_required = true;
+			dpp_base->deferred_reg_writes.bits.disable_gamcor = true;
+		}
 	} else
 		REG_SET(CM_MEM_PWR_CTRL, 0,
 				GAMCOR_MEM_PWR_DIS, power_on == true ? 0:1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8b4a97e39f1a..abbfb5aeff2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2454,6 +2454,8 @@ static bool dcn31_resource_construct(
 
 	dc->cap_funcs = cap_funcs;
 
+	dc->dcn_ip->max_num_dpp = dcn3_1_ip.max_num_dpp;
+
 	DC_FP_END();
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 9f12792b7e59..3ef7faa92052 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -34,6 +34,8 @@ union defer_reg_writes {
 		bool disable_blnd_lut:1;
 		bool disable_3dlut:1;
 		bool disable_shaper:1;
+		bool disable_gamcor:1;
+		bool disable_dscl:1;
 	} bits;
 	uint32_t raw;
 };
-- 
2.25.1

