Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD5C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3222520748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uqLAAyZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3222520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF776ED09;
	Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FE96ED0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EePtzpgZpM5WorYVnHHdl0xd3HMSOj6qOE8iBmHzJqvwmCKaCoXjUehbYxX9Eiv9bMznCpGonsaXh5FNidd29t5HLQz6MuiakWYJkKyni+kpFG/PhzR3HRaJmekUV+AensAYA5d/yoWeWMTveNbcD6f3p06e6sxs+bUjzPDfG8zMKKMT/MU0q1oqFLuDj6/JKqEnvDNI2BEd+90h4WxL0MQinMm84GmG9VD6JVoqOlRtdeov4thU/Kqp6JuUES8MejVPYvwkcaraBTo/gKtEzwioLEiapvNJzRE+XX19iDdbriHRFUciq0mPLxrh7bhlwedF5PN+keAqCQ33q/TyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCCsz3mp/dzl2cTBDz1ckE2/Cnv7aAJBHbuOfUF4INw=;
 b=MW7vCEdK0YKw2B/xd8+pg+WWobZG9YPE6vV6iS2mA8Mt4GQUvkke75DfCD8eAqXAI2nLNf2G5mEcsk9uUd/j+9LnoyOuElZgQi6EySfG0KEcQPI2szq3MHsHXHHuN94tKeItL/ixKgBAE46BeSxVrVgjjEglIYVg6aRd8aGhsBoc2K0HIDsylehlfAEMBcSATmtVyGrqVtLkRy9XlNFMmIWrVi77RtSGFuv0G1gLpC0RiIYDdgE6mgp1PdDW2KVl7u4cIzP65lUm5yeL4yrwvvNrxB02ppf5ki9FNanP1GfuEIXMF79iFZ5Rx6RwaBNEvwokNOfzFayFjxFBb4Oi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCCsz3mp/dzl2cTBDz1ckE2/Cnv7aAJBHbuOfUF4INw=;
 b=uqLAAyZ8tL8vCgK6TH6KFuuCx9Yd+9+vyxANFyYKzm1of9qCpzlraJ+V0lZOKsWv6OaN2tGm1Xudf33evcwFgr8li6K3an1WjNXAcQgSaatlmxkfgNKXw/hbY3wFv9BYuJDbz7wL+1wDxJGETT0PITKim670bT+KsYZIAwreXp8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:01 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/10] drm/amd/display: reduce sr_xxx_time by 3 us when ppt
 disable
Date: Fri, 10 Jul 2020 16:33:18 -0400
Message-Id: <20200710203325.1097188-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e9f8a0e-f16a-4a24-effd-08d825109448
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231C333BA48CB6DC0EBF2FC98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dFYetKxd68/I4yRjgFVgFqpjzEJ6YAOsP0V3PRY0lxEGxcc+5WyvXdXooVl4CB8V52R+ltWXOnisHdabiJczIzyYj2nhyNfmeFtyEvKHIWkU8NoucKGojLnLr0wZhUXCnc+wpOrvScqFV0mWlZT3S+4HN/pomSD21nhMOKh+jF0mFqZUKpNESzJYsI66IwCTEoyOS9I3gbs9sdyodG+NGl8GKhOCRO7Nkyk6HgMa+3RDmjcLMV2GFo4b0Tr6mpiWSJ4/1wtts8aqDCWbKl3Jb5IbFmYVPF+vsX1UsONul5limryAw/jOHMjQMLBQGU75+OgBNbOSYR+l1R+Bv1e3mo2nX63NLDx/sXEytSBj3hq8AB+N3gO4LA3zwryBJ7g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(19627235002)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fyAknHUE0NDojt6igmxkCkOjc/gtgs5NCzSAiDEepQ9tCcdKfpOio8oynraItY98+9QT0MoD+3s/MAaQHZCnRJK6HUdRtNisSEtwNgzurshl0ILwbZZuWsQ5y2Di3vqJ6xWDT805zInPxKCkIGimnIHrNAj6fqU8mVPabho7F40rrSnARkE5p7fDfNezvCg6RSZ+UWBZKA/HJczb8y5y3O1Irof/LWeNBNOkm4EbNvHCcmEXMMRLRQA8zEotPNooVsn1BYfTINRIqPNuZqYs4EYGkFhEWt6BBWSlYFioD+U7O+AV+/sMiydnVsQVM0afvpHo72yfYaxu2dWovIsXdjD8bAcd2Vkl1lqD/RJ5u6zDoL8WLkGpAdVjCHbdj4xlsl8r5QfZTG/pp6cBHv++yOX9oMQ8MZCedQK141vna0LmQPNQFrhRbjriy0wnkcVgMA6eO23mVhqw6oMgCuq0zU5KuAWrrbg55nbHAxtHlViypqVifI4GqWCdREHijUs1ZXumQ+MKyUCaB1h/5hw1xQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9f8a0e-f16a-4a24-effd-08d825109448
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:01.2020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLUSNbvGv2un94FGWQ80IAicz9dcqjz3xxHBgWobNW1Yvtkd12oEL+9wTlQxUw5eakrE80jhd1+YBGReQYvxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Chiawen Huang <chiawen.huang@amd.com>, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why]
when ppt disabled, the watermark doesn't get fine tune causing
underflow.

[How]
It is a temporary solution to reduce sr_xxx_time by 3 us when ppt
disable.

Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 43 ++++++++++++++++++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 13 +++++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h   |  1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  1 +
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 9b4807f52381..c664404a75d4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -634,6 +634,42 @@ static struct wm_table lpddr4_wm_table = {
 	}
 };
 
+static struct wm_table lpddr4_wm_table_with_disabled_ppt = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 8.32,
+			.sr_enter_plus_exit_time_us = 9.38,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 9.82,
+			.sr_enter_plus_exit_time_us = 11.196,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 9.89,
+			.sr_enter_plus_exit_time_us = 11.24,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 9.748,
+			.sr_enter_plus_exit_time_us = 11.102,
+			.valid = true,
+		},
+	}
+};
 
 static unsigned int find_dcfclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
 {
@@ -738,6 +774,7 @@ void rn_clk_mgr_construct(
 		struct clk_log_info log_info = {0};
 
 		clk_mgr->smu_ver = rn_vbios_smu_get_smu_version(clk_mgr);
+		clk_mgr->periodic_retraining_disabled = rn_vbios_smu_is_periodic_retraining_disabled(clk_mgr);
 
 		/* SMU Version 55.51.0 and up no longer have an issue
 		 * that needs to limit minimum dispclk */
@@ -752,7 +789,11 @@ void rn_clk_mgr_construct(
 			clk_mgr->base.dentist_vco_freq_khz = 3600000;
 
 		if (ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
-			rn_bw_params.wm_table = lpddr4_wm_table;
+			if (clk_mgr->periodic_retraining_disabled) {
+				rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
+			} else {
+				rn_bw_params.wm_table = lpddr4_wm_table;
+			}
 		} else {
 			rn_bw_params.wm_table = ddr4_wm_table;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index d2facbb114d3..9a374522e963 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -52,7 +52,8 @@
 #define VBIOSSMC_MSG_GetFclkFrequency             0xB
 #define VBIOSSMC_MSG_SetDisplayCount              0xC
 #define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0xD
-#define VBIOSSMC_MSG_UpdatePmeRestore			  0xE
+#define VBIOSSMC_MSG_UpdatePmeRestore             0xE
+#define VBIOSSMC_MSG_IsPeriodicRetrainingDisabled 0xF
 
 #define VBIOSSMC_Status_BUSY                      0x0
 #define VBIOSSMC_Result_OK                        0x1
@@ -100,7 +101,7 @@ int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
 
 	result = rn_smu_wait_for_response(clk_mgr, 10, 1000);
 
-	ASSERT(result == VBIOSSMC_Result_OK);
+	ASSERT(result == VBIOSSMC_Result_OK || result == VBIOSSMC_Result_UnknownCmd);
 
 	/* Actual dispclk set is returned in the parameter register */
 	return REG_READ(MP1_SMN_C2PMSG_83);
@@ -232,3 +233,11 @@ void rn_vbios_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr)
 			VBIOSSMC_MSG_UpdatePmeRestore,
 			0);
 }
+
+int rn_vbios_smu_is_periodic_retraining_disabled(struct clk_mgr_internal *clk_mgr)
+{
+	return rn_vbios_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_IsPeriodicRetrainingDisabled,
+			0);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
index ccc01879c9d4..3e5df27aa96f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
@@ -36,5 +36,6 @@ int rn_vbios_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_
 void rn_vbios_smu_set_dcn_low_power_state(struct clk_mgr_internal *clk_mgr, int display_count);
 void rn_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
 void rn_vbios_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
+int rn_vbios_smu_is_periodic_retraining_disabled(struct clk_mgr_internal *clk_mgr);
 
 #endif /* DAL_DC_DCN10_RV1_CLK_MGR_VBIOS_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index b3b8b46d293e..4e6e18bbef5d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -270,6 +270,7 @@ struct clk_mgr_internal {
 
 	enum dm_pp_clocks_state max_clks_state;
 	enum dm_pp_clocks_state cur_min_clks_state;
+	bool periodic_retraining_disabled;
 
 	unsigned int cur_phyclk_req_table[MAX_PIPES * 2];
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
