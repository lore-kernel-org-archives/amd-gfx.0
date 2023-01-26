Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C453C61D97
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD33F10E3BA;
	Thu, 26 Jan 2023 00:34:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D5F10E3BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihjm6cq6wGXa1G17aQ84IzACQh+tIWImAWSAH9raWKkfVYwOG4yNtyQ2V+fRQIZ/yyi0FLafDKtETviDRJ5ZGJwdAtsroQrB8wzXT36P4B65NsVisupqXVhukuysojy2ilXQLKpY4uAizkCwzKXzdupXcpatMislA3FI3foLeTC5iHoGuUo49dE5rT8/ZOzYHN/9F64CS8tJl5upmx6lH7kdzJrqCIsyTJsKAbDebGWfSTGLSkX/LO7Lo9nOASbv51aXuSUxshz2qBKl5ZTZcqKworzH95vD70MEmpRHkS3qO85GnlJiluWzKODi352WT0INTzFJZIMHKUOgXd6QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+5E5XSWWuIlD8UmmxFsBBZyyvPHUeXJpHSVq+IyfwE=;
 b=cnH6VV8cVeLho4y8CIuZOC/f53VHEAFE8sBKsogGir5j4Vecsv+pb1dZNp6QOie3j4MVntNkKgg2KIdXSzScO7WBu1iYow/IHhOj1UYZ8nP9eyQ9Xx59wkzUxMS9419J59wdtQ5uJ7HZATajuTN+dPLyNydk7IqNMyl/0PblQTQlzIeUQRuxrxojyKkK5D1Ad//brmIdG8NXK4n0yPP6d5c3oGI70Iv9KQpP/8DUITJxetTT0H36lKEAYAqObRt7R37o7NRDsb9wp1laVqbXJ9IQ7L+x5pC/2FSmPIbeM5DrT2S4VXXpoTf9OAF2H6a5rNR7/PopmqvZO45lAJGT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+5E5XSWWuIlD8UmmxFsBBZyyvPHUeXJpHSVq+IyfwE=;
 b=wIP4sNhFL3UWBTFSOW9zyOXC2KwpBepGSwh2UAYxSboTm3vmLePb6owbl1gfuu5REHoVcDNKu/Ft6njgPZf5rrY/T3jqElvu/xMQGLIl7rhDVR1IXLvG4noEFIg6UpT19niclyA4mIZx18DG3aygqk12ZPadDQMJmDGUVWo/fO0=
Received: from DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:34:40 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e6) by DM6PR17CA0021.outlook.office365.com
 (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Thu, 26 Jan 2023 00:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 26 Jan 2023 00:34:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:34:36 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Fix Z8 support configurations
Date: Wed, 25 Jan 2023 17:32:19 -0700
Message-ID: <20230126003230.4178466-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 04897148-f2b4-4845-d666-08daff351c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sO2i96raAZaXF2Q++Z+BaU5p0wpanMeIqTzkCdORG5rco7iPnpks19Oz8zIdT36PKfsgSSonszPkU0qFCb8+mSZKTkvGtkQasBaYzUb1MA1FBozMR7AfoKsbdnhsOJ+hSqpu476xh38Fofg8HGtpwvlymBqIy2j+fG1arYukPCHGZwzRr13EOeYWTLo1vFEECzvO3Mkb5ohcJ2AU9udxy1eKCZew/sp2DliSmLpv0SgNeF87Kd2Wi+rwOJkRvhNNbFCM1rEFyvc4m3VXBXfFeBzJmKyyjd0dGfW+1cBp1S9kMs9+zROj9g+k7Udr156OW675kUsMogpKKb8/ZDgJeW27cw5/dsywMqn5ESQKuYwiaHwihJD0mXimctu/1vTRYLyPDRxAHWLkTvCAJikBZ3+Uq1z/FyqQu9tjUcDriZlGml3E40dAtNar2Zv97rsOGVXScuxeHCWFu6iwcVRzV/bHweD1hnPpRya7m4Mj7dO/BkM477i2i7VUBK25UmnR09UVPedwNERnZDkM6ChJZnL4q5D1xypPhIzKwRuTtRkhRoONdVuPgt6PyPSOFjY4i4fIRR/d16c+StSJv+GR/yFH/I8nDyk6ylhSm+IohTOJLs5rbyE/vfXUPseQPN1aXliPYv+xstnvYnP7BY1IGOiAacXijKvNmWcSP2qw9rjy4WHwSa53l6GBy/w4aI9XroeF899Fjwk65FJDXT0Hyo6bs8MSjDfy2AA5HoOvYUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(336012)(16526019)(86362001)(6666004)(26005)(478600001)(1076003)(186003)(82310400005)(36860700001)(4326008)(2906002)(83380400001)(40480700001)(81166007)(356005)(54906003)(47076005)(6916009)(82740400003)(70206006)(8676002)(426003)(70586007)(40460700003)(44832011)(7696005)(316002)(5660300002)(2616005)(8936002)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:34:39.8712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04897148-f2b4-4845-d666-08daff351c4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
It's not supported in multi-display, but it is supported in 2nd eDP
screen only.

[How]
Remove multi display support, restrict number of planes for all
z-states support, but still allow Z8 if we're not using PWRSEQ0.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 197df404761a..d3ba65efe1d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -949,7 +949,6 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	int plane_count;
 	int i;
 	unsigned int optimized_min_dst_y_next_start_us;
-	bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
 
 	plane_count = 0;
 	optimized_min_dst_y_next_start_us = 0;
@@ -974,6 +973,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
+		bool is_pwrseq0 = link->link_index == 0;
 
 		if (dc_extended_blank_supported(dc)) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -986,18 +987,17 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 				}
 			}
 		}
-		/* zstate only supported on PWRSEQ0  and when there's <2 planes*/
-		if (link->link_index != 0 || stream_status->plane_count > 1)
+
+		/* Don't support multi-plane configurations */
+		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
+		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY : DCN_ZSTATE_SUPPORT_DISALLOW;
-	} else if (allow_z8) {
-		return DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
 	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
 	}
-- 
2.39.1

