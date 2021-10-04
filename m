Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538A26137D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 538A26137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DDD6EA04;
	Mon,  4 Oct 2021 14:43:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FBC6EA06
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDYUYhYt52GJbb5dFfN0c+FwzBYGelS+AeJCXh3xTuRSJ93Dvlrsy7Fdfhyno1sCOPpyUFtsW5Wzl0azlEy2i29fsjmNRSyezknwO7gN737X+eisLIQ1f2gaq9EfDxU8GbcshNXYHFZstR2K+wsjhZ+hBeXsfKe21RN0Sn+x879s8bZfV2bBn7x9ImfHJ4vWWLIUXFq4j59wkqUDQ3v8UWjPPwzaP64XhwXNMKCtMQslSTvZubZYC/OxZlds46BOPfMJ1FVIvnr2t6ZQWWZyAobuZvmdDV2n9s9/pjWSYSfYsUi/s/bOdeS0UuTyK8LJoBr062D5G5qdAnCA6tvkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n53ZXRq3bJDAKl7hQ0mXYRB+u1+g/gjR15cy9RpM6Yg=;
 b=V7IvNyGQbvXgE4bSnQHPhAJFom4iW0BYVWjv12oFu1TgZNiq0EAT/qMz8qr27zLpgqju+RaR9ZjK7FDA1ueH3AGnNmXmnUVKazcqNyrYJ+4kREUPt5VLvHJ1L4FPRH2Qe/eg0fQI1HOKVJpPPZY/gKxk/CgW2/Uw2AkasnTmRl21JPdk10bABmHLN971JQ5hxg5P3FEPhVHnyVtM5gmQfzujOWHlnMu0Mf11CdK99WMxQh+/AjfFwBS1Ui8XsrrvVDzGv0u/0/MNf9Va1ftg2aB3Ip0t0v0d1nVZ5TotBys7ui+w0/eT82eiKU30iGNh8ea3xdadvL6Zt9CTWan8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n53ZXRq3bJDAKl7hQ0mXYRB+u1+g/gjR15cy9RpM6Yg=;
 b=LlOPKaEM5Gjpje4bMRwfHxtDgnDsnm7WaxqZCH/K4aggYIXztHmtaigaJwTpRwAk1Cxl2wX4B+rymiVjAXkCnnArqE9Lq+5wYq1NQypF/yVwSFp8GgOqbdaYof2RZwYVDrvYGx4VmQ41T/BxB0CE5wSPIRsbZzU5EPZOerEiCIU=
Received: from CO2PR04CA0167.namprd04.prod.outlook.com (2603:10b6:104:4::21)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 14:43:29 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::73) by CO2PR04CA0167.outlook.office365.com
 (2603:10b6:104:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend
 Transport; Mon, 4 Oct 2021 14:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:43:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:43:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:43:26 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:43:13 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 10/23] drm/amd/display: Implement DPIA link configuration
Date: Mon, 4 Oct 2021 22:40:37 +0800
Message-ID: <20211004144050.3425351-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f48bb2b5-f5d6-4ced-8045-08d987455431
X-MS-TrafficTypeDiagnostic: CH0PR12MB5203:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5203667BB32449D30800159FFCAE9@CH0PR12MB5203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqYabhvfw+atnL80KbsVBKjxTBSrAfhWl1DqrWIA4XNev0BnoK6/94uofTOWFz7kcJj8mNlDMeAPF/ccjECo4kO9Ske/HnoB5nAJ+goHFrFbKTMV3HPt8r9ucpojSB67c6TU6TkL6TyQdc2j2NihAX0fV6t0VB2iEfLL9h8EPGGLWuZ0q9XPuEZMuxqqyC5iK4eg4Q1ep471FuahRuZZ6dby1fRzT4DpLQYZ0ZFmcFU9swoawTU+FEDIrNADLvgL9tYWnxh0xH6itm8Mo4f3cwtHFKwfC5GXJXaEk7Pw291b6ootXh+W3vsbnPbQTkP6vdCfzm3fJ8fNvypim5gOl4HeHFQqGHkvNheIpHqoUm1/2fwdKDAfNgHx3PFM2mHAIgntUclpQSfmlFJ/24pwQbSHE/r/cB9IMsrnjh78aq5FwgGTnUPB9tunAxzKhtjAUQoS/zufaWP8g1IZ34tWfFg6CEl2qBg79cLii4R6ZKAuaNO0L3dJVul2nrR7Z2wOu+bWV23YUFOJ4T1vl5Rw5CvA5MGm3teXy3lV+N0DrVSriQCbHgedQlcv7wCw51Sr5XyhGl7RNymgyLbacQgfPcNfAZRlITaKLvCj7lsqz3uNzZHhI5mPK1B80GFnOES/GzuTHYQ4t0QVaavl8i9WToR1X/MprpP+SrZdSFcIwZtt4eByvEtzp9A+Sn1P7KUhRg3VnUvZnvwlJ6L5ywxrrExzMy7yKJa7Lt/tKcS9Wm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(2616005)(8676002)(316002)(2906002)(508600001)(83380400001)(426003)(7696005)(6666004)(8936002)(82310400003)(54906003)(47076005)(336012)(5660300002)(26005)(86362001)(70586007)(6916009)(70206006)(4326008)(1076003)(81166007)(36756003)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:43:28.3110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48bb2b5-f5d6-4ced-8045-08d987455431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Training settings need to be applied to DPIA link at start of each
training loop. Note: FEC readiness should be configured before link
training while FEC enablement should be configured once training is
complete.

[How]
- Implement DPIA link configuration function.
- Account for dynamically assigned link encoders during link
configuration.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 49 ++++++++++++++++---
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  2 +
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 4e9bbc9180d0..5ffaf6ca372b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -29,6 +29,9 @@
 #include "dc_link.h"
 #include "dc_link_dp.h"
 
+#define DC_LOGGER \
+	link->ctx->logger
+
 enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 {
 	/** @todo Read corresponding DPCD region and update link caps. */
@@ -37,17 +40,51 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 
 /* Configure link as prescribed in link_setting; set LTTPR mode; and
  * Initialize link training settings.
+ * Abort link training if sink unplug detected.
+ *
+ * @param link DPIA link being trained.
+ * @param[in] link_setting Lane count, link rate and downspread control.
+ * @param[out] lt_settings Link settings and drive settings (voltage swing and pre-emphasis).
  */
 static enum link_training_result dpia_configure_link(struct dc_link *link,
 		const struct dc_link_settings *link_setting,
 		struct link_training_settings *lt_settings)
 {
-	enum link_training_result result;
-
-	/** @todo Fail until implemented. */
-	result = LINK_TRAINING_ABORT;
-
-	return result;
+	enum dc_status status;
+	bool fec_enable;
+
+	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) configuring\n - LTTPR mode(%d)\n",
+				__func__,
+				link->link_id.enum_id - ENUM_ID_1,
+				link->lttpr_mode);
+
+	dp_decide_training_settings(link,
+		link_setting,
+		lt_settings);
+
+	status = dpcd_configure_channel_coding(link, lt_settings);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	/* Configure lttpr mode */
+	status = dpcd_configure_lttpr_mode(link, lt_settings);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	/* Set link rate, lane count and spread. */
+	status = dpcd_set_link_settings(link, lt_settings);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	if (link->preferred_training_settings.fec_enable)
+		fec_enable = *link->preferred_training_settings.fec_enable;
+	else
+		fec_enable = true;
+	status = dp_set_fec_ready(link, fec_enable);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	return LINK_TRAINING_SUCCESS;
 }
 
 /* Execute clock recovery phase of link training for specified hop in display
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index f86d4446f347..a5266d5999d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -428,6 +428,7 @@ void dcn31_link_encoder_enable_dp_output(
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
+			dpia_control.fec_rdy = link->fec_state == dc_link_fec_ready ? 1 : 0;
 		} else {
 			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
 			BREAK_TO_DEBUGGER();
@@ -469,6 +470,7 @@ void dcn31_link_encoder_enable_dp_mst_output(
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
+			dpia_control.fec_rdy = link->fec_state == dc_link_fec_ready ? 1 : 0;
 		} else {
 			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
 			BREAK_TO_DEBUGGER();
-- 
2.25.1

