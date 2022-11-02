Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8646C43217
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488C310E4DC;
	Wed,  2 Nov 2022 16:03:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39F210E4DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRg4O8NSiHZ+z4vPTzG04DiI1jKPGbrKL/jUBBgcIkupdtzZZ9sslV/vSK4745gX3oAG/kLru/uQJKryZPWXtmytp4tZ9beTp0ktdW16ZmZWWjdvgtzdpsjmhXsUVJbvbvq471zz3mHu0SB5mhbjXAncW1i8JDC3FFNYI8u2cUxtW8477pYfuwaTe2tSlFx103EajKOaISsNb3R726COKjUx5j6OB0/0BEPAiaK/ysY4TTIYNVju7AUvhWv4mAIrgc34/SNWEjAwGQuRW7gs9mrn6/ga4PFlxnwlIW86FdI036IzaIa61FbaRE4pkZwQzoSIscygGn62SNOL0vdgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jUoZ4USFk4KAGEcdQjhf4CdPWvHzcewBOqQrdTgRAE=;
 b=XadvM4ThnQCK+U0ruc/CWPviOzeoLmmaO9c/itYQz2mm8zZxfWPl0hiql8eh41z214d+obR5swiFOas32lLEZNS2pqaQ2r7tzrxOC8qmsp8Bc0UcrjxtPV16svWfW8XeBxrhURsFAOK+1MYf0rllX5xotB7U+5Y3zd99e7MwmC3KlRN3buvtOK5FIHo275EZ4ZqVtjnubXqPYb2d2Moxv3GlmWjDc0GyMdhLFRXmCb/qTUeUmDNL1k/zltJkVIh7YkPBMEVIki3vVWnITeh1xZKVzuFORd9Y7Mpeo/Ok5XQ2fMHsjd9YH8UCzD7SVByJ9OshBRxd5tWO6SqibyGfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jUoZ4USFk4KAGEcdQjhf4CdPWvHzcewBOqQrdTgRAE=;
 b=u17AhHI1WajsEiYz/JLqdUEOThcscHbEJXcvY8a057rzmPd521R5XtIxM6MeDRqVWKG/5iZaAZWOL5PqjmkUi7m67CFBeJGOzMuk4aBFiEQgHFe/ucY3/be1aQadkYivy6m9Cs7sly3NAr4lFHkBY0aVpWiUSZ8TL1JntjcuLC4=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Wed, 2 Nov 2022 16:03:05 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::3e) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:04 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:00 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: Cursor update refactor: PSR-SU support
 condition
Date: Thu, 3 Nov 2022 00:00:58 +0800
Message-ID: <20221102160117.506511-4-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc25b4d-d614-4134-00b7-08dabcebba62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxv2H8D+qjOr0QyiDGajxM0HX1gbL2MUAd97apClRvDqR0Aya7vtmWYRaaoJISo6ABMhnQ6pdO9GHDZuf97L6cK3a0BvzMtbx4+VuVakZOcfDOwSq4z9gv5Bey8FfRF3MveRiC30R1uS783IFcuKNUI2NWh+kGahy5cQ0YImY1rTnrCB19irQ0tTlGM47zXcNASBfZRXkBr9dfDEePhiwf8ZIfiLxg6iafM3v0LZ3VgzddskRvm/n7Ahquy7T6JWc+RzsR2nZiwjSg6Q/eFMfERRnDCq9WcoMncUwqRN8t4HQIpVPHx4Ek2yfRcYMRTtj31xy5WVa97+LM4Srf18qjSG8S4byXPcfsfuG7MbM56eG2zJWZgH+3gDuEjzkeSqAHPb31mQ9huSAC52aD1Th2NYTPEKuRz9qh9wmjVL4FbLNY1OiclInWMd/WdJkAkuhyt1+feT2IQWbVquWNc/vVUk4PJ3nHdE3gkEkBxd7iLgg1VxNy7YAKWlqYuauLK6tRJQDy0zeo++lahSYBJckwO1+qxXbNAWBwfjkN32nd7HIXRlnSOXJL2QeBPC+N7FcX4LiSv/4A1KyzeTEdD2g5CwxX84sUdvIhNVetiMly3rj0im/QvLFuajuppRVuGTDWgzburzj3n+u4Gv/q2ygIodyMlh2tZ87LX764lv6R6RW5pDzM9Bz15D7uomzFp0ECIYICfu/+XuN64jv2b5BJqvA8HTXt3/dekLZRc2/ymAhNa1tZvm9Dt5jaklDjm51rEi9IatPWg7b5VMcKUSTXCSKHe/nmnH94lsJZujmTo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(186003)(2616005)(336012)(1076003)(478600001)(7696005)(47076005)(81166007)(40460700003)(426003)(356005)(82740400003)(26005)(40480700001)(36860700001)(8936002)(83380400001)(82310400005)(86362001)(36756003)(15650500001)(2906002)(41300700001)(54906003)(316002)(70586007)(8676002)(70206006)(4326008)(6916009)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:05.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc25b4d-d614-4134-00b7-08dabcebba62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Max Tseng <Max.Tseng@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <Max.Tseng@amd.com>

[Why]
PSR-SU requires extra conditions while cursor update.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Max Tseng <Max.Tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 67eef5beab95..4cb912bf400b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -859,11 +859,59 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 		diag_data.is_cw6_enabled);
 }
 
+static bool dc_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *test_pipe, *split_pipe;
+	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
+	struct rect r1 = scl_data->recout, r2, r2_half;
+	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
+	int cur_layer = pipe_ctx->plane_state->layer_index;
+
+	/**
+	 * Disable the cursor if there's another pipe above this with a
+	 * plane that contains this pipe's viewport to prevent double cursor
+	 * and incorrect scaling artifacts.
+	 */
+	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
+	     test_pipe = test_pipe->top_pipe) {
+		// Skip invisible layer and pipe-split plane on same layer
+		if (!test_pipe->plane_state->visible || test_pipe->plane_state->layer_index == cur_layer)
+			continue;
+
+		r2 = test_pipe->plane_res.scl_data.recout;
+		r2_r = r2.x + r2.width;
+		r2_b = r2.y + r2.height;
+		split_pipe = test_pipe;
+
+		/**
+		 * There is another half plane on same layer because of
+		 * pipe-split, merge together per same height.
+		 */
+		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
+		     split_pipe = split_pipe->top_pipe)
+			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
+				r2_half = split_pipe->plane_res.scl_data.recout;
+				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
+				r2.width = r2.width + r2_half.width;
+				r2_r = r2.x + r2.width;
+				break;
+			}
+
+		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
+			return true;
+	}
+
+	return false;
+}
+
 static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state != NULL) {
 		if (pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
 			return false;
+
+		if (dc_can_pipe_disable_cursor(pipe_ctx))
+			return false;
 	}
 
 	if ((pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-- 
2.25.1

