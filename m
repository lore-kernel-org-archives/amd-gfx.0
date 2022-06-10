Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23F4C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F892113FD2;
	Fri, 10 Jun 2022 20:53:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47B4113FCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7bSy7Bb20b/SYtzMY8Vmxx9x2ZJjEoqYsCN9ThzpXDXPiTQyesBu9J+zYlibXvE3Q1JRRTxPTdzXBRjoJUn2c4sJzU7O1luMmbxiH4milSrD2mxjrZACBZdXMt3OT6JdiJO6my9CNW7w+yfopOskGpFw82nC5f/DwcjUDM7fs2xx1V08lNG4SuWMKXQUiEP+Z5BiZFbEjLzDnQ1vNCSDWRq4Bi67R2voivVHFvWiJfuoHcxDuhvntZh5WRD0sVs/cm3mSaBKe81nLQO9+fNleN9D/FZlkbWpj684eqPWWde+1OM599tyY2hp0Vl+f44qL/SllHYTnwql7FHUdisZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqOIkvx1BEVyae7EmEcJxiKnVIh65LpY1UJkEL7+EyM=;
 b=lWcmM6ZhO/8MsVthptb21xn8A/dB3u2X/NsO0x/jNiXh5Va19RuGyaj9Y3MCad/7kKstdK5HRCUzjEMSMCLeUxaqDiKokC2s8icGZYyL4U5E+G9OI+rSmByTtdbom8fuSNXLgWkOe3Z+BO5H5NZkDbN2yxl+azwmuXi+geXL8hvDjhCPPz6F74AtlvUOl3OLXi7fD8R3Hu8UHJYO1m85oQMH/lwnH2v76dxPH30Q/CLjA7AhQtMNVo6RMjzZgVHkt/ysXx+alWLZp3dvCjRs1nsGWvSxBAQWc/BEkPPwUuKAiNfCaCm1GeOmSvuVze8HmHd9Ed9D/Z2nWi0yy8CLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqOIkvx1BEVyae7EmEcJxiKnVIh65LpY1UJkEL7+EyM=;
 b=K6E2BCBbHXCbq9ZzYGSPoNmL/qKzlWnwnP4nDEq4j3Mqm5BNnN9uhAAgR1V49Rasxr2FrlE6kBcyd5yyAyu4SFHzh4mHizSFghyEjNUAHavyxZF9lAXtuQ7nI8XSRfdYHK3w4RypycTCpUt0vqWZpXoElCRMA9ZfH/qgDjWdRfA=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 20:53:18 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::6e) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:17 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:14 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/23] drm/amd/display: Add debug option for exiting idle
 optimizations on cursor updates
Date: Fri, 10 Jun 2022 16:52:31 -0400
Message-ID: <20220610205245.174802-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea6bb2c-d100-484c-7893-08da4b233eb7
X-MS-TrafficTypeDiagnostic: MN0PR12MB6344:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB634453607D1C7E3FF3224283F4A69@MN0PR12MB6344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXH135fy/oPocOE2aaKEqIsx0laNPagKpxwIu2x4JYALL80CqUv1H2Run0y2KUGbyd6ZvqM1Z+wZ3v6syBfDDQwfvaimfwLru8paxLe+4P8yilXZtt0FW30k3sqLvQVdYM8haIsVYQT3rr+U8wtHnUvwvZGlg3AiJwNtdNyOqPIA8C3O2OjbrIeVVf2e8dkLvfURVsHS0LuvYZ5Oskjk+szxd3e/Sn4UPmngj4mSZm2AGDHqN8njXpTIrmv8MMO7zP4gTbqLNaCLyKayigYrnKe4qPRbQLxQTMX8aeAXeRUJbX0Vq7ZW4WIfXG4LqbsGPEJMhfRqckBYd5WX/ONEEeG8Ho8SwwS8irZlWUWUOs4/lNDExdQJsln8RZ3RDah13Bk+qAYt2DEAfb6+nVZ4zTM+Ja/LEO1LzqSM8zdmR5GHPDDj4xnSmcesxPdQoJ/QIjbY3BX1QLMvR6kuQquOJW5Qtod9nT1YtbYCdEzKJVlZ/b/HSpomJRaOlvaQEHiLOIMPJm9hU4HvOU50IaSs46sV9vWdp8JtdwlnN4zGB3TOmbw7Wpzmjs8ZtNRsFuf1BH9S1NnE8zehDJKR6Y5nmv2dXDaa6Tgc/gP53JHgjOE2PzAgOHnVXzTuX279dcADwWSiPqAiCllbRgFnkjqQcxa5S+cnACG1nWTyApEZxDAnMruvHcpwFykNMc86ke2g3nwOUvSRfqkch2CCdef9rjdNwql/soqkNsUT3sUGrDJZHTN73rIqYMGzDSsgfPTU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(2906002)(44832011)(1076003)(7696005)(86362001)(15650500001)(4326008)(26005)(8676002)(83380400001)(426003)(336012)(47076005)(16526019)(186003)(54906003)(5660300002)(36756003)(70206006)(70586007)(82310400005)(6916009)(81166007)(6666004)(8936002)(316002)(2616005)(40460700003)(356005)(508600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:17.2621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea6bb2c-d100-484c-7893-08da4b233eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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
 Samson Tam <Samson.Tam@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
- Have option to exit idle opt on cursor updates
for debug and optimizations purposes

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/dc.h             | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index de8b214132a2..167bb3310877 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -389,7 +389,7 @@ bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position)
 {
-	struct dc  *dc;
+	struct dc  *dc = stream->ctx->dc;
 	bool reset_idle_optimizations = false;
 
 	if (NULL == stream) {
@@ -406,7 +406,8 @@ bool dc_stream_set_cursor_position(
 	dc_z10_restore(dc);
 
 	/* disable idle optimizations if enabling cursor */
-	if (dc->idle_optimizations_allowed && !stream->cursor_position.enable && position->enable) {
+	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
+			&& position->enable) {
 		dc_allow_idle_optimizations(dc, false);
 		reset_idle_optimizations = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 76db013aac6e..7191fc48c2e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -748,6 +748,7 @@ struct dc_debug_options {
 	uint8_t psr_power_use_phy_fsm;
 	enum dml_hostvm_override_opts dml_hostvm_override;
 	bool use_legacy_soc_bb_mechanism;
+	bool exit_idle_opt_for_cursor_updates;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
-- 
2.36.1

