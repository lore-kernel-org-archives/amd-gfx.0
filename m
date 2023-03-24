Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E06C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9E010E4FB;
	Fri, 24 Mar 2023 06:53:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7FE10E4FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoETc7iM0xUNXwn4IGT6Is342tZIQtJIDSNuPqf2Mo+kGw1ns9RYnx/VF1i0qRAmWkKCwmWKanxfi5n3AwcUS+5GjpOwyK6Ojf6ATxLBd0YzfI70mWXfCJXAm0/3VOmVxgA9QYmDRWjQ/q4FylPwo8aivAVK4v9cWuAwuwMwrPEnncckl/bDX8+pYkXyhCG1gTd53z+278mi1jcdt5Nq2zrCqMhVLz75IgbcJfR+QLN5FfIvQXLmn5NovNK3X0TTGikNSi7342bgPEQNKIbSRhrhE+rE2A9IH5Xj/1vDaXm0EfKK4rmJzoY4cOjR0LLilsaj7hsK5EoDGv0zseQpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toRYd4PEN5rVPt1YUzlb7DSWSLAtnpuBA6zqSdDQd4s=;
 b=OkZ8vW8VHOU+D5AcqIjH2NKZeEhlJRmbSvolAu2wbbXTuyEeXV7jlmLXQueJRa01/FZJRH96bl1N64NPt3MuAP13FORgekmCZ9aqbPFgSzotYGn8cUkOqzdfdUparMZB5j3S24f/bluPMPFAEGUm2hy21DrqmHVEJustbEgTFT0mKD6/VsOPiz4mYVddAhK/zTIPIHNJVZpLwGZN2IwYE0PnwWOze+GvwGCzTnW0HHHZRhuVa480498DVaYx0A7VoFEtcjCjxXx1XO0Rkq+C6sYIpOp9VSw2U7gH+wol8juJjfUG7HscIrSvOGcaxqkfWnlX21EnXc7L7k2FUOQk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toRYd4PEN5rVPt1YUzlb7DSWSLAtnpuBA6zqSdDQd4s=;
 b=An4+hyoynpJVrX5VY+naSzKJTIJWHB9ULhlbex60EeOEO1gfPlBAl5FPd3314V/bQMAsORqc4ad+NHwKbCVIl2h9450J8FWaWuvgl2RWC6ctd2WqE7RUkSz0jcrPfabKZxPtxdOMQoKteXLKfQm5zbeUW5nE+cqPhsQMN7sNXxM=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:53:42 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::43) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:53:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:53:35 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: Uncomment assignments after HW headers
 are promoted
Date: Fri, 24 Mar 2023 02:51:10 -0400
Message-ID: <20230324065111.2782-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: c1af1031-0a29-4ce7-3e03-08db2c348181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvMkFuQFg91hu+ZUGGGwFaux6Lq/Z+6v5kJVEi8UAAvxEAZJS2T4tNaJ+r2A4aHRPa7c4+jSxjdqTEp+bRxHafovJzTAjv1S/iBinYwMdqjFyA6GApzjv4pkX3tLu9AfXO7DoJ0VVsMmqsb9ykIEFtGeD93IF/4VBYWX9CB8efJ6tw36RdtyihJoatIW1ursP0rf7e1IwipwsoKEMyDgmL97x6Wd2F7B3fWXCBTxX1sqhsD5mlAcIQqN2l1kO67HFSf5XlfHerCKV+4qFBsA1jtXiznHwLN6IWxRmuGttyN6/3BX3i8AfGCKtodxctV0i6CaTeTznsWeusfoX6ReWgNnx7faGJMQyukHnBBNKP33CGV3XlpoObJNvr/aODjJc1PquVj3pykfAq3PUnNPXp+T99sBascRaJTwTcFQeMWK9zmdRJ7S73B8j6B1MYN5IqXFb/WvtsFlddcOoRw89vCHvkiSEWibE39trM/JRPY0jVYs6CkKQkdHw3zfEs+3Lh2BF8nafflvwX84gaW8szROZlfMB/QAp31WvKXCKkZPdZr4j3piPiglVt7ohak83MpS6C5wshENzelbF9p74aoAUGa0LpO7+F6eO4GVQWNCppK+hJ3o3hetJI2d7+4YeI3bYjm0vV9l4iYd/RDob8pAlm8Qcc7SR0La5MFTWjauuKCATag1b2aVN9cvBgGhDcjHRQEsoPYSoK3/egWClUz65LMK2z5ThhfodIgAkyk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(356005)(40480700001)(2906002)(40460700003)(478600001)(83380400001)(336012)(16526019)(186003)(316002)(2616005)(86362001)(82310400005)(36756003)(54906003)(36860700001)(70206006)(8676002)(4326008)(70586007)(6916009)(1076003)(26005)(8936002)(6666004)(47076005)(44832011)(426003)(81166007)(41300700001)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:42.4147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1af1031-0a29-4ce7-3e03-08db2c348181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Assign the correct info now that FW headers are promoted

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 8f26f7245104..dd6f643254fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -307,19 +307,17 @@ static void dc_dmub_srv_populate_fams_pipe_info(struct dc *dc, struct dc_state *
 		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data *fams_pipe_data)
 {
 	int j;
+	int pipe_idx = 0;
 
-	// TODO: Uncomment once FW headers are updated in driver
-	//fams_pipe_data->pipe_index[pipe_idx++] = head_pipe->plane_res.hubp->inst;
+	fams_pipe_data->pipe_index[pipe_idx++] = head_pipe->plane_res.hubp->inst;
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *split_pipe = &context->res_ctx.pipe_ctx[j];
 
 		if (split_pipe->stream == head_pipe->stream && (split_pipe->top_pipe || split_pipe->prev_odm_pipe)) {
-			// TODO: Uncomment once FW headers are updated in driver
-			//fams_pipe_data->pipe_index[pipe_idx++] = split_pipe->plane_res.hubp->inst;
+			fams_pipe_data->pipe_index[pipe_idx++] = split_pipe->plane_res.hubp->inst;
 		}
 	}
-	// TODO: Uncomment once FW headers are updated in driver
-	//fams_pipe_data->pipe_count = pipe_idx;
+	fams_pipe_data->pipe_count = pipe_idx;
 }
 
 bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, struct dc_state *context)
-- 
2.34.1

