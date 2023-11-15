Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4EAC5AE5B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B9910E1D6;
	Wed, 15 Nov 2023 19:44:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1DF10E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRqDqLzEdN3ZZ/0DhGw4pqTdewPYoE0Ftoaul39YPRqIXciDgzncYlsZorchOOoHEEoZUnTnBFLhPoh3ejILsMX4n7xEUb6YkXQfHH3RCGpX5fHvwOrOKiJQ2vfpw6WsUp+N8n8L76U6VLO0SmA2/a3MxvKGqufVCftQ2YR5zuPz3GWstRvziehfiImtvBWN0HNqWkWEyrLZ/kgDIKxXOXz9d1X6KYC3auVJo9jYQVHMSy5ugveuC7yffO9Q4tU7agxFhyxbpjeUGGsZ1pSYIty1YQRk9UztUb+7J/9wnTeV/T1ud3kyoCsEAiQE8TXz2xIXerhz/3mpOM4qVKERuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL4vRb6dNaEPb7PEaK5Y1HamP5m47hLEO7YwwOu85h8=;
 b=feIkauiKPcHFBxDRMFmabKo3ePp/26AFw7mq36zbjfL/gr/AHrIhYXvhNqQd4vmdvcWqDMISBSSiddPlSaSGwyx93d1x2Ry/2USNfmkF/tjqNDXPDjrt3eLF5MwKPHW0Cx92owt9U6LoJl/pATiXH10whD00Cw/N1Of2dqGiB9OwCECxPISogMROtdufWaao5KGKk99UHYv5d2aoWwF/Gn38VGY3HsaLLg2IQ2uWcUb9NuBK8v0R+VFGYSTBUbt/FxCGewrns/Lfu8f38pRWvyHXKDDp8TgIWXkFAClw2n5dU/KwjQ7jMi2w4DN1HC8iMM2BaeWYAyMYlXDkHwhTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL4vRb6dNaEPb7PEaK5Y1HamP5m47hLEO7YwwOu85h8=;
 b=CKQCAkfdZSugn7w4UjvtYu+b7/UKGrlPtwto9wDyN3qrSnzXB0fJVOB8pfgdHrxgznu1WirM1uwYrdHPSI/xXUWQFkkaInTPgKrYV6jw1R6fX+V2j9mNEXgHtup1G4ZZlH/+ubWDLLl5IqdFMGNoUp9aJZgAnuMXsSDsvvCM8JE=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:11 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::2c) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:11 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:10 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/35] drm/amd/display: Add z-state support policy for dcn35
Date: Wed, 15 Nov 2023 14:40:16 -0500
Message-ID: <20231115194332.39469-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 1471940a-8061-4c79-1e23-08dbe6133db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0am5K613zbEoLw/LsJPDREr2ZvS1RhZU/M4ShtcOZZWbfk3+EKwDTmYW1l8b47ZaGjkXN3Upi2rpUHWho7VLVRNDKNSeV1yGEOCOPVSluCwSTKl5uxuRP2HlYAgVzRm9+5cDJcoLykpbIyNH7bSKo1/bJ91348zkInHQLoRMVvLqNHRiuQhzhw2o4sKYeNOcpY1uqHj9OBZaBApr9fXNe/92QyDzPQAJV8jH7siwAVPjrXS1OYmtIGgbfQE1yocu0Hw8VgMZn3yrX+I2iitdnNceMDi12au/RW0XRzbM+yJz7MRC5Lm1fn5hgewFLbwKxVq2BgPUQQZl3UOu/Gb83E6R8qrTf41KHz+QdwgNTXr/zroqMM4pwrJGCxLXkeGvmJIuP5gR18Widzn3LtY7+hKLp8SS21kIGyIMEvo4+h/aVeebHBPk1gH1gkFD4GIwnq7XyQG95/NF4IKxR+66trUQBXtKNH7YfqQL6I87L1uGN63ZonJAZSe3qnx9FL7RxocIDMOUKDb4VGAyHLI0sqJcnang5tVc6kCFRIaRGV7RGw/dMu2OXctUMR/yx1dIF3blgO8fQr+K1eLw1p1N+iVfQvAhaf/jXnQwT6NmCmUVwFi8Drp614aJ5xdOfb03femcsGOaPO6FUClkUTjpOyjE5No12cL9TJDOhyph+QBUtOgqlQZgkmxWdo0bxjgvhkd3rTJ8APszEaK8zS9rAx7yyQHNTfxJbFngqPZ7qOWYqV5hOIgDoZWBxgaqdQoOjSsnnrCisDoGm0ZvKfQ8RaR0E5unSQkniu5DP3sN1rtcnBq/7dY3R9lydR66IYK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(86362001)(47076005)(40480700001)(40460700003)(478600001)(36860700001)(54906003)(6916009)(316002)(70206006)(70586007)(82740400003)(26005)(1076003)(16526019)(2616005)(41300700001)(44832011)(36756003)(2906002)(5660300002)(81166007)(356005)(83380400001)(336012)(426003)(4326008)(8676002)(8936002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:11.6857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1471940a-8061-4c79-1e23-08dbe6133db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
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
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DML2 means that the dcn3x policy for calculating z-state support
no longer runs from validate_bandwidth.

This means we are unconditionally allowing Z8, the hardware default.

[How]
Port the policy over to DCN35, but with a few modifications:
- Don't use min_dst_y_next_start as a check for Z8/Z10 allow
- Add support for overriding the Z10 stutter period per ASIC
- Cleanup the code to make the policy assignment more clear

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 34 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |  2 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  7 ++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e6f109bbf468..42ae3edd9015 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -874,6 +874,7 @@ struct dc_debug_options {
 	unsigned int seamless_boot_odm_combine;
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
 	int minimum_z8_residency_time;
+	int minimum_z10_residency_time;
 	bool disable_z9_mpc;
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index a5fe523668e9..dee80429fc4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -507,3 +507,37 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 
 	return pipe_cnt;
 }
+
+void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
+{
+	enum dcn_zstate_support_state support = DCN_ZSTATE_SUPPORT_DISALLOW;
+	unsigned int i, plane_count = 0;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			plane_count++;
+	}
+
+	if (plane_count == 0) {
+		support = DCN_ZSTATE_SUPPORT_ALLOW;
+	} else if (plane_count == 1 && context->stream_count == 1 && context->streams[0]->signal == SIGNAL_TYPE_EDP) {
+		struct dc_link *link = context->streams[0]->sink->link;
+		bool is_pwrseq0 = link && link->link_index == 0;
+		bool is_psr1 = link && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr;
+		int minmum_z8_residency =
+			dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
+		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
+		int minmum_z10_residency =
+			dc->debug.minimum_z10_residency_time > 0 ? dc->debug.minimum_z10_residency_time : 5000;
+		bool allow_z10 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z10_residency;
+
+		if (is_pwrseq0 && allow_z10)
+			support = DCN_ZSTATE_SUPPORT_ALLOW;
+		else if (is_pwrseq0 && is_psr1)
+			support = allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
+		else if (allow_z8)
+			support = DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
+	}
+
+	context->bw_ctx.bw.dcn.clk.zstate_support = support;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
index e8d5a170893e..067480fc3691 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
@@ -39,4 +39,6 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 					      display_e2e_pipe_params_st *pipes,
 					      bool fast_validate);
 
+void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5c935d94a95c..0d5a03c6d812 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1724,6 +1724,13 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 
 	out = dml2_validate(dc, context, fast_validate);
 
+	if (fast_validate)
+		return out;
+
+	DC_FP_START();
+	dcn35_decide_zstate_support(dc, context);
+	DC_FP_END();
+
 	return out;
 }
 
-- 
2.42.0

