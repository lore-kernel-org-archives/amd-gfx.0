Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF390C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DAD10E627;
	Tue, 10 Jan 2023 16:59:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5237C10E621
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT6+L6SRDV7+G7+g9OjsYwAP6zDG7J5hoO76+KyWp+FETt4HJ0PcR+hxRd2MBY93iZjaXPx6jvwBPEXJi7gU0JEgpBlfSX6akOZSKT2zTBGJcUcZZhUgJNmq/8r1FWONkp69T753nd1cqXUBPmGG7uxChEkkxgctZosoyOrcWZH/bGh4rfb4BrTQhNT4omOq/kij40PInnrkVAnpmOA+BLO6HLilFfZ2eDW2/nhhVPGvm0G9R1QOBs/+CHoKdUs2gUc8lkM7rC4AZwse4lJpkptd+Hk+2VjhutiTY10dwAaHQWloHZRAS8/hnn3vMSO3fq3+gA4c6gtuDvEq5sLKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URRwHVHwsq8NF4Oxg2iU8YrKr6QAio9o5sny67G0RYg=;
 b=Jdws50/F+t61bLl7R4fRvOIsQX727pH/lEwLs5HQw08us1fdw8Hma1bCgUUxD7bSGK69XaYOtA/gibIXDo/Pny4S4FPUSCFuAwA4gGeM/sqo8t/cjzgN34hnBLHFVOx5JtVaZdrG0DX4Xb4mjHaXE0wO/hkMclz/IF5x8rbU5oQ4928CucIqXjulLArvBnC49aCNqkH5mvNwt7iFzTUHC4XK9VgCYuYdmJyYeN0aSYdK/ARlNuGXVCnK7vWPjWx4ycfVtVNoUeB17IprOaiEXztxJzD4xsF24K2ufbBgzhejK4+9I6QUqRju/l3bDY3aK0Y76zIFnoutQhlsL60UyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URRwHVHwsq8NF4Oxg2iU8YrKr6QAio9o5sny67G0RYg=;
 b=PZwANimfDM+tiToLOsFeZzdE4OAOKM5jzEReFC3dyk+KTR3pD/LS7q08dJGvRtcjv6kk6Z4FqdUrydIh+ys3pUApckAnbqBe5/xdEeU6tu/tfCSdE0GnwX9F53snrCYEcnRX8z91fr85X9U58Y078yvXBEbaG/vXRieP24BwRZ8=
Received: from MW4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:303:8f::24)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:58 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::20) by MW4PR03CA0019.outlook.office365.com
 (2603:10b6:303:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:58:57 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:55 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/37] drm/amd/display: Allow subvp on vactive pipes that are
 2560x1440@60
Date: Tue, 10 Jan 2023 11:55:31 -0500
Message-ID: <20230110165535.3358492-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d052e85-e492-4fcd-8edc-08daf32bf706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehYCndJDhZX7iIwiomteA8Nk9lWp82UN6woRI/KWIbaLZ8yV2naPkYJD84vmcwkuJOCNcbc25Rsvjm0NNxCaavXrbCEB0pguw02h9w4noyDM4rnXHc2ce2ePobZDLO2qLQct6cp8Cb/+EBOJsXWpgWj7aQNioirsGbliI8ahfuPYwddTzGt7ieJsVgtpDPLweHM+TUr6ip8XdpNSEdYIksId8rhbP1YT150vAKHRFylzg8lHXP5ixYP4MFExzPGbFPr6CRRsff7NAr7kzkhj+sY0014/YA1Kj/ZCbH8+XZNXs7C2tFcYlf0UqKMZ/TYMy0Tv1gdtRwViZTOgqP5UDeXN4MdFBHnW3crLL+ngpnGOiAg9yRy7FpFPceVptH+xEJdgU407GB3FMFNg+gCUTsZERnZsvGCsKbsT3XIY/95VIqKdAMzpjh+MiQUSfZnkNNoUkCPM9CLFsaKIAhSg1apuAYVV8oITguuSvORhwM6w+3JzRaenITfGK8KRqZtiKMyaifsOa3AbypE1X8uiiiS2pVGUEPHyczEdVx+J35XMrldyqZzOknEA0Z9SFiFgqH4SKqHMn7Dzd7E8MeH05IXSmWYY6HSrA832eEMBCWhcNCkbC313KI7HBa9q9RqfRN3grwWkrqyoj6QGrr1+AdN2MX5kioVs2SUIPgKV7FcqWc5uMX5pvep+tUHcr3cphGNnoWNyqHZy7f9irm8yggW4pbRABwIb++SWdt7xgc+ktlXqFIMm6g9EcnOG5j3FQRqhlsOiNBZqH83xzCHfDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(86362001)(6916009)(8936002)(70586007)(70206006)(81166007)(356005)(5660300002)(4326008)(8676002)(2906002)(36860700001)(83380400001)(478600001)(7696005)(316002)(40460700003)(54906003)(336012)(82740400003)(41300700001)(82310400005)(186003)(40480700001)(16526019)(426003)(1076003)(2616005)(47076005)(26005)(6666004)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:57.8329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d052e85-e492-4fcd-8edc-08daf32bf706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
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
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Enable subvp on specifically 1440p@60hz displays even though it can
switch in vactive.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  2 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 31 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 40cda0f4c12c..b07d3b0e6a5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -144,6 +144,8 @@ void dcn32_restore_mall_state(struct dc *dc,
 		struct dc_state *context,
 		struct mall_temp_config *temp_config);
 
+bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 2e22600ad5df..5b928f3b719d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -694,7 +694,9 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
 				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 && !pipe->plane_state->address.tmz_surface &&
-				vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
+				(vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0 ||
+				(vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] > 0 &&
+						dcn32_allow_subvp_with_active_margin(pipe)))) {
 			while (pipe) {
 				num_pipes++;
 				pipe = pipe->bottom_pipe;
@@ -2675,3 +2677,30 @@ void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
 	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
 }
+
+bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
+{
+	bool allow = false;
+	uint32_t refresh_rate = 0;
+
+	/* Allow subvp on displays that have active margin for 2560x1440@60hz displays
+	 * only for now. There must be no scaling as well.
+	 *
+	 * For now we only enable on 2560x1440@60hz displays to enable 4K60 + 1440p60 configs
+	 * for p-state switching.
+	 */
+	if (pipe->stream && pipe->plane_state) {
+		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
+						pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
+						/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
+		if (pipe->stream->timing.v_addressable == 1440 &&
+				pipe->stream->timing.h_addressable == 2560 &&
+				refresh_rate >= 55 && refresh_rate <= 65 &&
+				pipe->plane_state->src_rect.height == 1440 &&
+				pipe->plane_state->src_rect.width == 2560 &&
+				pipe->plane_state->dst_rect.height == 1440 &&
+				pipe->plane_state->dst_rect.width == 2560)
+			allow = true;
+	}
+	return allow;
+}
-- 
2.39.0

