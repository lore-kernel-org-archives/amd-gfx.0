Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD66CC61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585F710E2E5;
	Sat, 18 Mar 2023 07:57:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604A710E1FB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxKthB9lRwOXboQRngc6MSQsKySKHBEFNzipKNAGAuxUdYIScGWnJ5hZoijf64Kzb1HrddjDoUSFrDOjVW0V5CSHf9pgSuXTpUeOfjy/EWNF1HWPvYHVcyPWjdonqbywTMkKVu1Kj0lFqh379ns/yR51HpY54xhplcG1PmN2M5e3cvPYFWcBpjMIejBdK6Mp6SIWQMZOLUDGi09NgW38ATWGMF32u7afSjxsYaCHI26pLwhXQgG0J+i1P1gxP01DOTgmZ6+kXQpvP5eUUF0OpbhzunVjoCS7eSRjMjgHvXfqqaa4JuXJnfR1eIB4wk6d8m4LhXbPykbiGiGN2jYFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGjWYOJOI3BRrL4+zycNn8DvioqO1XiR45d/mbo8VjY=;
 b=jjqjsJFKhfjixdZAiJOHs0g+X72v9qXTTcJgukVC2kcbFTdJW4CQOHStSR5qA1skaP+ys10MPzg7iUnKhqVHRLhNLBZvVNhCVXa/Pmb1ls+vzMvDdlVCSnpOkt+9og10gBbcIK2hBJqmOvG6aWN9n4op626/mICAr3/CzCSIksIoXYRPH3v4oNxZfZyruVJ3W86jtZCNq4MC0J29pIkRoSinU7VDM/7U/8oi45QCttTzFJemRzOwKNSm3K+0V4OPR92LATjfEwAMfPB8GlABSnKV+jqiQkn9lyklyo47h7o431pjCTY1VI3ADnGzBdwKHfEThu4hKmoW/VB+CSfRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGjWYOJOI3BRrL4+zycNn8DvioqO1XiR45d/mbo8VjY=;
 b=a8uuLAfowBHdddjQjvCnu32liV0wkzEJCMdKFcsAIIDdAFR54H+rqmi+a+zq7ghY62MGXvB5diwX4WVH8zg4IYUluM/PCQ8nudFuoW8+NMOXTSya30oa36KM/BIkor9iARdBaga9OWV/0PzfMBhL3mU5bl/TWMTR4MAM5OAQ9rs=
Received: from BN9PR03CA0109.namprd03.prod.outlook.com (2603:10b6:408:fd::24)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:56:51 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::8b) by BN9PR03CA0109.outlook.office365.com
 (2603:10b6:408:fd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Sat, 18 Mar 2023 07:56:50 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:44 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: Make DCN32 3dlut function available to
 future DCNs
Date: Sat, 18 Mar 2023 03:55:59 -0400
Message-ID: <20230318075615.2630-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f73fc9-2697-4174-9d0c-08db278654da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWo/cpMjo52wmzEH/iqBKpE3S4tWZyNMysMVMqV/oHIlCRsi4xL1wTyMlb31AIfRyhoTGnTAqHtToiV7Z+mOeWVFbUi1ISs2F1fbNBHW+dKCLX7jjX6V2LI6dN1yVm9aY1RvgcM2DWOnfPK4S3dVWjqElTPHZaLctEfYksfdJ1Fc+UG+6/Ivz3bL7/oy+GLZc3Jeb4yVresAVpEi6jxP07siUtde4tkQXMIh8qajURLGmhAYgi76QeNyIn/J6pwxGo3aBs1U3B/Ew2mEpFRq/zu7n9ZeZ1B1jKikROS1iqoubltt2PHUxdfNqlSS1bcIVA4YFWt3SrIpOgHEVRQ2BlvIQWNmHTZULNUGhw+BmPZQTjSN83QsPmuXQLAfxRcLWyrpH2B/e3BCeq+BCQR+PYtXxYH3E1GSl3i65ctCfWiIhMRaZy6REwbEGi8U3SSR7nG/nM/W2NPIOsSpCh7v8uK5hYZFcW3e6pll0o9LDrd0n4x6qLm1nLBZlDm4AbgvNCBPcNyNryqogu22nfyTOXCwuIKuIf0JGyI3Jg6NNakuwMJwb34LBPt/5/bE2IE5exj/7tVYfWMHHBBsEwDaAvKDGSJEJ/0d0yRzfhWfpuKsNqJRaeMXc7/Bx/KgT6ImUa9QON20pUR/WCuLKxGzvt4IzX0uxnLPHL9BoPjPWZIjsSOGGZcRErjWo80aMpYMfqI58GIp6uCRcRGmDC4mO0N6ZYrFiYJHBPkX4Sx0zdw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(82310400005)(40480700001)(36756003)(316002)(70586007)(70206006)(8676002)(4326008)(83380400001)(478600001)(54906003)(186003)(6666004)(1076003)(26005)(16526019)(2616005)(426003)(47076005)(336012)(6916009)(356005)(44832011)(8936002)(5660300002)(36860700001)(81166007)(2906002)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:56:50.5302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f73fc9-2697-4174-9d0c-08db278654da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[Why & How]
Make DCN32 3dlut function non-static and thus
available for future DCNs.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5016b1313f3d..42255c22605d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -414,7 +414,7 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 }
 
 
-static bool dcn32_set_mpc_shaper_3dlut(
+bool dcn32_set_mpc_shaper_3dlut(
 	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 84c1f36c3fa6..2a5376eb9d66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -54,6 +54,9 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
 
+bool dcn32_set_mpc_shaper_3dlut(
+	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream);
+
 bool dcn32_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream);
-- 
2.34.1

