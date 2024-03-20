Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B547C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E787410EE9A;
	Wed, 20 Mar 2024 06:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gk1320p/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4F110EE9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmsw63afFppkE9Mkve2IpPh2Af5am+OBWqT1IDEE8H+aa4IkU0bxIVhyqKsEovywhPABnjWK5ft75FDEmKgQqpHJsawxBZZ4LRjKXrp0ShOlsRYORsm8s8hpjnZelS/z/xgSMaS01mDeFA6M4tEQzNf1KQIqyoznVASJr4t/l251uwMeZp8Ppr2rVrReHjF/zRA0RjNdxFWnxGD4YMJrFQinTKCoxCEW4a5siPWDU4pbNmKCVFZ/41oEMS7KDyVSrUy16w5v/exYltrnuyW7wUmICWrJOQuDXqiK+ALdTs4oIqt5Borh/wJtqRbyUXu11CQGyORXP7uDdQl6oHCesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnDHQ3z/FwKUucn6ULIP/ig8ArxgXCqvICxVnSv/JjI=;
 b=a/lZHvR6YdZRiUUGYAEQDrlzIhJAXvQfnaETBEfyW0HmeGrgSySxBVpowydp8efBgjuK52xpeyEEwaQ+6R1O5UY1K9/6uA7j/o+Iws1tdHNlJVRz3qvXlkLFyPNgvkts5pOi0Icji4SDtcjc9ul6YTgp3F8a/CNpKVviAiu8HiopEeJDn03/m1uiuMQ0kCJJxscAbeFeEfFnnv2jLhxVhPDOIYf5H1zxjsFgU9d2xMYPxvPcLwtr3v3rilvJnct7f6MPeYS33EhXk5LsgdOyA8oL0kbCKc9WNFHzP5inrZfr52YPaVs370npm38XXuKtgfpxRk6GmNeKvQOmk2oE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnDHQ3z/FwKUucn6ULIP/ig8ArxgXCqvICxVnSv/JjI=;
 b=Gk1320p/asuxDjXipEPHENm8dNlc0y9hTi9W0YtpHjLd8U48zQ1YNbF7t/YHjqrBDJdLfx5oVbswj1jdR0221ic4CX2K/6AvXiruwXjQy1Gxs9Te4R8P7wLa2Vl0mOK6e/xVuHq/q5oNtkp+oQ1XzohXMFUGhZ1To46TbDtf0qk=
Received: from BLAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:36e::15)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Wed, 20 Mar
 2024 06:37:07 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::7d) by BLAPR05CA0015.outlook.office365.com
 (2603:10b6:208:36e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:05 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:03 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/22] drm/amd/display: Allow Z8 when stutter threshold is not
 met for dcn35
Date: Wed, 20 Mar 2024 14:35:49 +0800
Message-ID: <20240320063556.1326615-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: e51eb912-7468-407f-4a79-08dc48a829c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89iZ+1fyMcmpzJ9EgCaIrZy+FFwqnASS11x2PMhLt4Tk2/sVeI1zjj3JoLuTDwkh+FSo7O70tDKbNefnqPnwJ55eiivfs8boIK9WzW0bkhJyyuL5FJJHiX2hUfOTjB+nDmlWFAnyKp17mMNWeYbhpK/y+2CwVwwFxNnqO3hk1Mlflm29qBBwSB+vglClPCm5jFyFT29GS1R8R/DVBB4aMDPvj8MAdE05REdyAB5Bg0XOz3X+4C3VAZMqOL1PTBaIYZYfsE915TyX94UwooqHIkLbHWxDVLltC/tpB96kxravYZMHd33fDyDlmuk6MZ5Xkt6SGMDpbcz3RAr3oRWixCvR0sByy6zuHc0r3a1eYbxgEFOh9cNIq/ye4U1MQqqQKumb6K7yTui+1fUGdOvxRsM362NFjTbekHnJz2lrrVsiEKfkhIDJ9EWGKsBAH+RCyS8Lh8Mi/RfGAoSetnwCYa6p4LeB1Nk3YgjumL6OoINmUr0mDnIToWuuNmd1tlovkoYicJnROfULbVABq5fZIqAJVEnY0w8EaFY07LJYRkTN6NlfqsSyDxUAUbfVr/aUHrl/eWx4mm8IxgDoPLqmQDRWfdPHB7crHu2OIvuJSuo12gLPdYrsESVyeHMY9g3JfWh/OQNrcNIaqNEQX+x/dhDbSiMqnEQCF+RwR5D0mxuuBM4migD/jUtHN7UsAXHgXb3+O8b49TibF4ql08Dj+u99CdtbF8T4B7HkJ7LVRBUbDueitM7vxLYu4NQWphDR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:07.1931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51eb912-7468-407f-4a79-08dc48a829c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

[Why&How]
Some panels don't meet the stutter threshold (4k etc), this leads to
power regressions. Allow z8 for panels that don't meet the threshold
but support PSR/replay

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c   | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 33ea89f20449..714c2fe03c5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -603,7 +603,7 @@ void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
 		if (is_pwrseq0 && allow_z10)
 			support = DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && (is_psr || is_replay))
-			support = allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
+			support = DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY;
 		else if (allow_z8)
 			support = DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 72cca367062e..e2489eaabb20 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -570,6 +570,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	struct dml2_dcn_clocks out_clks;
 	unsigned int result = 0;
 	bool need_recalculation = false;
+	uint32_t cstate_enter_plus_exit_z8_ns;
 
 	if (!context || context->stream_count == 0)
 		return true;
@@ -641,6 +642,14 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.d, &dml2->v20.dml_core_ctx);
 		//copy for deciding zstate use
 		context->bw_ctx.dml.vba.StutterPeriod = context->bw_ctx.dml2->v20.dml_core_ctx.mp.StutterPeriod;
+
+		cstate_enter_plus_exit_z8_ns = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns;
+
+		if (context->bw_ctx.dml.vba.StutterPeriod < in_dc->debug.minimum_z8_residency_time &&
+				cstate_enter_plus_exit_z8_ns < in_dc->debug.minimum_z8_residency_time * 1000)
+			cstate_enter_plus_exit_z8_ns = in_dc->debug.minimum_z8_residency_time * 1000;
+
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns = cstate_enter_plus_exit_z8_ns;
 	}
 
 	return result;
-- 
2.34.1

