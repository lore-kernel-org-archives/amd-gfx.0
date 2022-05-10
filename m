Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2E4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE58310E85A;
	Tue, 10 May 2022 20:45:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DCC10E85A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyuEJJWVAa4AdjzbrjWfbXPhgKhWGkWMupNvpxNNPC/hEOaBEim6kx71s3mYioOgCZJ/EtfFb7DIlu7B2jimCWlgYGRGie57HWezqDD5MmZ4qy78OP/uMUILbukzCA3m99mTzkFCwNYc+Fd4ZzWuDbc5rcY/agAzJONH4gdHP4vwcmiWIOCsIE6Vq+QdFWsPrJrVEevn/bVOtQaHXi8rdZx0tbWTR7TmbJjwPv1Fj2u9134uFl18kV4p21mkYcbRLbSCGBr4HOrgRRNyGBXsMUhxRtNZ276xHK+6JwbAj+jd1MUDgGCh7EuC4o6uNdlAWH3IpKXts0rb6/ZSt2LdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK+O3cgbz2v7O5fMetdafrvFUlTWphFUGkZc3Azq0JM=;
 b=gSnNwz5zSkrtUrE7o3cqARnoackqy22dduhRjTo65iHBjH49NoTOjWW0oS5yQ0FUCGiRcZH5V2evpLVCK9GD5O+1gmz5hoW4z+5ZRoQIgeQQg8k7dVBeNRhksb2OyorkU7bfx6oSOwZPamt0mg+pdpPmqXSB9YijSyuiNJC88PQAihrEUu4x1sqcN+hh/qh5J5/uPJ58+MUlJITeUlyEZHEWGoCz0Bz/sghwJjmzjm5zvdA5HrpmN7wd2hb+BB+pWL2mnREptpHP4AfZ3emSL1+3VlTPvIl0QT8Gg516kX3juilvLfmljNk9LwZv8w2f2jq6unqKQJVMuebVlybxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK+O3cgbz2v7O5fMetdafrvFUlTWphFUGkZc3Azq0JM=;
 b=X35Xz3DMvI2f+DEqGxcge3LLIXllRoqPq60TaXiUaszhsiDhPePxtrBY0nJ/OUHGoyfpTCISCwS3SX7LQosE3VqVn57Z89nwa+iQ+FS2pHPwBTK+GFnKEl3Bt6Y6G+GmkwtXaq9cJ22fVAWai9/Doy8hVM1OJMdGWKfbl2mXM6Q=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:45:50 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::a9) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 10 May 2022 20:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:45:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:48 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:43 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/19] drm/amd/display: program PSR2 DPCD Configuration
Date: Tue, 10 May 2022 16:44:55 -0400
Message-ID: <20220510204508.506089-7-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f35788-8022-49c6-6e02-08da32c61197
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5465C489491F738ED1BE25C68DC99@PH0PR12MB5465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J8JkfRqZoTTvGapSX1EieLDm8g4rR8m8EIqk7CkCmElZEx7EOUdN0c0C4OeGimY5dIpv1x2Hb//Ao8yizdTK9tpv48Yw0sRkRjbfUQVSHQA0PjX8qHrSX5MH/K9EFuxCpg+Ujm2YRT0+OqLs3NRU1kIWsEL9jRvo7/7qB6VGTqNV66QxczIV6i3eV4ZwQTE5qaevCqxrcy/ltIe5po87Pn03575lyv4xEPL9WUK/TSReAj0VjiBMjBWEEmDgGx82nsKAUBZNjULIRVdqG6wUYoM9OnQmMXMeHBqPXlJ22JduNmOhJQ/JOJoEsDitswSTlBYrKwGB8wVTbKKkIv9vmr/YULKTj6UqbMxgc55pdjf74Im32MbH4kixmbyep+4cosgQ6yv5x/rPJerd6XimiN4i/YEr/nroHEUdCunsleYGULs5e5jDSIMsuHsnVs6MB0/PXXoxnqLFm2LwJyNGLk5N19F1bW12coDbv9CM6VlcvcSGZhrY8FCkf8i+24g756V0ojyNQZemt3fbGAXGJXaQZF9/C7opFdAn6p+WKPbIXvjXpIUs6HZMXg/UeZL22wcA/9h4HHJRJAPAojBvOG8g6e3zFlKDGWkUJ+OxvF1cHhXkLq+R9CI6jzd9d9WUpQjdWIJv3ig6FX6U6E/4UQDTHRFo6p/z9QyxBvSiq6QI6/7ALlet1hOV+6p+BJmVOFXAvfWkz0jlKX7oVmMkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(70586007)(6666004)(426003)(47076005)(70206006)(316002)(508600001)(7696005)(186003)(81166007)(36860700001)(2906002)(40460700003)(4326008)(54906003)(8676002)(6916009)(336012)(82310400005)(86362001)(356005)(2616005)(8936002)(83380400001)(1076003)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:50.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f35788-8022-49c6-6e02-08da32c61197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
To support PSR2 Source DPCD configuration

[How]
Update the PSR2 Source DPCD settings while the PSR2 enabled

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 23 ++++++++++++++++++-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  | 13 ++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67ef357e5798..a391a58252bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3175,6 +3175,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	unsigned int panel_inst;
 	/* updateSinkPsrDpcdConfig*/
 	union dpcd_psr_configuration psr_configuration;
+	union dpcd_alpm_configuration alpm_configuration;
 
 	psr_context->controllerId = CONTROLLER_ID_UNDEFINED;
 
@@ -3200,7 +3201,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 			psr_config->psr_frame_capture_indication_req;
 
 	/* Check for PSR v2*/
-	if (psr_config->psr_version == 0x2) {
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
 		/* For PSR v2 selective update.
 		 * Indicates whether sink should start capturing
 		 * immediately following active scan line,
@@ -3211,6 +3212,14 @@ bool dc_link_setup_psr(struct dc_link *link,
 		 * IRQ_HPD when CRC mismatch is detected.
 		 */
 		psr_configuration.bits.IRQ_HPD_WITH_CRC_ERROR    = 1;
+		/* For PSR v2, set the bit when the Source device will
+		 * be enabling PSR2 operation.
+		 */
+		psr_configuration.bits.ENABLE_PSR2    = 1;
+		/* For PSR v2, the Sink device must be able to receive
+		 * SU region updates early in the frame time.
+		 */
+		psr_configuration.bits.EARLY_TRANSPORT_ENABLE    = 1;
 	}
 
 	dm_helpers_dp_write_dpcd(
@@ -3220,6 +3229,18 @@ bool dc_link_setup_psr(struct dc_link *link,
 		&psr_configuration.raw,
 		sizeof(psr_configuration.raw));
 
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
+		memset(&alpm_configuration, 0, sizeof(alpm_configuration));
+
+		alpm_configuration.bits.ENABLE = 1;
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_RECEIVER_ALPM_CONFIG,
+			&alpm_configuration.raw,
+			sizeof(alpm_configuration.raw));
+	}
+
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
 	psr_context->transmitterId = link->link_enc->transmitter;
 	psr_context->engineId = link->link_enc->preferred_engine;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 2013a70603ae..66132f3cac42 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -85,7 +85,18 @@ union dpcd_psr_configuration {
 		unsigned char LINE_CAPTURE_INDICATION   : 1;
 		/* For eDP 1.4, PSR v2*/
 		unsigned char IRQ_HPD_WITH_CRC_ERROR    : 1;
-		unsigned char RESERVED                  : 2;
+		unsigned char ENABLE_PSR2               : 1;
+		/* For eDP 1.5, PSR v2 w/ early transport */
+		unsigned char EARLY_TRANSPORT_ENABLE    : 1;
+	} bits;
+	unsigned char raw;
+};
+
+union dpcd_alpm_configuration {
+	struct {
+		unsigned char ENABLE                    : 1;
+		unsigned char IRQ_HPD_ENABLE            : 1;
+		unsigned char RESERVED                  : 6;
 	} bits;
 	unsigned char raw;
 };
-- 
2.25.1

