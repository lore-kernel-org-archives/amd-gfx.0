Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F60C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAE660C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BAE660C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97DC56EDA7;
	Fri, 15 Oct 2021 18:43:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12A56EDA7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gULmLSkH1LIzW2rmJ73hDIkADhFhgAbltpMDfT/QHi11v2zFA0rdmCSdrIvXzZMpTosiaepEDTA6NcwqMPqYGUONwuCT1q5HJY/6aJs0fAcfpc8uAHlCY1y2Epi7LXkMLGth7HC1PRi69NvPUnzRtXixp20FLrg3kEa0dNTWyQdGUUU6azBYNy/btVW4k5GP5g5BLBIauykQZOCZKmw0CyrdkAcnQVp9gPyOghOG/n7hw8grTg5DgQpH51XITRAGOrIm8LmEk2Q3GBmUu/WRksYwUkZT0XsSrenz0RYm4MLYi4Sffc58CDQzBWss6xLaBUFafwogBef8rfeyN9pbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FPLs9nw97/vKUc44dV/mgm4NL3fBch5u8yfKimy8gs=;
 b=AdI34iv8OO5QpgOHPhjS4pF69avwXbhJdjAl7I1SOFtk4RUsd9CwCop2EvYLZj4+IhfKOPd98SyTIyUGOvrKkCwAIhK8I3tk0rlmjHM4f+ROzbPS5RNvWFOIfCsPo1qBW+mmdphoIWYnpOopXpEWLyRs8YqSFVfER/mYff/GYiWuG2Dv+Eol4BoxUSzdxthJzS4cfFb4PpsHKPc2VEXoB5UfDoN5FUOAV69SWaLXPiTc5LOLoaxW3HH9BhzDEIjNxlCGtn9yhpOHgg6IRhUl75tRx/Hv2jS9WGUDCMUKl87d5ytCdzOvYBlBB1BYg5Y1+XzwTB7UoTYIflLDl0weJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FPLs9nw97/vKUc44dV/mgm4NL3fBch5u8yfKimy8gs=;
 b=NPctKQSLOex7KXQnyE6VJzO6xc612EpYoWNlxc1+ryJtuhYrWzVsEhnRnbWRreaPfA/a1zLKnWtAxQX9yQBnPWTQ7Ups9MAiEgZN6dXyJG9JXbraQb9xPwTFfFTXqWiwkHftjLoFveSv6NqqMFBRjkzlvH+9JF+bEqad893sDp4=
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 BN8PR12MB3345.namprd12.prod.outlook.com (2603:10b6:408:64::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:43:54 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::1e) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:54 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:51 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Eric
 Yang" <eric.yang2@amd.com>
Subject: [PATCH 05/27] drm/amd/display: Clean Up VPG Low Mem Power
Date: Fri, 15 Oct 2021 14:43:10 -0400
Message-ID: <20211015184332.221091-6-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4945fcd7-df3d-4a30-7300-08d9900bbd2c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3345:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3345139605F1DF367F880F11F5B99@BN8PR12MB3345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jccs3zBJg/SQRPWJEi2dcEJAUa3WANE0P7WVDefw+z+GWay7fX0KnxXpBVClgRUCQLKA/y88rmXOZQFYGQNd46bA9vEhpX7FOwZpwJhRjdCXKNdCevZUs93+dgQtIpqwj+JPFEpWQEQhratoVFo7pwAdTjc8NE+lbt6/YzWD9qJvWHgYdab+H7wx3fEwzPaJk0ktrWufqGhiGFr/cGZkeLB70N6qS7YueNC0oOxnL5SXUTnMtCafR6yyvLwiBsfSBeEXCtv4Xf6Vc6VI/eHPT4octyxz4skGQSkxQKBZ4w+Jqb1Kzv+oLvBvXi772tuC8/tmktFBt3+Wp1rD740DkxNFc00aztnpL8wnBbBATZkJAdRckt0iCGMys+vLhoGSjcpFp2ZCEW3DHij38tfN933W4T4K4RPgb4gCPJwfdSoJNgb/ahCxNMNO2In2KZlXlXG/MVG0rrDRp2XxZy7KkLbleM6XHkGMpiZiQ01rXzsmtQKf/EIJEK+ws9DsDD1zZdIyDZHMTLrzxYF1Pqs6j200BSuVoWjRtktyFYeKljwJ7fCJwypBWJhKg7xzu+7cGf7WuQuA6HdJasWJ4Rb3C38vzRPd/hcXow3eS5qEe9pIv86iSHOB/xzRotwTyycXHRNiRIlJRnmUD3gOaS537DqrPbnPPy8WziSyLBxHr+iTDHpOPycO2ZwAtw4lGEzw2ON5DO5eFnp1/xykh4iW19JaDDS+MKrxiigXEOxgEo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(508600001)(316002)(54906003)(83380400001)(2906002)(356005)(81166007)(47076005)(36756003)(44832011)(6916009)(70206006)(86362001)(2616005)(1076003)(426003)(16526019)(70586007)(6666004)(336012)(82310400003)(4326008)(8676002)(36860700001)(186003)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:54.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4945fcd7-df3d-4a30-7300-08d9900bbd2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3345
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHAT]
One of the current VPG power on calls is unnecessary

Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c            | 10 ----------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c  | 13 +++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   |  4 ----
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f9876e429f26..8be04be19124 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -71,8 +71,6 @@
 
 #include "dmub/dmub_srv.h"
 
-#include "dcn30/dcn30_vpg.h"
-
 #include "i2caux_interface.h"
 #include "dce/dmub_hw_lock_mgr.h"
 
@@ -2674,9 +2672,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	struct vpg *vpg;
-#endif
 	int j;
 
 	// Stream updates
@@ -2697,11 +2692,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
 					stream_update->vsp_infopacket) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-				vpg = pipe_ctx->stream_res.stream_enc->vpg;
-				if (vpg && vpg->funcs->vpg_poweron)
-					vpg->funcs->vpg_poweron(vpg);
-#endif
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 18e33ef3d217..968b8825dec7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -49,6 +49,7 @@
 #include "inc/link_dpcd.h"
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "inc/link_enc_cfg.h"
+#include "dcn30/dcn30_vpg.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -126,6 +127,18 @@ void dcn31_init_hw(struct dc *dc)
 		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
 	}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
+		// Power down VPGs
+		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
+			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
+#if defined(CONFIG_DRM_AMD_DC_DP2_0)
+		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
+			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
+#endif
+	}
+#endif
+
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7cb7604a35eb..20b4202bda13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1312,10 +1312,6 @@ static struct vpg *dcn31_vpg_create(
 			&vpg_shift,
 			&vpg_mask);
 
-	// Will re-enable hw block when we enable stream
-	// Check for enabled stream before powering down?
-	vpg31_powerdown(&vpg31->base);
-
 	return &vpg31->base;
 }
 
-- 
2.25.1

