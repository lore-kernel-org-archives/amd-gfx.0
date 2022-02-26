Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F07C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2C110E28C;
	Sat, 26 Feb 2022 15:41:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E91010E28C
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpTKs5u7oX7aCTGfvzLiNqCGyge6V2MNEwxwkzvTiniy56BXPwyVJvgYWA/Bm4j+wpLu7ygVeinH/zYcVt2wSdrWqZMX0hRRHz7lbm/JwUh7rbRDS0CunNFqsp/AFWLvrP2CcCdm3RCKW6h1wgmLvdX5wq+XplxjPgErgHMEMy4K8GQxgcr9Sy52oI03yTvB8Oz/d20TZ6HcP+HWF5YK6Aj5Gp/63C00kp+YPaVuWnLpeOi+rtd7R7Xhc349S47jA0k51vZemKKc9oPYm8Wec5vOmISmAi9GR5I+nybatV0zCkh64wSIAtsu80tZn/uLxve03h0xMfed4jlbKRqWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7oTWnVC4xp2xKg6Cm2ATdy2PAYdn8eE3CywjOLLrOc=;
 b=Zf1mQ0kthIc58B1I6l9mSkb2kwUbW7EKomUSV4k1abCKfzNeilIPg2z6NxXbX/liQjE6lENceifIQvv6Hj0yPxV2oUP2kKNLma2NCircS2eoy4bO1HSzF+QWb1dg/uaYbgfmlPZycX88uoh6JxFxWHrWr6gbtopuGwDm66p2a+8oKXeb/80+S+OVTJQvyUZgLdx/YuSfTR9qriNa7WCc8jM3XKWvVXbGQNIf9by0PYRmFoi4Gh0CUwUWljIEgDxMTyYn/WITWy9egKxjKiWvW1l2bH23uiRueCadO17pZbiPgQSATN5g8dNpP6zrdyDM2ovhr4M9Lc5G2fxfxJahpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7oTWnVC4xp2xKg6Cm2ATdy2PAYdn8eE3CywjOLLrOc=;
 b=2w9G1rdu1H9lxxqDN3+YklWDrfw9Yx1E48f8J05e2VaXbsEDsEMaoTiI8lfV6y7m/EExVZteqIF2QVdaLub5z82erPKxAMJWWWhr+7egugEc/rYyX+ZYQVoVC80ZSUZ1irL99WHOjAioOO1TWqP63k6FvZZk4/yUGaPei7juJuE=
Received: from DM5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:3:13d::12)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Sat, 26 Feb
 2022 15:41:36 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::bf) by DM5PR20CA0026.outlook.office365.com
 (2603:10b6:3:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Sat, 26 Feb 2022 15:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:41:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:34 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:30 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Make functional resource functions
 non-static
Date: Sun, 27 Feb 2022 07:41:05 +0800
Message-ID: <20220226234117.3328151-3-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02718f88-186f-445f-4629-08d9f93e788f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50743D9802A512B6A9F08C49F53F9@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ISKk1SQXAF8FLtwX6DzQ/iGTj3nn9ZM9X2rI5SiSO230J7FyvlKptcMEz74rszFBu3EVSQH7mf2LJGtm+7RUUGpl6D3UxHnUELkipS5WEDyPDtt5JoVNNnupsUhm/iBBj9pbVFATQ47adS0Sy6F0ijTR+dpV2BBS9Qvp2Y1g/7d8IZMTei14zx+bYjUSQtaXNdI+6CXr4pzchJDkDBvjm0advtrq4EbD+IORCgcDHBIwJmWzo8g0lUKfdYWg+EdBC0SM8QZro287X6oaNcSYlqoqhB3Eykb6mM39WnwT31oK9UPXkzh2t5ERiHMqzRJTdTisYOxdBPWTXtiYN5OD+V+qs4qLbtOK31xiNhvO59+TOnWNCIUHkjUnCvBJ2R7KaTkeDhH1fJUYJxWdci/2Sjb4kQFKJlxtsIoSVvT4W91b1/pfAi/sJ1M11vPjvcbyPYYMAYsAwW2TO+Yc8mF1uljfIzaO0DgRC6mGsJt8qy/46MdfMIpUJObAVdlraINOA6y1xnOwp/WIpTn+8eKRUMFDyQJSdJEa3Gu3FyFqkvQ5HGSM5qE2LI0os67RCMAKsWceYcXzJnl+6f0Rmf/kjrf1AVOXyZ693fxWNhdVZ5WNCkQ6QHlfIKyCC7kSpGvhWAe1JP8gPQBormrn6L92/XUPl2Rmoe/6XsBeeD1HoycK1CcT4aiWz1G12NYtH+J59i5Wm5X12HQ40SgAydEiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(70206006)(2906002)(40460700003)(6666004)(336012)(186003)(82310400004)(426003)(8936002)(1076003)(2616005)(26005)(83380400001)(70586007)(508600001)(7696005)(54906003)(5660300002)(6916009)(356005)(316002)(81166007)(36860700001)(4326008)(47076005)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:41:35.4642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02718f88-186f-445f-4629-08d9f93e788f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
To align coding style for how we use this across DCN. The resource
creation ones can remain static, however.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 660e96a7fe7f..28cd4f82529e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1777,7 +1777,7 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
-static int dcn31_populate_dml_pipes_from_context(
+int dcn31_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
 	bool fast_validate)
@@ -2068,7 +2068,7 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
-static void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
index a513363b3326..4b7ab21ea15b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
@@ -43,6 +43,11 @@ void dcn31_calculate_wm_and_dlg(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
 		int vlevel);
+int dcn31_populate_dml_pipes_from_context(
+	struct dc *dc, struct dc_state *context,
+	display_e2e_pipe_params_st *pipes,
+	bool fast_validate);
+void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
 
 struct resource_pool *dcn31_create_resource_pool(
-- 
2.25.1

