Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6F3C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2FE208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rg9qK1yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2FE208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B645D6EA64;
	Fri, 19 Jun 2020 20:13:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9206E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgS49AZxUUnjVCsJoVgtJtHsk1iqttqIptyz4y+CCE3/QhJrB8eHU+CNWW6Tn9jCiZiKg0SQ9eF1JGQDrsCrI6GrIw2DM51hGgxx2v/tLGMjzcXHTVigATjr5p46VH4VbvZH/4sNH73mDimQ13Fb3+OnUYdJm0AsaV16OiQEH4zBIHYEwgxxLuVlRw09qkAjS+zau2JBeB7UXSmGbH5fIt919Uw0Ualg6ykE8oAP82XA06WXyz8qucS9GIt3A88wqfmiAubLTqBnWSzpu1AGSCeFx0cFBwxrQN+0hOCyAjINNDFr/8Px6TxpMvUw4KIiQMdRnczse2zsiCiRGSoI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bs60mqCvARTNn9LzBeuJwtPhwwV+1yUOmpqLkhf4Mo=;
 b=DXs9XAPg18Mg2d0ltCgk7DnlZlID/rYGmRssg0mr1LIyqtp281IG4Odd473Ph3EZQqRTUkKzFu4GwQ1SEULjnnSnFOdKDMU/2jFvkkYuq+NPLw4zrn+aG0rX6tm6nUfiU0a46UeYWZlileiii94nkmBrNJw1ClmOGA4YzEcbAcQOJlN3mAL7kVsS84kI8LqAw9yWJao5uncLOlA9AqnikZG67lZtR4f5Qp4dvPpLOkpnoS3K5lp5SlIYFTO8gliiEgRoIdTkYhOo22Sx+uEKwmuOZmvXzTyeuqS6mgwXEiQWABEKvQqYDXwkLMf0isTAMvtBWUY5KDOE/2oyKeEzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bs60mqCvARTNn9LzBeuJwtPhwwV+1yUOmpqLkhf4Mo=;
 b=rg9qK1yfsksBbFvSRrBJrt+HEN3X+b+rDeQGz7ODCvwGsFU0DMSrEt2Gx6UZGqCTA4Gp1VyQVjO5ZIImM+OHdYvjneVIZLMt+nkOg0XHt2A4Y+T5/pwdlXFL7YnahAneRJtlJO/9CkQKXDwAw5dl+WkTFGhekpM8rQE2ZrDyiYg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:58 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/30] drm/amd/display: add mechanism to skip DCN init
Date: Fri, 19 Jun 2020 16:12:07 -0400
Message-Id: <20200619201222.2916504-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:57 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c44c726-c31b-405d-d1a2-08d8148d289a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408786E571C5EB34FD989C9198980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYRNZAM4PCXPIWHanbDUYfuUyvEOWdFaKkEEwT9VaL1VsPfDza/K/1V6gMZcEBpjFAbc0WoPjV8uuc73wfNvoObMDr5ludGdvYWXO1lQpQDqPXCd7Y7T6aYN07nvrY0XpOJo1MwunaG3+AadUpNNLETZxBILj+2u/irfN79AMVukP6F1nVonvo5c5nHZtvAqkFlIV/+5/X+Hko/xmJtV15uZiSn3dXILohRIPYg8JRhiVsUuUDsyvJ0uXkH2t9kayBfYYYJQhfxwjgoDGqn/fBMTuEqXrm5AsJ1wgoAGJSaQCRsbmu273/QlXlmamf69U6H9zNxdIPlIMELBDcV2xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: J2r/UCjDPhQS1xSv/poODieTdrQmO7QaDUQikJEBPqtdBYm4aPbCGTiPwYr9wL/XQO+FvPfaTPeSIVnQBk1vzUKu3JxcmMrRZsIWHx4ouVI8MJNgObyfDYukVntlAoOC7YrR2q92Er4EaNhlOvQrfgS2MUhppcjLC7YdTiVH0LVfygJ8gc7zwcx/VtTpgET8qrkDx2rieTAHromKIEtGR7cNkF3tEvxkWmAZKQEcVjaEu9+1piN6P/uFqLTY3Z54OfCD2oW44mIjGBxo3oizEZg93ze5ygBhGEhvdW8pjxtFCctnxSxppJ/4U+SXs6bBf57HhIfBHHIKx4JE6pZnjWthMLLES0sbIyyc7oOBte5V56iQX5JJTn3ecz4GGnuV0zemb4hFpA48pZx1L3oAqshLb6M95Pk2jHz0giN1/N6AKqxdYAolYf+XUNzb2ehQKbBpS9AtlHn/ZrWda4q5vXlwN28Uh90w4Lbe0YujzJargvNnL/m3ibsSPrFWBnzGjBIJYihwCKiaXF4FQ84u4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c44c726-c31b-405d-d1a2-08d8148d289a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:57.9359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxiboWXOsA6I2+XCDYqKcxTGqBOorsPpreTwVVIseEXZ3wO1vrB7tdfGhDdOV1olPBlwngmLOorwApHrFDs/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
If optimized init is done in FW. DCN init be skipped in driver. This
need to be communicated between driver and fw and maintain backwards
compatibility.

[How]
Use DMUB scratch 0 bit 2 to indicate optimized init done in fw and
use DMUB scatch 4 bit 0 to indicate drive supports the optimized flow
so FW will perform it.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 28 ++++---------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  5 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 15 +++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  4 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c | 10 -----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  6 ---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 40 +++++--------------
 10 files changed, 46 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index db5feb89d4af..67402d75e67e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2681,6 +2681,7 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 	dal_irq_service_ack(dc->res_pool->irqs, src);
 }
 
+
 void dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
@@ -2692,9 +2693,6 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
 
-		if (dc->ctx->dmub_srv)
-			dc_dmub_srv_wait_phy_init(dc->ctx->dmub_srv);
-
 		dc->hwss.init_hw(dc);
 
 		if (dc->hwss.init_sys_ctx != NULL &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index eea2429ac67d..96532f7ba480 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -106,29 +106,17 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
 }
 
-void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv)
+bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 {
-	struct dmub_srv *dmub = dc_dmub_srv->dmub;
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
-	enum dmub_status status;
+	struct dmub_srv *dmub;
+	union dmub_fw_boot_status status;
 
-	for (;;) {
-		/* Wait up to a second for PHY init. */
-		status = dmub_srv_wait_for_phy_init(dmub, 1000000);
-		if (status == DMUB_STATUS_OK)
-			/* Initialization OK */
-			break;
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
 
-		DC_ERROR("DMCUB PHY init failed: status=%d\n", status);
-		ASSERT(0);
+	dmub = dc_dmub_srv->dmub;
 
-		if (status != DMUB_STATUS_TIMEOUT)
-			/*
-			 * Server likely initialized or we don't have
-			 * DMCUB HW support - this won't end.
-			 */
-			break;
+	status = dmub->hw_funcs.get_fw_status(dmub);
 
-		/* Continue spinning so we don't hang the ASIC. */
-	}
+	return status.bits.optimized_init_done;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index a3a09ccb6d26..8bd20d0d7689 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,4 +56,6 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv);
 
+bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index abb160b5c395..cb45f05a0319 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1288,7 +1288,9 @@ void dcn10_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb))
 		hws->funcs.disable_vga(dc->hwseq);
 
-	hws->funcs.bios_golden_init(dc);
+	if (!dc_dmub_srv_optimized_init_done(dc->ctx->dmub_srv))
+		hws->funcs.bios_golden_init(dc);
+
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c6a8d6c54621..3cac170312fc 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -264,9 +264,10 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
-	bool (*is_phy_init)(struct dmub_srv *dmub);
+	void (*enable_dmub_boot_options)(struct dmub_srv *dmub);
+
+	union dmub_fw_boot_status (*get_fw_status)(struct dmub_srv *dmub);
 
-	bool (*is_auto_load_done)(struct dmub_srv *dmub);
 
 	void (*set_gpint)(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 2c4a2fe9311d..0cd78e745e7e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -312,3 +312,18 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_SCRATCH7);
 }
+
+union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	return status;
+}
+
+void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_options boot_options = {0};
+
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index a316f260f6ac..a27b509cd6fd 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -192,4 +192,8 @@ bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
 
 uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
 
+void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub);
+
+union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index e8f488232e34..a6047673c3f5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -51,14 +51,4 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
 #undef DMUB_SF
 };
 
-/* Shared functions. */
 
-bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub)
-{
-	return (REG_READ(DMCUB_SCRATCH0) == 3);
-}
-
-bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub)
-{
-	return REG_READ(DMCUB_SCRATCH10) == 0;
-}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
index 2bbea237137b..8c4033ae4007 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
@@ -32,10 +32,4 @@
 
 extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
 
-/* Hardware functions. */
-
-bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub);
-
-bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
-
 #endif /* _DMUB_DCN21_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index eb51b7920864..9c924994a2c3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -153,18 +153,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_gpint = dmub_dcn20_set_gpint;
 		funcs->is_gpint_acked = dmub_dcn20_is_gpint_acked;
 		funcs->get_gpint_response = dmub_dcn20_get_gpint_response;
+		funcs->get_fw_status = dmub_dcn20_get_fw_boot_status;
+		funcs->enable_dmub_boot_options = dmub_dcn20_enable_dmub_boot_options;
 
-		if (asic == DMUB_ASIC_DCN21) {
+		if (asic == DMUB_ASIC_DCN21)
 			dmub->regs = &dmub_srv_dcn21_regs;
 
-			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
-			funcs->is_phy_init = dmub_dcn21_is_phy_init;
-		}
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 		if (asic == DMUB_ASIC_DCN30) {
 			dmub->regs = &dmub_srv_dcn30_regs;
 
-			funcs->is_auto_load_done = dmub_dcn30_is_auto_load_done;
 			funcs->backdoor_load = dmub_dcn30_backdoor_load;
 			funcs->setup_windows = dmub_dcn30_setup_windows;
 		}
@@ -454,6 +452,10 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		dmub_rb_init(&dmub->inbox1_rb, &rb_params);
 	}
 
+	/* Report to DMUB what features are supported by current driver */
+	if (dmub->hw_funcs.enable_dmub_boot_options)
+		dmub->hw_funcs.enable_dmub_boot_options(dmub);
+
 	if (dmub->hw_funcs.reset_release)
 		dmub->hw_funcs.reset_release(dmub);
 
@@ -514,35 +516,13 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
-	if (!dmub->hw_funcs.is_auto_load_done)
-		return DMUB_STATUS_OK;
-
 	for (i = 0; i <= timeout_us; i += 100) {
-		if (dmub->hw_funcs.is_auto_load_done(dmub))
-			return DMUB_STATUS_OK;
+		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);
 
-		udelay(100);
-	}
-
-	return DMUB_STATUS_TIMEOUT;
-}
-
-enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
-					    uint32_t timeout_us)
-{
-	uint32_t i = 0;
-
-	if (!dmub->hw_init)
-		return DMUB_STATUS_INVALID;
-
-	if (!dmub->hw_funcs.is_phy_init)
-		return DMUB_STATUS_OK;
-
-	for (i = 0; i <= timeout_us; i += 10) {
-		if (dmub->hw_funcs.is_phy_init(dmub))
+		if (status.bits.dal_fw && status.bits.mailbox_rdy)
 			return DMUB_STATUS_OK;
 
-		udelay(10);
+		udelay(100);
 	}
 
 	return DMUB_STATUS_TIMEOUT;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
