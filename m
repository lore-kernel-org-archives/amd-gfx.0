Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FC561381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67FC561381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8436ED74;
	Fri,  1 Oct 2021 14:41:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70EA6ED34
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6m9bQw35yDLj6L9s0BlyLMoe4a7h3l6Z84C7WS4FMhcQJ2F0z81psK3Yny3YlQvTr2rHxLuxdfgSg9ICGfs49K1ZSvPCHcrbNbIuGA1VXr80pjc2/qs55QFNDOP5gs9T9XiAJGSfmq2XAmXBILa9SFUTaf1goLYkpcgIwzxI+bGhLq7+eygCcNvUcHtB8z34zUzwQ7TxItSQSxaR8ZCtqOvgI5BBIP4aTy+33/43+XvBI3RrsW/G8LLYPRipfWlplFjC7JVry/nAEJrnjYVvWQboo+vAGPd3xs7xMnj6XQXZgaSjUn3Vn8sAAcD7U3u0v4S1JR0YJhqlyBcTzmwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eInG7A/kOkvJyi8lDkj2PYEmoJa0HDAZjFWak0fr8YA=;
 b=c/Lt8ipvbDEZh6B0poht0gWc2eyeC0Pu8ipmqpPtTgtqX0Nsq5oDJGcHD1/Evvu6o2oiDlV5Jsh5M+duGe3ufSBpyG4H8gvS3SWAZqPWSnGXWbvd7o16TYfejr8qPUZJ0UIRWfBj2Wmt8vi/1Bc/VFJ0OT1PHuA3TexIJTuKg5S9Z48eZbb6op/cPKZf/goA7tbw6/aNQ9MQrKJSJE5p/5aguEYGAmMvio93ZhraWvuJ/3nBI3tuwH/7AdHP04Wn1yiv8A2V5+vEc/e286mrpN2zms0UGbQ4oWZZJ/+fu6GNpYmLqRHnR9fEmq0oxQHyGIHlT1tLLoW1OmN4FgqbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eInG7A/kOkvJyi8lDkj2PYEmoJa0HDAZjFWak0fr8YA=;
 b=fXPX58Ol2bIN13lw8/4Fz9oBIy6dJTD32nCp4/IfG2Sq+L5H+aiELMWtPj/0Acd3gjo2flJ0g88fu2L34bwfE6XHX+GqDtidr2wQOFPyWcK3mSvCxzgFjmYD+IYBJBVZAuIIcxcwioUA4ne8GPRyjIgppg/K/yUOs90oO/7uA1M=
Received: from CO2PR05CA0070.namprd05.prod.outlook.com (2603:10b6:102:2::38)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Fri, 1 Oct
 2021 14:41:01 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::ee) by CO2PR05CA0070.outlook.office365.com
 (2603:10b6:102:2::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:00 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:40:55 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, <sungjoon.kim@amd.com>
Subject: [PATCH 02/14] drm/amd/display: update irq_service and other required
 change part 2.
Date: Fri, 1 Oct 2021 22:36:08 +0800
Message-ID: <20211001143620.192679-3-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca921ef-0487-4126-1e56-08d984e97d00
X-MS-TrafficTypeDiagnostic: CH0PR12MB5187:
X-Microsoft-Antispam-PRVS: <CH0PR12MB518711A228E85A8BDE080F3D97AB9@CH0PR12MB5187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoLDp9jo63HUAFnvAC5bysDx6OreB+Lh5wvwI7Dw+ojJoQQPSn6osoHT5VX6sp6tueM9jcuOLkXVgb0IwlTgPCQ33np0HDknxioCrgD3xKjQ855EKlo7f3laLe4lQvAO4AjG0h9/lJRYwC0uZgWQ3jKqC+J52eqslLPe4Cj9FeZcsQIpMzJ3Q8XLyfmYAEoqFPVLzjzybgBLkhyRKgn0gtS7CTArP9L1nzKf2RLd8mlbbYpYMa6yiipfac38KnaaHwjZPIW9j9JJg82X4WEBgs/bxFtIRE5dbPKGmViW45uzhdAimgVStf1biQa0PvOG0axXtXnmRTYhW4Anxvcf63gSVkmPeGdv4S6qNjuuiatpcm9NK6mlGh1suiJwkAvj95ed4OATXcDWx34wKqQr63GmMEbjjaoJF8m08niI/18sLOYDt0lf+xmhln2lIJ7jKyouUDohSIakDUxoU80rBOSvOV9X1L+DED8B0uAML1+/D+sS8MYl3JMtlxE480dlrEkQ1AgszaL9+NH6FgPZmkrspcZ5+5nU1iM1NWGsh3bYsxzampGAATxKRRn3zTLLZ1AHPTi8wHKvRAUdqv9amd1rT6qQrbLtSQHjw/emmCGRKzsHXOnDvjKvIJyU1BXFx2pBm7AGfuMVGzJZoEFBNAWL7vsUvvNaaV437gG1qANYDo46f6mm1i6MsyC3/Id9jIhqELQY8Arj0/QV09HeDPXDGtMtiutuaYQC3m6MGcQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(4326008)(2616005)(70586007)(6916009)(16526019)(8676002)(26005)(1076003)(186003)(47076005)(70206006)(36860700001)(86362001)(83380400001)(44832011)(316002)(82310400003)(36756003)(2906002)(356005)(6666004)(5660300002)(336012)(8936002)(54906003)(81166007)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:00.7399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca921ef-0487-4126-1e56-08d984e97d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
fix NULL pointer in irq_service_dcn201

[how]
initialize proper num of irq source for linu

Reviewed-by: Sung joon Kim <USER DID NOT SET AN EMAIL>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h |  9 +++++----
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h   |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c  | 17 ++++++++++-------
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8cc9626fc111..c5a091d0bbfc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -899,6 +899,7 @@ union surface_update_flags {
 		uint32_t bandwidth_change:1;
 		uint32_t clock_change:1;
 		uint32_t stereo_format_change:1;
+		uint32_t lut_3d:1;
 		uint32_t full_update:1;
 	} bits;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index 296b2f80a1ec..307369b52b42 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -663,14 +663,15 @@ struct dce_hwseq_registers {
 	uint32_t MC_VM_XGMI_LFB_CNTL;
 	uint32_t AZALIA_AUDIO_DTO;
 	uint32_t AZALIA_CONTROLLER_CLOCK_GATING;
+	/* MMHUB VM */
+	uint32_t MC_VM_FB_LOCATION_BASE;
+	uint32_t MC_VM_FB_LOCATION_TOP;
+	uint32_t MC_VM_FB_OFFSET;
+	uint32_t MMHUBBUB_MEM_PWR_CNTL;
 	uint32_t HPO_TOP_CLOCK_CONTROL;
 	uint32_t ODM_MEM_PWR_CTRL3;
 	uint32_t DMU_MEM_PWR_CNTL;
-	uint32_t MMHUBBUB_MEM_PWR_CNTL;
 	uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
-	uint32_t MC_VM_FB_LOCATION_BASE;
-	uint32_t MC_VM_FB_LOCATION_TOP;
-	uint32_t MC_VM_FB_OFFSET;
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
index bf1ffc3629c7..3d9be87aae45 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
@@ -111,6 +111,7 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index fb0dec4ed3a6..0f273ac0c83f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -256,16 +256,19 @@ struct abm *dmub_abm_create(
 	const struct dce_abm_shift *abm_shift,
 	const struct dce_abm_mask *abm_mask)
 {
-	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
+	if (!ctx->dc->config.disable_dmcu) {
+		struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
 
-	if (abm_dce == NULL) {
-		BREAK_TO_DEBUGGER();
-		return NULL;
-	}
+		if (abm_dce == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 
-	dmub_abm_construct(abm_dce, ctx, regs, abm_shift, abm_mask);
+		dmub_abm_construct(abm_dce, ctx, regs, abm_shift, abm_mask);
 
-	return &abm_dce->base;
+		return &abm_dce->base;
+	}
+	return NULL;
 }
 
 void dmub_abm_destroy(struct abm **abm)
-- 
2.25.1

