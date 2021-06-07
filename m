Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A731DC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7752D60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7752D60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBE56E93D;
	Mon,  7 Jun 2021 16:48:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC046E93D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfRmgGiIvQuqqTdAs5eH7ztAN+dsjFCcunuGh0R5R8fJ1hfbbMHh7sf2DdnhPnZNtAJEOvHc9J5pgCpiRjOYQmHiMCySULyyXOi17pum5e7Im5i7dGMataq7Z0PwoOVnU6R9kXS2G10TYo642BON9I1OzjitGiDMP/gYfl6SiFhZl/+nSI8J4F2JbrxAd29TGv21iO2VAJW3FnlDSRS9J5KlG5NE05D/BmsZT/RYTJ9qxr6tTP4p1XLnpVm5DzcNYLoBsO+x5g4UKfQ+t3aZb8t2xbAOQZ01VDxxIywV9WWtNtFe31k6yKcOenuhVbQq9c4ymQWG6dHFksNVefMFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzqH3C392GJKu0Onw8QmSHBbOyNGcmEzY/GY/cmtzKI=;
 b=DPfL51L4xo+W711h6ut23h9fcVzdfUUE0JVyKAZbmn/E2Lmn47n9smAbIZe8J8sw+dLyOTALw8EGzsC/9PpbO3kc0ezIplSRC7XgrTRuG1mElGqwGcuZB4r/tXKBdcXTtUhSEavqYCYPaeWLZlFQij5hyk2/xj3aHIIkIBsX/64qjcrSQjDcrytkCkbog6bw19CZqr1GHCovdR1FVzJWBsKJ1fiG+BoLDyleUp/dUvUAeWzdjt/MPozcJHVwsBS5+DiYk6AFgox+zXq0RXzLnzcb/FEN+uYtNj78hp1LcuSP4uPH/wJ1vdAxkgFmgfv3hunc61nFph68pwjRxa7axA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzqH3C392GJKu0Onw8QmSHBbOyNGcmEzY/GY/cmtzKI=;
 b=NExlWgz8BuLria3nPLI01s9pJZczl1lC2mlciURII/QIfowMf69Eh6khDa+I903j954itv5bdetcaBgvQUVMfWNACTwvprJ48E0gWfV8yMcG7m8XplgAKtxh9yK/pviE6jEcWV/Qy1xuIl7YhEm9KagJy8jy7/7KCZgcjeDzswM=
Received: from BN6PR2001CA0021.namprd20.prod.outlook.com
 (2603:10b6:404:b4::31) by MN2PR12MB3134.namprd12.prod.outlook.com
 (2603:10b6:208:c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:48:51 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::55) by BN6PR2001CA0021.outlook.office365.com
 (2603:10b6:404:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:50 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:46 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/30] drm/amd/display: Add Interface to set FIFO ERRDET SW
 Override
Date: Tue, 8 Jun 2021 00:47:03 +0800
Message-ID: <20210607164714.311325-20-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed0f0e84-35c2-4738-dea8-08d929d42073
X-MS-TrafficTypeDiagnostic: MN2PR12MB3134:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31343C26D437DC9759C2A50CFF389@MN2PR12MB3134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA68zh64NScRqwOmpHItlCpZzJQGySSihc4389YYEYvu9xvhdE8wCPF3dQRAgEmSbaxa73YqXq8pwsl9oGupCbnscCT+RmiyzY2XYc3tyKzDAvYnNkJO2V1duqtm1/bBJfn3tpZ65gv/CA1SQbhGSdJsgCO07v4rQ8KDxnhzinaZn2f9uO0XwScXdauf8MocdZcPrxKrF/JNRpKsFaoTloQBvB96JAwmFm9BQqpZGMa7TgCHYhdxBNKUU5Ss83Nv+Hvet42svBREUosMBabbJldgvzzVIwjJ+PvVQajTXdlY6qyQq+yG4C8dBMPSrXHB6lyAwb2tgcKHcs+bCLbWS8DapXwuSXUHflY0wowDz2onCDWqUKM3dbM0ZNj3WTMprgkksLNXtr95EC7WNfg8aGHLum6mNQoAoTY21wp33mDzfyduSIrascB47RIY6V/S6h86afYkdfViKeMEsZPlbm2j8luLVO6FHhHsCheBfiN/GiX1X4sKTEoolBeRwBvk54nDH6IQJzmMtBPC3XStHaCOuZ15h+eerl4olgvWSiXse9TRoFkPTqBBMYdAYfV8QMazKhihr8NtWkleaH1WTXcHekxrYJKIcSdG9mvCWrT6lmtjssnCVUih+9QwEvp6zLX7rP+vqzAVgriB/AjQTfygzilj18gmS6knHRjnVTvuaYD+oIEh9YVhPByPFbII
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(46966006)(36840700001)(4326008)(82310400003)(316002)(356005)(336012)(36860700001)(6916009)(7696005)(82740400003)(8936002)(70206006)(70586007)(478600001)(2616005)(1076003)(26005)(16526019)(186003)(2906002)(5660300002)(47076005)(36756003)(6666004)(54906003)(426003)(8676002)(86362001)(83380400001)(44832011)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:50.3476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0f0e84-35c2-4738-dea8-08d929d42073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
HW has handed down a new sequence which requires access to the FIFO
ERRDET SW Override register.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c | 10 +++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 29 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c |  1 +
 .../drm/amd/display/dc/dcn301/dcn301_dccg.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  2 ++
 6 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
index 8774406120fc..5679983158e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
@@ -96,6 +96,15 @@ void dccg2_get_dccg_ref_freq(struct dccg *dccg,
 	return;
 }
 
+void dccg2_set_fifo_errdet_ovr_en(struct dccg *dccg,
+		bool en)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE(DISPCLK_FREQ_CHANGE_CNTL,
+			DCCG_FIFO_ERRDET_OVR_EN, en ? 1 : 0);
+}
+
 void dccg2_init(struct dccg *dccg)
 {
 }
@@ -103,6 +112,7 @@ void dccg2_init(struct dccg *dccg)
 static const struct dccg_funcs dccg2_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
+	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index d407f33308b9..7e471c9ed477 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -34,7 +34,8 @@
 	DCCG_SRII(DTO_PARAM, DPPCLK, 1),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 2),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 3),\
-	SR(REFCLK_CNTL)
+	SR(REFCLK_CNTL),\
+	SR(DISPCLK_FREQ_CHANGE_CNTL)
 
 #define DCCG_REG_LIST_DCN2() \
 	DCCG_COMMON_REG_LIST_DCN_BASE(),\
@@ -59,7 +60,16 @@
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(REFCLK_CNTL, REFCLK_CLOCK_EN, mask_sh),\
-	DCCG_SF(REFCLK_CNTL, REFCLK_SRC_SEL, mask_sh)
+	DCCG_SF(REFCLK_CNTL, REFCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_STEP_DELAY, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_STEP_SIZE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_FREQ_RAMP_DONE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_MAX_ERRDET_CYCLES, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_RESET, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_STATE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_OVR_EN, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_CHG_FWD_CORR_DISABLE, mask_sh)
+
 
 #define DCCG_MASK_SH_LIST_DCN2(mask_sh) \
 	DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh),\
@@ -74,7 +84,16 @@
 	type DPPCLK_DTO_ENABLE[6];\
 	type DPPCLK_DTO_DB_EN[6];\
 	type REFCLK_CLOCK_EN;\
-	type REFCLK_SRC_SEL;
+	type REFCLK_SRC_SEL;\
+	type DISPCLK_STEP_DELAY;\
+	type DISPCLK_STEP_SIZE;\
+	type DISPCLK_FREQ_RAMP_DONE;\
+	type DISPCLK_MAX_ERRDET_CYCLES;\
+	type DCCG_FIFO_ERRDET_RESET;\
+	type DCCG_FIFO_ERRDET_STATE;\
+	type DCCG_FIFO_ERRDET_OVR_EN;\
+	type DISPCLK_CHG_FWD_CORR_DISABLE;\
+	type DISPCLK_FREQ_CHANGE_CNTL;
 
 #define DCCG3_REG_FIELD_LIST(type) \
 	type PHYASYMCLK_FORCE_EN;\
@@ -98,6 +117,7 @@ struct dccg_registers {
 	uint32_t DPPCLK_DTO_CTRL;
 	uint32_t DPPCLK_DTO_PARAM[6];
 	uint32_t REFCLK_CNTL;
+	uint32_t DISPCLK_FREQ_CHANGE_CNTL;
 	uint32_t HDMICHARCLK_CLOCK_CNTL[6];
 	uint32_t PHYASYMCLK_CLOCK_CNTL;
 	uint32_t PHYBSYMCLK_CLOCK_CNTL;
@@ -117,6 +137,9 @@ void dccg2_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz);
 
+void dccg2_set_fifo_errdet_ovr_en(struct dccg *dccg,
+		bool en);
+
 void dccg2_init(struct dccg *dccg);
 
 struct dccg *dccg2_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
index 60cf3ff68cb0..6e1befbb4458 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
@@ -100,6 +100,7 @@ void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 static const struct dccg_funcs dccg21_funcs = {
 	.update_dpp_dto = dccg21_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
+	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
index b822a13e40ce..570f6eacd4e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
@@ -46,6 +46,7 @@
 static const struct dccg_funcs dccg3_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
+	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
index 420da414929c..6e6af02b38f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
@@ -45,6 +45,7 @@
 static const struct dccg_funcs dccg301_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
+	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 336c80a18175..693379c7e659 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -43,6 +43,8 @@ struct dccg_funcs {
 	void (*get_dccg_ref_freq)(struct dccg *dccg,
 			unsigned int xtalin_freq_inKhz,
 			unsigned int *dccg_ref_freq_inKhz);
+	void (*set_fifo_errdet_ovr_en)(struct dccg *dccg,
+			bool en);
 	void (*dccg_init)(struct dccg *dccg);
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
