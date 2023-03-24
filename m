Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F756C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E43F10E4F1;
	Fri, 24 Mar 2023 06:52:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E707410E4F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6GO6GB9nmNycimSfRQli8eL9hXF/h+lBULqImvFZCpiEto767JlTw3QAmDhHuYnIciWD/NlExlqDIOoyaFhO9oehaONLU52+uUd4gmdV+i0YNC9pS+3WRe5hy5cif47kXXaheez0Ao/eYwVLUofOKQgGBrRMqHlxcL1Hv15xSiivHD9s4LRRCya2lxXUQTqDMHqn/Tk7FMUQW0T9GguS3e4p9wfFnDu5/FyWd7aRZLPhm3xH+QX+BWmCUAxuACp9oTO6PZytXQmK0oGVByEjTD5ZhCYlujR41xARN7V3d2FJmlZGjF9rLELuf6n4bBHQVO8w/MGql5HS6ONGot7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vSAXgRA6fSVTwwbeiMccVIlT942kBeqIfqEUWEORBw=;
 b=mX0Vdm3ub2vu62118VjMTlLm3K2K71oz/rQCCFlm033eh/7IazQIDhQqaolKOyyN3YwIIgV3kq/lR3r8AuMhArz2cK348Z+WqKZIuYmk1WRYH+eP/xc20BNt4z6e2xdwbPLwKfX4BpPTAKo9tcVlZbi9ACkeNV13zjLT58dgWNc7kxidVzTeOOM2smrqqUFNmoZlIKuRAk6A6M++mZcZMgxmXQojr6yCMLQt82YsXZ8TNv6/hdyQLJzzXvdjv95aN9fyajmMlbUrf34WXpVwu1auuVrBiK1srKFgeP8k2D/clcdkdxdEyAir6EM0HG/ab1pft5ad3+ohLqSF7hSPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vSAXgRA6fSVTwwbeiMccVIlT942kBeqIfqEUWEORBw=;
 b=A2yzs52sasiJ8uneyixbw5F8zrYhhflCXyFSJiHHuKlJV9mFJMv5L+r06inJY82tJyU0o6FtF18htdFmEvV9EB5DTgzJ35jwE4pR9MqvFYu9iVOsMnQ5hl/kemVqKdYFHOqtyJ6YEmfB1k2tSVldaX9unkr1BIyB4rk5ICc2umg=
Received: from MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:48 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::a) by MW4PR03CA0058.outlook.office365.com
 (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:52:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:42 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: fixed dcn30+ underflow issue
Date: Fri, 24 Mar 2023 02:51:03 -0400
Message-ID: <20230324065111.2782-12-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7a42b4-02f7-4f74-099e-08db2c346174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBZYPghFh6DSOdknZTaQ+cJPhaBCwFT3aClvuvcEkOMV103u33JOwN/pVJCW3JVJ5xRSb2inCeLzNFRTdtNulB0nGqXm6tpPXMzHkdeVjl4ohV5MyB3/0gGVDrK23ktRZCDkfPvMTyVcF/4F5foeE8TM1l4/IlCAPWdEwIbGRWoTpK3Yz+TKEDIj4IgB2MaRZJiUDtXShwj+FQamJm0b/gIoz/perKF9SvPf05k2xZ6jlzaVVetArwpKPQHE7sKf9JSjRJHKyYLMI4UQnHw82sA3urE6bCaCQSW9vyReZROVf+UE72k5U//5eMFfSuiI3aX/Dl4en7+Y2sB5YSDyzEcd6TIlAx+b6ZVaJpba8ZrJs2rq24zrhfBRjRBSpJNH7plvYYHPyOVJU5TFTo86RfESpH2r+j2bOVP5Psdtt3YH+uEVy/I6EIPY5QGqSkSGkibuNwUtf7RxSUdJSF3jXp3xGpBKQU5IxoGuG2E0COCPkIfQ6IOGNqX+4emMMLjGfYNmyySwZSLWYCF+MN0Maz77wK4VvWMWdckqLyRflGrmuqSYl8n5lCe7dOLnwWG02MSA7+uxxMIBLLKFfM2fEc10Nz+FkNDoXGixPvXk+mfEFpRtC8DX+zmTcW1FEwSiPXLgJAiIXozach+xSrMDohgZO6arZ9XYeWKy2WBPOeB36RP4fTViQJFU2ckd3CBBaUDSRzBa7tTRKxbhgviBo11zrQ2Qb4c7+TmYgJNaQ9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(356005)(2906002)(40460700003)(36756003)(83380400001)(2616005)(336012)(186003)(16526019)(478600001)(86362001)(82310400005)(36860700001)(70586007)(6916009)(8676002)(4326008)(70206006)(54906003)(426003)(47076005)(316002)(6666004)(1076003)(8936002)(26005)(81166007)(41300700001)(5660300002)(44832011)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:48.6410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7a42b4-02f7-4f74-099e-08db2c346174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Ayush Gupta <ayugupta@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ayush Gupta <ayugupta@amd.com>

[Why]
Observing underflow on dcn30+ system config at 4k144hz

[How]
We set the UCLK hardmax on AC/DC switch if softmax is enabled
and also on boot. While booting up the UCLK Hardmax is set
to softmax before the init sequence and the init sequence
resets the hardmax to UCLK max which enables P-state switching.
Just added a conditional check to avoid setting hardmax on init.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta <ayugupta@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 6d328b7e07a8..0e071fbc9154 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -621,7 +621,8 @@ void dcn30_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	//if softmax is enabled then hardmax will be set by a different call
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 10e3cc17f71a..7ac6e69cff37 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -285,7 +285,7 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5ee9c5a74ecb..b2919104ffc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -909,7 +909,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.34.1

