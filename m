Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F5CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0A510E413;
	Wed, 18 Oct 2023 17:42:37 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0B610E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPUTOAa+3/l5OiX3V6thPAxe1beIx6fl6QWo3qhK+Ye+P3ICd6H4nvs6C5inYOqOtEto86VvafuITjMcX5ID3/sqCXYc20l1XYNwo/uHCVMrjw5ZPuvQnV/NdtMT2ZnDDnqmA24qiStI4lPUzIcMognbGEjIOnJn4nSrqBS/58ygnjUgkuacsPMwwHcLqF7JeLJmPu2z4KfShXOD6hMSxLTUW+6btNjPMEccLbS8IO+qfMuhm/uGkMSBY0uXc6eDtEjB2s/Bt1c5HqivQnZt6JytHvyOW34eiPWl9Nvar/6wx8+QQSwIpEtLEpJwr/L91temLWNk+45vVtlLHoa4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5il+aInxCRN7J7TSeBPcYxClt9wpGuFt5MInc7K5RE=;
 b=HTxFumDv3XrFvWn1unCjz9oTKbbBJ9CWa9o1XMhQNbSwmFTvlrJB8bIuZhP/DJjpkxXHk5Ri5u7YNo0GRUccbmw5WbkdzHidD4ADCVlvo6vJoWKTRrSgA9YaH0Y48oa9mq/WFZu7LIR9hKDHhBV+dfXdpwKYEvWbAVLt5OeRFz3AAvA6eFxCUaNcxvDShDPPGkvptvichJf89EwQhzdAm7bZn0gjuMDg7AEy5Uq437FS2cw7yLf1iV1NaADsB2kqagzJtEJayPyyTeiusP9J++nGDO6WkHZmnVFzuljBmqrIRyA5A3QU+8GNbeBIShjVSnzLb3nu4/BCoCIX03Ui0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5il+aInxCRN7J7TSeBPcYxClt9wpGuFt5MInc7K5RE=;
 b=rvfvRAnb8BDQTlzpCRbaweEEGk+nuEBHvAwwUguocN1H4AgwiRz1OEW/CDvyHDWpRTOdX6X5sHhz+jvEG1aTR8Y5rnR4qajV6O3WJp82sKL97rJ61DcYCLT2bw3sUnlEVCaTwoJh7IAN4qZzQ7T5nYnlAZTkmwok4jVPWa0QwnI=
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:42:32 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c2) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:42:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:57 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:51 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/26] drm/amd/display: Fix MST Multi-Stream Not Lighting Up
 on dcn35
Date: Wed, 18 Oct 2023 13:41:11 -0400
Message-ID: <20231018174133.1613439-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY5PR12MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fe91f8-cb88-455b-bf7c-08dbd0019b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tWK5qGQc2vXdoYobNIGfVsCJ0mBko9jcyLqDGGKcinOhqTKFL7RT6WPCEs0AKQcysydOsJZo0fF+rXX1eerUvHhdf8EvfRR5ihkV8gJe8LnQOArg5Xnl+lgIWHApQls9e7I6QY6fLeRXHes0NEzlQM0cFw/YfJyd6sKTuqgaqmGVXwWg7ieGfgiEaOZI7BmL1x0KWuYkU9LSva6DQTYKR58ninhbGAkA+PGwLgaETYy9UPvWcrZFZDCcdNGePEKdqms9emdC6/gKKwLS+xoTt/wF+pAj3UP891/E1bxyjSCLW5ylFhPwYDdIxeu1xjMGmGhf20P3mS4fNrLXAdAD2w3rTdp0ofaFJrp3ztqu3c2YEYVyzjXmc+B94DEQHnE3rpLZ7t1rnhEX1Vevw4Dv4sl3tfURZkXmiea3MQoCM6RgeUpf3cU01W7MKIL1E3cLemi13sPG0vwMCUW+SItm5+dzV4Dl4boR5/lToKFWR8ZBicBXVdgE45NPe3HEptiKdZA5uRWOXO0rTCi9SBiR9rMncl8gd2GIBB1+kOebAL9euHcp3mS0tmQg0C6Jz+r7yN0Hy2BEk14wxd+c21O/6XyBbQzmKhsTD9D6fhZfXx3duvI7gJz39zsezTZ0ET0sJsZu2+yFih0e8prk8FxH4+OIN28K/LJr/MXv4JGg1TdwzFOfQzXyiuKVaWj8ygtyrGyoqWXT64upawXplzHlM8EDUxIApdyxhu4B9m1FVc76d5XjbWlp4L8F+OE99gZbnmnuew+QFOEb691uPbrDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(356005)(81166007)(26005)(1076003)(2616005)(41300700001)(36860700001)(426003)(7696005)(336012)(47076005)(82740400003)(478600001)(6666004)(54906003)(40480700001)(6916009)(70206006)(316002)(70586007)(2876002)(2906002)(36756003)(5660300002)(86362001)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:32.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fe91f8-cb88-455b-bf7c-08dbd0019b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
 kotarac@amd.com
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

