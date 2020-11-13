Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E6C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B6D2224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LKqL7U09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B6D2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D3B6E840;
	Fri, 13 Nov 2020 20:58:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F626E842
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFS9+EaJRvwf5CDLLcAAp4vDMY+yheLNmzlWvoD9Qp4Ho6X6WcWRSECV3Jf2d7rB2Q7vw2+umDEBXp44a6zJK/qT/1hc6x3gJ4oD6e15nGlnQtWf/YtycPDWR8I/DA00bo3zimeceqJIufNqtRWLAb/1jh8G6Fw9idPNh1Cw5C8Smn3Ubh/UGuH2KckFwQNsmsjI7QXjHB5YTNNKY1otUIUXC3lYEmQU5Z3eFHrodAl9xdjyZKsTshpwjXDLj0eJNDYb2gJtzaOmJGF2GZPtaNoO13vQDiK1NPbzdHhJaio4YSAGm8TgozKo3/U27cmX83gNvNC/0uDjsbLg1mk5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoASKyw7HzSp82b2diC0Qv89ku955b5vgi11+NDQp1Y=;
 b=H6sTXIy0dqqtzsGXQnsmJHmaqS17d+p9ooyhMqiYSiVeraU9QBsaVNEIi0SOG9MJ4mIn5lGw4xgXZikf2ocYlglugYbEFFk9gisRVp7LvwglSefx2TRbHUQde2LYZNTTt9kLxm94aqkoB0R9ZCDdk921h2Mt3i+MYFH5pY2GA6UlJAi9w9m5Bvyk81+WzqMlZ9zv7eFF4f3258jQepwYoO2NhFiCQj2wFhR97zvn3LkXde2J+Pmg5DvPh6ke0iC0wtsXFfu6vZEwneTnHkmjWqdL1Hb0qEgmlDVpWJF1BJt/546g3NqlaV3Xqdz8vBuKuSa/FRlAasv9qxCvPAxh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoASKyw7HzSp82b2diC0Qv89ku955b5vgi11+NDQp1Y=;
 b=LKqL7U09QhTuE2zmpwxQpEq5HnukSUCIF9KmpjmpUvXv+ZPclFbxQC7MNesfUySeM1KxrP/hFwqy3V8rL8iG9eElemwuD2blnKdNBgKE3LPnB1+WN3rIBlropuH/ZqedCNnWHsBvh6c4/QMLYQdAXyci5nmowJqNSaLN42Nuj08=
Received: from DM5PR2201CA0007.namprd22.prod.outlook.com (2603:10b6:4:14::17)
 by MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Fri, 13 Nov
 2020 20:58:07 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::f0) by DM5PR2201CA0007.outlook.office365.com
 (2603:10b6:4:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:03 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:03 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:02 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/17] drm/amd/display: Add I2C memory low power support
Date: Fri, 13 Nov 2020 15:56:37 -0500
Message-ID: <20201113205645.640981-10-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805c487e-133b-41bf-62c3-08d88816d1a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32777733C60F2534D516126AF5E60@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtq/mAVBfu6WRPcJCpnPxDj4pueLnHSbFDDyf5vji1yCK/QXgS2f4hNYWKlXXObSq3UMMNkdvj9kyqje/OffIbx47v6gK3PpbgTJ3lpWVcgfBldHHYV0oMeVKzZeUjam8RMTYBGQV6WkFFfEhyjX5rM/aOPs4+VaB/R2JXmZox6z1CXcV/4h78JN6msoPohl7CvoP3cMZvJZ+b33FHM/7GEyN995zWTI/q7olQl4h4EuR62kbupR+PJ5pQOLb/9dmZKHeEyB0O4WzmimKFyziss7fx6Skb6VSodqgaVKzyefKSshtiliqu+eEGOOFIXrr1bOfVoXKYz18w1KhtkKb5KmmIiNnVct3E9Em9GdkL3k5uJpVXtoGPnrupH8M2KgzOo77dYU41z+zeLaptlMOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(26005)(5660300002)(6916009)(1076003)(2906002)(81166007)(316002)(8936002)(8676002)(86362001)(336012)(83380400001)(36756003)(82310400003)(186003)(82740400003)(6666004)(356005)(47076004)(54906003)(478600001)(2616005)(4326008)(70586007)(426003)(70206006)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:05.9684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c487e-133b-41bf-62c3-08d88816d1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The I2C memory blocks should be powered down when they are not in use.
This will reduce power consumption.

[How]
1. Write to I2C_LIGHT_SLEEP_FORCE to put memory in light sleep when
   released
2. Added a debug option to allow this behaviour to be turned off

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c  | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h  | 16 ++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c    |  6 +++---
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 52e819678ecd..e282c2211f42 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -419,6 +419,7 @@ struct dc_bw_validation_profile {
 
 union mem_low_power_enable_options {
 	struct {
+		bool i2c: 1;
 		bool mpc: 1;
 		bool optc: 1;
 	} bits;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 3e34afe8c504..7fbd92fbc63a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -293,6 +293,14 @@ static bool setup_engine(
 {
 	uint32_t i2c_setup_limit = I2C_SETUP_TIME_LIMIT_DCE;
 	uint32_t  reset_length = 0;
+
+        if (dce_i2c_hw->ctx->dc->debug.enable_mem_low_power.bits.i2c) {
+	     if (dce_i2c_hw->regs->DIO_MEM_PWR_CTRL) {
+		     REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 0);
+		     REG_WAIT(DIO_MEM_PWR_STATUS, I2C_MEM_PWR_STATE, 0, 0, 5);
+		     }
+	     }
+
 	/* we have checked I2c not used by DMCU, set SW use I2C REQ to 1 to indicate SW using it*/
 	REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C_SW_USE_I2C_REG_REQ, 1);
 
@@ -369,6 +377,10 @@ static void release_engine(
 	REG_UPDATE_2(DC_I2C_ARBITRATION, DC_I2C_SW_DONE_USING_I2C_REG, 1,
 		DC_I2C_SW_USE_I2C_REG_REQ, 0);
 
+	if (dce_i2c_hw->ctx->dc->debug.enable_mem_low_power.bits.i2c) {
+		if (dce_i2c_hw->regs->DIO_MEM_PWR_CTRL)
+			REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 1);
+	}
 }
 
 struct dce_i2c_hw *acquire_i2c_hw_engine(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
index fb055e6883c0..2309f2bb162c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
@@ -95,6 +95,11 @@ enum {
 	SR(DC_I2C_DATA),\
 	SR(MICROSECOND_TIME_BASE_DIV)
 
+#define I2C_HW_ENGINE_COMMON_REG_LIST_DCN30(id)\
+	I2C_HW_ENGINE_COMMON_REG_LIST(id),\
+	SR(DIO_MEM_PWR_CTRL),\
+	SR(DIO_MEM_PWR_STATUS)
+
 #define I2C_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
@@ -179,6 +184,8 @@ struct dce_i2c_shift {
 	uint8_t XTAL_REF_DIV;
 	uint8_t DC_I2C_DDC1_SEND_RESET_LENGTH;
 	uint8_t DC_I2C_REG_RW_CNTL_STATUS;
+	uint8_t I2C_LIGHT_SLEEP_FORCE;
+	uint8_t I2C_MEM_PWR_STATE;
 };
 
 struct dce_i2c_mask {
@@ -220,12 +227,19 @@ struct dce_i2c_mask {
 	uint32_t XTAL_REF_DIV;
 	uint32_t DC_I2C_DDC1_SEND_RESET_LENGTH;
 	uint32_t DC_I2C_REG_RW_CNTL_STATUS;
+	uint32_t I2C_LIGHT_SLEEP_FORCE;
+	uint32_t I2C_MEM_PWR_STATE;
 };
 
 #define I2C_COMMON_MASK_SH_LIST_DCN2(mask_sh)\
 	I2C_COMMON_MASK_SH_LIST_DCE110(mask_sh),\
 	I2C_SF(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_SEND_RESET_LENGTH, mask_sh)
 
+#define I2C_COMMON_MASK_SH_LIST_DCN30(mask_sh)\
+	I2C_COMMON_MASK_SH_LIST_DCN2(mask_sh),\
+	I2C_SF(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh),\
+	I2C_SF(DIO_MEM_PWR_STATUS, I2C_MEM_PWR_STATE, mask_sh)
+
 struct dce_i2c_registers {
 	uint32_t SETUP;
 	uint32_t SPEED;
@@ -239,6 +253,8 @@ struct dce_i2c_registers {
 	uint32_t DC_I2C_TRANSACTION3;
 	uint32_t DC_I2C_DATA;
 	uint32_t MICROSECOND_TIME_BASE_DIV;
+	uint32_t DIO_MEM_PWR_CTRL;
+	uint32_t DIO_MEM_PWR_STATUS;
 };
 
 enum dce_i2c_transaction_address_space {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index b379057e669c..eb067034ad45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -933,7 +933,7 @@ static struct dce_aux *dcn30_aux_engine_create(
 	return &aux_engine->base;
 }
 
-#define i2c_inst_regs(id) { I2C_HW_ENGINE_COMMON_REG_LIST(id) }
+#define i2c_inst_regs(id) { I2C_HW_ENGINE_COMMON_REG_LIST_DCN30(id) }
 
 static const struct dce_i2c_registers i2c_hw_regs[] = {
 		i2c_inst_regs(1),
@@ -945,11 +945,11 @@ static const struct dce_i2c_registers i2c_hw_regs[] = {
 };
 
 static const struct dce_i2c_shift i2c_shifts = {
-		I2C_COMMON_MASK_SH_LIST_DCN2(__SHIFT)
+		I2C_COMMON_MASK_SH_LIST_DCN30(__SHIFT)
 };
 
 static const struct dce_i2c_mask i2c_masks = {
-		I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)
+		I2C_COMMON_MASK_SH_LIST_DCN30(_MASK)
 };
 
 static struct dce_i2c_hw *dcn30_i2c_hw_create(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
