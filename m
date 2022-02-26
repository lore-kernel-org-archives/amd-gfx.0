Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E96C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0036D10E29F;
	Sat, 26 Feb 2022 15:42:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCDF10E29F
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzXGH8vqZswdelHGmS+3I68QPUlsn3jBjpUX3RR3WfZJWME8d683ux/ncNNrWAQwoxnK81Q/CalqvRRcVFRZeeK8mS52ib9uNM0/Xsw4WxKu9NUqvNZ/lEyFrArPFHIan2mnW7PxPZrDKsRuRLEjqye8N4Bcr9H2OhTdV3q9tWGodXSqJ9dOu4Z5bJYdLjleIfndMoMbx1zyeIjMzyh5pemsMsbw9pz2O/12qabNDO3hCPeytFUNASXCX7c+uao7Kx4vA8rvHBdETSezXX50/Qt8dEqLdQ8f6C+ipjKu7Kzsy5FjHIaGxOToWEHaOoKwUYJ/4u3VnQuAiqJTw1ceTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzpT5ibfJ4woEH+FuPRKcZ4hQvPDz1iuDcN0/RMEJ7g=;
 b=apPoBuPocSj7TSD6ZwKDc2mHJK20Zi3Ho6nsUZlLftfFnR6PsUDMGCx/gKxeBzL54qdtCC6G4e1C+q2raxKkIwt2jL9HoB9RvV6bq2t1uy2iDels3ggXSZM59HoAjvu47KTgSy636cBUOVVguUMeS5Ah7PGU+wCGpmLZrg9iH+ggzC4NdbQjs8ajBkQz2uO7V4RHuSahIPh8HGNBtHWlXt2MRJ7E3hSweZDGSeNZ0lEV53PxO6WWvJiCHQLPSh/cXpd8GdOMTBbmW+Rt4prmjHEK/fSd1oT3vFahBgvs4WJXqz72d6knpcZTWSdFpk8tHpZHCb85uTFoZYZHRniWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzpT5ibfJ4woEH+FuPRKcZ4hQvPDz1iuDcN0/RMEJ7g=;
 b=B9dzpPKibMU5VWBM4goSZewvVNtjinRr5GxviqHm45S+sHvvSdMWVcA/yfDm4NfeWNpMd6K0bBk8ycCYvJR44IdfVYVjIFCu9nqpv0AktxRr3yqk/KO6ctw1sDdWrgs36v9AZerdw9gLACdLSF5wo9cc7CVtES5/QH0uJp7baMk=
Received: from BN6PR17CA0053.namprd17.prod.outlook.com (2603:10b6:405:75::42)
 by DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 15:42:12 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::58) by BN6PR17CA0053.outlook.office365.com
 (2603:10b6:405:75::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 07:42:11 -0800
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:07 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Program OPP before ODM
Date: Sun, 27 Feb 2022 07:41:11 +0800
Message-ID: <20220226234117.3328151-9-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c0600f1-aee1-44b4-82da-08d9f93e8e55
X-MS-TrafficTypeDiagnostic: DM5PR12MB2392:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23921576A0875483DC972427F53F9@DM5PR12MB2392.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9irICejlB4fYrl6iktvZCPv74+gGJkngSFlgGmAfwf63bUep1OZEl5SJzvCNSl3s8Oq5VBJWob9OkhFozBE8RX/M2GN6y5ZYZ0FtgnTziAINLSAKBDc8hqjTAw2SIHzUTeCh4x5l9kCqh0FUQVej9GjpmUzVbH9wP8m3ul9CkEVANKwJBOre85P6Kr5KiBRPqWBVetJKkHp0B++RqBYZjSsoZ8oHWUvlnmqxwAYTIZ/s1krlEiPIfl9rZZLzkPkqAXHqzR+a9HT9kvOxD3NpQf1CPgdAAfPSXtJqQFP/9zKGL+R0zQir4oRNKVjngo1wb56BX90zj+8dlWh2pIBROU3+6L3t6h4WNrmtp9JgPBW3Y93+/+eLLvclyfvJp9vHvQ/G0Pd1WxvbuivgzQ9IgT00Qi0SMMzJwnuviNLMDqdUuAAjn3UVXpVzi1NFy8YW+1YJUuIIFP/Sa6K6tPDAbqJgYZN1BxZm6JDBh2fvgjqMtVWnhb/9j2x6ttBZF4zCSfZUCi3JmsFvHAmyTJzinI78i4F/S4NmRALMBPcpB8mNKH9uYUtzTwwz0brVn8nzXi/DcvXPk3+G9r9vZTD2kwUEL/oWdMOtLS0ga+SaWphsR6EFxMPODioo9RHpzDBjgPsORP+onmp/Rj1ETheiSSJHafb/HF7Wca+owHh72ZGurF6jVdePp3s1WBxFq9/N2Y9SrgUKE3e2OCuqEhhKXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(40460700003)(8676002)(4326008)(70586007)(5660300002)(70206006)(1076003)(86362001)(426003)(186003)(26005)(7696005)(8936002)(336012)(6666004)(83380400001)(2616005)(356005)(36860700001)(508600001)(6916009)(54906003)(81166007)(2906002)(47076005)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:12.0111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0600f1-aee1-44b4-82da-08d9f93e8e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
HW expects OPP to be configured before ODM is enabled.
Failure to do so can cause errors.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 49 ++++++++++---------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index ace04e2ed34e..e2909f9ee977 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1509,6 +1509,31 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use_pipe_ctx_sync_logic)
 		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_idx);
 
+	pipe_ctx->stream_res.opp->funcs->opp_program_fmt(
+		pipe_ctx->stream_res.opp,
+		&stream->bit_depth_params,
+		&stream->clamping);
+
+	pipe_ctx->stream_res.opp->funcs->opp_set_dyn_expansion(
+			pipe_ctx->stream_res.opp,
+			COLOR_SPACE_YCBCR601,
+			stream->timing.display_color_depth,
+			stream->signal);
+
+	while (odm_pipe) {
+		odm_pipe->stream_res.opp->funcs->opp_set_dyn_expansion(
+				odm_pipe->stream_res.opp,
+				COLOR_SPACE_YCBCR601,
+				stream->timing.display_color_depth,
+				stream->signal);
+
+		odm_pipe->stream_res.opp->funcs->opp_program_fmt(
+				odm_pipe->stream_res.opp,
+				&stream->bit_depth_params,
+				&stream->clamping);
+		odm_pipe = odm_pipe->next_odm_pipe;
+	}
+
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
 	 * To do so, move calling function enable_stream_timing to only be done AFTER calling
@@ -1548,30 +1573,6 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
-	pipe_ctx->stream_res.opp->funcs->opp_set_dyn_expansion(
-			pipe_ctx->stream_res.opp,
-			COLOR_SPACE_YCBCR601,
-			stream->timing.display_color_depth,
-			stream->signal);
-
-	pipe_ctx->stream_res.opp->funcs->opp_program_fmt(
-		pipe_ctx->stream_res.opp,
-		&stream->bit_depth_params,
-		&stream->clamping);
-	while (odm_pipe) {
-		odm_pipe->stream_res.opp->funcs->opp_set_dyn_expansion(
-				odm_pipe->stream_res.opp,
-				COLOR_SPACE_YCBCR601,
-				stream->timing.display_color_depth,
-				stream->signal);
-
-		odm_pipe->stream_res.opp->funcs->opp_program_fmt(
-				odm_pipe->stream_res.opp,
-				&stream->bit_depth_params,
-				&stream->clamping);
-		odm_pipe = odm_pipe->next_odm_pipe;
-	}
-
 	if (!stream->dpms_off)
 		core_link_enable_stream(context, pipe_ctx);
 
-- 
2.25.1

