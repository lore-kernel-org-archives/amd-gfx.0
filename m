Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE19DC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F7C10FE39;
	Wed, 24 Apr 2024 08:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GbJxDrWd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DEB10FE39
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5VZzzupJV+KomZWReRObVHPOFoDvanUgQ1x9XVa7Jt2dV8S77sUFuDRzhA8+tnyqy1vFUjhug2sW6knaXxCcaS/zd1u5bZk5Rbxxy6JwuLvlXezQd5qDT0j1KWLrQ/nXIpIPnKkwxZ0zPU08OK4wVlDnXilef4qeifxcSSBzeqYabO1COXiAYKX0DuyKdTAZh/KU0pP7EVxYrYH3NOpRIofb0HGP2OY27eLflD/5w2Lig+PU2hEIqHrhsgOlW+2+Gq05BqL6gFsPx5GPe5Nm+XFJH1lm0L5dQuJlDl/+JrJafZMOUBRu6+UlLKesgyP2SCevR2qZYcedbRkIVev2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rT4t91GKIRitpeYRcLCU5H19f2nXhgwyRrEbfxrilI=;
 b=UmSVHfkO1rtvt3YQePZsF7IC108DX1aVqE74+8gePRvw8Bcwok4TUgkhWYG/ETt441Tyz+GUxxHhEU8GsXdPoua88Bk839nho7/6HF4qFZNIr5BnW1VNDivz81RrYivU9hD3cYdOUBga1l+2ombWXL3prKIkV57nyNLa3X1Ahp++Z2DOCr0ynIX7pUevqtcpEGvbENG2MMbDMlLmjd6ESA8rqePsNcYvU/IMzL3oD8gbOIEIZCtqaMj9TApJf2aFWL/TJB8DXVIWhFtrdZDGxlrH2YIKWY0l54lTkhuPNlWLbL+pfIQDPmy4+866WqMXVCYFR31RGffUC/nKiw1AMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rT4t91GKIRitpeYRcLCU5H19f2nXhgwyRrEbfxrilI=;
 b=GbJxDrWdgyhXVt0Ke0A9pdGeDl89jK02E64d8z0IySkieHv4eIR0D0WQ51pQNQlPfFGrbQPffKGQcF9Ewv8ufjXiKWfrEc9OzUejeF+JrABpI4haN5bjfFcDt/9w7aBKVeUq5wA7SScL46vKCamT6Nr0erXWi2rb8mZvb/wbdKM=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:54:16 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::ee) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Wed, 24 Apr 2024 08:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:54:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:54:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 44/46] drm/amd/display: Fix uninitialized variables in DC
Date: Wed, 24 Apr 2024 16:49:29 +0800
Message-ID: <20240424084931.2656128-45-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e70362-6a3d-4ef2-e2de-08dc643c1f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8jX4UjhHMnIcN+IIZqqZ8pd6rIXl+EQ9zg0ePCqlS2qSqv+By31k/7dZfgFe?=
 =?us-ascii?Q?Qnoz0arDF+Z5R3mB1TVMi4fvesaRC0CJx4Cpy3L84qEZAkd5oBWNgTbdyy1m?=
 =?us-ascii?Q?sshUYQY8ViOy0d92/a0lGh75stYomifSRq0gDTO3GHyvnym+dyuwAMbQz+t7?=
 =?us-ascii?Q?PdEoB344DC1Gg3DsmPa/Dx0tHSRi7PvbsMcI6/6TXi4nD5rlfbAFVs5eObzQ?=
 =?us-ascii?Q?1bnlAWZ1Zy0ClH1t/Hyvg0DaG5lkj/m2qUg9iXepnRfHSAADFFCzzwzqpWql?=
 =?us-ascii?Q?lJHwuRLPowPW1Lda7CCSSzemlbjwS5BrKuC9uIFCskZqFvQkAspML7CVHVTt?=
 =?us-ascii?Q?OEMaqCT8jbff+NVbbmpDA+Vu1Nb1uCgCee9z+tgv500LmwciSVuX36h0hSrN?=
 =?us-ascii?Q?RswD+sX3/8H43ehdlnfRM2ynJjOPLPgVtFZ3aLsbAM6X5YFrNxHQlXAN3SaU?=
 =?us-ascii?Q?5I2wYHBaG0OQ/IsipUTcGxDhe4u1fq4tkSmcxt8nOTLM6+JMz5Jx76ee17Nm?=
 =?us-ascii?Q?kRxj9lmORbjVpCyL+gIOCxSIKs/HFd6t/RYXFy/KP2JBfwhsS4tLigCtF7fK?=
 =?us-ascii?Q?3DMN78csv+ZZFzksYeoOM0bVuEns5qowNg+4BoukoTnmcEoG7b/lAsu8ITJS?=
 =?us-ascii?Q?/bM0dRG8JzZ45Cfpujcel5LqRXFXEKV4tJfZTZdQyVfcN41jKWlUU55dCUcc?=
 =?us-ascii?Q?y7oNeKhNQ5TytilXUjVbYc5JVcyHjMtTFtRnJaaNW0FFrhOQh3PsBachTc/8?=
 =?us-ascii?Q?iic8fkvNeVgNv04VX32H8+/5TLeb8/T5g/aJ3k8Gn92gAPUIjUQclz/cdqz/?=
 =?us-ascii?Q?f+qmUAdqKHCbFbbFJST7mvPvUaC7GMudhw4lEW1vQFC5iewsBTslQZYKkep0?=
 =?us-ascii?Q?2S4Kqr45O9o6JU7Q7bjJqjH22xdgEt9iq99rtrRlJMc+WvfDdVRbdZmwEL3L?=
 =?us-ascii?Q?B2xlviao5WNVbkvqr1m0BaDNA693ObzP1juOfALHPZPOfLH+ahSPKPVKzrLd?=
 =?us-ascii?Q?jk0meN+r/YR1XXTqS/fgeop+uKm9vlXzp6A3k1kuHeby68NZ+6Ot2JQdrKxL?=
 =?us-ascii?Q?mpAwGot2qg8gJl5JwpZSrZk4/LJWSMJtH+VqPkyQ53gXkseSi8PyC6HyEawW?=
 =?us-ascii?Q?ElSX3C5LFsYPvhrE6mEGDdvCsMHs/Fhs/TpVAKg0/NfilwZ6dI1hri/X/tUG?=
 =?us-ascii?Q?LaLI4jwXS+Ha3s0K8YkXeeDuxj/7b/OpnlHGqHPTdIUF8MwY0X266Iylwvxx?=
 =?us-ascii?Q?g49mjGExg1AWKXhCjFITf+00YRZtHL/tCD/0Qb0+fs/SCku0kM83ZtLMkGK7?=
 =?us-ascii?Q?egj0qB5hlUDGVdAUeS1/kvlw90fqXZexyYB7XrMosBqo8rnaEk68E6N3BMod?=
 =?us-ascii?Q?7gvjPHXXkFiEm94KaWHQY1bdgMKm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:54:16.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e70362-6a3d-4ef2-e2de-08dc643c1f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
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

From: Alex Hung <alex.hung@amd.com>

This fixes 29 UNINIT issues reported by Coverity.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c          | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c          | 2 +-
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c          | 4 ++--
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c  | 2 +-
 14 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 86f9198e7501..2bcae0643e61 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -399,7 +399,7 @@ static enum bp_result transmitter_control_v1_6(
 static void init_transmitter_control(struct bios_parser *bp)
 {
 	uint8_t frev;
-	uint8_t crev;
+	uint8_t crev = 0;
 
 	if (BIOS_CMD_TABLE_REVISION(UNIPHYTransmitterControl,
 			frev, crev) == false)
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index cbae1be7b009..cc000833d300 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -225,7 +225,7 @@ static enum bp_result transmitter_control_fallback(
 static void init_transmitter_control(struct bios_parser *bp)
 {
 	uint8_t frev;
-	uint8_t crev;
+	uint8_t crev = 0;
 
 	BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 25d46c69464f..74da9ebda016 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2372,7 +2372,7 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 
 static struct _vcs_dpi_voltage_scaling_st construct_low_pstate_lvl(struct clk_limit_table *clk_table, unsigned int high_voltage_lvl)
 {
-	struct _vcs_dpi_voltage_scaling_st low_pstate_lvl;
+	struct _vcs_dpi_voltage_scaling_st low_pstate_lvl = {0};
 	int i;
 
 	low_pstate_lvl.state = 1;
@@ -2477,7 +2477,7 @@ void dcn201_populate_dml_writeback_from_context_fpu(struct dc *dc,
 	int pipe_cnt, i, j;
 	double max_calc_writeback_dispclk;
 	double writeback_dispclk;
-	struct writeback_st dout_wb;
+	struct writeback_st dout_wb = {0};
 
 	dc_assert_fp_enabled();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index ccb4ad78f667..81f7b90849ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -260,7 +260,7 @@ void dcn30_fpu_populate_dml_writeback_from_context(
 	int pipe_cnt, i, j;
 	double max_calc_writeback_dispclk;
 	double writeback_dispclk;
-	struct writeback_st dout_wb;
+	struct writeback_st dout_wb = {0};
 
 	dc_assert_fp_enabled();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 8912475f01e2..d74f51efb703 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -723,7 +723,7 @@ static bool dcn32_enough_pipes_for_subvp(struct dc *dc, struct dc_state *context
  */
 static bool subvp_subvp_schedulable(struct dc *dc, struct dc_state *context)
 {
-	struct pipe_ctx *subvp_pipes[2];
+	struct pipe_ctx *subvp_pipes[2] = {0};
 	struct dc_stream_state *phantom = NULL;
 	uint32_t microschedule_lines = 0;
 	uint32_t index = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 76399c66bc3b..ba1310c8fd77 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1973,8 +1973,8 @@ void dml32_CalculateVMRowAndSwath(
 	unsigned int PTEBufferSizeInRequestsForChroma[DC__NUM_DPP__MAX];
 	unsigned int PDEAndMetaPTEBytesFrameY;
 	unsigned int PDEAndMetaPTEBytesFrameC;
-	unsigned int MetaRowByteY[DC__NUM_DPP__MAX];
-	unsigned int MetaRowByteC[DC__NUM_DPP__MAX];
+	unsigned int MetaRowByteY[DC__NUM_DPP__MAX] = {0};
+	unsigned int MetaRowByteC[DC__NUM_DPP__MAX] = {0};
 	unsigned int PixelPTEBytesPerRowY[DC__NUM_DPP__MAX];
 	unsigned int PixelPTEBytesPerRowC[DC__NUM_DPP__MAX];
 	unsigned int PixelPTEBytesPerRowY_one_row_per_frame[DC__NUM_DPP__MAX];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index f00526d04cb7..705985d3f407 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -326,8 +326,8 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 {
 	struct dml2_policy_build_synthetic_soc_states_scratch *s = &dml2->v20.scratch.create_scratch.build_synthetic_socbb_scratch;
 	struct dml2_policy_build_synthetic_soc_states_params *p = &dml2->v20.scratch.build_synthetic_socbb_params;
-	unsigned int dcfclk_stas_mhz[NUM_DCFCLK_STAS];
-	unsigned int dcfclk_stas_mhz_new[NUM_DCFCLK_STAS_NEW];
+	unsigned int dcfclk_stas_mhz[NUM_DCFCLK_STAS] = {0};
+	unsigned int dcfclk_stas_mhz_new[NUM_DCFCLK_STAS_NEW] = {0};
 	unsigned int dml_project = dml2->v20.dml_core_ctx.project;
 
 	unsigned int i = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index e0cc78e899bd..4a37f13cbd62 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -403,7 +403,7 @@ void dcn20_init_blank(
 	struct output_pixel_processor *opp = NULL;
 	struct output_pixel_processor *bottom_opp = NULL;
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
-	uint32_t otg_active_width, otg_active_height;
+	uint32_t otg_active_width = 0, otg_active_height = 0;
 
 	/* program opp dpg blank color */
 	color_space = COLOR_SPACE_SRGB;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 06b70c360ff8..0c994b5a48b1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -82,7 +82,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 	if (enable) {
 		struct dsc_config dsc_cfg;
-		struct dsc_optc_config dsc_optc_cfg;
+		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 5bc4d9b2cf79..4302f9be1a7d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1005,7 +1005,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 	if (enable) {
 		struct dsc_config dsc_cfg;
-		struct dsc_optc_config dsc_optc_cfg;
+		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
@@ -1558,7 +1558,7 @@ void dcn32_init_blank(
 	struct output_pixel_processor *opp = NULL;
 	struct output_pixel_processor *bottom_opp = NULL;
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
-	uint32_t otg_active_width, otg_active_height;
+	uint32_t otg_active_width = 0, otg_active_height = 0;
 	uint32_t i;
 
 	/* program opp dpg blank color */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index dea7e63a49d9..a39a219a0bce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -373,7 +373,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 	if (enable) {
 		struct dsc_config dsc_cfg;
-		struct dsc_optc_config dsc_optc_cfg;
+		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index fd9c1311c2fa..bba644024780 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -516,8 +516,8 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 static void read_current_link_settings_on_detect(struct dc_link *link)
 {
 	union lane_count_set lane_count_set = {0};
-	uint8_t link_bw_set;
-	uint8_t link_rate_set;
+	uint8_t link_bw_set = 0;
+	uint8_t link_rate_set = 0;
 	uint32_t read_dpcd_retry_cnt = 10;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 9de5380757e0..1818970b8eaf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1071,7 +1071,7 @@ enum dc_status dpcd_set_link_settings(
 		 * MUX chip gets link rate set back before link training.
 		 */
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
-			uint8_t supported_link_rates[16];
+			uint8_t supported_link_rates[16] = {0};
 
 			core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
 					supported_link_rates, sizeof(supported_link_rates));
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index d2bc66904217..63f0f882c861 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1144,7 +1144,7 @@ static bool dcn303_resource_construct(
 	int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
-	struct ddc_service_init_data ddc_init_data;
+	struct ddc_service_init_data ddc_init_data = {0};
 
 	ctx->dc_bios->regs = &bios_regs;
 
-- 
2.37.3

