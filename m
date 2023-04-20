Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A8DC7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A2410ED54;
	Thu, 20 Apr 2023 23:50:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2039E10ED51
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny/g+JkTB8KnYIAeUyerFJbCi5ZnvkQKr7VEcc+AMV/CASqdPXdYyuBzbvMqtrmLkFUVb6/vsJPQwNns5WtOEYvKyyZIE5Iq7NZaNejs6dk76NUoO8PRJhXCW5wL5ko4Rz59FBOILIKn5CHNiwk5sJkqCwPT4un7HZutNtE4ewG3yW+mQ+XbMsfaz6lzGt0D54N5gs1IbqnC6k7p1WJejrTnVkL9vcRlrXcREiJnpaBb7sAQbUEHcnOsaMi7Y9T4OPWoeyGlGDWKYVAHbhdYaKr7dXB1iR+OH31mEf0qJ2tAuJQPq8ZXT/ps0x4EYiUceFmLLe106j2UYF0bl3oCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyfh3H5FY1vbivP4oBcQd82MM95U6N77/rm4p+3Qw6g=;
 b=Y0rsH8Ncv1/KzgDOhoQi4xzUvZsZcEt9GenHoCPVAvt2PNyAPw4LVeQpfr84UtdFW+VWI79FhLKMTvbPLjyAlnDFWdJkZ6K3o7PxcEEeiiEOB1WzSYLDPstKi5Y7j3/izo81VpxgV1YxCybZMZAp9d9sz+GZsyjuIaborJl7mSC2RcbVh6A1gkR5Hm9Z29f1Yl0zd7uBWpbmx4bNSdw6XgOxt/ic7zHORZU4m/BMmvzGF/iTmP7+NIBt2oowZCttOze+tzHRo7gYqERtoNosHszyCSCyR6c9Te3LZajMmyfq03fZh/m2X+dCb/8v393pz0L8R1RQHyFHavlEcKGrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyfh3H5FY1vbivP4oBcQd82MM95U6N77/rm4p+3Qw6g=;
 b=ii5kLe0CkBeUbAH5mFfl7FuBfdd+gxgUxRYIPiqaLWbuSLCeP+oHDi1MaYBpRS3yjjEu4qupn0v9fbFKnz2Yellf2UNEYGJwZZEOLMzj3v7O33kNPWIup33t4awx6E4wNiw2hOMlI6XYjnsgkj5IipTY+cYqVL4i73TrBT79ENw=
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:26 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::25) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 23:50:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:23 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: Enable SubVP on PSR panels if single
 stream
Date: Thu, 20 Apr 2023 17:49:40 -0600
Message-ID: <20230420234951.1772270-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dd6455-de83-49d0-850a-08db41fa0371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAJo0cdbrrwYRBO9oK6XJr10Ze6cQ6Pe8xuSxgBEvXpVDrgJVB08QfAFgV8U6b7lEeGYmg1QoHUVD/d4CDWn80s4q5bsXgLPPcicIwdmR3aDrsv25CcjXL55OGTzgnApPm11E87O0V+lFGSelgBewsf1WL4A7HoosvZiw1+zqE0rn5vK6OBcbIwAdNXYlHA0uG0wyC3EHNh9CJy/E0Cf74jEkyL3WYF1Kffyppqb35bZLZ2h6yIgXDrZz3kEhYMKRd7DZn5Uu/+IkpXquc/MgLFTnopfbKLXru8gPsuhUGVKVFQwcA9kwJSwY1HxbGhmC+HaapOF27Q9dAagTda2STP3YeWM7ANfNsDbzAztWjn+OXP64uxvEoWs0E9xyrlYJFRuvUsiqg7bPoBV31Ee2N+uW2MxX8M/FLngG0xjhEThWBXjdzWPv2JzvzJ5AeUNiT0QHkKjUZAppnJEyn2T91H3vMAkZPwFuUqOCHiSgb1bxNqddeRqObrkd5PeCqMttszHRd8gQfkdao4RcYFy8fYa4tS2E8ZUfZ1G6DKL1Nh1BK1lXFm1db4xrDFsC9aFfkfAtcrP9gb/QRUv2W/RcA94ay7wz9LN7luXYC1R2pOO2CQ9uxu6LFSLVLU5HBKMXI10J3gUKuIVHunUnjahXGNGK0XoLSuCTRsdNlPPkUl1jQCN3UgqA5vLESO0e8TXRgzGoK6pSSAtE//7GCeQZ4d34sj2xIzZxc8Ke47ze0eTz/mUXP+8U/+fJMQy6Hi0EVa2VrFPh9ebyMSGzYXxIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(40460700003)(1076003)(26005)(82740400003)(40480700001)(186003)(86362001)(70586007)(6916009)(41300700001)(6666004)(70206006)(36756003)(54906003)(478600001)(83380400001)(316002)(4326008)(81166007)(356005)(16526019)(36860700001)(8676002)(8936002)(2906002)(426003)(336012)(5660300002)(2616005)(47076005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:25.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dd6455-de83-49d0-850a-08db41fa0371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

Enable SubVP on PSR panels now that we have FW support

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d6f0ecb708cd..dc0a61ca99d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -209,6 +209,7 @@ struct dc_color_caps {
 struct dc_dmub_caps {
 	bool psr;
 	bool mclk_sw;
+	bool subvp_psr;
 };
 
 struct dc_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 9ce11ed769a0..1e9ada8b131c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -944,6 +944,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ed7ea4c42412..e1e82ad4c583 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -692,7 +692,8 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 *   to combine this with SubVP can cause issues with the scheduling).
 		 * - Not TMZ surface
 		 */
-		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) && !dcn32_is_psr_capable(pipe) &&
+		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
+				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 && !pipe->plane_state->address.tmz_surface &&
 				(vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0 ||
 				(vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] > 0 &&
-- 
2.39.2

