Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC37C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F1961409
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5F1961409
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709986F5B6;
	Tue,  5 Oct 2021 08:01:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BAB6F5B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 08:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqPcTDXp9Pje1LI3L58B8kV51NafO2lqfoYEU4nZtpTNTXd7nkgXGr+QTEAoHae7rTxcMl6uh1qL09lMdMvS74vJ6W+behJz08DhVyfapeMlJ8Krz4tYUauUxL6xpvyTkDWqqjrEH7ALYO0pMkNhbZgTqSLCqio7jELPmO3Cc8Ldt8Iy3yzXiYtYBx0gx+oWZomqTB/s3c2lOBOmWl6bwXxkGTBzqqRBg0O6J2UAzpx9agjRDPhgTaoPN3t9bzK7SJpwN3s3qh1kuq5u2RDNazYDl8l9KZALiDWojlC6+2RJf3UQZTrXzYME2reBtwWDbVaOhUESz2CGdk84w8eIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Op3cuyxFwUOWYqvDLn++DDS8fko+0kWIdBi+DjGAmg=;
 b=TvffJ/uRq6Bln8iYRCLEQivvd2A1zgz0mt5EI0ZkqJGDHxnoaHFVT9mrdnV1CGcS/ZsKdpYApfbH0Wx+1bgl3yrQ7nwh84PMYpZIvKdpa6msM8l4QnYij/+oVzMMrY9sO4Gfi7ipFvazjfjBA9kmipuJ9sPJ2YLj2U++Its9k+0o2imkic5hCKltYHfy7me/YkytkmLLuiLRAOerTxkl8l6r2Tks4uN5+ms7BTTp6qHwKR362cYTgaqYMxABsTJsMsED3JAfRaI/EQBhfZpQ4DJTAcUYIq99pC5ULbOFxi2KwL/I2gIMGcx3O4p2x3wzZqCdgoSnFoOhbCVjH0J2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Op3cuyxFwUOWYqvDLn++DDS8fko+0kWIdBi+DjGAmg=;
 b=OErHnRCpjyYmQROHeHAi+LAEZTh4lGaeC1LufH+rTwclWfxfVh+CjZJcCpJM4imbjO0oHiZpG22qNkxJrbBZQYvmkR6IVmjnNp1Kx/0QJRfmbHI4p19JxM0WXC5xMGlzpgM/2+G5/SDIwVqRHYgfB8H7FYyN1RW63fa/0URNqFM=
Received: from MWHPR2201CA0054.namprd22.prod.outlook.com
 (2603:10b6:301:16::28) by DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 08:01:09 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::f6) by MWHPR2201CA0054.outlook.office365.com
 (2603:10b6:301:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 08:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 08:01:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 03:01:07 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 03:00:54 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 20/23] drm/amd/display: Fix for access for ddc pin and aux
 engine
Date: Tue, 5 Oct 2021 15:52:02 +0800
Message-ID: <20211005075205.3467938-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7127ebd3-36fe-4b31-a335-08d987d64a5c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2407:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2407905DB2A83E964731AF9CFCAF9@DM5PR12MB2407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3kYRYe24yMsI+8ZvlNyI5ATcVpy092mnJixAEu4Q+OegKKUWo6MhLE9HF65C9TLr4SyMqAecB0ZyqKHt6U1D7EFQjMJcxtZrT0ynhB8zVHrHrmy1tSk+oaRCrmgnA5Um5TGIcY5dOsqtbmIdAEcTbdHRul2dtSztNNOIIzoIBiO70u2pO43g+3B3EUWG/Hb7R8W6JpFTcVjSWH3CxnrnLUwXvubNbODl+OYLAT8GJBdWAMgP2lbp4sSckLvhHXLbj26OBswLkP+kzFun5hcpC9SPQCx8rrCUqbNynvIul1KjpNddArOJyKrVklovs2QjtNohT02QzOzuBVCxwt3A2kSmzb3r4s1GD62Ive9JHyjpEGUBve7Z09kPVFR8Lu6Tm9UGVcWn8JA4vUaj/HsaCgankLo+3107am83YxXhP1NXG6FUgVd0Z2rs3W0NoqDJnZbBdsxsyVoy4lMnIcpY+VYBO4JGx/5A9Zr7Cq4xbpHVsYNzPxcbRh6T/wIE31rKHWmsqoeu5IPhuphHZSGecNXFG+heQHpVoVFsjefdCflfQtGWQmM/NrhJ+CPuxkIqjm5rfg9sGpMsw1+iayYlzdATLrCPdsaK0afcmMfEv7rNf9sESOblGUPXPKSdd++rOIkoIlZuj7GV1+14NRdtAhLMgXOLxcJkohm6aG6bp8tP+3mf5OmGro7Z/vJ6gUNRkUiLzUv3G0GZCIT+CvgBPo91IrNm/DED0Rul8SuECk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(6916009)(36756003)(508600001)(81166007)(8936002)(6666004)(54906003)(8676002)(356005)(70206006)(70586007)(86362001)(1076003)(316002)(26005)(186003)(5660300002)(2906002)(36860700001)(4326008)(2616005)(426003)(7696005)(83380400001)(82310400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 08:01:08.8514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7127ebd3-36fe-4b31-a335-08d987d64a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
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

[Why & How]
Add codes for commit "b693dfe24d61 drm/amd/display: Fix for null
pointer access for ddc pin and aux engine" to take USB4 feature
into account.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 6 +++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 6 +++---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/irq_types.h         | 5 +----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6b5ddf0a29c1..ca5dc3c168ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1709,9 +1709,9 @@ static bool dc_link_construct_dpia(struct dc_link *link,
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
-	/* Initialized dummy hpd and hpd rx */
-	link->irq_source_hpd = DC_IRQ_SOURCE_USB4_DMUB_HPD;
-	link->irq_source_hpd_rx = DC_IRQ_SOURCE_USB4_DMUB_HPDRX;
+	/* Initialized irq source for hpd and hpd rx */
+	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
 	link->link_status.dpcd_caps = &link->dpcd_caps;
 
 	link->dc = init_params->dc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index ce15a38c2aea..b8b1fa0d4ae3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -230,7 +230,7 @@ static enum dc_status dpcd_set_lt_pattern(struct dc_link *link,
 	}
 
 	status = core_link_write_dpcd(link,
-				      DP_TRAINING_PATTERN_SET,
+				      dpcd_tps_offset,
 				      &dpcd_pattern.raw,
 				      sizeof(dpcd_pattern.raw));
 
@@ -788,7 +788,7 @@ static enum dc_status dpcd_clear_lt_pattern(struct dc_link *link, uint32_t hop)
 			((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (hop - 1));
 
 	status = core_link_write_dpcd(link,
-			DP_TRAINING_PATTERN_SET,
+			dpcd_tps_offset,
 			&dpcd_pattern.raw,
 			sizeof(dpcd_pattern.raw));
 
@@ -898,7 +898,7 @@ enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *lin
 	enum link_training_result result;
 	struct link_training_settings lt_settings;
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
-	uint8_t repeater_id; /* Current hop. */
+	int8_t repeater_id; /* Current hop. */
 
 	/* Configure link as prescribed in link_setting and set LTTPR mode. */
 	result = dpia_configure_link(link, link_setting, &lt_settings);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 5666543f095b..95cb4d7cc76a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -627,6 +627,7 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 #define AUX_MAX_I2C_DEFER_RETRIES 7
 #define AUX_MAX_INVALID_REPLY_RETRIES 2
 #define AUX_MAX_TIMEOUT_RETRIES 3
+#define AUX_DEFER_DELAY_FOR_DPIA 4 /*ms*/
 
 static void dce_aux_log_payload(const char *payload_name,
 	unsigned char *payload, uint32_t length, uint32_t max_length_to_log)
@@ -772,6 +773,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 				/* polling_timeout_period is in us */
 				if (aux110)
 					defer_time_in_ms += aux110->polling_timeout_period / 1000;
+				else
+					defer_time_in_ms += AUX_DEFER_DELAY_FOR_DPIA;
 				++aux_defer_retries;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 7a9f667d5edb..530c2578db40 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -153,10 +153,7 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DMCUB_OUTBOX,
 	DC_IRQ_SOURCE_DMCUB_OUTBOX0,
 	DC_IRQ_SOURCE_DMCUB_GENERAL_DATAOUT,
-	DAL_IRQ_SOURCES_NUMBER,
-	/* Dummy interrupt source for USB4 HPD & HPD RX */
-	DC_IRQ_SOURCE_USB4_DMUB_HPD,
-	DC_IRQ_SOURCE_USB4_DMUB_HPDRX,
+	DAL_IRQ_SOURCES_NUMBER
 };
 
 enum irq_type
-- 
2.25.1

