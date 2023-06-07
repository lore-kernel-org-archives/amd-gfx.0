Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7262CC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E4A10E4DB;
	Wed,  7 Jun 2023 12:17:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6D410E4DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwFUAtdxNt3kj1hZ3oDXuiLtlVRQ6c1j2EY4mtwbsgQgHh4NiZSKtYB1h+HOiuQJXTI7bfzX/U8Fov6Hw6aztDjqMNVQX9ydM3a/HCsnI4dDmj1fkoQa9/izLS2Acu4BeStQjve46fIaEEvh2kUkV04lxSnwushuPw+QPHco8D1g71/Sog1T5l5SACjC1evx9OAlYqwCbCcaWfeOySD92kNmXgQqDVKChVy1REW5pR3ECouhp+9u29A0YyrBll91SqZf3pcnfsNpgPJqrVvXgnxbiNzIskbEOfOq4wXzb5F0dvL3CpAteoRpSFv3gd9Cvlu9A1NP9hiNRlYapoKj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7+hRqgdcBJwKKbiUmYkk6aMl+1S3oZAQTVx/94jw0o=;
 b=BSpu8WFfgoS0NcVM96TsuERI3sf3JqLKacYWRr6ta04RjnZRwyLXEuCZA2oIoCZ9S+2eBAwgMG9pzhnOLnKbwxaGrcfnkMsTnkfh1nyR0RH89tQXBKEMDjYC9W0D35oaPnsvHXIJkSV329r2DiUHwzsdVPgxRe9bYhK0TLl8a05D8fLV3ANChbVkG4TLgtjSgm3TP2Bn9Oe93oyAIlXKUWIAXH5FJmqxDfPGt9JOqVZ+j+y/n4AHtDgl2q7vOZSqzkhMQCkrKcRR9yP4Pb5ehDSn3PBes6JzyOQK6Et2YtnzGxqJCniJRy0EG3gIpVKujOYoPILIjzLnSvdfYrMb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7+hRqgdcBJwKKbiUmYkk6aMl+1S3oZAQTVx/94jw0o=;
 b=p8TeQp4jwVMjh3KR0mzovPwE5LfhEXL+0e0xqc7+f59OcXI+lxu2wWZYQq+gECYDf1cFlczRNNz4Ev6x2xUJcBkGcnbLnMO3WRAOoabijA5v/nv3bW39XVI4DgUpMOB6iX0Hco/duHgZReWdTKSUamgmTvDnSn053moHPBc4RzY=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 12:17:04 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com (2603:10b6:5:3bb::4)
 by DS7PR03CA0083.outlook.office365.com (2603:10b6:5:3bb::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 12:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:03 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:59 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/20] Revert "drm/amd/display: Move DCN314 DOMAIN power
 control to DMCUB"
Date: Wed, 7 Jun 2023 20:15:41 +0800
Message-ID: <20230607121548.1479290-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: fb24eadf-136a-4a2e-3622-08db67511aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uG5l3yVhSIQmpXEw6rQjwWCqkHQQBKEFbmFR2nys8jrelgh8HI4yzM3J/LHS1bhgFK5slfljOaNrPzrJkX3jY1L4JOV33f3kz2kapWINbdG7Va0p/grWtn/t9/fwqOCtnocyyeCnMKnBZjoZMdzxeamwlio2ZqsyYMpswSebRVepRGISmPIr8mCk69ZOPH0DdxxrMqCEjy4FHRZRChM19wIhLa7K4eu3yVewvHvuHitpHlr9Mnx3S+oKIfr5efrZdHfFpCicptEVBxJIGzHDu3GRGoR4uQ7Eu/SJYr40Y2xIsl7tTCmAq9gmU3EfB9IADhUyGsPm3EZlG2hA6yBtQd1LcGqEazJgSmNoeA4R+gwg+yNC6sOQgNqAvbugQG70NXGS9dFLUTVXRtkDb1FGTTSJlw7A7jASOmSopvac+EICCvdvUPtIT1E3iemvN3hLs0ouzvcn41kh6ufN143cBeKT7Tl7hKY0XHLa5r0vv8Xk5Ha3n9bwiE3UaIJXj7bjw/dCNS7r2TWiXFhae6MLD+adqro2ffJwKyjOTJSaj9X7w3BiaOLp/VA87FfgcA0V1TpNurDFrHOo+XLvXUVW5d8oVcxZYhSMJ9wnNWO9/GRFwqDdBjLM6hDEX5abr7jvaNC/lRhmt4GkcZfukNnpTjA2DBrlHxxx7AYSnxusFR0mtR39PEfdyqOaxa2diXCWus9FXG61zbY/6AwnSXveUe7+nQmMm4rsuT2D3CXUxQCTdZ85tgtsbfbQxxRws7fnb+C2x3rk++RHjVa/Ly1yRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(426003)(336012)(54906003)(44832011)(40480700001)(8676002)(478600001)(8936002)(316002)(40460700003)(70586007)(70206006)(356005)(81166007)(6916009)(4326008)(86362001)(5660300002)(41300700001)(6666004)(36756003)(82740400003)(2906002)(7696005)(36860700001)(82310400005)(1076003)(26005)(186003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:03.8748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb24eadf-136a-4a2e-3622-08db67511aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

Revert commit 6c2c207e4a24 ("drm/amd/display: Move DCN314 DOMAIN power control to DMCUB")

[Why]
Controling hubp power gating using the DMCUB isn't stable so we
are reverting this change to move control back into the driver

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 21 -------------------
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 --
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index ce7e6f20b31f..4d2820ffe468 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -429,27 +429,6 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
 }
 
-void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
-{
-	struct dc_context *ctx = hws->ctx;
-	union dmub_rb_cmd cmd;
-
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
-		return;
-
-	PERF_TRACE();
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.domain_control.header.type = DMUB_CMD__VBIOS;
-	cmd.domain_control.header.sub_type = DMUB_CMD__VBIOS_DOMAIN_CONTROL;
-	cmd.domain_control.header.payload_bytes = sizeof(cmd.domain_control.data);
-	cmd.domain_control.data.inst = hubp_inst;
-	cmd.domain_control.data.power_gate = !power_on;
-
-	dm_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-
-	PERF_TRACE();
-}
 static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 {
 	/* There are use cases where SYMCLK is referenced by OTG. For instance
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index 559d71002e8a..eafcc4ea6d24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -43,8 +43,6 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
 
-void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
-
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 86d6a514dec0..ca8fe55c33b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -139,7 +139,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
-	.hubp_pg_control = dcn314_hubp_pg_control,
+	.hubp_pg_control = dcn31_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,
-- 
2.40.1

