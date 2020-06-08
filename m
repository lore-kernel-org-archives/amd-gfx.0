Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D1C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F5B20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xaHcIkpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F5B20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC686E486;
	Mon,  8 Jun 2020 04:59:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202216E484
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kml1nbeKx+ALvvhH6V+KVz/OAu9hNnAvhjB0yx0RpVhKXahj5wZe1IMhhOS20dvkIPvWx0tyEuocdnq2BAg513qwkJOCsavGrVMFtewYKt6oQ+hfAD2z6V+c1cBFtAzm335U7WkEWaxH2faCKhNsZChg6UjPManBEY0ZFaP4sDBhP+YbGZ3A1nhYs8g8ggU/7sI578EY8Lm/E/puNq4qg9kJrN/trIS9HZ4d0j6eitAe9eOxTg9kb/BLoIIcjUEUbIFbL4+5Brw+9+XqmbjK1l1Ob7jMZqbHN+MOXRTd1wjtURRsSiQDNGUNqsI+2bGF3o9NaUDqkTD4+YFHKAVVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr6TrtKL6mB/xqkrfgN3CYniizAOzYO6Cx3OVLEuI70=;
 b=MEfgnaP+dTPsa2Zc9yg+COExQ87K5yM4zMqnAkKsp8Bo7/t3qjX/UFyE8hQtoVVvSBeck8GXUpbDOTTQ39XjfrOqXwkQljG6wEvJW9GIf2QiAmxHJkh4bfdmAyMYFhMYgOY9vUviai0wQWX9VNXA5DzgFM3gcxv7fODW9hR3O7UV97PPpkhqRaLpa/jWSrKo/9qWD+O+l/SsFvzNZKJ7v9ZY980fA5X9J64bVLyQDzP5qA8HJRTHSAPZLELYd6/NotuHGbUNg+3wf1B4NjbnkmjMy0Gj7b4IswHCFeBjTuzlMrZ8SYgyJ82rzcxgzExNpl02IImgfL+SuRbeVSRG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr6TrtKL6mB/xqkrfgN3CYniizAOzYO6Cx3OVLEuI70=;
 b=xaHcIkpOhxHojDqGCCworO/hlZf8bHVs4ji2tpD2CaouV2COH+nr9y7DYbdRRD4qxMHLEC9/v/N1iCFvD3XOlgK2bOA/cB+fmlQDYeiKBKXFJ8eS/2RJmAmmTGazbMuzi71crPiZ54iTjwJkahuo1M64ZJLIYSZ0Q0pDOnB7kco=
Received: from DM6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:5:190::32)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:36 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c2) by DM6PR11CA0019.outlook.office365.com
 (2603:10b6:5:190::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:34 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:34 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:33 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/28] drm/amd/display: update audio wall clock programming
Date: Mon, 8 Jun 2020 00:59:08 -0400
Message-ID: <20200608045926.17197-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(81166007)(82310400002)(356005)(478600001)(4326008)(47076004)(82740400003)(8676002)(8936002)(83380400001)(1076003)(426003)(44832011)(2616005)(336012)(86362001)(2906002)(54906003)(186003)(5660300002)(26005)(316002)(6666004)(70586007)(70206006)(36756003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ded654-73f1-45b6-58f3-08d80b68bdd3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4425:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4425EBC5A61ACD8F6990A7C9FB850@MW3PR12MB4425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4gMx8pe/b9VQE0Qp3xgUIBePheQbIDcsUH4JnEcwQdl9vt0xzQAG42P2C8Kr6tTQCddh8AE0LSlygmpJQNvCUDj+pUkmcImJl1mxcE5hlB3VRNALZhJUBybJPQIEZWNxarJ2vQ7+qC6yPau0rwcM4TeTKEW2wRRMVRTS2i1RVj1K52wteMTICqtFudPghK9kk9DxvC7An2hEhpQQdr7DK4fJS/Wi7gwgGfsF/ETjP1+YPqJ5WCivASpb6O2azBdohfOEHtYjPcLzOzhCQ51Y6cNiiEnnlKpF/44ltDZcViAAjojBPDQ+kcA/Zn63a+g/5bwns7YRaEiTtuPZ5wME/Ec8t6QlT3Msa99tGuWc4AqfzADx4LyTJK+dLSsmb5fuXDadd9cy7KAHzrOSaTJDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:36.1344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ded654-73f1-45b6-58f3-08d80b68bdd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
for audio on real TV issue.

[how]
-add wall clock programming for DPREF based when
Pixel clock is done by DP DTO.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c              | 4 +++-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 +---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 5a35495bc11d..408046579712 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -140,6 +140,8 @@ static void check_audio_bandwidth_hdmi(
 	bool limit_freq_to_88_2_khz = false;
 	bool limit_freq_to_96_khz = false;
 	bool limit_freq_to_174_4_khz = false;
+	if (!crtc_info)
+		return;
 
 	/* For two channels supported return whatever sink support,unmodified*/
 	if (channel_count > 2) {
@@ -784,7 +786,7 @@ void dce_aud_wall_dto_setup(
 
 	struct azalia_clock_info clock_info = { 0 };
 
-	if (dc_is_hdmi_signal(signal)) {
+	if (dc_is_hdmi_tmds_signal(signal)) {
 		uint32_t src_sel;
 
 		/*DTO0 Programming goal:
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 2ec5e9e1bdc6..0ce430cf4dd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1148,7 +1148,7 @@ static void build_audio_output(
 			pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz;
 
 /*for HDMI, audio ACR is with deep color ratio factor*/
-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) &&
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) &&
 		audio_output->crtc_info.requested_pixel_clock_100Hz ==
 				(stream->timing.pix_clk_100hz)) {
 		if (pipe_ctx->stream_res.pix_clk_params.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
@@ -1963,10 +1963,8 @@ static void dce110_setup_audio_dto(
 
 		if (pipe_ctx->top_pipe)
 			continue;
-
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
-
 		if (pipe_ctx->stream_res.audio != NULL) {
 			struct audio_output audio_output;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
