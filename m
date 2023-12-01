Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A10C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D04910E8A3;
	Fri,  1 Dec 2023 13:28:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0A310E8A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdLLE4dzOJc0WkI8fNvmA2fi7OAfdk+x2r/6gHoKkufpG7mtmVcpNwy5qzXAm2RrXepVGNYY/2I8QB9mEUeLXSvb3IDag7Rj5sI4KLsUiypnlW9ZGEuhNZS1Ze+9clJF4FhVvWdJ+UQqYFMXaRHMGOcGAFWfrXtiMUR2jbmOZWj5kZtTQjqx22zHq02oVLrZNnAh58npbVCsbL/FXjicThiCpMEeQKaicZo6uk4gmx+kKKRry8hjcO40LyBxlKsp05P+6cGs6bLWiywOVWXwmttpea/a0Xl0cpl2Zu/PnUfFDKspMzL5BhX6LX3IUMSDxkY06vp+Vmvzig2P+nCggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnsACK1GPJ4qo3NwTmA8ktI0JG9rDrALxJvNe4MpmJ0=;
 b=cX7sqtKduDI9Oyr7JiSm7AANMQihNkEzE4/M3H7O4+RG0GXWry0RdNjGjfVOH+PHqdRIf/5LbcF9BJPZfbfEZ8FAqUFJLy0XVb12cuI2fZzM/H9BRUpP7U7OXXbkFjTLsehsKthjuNxCgxFKfmiM3KLfLwGppzn8wCzsbOjW/7ote8/w7xOTAzPSWwWlmEMKe9Fbm9hnVxq/n1kbPv/T124rQ7YZvNyZqnMXX9wMqAi5zh7H1Bz+go2gJZMyZviarnR48/66GVCDNyafB+2n7dsIuS4hanOKbgtWAUa5FAXxwStRw/+Lh7WR9lhxCJPfug1ZkSs1xQlqr6Xe0sfWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnsACK1GPJ4qo3NwTmA8ktI0JG9rDrALxJvNe4MpmJ0=;
 b=kFl1ANs2JttqR775dG+onxJ5EEbbPUXJceZRr3o4i/Phc0Txi0YGwQ1Ug4bXkgltiuXC471SosnfKFrBeXYX5uK9aHcH49IxgCMg/YfzCtOTOG9e/Xpd256iM96VfFeTdbGgiqRLXsBYcJRkGQ+Cngkh5iMxkQtuQAqqbi5d53Y=
Received: from BYAPR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:40::33)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.29; Fri, 1 Dec 2023 13:28:33 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::82) by BYAPR04CA0020.outlook.office365.com
 (2603:10b6:a03:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.28 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:30 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/47] drm/amd/display: keep domain24 power on if eDP not exist
Date: Fri, 1 Dec 2023 06:25:14 -0700
Message-ID: <20231201132731.2354141-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: d8de4d92-4068-4643-3f78-08dbf2716a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXQuQLR85LCb69icCwGgLk7GcdfAgU6jqnSzAL5HoA4qUGYpgH2ZN/ogFHx4XOeOtE0D/FGpFjIvLyfCIGZteGCWzvWMZzArgS1/1SZjx+za16eNHBRhBBK/WQ12QhDiqDHe7zMkHKkZ3ZS6oTywKun1i3cnYhL8V5WcwE7c83JATCtYCJ9WAKamAwD5ULQ7XaCGnAXDY4O14r7YRkIBADDVc9jB3zOsi2OD3pnFjnx7uBlaG1p3GDV7an2erUPE/9Rhuvp9xnTfhWRiELzJGJ3z2bILtNPu0xnxUYVYkccM1SQArzObvdBcmJ/OV9XLzwCWyAk/a30TdtHeGjyxuS46uZKxfRQAIuf6zlqtt9cxz7d16WOr5iP2u9qYSdw9wBnlDIQjsjNRVwDKQl9br4baA5f2Y1hMCoxZkWnwst/da4sOVfRfMj5B+5vj/1zf3u4RR1uqmgl0hc1mnln/Uvfua694WE/3iXS038AP+1GAxorJYNFTvA5Z2YQ4+HVgFg+uvK3Px71X24MRoWnVPBkoQ8+vmUcb6Nry/Mmm6/O5llvEko+TvLTrpGoI0o72sNDxxa8GUHKyfg+5s4g9UyRlndcmvz9VoJe4AGdjG6D/Y8jnV415FVJ+OfJxnO7DXyZPXHdvvjCsN0N2OeWH71QsxEzQHYjNQVLSBA3xTM5VU9TTZDERRKAFYMtQMLSGdMUYNzU36btf7uRxFgz6kRez4yDzg5YMtgPk2ppiRpYv7i1tycs6b74FWspJ+2zKCbhOgFiFxib/uOCx5YiuJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(26005)(16526019)(426003)(336012)(81166007)(47076005)(356005)(83380400001)(82740400003)(36860700001)(40480700001)(1076003)(2616005)(36756003)(478600001)(5660300002)(316002)(86362001)(6916009)(70206006)(70586007)(54906003)(6666004)(2906002)(40460700003)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:33.3046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8de4d92-4068-4643-3f78-08dbf2716a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Chris Park <chris.park@amd.com>, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

This is w/a: we need to keep domain 24 power up in driver side, and let
dmubfw handle it for S0i3. For last display unplugged, if OTG in PG, no
interrupt call back coming.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 39260371beb9..09498aa92096 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -979,6 +979,8 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
 	int i = 0, j = 0;
+	int edp_num = 0;
+	struct dc_link *edp_links[MAX_NUM_EDP] = { NULL };
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
@@ -1019,10 +1021,24 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 
 		if (pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_OPP][pipe_ctx->stream_res.opp->inst] = false;
+	}
+	/*domain24 controls all the otg, mpc, opp, as long as one otg is still up, avoid enabling OTG PG*/
+	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+		struct timing_generator *tg = dc->res_pool->timing_generators[i];
+		if (tg && tg->funcs->is_tg_enabled(tg)) {
+			update_state->pg_pipe_res_update[PG_OPTC][i] = false;
+			break;
+		}
+	}
 
-		if (pipe_ctx->stream_res.tg)
-			update_state->pg_pipe_res_update[PG_OPTC][pipe_ctx->stream_res.tg->inst] = false;
+	dc_get_edp_links(dc, edp_links, &edp_num);
+	if (edp_num == 0 ||
+		((!edp_links[0] || !edp_links[0]->edp_sink_present) &&
+			(!edp_links[1] || !edp_links[1]->edp_sink_present))) {
+		/*eDP not exist on this config, keep Domain24 power on, for S0i3, this will be handled in dmubfw*/
+		update_state->pg_pipe_res_update[PG_OPTC][0] = false;
 	}
+
 }
 
 void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
@@ -1156,8 +1172,10 @@ void dcn35_block_power_control(struct dc *dc,
 			pg_cntl->funcs->dwb_pg_control(pg_cntl, power_on);
 	}
 
+	/*this will need all the clients to unregister optc interruts let dmubfw handle this*/
 	if (pg_cntl->funcs->plane_otg_pg_control)
 		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, power_on);
+
 }
 
 void dcn35_root_clock_control(struct dc *dc,
-- 
2.42.0

