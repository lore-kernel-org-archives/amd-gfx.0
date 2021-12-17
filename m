Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672D0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81ABF10E6BF;
	Fri, 17 Dec 2021 21:24:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348A910E682
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rla6ZuJEPKyFe7bIT73zE4u9l9RHKq9LvvT0wuYB61DvkLb/J7fjx2CwnWFRibAGp1TKu1Ccxm9KJxhLhSKdtirNHoz9xYGhQbMnQFMobLt3TWssJ8aAnmmzoBRRu5JU15eMsPxB+QUJ0mQn0f/laZe5NR8kq5K1UPVjhnyJRndd+RcINDtQ/5kGmsjVDTljsbCz/p4MAMckcEyqUDiok3hbaPwcEND7zKRsVV90HHW1AkdUInimISj8GIo8MLS94Kc5c9PjMDNpJSWsYkWl94OBqrzOZ7K0/mx2XOtP+mu2zeS43F16AN+9RMgcm5cbtQ9U73r5D2acFZ4awdmvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJlc1tkzRUpJyN9+irQ2XlmN1g5GGEovb683dzoi+zI=;
 b=EUYSThxprvsbso0ox6VVjKm5cn8OBnPUhiwMAnzVVtECj33O89OhjXvKRWOYZODEYAyRJwBCn/rkya8pCD387ysEU/ItwntVM8k19c5YJIC3U9tPeeC8+nL9QsbQw1eAPoKmEdiA/2GN+QERPFrf9ew6kJDmiMD2DfB7ZBFk09mbXWqlecJcX3RluIAjUEeNKJFmXsTxpqwswGgJcAD6/QxhIKHnlDubINO5wgjzdDyqL+fGPU2Tz6fqvjcLbuRrvr5YLs5IvMhgOBQqgvOW3Mq96pEgSCjBRc8u0KA4Ew/qAygse46R3pKUsH+WmIRAsXAX2FAobcH/E83iAtSCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJlc1tkzRUpJyN9+irQ2XlmN1g5GGEovb683dzoi+zI=;
 b=iAmIEuTEh+TiTWfq2qSXJRZhCfAaCjQgFZt5j2JhpM4W0tTzOuVaYML4glV+KwNQ+ChxW8OmPAugbx8UzflAodMfIl1jkryJekRld61mypcR7bK+oann2CN+JiKbkymKw3uZ62WW38Mv8EF4xJBboN9iqVC+DJsI1bC3+IMIt1M=
Received: from MWHPR1601CA0002.namprd16.prod.outlook.com
 (2603:10b6:300:da::12) by DM6PR12MB4943.namprd12.prod.outlook.com
 (2603:10b6:5:1bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 21:24:35 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::7b) by MWHPR1601CA0002.outlook.office365.com
 (2603:10b6:300:da::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:34 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:33 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Changed pipe split policy to allow for
 multi-display pipe split
Date: Fri, 17 Dec 2021 16:23:58 -0500
Message-ID: <20211217212407.3583190-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0394c33-0bbf-452f-5527-08d9c1a39f98
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB494346A8EB7DC524D70F762198789@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQGC8Wvbk6Xt/AsHwjezxU5QcL+MuEMzR7GjS6xcLfhSHTCNuruhHEOTOCn5yuHcr7WuiXYZceqHEn5dYYhyN+EVILfPRsfkq0PHSvoUZxH9klA8HF6CnUOVARRKIdwxG5tf4+ShYAn3VY+iuf6+OFG9mnN4O6xpa3NmagDdYRYGI50LsS4Fa/I8TQXqwEXZIU75GoPSqiZB8zCZ9vXQuDxfkGjeXU4z5cPWvqTKcSN8pnrHBFFe9NYqglwklaioG0ta18kogaka6ep+LrD5nJC7kPWLj+W+X0xVgiQg3QpOKsMx1Cq1KcGdHqHJADQZ4bnC5hv3DhUeXochHjpBiwEwzrxJ7pmnyLPeveITUD6ZtAmRvpa3iBiPNVzHrjOplslBtZ3LnObnuqKXJSDTpG+j7dwx9ptWw4FGe6/sesQQniy9Xa9oa7KqXPrsv3wOkzRfD7WNPiNrOqjW7kb2Etu1QCjI3rCXh9t5vXXeT/e21OKr0a7Fd6K40srUKuCpBsxgS04tkbT5T/h0ulT47qTPSBsZMUteNbb9FAR7me1myb3ZnmVB9gOsVZZtgF7xA8BvrVGYHSpdDZwSxZSVm9+3Zu9/Z49063UbV4IhiDLCTIsw7WklVWQ9R0gFAZgthAx2zQDVjJcLfXhr9cT+0oq0yZ7PWXXGsEZEPhBwRJRuj0/nRMPBRhJ45Tet4PBYyI2Qrk3sQRy2l+rfwlyMmyyWdHod48msf0oGNBJZJuPIJYmGop2CUEBT9IUPGlU5PjjIeZ99DRG9aP2nGBwM8/V2pOnW9J0+vu4gixVt2L0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36756003)(70206006)(2906002)(426003)(186003)(82310400004)(83380400001)(86362001)(36860700001)(26005)(81166007)(4326008)(2616005)(5660300002)(6666004)(336012)(40460700001)(47076005)(6916009)(508600001)(356005)(316002)(16526019)(54906003)(1076003)(8936002)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:34.9464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0394c33-0bbf-452f-5527-08d9c1a39f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Angus Wang <angus.wang@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <angus.wang@amd.com>

[WHY]
Current implementation of pipe split policy prevents pipe split with
multiple displays connected, which caused the MCLK speed to be stuck at
max

[HOW]
Changed the pipe split policies so that pipe split is allowed for
multi-display configurations

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2a72517e2b28..2bc93df023ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index d6acf9a8590a..0bb7d3dd53fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -603,7 +603,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ca1bbc942fd4..e5cc6bf45743 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -873,7 +873,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
 		.min_disp_clk_khz = 100000,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 369ceeeddc7e..e12660c609ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -840,7 +840,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = true,
-	.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index b4001233867c..c1c6e602b06c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_clock_gate = true,
 	.disable_pplib_clock_request = true,
 	.disable_pplib_wm_range = true,
-	.pipe_split_policy = MPC_SPLIT_AVOID,
+	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 003e95368672..2e9cbfa7663b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -211,7 +211,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 01ba9d656c72..2de687f64cf6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6d07dcecc953..7c64317a56f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1003,7 +1003,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
-	.pipe_split_policy = MPC_SPLIT_AVOID,
+	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
-- 
2.25.1

