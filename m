Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C1FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9854F10E565;
	Fri,  9 Dec 2022 16:37:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB69910E56E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilXNdBBlSEyPrdi7awKaXP8VchLGu9h2Pw5esN6mwtE86IG1Vk/MU1BOA5xVZn5whL0dEZwG7L3MkdvMw1XtUUSmjr4XgvB0s9Z5cr796bsqWS6MJpa0OYSzIqU6ZBBPIHxQwXkqqocM/hG6NOpcDLELhZCPMprDZXxPaLkF9gABpQqiiMOtR5fhUVMu8Jc/ihmQDN8eGpRMa9MFMXLK5b7m5kt59dWZSjnieHpvYazkZvXt/w1nYRC0542Q5KOLpKAVbPabMSIyQ+r59mTGs6fIaiGaT7vx+ynHX8apNfCYZoKadRkG7uNN/yBORjg4puTiD5a+8ZizbNVmSzKidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VJVlWjokNj9YL4b5FZ1N0lu8pboEnkGLEhAB6BouWs=;
 b=Ps7w59mvHp57GwjcqI8LWUf0V2DeK+2xXbx/FdOGFHm/YJ3FjCbYpwH+zivRvKBA3+dAGc8BOgDrghvmR2ZpjkxXSYx40DAROHgTziatecVjvyYh/cU/ce4hcJBytKqZbE255lxxWCIZMYOy9bqgw89LXXcHQlJ68CHy9L7E2xXmOviy4ln4r9N1aRPVxRj8X7E+MwBX3g9gWaU1KAK2uw8bZQwrNc+8kZfUmo/LhlJo1Z70nwQ5KOjPEIqH4YKiSCrSQWcEJ5HDdtgQSaou3W5Pqk/uY6tGK07tX0NtQ4Uz44ENPTh/dmTtHBRfGtU1BiPgPMMmF3qV1JEY4Fv3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VJVlWjokNj9YL4b5FZ1N0lu8pboEnkGLEhAB6BouWs=;
 b=gFiI7m0z7/l0IuaaGc77o2EGLPmO/nJsaWnw4Qy+BAISqP3dOeuT0cnyGTWWqvHkuicL7zfTb/Qwxsx0g0G+cIA0Vf/q8688QvDNrHWB/s6XE6k7NGeaku80dfGFPU65WXvTq5jNQKyXjgidBYbXISkpG/V+N6UdmWLlAhU7zJw=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:38 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::65) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:37 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:34 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/23] drm/amd/display: Block subvp if center timing is in use
Date: Fri, 9 Dec 2022 11:36:43 -0500
Message-ID: <20221209163647.25704-20-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|CO6PR12MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3baf37-adb4-413a-5ec0-08dada03aebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 368Z7YU8di4qmEJtn7J+LIXCpTTvf3ebd68FRsLI9i2dtvmEclb6TxVOgFgikh2svw7ryIBTEpqZfbdt3nW2INyv2DpHKCPWcdck7tUqbu3qVGGyJ48n7ypFFiCN8jkpiUDmbPBvfLRKHvDnMCfAnJwAFH6f+8U1SBYGDsQN6JwWtdgwdeUiI+soJYuoFnQEoYtH1V4cODZfDIR+eWr0ILmlCiSMUcfHBwQKUtvAdDvA74CAi/1ezbO1MyrS2FErtN0eEbx4X9emU9bV3JSnBLXOvvpFNvt8Cxj11+TakiEUK5eZvtnu4wZaFu2IYRIcYn3suZOBLZbm/3EwYY6fv2p1NA0Iz7e1e74C8+WNvBtMjjwAd+MvSb364Luns4+AiqyMeYFZylatLdavbhxFv4rRfjiLhLvzeF6xGdc9RRibZwSWNYgT8jcHeYGh2d8j0noHcRQPDcuYm6dCG7+Gf+bhIKbXYkLPLdpRJkCbbx55b/qFQQ7mSuT59MQZrxfhHJhV4C1EoByA/m7A7iGGTW79Ey8kJkLL+zLOOSIeH/jphfAFXmfR1dt0oIa6m0cPD4gCxN9OTSWxmqNGSESrj7zY2ALPwXGnqJsWbj2S0kHLuYT9LV8hlN9DJF+KZspIx1ahHSZDEZjdqmpeREcyvizfM1L+Yj68NnyofHzbgyqP7hxQU/VFYWxTb32XRv3ebKEV0l1MiS/AzTBqSUVhIR+ImjYDavHPr79axFH0x8HQkv1gbVTarsyE34rPDe0h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(336012)(4326008)(8676002)(83380400001)(8936002)(5660300002)(82310400005)(36756003)(426003)(26005)(47076005)(36860700001)(2906002)(16526019)(6916009)(186003)(54906003)(316002)(1076003)(82740400003)(70586007)(81166007)(70206006)(40480700001)(41300700001)(6666004)(356005)(478600001)(40460700003)(2616005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:37.6278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3baf37-adb4-413a-5ec0-08dada03aebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- FW scheduling algorithm doesn't take into account of it's
  a center timing
- This affects where the subvp mclk switch can be scheduled
  (prevents HUBP vline interrupt from coming in if scheduled
  incorrectly)
- Block subvp center timing cases for now

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.h   |  1 +
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c   | 13 +++++++++++++
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c    |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 13fbc574910b..57ce1d670abe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -112,6 +112,7 @@ bool dcn32_subvp_in_use(struct dc *dc,
 bool dcn32_mpo_in_use(struct dc_state *context);
 
 bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
+bool dcn32_is_center_timing(struct pipe_ctx *pipe);
 
 struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 		struct dc_state *state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 04fca788c50b..e5287e5f66d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -255,6 +255,19 @@ bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context)
 	return false;
 }
 
+bool dcn32_is_center_timing(struct pipe_ctx *pipe)
+{
+	bool is_center_timing = false;
+
+	if (pipe->stream) {
+		if (pipe->stream->timing.v_addressable != pipe->stream->dst.height ||
+				pipe->stream->timing.v_addressable != pipe->stream->src.height) {
+			is_center_timing = true;
+		}
+	}
+	return is_center_timing;
+}
+
 /**
  * *******************************************************************************************
  * dcn32_determine_det_override: Determine DET allocation for each pipe
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 13e5542a7028..e7459fd50bf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -691,7 +691,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 *   to combine this with SubVP can cause issues with the scheduling).
 		 * - Not TMZ surface
 		 */
-		if (pipe->plane_state && !pipe->top_pipe &&
+		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
 				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 && !pipe->plane_state->address.tmz_surface &&
 				vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
 			while (pipe) {
-- 
2.34.1

