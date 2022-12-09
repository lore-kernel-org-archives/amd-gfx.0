Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D06BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C914510E56D;
	Fri,  9 Dec 2022 16:37:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9920710E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPpGXRbkuCD+jcqeKraBt4sVaH0R5syr+h/PB5WtLzC4DeqX9vVnIGOyp2Ph/GW2nHLX82HpBqxw0qPiVvSE/VRW+WSSFx2dMWPAMIGdhowhAe+6AwQcuqoj7aiZWtlC1OfolyMKEP9pmOUfg/xY07ZjIsQ345I4rjCF/R+mlHnoKTQkfl3tz408CcVAzLafWk/a6CGU3fGmYfrETMkSRxALbqfP7EneDuJbXsCnMBeoCxVHm8aNd5nkhxPxDpn7Meybv8KIfuYYHjRfJpwmAZQj+TUu4wVx4bQPWzke/8irVCmLkAb3NLEt3oAdDRLrDvSbv9bPMR2PDbErmLUcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJEqCx+/4PF2p3/yfBg4QNnQ9m477aKr7D1YPFwuV6U=;
 b=eKyPZ8QV7IL8YX7FfwKORzigHAHPDzStJgAn0+SVMJUwexO2nOPBID5mtEL6+lMnKXsi6INGxLmHCtBqKQPzaFVpLQIp8i8Qy4wEZJOfPiusM4PaUAEKRdEQq5Ffv9SOTt5guQNC9GNImqHb3O5Ev4xFyxk2HYt+BE9MRAoAIilgN9iml0x/0Hk9Ed/QKCkF4mjMXHb3HbnoXxMW7sUwlRWz5oH7LjO1lTrylhmM2X/Qp3A0iBzffD7AGygLw8i5fNtnZiPuBwcLmgT83qTfF/L6FFvuynmV7mEbT4yAeWLCvIE9X/Ms3SIo2vcsE+0yLHrORTm6C+eg/czUVhcRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJEqCx+/4PF2p3/yfBg4QNnQ9m477aKr7D1YPFwuV6U=;
 b=zogIZroERsjTCM06tM8XtpIn9WGtSXAtOyiclHNVghe1qxkMM3eOOIYtIMejUKPTbc1gUrI/4g4RGnr3fDjSvqbHh75Mmp+SEhNkXNRdhKUwRxzveMxz8cnvgzG5yKBZ0EySz+tDkkv2JMwKRo2RzYg3i5433cMJMqUJgGwsbGQ=
Received: from MW4PR04CA0366.namprd04.prod.outlook.com (2603:10b6:303:81::11)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:24 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f9) by MW4PR04CA0366.outlook.office365.com
 (2603:10b6:303:81::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:24 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:21 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/23] drm/amd/display: Demote Error Level When ODM Transition
 Supported
Date: Fri, 9 Dec 2022 11:36:31 -0500
Message-ID: <20221209163647.25704-8-jdhillon@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: f877993b-9127-4732-80ef-08dada03a6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wkIDpLer+8G+xnXBvoCX4u166ZJG9C0kHkid4nT2te9zPrTjJJXfC1LAdadr0tPoFp7bbmO0JtiG3uLo82TrA4La30yVuHFMMLmS3ArtRC3Ods7PFoIgDPWNqp2+W40aucsBtEAebsB3YtAq3K7HwNJb3QHpDVS0g3+1e00IW+jnwdcWkUS++0/maLwV9K/oXd6QbZ//9ooGOBwBNb28xoUPw8ZxUoo6Wr068bHl6nTB3H6ZydrdEONAEdVOxjltTxL/SyfVXYBuatY2MRnZdOFWFzZMmlfCcPtxwmC7c1xBRr5cNZpj44npktoFpwH73ZBh5heJlMXR6s3cJqYlnYlDpUGecZ99yefqklkz1DQJTRFQ2pHyTqYPjHfuuV5T7NdyAglZ5TM1QHnga6gVM9a3cOcPegZjDkzTtNBx5EWHXumeHhEpxK6c2JeU4fAEHAEDkdtR7bGVcGjLP5xEgsEZw886/f9NXwOm88/KgbCxrXRW4TU43/OhgFqrId1UZ2PtrTp73qwQluLjJ5cM9+0Lo7UdpEtl93rXwYLykMU9ruEZYScQrEqHeV8s4qj3uFFmh3dx8N94RKnTTCf3Hp8AO65Pt3nX16TuA4SMrgECChGQjKzvpU5kHbeHjpQd0zUCU4NH8Z8EyL4ICgSOY3AhZmcMONSsUIPyYekBjgB1Mllc1XtGB2o4QIKVsyvO9S46iRWxWxNek+BU9HFSboRwLkX6qwONklzuOBncqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(478600001)(6916009)(26005)(36860700001)(8676002)(4326008)(316002)(70206006)(70586007)(41300700001)(47076005)(83380400001)(426003)(5660300002)(2906002)(54906003)(8936002)(82740400003)(40480700001)(81166007)(356005)(16526019)(2616005)(336012)(1076003)(186003)(36756003)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:24.3641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f877993b-9127-4732-80ef-08dada03a6d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why && How]
On dcn32, HW supports odm transition in fast update. Hence this
error message is considered false positive. Downgrade the error level
to avoid catching unnecessary attention.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index da164685547d..002b7b512b09 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3810,6 +3810,8 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 	int i;
 	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
 
+	DC_LOGGER_INIT(dc->ctx->logger);
+
 	pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
 	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) != disabled_master_pipe_idx) ||
 		!IS_PIPE_SYNCD_VALID(pipe_ctx))
@@ -3820,9 +3822,16 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 		pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
 
 		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
-			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
-			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
-				i, disabled_master_pipe_idx);
+			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx)) {
+			/* On dcn32, this error isn't fatal since hw supports odm transition in fast update*/
+			if (dc->ctx->dce_version == DCN_VERSION_3_2 ||
+					dc->ctx->dce_version == DCN_VERSION_3_21)
+				DC_LOG_DEBUG("DC: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
+					i, disabled_master_pipe_idx);
+			else
+				DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
+					i, disabled_master_pipe_idx);
+		}
 	}
 }
 
-- 
2.34.1

