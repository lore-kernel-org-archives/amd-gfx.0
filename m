Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64CFC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A647661A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A647661A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0496F4AB;
	Fri, 26 Mar 2021 22:05:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676496F4A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH7167VVMIAM/MqjgoLv792mK5NTK/ckkLBRSt+XFb9xhysNhQx3NJMzIT/aH6B6q7jEfqK+3Q+VPWIphqzthhopZ0yxiUwM8iSfa5l2WhasvR4AWmyNJMRx2lJ4j2O1/aNMWDvRvHmtQsegTZ6jWbhauCwu6dRJR4QP5mio9pjFjnVGli29bQ6LaPd2A9dE3nQDdsV5wpTfmFKx0x0XIoJiY7PGahFcHbRaKcd6ujLot70r2rl9uB4KaKO4KDi5w2xs0p9aKkOuG6Sx4ZYtlLZ0RSKDv1b15k4u1EAmPX0jtlxVGOoc2Myw7iF1nPdYHXd2p2j+SKpGpAtxip4PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rhf88L1gkO3//TG0as7VMpLu7NjN+McIGzvZyvVFU8=;
 b=BRNZYire9Pk01NMmT8+SC5IkD7Vj5b536mmBWxens1ENqG58jRN1tFQ5oVn9cvbODMfefcgYpVsiyE5YyPYcjRd6V/foKwBOxI95808P0tgdv6eqONnAKLj5M+enYREep8096zFWGLmaknnEiF1DmYx82lEocbjHQ29uU5fHom9Y/WXzssgpAEoQe6AgLqbQwjDMGmwfT0I1ivzUqoPg6e3zk2kr/MkjZmPeBNo9/qR57eYnJ1EQYh9wDwxsCBlLYzZ71e0XDFF+3ELQ0Amwu7Y6wrKWlS8qXE4sOQ8kTfxxxY3XKYSijDrDE/Mv1ka1uSb5JTwngDDHbnpDpeRjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rhf88L1gkO3//TG0as7VMpLu7NjN+McIGzvZyvVFU8=;
 b=PQAgcNZ4j8bvsjQYNMycpQR6+U4FCGkRWwz+U6dej0eC/BAyUw00QEHR1G7YpExjeCBM+ditddn97CFizQQvbuufuGWOB3SCYmcKpukuM3j5feoSLSrVLkiDZtw+SCkW4oSR4zV/8xa9UIbKC19qUUrbLFmn0kkREPqr84Z8RfM=
Received: from DM3PR11CA0005.namprd11.prod.outlook.com (2603:10b6:0:54::15) by
 CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.26; Fri, 26 Mar 2021 22:05:46 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::f6) by DM3PR11CA0005.outlook.office365.com
 (2603:10b6:0:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:44 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:44 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amd/display: Guard ASSR with internal display flag
Date: Fri, 26 Mar 2021 18:05:17 -0400
Message-ID: <20210326220534.918023-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 749cd77f-802c-4c11-47a8-08d8f0a34e68
X-MS-TrafficTypeDiagnostic: CH2PR12MB4294:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4294AAFDD163A58D95BD090EEB619@CH2PR12MB4294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QVCk/tlz0Wv7hVmz62eznHjrEskK4bZJVd9PTekPaG0d8kWWATcexjyXI0K5F6fTlDQTpHiXIlLNvLdNHaB3Idt5xYcaSjDS+fO/7WQbw+37uR+9rxPe5hYWkbbBRJblThlzpbmF8+o/w6t7JFFnuQDRLjisR0krxaMc/ki+QskfmcUcW1bEfZkjs2zj1Rh6KEhxtbXtn7gkYjGyp9AsFM0mv93jtKOufzUVxYXBehu2+i2NDy50In8889lS/WCSHPDsv5DG5+IbIRA33h0dWupX1CxsY/8iMIoZr0h8lBL9/NzpWPLWFltQkLddB0fI3UH5u50iucQz/Ejj4mr52+4WoiOK4W4bJU1vgve1t97JQRGz9B56Aj6bdcmqGUw1ZNNlstjidbTd+ka5IyQe6JkBZ35ANJNoqFYB5IuMi2cn64AUuJCAh38DHgYnRmrTMT4aDcZdjdFVonM0td9lSDBitv+1v41VgPPKn2TEU9MC375y1vVijgTWb3rGgpSYvqkeko02UNIKUgAVp6G04487ctx3EF3bj1MGWYnMcfxmV6S2e0D1qT8ii8IFYcS51GKnkjnRY+8UiZOfFfnmC6S7bXegQKxSRVfADZKlVNJ1mSLwaJVIrTTzI6AMyfOJdztPyTpRWof95aKoC9qsIwGTKAtGqdZSvx1LU/Kgy+2W4cIgZxh2LmVnqrQMbuh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(36860700001)(82740400003)(356005)(82310400003)(81166007)(70586007)(36756003)(7696005)(83380400001)(47076005)(86362001)(70206006)(2906002)(2616005)(478600001)(8936002)(336012)(5660300002)(1076003)(6916009)(8676002)(26005)(4326008)(6666004)(186003)(426003)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:45.7778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749cd77f-802c-4c11-47a8-08d8f0a34e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
ASSR enabling only considers capability declared in DPCD.
We also need to check whether the connector is internal.

[How]
ASSR enabling need to check both DPCD capability and internal display
flag.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 58 +++++++++++++------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 484d96f78ade..a92fc1875474 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1635,6 +1635,42 @@ enum link_training_result dc_link_dp_perform_link_training(
 	return status;
 }
 
+static enum dp_panel_mode try_enable_assr(struct dc_stream_state *stream)
+{
+	struct dc_link *link = stream->link;
+	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+	struct cp_psp *cp_psp = &stream->ctx->cp_psp;
+#endif
+
+	/* ASSR must be supported on the panel */
+	if (panel_mode == DP_PANEL_MODE_DEFAULT)
+		return panel_mode;
+
+	/* eDP or internal DP only */
+	if (link->connector_signal != SIGNAL_TYPE_EDP &&
+		!(link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+		 link->is_internal_display))
+		return DP_PANEL_MODE_DEFAULT;
+
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+	if (cp_psp && cp_psp->funcs.enable_assr) {
+		if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
+			/* since eDP implies ASSR on, change panel
+			 * mode to disable ASSR
+			 */
+			panel_mode = DP_PANEL_MODE_DEFAULT;
+		}
+	} else
+		panel_mode = DP_PANEL_MODE_DEFAULT;
+
+#else
+	/* turn off ASSR if the implementation is not compiled in */
+	panel_mode = DP_PANEL_MODE_DEFAULT;
+#endif
+	return panel_mode;
+}
+
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern,
@@ -1646,7 +1682,7 @@ bool perform_link_training_with_retries(
 	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
+	enum dp_panel_mode panel_mode;
 
 	/* We need to do this before the link training to ensure the idle pattern in SST
 	 * mode will be sent right after the link training
@@ -1671,23 +1707,11 @@ bool perform_link_training_with_retries(
 			msleep(delay_dp_power_up_in_ms);
 		}
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-		if (panel_mode == DP_PANEL_MODE_EDP) {
-			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
-
-			if (cp_psp && cp_psp->funcs.enable_assr) {
-				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
-					/* since eDP implies ASSR on, change panel
-					 * mode to disable ASSR
-					 */
-					panel_mode = DP_PANEL_MODE_DEFAULT;
-				}
-			} else
-				panel_mode = DP_PANEL_MODE_DEFAULT;
-		}
-#endif
-
+		panel_mode = try_enable_assr(stream);
 		dp_set_panel_mode(link, panel_mode);
+		DC_LOG_DETECTION_DP_CAPS("Link: %d ASSR enabled: %d\n",
+			 link->link_index,
+			 panel_mode != DP_PANEL_MODE_DEFAULT);
 
 		if (link->aux_access_disabled) {
 			dc_link_dp_perform_link_training_skip_aux(link, link_setting);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
