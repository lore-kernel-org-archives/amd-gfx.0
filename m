Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2171C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990D264F95
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990D264F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDD76F509;
	Fri,  5 Feb 2021 22:03:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D9E6F507
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm+U9xtgBVG4H7OAWDy5MOBkvzeqmuLbrznbGM6S7zUWY62ZIQ7OKkdrLm9dBIRrzJzD6NP4/7vkZmIeLyeC9Cl0R4G/Bx+jyTzkcr75lBj40n7dntX/SPM6cP9CA48EkER9nxPHaBnis05bgARgUUv845FKHnhcXjcQOmP+zLWd8OUNjwgQuUc7sE4J4DXoqBZ22vSzLO/v2Jea4sD+pN1wG8Fs1HtXKScQK8VATrrztz+hwL+vp8KhkIJyQVUdGv+EKQ4BHQlOTR0UMuiLErUfZgp40+Rpgflx4sxvusr6hBPcgGdrH+VKu/UuNA2HlH6tRaIfQs+1Otazyag1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6SEXR1HPq1cLPccz1IAjtqxtiXFptLRTOntI0MA4i4=;
 b=R79t1BvHYJ19YVkDtAKIAF84ylPXBLNW7z8/ea4kx4552JhgEDM+PMdElxhbnKXFC0/WXb9Pd61quXe8VsL9yX8XOCEffyh0uLa+2Q3sAnMDqwNeklknKLWmDqIpBYMTVPztjrzAa8SAiFxtFdwknNbhNuHVdhKTBADshFPooze/CCWZTqA+EXYO3ABZSEVEkuG9ZWZN2wnCjQ+R4hlPxmOdlozxs/WPyuYc1FkfFkuC774Q5irPA8xZX7Hh9hwohPUOu7BetVDOnvQTtifAghPhto94r54nyT6r3d01DE6cAAzTM7htmzyg0VSayh1CMit5xZMSHOFDowrV/wbd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6SEXR1HPq1cLPccz1IAjtqxtiXFptLRTOntI0MA4i4=;
 b=oOxoT8ZoCtULuhadwzP81MHxUsdKT6uUWELcYPuKTssLdK1t/JVm5NMZLuoskNn77LQ7LLArDITzi+vC6PUK5inwFGViM7wq5FKfcfaFsKZ3+XXegF0pqzcwmQvVSNdikQ6iA1eFEHZ4iyspNluLHfZS3RcXdx9j3z/yDbsWDsE=
Received: from CO2PR05CA0092.namprd05.prod.outlook.com (2603:10b6:104:1::18)
 by CH2PR12MB4840.namprd12.prod.outlook.com (2603:10b6:610:c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 22:03:19 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::ee) by CO2PR05CA0092.outlook.office365.com
 (2603:10b6:104:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:12 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:11 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amd/display: DIO Supported for virtual displays
Date: Fri, 5 Feb 2021 17:02:47 -0500
Message-ID: <20210205220250.1871069-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db293937-c6c0-48ad-16fd-08d8ca21d7fa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4840EDCFD29F2110B13C7830EBB29@CH2PR12MB4840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTN4EzYJxLUtUYLPPnsmDYgHDBQ1v9jZe5uau1VkYtcJtklyWjGo/Ic24epkzZhNZMTZ9lAl6HEplUugzDX/QqzsmrC1Vh89WjI4p0vIAwt/j1GdBQfra6nSYjqohPqaURIW3AWZZq/BmgXIVBdyr0oxqRpDJlNzd2npxo3H1GjuGWefUUY72clZCAYlW155BDAvcr8kaGOr1g+TOCx7cJ5U74fsGoUg2yQHW14pDJOf7OikNhp3TeUUFBERoNfcBthn58LzFqauVjCfJUbIW8VCpMFcuiCoSS5+X62crlesrhOI3pZ29dyT68g8/7wP17ksXMp+OrU4BQEQbffvlIcWBE3OCWmaWYen0ye1id/nNqKJtkR0EvBOJiFAfCT6XOvSJ93gxrGf9EquLvYKTYtPsBdSxQJfEkDmeVUBob8oDSVG+467DrPikzUQ2TfWAfFZrjYY9zq1P5jkTLrPLaevr2fD50IoBgvINQOO8aZCqGLEuB9ChU9gTttI9fV3T9gUrpGLfN/vWbKJb6kYtK1twiPD/P3bIXLF2q3Jdki3Vk4ozCIY3vx8VCl1hbgY+vqADGRGhYiDrgAn/FavttPAnS098kqxUVDuLZ/9eJd9GsaoSegiombpRxrx09ECWJKqcHbpliG0g6MLBUIBYaCYj0bmpog98EJc+LMmcd/5vwmk/qoO268lydCei8YoR5DumghhA8z0JBecsM42Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(8676002)(2906002)(5660300002)(36756003)(81166007)(70206006)(186003)(70586007)(36860700001)(83380400001)(4326008)(54906003)(8936002)(6666004)(82740400003)(356005)(316002)(86362001)(26005)(478600001)(7696005)(1076003)(47076005)(336012)(2616005)(426003)(6916009)(82310400003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:17.7498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db293937-c6c0-48ad-16fd-08d8ca21d7fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
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
Cc: Chris Park <Chris.Park@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Virtual displays do not use the backend of the pipe, and so have
infinite backend bandwidth.

[HOW]
Add a skip_dio_check bool to the VBA struct, which is used to override
the DIOSupport calculations.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Acked-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c      | 2 ++
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c | 7 ++++---
 .../drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c   | 7 ++++---
 .../gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c | 7 ++++---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h  | 1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c      | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h      | 1 +
 8 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 6505373483bb..a0a4ab47a1c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2097,6 +2097,7 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].pipe.dest.pixel_rate_mhz *= 2;
 		pipes[pipe_cnt].pipe.dest.otg_inst = res_ctx->pipe_ctx[i].stream_res.tg->inst;
 		pipes[pipe_cnt].dout.dp_lanes = 4;
+		pipes[pipe_cnt].dout.is_virtual = 0;
 		pipes[pipe_cnt].pipe.dest.vtotal_min = res_ctx->pipe_ctx[i].stream->adjust.v_total_min;
 		pipes[pipe_cnt].pipe.dest.vtotal_max = res_ctx->pipe_ctx[i].stream->adjust.v_total_max;
 		switch (get_num_odm_splits(&res_ctx->pipe_ctx[i])) {
@@ -2150,6 +2151,7 @@ int dcn20_populate_dml_pipes_from_context(
 			break;
 		default:
 			/* In case there is no signal, set dp with 4 lanes to allow max config */
+			pipes[pipe_cnt].dout.is_virtual = 1;
 			pipes[pipe_cnt].dout.output_type = dm_dp;
 			pipes[pipe_cnt].dout.dp_lanes = 4;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index f33e3de08176..0f3f510fd83b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -4168,10 +4168,11 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
 		locals->DIOSupport[i] = true;
 		for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-			if (locals->OutputBppPerState[i][k] == BPP_INVALID
-					|| (mode_lib->vba.OutputFormat[k] == dm_420
+			if (!mode_lib->vba.skip_dio_check[k]
+					&& (locals->OutputBppPerState[i][k] == BPP_INVALID
+						|| (mode_lib->vba.OutputFormat[k] == dm_420
 							&& mode_lib->vba.Interlace[k] == true
-							&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true)) {
+							&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true))) {
 				locals->DIOSupport[i] = false;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 47e8e71113ee..210c96cd5b03 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -4289,10 +4289,11 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
 		locals->DIOSupport[i] = true;
 		for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-			if (locals->OutputBppPerState[i][k] == BPP_INVALID
-					|| (mode_lib->vba.OutputFormat[k] == dm_420
+			if (!mode_lib->vba.skip_dio_check[k]
+					&& (locals->OutputBppPerState[i][k] == BPP_INVALID
+						|| (mode_lib->vba.OutputFormat[k] == dm_420
 							&& mode_lib->vba.Interlace[k] == true
-							&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true)) {
+							&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true))) {
 				locals->DIOSupport[i] = false;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 0bcec113ecac..398210d1af34 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -4257,10 +4257,11 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
 		locals->DIOSupport[i] = true;
 		for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-			if (locals->OutputBppPerState[i][k] == BPP_INVALID
-					|| (mode_lib->vba.OutputFormat[k] == dm_420
+			if (!mode_lib->vba.skip_dio_check[k]
+					&& (locals->OutputBppPerState[i][k] == BPP_INVALID
+						|| (mode_lib->vba.OutputFormat[k] == dm_420
 							&& mode_lib->vba.Interlace[k] == true
-							&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true)) {
+							&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true))) {
 				locals->DIOSupport[i] = false;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 8fdb34aa70ff..bc07082c1357 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4263,7 +4263,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (i = 0; i < v->soc.num_states; i++) {
 		v->DIOSupport[i] = true;
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			if (v->BlendingAndTiming[k] == k && (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi)
+			if (!v->skip_dio_check[k] && v->BlendingAndTiming[k] == k && (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi)
 					&& (v->OutputBppPerState[i][k] == 0
 							|| (v->OutputFormat[k] == dm_420 && v->Interlace[k] == true && v->ProgressiveToInterlaceUnitInOPP == true))) {
 				v->DIOSupport[i] = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index dd0c3b1780d7..0c5128187e08 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -297,6 +297,7 @@ struct _vcs_dpi_display_output_params_st {
 	int num_active_wb;
 	int output_bpc;
 	int output_type;
+	int is_virtual;
 	int output_format;
 	int dsc_slices;
 	int max_audio_sample_rate;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index c9fbb33f05a3..bc0485a59018 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -451,6 +451,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 				dout->output_bpp;
 		mode_lib->vba.Output[mode_lib->vba.NumberOfActivePlanes] =
 				(enum output_encoder_class) (dout->output_type);
+		mode_lib->vba.skip_dio_check[mode_lib->vba.NumberOfActivePlanes] =
+				dout->is_virtual;
 
 		if (!dout->dsc_enable)
 			mode_lib->vba.ForcedOutputLinkBPP[mode_lib->vba.NumberOfActivePlanes] = dout->output_bpp;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 3529fedc4c52..025aa5bd8ea0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -340,6 +340,7 @@ struct vba_vars_st {
 	unsigned int DSCInputBitPerComponent[DC__NUM_DPP__MAX];
 	enum output_format_class OutputFormat[DC__NUM_DPP__MAX];
 	enum output_encoder_class Output[DC__NUM_DPP__MAX];
+	bool skip_dio_check[DC__NUM_DPP__MAX];
 	unsigned int BlendingAndTiming[DC__NUM_DPP__MAX];
 	bool SynchronizedVBlank;
 	unsigned int NumberOfCursors[DC__NUM_DPP__MAX];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
