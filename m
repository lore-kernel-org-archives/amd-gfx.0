Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA1FC11F6C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831EB61D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831EB61D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8665289F3C;
	Tue, 29 Jun 2021 15:54:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE8989F33
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT1FDXf64nroH5yKLmpM93ewxccOabvOqrXIW7K2bqu6ee0Hdax+HvXa1J9uIjo0DU0Jt7SZ9Fbi57DuXv/HG2bpss2PsHa+90xS4sFdBnS+1ccYLL945tf/u40qHz0xyGY3z4d+zCsD/hXxN0sBS4d1fq4YjLNC8LphrcMAarCjkR7XeeaPP28w06SiTAQ5X7YiNXLMAti1/J1xjTQ4weY0NLI7/uFlXB30680GIbTayxQj8QeqDqa+4ONN5XPWxlSvMhDDKY3whUixuSbUbQo7AQue4K5rMl3QyW0xHuDZlC7MPg8bM9RoCohr60aV+x+kS/QeCWGJMbczbbAI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlUp1l3yattIhSnPuSbHYul6b3l64r6SMVoC4VVvs64=;
 b=Hqxxcj2RsDcJVWDZQoXeCwWftat4awBeFmjQjdLiv4YbTulY6kJIx/9ZXJZ6oBTUOLvXQCIZnmgk6kpQPkRLjb+x/eXoIWo8tjQqiceTQQ7BxkSuTh5CZIvrIHT2REUSy8DfdWCfEKDoGVBpQv92kToq98nZx+iDuCFNt7wWxeKL+tbtpHRi1IIwcPc3p+6mFbltGfq+aaGW/nuAHXxbGdp74oO54JMVIw2P3qUXdmRewTus6pNwv3OXAAb9taXsZcQRHQlkhFmYgyWbKrKasawhBwz09almKyD6+XHKo5cfI/W08NH6HlQwf9JstLjEW9j9Yz1X1pXnkUJZVOBbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlUp1l3yattIhSnPuSbHYul6b3l64r6SMVoC4VVvs64=;
 b=WUeCZ25OqvmxhPtsb6ZHmsPw0A3+bnvuW1OP8zclp4onLjEIQLIO59xidkscbXARZabSnDcC6jG8A0Tn8Ltl6GrDtV5EcWCTRO9VxzFOd8BL18wl71RBj1+TWxDEUaqiB96BOTQ4mYuS7iy2/XDmH+dehzv0FbOr18Ymx9L+YRY=
Received: from DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) by
 CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Tue, 29 Jun 2021 15:54:53 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::89) by DM5PR15CA0034.outlook.office365.com
 (2603:10b6:4:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:53 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: DMUB Outbound Interrupt Process-X86
Date: Tue, 29 Jun 2021 11:54:12 -0400
Message-ID: <20210629155422.26118-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62eb3b1f-1d41-4c2b-0a85-08d93b163c3d
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5513357B72C6DC29D9EDC5E898029@CH2PR12MB5513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzgH16MnZFrd48S1wGXJ6+oRrRHdX7fN6WIfTsyvGBQqqK+a12JGsLhuBa3GiJh34gJwlv03QGeO56kaROtDeU+0cm825gclOTgZbXJ48eMFowpIzaVz+QhGEj3K80MMw82kde4tYzh9rzwdeqy9fS/qItSpdF0EfbpM3x3zwrlUktzW5TzS0YDMqIvCi9EqP9R8gFzEtSdsW9m77TxPYGRqsmFPJRooYjIjDcG2Gg9jUJxxN/P9Idi5dTB2T4oJWsJgVTZxQlMkvG/8WWDozqGHz5x+ZgOuinOqx16njodG8+RLmqLfjzlisZATBQY2+98ovyWP0xUiIIRgivR70wTM8mclwgZKYQZB5bL2i48l+6jni/7mWcnieNwQju/yFVUwoqz8v6+Z3oG+BCjwnh3LFBoXP+1sy8xsMf4ezrMs086U908friesHW8G//EWrrRvbeRyHLOVJxhRKGDDw7lSWRuzQ69uEGcbAEW53m+r7Ioi426Bn0floBWwtnHsR27Qrg08wqm0B1PyFUzoOE+01gTNDRCtX9vk92/EXislxrvVcAX5IwCAxPf85m4Pa6PggPOzWt/Zy3nZ02qqtRG87q2D+0ffYAOdNF6rzuqwNWMHJ+gPuHYKRuBlttmMtzkhuBQO7uGA86FLd+bUjIVzJHO+X71fL4oEVgig36f92BMlNkkAqIeSXkJJ8tp5//d5AQFWfhRfAQ6zDJbmWP7dPPuSIQ1uFDLYQHZHotY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(426003)(4326008)(26005)(70206006)(8676002)(70586007)(336012)(36756003)(5660300002)(82310400003)(82740400003)(8936002)(186003)(16526019)(36860700001)(6916009)(47076005)(6666004)(478600001)(316002)(54906003)(2906002)(1076003)(2616005)(30864003)(86362001)(81166007)(356005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:53.4419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62eb3b1f-1d41-4c2b-0a85-08d93b163c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Chun-Liang Chang <Chun-Liang.Chang@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chun-Liang Chang <Chun-Liang.Chang@amd.com>

[Why]
dmub would notify x86 response time violation by GPINT_DATAOUT

[How]
1. Use GPINT_DATAOUT to trigger x86 interrupt
2. Register GPINT_DATAOUT interrupt handler.
3. Trigger ACR while GPINT_DATAOUT occurred.

Signed-off-by: Chun-Liang Chang <Chun-Liang.Chang@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c | 24 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stat.h      |  1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 18 ++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 15 ++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h | 13 ++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 17 +++++++++++++
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  4 ++++
 8 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 31761f3595a6..28ef9760fa34 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -62,3 +62,27 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 	status = dmub_srv_stat_get_notification(dmub, notify);
 	ASSERT(status == DMUB_STATUS_OK);
 }
+
+/**
+ *****************************************************************************
+ *  Function: dc_stat_get_dmub_dataout
+ *
+ *  @brief
+ *		Calls dmub layer to retrieve dmub gpint dataout
+ *
+ *  @param
+ *		[in] dc: dc structure
+ *		[in] dataout: dmub gpint dataout
+ *
+ *  @return
+ *     None
+ *****************************************************************************
+ */
+void dc_stat_get_dmub_dataout(const struct dc *dc, uint32_t *dataout)
+{
+	struct dmub_srv *dmub = dc->ctx->dmub_srv->dmub;
+	enum dmub_status status;
+
+	status = dmub_srv_get_gpint_dataout(dmub, dataout);
+	ASSERT(status == DMUB_STATUS_OK);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stat.h b/drivers/gpu/drm/amd/display/dc/dc_stat.h
index 2a000ba54ddb..aacbfd786c6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stat.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stat.h
@@ -38,5 +38,6 @@
 #include "dmub/dmub_srv.h"
 
 void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification *notify);
+void dc_stat_get_dmub_dataout(const struct dc *dc, uint32_t *dataout);
 
 #endif /* _DC_STAT_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 5f9346622301..b3edd7e618a6 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -152,7 +152,7 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DC6_VLINE1,
 	DC_IRQ_SOURCE_DMCUB_OUTBOX,
 	DC_IRQ_SOURCE_DMCUB_OUTBOX0,
-
+	DC_IRQ_SOURCE_DMCUB_GENERAL_DATAOUT,
 	DAL_IRQ_SOURCES_NUMBER
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index abbf7ae584c9..caf961bb633f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -352,6 +352,8 @@ struct dmub_srv_hw_funcs {
 
 	uint32_t (*get_gpint_response)(struct dmub_srv *dmub);
 
+	uint32_t (*get_gpint_dataout)(struct dmub_srv *dmub);
+
 	void (*send_inbox0_cmd)(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 
@@ -676,6 +678,22 @@ dmub_srv_send_gpint_command(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
 					     uint32_t *response);
 
+/**
+ * dmub_srv_get_gpint_dataout() - Queries the GPINT DATAOUT.
+ * @dmub: the dmub service
+ * @dataout: the data for the GPINT DATAOUT
+ *
+ * Returns the response code for the last GPINT DATAOUT interrupt.
+ *
+ * Can be called after software initialization.
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_get_gpint_dataout(struct dmub_srv *dmub,
+					     uint32_t *dataout);
+
 /**
  * dmub_flush_buffer_mem() - Read back entire frame buffer region.
  * This ensures that the write from x86 has been flushed and will not
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 8c886ece71f6..4fb9423fd880 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -305,6 +305,21 @@ uint32_t dmub_dcn31_get_gpint_response(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_SCRATCH7);
 }
 
+uint32_t dmub_dcn31_get_gpint_dataout(struct dmub_srv *dmub)
+{
+	uint32_t dataout = REG_READ(DMCUB_GPINT_DATAOUT);
+
+	REG_UPDATE(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN, 0);
+
+	REG_WRITE(DMCUB_GPINT_DATAOUT, 0);
+	REG_UPDATE(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK, 1);
+	REG_UPDATE(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK, 0);
+
+	REG_UPDATE(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN, 1);
+
+	return dataout;
+}
+
 union dmub_fw_boot_status dmub_dcn31_get_fw_boot_status(struct dmub_srv *dmub)
 {
 	union dmub_fw_boot_status status;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 2829c3e9a310..868119b0c566 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -103,11 +103,15 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH14) \
 	DMUB_SR(DMCUB_SCRATCH15) \
 	DMUB_SR(DMCUB_GPINT_DATAIN1) \
+	DMUB_SR(DMCUB_GPINT_DATAOUT) \
 	DMUB_SR(CC_DC_PIPE_DIS) \
 	DMUB_SR(MMHUBBUB_SOFT_RESET) \
 	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
 	DMUB_SR(DCN_VM_FB_OFFSET) \
-	DMUB_SR(DMCUB_TIMER_CURRENT)
+	DMUB_SR(DMCUB_TIMER_CURRENT) \
+	DMUB_SR(DMCUB_DATA_WRITE_FAULT_ADDR) \
+	DMUB_SR(DMCUB_INTERRUPT_ENABLE) \
+	DMUB_SR(DMCUB_INTERRUPT_ACK)
 
 #define DMUB_DCN31_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -138,7 +142,10 @@ struct dmub_srv;
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
-	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET)
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
+	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
+	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN) \
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK)
 
 struct dmub_srv_dcn31_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
@@ -212,6 +219,8 @@ bool dmub_dcn31_is_gpint_acked(struct dmub_srv *dmub,
 
 uint32_t dmub_dcn31_get_gpint_response(struct dmub_srv *dmub);
 
+uint32_t dmub_dcn31_get_gpint_dataout(struct dmub_srv *dmub);
+
 void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params);
 
 void dmub_dcn31_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index fd7e996ab1d7..d560e31ecab6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -223,6 +223,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_gpint = dmub_dcn31_set_gpint;
 		funcs->is_gpint_acked = dmub_dcn31_is_gpint_acked;
 		funcs->get_gpint_response = dmub_dcn31_get_gpint_response;
+		funcs->get_gpint_dataout = dmub_dcn31_get_gpint_dataout;
 		funcs->get_fw_status = dmub_dcn31_get_fw_boot_status;
 		funcs->enable_dmub_boot_options = dmub_dcn31_enable_dmub_boot_options;
 		funcs->skip_dmub_panel_power_sequence = dmub_dcn31_skip_dmub_panel_power_sequence;
@@ -720,6 +721,22 @@ enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_get_gpint_dataout(struct dmub_srv *dmub,
+					     uint32_t *dataout)
+{
+	*dataout = 0;
+
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (!dmub->hw_funcs.get_gpint_dataout)
+		return DMUB_STATUS_INVALID;
+
+	*dataout = dmub->hw_funcs.get_gpint_dataout(dmub);
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 					     union dmub_fw_boot_status *status)
 {
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
index e5fd0121ceff..a9d553ef26c0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
@@ -5971,6 +5971,7 @@
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_GPINT1_INT_EN__SHIFT                                                    0xb
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_GPINT2_INT_EN__SHIFT                                                    0xc
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_UNDEFINED_ADDRESS_FAULT_INT_EN__SHIFT                                   0xd
+#define DMCUB_INTERRUPT_ENABLE__DMCUB_GPINT_IH_INT_EN__SHIFT                                                  0x11
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_TIMER0_INT_EN_MASK                                                      0x00000001L
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_TIMER1_INT_EN_MASK                                                      0x00000002L
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_INBOX0_READY_INT_EN_MASK                                                0x00000004L
@@ -5985,6 +5986,7 @@
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_GPINT1_INT_EN_MASK                                                      0x00000800L
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_GPINT2_INT_EN_MASK                                                      0x00001000L
 #define DMCUB_INTERRUPT_ENABLE__DMCUB_UNDEFINED_ADDRESS_FAULT_INT_EN_MASK                                     0x00002000L
+#define DMCUB_INTERRUPT_ENABLE__DMCUB_GPINT_IH_INT_EN_MASK                                                    0x00020000L
 //DMCUB_INTERRUPT_ACK
 #define DMCUB_INTERRUPT_ACK__DMCUB_TIMER0_INT_ACK__SHIFT                                                      0x0
 #define DMCUB_INTERRUPT_ACK__DMCUB_TIMER1_INT_ACK__SHIFT                                                      0x1
@@ -6000,6 +6002,7 @@
 #define DMCUB_INTERRUPT_ACK__DMCUB_GPINT1_INT_ACK__SHIFT                                                      0xb
 #define DMCUB_INTERRUPT_ACK__DMCUB_GPINT2_INT_ACK__SHIFT                                                      0xc
 #define DMCUB_INTERRUPT_ACK__DMCUB_UNDEFINED_ADDRESS_FAULT_ACK__SHIFT                                         0xd
+#define DMCUB_INTERRUPT_ACK__DMCUB_GPINT_IH_INT_ACK__SHIFT                                                    0x11
 #define DMCUB_INTERRUPT_ACK__DMCUB_TIMER0_INT_ACK_MASK                                                        0x00000001L
 #define DMCUB_INTERRUPT_ACK__DMCUB_TIMER1_INT_ACK_MASK                                                        0x00000002L
 #define DMCUB_INTERRUPT_ACK__DMCUB_INBOX0_READY_INT_ACK_MASK                                                  0x00000004L
@@ -6014,6 +6017,7 @@
 #define DMCUB_INTERRUPT_ACK__DMCUB_GPINT1_INT_ACK_MASK                                                        0x00000800L
 #define DMCUB_INTERRUPT_ACK__DMCUB_GPINT2_INT_ACK_MASK                                                        0x00001000L
 #define DMCUB_INTERRUPT_ACK__DMCUB_UNDEFINED_ADDRESS_FAULT_ACK_MASK                                           0x00002000L
+#define DMCUB_INTERRUPT_ACK__DMCUB_GPINT_IH_INT_ACK_MASK                                                      0x00020000L
 //DMCUB_INTERRUPT_STATUS
 #define DMCUB_INTERRUPT_STATUS__DMCUB_TIMER0_INT_STAT__SHIFT                                                  0x0
 #define DMCUB_INTERRUPT_STATUS__DMCUB_TIMER1_INT_STAT__SHIFT                                                  0x1
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
