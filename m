Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 19:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D8764E8B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 19:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D8764E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58E66E9D6;
	Mon,  8 Feb 2021 19:26:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826296E9D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 19:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP0f6Iu7hG7bd2mvw2/GNrHkxe63qHVvrjFx3IJnfKTFagGpEk0qypM7C/Xr+/owzZ2MPgDhIuroJh8K9tYrYV3UGoWCg6uHf96abZNaSKJgcL+4Op88I8uXeAX1bdvrww9hA9FJJ/ATd3/TuwAGq9+7wIRaq+Jy5bcGglo5R353NkQ7HC7Cn/0sFfKIPFP/76HEwL+2erirbV94pqJ8VscwLCgvcA2AipMEUSwguzG38y1XeZwnuzUFMTV4z5g1VXAWRGlpwZxJP76YMW029rmxGik3UGEnf4vqTRdnKBoQTcnKD+435u7vsKZy2b73uWFEUM6E1eKASj8DstLKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJBuW0iafkJG69lASx9x12aVRZ4jwhxOLVJ/2VjSGpc=;
 b=T2h7LCD4DKTQGAK86LudHkj9MSKn55/7B7/KP6rLcPRBxBEtck7Ed3q3POqLe8lg3es6Q+9NUuLoM8KjZS6k96NwsIr1wIezdgcORjriHpqrupsFOU1GEB349x2AjqrxKRP/9Y3pDFlNLqiMLev2o3gA5JyyhySkN2/y7T47GukpH9By4alkIvjfinkxLjqHdPoKcLWdygHQJSnJtnYZyBkQHfnFPVSwXtoh4SOLUCSzKuoJ72kiR+LIHxRqvozBs7sP+T+jPf+cwtzLo6FgbiGYTtS2fDqAFonn9vjWJNtAPgXlR+Kd4O0EOPlP938JNTiqB0cmG0KqX4D0hptX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJBuW0iafkJG69lASx9x12aVRZ4jwhxOLVJ/2VjSGpc=;
 b=UyEv2D/E6FWekLJwG5A64mBSHvtqykblCI8NdNC5YM9vuW8Yi/cJUg719QcA2uBPPQWKPQhHlKT9qCO2Pi5wXYjfT8ScG6p5oPDKETOFyUzzXJgXhC5JrW2+RSX6KNYMgVry8c6GP7Bon1RcnvwP31fZtEoQ+OPv+HoopNGCp/U=
Received: from DM5PR06CA0092.namprd06.prod.outlook.com (2603:10b6:3:4::30) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19; Mon, 8 Feb 2021 19:26:03 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::21) by DM5PR06CA0092.outlook.office365.com
 (2603:10b6:3:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Mon, 8 Feb 2021 19:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 8 Feb 2021 19:26:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 8 Feb 2021
 13:26:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 8 Feb 2021
 13:26:00 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 8 Feb 2021 13:26:00 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: move edp sink present detection to
 hw init"
Date: Mon, 8 Feb 2021 14:25:31 -0500
Message-ID: <20210208192531.2924743-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d12f39-7216-43e6-c2e0-08d8cc675edf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB250728C423E3430136AC0398EB8F9@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLYby9NvQVOIPGvaUY/bq70XHsJ5M7ElcivwXi/iicRDwk32x9M0+27ogHb2IBgqs/Tjjbip1Ce4t1+A7as2HMHjx0qx1XMd1UwqgJ9ste7/xug6Fj01A4FsMwzHaGC5Q0941P0WXQFZbulu1151lascSibG0CQ30IkuT42DGX3ytJFokTHYCN6ufJYIaMQIsIIZNCHQEdXyfEYtpK4mXD4qdUz8tjLNoOC23BzGZBFOyttjZ6G8nupFUxpGz4V9XFrkuHGw1tWCYQnUgTvjjatYes9TVPfQdTGVMmSOszPXvVDnlWat1XShNblufVC88P1H5UjjtZ6IJWaq9pwdhjUvZFQOqmSt7PxezVOjRqZyaaCfyaBQ7IU4t5kHficXI8dDYAodI60PC9TwuH2a5b/u2PF7qxLFB1gVsFnxyzICStnAKIc2vExPAQiIoAqJCw1z5+TGex6mhl+cIOxcLLtwcJKXul0QPzbjOifb4EHExs3jBscSl9EBnY/FhMbQnZN0bT95PDrvhR9ENBCzEK8t8Oz2Nkb/1uSIU3iY9+QViXkJll/9UIi13eb0ImeQyNqt0rXOCY58Fg/QxG5q6KbGUeOVYDYMhuQdfF9qcQLJj2+3jzTzjBC9qMqBo3vnJ48OHFRX1bZKwibSfjTz/sdPQsD5Wjg3ezPCcoA5o+7VVun0kyKfcpiShaldpSKz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(36756003)(316002)(26005)(478600001)(4326008)(7696005)(82310400003)(70206006)(82740400003)(36860700001)(6666004)(83380400001)(8936002)(6916009)(5660300002)(356005)(81166007)(54906003)(1076003)(2616005)(8676002)(70586007)(186003)(47076005)(336012)(2906002)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 19:26:01.7346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d12f39-7216-43e6-c2e0-08d8cc675edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit de6571ecbb88643fa4bb4172e65c12795a2f3124.

Patch causes regression in resume time.
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 40 +++++++++++-------------
 drivers/gpu/drm/amd/display/dc/dc_link.h |  2 --
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c9aede2f783d..8d5378f53243 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -205,9 +205,27 @@ static bool create_links(
 		link = link_create(&link_init_params);
 
 		if (link) {
+			bool should_destory_link = false;
+
+			if (link->connector_signal == SIGNAL_TYPE_EDP) {
+				if (dc->config.edp_not_connected) {
+					if (!IS_DIAG_DC(dc->ctx->dce_environment))
+						should_destory_link = true;
+				} else {
+					enum dc_connection_type type;
+					dc_link_detect_sink(link, &type);
+					if (type == dc_connection_none)
+						should_destory_link = true;
+				}
+			}
+
+			if (dc->config.force_enum_edp || !should_destory_link) {
 				dc->links[dc->link_count] = link;
 				link->dc = dc;
 				++dc->link_count;
+			} else {
+				link_destroy(&link);
+			}
 		}
 	}
 
@@ -998,30 +1016,8 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 	return NULL;
 }
 
-static void detect_edp_presence(struct dc *dc)
-{
-	struct dc_link *edp_link = get_edp_link(dc);
-	bool edp_sink_present = true;
-
-	if (!edp_link)
-		return;
-
-	if (dc->config.edp_not_connected) {
-			edp_sink_present = false;
-	} else {
-		enum dc_connection_type type;
-		dc_link_detect_sink(edp_link, &type);
-		if (type == dc_connection_none)
-			edp_sink_present = false;
-	}
-
-	edp_link->edp_sink_present = edp_sink_present;
-}
-
 void dc_hardware_init(struct dc *dc)
 {
-
-	detect_edp_presence(dc);
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW)
 		dc->hwss.init_hw(dc);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e189f16bc026..d5d8f0ad9233 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -103,8 +103,6 @@ struct dc_link {
 	bool lttpr_non_transparent_mode;
 	bool is_internal_display;
 
-	bool edp_sink_present;
-
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
 	 */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
