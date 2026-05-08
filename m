Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE047CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB2610F5B8;
	Fri,  8 May 2026 18:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rghs0bKw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6C910F5B8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVXqc/mXRqKthtQGaoj1o6N0gwyym08YS6e+uCGhAlKKSVTjuJOo/BVqleKepffkX8b6kpLGOjL6N14r5k0B2SzAnTlgq1gdbyHX9AK6FosRHHXirh3g04bjmDinzwXhvtpYqMh/UkzYQ9jXB3NPKvcg6UCzZpc2UKr8tTNsqjqjHM4HExP9ZPWkPUbpwIvd2Y5mbKIeUwANA3AJxaq+vkFXBFT3emLEjTyy6DXz59RgPIHXyWRfGa5agYSfyYGXHpg8cj7nUEAop4VD5s0jtAhDAt7UaEoicz/Elu4F7J0zxeuaK816WzQGWnR3f75bH8pauGInIvVFcm5jwDrTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akVvAd1RzF2CNTMWDSJHCHcwFnAUD8eECBfLax80FkA=;
 b=OXUCqsIxBmUcV044F3lKR8RwwTIiTwdcIP9bFt4MvGjQ299i10ghmpTAnak21qL3qQZcwOnab1fbgqtcsDwlWWUIitzOJKqPYHoGQZkYVmuosPHfqzhItvlR0zPd/WOGrC2kSoOEyxRZRDA7H/qCao64wSe2yZpEecrKkcnnxxzlG5505ltVUa6uApFfYDp+tAb0hFZfntSm6+5JyNSC6AFAScqHgq49lNP5XR4MRSYWR/jRsJ9HQw8+I77DY+5BebXks52WINAhdu59RPg3dY3v/SsbZdPLXFkUMN2BDNLTIe+I9Ve0zVmf/osWa3Fbfxa0C4kD8X/CzSvH+pgMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akVvAd1RzF2CNTMWDSJHCHcwFnAUD8eECBfLax80FkA=;
 b=rghs0bKwgknJlS1Rija+VJ0Xr6BDC6WITUXnmWxTwuZFZQP6IGzBAyLGLau+UqYk1GmYwMY7qY745U7Ly2QNmM4HulA8RysEpVZ4SW3ZcwUKNOLrfEMBiMW7uECLoHI+ClVIz1UKrpw1ch+sdgQl6WCm/JgupwXUZdJhigiEe0Q=
Received: from MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27)
 by DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 18:28:21 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::c7) by MN2PR03CA0022.outlook.office365.com
 (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 18:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 18:28:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:14 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 13:28:14 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v3 04/14] drm/amd/display: Add DCCG DIO, HPO, OPP,
 and OPTC support for FRL
Date: Fri, 8 May 2026 14:27:56 -0400
Message-ID: <20260508182808.520863-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508182808.520863-1-harry.wentland@amd.com>
References: <20260508182808.520863-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: df91675a-44f4-411c-17d1-08dead2f951c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|3023799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ue/bhrmTs/CmJdGv/Y3/qarBmlEmvvST2aJNBYs4dHTOWDTTUOe/xppSDwVnL2K9CB06G8PDDPmxsr6r51z/8+xDx43LoFqY5ElPP7i+544F7Jb4lnhm089BsuTDFp71z2JnXPFLeeqM+1whZbFIjylY0TPNISNne5XAySHJQpjpiexhYn7jLwGYGnL45ytHLn9b/jbuqklFCuxmfXToxIisZgD9gpsFwltzAFHtQso+LPTSy2q0RzXFueRWnrvGSVduN0768V7XVQ2RN4SFoyhRuqkUKpdxKSnDNyUSVL/lOhxGWQ3YouZ0KYiyIoOrqey0zHWMg3XGbb48gxTwdP6/JNm48/kYXacwOpEbb/K8VpI1WskwtRwvOvOWMxVXsoc1+BXEiTNp6gTN4xeGV/cErA/Hadn9ZtTznWCUu7iJNMYiwX/RhTgaY1sh63S0ZhS467Ja2p/+AmWg7iYnBp+dAV+7LcMnfKmg2b0TIpqJOywiJG97PsLicKtzMAbv1l8BDIyeq0wQeNIyd/8dZQoA35TBRF11dhpQX1Fx7+Uqj27K+5QfiXXQZRHaUts8FnlQ5sKrPzG5Mh+V25m6bouXMJREi4m7eDM+2QCv2lPFpiM27ZjxpOUQkYXFlqfJSNOzHP/3cupIF4SEa32ZjhedsFbruOslVvcAOtTwfo5GoHzzrwCNQMnATXiZ2PldYruu/Qq1HG8eJTFJev2O4id1qUAh9Rr7za4+B6NB9HY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(3023799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +R/vtrIEXBJfuXEqOmpBcY5RE4FlQl6i9F8QkdPcFM6uOuGF9qg+A7VzfjV1I85UbMseplgtfG1gvD9funEJ6xUK6GyPDv4zf3EdraiDnORHIqxBqPdSAil55E3scyWQmVOWol5ReYc3bfyAhiZSxNIGP0Nio8d/X86AytdEs8dQzet3LCobbFtHlNt8UrBiXwoAwLvaiY7kaE3m0oZGgC21ck/YL8g9kEDaWhewq3A+5NxpVHI3wXJQmPcJFC9YFwpomAxh3W58QTNyIhELL+wVKiKrtWH1v9zoAzWVulvYWqLXiwA88QWHlgSuci7EPgY8TCp8jYDYdBO11oz1mg6E1tVlJQEKmYrMZi7wnMXUVFRrt4IuQhZReYiRAuF3PeHMrxyEV9KZ/+YpdfKIhyYomiA75HgQoX/bUMZHaKOLsfM6oNaccwfpa5cY6usA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:28:20.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df91675a-44f4-411c-17d1-08dead2f951c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds support to HW block programming for the core blocks
for HDMI FRL:
- DIO
- HPO
- OPP
- OPTC

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |  40 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |   8 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |  88 ++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |  13 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |  25 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |  68 ++
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 321 ++++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  73 ++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   4 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  33 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |   3 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.h |   1 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     | 250 +++++
 .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |  17 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |  18 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     | 114 +++
 .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |   8 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     | 214 ++++
 .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |  16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |  20 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |  21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   | 220 ++++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |  16 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |  21 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |  10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c | 286 ++++++
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h | 146 +++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 938 ++++++++++++++++++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  | 436 ++++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    | 906 +++++++++++++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.h    | 335 +++++++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  | 206 ++++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |  59 ++
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |   1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   5 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   2 +
 38 files changed, 4948 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
index adec7c3c2d49..180175693e0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
@@ -42,8 +42,48 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+void dccg3_enable_hdmicharclk(struct dccg *dccg, int hpo_inst, int phypll_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	ASSERT(hpo_inst >= 0 && phypll_inst >= 0);
+	REG_UPDATE_2(HDMICHARCLK_CLOCK_CNTL[hpo_inst],
+			HDMICHARCLK0_EN, 1,
+			HDMICHARCLK0_SRC_SEL, phypll_inst);
+
+	/* Enable FORCE_EN for SYMCLK */
+	switch (phypll_inst) {
+	case 0:
+		REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+				PHYASYMCLK_FORCE_EN, 1,
+				PHYASYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+				PHYBSYMCLK_FORCE_EN, 1,
+				PHYBSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+				PHYCSYMCLK_FORCE_EN, 1,
+				PHYCSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg3_disable_hdmicharclk(struct dccg *dccg, int hpo_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_WRITE(HDMICHARCLK_CLOCK_CNTL[hpo_inst], 0);
+}
 
 static const struct dccg_funcs dccg3_funcs = {
+	.enable_hdmicharclk = dccg3_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg3_disable_hdmicharclk,
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h
index 3f1da7f3a91c..379fe94734ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h
@@ -63,4 +63,12 @@ struct dccg *dccg30_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask);
 
+void dccg3_enable_hdmicharclk(
+	struct dccg *dccg,
+	int hpo_inst,
+	int phypll_inst);
+
+void dccg3_disable_hdmicharclk(
+	struct dccg *dccg,
+	int hpo_inst);
 #endif //__DCN30_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
index 1f5a4a8bf691..a4f6faaf97fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
@@ -664,6 +664,87 @@ void dccg31_set_dispclk_change_mode(
 		   change_mode == DISPCLK_CHANGE_MODE_RAMPING ? 2 : 0);
 }
 
+void dccg31_set_hdmistreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst)
+{
+	(void)otg_inst;
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (src == REFCLK) {
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_SRC_SEL, 0,        /* SEL_REFCLK0 */
+				HDMISTREAMCLK0_DTO_FORCE_DIS, 1); /* DTO_FORCE_BYPASS */
+	} else {
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_SRC_SEL, 1,        /* SEL_DTBCLK0 */
+				HDMISTREAMCLK0_DTO_FORCE_DIS, 1); /* DTO_FORCE_BYPASS */
+	}
+}
+
+static void dccg31_disable_hdmistreamclk(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream)
+		REG_UPDATE_2(HDMISTREAMCLK0_DTO_PARAM,
+			HDMISTREAMCLK0_DTO_PHASE, 0,
+			HDMISTREAMCLK0_DTO_MODULO, 1);
+}
+
+void dccg31_enable_hdmicharclk(struct dccg *dccg, int hpo_inst, int phypll_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	ASSERT(hpo_inst >= 0 && phypll_inst >= 0);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar) {
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, 1);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 1);
+	}
+
+	REG_UPDATE_2(HDMICHARCLK_CLOCK_CNTL[hpo_inst],
+			HDMICHARCLK0_EN, 1,
+			HDMICHARCLK0_SRC_SEL, phypll_inst);
+
+	/* Enable FORCE_EN for SYMCLK */
+	switch (phypll_inst) {
+	case 0:
+		REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+				PHYASYMCLK_FORCE_EN, 1,
+				PHYASYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+				PHYBSYMCLK_FORCE_EN, 1,
+				PHYBSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+				PHYCSYMCLK_FORCE_EN, 1,
+				PHYCSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_disable_hdmicharclk(struct dccg *dccg, int hpo_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_WRITE(HDMICHARCLK_CLOCK_CNTL[hpo_inst], 0);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar) {
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 0);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, 0);
+	}
+}
+
 void dccg31_init(struct dccg *dccg)
 {
 	/* Set HPO stream encoder to use refclk to avoid case where PHY is
@@ -692,6 +773,10 @@ void dccg31_init(struct dccg *dccg)
 		dccg31_set_physymclk(dccg, 3, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
 		dccg31_set_physymclk(dccg, 4, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
 	}
+	dccg31_disable_hdmistreamclk(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar)
+		dccg31_disable_hdmicharclk(dccg, 0);
 }
 
 void dccg31_otg_add_pixel(struct dccg *dccg,
@@ -835,6 +920,9 @@ void dccg31_read_reg_state(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_re
 }
 
 static const struct dccg_funcs dccg31_funcs = {
+	.enable_hdmicharclk = dccg31_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg31_disable_hdmicharclk,
+	.set_hdmistreamclk = dccg31_set_hdmistreamclk,
 	.update_dpp_dto = dccg31_update_dpp_dto,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
index b5e3849ef12a..2c2d682a82c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
@@ -202,6 +202,19 @@ void dccg31_set_physymclk(
 void dccg31_set_audio_dtbclk_dto(
 		struct dccg *dccg,
 		const struct dtbclk_dto_params *params);
+void dccg31_enable_hdmicharclk(
+	struct dccg *dccg,
+	int hpo_inst,
+	int phypll_inst);
+
+void dccg31_disable_hdmicharclk(
+	struct dccg *dccg,
+	int hpo_inst);
+
+void dccg31_set_hdmistreamclk(
+	struct dccg *dccg,
+	enum streamclk_source src,
+	uint32_t otg_inst);
 
 void dccg31_update_dpp_dto(
 	struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
index 2e9c4b13988a..410e914c720c 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
@@ -286,6 +286,28 @@ void dccg314_set_dpstreamclk(
 	}
 }
 
+static void dccg314_set_hdmistreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set the dtbclk_p source */
+	dccg314_set_dtbclk_p_src(dccg, src, otg_inst);
+
+	if (src == REFCLK) {
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 0,             /* SEL_REFCLK */
+				HDMISTREAMCLK0_DTO_FORCE_DIS, 1); /* DTO_FORCE_BYPASS */
+	} else {
+		REG_UPDATE_3(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 1,             /* selects one of the dtbclk_p as per HDMISTREAMCLK0_SRC_SEL */
+				HDMISTREAMCLK0_SRC_SEL, otg_inst, /* Selects dtbclk_p as source for hdmistreamclk */
+				HDMISTREAMCLK0_DTO_FORCE_DIS, 1); /* DTO_FORCE_BYPASS */
+	}
+}
+
 static void dccg314_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -355,6 +377,9 @@ static void dccg314_dpp_root_clock_control(
 }
 
 static const struct dccg_funcs dccg314_funcs = {
+	.enable_hdmicharclk = dccg31_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg31_disable_hdmicharclk,
+	.set_hdmistreamclk = dccg314_set_hdmistreamclk,
 	.update_dpp_dto = dccg31_update_dpp_dto,
 	.dpp_root_clock_control = dccg314_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
index d2752dd8f81f..c81362876774 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
@@ -329,7 +329,75 @@ static void dccg32_otg_drop_pixel(struct dccg *dccg,
 			OTG_DROP_PIXEL[otg_inst], 1);
 }
 
+static void dccg32_set_hdmistreamclk(struct dccg *dccg,
+				     enum streamclk_source src,
+				     uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set the dtbclk_p source */
+	/* always program refclk as DTBCLK. No use-case expected to require DPREFCLK as refclk */
+	dccg32_set_dtbclk_p_src(dccg, DTBCLK0, otg_inst);
+
+	if (src == REFCLK) {
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 0,             /* SEL_REFCLK */
+				HDMISTREAMCLK0_DTO_FORCE_DIS, 1); /* DTO_FORCE_BYPASS */
+	} else {
+		REG_UPDATE_3(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 1,             /* selects one of the dtbclk_p as per HDMISTREAMCLK0_SRC_SEL */
+				HDMISTREAMCLK0_SRC_SEL, otg_inst, /* Selects dtbclk_p as source for hdmistreamclk */
+				HDMISTREAMCLK0_DTO_FORCE_DIS, 1); /* DTO_FORCE_BYPASS */
+	}
+}
+
+static void dccg32_enable_hdmicharclk(struct dccg *dccg, int hpo_inst,
+				      int phypll_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	ASSERT(hpo_inst >= 0 && phypll_inst >= 0);
+	REG_UPDATE_2(HDMICHARCLK_CLOCK_CNTL[hpo_inst],
+			HDMICHARCLK0_EN, 1,
+			HDMICHARCLK0_SRC_SEL, phypll_inst);
+
+	/* Enable FORCE_EN for SYMCLK */
+	switch (phypll_inst) {
+	case 0:
+		REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+				PHYASYMCLK_FORCE_EN, 1,
+				PHYASYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+				PHYBSYMCLK_FORCE_EN, 1,
+				PHYBSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+				PHYCSYMCLK_FORCE_EN, 1,
+				PHYCSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 3:
+		REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
+				PHYDSYMCLK_FORCE_EN, 1,
+				PHYDSYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	case 4:
+		REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
+				PHYESYMCLK_FORCE_EN, 1,
+				PHYESYMCLK_FORCE_SRC_SEL, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 static const struct dccg_funcs dccg32_funcs = {
+	.enable_hdmicharclk = dccg32_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg3_disable_hdmicharclk,
+	.set_hdmistreamclk = dccg32_set_hdmistreamclk,
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg32_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 33418ee1fa62..83589777f1ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -495,6 +495,92 @@ static void dccg35_set_smclk32_se_rcg(
 	}
 }
 
+static void dccg35_set_hdmistreamclk_rcg(
+		struct dccg *dccg,
+		int inst,
+		bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream && enable)
+		return;
+
+	switch (inst) {
+	case 0:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3, HDMISTREAMCLK0_GATE_DISABLE, enable ? 0 : 1);
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_hdmi_char_clk_rcg(
+		struct dccg *dccg,
+		int inst,
+		bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* Only 1 HPO in DCN35 */
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar && enable)
+		return;
+
+	switch (inst) {
+	case 0:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL2, HDMICHARCLK0_GATE_DISABLE, enable ? 0 : 1);
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL4, HDMICHARCLK0_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_hdmi_char_clk_src_new(
+	struct dccg *dccg,
+	enum hdmi_char_clk src,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* If DTBCLK_P#_EN is 0 refclock is selected as functional clock
+	 * If DTBCLK_P#_EN is 1 functional clock is selected as DTBCLK_P#_SRC_SEL
+	 */
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(HDMICHARCLK_CLOCK_CNTL[0],
+					 HDMICHARCLK0_SRC_SEL, (src == HDMI_CHAR_REFCLK) ? 0 : src,
+					 HDMICHARCLK0_EN, (src == HDMI_CHAR_REFCLK) ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_hdmistreamclk_src_new(
+	struct dccg *dccg,
+	enum hdmi_stream_clk_source src,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN,
+					 (src == HDMI_STREAM_REFCLK) ? 0 : 1,
+					 DPSTREAMCLK0_SRC_SEL,
+					 (src == HDMI_STREAM_REFCLK) ? 0 : src);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 static void dccg35_set_dsc_clk_src_new(struct dccg *dccg, int inst, enum dsc_clk_source src)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -1107,6 +1193,35 @@ static void dccg35_enable_dpstreamclk_new(struct dccg *dccg,
 	dccg35_set_dpstreamclk_src_new(dccg, src, inst);
 }
 
+static void dccg35_disable_hdmistreamclk_new(
+	struct dccg *dccg,
+	int inst)
+{
+	dccg35_set_hdmistreamclk_src_new(dccg, HDMI_STREAM_REFCLK, inst);
+	dccg35_set_hdmistreamclk_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_hdmistreamclk_new(struct dccg *dccg,
+								enum hdmi_stream_clk_source src,
+								int inst)
+{
+	dccg35_set_hdmistreamclk_rcg(dccg, inst, false);
+	dccg35_set_hdmistreamclk_src_new(dccg, src, inst);
+}
+
+static void dccg35_enable_hdmicharclk_new(struct dccg *dccg, enum hdmi_char_clk src,
+										  int inst)
+{
+	dccg35_set_hdmi_char_clk_rcg(dccg, inst, false);
+	dccg35_set_hdmi_char_clk_src_new(dccg, src, inst);
+}
+
+static void dccg35_disable_hdmicharclk_new(struct dccg *dccg, int inst)
+{
+	dccg35_set_hdmi_char_clk_src_new(dccg, HDMI_CHAR_REFCLK, inst);
+	dccg35_set_hdmi_char_clk_rcg(dccg, inst, true);
+}
+
 void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -1539,6 +1654,88 @@ void dccg35_set_dpstreamclk_root_clock_gating(struct dccg *dccg, int dp_hpo_inst
 
 
 
+static void dccg35_set_hdmistreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set the dtbclk_p source */
+	dccg35_set_dtbclk_p_src(dccg, src, otg_inst);
+
+	if (src == REFCLK) {
+		REG_UPDATE(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 0);             /* SEL_REFCLK */
+	} else {
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 1,              /* selects one of the dtbclk_p as per HDMISTREAMCLK0_SRC_SEL */
+				HDMISTREAMCLK0_SRC_SEL, otg_inst); /* Selects dtbclk_p as source for hdmistreamclk */
+	}
+	DC_LOG_DEBUG("%s: OTG%d HDMISTREAMCLK_EN = %d, HDMISTREAMCLK_SRC_SEL = %d\n",
+			__func__, otg_inst, (src == REFCLK) ? 0 : 1, otg_inst);
+}
+
+void dccg35_set_hdmistreamclk_root_clock_gating(struct dccg *dccg, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream)
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, enable ? 1 : 0);
+
+	DC_LOG_DEBUG("%s: HDMISTREAMCLK0_ROOT_GATE_DISABLE = %d\n", __func__, enable ? 1 : 0);
+}
+
+static void dccg35_enable_hdmicharclk(struct dccg *dccg, int hpo_inst,
+				      int phypll_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar) {
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, 1);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 1);
+	}
+
+	ASSERT(hpo_inst >= 0 && phypll_inst >= 0);
+	REG_UPDATE_2(HDMICHARCLK_CLOCK_CNTL[hpo_inst],
+			HDMICHARCLK0_EN, 1,
+			HDMICHARCLK0_SRC_SEL, phypll_inst);
+
+	/* Enable FORCE_EN for SYMCLK */
+	switch (phypll_inst) {
+	case 0:
+		REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+				PHYASYMCLK_EN, 1,
+				PHYASYMCLK_SRC_SEL, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+				PHYBSYMCLK_EN, 1,
+				PHYBSYMCLK_SRC_SEL, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+				PHYCSYMCLK_EN, 1,
+				PHYCSYMCLK_SRC_SEL, 1);
+		break;
+	case 3:
+		REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
+				PHYDSYMCLK_EN, 1,
+				PHYDSYMCLK_SRC_SEL, 1);
+		break;
+	case 4:
+		REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
+				PHYESYMCLK_EN, 1,
+				PHYESYMCLK_SRC_SEL, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 static void dccg35_set_physymclk_root_clock_gating(
 		struct dccg *dccg,
 		int phy_inst,
@@ -1756,6 +1953,33 @@ void dccg35_disable_symclk32_se(struct dccg *dccg, int hpo_se_inst)
 
 }
 
+static void dccg35_disable_hdmistreamclk(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream) {
+//		REG_UPDATE_2(HDMISTREAMCLK0_DTO_PARAM,
+//			HDMISTREAMCLK0_DTO_PHASE, 0,
+//			HDMISTREAMCLK0_DTO_MODULO, 1);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, 0);
+
+	}
+}
+
+static void dccg35_disable_hdmicharclk(struct dccg *dccg, int hpo_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_WRITE(HDMICHARCLK_CLOCK_CNTL[hpo_inst], 0);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar) {
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 0);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, 0);
+		DC_LOG_DEBUG("%s: HDMICHARCLK0_ROOT_GATE_DISABLE = 0\n", __func__);
+	}
+}
+
 static void dccg35_init_cb(struct dccg *dccg)
 {
 	(void)dccg;
@@ -1793,6 +2017,9 @@ void dccg35_init(struct dccg *dccg)
 					__func__, otg_inst);
 		}
 
+	dccg35_disable_hdmistreamclk(dccg);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar)
+		dccg35_disable_hdmicharclk(dccg, 0);
 /*
 	dccg35_enable_global_fgcg_rep(
 		dccg, dccg->ctx->dc->debug.enable_fine_grain_clock_gating.bits
@@ -2088,6 +2315,92 @@ void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint3
 	}
 }
 
+static void dccg35_enable_hdmicharclk_cb(struct dccg *dccg, int hpo_inst, int phypll_inst)
+{
+	ASSERT(hpo_inst >= 0 && phypll_inst >= 0);
+
+	/* Note that this is now done in DMU as part of phy fsm enable sequence,
+	 * this function does not get called on x86
+	 */
+	enum hdmi_char_clk src = (enum hdmi_char_clk) phypll_inst;
+
+	dccg35_enable_hdmicharclk_new(dccg, src, hpo_inst);
+
+	/* Select PHYD18 as final SYMCLK going to the PHY from DCCG */
+	dccg35_set_physymclk_src_new(dccg, phypll_inst, PHYSYMCLK_PHYD18CLK);
+}
+
+static void dccg35_disable_hdmicharclk_cb(struct dccg *dccg, int hpo_inst)
+{
+	ASSERT(hpo_inst >= 0);
+
+	/* Note that this is now done in DMU as part of phy fsm disable sequence,
+	 * this function does not get called on x86
+	 */
+	dccg35_disable_hdmicharclk_new(dccg, hpo_inst);
+
+	/* TBD Optionally check if SYMCLK is active and disable it */
+}
+
+static void dccg35_set_hdmistreamclk_cb(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst)
+{
+	enum dtbclk_source dtb_clk_src;
+	enum hdmi_stream_clk_source hdmi_stream_clk_src;
+
+	switch (src) {
+	case REFCLK:
+		dtb_clk_src = DTBCLK_REFCLK;
+		hdmi_stream_clk_src = HDMI_STREAM_REFCLK;
+		break;
+	case DPREFCLK:
+		dtb_clk_src = DTBCLK_DPREFCLK;
+		hdmi_stream_clk_src = (enum hdmi_stream_clk_source)otg_inst;
+		break;
+	case DTBCLK0:
+		dtb_clk_src = DTBCLK_DTBCLK0;
+		hdmi_stream_clk_src = (enum hdmi_stream_clk_source)otg_inst;
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (dtb_clk_src == DTBCLK_REFCLK &&
+		hdmi_stream_clk_src == HDMI_STREAM_REFCLK) {
+		dccg35_disable_dtbclk_p_new(dccg, otg_inst);
+		dccg35_disable_hdmistreamclk_new(dccg, 0);
+	} else {
+		dccg35_enable_dtbclk_p_new(dccg, dtb_clk_src, otg_inst);
+		dccg35_enable_hdmistreamclk_new(dccg,
+										hdmi_stream_clk_src,
+										0);
+	}
+}
+
+static void dccg35_set_hdmistreamclk_root_clock_gating_cb(
+	struct dccg *dccg,
+	bool power_on)
+{
+	/* power_on set indicates we need to ungate
+	 * Currently called from optimize_bandwidth and prepare_bandwidth calls
+	 * Since clock source is not passed restore to refclock on ungate
+	 * Instance 0 is implied here since only one streamclock resource
+	 * Redundant as gating when enabled is acheived through set_hdmistreamclk
+	 */
+	if (power_on) {
+		dccg35_enable_hdmicharclk_new(dccg, HDMI_CHAR_REFCLK, 0);
+		dccg35_enable_hdmistreamclk_new(dccg,
+										HDMI_STREAM_REFCLK,
+										0);
+	} else {
+		dccg35_disable_hdmistreamclk_new(dccg, 0);
+		dccg35_disable_hdmicharclk_new(dccg, 0);
+	}
+}
+
 static void dccg35_set_dpstreamclk_cb(
 		struct dccg *dccg,
 		enum streamclk_source src,
@@ -2386,6 +2699,10 @@ void dccg35_root_gate_disable_control(struct dccg *dccg, uint32_t pipe_idx, uint
 }
 
 static const struct dccg_funcs dccg35_funcs_new = {
+	.enable_hdmicharclk = dccg35_enable_hdmicharclk_cb,
+	.disable_hdmicharclk = dccg35_disable_hdmicharclk_cb,
+	.set_hdmistreamclk = dccg35_set_hdmistreamclk_cb,
+	.set_hdmistreamclk_root_clock_gating = dccg35_set_hdmistreamclk_root_clock_gating_cb,
 	.update_dpp_dto = dccg35_update_dpp_dto_cb,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control_cb,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
@@ -2421,6 +2738,10 @@ static const struct dccg_funcs dccg35_funcs_new = {
 };
 
 static const struct dccg_funcs dccg35_funcs = {
+	.enable_hdmicharclk = dccg35_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg35_disable_hdmicharclk,
+	.set_hdmistreamclk = dccg35_set_hdmistreamclk,
+	.set_hdmistreamclk_root_clock_gating = dccg35_set_hdmistreamclk_root_clock_gating,
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index d49689baa7ca..b9c88bc436e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -381,6 +381,72 @@ static void dccg401_otg_drop_pixel(struct dccg *dccg,
 			OTG_DROP_PIXEL[otg_inst], 1);
 }
 
+void dccg401_set_hdmistreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (src == REFCLK) {
+		REG_UPDATE(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 0);             /* SEL_REFCLK */
+	} else {
+		REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 1,              /* selects one of the dtbclk_p as per HDMISTREAMCLK0_SRC_SEL */
+				HDMISTREAMCLK0_SRC_SEL, otg_inst); /* Selects dtbclk_p as source for hdmistreamclk */
+	}
+}
+
+void dccg401_enable_hdmicharclk(struct dccg *dccg, int hpo_inst, int phypll_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	ASSERT(hpo_inst >= 0 && phypll_inst >= 0);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar) {
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, 1);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 1);
+	}
+
+	REG_UPDATE_2(HDMICHARCLK_CLOCK_CNTL[hpo_inst],
+			HDMICHARCLK0_EN, 1,
+			HDMICHARCLK0_SRC_SEL, phypll_inst);
+
+	/* Enable FORCE_EN for SYMCLK */
+	dccg401_set_physymclk(dccg, phypll_inst, PHYSYMCLK_FORCE_SRC_PHYD18CLK, true);
+}
+
+void dccg401_disable_hdmicharclk(struct dccg *dccg, int hpo_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	//int phypll_inst = 0;
+
+	ASSERT(hpo_inst >= 0);
+	//REG_GET(dccg, HDMICHARCLK_CLOCK_CNTL[hpo_inst], HDMICHARCLK0_SRC_SEL, &phypll_inst);
+	REG_WRITE(HDMICHARCLK_CLOCK_CNTL[hpo_inst], 0);
+
+	/* TODO should we also disable physymclk? */
+	/* Disable FORCE_EN for SYMCLK */
+	//dccg401_set_physymclk(dccg, phypll_inst, PHYSYMCLK_FORCE_SRC_PHYD18CLK, true);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar) {
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 0);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, 0);
+	}
+}
+
+static void dccg401_disable_hdmistreamclk(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 0,
+				HDMISTREAMCLK0_SRC_SEL, 0);
+}
 void dccg401_enable_symclk32_le(
 		struct dccg *dccg,
 		int hpo_le_inst,
@@ -721,6 +787,10 @@ void dccg401_init(struct dccg *dccg)
 		dccg401_set_physymclk(dccg, 2, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
 		dccg401_set_physymclk(dccg, 3, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
 	}
+	dccg401_disable_hdmistreamclk(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar)
+		dccg401_disable_hdmicharclk(dccg, 0);
 }
 
 void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst, uint32_t num_slices_h)
@@ -881,6 +951,9 @@ void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint
 }
 
 static const struct dccg_funcs dccg401_funcs = {
+	.enable_hdmicharclk = dccg401_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg401_disable_hdmicharclk,
+	.set_hdmistreamclk = dccg401_set_hdmistreamclk,
 	.update_dpp_dto = dccg401_update_dpp_dto,
 	.get_dccg_ref_freq = dccg401_get_dccg_ref_freq,
 	.dccg_init = dccg401_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
index 5947a35363aa..95f0602466d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
@@ -246,4 +246,8 @@ void dccg401_set_physymclk(
 	enum physymclk_clock_source clk_src,
 	bool force_enable);
 
+void dccg401_set_hdmistreamclk(struct dccg *dccg, enum streamclk_source src, uint32_t otg_inst);
+void dccg401_enable_hdmicharclk(struct dccg *dccg, int hpo_inst, int phypll_inst);
+void dccg401_disable_hdmicharclk(struct dccg *dccg, int hpo_inst);
+
 #endif //__DCN401_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index 9612f4498ef6..e57242f8bc12 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -181,6 +181,32 @@ void dccg42_set_physymclk(
 	}
 }
 
+static void dccg42_disable_hdmistreamclk(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE_2(HDMISTREAMCLK_CNTL,
+				HDMISTREAMCLK0_EN, 0,
+				HDMISTREAMCLK0_SRC_SEL, 0);
+
+	REG_UPDATE(DCCG_GATE_DISABLE_CNTL6,
+				HDMISTREAMCLK0_ROOT_GATE_DISABLE,
+				dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream ? 0 : 1);
+}
+
+static void dccg42_disable_hdmicharclk(struct dccg *dccg, int hpo_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	ASSERT(hpo_inst >= 0);
+	REG_WRITE(HDMICHARCLK_CLOCK_CNTL[hpo_inst], 0);
+
+	REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+			HDMICHARCLK0_GATE_DISABLE, 0);
+	REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
+			HDMICHARCLK0_ROOT_GATE_DISABLE, dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar ? 0 : 1);
+}
+
 void dccg42_set_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -270,10 +296,17 @@ static void dccg42_init(struct dccg *dccg)
 			PHYDSYMCLK_ROOT_GATE_DISABLE, 1,
 			PHYESYMCLK_ROOT_GATE_DISABLE, 1);
 	}
+	dccg42_disable_hdmistreamclk(dccg);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar)
+		dccg42_disable_hdmicharclk(dccg, 0);
 }
 
 
 static const struct dccg_funcs dccg42_funcs = {
+	.enable_hdmicharclk = dccg401_enable_hdmicharclk,
+	.disable_hdmicharclk = dccg42_disable_hdmicharclk,
+	.set_hdmistreamclk = dccg401_set_hdmistreamclk,
+	.set_hdmistreamclk_root_clock_gating = dccg35_set_hdmistreamclk_root_clock_gating,
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg401_get_dccg_ref_freq,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 13e14aad3daa..f97ec72f8aba 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -1065,7 +1065,8 @@ void dcn10_link_encoder_disable_output(
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result result;
 
-	if (enc->funcs->is_dig_enabled && !enc->funcs->is_dig_enabled(enc)) {
+	if (!dc_is_hdmi_frl_signal(signal) &&
+	    (enc->funcs->is_dig_enabled && !enc->funcs->is_dig_enabled(enc))) {
 		/* OF_SKIP_POWER_DOWN_INACTIVE_ENCODER */
 	/*in DP_Alt_No_Connect case, we turn off the dig already,
 	after excuation the PHY w/a sequence, not allow touch PHY any more*/
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.h
index 762c579fcb44..1beba9c7d3f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.h
@@ -291,6 +291,7 @@ struct dpcssys_phy_seq_cfg {
 	bool use_calibration_setting;
 	struct mpll_cfg mpll_cfg;
 	bool load_sram_fw;
+	bool tx_hdmi_frl_mode;
 #if 0
 
 	bool hdmimode_enable;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
index 57b9ae5fca1d..8c4010c5b2e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
@@ -48,11 +48,240 @@
 	(enc10->link_regs->index)
 
 
+static bool dcn30_link_encoder_validate_hdmi_frl_output(
+	const struct dcn10_link_encoder *enc10,
+	const struct dc_crtc_timing *crtc_timing)
+{
+	enum dc_color_depth max_deep_color =
+			enc10->base.features.max_hdmi_deep_color;
+
+	if (!enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE)
+		return false;
+
+	if (max_deep_color < crtc_timing->display_color_depth)
+		return false;
+
+	if (crtc_timing->display_color_depth < COLOR_DEPTH_888)
+		return false;
+
+	/* TODO: check if hdmi_charclk is above ASIC cap (10 GBS for DCN3AG) */
+
+	return true;
+}
+
 bool dcn30_link_encoder_validate_output_with_stream(
 	struct link_encoder *enc,
 	const struct dc_stream_state *stream)
 {
+	if (dc_is_hdmi_frl_signal(stream->signal)) {
+		struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+		return dcn30_link_encoder_validate_hdmi_frl_output(enc10, &stream->timing);
+	} else {
 		return dcn10_link_encoder_validate_output_with_stream(enc, stream);
+	}
+}
+
+//---------------------------------------------------
+// Task: Program EQ setting
+// Note:
+//      EQ setting can be dont during P2 state or P0 state
+//      If set in P0 state, The values are latched in a single
+//      cycle of txX_clk but will take maximum of 40 txX_clk symbols
+//      to be reflected on the output. During this period the
+//      analog serial lines might have a transitional behavior.
+//---------------------------------------------------
+void dpcs30_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings)
+{
+	(void)link_settings;
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	/* EQ setting for DP lane0 */
+	uint32_t eq_main;
+	uint32_t eq_pre;
+	uint32_t eq_post;
+
+	if (enc10->base.ctx->dc->debug.ignore_ffe)
+		return;
+
+	if (FFE_Level < 0x5)
+		enc10->base.txffe_state = FFE_Level;
+
+	if (FFE_Level == 0xEE) {
+		enc10->base.txffe_state++;
+		if (enc10->base.txffe_state > 3)
+			enc10->base.txffe_state = 0;
+	}
+
+	switch (enc10->base.txffe_state) {
+	case 0:
+		eq_main = 0x31;
+		if (de_emphasis_only)
+			eq_main = 0x36;
+		if (pre_shoot_only)
+			eq_main = 0x39;
+		eq_pre = 0x5;
+		eq_post = 0x8;
+		break;
+	case 1:
+		eq_main = 0x2F;
+		if (de_emphasis_only)
+			eq_main = 0x34;
+		if (pre_shoot_only)
+			eq_main = 0x39;
+		eq_pre = 0x5;
+		eq_post = 0xA;
+		break;
+	case 2:
+		eq_main = 0x2C;
+		if (de_emphasis_only)
+			eq_main = 0x31;
+		if (pre_shoot_only)
+			eq_main = 0x39;
+		eq_pre = 0x5;
+		eq_post = 0xD;
+		break;
+	case 3:
+		eq_main = 0x29;
+		if (de_emphasis_only)
+			eq_main = 0x2E;
+		if (pre_shoot_only)
+			eq_main = 0x39;
+		eq_pre = 0x5;
+		eq_post = 0x10;
+		break;
+	default:
+		return;
+	}
+
+	eq_pre = de_emphasis_only ? 0 : eq_pre;
+	eq_post = pre_shoot_only ? 0 : eq_post;
+
+	if (no_ffe) {
+		eq_pre = 0;
+		eq_post = 0;
+		eq_main = 0x3E;
+	}
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE0,
+			RDPCS_PHY_DP_TX0_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX0_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX0_EQ_POST, eq_post);
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE1,
+			RDPCS_PHY_DP_TX1_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX1_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX1_EQ_POST, eq_post);
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE2,
+			RDPCS_PHY_DP_TX2_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX2_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX2_EQ_POST, eq_post);
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE3,
+			RDPCS_PHY_DP_TX3_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX3_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX3_EQ_POST, eq_post);
+}
+
+void dpcs30_get_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	/* EQ setting for DP lane0 */
+	uint32_t eq_main;
+	uint32_t eq_pre;
+	uint32_t eq_post;
+
+	REG_GET_3(RDPCSTX_PHY_FUSE0,
+			RDPCS_PHY_DP_TX0_EQ_MAIN, &eq_main,
+			RDPCS_PHY_DP_TX0_EQ_PRE, &eq_pre,
+			RDPCS_PHY_DP_TX0_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[0] = eq_main;
+	lane_settings->pre_emphasis[0] = eq_pre;
+	lane_settings->post_emphasis[0] = eq_post;
+
+	REG_GET_3(RDPCSTX_PHY_FUSE1,
+			RDPCS_PHY_DP_TX1_EQ_MAIN, &eq_main,
+			RDPCS_PHY_DP_TX1_EQ_PRE, &eq_pre,
+			RDPCS_PHY_DP_TX1_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[1] = eq_main;
+	lane_settings->pre_emphasis[1] = eq_pre;
+	lane_settings->post_emphasis[1] = eq_post;
+
+	REG_GET_3(RDPCSTX_PHY_FUSE2,
+			RDPCS_PHY_DP_TX2_EQ_MAIN, &eq_main,
+			RDPCS_PHY_DP_TX2_EQ_PRE, &eq_pre,
+			RDPCS_PHY_DP_TX2_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[2] = eq_main;
+	lane_settings->pre_emphasis[2] = eq_pre;
+	lane_settings->post_emphasis[2] = eq_post;
+
+	REG_GET_3(RDPCSTX_PHY_FUSE3,
+			RDPCS_PHY_DP_TX3_EQ_MAIN, &eq_main,
+			RDPCS_PHY_DP_TX3_EQ_PRE, &eq_pre,
+			RDPCS_PHY_DP_TX3_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[3] = eq_main;
+	lane_settings->pre_emphasis[3] = eq_pre;
+	lane_settings->post_emphasis[3] = eq_post;
+
+}
+
+void dpcs30_set_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	/* EQ setting for DP lane0 */
+	uint32_t eq_main;
+	uint32_t eq_pre;
+	uint32_t eq_post;
+
+	eq_main = lane_settings->amplitude[0];
+	eq_pre = lane_settings->pre_emphasis[0];
+	eq_post = lane_settings->post_emphasis[0];
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE0,
+			RDPCS_PHY_DP_TX0_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX0_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX0_EQ_POST, eq_post);
+
+	eq_main = lane_settings->amplitude[1];
+	eq_pre = lane_settings->pre_emphasis[1];
+	eq_post = lane_settings->post_emphasis[1];
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE1,
+			RDPCS_PHY_DP_TX1_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX1_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX1_EQ_POST, eq_post);
+
+	eq_main = lane_settings->amplitude[2];
+	eq_pre = lane_settings->pre_emphasis[2];
+	eq_post = lane_settings->post_emphasis[2];
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE2,
+			RDPCS_PHY_DP_TX2_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX2_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX2_EQ_POST, eq_post);
+
+	eq_main = lane_settings->amplitude[3];
+	eq_pre = lane_settings->pre_emphasis[3];
+	eq_post = lane_settings->post_emphasis[3];
+
+	REG_UPDATE_3(RDPCSTX_PHY_FUSE3,
+			RDPCS_PHY_DP_TX3_EQ_MAIN, eq_main,
+			RDPCS_PHY_DP_TX3_EQ_PRE, eq_pre,
+			RDPCS_PHY_DP_TX3_EQ_POST, eq_post);
 }
 
 static const struct link_encoder_funcs dcn30_link_enc_funcs = {
@@ -84,6 +313,15 @@ static const struct link_encoder_funcs dcn30_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs30_program_eq_setting,
+	.get_txffe = dpcs30_get_txffe,
+	.set_txffe = dpcs30_set_txffe,
 	.get_hpd_state = dcn10_get_hpd_state,
 	.program_hpd_filter = dcn10_program_hpd_filter,
 };
@@ -198,6 +436,12 @@ void dcn30_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
 		enc10->base.features.flags.bits.DP_IS_USB_C =
 				bp_cap_info.DP_IS_USB_C;
+
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = bp_cap_info.IS_HDMI_FRL_CAPABLE;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -206,6 +450,12 @@ void dcn30_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
 
 #define AUX_REG(reg)\
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.h
index 5b6177c2ae98..4fc0915a5dc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.h
@@ -60,6 +60,8 @@
 
 #define DPCS_DCN3_MASK_SH_LIST(mask_sh)\
 	DPCS_DCN2_MASK_SH_LIST(mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_HDMI_FRL_MODE, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_SWAP_10_BIT, mask_sh),\
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_ORDER_INVERT_18_BIT, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_TX_VBOOST_LVL, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_TX_CLK_EN, mask_sh),\
@@ -83,4 +85,19 @@ bool dcn30_link_encoder_validate_output_with_stream(
 	struct link_encoder *enc,
 	const struct dc_stream_state *stream);
 
+void dpcs30_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings);
+
+void dpcs30_get_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
+
+void dpcs30_set_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
 #endif /* __DC_LINK_ENCODER__DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
index 47d84a2a48ce..02fb844670f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
@@ -73,6 +73,13 @@ static const struct link_encoder_funcs dcn301_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = NULL,
 	.get_hpd_state = dcn10_get_hpd_state,
 	.program_hpd_filter = dcn10_program_hpd_filter,
 };
@@ -183,6 +190,11 @@ void dcn301_link_encoder_construct(
 		enc10->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
 		enc10->base.features.flags.bits.DP_IS_USB_C =
 				bp_cap_info.DP_IS_USB_C;
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = bp_cap_info.IS_HDMI_FRL_CAPABLE;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -191,4 +203,10 @@ void dcn301_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
index 07d362ef0daf..bcb791d74189 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
@@ -67,6 +67,17 @@
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #endif
 
+// HDMI FRL EQ Setting masks/shifts
+// EQ level 0-32 bits[0:1]
+#define HDMI_FRL_EQ__LEVEL__SHIFT 0x0
+#define HDMI_FRL_EQ__LEVEL__MASK 0x3
+// Enable no preshoot bit[5]
+#define HDMI_FRL_EQ__NO_PRE__SHIFT 0x5
+// Enable no demphasis bit[6]
+#define HDMI_FRL_EQ__NO_DEMPH__SHIFT 0x6
+// Enable no FFE bit[4]
+#define HDMI_FRL_EQ__NO_FFE__SHIFT 0x4
+
 static uint8_t phy_id_from_transmitter(enum transmitter t)
 {
 	uint8_t phy_id;
@@ -246,6 +257,89 @@ void enc31_hw_init(struct link_encoder *enc)
 	dcn10_aux_initialize(enc10);
 }
 
+static enum bp_result link_transmitter_control(
+	struct dcn10_link_encoder *enc10,
+	struct bp_transmitter_control *cntl)
+{
+	enum bp_result result;
+	struct dc_bios *bp = enc10->base.ctx->dc_bios;
+
+	result = bp->funcs->transmitter_control(bp, cntl);
+
+	return result;
+}
+//---------------------------------------------------
+// Task: Program EQ setting in HDMI FRL mode
+// Note:
+//      EQ setting can be dont during P2 state or P0 state
+//      If set in P0 state, The values are latched in a single
+//      cycle of txX_clk but will take maximum of 40 txX_clk symbols
+//      to be reflected on the output. During this period the
+//      analog serial lines might have a transitional behavior.
+//---------------------------------------------------
+void dpcs31_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	/* EQ setting for DP lane0 */
+
+	if (enc10->base.ctx->dc->debug.ignore_ffe)
+		return;
+
+	if (FFE_Level < 0x5)
+		enc10->base.txffe_state = FFE_Level;
+
+	if (FFE_Level == 0xEE) {
+		enc10->base.txffe_state++;
+		if (enc10->base.txffe_state > 3)
+			enc10->base.txffe_state = 0;
+	}
+
+	if (no_ffe) {
+		de_emphasis_only = true;
+		pre_shoot_only = true;
+	}
+	/* Pass on the input params to DMCUB for proper calc of eq settings */
+	cntl.lane_settings = ((de_emphasis_only ? 1 : 0) << HDMI_FRL_EQ__NO_PRE__SHIFT) |
+						 ((pre_shoot_only ? 1 : 0) << HDMI_FRL_EQ__NO_DEMPH__SHIFT) |
+						 ((enc10->base.txffe_state & HDMI_FRL_EQ__LEVEL__MASK)
+						  << HDMI_FRL_EQ__LEVEL__SHIFT);
+	cntl.lane_select = 0;
+	cntl.action = TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS;
+	cntl.transmitter = enc10->base.transmitter;
+	cntl.connector_obj_id = enc10->base.connector;
+	cntl.lanes_number = link_settings->frl_num_lanes;
+	cntl.hpd_sel = enc10->base.hpd_source;
+	/* Use below or dc_link_frl_bandwidth_kbps()? */
+	switch (link_settings->frl_link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		cntl.pixel_clock = 166667 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		cntl.pixel_clock = 333333 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		cntl.pixel_clock = 444444 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+		cntl.pixel_clock = 555555 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+	default:
+		cntl.pixel_clock = 666667 / 10;
+		break;
+	}
+	/* call VBIOS table to set eq settings - voltage swing and pre-emphasis */
+	link_transmitter_control(enc10, &cntl);
+}
+
 static const struct link_encoder_funcs dcn31_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -275,6 +369,15 @@ static const struct link_encoder_funcs dcn31_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn31_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs31_program_eq_setting,
+	.get_txffe = dpcs30_get_txffe,
+	.set_txffe = dpcs30_set_txffe,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.get_hpd_state = dcn10_get_hpd_state,
 	.program_hpd_filter = dcn10_program_hpd_filter,
@@ -387,6 +490,11 @@ void dcn31_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
 		enc10->base.features.flags.bits.DP_IS_USB_C =
 				bp_cap_info.DP_IS_USB_C;
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = bp_cap_info.IS_HDMI_FRL_CAPABLE;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -395,6 +503,12 @@ void dcn31_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
 
 void dcn31_link_encoder_construct_minimal(
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
index ee78ba80797c..3cf587527991 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
@@ -285,6 +285,14 @@ bool dcn31_link_encoder_is_in_alt_mode(
 void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings);
 
+void dpcs31_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings);
+
 void enc31_hw_init(struct link_encoder *enc);
 
 #endif /* __DC_LINK_ENCODER__DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
index 65d28cb07b04..68e0dc93ae7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
@@ -62,6 +62,17 @@
 #define AUX_REG_WRITE(reg_name, val) \
 			dm_write_reg(CTX, AUX_REG(reg_name), val)
 
+// HDMI FRL EQ Setting masks/shifts
+// EQ level 0-32 bits[0:1]
+#define HDMI_FRL_EQ__LEVEL__SHIFT 0x0
+#define HDMI_FRL_EQ__LEVEL__MASK 0x3
+// Enable no preshoot bit[5]
+#define HDMI_FRL_EQ__NO_PRE__SHIFT 0x5
+// Enable no demphasis bit[6]
+#define HDMI_FRL_EQ__NO_DEMPH__SHIFT 0x6
+// Enable no FFE bit[4]
+#define HDMI_FRL_EQ__NO_FFE__SHIFT 0x4
+
 static uint8_t phy_id_from_transmitter(enum transmitter t)
 {
 	uint8_t phy_id;
@@ -203,6 +214,188 @@ void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 }
 
 
+static enum bp_result link_transmitter_control(
+	struct dcn10_link_encoder *enc10,
+	struct bp_transmitter_control *cntl)
+{
+	enum bp_result result;
+	struct dc_bios *bp = enc10->base.ctx->dc_bios;
+
+	result = bp->funcs->transmitter_control(bp, cntl);
+
+	return result;
+}
+//---------------------------------------------------
+// Task: Program EQ setting
+// Note:
+//      EQ setting can be dont during P2 state or P0 state
+//      If set in P0 state, The values are latched in a single
+//      cycle of txX_clk but will take maximum of 40 txX_clk symbols
+//      to be reflected on the output. During this period the
+//      analog serial lines might have a transitional behavior.
+//---------------------------------------------------
+void dpcs32_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	/* EQ setting for DP lane0 */
+
+	if (enc10->base.ctx->dc->debug.ignore_ffe)
+		return;
+
+	if (FFE_Level < 0x5)
+		enc10->base.txffe_state = FFE_Level;
+
+	if (FFE_Level == 0xEE) {
+		enc10->base.txffe_state++;
+		if (enc10->base.txffe_state > 3)
+			enc10->base.txffe_state = 0;
+	}
+
+	if (no_ffe) {
+		de_emphasis_only = true;
+		pre_shoot_only = true;
+	}
+	/* Pass on the input params to DMCUB for proper calc of eq settings */
+	cntl.lane_settings = ((de_emphasis_only ? 1 : 0) << HDMI_FRL_EQ__NO_PRE__SHIFT) |
+						 ((pre_shoot_only ? 1 : 0) << HDMI_FRL_EQ__NO_DEMPH__SHIFT) |
+						 ((enc10->base.txffe_state & HDMI_FRL_EQ__LEVEL__MASK)
+						  << HDMI_FRL_EQ__LEVEL__SHIFT);
+	cntl.lane_select = 0;
+	cntl.action = TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS;
+	cntl.transmitter = enc10->base.transmitter;
+	cntl.connector_obj_id = enc10->base.connector;
+	cntl.lanes_number = link_settings->frl_num_lanes;
+	cntl.hpd_sel = enc10->base.hpd_source;
+	/* Use below or dc_link_frl_bandwidth_kbps()? */
+	switch (link_settings->frl_link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		cntl.pixel_clock = 166667 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		cntl.pixel_clock = 333333 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		cntl.pixel_clock = 444444 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+		cntl.pixel_clock = 555555 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+	default:
+		cntl.pixel_clock = 666667 / 10;
+		break;
+	}
+	/* call VBIOS table to set eq settings - voltage swing and pre-emphasis */
+	link_transmitter_control(enc10, &cntl);
+}
+
+void dpcs32_get_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings)
+{
+	(void)enc;
+	/* EQ setting for DP lane0 */
+	uint32_t eq_main = 0;
+	uint32_t eq_pre = 0;
+	uint32_t eq_post = 0;
+
+	/* TODO */
+	//REG_GET_3(RDPCSTX_PHY_FUSE0,
+	//		RDPCS_PHY_DP_TX0_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX0_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX0_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[0] = eq_main;
+	lane_settings->pre_emphasis[0] = eq_pre;
+	lane_settings->post_emphasis[0] = eq_post;
+
+	//REG_GET_3(RDPCSTX_PHY_FUSE1,
+	//		RDPCS_PHY_DP_TX1_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX1_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX1_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[1] = eq_main;
+	lane_settings->pre_emphasis[1] = eq_pre;
+	lane_settings->post_emphasis[1] = eq_post;
+
+	//REG_GET_3(RDPCSTX_PHY_FUSE2,
+	//		RDPCS_PHY_DP_TX2_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX2_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX2_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[2] = eq_main;
+	lane_settings->pre_emphasis[2] = eq_pre;
+	lane_settings->post_emphasis[2] = eq_post;
+
+	//REG_GET_3(RDPCSTX_PHY_FUSE3,
+	//		RDPCS_PHY_DP_TX3_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX3_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX3_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[3] = eq_main;
+	lane_settings->pre_emphasis[3] = eq_pre;
+	lane_settings->post_emphasis[3] = eq_post;
+
+}
+
+void dpcs32_set_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings)
+{
+	(void)enc;
+	(void)lane_settings;
+	/* EQ setting for DP lane0 */
+	//uint32_t eq_main;
+	//uint32_t eq_pre;
+	//uint32_t eq_post;
+
+	//eq_main = lane_settings->amplitude[0];
+	//eq_pre = lane_settings->pre_emphasis[0];
+	//eq_post = lane_settings->post_emphasis[0];
+
+	/* TODO */
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE0,
+	//		RDPCS_PHY_DP_TX0_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX0_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX0_EQ_POST, eq_post);
+
+	//eq_main = lane_settings->amplitude[1];
+	//eq_pre = lane_settings->pre_emphasis[1];
+	//eq_post = lane_settings->post_emphasis[1];
+
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE1,
+	//		RDPCS_PHY_DP_TX1_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX1_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX1_EQ_POST, eq_post);
+
+	//eq_main = lane_settings->amplitude[2];
+	//eq_pre = lane_settings->pre_emphasis[2];
+	//eq_post = lane_settings->post_emphasis[2];
+
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE2,
+	//		RDPCS_PHY_DP_TX2_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX2_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX2_EQ_POST, eq_post);
+
+	//1eq_main = lane_settings->amplitude[3];
+	//eq_pre = lane_settings->pre_emphasis[3];
+	//eq_post = lane_settings->post_emphasis[3];
+
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE3,
+	//		RDPCS_PHY_DP_TX3_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX3_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX3_EQ_POST, eq_post);
+}
+
+
 static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -232,6 +425,15 @@ static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs32_program_eq_setting,
+	.get_txffe = dpcs32_get_txffe,
+	.set_txffe = dpcs32_set_txffe,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.get_hpd_state = dcn10_get_hpd_state,
 	.program_hpd_filter = dcn10_program_hpd_filter,
@@ -329,6 +531,12 @@ void dcn32_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -337,4 +545,10 @@ void dcn32_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.h
index 35d23d9db45e..262796819a63 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.h
@@ -50,4 +50,20 @@ bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc);
 void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings);
 
+void dpcs32_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings);
+
+void dpcs32_get_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
+
+void dpcs32_set_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
+
 #endif /* __DC_LINK_ENCODER__DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
index 968f89295b64..4108fd0f4380 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
@@ -88,6 +88,15 @@ static const struct link_encoder_funcs dcn321_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs32_program_eq_setting,
+	.get_txffe = dpcs32_get_txffe,
+	.set_txffe = dpcs32_set_txffe,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.get_hpd_state = dcn10_get_hpd_state,
 	.program_hpd_filter = dcn10_program_hpd_filter,
@@ -183,6 +192,11 @@ void dcn321_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -190,4 +204,10 @@ void dcn321_link_encoder_construct(
 	}
 	if (enc10->base.ctx->dc->debug.hdmi20_disable)
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
index 20bf04dac609..8fa9b8c500f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
@@ -158,6 +158,15 @@ static const struct link_encoder_funcs dcn35_link_enc_funcs = {
 	.get_dig_mode = dcn35_get_dig_mode,
 	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn31_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs32_program_eq_setting,
+	.get_txffe = dpcs32_get_txffe,
+	.set_txffe = dpcs32_set_txffe,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.enable_dpia_output = dcn35_link_encoder_enable_dpia_output,
 	.disable_dpia_output = dcn35_link_encoder_disable_dpia_output,
@@ -261,6 +270,12 @@ void dcn35_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
 
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE =
+				bp_cap_info.FRL_8G_EN || bp_cap_info.FRL_10G_EN || bp_cap_info.FRL_12G_EN;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -268,6 +283,12 @@ void dcn35_link_encoder_construct(
 	}
 	if (enc10->base.ctx->dc->debug.hdmi20_disable)
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
index e1f0a1bf1075..2aaf06d48771 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
@@ -65,6 +65,17 @@
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #endif
 
+// HDMI FRL EQ Setting masks/shifts
+// EQ level 0-32 bits[0:1]
+#define HDMI_FRL_EQ__LEVEL__SHIFT 0x0
+#define HDMI_FRL_EQ__LEVEL__MASK 0x3
+// Enable no preshoot bit[5]
+#define HDMI_FRL_EQ__NO_PRE__SHIFT 0x5
+// Enable no demphasis bit[6]
+#define HDMI_FRL_EQ__NO_DEMPH__SHIFT 0x6
+// Enable no FFE bit[4]
+#define HDMI_FRL_EQ__NO_FFE__SHIFT 0x4
+
 void enc401_hw_init(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
@@ -120,6 +131,194 @@ void dcn401_link_encoder_enable_dp_output(
 	}
 }
 
+static enum bp_result link_transmitter_control(
+	struct dcn10_link_encoder *enc10,
+	struct bp_transmitter_control *cntl)
+{
+	enum bp_result result;
+	struct dc_bios *bp = enc10->base.ctx->dc_bios;
+
+	result = bp->funcs->transmitter_control(bp, cntl);
+
+	return result;
+}
+//---------------------------------------------------
+// Task: Program EQ setting
+// Note:
+//      EQ setting can be dont during P2 state or P0 state
+//      If set in P0 state, The values are latched in a single
+//      cycle of txX_clk but will take maximum of 40 txX_clk symbols
+//      to be reflected on the output. During this period the
+//      analog serial lines might have a transitional behavior.
+//---------------------------------------------------
+
+void dpcs401_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+
+	if (enc10->base.ctx->dc->debug.ignore_ffe)
+		return;
+
+	if (FFE_Level < 0x5)
+		enc10->base.txffe_state = FFE_Level;
+
+	if (enc10->base.ctx->dc->debug.select_ffe)
+		enc10->base.txffe_state =
+				(uint8_t)enc10->base.ctx->dc->debug.select_ffe;
+
+	if (FFE_Level == 0xEE) {
+		enc10->base.txffe_state++;
+		if (enc10->base.txffe_state > 3)
+			enc10->base.txffe_state = 0;
+	}
+
+	if (no_ffe) {
+		de_emphasis_only = true;
+		pre_shoot_only = true;
+	}
+	/* Pass on the input params to DMCUB for proper calc of eq settings */
+	cntl.lane_settings = ((de_emphasis_only ? 1 : 0) << HDMI_FRL_EQ__NO_PRE__SHIFT) |
+						 ((pre_shoot_only ? 1 : 0) << HDMI_FRL_EQ__NO_DEMPH__SHIFT) |
+						 ((enc10->base.txffe_state & HDMI_FRL_EQ__LEVEL__MASK)
+						  << HDMI_FRL_EQ__LEVEL__SHIFT);
+	cntl.lane_select = 0;
+	cntl.action = TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS;
+	cntl.transmitter = enc10->base.transmitter;
+	cntl.connector_obj_id = enc10->base.connector;
+	cntl.lanes_number = link_settings->frl_num_lanes;
+	cntl.hpd_sel = enc10->base.hpd_source;
+	/* Use below or dc_link_frl_bandwidth_kbps()? */
+	switch (link_settings->frl_link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		cntl.pixel_clock = 166667 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		cntl.pixel_clock = 333333 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		cntl.pixel_clock = 444444 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+		cntl.pixel_clock = 555555 / 10;
+		break;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+	default:
+		cntl.pixel_clock = 666667 / 10;
+		break;
+	}
+	/* call VBIOS table to set eq settings - voltage swing and pre-emphasis */
+	link_transmitter_control(enc10, &cntl);
+}
+
+void dpcs401_get_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings)
+{
+	(void)enc;
+	/* EQ setting for DP lane0 */
+	uint32_t eq_main = 0;
+	uint32_t eq_pre = 0;
+	uint32_t eq_post = 0;
+
+	/* TODO */
+	//REG_GET_3(RDPCSTX_PHY_FUSE0,
+	//		RDPCS_PHY_DP_TX0_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX0_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX0_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[0] = eq_main;
+	lane_settings->pre_emphasis[0] = eq_pre;
+	lane_settings->post_emphasis[0] = eq_post;
+
+	//REG_GET_3(RDPCSTX_PHY_FUSE1,
+	//		RDPCS_PHY_DP_TX1_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX1_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX1_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[1] = eq_main;
+	lane_settings->pre_emphasis[1] = eq_pre;
+	lane_settings->post_emphasis[1] = eq_post;
+
+	//REG_GET_3(RDPCSTX_PHY_FUSE2,
+	//		RDPCS_PHY_DP_TX2_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX2_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX2_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[2] = eq_main;
+	lane_settings->pre_emphasis[2] = eq_pre;
+	lane_settings->post_emphasis[2] = eq_post;
+
+	//REG_GET_3(RDPCSTX_PHY_FUSE3,
+	//		RDPCS_PHY_DP_TX3_EQ_MAIN, &eq_main,
+	//		RDPCS_PHY_DP_TX3_EQ_PRE, &eq_pre,
+	//		RDPCS_PHY_DP_TX3_EQ_POST, &eq_post);
+
+	lane_settings->amplitude[3] = eq_main;
+	lane_settings->pre_emphasis[3] = eq_pre;
+	lane_settings->post_emphasis[3] = eq_post;
+
+}
+
+void dpcs401_set_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings)
+{
+	(void)enc;
+	(void)lane_settings;
+	//struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	/* EQ setting for DP lane0 */
+	//TODO: Unused
+	//uint32_t eq_main;
+	//uint32_t eq_pre;
+	//uint32_t eq_post;
+
+	//eq_main = lane_settings->amplitude[0];
+	//eq_pre = lane_settings->pre_emphasis[0];
+	//eq_post = lane_settings->post_emphasis[0];
+
+	/* TODO */
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE0,
+	//		RDPCS_PHY_DP_TX0_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX0_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX0_EQ_POST, eq_post);
+
+	//eq_main = lane_settings->amplitude[1];
+	//eq_pre = lane_settings->pre_emphasis[1];
+	//eq_post = lane_settings->post_emphasis[1];
+
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE1,
+	//		RDPCS_PHY_DP_TX1_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX1_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX1_EQ_POST, eq_post);
+
+	//eq_main = lane_settings->amplitude[2];
+	//eq_pre = lane_settings->pre_emphasis[2];
+	//eq_post = lane_settings->post_emphasis[2];
+
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE2,
+	//		RDPCS_PHY_DP_TX2_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX2_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX2_EQ_POST, eq_post);
+
+	//eq_main = lane_settings->amplitude[3];
+	//eq_pre = lane_settings->pre_emphasis[3];
+	//eq_post = lane_settings->post_emphasis[3];
+
+	//REG_UPDATE_3(RDPCSTX_PHY_FUSE3,
+	//		RDPCS_PHY_DP_TX3_EQ_MAIN, eq_main,
+	//		RDPCS_PHY_DP_TX3_EQ_PRE, eq_pre,
+	//		RDPCS_PHY_DP_TX3_EQ_POST, eq_post);
+}
+
+
 void dcn401_link_encoder_setup(
 	struct link_encoder *enc,
 	enum signal_type signal)
@@ -214,6 +413,15 @@ static const struct link_encoder_funcs dcn401_link_enc_funcs = {
 	.get_dig_mode = dcn401_get_dig_mode,
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs401_program_eq_setting,
+	.get_txffe = dpcs401_get_txffe,
+	.set_txffe = dpcs401_set_txffe,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.get_hpd_state = dcn10_get_hpd_state,
 	.program_hpd_filter = dcn10_program_hpd_filter,
@@ -314,6 +522,12 @@ void dcn401_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE =
+				bp_cap_info.FRL_8G_EN || bp_cap_info.FRL_10G_EN || bp_cap_info.FRL_12G_EN;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -322,4 +536,10 @@ void dcn401_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
index 6baab8302b81..a40c479fada8 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
@@ -121,6 +121,22 @@ void dcn401_link_encoder_enable_dp_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source);
 
+void dpcs401_program_eq_setting(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings);
+
+void dpcs401_get_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
+
+void dpcs401_set_txffe(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
+
 void dcn401_link_encoder_setup(
 	struct link_encoder *enc,
 	enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
index 35dfe3bb0c55..fae49b3b170e 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
@@ -93,6 +93,15 @@ static const struct link_encoder_funcs dcn42_link_enc_funcs = {
 	.get_dig_mode = dcn401_get_dig_mode,
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
+	.dpcstx_set_order_invert_18_bit = NULL,
+	.set_phy_source = NULL,
+	.dpcs_initialize_phy = NULL,
+	.dpcs_configure_phypll = NULL,
+	.dpcs_configure_dpcs = NULL,
+	.dpcs_enable_dpcs = NULL,
+	.prog_eq_setting = dpcs401_program_eq_setting,
+	.get_txffe = dpcs401_get_txffe,
+	.set_txffe = dpcs401_set_txffe,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.enable_dpia_output = dcn35_link_encoder_enable_dpia_output,
 	.disable_dpia_output = dcn35_link_encoder_disable_dpia_output,
@@ -194,6 +203,12 @@ void dcn42_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE =
+				bp_cap_info.FRL_8G_EN || bp_cap_info.FRL_10G_EN || bp_cap_info.FRL_12G_EN;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = bp_cap_info.FRL_8G_EN;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = bp_cap_info.FRL_10G_EN;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = bp_cap_info.FRL_12G_EN;
+		enc10->base.txffe_state = 0;
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
@@ -202,4 +217,10 @@ void dcn42_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+	if (enc10->base.ctx->dc->config.force_hdmi21_frl_enc_enable) {
+		enc10->base.features.flags.bits.IS_HDMI_FRL_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_8G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/Makefile b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
index 25b196714bd8..db60564b9cfd 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
@@ -27,6 +27,7 @@ ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN30
 ###############################################################################
+HPO_DCN30 = dcn30_hpo_frl_link_encoder.o dcn30_hpo_frl_stream_encoder.o
 
 AMD_DAL_HPO_DCN30 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn30/,$(HPO_DCN30))
 
@@ -48,10 +49,19 @@ AMD_DAL_HPO_DCN32 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn32/,$(HPO_DCN32))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN32)
 
+###############################################################################
+# DCN401
+###############################################################################
+HPO_DCN401 = dcn401_hpo_frl_stream_encoder.o
+
+AMD_DAL_HPO_DCN401 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn401/,$(HPO_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN401)
 ###############################################################################
 # DCN42
 ###############################################################################
 HPO_DCN42 = dcn42_hpo_dp_link_encoder.o
+HPO_DCN42 += dcn42_hpo_frl_stream_encoder.o
 
 AMD_DAL_HPO_DCN42 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn42/,$(HPO_DCN42))
 
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
new file mode 100644
index 000000000000..56e753d2f43d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
@@ -0,0 +1,286 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+
+#include "core_types.h"
+#include "dc_bios_types.h"
+#include "dcn30_hpo_frl_link_encoder.h"
+#include "reg_helper.h"
+#include "dcn10/dcn10_link_encoder.h"
+
+#define DC_LOGGER enc3->base.ctx->logger
+
+#define REG(reg) (enc3->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) enc3->hpo_le_shift->field_name, enc3->hpo_le_mask->field_name
+
+#define CTX enc3->base.ctx
+
+void hpo_frl_link_enc3_setup_link_encoder(struct hpo_frl_link_encoder *enc,
+						 int lane_count)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+
+	DC_LOG_DEBUG("Entering [%s]\n", __func__);
+
+	if (enc->ctx->dc->caps.ips_v2_support) {
+		REG_UPDATE(HDMI_FRL_ENC_MEM_CTRL,
+			METERBUFFER_MEM_PWR_DIS, 1);
+		REG_WAIT(HDMI_FRL_ENC_MEM_CTRL,	METERBUFFER_MEM_PWR_STATE, 0, 1, 100);
+	}
+	/* Enable Link encoder clock */
+	REG_UPDATE(HDMI_LINK_ENC_CLK_CTRL,
+		   HDMI_LINK_ENC_CLOCK_EN, 1);
+
+	/* Configure lane count of FRL encoder */
+	REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+		   HDMI_LINK_LANE_COUNT, lane_count == 3 ? 0 : 1);
+
+	/* Reset link encoder */
+	REG_UPDATE_2(HDMI_LINK_ENC_CONTROL,
+		     HDMI_LINK_ENC_ENABLE, 0,
+		     HDMI_LINK_ENC_SOFT_RESET, 1);
+
+	REG_UPDATE(HDMI_LINK_ENC_CONTROL,
+		   HDMI_LINK_ENC_SOFT_RESET, 0);
+
+	/* Enable link encoder */
+	REG_UPDATE(HDMI_LINK_ENC_CONTROL,
+		   HDMI_LINK_ENC_ENABLE, 1);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_frl_link_enc3_set_training_pattern(struct hpo_frl_link_encoder *enc,
+						   uint32_t lane0_pattern,
+						   uint32_t lane1_pattern,
+						   uint32_t lane2_pattern,
+						   uint32_t lane3_pattern)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+
+	/* Configure lane count of FRL encoder */
+	REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+		   HDMI_LINK_TRAINING_ENABLE, 1);
+
+	if (lane0_pattern < 8)
+		REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+			   HDMI_LINK_LANE0_TRAINING_PATTERN, lane0_pattern);
+
+	if (lane1_pattern < 8)
+		REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+			   HDMI_LINK_LANE1_TRAINING_PATTERN, lane1_pattern);
+
+	if (lane2_pattern < 8)
+		REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+			   HDMI_LINK_LANE2_TRAINING_PATTERN, lane2_pattern);
+
+	if (lane3_pattern < 8)
+		REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+			   HDMI_LINK_LANE3_TRAINING_PATTERN, lane3_pattern);
+}
+
+void hpo_frl_link_enc3_get_training_pattern(struct hpo_frl_link_encoder *enc,
+						   uint32_t *lane0_pattern,
+						   uint32_t *lane1_pattern,
+						   uint32_t *lane2_pattern,
+						   uint32_t *lane3_pattern)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+
+	/* Configure lane count of FRL encoder */
+	REG_GET_4(HDMI_FRL_ENC_CONFIG,
+		  HDMI_LINK_LANE0_TRAINING_PATTERN, lane0_pattern,
+		  HDMI_LINK_LANE1_TRAINING_PATTERN, lane1_pattern,
+		  HDMI_LINK_LANE2_TRAINING_PATTERN, lane2_pattern,
+		  HDMI_LINK_LANE3_TRAINING_PATTERN, lane3_pattern);
+}
+
+static enum bp_result link_transmitter_control(struct dcn10_link_encoder *enc10,
+					       struct bp_transmitter_control *cntl)
+{
+	struct dc_bios *bp = enc10->base.ctx->dc_bios;
+
+	return bp->funcs->transmitter_control(bp, cntl);
+}
+
+static void hpo_frl_link_enc3_enable_phy_output(struct hpo_frl_link_encoder *hpo_enc,
+						struct link_encoder *enc,
+						enum clock_source_id clock_source,
+						enum hdmi_frl_link_rate frl_link_rate)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(hpo_enc);
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
+
+	/* Enable the PHY */
+	cntl.action = TRANSMITTER_CONTROL_ENABLE;
+	cntl.engine_id = enc->preferred_engine;
+	cntl.transmitter = enc10->base.transmitter;
+	cntl.pll_id = clock_source;
+	cntl.signal = SIGNAL_TYPE_HDMI_FRL;
+	cntl.hpd_sel = enc10->base.hpd_source;
+
+	switch (frl_link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		cntl.pixel_clock = 166667;
+		break;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		cntl.pixel_clock = 333333;
+		break;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		cntl.pixel_clock = 444444;
+		break;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+		cntl.pixel_clock = 555555;
+		break;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+	default:
+		cntl.pixel_clock = 666667;
+		break;
+	}
+
+	cntl.hpo_engine_id = enc3->base.inst + ENGINE_ID_HPO_0;
+
+	if (frl_link_rate <= HDMI_FRL_LINK_RATE_6GBPS)
+		cntl.lanes_number = 3;
+	else
+		cntl.lanes_number = 4;
+
+	result = link_transmitter_control(enc10, &cntl);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_HDMI_FRL("%s: Failed to execute VBIOS command table!\n", __func__);
+		BREAK_TO_DEBUGGER();
+	}
+}
+
+void hpo_frl_link_enc3_enable_output(struct hpo_frl_link_encoder *enc)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	/* Enable FRL packet transmission */
+	REG_UPDATE(HDMI_FRL_ENC_CONFIG,
+		   HDMI_LINK_TRAINING_ENABLE, 0);
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_frl_link_enc3_disable(struct hpo_frl_link_encoder *enc)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	REG_UPDATE_5(HDMI_FRL_ENC_CONFIG,
+		     HDMI_LINK_TRAINING_ENABLE, 1,
+		     HDMI_LINK_LANE0_TRAINING_PATTERN, 0,
+		     HDMI_LINK_LANE1_TRAINING_PATTERN, 0,
+		     HDMI_LINK_LANE2_TRAINING_PATTERN, 0,
+		     HDMI_LINK_LANE3_TRAINING_PATTERN, 0);
+
+	/* Disable link encoder */
+	REG_UPDATE(HDMI_LINK_ENC_CONTROL,
+		   HDMI_LINK_ENC_ENABLE, 0);
+
+	/* Disable Link encoder clock */
+	REG_UPDATE(HDMI_LINK_ENC_CLK_CTRL,
+		   HDMI_LINK_ENC_CLOCK_EN, 0);
+	REG_UPDATE(HDMI_FRL_ENC_CONFIG2,
+		   HDMI_LINK_RC_COMPRESS_DISABLE, 0);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_frl_link_enc3_read_state(struct hpo_frl_link_encoder *enc,
+					 struct hpo_frl_link_enc_state *state)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 = DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+	unsigned int link_training_enabled;
+	unsigned int lane_count_field;
+
+	ASSERT(state);
+	REG_GET(HDMI_LINK_ENC_CONTROL,
+		HDMI_LINK_ENC_ENABLE, &state->link_enc_enabled);
+
+	REG_GET_2(HDMI_FRL_ENC_CONFIG,
+		  HDMI_LINK_TRAINING_ENABLE, &link_training_enabled,
+			  HDMI_LINK_LANE_COUNT, &lane_count_field);
+
+	state->link_active = link_training_enabled == 1;
+
+	if (lane_count_field == 1)
+		state->lane_count = 4;
+	else
+		state->lane_count = 3;
+}
+
+void hpo_frl_link_enc3_destroy(struct hpo_frl_link_encoder **enc)
+{
+	kfree(DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(*enc));
+	*enc = NULL;
+}
+
+void hpo_frl_link_enc3_apply_vsdb_rcc_wa(struct hpo_frl_link_encoder *enc)
+{
+	struct dcn30_hpo_frl_link_encoder *enc3 =
+			DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(enc);
+
+	REG_UPDATE(HDMI_FRL_ENC_CONFIG2,
+			HDMI_LINK_RC_COMPRESS_DISABLE, 1);
+}
+
+static struct hpo_frl_link_encoder_funcs dcn30_hpo_frl_link_encoder_funcs = {
+	.setup_link_encoder = hpo_frl_link_enc3_setup_link_encoder,
+	.set_hdmi_training_pattern = hpo_frl_link_enc3_set_training_pattern,
+	.get_hdmi_training_pattern = hpo_frl_link_enc3_get_training_pattern,
+	.enable_frl_phy_output = hpo_frl_link_enc3_enable_phy_output,
+	.enable_output = hpo_frl_link_enc3_enable_output,
+	.disable_link_encoder = hpo_frl_link_enc3_disable,
+	.read_state = hpo_frl_link_enc3_read_state,
+	.destroy = hpo_frl_link_enc3_destroy,
+	.apply_vsdb_rcc_wa = hpo_frl_link_enc3_apply_vsdb_rcc_wa
+};
+
+void hpo_frl_link_encoder3_construct(struct dcn30_hpo_frl_link_encoder *enc3,
+				     struct dc_context *ctx,
+				     uint32_t inst,
+				     const struct dcn30_hpo_frl_link_encoder_registers *hpo_le_regs,
+				     const struct dcn30_hpo_frl_link_encoder_shift *hpo_le_shift,
+				     const struct dcn30_hpo_frl_link_encoder_mask *hpo_le_mask)
+{
+	enc3->base.ctx = ctx;
+
+	enc3->base.inst = inst;
+	enc3->base.funcs = &dcn30_hpo_frl_link_encoder_funcs;
+
+	enc3->regs = hpo_le_regs;
+	enc3->hpo_le_shift = hpo_le_shift;
+	enc3->hpo_le_mask = hpo_le_mask;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
new file mode 100644
index 000000000000..9626793812b8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
@@ -0,0 +1,146 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DAL_DCN30_HPO_FRL_LINK_ENCODER_H__
+#define __DAL_DCN30_HPO_FRL_LINK_ENCODER_H__
+
+#include "link_encoder.h"
+
+
+#define DCN30_HPO_FRL_LINK_ENC_FROM_HPO_FRL_LINK_ENC(hpo_frl_link_encoder)\
+	container_of(hpo_frl_link_encoder, struct dcn30_hpo_frl_link_encoder, base)
+
+
+#define DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id) \
+	SR(HDMI_LINK_ENC_CLK_CTRL), \
+	SR(HDMI_LINK_ENC_CONTROL), \
+	SR(HDMI_FRL_ENC_CONFIG), \
+	SR(HDMI_FRL_ENC_CONFIG2),\
+	SR(HDMI_FRL_ENC_MEM_CTRL)
+
+struct dcn30_hpo_frl_link_encoder_registers {
+	uint32_t HDMI_LINK_ENC_CLK_CTRL;
+	uint32_t HDMI_LINK_ENC_CONTROL;
+	uint32_t HDMI_FRL_ENC_CONFIG;
+	uint32_t HDMI_FRL_ENC_CONFIG2;
+	uint32_t HDMI_FRL_ENC_MEM_CTRL;
+};
+
+#define DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(HDMI_LINK_ENC_CLK_CTRL, HDMI_LINK_ENC_CLOCK_EN, mask_sh),\
+	SE_SF(HDMI_LINK_ENC_CONTROL, HDMI_LINK_ENC_ENABLE, mask_sh),\
+	SE_SF(HDMI_LINK_ENC_CONTROL, HDMI_LINK_ENC_SOFT_RESET, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_MEM_CTRL, METERBUFFER_MEM_PWR_DIS, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_MEM_CTRL, METERBUFFER_MEM_PWR_FORCE, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_MEM_CTRL, METERBUFFER_MEM_PWR_STATE, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_MEM_CTRL, METERBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG, HDMI_LINK_LANE_COUNT, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG, HDMI_LINK_TRAINING_ENABLE, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG, HDMI_LINK_LANE0_TRAINING_PATTERN, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG, HDMI_LINK_LANE1_TRAINING_PATTERN, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG, HDMI_LINK_LANE2_TRAINING_PATTERN, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG, HDMI_LINK_LANE3_TRAINING_PATTERN, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_MAX_JITTER_VALUE, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_JITTER_THRESHOLD, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_JITTER_CAL_EN, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_RC_COMPRESS_DISABLE, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_FRL_HDMISTREAMCLK_DB_SEL, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_MAX_JITTER_VALUE_RESET, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_JITTER_EXCEED_STATUS, mask_sh),\
+	SE_SF(HDMI_FRL_ENC_CONFIG2, HDMI_LINK_METER_BUFFER_OVERFLOW_STATUS, mask_sh)
+
+#define HPO_FRL_LINK_ENC_DCN3_REG_FIELD_LIST(type) \
+	type HDMI_LINK_ENC_CLOCK_EN;\
+	type HDMI_LINK_ENC_ENABLE;\
+	type HDMI_LINK_ENC_SOFT_RESET;\
+	type HDMI_LINK_LANE_COUNT;\
+	type HDMI_LINK_TRAINING_ENABLE;\
+	type HDMI_LINK_LANE0_TRAINING_PATTERN;\
+	type HDMI_LINK_LANE1_TRAINING_PATTERN;\
+	type HDMI_LINK_LANE2_TRAINING_PATTERN;\
+	type HDMI_LINK_LANE3_TRAINING_PATTERN;\
+	type HDMI_LINK_MAX_JITTER_VALUE;\
+	type HDMI_LINK_JITTER_THRESHOLD;\
+	type HDMI_LINK_JITTER_CAL_EN;\
+	type HDMI_LINK_RC_COMPRESS_DISABLE;\
+	type METERBUFFER_MEM_PWR_DIS;\
+	type METERBUFFER_MEM_PWR_STATE;\
+	type METERBUFFER_MEM_PWR_FORCE;\
+	type METERBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE;\
+	type HDMI_FRL_HDMISTREAMCLK_DB_SEL;\
+	type HDMI_LINK_MAX_JITTER_VALUE_RESET;\
+	type HDMI_LINK_JITTER_EXCEED_STATUS;\
+	type HDMI_LINK_METER_BUFFER_OVERFLOW_STATUS
+
+
+struct dcn30_hpo_frl_link_encoder_shift {
+	HPO_FRL_LINK_ENC_DCN3_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn30_hpo_frl_link_encoder_mask {
+	HPO_FRL_LINK_ENC_DCN3_REG_FIELD_LIST(uint32_t);
+};
+
+struct dcn30_hpo_frl_link_encoder {
+	struct hpo_frl_link_encoder base;
+	const struct dcn30_hpo_frl_link_encoder_registers *regs;
+	const struct dcn30_hpo_frl_link_encoder_shift *hpo_le_shift;
+	const struct dcn30_hpo_frl_link_encoder_mask *hpo_le_mask;
+};
+
+void hpo_frl_link_enc3_setup_link_encoder(struct hpo_frl_link_encoder *enc,
+						 int lane_count);
+
+void hpo_frl_link_enc3_set_training_pattern(struct hpo_frl_link_encoder *enc,
+						uint32_t lane0_pattern,
+						uint32_t lane1_pattern,
+						uint32_t lane2_pattern,
+						uint32_t lane3_pattern);
+
+void hpo_frl_link_enc3_get_training_pattern(struct hpo_frl_link_encoder *enc,
+						uint32_t *lane0_pattern,
+						uint32_t *lane1_pattern,
+						uint32_t *lane2_pattern,
+						uint32_t *lane3_pattern);
+
+void hpo_frl_link_enc3_enable_output(struct hpo_frl_link_encoder *enc);
+
+void hpo_frl_link_enc3_disable(struct hpo_frl_link_encoder *enc);
+
+void hpo_frl_link_enc3_read_state(struct hpo_frl_link_encoder *enc,
+					 struct hpo_frl_link_enc_state *state);
+
+void hpo_frl_link_enc3_destroy(struct hpo_frl_link_encoder **enc);
+
+void hpo_frl_link_enc3_apply_vsdb_rcc_wa(struct hpo_frl_link_encoder *enc);
+
+void hpo_frl_link_encoder3_construct(struct dcn30_hpo_frl_link_encoder *enc3,
+				     struct dc_context *ctx,
+				     uint32_t inst,
+				     const struct dcn30_hpo_frl_link_encoder_registers *hpo_le_regs,
+				     const struct dcn30_hpo_frl_link_encoder_shift *hpo_le_shift,
+				     const struct dcn30_hpo_frl_link_encoder_mask *hpo_le_mask);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
new file mode 100644
index 000000000000..cd7d2bb661e5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
@@ -0,0 +1,938 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+
+#include "dc_bios_types.h"
+#include "core_types.h"
+#include "dcn30_hpo_frl_stream_encoder.h"
+#include "reg_helper.h"
+#include "hw_shared.h"
+#include "dcn_calc_math.h"
+#include "dml/dcn30/dcn30_fpu.h"
+
+#undef DC_LOGGER
+#define DC_LOGGER enc3->base.ctx->logger
+
+#define DTRACE(str, ...) {DC_LOG_HDMI_FRL(str, ##__VA_ARGS__); }
+
+#define DEBUG_FRL_CAP_CHK 1
+
+#define REG(reg) (enc3->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) enc3->hpo_se_shift->field_name, enc3->hpo_se_mask->field_name
+
+#define CTX enc3->base.ctx
+
+#define VBI_LINE_0 0
+
+void hpo_enc3_enable(struct hpo_frl_stream_encoder *enc, int otg_inst)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	/* Enable DISPCLK, SOCCLK, and HDMISTREAMCLK */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_CONTROL,
+		   HDMI_STREAM_ENC_CLOCK_EN, 1);
+
+	/* Reset */
+	REG_UPDATE_2(HDMI_TB_ENC_CONTROL,
+		     HDMI_RESET, 1,
+		     HDMI_TB_ENC_EN, 0);
+	REG_WAIT(HDMI_TB_ENC_CONTROL, HDMI_RESET_DONE,
+		 1, 10, 100);
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+		   HDMI_RESET, 0);
+
+	/* FOR DEBUG:  enable CRC */
+	REG_UPDATE_2(HDMI_TB_ENC_CRC_CNTL,
+		     HDMI_CRC_EN, 1,
+		     HDMI_CRC_CONT_EN, 1);
+
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2,
+		   FIFO_DB_DISABLE, 1);
+
+	/* TODO: confirm if need to set HDMI_DB_DISABLE -- HW team only setting FIFO_DB_DISABLE */
+	REG_UPDATE(HDMI_TB_ENC_DB_CONTROL,
+		   HDMI_DB_DISABLE, 1);
+
+	/* Set the input mux to select OTG source */
+	REG_UPDATE(HDMI_STREAM_ENC_INPUT_MUX_CONTROL,
+		   HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL, otg_inst);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc3_unblank(struct hpo_frl_stream_encoder *enc, int otg_inst)
+{
+	(void)otg_inst;
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	/*make sure FIFO_VIDEO_STREAM_ACTIVE =1*/
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 0);
+
+	/* Reset */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_RESET, 1);
+	REG_WAIT(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE,
+		 1, 10, 1000);
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_RESET, 0);
+	REG_WAIT(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE,
+		 0, 10, 1000);
+
+	/* Enable HDMI Tribyte Encoder */
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+		   HDMI_TB_ENC_EN, 1);
+
+	/* Enable Clock Ramp Adjuster FIFO */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 1);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+bool hpo_enc3_fifo_odm_enabled(struct hpo_frl_stream_encoder *enc)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	uint32_t fifo_odm_combine_mode;
+
+	REG_GET(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			FIFO_ODM_COMBINE_MODE, &fifo_odm_combine_mode);
+
+	return (fifo_odm_combine_mode != 0);
+}
+
+void hpo_enc3_blank(struct hpo_frl_stream_encoder *enc)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	/* Disable Clock Ramp Adjuster FIFO */
+	REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 0,
+		   FIFO_ODM_COMBINE_MODE, 0);
+
+	/* Disable HDMI Tribyte Encoder */
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+		   HDMI_TB_ENC_EN, 0);
+
+	/* Disable DISPCLK, SOCCLK, and HDMISTREAMCLK */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_CONTROL,
+		   HDMI_STREAM_ENC_CLOCK_EN, 0);
+}
+
+/* Setup stream encoder in hdmi mode
+ * - Precondition: link is trained
+ */
+void hpo_enc3_set_hdmi_stream_attribute(struct hpo_frl_stream_encoder *enc,
+					struct dc_crtc_timing *crtc_timing,
+					struct frl_borrow_params *borrow_params,
+					int odm_combine_num_segments)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	uint32_t h_active;
+	uint32_t h_blank;
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	/* Configure pixel encoding */
+	switch (crtc_timing->pixel_encoding) {
+	case PIXEL_ENCODING_YCBCR422:
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+			   HDMI_PIXEL_ENCODING, 1);
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			   FIFO_PIXEL_ENCODING, 1);
+		break;
+	case PIXEL_ENCODING_YCBCR420:
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+			   HDMI_PIXEL_ENCODING, 2);
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			   FIFO_PIXEL_ENCODING, 2);
+		break;
+	default:
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+			   HDMI_PIXEL_ENCODING, 0);
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			   FIFO_PIXEL_ENCODING, 0);
+		break;
+	}
+
+	/* Configure color depth */
+	switch (crtc_timing->display_color_depth) {
+	case COLOR_DEPTH_888:
+		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+			     HDMI_DEEP_COLOR_DEPTH, 0,
+			     HDMI_DEEP_COLOR_ENABLE, 0);
+		break;
+	case COLOR_DEPTH_101010:
+		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				     HDMI_DEEP_COLOR_DEPTH, 1,
+				     HDMI_DEEP_COLOR_ENABLE, 0);
+		} else {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				     HDMI_DEEP_COLOR_DEPTH, 1,
+				     HDMI_DEEP_COLOR_ENABLE, 1);
+		}
+		break;
+	case COLOR_DEPTH_121212:
+		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				     HDMI_DEEP_COLOR_DEPTH, 2,
+				     HDMI_DEEP_COLOR_ENABLE, 0);
+		} else {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				     HDMI_DEEP_COLOR_DEPTH, 2,
+				     HDMI_DEEP_COLOR_ENABLE, 1);
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* Configure ODM combine mode */
+	switch (odm_combine_num_segments) {
+	case 1:
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			   FIFO_ODM_COMBINE_MODE, 0);
+
+		if (enc3->hpo_se_mask->HDMI_ODM_COMBINE_MODE)
+			REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+				   HDMI_ODM_COMBINE_MODE, 0);
+		break;
+	case 2:
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			   FIFO_ODM_COMBINE_MODE, 1);
+
+		if (enc3->hpo_se_mask->HDMI_ODM_COMBINE_MODE)
+			REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+				   HDMI_ODM_COMBINE_MODE, 1);
+		break;
+	case 4:
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			   FIFO_ODM_COMBINE_MODE, 3);
+		break;
+	default:
+		break;
+	}
+
+	/* Configure horizontal active and blank size */
+	h_active = crtc_timing->h_addressable + crtc_timing->h_border_left + crtc_timing->h_border_right;
+	h_blank = crtc_timing->h_total - h_active;
+
+	if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
+	    crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		h_active /= 2;
+		h_blank /= 2;
+	}
+
+
+	REG_SET_2(HDMI_TB_ENC_H_ACTIVE_BLANK, 0,
+		  HDMI_H_ACTIVE, h_active,
+		  HDMI_H_BLANK, h_blank);
+
+	/* Configure borrow parameters */
+	REG_UPDATE(HDMI_TB_ENC_MODE,
+		   HDMI_BORROW_MODE, borrow_params->borrow_mode);
+
+	REG_UPDATE(HDMI_TB_ENC_PACKET_CONTROL,
+		   HDMI_MAX_PACKETS_PER_LINE, borrow_params->audio_packets_line);
+
+	REG_SET_2(HDMI_TB_ENC_HC_ACTIVE_BLANK, 0,
+		  HDMI_HC_ACTIVE, borrow_params->hc_active_target,
+		  HDMI_HC_BLANK, borrow_params->hc_blank_target);
+
+	/* Enable transmission of General Control packet on every frame */
+	REG_UPDATE_2(HDMI_TB_ENC_VBI_PACKET_CONTROL1,
+		     HDMI_GC_CONT, 1,
+		     HDMI_GC_SEND, 1);
+
+	/* Disable Audio Content Protection packet transmission */
+	/* TODO: review if this needs to be here */
+	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1,
+		   HDMI_ACP_SEND, 0);
+
+	/* Enable Audio InfoFrame packet transmission. */
+	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1,
+		   HDMI_AUDIO_INFO_SEND, 1);
+
+	/* update double-buffered AUDIO_INFO registers immediately */
+	ASSERT(enc->afmt);
+	enc->afmt->funcs->audio_info_immediate_update(enc->afmt);
+
+	/* Select line number on which to send Audio InfoFrame packets */
+	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_LINE,
+		   VBI_LINE_0 + 2);
+
+	/* set HDMI GC AVMUTE */
+	REG_UPDATE(HDMI_TB_ENC_GC_CONTROL,
+		   HDMI_GC_AVMUTE, 0);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc3_update_hdmi_info_packets(struct hpo_frl_stream_encoder *enc,
+				       const struct encoder_info_frame *info_frame)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	hpo_enc3_update_hdmi_info_packet(enc3, 0, &info_frame->avi);
+	hpo_enc3_update_hdmi_info_packet(enc3, 1, &info_frame->vendor);
+	hpo_enc3_update_hdmi_info_packet(enc3, 2, &info_frame->gamut);
+	hpo_enc3_update_hdmi_info_packet(enc3, 3, &info_frame->spd);
+	hpo_enc3_update_hdmi_info_packet(enc3, 4, &info_frame->hdrsmd);
+
+	/* 5-10 used by dsc */
+	hpo_enc3_update_hdmi_info_packet(enc3, 11, &info_frame->hfvsif);
+	hpo_enc3_update_hdmi_info_packet(enc3, 12, &info_frame->vtem);
+}
+
+void hpo_enc3_update_hdmi_info_packet(struct dcn30_hpo_frl_stream_encoder *enc3,
+				      uint32_t packet_index,
+				      const struct dc_info_packet *info_packet)
+{
+	uint32_t cont, send, line;
+
+	if (info_packet->valid) {
+		enc3->base.vpg->funcs->update_generic_info_packet(
+				enc3->base.vpg,
+				packet_index,
+				info_packet,
+				true);
+
+		/* enable transmission of packet(s) -
+		 * packet transmission begins on the next frame */
+		cont = 1;
+		/* send packet(s) every frame */
+		send = 1;
+		/* select line number to send packets on */
+		/* TODO: check if line 2 is correct */
+		line = 2;
+	} else {
+		cont = 0;
+		send = 0;
+		line = 0;
+	}
+
+	/* TODO: set bit to indicate if packet is Extended Metadata Packet. */
+	/* TODO: In DCN3, there are 0-14 generic packets */
+
+	/* choose which generic packet control to use */
+	switch (packet_index) {
+	case 0:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC0_CONT, cont,
+			     HDMI_GENERIC0_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE,
+			   HDMI_GENERIC0_LINE, line);
+		break;
+	case 1:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC1_CONT, cont,
+			     HDMI_GENERIC1_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE,
+			   HDMI_GENERIC1_LINE, line);
+		break;
+	case 2:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC2_CONT, cont,
+			     HDMI_GENERIC2_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE,
+			   HDMI_GENERIC2_LINE, line);
+		break;
+	case 3:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC3_CONT, cont,
+			     HDMI_GENERIC3_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE,
+			   HDMI_GENERIC3_LINE, line);
+		break;
+	case 4:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC4_CONT, cont,
+			     HDMI_GENERIC4_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE,
+			   HDMI_GENERIC4_LINE, line);
+		break;
+	case 5:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC5_CONT, cont,
+			     HDMI_GENERIC5_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE,
+			   HDMI_GENERIC5_LINE, line);
+		break;
+	case 6:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC6_CONT, cont,
+			     HDMI_GENERIC6_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE,
+			   HDMI_GENERIC6_LINE, line);
+		break;
+	case 7:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+			     HDMI_GENERIC7_CONT, cont,
+			     HDMI_GENERIC7_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE,
+			   HDMI_GENERIC7_LINE, line);
+		break;
+	case 8:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC8_CONT, cont,
+			     HDMI_GENERIC8_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE,
+			   HDMI_GENERIC8_LINE, line);
+		break;
+	case 9:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC9_CONT, cont,
+			     HDMI_GENERIC9_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE,
+			   HDMI_GENERIC9_LINE, line);
+		break;
+	case 10:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC10_CONT, cont,
+			     HDMI_GENERIC10_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE,
+			   HDMI_GENERIC10_LINE, line);
+		break;
+	case 11:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC11_CONT, cont,
+			     HDMI_GENERIC11_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE,
+			   HDMI_GENERIC11_LINE, line);
+		break;
+	case 12:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC12_CONT, cont,
+			     HDMI_GENERIC12_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE,
+			   HDMI_GENERIC12_LINE, line);
+		break;
+	case 13:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC13_CONT, cont,
+			     HDMI_GENERIC13_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE,
+			   HDMI_GENERIC13_LINE, line);
+		break;
+	case 14:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+			     HDMI_GENERIC14_CONT, cont,
+			     HDMI_GENERIC14_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET14_LINE,
+			   HDMI_GENERIC14_LINE, line);
+		break;
+	default:
+		/* invalid HW packet index */
+		DC_LOG_WARNING("Invalid HW packet index: %s()\n", __func__);
+		return;
+	}
+}
+
+void hpo_enc3_stop_hdmi_info_packets(
+	struct hpo_frl_stream_encoder *enc)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	/* TODO: should also set extended metadata packet bit back to 0? */
+
+	/* stop generic packets 0,1 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC0_CONT, 0,
+		HDMI_GENERIC0_SEND, 0,
+		HDMI_GENERIC1_CONT, 0,
+		HDMI_GENERIC1_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, 0,
+		HDMI_GENERIC0_LINE, 0,
+		HDMI_GENERIC1_LINE, 0);
+
+	/* stop generic packets 2,3 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC2_CONT, 0,
+		HDMI_GENERIC2_SEND, 0,
+		HDMI_GENERIC3_CONT, 0,
+		HDMI_GENERIC3_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, 0,
+		HDMI_GENERIC2_LINE, 0,
+		HDMI_GENERIC3_LINE, 0);
+
+	/* stop generic packets 4,5 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC4_CONT, 0,
+		HDMI_GENERIC4_SEND, 0,
+		HDMI_GENERIC5_CONT, 0,
+		HDMI_GENERIC5_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, 0,
+		HDMI_GENERIC4_LINE, 0,
+		HDMI_GENERIC5_LINE, 0);
+
+	/* stop generic packets 6,7 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC6_CONT, 0,
+		HDMI_GENERIC6_SEND, 0,
+		HDMI_GENERIC7_CONT, 0,
+		HDMI_GENERIC7_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, 0,
+		HDMI_GENERIC6_LINE, 0,
+		HDMI_GENERIC7_LINE, 0);
+
+	/* stop generic packets 8,9 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC8_CONT, 0,
+		HDMI_GENERIC8_SEND, 0,
+		HDMI_GENERIC9_CONT, 0,
+		HDMI_GENERIC9_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, 0,
+		HDMI_GENERIC8_LINE, 0,
+		HDMI_GENERIC9_LINE, 0);
+
+	/* stop generic packets 10,11 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC10_CONT, 0,
+		HDMI_GENERIC10_SEND, 0,
+		HDMI_GENERIC11_CONT, 0,
+		HDMI_GENERIC11_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, 0,
+		HDMI_GENERIC10_LINE, 0,
+		HDMI_GENERIC11_LINE, 0);
+
+	/* stop generic packets 12,13 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC12_CONT, 0,
+		HDMI_GENERIC12_SEND, 0,
+		HDMI_GENERIC13_CONT, 0,
+		HDMI_GENERIC13_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, 0,
+		HDMI_GENERIC12_LINE, 0,
+		HDMI_GENERIC13_LINE, 0);
+
+	/* stop generic packets 14 on HDMI */
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC14_CONT, 0,
+		HDMI_GENERIC14_SEND, 0);
+	REG_SET(HDMI_TB_ENC_GENERIC_PACKET14_LINE, 0,
+		HDMI_GENERIC14_LINE, 0);
+
+}
+
+//Covered both, rounding up or rounding down from FRL Link Rate /18.
+static const struct frl_audio_clock_info frl_audio_clock_info_table[10] = {
+	{166666, 4224, 171875, 5292, 156250, 5760, 156250},
+	{166667, 4224, 171875, 5292, 156250, 5760, 156250},
+	{333333, 4032, 328125, 5292, 312500, 6048, 328125},
+	{333334, 4032, 328125, 5292, 312500, 6048, 328125},
+	{444444, 4032, 437500, 3969, 312500, 6048, 437500},
+	{444445, 4032, 437500, 3969, 312500, 6048, 437500},
+	{555555, 3456, 468750, 3969, 390625, 5184, 468750},
+	{555556, 3456, 468750, 3969, 390625, 5184, 468750},
+	{666666, 3072, 500000, 3969, 468750, 4752, 515625},
+	{666667, 3072, 500000, 3969, 468750, 4752, 515625}
+};
+
+static void get_audio_clock_info(
+	enum dc_color_depth color_depth,
+	uint32_t frl_character_clock_kHz,
+	struct frl_audio_clock_info *audio_clock_info)
+{
+	(void)color_depth;
+	const struct frl_audio_clock_info *clock_info;
+	uint32_t index;
+	uint32_t audio_array_size;
+
+	clock_info = frl_audio_clock_info_table;
+	audio_array_size = ARRAY_SIZE(
+			frl_audio_clock_info_table);
+
+	if (clock_info != NULL) {
+		/* search for exact frl character clock in table */
+		for (index = 0; index < audio_array_size; index++) {
+			if (clock_info[index].frl_character_clock_kHz >
+				frl_character_clock_kHz)
+				break;  /* not match */
+			else if (clock_info[index].frl_character_clock_kHz ==
+					frl_character_clock_kHz) {
+				/* match found */
+				*audio_clock_info = clock_info[index];
+				return;
+			}
+		}
+	}
+	/*Only 3, 6, 8, 10 and 12 Gbps are used for FRL Link rates with character
+	 *clocks of 166.667, 333.333, 444.444, 555.555 and 666.667 MHz are used
+	 *so entry should be found in above table if no bugs */
+	BREAK_TO_DEBUGGER();
+}
+
+void hpo_enc3_setup_hdmi_audio(
+	struct hpo_frl_stream_encoder *enc,
+	const struct audio_crtc_info *crtc_info)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	struct frl_audio_clock_info audio_clock_info = {0};
+
+	DC_LOG_DEBUG("Entering [%s]\n", __func__);
+
+	/* TODO:  HDMI_AUDIO_DELAY_EN bit only in DIG -- not in HPO? */
+	/* HDMI_AUDIO_PACKET_CONTROL */
+	//REG_UPDATE(HDMI_AUDIO_PACKET_CONTROL,
+	//		HDMI_AUDIO_DELAY_EN, 1);
+
+	/* Setup audio in AFMT - program AFMT block associated with HPO */
+	ASSERT (enc->afmt);
+	enc->afmt->funcs->setup_hdmi_audio(enc->afmt);
+
+	/* TODO: Same programming, but using HDMI_TB_ENC register */
+	/* HDMI_ACR_PACKET_CONTROL */
+	REG_UPDATE_3(HDMI_TB_ENC_ACR_PACKET_CONTROL,
+			HDMI_ACR_AUTO_SEND, 1,
+			HDMI_ACR_SOURCE, 0,
+			HDMI_ACR_AUDIO_PRIORITY, 0);
+
+	/* N/CTS computed relative to FRL rate instead of video rate (TMDS character clock). */
+	/* Program audio clock sample/regeneration parameters */
+	get_audio_clock_info(crtc_info->color_depth,
+			     crtc_info->frl_character_clock_kHz,
+			     &audio_clock_info);
+	DC_LOG_HW_AUDIO(
+			"\n%s:Input::requested_pixel_clock_100Hz = %d"	\
+			"calculated_pixel_clock_100Hz = %d \n", __func__,	\
+			crtc_info->requested_pixel_clock_100Hz,		\
+			crtc_info->calculated_pixel_clock_100Hz);
+
+	/* Same register definition, but using HDMI_TB_ENC register */
+	/* HDMI_ACR_32_0__HDMI_ACR_CTS_32_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_32_0, HDMI_ACR_CTS_32, audio_clock_info.cts_32khz);
+
+	/* HDMI_ACR_32_1__HDMI_ACR_N_32_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_32_1, HDMI_ACR_N_32, audio_clock_info.n_32khz);
+
+	/* HDMI_ACR_44_0__HDMI_ACR_CTS_44_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_44_0, HDMI_ACR_CTS_44, audio_clock_info.cts_44khz);
+
+	/* HDMI_ACR_44_1__HDMI_ACR_N_44_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_44_1, HDMI_ACR_N_44, audio_clock_info.n_44khz);
+
+	/* HDMI_ACR_48_0__HDMI_ACR_CTS_48_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_48_0, HDMI_ACR_CTS_48, audio_clock_info.cts_48khz);
+
+	/* HDMI_ACR_48_1__HDMI_ACR_N_48_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_48_1, HDMI_ACR_N_48, audio_clock_info.n_48khz);
+
+
+	/* TODO: HDMI_TB_ENC_ACR_PACKET_CONTROL::ACR_N_MULTIPLE
+	 *       Same register definition, but using HDMI_TB_ENC register*/
+
+	/* Video driver cannot know in advance which sample rate will
+	 * be used by HD Audio driver
+	 * HDMI_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE field is
+	 * programmed below in interrupt callback
+	 */
+	DC_LOG_DEBUG("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc3_hdmi_audio_setup(
+	struct hpo_frl_stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info)
+{
+	hpo_enc3_setup_hdmi_audio(enc, audio_crtc_info);
+	ASSERT (enc->afmt);
+	enc->afmt->funcs->se_audio_setup(enc->afmt, az_inst, info);
+}
+
+void hpo_enc3_hdmi_audio_disable(
+	struct hpo_frl_stream_encoder *enc)
+{
+	ASSERT(enc->afmt);
+	if (enc->afmt->funcs->afmt_powerdown)
+		enc->afmt->funcs->afmt_powerdown(enc->afmt);
+}
+
+void hpo_enc3_audio_mute_control(
+	struct hpo_frl_stream_encoder *enc,
+	bool mute)
+{
+	ASSERT (enc->afmt);
+	enc->afmt->funcs->audio_mute_control(enc->afmt, mute);
+}
+
+void enc3_stream_encoder_set_avmute(
+	struct hpo_frl_stream_encoder *enc,
+	bool enable)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	unsigned int value = enable ? 1 : 0;
+
+	REG_UPDATE(HDMI_TB_ENC_GC_CONTROL, HDMI_GC_AVMUTE, value);
+}
+
+static enum frl_cap_chk_result frl_cap_chk_uncompressed(
+		struct hpo_frl_stream_encoder *enc,
+		struct frl_cap_chk_params *params,
+		struct frl_cap_chk_intermediates *inter)
+{
+	int res;
+	DC_FP_START();
+	res = frl_fpu_cap_chk_uncompressed(enc, params, inter);
+	DC_FP_END();
+	return res;
+}
+
+static enum frl_cap_chk_result frl_cap_chk_compressed(
+		struct hpo_frl_stream_encoder *enc,
+		struct frl_cap_chk_params *params,
+		struct frl_cap_chk_intermediates *inter)
+{
+	int res;
+	DC_FP_START();
+	res = frl_fpu_cap_chk_compressed(enc, params, inter);
+	DC_FP_END();
+	return res;
+}
+
+static bool hpo_enc3_frl_cap_chk(
+		struct hpo_frl_stream_encoder *enc,
+		struct frl_cap_chk_params *params)
+{
+	struct frl_cap_chk_intermediates   inter;
+	enum frl_cap_chk_result res;
+
+	if (params->compressed)
+		res = frl_cap_chk_compressed(enc, params, &inter);
+	else
+		res = frl_cap_chk_uncompressed(enc, params, &inter);
+
+	return (res == FRL_CAP_CHK_OK);
+}
+
+bool hpo_enc3_validate_hdmi_frl_output(
+	struct hpo_frl_stream_encoder *enc,
+	const struct dc_crtc_timing *timing,
+	const struct audio_check *audio,
+	struct dc_hdmi_frl_link_settings *frl_link_settings,
+	unsigned int dsc_max_rate)
+{
+	struct frl_cap_chk_params frl_params = {0};
+	bool frl_check_res = false;
+
+	/* Set inputs for FRL check */
+	frl_params.lanes = frl_link_settings->frl_num_lanes;
+	DC_FP_START();
+	hpo_fpu_enc3_validate_hdmi_frl_output_link(enc,
+						   frl_link_settings,
+						   &frl_params,
+						   timing,
+						   dsc_max_rate);
+	DC_FP_END();
+
+	if (timing->display_color_depth == COLOR_DEPTH_888)
+		frl_params.bpc = 8;
+	else if (timing->display_color_depth == COLOR_DEPTH_101010)
+		frl_params.bpc = 10;
+	else
+		frl_params.bpc = 12;
+
+	switch (timing->hdmi_vic) {
+	case 1:
+		frl_params.vic = 95;
+		break;
+	case 2:
+		frl_params.vic = 94;
+		break;
+	case 3:
+		frl_params.vic = 93;
+		break;
+	case 4:
+		frl_params.vic = 98;
+		break;
+	default:
+		break;
+	}
+	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
+	else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
+		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
+	else
+		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
+	/* Audio parameters */
+	/* TODO: set Audio parameters */
+
+	if (audio->audio_packet_type == 2) {
+		if (audio->max_channel_count <= 2
+			  || (timing->v_addressable + timing->v_border_top + timing->v_border_bottom) <= 576)
+			frl_params.layout = 0;
+		else
+			frl_params.layout = 1;
+
+	}
+
+	/* Check HDMI FRL Capacity and compute borrow parameters */
+	frl_check_res = hpo_enc3_frl_cap_chk(enc, &frl_params);
+	/* Save borrow parameters and average tribyte rate (for capture sideband) */
+	if (frl_check_res) {
+		frl_link_settings->borrow_params.audio_packets_line =
+				frl_params.borrow_params.audio_packets_line;
+		frl_link_settings->borrow_params.hc_active_target =
+				frl_params.borrow_params.hc_active_target;
+		frl_link_settings->borrow_params.hc_blank_target =
+				frl_params.borrow_params.hc_blank_target;
+		frl_link_settings->borrow_params.borrow_mode =
+				(unsigned int) frl_params.borrow_params.borrow_mode;
+		frl_link_settings->average_tribyte_rate = frl_params.average_tribyte_rate;
+	}
+
+	return frl_check_res;
+}
+
+void hpo_enc3_read_state(
+	struct hpo_frl_stream_encoder *enc,
+	struct hpo_frl_stream_encoder_state *state)
+{
+	int pixel_encoding;
+	int color_depth;
+	int odm_combine;
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	ASSERT(state);
+
+	REG_GET(HDMI_TB_ENC_CONTROL,
+			HDMI_TB_ENC_EN, &state->stream_enc_enabled);
+
+	REG_GET(HDMI_STREAM_ENC_INPUT_MUX_CONTROL,
+			HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL, &state->otg_inst);
+
+	REG_GET_2(HDMI_TB_ENC_PIXEL_FORMAT,
+			HDMI_PIXEL_ENCODING, &pixel_encoding,
+			HDMI_DEEP_COLOR_DEPTH, &color_depth);
+
+	REG_GET(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			FIFO_ODM_COMBINE_MODE, &odm_combine);
+
+	REG_GET_2(HDMI_TB_ENC_H_ACTIVE_BLANK,
+			HDMI_H_ACTIVE, &state->h_active,
+			HDMI_H_BLANK, &state->h_blank);
+
+	REG_GET(HDMI_TB_ENC_MODE,
+			HDMI_BORROW_MODE, &state->borrow_mode);
+
+	if (pixel_encoding == 0)
+		state->pixel_format = PIXEL_ENCODING_YCBCR444;
+	else if (pixel_encoding == 1)
+		state->pixel_format = PIXEL_ENCODING_YCBCR422;
+	else
+		state->pixel_format = PIXEL_ENCODING_YCBCR420;
+
+	if (color_depth == 0)
+		state->color_depth = 8;
+	else if (color_depth == 1)
+		state->color_depth = 10;
+	else
+		state->color_depth = 12;
+
+	state->num_odm_segments = odm_combine + 1;
+}
+
+/* Set Dynamic Metadata-configuration.
+ *   enable_dme:         TRUE: enables Dynamic Metadata Enfine, FALSE: disables DME
+ *   hubp_requestor_id:  HUBP physical instance that is the source of dynamic metadata
+ *                       only needs to be set when enable_dme is TRUE
+ *   dmdata_mode:        dynamic metadata packet type: DP, HDMI, or Dolby Vision
+ *
+ *   Ensure the OTG master update lock is set when changing DME configuration.
+ */
+void hpo_enc3_set_dynamic_metadata(struct hpo_frl_stream_encoder *enc,
+	bool enable_dme,
+	uint32_t hubp_requestor_id,
+	enum dynamic_metadata_mode dmdata_mode)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	if (enable_dme) {
+		REG_UPDATE_2(DME_CONTROL,
+			METADATA_HUBP_REQUESTOR_ID, hubp_requestor_id,
+			METADATA_STREAM_TYPE, (dmdata_mode == dmdata_dolby_vision) ? 1 : 0);
+
+		REG_UPDATE_3(HDMI_TB_ENC_METADATA_PACKET_CONTROL,
+			HDMI_METADATA_PACKET_ENABLE, 1,
+			HDMI_METADATA_PACKET_LINE_REFERENCE, 0,
+			HDMI_METADATA_PACKET_LINE, 2);
+
+		REG_UPDATE(DME_CONTROL,
+			METADATA_ENGINE_EN, 1);
+	} else {
+		REG_UPDATE(DME_CONTROL,
+			METADATA_ENGINE_EN, 0);
+
+		REG_UPDATE(HDMI_TB_ENC_METADATA_PACKET_CONTROL,
+			HDMI_METADATA_PACKET_ENABLE, 0);
+	}
+}
+
+static const struct hpo_frl_stream_encoder_funcs dcn30_str_enc_funcs = {
+	.hdmi_frl_enable		= hpo_enc3_enable,
+	.hdmi_frl_unblank		= hpo_enc3_unblank,
+	.hdmi_frl_blank			= hpo_enc3_blank,
+	.hdmi_frl_set_stream_attribute	= hpo_enc3_set_hdmi_stream_attribute,
+	.update_hdmi_info_packets	= hpo_enc3_update_hdmi_info_packets,
+	.stop_hdmi_info_packets		= hpo_enc3_stop_hdmi_info_packets,
+	.audio_mute_control		= hpo_enc3_audio_mute_control,
+	.hdmi_audio_setup		= hpo_enc3_hdmi_audio_setup,
+	.hdmi_audio_disable		= hpo_enc3_hdmi_audio_disable,
+	.set_avmute			= enc3_stream_encoder_set_avmute,
+	.validate_hdmi_frl_output	= hpo_enc3_validate_hdmi_frl_output,
+	.read_state			= hpo_enc3_read_state,
+	.set_dynamic_metadata           = hpo_enc3_set_dynamic_metadata,
+	.hdmi_frl_fifo_odm_enabled = hpo_enc3_fifo_odm_enabled,
+};
+
+void dcn30_hpo_frl_stream_encoder_construct(
+	struct dcn30_hpo_frl_stream_encoder *enc3,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct afmt *afmt,
+	const struct dcn30_hpo_frl_stream_enc_registers *regs,
+	const struct dcn30_hpo_frl_stream_encoder_shift *hpo_se_shift,
+	const struct dcn30_hpo_frl_stream_encoder_mask *hpo_se_mask)
+{
+	enc3->base.funcs = &dcn30_str_enc_funcs;
+	enc3->base.ctx = ctx;
+	enc3->base.id = eng_id;
+	enc3->base.bp = bp;
+	enc3->base.vpg = vpg;
+	enc3->base.afmt = afmt;
+	enc3->regs = regs;
+	enc3->hpo_se_shift = hpo_se_shift;
+	enc3->hpo_se_mask = hpo_se_mask;
+	enc3->base.stream_enc_inst = vpg->inst;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
new file mode 100644
index 000000000000..c00be852aa17
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
@@ -0,0 +1,436 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_HPO_FRL_STREAM_ENCODER_DCN30_H__
+#define __DC_HPO_FRL_STREAM_ENCODER_DCN30_H__
+
+#include "dcn30/dcn30_vpg.h"
+#include "dcn30/dcn30_afmt.h"
+#include "stream_encoder.h"
+#include "dml/dml1_frl_cap_chk.h"
+
+#define DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(hpo_frl_stream_encoder)\
+	container_of(hpo_frl_stream_encoder, struct dcn30_hpo_frl_stream_encoder, base)
+
+#define SE_SF(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+#define DCN3_0_HDMI_STREAM_ENC_REG_LIST \
+	SR(HDMI_STREAM_ENC_CLOCK_CONTROL), \
+	SR(HDMI_STREAM_ENC_INPUT_MUX_CONTROL), \
+	SR(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0), \
+	SR(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2)
+
+#define DCN3_0_HDMI_TB_ENC_REG_LIST \
+	SR(HDMI_TB_ENC_CONTROL), \
+	SR(HDMI_TB_ENC_H_ACTIVE_BLANK), \
+	SR(HDMI_TB_ENC_HC_ACTIVE_BLANK), \
+	SR(HDMI_TB_ENC_MODE), \
+	SR(HDMI_TB_ENC_PACKET_CONTROL), \
+	SR(HDMI_TB_ENC_DB_CONTROL), \
+	SR(HDMI_TB_ENC_PIXEL_FORMAT), \
+	SR(HDMI_TB_ENC_VBI_PACKET_CONTROL1), \
+	SR(HDMI_TB_ENC_GC_CONTROL), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE), \
+	SR(HDMI_TB_ENC_GENERIC_PACKET14_LINE), \
+	SR(HDMI_TB_ENC_ACR_PACKET_CONTROL), \
+	SR(HDMI_TB_ENC_ACR_32_0), \
+	SR(HDMI_TB_ENC_ACR_32_1), \
+	SR(HDMI_TB_ENC_ACR_44_0), \
+	SR(HDMI_TB_ENC_ACR_44_1), \
+	SR(HDMI_TB_ENC_ACR_48_0), \
+	SR(HDMI_TB_ENC_ACR_48_1), \
+	SR(HDMI_TB_ENC_CRC_CNTL),\
+	SR(HDMI_TB_ENC_METADATA_PACKET_CONTROL)
+
+#define DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id) \
+	DCN3_0_HDMI_STREAM_ENC_REG_LIST, \
+	DCN3_0_HDMI_TB_ENC_REG_LIST
+
+#define DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, offset) \
+	[id - offset]SRI(DME_CONTROL, DME, id)
+
+
+struct dcn30_hpo_frl_stream_enc_registers {
+	uint32_t HDMI_STREAM_ENC_CLOCK_CONTROL;
+	uint32_t HDMI_STREAM_ENC_INPUT_MUX_CONTROL;
+	uint32_t HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0;
+	uint32_t HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2;
+	uint32_t HDMI_STREAM_ENC_AUDIO_CONTROL;
+	uint32_t HDMI_TB_ENC_CONTROL;
+	uint32_t HDMI_TB_ENC_MODE;
+	uint32_t HDMI_TB_ENC_H_ACTIVE_BLANK;
+	uint32_t HDMI_TB_ENC_HC_ACTIVE_BLANK;
+	uint32_t HDMI_TB_ENC_PACKET_CONTROL;
+	uint32_t HDMI_TB_ENC_DB_CONTROL;
+	uint32_t HDMI_TB_ENC_PIXEL_FORMAT;
+	uint32_t HDMI_TB_ENC_VBI_PACKET_CONTROL1;
+	uint32_t HDMI_TB_ENC_GC_CONTROL;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET_CONTROL0;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET_CONTROL1;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET0_1_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET2_3_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET4_5_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET6_7_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET8_9_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET10_11_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET12_13_LINE;
+	uint32_t HDMI_TB_ENC_GENERIC_PACKET14_LINE;
+	uint32_t HDMI_TB_ENC_ACR_PACKET_CONTROL;
+	uint32_t HDMI_TB_ENC_ACR_32_0;
+	uint32_t HDMI_TB_ENC_ACR_32_1;
+	uint32_t HDMI_TB_ENC_ACR_44_0;
+	uint32_t HDMI_TB_ENC_ACR_44_1;
+	uint32_t HDMI_TB_ENC_ACR_48_0;
+	uint32_t HDMI_TB_ENC_ACR_48_1;
+	uint32_t HDMI_TB_ENC_CRC_CNTL;
+	uint32_t DME_CONTROL;
+	uint32_t HDMI_TB_ENC_METADATA_PACKET_CONTROL;
+	uint32_t HDMI_TB_ENC_MEM_CTRL;
+	uint32_t HDMI_FRL_ENC_MEM_CTRL;
+};
+
+#define DCN3_0_HDMI_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(HDMI_STREAM_ENC_INPUT_MUX_CONTROL, HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_ENABLE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_PIXEL_ENCODING, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_CONTROL, HDMI_STREAM_ENC_CLOCK_EN, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_ODM_COMBINE_MODE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_DSC_MODE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2, FIFO_DB_DISABLE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2, FIFO_DB_DISABLE, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_HUBP_REQUESTOR_ID, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_ENGINE_EN, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_STREAM_TYPE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_MEM_CTRL, BORROWBUFFER_MEM_PWR_DIS, mask_sh),\
+	SE_SF(HDMI_TB_ENC_MEM_CTRL, BORROWBUFFER_MEM_PWR_FORCE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_MEM_CTRL, BORROWBUFFER_MEM_PWR_STATE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_MEM_CTRL, BORROWBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_ENABLE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE_REFERENCE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_MISSED, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE, mask_sh)
+
+#define DCN3_0_HDMI_TB_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(HDMI_TB_ENC_CONTROL, HDMI_TB_ENC_EN, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CONTROL, HDMI_RESET, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CONTROL, HDMI_RESET_DONE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_MODE, HDMI_BORROW_MODE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_H_ACTIVE_BLANK, HDMI_H_ACTIVE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_H_ACTIVE_BLANK, HDMI_H_BLANK, mask_sh),\
+	SE_SF(HDMI_TB_ENC_HC_ACTIVE_BLANK, HDMI_HC_ACTIVE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_HC_ACTIVE_BLANK, HDMI_HC_BLANK, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PACKET_CONTROL, HDMI_MAX_PACKETS_PER_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_DB_CONTROL, HDMI_DB_DISABLE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_PIXEL_ENCODING, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_DEEP_COLOR_DEPTH, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_DEEP_COLOR_ENABLE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_DSC_MODE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_GC_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_GC_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_ACP_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GC_CONTROL, HDMI_GC_AVMUTE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC1_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC2_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC3_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC4_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC5_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC6_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC7_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC8_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC9_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC10_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC11_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC12_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC13_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC14_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC1_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC2_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC3_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC4_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC5_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC6_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC7_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC8_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC9_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC10_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC11_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC12_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC13_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC14_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, HDMI_GENERIC0_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, HDMI_GENERIC1_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, HDMI_GENERIC2_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, HDMI_GENERIC3_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, HDMI_GENERIC4_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, HDMI_GENERIC5_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, HDMI_GENERIC6_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, HDMI_GENERIC7_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, HDMI_GENERIC8_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, HDMI_GENERIC9_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, HDMI_GENERIC10_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, HDMI_GENERIC11_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, HDMI_GENERIC12_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, HDMI_GENERIC13_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET14_LINE, HDMI_GENERIC14_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_PACKET_CONTROL, HDMI_ACR_SOURCE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_PACKET_CONTROL, HDMI_ACR_AUDIO_PRIORITY, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_32_0, HDMI_ACR_CTS_32, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_32_1, HDMI_ACR_N_32, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_44_0, HDMI_ACR_CTS_44, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_44_1, HDMI_ACR_N_44, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_48_0, HDMI_ACR_CTS_48, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_48_1, HDMI_ACR_N_48, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CRC_CNTL, HDMI_CRC_EN, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CRC_CNTL, HDMI_CRC_CONT_EN, mask_sh)
+
+#define DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	DCN3_0_HDMI_STREAM_ENC_MASK_SH_LIST(mask_sh),\
+	DCN3_0_HDMI_TB_ENC_MASK_SH_LIST(mask_sh)
+
+
+
+
+#define DCN3_HDMI_TB_ENC_REG_FIELD_LIST(type) \
+	type HDMI_TB_ENC_EN;\
+	type HDMI_RESET;\
+	type HDMI_RESET_DONE;\
+	type HDMI_STREAM_ENC_CLOCK_EN;\
+	type HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL;\
+	type HDMI_MAX_PACKETS_PER_LINE;\
+	type FIFO_ENABLE;\
+	type FIFO_RESET;\
+	type FIFO_RESET_DONE;\
+	type FIFO_PIXEL_ENCODING;\
+	type FIFO_ODM_COMBINE_MODE;\
+	type FIFO_DSC_MODE;\
+	type FIFO_DB_DISABLE;\
+	type HDMI_BORROW_MODE;\
+	type HDMI_H_ACTIVE;\
+	type HDMI_H_BLANK;\
+	type HDMI_HC_ACTIVE;\
+	type HDMI_HC_BLANK;\
+	type HDMI_DB_DISABLE;\
+	type HDMI_PIXEL_ENCODING;\
+	type HDMI_DEEP_COLOR_DEPTH;\
+	type HDMI_DEEP_COLOR_ENABLE;\
+	type HDMI_ODM_COMBINE_MODE;\
+	type HDMI_DSC_MODE;\
+	type HDMI_GC_CONT;\
+	type HDMI_GC_SEND;\
+	type HDMI_ACP_SEND;\
+	type HDMI_AUDIO_INFO_SEND;\
+	type HDMI_AUDIO_INFO_LINE;\
+	type HDMI_GC_AVMUTE;\
+	type HDMI_GENERIC0_CONT;\
+	type HDMI_GENERIC0_SEND;\
+	type HDMI_GENERIC0_LINE;\
+	type HDMI_GENERIC1_CONT;\
+	type HDMI_GENERIC1_SEND;\
+	type HDMI_GENERIC1_LINE;\
+	type HDMI_GENERIC2_CONT;\
+	type HDMI_GENERIC2_SEND;\
+	type HDMI_GENERIC2_LINE;\
+	type HDMI_GENERIC3_CONT;\
+	type HDMI_GENERIC3_SEND;\
+	type HDMI_GENERIC3_LINE;\
+	type HDMI_GENERIC4_CONT;\
+	type HDMI_GENERIC4_SEND;\
+	type HDMI_GENERIC4_LINE;\
+	type HDMI_GENERIC5_CONT;\
+	type HDMI_GENERIC5_SEND;\
+	type HDMI_GENERIC5_LINE;\
+	type HDMI_GENERIC6_CONT;\
+	type HDMI_GENERIC6_SEND;\
+	type HDMI_GENERIC6_LINE;\
+	type HDMI_GENERIC7_CONT;\
+	type HDMI_GENERIC7_SEND;\
+	type HDMI_GENERIC7_LINE;\
+	type HDMI_GENERIC8_CONT;\
+	type HDMI_GENERIC8_SEND;\
+	type HDMI_GENERIC8_LINE;\
+	type HDMI_GENERIC9_CONT;\
+	type HDMI_GENERIC9_SEND;\
+	type HDMI_GENERIC9_LINE;\
+	type HDMI_GENERIC10_CONT;\
+	type HDMI_GENERIC10_SEND;\
+	type HDMI_GENERIC10_LINE;\
+	type HDMI_GENERIC11_CONT;\
+	type HDMI_GENERIC11_SEND;\
+	type HDMI_GENERIC11_LINE;\
+	type HDMI_GENERIC12_CONT;\
+	type HDMI_GENERIC12_SEND;\
+	type HDMI_GENERIC12_LINE;\
+	type HDMI_GENERIC13_CONT;\
+	type HDMI_GENERIC13_SEND;\
+	type HDMI_GENERIC13_LINE;\
+	type HDMI_GENERIC14_CONT;\
+	type HDMI_GENERIC14_SEND;\
+	type HDMI_GENERIC14_LINE;\
+	type HDMI_ACR_AUTO_SEND;\
+	type HDMI_ACR_SOURCE;\
+	type HDMI_ACR_AUDIO_PRIORITY;\
+	type HDMI_ACR_CTS_32;\
+	type HDMI_ACR_N_32;\
+	type HDMI_ACR_CTS_44;\
+	type HDMI_ACR_N_44;\
+	type HDMI_ACR_CTS_48;\
+	type HDMI_ACR_N_48;\
+	type HDMI_CRC_EN;\
+	type HDMI_CRC_CONT_EN;\
+	type METADATA_HUBP_REQUESTOR_ID;\
+	type METADATA_ENGINE_EN;\
+	type METADATA_STREAM_TYPE;\
+	type HDMI_METADATA_PACKET_ENABLE;\
+	type HDMI_METADATA_PACKET_LINE_REFERENCE;\
+	type HDMI_METADATA_PACKET_MISSED;\
+	type HDMI_METADATA_PACKET_LINE;\
+	type BORROWBUFFER_MEM_PWR_DIS;\
+	type BORROWBUFFER_MEM_PWR_FORCE;\
+	type BORROWBUFFER_MEM_PWR_STATE;\
+	type BORROWBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE
+
+
+struct dcn30_hpo_frl_stream_encoder_shift {
+	DCN3_HDMI_TB_ENC_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn30_hpo_frl_stream_encoder_mask {
+	DCN3_HDMI_TB_ENC_REG_FIELD_LIST(uint32_t);
+};
+
+struct dcn30_hpo_frl_stream_encoder {
+	struct hpo_frl_stream_encoder base;
+	const struct dcn30_hpo_frl_stream_enc_registers *regs;
+	const struct dcn30_hpo_frl_stream_encoder_shift *hpo_se_shift;
+	const struct dcn30_hpo_frl_stream_encoder_mask *hpo_se_mask;
+};
+
+void hpo_enc3_enable(
+	struct hpo_frl_stream_encoder *enc,
+	int otg_inst);
+
+void hpo_enc3_unblank(
+	struct hpo_frl_stream_encoder *enc,
+	int otg_inst);
+
+void hpo_enc3_read_state(
+	struct hpo_frl_stream_encoder *enc,
+	struct hpo_frl_stream_encoder_state *state);
+
+bool hpo_enc3_fifo_odm_enabled(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc3_blank(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc3_set_hdmi_stream_attribute(
+	struct hpo_frl_stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	struct frl_borrow_params *borrow_params,
+	int odm_combine_num_segments);
+
+void hpo_enc3_update_hdmi_info_packet(
+	struct dcn30_hpo_frl_stream_encoder *enc3,
+	uint32_t packet_index,
+	const struct dc_info_packet *info_packet);
+
+void hpo_enc3_update_hdmi_info_packets(
+	struct hpo_frl_stream_encoder *enc,
+	const struct encoder_info_frame *info_frame);
+
+void hpo_enc3_hdmi_set_dsc_config(
+	struct hpo_frl_stream_encoder *enc,
+	struct dc_crtc_timing *timing,
+	uint8_t *dsc_packed_pps);
+
+void hpo_enc3_stop_hdmi_info_packets(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc3_setup_hdmi_audio(
+	struct hpo_frl_stream_encoder *enc,
+	const struct audio_crtc_info *crtc_info);
+
+void hpo_enc3_hdmi_audio_setup(
+	struct hpo_frl_stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info);
+
+void hpo_enc3_hdmi_audio_disable(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc3_audio_mute_control(
+	struct hpo_frl_stream_encoder *enc,
+	bool mute);
+
+void enc3_stream_encoder_set_avmute(
+	struct hpo_frl_stream_encoder *enc,
+	bool enable);
+
+bool hpo_enc3_validate_hdmi_frl_output(
+	struct hpo_frl_stream_encoder *enc,
+	const struct dc_crtc_timing *timing,
+	const struct audio_check *audio,
+	struct dc_hdmi_frl_link_settings *frl_link_settings,
+	unsigned int dsc_max_rate);
+
+void hpo_enc3_set_dynamic_metadata(
+	struct hpo_frl_stream_encoder *enc,
+	bool enable_dme,
+	uint32_t hubp_requestor_id,
+	enum dynamic_metadata_mode dmdata_mode);
+
+void dcn30_hpo_frl_stream_encoder_construct(
+	struct dcn30_hpo_frl_stream_encoder *enc3,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct afmt *afmt,
+	const struct dcn30_hpo_frl_stream_enc_registers *regs,
+	const struct dcn30_hpo_frl_stream_encoder_shift *hpo_se_shift,
+	const struct dcn30_hpo_frl_stream_encoder_mask *hpo_se_mask);
+
+void convert_dc_info_packet_to_128(
+	const struct dc_info_packet *info_packet,
+	struct dc_info_packet_128 *info_packet_128);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
new file mode 100644
index 000000000000..27f7ffd89629
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
@@ -0,0 +1,906 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+
+#include "dc_bios_types.h"
+#include "core_types.h"
+#include "dcn401_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "reg_helper.h"
+#include "hw_shared.h"
+#include "dcn_calc_math.h"
+#include "dml/dcn30/dcn30_fpu.h"
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+		enc401->base.ctx->logger
+
+#define DTRACE(str, ...) {DC_LOG_HDMI_FRL(str, ##__VA_ARGS__); }
+
+#define DEBUG_FRL_CAP_CHK 1
+
+#define REG(reg)\
+	(enc401->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	enc401->hpo_se_shift->field_name, enc401->hpo_se_mask->field_name
+
+
+#define CTX \
+	enc401->base.ctx
+
+
+#define VBI_LINE_0 0
+
+void hpo_enc401_enable(
+	struct hpo_frl_stream_encoder *enc,
+	int otg_inst)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	DC_LOG_DEBUG("Entering [%s]\n", __func__);
+
+	/* Enable DISPCLK, SOCCLK, and HDMISTREAMCLK */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_CONTROL, HDMI_STREAM_ENC_CLOCK_EN, 1);
+
+	/* Reset */
+	REG_UPDATE_2(HDMI_TB_ENC_CONTROL,
+			HDMI_RESET, 1,
+			HDMI_TB_ENC_EN, 0);
+	REG_WAIT(HDMI_TB_ENC_CONTROL, HDMI_RESET_DONE,
+			1, 10, 100);
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+			HDMI_RESET, 0);
+
+	/* FOR DEBUG:  enable CRC */
+	REG_UPDATE_2(HDMI_TB_ENC_CRC_CNTL,
+			HDMI_CRC_EN, 1,
+			HDMI_CRC_CONT_EN, 1);
+
+//	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2, FIFO_DB_DISABLE, 1);
+	/* TODO: confirm if need to set HDMI_DB_DISABLE -- HW team only setting FIFO_DB_DISABLE */
+	REG_UPDATE(HDMI_TB_ENC_DB_CONTROL, HDMI_DB_DISABLE, 1);
+
+	/* Set the input mux to select OTG source */
+	REG_UPDATE(HDMI_STREAM_ENC_INPUT_MUX_CONTROL, HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL, otg_inst);
+
+	DC_LOG_DEBUG("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc401_unblank(struct hpo_frl_stream_encoder *enc, int otg_inst)
+{
+	(void)otg_inst;
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	/*make sure FIFO_VIDEO_STREAM_ACTIVE =1*/
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 0);
+
+	/* Reset */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_RESET, 1);
+	REG_WAIT(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE,
+		 1, 10, 1000);
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_RESET, 0);
+	REG_WAIT(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE,
+		 0, 10, 1000);
+
+	/* Enable HDMI Tribyte Encoder */
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+		   HDMI_TB_ENC_EN, 1);
+
+	/* Enable Clock Ramp Adjuster FIFO */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 1);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc401_blank(struct hpo_frl_stream_encoder *enc)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	/* Disable Clock Ramp Adjuster FIFO */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 0);
+
+	/* Disable HDMI Tribyte Encoder */
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+		   HDMI_TB_ENC_EN, 0);
+
+	/* Disable DISPCLK, SOCCLK, and HDMISTREAMCLK */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_CONTROL,
+		   HDMI_STREAM_ENC_CLOCK_EN, 0);
+}
+
+void hpo_enc401_read_state(
+	struct hpo_frl_stream_encoder *enc,
+	struct hpo_frl_stream_encoder_state *state)
+{
+	int pixel_encoding;
+	int color_depth;
+//	int odm_combine;
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	ASSERT(state);
+
+	REG_GET(HDMI_TB_ENC_CONTROL,
+			HDMI_TB_ENC_EN, &state->stream_enc_enabled);
+
+	REG_GET(HDMI_STREAM_ENC_INPUT_MUX_CONTROL,
+			HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL, &state->otg_inst);
+
+	REG_GET_2(HDMI_TB_ENC_PIXEL_FORMAT,
+			HDMI_PIXEL_ENCODING, &pixel_encoding,
+			HDMI_DEEP_COLOR_DEPTH, &color_depth);
+
+//	REG_GET(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+	//		FIFO_ODM_COMBINE_MODE, &odm_combine);
+
+	REG_GET_2(HDMI_TB_ENC_H_ACTIVE_BLANK,
+			HDMI_H_ACTIVE, &state->h_active,
+			HDMI_H_BLANK, &state->h_blank);
+
+	REG_GET(HDMI_TB_ENC_MODE,
+			HDMI_BORROW_MODE, &state->borrow_mode);
+
+	if (pixel_encoding == 0)
+		state->pixel_format = PIXEL_ENCODING_YCBCR444;
+	else if (pixel_encoding == 1)
+		state->pixel_format = PIXEL_ENCODING_YCBCR422;
+	else
+		state->pixel_format = PIXEL_ENCODING_YCBCR420;
+
+	if (color_depth == 0)
+		state->color_depth = 8;
+	else if (color_depth == 1)
+		state->color_depth = 10;
+	else
+		state->color_depth = 12;
+
+//	state->num_odm_segments = odm_combine + 1;
+}
+
+/* setup stream encoder in hdmi mode */
+/* Precondition: link is trained */
+void hpo_enc401_set_hdmi_stream_attribute(
+	struct hpo_frl_stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	struct frl_borrow_params *borrow_params,
+	int odm_combine_num_segments)
+{
+	(void)odm_combine_num_segments;
+	uint32_t h_active;
+	uint32_t h_blank;
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	DC_LOG_DEBUG("Entering [%s]\n", __func__);
+
+	/* Configure pixel encoding */
+	switch (crtc_timing->pixel_encoding) {
+	case PIXEL_ENCODING_YCBCR422:
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+				HDMI_PIXEL_ENCODING, 1);
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+				FIFO_UNCOMPRESSED_PIXEL_FORMAT, 0);
+		break;
+	case PIXEL_ENCODING_YCBCR420:
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+				HDMI_PIXEL_ENCODING, 2);
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+				FIFO_UNCOMPRESSED_PIXEL_FORMAT, 1);
+		break;
+	default:
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+				HDMI_PIXEL_ENCODING, 0);
+		REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+				FIFO_UNCOMPRESSED_PIXEL_FORMAT, 0);
+		break;
+	}
+
+	/* Configure color depth */
+	switch (crtc_timing->display_color_depth) {
+	case COLOR_DEPTH_888:
+		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				HDMI_DEEP_COLOR_DEPTH, 0,
+				HDMI_DEEP_COLOR_ENABLE, 0);
+		break;
+	case COLOR_DEPTH_101010:
+		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+					HDMI_DEEP_COLOR_DEPTH, 1,
+					HDMI_DEEP_COLOR_ENABLE, 0);
+		} else {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+					HDMI_DEEP_COLOR_DEPTH, 1,
+					HDMI_DEEP_COLOR_ENABLE, 1);
+		}
+		break;
+	case COLOR_DEPTH_121212:
+		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+					HDMI_DEEP_COLOR_DEPTH, 2,
+					HDMI_DEEP_COLOR_ENABLE, 0);
+		} else {
+			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+					HDMI_DEEP_COLOR_DEPTH, 2,
+					HDMI_DEEP_COLOR_ENABLE, 1);
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* When compression active, CD/PP/Phase field shall be zero in GCP */
+	if (crtc_timing->flags.DSC) {
+		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				HDMI_DEEP_COLOR_DEPTH, 0,
+				HDMI_DEEP_COLOR_ENABLE, 0);
+	}
+
+	/* Configure horizontal active and blank size */
+	h_active = crtc_timing->h_addressable + crtc_timing->h_border_left + crtc_timing->h_border_right;
+	h_blank = crtc_timing->h_total - h_active;
+
+	if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
+			crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		h_active /= 2;
+		h_blank /= 2;
+	}
+
+
+	REG_SET_2(HDMI_TB_ENC_H_ACTIVE_BLANK, 0,
+			HDMI_H_ACTIVE, h_active,
+			HDMI_H_BLANK, h_blank);
+
+	/* Configure borrow parameters */
+	REG_UPDATE(HDMI_TB_ENC_MODE,
+			HDMI_BORROW_MODE, borrow_params->borrow_mode);
+	REG_UPDATE(HDMI_TB_ENC_PACKET_CONTROL,
+			HDMI_MAX_PACKETS_PER_LINE, borrow_params->audio_packets_line);
+	REG_SET_2(HDMI_TB_ENC_HC_ACTIVE_BLANK, 0,
+			HDMI_HC_ACTIVE, borrow_params->hc_active_target,
+			HDMI_HC_BLANK, borrow_params->hc_blank_target);
+
+	/* Enable transmission of General Control packet on every frame */
+	REG_UPDATE_2(HDMI_TB_ENC_VBI_PACKET_CONTROL1,
+		HDMI_GC_CONT, 1,
+		HDMI_GC_SEND, 1);
+
+	/* Disable Audio Content Protection packet transmission */
+	/* TODO: review if this needs to be here */
+	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_ACP_SEND, 0);
+
+
+	/* Enable Audio InfoFrame packet transmission. */
+	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_SEND, 1);
+
+	/* update double-buffered AUDIO_INFO registers immediately */
+	if (enc->afmt && enc->afmt->funcs->audio_info_immediate_update)
+		enc->afmt->funcs->audio_info_immediate_update(enc->afmt);
+
+	/* Select line number on which to send Audio InfoFrame packets */
+	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_LINE,
+				VBI_LINE_0 + 2);
+
+	/* set HDMI GC AVMUTE */
+	REG_UPDATE(HDMI_TB_ENC_GC_CONTROL, HDMI_GC_AVMUTE, 0);
+
+	DC_LOG_DEBUG("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc401_update_hdmi_info_packet(
+	struct dcn401_hpo_frl_stream_encoder *enc401,
+	uint32_t packet_index,
+	const struct dc_info_packet *info_packet)
+{
+	uint32_t cont, send, line;
+
+	if (info_packet->valid) {
+		enc401->base.vpg->funcs->update_generic_info_packet(
+				enc401->base.vpg,
+				packet_index,
+				info_packet,
+				true);
+
+		/* enable transmission of packet(s) -
+		 * packet transmission begins on the next frame
+		 */
+		cont = 1;
+		/* send packet(s) every frame */
+		send = 1;
+		/* select line number to send packets on */
+		/* TODO: check if line 2 is correct */
+		line = 2;
+	} else {
+		cont = 0;
+		send = 0;
+		line = 0;
+	}
+
+	/* TODO: set bit to indicate if packet is Extended Metadata Packet. */
+	/* TODO: In DCN3, there are 0-14 generic packets */
+
+	/* choose which generic packet control to use */
+	switch (packet_index) {
+	case 0:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC0_CONT, cont,
+				HDMI_GENERIC0_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE,
+				HDMI_GENERIC0_LINE, line);
+		break;
+	case 1:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC1_CONT, cont,
+				HDMI_GENERIC1_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE,
+				HDMI_GENERIC1_LINE, line);
+		break;
+	case 2:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC2_CONT, cont,
+				HDMI_GENERIC2_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE,
+				HDMI_GENERIC2_LINE, line);
+		break;
+	case 3:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC3_CONT, cont,
+				HDMI_GENERIC3_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE,
+				HDMI_GENERIC3_LINE, line);
+		break;
+	case 4:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC4_CONT, cont,
+				HDMI_GENERIC4_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE,
+				HDMI_GENERIC4_LINE, line);
+		break;
+	case 5:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC5_CONT, cont,
+				HDMI_GENERIC5_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE,
+				HDMI_GENERIC5_LINE, line);
+		break;
+	case 6:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC6_CONT, cont,
+				HDMI_GENERIC6_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE,
+				HDMI_GENERIC6_LINE, line);
+		break;
+	case 7:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0,
+				HDMI_GENERIC7_CONT, cont,
+				HDMI_GENERIC7_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE,
+				HDMI_GENERIC7_LINE, line);
+		break;
+	case 8:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC8_CONT, cont,
+				HDMI_GENERIC8_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE,
+				HDMI_GENERIC8_LINE, line);
+		break;
+	case 9:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC9_CONT, cont,
+				HDMI_GENERIC9_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE,
+				HDMI_GENERIC9_LINE, line);
+		break;
+	case 10:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC10_CONT, cont,
+				HDMI_GENERIC10_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE,
+				HDMI_GENERIC10_LINE, line);
+		break;
+	case 11:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC11_CONT, cont,
+				HDMI_GENERIC11_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE,
+				HDMI_GENERIC11_LINE, line);
+		break;
+	case 12:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC12_CONT, cont,
+				HDMI_GENERIC12_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE,
+				HDMI_GENERIC12_LINE, line);
+		break;
+	case 13:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC13_CONT, cont,
+				HDMI_GENERIC13_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE,
+				HDMI_GENERIC13_LINE, line);
+		break;
+	case 14:
+		REG_UPDATE_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1,
+				HDMI_GENERIC14_CONT, cont,
+				HDMI_GENERIC14_SEND, send);
+		REG_UPDATE(HDMI_TB_ENC_GENERIC_PACKET14_LINE,
+				HDMI_GENERIC14_LINE, line);
+		break;
+	default:
+		/* invalid HW packet index */
+		DC_LOG_WARNING(
+			"Invalid HW packet index: %s()\n",
+			__func__);
+		return;
+	}
+}
+
+void hpo_enc401_update_hdmi_info_packets(struct hpo_frl_stream_encoder *enc,
+				       const struct encoder_info_frame *info_frame)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	hpo_enc401_update_hdmi_info_packet(enc401, 0, &info_frame->avi);
+	hpo_enc401_update_hdmi_info_packet(enc401, 1, &info_frame->vendor);
+	hpo_enc401_update_hdmi_info_packet(enc401, 2, &info_frame->gamut);
+	hpo_enc401_update_hdmi_info_packet(enc401, 3, &info_frame->spd);
+	hpo_enc401_update_hdmi_info_packet(enc401, 4, &info_frame->hdrsmd);
+
+	/* 5-10 used by dsc */
+	hpo_enc401_update_hdmi_info_packet(enc401, 11, &info_frame->hfvsif);
+	hpo_enc401_update_hdmi_info_packet(enc401, 12, &info_frame->vtem);
+}
+
+void hpo_enc401_hdmi_set_dsc_config(
+	struct hpo_frl_stream_encoder *enc,
+	struct dc_crtc_timing *timing,
+	uint8_t *dsc_packed_pps)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	enum optc_dsc_mode dsc_mode = OPTC_DSC_DISABLED;
+	uint8_t i;
+
+	if (dsc_packed_pps) {
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
+				(timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
+					&& !timing->dsc_cfg.ycbcr422_simple))
+			dsc_mode = OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+		else
+			dsc_mode = OPTC_DSC_ENABLED_444;
+	}
+
+	switch (dsc_mode) {
+	case OPTC_DSC_DISABLED:
+		REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+				FIFO_PIXEL_ENCODING_TYPE, 0,
+				FIFO_COMPRESSED_PIXEL_FORMAT, 0);
+		break;
+	case OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED:
+		REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+				FIFO_PIXEL_ENCODING_TYPE, 1,
+				FIFO_COMPRESSED_PIXEL_FORMAT, 1);
+		break;
+	case OPTC_DSC_ENABLED_444:
+		REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+				FIFO_PIXEL_ENCODING_TYPE, 1,
+				FIFO_COMPRESSED_PIXEL_FORMAT, 0);
+		break;
+	}
+
+	REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+			HDMI_DSC_MODE, dsc_mode);
+
+	/* 5 packets for hdmi 2.1, use generic packets 5-10 to transmit*/
+	/* TODO: do we change new bit to 0 after first transmission? Do we set End bit when exiting dsc? */
+	if (dsc_mode != OPTC_DSC_DISABLED) {
+		struct dc_info_packet emp_packet = {0};
+		/* Need to find the padded h_total to recover the expected h_back*/
+		uint32_t h_active_padding = timing->h_addressable % timing->dsc_cfg.num_slices_h;
+		if (h_active_padding != 0)
+			h_active_padding = timing->dsc_cfg.num_slices_h - h_active_padding;
+		/* if YCBCR420, ensure slice width is even */
+		uint32_t slice_width = (timing->h_addressable + h_active_padding) / timing->dsc_cfg.num_slices_h;
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 &&
+			slice_width % 2 != 0)
+			h_active_padding += timing->dsc_cfg.num_slices_h;
+		uint32_t dsc_pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right + h_active_padding;
+		uint32_t h_back = timing->h_total - dsc_pic_width - timing->h_sync_width - timing->h_front_porch + h_active_padding;
+		/* HCactivebytes = Slices * ceil(SliceWidth * bpp/8)
+		 * Since bpp is stored as 16x actual value do (sliceWidth * bpp + 127) / 128 to ceil
+		 */
+		uint32_t h_cactive_bytes = timing->dsc_cfg.num_slices_h * (
+				(dsc_pic_width /
+						timing->dsc_cfg.num_slices_h * timing->dsc_cfg.bits_per_pixel + 127) / 128);
+
+		/* Packet 0 */
+		emp_packet.valid = true;
+		emp_packet.hb0 = 0x7F; /* Default */
+		emp_packet.hb1 = (1 << 7); /* First */
+		emp_packet.hb2 = 0; /* Sequence index */
+		emp_packet.sb[0] = (1 << 1) | (1 << 2) | (1 << 7); /* Sync[1] = 1, VFR[2] = 1, New[7] = 1*/
+		emp_packet.sb[2] = 1; /* Organization_ID = 1 (Vesa spec)*/
+		emp_packet.sb[4] = 2; /* Data_Set_Tag(LSB) = 2*/
+		emp_packet.sb[6] = 136; /* Data_Set_Length(LSB) = 136*/
+		memcpy(&emp_packet.sb[7], dsc_packed_pps, 21);
+		hpo_enc401_update_hdmi_info_packet(enc401, 5, &emp_packet);
+
+		/* Packets 1-3 */
+		emp_packet.hb1 = 0; /* Not first or last*/
+		for (i = 1; i < 4; i++) {
+			emp_packet.hb2 = i; /* Sequence index */
+			memcpy(&emp_packet.sb[0], &dsc_packed_pps[21 + 28 * (i - 1)], 28);
+			hpo_enc401_update_hdmi_info_packet(enc401, 5 + i, &emp_packet);
+		}
+
+		/* Packet 4 */
+		emp_packet.hb2 = 4; /* Sequence index */
+		memcpy(&emp_packet.sb[0], &dsc_packed_pps[105], 23);
+		emp_packet.sb[23] = (uint8_t)timing->h_front_porch; /* Hfront[7:0] */
+		emp_packet.sb[24] = (uint8_t)(timing->h_front_porch >> 8); /* Hfront[15:8] */
+		emp_packet.sb[25] = (uint8_t)timing->h_sync_width; /* Hsync[7:0] */
+		emp_packet.sb[26] = (uint8_t)(timing->h_sync_width >> 8); /* Hsync[15:8] */
+		emp_packet.sb[27] = (uint8_t)h_back; /* Hback[7:0] */
+		hpo_enc401_update_hdmi_info_packet(enc401, 9, &emp_packet);
+
+		/* Packet 5 */
+		emp_packet.hb1 = (1 << 6); /* Last */
+		emp_packet.hb2 = 5;
+		emp_packet.sb[0] = (uint8_t)(h_back >> 8); /* Hback[15:8] */
+		emp_packet.sb[1] = (uint8_t)h_cactive_bytes; /* HCactive_bytes[7:0] */
+		emp_packet.sb[2] = (uint8_t)(h_cactive_bytes >> 8); /* HCactive_bytes[15:8] */
+		hpo_enc401_update_hdmi_info_packet(enc401, 10, &emp_packet);
+
+		/* Packet 0 - Clear New[7] */
+		emp_packet.valid = true;
+		emp_packet.hb0 = 0x7F; /* Default */
+		emp_packet.hb1 = (1 << 7); /* First */
+		emp_packet.hb2 = 0; /* Sequence index */
+		emp_packet.sb[0] = (1 << 1) | (1 << 2); /* Sync[1] = 1, VFR[2] = 1*/
+		emp_packet.sb[2] = 1; /* Organization_ID = 1 (Vesa spec)*/
+		emp_packet.sb[4] = 2; /* Data_Set_Tag(LSB) = 2*/
+		emp_packet.sb[6] = 136; /* Data_Set_Length(LSB) = 136*/
+		memcpy(&emp_packet.sb[7], dsc_packed_pps, 21);
+		hpo_enc401_update_hdmi_info_packet(enc401, 5, &emp_packet);
+	}
+}
+
+void hpo_enc401_stop_hdmi_info_packets(
+	struct hpo_frl_stream_encoder *enc)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	/* TODO: should also set extended metadata packet bit back to 0? */
+
+	/* stop generic packets 0,1 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC0_CONT, 0,
+		HDMI_GENERIC0_SEND, 0,
+		HDMI_GENERIC1_CONT, 0,
+		HDMI_GENERIC1_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, 0,
+		HDMI_GENERIC0_LINE, 0,
+		HDMI_GENERIC1_LINE, 0);
+
+	/* stop generic packets 2,3 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC2_CONT, 0,
+		HDMI_GENERIC2_SEND, 0,
+		HDMI_GENERIC3_CONT, 0,
+		HDMI_GENERIC3_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, 0,
+		HDMI_GENERIC2_LINE, 0,
+		HDMI_GENERIC3_LINE, 0);
+
+	/* stop generic packets 4,5 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC4_CONT, 0,
+		HDMI_GENERIC4_SEND, 0,
+		HDMI_GENERIC5_CONT, 0,
+		HDMI_GENERIC5_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, 0,
+		HDMI_GENERIC4_LINE, 0,
+		HDMI_GENERIC5_LINE, 0);
+
+	/* stop generic packets 6,7 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, 0,
+		HDMI_GENERIC6_CONT, 0,
+		HDMI_GENERIC6_SEND, 0,
+		HDMI_GENERIC7_CONT, 0,
+		HDMI_GENERIC7_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, 0,
+		HDMI_GENERIC6_LINE, 0,
+		HDMI_GENERIC7_LINE, 0);
+
+	/* stop generic packets 8,9 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC8_CONT, 0,
+		HDMI_GENERIC8_SEND, 0,
+		HDMI_GENERIC9_CONT, 0,
+		HDMI_GENERIC9_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, 0,
+		HDMI_GENERIC8_LINE, 0,
+		HDMI_GENERIC9_LINE, 0);
+
+	/* stop generic packets 10,11 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC10_CONT, 0,
+		HDMI_GENERIC10_SEND, 0,
+		HDMI_GENERIC11_CONT, 0,
+		HDMI_GENERIC11_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, 0,
+		HDMI_GENERIC10_LINE, 0,
+		HDMI_GENERIC11_LINE, 0);
+
+	/* stop generic packets 12,13 on HDMI */
+	REG_SET_4(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC12_CONT, 0,
+		HDMI_GENERIC12_SEND, 0,
+		HDMI_GENERIC13_CONT, 0,
+		HDMI_GENERIC13_SEND, 0);
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, 0,
+		HDMI_GENERIC12_LINE, 0,
+		HDMI_GENERIC13_LINE, 0);
+
+	/* stop generic packets 14 on HDMI */
+	REG_SET_2(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, 0,
+		HDMI_GENERIC14_CONT, 0,
+		HDMI_GENERIC14_SEND, 0);
+	REG_SET(HDMI_TB_ENC_GENERIC_PACKET14_LINE, 0,
+		HDMI_GENERIC14_LINE, 0);
+
+}
+
+//Covered both, rounding up or rounding down from FRL Link Rate /18.
+static const struct frl_audio_clock_info frl_audio_clock_info_table[10] = {
+	{166666, 4224, 171875, 5292, 156250, 5760, 156250},
+	{166667, 4224, 171875, 5292, 156250, 5760, 156250},
+	{333333, 4032, 328125, 5292, 312500, 6048, 328125},
+	{333334, 4032, 328125, 5292, 312500, 6048, 328125},
+	{444444, 4032, 437500, 3969, 312500, 6048, 437500},
+	{444445, 4032, 437500, 3969, 312500, 6048, 437500},
+	{555555, 3456, 468750, 3969, 390625, 5184, 468750},
+	{555556, 3456, 468750, 3969, 390625, 5184, 468750},
+	{666666, 3072, 500000, 3969, 468750, 4752, 515625},
+	{666667, 3072, 500000, 3969, 468750, 4752, 515625}
+};
+
+void frl_get_audio_clock_info(
+	enum dc_color_depth color_depth,
+	uint32_t frl_character_clock_kHz,
+	struct frl_audio_clock_info *audio_clock_info)
+{
+	(void)color_depth;
+	const struct frl_audio_clock_info *clock_info;
+	uint32_t index;
+	uint32_t audio_array_size;
+
+	clock_info = frl_audio_clock_info_table;
+	audio_array_size = ARRAY_SIZE(
+			frl_audio_clock_info_table);
+
+	if (clock_info != NULL) {
+		/* search for exact frl character clock in table */
+		for (index = 0; index < audio_array_size; index++) {
+			if (clock_info[index].frl_character_clock_kHz >
+				frl_character_clock_kHz)
+				break;  /* not match */
+			else if (clock_info[index].frl_character_clock_kHz ==
+					frl_character_clock_kHz) {
+				/* match found */
+				*audio_clock_info = clock_info[index];
+				return;
+			}
+		}
+	}
+	/*Only 3, 6, 8, 10 and 12 Gbps are used for FRL Link rates with character
+	 *clocks of 166.667, 333.333, 444.444, 555.555 and 666.667 MHz are used
+	 *so entry should be found in above table if no bugs */
+	BREAK_TO_DEBUGGER();
+}
+
+void hpo_enc401_setup_hdmi_audio(
+	struct hpo_frl_stream_encoder *enc,
+	const struct audio_crtc_info *crtc_info)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	struct frl_audio_clock_info audio_clock_info = {0};
+
+	DC_LOG_DEBUG("Entering [%s]\n", __func__);
+
+	/* TODO:  HDMI_AUDIO_DELAY_EN bit only in DIG -- not in HPO? */
+	/* HDMI_AUDIO_PACKET_CONTROL */
+	//REG_UPDATE(HDMI_AUDIO_PACKET_CONTROL,
+	//		HDMI_AUDIO_DELAY_EN, 1);
+
+	/* Setup audio in AFMT - program AFMT block associated with HPO */
+	ASSERT (enc->afmt);
+	enc->afmt->funcs->setup_hdmi_audio(enc->afmt);
+
+	/* TODO: Same programming, but using HDMI_TB_ENC register */
+	/* HDMI_ACR_PACKET_CONTROL */
+	REG_UPDATE_3(HDMI_TB_ENC_ACR_PACKET_CONTROL,
+			HDMI_ACR_AUTO_SEND, 1,
+			HDMI_ACR_SOURCE, 0,
+			HDMI_ACR_AUDIO_PRIORITY, 0);
+
+	/* N/CTS computed relative to FRL rate instead of video rate (TMDS character clock). */
+	/* Program audio clock sample/regeneration parameters */
+	frl_get_audio_clock_info(crtc_info->color_depth,
+			     crtc_info->frl_character_clock_kHz,
+			     &audio_clock_info);
+	DC_LOG_HW_AUDIO(
+			"\n%s:Input::requested_pixel_clock_100Hz = %d"	\
+			"calculated_pixel_clock_100Hz = %d \n", __func__,	\
+			crtc_info->requested_pixel_clock_100Hz,		\
+			crtc_info->calculated_pixel_clock_100Hz);
+
+	/* Same register definition, but using HDMI_TB_ENC register */
+	/* HDMI_ACR_32_0__HDMI_ACR_CTS_32_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_32_0, HDMI_ACR_CTS_32, audio_clock_info.cts_32khz);
+
+	/* HDMI_ACR_32_1__HDMI_ACR_N_32_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_32_1, HDMI_ACR_N_32, audio_clock_info.n_32khz);
+
+	/* HDMI_ACR_44_0__HDMI_ACR_CTS_44_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_44_0, HDMI_ACR_CTS_44, audio_clock_info.cts_44khz);
+
+	/* HDMI_ACR_44_1__HDMI_ACR_N_44_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_44_1, HDMI_ACR_N_44, audio_clock_info.n_44khz);
+
+	/* HDMI_ACR_48_0__HDMI_ACR_CTS_48_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_48_0, HDMI_ACR_CTS_48, audio_clock_info.cts_48khz);
+
+	/* HDMI_ACR_48_1__HDMI_ACR_N_48_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_48_1, HDMI_ACR_N_48, audio_clock_info.n_48khz);
+
+
+	/* TODO: HDMI_TB_ENC_ACR_PACKET_CONTROL::ACR_N_MULTIPLE
+	 *       Same register definition, but using HDMI_TB_ENC register*/
+
+	/* Video driver cannot know in advance which sample rate will
+	 * be used by HD Audio driver
+	 * HDMI_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE field is
+	 * programmed below in interrupt callback
+	 */
+	DC_LOG_DEBUG("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc401_hdmi_audio_setup(
+	struct hpo_frl_stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info)
+{
+	hpo_enc401_setup_hdmi_audio(enc, audio_crtc_info);
+	ASSERT (enc->afmt);
+	enc->afmt->funcs->se_audio_setup(enc->afmt, az_inst, info);
+}
+
+void hpo_enc401_hdmi_audio_disable(
+	struct hpo_frl_stream_encoder *enc)
+{
+	ASSERT(enc->afmt);
+	if (enc->afmt->funcs->afmt_powerdown)
+		enc->afmt->funcs->afmt_powerdown(enc->afmt);
+}
+
+void hpo_enc401_audio_mute_control(
+	struct hpo_frl_stream_encoder *enc,
+	bool mute)
+{
+	ASSERT (enc->afmt);
+	enc->afmt->funcs->audio_mute_control(enc->afmt, mute);
+}
+
+void enc401_stream_encoder_set_avmute(
+	struct hpo_frl_stream_encoder *enc,
+	bool enable)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	unsigned int value = enable ? 1 : 0;
+
+	REG_UPDATE(HDMI_TB_ENC_GC_CONTROL, HDMI_GC_AVMUTE, value);
+}
+
+/* Set Dynamic Metadata-configuration.
+ *   enable_dme:         TRUE: enables Dynamic Metadata Enfine, FALSE: disables DME
+ *   hubp_requestor_id:  HUBP physical instance that is the source of dynamic metadata
+ *                       only needs to be set when enable_dme is TRUE
+ *   dmdata_mode:        dynamic metadata packet type: DP, HDMI, or Dolby Vision
+ *
+ *   Ensure the OTG master update lock is set when changing DME configuration.
+ */
+void hpo_enc401_set_dynamic_metadata(struct hpo_frl_stream_encoder *enc,
+	bool enable_dme,
+	uint32_t hubp_requestor_id,
+	enum dynamic_metadata_mode dmdata_mode)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	if (enable_dme) {
+		REG_UPDATE_2(DME_CONTROL,
+			METADATA_HUBP_REQUESTOR_ID, hubp_requestor_id,
+			METADATA_STREAM_TYPE, (dmdata_mode == dmdata_dolby_vision) ? 1 : 0);
+
+		REG_UPDATE_3(HDMI_TB_ENC_METADATA_PACKET_CONTROL,
+			HDMI_METADATA_PACKET_ENABLE, 1,
+			HDMI_METADATA_PACKET_LINE_REFERENCE, 0,
+			HDMI_METADATA_PACKET_LINE, 2);
+
+		REG_UPDATE(DME_CONTROL,
+			METADATA_ENGINE_EN, 1);
+	} else {
+		REG_UPDATE(DME_CONTROL,
+			METADATA_ENGINE_EN, 0);
+
+		REG_UPDATE(HDMI_TB_ENC_METADATA_PACKET_CONTROL,
+			HDMI_METADATA_PACKET_ENABLE, 0);
+	}
+}
+
+static const struct hpo_frl_stream_encoder_funcs dcn401_str_enc_funcs = {
+	.hdmi_frl_enable		= hpo_enc401_enable,
+	.hdmi_frl_unblank		= hpo_enc401_unblank,
+	.hdmi_frl_blank			= hpo_enc401_blank,
+	.hdmi_frl_set_stream_attribute	= hpo_enc401_set_hdmi_stream_attribute,
+	.validate_hdmi_frl_output	= hpo_enc3_validate_hdmi_frl_output,
+	.update_hdmi_info_packets	= hpo_enc401_update_hdmi_info_packets,
+	.stop_hdmi_info_packets		= hpo_enc401_stop_hdmi_info_packets,
+	.audio_mute_control		= hpo_enc401_audio_mute_control,
+	.hdmi_audio_setup		= hpo_enc401_hdmi_audio_setup,
+	.hdmi_audio_disable		= hpo_enc401_hdmi_audio_disable,
+	.set_avmute			= enc401_stream_encoder_set_avmute,
+	.read_state			= hpo_enc401_read_state,
+	.set_dynamic_metadata           = hpo_enc401_set_dynamic_metadata,
+};
+
+void dcn401_hpo_frl_stream_encoder_construct(
+	struct dcn401_hpo_frl_stream_encoder *enc401,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct afmt *afmt,
+	const struct dcn30_hpo_frl_stream_enc_registers *regs,
+	const struct dcn401_hpo_frl_stream_encoder_shift *hpo_se_shift,
+	const struct dcn401_hpo_frl_stream_encoder_mask *hpo_se_mask)
+{
+	enc401->base.funcs = &dcn401_str_enc_funcs;
+	enc401->base.ctx = ctx;
+	enc401->base.id = eng_id;
+	enc401->base.bp = bp;
+	enc401->base.vpg = vpg;
+	enc401->base.afmt = afmt;
+	enc401->regs = regs;
+	enc401->hpo_se_shift = hpo_se_shift;
+	enc401->hpo_se_mask = hpo_se_mask;
+	enc401->base.stream_enc_inst = vpg->inst;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
new file mode 100644
index 000000000000..b47ba55b9a68
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
@@ -0,0 +1,335 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_HPO_FRL_STREAM_ENCODER_DCN401_H__
+#define __DC_HPO_FRL_STREAM_ENCODER_DCN401_H__
+
+#include "dcn30/dcn30_vpg.h"
+#include "dcn30/dcn30_afmt.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "stream_encoder.h"
+#include "dml/dml1_frl_cap_chk.h"
+
+#define DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(hpo_frl_stream_encoder)\
+	container_of(hpo_frl_stream_encoder, struct dcn401_hpo_frl_stream_encoder, base)
+
+#define SE_SF(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+#define DCN401_HDMI_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(HDMI_STREAM_ENC_INPUT_MUX_CONTROL, HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_ENABLE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_PIXEL_ENCODING_TYPE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_UNCOMPRESSED_PIXEL_FORMAT, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_COMPRESSED_PIXEL_FORMAT, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_CLOCK_CONTROL, HDMI_STREAM_ENC_CLOCK_EN, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_HUBP_REQUESTOR_ID, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_ENGINE_EN, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_STREAM_TYPE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_ENABLE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE_REFERENCE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_MISSED, mask_sh),\
+	SE_SF(HDMI_TB_ENC_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE, mask_sh)
+
+#define DCN401_HDMI_TB_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(HDMI_TB_ENC_CONTROL, HDMI_TB_ENC_EN, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CONTROL, HDMI_RESET, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CONTROL, HDMI_RESET_DONE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_MODE, HDMI_BORROW_MODE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_H_ACTIVE_BLANK, HDMI_H_ACTIVE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_H_ACTIVE_BLANK, HDMI_H_BLANK, mask_sh),\
+	SE_SF(HDMI_TB_ENC_HC_ACTIVE_BLANK, HDMI_HC_ACTIVE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_HC_ACTIVE_BLANK, HDMI_HC_BLANK, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PACKET_CONTROL, HDMI_MAX_PACKETS_PER_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_DB_CONTROL, HDMI_DB_DISABLE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_PIXEL_ENCODING, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_DEEP_COLOR_DEPTH, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_DEEP_COLOR_ENABLE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_PIXEL_FORMAT, HDMI_DSC_MODE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_GC_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_GC_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_ACP_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GC_CONTROL, HDMI_GC_AVMUTE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC1_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC2_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC3_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC4_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC5_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC6_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC7_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC8_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC9_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC10_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC11_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC12_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC13_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC14_CONT, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC1_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC2_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC3_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC4_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC5_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC6_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, HDMI_GENERIC7_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC8_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC9_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC10_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC11_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC12_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC13_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, HDMI_GENERIC14_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, HDMI_GENERIC0_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, HDMI_GENERIC1_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, HDMI_GENERIC2_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, HDMI_GENERIC3_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, HDMI_GENERIC4_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, HDMI_GENERIC5_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, HDMI_GENERIC6_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, HDMI_GENERIC7_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, HDMI_GENERIC8_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, HDMI_GENERIC9_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, HDMI_GENERIC10_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, HDMI_GENERIC11_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, HDMI_GENERIC12_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, HDMI_GENERIC13_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_GENERIC_PACKET14_LINE, HDMI_GENERIC14_LINE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEND, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_PACKET_CONTROL, HDMI_ACR_SOURCE, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_PACKET_CONTROL, HDMI_ACR_AUDIO_PRIORITY, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_32_0, HDMI_ACR_CTS_32, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_32_1, HDMI_ACR_N_32, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_44_0, HDMI_ACR_CTS_44, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_44_1, HDMI_ACR_N_44, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_48_0, HDMI_ACR_CTS_48, mask_sh),\
+	SE_SF(HDMI_TB_ENC_ACR_48_1, HDMI_ACR_N_48, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CRC_CNTL, HDMI_CRC_EN, mask_sh),\
+	SE_SF(HDMI_TB_ENC_CRC_CNTL, HDMI_CRC_CONT_EN, mask_sh)
+
+#define DCN401_HDMI_TB_ENC_REG_FIELD_LIST(type) \
+	type HDMI_TB_ENC_EN;\
+	type HDMI_RESET;\
+	type HDMI_RESET_DONE;\
+	type HDMI_STREAM_ENC_CLOCK_EN;\
+	type HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL;\
+	type HDMI_MAX_PACKETS_PER_LINE;\
+	type FIFO_ENABLE;\
+	type FIFO_RESET;\
+	type FIFO_PIXEL_ENCODING_TYPE;\
+	type FIFO_UNCOMPRESSED_PIXEL_FORMAT;\
+	type FIFO_COMPRESSED_PIXEL_FORMAT;\
+	type FIFO_RESET_DONE;\
+	type HDMI_BORROW_MODE;\
+	type HDMI_H_ACTIVE;\
+	type HDMI_H_BLANK;\
+	type HDMI_HC_ACTIVE;\
+	type HDMI_HC_BLANK;\
+	type HDMI_DB_DISABLE;\
+	type HDMI_PIXEL_ENCODING;\
+	type HDMI_DEEP_COLOR_DEPTH;\
+	type HDMI_DEEP_COLOR_ENABLE;\
+	type HDMI_ODM_COMBINE_MODE;\
+	type HDMI_DSC_MODE;\
+	type HDMI_GC_CONT;\
+	type HDMI_GC_SEND;\
+	type HDMI_ACP_SEND;\
+	type HDMI_AUDIO_INFO_SEND;\
+	type HDMI_AUDIO_INFO_LINE;\
+	type HDMI_GC_AVMUTE;\
+	type HDMI_GENERIC0_CONT;\
+	type HDMI_GENERIC0_SEND;\
+	type HDMI_GENERIC0_LINE;\
+	type HDMI_GENERIC1_CONT;\
+	type HDMI_GENERIC1_SEND;\
+	type HDMI_GENERIC1_LINE;\
+	type HDMI_GENERIC2_CONT;\
+	type HDMI_GENERIC2_SEND;\
+	type HDMI_GENERIC2_LINE;\
+	type HDMI_GENERIC3_CONT;\
+	type HDMI_GENERIC3_SEND;\
+	type HDMI_GENERIC3_LINE;\
+	type HDMI_GENERIC4_CONT;\
+	type HDMI_GENERIC4_SEND;\
+	type HDMI_GENERIC4_LINE;\
+	type HDMI_GENERIC5_CONT;\
+	type HDMI_GENERIC5_SEND;\
+	type HDMI_GENERIC5_LINE;\
+	type HDMI_GENERIC6_CONT;\
+	type HDMI_GENERIC6_SEND;\
+	type HDMI_GENERIC6_LINE;\
+	type HDMI_GENERIC7_CONT;\
+	type HDMI_GENERIC7_SEND;\
+	type HDMI_GENERIC7_LINE;\
+	type HDMI_GENERIC8_CONT;\
+	type HDMI_GENERIC8_SEND;\
+	type HDMI_GENERIC8_LINE;\
+	type HDMI_GENERIC9_CONT;\
+	type HDMI_GENERIC9_SEND;\
+	type HDMI_GENERIC9_LINE;\
+	type HDMI_GENERIC10_CONT;\
+	type HDMI_GENERIC10_SEND;\
+	type HDMI_GENERIC10_LINE;\
+	type HDMI_GENERIC11_CONT;\
+	type HDMI_GENERIC11_SEND;\
+	type HDMI_GENERIC11_LINE;\
+	type HDMI_GENERIC12_CONT;\
+	type HDMI_GENERIC12_SEND;\
+	type HDMI_GENERIC12_LINE;\
+	type HDMI_GENERIC13_CONT;\
+	type HDMI_GENERIC13_SEND;\
+	type HDMI_GENERIC13_LINE;\
+	type HDMI_GENERIC14_CONT;\
+	type HDMI_GENERIC14_SEND;\
+	type HDMI_GENERIC14_LINE;\
+	type HDMI_ACR_AUTO_SEND;\
+	type HDMI_ACR_SOURCE;\
+	type HDMI_ACR_AUDIO_PRIORITY;\
+	type HDMI_ACR_CTS_32;\
+	type HDMI_ACR_N_32;\
+	type HDMI_ACR_CTS_44;\
+	type HDMI_ACR_N_44;\
+	type HDMI_ACR_CTS_48;\
+	type HDMI_ACR_N_48;\
+	type HDMI_CRC_EN;\
+	type HDMI_CRC_CONT_EN;\
+	type METADATA_HUBP_REQUESTOR_ID;\
+	type METADATA_ENGINE_EN;\
+	type METADATA_STREAM_TYPE;\
+	type HDMI_METADATA_PACKET_ENABLE;\
+	type HDMI_METADATA_PACKET_LINE_REFERENCE;\
+	type HDMI_METADATA_PACKET_MISSED;\
+	type HDMI_METADATA_PACKET_LINE
+
+#define DCN401_HPO_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	DCN401_HDMI_STREAM_ENC_MASK_SH_LIST(mask_sh),\
+	DCN401_HDMI_TB_ENC_MASK_SH_LIST(mask_sh)
+
+#define DCN42_HDMI_TB_ENC_REG_FIELD_LIST(type) \
+	type HDMI_STREAM_ENC_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL;\
+	type HDMI_STREAM_ENC_APG_CLOCK_EN
+
+struct dcn401_hpo_frl_stream_encoder_shift {
+	DCN401_HDMI_TB_ENC_REG_FIELD_LIST(uint8_t);
+	DCN42_HDMI_TB_ENC_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn401_hpo_frl_stream_encoder_mask {
+	DCN401_HDMI_TB_ENC_REG_FIELD_LIST(uint32_t);
+	DCN42_HDMI_TB_ENC_REG_FIELD_LIST(uint32_t);
+};
+
+struct dcn401_hpo_frl_stream_encoder {
+	struct hpo_frl_stream_encoder base;
+	const struct dcn30_hpo_frl_stream_enc_registers *regs;
+	const struct dcn401_hpo_frl_stream_encoder_shift *hpo_se_shift;
+	const struct dcn401_hpo_frl_stream_encoder_mask *hpo_se_mask;
+};
+
+void hpo_enc401_enable(
+		struct hpo_frl_stream_encoder *enc,
+		int otg_inst);
+
+void hpo_enc401_unblank(
+	struct hpo_frl_stream_encoder *enc,
+	int otg_inst);
+
+void hpo_enc401_read_state(
+		struct hpo_frl_stream_encoder *enc,
+		struct hpo_frl_stream_encoder_state *state);
+
+void hpo_enc401_blank(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc401_set_hdmi_stream_attribute(
+	struct hpo_frl_stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	struct frl_borrow_params *borrow_params,
+	int odm_combine_num_segments);
+
+void hpo_enc401_update_hdmi_info_packet(
+	struct dcn401_hpo_frl_stream_encoder *enc401,
+	uint32_t packet_index,
+	const struct dc_info_packet *info_packet);
+
+void hpo_enc401_update_hdmi_info_packets(
+	struct hpo_frl_stream_encoder *enc,
+	const struct encoder_info_frame *info_frame);
+
+void hpo_enc401_hdmi_set_dsc_config(
+  struct hpo_frl_stream_encoder *enc,
+  struct dc_crtc_timing *timing,
+  uint8_t *dsc_packed_pps);
+
+void hpo_enc401_stop_hdmi_info_packets(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc401_setup_hdmi_audio(
+	struct hpo_frl_stream_encoder *enc,
+	const struct audio_crtc_info *crtc_info);
+
+void hpo_enc401_hdmi_audio_setup(
+	struct hpo_frl_stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info);
+
+void hpo_enc401_hdmi_audio_disable(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc401_audio_mute_control(
+	struct hpo_frl_stream_encoder *enc,
+	bool mute);
+
+void enc401_stream_encoder_set_avmute(
+	struct hpo_frl_stream_encoder *enc,
+	bool enable);
+
+void hpo_enc401_set_dynamic_metadata(
+	struct hpo_frl_stream_encoder *enc,
+	bool enable_dme,
+	uint32_t hubp_requestor_id,
+	enum dynamic_metadata_mode dmdata_mode);
+void frl_get_audio_clock_info(
+	enum dc_color_depth color_depth,
+	uint32_t frl_character_clock_kHz,
+	struct frl_audio_clock_info *audio_clock_info);
+
+void dcn401_hpo_frl_stream_encoder_construct(
+	struct dcn401_hpo_frl_stream_encoder *enc401,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct afmt *afmt,
+	const struct dcn30_hpo_frl_stream_enc_registers *regs,
+	const struct dcn401_hpo_frl_stream_encoder_shift *hpo_se_shift,
+	const struct dcn401_hpo_frl_stream_encoder_mask *hpo_se_mask);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
new file mode 100644
index 000000000000..0ec386347f80
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "dc_bios_types.h"
+#include "core_types.h"
+#include "dcn42_hpo_frl_stream_encoder.h"
+#include "dcn31/dcn31_apg.h"
+#include "dcn401/dcn401_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "reg_helper.h"
+#include "hw_shared.h"
+#include "dcn_calc_math.h"
+#include "dml/dcn30/dcn30_fpu.h"
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+		enc401->base.ctx->logger
+
+#define DTRACE(str, ...) {DC_LOG_HDMI_FRL(str, ##__VA_ARGS__); }
+
+#define DEBUG_FRL_CAP_CHK 1
+
+#define REG(reg)\
+	(enc401->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	enc401->hpo_se_shift->field_name, enc401->hpo_se_mask->field_name
+
+#define CTX \
+	enc401->base.ctx
+
+#define VBI_LINE_0 0
+
+void hpo_enc42_unblank(struct hpo_frl_stream_encoder *enc, int otg_inst)
+{
+	(void)otg_inst;
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	DC_LOG_HDMI_FRL("Entering [%s]\n", __func__);
+
+	/*make sure FIFO_VIDEO_STREAM_ACTIVE =1*/
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 0);
+
+	/* Reset */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_RESET, 1);
+	REG_WAIT(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE,
+		 1, 10, 1000);
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_RESET, 0);
+	REG_WAIT(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE,
+		 0, 10, 1000);
+
+	/* Enable HDMI Tribyte Encoder */
+	REG_UPDATE(HDMI_TB_ENC_CONTROL,
+		   HDMI_TB_ENC_EN, 1);
+
+	/* Enable Clock Ramp Adjuster FIFO */
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+		   FIFO_ENABLE, 1);
+
+	DC_LOG_HDMI_FRL("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc42_setup_hdmi_audio(
+	struct hpo_frl_stream_encoder *enc,
+	const struct audio_crtc_info *crtc_info)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	struct frl_audio_clock_info audio_clock_info = {0};
+
+	DC_LOG_DEBUG("Entering [%s]\n", __func__);
+
+	/* TODO:  HDMI_AUDIO_DELAY_EN bit only in DIG -- not in HPO? */
+	/* HDMI_AUDIO_PACKET_CONTROL */
+	//REG_UPDATE(HDMI_AUDIO_PACKET_CONTROL,
+	//		HDMI_AUDIO_DELAY_EN, 1);
+
+	/* Setup audio in APG - program APG block associated with HPO */
+	ASSERT(enc->apg);
+
+	/* HDMI_ACR_PACKET_CONTROL */
+	REG_UPDATE_3(HDMI_TB_ENC_ACR_PACKET_CONTROL,
+			HDMI_ACR_AUTO_SEND, 1,
+			HDMI_ACR_SOURCE, 0,
+			HDMI_ACR_AUDIO_PRIORITY, 0);
+
+	/* N/CTS computed relative to FRL rate instead of video rate (TMDS character clock). */
+	/* Program audio clock sample/regeneration parameters */
+	frl_get_audio_clock_info(crtc_info->color_depth,
+			     crtc_info->frl_character_clock_kHz,
+			     &audio_clock_info);
+	DC_LOG_HW_AUDIO(
+			"\n%s:Input::requested_pixel_clock_100Hz = %d"	\
+			"calculated_pixel_clock_100Hz = %d \n", __func__,	\
+			crtc_info->requested_pixel_clock_100Hz,		\
+			crtc_info->calculated_pixel_clock_100Hz);
+
+	/* Same register definition, but using HDMI_TB_ENC register */
+	/* HDMI_ACR_32_0__HDMI_ACR_CTS_32_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_32_0, HDMI_ACR_CTS_32, audio_clock_info.cts_32khz);
+
+	/* HDMI_ACR_32_1__HDMI_ACR_N_32_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_32_1, HDMI_ACR_N_32, audio_clock_info.n_32khz);
+
+	/* HDMI_ACR_44_0__HDMI_ACR_CTS_44_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_44_0, HDMI_ACR_CTS_44, audio_clock_info.cts_44khz);
+
+	/* HDMI_ACR_44_1__HDMI_ACR_N_44_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_44_1, HDMI_ACR_N_44, audio_clock_info.n_44khz);
+
+	/* HDMI_ACR_48_0__HDMI_ACR_CTS_48_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_48_0, HDMI_ACR_CTS_48, audio_clock_info.cts_48khz);
+
+	/* HDMI_ACR_48_1__HDMI_ACR_N_48_MASK */
+	REG_UPDATE(HDMI_TB_ENC_ACR_48_1, HDMI_ACR_N_48, audio_clock_info.n_48khz);
+
+
+	/* TODO: HDMI_TB_ENC_ACR_PACKET_CONTROL::ACR_N_MULTIPLE
+	 *       Same register definition, but using HDMI_TB_ENC register*/
+
+	/* Video driver cannot know in advance which sample rate will
+	 * be used by HD Audio driver
+	 * HDMI_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE field is
+	 * programmed below in interrupt callback
+	 */
+	DC_LOG_DEBUG("Exiting [%s]\n", __func__);
+}
+
+void hpo_enc42_hdmi_audio_setup(
+	struct hpo_frl_stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info)
+{
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+
+	REG_UPDATE_2(HDMI_STREAM_ENC_AUDIO_CONTROL,
+			HDMI_STREAM_ENC_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL, az_inst,
+			HDMI_STREAM_ENC_APG_CLOCK_EN, 1);
+
+	hpo_enc42_setup_hdmi_audio(enc, audio_crtc_info);
+	ASSERT (enc->apg);
+	enc->apg->funcs->se_audio_setup(enc->apg, az_inst, info);
+}
+
+void hpo_enc42_hdmi_audio_disable(
+	struct hpo_frl_stream_encoder *enc)
+{
+	ASSERT(enc->apg);
+	if (enc->apg->funcs->disable_apg)
+		enc->apg->funcs->disable_apg(enc->apg);
+}
+
+void hpo_enc42_audio_mute_control(
+	struct hpo_frl_stream_encoder *enc,
+	bool mute)
+{
+	ASSERT (enc->apg);
+	if (mute)
+		enc->apg->funcs->disable_apg(enc->apg);
+	else
+		enc->apg->funcs->enable_apg(enc->apg);
+}
+
+static const struct hpo_frl_stream_encoder_funcs dcn42_str_enc_funcs = {
+	.hdmi_frl_enable		= hpo_enc401_enable,
+	.hdmi_frl_unblank		= hpo_enc42_unblank,
+	.hdmi_frl_blank			= hpo_enc401_blank,
+	.hdmi_frl_set_stream_attribute	= hpo_enc401_set_hdmi_stream_attribute,
+	.validate_hdmi_frl_output	= hpo_enc3_validate_hdmi_frl_output,
+	.update_hdmi_info_packets	= hpo_enc401_update_hdmi_info_packets,
+	.stop_hdmi_info_packets		= hpo_enc401_stop_hdmi_info_packets,
+	.audio_mute_control		= hpo_enc42_audio_mute_control,
+	.hdmi_audio_setup		= hpo_enc42_hdmi_audio_setup,
+	.hdmi_audio_disable		= hpo_enc42_hdmi_audio_disable,
+	.set_avmute			= enc401_stream_encoder_set_avmute,
+	.read_state			= hpo_enc401_read_state,
+	.set_dynamic_metadata           = hpo_enc401_set_dynamic_metadata,
+};
+
+void dcn42_hpo_frl_stream_encoder_construct(
+	struct dcn42_hpo_frl_stream_encoder *enc42,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct apg *apg,
+	const struct dcn30_hpo_frl_stream_enc_registers *regs,
+	const struct dcn401_hpo_frl_stream_encoder_shift *hpo_se_shift,
+	const struct dcn401_hpo_frl_stream_encoder_mask *hpo_se_mask)
+{
+	enc42->base.funcs = &dcn42_str_enc_funcs;
+	enc42->base.ctx = ctx;
+	enc42->base.id = eng_id;
+	enc42->base.bp = bp;
+	enc42->base.vpg = vpg;
+	enc42->base.apg = apg;
+	enc42->regs = regs;
+	enc42->hpo_se_shift = hpo_se_shift;
+	enc42->hpo_se_mask = hpo_se_mask;
+	enc42->base.stream_enc_inst = vpg->inst;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
new file mode 100644
index 000000000000..ff8218bed753
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef __DC_HPO_FRL_STREAM_ENCODER_DCN42_H__
+#define __DC_HPO_FRL_STREAM_ENCODER_DCN42_H__
+
+#include "dcn30/dcn30_vpg.h"
+#include "dcn31/dcn31_apg.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn401/dcn401_hpo_frl_stream_encoder.h"
+
+#include "stream_encoder.h"
+#include "dml/dml1_frl_cap_chk.h"
+
+#define DCN42_HDMI_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	DCN401_HPO_STREAM_ENC_MASK_SH_LIST(mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_AUDIO_CONTROL, HDMI_STREAM_ENC_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL, mask_sh),\
+	SE_SF(HDMI_STREAM_ENC_AUDIO_CONTROL, HDMI_STREAM_ENC_APG_CLOCK_EN, mask_sh)
+struct dcn42_hpo_frl_stream_encoder {
+	struct hpo_frl_stream_encoder base;
+	const struct dcn30_hpo_frl_stream_enc_registers *regs;
+	const struct dcn401_hpo_frl_stream_encoder_shift *hpo_se_shift;
+	const struct dcn401_hpo_frl_stream_encoder_mask *hpo_se_mask;
+};
+
+void hpo_enc42_unblank(
+	struct hpo_frl_stream_encoder *enc,
+	int otg_inst);
+
+void hpo_enc42_setup_hdmi_audio(
+	struct hpo_frl_stream_encoder *enc,
+	const struct audio_crtc_info *crtc_info);
+
+void hpo_enc42_hdmi_audio_setup(
+	struct hpo_frl_stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info);
+
+void hpo_enc42_hdmi_audio_disable(
+	struct hpo_frl_stream_encoder *enc);
+
+void hpo_enc42_audio_mute_control(
+	struct hpo_frl_stream_encoder *enc,
+	bool mute);
+
+void dcn42_hpo_frl_stream_encoder_construct(
+	struct dcn42_hpo_frl_stream_encoder *enc42,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct apg *apg,
+	const struct dcn30_hpo_frl_stream_enc_registers *regs,
+	const struct dcn401_hpo_frl_stream_encoder_shift *hpo_se_shift,
+	const struct dcn401_hpo_frl_stream_encoder_mask *hpo_se_mask);
+
+#endif /* __DC_HPO_STREAM_ENCODER_DCN42_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
index b49bd155cad4..98335a53ca52 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
@@ -263,6 +263,7 @@ void opp1_set_dyn_expansion(
 	/*00 - 10-bit -> 12-bit dynamic expansion*/
 	/*01 - 8-bit  -> 12-bit dynamic expansion*/
 	if (signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+		signal == SIGNAL_TYPE_HDMI_FRL ||
 		signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
 		signal == SIGNAL_TYPE_VIRTUAL) {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 138081e6cc97..bceefb5320eb 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -266,6 +266,7 @@
 
 struct dcn_optc_registers {
 	OPTC_REG_VARIABLE_LIST_DCN;
+	uint32_t OTG_DRR_V_TOTAL_REACH_RANGE;
 	OPTC_REG_VARIABLE_LIST_DCN42;
 };
 
@@ -595,7 +596,9 @@ struct dcn_optc_registers {
 	type MANUAL_FLOW_CONTROL;\
 	type MANUAL_FLOW_CONTROL_SEL;
 
-#define V_TOTAL_REGS(type)
+#define V_TOTAL_REGS(type) \
+	type OTG_DRR_V_TOTAL_REACH_LOWER_RANGE;\
+	type OTG_DRR_V_TOTAL_REACH_UPPER_RANGE;
 
 #define TG_REG_FIELD_LIST(type) \
 	TG_REG_FIELD_LIST_DCN1_0(type)\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
index e2303f9eaf13..16c5610b49ac 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
@@ -28,7 +28,9 @@
 
 #include "dcn20/dcn20_optc.h"
 
-#define V_TOTAL_REGS_DCN30_SRI(inst)
+#define V_TOTAL_REGS_DCN30_SRI(inst) \
+	SRI(OTG_V_TOTAL_MID, OTG, inst),\
+	SRI(OTG_DRR_V_TOTAL_REACH_RANGE, OTG, inst),
 
 #define OPTC_COMMON_REG_LIST_DCN3_BASE(inst) \
 	SRI(OTG_VSTARTUP_PARAM, OTG, inst),\
@@ -112,7 +114,9 @@
 	SR(DWB_SOURCE_SELECT),\
 	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
-#define DCN30_VTOTAL_REGS_SF(mask_sh)
+#define DCN30_VTOTAL_REGS_SF(mask_sh)\
+	SF(OTG0_OTG_DRR_V_TOTAL_REACH_RANGE, OTG_DRR_V_TOTAL_REACH_LOWER_RANGE, mask_sh),\
+	SF(OTG0_OTG_DRR_V_TOTAL_REACH_RANGE, OTG_DRR_V_TOTAL_REACH_UPPER_RANGE, mask_sh),
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_BASE(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 5f53f8747812..98aaa22ce81c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -320,6 +320,8 @@ void optc31_read_reg_state(struct timing_generator *optc, struct dcn_optc_reg_st
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	optc_reg_state->otg_drr_v_total_reach_range = REG_READ(OTG_DRR_V_TOTAL_REACH_RANGE);
+
 	optc_reg_state->optc_bytes_per_pixel = REG_READ(OPTC_BYTES_PER_PIXEL);
 	optc_reg_state->optc_data_format_control = REG_READ(OPTC_DATA_FORMAT_CONTROL);
 	optc_reg_state->optc_data_source_select = REG_READ(OPTC_DATA_SOURCE_SELECT);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index a8e978d1fae8..a6d76f451cf8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -378,6 +378,8 @@ void optc401_set_out_mux(struct timing_generator *optc, enum otg_out_mux_dest de
 	   01 - OTG_CONTROL_OTG_OUT_MUX_1 : Reserved.
 	   02 - OTG_CONTROL_OTG_OUT_MUX_2 : Connects to HPO.
 	*/
+	if (dest  == OUT_MUX_HPO_FRL)
+		dest = OUT_MUX_HPO_DP;
 	REG_UPDATE(OTG_CONTROL, OTG_OUT_MUX, dest);
 }
 
-- 
2.54.0

