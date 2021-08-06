Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E1CC4320A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2948611C5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2948611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5727895C4;
	Fri,  6 Aug 2021 16:36:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669E96EB9F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/JVKBYeAog+o5+rSfIx8x6VnTXLq/4VumPuMzoRp8AJZY0rOVTYVNYTNCM0lT+iJaq8srG5q3SIUw7qaS7ymLQKrbcFpa5DIa3SwGyiJq/X/3or2oGleDXYAVzwuVwfaJe9uoTGvJNyQYW2XDIDzHsyAi/gpGvgCE5L/4AeRPu7HcS2NFAhTpb6pkJxLKEm1y9amIwD5SFszPIJ97Iplv7eigcmKDBF0TDER/KEELnWbZlEpDBajw81n0qlfH7eSAjpMr8QXQfhCfPuHaPl6hdm8C3P4zeNuq9sn53vf9ynkyZECchKootCU4YmNMUJMHh4PA3RzFtdwEnPJzYzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttH8u/a5rQcKcMf446AoVo2HxhMhQFEFqnZBV2tFmI8=;
 b=XFkRSBC+8hDkJYH4U66P+Gli3HkM4zjxkzUSFr9t7EeyM5jR5SuuDJVQGHt66d3VJCShGux4sDKIXq/wmMQdTVdcKyEC+jQTnULPKfONdrZQpR9HM6jRRYx20pilBepMYEE7lxzDJQXZj35GLnW8RQQi8pA56r11KMjeVQvo/JjqcIYaLyL+P2IaX+dpuqiI/BAgEwU9kvd3XQZucBlCrjXY045e4D9xtLYyGXig7u0oOqhflNW9WzFeuZYPLEurjhRd3UT4Jw3UArnCVSt9yvSzWesJIgEIG8/vmm24IVrma5gAnFD5hPJr5dyjYnoSrmTnR4Wq0ijV3KwtZxah9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttH8u/a5rQcKcMf446AoVo2HxhMhQFEFqnZBV2tFmI8=;
 b=cpaDbiLEsqe2jIWeFVhh8BVelntK3WlmHnoO/pEu0D+5LNANfNw/HrBgFDKj6tarnX9/NOpqofSEmPGE8l3irX7AoKdxSrz5TFEC8KvKE506c0XJaSTOZUp9s5QpamdJKa+NnHCzEQqFTrwQVMI27IEbp6VIOHbyychp38ax2Mc=
Received: from BN6PR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:404:b4::17) by CH0PR12MB5154.namprd12.prod.outlook.com
 (2603:10b6:610:b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 16:35:35 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::69) by BN6PR2001CA0007.outlook.office365.com
 (2603:10b6:404:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:34 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:32 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Roy Chan <roy.chan@amd.com>
Subject: [PATCH 02/13] drm/amd/display: fix missing writeback disablement if
 plane is removed
Date: Fri, 6 Aug 2021 12:34:38 -0400
Message-ID: <20210806163449.349757-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5ba77c-c162-4bbe-c2b5-08d958f83717
X-MS-TrafficTypeDiagnostic: CH0PR12MB5154:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5154EEDD402D3D194864AF19EBF39@CH0PR12MB5154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKOrG44+9Proj3AWSTIQXYpS867pIsELmEPgcJs1ZA5ONfDdh7Gj7356xniP7pJC5PbMFwdtpqTYs2xmHsT/nhEzcAoF1bKVbjRSOUSwOmEmZM6AJ52/Zn9O9llarGeQpBRxmPhn6+lvABW9FH3ErSOuDG3OBoC/1zboHIBZr0fKmL2kMhxtqXdMCJ71mmgxZ+1kqNAzIiE4xlxPpI+PyjCFsbRlOpwBvUi2T8VF5vuMmqEsgQuGTRvsgXuCc5p7pXblLrZYiZJgi+hTOhgIkgA3GSlDBRoaGcbRfWPnvo6/bBDdY2PHJcPW2fjrRbStywL+37FhLdGKVv5nqdEXG12/ScJ8ShBkEz6m1brZrOkCBQ4xFLMhGTAeiMdtsy4x04I4n77bLVwkROqbCWOQkUPeYoDhZs63BzbAL+Fotjla7lVBpkEUlKAutGn60s9FSCSQ7LCWgk1oR+D+/eMQedAvxb8dvUCoiYt3XLcxh2eA1thheCZl6Ow2wbQhBtzYwjfv8tU2qkKIJWolXs932gKHgjMtXvSA/lNLH3uA1v3L5hXsZWOj10kaQUENw5xB8Eko5C/ZCbeYklt7r+qgaUhDL1/SilkdBPFktUDLSPiESEFB994IOGfTnYNLm1P3Ij5QLk+dejgItBuoJQ+V5YyN2HXZt3X7VjWY8OTNmx/6+D7RweFrGPdpx3cf+uSOjEg6XMR54J1yO95oOPYuuxcLZ28IUTGIa3nq7QdF9ug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(426003)(1076003)(2616005)(316002)(82740400003)(54906003)(83380400001)(8936002)(336012)(4326008)(86362001)(26005)(6916009)(70206006)(70586007)(7696005)(36860700001)(81166007)(82310400003)(8676002)(5660300002)(356005)(478600001)(36756003)(2906002)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:34.8643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5ba77c-c162-4bbe-c2b5-08d958f83717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roy Chan <roy.chan@amd.com>

[Why]
If the plane has been removed, the writeback disablement logic
doesn't run

[How]
fix the logic order

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Roy Chan <roy.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 14 ++++++++------
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 12 +++++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5c2853654cca..a47ba1d45be9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1723,13 +1723,15 @@ void dcn20_program_front_end_for_ctx(
 
 				pipe = pipe->bottom_pipe;
 			}
-			/* Program secondary blending tree and writeback pipes */
-			pipe = &context->res_ctx.pipe_ctx[i];
-			if (!pipe->prev_odm_pipe && pipe->stream->num_wb_info > 0
-					&& (pipe->update_flags.raw || pipe->plane_state->update_flags.raw || pipe->stream->update_flags.raw)
-					&& hws->funcs.program_all_writeback_pipes_in_tree)
-				hws->funcs.program_all_writeback_pipes_in_tree(dc, pipe->stream, context);
 		}
+		/* Program secondary blending tree and writeback pipes */
+		pipe = &context->res_ctx.pipe_ctx[i];
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe
+				&& pipe->stream && pipe->stream->num_wb_info > 0
+				&& (pipe->update_flags.raw || (pipe->plane_state && pipe->plane_state->update_flags.raw)
+					|| pipe->stream->update_flags.raw)
+				&& hws->funcs.program_all_writeback_pipes_in_tree)
+			hws->funcs.program_all_writeback_pipes_in_tree(dc, pipe->stream, context);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 2e8ab9775fa3..fafed1e4a998 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -398,12 +398,22 @@ void dcn30_program_all_writeback_pipes_in_tree(
 			for (i_pipe = 0; i_pipe < dc->res_pool->pipe_count; i_pipe++) {
 				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i_pipe];
 
+				if (!pipe_ctx->plane_state)
+					continue;
+
 				if (pipe_ctx->plane_state == wb_info.writeback_source_plane) {
 					wb_info.mpcc_inst = pipe_ctx->plane_res.mpcc_inst;
 					break;
 				}
 			}
-			ASSERT(wb_info.mpcc_inst != -1);
+
+			if (wb_info.mpcc_inst == -1) {
+				/* Disable writeback pipe and disconnect from MPCC
+				 * if source plane has been removed
+				 */
+				dc->hwss.disable_writeback(dc, wb_info.dwb_pipe_inst);
+				continue;
+			}
 
 			ASSERT(wb_info.dwb_pipe_inst < dc->res_pool->res_cap->num_dwb);
 			dwb = dc->res_pool->dwbc[wb_info.dwb_pipe_inst];
-- 
2.25.1

