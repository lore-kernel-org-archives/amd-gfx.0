Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1868C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9BC10E4D0;
	Wed,  7 Jun 2023 12:16:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3560F10E4CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6fM92ihAgCgb/EFVHDT1cN6lwNXamSHGyAqAc2AHzVIcPRfkO58suwDwhzFe19SqsBDTMPEcBibi7Sw69f09e9Usk+SmKycKc/kO9tY7hs8I1rx+vn6QovxZJFD7kngnySRGQ3n3Gh+E1sstdEiRV/9xXjM8OA5CeXC/0J1Pyrvf/HcjJlefgN24mESKi5c10g2Ejgfc/6jWvwoKYf+OJyWhW9DqQfAiFjp9bPhtpR3mznriPqL0il6rpZ8YwXCI4xTj5ywU49SP/HPtNE7CkRbRSJDzqYalQsT0BYGJu8GCybI72IFU9DXF6em50dSfCNGOrkqM1b65TAVY3hUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3h9Z/muN+K4Q5v5vQaKeThkV8KUqdtKkJA3uyJhi80=;
 b=CndsPzIhWS1QpJaR5GOhp9xIYMj3EsO/a14xgHsQbp6feJE5oi5z9g8dcJCuFT1ylqcnK6ojdw6uyiZhEIfeKhkcCr6tMgLzEwuLs+Hkaq0fz6Z/clug6JIhK439FBO+77AoKOwI3NfFEFO2TBub+OHWNlTajoNrsI8JaHiSZt+i7dg3oYBhtjLMjFbL8jxltn0QpCjoeIl+kyQyKjcbp21Ro8Iawgg5L3ngJDjOwed6pPU0gQKJ9UEYoW7Bes8CbdcryVID4lYQcEh/8d4xqC/e1p0/4IPP56bu63zK5pP3rx/sKSAMr/N1Z7UYgiO4qlx4EzSLwD1tv8nybVwcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3h9Z/muN+K4Q5v5vQaKeThkV8KUqdtKkJA3uyJhi80=;
 b=Go9cj1SjWhUcpexJbSA9nevnkORQAIrCbI/L+gMRpQDZRm4q0gx3G1Y9TWYgX1VUguz5PCrjl1wTxdafEYlW+/kT5g91J+CtoTP8APMAqdxOmjVYFOWwSFeG77pwQWnHZmq5qwIJJvPRiudzXfgWppySdyttevcTW8m9bbuP3hs=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 12:16:27 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::63) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:27 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:23 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/20] drm/amd/display: Add Error Code for Dml Validation
 Failure
Date: Wed, 7 Jun 2023 20:15:32 +0800
Message-ID: <20230607121548.1479290-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a3eec4-3009-47f4-6130-08db675104f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVn7Aj9v0gK1is0K+/T5K7L9f8e2yLmarNvQY8WXYzjCLpltEg/FZwpvCpNl9F8kMCNSbADJam5PzjeEYpbfQkYkyhl1XrNDuz/LajSlApjFBersYawQ+AkP113c7BzWIUxxyPqQ3IpVzBQpgHnyvSwzu4Hfm1Uw2I/f/wAhplpf8gywONgCnwPC0lNhQssJJv874PCdFa04oMGWQd6puyWuVSVh2NUP4SZQSQ54wj2lC4FDWiy9aRc98EfDW7C1pNoZeYrHzFFm6YZRP6c0/ZJh6wSyFQA2WbWavuJPwxt6+GCf0yL9ph7Y2VSViOnfLPUU9/m1CulW96D+Taqez5RZAMgwdXu6ynGdVAjTw//1l1+1ey+YBwSTzyWEdc5m2ruXi7W/rMoWYs8BPJSfG7NvWFbVHfCUg1VahKpfQ7FxUaGA7ZxyOsgeu8EeRycYQBVc9TU/iYMze2OP8Jb+AABNBI2hU5nBWfbHDSQMkAs/v5fvXoJL6in5AFIUvXGO6IPTYGOedVKGBWPYuRXZnyiB6JQZAj3L7XSpi4GH5YkmNvN2TTE2MlmrJGP8IVz21Jjs8e0YvjNoC7/SUW2fy0pABUHusDK+GgRveubY3R7uk93fyFoTwMuztlwMK8/Ka3rpKE+OwLyf4G0PymFP/ECyU8mrQ+kjKBS3q/WeW0hw07O/WEKRBbiyEdqXexf9V7SyZCHsquaSuMFdUU+hksmq4Hc1O3In6yMoEozKCtqscawl+ASPaYaascEZNPtXd68mqsYUYtNycj1khMLsHQxuxAKXkxU7a22deKnCt8o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(478600001)(6666004)(36860700001)(82310400005)(36756003)(2616005)(186003)(16526019)(47076005)(336012)(426003)(83380400001)(86362001)(40480700001)(356005)(81166007)(82740400003)(26005)(1076003)(40460700003)(8936002)(8676002)(5660300002)(41300700001)(44832011)(2906002)(54906003)(4326008)(316002)(6916009)(70206006)(70586007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:27.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a3eec4-3009-47f4-6130-08db675104f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Fangzhi Zuo <jerry.zuo@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

Any invalid mode from hw perspective should be given corresponding
error code, otherwise it leads to confusing warning message
"[drm] Mode Validation Warning: Validation OK failed validation."

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../dc/dml/dcn314/display_mode_vba_314.c      | 59 +++++++++++++++++++
 .../amd/display/dc/dml/display_mode_enums.h   |  8 +++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 1532a7e0ed6c..9010c47476e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5557,6 +5557,65 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 			}
 		}
 	}
+	for (i = v->soc.num_states; i >= 0; i--) {
+		for (j = 0; j < 2; j++) {
+			enum dm_validation_status status = DML_VALIDATION_OK;
+
+			if (!v->ScaleRatioAndTapsSupport) {
+				status = DML_FAIL_SCALE_RATIO_TAP;
+			} else if (!v->SourceFormatPixelAndScanSupport) {
+				status = DML_FAIL_SOURCE_PIXEL_FORMAT;
+			} else if (!v->ViewportSizeSupport[i][j]) {
+				status = DML_FAIL_VIEWPORT_SIZE;
+			} else if (P2IWith420) {
+				status = DML_FAIL_P2I_WITH_420;
+			} else if (DSCOnlyIfNecessaryWithBPP) {
+				status = DML_FAIL_DSC_ONLY_IF_NECESSARY_WITH_BPP;
+			} else if (DSC422NativeNotSupported) {
+				status = DML_FAIL_NOT_DSC422_NATIVE;
+			} else if (!v->ODMCombine4To1SupportCheckOK[i]) {
+				status = DML_FAIL_ODM_COMBINE4TO1;
+			} else if (v->NotEnoughDSCUnits[i]) {
+				status = DML_FAIL_NOT_ENOUGH_DSC;
+			} else if (!v->ROBSupport[i][j]) {
+				status = DML_FAIL_REORDERING_BUFFER;
+			} else if (!v->DISPCLK_DPPCLK_Support[i][j]) {
+				status = DML_FAIL_DISPCLK_DPPCLK;
+			} else if (!v->TotalAvailablePipesSupport[i][j]) {
+				status = DML_FAIL_TOTAL_AVAILABLE_PIPES;
+			} else if (!EnoughWritebackUnits) {
+				status = DML_FAIL_ENOUGH_WRITEBACK_UNITS;
+			} else if (!v->WritebackLatencySupport) {
+				status = DML_FAIL_WRITEBACK_LATENCY;
+			} else if (!v->WritebackScaleRatioAndTapsSupport) {
+				status = DML_FAIL_WRITEBACK_SCALE_RATIO_TAP;
+			} else if (!v->CursorSupport) {
+				status = DML_FAIL_CURSOR_SUPPORT;
+			} else if (!v->PitchSupport) {
+				status = DML_FAIL_PITCH_SUPPORT;
+			} else if (ViewportExceedsSurface) {
+				status = DML_FAIL_VIEWPORT_EXCEEDS_SURFACE;
+			} else if (!v->PrefetchSupported[i][j]) {
+				status = DML_FAIL_PREFETCH_SUPPORT;
+			} else if (!v->DynamicMetadataSupported[i][j]) {
+				status = DML_FAIL_DYNAMIC_METADATA;
+			} else if (!v->TotalVerticalActiveBandwidthSupport[i][j]) {
+				status = DML_FAIL_TOTAL_V_ACTIVE_BW;
+			} else if (!v->VRatioInPrefetchSupported[i][j]) {
+				status = DML_FAIL_V_RATIO_PREFETCH;
+			} else if (!v->PTEBufferSizeNotExceeded[i][j]) {
+				status = DML_FAIL_PTE_BUFFER_SIZE;
+			} else if (v->NonsupportedDSCInputBPC) {
+				status = DML_FAIL_DSC_INPUT_BPC;
+			} else if ((v->HostVMEnable
+					&& !v->ImmediateFlipSupportedForState[i][j])) {
+				status = DML_FAIL_HOST_VM_IMMEDIATE_FLIP;
+			} else if (FMTBufferExceeded) {
+				status = DML_FAIL_FMT_BUFFER_EXCEEDED;
+			}
+			mode_lib->vba.ValidationStatus[i] = status;
+		}
+	}
 
 	{
 		unsigned int MaximumMPCCombine = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index 0bffae95f3a2..d5831a34f5a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -190,6 +190,14 @@ enum dm_validation_status {
 	DML_FAIL_DSC_INPUT_BPC,
 	DML_FAIL_PREFETCH_SUPPORT,
 	DML_FAIL_V_RATIO_PREFETCH,
+	DML_FAIL_P2I_WITH_420,
+	DML_FAIL_DSC_ONLY_IF_NECESSARY_WITH_BPP,
+	DML_FAIL_NOT_DSC422_NATIVE,
+	DML_FAIL_ODM_COMBINE4TO1,
+	DML_FAIL_ENOUGH_WRITEBACK_UNITS,
+	DML_FAIL_VIEWPORT_EXCEEDS_SURFACE,
+	DML_FAIL_DYNAMIC_METADATA,
+	DML_FAIL_FMT_BUFFER_EXCEEDED,
 };
 
 enum writeback_config {
-- 
2.40.1

