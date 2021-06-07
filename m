Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B31C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3979560FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3979560FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBADD6E945;
	Mon,  7 Jun 2021 16:48:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310D26E946
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvBn9NSF3sLI4npjJ8AVAO7k+2FPjfg7WbMmAMFbo0ydXBUyCAnGlLGqkVNLS4eBUYODE2fzqrIqYQ8of29Axy24LZqcB05pj90nRzt1AYYTqnMeIt3lR1Zz1nSyisC1ylL7FPxi3p/dMBvwqNvMT3RAhIjJ0gXXZSJg3YbNJzJFSD0HXlrCAx8yd6twps6ExVX4RL+P02NVkqgRAQv45cspWK8mTCT4M3SvwsKR9ND8jHfR42z1wP+XMAIepMEJDOuAtTQlTwSZb85f0RuJ5xnc08ddr33bQHVSTf71Vc/E8H8bjffjsKldHoupbXCCYofymUE1sbYvcizGp4TcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdAbeej9nCBR7v9KT4PbuaJ91E09gvnoHnepJIvZJCk=;
 b=dDuQ/AgkoUjClZh5+xLcBjsZZOxc3YngshxfCB6pF8F/XEVZopZ2vI6XousPGjNqEwG0bSsc2TyL6gzeqQDcvfxb84A7iaptNUaHB24sl+ux92x5PbJqj7E93M/0sbUc8FNg2DGfMqt2cMTPqDQYI9tfC0RQHXfYEMTVblR1YAWJkcanzqZsSJTt4u2ANq+MlqcSg6Rtt8XCbV64lpEGnwBmdXeoa3wJakhN29GVow4dqw/pLTkwv75agtI6UacjpnOTltqoasKNeAMBnW/tYiNzJXlpJoWrP+QVNhIRXz0OiUmbtRYWg25WqP3TZ7mexKhV+bh5nEPSqsg6gFGL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdAbeej9nCBR7v9KT4PbuaJ91E09gvnoHnepJIvZJCk=;
 b=W1UBcayoQKlXV0BES5rUwS6DmGNjZsdbyfifhLJMJ+Cs4xWUy5UUuxYfZK8cBGQTlQZTbKn4TG95wtZwCQBM3yJfVDYNHpMR6mvB+YTyrdpBUm8YN+BonRzQXhiK035YGohHWzD3gmqQmnXBGUSgQFW2aQ/I0MvY2EF6gC+4IMc=
Received: from BN8PR15CA0042.namprd15.prod.outlook.com (2603:10b6:408:80::19)
 by MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:48:54 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::42) by BN8PR15CA0042.outlook.office365.com
 (2603:10b6:408:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:53 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:50 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/30] drm/amd/display: Add interface for ADD & DROP PIXEL
 Registers
Date: Tue, 8 Jun 2021 00:47:04 +0800
Message-ID: <20210607164714.311325-21-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f60671-428e-4c99-a113-08d929d4227c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01095BDFAA97F9CEC688BD12FF389@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HWjPt32RZFznvLb367E50zs/duafoouyaj8FkKfqaR4UQJlqkf9C4awAiY7hLN1VwVRMR/3dgRMWox02Ta3TY30RkghbIAf/t8zhLfVsWmzuOt/gs0WG08ak3aObeD7EjvQhk4jcIJabHe5ezDjVOYJoUd6wK8vNVJlLl1jcK5l0SI9ue7AhluBQZ1Waa4mXyyTJf2xdF5+peB9z2kJdYAFqgwPQBbDBEjswBn2atilEmo9g41/w+E8/0kTumMDX+tNi8rUS/XGeq/tm9ZXvKoklC3C/czwEuc6mOp9QFhX9e0h+bMdjJ1T5u6ZkyG97VJOHMXBAC+B3oWV6zEzDpCad5oJascKob6rkt2eXHWWUkbOtV5gCI1FT6qMzo99Ypd0jeJfc2asVAddgQtRw5Vr4l/4xvVXJ0JtWUYL9dsik14A0j+3gUvxgP0kfVNj6s+WMI4R4o08NXN6lRqrYPNlduHD1n5squRGN8BuknsS0WTJH/CYAuKL0nWN7K8SxirzF1NqwkZV+j9D8FuF+qHY593STSslvx0M1lRjmmWryvh51LVh7ZxDLGTLZbJiKuA/c8rqLuDJi0/tzy/61f/MW2HXoxa30XOHJYxJ3blxUq/2ugZeLQhBItRs21qyqEX93hB9tG7ZWBKHTEwod4t4BcVHY5WzY6/lCe+rgrkVwdehMiYcAaCHnIvj9beE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(54906003)(86362001)(2616005)(2906002)(36860700001)(30864003)(36756003)(47076005)(6916009)(186003)(4326008)(478600001)(82310400003)(336012)(426003)(1076003)(83380400001)(70206006)(70586007)(81166007)(82740400003)(8676002)(26005)(8936002)(5660300002)(316002)(6666004)(356005)(16526019)(7696005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:53.7594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f60671-428e-4c99-a113-08d929d4227c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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
HW has handed down a new sequence that requires access to these
registers.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c | 26 ++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 51 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c |  2 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c |  2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h | 17 ++++++-
 .../drm/amd/display/dc/dcn301/dcn301_dccg.c   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 ++
 8 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
index 5679983158e2..5999b2da3a01 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
@@ -105,6 +105,30 @@ void dccg2_set_fifo_errdet_ovr_en(struct dccg *dccg,
 			DCCG_FIFO_ERRDET_OVR_EN, en ? 1 : 0);
 }
 
+void dccg2_otg_add_pixel(struct dccg *dccg,
+		uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[otg_inst],
+			OTG_ADD_PIXEL[otg_inst], 0,
+			OTG_DROP_PIXEL[otg_inst], 0);
+	REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
+			OTG_ADD_PIXEL[otg_inst], 1);
+}
+
+void dccg2_otg_drop_pixel(struct dccg *dccg,
+		uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[otg_inst],
+			OTG_ADD_PIXEL[otg_inst], 0,
+			OTG_DROP_PIXEL[otg_inst], 0);
+	REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
+			OTG_DROP_PIXEL[otg_inst], 1);
+}
+
 void dccg2_init(struct dccg *dccg)
 {
 }
@@ -113,6 +137,8 @@ static const struct dccg_funcs dccg2_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
+	.otg_add_pixel = dccg2_otg_add_pixel,
+	.otg_drop_pixel = dccg2_otg_drop_pixel,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 7e471c9ed477..4369ae5bfff3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -35,12 +35,18 @@
 	DCCG_SRII(DTO_PARAM, DPPCLK, 2),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 3),\
 	SR(REFCLK_CNTL),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1),\
 	SR(DISPCLK_FREQ_CHANGE_CNTL)
 
 #define DCCG_REG_LIST_DCN2() \
 	DCCG_COMMON_REG_LIST_DCN_BASE(),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 4),\
-	DCCG_SRII(DTO_PARAM, DPPCLK, 5)
+	DCCG_SRII(DTO_PARAM, DPPCLK, 5),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 4),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 5)
 
 #define DCCG_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -48,6 +54,9 @@
 #define DCCG_SFI(reg_name, field_name, field_prefix, inst, post_fix)\
 	.field_prefix ## _ ## field_name[inst] = reg_name ## __ ## field_prefix ## inst ## _ ## field_name ## post_fix
 
+#define DCCG_SFII(block, reg_name, field_prefix, field_name, inst, post_fix)\
+	.field_prefix ## _ ## field_name[inst] = block ## inst ## _ ## reg_name ## __ ## field_prefix ## inst ## _ ## field_name ## post_fix
+
 #define DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
@@ -68,7 +77,13 @@
 	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_RESET, mask_sh),\
 	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_STATE, mask_sh),\
 	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_OVR_EN, mask_sh),\
-	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_CHG_FWD_CORR_DISABLE, mask_sh)
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_CHG_FWD_CORR_DISABLE, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh)
+
+
 
 
 #define DCCG_MASK_SH_LIST_DCN2(mask_sh) \
@@ -76,7 +91,27 @@
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 4, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 4, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 5, mask_sh),\
-	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 5, mask_sh)
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 5, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 4, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 5, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 4, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 5, mask_sh)
+
+#define DCCG_MASK_SH_LIST_DCN2_1(mask_sh) \
+	DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 4, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 4, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 5, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 5, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 3, mask_sh)
+
 
 #define DCCG_REG_FIELD_LIST(type) \
 	type DPPCLK0_DTO_PHASE;\
@@ -93,7 +128,9 @@
 	type DCCG_FIFO_ERRDET_STATE;\
 	type DCCG_FIFO_ERRDET_OVR_EN;\
 	type DISPCLK_CHG_FWD_CORR_DISABLE;\
-	type DISPCLK_FREQ_CHANGE_CNTL;
+	type DISPCLK_FREQ_CHANGE_CNTL;\
+	type OTG_ADD_PIXEL[MAX_PIPES];\
+	type OTG_DROP_PIXEL[MAX_PIPES];
 
 #define DCCG3_REG_FIELD_LIST(type) \
 	type PHYASYMCLK_FORCE_EN;\
@@ -118,6 +155,7 @@ struct dccg_registers {
 	uint32_t DPPCLK_DTO_PARAM[6];
 	uint32_t REFCLK_CNTL;
 	uint32_t DISPCLK_FREQ_CHANGE_CNTL;
+	uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPES];
 	uint32_t HDMICHARCLK_CLOCK_CNTL[6];
 	uint32_t PHYASYMCLK_CLOCK_CNTL;
 	uint32_t PHYBSYMCLK_CLOCK_CNTL;
@@ -139,6 +177,11 @@ void dccg2_get_dccg_ref_freq(struct dccg *dccg,
 
 void dccg2_set_fifo_errdet_ovr_en(struct dccg *dccg,
 		bool en);
+void dccg2_otg_add_pixel(struct dccg *dccg,
+		uint32_t otg_inst);
+void dccg2_otg_drop_pixel(struct dccg *dccg,
+		uint32_t otg_inst);
+
 
 void dccg2_init(struct dccg *dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
index 6e1befbb4458..33fc9aa8621b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
@@ -101,6 +101,8 @@ static const struct dccg_funcs dccg21_funcs = {
 	.update_dpp_dto = dccg21_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
+	.otg_add_pixel = dccg2_otg_add_pixel,
+	.otg_drop_pixel = dccg2_otg_drop_pixel,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8e3f1d0b4cc3..f3d98e3ba624 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -448,11 +448,11 @@ static const struct dccg_registers dccg_regs = {
 };
 
 static const struct dccg_shift dccg_shift = {
-		DCCG_MASK_SH_LIST_DCN2(__SHIFT)
+		DCCG_MASK_SH_LIST_DCN2_1(__SHIFT)
 };
 
 static const struct dccg_mask dccg_mask = {
-		DCCG_MASK_SH_LIST_DCN2(_MASK)
+		DCCG_MASK_SH_LIST_DCN2_1(_MASK)
 };
 
 #define opp_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
index 570f6eacd4e4..d445dfefc047 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
@@ -47,6 +47,8 @@ static const struct dccg_funcs dccg3_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
+	.otg_add_pixel = dccg2_otg_add_pixel,
+	.otg_drop_pixel = dccg2_otg_drop_pixel,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
index 029dda13a464..35a613bb08bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
@@ -38,10 +38,25 @@
 
 #define DCCG_REG_LIST_DCN30() \
 	DCCG_REG_LIST_DCN2(),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 4),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 5),\
 	SR(PHYASYMCLK_CLOCK_CNTL),\
 	SR(PHYBSYMCLK_CLOCK_CNTL),\
 	SR(PHYCSYMCLK_CLOCK_CNTL)
 
+#define DCCG_MASK_SH_LIST_DCN3AG(mask_sh) \
+	DCCG_MASK_SH_LIST_DCN2_1(mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh)
+
 #define DCCG_MASK_SH_LIST_DCN3(mask_sh) \
 	DCCG_MASK_SH_LIST_DCN2(mask_sh),\
 	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
@@ -49,7 +64,7 @@
 	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
 	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh)
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh),\
 
 struct dccg *dccg3_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
index 6e6af02b38f9..97e9be87afd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
@@ -46,6 +46,8 @@ static const struct dccg_funcs dccg301_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
+	.otg_add_pixel = dccg2_otg_add_pixel,
+	.otg_drop_pixel = dccg2_otg_drop_pixel,
 	.dccg_init = dccg2_init
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 693379c7e659..c66a6099a7d7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -45,6 +45,10 @@ struct dccg_funcs {
 			unsigned int *dccg_ref_freq_inKhz);
 	void (*set_fifo_errdet_ovr_en)(struct dccg *dccg,
 			bool en);
+	void (*otg_add_pixel)(struct dccg *dccg,
+			uint32_t otg_inst);
+	void (*otg_drop_pixel)(struct dccg *dccg,
+			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
