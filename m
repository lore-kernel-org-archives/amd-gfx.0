Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80090C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B003D10E57E;
	Wed,  9 Nov 2022 06:16:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5071E10E57E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUiCoN0a6N/pm2JxwqHXjcWYL2qafGeTWwBx6De6LYZxRfL+oZBUDZwGQ+NTAIZ00dAwLpRiuIjGJIWi13wicSao1RGj1XGYG5ooIvX9iI0rm4SUrkJM96PPdb2MoIE5t34TBD/yKdBzvqO/T39S8jqWvCbBOPnFPTNphre/piAURloLiKJpoM8GT+z+OjWVZ5eqH+0QJXMhzPCHw/b9RZEpgCoqqOus6lzCCIXXvTbyPCA4jFBBhDT7k2jSHqYtw9GzNWYQoAKnIwuuKSUPhMZgpwzaP+UDKPTW07xlXKl++UuoyOsycHvl0a2meZsm1+9YsAWdTCUdG6bCvvciGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPjGJ7KrZoPoodKdPStcTht/jRewoKNvmbbIzF8y9q0=;
 b=ktlk+Xz402uZ5CJRu6krtjvQYOQ9QvIpxjaaKkmqIge1WyKotcPe2rbMYoIOas0icqcAZh1OWRq5afSlZbOsrCx8XPGtU6ieG9av469RR2vM5ODdagpoFXi+83jOe813tdVR34tzy6U7cUzhoy+OYxtqiLuO++AqAHutGuaRUF2CUKp9IyIbryPF8oZYXtrc0ilLHruk2OyyeKukY+LPjsxm7sEvBZZEBh5PvjX54bXKWbfs0mA50w/JPbMifZbCfqkxb8PZcDRjskvjYi1V+tUSjBK8UIkAVGf7i/ye7zOvzjHl9CO8aq2Msnr4Krizt6k0nc3kvdrMOxwHZInXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPjGJ7KrZoPoodKdPStcTht/jRewoKNvmbbIzF8y9q0=;
 b=XMb3GxNvPtk9GOQjcuLYJg8MKeSJgLQIjEQg48MJcBc0/5LCHvaD8J0DwyqDUarHfd0n800jcQszJqFPrNhmcQQfVeQ4YX3HlYFsFWYvuLczA27vzku4LIEAt5Jz+Rcz53l2KKBL1HAwvGHd9R/ZPksxx2Q4LS5N6wpI0hQbJk0=
Received: from BN9PR03CA0856.namprd03.prod.outlook.com (2603:10b6:408:13d::21)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:16:42 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::b) by BN9PR03CA0856.outlook.office365.com
 (2603:10b6:408:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:16:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:16:41 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:36 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/29] drm/amd/display: fix unbounded requesting for high
 pixel rate modes on dcn315
Date: Wed, 9 Nov 2022 14:13:07 +0800
Message-ID: <20221109061319.2870943-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0755de88-0a93-4c55-6024-08dac219f846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0fefzMQ4hLzKdTuouY/a3rVEjpCa3wPB8GmfsAOq94gN7wJLSgdtmkceCl4+ScRNWZ4ju3yuLW9179WCuFOj0X7zZA6vgL8Lm49UE83GyhuBNIo777Y4nQAWGuxbnWs/l2YoB4Hig+Y2HaJJxWI9vcU3y5XSRA48s2UmshQcXxAu0NWmkMGkSAymigwX7XHfZIDKRW7ho2OduNZoT1Mb4pXuH23vLdmYgYj/NhpE2qaaIfJTERc6WtINe8sXazivc39GK30P0pHEQODZ+9VhYqQZlV7ss9FlWN2j424WPZFUSmBryt3GCZWclEivpYLzcpqn7qIW7y91hdnWIqJXcBOHK1kW/QfdHNOXzS+bfTFZtiIxz2j9AZg5a2qCtbbMnPoINlGHOMawcFuh0XJCeUUOWB8H9+mWrLf8j+libyMSaPGkq4unUYRNmmfjufuretticY5UuZZuFjTQCYf0mrUkR8/FOzF5nDk09cUjixE94LX3Ls48fSFExBHUHyCuNhVtlU88lpwiQ/FlwueCeJnUSCyFitAr678szYvw0qcrq087Aqk4tqWxQfQCnObKJP+a5ycIUlxbeujelghgVnA9l0xj0pkmJHU2kat0kLBcLpGvZrxK2ILLT7p+znpKM3jtqDx0lLGHn2ZSa+tDm6MmVJ1DyIttSjFHjl2bDdvE7pvVFHjRXhPAlsp8+inLz+0cGz5YpvqmgNsWqpCmzGcc1lXPmwU+nfDgejEwMMd412Jy6Wuuj2CG0NLQT+a/E4ElkwtQMw051+Qzm06roL0yhom/G/mUx0tjwLRJ9E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(426003)(186003)(1076003)(2616005)(336012)(6666004)(82310400005)(36860700001)(83380400001)(26005)(41300700001)(6916009)(2906002)(40460700003)(7696005)(40480700001)(54906003)(478600001)(5660300002)(316002)(4326008)(8936002)(70206006)(8676002)(70586007)(36756003)(86362001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:16:42.1210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0755de88-0a93-4c55-6024-08dac219f846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Unbounded requesting is getting configured for odm mode calculations which
is incorrect. This change checks whether mode requires odm ahead of time.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c    | 5 +++++
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 2a5227330513..2d05e8d843c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1706,7 +1706,9 @@ static int dcn315_populate_dml_pipes_from_context(
 			dc->config.enable_4to1MPC = true;
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 					(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / 4) * DCN3_15_CRB_SEGMENT_SIZE_KB;
-		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+		} else if (!is_dual_plane(pipe->plane_state->format)
+				&& pipe->plane_state->src_rect.width <= 5120
+				&& pipe->stream->timing.pix_clk_100hz < dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)) {
 			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 4cdad8674b8e..12b23bd50e19 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -807,3 +807,8 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	else
 		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31_FPGA);
 }
+
+int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc)
+{
+	return soc->clock_limits[0].dispclk_mhz * 10000.0 / (1.0 + soc->dcn_downspread_percent / 100.0);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index b0b2ba9df57a..687d3522cc33 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -46,6 +46,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc);
 
 int dcn31x_populate_dml_pipes_from_context(struct dc *dc,
 					  struct dc_state *context,
-- 
2.25.1

