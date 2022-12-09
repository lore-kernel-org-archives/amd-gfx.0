Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE10C04FDE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1610C10E567;
	Fri,  9 Dec 2022 16:37:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F5710E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXqkGDCmxHZPyNpjdoIOmk7tbAyzX46gtlGH7fLiqJzzZwiLN8dY8Mc1B7UEMSK84I90GX+h2wObB7S4c7hiIpKG1gzXVCWipWcIkujrA7okjxqY/SOD+2M+MjDyuH1GK3TcBclqdckzMnsFgYxxprF5Oc31+WMo/6A+W63u4UHi1qpEv14pFBfEiFNCE6gvFGS0xgv2l2NA95Pla1AuE0Ale2wAbHf0unlf30fhzK/7vc742Xbs2iE2svAX0Unj0twG6ppetJ4MdkvLGwFb3sBJKx9oVRSjKMRxJwVLqX+DzOY72xym4GCGwt1NYX2d3m3krh8RHLqMe3WHJrCc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzqjdmXePaSuHE+fdSA+MLpxAY+alWfJN+ctAOJ/qRs=;
 b=WsQch5+ipT8YSMYwh8go/Qayn3z8TXe1IQrQ++NUK6t4QnzCAxYrWAdPP5/0sI68v8H+fr8Qo03oDwWX0eK9Rh5cDiV5evMamXXNTY6ojvjJZuk4RThrtFdKe1Ulcpy2piIVPDzrYdVcZj2kR82LxYBQHAr0g1DCe8hHegcgjDwuNtr1ZnlvkNtmpVJykbRM44Hp5ZOSsfPRnoVHHOn5tBR8rUG3fbVKKwZqPSIZ3gtx0NSwsrIst17hZ4bDxPt+Xg/221+egMf3hqxdFMzSzXeid3rRNOy4jJuwukFmbL/PntqT4+wU4+9BpU4lXV+AJo7sAbb7TZyyKCLiItugjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzqjdmXePaSuHE+fdSA+MLpxAY+alWfJN+ctAOJ/qRs=;
 b=lncGVyqzKuHKaeVuXhVvf/ALeT6WvJkmsKgMcG7QDVUgzAmRWAO5JcOiL2xgT5tmG78yyzl0kxagFA76HvVTQeVVniH8gdhpay44ZeZdv9SbjpU5MHUvhM8W1kH/hn8X/9RKZbph+QOcSufKo3XAbnerUNpdzwTdzUI+9FJEvpE=
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:30 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::d4) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:30 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:28 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/23] drm/amd/display: Clear link res when merging a pipe
 split
Date: Fri, 9 Dec 2022 11:36:37 -0500
Message-ID: <20221209163647.25704-14-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acb7baf-cd90-435c-cf1f-08dada03aa74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDsNKk7PLiOLsboPoTpsdVRmAg8rmvxgXGHS74lkIMSPMYArp7dQxVycAkGyqXT2P6eRU4MxVdpv+jVwHYIKwR/iJKB/yprp8rdQ4pRNrgcO+fLZz8Xt5PHSzSZX2BsPqUewZxVEQblkU3sFx8jGRHLAI8qN31VOxzHDyrN1oWrESHnrCfv3YAjbN6DlylwhuSVZEQvZ1mX30u6Pr2/g9eQOj00frNJVPbxtWVT4UUZyQ4ASQMSv04f9Z3FQ8kU/2TsF+SGDjRk+O9PEMKmTgCm6aztXupN33fIrE3CKJpWOm11yY/8+aeFMY1Oqa1KHCKp7fa9E0/7KdIMi1RJXOXT6IKJUSZ6BhtrRE4JGBoeLpTwSFiixomSC41uNrvKe+YFpJ2jdgOrRXG70GNcaqSiyibNZTA00tjRPOxpyy6zEWMKTzmhrMU2h8q0Zj7fqe2IXboe1pi6qdOJEUFgBFwwgifVzdvAc3KHwmr/ww3dsVOZOYlt591/tQkjZndg6jAOvkP8xVUpMFLHuVXmKn3C3amypEIitUjIbYTcTT0qjFr+zOKnrLnyagbqSjIE89NR2T8TxkvZvx4IFVkx+Z3AQ8we8DlLgP89AGnjpV3U2kB/Hnwnw7DeI4v5WJsuLDiH/vLD1f1yDte9VKO1QI1OW4cnHUxP6DQWIF2ks4lw+G2/CLeXAO7+/9bmjUBDDSB6OfY5GNF2e+U/7+ZRGgXNkv3uv1AAmS4Xhmd9qTYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(70206006)(2616005)(40460700003)(336012)(1076003)(70586007)(40480700001)(41300700001)(16526019)(36756003)(54906003)(356005)(426003)(6666004)(8936002)(316002)(47076005)(5660300002)(6916009)(478600001)(186003)(82740400003)(81166007)(26005)(4326008)(8676002)(2906002)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:30.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acb7baf-cd90-435c-cf1f-08dada03aa74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When merging a pipe that was previously pipe split, we need
  to also clear the link resources or the next stream/plane that
  uses the pipe may have an incorrect link resource state

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 815cf13ebe11..13e5542a7028 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1660,6 +1660,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
 			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+			memset(&pipe->link_res, 0, sizeof(pipe->link_res));
 			repopulate_pipes = true;
 		} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
 			struct pipe_ctx *top_pipe = pipe->top_pipe;
@@ -1675,6 +1676,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 			pipe->stream = NULL;
 			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+			memset(&pipe->link_res, 0, sizeof(pipe->link_res));
 			repopulate_pipes = true;
 		} else
 			ASSERT(0); /* Should never try to merge master pipe */
-- 
2.34.1

