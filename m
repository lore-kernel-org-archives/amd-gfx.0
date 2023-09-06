Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36DBEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3511A10E645;
	Wed,  6 Sep 2023 12:52:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418D310E645
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmgJe1f2iCrIHGaI5ocJ3Nibo3P+OmTIOHAwcGWulOthPGsluoUAH1ufOfYmyqSXGDha+LBt3H08pU9ab0YQNqltEo0K5jbY9t2BwZp6K/JExMDXC2r6lJTru62v+ed+QXiVrtZkFAg2dnV7X2q9avYz6j/YBL/CPb7leZY+Z7yRcUtuxd4XvFCqnzUNGMpL+HfgZCtXNckcEaKwyfBHDblUNlvCqF1lcD6M2NQHDKh34GtlKglGj1M/mLZni49w/Tg5qWYZbJi8q+FCXlO/to8U70p4lUsidIUlEwEzzLwcvKzQN+Kby3vLkQ56f8a2UK9W2SsrFmFM1Q9SyZTulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJFRnJSLTvkZNNHrwxYqsZY6gUWpVxV8oFdwsh4fiFY=;
 b=ehJY3nfmDqReU5EC+iWXAP4ZOWYJeyTe7yc4zXTCO8QNDh2nt+Qc9DJzpv/WRca6lyhlnXN/xkaymrf/IrCFYUF0Zva3qhoURbV6kvdG1ZO5qLLXnqqzRZOnw2M95CkARsdRSDveO1CCNR38W45kNQyHK4HhzCGMPpXQjoolt2g6+wrUnQWseu8NyXELjPOSrgbb6ria1VEdecqQYfR5tDx7DkcXctPetY+2UkKgrFzx51j/fbYm1sagfUCSgBYSlpNSzzvlmL9RQGWqm5T/S5n2k5NYSuyEomp+4c9JJeSDJ0HYLbzswDCsSknUyEhR7hXpUOjK57Hu3iCANEKUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJFRnJSLTvkZNNHrwxYqsZY6gUWpVxV8oFdwsh4fiFY=;
 b=iRyaaFzHR01UpcyyoKKr1K/r+mk0aVp8uQGw368H0sDbTMbDTd1QImdhb2LxDTi6ThJ6EPNqv170Hc1GN3n87Dnbwnvgg+Y8OKIFu4bHeedPJBceivFCruDZbyWPZMfISMMdVIIGyaofICpm3XY63w6Y+RLHTgF8XfO+Z0fVNlc=
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:59 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::b2) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:59 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:55 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/28] drm/amd/display: do not skip ODM minimal transition
 based on new state
Date: Wed, 6 Sep 2023 20:28:29 +0800
Message-ID: <20230906124915.586250-25-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3c74f9-e63f-4c6e-dd33-08dbaed80f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56/UdHsn3X/la3FUmBAIruya4F0UQeI5yJRnD4NtPqF/o8NAm/22YVUqICZbiO+LEXrSJ4+cjgKOvXO7FFYJkuat023UFd9Sf0egpfclKnF+7Hp18B0oueDTeEzYXs1bbFt37+ZmF2lG7YvVTgu2fuqpSdeD/cYI6pS/DAzi86K/Ti4I6iXeTyKOckk0K80XlzhVZL5m+tucBQPavBqcHo6jNzinE4mXB8buFzUGQ6ozllGJ1XF1Pk+ydWM3jS6xeYK1Ucg9+bIYOoLtgLlYKpuqMDumFBCppLhF3TRSJPZgxTsLHqzBwY/+eZj9wnr6YTvst/ws2BbxjEYexhUgFXvdK8KmQZRGQG+xZXWonnrBxQNf8exVvW8weWX4YwMIxcRDOl3UGIl/lI0oNRSSVfyOpjI4kGFTpfD5XJVMClMPS6vyC8EWfsLimVoMD3pTdpTPEPGFXz+zwqhKid23m0f6yf0JvRFvqwA/3In2VgBDfGy7s2wi4jDiQUglM9o1CILBbZoOGegOkG3dN9PgcvjCwtzr4v2BLuVBjIjJeLud86lzExjaBU8cPZ0T9+LvVXq0xOhKf+gMKzzDLFsng9CMN+Q2nb6sJdxYtNi3baHeop7q2stbpi1y3UFUFVq8VVw30hoVbobnteoXH1X3ffa73vhfwziGv6QXcEfJMrDjz0ElB5aSaSuYP1fZYrVauOf2KlcwpBi0NrN4Iyca52NWavoDNlU2wYT8RPbaRffREy4cetrOxMPaxbKxbq+Opps3AYCM2g0mYsnUzKQSnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(6666004)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:59.4560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3c74f9-e63f-4c6e-dd33-08dbaed80f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
During 8k video plane resizing we could transition from MPC combine mode
back to ODM combine 2:1 + 8k video plane. In this transition minimal
transition state is based on new state with ODM combine enabled.
We are skipping this and it causes corruption because we have to reassign
a current DPP pipe to a different MPC blending tree which is not supported
seamlessly.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0320bc49458c..8e8362026825 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4048,10 +4048,10 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * pipe, we must use the minimal transition.
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &transition_base_context->res_ctx.pipe_ctx[i];
 
-		if (pipe->stream && pipe->next_odm_pipe) {
-			odm_in_use = true;
+		if (resource_is_pipe_type(pipe, OTG_MASTER)) {
+			odm_in_use = resource_get_odm_slice_count(pipe) > 1;
 			break;
 		}
 	}
-- 
2.42.0

