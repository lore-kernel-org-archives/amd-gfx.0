Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2868C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B06360EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B06360EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2574C6E9D1;
	Fri, 27 Aug 2021 20:44:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DD66E9D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maK3u0JUj/Rk4vQinotYk0uSOxXqjp5uSRsNOvyJbuuqg0N8ECY6YFSrEMr04ammDnMzio/4+a0269TZXpz66Dm+LeL+sER4vn1J0aKsIDNS+jEP29m6/S4tD1DFKTCQn8l4BzMaBzdhxdP2loSWl3dD6ZU7kKbXcjZcaCFsjCJat8KRIaIRTfrJFrGaKiQObZeVwp56NDfJwEVk1eBYp1nPcj9cJXMoV2PZi+GFG565T1ioHkd6dmk02geQVCr0v75hdr+TrKW6Q73NCKVNxzKTd+kU5KlNiEy14F+GOGCVAo6fkdSa5lMZTtk1j217Uy2cGiZfacuyzYz5EZcLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAj6i2z8xtPZgLaXgCV3llt+BUJqPwgp1oCb2xQNOyk=;
 b=UOXJWk9SCkhUwrdSJQKMVcSDrVBYz4Fr5KTf2LEbiJIcMhZLkp9Ysy3USbHrC62QqGZ+jVKx3NAK1LIOSIZnW+u9QmoPvQddiXA84QlEDx9kqfxmfSJgNWjAIMPlKebrpyEP2XQ+IoXXG/rFdn8egPmW8eLVERrh3iEN2Rk3p1kxyvWPILgbtw3l/OGozXxlyO9Bcpl9DI6d+seN8hAxkyPRQgOVPIdYaBvsFhuqTJ1iTfs2sdWVFEp7GPbP2C5mBxmlnQLGLGUIgkA/o0L0PEi4a/sf7Z0aXviIACWpfrIwz0nwVkTPJsAw0xGz7wdfEH3C8A7AHrvloVjxXhi8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAj6i2z8xtPZgLaXgCV3llt+BUJqPwgp1oCb2xQNOyk=;
 b=yOAxAz+hevc1NzXLO1dTmH3tiMrGPXMdmG7XBTLD4OaFqP1vWREHY52SQUgh5GZXo0TEumjXQsFxaVzlYSUyYuSurXbpRMNlGB2/59t0MmRrBuVQTOf5hTtfiFZLXimnOr2gAZXX5nu9ZZWWvWn5Uunug4/FqipSoD1qlBj8tl4=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by BN8PR12MB3044.namprd12.prod.outlook.com (2603:10b6:408:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 20:29:39 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::17) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:38 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:37 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito <jimmy.kizito@amd.com>
Subject: [PATCH 13/19] drm/amd/display: Fix for null pointer access for ddc
 pin and aux engine.
Date: Fri, 27 Aug 2021 16:29:04 -0400
Message-ID: <20210827202910.20864-14-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db06168-441e-4029-99aa-08d9699964be
X-MS-TrafficTypeDiagnostic: BN8PR12MB3044:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3044289C13BDF50B939648F1E4C89@BN8PR12MB3044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73PP9Hd4gPJU+8IdeH0kbD9+LJAlvbud2NUF3rxNpemkwEbwxqcPPtTbzbfBA/GCAGXCNcFIrGKWAUU3f4Cy4MqSmIpF2I2RmkHFHwSFqVrSmGKSmk48NScoS8ii7YQHmeib9QuGef5SMno2CQwL/b19pI4dQdpR3PpgFUucV5/WydPmDf4kurFjxNKkesUrpYkLd+5uZlI9ULB0aqTHvN3zu1QlZENUtZ2vWkUOBi3TL2c3Bd9u7SVzraUf1tnV2rcneDA825I+tynd8auwaUtGA6aPbxN3udZ1P6eQUK8Fgr0H4FjZQ8RcW6RDkjTFyRa45/ehmvlqXVJeCbzSNAu+A1CggHDBTr5crX77da16myVARApLWWaHc7ik4O6XOEzh+O/K2b8/OWCnAwNwBjaTTpljjFzW2jJz3L7Fq4aNUfR22sot6PZtZvwHfX0uIY1TXVvCiTE3DXK1IL4iI5yw+h8dpXXWC7kZfAXPXXfZVd4IW2OBdaGCTQSCfYM8eIV68MNAt2v4eChPMnmmXcMrKsEKC3OMWkkQNfMB/TxhSFQoM0mzVtAkm7z1XK8jx4ByB4VBtQUy5JUjRhKsvj1fpcbTN2Bddht0m2o0EKa2OQH5JXMHF9A3Aic+n4hjxFsTrQv0RBUdfmuyT/F3tBgs5x03wAWckvHvUUfOo41ydHo46gwY9LlHS0iZteDzln6Y9DSrmAwGhNDkBqQqkSCpZfev9AUHnDmZm61WRWA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(83380400001)(426003)(1076003)(16526019)(86362001)(186003)(2906002)(5660300002)(70206006)(70586007)(54906003)(81166007)(6666004)(36860700001)(336012)(2616005)(478600001)(44832011)(8936002)(82740400003)(36756003)(356005)(26005)(82310400003)(4326008)(47076005)(8676002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:38.9202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db06168-441e-4029-99aa-08d9699964be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3044
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Need a check for NULL pointer access for ddc pin and aux engine.

[How]
Adding a check for ddc pin and aux engine accesses.

Reviewed-by: Jimmy Kizito <jimmy.kizito@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c      | 12 +++++++++---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 2fb88e54a4bf..a75487ed1bb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -630,8 +630,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 	enum aux_return_code_type operation_result;
 	bool retry_on_defer = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
-	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
-	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
+	struct dce_aux *aux_engine = NULL;
+	struct aux_engine_dce110 *aux110 = NULL;
 	uint32_t defer_time_in_ms = 0;
 
 	int aux_ack_retries = 0,
@@ -640,6 +640,11 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		aux_timeout_retries = 0,
 		aux_invalid_reply_retries = 0;
 
+	if (ddc_pin) {
+		aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
+		aux110 = FROM_AUX_ENGINE(aux_engine);
+	}
+
 	if (!payload->reply) {
 		payload_reply = false;
 		payload->reply = &reply;
@@ -666,7 +671,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 
 			case AUX_TRANSACTION_REPLY_AUX_DEFER:
 				/* polling_timeout_period is in us */
-				defer_time_in_ms += aux110->polling_timeout_period / 1000;
+				if (aux110)
+					defer_time_in_ms += aux110->polling_timeout_period / 1000;
 				++aux_defer_retries;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 381c17caace1..3d2f0817e40a 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -227,7 +227,7 @@ enum {
 #define FAMILY_YELLOW_CARP                     146
 
 #define YELLOW_CARP_A0 0x01
-#define YELLOW_CARP_B0 0x02		// TODO: DCN31 - update with correct B0 ID
+#define YELLOW_CARP_B0 0x20
 #define YELLOW_CARP_UNKNOWN 0xFF
 
 #ifndef ASICREV_IS_YELLOW_CARP
-- 
2.25.1

