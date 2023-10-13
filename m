Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4F7CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 08:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C791310E09D;
	Fri, 13 Oct 2023 08:56:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E5CE10E09D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 08:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Y/x3Yy1lHeyqeBhFI7PLzId15PlckERGH+cjSO5axEUrE7SYATvTtkhduPANqbQhRb4/3YsVAhm/DYe1cBaACrIZidwlskrkIShOQtcTKQREmVZG6vJm1ZIoCqtlRdYQ1VSgAIVqN/loFFXdtd8LeZl++17yELIqJkG6vuUgVLgPG+cObUKly7yVnwqaW3oVc3yteZ5SuLPvi1zi5apmUpVMZQM0lUCNu1iEXWCJnv/gv81WUDGoHfQ0p2sj55hrYWGS/1XZQ9DOLEdxz22goKp2DDXWtKZk11Ke5jzHKrLBchYIWq3WEHPi/eJ8C6vEQCMIpSQUP/YgqfBrCCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNRmO+Sb8aGKlQNShXQfBZE7AqliubdqnB36oN7ujPQ=;
 b=mbXbT51fKoz+8vdMFl2v7rgInUIEC+64TQt5zpCh9U7+oAn1YN4Kr+DgkS48t9vzzCNh8akY7RqQupBZV7mzGu7XJhJEqemiYTcv+l+xclepZoUzK6gTMCPg7vC3lh5smREO4N7TzJsUIKj9TUShBdnTznqE1pRpX8wcd/FbdSRoA04KOUBng/yJ6qTsS73j/24ZG75jzTy7vc2yAO3R53KwwADf0lIC9ipF49fQDtX4vk4Hgte0xnRq7KA5Pb0q0xZAm66B7GfztKSRS+p2Q8b920+u0buIN3fGb47ybEItg6rMcngn5q8yUZBI76DjzCO1CtvBjU8xcNiFuPsymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNRmO+Sb8aGKlQNShXQfBZE7AqliubdqnB36oN7ujPQ=;
 b=OvrILzAQkw61lk5hCMAtU2Vw+n2f2dG3Ga1Q/TNyF2B1NnVQnsmTO3V3vYlywFk0QiXhhXF0pjrr4F26E2kXj5BAGhghz9TL1lCk7rJcsNKDaaBgxHkMyEOVMwvAryEPC3w/ciGixXa8FZnWBMKeqNTrUJVtGeYZWP8hAhBqMOE=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:56:32 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::50) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 08:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 08:56:31 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 03:56:27 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add missing lines of code in dc.c
Date: Fri, 13 Oct 2023 16:57:47 +0800
Message-ID: <20231013085751.376014-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: a4746284-9faf-405c-dbe9-08dbcbca4bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggkxaiFXf7qdARX3I8BpcTc01PADsXCjml+Zd/hul0aYVSI1uLGPWYpkbEXEIWGoXjeP2p13xwINucoAttFNQ7HqLMdeZS6WhyZ7fXCW0+88iut3/JW8SF6ACxrBSq925PUKtLbM4BJ4KNCYdwPfHhnpWshqG9LdP6RpPeLshxfjdYsPRQ13y/KiMonI097S2kSAfpxu9yecsJQsWuH/VO+A/eEHrBr3e1U1CKRJLhLLvJYCpwoIdWouCRHNfos6JlxZWDnrqnKnbKx5s3NPITTOwucL7jgB76va1vl/Rvc10Oh0pZGX4dnFkgj0jS4YWM6D3PO6Ua5H3pLddyY6gh3f7GahXmh0E+j1jd95r8Kl/5yQuKPDHd3GcPKvA/VJ9r9MtYo3Ehtu2knR02Rq196dUacBeyUSQ0HZyKxF821voIur64wImkK9x+k0mGB/f7yvp39lnlnQ5ekiyzts/lRdu0N1hpzJMImhWcvK3FHzwv+huQCfeuYaGiJwdEHn+gdSO1ISZXZAdaEOy1iXHahhRynLYkRCf/OvlBwkW8lz1Xc3FcIHyQS/lie+HnTmTe1EMxavYM3kzQTX1nbv2xM5ke4ijt3vs8cWFfZa/zIURDF1PvVCnNmtazFwyv3OY0TL7U7LkVzqO7Gd+WRnJItUiD+8saM6rB+TYkEOTFdsDFox/uUYxc4ELmzKPCD5ZN7vpBUNsZs03yfMJqgzo+QBeeH2H4x9MbhmbUsAWZ+nh039m5klEN7HgoD3otk6oGVQnqng4mqvk0YcIdWNjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(7696005)(6666004)(478600001)(83380400001)(1076003)(2616005)(336012)(426003)(316002)(26005)(16526019)(2906002)(6916009)(41300700001)(54906003)(70586007)(5660300002)(8936002)(44832011)(4326008)(8676002)(70206006)(47076005)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 08:56:31.8782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4746284-9faf-405c-dbe9-08dbcbca4bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
A critial part of "drm/amd/display: Fix windowed MPO video with ODM
combine for DCN32" is lost during promotion to upstream. This patch
addes the code back to dc.c.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f602ff0d4146..e13d8bab0b33 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3096,6 +3096,9 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	if (update_type >= update_surface_trace_level)
 		update_surface_trace(dc, srf_updates, surface_count);
 
+	for (i = 0; i < surface_count; i++)
+		copy_surface_update_to_plane(srf_updates[i].surface, &srf_updates[i]);
+
 	if (update_type >= UPDATE_TYPE_FULL) {
 		struct dc_plane_state *new_planes[MAX_SURFACES] = {0};
 
@@ -3137,8 +3140,6 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *surface = srf_updates[i].surface;
 
-		copy_surface_update_to_plane(surface, &srf_updates[i]);
-
 		if (update_type >= UPDATE_TYPE_MED) {
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
 				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
-- 
2.42.0

