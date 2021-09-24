Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E759C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D03061250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D03061250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722816E221;
	Fri, 24 Sep 2021 19:10:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903276E21D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buf6t9L/dkTDTKoKknMq4yE2F4yGKAXRq4+LhLpbVxdrRNHSmd5C2HxLChdkO2yIjTrlkGcBubxAOxidZ0pwq+y7wBB5N4oq9eaDy6FYUWVCKrAaHiqVexA/0cXmA44v4tBTmlVzDTu7Kmp+7L0R4uSrDKprj1K64Bu6aHniLVmDuoVR384Kf2ZKAo5veRkY5Dxykp7s8zAaDVA97G62DKQfZLhZ20fJaqkhlnfLt6YVwYEzwO0bS4Nt85QOVCezTa5SnOqx955017c7WH8YXTyHRQwCGX4cvR8JjElxwO8Bl+QMfF9uLDq3Z6UqFkWDQLTQY2ysCxZkCJN4BMjHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WPQPRvIrDJgCIctud+1xjnjfBu8l8h6b7f1WPGmh+S8=;
 b=iC7mXRW+B1DBebOKZUHY116BByir0Ja+d3/kvHGq2dT1dAB6d/E+R9eD0lMac9e4yhYtrrpkmhS0NR28QborhCbugk4viQbCdijoVmn02d0Ip4Mt6xIzw9/LeCB1ATL3yhPa0eWmRRJog6UtJjaLhdUOxSciu6cRlsdMp3nGRrp7UoGQWq9494PWnQY78T29XSoBhd68L5HMZuuGi77c+Rc/3CLSl9yXhV1YitoK6eEZdHtRT5IG1vbHFQZbIcMam7xl2VGoCiB8L3F39s9bobXdG/51G4yr9uec1bnGm323nmtdzyqmYRBew04aydx2B2BMvMz3Y94Hmwbtc9LeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPQPRvIrDJgCIctud+1xjnjfBu8l8h6b7f1WPGmh+S8=;
 b=VBjOBQX3Ki+GPb5IGRqqbBxWytNbYkNTlzMIVL/yookA/U/p8/13jggHT6yoaj+ECPuQxyEWkQhLdHjTvbN/lO5rM9Q2eZ0ls/VTyThZSBem1LBkhdqcAVybAikGMgAgBZionTRH705yJZ3csv0BfVMrAY72yBhAIVYC4eVCysw=
Received: from DM5PR1401CA0022.namprd14.prod.outlook.com (2603:10b6:4:4a::32)
 by CY4PR12MB1127.namprd12.prod.outlook.com (2603:10b6:903:44::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 19:10:29 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::c) by DM5PR1401CA0022.outlook.office365.com
 (2603:10b6:4:4a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:27 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:21 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Qingqing Zhuo
 <Qingqing.Zhuo@amd.com>
Subject: [PATCH 18/24] drm/amd/display: Replace referral of dal with dc
Date: Fri, 24 Sep 2021 15:09:28 -0400
Message-ID: <20210924190934.1193379-19-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f53034-203a-4e62-39d8-08d97f8ef8e1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1127:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1127FD40531C34964FEF31DDEBA49@CY4PR12MB1127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAMUOFyTwWoElKh1exZdmcFiCdcjBhmwfJ1prXQhZpFSK1oBIhRQzQq7xnTOM1k8uBS0KFsEiGedzhzxH+uyrrym5Tlwu7GiM+BbP5/As/yhIfiW9QsrBTvfZTWo0ssyjssMR4iyK4qeBABv/PeXHWbz2OZtCWUJsOJG5o3htczKd3tURkjjlu/fsY5rjeM5+0ZCn3FA/+PmXe60vFEkoHiRzxfAZ//5DaZh/eEDg0SgcoRX7d6qU1EID2NOL6Es9trXUYTwEhVxFIlIC5OczzSu5/pIYucOdELX6IUhhRkltpuJP18MdRgEBZm3gv0oRVkoa6wkC0/NNALeoFNDUDQzVQ75K1jTt3k+dzP+2jSuT4er/LHd5Fd7i/d3cl+lHcyXe3jqGOJJEgQglt2It+e6GE6kDjXnhXYHlRMkDUXhj6M27qRfT3XvP9Ng/MG7wcs1+s9PrDDv37PjAPOXB83AI0BTBsLTzlXHtpe/rj8O0e7v0Xcbku7myz/tUhKfFkvef3yeopHVg9nCUciokgEkL0Vlkd0j1dsGFUnJU/lUuTKzZKbX+Mn0af8lZOFaMZC/F0pcUqMbbpFelOQgwKIec3L2wtz53th3/8BL87nujvmEqVpQsyMKHj7ESNpROfyqFaPE/BAwbcUIPn2kJ52HoQAiLhsmDYB7LbzlBY3alzO6SL82sPZKhVwpROk5oPEsdutr5BHVrTdMFH4B3MqdloHdzWfORJiBEnbPV38=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(36756003)(6916009)(356005)(508600001)(26005)(47076005)(8936002)(70586007)(83380400001)(54906003)(1076003)(7696005)(8676002)(2616005)(426003)(336012)(70206006)(2906002)(316002)(4326008)(186003)(86362001)(82310400003)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:28.6359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f53034-203a-4e62-39d8-08d97f8ef8e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1127
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

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why]
DC should be used in place of DAL in
upstream.

[How]
Replace dal with dc in function names.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c | 2 +-
 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h | 2 +-
 drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c | 2 +-
 drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 315466f5aade..2108bff49d4e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -243,7 +243,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 		pp_smu = &dc->res_pool->pp_smu->nv_funcs;
 
 	for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD6; irq_src++) {
-		hpd_state = dal_get_hpd_state_dcn20(dc->res_pool->irqs, irq_src);
+		hpd_state = dc_get_hpd_state_dcn20(dc->res_pool->irqs, irq_src);
 		if (hpd_state)
 			break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 3fabf32a0558..ac2d4c4f04e4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -152,7 +152,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			display_count = rn_get_active_display_cnt_wa(dc, context);
 
 			for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD5; irq_src++) {
-				hpd_state = dal_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
+				hpd_state = dc_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
 				if (hpd_state)
 					break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 49d87fe5c167..9ccafe007b23 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -132,7 +132,7 @@ enum dc_irq_source to_dal_irq_source_dcn20(
 	}
 }
 
-uint32_t dal_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source)
+uint32_t dc_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source)
 {
 	const struct irq_source_info *info;
 	uint32_t addr;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
index f60a203e7188..4d69ab24ca25 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
@@ -31,6 +31,6 @@
 struct irq_service *dal_irq_service_dcn20_create(
 	struct irq_service_init_data *init_data);
 
-uint32_t dal_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source);
+uint32_t dc_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 685528734575..78940cb20e10 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -135,7 +135,7 @@ enum dc_irq_source to_dal_irq_source_dcn21(
 	return DC_IRQ_SOURCE_INVALID;
 }
 
-uint32_t dal_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source)
+uint32_t dc_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source)
 {
 	const struct irq_source_info *info;
 	uint32_t addr;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
index 3df2ceeb2b70..616470e32380 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
@@ -31,6 +31,6 @@
 struct irq_service *dal_irq_service_dcn21_create(
 	struct irq_service_init_data *init_data);
 
-uint32_t dal_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source);
+uint32_t dc_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source);
 
 #endif
-- 
2.25.1

