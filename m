Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC5C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B467D613F7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B467D613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538336ED7E;
	Thu, 29 Apr 2021 07:54:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D2B6ED94
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4WoHEh2EP5MQT13xuTAePVPcz0EpsKS8vKHooBkR+Nqz+iGFCMuCnIHXp9Fe8FtPfv0ndZ3u6FakU+F5SsPmWVIsSJAPPhMgOvh6DQHldb/gdPe1XAtC1Fx/k7/nx1KUap8nv8y2PXVH9iVERmWH0Yx+/hOxq89H99HysWWDhxUzCDbR7WhlAFdd46sT1g79b6w53NwWl2oKgKYcwyywcUyPKp8TDGZdnFpljvTtfabo2KF4vvA0SrtAcyOeteqdEIz9ZeTWEtV0I+QPwgv2yThUK1CYrMT1Ycot0QOOC1KyBNzCXbCB+rZtmC1Xnhh9I+JmqmJqw/lg3yUo0bkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ECpQAUa3fS+59IFPvIWDMDasSiDZg+zmh1WE1I012c=;
 b=F8fhRZ7z1tUzUjYfK0bipzOosKv/EBO52ch0PsJDv+rsQO3VOp/9Bjtjr/FPJR2eZHNVOPH8bwgywQLAmLJSZ+cNwHm0WIpGC9VXuZ4ai0ULf4Jtun6Ho+r47McmNLbAUpu16Jlp2bhOs8uHqtXp7Ns8ZQ66pFXZuEReoperWHdZbpyiIt/8OjtLKDtNwaryg/QsvC8JTY3Vrm9xvsXYLvXJgPZV107lvqs64mn2QgBOznWiKJIoKtCj5S6TT7TuhBM0YsymlHokDtkUrIHqk4umla1byQByBog7/hKV6UyGTjUtGIM7JKVr3+IUG9gWsMSMF762HiONQG08wL0x7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ECpQAUa3fS+59IFPvIWDMDasSiDZg+zmh1WE1I012c=;
 b=BzL7xRYEAq3fcZswnhYGVKXdTchZ4KrXo674qZBQ9Ngg0vVbqEXYa748TYgyXrNU8cabohx6h9QTrU5eI5xsqT0fzieH0agWXg8H4JP4QyEKrKtUhOa6r8VZhI0uFy3t1jKi8nb52p8yKFlCWer7faG6WdVDE0rrWolfqQd60as=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.26; Thu, 29 Apr 2021 07:54:14 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::f9) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:13 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] dc: Revert commit "treat memory as a single-channel"
Date: Thu, 29 Apr 2021 15:51:54 +0800
Message-ID: <20210429075206.15974-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 301ab280-5b21-4c30-f33a-08d90ae3fbc7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2423:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24233A856440B338845770F1FC5F9@DM5PR12MB2423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRl8Mq0pw9qA+2vV959UMV+oHmNPqeguH4qCr8FFJGpY+UGpvdGuYW+Jqcx4HphJmf4usZ5glitVx/kixiZzkc4uN4LB8iKCmIHjManySGsqM2s22tCrvmWNEIcD5aGIhc29WOo594De1gtEnfRiO5IYTeCfjHOum511Ux1mOg6cAmVysDiiTuNAgB2FDnVRL35l5r4Ufrl5ZHJy/9Hf1DdrUauuEFnejN0erIcwpCevNcFh5lyba6zPro53elhYn2q+bn6UC8Xy+us9gpuZap/yPQY1iLl8D9k4uji6si/7uAgyntS9fLyKcjhpf3fqJiY5jhQsGwJUxqucJcLrsUWdvfcY1Y/bT/5b849YPAAIialy6CoYMif6ikjgiSCHdX54MD9nOUzKNi5RxDa3gcOWBZjHndJokJgUvEbOqGBPUxlRVcCwZeuGf3yz5JgxETsUAde21io7mQSG09xc2T4c+QFYJf5saUoG8B6voQGYPyb+tQ/QMmC6QnjJ2G2Bvf1kkVA66tPrUby8NdTWJidPtfMWNUGzMznAvTtDEjPJJ0M+1IfQQ7Wq9f4LBzlzmCVOUkLJJwIV4X+S0gu/khU6I28HZVhuglJrtdQSpv2wrY2CSZYxHqX0NwgNS20t+rb4XnzXEXyGQVarbuj2SjnmqCOpAZ4J5P7CNiQEGmyqY7wiMng25FY8XCFng5Kc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(82740400003)(83380400001)(81166007)(186003)(86362001)(82310400003)(356005)(8936002)(5660300002)(336012)(2616005)(426003)(70206006)(26005)(8676002)(70586007)(54906003)(36860700001)(4326008)(6916009)(1076003)(6666004)(36756003)(2906002)(478600001)(7696005)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:14.6685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301ab280-5b21-4c30-f33a-08d90ae3fbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit "dc: treat memory as a single-channel for
asymmetric memory".

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 48 +------------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 -
 2 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 49d19fdd750b..887a54246bde 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -761,43 +761,6 @@ static struct wm_table ddr4_wm_table_rn = {
 	}
 };
 
-static struct wm_table ddr4_1R_wm_table_rn = {
-	.entries = {
-		{
-			.wm_inst = WM_A,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_B,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_C,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_D,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-	}
-};
-
 static struct wm_table lpddr4_wm_table_rn = {
 	.entries = {
 		{
@@ -982,12 +945,8 @@ void rn_clk_mgr_construct(
 		} else {
 			if (is_green_sardine)
 				rn_bw_params.wm_table = ddr4_wm_table_gs;
-			else {
-				if (ctx->dc->config.is_single_rank_dimm)
-					rn_bw_params.wm_table = ddr4_1R_wm_table_rn;
-				else
-					rn_bw_params.wm_table = ddr4_wm_table_rn;
-			}
+			else
+				rn_bw_params.wm_table = ddr4_wm_table_rn;
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
@@ -1005,9 +964,6 @@ void rn_clk_mgr_construct(
 		if (status == PP_SMU_RESULT_OK &&
 		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
-			/* treat memory config as single channel if memory is asymmetrics. */
-			if (ctx->dc->config.is_asymmetric_memory)
-				clk_mgr->base.bw_params->num_channels = 1;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dba2584e8986..6ef1dcadd454 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -308,8 +308,6 @@ struct dc_config {
 #endif
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
-	bool is_asymmetric_memory;
-	bool is_single_rank_dimm;
 };
 
 enum visual_confirm {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
