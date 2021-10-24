Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC30C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A293B6052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A293B6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AB589B96;
	Sun, 24 Oct 2021 13:32:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1814B89F9F
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+rCGxl9R9YGW/pnLx5fP2rgE0q0ArFpPuMvGSmz8fOtlCucPbTMUJ8w2QTvmkE1BAmxniNYRgmZZ6DMqzHF0OO4HWdE39pqDFFlwuMNwSqC7mVr6iD0uP4rZ8ujjZ/O+01HwQ4gvId6KSq7UxiKVCpTUBqDE9M5/ezzLfzkeRUFrWwz4nCFaDrE2L8BSb2U8jiW64O3J/EW94KYWRtFYD06TMWwhAfA1oLQ8x/c7UenS3csaZPpKwVKjbjfA10dpwNbZZqiJeQUbpfoEoxLeor+4oRCsCG+qwmIoBh7o9omxFkGCAQieEjN4yZHVvvZU3P+SIPHYrGDIfB+9qpPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMVsTkKnD8pLro4tCSz8ytKVYBhNWa32Oko0l2GZqPo=;
 b=dhPsDRY5j4iz1sxhCjXaMZsGC9qcCcdkzbAPeAS1ApCaIpeyg7Qt5CgWiRkj+ghl5ldnNsz2j+GVOeCudkjsLoNhDSQwmSucq1ELXekv8cz8fQjuu44HEoAb41LhNcpYPmoJP8IENSn4kARW0kKoGOXSrgBaJakZZpUiX0xihSOkHyRIfO3gqvuokkF5N6UsP008rDHuCrULMIW8N0xsM/ZHe9L1681r9FZAbF0x2+1K2FfJDW1ZZoJ8bwKlC5YWSZJaZu14+PJrHyi+gSRMB57XbjACfFAvcrYrYu+dc/RLK0JzTeYUu1RukQ/QakMtG9KbPLLe9YpkM1yN71htQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMVsTkKnD8pLro4tCSz8ytKVYBhNWa32Oko0l2GZqPo=;
 b=TM8waCLh4Aqv8LSno1cAY98ocA3atnmKHs7fEhc/SXZP83dnVrALiN+dnGVfCNLVSQPgZvQx8pALrRuZAm0EzRGctAxt4x7+meAmk9bp+OBNYT401ts9v/JMGYEDe0+kIcAzRRD+AROWskSsGPdj6/hZ4RoL2vU2gSJ5d0pglEA=
Received: from MWHPR1401CA0023.namprd14.prod.outlook.com
 (2603:10b6:301:4b::33) by DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:15 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::ba) by MWHPR1401CA0023.outlook.office365.com
 (2603:10b6:301:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:15 +0000
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
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:15 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:12 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Robin Chen <po-tchen@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 04/33] drm/amd/display: dc_link_set_psr_allow_active
 refactoring
Date: Sun, 24 Oct 2021 09:31:12 -0400
Message-ID: <20211024133141.239861-5-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20c51a42-6939-4f36-4d73-08d996f2b160
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5119D8BB324018AA5BD612BA98829@DM4PR12MB5119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqAH8fHL9YnHjaPhuEwJOtPjtJ7UiwiKbz38RxZbaDh9+BkXi2eY1R7vwxLQVTxDPUmj+fb/gin2IadMaJ0LhGSMStwRc4FbP8eTF8thLLuhqAJyGuEf8PzRjQ0HUnFxhkQ/fUk/2ox17NN+Flj+oa/VY/1d1/hYFfIzBUeWiUvA66OMMb0tbsroViluUbsTHTa23FNcDJRKigc/XUde5o2LrAyt3zE3PEJIjFYPftp6lOyBjSfG26f7Ny0epht+iHC3c+imyEc7BkMkr9bbgBUNJe1MxM6w6Iz9UWR2xRyX+qv32T2iAtGAuybzTNu2pu6eWsM9i8slLKPgS1+dw6KyUA+5y3y8qu4A0Dn9msWNClg+T46KW/g61kngyjZR0qhwFhiTBkMlZ7hlGA3ru1eCr8p3D7vGcro41EnLCWmmEzpXWRZkQ+CPt6ZU4v35ulE95Ky4tsLtVCZIg3EdQi9iB7GRawPC84UUvDa2XlTeP9tyW5+ju520sVbjiQYxZczLX7P45UppYcw8EXySvemDlWJFW+kANNEA1uMRebRMoj7JjCYFmp9UVaB7j+BcVmTxiIZWjU46XQap+uwGm3tQ9P/NpN/CVGN5Oys7CEsMAmQ2GlINuFPnbhNmLou9hYns+qdIkhhfS/obfc1+V5Dxue3cku1jDiXm3tlLUfrbZs+fr1fnHRxgZKBtk3ePX0/LSdoQnLh0anfEgpGztNdqEFCfQgkhv9qB+o2n0vA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(36860700001)(54906003)(70586007)(336012)(186003)(47076005)(5660300002)(8676002)(82310400003)(36756003)(8936002)(4326008)(30864003)(2906002)(83380400001)(26005)(356005)(1076003)(81166007)(70206006)(86362001)(426003)(16526019)(2616005)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:15.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c51a42-6939-4f36-4d73-08d996f2b160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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

From: Robin Chen <po-tchen@amd.com>

[Why]
To expose new power optimization flags to PSR interface. It allows the
PSR related power features can be enabled separately base on different
use scenarios.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Robin Chen <po-tchen@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 +++-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  6 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  7 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 39 ++++++++++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  8 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 20 ++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 46 +++++++++++++++++++
 10 files changed, 125 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 70a554f1e725..c022e56f9459 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -107,6 +107,8 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	 */
 	// Init fail safe of 2 frames static
 	unsigned int num_frames_static = 2;
+	unsigned int power_opt = 0;
+	bool psr_enable = true;
 
 	DRM_DEBUG_DRIVER("Enabling psr...\n");
 
@@ -133,7 +135,9 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 					   &stream, 1,
 					   &params);
 
-	return dc_link_set_psr_allow_active(link, true, false, false);
+	power_opt |= psr_power_opt_z10_static_screen;
+
+	return dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
 }
 
 /*
@@ -144,10 +148,12 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
  */
 bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
 {
+	unsigned int power_opt = 0;
+	bool psr_enable = false;
 
 	DRM_DEBUG_DRIVER("Disabling psr...\n");
 
-	return dc_link_set_psr_allow_active(stream->link, false, true, false);
+	return dc_link_set_psr_allow_active(stream->link, &psr_enable, true, false, &power_opt);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 1548b2a3fe03..acbda3962650 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -100,11 +100,13 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 
 	if (edp_num) {
 		for (panel_inst = 0; panel_inst < edp_num; panel_inst++) {
+			bool allow_active = false;
+
 			edp_link = edp_links[panel_inst];
 			if (!edp_link->psr_settings.psr_feature_enabled)
 				continue;
 			clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
-			dc_link_set_psr_allow_active(edp_link, false, false, false);
+			dc_link_set_psr_allow_active(edp_link, &allow_active, false, false, NULL);
 		}
 	}
 
@@ -124,7 +126,7 @@ void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 			if (!edp_link->psr_settings.psr_feature_enabled)
 				continue;
 			dc_link_set_psr_allow_active(edp_link,
-					clk_mgr->psr_allow_active_cache, false, false);
+					&clk_mgr->psr_allow_active_cache, false, false, NULL);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8be04be19124..a575d372ef5f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3479,6 +3479,7 @@ void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_
 bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 {
 	int i;
+	bool allow_active;
 
 	for (i = 0; i < dc->current_state->stream_count ; i++) {
 		struct dc_link *link;
@@ -3490,10 +3491,12 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 
 		if (link->psr_settings.psr_feature_enabled) {
 			if (enable && !link->psr_settings.psr_allow_active) {
-				if (!dc_link_set_psr_allow_active(link, true, false, false))
+				allow_active = true;
+				if (!dc_link_set_psr_allow_active(link, &allow_active, false, false, NULL))
 					return false;
 			} else if (!enable && link->psr_settings.psr_allow_active) {
-				if (!dc_link_set_psr_allow_active(link, false, true, false))
+				allow_active = false;
+				if (!dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL))
 					return false;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index e5d6cbd7ea78..dfec35caf426 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2916,8 +2916,8 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 	return true;
 }
 
-bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active,
-		bool wait, bool force_static)
+bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
+		bool wait, bool force_static, const unsigned int *power_opts)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
@@ -2930,20 +2930,33 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active,
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	link->psr_settings.psr_allow_active = allow_active;
+	/* Set power optimization flag */
+	if (power_opts && link->psr_settings.psr_power_opt != *power_opts) {
+		link->psr_settings.psr_power_opt = *power_opts;
+
+		if (psr != NULL && link->psr_settings.psr_feature_enabled && psr->funcs->psr_set_power_opt)
+			psr->funcs->psr_set_power_opt(psr, link->psr_settings.psr_power_opt);
+	}
+
+	/* Enable or Disable PSR */
+	if (allow_active && link->psr_settings.psr_allow_active != *allow_active) {
+		link->psr_settings.psr_allow_active = *allow_active;
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (!allow_active)
-		dc_z10_restore(dc);
+		if (!link->psr_settings.psr_allow_active)
+			dc_z10_restore(dc);
 #endif
 
-	if (psr != NULL && link->psr_settings.psr_feature_enabled) {
-		if (force_static && psr->funcs->psr_force_static)
-			psr->funcs->psr_force_static(psr, panel_inst);
-		psr->funcs->psr_enable(psr, allow_active, wait, panel_inst);
-	} else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
-		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
-	else
-		return false;
+		if (psr != NULL && link->psr_settings.psr_feature_enabled) {
+			if (force_static && psr->funcs->psr_force_static)
+				psr->funcs->psr_force_static(psr, panel_inst);
+			psr->funcs->psr_enable(psr, link->psr_settings.psr_allow_active, wait, panel_inst);
+		} else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) &&
+			link->psr_settings.psr_feature_enabled)
+			dmcu->funcs->set_psr_enable(dmcu, link->psr_settings.psr_allow_active, wait);
+		else
+			return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 296b0defcd1c..3819eb58a9e5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3523,6 +3523,8 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 		if (psr_error_status.bits.LINK_CRC_ERROR ||
 				psr_error_status.bits.RFB_STORAGE_ERROR ||
 				psr_error_status.bits.VSC_SDP_ERROR) {
+			bool allow_active;
+
 			/* Acknowledge and clear error bits */
 			dm_helpers_dp_write_dpcd(
 				link->ctx,
@@ -3532,8 +3534,10 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 				sizeof(psr_error_status.raw));
 
 			/* PSR error, disable and re-enable PSR */
-			dc_link_set_psr_allow_active(link, false, true, false);
-			dc_link_set_psr_allow_active(link, true, true, false);
+			allow_active = false;
+			dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL);
+			allow_active = true;
+			dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL);
 
 			return true;
 		} else if (psr_sink_psr_status.bits.SINK_SELF_REFRESH_STATUS ==
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fc3f0fd1f068..f0141f27880f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -342,6 +342,12 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SWIZZLE = 9,
 };
 
+enum dc_psr_power_opts {
+	psr_power_opt_invalid = 0x0,
+	psr_power_opt_smu_opt_static_screen = 0x1,
+	psr_power_opt_z10_static_screen = 0x10,
+};
+
 enum dcc_option {
 	DCC_ENABLE = 0,
 	DCC_DISABLE = 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a73d64b1fd33..eaff496690af 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -85,6 +85,7 @@ struct psr_settings {
 	 */
 	bool psr_frame_capture_indication_req;
 	unsigned int psr_sdp_transmit_line_num_deadline;
+	unsigned int psr_power_opt;
 };
 
 /*
@@ -267,8 +268,8 @@ int dc_link_get_backlight_level(const struct dc_link *dc_link);
 
 int dc_link_get_target_backlight_pwm(const struct dc_link *link);
 
-bool dc_link_set_psr_allow_active(struct dc_link *dc_link, bool enable,
-		bool wait, bool force_static);
+bool dc_link_set_psr_allow_active(struct dc_link *dc_link, const bool *enable,
+		bool wait, bool force_static, const unsigned int *power_opts);
 
 bool dc_link_get_psr_state(const struct dc_link *dc_link, enum dc_psr_state *state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 05d96ca80512..90eb8eedacf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -227,6 +227,25 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
+/**
+ * Set PSR power optimization flags.
+ */
+static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.psr_set_power_opt.header.type = DMUB_CMD__PSR;
+	cmd.psr_set_power_opt.header.sub_type = DMUB_CMD__SET_PSR_POWER_OPT;
+	cmd.psr_set_power_opt.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_power_opt_data);
+	cmd.psr_set_power_opt.psr_set_power_opt_data.power_opt = power_opt;
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 /*
  * Setup PSR by programming phy registers and sending psr hw context values to firmware.
  */
@@ -358,6 +377,7 @@ static const struct dmub_psr_funcs psr_funcs = {
 	.psr_set_level			= dmub_psr_set_level,
 	.psr_force_static		= dmub_psr_force_static,
 	.psr_get_residency		= dmub_psr_get_residency,
+	.psr_set_power_opt		= dmub_psr_set_power_opt,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 9675c269e649..5dbd479660f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -46,6 +46,7 @@ struct dmub_psr_funcs {
 	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
 	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency,
 	uint8_t panel_inst);
+	void (*psr_set_power_opt)(struct dmub_psr *dmub, unsigned int power_opt);
 };
 
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index bfe052afc518..f4bd9ece2af2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1379,6 +1379,10 @@ enum dmub_cmd_psr_type {
 	 * Forces PSR enabled until an explicit PSR disable call.
 	 */
 	DMUB_CMD__PSR_FORCE_STATIC		= 5,
+	/**
+	 * Set PSR power option
+	 */
+	DMUB_CMD__SET_PSR_POWER_OPT = 7,
 };
 
 /**
@@ -1676,6 +1680,44 @@ struct dmub_rb_cmd_psr_force_static {
 	struct dmub_cmd_psr_force_static_data psr_force_static_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__SET_PSR_POWER_OPT command.
+ */
+struct dmub_cmd_psr_set_power_opt_data {
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+	/**
+	 * PSR power option
+	 */
+	uint32_t power_opt;
+};
+
+/**
+ * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
+ */
+struct dmub_rb_cmd_psr_set_power_opt {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
+	 */
+	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
+};
+
 /**
  * Set of HW components that can be locked.
  *
@@ -2459,6 +2501,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSR_FORCE_STATIC command.
 	 */
 	struct dmub_rb_cmd_psr_force_static psr_force_static;
+	/**
+	 * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
+	 */
+	struct dmub_rb_cmd_psr_set_power_opt psr_set_power_opt;
 	/**
 	 * Definition of a DMUB_CMD__PLAT_54186_WA command.
 	 */
-- 
2.25.1

