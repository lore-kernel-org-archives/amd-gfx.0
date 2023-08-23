Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4046EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952EE10E472;
	Wed, 23 Aug 2023 16:05:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C878F10E473
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laUoKoer+Im/x3hAyu6rJyS9BlhWmu0dSXRnnhOk7KoKAhVv4IWKn+trMuymE0B+U5I5SOdu7UVwUAaxNojMUBC6eIelceDQNRSfFQl7Yc2LGIleS0uDs1/uhQsMAIu2eguV4+Ai5F2n3FLkLzQjuqL/HJL+bvOKRJYyidZqD3e2mOs6qXs+uqhaKuGhZK4z/NC3y2HPI7WEkmWVY18vMJfAR+kHmsLdpJeGkRGfIiKt1ubtam1l7M1oIK5TlGbtympqwOrnbv0TM5oKNosSvuHZ2eDprTJ/E31uzf85w+Y1ql3MT1pSjV4de4hFZV7Cj3l3kLSCnpuPmsbUdAJE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLn3NUw1MzoKFTpERbbQ4LLYDMCGqcNW2OFoK7V/QZM=;
 b=j0Jo6PTwtrLmq8h3ZYQvfKQRZ8/iJE5QsFom+FLtmItqRKI7mx1yJdxWjrCIQZs3+8hUEyTrUJsUWhzGiJ58D4MBMhaTM1PX7SV2W9RE8leccUAaC1ib1CBAeZy4ekNxRBvWuu6le3VJGom8Ct+ngT0tiWo4Vj5eq0xFIawuYm09qHm/fnRycGliIlQeyosF0oL/+UaaTJtWTWfPWu8CTqzf19rPbHH9fBavHI5yIaU0RzFSmb89b+zr2R5H0rQOstKx+IkQclZQEmwGHS1ovgyLbv7SE5W0HbanrPBmaz3xRCXI2sGhfWZRmk0/nXyVAiMj/HBbIudhs1psWXWOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLn3NUw1MzoKFTpERbbQ4LLYDMCGqcNW2OFoK7V/QZM=;
 b=ffhYq38Z3/ZvWhZl4FjLv80B+ej83nLaOYThAZ1O3UikFBEakErF5hppFJgqf+cIPc1dW8UNpDhEegGgCPMPEA3M6ogTKI76zCYPLiLeTrGJ/JNSRFXyMTbKZ9k35OTPwiVj1ot6bXR0PxpdFRMhwh7RnJ9bm9j5inhSe3d1L+s=
Received: from PA7P264CA0116.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::7)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:04:56 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::30) by PA7P264CA0116.outlook.office365.com
 (2603:10a6:102:34c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:55 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:43 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/21] drm/amd/display: fix pipe topology logging error
Date: Wed, 23 Aug 2023 11:58:22 -0400
Message-ID: <20230823160347.176991-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 9859817b-e3c9-4fe2-7605-08dba3f2b145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7r4EFCoGICFzxZ3cuUImZZJK+vbTrv+TuSE40Zo9xLQlvmGnR9QJgh3owHh7LPDSwz3cElGGKmfBND1z5erObgxfRol1pL3UesjFmvS1ugKlzjlpGCmQK/ajg/ECEme9jcl+uHA54G8+gtlL6eMIl+LtUxTUV6kgDuhXkoURIMfQRTjecCrRs0ya/yDMybnov3SxAXl79uXKQWmQoCK4ZLGENFXPpKsNADs46LHstMUj3YDXIFuFgO929/VWIoyg+Bq95H6xz7r4e2Nd407HO6tDM5wTdCELsABuw3axvWt4RA/BHmJdyLAXSjY6of1QRkNF6nrtYEEx1PGHGzDxhbrFqAONV6b06Ww1LQEdo1I8B07J4UZ1zV79FmV9EGQvNMqBqzjAADlKa7HrQRza93v7X82ARaVrDDOa93v4YNqZ9BRLIPfUoPHlgTjGaUVJGCqm6g9HNt8SFbvb9H7+7+f9r3gL0vJ9mCagSgy2gIfBgKmS8/bpGU35i3zsIapVocuE12D2Sb7QIikLh1YNP0pxYm6JnAIFoFuWDIyenr8eYPoe6lCx5W7nj+2ENY7REVxMCovHUXU3FinIecWfTTWwL+mEWcuBNGsXKMOtrfXXRtNQf9VSR1EBtVVh0ySB/wRXfoUM2w1yx29YHMyzdBP1CMnRjtM+LSYeyZD8REESUqu1EgSeph4W0a519iWFmEXoQeqPJT4+zwrJbHH2xHcgGuHtoqyAvSM9P9h1qdQwHQLx9p+kKNDfmhdB2w1s+muCzSDtGrO+H3kDrHNyl/dSD6cSuSN9mru4UUGQnRMpbod/3OayCR4RA6tkYtut
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(316002)(6916009)(4326008)(8936002)(8676002)(40480700001)(70586007)(54906003)(70206006)(41300700001)(336012)(426003)(16526019)(26005)(1076003)(5660300002)(44832011)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(36756003)(86362001)(2906002)(82740400003)(356005)(81166007)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:55.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9859817b-e3c9-4fe2-7605-08dba3f2b145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a logging error in the recently added pipe topology log.
If the plane with index 0 uses MPC combine, the log shows that
as two separate planes.

[how]
Initialize plane idx as -1 and increment plane idx before logging
any primary dpp pipes of a plane.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f32337122f5b..30424ba7761d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1996,8 +1996,8 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
 				&state->res_ctx, opp_heads);
 		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
+			plane_idx = -1;
 			if (opp_heads[slice_idx]->plane_state) {
-				plane_idx = 0;
 				dpp_count = resource_get_dpp_pipes_for_opp_head(
 						opp_heads[slice_idx],
 						&state->res_ctx,
@@ -2005,15 +2005,14 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 				for (dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
 					is_primary = !dpp_pipes[dpp_idx]->top_pipe ||
 							dpp_pipes[dpp_idx]->top_pipe->plane_state != dpp_pipes[dpp_idx]->plane_state;
+					if (is_primary)
+						plane_idx++;
 					resource_log_pipe(dc, dpp_pipes[dpp_idx],
 							stream_idx, slice_idx,
 							plane_idx, slice_count,
 							is_primary);
-					if (is_primary)
-						plane_idx++;
 				}
 			} else {
-				plane_idx = -1;
 				resource_log_pipe(dc, opp_heads[slice_idx],
 						stream_idx, slice_idx, plane_idx,
 						slice_count, true);
-- 
2.41.0

