Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3088DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5FD12A736;
	Thu, 30 Jun 2022 19:14:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8583912A699
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGBYzgUSX62i7ry08Xq0mZUM1AOOHz9cR1SxWmRXjxL/GMZvhr4LsdaJE0386dxSF3t9nYsGMZj8H1uujzC4snZCpAy3ddylUeWoS95X3M/cyFVgsAEKJn210DjUHw5HPwVAGfHYHl1mr5Q786R6ipQyxyB35JILdgIkzwAk/i858dECHAjYvoOOYk16cbpWtusYKO/7jc5TNHTSmPAoOKwCHbNdP2YAfHewUg/h63ux0gAzkQMnG7dpv5bV3Du54b1Vx8pS7WIW/LM932xE2zOaCEV4jhVmwfus6qOvm6q32uBS0BL0iUjiEzJv+YvQ7h13/uSD6z0wslXOU+IWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/2c6VMs74Jao7IkxREZuXRNE6jY3ozRNnFxupZ9lo4=;
 b=nN3nU5qgLnNK8xzfilBSZBoJAdVqmw72vqyXS6LlqR5WqjbtqxP0s+TWeZqMi8RX+FlnY7OR8NxGAIekwp+cGtw+qTux8CVbzEQ3CVcP0TfXTHlrOy7koGHRnvzohWUYo3xVp/skMM87ad8LHz2PIboCF3uIJ6qCeok0u1NJWzW1+Q9U/bXuh0zROAipEqMKR5nl1M+JUJtvsLYQ/2WtBvNvX587DpYqRmo5+lkk04kq3rZ6jbUOhWnDgwu43BqpOQepKKrhU85ueR3OQ6jXKwQ8SM85fTRHfIMFvPTkx1p9lyMMqepgBzXH5qXhSscc6wV4G/lK2QMZEZPVTdntXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/2c6VMs74Jao7IkxREZuXRNE6jY3ozRNnFxupZ9lo4=;
 b=G6BiT5ohDbA67+YwT6Nge+NwDchhWdljsl2IuTNJ8hq2x9QHC5lZGmdFY6tckQNBWmZs0soPO6MLIvzd1lBzta85B/uMUjkdIoWX8brdpD1Tpsbs4TJKAkTXpK0DXRtV+fuoMxBPhVEVH7uH5ZZY6Laq4qiMP9d0Juwv2xuNX8Q=
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by DM5PR12MB2405.namprd12.prod.outlook.com (2603:10b6:4:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:21 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::6d) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:20 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/40] drm/amd/display: Add flag to modify MST delay
Date: Thu, 30 Jun 2022 15:13:13 -0400
Message-ID: <20220630191322.909650-32-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0abbe784-ddd7-4851-5fa8-08da5accbc66
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUDFubWqY1OZhZoWFREs92o6uz7vUSeZCFt6zkS3Um8WUfyqu5nwOULZJQcC3ng3F61L0HJ8PLtN7VL7WLQGiMdIZvmQJ1zrY26ehoro1b6JtYOGaHuDYA6E2kucjjhnYLZXsn/RWRdECV0vIbPAD9x9YNBKECYle5A9CZ0bDWQ2AJZXl7JXM72X7DswoJx83P8uuWbW4YWZYzLEmbLRrasObaczTVIZwZo1fqXmdJzz/ut25GBgFoXpvHvnL5pEuKdLGvR6P93sTZ8d1tfnj6wZNN058xXvh08KGmT2GcZ0SAwdjuNre5zsUb4TmWUTytsPSLey7Y8QIqTDIGp17StyS/gWgfGNYppPqJSmKSWVD3cS9YlY88BNY6e5v2eD+A5F52jPV0YOW+64uJn2DqXeVUoplHe+VEDG2Vkt74H8NJP2rudk8jozLfjxVyzRHUdZb7GmE2XxapWeVLKo9TUL51z7MSzFrB6NSONWJfQc98TF8wvWRIZIPI3lSBBsLuayveV81XR2Vv1gR+O4lQj+kn0Na68ncYPgBlzdblLZd1rUlQ4c8/7Yx2XZ+ao27yqR1SXMZIJh3CQaR3BH9A5M3l4CPKYReDD+FWVZbXOvnQStSo/skY45x6DJ65dWEdcSgC5cBxGgiNN9AePhvd0UlY8SFH3HD2M8et+I507NZEpYNczv0XljLjSChkLZAZRWnkXBpzupPoOfzzShqOl6gW/1wK56to43yu5ajj6fqcr+o2FP6+9Lrk8QV7gboCMqcWtp/+1ykwTjwgS3POB7VQsuZcRrMcEQ07QW+4EyG5/eoR1iWfNFv+FG/hiDejPmq/ZAGTkAUWK6hOtbTW4JcXzNjzr+3va3rJtegmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(40470700004)(36840700001)(186003)(426003)(1076003)(81166007)(47076005)(6666004)(41300700001)(7696005)(16526019)(26005)(2616005)(36860700001)(336012)(82740400003)(83380400001)(356005)(82310400005)(5660300002)(6916009)(2906002)(40460700003)(54906003)(316002)(8676002)(36756003)(478600001)(86362001)(40480700001)(70206006)(70586007)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:20.6375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abbe784-ddd7-4851-5fa8-08da5accbc66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
Some panels may require more MST delay on discovery

[How]
Add panel patch and debug mst delay flag

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h       | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 337bbd4c6642..b9a23e6b3696 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -741,14 +741,15 @@ struct dc_debug_options {
 	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
-	uint32_t fixed_vs_aux_delay_config_wa;
 	bool force_disable_subvp;
 	bool force_subvp_mclk_switch;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
+	uint32_t fixed_vs_aux_delay_config_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
+	uint32_t mst_start_top_delay;
 	uint8_t psr_power_use_phy_fsm;
 	enum dml_hostvm_override_opts dml_hostvm_override;
 	bool use_legacy_soc_bb_mechanism;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 413738fe9d59..084074a23031 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -199,6 +199,7 @@ struct dc_panel_patch {
 	unsigned int embedded_tiled_slave;
 	unsigned int disable_fams;
 	unsigned int skip_avmute;
+	unsigned int mst_start_top_delay;
 };
 
 struct dc_edid_caps {
-- 
2.25.1

