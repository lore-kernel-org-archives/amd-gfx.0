Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17636C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 16:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8EE10EA6D;
	Fri,  7 Jan 2022 16:50:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8520010E93E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 16:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlDximMJ3bSjnTkOdO0QUcI0kWOrzKgNKOaKIVI8hY+LnPmDtM5Ita3tREQfrn18dJNB/Rclxrc9xu/tMsz9d+0z7qgcp959z7m5x/jsZSmNffpPyO/FmrdU9I2b5TN38Q4NPS5vpFSVC1JjIcYpQdkTgRVr8ipPMk+1N8UBJG8Ojbemd/orQ2W3TnRRlcGezvsndi2KnpRLd60VBiOhgW3RaMvDrgEJtV5gHwbpJh6ipe+T9lMfBThCJWg+oEY3zHQKm2G2J1FWJsXHtpMv60OvQiD0gsP92kNHUjNg0zDanSsX7otpmK/pRSwLi4JoX/Pnfb5OMgVJs+BmMN85dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+gxE0Ta1SB4haiyPFzdqqyjqEMnyYJxBTcCt5Ch+sg=;
 b=H7YontZniizq2dvdePMGFcc3BkCJnJnME1mc6ndgYISvhFM5YY7f3pB+IHrL12DWtA/K7ZoPAZscoVAFZt639Jd7km1PcBMdZ0lEqbSs+xeGa0qqmBbSSx3/WEEXjQhbVPHcenhJacIOyRsWdT053NIMzLJMDOENKdLLjRP9D+IGgIjgNSTnC3l2SKW9uyB/IoE9MPtlaOjK2UEFLbwUJxzgT3NiPaee0d119ry01FtfePU+YJ+P7pPQX1/UpUqpQYIbTg3cxbSFpvt1oyk+7rqA/2SR+hoioDD5bc2Yztua7fJoJta/HMg2NtZhkf9340EUpNNcYmbnU69bAAkMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+gxE0Ta1SB4haiyPFzdqqyjqEMnyYJxBTcCt5Ch+sg=;
 b=nFHTWB6eW2vnRVfsyM7EamcQo0kIBBqlfK/mgKNYYyVqYlC9gLWejaZOcH0+ZQ6pa9dMRaCOr7OkaLccXiVO7GUCO3gd0L+wf+HMRfD79IwYflPXboUxo17obF541/SXq9poY6a5AMDdbzDrT9mXCSOrulKljps7HPHyTPnbTaY=
Received: from BN6PR14CA0027.namprd14.prod.outlook.com (2603:10b6:404:13f::13)
 by DM6PR12MB5552.namprd12.prod.outlook.com (2603:10b6:5:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 16:50:00 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::29) by BN6PR14CA0027.outlook.office365.com
 (2603:10b6:404:13f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 16:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 16:49:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 10:49:59 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on DCN20/DCN21
Date: Fri, 7 Jan 2022 10:49:59 -0600
Message-ID: <20220107164959.12511-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90a42e88-2b9f-4237-34a9-08d9d1fdbe3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB5552:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5552A246D6C9CEC4ACD5E9A6E24D9@DM6PR12MB5552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0ouveEyZGY+/VbL+4D56LyN3GDGrh0LEd3LqPwZx7fobzbzRdiBgHE1Q9vMjzntsRfEjNW2f1CjFECCpRKDmTEn5UqBKE8Ac8mAqTEolcyK9eJc2hox7E0CrsluDZaxdR+hNJlfWual4OHDPDJ8uZ9ye8zNoXvDkN5kti1tbbBHR3ymZh4ZmKTOjm5mUe2enNCN4WEkioyWEQaqu2FKw9rCfcdp4/6Pclv/PP41bQysv1npNamj3IUd+zNup5w/OGcQmFjUYAkzRhT441/O+evy2cPWejMb+6u1N3ing2kKcyuV2v8l/qElA10TBd/N23tWwE7dHMuwNy/wPdTdTftqs3IChfkaCLl05kyef1LaB20m7kwD6kikmYjoAEFVULCTVpJ5D0V2KrHkIlVGEofIBW5eWRzup1FxBnXe9zJNaTilxDvnGrp4PRmiCQFUrRCEUZkYSKgj/BuuoZLqugsgbCgLuVhjSVKA/e8vbcCUgwtwpm61frIgAZphSTHq7YYAQBVurQwK/VI8CqU0h49X2fr2I6mikhZY7HIGX2z6bxkgzIqqwKn3iSc2hVlu59G9cFmw7jGuUkNe1uuo+AS0lKHn0x339JvMEhWkUojkcxSdczAT6X9xIOwROMQ9bVswG/Xs72TJsB8Tw80EO6cgcA+g/JgKnwR/xcfBPG6JdZB6Yb0wD7+vDU1OMXDy/k9Kd9pTz8M0V5RdN73JA+xf9uqe8xda0VX9oLap9Ex5ijvTBOsaxYXNCnTbbguFun2tVvssD2H1XnHuL7wgWjjd5yPjsT7583nSN8MIjGmFcH0SY2OaICFxaOjoL91gyZbocmRGKj9YVkyp0g2Mph45uPT5uK/GX0dXybVE3u5d8/YIT8RHU8XgsRsU4x64
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(6916009)(1076003)(81166007)(83380400001)(82310400004)(356005)(4326008)(5660300002)(7696005)(8676002)(8936002)(508600001)(186003)(966005)(26005)(54906003)(86362001)(2906002)(70206006)(70586007)(316002)(36756003)(336012)(426003)(2616005)(16526019)(44832011)(40460700001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 16:49:59.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a42e88-2b9f-4237-34a9-08d9d1fdbe3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5552
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
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott
 Bruce <smbruce@gmail.com>, spasswolf@web.de,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WA from commit 2a50edbf10c8 ("drm/amd/display: Apply w/a for hard hang
on HPD") and commit 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard
hang on HPD to dcn20") causes a regression in s0ix where the system will
fail to resume properly on many laptops.  Pull the workarounds out to
avoid that s0ix regression in the common case.  This HPD hang happens with
an external device and a new W/A will need to be developed for this in the
future.

Cc: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reported-by: Scott Bruce <smbruce@gmail.com>
Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
Reported-by: spasswolf@web.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215436
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1852
Fixes: 2a50edbf10c8 ("drm/amd/display: Apply w/a for hard hang on HPD")
Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to dcn20")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 11 +-------
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 11 +-------
 .../display/dc/irq/dcn20/irq_service_dcn20.c  | 25 -------------------
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |  2 --
 .../display/dc/irq/dcn21/irq_service_dcn21.c  | 25 -------------------
 .../display/dc/irq/dcn21/irq_service_dcn21.h  |  2 --
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |  2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |  4 ---
 8 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 9f35f2e8f971..cac80ba69072 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -38,7 +38,6 @@
 #include "clk/clk_11_0_0_offset.h"
 #include "clk/clk_11_0_0_sh_mask.h"
 
-#include "irq/dcn20/irq_service_dcn20.h"
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -223,8 +222,6 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool force_reset = false;
 	bool p_state_change_support;
 	int total_plane_count;
-	int irq_src;
-	uint32_t hpd_state;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -242,13 +239,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->res_pool->pp_smu)
 		pp_smu = &dc->res_pool->pp_smu->nv_funcs;
 
-	for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD6; irq_src++) {
-		hpd_state = dc_get_hpd_state_dcn20(dc->res_pool->irqs, irq_src);
-		if (hpd_state)
-			break;
-	}
-
-	if (display_count == 0 && !hpd_state)
+	if (display_count == 0)
 		enter_display_off = true;
 
 	if (enter_display_off == safe_to_lower) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index fbda42313bfe..f4dee0e48a67 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -42,7 +42,6 @@
 #include "clk/clk_10_0_2_sh_mask.h"
 #include "renoir_ip_offset.h"
 
-#include "irq/dcn21/irq_service_dcn21.h"
 
 /* Constants */
 
@@ -129,11 +128,9 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int display_count;
-	int irq_src;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
-	uint32_t hpd_state;
 
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 
@@ -150,14 +147,8 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			display_count = rn_get_active_display_cnt_wa(dc, context);
 
-			for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD5; irq_src++) {
-				hpd_state = dc_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
-				if (hpd_state)
-					break;
-			}
-
 			/* if we can go lower, go lower */
-			if (display_count == 0 && !hpd_state) {
+			if (display_count == 0) {
 				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 9ccafe007b23..c4b067d01895 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -132,31 +132,6 @@ enum dc_irq_source to_dal_irq_source_dcn20(
 	}
 }
 
-uint32_t dc_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source)
-{
-	const struct irq_source_info *info;
-	uint32_t addr;
-	uint32_t value;
-	uint32_t current_status;
-
-	info = find_irq_source_info(irq_service, source);
-	if (!info)
-		return 0;
-
-	addr = info->status_reg;
-	if (!addr)
-		return 0;
-
-	value = dm_read_reg(irq_service->ctx, addr);
-	current_status =
-		get_reg_field_value(
-			value,
-			HPD0_DC_HPD_INT_STATUS,
-			DC_HPD_SENSE);
-
-	return current_status;
-}
-
 static bool hpd_ack(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
index 4d69ab24ca25..aee4b37999f1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
@@ -31,6 +31,4 @@
 struct irq_service *dal_irq_service_dcn20_create(
 	struct irq_service_init_data *init_data);
 
-uint32_t dc_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source);
-
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 235294534c43..0f15bcada4e9 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -134,31 +134,6 @@ static enum dc_irq_source to_dal_irq_source_dcn21(struct irq_service *irq_servic
 	return DC_IRQ_SOURCE_INVALID;
 }
 
-uint32_t dc_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source)
-{
-	const struct irq_source_info *info;
-	uint32_t addr;
-	uint32_t value;
-	uint32_t current_status;
-
-	info = find_irq_source_info(irq_service, source);
-	if (!info)
-		return 0;
-
-	addr = info->status_reg;
-	if (!addr)
-		return 0;
-
-	value = dm_read_reg(irq_service->ctx, addr);
-	current_status =
-		get_reg_field_value(
-			value,
-			HPD0_DC_HPD_INT_STATUS,
-			DC_HPD_SENSE);
-
-	return current_status;
-}
-
 static bool hpd_ack(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
index 616470e32380..da2bd0e93d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
@@ -31,6 +31,4 @@
 struct irq_service *dal_irq_service_dcn21_create(
 	struct irq_service_init_data *init_data);
 
-uint32_t dc_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source);
-
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index 4db1133e4466..a2a4fbeb83f8 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -79,7 +79,7 @@ void dal_irq_service_destroy(struct irq_service **irq_service)
 	*irq_service = NULL;
 }
 
-const struct irq_source_info *find_irq_source_info(
+static const struct irq_source_info *find_irq_source_info(
 	struct irq_service *irq_service,
 	enum dc_irq_source source)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
index e60b82480093..dbfcb096eedd 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
@@ -69,10 +69,6 @@ struct irq_service {
 	const struct irq_service_funcs *funcs;
 };
 
-const struct irq_source_info *find_irq_source_info(
-	struct irq_service *irq_service,
-	enum dc_irq_source source);
-
 void dal_irq_service_construct(
 	struct irq_service *irq_service,
 	struct irq_service_init_data *init_data);
-- 
2.25.1

