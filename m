Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB27BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691BD604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 691BD604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE4D6EE78;
	Fri, 17 Sep 2021 19:25:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153796EE78
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7hkI+Y3tOWFl4LG8tPTzB6qKYXAQW/BMY/4E7i5gkEd6xBBIIqBop7OA/Wl6m0UjDpp3vqcj3jLMSinF6gqUBSUGZFa1HVV5Kt00W/00zo7yF34jSzvFhoo3mMq3TJrw6BTMCglZBAI5fr0AZ++qtMBzuv9VawpCi5eiis5JyX3nKR7cvH5MH9gWAOBtDy0eCSr0FG+agNEOTIzkxquznIMv/FUO2Yu2/7YOL+KHxP6DbMg1uagQtMBSnolwSc0iUD24mlLQcqERofBcbsLWGKyT77+7zPOiNgFRbQC7Se2wWovPN84Pbxa0e1EzEaFbPyrgpeNzkAB8FeKvoLxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6ciS+Zwnm1phzzU11dJ4EknTVU9U3XbvIdhW1Ia6PV0=;
 b=jYDI/nOC3ThH9xVGBrpPUfCZcpt7e/auGfebLSb/XVxLA7AJuMaLA5hZmhhlo+C3MJNgcop4WEPY7FhbKIpDZ5TbUi77zrf8927yD8/L40xl7F+SXfaAD6Q6agKlJaasd34+4hmXhV+m3Zx6PRYseLZghSxkHpbMr6R+pELlUDRcjSxjMIgnsAwhF96tOAvna6VXU0pFYtZQcuj8NhMy1kmts9NhNvkYYdAL4Zg54yV+mno/H+3YCDT97M2wfq3ThieHqo3+9+Pn6fYVZiUokBXEJs49kW3EPHrw9Croaqr651qjI9yVHo31joKU3QEcgsyhtRajCCjqco0LODuuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ciS+Zwnm1phzzU11dJ4EknTVU9U3XbvIdhW1Ia6PV0=;
 b=1LYD+5JstXRCD74ImzFQyP5nCuEi6LdWKB25MDtbpKFmGV5GG9Ozd+Q5gN9fvI+680/NFjW0tzdLjakAlRG9Dd5W3SwSkYHcYGoMYng7QR5v6E+jGknpzb5WhPvhsKBWrJJqjYj7N7dqS7UQptkxAdKSVuYZLVjuLPRxzi8OARM=
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:47 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::df) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:46 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>
Subject: [PATCH 01/18] drm/amd/display: Extend w/a for hard hang on HPD to
 dcn20
Date: Fri, 17 Sep 2021 15:25:07 -0400
Message-ID: <20210917192524.3020276-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad0d343-bd16-41eb-8290-08d97a10f33e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:
X-Microsoft-Antispam-PRVS: <BY5PR12MB414559828DCCF6ADD48E0B9798DD9@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZuWR4vLNvMX8Rz5psBIxVgZSPDpg1Fey83Myfw7nXgZJgq762XQSrUCYPU5UPjXqWtx0yS0+WMP/LPschK2Y17KyS9ZeuY42vxccUbVT9PweOr1ooWZKzcw95umgxHRted5flHQqGVLjIq1PmGx9QNWb3Z9TZApNqwfJ8nedLCSg9GN7fir8nPKo2C1D6WFo6yqrzzb0fRxBGxvp7u48AgpIohvn7MOd2GJ+6z7tw/IViphBLGQrnCi1dUzZ9aiTEHXYwytO6pkfMIYCFjTeaNqd09RxaBOXl/FyOCBckfvlBO/TIZu+IFkNhy0O4zLKbKRm/3ew3ukWkz1DehFqkHDgkKG4xog5Sf0MH2ANCd1D5vv1Mm9JyMTWG2XFP+rqYh6WOccFXS7RjlC5TS8MMyxotnQElscInCmJsGV6/cdOKk+UCD/wU4i504Zsq601oJ8hsF1b88Ai9hVg3vDj3T2um5I+fUa2C0/8RulDZmyJxYCV55v9jbW+mzbhl2ocxLKECzSlx5Fu9jM/cZ3ZKUjIGXFEIb3+AjV+B5wZ4lfGuUpz5mnJSUpxBG+Y9xKFkYsgDnqOp9n9vvh2xJen9XI/tWZJY76W8uZJQ2h5GjSQvUBFGeoiOliECph1OVBrXl1nMbs8Ctb8B1po6QzhjF8QmGc42o3NPq5K3h2rf7WQa0KOm0F+RJS45zb1KhZ4sUuxx6a8pVpAeLvFyHRaceFdBUVAKrf2tKCrlpCkvs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(2906002)(54906003)(8936002)(356005)(36756003)(6666004)(5660300002)(83380400001)(6916009)(2616005)(86362001)(8676002)(81166007)(508600001)(70206006)(47076005)(70586007)(336012)(316002)(4326008)(426003)(186003)(26005)(16526019)(36860700001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:46.8232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad0d343-bd16-41eb-8290-08d97a10f33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
HPD disable and enable sequences are not mutually exclusive on Linux.
For HPDs that spans under 1s (i.e. HPD low = 1s), part of the disable
sequence (specifically, a request to SMU to lower refclk) could come
right before the call to PHY enablement, causing DMUB to access an
irresponsive PHY and thus a hard hang on the system.

[How]
Disable 48mhz refclk off when there is any HPD status in connected state
for dcn20.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 12 ++++++++-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  | 25 +++++++++++++++++++
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 0d01aa9f15a6..315466f5aade 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -38,6 +38,8 @@
 #include "clk/clk_11_0_0_offset.h"
 #include "clk/clk_11_0_0_sh_mask.h"
 
+#include "irq/dcn20/irq_service_dcn20.h"
+
 #undef FN
 #define FN(reg_name, field_name) \
 	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
@@ -221,6 +223,8 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool force_reset = false;
 	bool p_state_change_support;
 	int total_plane_count;
+	int irq_src;
+	uint32_t hpd_state;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -238,7 +242,13 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->res_pool->pp_smu)
 		pp_smu = &dc->res_pool->pp_smu->nv_funcs;
 
-	if (display_count == 0)
+	for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD6; irq_src++) {
+		hpd_state = dal_get_hpd_state_dcn20(dc->res_pool->irqs, irq_src);
+		if (hpd_state)
+			break;
+	}
+
+	if (display_count == 0 && !hpd_state)
 		enter_display_off = true;
 
 	if (enter_display_off == safe_to_lower) {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index c4b067d01895..49d87fe5c167 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -132,6 +132,31 @@ enum dc_irq_source to_dal_irq_source_dcn20(
 	}
 }
 
+uint32_t dal_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source)
+{
+	const struct irq_source_info *info;
+	uint32_t addr;
+	uint32_t value;
+	uint32_t current_status;
+
+	info = find_irq_source_info(irq_service, source);
+	if (!info)
+		return 0;
+
+	addr = info->status_reg;
+	if (!addr)
+		return 0;
+
+	value = dm_read_reg(irq_service->ctx, addr);
+	current_status =
+		get_reg_field_value(
+			value,
+			HPD0_DC_HPD_INT_STATUS,
+			DC_HPD_SENSE);
+
+	return current_status;
+}
+
 static bool hpd_ack(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
index aee4b37999f1..f60a203e7188 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
@@ -31,4 +31,6 @@
 struct irq_service *dal_irq_service_dcn20_create(
 	struct irq_service_init_data *init_data);
 
+uint32_t dal_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source);
+
 #endif
-- 
2.25.1

