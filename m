Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79420ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5D910E836;
	Wed, 14 Sep 2022 05:14:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CB510E836
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJBvd9I9o2hohAqJX6WPZ7NkhXtz5BC8am4c/I7rFu4uZNhTeHJAgPFplKSCCBALvayDHA61N7+lH/ELgfHlkQ+tdR5np/ZWgAa+BQT6BN1ITWG/UWP+4hc1wW/BZxy8zV5nDiYehw6OzSqkFjPX5IR7wlhauwW7PAzRIP9kaCbIHmALa9swllvIMQXm8v+2pdE/J4qhIwGhd0rOKqx7DOsn7nGqdIt13OfSMiEmfs7R94ijU11DpR/M7aRe5EFUh6E4xVVY6kpi8IXplbWHRG410dFmtbegPu4YKcdt+/p+8ayQzyxO2Ro6xeE5b7WK7y5PJoD084liS6GQ0nLILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11veMkwzeWkiqv27eLf9H3Ch5DFJlHO39KiiMjPio+w=;
 b=AmZdq0UBWKtojPJUtVikrlIAQX6H0ktUnKG5hflR2xjZWRd02pVtXTCw61tplFwC3FAQAUbxrLj3iGRmnyv/MPu02l6UZZCH28YwRi99ClCGgsShO4NNbkidwYjVJJSWhqUURBZFwrZHV/v7Aqs8wMYeMbxajKXqjorcdeNh+GZGfCKdFTYNbMthPx2nRjq4n2zFk7gIj60Fw+S0GNxrz2iimwFHyaS/2IZOTKvb78W/Gqs8bARW+2K8DKQyECpdIQCKDslkCPelwTLmsMelfO7O7TuaUG03mhY/4GEcACisStl4G+qj865r5nWoG5teKPVIs00YlGs2m+VLEurA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11veMkwzeWkiqv27eLf9H3Ch5DFJlHO39KiiMjPio+w=;
 b=g9rk92V0vEDy4swXsQLeblFxcoQ3X69OlQ34BagxuuToRPZ7BOufXu2Kkdn9Nez28hYB22r0Et8B++XTeA1DoJoStZCIomk2ffTjBd7VeKYXdt8+pcQSQzSi1vNkjiM/9jOv/zJc6HXd1u+L9tzmMveY2KDN7xWqB23IHZQBXJ4=
Received: from DM5PR07CA0080.namprd07.prod.outlook.com (2603:10b6:4:ad::45) by
 DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 05:14:31 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::fd) by DM5PR07CA0080.outlook.office365.com
 (2603:10b6:4:ad::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:14:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:14:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:13:43 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 15/47] drm/amd/display: Disable SubVP on driver disable
Date: Wed, 14 Sep 2022 13:10:14 +0800
Message-ID: <20220914051046.1131186-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: e832809e-081f-447f-73a9-08da9610013f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/SG2yvK2wUfV7njJ4lnYMcSvwrIiNL1c+VXUxKt8D1Qep9rLw4x+/uCHhwFRRdDcbyn3EW3SVYDqRf3nzuu/3opKoHYHnU0UCLxfmHTb8OeCjxXzVJrxriXBw+EDWSn8LS0t3v/PqrF4KxaH7FDvN/Mqv9OgA1x9gIZLtg4PpxFJWv/IlvRhjTps8QXxxe5+zpsT79wyH7g8wXlsQzcbkIwr1hu/QdvYglOwydoUbDf8Hl2dzUo9uidUAVEChuM2bx5T9wWniaIrBxOhdcIBe9bxybzJTVmZRxhs4Uq+qMZQnltVWw7T7sOTBq2h/kST/XMz7ooTgZ5qv0ni7laSAfGOVZLAwWsZZ7Ow5znOwWQ0mTyCymW+kBu33rlY1dQwYJxpo9EsqDGf82LAHjzGBtfMKhOFIhGkvKqOsa8+JyLKZR1BtIwrUHzq0lcWNjpQOkawCoSjvi30Nf4xfgkGnb/FWqHMWBV93R4felfczdc/zpK3U6VbJCC6X0wYYksalfuP76BmuPuUv4KMkk6jlRNG8lK+KmcOsDE0QujsjGDHA+4iynPP+dg7f+IK73xbYhgYGUpIkyJMVDTUM1tRvdQ9+1YuCKU3SgS1bZuS2pH8iRn4Tlw/4M9p/fFoTgLtx+A3ayt184ajGTGmB3x9CLygxj72uh9H6cqS3Rk+NPPVpNJE0MxQ7Kj3GeLgmKKhcO9BX8jLdjIQWpbh7H7L+SqkjNMYUosDcx0xi7Np57jjZlcllc6yv8k0iSOJ/48XxXMCqiJQVZaIJ7u4iCPUPcw7jbLaySMdf+VvcXRwYh2T+aeYEKpRGx13pqk3xor
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(70586007)(86362001)(54906003)(36756003)(356005)(40480700001)(41300700001)(36860700001)(6666004)(336012)(83380400001)(2616005)(7696005)(426003)(4326008)(26005)(186003)(70206006)(2906002)(6916009)(8936002)(82740400003)(81166007)(8676002)(47076005)(478600001)(1076003)(40460700003)(5660300002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:14:30.9987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e832809e-081f-447f-73a9-08da9610013f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

