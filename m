Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA85C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7100E10E506;
	Fri, 22 Apr 2022 16:47:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877B910E506
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QijkbsNkpMF+K5NzpsEq97BIjynReDT0q5wt8K7kMlgVnaT4+h7bkXW+nTLKB3bS+IZkT5aT+4Ndmc4TCJqk1C2lQvmPL2uWgK9Mp1nS3fa/Gj9cEptCwU556vQZEmwMAqKDa0siCQGpcbjK4dFMctdvnFZi8Nd36QBU9JgsDkZAjNXf/cmb4TGadjHH3BcCUbqbR8IFha2aiPQKIcaZN/MnCJ8hjiQf6mKHAOcNut0HQv+7oYGHu4ElU5ba+ktghwLFTXiNLe6oWhMHlKIr/r3ViTTPXnWrmp8AYaNi4MMXW+O88WewxBUcxCWr2kaxItlaQ0dXP9OeCXa2DAEliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgZI4UCbiozyBfcFJDbcpMB51DQPrbIurKdgK20QbaA=;
 b=cIDtyLnFuIsqeTkIbY0kO4zwFzc2d+IQ350dRaDkkZd5jjQMAMlR8PyZtN4kvw4p7TjkG+jGhGX/U7vC3o1gKlaKYBqjBxLY0XX+w7NuSVvFN5fnUHiZJG5Xnhga/xwje+3OGr44Hwzcoi2BBTWBRhx/a+Cphwqi+NQmUTbiax3/FnufYD1fjnFwXiPadO3B+p0YHCKyNe+eCJvuiuIdL5w3u/T+Mo3bGD3BFLb2ozae+eq42uyIPmaYVB9SLthjLscYqqNlI72vhhtBlgtVE2yw4JACjcMWy+b8lHNU6I6mhs+dy1IsoWmzsB6fOM5/COT9GeGnWwkSR6AdTUQp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgZI4UCbiozyBfcFJDbcpMB51DQPrbIurKdgK20QbaA=;
 b=aLyUTV7xVC32A+aQgbhnid/30Tdw+Q6uzZMPTcUEKmymfj3rgHpVtVaQQJO+BxtCQCx2rQR5++kDOkJYxyNFsO7RblC4ID+q4pjqsFT/1/7yi3K7otIc6aVruvtijWkCkOFS1qgDflI3s/7HalGfgnmp83UKaGLQGUX5rM9j9t4=
Received: from DM6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:5:177::20)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:47:25 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f0) by DM6PR02CA0043.outlook.office365.com
 (2603:10b6:5:177::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:47:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 09:47:17 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:47:13 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: Maintain current link settings in link
 loss interrupt
Date: Sat, 23 Apr 2022 00:44:54 +0800
Message-ID: <20220422164457.1755751-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c2acaf-c00c-46f0-8dad-08da247fc74b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2776C9C0D415369BB0BD5F7FE6F79@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRjL05NblZ8Fkr4Nxk54l3Tsbj92osbFuGTzse2SZTQBloyBqMlv0Rq3v8ftjWM/AliE6IHr4H9SyrV/kbp7OL7roNzgP6Otp/y8WBIy/jdVMKZSfoFh9KI12GvyMxZgdF99OxkbuiStDmtsyakHvrqfiqyHC2c5TbXFBOE3ZovTU4qdiCRXZvlFlEw5ZF+UJcEbMiDDuYwxjRBBqdwNJBD4AHkNXlK+peLB6RIMnLYdiuHXTMHS78IsgwmptI0A3mveWDUmYMyueY2anU0hMIUSJVXaq5RnXG0OUimP7xmkyQLl8+Yn9aUdYMxV6wXtS+1kxU5BcAC0q2Yf64/1+9YJkGWYP6jAdzB+b1Os2qSDZX20A5u67MU72r+kWWFtblRWzqgOhjml9iqt9RfRKzwjPKVxfB6KhE7lXp9RcAEgBpjmjddmqpz/2F/GQOFuhKaakV7UFV+as2sWj70QzR3Q+dXbZ26GBCPSF1u7e9UhGcKlHlCx9wto85qePLLv+2Iy6/3FVNjH154voG6CeDRhNWA55Tcce1ao6eV6jR1vzGNua+6W9RcDTzXZtxqNAY830cOIKXpmZ5XxDDUtOkdwUbkhwyZxf+o9NTo0WwHjeXfWw3nXrRX6jejWmLkLbVhACTZniN5I3fXHkjNPlavRoy7ruv5aDLOuFpGbMK8GJ2Agx75NruR603kemHR+PQWAcrQ/6CLEMmRftZl6rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(40460700003)(82310400005)(86362001)(5660300002)(8936002)(508600001)(6666004)(7696005)(81166007)(356005)(426003)(26005)(36860700001)(70586007)(336012)(70206006)(47076005)(186003)(8676002)(4326008)(54906003)(2906002)(83380400001)(6916009)(1076003)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:47:24.8473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c2acaf-c00c-46f0-8dad-08da247fc74b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 Gary Li <garyli12@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gary Li <garyli12@amd.com>

[Why]
DP compliance test case 400.3.2.3 is failed because in link loss interrupt
the current link settings is not used in the DP link training.

[How]
In link loss interrupt, use the current link settings in the following DP
link training.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Gary Li <garyli12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 10f990eefe7d..50a12fd08f4a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4576,6 +4576,7 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 {
 	int i;
 	struct pipe_ctx *pipe_ctx;
+	struct dc_link_settings prev_link_settings = link->preferred_link_setting;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -4586,6 +4587,10 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
 		return;
 
+	/* toggle stream state with the preference for current link settings */
+	dc_link_set_preferred_training_settings((struct dc *)link->dc,
+					&link->cur_link_settings, NULL, link, true);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
@@ -4601,6 +4606,10 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 			core_link_enable_stream(link->dc->current_state, pipe_ctx);
 		}
 	}
+
+	/* restore previous link settings preference */
+	dc_link_set_preferred_training_settings((struct dc *)link->dc,
+					&prev_link_settings, NULL, link, true);
 }
 
 bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
-- 
2.25.1

