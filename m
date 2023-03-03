Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9954C7EE2F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F3710E6CA;
	Fri,  3 Mar 2023 15:44:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A20410E6CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0ekNCW5yxC8msIr6KDsZatFUnfCENjrMI0P8umKl9qeesFDrNaa2ZgvE1+Msb8aBl4EmWCjarVwOu2ZPzqQ3UOBrwDFISkiL/7jE8NnbbX+QNlg0mwJPK3y7PELDnda8oiP8OUn5z3Nu3eA7G6ycyOsDR28u5+WVj2OGOF24kRpt1TWdKWXMIHQZ0DIJ6AnqJdlsEUCwBcwxZBnIRObVQXOqF4+DkH+Y3mzGyj9gwTg/ONb4tadchx7fAs/Z83XNvuL3YjZrQ4Xm9gjt1r+Vowzon4JlJTBDb+/Y36VFTO6gjb8+dWqbCkdcqA/yAaE1pMt7rix7ZsyeFZuCgxgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHKuZCYntyUMlu/b8i/QwDFgMjLQLoJBMciOt89RXdM=;
 b=er55BBVI+0BD+DLHOaVL7PkKOy4noKPrKeFi4dqIH1MIP2BXjnJtlKbySwE3heERhXZ+8C7zOXNMGYpAKnbr4otQ6EU3xmTqNRvX8/owwivqHlxq3l3YWMHuAkas4uB05wVwQSCM3801AgtyXmvnxK7TZYw9AiUJkSSHIiOk2aZ5nNo2P0+Ej1GJLkir+7WDF8DYnyw1YcwP8K8bcvFTRFBEkf5LcurZrULu2FBYI3uR02HgefJHD7eJacFSr+XZso/xFJdy4d7XTim8s5EAXgV8kXtXn5VFh14CF6Pt5yPUh9M/52uQKxB52y7r9vdowT9VKvPLmDEMD9M5W8tCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHKuZCYntyUMlu/b8i/QwDFgMjLQLoJBMciOt89RXdM=;
 b=KBYLL9yQVVj7yRM6C+xId5ddrYfXxGaTgAYUb7JPvVhDVn2HsuQtTseLKkPjvukjAC8grDaJJjRWI7hImyBCvVC0SHHCLztgfoc/pwqgdZpTnOX5ov+0yGU7Ld6cUnvF3E2fed1D0iIFW+NBMtTofy9CRhRfd0o6UuNEJ8kp+4E=
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:44:38 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::67) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:44:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:44:26 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: When blanking during init loop to find
 OPP index
Date: Fri, 3 Mar 2023 10:39:52 -0500
Message-ID: <20230303154022.2667-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: f330f502-ce5a-4f78-8bb5-08db1bfe326f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKKVEQS06MUn7H/wi7iouQ1TtO1OGEF3NLvBi5LtY3vGH2Ne4v9l1esMUFkN4E2chfkHDtVUmSXQ1OwImZjO1WVfaIs3LHULxEZH68nzs0up2droescs3qdgURjwYbaEjMhffurUwaR8tt9vFnU0JVEMKMT4kMz+J8kzIp5J/+qWhKagNBD2Rqr75Kaf5gQzhwLXwGLK8AUaSfWNC4Lr0HAtTRRemQxy0CAqiMe2C9r6S2wUIRBh8fsRaK303ac/uf0NE344VwL/fH3khzgFZ9v4flKlyfPjlh5EV52ZglmKfyXE7cohI+qGoinxcS3Ml7MM7vstyQpCGKjnjZD7vqfGYaqEdauuu3aDCmcRhS8nYHxVlrut83Z1rFEbyy6x0+LRDeEkEatvNINXO3D4c9BQ+5E1/uTDX3qeY937IrEdXaZ12G4H9LbI+DlZgqfO9CR4m7MPrlT4KnzRI6InO/8AcLZBTEIFrz9SuZ7ab0B/JZRb8ybdDCpjS2mR3d2DcCZZhgU8xIqSiHg+7KFTqGM/TIPODkfNyBGPxtgYpNJvPIWjjIkTZrwvmAyAmGEj22JPsvFJRiBVrakqsXU0E9gZ3z1R9b2hHwQKP6N1FCR7BieMbzCEeFUk7jEdCNgT0mP5/JbME/KbTNqt0Fpp7iUbALijhfL3T32eLb7ioqBSZRHGdPJj7U1L+9aUPYwcPvValkuaiQYEbuD8YSCFPHT5mJkWaJ8HjpNfauifieMZhb4Y96X8wgfIn24rVzNScltNyHB1widv1u0uCFHAOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(6666004)(82740400003)(36860700001)(47076005)(426003)(83380400001)(36756003)(478600001)(81166007)(356005)(316002)(54906003)(186003)(336012)(41300700001)(40460700003)(2616005)(1076003)(26005)(16526019)(5660300002)(70586007)(44832011)(70206006)(8936002)(86362001)(2906002)(4326008)(6916009)(40480700001)(8676002)(37363002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:44:38.3465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f330f502-ce5a-4f78-8bb5-08db1bfe326f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
For pipe harvesting cases we cannot rely on array index
to get the correct OPP instance, we must loop through
each instance to find the correct one.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 83 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  4 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 4ba7a10dd7ec..f87db2271924 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1413,3 +1413,86 @@ void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 		}
 	}
 }
+
+/* Blank pixel data during initialization */
+void dcn32_init_blank(
+		struct dc *dc,
+		struct timing_generator *tg)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	enum dc_color_space color_space;
+	struct tg_color black_color = {0};
+	struct output_pixel_processor *opp = NULL;
+	struct output_pixel_processor *bottom_opp = NULL;
+	uint32_t num_opps, opp_id_src0, opp_id_src1;
+	uint32_t otg_active_width, otg_active_height;
+	uint32_t i;
+
+	/* program opp dpg blank color */
+	color_space = COLOR_SPACE_SRGB;
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	/* get the OTG active size */
+	tg->funcs->get_otg_active_size(tg,
+			&otg_active_width,
+			&otg_active_height);
+
+	/* get the OPTC source */
+	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+
+	if (opp_id_src0 >= dc->res_pool->res_cap->num_opp) {
+		ASSERT(false);
+		return;
+	}
+
+	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+		if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src0) {
+			opp = dc->res_pool->opps[i];
+			break;
+		}
+	}
+
+	if (num_opps == 2) {
+		otg_active_width = otg_active_width / 2;
+
+		if (opp_id_src1 >= dc->res_pool->res_cap->num_opp) {
+			ASSERT(false);
+			return;
+		}
+		for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+			if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src1) {
+				bottom_opp = dc->res_pool->opps[i];
+				break;
+			}
+		}
+	}
+
+	if (opp && opp->funcs->opp_set_disp_pattern_generator)
+		opp->funcs->opp_set_disp_pattern_generator(
+				opp,
+				CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+				COLOR_DEPTH_UNDEFINED,
+				&black_color,
+				otg_active_width,
+				otg_active_height,
+				0);
+
+	if (num_opps == 2) {
+		if (bottom_opp && bottom_opp->funcs->opp_set_disp_pattern_generator) {
+			bottom_opp->funcs->opp_set_disp_pattern_generator(
+					bottom_opp,
+					CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+					CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+					COLOR_DEPTH_UNDEFINED,
+					&black_color,
+					otg_active_width,
+					otg_active_height,
+					0);
+			hws->funcs.wait_for_blank_complete(bottom_opp);
+		}
+	}
+
+	if (opp)
+		hws->funcs.wait_for_blank_complete(opp);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index e9e9534f3668..84c1f36c3fa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -104,4 +104,8 @@ void dcn32_update_dsc_pg(struct dc *dc,
 
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context);
 
+void dcn32_init_blank(
+		struct dc *dc,
+		struct timing_generator *tg);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 0694fa3a3680..dcb81662884f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -132,7 +132,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
 	.did_underflow_occur = dcn10_did_underflow_occur,
-	.init_blank = dcn20_init_blank,
+	.init_blank = dcn32_init_blank,
 	.disable_vga = dcn20_disable_vga,
 	.bios_golden_init = dcn10_bios_golden_init,
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
-- 
2.34.1

