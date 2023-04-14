Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18686C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A7C10EDD4;
	Fri, 14 Apr 2023 15:54:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7D010EDD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp2SE/CD4pe7M71bQlR+V3HyCeIJMl6DEJXWDopKbiZBKO0THe8UMHK77XsI8sv/NaVdiNHciga+MI0Cu7o0Am4Nw3Sn7obhGte+ceUBTEkAzIKZmDI5zvqg6CSeCfX5hQtiBAP2lLF0owSopl5X5aEW51+sU98QElVSHX4puxg8fgM73cL5gGhSQvxIFOFP3iUrwyVFB3VX1OdCSQwTArjS1CHiPr9gUT+PtvXP4u8r/m+0IB+iq2SplXq3AVFrgbhKlosqLbs0tzlgSwDrrl92/dSEK2iuoXrFGLRgjBHKjpJi3jpQtqbUICtvTajiNgUVt8cQ1eFeILy/DdCJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL7LpkOz7b6edeVrRJD7bak0ASB0YrjO2n4FyUjJlMk=;
 b=nn2T6A10hfSRKcwm8acQZlRRWONJ/UgO6P/5do0o5vVjX9Zf21s9i7/2I2/xx7FXgtYy/bp5h44i6VwNpqDt/Q4w3ujcxrXFIK0kmcj9hUC4efZSIZd0siu0ng53Cx2N0dVBY22CsedgytNUPhgYA+FRJKW9r3OGRdr869+MU6LM7C1y2hyxrBw+GMe+MY67oO/ZA6j6I0vaW0kkR2pSDnor1UM/LI1diEuzFHPfnAlapxf0mMXE6jrMjVg+sJf2JlCpgt0qemN3WMi6umeePssM+dpbmMIZQAmvMjWE1NYr2mpMN3iJVkgj3fg7s931RY8xQK+Hd0wEgesSIte6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL7LpkOz7b6edeVrRJD7bak0ASB0YrjO2n4FyUjJlMk=;
 b=Z7QkHEpMRoxpbImQnm5LSaaOUeETueWTFKBY+vkFRfjkBi8z/bivHshIjg5+pYg16l8sSZdU5ZNkHX4Wf95Rd78AiHHcIR9g5zwTikypO84xho3T5jGqUDw7kjoStMemNvRbqI/PUaVGCdUEOUDIvIUK3l1jlQjqyQu5hYuIyJo=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:29 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::38) by BN8PR12CA0036.outlook.office365.com
 (2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:29 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:27 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/66] drm/amd/display: Set watermarks set D equal to A
Date: Fri, 14 Apr 2023 11:52:52 -0400
Message-ID: <20230414155330.5215-29-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b54342-19d8-4af3-8267-08db3d008811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECywr8V+RRufB04tE3cT7c4AKAOu2yIyV6cpT2sZ5h/ZsTeabK6xPXy/vxkQkN44qpm8ZzZHNX+lmCRo85vCiuWL4v0pb1p2cuE7QUJ/rRXdw1oYnsqwuFNeTzZf06Iniv/IoFZYwt63jiHnkgncyDs23fRrxPINGdGmTsOnX9zGERICpNE3bdu0VMTy9nY+WodD2XEUqT3xpcHvNjbOFP5mXGU3mRwlFFv1v1+Vg1Be486iD1PHjf7QEpXyDWKVhNffRKLQbw7rlbqgSXMQnzVfCBkXCkdF8MpLi+4uwnmQZaGeBN/+ulI40n3eom3CbYF1nImZ36dihNCzFN0y9XswGPwRtKkygJd1h6+zH1h0tVPkcRgmXsF/GIglWB70HlRRQvTLplxQ53alK+kkGIDhjlxN6GLKIR1JSnIi6FmplZ/ah58UZlFl+NPFFCqT4tP1roP0OsuxiJLHGzHZdx/CAASODtwZCVQKjC+hGCgEppIXOtfL/jrDUFTLJhR7R5tbHtktnJZ2ZZypErve1agQ0i5217cUS/sYSc0wZEL2cO0HhfYv2q96890OxJ55akzqEDc/eiZQ3qHJrsZLLotdiBtahJNDCBY4WfEO2/sQ/3BOuCeGej/jTcx1FVMImXnj4Y9d2XiSXSnuLovejZzXjVRItFPvaybyMACXjtKWJPel8MPL0dQLtRV30s7+SHdmHH/nxmXqh41Nz1DICTVh/1gjCMyaj5cX6s4jiwo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82310400005)(2906002)(40480700001)(186003)(336012)(2616005)(6666004)(83380400001)(426003)(36860700001)(16526019)(47076005)(1076003)(26005)(82740400003)(478600001)(70586007)(4326008)(6916009)(70206006)(40460700003)(81166007)(356005)(8676002)(8936002)(41300700001)(54906003)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:29.4731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b54342-19d8-4af3-8267-08db3d008811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
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
- Since we do not use optimized watermark settings for MALL,
  set D = A
- PMFW uses Set D for d0i3.1, so driver should make D = A for the
  time being
- If we choose to optimize in the future we can set watermarks D
  correctly

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 23a972f2885f..2f7723053042 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2062,6 +2062,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	 * sr_enter_exit/sr_exit should be lower than used for DRAM (TBD after bringup or later, use as decided in Clk Mgr)
 	 */
 
+	/*
 	if (dcn3_2_soc.num_states > 2) {
 		vlevel_temp = 0;
 		dcfclk = dc->clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
@@ -2088,6 +2089,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.d.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	*/
 
 	/* Set C, for Dummy P-State:
 	 * All clocks min.
@@ -2189,6 +2191,9 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		context->bw_ctx.bw.dcn.watermarks.a.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	}
 
+	/* Make set D = set A since we do not optimized watermarks for MALL */
+	context->bw_ctx.bw.dcn.watermarks.d = context->bw_ctx.bw.dcn.watermarks.a;
+
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
-- 
2.34.1

