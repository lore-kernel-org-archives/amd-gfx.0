Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9873C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4775610E4EE;
	Fri, 24 Mar 2023 06:52:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE51810E4F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/pMWS0FkHT5wgspYmMtvL9ZwYj3OPG93tjrss5i3Ww/XtwbrT13imQDELAuBqaORqmos7TTFS6N5PYNWPUOR5/nHqmkPA9q0BpzNjQOFrMi6on1xUvRoFttv9aDyPcRBnzAff7ssqfDO1SJihgInlqQBhW5aS4kAR46IJ5/jFWomRGqJnG7EbPP1WhnH8OoF54xhJqNntFfgG3LAerTyABw+qoozuPOXGBVUqUtDERFn8KIWIKeOuX9F7v78NrsrHqYTK3KNBgH+ar7jZMUKW2hPvmO+G4VgYwMk5n1WAa2buiJOtPPq+jXuYzdDxLWhZWCHkXXP4PqZL5TpvDayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKGuSXfykk1wZHatoJhiyvsNX9Riq8j+sRm7EB0WwSA=;
 b=hT3VBxphKoOp2W7UJSGVvfCtTFE2ALFUj9EhSshAVzBh2ClW0at84GwqjqrAzY32ISRCb7qu0Llqj8d8vqY2I1lWU2pyjO1bUQLCgGgTHKcs31it+HYfrzNTcE0QDo0mw55nN3KStvmCX9OTeWliq+pvWEwNAHf0bHMlTizCsWU7pqDHlSioEKoH7CSkLsa0WbrvuvCUIV96DF8DBziJxPqDyoDkOJPb0cjK5x2rxuQ9rftREK9Lei/lVmkiNBGNM+gZ0Mc9rCI3HErs2aSQnJTUQAWWtiVFGGj/xhPuhl03Ugk4G4q1/uK+I5d5HBBlSSrXI43/h9YxFv8bhpoCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKGuSXfykk1wZHatoJhiyvsNX9Riq8j+sRm7EB0WwSA=;
 b=tA08GpSDsJ/KUUr1r3hZ2vRja1wfhhTUPDdUEXPm0Ts4tbsAkynLyJGmBkDPCoQtgN2IBIUyyBZLYMF9PZeSaH/0SUtAKGD7jjEjRNrqrtSOnplL9HjYa3CYtSdc4UgfmidOwE5LE7cWM73mx82DqD6VSFO84jVSEos1Q9uGXgs=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:39 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::53) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:52:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:34 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: Add infrastructure for enabling FAMS
 for DCN30
Date: Fri, 24 Mar 2023 02:51:01 -0400
Message-ID: <20230324065111.2782-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b84972-0014-4d4e-0123-08db2c345bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAiew1F0dT13UYXkh60GG/jtkf1XUoVwpLoEjuD+1zsALmbmqUuxNss1dwn+1/DAHGD5UZ7RL1jtEMQ0sOWGWO+IqrxHel7STxZOZr+iGeOlM1dG8wk9ZJrwr5plTSlW1Dg5R6BCeJZvA2X9pm9JGCE5FZ3SAXykUK/dFdFQwomkUxdk9oTXH5be6eQVclz5HElh4h0udMosIAJd3A5LdLM+otuTNaM7NBYErmHaSJrwurPdqhdKQallbG7DXDHWAYkWbiwSRj9tmPQK8EiG+9c8RiaZKoVGB6835DUHvjNxE+SWUikr9kDq8rWmHrFSYy4u1A/qNhdi/wMVwO43dve5Yy35d/PzFWwyIv7n2KNOdHs7H1zMqE3A/XyL/mQxKIgqqJyg02A3/F94xjaWVVAv+eXD7O4Eq+8JKJ7FfvgjF/A1P0ocRV2UbR7z5i4/x6abQ+c9IBa3EbTSpDzl7k117X9ryBypeJmR/vYmiLGppy5HHRfqE11NRw2ORU4wXJTNMgF045hlRle3GWu/2IQZ90VerzmBO+/Tm3WRlB3c20KJMLQiTu3z82hmPXMzUsv4fLlhyDEIdLRnp22p0csgrty6RMiM1QgSslVplOe+4446jW/RnqroHcv+LvpC8U+IGClYKdJ4tXvIj+H4uhyj7jP0klI93nyurbPZb6zSv17WNBzfIMxNsOLrfGXe55kn3l+EJdauZ6VLdvQPiue0cw6EXcEO7pHct19PVuU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(356005)(336012)(83380400001)(2616005)(16526019)(186003)(26005)(47076005)(478600001)(6666004)(426003)(316002)(6916009)(4326008)(8676002)(54906003)(70206006)(1076003)(70586007)(41300700001)(81166007)(82740400003)(2906002)(5660300002)(8936002)(44832011)(36860700001)(40460700003)(40480700001)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:38.9637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b84972-0014-4d4e-0123-08db2c345bad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of the FAMS work, we need code infrastructure in DC.
dcn30_fpu.c changes went missing during previous upstream
activity.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 53 ++++++++++++++++---
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 4fa636364793..ecfa395f5fa8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -384,9 +384,34 @@ void dcn30_fpu_calculate_wm_and_dlg(
 	int i, pipe_idx;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
+	unsigned int dummy_latency_index = 0;
 
 	dc_assert_fp_enabled();
 
+	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+
+	if (!pstate_en) {
+		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
+		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
+			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
+
+		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+			dummy_latency_index = dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
+				context, pipes, pipe_cnt, vlevel);
+
+			/* After calling dcn30_find_dummy_latency_index_for_fw_based_mclk_switch
+			 * we reinstate the original dram_clock_change_latency_us on the context
+			 * and all variables that may have changed up to this point, except the
+			 * newly found dummy_latency_index
+			 */
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+			dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false, true);
+			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
+			dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+			pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
+		}
+	}
+
 	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
 		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
 
@@ -449,15 +474,29 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
 		unsigned int min_dram_speed_mts_margin = 160;
 
-		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
-			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+			dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
 
-		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
-		for (i = 3; i > 0; i--)
-			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
-				break;
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] ==
+			dm_dram_clock_change_unsupported) {
+			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries - 1;
 
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
+			min_dram_speed_mts =
+				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
+		}
+
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+			/* find largest table entry that is lower than dram speed,
+			 * but lower than DPM0 still uses DPM0
+			 */
+			for (dummy_latency_index = 3; dummy_latency_index > 0; dummy_latency_index--)
+				if (min_dram_speed_mts + min_dram_speed_mts_margin >
+					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dram_speed_mts)
+					break;
+		}
+
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+			dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
-- 
2.34.1

