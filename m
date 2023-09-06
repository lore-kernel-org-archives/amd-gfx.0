Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E0FEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8155910E63D;
	Wed,  6 Sep 2023 12:51:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F9E10E63D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jote/TyGSNXCOvWcb1LLb2VMRLm9jPrnEs/vZ6bHxx/8tWg/jddmps1b28BB4K0J6U/C6iHMbC7oD4i7KchmTqN6+0YhL17c8SIU5BRW60zaEULW7F7HEh5Ctto48WRS8GqcBKN5vSnTuZ+d8D+Oq7HQ54hj6/1LDZxStE68nixG0SFawiY/cvvJ4myq7NDOaQRQ9dhG2BP6RfC1JeJUcY0g62CLIUNIAZL1udhwyWWTqHF3wRTy8CI6GvBolxwbK3BcuNmpFk/Fw6Ub0kJLnI/fJDdWPwfadTeypnHyeKmK7dkKGT/TzebT+3HgJSTh70ZgeNKOJkwKOfmQ+QolRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQE4OMFvjapOQ4pcDdw/TTSdM3zEKY+jcdxLYZHhZEU=;
 b=fe8g8r9G4epFPoFsSkHoo8RDMv+8bC06nT3wwOMvMcbbW6LuVAmxmxZ4n7w8/oWYC7lKMs6nCjBprq3Ix2PTkcS4tGKgNsdKIERIJVOO3kS4xhJ2gW81C/8F2OWUR62agVKrBvZ40zP1c00HpIdLuU01E+uCuRFZAkvG3uMpYQvO2q5QIpe35yjs82RstoNbgjRxaHnjkUsms1fPkFceLhEeyniymS6rseeCaWy1A9EjbICMi9XMrr+fGIB/ni16vgodmLWdV5cKCpTVfKCDb30J6PS/bhW2QtjM9P2yu0FTCRqlunHoc0GfLwR2RowjA2ycLp70R/UBLWTMcK7nbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQE4OMFvjapOQ4pcDdw/TTSdM3zEKY+jcdxLYZHhZEU=;
 b=1Tn90la82NQIKh55YmWbJ5+g/TQPk4egLL9mRjvJv9VzJQvtlKkHBhE5560iUxCqmtb4xEQfBWXIZZrG5Cty3cm04437V+RYJSnw7BG9SILwTjsZWUoSVs5KPSLD5dFsQxLCnUX6BRYqYtXwh20IsbmVHNpYEMoLoWEq72KzziY=
Received: from BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:44 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::62) by BLAPR03CA0033.outlook.office365.com
 (2603:10b6:208:32d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:44 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:26 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/28] drm/amd/display: Add check for vrr_active_fixed
Date: Wed, 6 Sep 2023 20:28:25 +0800
Message-ID: <20230906124915.586250-21-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af3332c-a86f-4226-b52f-08dbaed80620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3BNHAv1PPhujes54+btMj0kAOdsnUUDAbeG9uT+VMb1N8WapOJmg4Gn+X3rBySKS0/hOIcVaYvU/WdARzdOGSxhLnrLbFQDlJGSHQ8atS/QSX42ob0lkOSTROZUPCnokRF8oEpVmvv4GPT/3TKG1HjLgpPnPeWw+yLwwFqAGntHPpyBrOxSBQsm+g4Xzvi1bAcvEQiwxULA1ysq6OJ9LK1bLtsK4iobazVfNSshkDw/SpQt3Vpqa568FL1I4nTvUCLw9evSNoHiLYExNehKjKaikr6DtnisaJpnvc4lVLM+6khtUl/PTMj3+449W5+ShEEf04UjFMiQmOwcAIe5FcuLqIIrOoKz/FIQ3R4+034s5naNCP/caydqyoxoP6/7Ckg2fyquw7o2LDG2uV0scurD5AIR7/kbDCNP1xedbtBHz+cBTmAxLHL30ITHGGvRps20IQiyGPDBDSuqdXvaXMoFA2iaR9eI7beawyaVU+lLhMJt4+xqauoIyL/BbpxChAxXracA23n6nl3UEuTmDkMCJKDhWThV7KgGhkBZR2eaTWDAEzK0NRq/u0KNn8D9Bbv92xbEg4zvpV0efD2AFnTnUjsFmtXWSkcE3p3pG5RyqPtstYkElgeLyZNlkAHjcgsp/VAp7JZEWz09bQiOhsRKY1Sv6bZa3ctac6yvJage8nw+C75NAeI4WTmpwC8dJSvhjvxQMJie8cLXQGWQbngoD+RhkbrykpEDRf1rjjf/y1yVV9gqCNaYVu3+HPSWEowaqN2FLZeIUNM5xyZFzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:44.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af3332c-a86f-4226-b52f-08dbaed80620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

Why:
vrr_active_fixed should also be checked when
determining if DRR is in use

How:
Add check for vrr_active_fixed when allow_freesync
and vrr_active_variable are also checked

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                  | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 979f52ee5604..2f98dfa06dad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -554,7 +554,7 @@ static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 			vblank_pipe->stream->timing.v_total - vblank_pipe->stream->timing.v_front_porch - vblank_pipe->stream->timing.v_addressable;
 
 	if (vblank_pipe->stream->ignore_msa_timing_param &&
-		(vblank_pipe->stream->allow_freesync || vblank_pipe->stream->vrr_active_variable))
+		(vblank_pipe->stream->allow_freesync || vblank_pipe->stream->vrr_active_variable || vblank_pipe->stream->vrr_active_fixed))
 		populate_subvp_cmd_drr_info(dc, pipe, vblank_pipe, pipe_data);
 }
 
@@ -648,7 +648,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	pipe_data->pipe_config.subvp_data.mall_region_lines = phantom_timing->v_addressable;
 	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->stream_res.tg->inst;
 	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param &&
-		(subvp_pipe->stream->allow_freesync || subvp_pipe->stream->vrr_active_variable);
+		(subvp_pipe->stream->allow_freesync || subvp_pipe->stream->vrr_active_variable || subvp_pipe->stream->vrr_active_fixed);
 
 	/* Calculate the scaling factor from the src and dst height.
 	 * e.g. If 3840x2160 being downscaled to 1920x1080, the scaling factor is 1/2.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index f5705b3e6e42..bc5f0db23d0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -706,7 +706,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 				non_subvp_pipes++;
 				drr_psr_capable = (drr_psr_capable || dcn32_is_psr_capable(pipe));
 				if (pipe->stream->ignore_msa_timing_param &&
-						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable)) {
+						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
 					drr_pipe_found = true;
 				}
 			}
@@ -764,7 +764,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 				non_subvp_pipes++;
 				vblank_psr_capable = (vblank_psr_capable || dcn32_is_psr_capable(pipe));
 				if (pipe->stream->ignore_msa_timing_param &&
-						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable)) {
+						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
 					drr_pipe_found = true;
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 2358c9100cff..92e2d1df5b32 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -822,7 +822,7 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 			continue;
 
 		if (drr_pipe->stream->mall_stream_config.type == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
-				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable))
+				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable || drr_pipe->stream->vrr_active_fixed))
 			break;
 	}
 
-- 
2.42.0

