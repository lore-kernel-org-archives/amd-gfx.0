Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FABC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0B510E4AC;
	Wed, 26 Jul 2023 19:32:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C000910E4A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXyZym5ZdzhQowVsqr59OBZO7bRC0+Hk8tMW7EZoWSdEEuLRazjNF8It5s+BKfsSUaip1TeOafzCTTWWxXbv11OYmkE99hCfLtW/exqCI6TSCgTit1wN8fgyrcpcs5lOWoMrtmDTe0SVRNFD86s77ANjrk0YnFR1KfS+sAC9uIzuqEp3rfKQbRkZUc+RfDoNJzSu8IsDM9EElTAyV/f1aDIzthPZKYJeYbJ27veFcZ3jD6Z4SJKOsZV129rfaD+DaPzruFVQ6DAzS6I/a89HflHtkHKuDKuLTwfiIoiUwiBDJPGVUFc4Rudg0HJhl5NuqgcJGVu4iStJHQi3sDenNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maANF8LG/eWqhvud/gY07hfxgeJ7QHYbU/gKTBpgqe4=;
 b=U/yxlF6IdS93IPH9II7+YSnpFWrLazKrNMSbh6V+Wl7vRXKNvHGH5c/0wsFOcBNufcObjlg0mM3e+We7l9TUjl4XzwUbQ0DDAplQ4PcI2PGYcn1MqgT5SwGAeM15jrJi1aUXSa8HL8fKyxCFUFAK758YVwI/PoempWG7EdPk8li7G3j/lD5i9UIMD+nmJjoKuxutHQVkikMh8W/7fjamvuhYv2NXUZcE8YY5coUD5IHLU7YduD3HowG1A1SObM22/IqIf2RTjV2SwHWRtrJXh+IGPOx6aaFcULkRm3Zh/QoyFrYUgPZyPT4pCmmq6RbtV9YfvJBDXBt5Pzfu4m0z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maANF8LG/eWqhvud/gY07hfxgeJ7QHYbU/gKTBpgqe4=;
 b=HFw1BCpcXnXFt0j/QI1ZlA5IG3Fv3gGyoEhfPxp7e4iHQ39gzrJcSLpbv0suuUzgWMEcU45HE/RSWUgs1TWgykoToLYqAQ6pCMLGkn7TbrC06TlevTkEUcd349pfZyQ27SYzsafA9JAlPOjCxJA3vuV+tGzjfSoEkBl2G3IiTyA=
Received: from BN8PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:d4::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 19:31:59 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::48) by BN8PR04CA0044.outlook.office365.com
 (2603:10b6:408:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:31:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:31:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 12:31:58 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:31:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/display: Fix typo in enable and disable symclk_se
Date: Wed, 26 Jul 2023 15:27:41 -0400
Message-ID: <20230726193155.2525270-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 942e2fe4-90ea-4112-4cb7-08db8e0efac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEEzM8c5b4Tyzcpq0MkPaNQxMlbYSRvD71OSmkStixqmTMMQYl39RORKqE9Cr2vgoqxHg0tnq1uo7hwZlh6lsPfNXjQ0VTMARBKQaEgKMZiBB93mi2X02Vz+hjL/YXM691YptGHOIM6NQyEOlQq6iYyMLcf0fspftsMEzd8rudxAWZHReTCBFGQ3kRLD1K11zJcjfdRoqKW78k+aMWTEFRWuZYv5xOke8hF210OwIrWeCEY8V5YaeAfBdKvBV+ca9QlnD0eZrG58tf15IyNb4NEE4W89+Lb53JjI2eRBJ0VkYcPY5K/yE61rZ6vnRwPum4RR5Ts8WWjvYubYsSpqrH/eWsTOQqR3ub3RlFZfDRVkWsjCzRhxp3OFv9FvRjZ63IFYOdsk1gTQpWF/9b8PUk9GxKl44bMxGy0UdUMLRHLG2ajPFW9IZTGA5L5BIZm8OTuOvg0PQzY438qbRRmBjSE8UUE4RyDzp1ydcoAlZoeZ1YqyrLCLLsRJi6fRnJTXC3D/Orgh/+eP4lTRSUYb1GGFcAetDZBPGc1ue7q+qjasz6ohx6yNXRW0Z17KYxlvqw2cKtgQXRJcHt6vjDGtvBxGbrjLBEOwS2nYhfw/uYegstYD7bAVnMJ6ufRK+d4/S3BFRNJlNicqh0tUD+d3bGVqRq19chfxnFeY/5TJDqwONWaZchJH7L/A32eu8+4YEzPZm8IFMHkd/DYF6f0sIxiwJiH8mUN/a3qzdhIUL5G7zlj6TNzhpzf4mlFvVn3mD60xL02rxMuHJnRe/QigJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(316002)(44832011)(40460700003)(5660300002)(8676002)(8936002)(36756003)(40480700001)(86362001)(1076003)(26005)(478600001)(356005)(82740400003)(6666004)(7696005)(83380400001)(47076005)(36860700001)(186003)(2616005)(336012)(426003)(6916009)(4326008)(81166007)(70206006)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:31:59.0181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942e2fe4-90ea-4112-4cb7-08db8e0efac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
Symclk should be based on link_enc_inst, and symclk_fe_sel should be based
on stream_enc_inst.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 1eb4f884e5bb..b4698108a7e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1150,6 +1150,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct dtbclk_dto_params dto_params = {0};
 	int dp_hpo_inst;
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal)) {
@@ -1178,7 +1179,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
 	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST && dccg->funcs->disable_symclk_se)
-		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst);
+		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
+				link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		/* TODO: This looks like a bug to me as we are disabling HPO IO when
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index c378cb287a3a..3e2f0f64c98c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -180,7 +180,8 @@ struct dccg_funcs {
 
 	void (*disable_symclk_se)(
 			struct dccg *dccg,
-			uint32_t stream_enc_inst);
+			uint32_t stream_enc_inst,
+			uint32_t link_enc_inst);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.41.0

