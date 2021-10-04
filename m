Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216DAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC9F61391
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCC9F61391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2C76EA18;
	Mon,  4 Oct 2021 14:45:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEC56EA17
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV1uObkJIlB/F9qQFPJ+kZ/OtGjuAPJ9+iQxj21hBC7V50r9ks5aY9ep1xS4O6cfG1XgvZtPgF2pGbE9iRFqjsjuXmfsjtv/lmIEkFi04k7tMFgWNCdlcZcZE9SoefIoj7oPssaAfbMWQFEisSYqgaXBxknCiprzJNv4tsC59i2yghfixJSidPTUpAYNv5U3lZsJe/9VFSZd6s7oizvY6RGV/4NI+ILqckdSLb8PINiHW5ev5m++MAEdntV5FF9biLYtLYLy6czKHPmfCQsCtY4vlIZnj142AFCP7Hw+wNqsI7HkWFS1SdzGl0t1X2wYTLGuTxwUEZotnXx1mcFTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Op3cuyxFwUOWYqvDLn++DDS8fko+0kWIdBi+DjGAmg=;
 b=fnksuL9HEF8tPjFSfxzNec26yKtx6+p3eGE4kQ/d6Jqx1HYc+SsY6LvYO9Io9rrJxZigK8YZjh12JHMff0TgPjEwvD/tVmWHxCKqGO7reUpDYeWMHbnNH7th3Ow1yYdV3+atjeWyFYc8sNuaCeOMcUqCsMX8qFOFlqlk2oXCQPWT+ZCOxgPTEaOH3lxfqOEFwzPYDn+0H98Hd36jVKMS/+tKpO7ufDGZSShT+nFVaav1mSHeB5PDLaLtlbfHMTfO+I43rIJ6kYLJHjxfZyc4y5gHQ/vxvbn0l18Ny04IIQNNDkGzLTEk/dCiAy3MShOeCP/Ut4Bnd4uYepniCkUrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Op3cuyxFwUOWYqvDLn++DDS8fko+0kWIdBi+DjGAmg=;
 b=INzbOHH08s57ka9vQRwzA+bVIdy6RzZdbQYgjGuUEhXqEBPAUVA3deYhoHfq/yLZoXp/+OF4gCwz5RoRBOvoBJwDFmW3Rc6eBCmauRv95y4fS+YTDVGuKCezkmANZCqfqjxuu1v+ILSEXFZF3YRDoeGRSBOdkk06iUi/I1jhraY=
Received: from MWHPR02CA0024.namprd02.prod.outlook.com (2603:10b6:300:4b::34)
 by DM6PR12MB3499.namprd12.prod.outlook.com (2603:10b6:5:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 14:45:49 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::ae) by MWHPR02CA0024.outlook.office365.com
 (2603:10b6:300:4b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Mon, 4 Oct 2021 14:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:45:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:47 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:45:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 20/23] drm/amd/display: Fix for access for ddc pin and aux
 engine
Date: Mon, 4 Oct 2021 22:40:47 +0800
Message-ID: <20211004144050.3425351-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da16673d-ad2f-4e48-21dc-08d98745a7ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34993636B2A99FD6EBE04BDAFCAE9@DM6PR12MB3499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97tabuFsc/WSI6hRyCIDXe8KCCA3BSojVeBszOF+yy7E5FxmCpAyHr6Qdp7xCa6gZTDlFE5+zMdKVbnbiR7pkrootE5Lh3OvGheCrXtjqf0rwig4z8gF4vES1e18w6XvOPtSztlAywNKBCfD+waBKRs2nonTvkNs8bdJCQPM9X8c9+6iRFAh/GV5bpZqGEwxVUiJjStSwmYIOO13fkBnOza0KdE5Z+wNfnTH9l7EEY4vcgwn6miSvp6ncDZ/IxhNdcGZkeqco5gwPLlxMxtAxXa2+4INF5nLJxkA6VJ9OpGV4TUfzlKjM71TrZsvmlUQ13/n4wCCe27R6VKgqGDoUlbit+/flpmx8fM9xlYn5QBlZMFGIUIt2lekxHr0ZrsWSoEKeP634d5OuRfsS4tSYAof23vxEwcy2s4yOqLuMGNSJFH24PvXGdX1ezENQVNuHOzFS0PnskknYW0aKwi+LB6YrCLzFcFH5pdnyHIMDIvbUU1V2e5I0gaGPVrTAFkO0tdOpSEppqvTbEKzxsqNY+iFLQsLP9Jf9g8favBCQjn561BhTCoQjeW7qsZ9wOnZGSo7ADtxyaJ/EC/IbTzkp5e0qg39/2a3OZfXOCptoCjKeQk0Ww6JZTCYP739qUtQOVsbDqZ5KaX///YgrmbssspWXbodiBvYPx1UxfbQtmdt5y+zI6OLbSSYc/ht2OuiA3eC7APeJD0j0RbEK10rHsZj8+rBvO0fRnltTOGA/cY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(5660300002)(81166007)(83380400001)(186003)(26005)(47076005)(6916009)(36860700001)(316002)(54906003)(86362001)(336012)(70206006)(1076003)(36756003)(6666004)(426003)(70586007)(2616005)(508600001)(8676002)(8936002)(7696005)(82310400003)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:45:48.8106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da16673d-ad2f-4e48-21dc-08d98745a7ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
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

