Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A2C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6603321D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VO5apTnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6603321D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50F56EC5C;
	Tue, 27 Oct 2020 20:53:02 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A446EC5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvetsk7RpaXm+3PgE0rNuNLI5uX8xZfBpoqe+82BLhojfnmf56m9ecFBqzHjWRw4J6YmXk/yqL5GusOdGe2Bq9/nw56vjthEjErk/cPMAiLUakmqzQBC8z/j/9I45EMJlAaEIdU/nmb3Iq7jI1d2j9np6NU9mW3h/w//cyPfKS2r6ktuxgxig7mR37Nosj2F2HaoB0FO5YkWUoPVqP7/ulQUFaI0/yEIo0Y3zUsSRQAnyJGOTbZoItitOKfccPanrDYUfXMJQBj9ucSi1WctbouRY9QAUxo2PDTMFrRhLGyXI6fJrinTUxPgm6eiDrZfBJ3/rZVvu1gjzwhLjl1Rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyN7ewG9xpy07g1dOqPJiu7dr8jwoAYdVSPbzSClplk=;
 b=HmGPGrIQrQ1Lk0rrgxeAgqLtwY3fX8eUG1RXF8U8XJbxHY4uYLpB37ZIsp7akBULA0wNGP55hJyOn+Fv7sTtXymqjRhtdCV6TwIeD5C1jBZRkt4HuXHuDxvmYFMygHyqQ66fn4d07WYYd5xHCi3BPfwd1cwbj4AZl43blxEGda0uwGm+wMQwcf6mbzhPnZPbTO4qydrkbuMfFmdCwtjBJHwdNbyI9BaAWAi/TyUt6PNCE8VTShr4vB/jI7BFtUX9crDWSSU+FKB2qr/OQnJyuwgDcC8m7HtL5J4jKyzJikc4O5QckKA38bpSuOYhOogDKDHgJeLi+Z7CZWLBYudKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyN7ewG9xpy07g1dOqPJiu7dr8jwoAYdVSPbzSClplk=;
 b=VO5apTnAnZsb/t9mMJ8NFanA2ynA5oTt5qGZ3L9maPIUZJYapZblAHtRPkB9HmpzGqlSrw2oAhuss5mrjzn8nNhk4dnafj+qVZebnuooO74hkqrW5CtqyHnxI6eDKlRxhVpdcD/a9Zo1uVf26Y5NiDAiD7dr8qBPiJpK/L9HQ3w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:00 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:00 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/25] drm/amd/display: Add OPTC memory low power support
Date: Tue, 27 Oct 2020 16:52:21 -0400
Message-Id: <20201027205234.8239-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d43458b8-98b7-4f11-a217-08d87aba45e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595BBFE9671E719450636FDFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7sflt+5qH9PlYpHGgz+0zpKJH2ERCP6sesROnEqTVhpVSCxq0zRT2of0egQmGQ2aYfaAJ/+hdboP+ZcTOzbHtsMxCKWfp5ob0qb19rKkof/5obW6anFKu3jsVDmvxV4TDG6x6MuQnJcDlVHjb6jlP9IAlGGZmX4u/F9G4RxceUNeQ+tpToGhmn5ndUD9zJoUfpk7XAKihKskf/kRvPuC5iJ52fIf2PbvaX8UqzIQRfikCq0q68YPRcyXNLXVvBN2oaT76yQofjTpPqIjp3TsS358xX/zd38mhcMMpFrbxFuQPygQuIstCgNJTR47B0SfEOXjKpOKQ6VVc7lOsfozH0L6AxXhh+FKyWzADgjBaoK0vkwsL5RViPgLXxyhGVk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vkJpVJISJSHEAncw9cfHmLnI8xux6LUlFtDB2CXW6OaVFx+XntYjiNu7/iO2gvl1TY6rvsVdhze2bzgj2OQGPjE9DrRdIN2jSYYAE/vJB6Vy3nF/FgxyOumnDlxdP+FCPPivebiMZmAxJ79YZGLTO792vUIfM5iCGiXZeEt9BSJ9w1fVwup29bIh24PpXP+6uffnx+t+naMNsWQp1yhq8g9CBI3E/8PlWL7CIPCOOI35IEiPwNn6MSMVT3WNuIXf3mFHUpFi4xE8r8LyqT0Wb4gvUaVL0MTfYJQKMC5QdZqaz1qxUPIVRaYp4NsPndVySMljpvLYa+hW+2tIf+5AwOH4x/JTql5ah7QLnBmurbKKNp36kBzxbmvaXoS/XZej7URh8mIE4EOMsV+Pw6o2U6Hzbxx986tgtw859b2yiR3B4alCAFAdRVZm6EhOd5oaHVmX/VAvLauLoLlfzV5qSBW0bVfNv7ThA2Iqawfj2ef2f3o2xkah1JxcXNr6U3B1chpPYmssL3OdODnTAUrT+SraX+8u7ZQtN1lo4V+c7Z8wXPj3LxrS8yPUOMlO0xRBEk8gKjgplLTWThuRvsGhAeERjLRad1o+KmnwsdF5oBh0jRwTxhuNPwvaGM9SIvNEaNBcvepiyrbjcGRxwNHuIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43458b8-98b7-4f11-a217-08d87aba45e7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:53.0068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x49peXOf5z6XTcy894ayrjAJ9APMKqFe2g3ZBeXbAhxahBPu5x/CINz/N9I7DxKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Jacky Liao <ziyu.liao@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The OPTC memory blocks should be powered down when they are not in use.
This will reduce power consumption.

[How]
1. Set ODM_MEM_UNASSIGNED_PWR_MODE to shutdown memory when unassigned
2. Set ODM_MEM_VBLANK_PWR_MODE to light sleep mode when in vblank
3. Added a debug option to allow this behaviour to be turned off
4. Restructured debug options to use a bitfield in a way that's more clear

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c   | 14 +++++++-------
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 273963e8e61a..87bc10279349 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -414,6 +414,14 @@ struct dc_bw_validation_profile {
 			} \
 		}
 
+union mem_low_power_enable_options {
+	struct {
+		bool mpc: 1;
+		bool optc: 1;
+	} bits;
+	uint32_t u32All;
+};
+
 struct dc_debug_options {
 	enum visual_confirm visual_confirm;
 	bool sanity_checks;
@@ -506,7 +514,7 @@ struct dc_debug_options {
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
 	bool force_ignore_link_settings;
-	bool enable_mpc_mem_powerdown: 1;
+	union mem_low_power_enable_options enable_mem_low_power;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index b77e22bf6aec..a8103c762c08 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -607,6 +607,10 @@ struct dce_hwseq_registers {
 	uint32_t MC_VM_XGMI_LFB_CNTL;
 	uint32_t AZALIA_AUDIO_DTO;
 	uint32_t AZALIA_CONTROLLER_CLOCK_GATING;
+ #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	uint32_t HPO_TOP_CLOCK_CONTROL;
+	uint32_t ODM_MEM_PWR_CTRL3;
+ #endif
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
@@ -845,7 +849,9 @@ struct dce_hwseq_registers {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 #define HWSEQ_DCN30_MASK_SH_LIST(mask_sh)\
 	HWSEQ_DCN2_MASK_SH_LIST(mask_sh), \
-	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh)
+	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
+	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh), \
+	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh)
 #endif
 
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
@@ -1059,7 +1065,9 @@ struct dce_hwseq_registers {
 	type D2VGA_MODE_ENABLE; \
 	type D3VGA_MODE_ENABLE; \
 	type D4VGA_MODE_ENABLE; \
-	type AZALIA_AUDIO_DTO_MODULE;
+	type AZALIA_AUDIO_DTO_MODULE; \
+	type ODM_MEM_UNASSIGNED_PWR_MODE; \
+	type ODM_MEM_VBLANK_PWR_MODE;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 #define HWSEQ_DCN3_REG_FIELD_LIST(type) \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3699c9a2789c..53b892f16da4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -462,6 +462,12 @@ void dcn30_init_hw(struct dc *dc)
 		hws->funcs.disable_vga(dc->hwseq);
 	}
 
+	// Set default OPTC memory power states
+	if (dc->debug.enable_mem_low_power.bits.optc) {
+		// Shutdown when unassigned and light sleep in VBLANK
+		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
+	}
+
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 1671688557f4..d7d053fc6e91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -143,7 +143,7 @@ static void mpc3_power_on_ogam_lut(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 		// Force power on
 		REG_UPDATE(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_PWR_DIS, power_on == true ? 1:0);
 		// Wait for confirmation when powering on
@@ -369,7 +369,7 @@ void mpc3_set_output_gamma(
 	REG_UPDATE(MPCC_OGAM_CONTROL[mpcc_id],
 			MPCC_OGAM_SELECT, next_mode == LUT_RAM_A ? 0:1);
 
-	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown)
+	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
 		mpc3_power_on_ogam_lut(mpc, mpcc_id, false);
 }
 
@@ -818,7 +818,7 @@ static void mpc3_power_on_shaper_3dlut(
 		REG_SET(MPC_RMU_MEM_PWR_CTRL, 0,
 			MPC_RMU0_MEM_PWR_DIS, power_on == true ? 1:0);
 		/* wait for memory to fully power up */
-		if (power_on && mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+		if (power_on && mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
 			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
 		}
@@ -829,7 +829,7 @@ static void mpc3_power_on_shaper_3dlut(
 	} else if (rmu_idx == 1) {
 		REG_SET(MPC_RMU_MEM_PWR_CTRL, 0,
 			MPC_RMU1_MEM_PWR_DIS, power_on == true ? 1:0);
-		if (power_on && mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+		if (power_on && mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
 			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
 		}
@@ -862,7 +862,7 @@ bool mpc3_program_shaper(
 		return false;
 	}
 
-	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown)
+	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
 		mpc3_power_on_shaper_3dlut(mpc, rmu_idx, true);
 
 	current_mode = mpc3_get_shaper_current(mpc, rmu_idx);
@@ -1223,7 +1223,7 @@ bool mpc3_program_3dlut(
 	mpc3_set_3dlut_mode(mpc, mode, is_12bits_color_channel,
 					is_17x17x17, rmu_idx);
 
-	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown)
+	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
 		mpc3_power_on_shaper_3dlut(mpc, rmu_idx, false);
 
 	return true;
@@ -1386,7 +1386,7 @@ static void mpc3_mpc_init(struct mpc *mpc)
 
 	mpc1_mpc_init(mpc);
 
-	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 		if (mpc30->mpc_mask->MPC_RMU0_MEM_LOW_PWR_MODE && mpc30->mpc_mask->MPC_RMU1_MEM_LOW_PWR_MODE) {
 			REG_UPDATE(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_MEM_LOW_PWR_MODE, 3);
 			REG_UPDATE(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_MEM_LOW_PWR_MODE, 3);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
