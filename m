Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868B6CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D6210E4DA;
	Thu, 19 Oct 2023 13:32:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A6710E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4tWTLsTQpP8ozPFH1dGTYvtb1cNCMwQtpFAJCBuC2uFx7lzan9FaiOoyFZQCTeHAoDj7crj9PSZeb3qSs8/RoFR5zJ7FRznHg/tSi8C0/nbHoqbYFmG4+Z+M8wwffwh2ya6evuZbvJ/6SfnbSkyiU1VTMYuKNM3ljXbkbFpGJUbb04fsp2j0IfAnuOugIMMKbcQ4w8ybrTwmDteYsRpaTDAwGSltSEtQdGbPN+fV7gu/5FlZWVYTMd/VvCtQmVbtGgwtOFhxbnhhbQLk/qdvhGQNZ1G3tDPRujV8qPQkQFjyxYmjvQglTkQ74hMo5nLZ+JGRHUaJAFsxyADTx4KWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5il+aInxCRN7J7TSeBPcYxClt9wpGuFt5MInc7K5RE=;
 b=XTum6XfcZKUpSvtIym+4Mq4hXnX3sVM8b91OjssogXaLK+4d7GpDNz0fnYaiu3LG5WJJ4flT30QNbcjbgDEH6JAwwt6243ifbJ/EahofEkCnM0Ef+IpvXrfzQZUGTXz4Q80Jdvkdkf4T7+r9Np9OWFPzBFzie/KHNdMgVYA1EZHTyzgLybExx8+7KjW86A/YSFAdO2EZb6zPSk3RkxwHgp0zBOT/8v4h5ssK4ICjjAgbrb9k4Gp2ooT88plSikiSQ8Kgz3d92ZyXocqvZg8uyoEnZEpp0WFWwA/QQmcTGSG7H/3zO7LWk0xYsVEiaQK71gTGOON0EEzZq91km2yZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5il+aInxCRN7J7TSeBPcYxClt9wpGuFt5MInc7K5RE=;
 b=3Hw/7E+jIkxkWi5Ni9AbVOMdY6RpSFkqKx8FIZtYhrwtBgF2BKl1Bl+ZEoM8FyBhiTDN+DwP9tp/+c9Mwt1zqdYMIXkqXCL/NwV9r8uZBRJualS8Y3SC12CD3qA89rGMoAgYQpBmNktn5AhQ35TBI6XFIdiGt4s2KPNtvgICj5s=
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Thu, 19 Oct 2023 13:32:39 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::9) by BL0PR0102CA0014.outlook.office365.com
 (2603:10b6:207:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:32:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:38 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:32 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/24] drm/amd/display: Fix MST Multi-Stream Not Lighting
 Up on dcn35
Date: Thu, 19 Oct 2023 09:32:01 -0400
Message-ID: <20231019133222.1633077-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: c893a2d8-04ab-49bd-464e-08dbd0a7dd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ES9l7Qju3jlgiRCveTb12Z+JbowBFP9mucDUnV1AyVJfFNdVKhxmBpLd8J0Nt4JmyGwE7W0I5CwC0sB4ypk/qaHqlG6ChxlSjXyObE/zWJaRWQg/1p5eRAC/lj+zombsMkMVgpq2tmD1HyiUyOWgU9Md3xQpMjJb4fEyWL9zZ/GSIIpJUGWF7tG9425PDt0BPJcFQ+7TQT5+yk3xUsnk4otEfsFRUaeJh7cQpKXQmKCflcjbIGMsnd893G78w6dlvfOlIxG+sQwy8yRFgT+Gm9ilVfXJqrxVVaBS6Y4eo5MSf/WXF18fVdFXtG86M/ZEb8qHjmgzGr683BrQ+osl0d5Zl1FWCm4GKDNJ1ZAoYOhF7Sv9sDfsBpmdju/r+aTz6KCEipxEg3GhQA6RlEOcUVUmHrcO6QIDfe90oJISSHp/S3qXol4T5od/+7uaIhlHUeuwyKTVNc94MRIoDsl51iRHeuGYsImHPhBmSsdK8pbPSxkNDd2m1Jqv+riLJB05glRdNYYfj6JFWuP1lxnNCKtKvOAlQ8NbvnXds7+60MJPou278hHCTWZ80mc9zqs0laDtKvsEBYxHZgE4/yKD+5HmzvhI8wCXFTfs8D2UUxIxfbFdr6YESHh1W2yylMeioLZwlsJtBpfm5HhnYk91fwFYfjUrfe6yniMHt35pUKdMUal1PSnnzec+STyw9iACN14r8Wznp/mfKV3vHYHCbnUokC7JQPuNywhXYoV2yC+JY3h/XLKmTiqEMcrl0G/v1c9US6qg11z+DVWrwRoXqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(4326008)(70586007)(40460700003)(40480700001)(82740400003)(8676002)(1076003)(81166007)(2616005)(36756003)(26005)(356005)(6666004)(8936002)(336012)(54906003)(41300700001)(6916009)(70206006)(316002)(2876002)(5660300002)(7696005)(86362001)(2906002)(478600001)(426003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:32:38.9732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c893a2d8-04ab-49bd-464e-08dbd0a7dd13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

dcn35 misses .enable_symclk_se hook that makes MST DSC
not functional when having multiple FE clk to be enabled.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4d6493e0ccfc..608221b0dd5d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2746,6 +2746,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = dc->hwseq;
 	unsigned int k1_div = PIXEL_RATE_DIV_NA;
 	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		if (dc->hwseq->funcs.setup_hpo_hw_control)
@@ -2765,6 +2767,10 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+	} else {
+		if (dccg->funcs->enable_symclk_se)
+			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
+						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
-- 
2.34.1

