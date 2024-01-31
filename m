Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFBDC47DDB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 03:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F441138BD;
	Wed, 31 Jan 2024 03:05:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26451138BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 03:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhfe7lLdW8gFeKIkx4nBj8aixbHHHJnj44JNPFM4/IIa2bX6fDIZgP+H+07s1Dkkw5NexoYCtSKZpf5y78/KjzBhF/NZIZQuzUny4rP9S/KeYQTqLxceEbEok6nt7dIqgAJLSYDp/j3hY7OXHgMZNmgd3M2k/Etz3Jdq5Gng4j36tGcdwfEwB9etXlF2uSwEQh6PXCDonL5nISG3TDZdn0YYRUxphPGzx8azgbXzZcGasDfX8SzPtszp2jvobGif6S1pEMoc4P186hnQQOl3L431mBVBpfQD+VBTJ3Qu3MC3agBzQp+eGk8UB5kLj6O6dIMQc6u8bHO0V6fZEIAmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyIo4R/4lYXmUdjs/ZoCjklDFffNu9YB4Zr8i7StLXY=;
 b=P+2eAqGqnEgaq+W7CYRCAhz1ZVfpVa8v9ELLowJHkcvBO4C9eZAzzGHZAG6/AVddPObFtKoy+turdLPT30FuImNaAsev05Usrmir6LZt4pFUOnY+nh7Q63VTFmPxXfL1oPBz07n9DXlHijzeVrQfAAx33Vw3soKHWV2UTxP2VkqcsXO0exeBv0w0ro2tLMHfEsPbMVLm2DDlfG/c+e0gFSwVoeqzj1Z/jwxuGKEVgHswhFsasA3fQ4z27nXH16evJ6R5s32n7O4ZT2WbiT+Ar6rLnxSv9fpStcW9Id8Us2Fmg9HQJwh3ZwDLriGeYPOzeEK7BCFcgVg4IzRLEidwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyIo4R/4lYXmUdjs/ZoCjklDFffNu9YB4Zr8i7StLXY=;
 b=sxPAy3BpgcKlX6bKNoff0+q1vBQI4C0FQdK240t3mQSx2GptxjRFWrOttlUKdTOMVhHYj8qusruHEfH3KMDHeH0lX5gjRKhi7PEmBaF0AERwFOjBmUX//MRkaeSb9h43tDc51gKdKLWJpN0/pNijryDAr7ETLo+RvEr+pJhB8TI=
Received: from BN7PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:20::44)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 03:04:49 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::30) by BN7PR02CA0031.outlook.office365.com
 (2603:10b6:408:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 03:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 03:04:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 30 Jan 2024 21:04:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix 'panel_cntl' could be null in
 'dcn21_set_backlight_level()'
Date: Wed, 31 Jan 2024 08:34:12 +0530
Message-ID: <20240131030412.692179-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127133909.1978795-1-srinivasan.shanmugam@amd.com>
References: <20240127133909.1978795-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: e64ac47c-68c0-4f21-8657-08dc220962ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km0vtvpzQ58PGdTIDkb2/LRoZA8y+3zEUmLTTVtRLZovoB+y7nEFgw5CbyhWG93qxNiJFZKCO/WPNeW+bItsvtvcVLcFvlk2mp4fvkyRPMk5+Sk3Di4tr4FGmEAxLxfeVLdK9A7kD6LEZE6Ha/GQGgdkWecwQ8KKnxyc3taV9K/Bjq9m4fkxSLGdcKdL3J8OcdUkXwIawn4w3vLgoPHYNjCNrLs1pUKshFxOb52JooBvrP1Nlx9K8I1QUbdH0JRKcIGoxl5HOr10uZcOuYKRJPOpO9R4au2pJkMqcZemDkg98Kz22K+AlgUo5V0SAf3WNNfpGhm6z434D3TvMLG1HkYU2oUTPGKJYADy9thrpvzq6LdcoDyYgbR0Ch1aacue8UcTZ8BjqZJq+ssDRppX4bnfz2iWihVoP/WYa4S7OWsS6WYJH0uneTJ6snew29JV/gy8GciEHHYHhl4HiGQxTkd0ZwGgqIqjPjKJcNnsWOKN5tTTO/BbunUkl/nWir0BsMiaKPJrNtwTHoRjxIylZIl4pEi0vTLQZhMFfb/HGDB0ewMgxihNygxSJWOtqAOPFT6uLu4d5LzcWZCp3R4oGszmL2BfFdfjsc44t3vWkf37IzSRkhsx6x7omYdr29T1IjiK7ifF+ftv2op0w4VKmWSbIsoYW4v8ZWxaWIahfLoMLopcvhTPYERJYjJ+Ncq6CyyTeL6lJyoIowshoOKE0jCEVRvzO0aFIZBUdY4jeldciN/otlSbSoYUzHtwx23ckhyS6l3sEcSuzCLEP174rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(36840700001)(46966006)(40470700004)(6636002)(8676002)(110136005)(8936002)(4326008)(86362001)(44832011)(5660300002)(70206006)(2906002)(54906003)(70586007)(316002)(47076005)(6666004)(36756003)(36860700001)(82740400003)(81166007)(356005)(7696005)(478600001)(83380400001)(26005)(16526019)(1076003)(336012)(426003)(41300700001)(40480700001)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:04:48.9148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64ac47c-68c0-4f21-8657-08dc220962ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'panel_cntl' structure used to control the display panel could be null,
dereferencing it could lead to a null pointer access.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn21/dcn21_hwseq.c:269 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 250)

Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm call backs.")
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Add NULL check for timing generator also which controls CRTC (Anthony)

 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8e88dcaf88f5..5d2d8fd64d98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -237,34 +237,35 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	u32 otg_inst;
+
+	if (!abm && !tg && !panel_cntl)
+		return false;
+
+	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
 		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
 		return true;
 	}
 
-	if (abm != NULL) {
-		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
-
-		if (abm && panel_cntl) {
-			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm,
-						otg_inst,
-						SET_ABM_PIPE_NORMAL,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-			} else {
-					dmub_abm_set_pipe(abm,
-							otg_inst,
-							SET_ABM_PIPE_NORMAL,
-							panel_cntl->inst,
-							panel_cntl->pwrseq_inst);
-			}
-		}
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
+	} else {
+		dmub_abm_set_pipe(abm,
+				  otg_inst,
+				  SET_ABM_PIPE_NORMAL,
+				  panel_cntl->inst,
+				  panel_cntl->pwrseq_inst);
 	}
 
-	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+	if (abm->funcs && abm->funcs->set_backlight_level_pwm)
 		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
 			frame_ramp, 0, panel_cntl->inst);
 	else
-- 
2.34.1

