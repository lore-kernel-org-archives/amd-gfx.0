Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FB5EB8FCD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534DA10E640;
	Wed,  6 Sep 2023 12:51:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05D410E640
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRpYBxVAi+oW4aSL0XJsDxojRGHuSNhooQz2i0TPB84U/XdQm1jip3wJZo5+PDX0QhhjJ59eO2rXzcT4bA13z49zeHbpb7Th3u76wk0TZZQYRuFoowjfCVHtYVsDONjCd35gDe/GMYl8KUa4gLoYo6kvPYLAjYeR9KHSBEerbfmTiYtt7uF5L/tIAc0YMdsO63tdbtqxdTT3H7Q0PQQEI4KVX1Gg7XwHvVB0nNyzuihx0sbtPBzJsZp5hRotU7a6O/VgsVVWDwkOVR6kbvPdfyQ4t+NL//DEHGyzym54n2v3SU+lx43wxFWhxZhU7+QiBsfZPymVxH8Tj588pTy4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvG+yWoPbDShxQ0gFGibOkwhsyP5nAI3uB+v0wGEbHI=;
 b=JayCveAZIix0xQsbSMeAvd22mIKCePGw0cr4C1ma14vWgJ3rCZm3bdwTOq9vHWWu4ZXv9FxGG0ML77wNWghYXcdoAtAok+xpubh0k9KTBQIR1TOuXReBnjjaPmn68ilSuAVPFlPou6oyej1HPDzd4K4PHhwLKdv9zsg9nVlkHTrfx1cn89PtlutKiO8I1J/GYU5BXSyfOwsZok2+7j5uP+h0abgRN4HUkx4pM/NtcutC5hQPhti++ETiFFIJPgVfrI39xs6umYKaTN5IEplEIvXdPTYPd3Nr4SfvAJ5BFUoFKOJMYb3+LaLEyQt4ROOXFsv2QMrriBQeAfUz4dHMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvG+yWoPbDShxQ0gFGibOkwhsyP5nAI3uB+v0wGEbHI=;
 b=gn3g1Q+AyySm5TzoQDrzd7Y3HNy/UQ/21RyLBuAqMHSanybvQEvU3wcApXxBCJt7tbLjwdHdlU7LToGKVJCpAI8JbehTMrKTy7Z59iJc9Krm5xn5tp7AUyZhVm7Z9z75HTb45Whivyph7HjJFhEch9S37GuBp3JiXYABfcPq77k=
Received: from CYZPR10CA0014.namprd10.prod.outlook.com (2603:10b6:930:8a::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:27 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::7a) by CYZPR10CA0014.outlook.office365.com
 (2603:10b6:930:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:26 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:22 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/28] drm/amd/display: dc cleanup for tests
Date: Wed, 6 Sep 2023 20:28:24 +0800
Message-ID: <20230906124915.586250-20-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BL1PR12MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d87a2e3-8c3e-492c-47c5-08dbaed7fbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RuRlo827mm2W2KjeJmonxl+pTdUlBY3FNF7gXxWLUzp7/GGZTea7+ZQWIdIBf/MMSFp95BQjgC/FNdCsdWdvtCEpIKxkTq8fGbZD8+ltLMxF9ofMmtMqujIytpjaLnokdA6PT+QpsWxIY7pC2GKdgoTm4oF7LQDa4cPEIPcqA6eJtnDpQ1/LENvCn1CkrZzJtym+l7RD98Rniz7krgZENoNNZGZBP1zYVUUV4aBBLWpvia/anpNTX0MrxfpAlPrltBtwJ3eBuDSIhq/8pcKL+6gTWa1KY0ob/K24BREZZjepS/X+IXrli41+Q3xvAoAVzfXNCOEDHXsQ2IJlue/6qvnsOGmafBlGLRsLR3SuuG6mXe0BYVom1Y97Yj09oRxF1iCfLJVC7KZh3daNomUhOg8lav/Z74FVenVKFPkBb2fJXrwFcv30TtMRm2VPDmDBUbqh3DTWCgH90EgKeEdoyaZ1IB3uCqgPo5/0oBUI3rp8EMPiTzTD2Q+PJI/rDPGmMf91scDOCtDsv61agpocAmo462Uz5g4ddsBVYm2Y5UZjnsB7/4fuePtYyeaWHTq5HMKBui07BqCoOutIWIFHEaCWeaE1EmIL/XFnwWr989X6lq7ieICCRQHIadQo1+FcTrmtttbMlEhegmCDVBCUeLOzT+Vu6/LXD7LNkCpYOoigMQtdTADG232UtZDJvKkC4YVnQQhSLG/f3r3/emFr29NZ2JcdCpEgZvQf6e0AcpYzOmvnqNWGgiwrS6SwJ1RYFh2J9/s0l/sPTSw0osc9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(8936002)(8676002)(4326008)(478600001)(70206006)(70586007)(44832011)(5660300002)(40480700001)(83380400001)(2906002)(41300700001)(316002)(86362001)(54906003)(6916009)(7696005)(40460700003)(82740400003)(2616005)(1076003)(356005)(81166007)(26005)(16526019)(336012)(426003)(47076005)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:26.6061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d87a2e3-8c3e-492c-47c5-08dbaed7fbb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>

[WHY&HOW]
Code cleanup found in internal tests

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5ac85df158b9..37cab11d1b31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2855,7 +2855,7 @@ void dcn20_fpga_init_hw(struct dc *dc)
 	res_pool->mpc->funcs->mpc_init(res_pool->mpc);
 
 	/* initialize OPP mpc_tree parameter */
-	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		res_pool->opps[i]->mpc_tree_params.opp_id = res_pool->opps[i]->inst;
 		res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
 		for (j = 0; j < MAX_PIPES; j++)
-- 
2.42.0

