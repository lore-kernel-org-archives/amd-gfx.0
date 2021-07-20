Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7003BC636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 03:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01CF610D0
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 03:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01CF610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988B889C83;
	Tue, 20 Jul 2021 03:33:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A6489C83
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 03:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR7+IaOiYuP8Vpr2jMqnRdijLPaY+VC4S5y2CFvRqO5McEz7a45rhHMP9o+DyRLeEnnhFgoJOCUAdcULKfL27KGcUFvEFH4j84Z/FmSi3UoQV8DXpWu+gCOpxWNfeBTU6DGftlEcvamyoKZhBDQhWwsLHgqMNPvPBHcDBwJXX93jt9NKqVLqWoq1zOUY0rKGLlQzgsQGhHn3aBxcH5POj03whqSkLNhK1MPR/6M7jV6IwB2KNd4h/1KcaHyRpomjZ9bC9NjU7ejFvOPql9WiZrJDdjtegh2mRjoJevzugQ9GCdHuL6md+OJEL+RiuU4WWF7bLvWd7dSqAPR6P7NxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci0ndf52P4BEQ0sD6SGhuva7apNkvTu+zhsF72HxdUo=;
 b=k/N2aPlABcys+VnVO3MZk9der+/3XSh1xGtDqaNwbQF9kl9syUUoywSkUtSV2/pSWCn0hH7Wr6MndT98r+dI+2b2uHnpKXgjrenaUEnq1Q7uNRiDFs/RSzVR8eFMsOJpedwpsw08XFsFK6GmPTUW67YNkg9jNr8CCaCPWO5FHDCMRLTWWlQf1yy78wCfFlLTonKg+XFOaC1BYrGHzGAkgCzDuOLodbK1OmfRKdBC8/v3WgufVw8wUE9HBrvMBIbFCc4JFxX4nH5PfKW/2TbXxBXOOmEU+Uo3VDGruWEhDKR2bLNItIOixBFwjRgwms6EWzWfIhOcaVXMNtfj88vHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci0ndf52P4BEQ0sD6SGhuva7apNkvTu+zhsF72HxdUo=;
 b=l2uFNZFRoRx9KGjXeUD61D9Xhf5Mu5eC34QH+uvIhSMIDklncyjmMZiU4keItZ4qHNrHf+Gdhtqk1A+acdaH/SJLpRqm2muX1Dd15AoEXm+zMJDKaEnVGD7ywBX6mOI7a1nFfZpm4F8DTUyKqdVAxQKdOJZm76uTc8s9oZD23JY=
Received: from DM5PR15CA0068.namprd15.prod.outlook.com (2603:10b6:3:ae::30) by
 SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.26; Tue, 20 Jul 2021 03:33:49 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::c0) by DM5PR15CA0068.outlook.office365.com
 (2603:10b6:3:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 03:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 03:33:48 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 22:33:45 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Revert "Re-enable 'Guard ASSR with
 internal display flag'"
Date: Tue, 20 Jul 2021 11:33:16 +0800
Message-ID: <20210720033317.686726-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720033317.686726-1-stylon.wang@amd.com>
References: <20210720033317.686726-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae8f72f8-5ca7-4d14-4eb9-08d94b2f2feb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2495:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2495B2B36205F310BE78A2B0FFE29@SN1PR12MB2495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XtwtZ8DhGmjH9y8vRTQHqJM0k3CeMC2LX8dEIlOWPrvEhwrCvruIniKI0u0OwhTb3CbUq+NQzuEheDNvPIWCHvb3H9mb835pxi7vg/X6iyq1wwWQjHNZ+phWpd1gz12J9o08wy5DdrQFnawRk7nk6AYIWbtntfZYLmKqy0lcPg9Ejftwz4zqjECYFfr8t4SU4SguVJcQSURgaINGhKEtwLDAfb+Mhk+iVbHR/CGqCQGK3g5TaimKcMIB7zSKSPkKDbtITTO1DpWitAK5BqUzlCfFJtHnEAyYQHEYWEvszRG/JYGId7VAVFJW6YAeVc9uoByGpy41dYNMOHfJ/Hr4kOxPqTm5v8yaWRhV9J5DBhKYDE0JtJxCvSIfLtj68+5lHsxT8nSDwl5SuQt+KqphPwLM/qnxq8TXY0ZmfC9oisdof5RXcCHxRwFXMg3SNdcM3vFfUv/e8vcYSi+6yGIdMh3zuWTdjSrr9MhxDHJ1Au4VkyGL/pcdUS5+8FnuMd3cslvO4kBf83RwcKobYU5nKQfFRmioBgqIZ5TumxTgV0LAiFjFoDpe++v/4kXuzKjB8vkneggfJzacJBvxkcwhj2ENEl4wICr3x0zGY/dv34VE9F0DJFpyR99b+gnfHkr9NEh5nB4KN+VSUWBfvyTLD5QiofHlUfH+RCkSWfjFHZeD7ioIuk4SL5K8Fgzx7xk3FRG1qPj6eWhpPLRNa6uRabIAAgU5xInIAMGblhDEG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(26005)(186003)(16526019)(1076003)(6916009)(81166007)(83380400001)(8676002)(7696005)(8936002)(36756003)(82310400003)(356005)(36860700001)(6666004)(82740400003)(47076005)(2616005)(426003)(86362001)(5660300002)(70586007)(70206006)(478600001)(336012)(54906003)(316002)(4326008)(2906002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 03:33:48.8092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8f72f8-5ca7-4d14-4eb9-08d94b2f2feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2495
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

[Why]
A new change that simplifies the ASSR enabling and guarding is found
that also fixes regression on some embedded panels.

[How]
Revert the ASSR changes in preparation for upcoming patch.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 54 ++++++-------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8b35cd9d4c01..cc62124b0b82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1752,38 +1752,6 @@ enum link_training_result dc_link_dp_perform_link_training(
 	return status;
 }
 
-static enum dp_panel_mode try_enable_assr(struct dc_stream_state *stream)
-{
-	struct dc_link *link = stream->link;
-	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-	struct cp_psp *cp_psp = &stream->ctx->cp_psp;
-#endif
-
-	/* ASSR must be supported on the panel */
-	if (panel_mode == DP_PANEL_MODE_DEFAULT)
-		return panel_mode;
-
-	/* eDP or internal DP only */
-	if (link->connector_signal != SIGNAL_TYPE_EDP &&
-		!(link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
-		 link->is_internal_display))
-		return DP_PANEL_MODE_DEFAULT;
-
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (cp_psp && cp_psp->funcs.enable_assr) {
-		if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
-			/* since eDP implies ASSR on, change panel
-			 * mode to disable ASSR
-			 */
-			panel_mode = DP_PANEL_MODE_DEFAULT;
-		}
-	} else
-		panel_mode = DP_PANEL_MODE_DEFAULT;
-#endif
-	return panel_mode;
-}
-
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern,
@@ -1796,7 +1764,7 @@ bool perform_link_training_with_retries(
 	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	enum dp_panel_mode panel_mode;
+	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 	struct link_encoder *link_enc;
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
 	struct dc_link_settings current_setting = *link_setting;
@@ -1832,11 +1800,23 @@ bool perform_link_training_with_retries(
 			msleep(delay_dp_power_up_in_ms);
 		}
 
-		panel_mode = try_enable_assr(stream);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		if (panel_mode == DP_PANEL_MODE_EDP) {
+			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
+
+			if (cp_psp && cp_psp->funcs.enable_assr) {
+				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
+					/* since eDP implies ASSR on, change panel
+					 * mode to disable ASSR
+					 */
+					panel_mode = DP_PANEL_MODE_DEFAULT;
+				}
+			} else
+				panel_mode = DP_PANEL_MODE_DEFAULT;
+		}
+#endif
+
 		dp_set_panel_mode(link, panel_mode);
-		DC_LOG_DETECTION_DP_CAPS("Link: %d ASSR enabled: %d\n",
-			 link->link_index,
-			 panel_mode != DP_PANEL_MODE_DEFAULT);
 
 		if (link->aux_access_disabled) {
 			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
