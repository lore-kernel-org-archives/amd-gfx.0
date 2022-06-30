Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C008ECCA483
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B7F12A6A4;
	Thu, 30 Jun 2022 19:14:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A1711369A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlIk9R/taWJX30I7jvw+RYgM2rNakNeyp6FdSb+B2LewejUuzDXRKXhFb6vUVN6DuJWID/bhcQ0qIXnOEWSPE3ltZOzgLlpTXfoifrdbbw1u/QdGmvaqEfEOiKLL/0ygm1DCAJ9idhqO46MMDIaAxbM+SrsDTAcaoocTKcddtbDXxrELzwgJ9ma7xvnXEJFuA96AhPt7uG0xMiKt2qxrGEjdwzcgfbfFeVyJB7piQAuiFGaH4Wlnc2Xw/Nh0fXvgMFQSU5Ja9VnvnDcjD1k3PVpkzPTsK5CjJwy5/Ugn38Ezx+iO1gbNpk0vPQZDQ50yieuNzxG+8fP5cj/vyDKbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypEmSoa3ynnfM2+uA7SKJ/kd8UHe9J00wSpwJyP18Tc=;
 b=Lt6mQEWZL9z+Fe5682pKNfHFj7Kz7jlAkKVJVoQKJ6Baou1JDhNjpD4IL4pbPefFNtngzE0sv11NwEL7vHxx9EAmw3nklWXDVX3w0S5c6C8yLd+Xlpd7m67elAtRpuebMwO5hgLP//hF/EqF8oot3h1lo+60eqQUzmtNVzmwJ0xRtTuztOt6F8auIK4P0WBjN0q01TudIeV1pzhrjgI2lQyl0iWX6PfqEC/lL6AHDraKuCfjqqTdUIjrlbeqCAgwwqED76HAoSdY9ah1YVMoOknTSiSFhrxA/pKPFruvdDLmehb8MShhV6Nu4QXFPFNLiMo+YaJbWM1MqhHrfaRKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypEmSoa3ynnfM2+uA7SKJ/kd8UHe9J00wSpwJyP18Tc=;
 b=HPtDJ7U++8zNgLa0jVX4dQPdN6LLYBvhtg4pI8/7ed7JIGvQMqzqQNCIrfsv7EslF5DcfiawS5GPuW/KWcK8+h74hk9Tz7Wfw/Wt1rpbIWwKQMpKjDoy1UUsptuo87a/H0JZIpD/n0bnRhcnjRaVrAoJXs269hIXibgAm0if3Fo=
Received: from BN0PR04CA0180.namprd04.prod.outlook.com (2603:10b6:408:eb::35)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:09 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::1) by BN0PR04CA0180.outlook.office365.com
 (2603:10b6:408:eb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:09 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:07 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/40] drm/amd/display: add an option to skip wait for HPD
 when powering on eDP panel
Date: Thu, 30 Jun 2022 15:13:02 -0400
Message-ID: <20220630191322.909650-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afbc668e-0f6e-4939-dc7a-08da5accb5b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZygKvCwxmg7IFvoij1UiYV4pZ6ocEnp/2/88exX/i7atNzG3xlXx9trKxtfim9qtBZuqTiBZSG8tdK10jWUrxMunKwrqkoh63C6/L+0uMuruAxQDtOFi09d17NoJ+PXtWLdrksWTCaLhq3WRZ0CvS/EXtEFBG+ADa1SZ/WFk0TMpeUve5Gz/0KPhoCCcXdwmx/nJYV0FU0D5ZHKVmbPdULoYbV4nDOhHHnDLnPdtUgURdV915ppMD1ZmqeO325NKzuHhtqjBtm24cknJrZEC33dGIzjMmUMukk4xnbe5U1Jas/pVnIK7cp55HIkEDNo8nEzIOWZYGUuv73y2Q62l1K0X2/Qv2VWHfD+Wf3EGJ8nj1V7he9ZbZRjr+6CZMQIfYOhLKpVWSN5rzYBPxcllAY9G/b4UQdNCkGlzVr8hib4VGuMB6wD03pzsQ8Moioa7vf7duOHdnFFBFYAO36TESHcf3TUdiAawrwRiEsE9n2uZux6B5pcq1kWIQEoSXNJy1FloGFH7bwrgWQrcjDW+OFX4onGdukIaOAQYHbNUy0eex/btd2g3oYbOOXxEld+rQ2gxGkFUVwD6UxI1xm/zLza8LJBR7p3r0BT74NbBKTH98uND9+2QFjZhn9qUPpV1Wa3L/Hj1WL1gJ6uScpBL52hHWlnjSqVjh3n74X5gBe+RZkaz5gIhV576Jh+wWgF//C9TWl6vbcnDXNHIZpOPnnI0PL14mCNCk1SbHJmulka5MgmDGhOQ+rITetErb67jP6bRqKp0gFrTPTFzWymbPJOyqEQK9mcBRe99o0jnQha8fylQkue2v3jKkcxMIbmZRzK6jSdvYZm0Agaas9d/ksd+UfFthD5MGDxLgAMehPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(6916009)(6666004)(2616005)(41300700001)(36756003)(82310400005)(8936002)(1076003)(356005)(54906003)(7696005)(40460700003)(316002)(4326008)(336012)(5660300002)(186003)(8676002)(26005)(83380400001)(82740400003)(426003)(2906002)(70586007)(70206006)(478600001)(47076005)(81166007)(36860700001)(86362001)(40480700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:09.3816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbc668e-0f6e-4939-dc7a-08da5accb5b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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
Cc: stylon.wang@amd.com, Jayendran Ramani <Jayendran.Ramani@amd.com>,
 Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

[HOW/WHY]
Add an option to skip edp_wait_for_hpd_ready when necessary

Reviewed-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h  | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1982ec0b55d4..e0660e7356c9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6971,13 +6971,14 @@ bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 			dc_is_dp_signal(pipe_ctx->stream->signal));
 }
 
-void edp_panel_backlight_power_on(struct dc_link *link)
+void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd)
 {
 	if (link->connector_signal != SIGNAL_TYPE_EDP)
 		return;
 
 	link->dc->hwss.edp_power_control(link, true);
-	link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+	if (wait_for_hpd)
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	if (link->dc->hwss.edp_backlight_control)
 		link->dc->hwss.edp_backlight_control(link, true);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 44f167d2584f..aaa17d4dd46b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -193,6 +193,7 @@ enum dc_status dpcd_configure_lttpr_mode(
 		struct link_training_settings *lt_settings);
 
 enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
+bool dp_retrieve_lttpr_cap(struct dc_link *link);
 bool dpcd_write_128b_132b_sst_payload_allocation_table(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
@@ -214,11 +215,10 @@ void enable_dp_hpo_output(struct dc_link *link,
 void disable_dp_hpo_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
+
 void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
-
-bool dp_retrieve_lttpr_cap(struct dc_link *link);
-void edp_panel_backlight_power_on(struct dc_link *link);
+void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 void dp_receiver_power_ctrl(struct dc_link *link, bool on);
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
 void dp_enable_link_phy(
-- 
2.25.1

