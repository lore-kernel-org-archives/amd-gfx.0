Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73EDC88CB2
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 13:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F65910E039;
	Mon, 12 Jun 2023 13:54:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D72810E039
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 13:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB2jhvLaQetjnCVbMCUdC9Kz36VfO0STSbH1/APrg5CddApfDVDtx9hA1NjIJ9AVR4fXqK7wLmcJy34dpHa3blKKMo6wmy63Q0CM5OlF/FMHRrVs9055Cyku3mrsFmVmhptsTYOP6frmkSyc9nT5x6nN/YHhNM3QyOq6WCuTPN5Rp3SLJXX3IH413HL900AoMds3fRy0NKJWnID5QPVTW2EAwLYyfBwGfUQAGEZWS6M5wlgVdI2aiIIuDjt2VLRY20CaKQsuK73tdbvGaBvwwmYxZilqNv+hqm0cpYoohYtKFV85F6qkiEz3W/vYHpwHXt08jAOA5QJjKZybxFZxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6v9K+Mp3+n4B9It+QjdJzAk/fsm6NzeX7+HSdOPj9o=;
 b=San2k3o2IIuSFeNniniEWr7QAfSAcNOrRo+VwQbbLccjJLh+bflqayt2+ZV+VBM3ZmGqJaxt/C7IXDRcPaVY8jyFxiU/WREkfWQhPzQBhBE08V0sPug+LPQWe0igvygXJBuPIhXiZXYssO6uPGJgFygYQ7zxWdLRARfEhi3/fRKq1E6g/w3NdHV4w6ke9iFWOdmdTH7h4nQdmSQapqOsTrZpvjIhz/yOBZ70WGjPYWHcHlnRiAOaDKwoYqiFw0P2nt/kPwcpydDobqibwPeODhex6rmuzdzhK3QuRqh8jKzpV+f6OO8mpRzh1Oy774hCHRjsnyKxG29QpD11WBYTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6v9K+Mp3+n4B9It+QjdJzAk/fsm6NzeX7+HSdOPj9o=;
 b=JXCgK2AqOqksRYb7DFMgdmp8iQoWrI7pippqGbJAEmsiWi1KGTAFWEAMIzQ1PHi+kncyLihf2DoBOtIPbHq4O7QbsnmmDjOuIOi7OvNiKYdRsE4Ched/XZIZvYpxMT2S9FLj9uBOGIVk4ZWzzoHqDitxMfpkdI5qZ1DFFnsy6Y8=
Received: from BN1PR14CA0022.namprd14.prod.outlook.com (2603:10b6:408:e3::27)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 13:54:43 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::a7) by BN1PR14CA0022.outlook.office365.com
 (2603:10b6:408:e3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 13:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 13:54:42 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 08:54:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Clean up dcn10_optc.c kdoc
Date: Mon, 12 Jun 2023 19:24:25 +0530
Message-ID: <20230612135425.2299237-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f0f0aa-86e9-4863-147f-08db6b4c92a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCoBAamsvFwz8jd8aW0Yd+uGKjb3zMf9lHIX6jGucB5W8qsyv8q/8FG9WLir1qtGlHK9gxAvyPfWXcZKVrJ36pl0WOhHzI+l+WQfw6ybgEASMiA7Sr2QqSCfaol8/Tx9JQ4CFzVeo7iig8dxGvDzG6WiQzDdZpOAymVNXIpnnh000sD9sNwYHBp0DHiVVIX0MsEo8oSrlSmnfeZq90gzVTQrfYrh4OtDacokLXmM0poHKjzlSNmiqjIlS2PzPYBxq4p/3zQu+HZMqNCHAGIKR0dnsD2/lew1v8z3AiGWo1tssNYC6Jx8jy3sYV8SsEZRJI3j7K0xbtCVqbhCic2kPEuwj1Rc46fd3eN63UEyHJQg0Bt7GAiLXjWOH/xRROqb6Jbc5+C6XVgd8ZF/lfRRfJGClezl71dsWUvaRj+y7Fpvm8pJlZqjMp9pTQs7NvI3w5WRy+8207/tdj8GPEAhJUjYN8KOmwpDzhQaeBydEDT+woeiBU1C/I+Xpja6+RzxUi52ODAvKvzgVYVhYXfGejOirHN4j3cc2+wdU6ZH6nts1Q6IGureACeZO0pc20XmwOaAGjVH2LPpjt+XH4B8RBcf5gngPXYF84fgQiEI6KnQfWRjO3wHJ3qGTBhSn+1Kx/IP3+rYIJ2e8u7/uMS0+9ciIYK70WUgVkJKzBk5o5ZvdY6el8XYaZ85OAg1RnGymIC3lsJO0UzW1u/eH+RdXFbZpCKvaL7ISezUAewEQObGZxAIZgtB7p+5TkYJEcHm1lNZu1cQF9fIHO3WptjQPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(2616005)(186003)(110136005)(54906003)(26005)(70206006)(81166007)(70586007)(6636002)(4326008)(356005)(6666004)(47076005)(426003)(36860700001)(478600001)(82310400005)(336012)(83380400001)(7696005)(1076003)(36756003)(40460700003)(2906002)(316002)(44832011)(41300700001)(40480700001)(16526019)(8936002)(8676002)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:54:42.4788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f0f0aa-86e9-4863-147f-08db6b4c92a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

display/dc/dcn10/dcn10_optc.c:45: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
* apply_front_porch_workaround  TODO FPGA still need?
display/dc/dcn10/dcn10_optc.c:136: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * program_timing_generator   used by mode timing set
display/dc/dcn10/dcn10_optc.c:391: warning: Function parameter or member 'optc' not described in 'optc1_set_timing_double_buffer'
display/dc/dcn10/dcn10_optc.c:391: warning: Function parameter or member 'enable' not described in 'optc1_set_timing_double_buffer'
display/dc/dcn10/dcn10_optc.c:404: warning: Function parameter or member 'optc' not described in 'optc1_unblank_crtc'
display/dc/dcn10/dcn10_optc.c:404: warning: expecting prototype for unblank_crtc(). Prototype was for optc1_unblank_crtc() instead
display/dc/dcn10/dcn10_optc.c:427: warning: Function parameter or member 'optc' not described in 'optc1_blank_crtc'
display/dc/dcn10/dcn10_optc.c:427: warning: expecting prototype for blank_crtc(). Prototype was for optc1_blank_crtc() instead
display/dc/dcn10/dcn10_optc.c:496: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Enable CRTC
display/dc/dcn10/dcn10_optc.c:895: warning: Cannot understand  *****************************************************************************
 on line 895 - I thought it was a doc line

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 57 ++++++++++++-------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 633989fd2514..0e8f4f36c87c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -42,11 +42,13 @@
 #define STATIC_SCREEN_EVENT_MASK_RANGETIMING_DOUBLE_BUFFER_UPDATE_EN 0x100
 
 /**
-* apply_front_porch_workaround  TODO FPGA still need?
-*
-* This is a workaround for a bug that has existed since R5xx and has not been
-* fixed keep Front porch at minimum 2 for Interlaced mode or 1 for progressive.
-*/
+ * apply_front_porch_workaround() - This is a workaround for a bug that has
+ *                                  existed since R5xx and has not been fixed
+ *                                  keep Front porch at minimum 2 for Interlaced
+ *                                  mode or 1 for progressive.
+ *
+ * @timing: Timing parameters used to configure DCN blocks.
+ */
 static void apply_front_porch_workaround(struct dc_crtc_timing *timing)
 {
 	if (timing->flags.INTERLACE == 1) {
@@ -133,9 +135,20 @@ void optc1_setup_vertical_interrupt2(
 }
 
 /**
- * program_timing_generator   used by mode timing set
- * Program CRTC Timing Registers - OTG_H_*, OTG_V_*, Pixel repetition.
- * Including SYNC. Call BIOS command table to program Timings.
+ * optc1_program_timing() - used by mode timing set Program
+ *                          CRTC Timing Registers - OTG_H_*,
+ *                          OTG_V_*, Pixel repetition.
+ *                          Including SYNC. Call BIOS command table to program Timings.
+ *
+ * @optc: timing_generator instance.
+ * @dc_crtc_timing: Timing parameters used to configure DCN blocks.
+ * @vready_offset: Vready's starting position.
+ * @vstartup_start: Vstartup period.
+ * @vupdate_offset: Vupdate starting position.
+ * @vupdate_width: Vupdate duration.
+ * @signal: DC signal types.
+ * @use_vbios: to program timings from BIOS command table.
+ *
  */
 void optc1_program_timing(
 	struct timing_generator *optc,
@@ -385,6 +398,9 @@ void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enab
  * Sets double buffer point for V_TOTAL, H_TOTAL, VTOTAL_MIN,
  * VTOTAL_MAX, VTOTAL_MIN_SEL and VTOTAL_MAX_SEL registers.
  *
+ * @optc: timing_generator instance.
+ * @enable: Enable DRR double buffering control if true, disable otherwise.
+ *
  * Options: any time,  start of frame, dp start of frame (range timing)
  */
 void optc1_set_timing_double_buffer(struct timing_generator *optc, bool enable)
@@ -397,8 +413,9 @@ void optc1_set_timing_double_buffer(struct timing_generator *optc, bool enable)
 }
 
 /**
- * unblank_crtc
- * Call ASIC Control Object to UnBlank CRTC.
+ * optc1_unblank_crtc() - Call ASIC Control Object to UnBlank CRTC.
+ *
+ * @optc: timing_generator instance.
  */
 static void optc1_unblank_crtc(struct timing_generator *optc)
 {
@@ -419,8 +436,9 @@ static void optc1_unblank_crtc(struct timing_generator *optc)
 }
 
 /**
- * blank_crtc
- * Call ASIC Control Object to Blank CRTC.
+ * optc1_blank_crtc() - Call ASIC Control Object to Blank CRTC.
+ *
+ * @optc: timing_generator instance.
  */
 
 static void optc1_blank_crtc(struct timing_generator *optc)
@@ -493,8 +511,9 @@ void optc1_enable_optc_clock(struct timing_generator *optc, bool enable)
 }
 
 /**
- * Enable CRTC
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ * optc1_enable_crtc() - Enable CRTC - call ASIC Control Object to enable Timing generator.
+ *
+ * @optc: timing_generator instance.
  */
 static bool optc1_enable_crtc(struct timing_generator *optc)
 {
@@ -890,15 +909,11 @@ static void optc1_program_manual_trigger(struct timing_generator *optc)
 			MANUAL_FLOW_CONTROL, 0);
 }
 
-
 /**
- *****************************************************************************
- *  Function: set_drr
+ * optc1_set_drr() - Program dynamic refresh rate registers m_OTGx_OTG_V_TOTAL_*.
  *
- *  @brief
- *     Program dynamic refresh rate registers m_OTGx_OTG_V_TOTAL_*.
- *
- *****************************************************************************
+ * @optc: timing_generator instance.
+ * @params: parameters used for Dynamic Refresh Rate.
  */
 void optc1_set_drr(
 	struct timing_generator *optc,
-- 
2.25.1

