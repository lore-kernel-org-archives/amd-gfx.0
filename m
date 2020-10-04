Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC0C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DB4206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u1WHMLxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DB4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3EE89E05;
	Sun,  4 Oct 2020 17:19:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A4889E05
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnWMbgH5u3QlB8Y61F5mXnPWrPI4QC7sJdpYRmV67Jv6gbwL7qW2LTLD4H2TeKslHh4v4wR/AnGMn9dvP4PtndCdjRKes38cluZaslfsHhcVjgDC1qPGy8g1A20RM9Gv6raSWZD9TkNIE7Mk2SZjcsOqy5N0QxzhBypIc8XoFxOAsn5J98yDt23HZdX2syDuYPh13uvSWu5wNDbVl7hYlncxUssdLThRSMDIGLzWXfmjwtcsa1KwoaqlX3JpYOFTmPll6qYA8p/xGC/lSE3zzwNigTvQXhg2t1900OGMSUYFahyEy21LRKs+DRtVNU9jvrdGLycJuDVi/008vDDGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q27irr8vlJxDFuUnFexbko0NGSfeRmXoYh0sxcQu1G0=;
 b=C1fpEhTqfNurupMyFmmSjKW9moAlQyiKc76EI7EaaGnwm9YsytU59vRnABse+cBAMNXriwbIhRpaKSFYk8K6DXGrDwCWbvOEn1Rn2ablGPRIjZDK4CbpHez7LhhnJ2MGbbSQ7EmksMBY1wfMyWs0VPh5U4HYLfy9RZMC+Sd/gMCCxyTGexg7fJoXDRerBoKmquHCDSFMJrjliP97alCelLOWi0oAXG1TOwTEYulR2lXMaf9id4lzha9DmKxDI7pv8TvL0rNhkAgdMsT4vNgo5EI8mnZ8oZxRk873kAIW7/u6w6bw35eoYdXfzeGb7Qv4FzGSXdhDvKYjm5fazBVpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q27irr8vlJxDFuUnFexbko0NGSfeRmXoYh0sxcQu1G0=;
 b=u1WHMLxX27dsib/SSDOzR3T7J5wYpI7XhAzfIdRjp8qvUktDrU9XDQ5emFDfNjGcdsG+ohAIMFDxuqFMc4pEIW0bCBzjpa3qEoRCWx0Stb5iQ5cqS3WvDeZS7KiViSJWAnSwJ5ffvF3YkkZTFIRboSGZ1cmc+HdJjNC0LxLYj9Y=
Received: from MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15) by
 MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35; Sun, 4 Oct 2020 17:19:31 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::53) by MW2PR16CA0002.outlook.office365.com
 (2603:10b6:907::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:29 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:29 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:23 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/18] drm/amd/display: Copy WM values from set A to other
 sets in hw_init
Date: Sun, 4 Oct 2020 13:18:02 -0400
Message-ID: <20201004171813.7819-8-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0ca33a2-8f56-4753-3909-08d86889a7e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2941B4F46547772C4729BB95E50F0@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyGjx6ZC9K4R/woS+YoeXe1a4JeQ9pPBqEUjFEIId1w1JtYDjR0YicURJh4NXqMd2rCkQx5HMJe81Pg0U1HiUGxAP5UmBPXMeOjN2Q5wB5dkDwQRL71AKrKst4YnfB/6A9U7A8HGGuZOIMQmMAYlKvYvdZRQezBZVp53t6GNWijP6AxgUATggG12hackUHT7ylXGiefAd8oUXBKKDb9zbGr5lfjPQ3pnOTDhllWU1fuOacXuz8nkiDswXI8bbJp27r4cI66Fmr39w/xvkZgcX9iC/SNK/92WiuyRfYL9MTolq2HCkJj0nHLaEFI//IQSCaPvWOVA1nZdMfwTKZkXaD9jylqcCVO5Qp5qwTYIeB8sKwvmHo3nZQpFkAb+E7ELCyuEb1lEO7DykaPWIqZkFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(136003)(376002)(46966005)(1076003)(70206006)(70586007)(8676002)(356005)(81166007)(54906003)(82310400003)(316002)(26005)(6916009)(5660300002)(86362001)(36756003)(2906002)(478600001)(426003)(186003)(4326008)(2616005)(336012)(8936002)(83380400001)(44832011)(47076004)(82740400003)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:30.7404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ca33a2-8f56-4753-3909-08d86889a7e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk
 Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
When we transfer the WM range table to SMU, they can perform a watermark
switch right away. This can be a problem if we're in not in accelerated mode
during hw_init as SMU may initiate a dummy p-state change before the rest
of the watermarks are programmed. Watermark set A is defined to be
sufficient for all cases, so we can copy the values from set A to all other
sets, avoiding any issues from SMU doing WM switches.

[How]
 - new hubbub func init_watermarks
 - copy register values from set A to all other sets
 - call init_watermarks before calling notify_wm_ranges

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   | 43 +++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   |  2 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 3 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
index 2c68a246fa83..c0980da6dc49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
@@ -394,6 +394,48 @@ void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, force);
 }
 
+/* Copy values from WM set A to all other sets */
+void hubbub3_init_watermarks(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t reg;
+
+	reg = REG_READ(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A);
+	REG_WRITE(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, reg);
+}
+
 static const struct hubbub_funcs hubbub30_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
@@ -408,6 +450,7 @@ static const struct hubbub_funcs hubbub30_funcs = {
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
+	.init_watermarks = hubbub3_init_watermarks,
 };
 
 void hubbub3_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
index 38f1d2fd939b..c0bd0fb09455 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
@@ -119,4 +119,6 @@ bool hubbub3_program_watermarks(
 void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
 		bool force, bool allow);
 
+void hubbub3_init_watermarks(struct hubbub *hubbub);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 371da657c8a4..bf4d6190dd00 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -155,6 +155,8 @@ struct hubbub_funcs {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 
 	void (*force_pstate_change_control)(struct hubbub *hubbub, bool force, bool allow);
+
+	void (*init_watermarks)(struct hubbub *hubbub);
 #endif
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
