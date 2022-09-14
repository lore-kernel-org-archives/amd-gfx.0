Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EADECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC72B10E845;
	Wed, 14 Sep 2022 05:17:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCB910E83E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkRXLspvaIua/x8KfOiqJ0qDIx48NyINsR0FKDLqXtxw0nMbsZfYNwnyEiBCXCD/FvrZCtsTV8SHOVsrArbOpW77YiC85dVW3r1kNUFz8egqNkin0WDcULRQB7wgWEr2WUyAsDdBROGBtP59e+Wyx92TvPamYrbKrHUYwUOdhiesD7yE+OpMjlll8alRiGMSOhy7HGLTCQysuuNp3vs3VktMKU1opPoQq8s7mMgOIlt5PhQMNGDPQaqRJrd+eATS1cDcUxmsbzBqOxC1/Pec8ADDdxs5Ol2zL83lW2NEG0A9hSMrhBhWYvNfND13QaQt0fuG2209IQgkjQ38Jxl8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3px1o/qd/jSggcROAmCB6bz1G/ZyUj55Z9GEafaMvgY=;
 b=QWkV0slDk881XnFsX0MM2SFt1t6aUEyG7htLfJ9WcsG0EqSOHo40AuGeVV02ojhzFVQ+ogkRw/Xqz/y/bBx6yog9emTA7xNX3RALLl8Pjgn4fcMTK5ILkGu1AAWu9b0C5zyZVq/JSoXT/d4aWvM2Gx4Qc2HIwsWzVu6PsDUArnaM6ahnqHbXtjgxEwl2p9UM0pPqbITcrLr1RloaqSlIc0ykfPoqbxa81dRYQ2f7Wc4IXvMJCVbcAlXtypZiT+pjKpLqzRR+8vdFv9rGZ6PUpQXQPD7ahwLmYmsKYrIC3P9Ws/oMK1KdGc2B4XnIh2SmGiFimPaaNQZooIgzjsUDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3px1o/qd/jSggcROAmCB6bz1G/ZyUj55Z9GEafaMvgY=;
 b=1AtaNvH219g9Twtts8mFOUfyezZkaAKyUmZ6IRvUlyYOy2pi7vyGm79KM169oBmJ8FkvxBkB6fW9NdVzE186poYKEUZ5LYRXHprevKK6koe6CgYauz41lZd0y2epoUd7zgwxHRkbBbtM8YsONn9tmRGf++JvS1ckkStCdY2VHH0=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 05:17:27 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::c) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:17:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:17:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:17:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 31/47] drm/amd/display: Don't allocate DET for phantom pipes
Date: Wed, 14 Sep 2022 13:10:30 +0800
Message-ID: <20220914051046.1131186-32-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: b6783f73-a34c-4c42-abf5-08da96106a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjExWo10V/40FkTkpYK8q4Eg5YsWtd0kM67oFztpoo5QbFKJmbCP9kqM4lZjP5qkalItOunVWOxdJLJ0T/iJRRm6cxhHGllkbxP8fo1+C1Esl25TBceOTvRENoiH437G1Rsize7uREMfPaQcU9YP4pD5ctGqTiFslGbVRUA6umdR3mJdzIVS33IKO2fS267OFbvO2sqFxCHiKObGBub52Hse5OV34q7ALelah4bCLfsyy+Q/Dy7eB5+CIWwsiZnfDcUg/Q34HmX0mC13Zb33pRBy3O5pEVc+/uUL0TDcShr3Fdi1bRiioQhuID4hCDmUksmtLV8voy50YkEwhPW1Bye21kuJUbZwoVWYdP1qCjgVItNY0buYo2qHFYTYExXovquKA8o+QMlmco+JGxbFfUAfGjJ96eK1EgdkRQQKC34npQiAnQ8qmbMlBWzBGKNH1Bc8Hs9W+4tEniyzy3V8bbYe4Tuq/e08bgKwzPjPQEjebO53hg9lILXUmZxNHF+ncCGfeF7nzbwoaC5GTSGxS7ui9CZbCjXxe2fxqYPhsRk/S2H+3t03nSMcvEVsvvASySyTlv3gSNV+NHOuSBn4ejmWzrieZNXx9aEXvdkM/j2MUxPBtbN9IRntGdqRi/9RF6BqGx6mLPis1wxCWHT4nVrproC/7p3NHVF+xT0DGIgV+bvGfmr9Zny0IGGrOQ7hpuOMsEgyR887tSwBolUPlGmkh4mVioonUS5BCJbkx0XJ4AjSEX+9hxN9LZeCa0FpVsnyeeFB2bYHcQDLiQiuSJx/f3vAI00cnYebljho56XUUKKwtll7Mcy7SroaIR6+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(6666004)(47076005)(426003)(336012)(86362001)(82740400003)(54906003)(70586007)(70206006)(4326008)(8676002)(26005)(6916009)(2906002)(356005)(2616005)(186003)(1076003)(82310400005)(81166007)(36756003)(8936002)(316002)(7696005)(41300700001)(40480700001)(5660300002)(83380400001)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:17:27.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6783f73-a34c-4c42-abf5-08da96106a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
We should not allocate any DET for the phantom pipes.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 14787e0f0b6e..5490b3705b41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -271,10 +271,20 @@ void dcn32_determine_det_override(struct dc *dc,
 	struct dc_plane_state *current_plane = NULL;
 	struct pipe_ctx *next_odm_pipe = NULL;
 	struct pipe_ctx *bottom_pipe = NULL;
+	uint8_t stream_count = 0;
+
+	for (i = 0; i < context->stream_count; i++) {
+		/* Don't count SubVP streams for DET allocation */
+		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
+			stream_count++;
+		}
+	}
 
 	if (context->stream_count > 0) {
-		stream_segments = 18 / context->stream_count;
+		stream_segments = 18 / stream_count;
 		for (i = 0; i < context->stream_count; i++) {
+			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
+				continue;
 			if (context->stream_status[i].plane_count > 0)
 				plane_segments = stream_segments / context->stream_status[i].plane_count;
 			else
-- 
2.37.3

