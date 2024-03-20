Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAED9C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAB010ECBC;
	Wed, 20 Mar 2024 06:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYWcwpPF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E3D10EC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILtXkRWbQOUNW5iKC4jsjT+Gy4y7zAlNyfAV+lt2gL/jhFYjIpV9fjAjg3Y+PT7ozGWMMMJQRFIejxT+z9vf3Q2I1PPQFm2QZg/6YkklxOywAAqg6nQvndFkq4h5SocoLgOOliEdTMQAkf62fUO7tX9yewBFJmGEQ9IdgAaL761Nnz3lsALbZeYSDXGqyqUIvMckSrKpmo9fsIXF0dyY9Wx6dYnYeK8QVL+v42tmRXaSdvw9yO0FLeNkGZVcCGSc2wB5jjIV98iSRdJTuNdwGB5tdQOBk2RP2BM0jkDjJxnXPVmRYAjj4MzjfnVjsafRL3hY8Qp1doewKmwGn4rcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ES3/AfayRBrUVFCbPDALmylH/ma+THHpQEooQT0DI=;
 b=flw3cvbk3g1SpG2yzcJulj5JbK9yXxTpe3l3W5221yLdp4aEsM5noNUFnuM3wVu3vrXot4ABVcZi1+XQsPydtL+3FNXlW8MM/w0sKOlpw5sWh41OdAJSFaVpuQ+DrPDmIIY4/95zXdtYrMK/BbGjFyjPSg+Dbb7gJFDNP1KpTWxs9Xona0bKpTiobrgpdYAZpGhB7ml1I4WXNbfyk+o7hLsA9gJOpIY4vhk8tu3Q0NVdtk8wglYjOmisltZ67FSeqMC5Oas3G5AjJOh5MT1HCb5sZPnVGbZDLGuX857kzdWBlEl5ZCLCUcb0+I9lN6uxrjDVBFjp9bnp51p2WcHyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ES3/AfayRBrUVFCbPDALmylH/ma+THHpQEooQT0DI=;
 b=sYWcwpPFdtWbBmw0buzm7GDtKhoiMOBNVv57Mr1KWmCuN/H+XKaK12lwvHYOTtT+E+E5+LI+UW0kukk9mwR8SMiB7wIy7yvpQMrZsQIBA9rytGboiqXBhb9twzxfnVD405SS3OEYA9vv5772O7qFs2MP38f+C3cdHKmitSoFXtU=
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Wed, 20 Mar 2024 06:36:22 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::af) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:21 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim <sungkim@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Remove read/write to external register
Date: Wed, 20 Mar 2024 14:35:38 +0800
Message-ID: <20240320063556.1326615-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: c1614fc1-838f-42d5-6aab-08dc48a80eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+onZY6oZ9btdMVhS5nPHq/84vSgHeJeEho+BI9OX9+mIzNPI4cBdHBbTfvrr5w46eOwOleSFT4X2wHnOQWbXjpdhIdfqk2qNK8nXm0XKC1WiZbGYcWvStz5h/ogE+nkL/i8cwLhGfHrXSLrgiFE0MysJGWD1l6nE0eiSqUa/nDpgo9ZoJEtAx5sIzEi3VLCmXtKC+ddXPCjoubwcwEU1Kdv/Ngp4RnmY5maaxfWUxgVQ8y7Gt70uh14DAuatgogE9jTp25l/eJQ7MohEr2Wav3GM7wg7A7Py5J3zbLi2ylgng0iBCslbj3arG+NTall9gd2tiqVWGvcDsMMTy4Q+uqU8+s6jk9EO1HN66m9Ia7zHlv4tW8T5KjqkYPMrWkCGKa31VjuX62Tc6x3byeStVehREYv+/vCbOOkK2AD8TXJIAOdzXbixEaYn7bHaGjO4zz2KoSeyvyxEpozwosjPkOkfo4UF8XLY2CUKLfTxqtgZNPiOrLdtrVW2e41lsoe9WzJI0sMmApLLmeP3UCf9KRhAWy52Wzw53R6AVC4mxeo4yOcS4dlylow/3pYOA7uF3vpKK+exmzuXWmlsKUgjYBc58szkAwdHbyzr7ls9wEIpMHtOTSf1gC6Ktp96N1g0q54Pgtl3DGVFaexg5Qt9S/7Aw/D8xWY18ffhcKCsL1SVUMTqd+Jw/i0HHbpOIysT38+drmUH9t+OvuQ8oybcGAUzCSLrgmyAypOJyUx9sQeP4ORd+PzVhCJ53MCiwde
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:21.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1614fc1-838f-42d5-6aab-08dc48a80eb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

From: Sung Joon Kim <sungkim@amd.com>

[why&how]
We need to remove the reference to these registers to
prevent any usage in the future.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 38 -------------------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 21 ----------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  2 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 16 --------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  3 --
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 -
 9 files changed, 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index dafa07671d00..928d61f9f858 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -842,35 +842,6 @@ static void dcn35_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	}
 }
 
-static void dcn35_set_ips_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dc *dc = clk_mgr_base->ctx->dc;
-	uint32_t val = dcn35_smu_read_ips_scratch(clk_mgr);
-
-	if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
-		dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	}
-
-	if (!allow_idle) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	}
-
-	dcn35_smu_write_ips_scratch(clk_mgr, val);
-}
-
 static void dcn35_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -890,13 +861,6 @@ static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
 	return ips_supported;
 }
 
-static uint32_t dcn35_get_ips_idle_state(struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-	return dcn35_smu_read_ips_scratch(clk_mgr);
-}
-
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
 {
 	init_clk_states(clk_mgr);
@@ -984,8 +948,6 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
 	.is_ips_supported = dcn35_is_ips_supported,
-	.set_idle_state = dcn35_set_ips_idle_state,
-	.get_idle_state = dcn35_get_ips_idle_state
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index 9e588c56c570..1399b41dfd1c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -487,24 +487,3 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 	//smu_print("%s: VBIOSSMC_MSG_QueryIPS2Support return = %x\n", __func__, retv);
 	return retv;
 }
-
-void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
-{
-	if (!clk_mgr->smu_present)
-		return;
-
-	REG_WRITE(MP1_SMN_C2PMSG_71, param);
-	//smu_print("%s: write_ips_scratch = %x\n", __func__, param);
-}
-
-uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
-{
-	uint32_t retv;
-
-	if (!clk_mgr->smu_present)
-		return 0;
-
-	retv = REG_READ(MP1_SMN_C2PMSG_71);
-	//smu_print("%s: dcn35_smu_read_ips_scratch = %x\n",  __func__, retv);
-	return retv;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 2b8e6959a03d..06cd3cc6d36e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -198,6 +198,4 @@ int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
-void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param);
-uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr);
 #endif /* DAL_DC_35_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 26ab60deb12d..ad88edebcdfe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1337,22 +1337,6 @@ void dcn35_optimize_bandwidth(
 	}
 }
 
-void dcn35_set_idle_state(const struct dc *dc, bool allow_idle)
-{
-	// TODO: Find a more suitable communcation
-	if (dc->clk_mgr->funcs->set_idle_state)
-		dc->clk_mgr->funcs->set_idle_state(dc->clk_mgr, allow_idle);
-}
-
-uint32_t dcn35_get_idle_state(const struct dc *dc)
-{
-	// TODO: Find a more suitable communcation
-	if (dc->clk_mgr->funcs->get_idle_state)
-		return dc->clk_mgr->funcs->get_idle_state(dc->clk_mgr);
-
-	return 0;
-}
-
 void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, struct dc_crtc_timing_adjust adjust)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 7c33bea3f4e7..68f714143431 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -84,9 +84,6 @@ void dcn35_dsc_pg_control(
 		unsigned int dsc_inst,
 		bool power_on);
 
-void dcn35_set_idle_state(const struct dc *dc, bool allow_idle);
-uint32_t dcn35_get_idle_state(const struct dc *dc);
-
 void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, struct dc_crtc_timing_adjust adjust);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index dce620d359a6..19b861349954 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -121,8 +121,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.hw_block_power_up = dcn35_hw_block_power_up,
 	.hw_block_power_down = dcn35_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
-	.set_idle_state = dcn35_set_idle_state,
-	.get_idle_state = dcn35_get_idle_state,
 	.set_long_vtotal = dcn35_set_long_vblank,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index ab17fa1c64e8..f584266ca25a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -120,8 +120,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.hw_block_power_up = dcn35_hw_block_power_up,
 	.hw_block_power_down = dcn35_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
-	.set_idle_state = dcn35_set_idle_state,
-	.get_idle_state = dcn35_get_idle_state
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 26ea86316e50..65df90842b83 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -424,8 +424,6 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state);
 	void (*root_clock_control)(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
-	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
-	uint32_t (*get_idle_state)(const struct dc *dc);
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
 			const struct dc_state *new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 17e014d3bdc8..4f7480f60c85 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -281,8 +281,6 @@ struct clk_mgr_funcs {
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
 	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
-	void (*set_idle_state)(struct clk_mgr *clk_mgr, bool allow_idle);
-	uint32_t (*get_idle_state)(struct clk_mgr *clk_mgr);
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
-- 
2.34.1

