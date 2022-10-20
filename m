Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE2DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD33110E160;
	Thu, 20 Oct 2022 15:50:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89C010E4EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZjXKJtWDN0jQKmlLqjatKeAxrQFRQZA4piNgMgknSRyYffInjr82/Hw7/pl5LSpFiMMj/ZSSKOMk+2d0nEadOHAnrQj3dedHWU21kzlk0mlQ6/qzwN2T+oN1oVwM+qlhF+YT1/2lDei2uWc+memhJ8Aa8gmG5ZLfMgCDmdH/Dmdj+fFM6+4TFAPs7yK91rLPtE79XHxjFfZ/K15Z44ZrI+qFALBdoxtbs2kQqT6VGKqodCQEtL36i+l8W2bkPFdPNsZyum8GFSyznkKQu8zVgSgTGquBlm8QtZE4WeOy6X73DzE4CT5aafdf/CjjK5OT5U6JNQ/mjAIK1F7kuRtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs9/roIQhlZ1HhmyE21ZlBCWxD9ZX5tevds9rqJLb5g=;
 b=HF6Ge6IXyEPqvATVzQBuho1fXN8E4SilO32NiBK+gWxJLAI77yypc3zsypoA/vr1vVpr57jZndoWBbc7T5szhzLyuImn2KSBJdntTwg0ZxV/Ax473zMX5+Y1ZWcGkKu13LhC3w6yt69oC0bfUkegC5Mk/qt0sP74IO7unFlq6vMyasZFbJ6bi+ghS0QZEBkDn1gx0aZAuey4Jgw7YtntxPAspUNFQjT80oahaqMe8WEAkL/m2z/ZCxtnYJy6ipJov7JMmCbFCjkR5NqSDhfZ6MVA2RjtCPc8DelR0ooDtepUArV7maOZBea/FV7EMNldGmV0Fr8u9+sk1s9mxa0JBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs9/roIQhlZ1HhmyE21ZlBCWxD9ZX5tevds9rqJLb5g=;
 b=bug/+lyx7wU+ynyFCDTs3FO3VzfQ99FzU/YXElkVE5/TeM6S6VRcmIMH7e+UTzqMMfB5ayXMXg99JEnCJ7MkTmxQDV4HKR90k8HaZ0QHqbxFxU7szPfQcr4e1Rpd6QbCCzN0uak+JP2foMcFp7x8Efl17iaYnycWtgSgxi6nLVo=
Received: from DM6PR10CA0029.namprd10.prod.outlook.com (2603:10b6:5:60::42) by
 DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:48:13 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::69) by DM6PR10CA0029.outlook.office365.com
 (2603:10b6:5:60::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:13 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:11 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/33] drm/amd/display: skip commit minimal transition state
Date: Thu, 20 Oct 2022 11:46:55 -0400
Message-ID: <20221020154702.503934-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c5b535-c66b-421b-24a8-08dab2b27f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4Q5rtWUseNGGQ+0u6gQER6F+Nkd6P50R+X8/nWQ7AI7pfScPA8P4REWMg7Fk92U5z+vCvAlovtiNYM7HcpUqEAI4bWLE5I9+mq9aL6r097xfMZL6SsOuECNg4DkiUt2F+bges6ytgrbyXZalu2h0FqCjBvDIaKipU3qGIs8wCLl3c9xXuYjeMIdqWpcX8dctxSFZ58CNR7Nz+Eeva1ezxl97U2VdLnIX+VzhaSX1RnsuofjpzC6p9QWbD9IEo6Pit3tc03tXTaBFj+BWp4Rcmit/q/JbDFVYwgohmRkswrtY4PQafaGmEJu/2zJxJQIwCo6hUgLYR04J4X/s2wMUYzZ1ak++bmP0HqfmlHvox4b3lggJzMJivFissxv6tVw7JW/FmxMU8aUvRvHhMSi9XnyArQU3Jq0vBtkGxyV+EioMzketHTGT6/eMg21ZRoJFe6HwLuLX2d0xQD/T/KmZgPO/F0/WyfDkgrDgwynewKtZVkH1ruo9Jf/389XlbehmsudLe8dO7fIgioouOq9ED7peAy1RTBTdvzZn9PzYYu0mhO32lRnlm00umalFdJzIELNurjOMKaOP0xDZJ7tnTvGnEu8+FHxHZgYiKhwQL4WfYpZ22htKwvRSF6WIa3DRzdkBozv5mWiesZGrKqlxcz8z/2W3XyQ+1NXoZ+Im84QgwzGj0Dmne52XWoj5wHNRas6AE0regiyuO/vKKs3rwuHMicpOieb+/nTjRRgZ1T7RM92UHM3QRlJvc7ggSFkSiGQlaiBRy1MjFrMAqsoBLmunYLEOvvy2LfMVRGZNfydLipNtr8KwYWuvg4wgfJs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(478600001)(82310400005)(356005)(82740400003)(6666004)(426003)(47076005)(8936002)(40480700001)(186003)(36860700001)(316002)(6916009)(41300700001)(54906003)(83380400001)(7696005)(86362001)(36756003)(40460700003)(8676002)(2906002)(16526019)(2616005)(26005)(5660300002)(1076003)(70206006)(70586007)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:13.5381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c5b535-c66b-421b-24a8-08dab2b27f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, zhikzhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhikzhai <zhikai.zhai@amd.com>

[WHY]
Now dynamic ODM will now be disabled when MPO is required safe
transitions to avoid underflow, but we are triggering the way of minimal
transition too often. Commit state of dc with no check will do pipeline
setup which may re-initialize the component with no need such as audio.

[HOW]
Just do the minimal transition when all of pipes are in use, otherwise
return true to skip.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: zhikzhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f6776ccf7a0e..945b5210fba4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3738,10 +3738,32 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	bool temp_subvp_policy;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
+	unsigned int pipe_in_use = 0;
 
 	if (!transition_context)
 		return false;
 
+	/* check current pipes in use*/
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &transition_base_context->res_ctx.pipe_ctx[i];
+
+		if (pipe->plane_state)
+			pipe_in_use++;
+	}
+
+	/* When the OS add a new surface if we have been used all of pipes with odm combine
+	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
+	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
+	 * call it again. Otherwise return true to skip.
+	 *
+	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
+	 * enter/exit MPO when DCN still have enough resources.
+	 */
+	if (pipe_in_use != dc->res_pool->pipe_count) {
+		dc_release_state(transition_context);
+		return true;
+	}
+
 	if (!dc->config.is_vmin_only_asic) {
 		tmp_mpc_policy = dc->debug.pipe_split_policy;
 		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
-- 
2.35.1

