Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCCECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AEA10E804;
	Wed, 14 Sep 2022 03:50:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8D910E804
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBstvQTr5gf79po7p8vu7Ht/r7dFLJadrVdHa3MvQk2T/JKut5gn2bID2THc3PqI1MQwKrqyMe6GJTEnZEZOqshqIAWm85LxlGdZqQhnIpEkVeWcMm1Xqz7qjeGUPdzSokYJP/7v3h0kzbUcL7ae3KFCDlefI05SzVOlfk7A1hyKRbnJLKXF59bdDvHkbDszkzety+Z/97X/EoexvqJXp0Iiarm6ifNvZ75e/RFAivG0jqN9+ejRpS300JrvhJanMSrQzXQlrnKZWaZRqqmTTdyB+0d/0O1wa06VYPRue7m13lbO7a3t/SkAB3xRuD3k2qHLp5SJ+LYTeAfYAmX9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ustIEJ7rt1h/Jxej59DLgAVxmJN1egO9c6HGTnDG204=;
 b=LI1jv4942GyR08dO9q+CQGKcusRbPTc1sgXCAftRbAFVpAlChg0bGutVNFdUhHyiRDFx7D6QElPZwbFc+aOAME5hc8mrVrd4NdeowrgluqHmyp+GQVb0ofIz28WplsiPSgQpX08vkvh1csA+UF/D7GplQ/2BYygdLaa7Fez+umumzGtbtWXtJgPrHEDzECvV0kQySQ6y4dB5EFiuI3R9BCVDvjCLVy4bvfx9yeJodx+vIrTcNN9MMaUm9u4Hi4DNhxXmjM1sz7WBBzi4Kt5T6dsI+/s+fMw5UljUPSfZTrv728V2K+9Q+CSG8Z91tuKv0thBqfpf5szooYTpsZnZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ustIEJ7rt1h/Jxej59DLgAVxmJN1egO9c6HGTnDG204=;
 b=J6ccoQC1L5LWZ340BgBDkaO1UWGit6KOKV5Je1XwG3sMOFMhD45Eh7dNA0RXiyTfknXiMV1oVjx4aB3ZJYtwJt6TGibkr98ZY5o4rBeiQcGj82xX4rw+0rPLmfdpIt5E5IYyIYtRQljwbrirSVGH+hNdCin0BOFw+CDyNGr5LNo=
Received: from BN9PR03CA0927.namprd03.prod.outlook.com (2603:10b6:408:107::32)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:50:51 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::ed) by BN9PR03CA0927.outlook.office365.com
 (2603:10b6:408:107::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:50:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:50:41 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:50:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 12/47] drm/amd/display: For ODM seamless transition require
 AUTO mode
Date: Wed, 14 Sep 2022 11:47:33 +0800
Message-ID: <20220914034808.1093521-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d44267-3f91-4bc7-6987-08da96045104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnKpWNOeu8QcCPnPwDIFUIqfKi3SqaqqwuTQkqnnj7BH2ETsJxK1D6NmaZfbz8VCkyxuAZxQbewWKX8AcNImyEhtnP+Cugyaq+Ti/iL4FKUPq5hDT9ACTe4lb0yKn4cmMw0lA5d0oVaD4y668egslEJtPnaElHNRCtBouOR4r+k8xb8BTyj0LZgHYc9smF+2CyrFLrpTZ0lBV5TH88ZTNkVoZ2W4uHnQo4RYdBGz64T8NL2jZ/3H/ml8YBTCaUum/fTAFGnaivPOOXbnHVPBadOhwA/vZuBhsVAPa3oZnAL48Wxh/atrq0t0q/eSJvNShgn/AQ+9YFlmav3xVb25Ngi1OrwqN8tr23y2QMIye19ibyKktdNFWRMt2lYCwChOewhAnUW5vsIN13u24VI+DQU4VUizkkDUtHPtEWBerviFbaDZ+33+S4dkML6poNxQ4ODGEJBeelJEk6xgknAGKhgrwIuXy1Gw5bN13XH7DoBaZn7csk8OqFjgXOfWx+KwVZNNSXgXTq7pTYso9jlxHdNCa4IrT5u7kvizGsTvI935cTd26N492Afbwl2/6Oi7MYQbhlOneOD29emCog+IQ4vBYZQMQSORilE/NGln03GFKpW9mFuzKZlP19PE/ETfLQ1V3aRFRFV4kwmQXyrJvtkFBPgxdAxFzTc/lxYW3ccxdh9f2SJQVy2AwttHtNtfkFyLWEMTYDB4V4Sbz+XpSLsNu9dumpSZlXUkA9plwaQgzUiZzqGhjkqS+gsD8lOE+EdtjoZtoGeN/R6vAJ8dSv+wg1qc/cXVCqPeuAO4kNrMRLwCkfXfbflMQuLN+UKW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(6916009)(316002)(82310400005)(41300700001)(54906003)(36756003)(70586007)(26005)(70206006)(336012)(2616005)(40480700001)(426003)(8936002)(6666004)(186003)(40460700003)(356005)(478600001)(4326008)(86362001)(5660300002)(82740400003)(8676002)(1076003)(47076005)(2906002)(83380400001)(81166007)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:50:50.9000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d44267-3f91-4bc7-6987-08da96045104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
ODM seamless transitions require DIV_MODE_AUTO. However,
DIV_MODE_AUTO only works when all the horizontal timing params
are divisible by the ODM combine factor. Therefore, disable the
ODM 2:1 policy when the horizontal timing params are not divisible
by 2.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 22 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 29f27e3fe3ac..5bedee56acd4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3645,3 +3645,25 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 	else
 		return get_virtual_link_hwss();
 }
+
+bool is_h_timing_divisible_by_2(struct dc_stream_state *stream)
+{
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (stream) {
+		h_blank_start = stream->timing.h_total - stream->timing.h_front_porch;
+		h_blank_end = h_blank_start - stream->timing.h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (stream->timing.h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(stream->timing.h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 6bc0fe922599..d757d1638fa7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1871,7 +1871,8 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal)) {
+		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
+				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream)) {
 			if (dc->debug.enable_single_display_2to1_odm_policy) {
 				if (!((plane_count > 2) && pipe->top_pipe))
 					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 58158764adc0..a58f80ac94ba 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -224,4 +224,6 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
 const struct link_hwss *get_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res);
 
+bool is_h_timing_divisible_by_2(struct dc_stream_state *stream);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.37.3

