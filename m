Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857EBC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C9A20720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ReKge4Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C9A20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE3A6FD08;
	Fri,  7 Feb 2020 15:50:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D296FD03
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsPAOzibEbnvaoMFvdwVWV7f7mx2FDPiSuKxEAAtUqQhqKyyhmNZobsbdSrp42an4QyAgbKRppOHM+MqjZ7Hi4SoegPpWC0Bn25pwo5vRoiuyrOCFcCI3mfUBT6HenTHOr9K4GzJShAL11qmelKlngyOjBg8VV8y+OfkSoCX3ufUqI/IZvEw0ugaJogQss1shUTnfVCNgx9S1prUXD+Cm43zOQfj9OFz+921pDlmoMp2IlBzh8mwWl7NUPpU2Rj5rEkZzTSTLscN0XpuFnEbNRedLaa41D2NBWDv75VLbKg5OAiHwfHR1fU67OD4kW1iRpUZRw6BlY0CPCE/a5E0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEanwbrc3ltspg2Hy0qW/95p6J2pLMpYOGxVpytxYJc=;
 b=kTklTqbDiTuz3H5WOoYgKdwdKz/DeLVj+8SXg2j2Fc0pRaR049Ie+29p7iOS1AENStrbN0/X4CCo3bZXgO5DQSbhskL5ocVFLcFOQsvoflVtyi7tFqKet/dMRoMFKzOOHI7qZSzSbL3TiZ8XirFpbppPiit6aIt0iYtjjvQw1ujEmaCDpIjif19X5s8vxfHXJ4/H9wIrlw3FJzdeWf2RK7O5iKqLs3jw2I6NyhogL9j+YfwEmr02WJDhlnImFxVZ7wWRN0gvY+jbPOwfeCkKOpty00ZpTbqEB8gymSslxee5L1i7Md7audvHvva+wtlZ2/hori3DKWBeul+4+MWzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEanwbrc3ltspg2Hy0qW/95p6J2pLMpYOGxVpytxYJc=;
 b=ReKge4QnkVo29ysa+cg7RI8bzBksDJpKqv9X4mw1S0SwDIUPqL4uEyYnFMT81EYSvLvQVHle/1+s2WSBO9eksXEbJ/Fkt1e7jfmhdGAzuwyhEBlM+PEOms1POiUTBq/77uv/A4WdudS8tebAehcmoKeB42KfAheJ7Zsu/8Igm0o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:44 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:43 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/17] drm/amd/display: Remove unused values from psr struct
Date: Fri,  7 Feb 2020 10:49:56 -0500
Message-Id: <20200207155010.1070737-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:42 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24a05519-538d-4778-4437-08d7abe57cfd
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24406A1552BDF1FAD8CAA0E4981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMPTM9VIhmZ7pdT5AXEmx6MbzNGW7mB7dCDmwBasblYUgZTJx6m/ZYWeCMb6mu9v1lpOYaMESOvF6524RRkmwy5477PVVAIg4pHZsy0k0PPxRTuEUzYhUpZpoWSfBMUQOS+0S0cK3Hg7+r4xOcAUyUmh+r1psQBOldP0/i67bVXEDq7MhSSlgsr7ufgeJ8DE8bPvBDw9wGsZmTlWS0bITiBEo3zlh9B6Xvz9l2PyWKJXHaLVoNbXc7vDvS1fhVZEgXMWvfS76OeEWgLNRDoOD7qC5h6j3/ZFP6nLV9i0le5HOdOZ8A/1JrRa4lxs+PH6M8TrSynXhESD1A8tl5u+YcUt23V5btg80wwzLHhYpQPALiNjGMvVZDxgzPwYnnxSnyt0vJPXXU+6N91DocI3vL1SE8C+3Fdubu5JgHoii2ar4flvbCCviSKUlor+51j9
X-MS-Exchange-AntiSpam-MessageData: kXFv7dxmBWkl3iQlPnk1pf6uBe23DXwds4GaARPHXPvKtvQhd002GN4w6804JLtwZQPB3Ma0BKEjPo6DxDd9vKo56e4O5PuJDafF9WCBs9WcnTbYqQ+rX9OW6cdStv06cMRIoWnHCCKi5P9E9ylRrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a05519-538d-4778-4437-08d7abe57cfd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:43.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahQUqXgnWTDQv7NkHSJ39KdO0nywjSJO5POja4RIW3Lq6zTa5uoDX3J2VRisssVmU4qevCUDyG0F/ceqICFq7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Taking up unnecessary space.

[How]
Remove unused values from psr struct.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   | 13 -------------
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 ----------
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index bdf80b09277e..59cdd8ea31fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -159,10 +159,6 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 
 	copy_settings_data->mpcc_inst				= pipe_ctx->plane_res.mpcc_inst;
 
-	if (pipe_ctx->plane_res.hubp)
-		copy_settings_data->hubp_inst			= pipe_ctx->plane_res.hubp->inst;
-	else
-		copy_settings_data->hubp_inst			= 0;
 	if (pipe_ctx->plane_res.dpp)
 		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
 	else
@@ -178,18 +174,9 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 
 	// Misc
 	copy_settings_data->psr_level				= psr_context->psr_level.u32all;
-	copy_settings_data->hyst_frames				= psr_context->timehyst_frames;
-	copy_settings_data->hyst_lines				= psr_context->hyst_lines;
-	copy_settings_data->phy_type				= psr_context->phyType;
-	copy_settings_data->aux_repeat				= psr_context->aux_repeats;
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
-	copy_settings_data->skip_wait_for_pll_lock		= psr_context->skipPsrWaitForPllLock;
 	copy_settings_data->frame_delay				= psr_context->frame_delay;
-	copy_settings_data->smu_phy_id				= psr_context->smuPhyId;
-	copy_settings_data->num_of_controllers			= psr_context->numberOfControllers;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
-	copy_settings_data->phy_num				= psr_context->frame_delay & 0x7;
-	copy_settings_data->link_rate				= psr_context->frame_delay & 0xF;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_copy_settings.header);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8f518e7d8b4e..0cb8967f0c45 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -216,7 +216,6 @@ struct dmub_rb_cmd_dpphy_init {
 
 struct dmub_cmd_psr_copy_settings_data {
 	uint16_t psr_level;
-	uint8_t hubp_inst;
 	uint8_t dpp_inst;
 	uint8_t mpcc_inst;
 	uint8_t opp_inst;
@@ -225,17 +224,8 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t digbe_inst;
 	uint8_t dpphy_inst;
 	uint8_t aux_inst;
-	uint8_t hyst_frames;
-	uint8_t hyst_lines;
-	uint8_t phy_num;
-	uint8_t phy_type;
-	uint8_t aux_repeat;
 	uint8_t smu_optimizations_en;
-	uint8_t skip_wait_for_pll_lock;
 	uint8_t frame_delay;
-	uint8_t smu_phy_id;
-	uint8_t num_of_controllers;
-	uint8_t link_rate;
 	uint8_t frame_cap_ind;
 };
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
