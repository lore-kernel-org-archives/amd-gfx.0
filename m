Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D600FC10F09
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD94810E139;
	Wed,  6 Dec 2023 19:52:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F30110E5ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4mmL2QAeo1o8IhYBTPRX/r8KHh9e4x4PKN3Ao4xUoKMUWD3UkDAH8ccayOHIyhZvFC2N3Ni8SI50Im7G/S3KMu3UnBcLKlV16AUXbtio5n3Pe3sOT29P5N+c3pnuUFHqkgVxPTZR6ndY0ISSPEjC50y8+MghbVQQ3dIO/3ZQyiV1vdr08JFHrBnSiYorco0j9WNSntg2/75HmomV5BoIMJ9S9AGupv8uFCjPCclKLUZdMIT1O8kjGUVflw6qEb2lkkRzYpDmyGv9+FaQ9lJJ/BEYGE/E2SoZMrwfxDOIeAndZrxc2Ih2ph6L9h0+AqvO/pfqC/QB0qMGGUSCvW2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=806irAorv2hxopBUSTNfHDjXSjGsmeg/jG1THnc5caY=;
 b=ht6Y4KHeg6thEVz9uJpv9ADh1+W0W1C4pWlxPOytK1B/+yTWqDdQ7y96lLsjVw/daH2RZG/SVNwylSmJfkVLElwFRt+u2wUCi6N5oDcWsRgbVX/NGQPKBxUsE7zh4FSevCaXFMTD84gLnhcENQfM67jPGCkf0gS+fZM3D3G+Yr4/tBQEt5uBptlYx/sxnGF/gbRSOIPd/NfpYH8mMXsq6r5DtrIlQrkQQfYjf9qXfnHTKKQKmpWR2svPWYlDA5yLIm0v6HXMt/6F/DapxHUNbAlXt1a8A8Swf+9J7v6Z4XsfbUuaHcRL7VofGjZw7IIWVPFpPVcAM/ClDOcNIh1trQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=806irAorv2hxopBUSTNfHDjXSjGsmeg/jG1THnc5caY=;
 b=ggQ2ioTpXX+RntHm7RQyxiTq0F4qbvEEGTKLzNxjRm7LInaJW51wU9deXScrGMMxdX/xqxaq8wXUnxZV+3c2gJHVYDDf15jlga9Ioy+K3v2O/lbSyXtBDEddPuKTbqDp4jnwVgqH06ejN2bH3toRuXe+vwb89gWcF8I7LRoDZ1g=
Received: from CH0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:610:cc::26)
 by BY5PR12MB4904.namprd12.prod.outlook.com (2603:10b6:a03:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:52:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::d) by CH0PR03CA0081.outlook.office365.com
 (2603:10b6:610:cc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:44 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:44 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amd/display: Force p-state disallow if leaving no
 plane config
Date: Wed, 6 Dec 2023 14:52:32 -0500
Message-ID: <20231206195234.182989-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BY5PR12MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 87804719-61f0-4461-863a-08dbf694eac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJm815YvStqJfVhTIbW5W2pdAGubppvpJmuAjKLipGGBDSk/6TwkIUCZo5iSCACukxKauPFd3mtzLgEZ8OtqfmTBg7GVt4VbI/AmfvPDHP3muxBoKxrIrKgKgr4l71raONv40WRdwyZrRHjhV7/vSiiT3STQzzC3/TobRnzFEBQo/hy8iqoP83JD2Aras8+nwuD/UW3R5ImC4X/OuoyAddVFzwZ05PeXuSUeHCDDoNBqWp98J5j4p5Z9KkSvSzs+QoFLQ2FvufitaAUC4eWYDcbYyM9BE/CPKx/cTFuUUXEihYwL7CNoPhWM7+sziv2u3MJC+55DWBGlAQjizrLeYOAJQm7MNVVXuPOo/5LrLzLURqZXCSGtA69C0qRDpNv+gvzxpu53szWBkvNvjF6LBFCbZpxB/GCJSM48qGnFV9Ewp3SXu4puD/PHvbgu0nggSCtoWBA+0493QQCargMHOcNxGr4XL7wW2yywrSY2Dyz71/TTBrt8KRJ+GCxdW52fjspfSz+UL97wCL89knBjZT7YY7fB+my359lCC7RtJ9LYcacGItqAtgDaG3Vy+SjCIp6B0MijhYITjMZ7entdo+M3sSul6LiESBaAEKu7SWiWtiis09wMDPkgL+ivLb1ffr2vohDGN2H4PClLnisNho1Z2vC7C30qE/MI1dylMIXoT78gU3VPiIU5LsvyTxl6KsxZFGiTioWzT9r/BpsIqdbteTJYj3n8QOHSaf5Izjain2FlLKtd7Upp3MRSA6k3d4durGVCwbn5WnciJbh2GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(81166007)(82740400003)(356005)(40480700001)(83380400001)(26005)(336012)(2616005)(426003)(7696005)(36860700001)(1076003)(6666004)(478600001)(40460700003)(70206006)(70586007)(54906003)(6916009)(316002)(8936002)(8676002)(4326008)(2906002)(41300700001)(36756003)(44832011)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:45.6419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87804719-61f0-4461-863a-08dbf694eac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4904
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- When we're in a no plane config, DCN is always asserting
  P-State allow
- This creates a scenario where the P-State blackout can start
  just as VUPDATE takes place and transitions the DCN config to
  a one where one or more HUBP's are active which can result in
  underflow
- To fix this issue, force p-state disallow and unforce after
  the transition from no planes case -> one or more planes active

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 608221b0dd5d..c3c83178eb1e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1877,6 +1877,8 @@ void dcn20_program_front_end_for_ctx(
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx->logger);
+	unsigned int prev_hubp_count = 0;
+	unsigned int hubp_count = 0;
 
 	if (resource_is_pipe_topology_changed(dc->current_state, context))
 		resource_log_pipe_topology_update(dc, context);
@@ -1894,6 +1896,20 @@ void dcn20_program_front_end_for_ctx(
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].plane_state)
+			prev_hubp_count++;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			hubp_count++;
+	}
+
+	if (prev_hubp_count == 0 && hubp_count > 0) {
+		if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
+			dc->res_pool->hubbub->funcs->force_pstate_change_control(
+					dc->res_pool->hubbub, true, false);
+		udelay(500);
+	}
+
 	/* Set pipe update flags and lock pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		dcn20_detect_pipe_changes(&dc->current_state->res_ctx.pipe_ctx[i],
@@ -2039,6 +2055,10 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
+		dc->res_pool->hubbub->funcs->force_pstate_change_control(
+				dc->res_pool->hubbub, false, false);
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-- 
2.39.2

