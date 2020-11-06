Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD4C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1311A206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kys902U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1311A206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF39F8994D;
	Fri,  6 Nov 2020 23:19:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417FA8994D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAXRC8tL0BJuXjExuvysFQgTamZG8APxPWFMPUPDXf6rPv2XjodhiFwMo2NBAP3YosAn+ZJbRaFBriBTIdOSZt7rI/Nr7hacbCsJJLFysGf2+GgC9+7X9kGvrbUIIX8Rxo5MdJME73whRBN8wDCYRfGKy+aiRGyWdcH+i/4AT0OLLENf57tUFOTUPu4k5rhob6ejlTx7S1NNgGVNtM7yTlqeaDGF86JnXDh2Lc14GP0ymSPAOm+T2TGtN/4Qs42wzIPUzgXs8s+CQaXZt4SoBGeg4FM3GrK0g2kPeZlP9mnL7zWD4bjxZN1ep1uKsAiJIdtjnrKl5JATM8eHsNMQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExiSgdAzwNjvGXSlX3Owb5Mq5xRLIaHZQGoievDYOWg=;
 b=gFaG/jDjT9ZKSnEimNzS57rkPIYbBp8exaaQgsL1A7RB57cSE2hkHC2FdNzlrLtJcHEwcLn8U4tR42fzvpftiJf/aZSA4gP+gOpiVGWrgYK2b2BdZNUaovTW7942s9SCVDvLd1dNY1U8dc4oShrwN/cjVCSpjLgcRtALIp6x8j24iE0Qg0lz09zQfRsMb5/tNdSpcu+TkRtyewRlip/3yn9iBHDhgBM39ly8xEqJBuukonRHSRWEw/mk3oQyTJUKosXzBC8xL0/5V7zicIRvT3HGQmPukFK58nQV/8J0x9QpxZKBpjSilfC+q0HJ7AJfhSs9rGaMRL6mvht2sl8wyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExiSgdAzwNjvGXSlX3Owb5Mq5xRLIaHZQGoievDYOWg=;
 b=kys902U9aiPgIhlgT9OttnJdlno3dwZpIr10QQsiv7CjORZ6m8LoqIU972nli+O4p2Ca6fjI867jtel/pdEQ1awLEtcMyQx8uRr/O+8VCxinoqTXeE086HNIw64EOiDtxNP3H1LUfDR6VvZlY2T8HTmzRsFsdtqdeX/4m9ufpm4=
Received: from BN1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:408:e2::22)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Fri, 6 Nov
 2020 23:19:19 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::71) by BN1PR13CA0017.outlook.office365.com
 (2603:10b6:408:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:18 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:18 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:12 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Engage PSR synchronously
Date: Fri, 6 Nov 2020 18:16:59 -0500
Message-ID: <20201106231710.1290392-4-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f3c8d63-77e4-4165-b21d-08d882aa6320
X-MS-TrafficTypeDiagnostic: BYAPR12MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2949041AE61A0D7B1DE4F1CAF5ED0@BYAPR12MB2949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:76;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsc8IVOlOrFalixEwwZh9zGlonlYl3JBTK68hVjLT6StZFwasUCjvNXzuP4WVwUQ2CMsIffveAokNQRK5kTp5pPlekrxcG47ZeKz5OrqM901mdZV7O+E0q7FlDdK6jQ7j9s5qsbFerEHlc3f76cDpEtYp3Y2wQ874gKU3wTTan2a1JUGytCCmsZHAmg7eo5+SCtSL/Fg4B/7ppNeHt4VcIcB3jVTk1hQYXbR0O19xY2nAlnVXdGkDl1NorqwG7w5fMt5Min2Pi25DRptCJFjVN9JgQZ6OS2Tg2rGIEUAXl4nPmndF4u0X9I4yLZIBu6PDiunm/r7hcNr/T+mkQMz4UyH59MUKW0ygcybLPux9JEhqLzjm69MjqLHeGo7+hyMdrf0V+i1YYs6pGq/iOhL3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(2616005)(6666004)(5660300002)(82310400003)(36756003)(336012)(186003)(478600001)(2906002)(426003)(83380400001)(86362001)(47076004)(30864003)(70586007)(8936002)(82740400003)(70206006)(356005)(316002)(4326008)(54906003)(1076003)(8676002)(81166007)(26005)(7696005)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:19.1623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3c8d63-77e4-4165-b21d-08d882aa6320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[Why & How]
The intended use is to force PSR into active state and ignore all
events until explicit EXIT.
A new event force_static is added to power module. It is then sent
to FW.

Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Bindu Ramamurthy<Bindu.R@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  18 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  19 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  24 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 111 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |   2 +-
 12 files changed, 129 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 84f11c05f12c..88893c9711cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9738,7 +9738,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 					   &stream, 1,
 					   &params);
 
-	return dc_link_set_psr_allow_active(link, true, false);
+	return dc_link_set_psr_allow_active(link, true, false, false);
 }
 
 /*
@@ -9752,7 +9752,7 @@ static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
 
 	DRM_DEBUG_DRIVER("Disabling psr...\n");
 
-	return dc_link_set_psr_allow_active(stream->link, false, true);
+	return dc_link_set_psr_allow_active(stream->link, false, true, false);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d31380ea57dc..11459fb09a37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2333,11 +2333,11 @@ static int psr_get(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
-	uint32_t psr_state = 0;
+	enum dc_psr_state state = PSR_STATE0;
 
-	dc_link_get_psr_state(link, &psr_state);
+	dc_link_get_psr_state(link, &state);
 
-	*val = psr_state;
+	*val = state;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 19d97ed6beb8..710b54e065fa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -98,7 +98,7 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 
 	if (edp_link) {
 		clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
-		dc_link_set_psr_allow_active(edp_link, false, false);
+		dc_link_set_psr_allow_active(edp_link, false, false, false);
 	}
 
 }
@@ -108,7 +108,8 @@ void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 	struct dc_link *edp_link = get_edp_link(dc);
 
 	if (edp_link)
-		dc_link_set_psr_allow_active(edp_link, clk_mgr->psr_allow_active_cache, false);
+		dc_link_set_psr_allow_active(edp_link,
+				clk_mgr->psr_allow_active_cache, false, false);
 
 	if (dc->hwss.optimize_pwr_state)
 		dc->hwss.optimize_pwr_state(dc, dc->current_state);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 34e76fdc1334..6b6127f3a82c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3058,9 +3058,9 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 
 		if (link->psr_settings.psr_feature_enabled) {
 			if (enable && !link->psr_settings.psr_allow_active)
-				return dc_link_set_psr_allow_active(link, true, false);
+				return dc_link_set_psr_allow_active(link, true, false, false);
 			else if (!enable && link->psr_settings.psr_allow_active)
-				return dc_link_set_psr_allow_active(link, false, true);
+				return dc_link_set_psr_allow_active(link, false, true, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 09b51fca3d44..46d415e183ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2565,17 +2565,23 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 	return true;
 }
 
-bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool wait)
+bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active,
+		bool wait, bool force_static)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 
+	if (psr == NULL && force_static)
+		return false;
+
 	link->psr_settings.psr_allow_active = allow_active;
 
-	if (psr != NULL && link->psr_settings.psr_feature_enabled)
+	if (psr != NULL && link->psr_settings.psr_feature_enabled) {
+		if (force_static && psr->funcs->psr_force_static)
+			psr->funcs->psr_force_static(psr);
 		psr->funcs->psr_enable(psr, allow_active, wait);
-	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
+	} else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
 	else
 		return false;
@@ -2583,16 +2589,16 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 	return true;
 }
 
-bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
+bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_state(psr, psr_state);
+		psr->funcs->psr_get_state(psr, state);
 	else if (dmcu != NULL && link->psr_settings.psr_feature_enabled)
-		dmcu->funcs->get_psr_state(dmcu, psr_state);
+		dmcu->funcs->get_psr_state(dmcu, state);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8a7c4de49a4b..6c60c1fdebdc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2575,8 +2575,8 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 				sizeof(psr_error_status.raw));
 
 			/* PSR error, disable and re-enable PSR */
-			dc_link_set_psr_allow_active(link, false, true);
-			dc_link_set_psr_allow_active(link, true, true);
+			dc_link_set_psr_allow_active(link, false, true, false);
+			dc_link_set_psr_allow_active(link, true, true, false);
 
 			return true;
 		} else if (psr_sink_psr_status.bits.SINK_SELF_REFRESH_STATUS ==
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 266b93a705d5..39277aaa3e62 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -219,9 +219,10 @@ int dc_link_get_backlight_level(const struct dc_link *dc_link);
 
 int dc_link_get_target_backlight_pwm(const struct dc_link *link);
 
-bool dc_link_set_psr_allow_active(struct dc_link *dc_link, bool enable, bool wait);
+bool dc_link_set_psr_allow_active(struct dc_link *dc_link, bool enable,
+		bool wait, bool force_static);
 
-bool dc_link_get_psr_state(const struct dc_link *dc_link, uint32_t *psr_state);
+bool dc_link_get_psr_state(const struct dc_link *dc_link, enum dc_psr_state *state);
 
 bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 7ff8676daec9..bfb98fd36bf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -676,6 +676,25 @@ struct dc_plane_flip_time {
 	unsigned int prev_update_time_in_us;
 };
 
+enum dc_psr_state {
+	PSR_STATE0 = 0x0,
+	PSR_STATE1,
+	PSR_STATE1a,
+	PSR_STATE2,
+	PSR_STATE2a,
+	PSR_STATE3,
+	PSR_STATE3Init,
+	PSR_STATE4,
+	PSR_STATE4a,
+	PSR_STATE4b,
+	PSR_STATE4c,
+	PSR_STATE4d,
+	PSR_STATE5,
+	PSR_STATE5a,
+	PSR_STATE5b,
+	PSR_STATE5c
+};
+
 struct psr_config {
 	unsigned char psr_version;
 	unsigned int psr_rfb_setup_time;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index f0cebe721bcc..f3ed8b619caf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -99,7 +99,7 @@ bool dce_dmcu_load_iram(struct dmcu *dmcu,
 	return true;
 }
 
-static void dce_get_dmcu_psr_state(struct dmcu *dmcu, uint32_t *psr_state)
+static void dce_get_dmcu_psr_state(struct dmcu *dmcu, enum dc_psr_state *state)
 {
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
 
@@ -114,7 +114,7 @@ static void dce_get_dmcu_psr_state(struct dmcu *dmcu, uint32_t *psr_state)
 	REG_WRITE(DMCU_IRAM_RD_CTRL, psr_state_offset);
 
 	/* Read data from IRAM_RD_DATA in DMCU_IRAM_RD_DATA*/
-	*psr_state = REG_READ(DMCU_IRAM_RD_DATA);
+	*state = (enum dc_psr_state)REG_READ(DMCU_IRAM_RD_DATA);
 
 	/* Disable write access to IRAM after finished using IRAM
 	 * in order to allow dynamic sleep state
@@ -129,7 +129,7 @@ static void dce_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 	unsigned int dmcu_wait_reg_ready_interval = 100;
 
 	unsigned int retryCount;
-	uint32_t psr_state = 0;
+	enum dc_psr_state state = PSR_STATE0;
 
 	/* waitDMCUReadyForCmd */
 	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0,
@@ -148,12 +148,12 @@ static void dce_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
 	if (wait == true) {
 		for (retryCount = 0; retryCount <= 100; retryCount++) {
-			dce_get_dmcu_psr_state(dmcu, &psr_state);
+			dce_get_dmcu_psr_state(dmcu, &state);
 			if (enable) {
-				if (psr_state != 0)
+				if (state != PSR_STATE0)
 					break;
 			} else {
-				if (psr_state == 0)
+				if (state == PSR_STATE0)
 					break;
 			}
 			udelay(10);
@@ -513,7 +513,7 @@ static bool dcn10_dmcu_load_iram(struct dmcu *dmcu,
 	return true;
 }
 
-static void dcn10_get_dmcu_psr_state(struct dmcu *dmcu, uint32_t *psr_state)
+static void dcn10_get_dmcu_psr_state(struct dmcu *dmcu, enum dc_psr_state *state)
 {
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
 
@@ -532,7 +532,7 @@ static void dcn10_get_dmcu_psr_state(struct dmcu *dmcu, uint32_t *psr_state)
 	REG_WRITE(DMCU_IRAM_RD_CTRL, psr_state_offset);
 
 	/* Read data from IRAM_RD_DATA in DMCU_IRAM_RD_DATA*/
-	*psr_state = REG_READ(DMCU_IRAM_RD_DATA);
+	*state = (enum dc_psr_state)REG_READ(DMCU_IRAM_RD_DATA);
 
 	/* Disable write access to IRAM after finished using IRAM
 	 * in order to allow dynamic sleep state
@@ -547,7 +547,7 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 	unsigned int dmcu_wait_reg_ready_interval = 100;
 
 	unsigned int retryCount;
-	uint32_t psr_state = 0;
+	enum dc_psr_state state = PSR_STATE0;
 
 	/* If microcontroller is not running, do nothing */
 	if (dmcu->dmcu_state != DMCU_RUNNING)
@@ -575,12 +575,12 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 	 */
 	if (wait == true) {
 		for (retryCount = 0; retryCount <= 1000; retryCount++) {
-			dcn10_get_dmcu_psr_state(dmcu, &psr_state);
+			dcn10_get_dmcu_psr_state(dmcu, &state);
 			if (enable) {
-				if (psr_state != 0)
+				if (state != PSR_STATE0)
 					break;
 			} else {
-				if (psr_state == 0)
+				if (state == PSR_STATE0)
 					break;
 			}
 			udelay(500);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 67af67ef2865..df3879c713c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -34,55 +34,60 @@
 /**
  * Convert dmcub psr state to dmcu psr state.
  */
-static void convert_psr_state(uint32_t *psr_state)
+static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 {
-	if (*psr_state == 0)
-		*psr_state = 0;
-	else if (*psr_state == 0x10)
-		*psr_state = 1;
-	else if (*psr_state == 0x11)
-		*psr_state = 2;
-	else if (*psr_state == 0x20)
-		*psr_state = 3;
-	else if (*psr_state == 0x21)
-		*psr_state = 4;
-	else if (*psr_state == 0x30)
-		*psr_state = 5;
-	else if (*psr_state == 0x31)
-		*psr_state = 6;
-	else if (*psr_state == 0x40)
-		*psr_state = 7;
-	else if (*psr_state == 0x41)
-		*psr_state = 8;
-	else if (*psr_state == 0x42)
-		*psr_state = 9;
-	else if (*psr_state == 0x43)
-		*psr_state = 10;
-	else if (*psr_state == 0x44)
-		*psr_state = 11;
-	else if (*psr_state == 0x50)
-		*psr_state = 12;
-	else if (*psr_state == 0x51)
-		*psr_state = 13;
-	else if (*psr_state == 0x52)
-		*psr_state = 14;
-	else if (*psr_state == 0x53)
-		*psr_state = 15;
+	enum dc_psr_state state = PSR_STATE0;
+
+	if (raw_state == 0)
+		state = PSR_STATE0;
+	else if (raw_state == 0x10)
+		state = PSR_STATE1;
+	else if (raw_state == 0x11)
+		state = PSR_STATE1a;
+	else if (raw_state == 0x20)
+		state = PSR_STATE2;
+	else if (raw_state == 0x21)
+		state = PSR_STATE2a;
+	else if (raw_state == 0x30)
+		state = PSR_STATE3;
+	else if (raw_state == 0x31)
+		state = PSR_STATE3Init;
+	else if (raw_state == 0x40)
+		state = PSR_STATE4;
+	else if (raw_state == 0x41)
+		state = PSR_STATE4a;
+	else if (raw_state == 0x42)
+		state = PSR_STATE4b;
+	else if (raw_state == 0x43)
+		state = PSR_STATE4c;
+	else if (raw_state == 0x44)
+		state = PSR_STATE4d;
+	else if (raw_state == 0x50)
+		state = PSR_STATE5;
+	else if (raw_state == 0x51)
+		state = PSR_STATE5a;
+	else if (raw_state == 0x52)
+		state = PSR_STATE5b;
+	else if (raw_state == 0x53)
+		state = PSR_STATE5c;
+
+	return state;
 }
 
 /**
  * Get PSR state from firmware.
  */
-static void dmub_psr_get_state(struct dmub_psr *dmub, uint32_t *psr_state)
+static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 {
 	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
+	uint32_t raw_state;
 
 	// Send gpint command and wait for ack
 	dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
 
-	dmub_srv_get_gpint_response(srv, psr_state);
+	dmub_srv_get_gpint_response(srv, &raw_state);
 
-	convert_psr_state(psr_state);
+	*state = convert_psr_state(raw_state);
 }
 
 /**
@@ -123,7 +128,9 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
-	uint32_t retry_count, psr_state = 0;
+	uint32_t retry_count;
+	enum dc_psr_state state = PSR_STATE0;
+
 
 	cmd.psr_enable.header.type = DMUB_CMD__PSR;
 
@@ -144,13 +151,13 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 	 */
 	if (wait) {
 		for (retry_count = 0; retry_count <= 1000; retry_count++) {
-			dmub_psr_get_state(dmub, &psr_state);
+			dmub_psr_get_state(dmub, &state);
 
 			if (enable) {
-				if (psr_state != 0)
+				if (state != PSR_STATE0)
 					break;
 			} else {
-				if (psr_state == 0)
+				if (state == PSR_STATE0)
 					break;
 			}
 
@@ -169,12 +176,12 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
 {
 	union dmub_rb_cmd cmd;
-	uint32_t psr_state = 0;
+	enum dc_psr_state state = PSR_STATE0;
 	struct dc_context *dc = dmub->ctx;
 
-	dmub_psr_get_state(dmub, &psr_state);
+	dmub_psr_get_state(dmub, &state);
 
-	if (psr_state == 0)
+	if (state == PSR_STATE0)
 		return;
 
 	cmd.psr_set_level.header.type = DMUB_CMD__PSR;
@@ -269,11 +276,29 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	return true;
 }
 
+/**
+ * Send command to PSR to force static ENTER and ignore all state changes until exit
+ */
+static void dmub_psr_force_static(struct dmub_psr *dmub)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	cmd.psr_force_static.header.type = DMUB_CMD__PSR;
+	cmd.psr_force_static.header.sub_type = DMUB_CMD__PSR_FORCE_STATIC;
+	cmd.psr_enable.header.payload_bytes = 0;
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 static const struct dmub_psr_funcs psr_funcs = {
 	.psr_copy_settings		= dmub_psr_copy_settings,
 	.psr_enable			= dmub_psr_enable,
 	.psr_get_state			= dmub_psr_get_state,
 	.psr_set_level			= dmub_psr_set_level,
+	.psr_force_static		= dmub_psr_force_static,
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index dc121ed92d2e..4e113ac5a56b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -37,8 +37,9 @@ struct dmub_psr {
 struct dmub_psr_funcs {
 	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
 	void (*psr_enable)(struct dmub_psr *dmub, bool enable, bool wait);
-	void (*psr_get_state)(struct dmub_psr *dmub, uint32_t *psr_state);
+	void (*psr_get_state)(struct dmub_psr *dmub, enum dc_psr_state *dc_psr_state);
 	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level);
+	void (*psr_force_static)(struct dmub_psr *dmub);
 };
 
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
index 5315f1f86b21..69d9fbfb4bec 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
@@ -66,7 +66,7 @@ struct dmcu_funcs {
 	bool (*setup_psr)(struct dmcu *dmcu,
 			struct dc_link *link,
 			struct psr_context *psr_context);
-	void (*get_psr_state)(struct dmcu *dmcu, uint32_t *psr_state);
+	void (*get_psr_state)(struct dmcu *dmcu, enum dc_psr_state *dc_psr_state);
 	void (*set_psr_wait_loop)(struct dmcu *dmcu,
 			unsigned int wait_loop_number);
 	void (*get_psr_wait_loop)(struct dmcu *dmcu,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
