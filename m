Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BB8C433E2
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0E120771
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YqmJ1ClN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0E120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508636EBE9;
	Sat,  4 Jul 2020 01:15:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2393F6E3D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU92qdbRZCQYIK/Juf1nbG6gqhq2PsclTdKKeaeMRxKFXvJS3swS9F2fO0dG6XW8Mqis+S0Dp3uVVZ9ShzyGAcOKz4P+scwHJTEcTAwsRhrpiNsd5b0BpbmqfKdgSn4FjQmZsUX5epFDI3rCr1XITGc7vS92ZQS1sVWc00tqabKQ5B2ZTSWLQ1bL0PLw8/AbIbhefNPq5hHUvAFHyv2qJb+yhX5nOlCiouDLXi96/0cPFNIWawHgqnPWcb89rfAAcfo2gVbG5dxRTWGtpQusn3GU6l8IEHaQLdel1VAf9+toLE0iEMjZocuQGHz/zL+b+ZG91zyWBOHEjlMrA3jjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0GkO+X8/uzxQj4JDiCVEzKgc+RnUUCLeSaOpRoeALU=;
 b=SZCezp7XXZdVO780Qi9N4F0Kgvwwvt3LSfEMYIo/LesFD8l0L1iuTLri74fVQSv+GQY+yRZho+6YNPA1iIUJON0nNW021ucT+cnPj/sseHkWGf6jsZRd9Vxxv+UCZun9A7esB1ROl9RmUco7T0Yl76VeyjCYOmBO2Fv+cGmTTXj0Dik/JjAN1pMs8n9Nam78cJY2DjVBfb40z5HYrNH8cmhqKGdKXvSiJUGbmKm1qQTs1Jnh8ludPXPxNV1C64h/67083K5nRwEquUD9JQv5xLKRqe5Z42/OLdVJdgy6nr0ZM8QYUA1jF8fCj9TugZhGIuloB+Mqk3T7FpeNbHXs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0GkO+X8/uzxQj4JDiCVEzKgc+RnUUCLeSaOpRoeALU=;
 b=YqmJ1ClN8A/DzalwonqxpkcRx+WvoYl1SGNuj8bqZpykTNrtqPBQrtKpmAlK94Pb9Z5uC0Rc2dGWe6AJQj5XLCaY4w8g9WajL0gbFpiFS0mFv6dFUrRT5wMR6JQZpMgM76edrZ3rI8GQiM3LmNCoWT2fTLzmQ4HjtfxfFgC7ig8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:29 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amd/display: Add logger for SMU msg
Date: Fri,  3 Jul 2020 21:14:57 -0400
Message-Id: <20200704011457.2368241-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:28 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02ac550b-e032-4fb5-e36c-08d81fb7bd43
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37689831012A8F4D98C95C36986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNOmO9OVHhQpEXWrDHzJk2fr0v55yTtL7K3lH97lpIsWACiwsvcV5FsyrUhFC+9PsplmU1PfdxrlnfbSsr88egX2npEYNkAGM5bEd20yGKVXFSeUFUsh8Kjg7fLflTZOQyJ7UBv2fRyO5oDBV2PRm+gru0x1HPfiAGixUPVcBcDHeoaikWCXqPoXcVhgTAMmSTbeKGHDH3sk7rXL3BEHAZiomDvDN+Xus7ydjsDJbFxii4pObo9nfbdSoRuSeGjCdkA+NB3d6hlb4XEG9Fgfl7lq1wABTOkXEg1mEqC9scwiUk8azKcXoe6oA+iUTpRr9yVPRhj+tLwG0DzX2uhx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(54906003)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cY+Ir0zrd7MQauOUNfS5jTmwvQHzNeY6scvNHTw3UeprPy0D3PYUqZzlnWPK/oePm2FP0z3NkascPoo0bgvwG5m7xtNaGE3cACdBUpUpPxfzr29UPLbih9Vpv6gx7OB8muDD361MxCKDFEEskr9wjIq2XhIprrGZd4GLVIiaKq69bb+fyKhvPOyFjfzGzfZDMBNovKzJmRulsVZYlRo14nKwr2ZNZPNfZ6bvYxSrR43YE88RlVEYCKpZi27OoPg9eGkMBznDm1OjTTXSTYHmcU7yjn7CeFpR6cqrrdCXRI562rPIZ/Hs59TpqKtkbjUAmHeYYxlHU9O6shaR2jCyPvzDAwIXtAX0DSorQaPbVravUQ+pITNt56sZYSobZEyoBhuzDADJ9BBCOOmPFqCeYB/1Ezi6dv8EoTZU8072y8po7nJ/TnEGl34lfrWNmz7Z6crKNh5Vb6PO7FxXM4hyRCYL+zK6j6rnGlNSAzIrEBr7n/BFe7TdMdhF8FewAEDOkYU+MlFNO2eJ9bnGoPZrgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac550b-e032-4fb5-e36c-08d81fb7bd43
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:28.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onhVBKPh8YStQJ9awWOjVIH0eBtFWeNFdWhimpM7zhJxeSBAL96D+dNkajKR+jLxctUPBNKuuu9avml2itYjqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, eryk.brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 aurabindo.pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
We want to be able to see SMU messages sent and their responses

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  | 65 ++++++++++++++++++-
 .../drm/amd/display/include/logger_types.h    |  2 +
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 986c53a3b6a8..7ee3ec5a8af8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -37,6 +37,13 @@
 #define REG(reg_name) \
 	mm ## reg_name
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
+
 /*
  * Function to be used instead of REG_WAIT macro because the wait ends when
  * the register is NOT EQUAL to zero, and because the translation in msg_if.h
@@ -94,6 +101,8 @@ bool dcn30_smu_test_message(struct clk_mgr_internal *clk_mgr, uint32_t input)
 {
 	uint32_t response = 0;
 
+	smu_print("SMU Test message: %d\n", input);
+
 	if (dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_TestMessage, input, &response))
 		if (response == input + 1)
@@ -104,9 +113,15 @@ bool dcn30_smu_test_message(struct clk_mgr_internal *clk_mgr, uint32_t input)
 
 bool dcn30_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version)
 {
+	smu_print("SMU Get SMU version\n");
+
 	if (dcn30_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_GetSmuVersion, 0, version))
+			DALSMC_MSG_GetSmuVersion, 0, version)) {
+
+		smu_print("SMU version: %d\n", *version);
+
 		return true;
+	}
 
 	return false;
 }
@@ -116,10 +131,16 @@ bool dcn30_smu_check_driver_if_version(struct clk_mgr_internal *clk_mgr)
 {
 	uint32_t response = 0;
 
+	smu_print("SMU Check driver if version\n");
+
 	if (dcn30_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_GetDriverIfVersion, 0, &response))
+			DALSMC_MSG_GetDriverIfVersion, 0, &response)) {
+
+		smu_print("SMU driver if version: %d\n", response);
+
 		if (response == SMU11_DRIVER_IF_VERSION)
 			return true;
+	}
 
 	return false;
 }
@@ -129,34 +150,48 @@ bool dcn30_smu_check_msg_header_version(struct clk_mgr_internal *clk_mgr)
 {
 	uint32_t response = 0;
 
+	smu_print("SMU Check msg header version\n");
+
 	if (dcn30_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_GetMsgHeaderVersion, 0, &response))
+			DALSMC_MSG_GetMsgHeaderVersion, 0, &response)) {
+
+		smu_print("SMU msg header version: %d\n", response);
+
 		if (response == DALSMC_VERSION)
 			return true;
+	}
 
 	return false;
 }
 
 void dcn30_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high)
 {
+	smu_print("SMU Set DRAM addr high: %d\n", addr_high);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetDalDramAddrHigh, addr_high, NULL);
 }
 
 void dcn30_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low)
 {
+	smu_print("SMU Set DRAM addr low: %d\n", addr_low);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetDalDramAddrLow, addr_low, NULL);
 }
 
 void dcn30_smu_transfer_wm_table_smu_2_dram(struct clk_mgr_internal *clk_mgr)
 {
+	smu_print("SMU Transfer WM table SMU 2 DRAM\n");
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_TransferTableSmu2Dram, TABLE_WATERMARKS, NULL);
 }
 
 void dcn30_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 {
+	smu_print("SMU Transfer WM table DRAM 2 SMU\n");
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS, NULL);
 }
@@ -169,9 +204,13 @@ unsigned int dcn30_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, PP
 	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
 	uint32_t param = (clk << 16) | freq_mhz;
 
+	smu_print("SMU Set hard min by freq: clk = %d, freq_mhz = %d MHz\n", clk, freq_mhz);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetHardMinByFreq, param, &response);
 
+	smu_print("SMU Frequency set = %d MHz\n", response);
+
 	return response;
 }
 
@@ -183,9 +222,13 @@ unsigned int dcn30_smu_set_hard_max_by_freq(struct clk_mgr_internal *clk_mgr, PP
 	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
 	uint32_t param = (clk << 16) | freq_mhz;
 
+	smu_print("SMU Set hard max by freq: clk = %d, freq_mhz = %d MHz\n", clk, freq_mhz);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetHardMaxByFreq, param, &response);
 
+	smu_print("SMU Frequency set = %d MHz\n", response);
+
 	return response;
 }
 
@@ -210,9 +253,13 @@ unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, P
 	/* bits 23:16 for clock type, lower 8 bits for DPM level */
 	uint32_t param = (clk << 16) | dpm_level;
 
+	smu_print("SMU Get dpm freq by index: clk = %d, dpm_level = %d\n", clk, dpm_level);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_GetDpmFreqByIndex, param, &response);
 
+	smu_print("SMU dpm freq: %d MHz\n", response);
+
 	return response;
 }
 
@@ -224,32 +271,44 @@ unsigned int dcn30_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr
 	/* bits 23:16 for clock type */
 	uint32_t param = clk << 16;
 
+	smu_print("SMU Get DC mode max DPM freq: clk = %d\n", clk);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_GetDcModeMaxDpmFreq, param, &response);
 
+	smu_print("SMU DC mode max DMP freq: %d MHz\n", response);
+
 	return response;
 }
 
 void dcn30_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz)
 {
+	smu_print("SMU Set min deep sleep dcef clk: freq_mhz = %d MHz\n", freq_mhz);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetMinDeepSleepDcefclk, freq_mhz, NULL);
 }
 
 void dcn30_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays)
 {
+	smu_print("SMU Set num of displays: num_displays = %d\n", num_displays);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_NumOfDisplays, num_displays, NULL);
 }
 
 void dcn30_smu_set_external_client_df_cstate_allow(struct clk_mgr_internal *clk_mgr, bool enable)
 {
+	smu_print("SMU Set external client df cstate allow: enable = %d\n", enable);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetExternalClientDfCstateAllow, enable ? 1 : 0, NULL);
 }
 
 void dcn30_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr)
 {
+	smu_print("SMU Set PME workaround\n");
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 	DALSMC_MSG_BacoAudioD3PME, 0, NULL);
 }
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 5dea27fc5198..21bbee17c527 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -67,6 +67,7 @@
 #define DC_LOG_ALL_GAMMA(...) pr_debug("[GAMMA]:"__VA_ARGS__)
 #define DC_LOG_ALL_TF_CHANNELS(...) pr_debug("[GAMMA]:"__VA_ARGS__)
 #define DC_LOG_DSC(...) DRM_DEBUG_KMS(__VA_ARGS__)
+#define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) DRM_DEBUG_KMS(__VA_ARGS__)
 
 struct dal_logger;
@@ -113,6 +114,7 @@ enum dc_log_type {
 	LOG_DISPLAYSTATS,
 	LOG_HDMI_RETIMER_REDRIVER,
 	LOG_DSC,
+	LOG_SMU_MSG,
 	LOG_DWB,
 	LOG_GAMMA_DEBUG,
 	LOG_MAX_HW_POINTS,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
