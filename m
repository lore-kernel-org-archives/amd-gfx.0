Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C44FECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D149F10E805;
	Wed, 14 Sep 2022 03:51:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8051010E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqaXQoHq3poit5kOxuX6zBwFsHMTf7UUXWT8NNTYTQSJ7/R2EP6c3663T9J8qoNWXxAxg1uyeltDTiQ+TjoVj74jt8Xo3GfMqWAiNET+WAzkk7DlH+RoMlsCa5paUvRy1Ac80NUBQ/U399bpIvcFW+guuDU2Mb+AqdP8PkiPmKEOIyJtrBDYmSSaEjOYnv4+V+0G3eW/sUqZ1zssQeBlih/jTy8draOGyw9FWA6E3p9z4PdpYxGia/ldtncAajU9ReE692+0vpkbLboJY46L7icLHSxImKKrD7kylwyPO/ZpQaf9VCwUitjyDh+tDb22CkTUN/o+g5TAbNI6p2351Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11veMkwzeWkiqv27eLf9H3Ch5DFJlHO39KiiMjPio+w=;
 b=f2mPruOgsF+XXe2rGQ9VvcP9xnfU9tNxeSyMoyuWqBjfxv+3265I1rk3hkthcEZENUN3h7oeVNkEpfPaQWvE3c76RHgXR+cEfB2js/ru1mCNU0DVsRVQMNpCdN7L08ikNmrATgyGvL/0zBaxFiuTdUBTvxEMAycYtUtL+QxKCv0m8VrUL8YJ5UkaHn2+b8h1RM2MG+j/biHtLjrSdtIjVOv/6xd6W17oKafjLLeNUkABEtZqi4wTTKAODS+cX9dpD98JcPwAuSHv6NgBJkOEccN2D0zm79M6uX3E0AGf8PQKss11T6RhDrnjU8js/3wnnqnENL7U8lqTDH4AP1PvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11veMkwzeWkiqv27eLf9H3Ch5DFJlHO39KiiMjPio+w=;
 b=Fxt+Y42TanPE88NiaZs9Gx4f/C0dmD5WNzXSoED8N8z46G7wUwF9FV9zIrOW7pw3nDfENTOJXeEGx2Rzq95QlfYCnwflGxLGk3rJPGNqeFxuWqztgMCljPW5KHU5Aac1L04wRldrhhIJ2mgy4U6uVwHFTdHWZ/ZQicbWtx/ZiMU=
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 03:51:10 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::99) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:51:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:51:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 15/47] drm/amd/display: Disable SubVP on driver disable
Date: Wed, 14 Sep 2022 11:47:36 +0800
Message-ID: <20220914034808.1093521-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0fd9e6-af02-4c26-1067-08da96045cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AAi+YrXF4pDN4XLhIY5/wndAhbEEGoA4yBdX9p6CH6fWXVHu+pdrCq5LZcQbNn735sciGlNp9YimC3MizcgW3HUEQa0fl5/ML2E16nhiOsKQi3Hij5j0Sf7y/Pq50s2i2szvhv82fXHkMVtduiBnNA0PUOd466z53sRWvqEQtPw1FRGzQfFvGLxxfpbi4kNssz7/NBxt1znhem75IViYJ9AWvlxx2LkkpH0i+MaRQBDR94fhD3p+rNpeNObKc4q82fEHYIXxYjNKgrRdQ8+bZVtprwgAdDGbzJi9rhzh4BqatXnYd1denXAspIGmfXAu3vjzK8Ay0XZ4L8S1IFJfF4eiBmIy5bVxXqhKAvCrf9JBlmRTBEZULFKj6Q6nT5SMrA0ItFm7TfLvA7M77NJTxudaIxqUVVd23RO2kJ47zKRJqs8IYPVVE9wwf6huVzcEwTLIDoSpQhSB1ZHxjyJ6jon6h69aEzAcA/Hh4t2tuyx0Ly/UvvPkv51Do14O19ID88S13e8KSxFTSJKchmbYRcHAKZkfzBqv44XNTIWnLjvzF/vuHZj9o2SsKE91Tg6Quhr9lZYehF8wKtQTK2p+fQDfQKOoXnv6CZN2K/uVQaLmfxsJ9WD0ktsQAqsR8dJZcGuS9VPQIzl2o6bYZ1ldA6SEb/KTcE214BVes41hQEf1HZ9fdUSMjncxoDBoV+aO+Fym5139PnJgf6LrCn2jeEiE5+VAV0ZNbx9gyzhGtIZSHYt7UIUCS0iXd180C1PaEwA8Tx7iktcMGF7ZD4z7Gc9EmdDaBG4E8DOkYzHfO3PfZ4A87wdAnaikhuPUC/i
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(6916009)(82310400005)(70206006)(356005)(54906003)(7696005)(86362001)(186003)(2616005)(316002)(41300700001)(26005)(426003)(2906002)(40460700003)(6666004)(8936002)(40480700001)(1076003)(5660300002)(336012)(36756003)(81166007)(70586007)(47076005)(4326008)(83380400001)(36860700001)(478600001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:51:10.6584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0fd9e6-af02-4c26-1067-08da96045cd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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

[Why and How]
- For driver disable cases in current implementation, if P-State
  is unsupported or still supported by firmware, we force it
  supported by DCN.

- SubVP now needs to be included in this case along with FPO.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 21 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 9f5b47b9a83d..7e438345b1a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -85,6 +85,7 @@ void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0
 
 bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *dmub_oca);
 
+void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, bool enable);
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index fb59fed8f425..4a1954fe3f7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -939,13 +939,32 @@ bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane, s
 
 void dcn30_hardware_release(struct dc *dc)
 {
+	bool subvp_in_use = false;
+	uint8_t i;
+
 	dc_dmub_srv_p_state_delegate(dc, false, NULL);
+	dc_dmub_setup_subvp_dmub_command(dc, dc->current_state, false);
+
+	/* SubVP treated the same way as FPO. If driver disable and
+	 * we are using a SubVP config, disable and force on DCN side
+	 * to prevent P-State hang on driver enable.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			subvp_in_use = true;
+			break;
+		}
+	}
 	/* If pstate unsupported, or still supported
 	 * by firmware, force it supported by dcn
 	 */
 	if (dc->current_state)
-		if ((!dc->clk_mgr->clks.p_state_change_support ||
+		if ((!dc->clk_mgr->clks.p_state_change_support || subvp_in_use ||
 				dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) &&
 				dc->res_pool->hubbub->funcs->force_pstate_change_control)
 			dc->res_pool->hubbub->funcs->force_pstate_change_control(
-- 
2.37.3

