Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6844C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FC9112B9E;
	Fri, 10 Jun 2022 20:53:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1FC112C65
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ9gGTW/njq/wJ9tJAb52Xh+YYv4Zl87g9TTeozsia5+Vm6keb9RYXtzR5jfvtSE2jV30LMYPZJa7gELaHrI6zX4q+krf7E5TTHLopryrfNojo4wedf6dnRwL/CW2sNWEFdfa5iwsh5IycCM8R8ziORtOEo4oPluPCmcuYvAN6NaLf1J/c+fhTN7Ssn2lXQiGYTLGPkyTBixZPM0gA0M3OHO2t6+YTZzetmsFcy+zxu/nyYq/AW9usMUG0kfqxwZMy/Y841W+3qgYY2+kfz60aAlY5l5Cw8qLdYkkhIrRDdw5oZmHQ0d62j38s58Gho1E1l9GDtOveoy8A6VIe9FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw7aZrUIFON/TOq2d3V0LLixFIlgUX37rNzs3hPkz/c=;
 b=Uswc5pPxdiuXRvsLyk2pzoN3ZE+ymjg+LeYLU+j5axuxlV8+Y295ooZBTAahc2EoebcFsvMWjsUfckUvD+kpC4Bu/Sy6aIPl+G5+C8RECZyjvvfb+HY22ROJ3uP3r4z3x75DlzH1XLSyVaQ5tosjhVVsoze9peWZmk6qSHiuz4QGX3E2DXtBpVT12vKZIMeYCqMrGY8du0rAE9d3ZX1/L5md0ysEoSOpJb9GFFKj64oVPaFcgIL7oLryLsPEx+9oNr1wVru0WBKCIr5Ly3ac/Ph/lF1q1uwdlBlVWZsRIx/pe2F/ru6My1WbkfLrAiwxdbhknZw8wgjuWuAPh/piwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw7aZrUIFON/TOq2d3V0LLixFIlgUX37rNzs3hPkz/c=;
 b=Atsf5JR5YTWYegnBAgTvBfmiI9xZHTVUSwe7ZfR8f0k9tuiF62ZIVV+t5gpj8mP3BrpQ1A7Z5NGo5JVN/fTGpFoyKDkcafVhZFAA5D/7z2OuCbZwZ0yv1EjT9SojPcdRiPlAoZ8VErbDpJJjpJUbyiyQqw/jyIqQK9uigEsFurY=
Received: from MW4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:303:16d::7)
 by DM5PR12MB1401.namprd12.prod.outlook.com (2603:10b6:3:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 20:53:44 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::ca) by MW4PR02CA0028.outlook.office365.com
 (2603:10b6:303:16d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:41 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:37 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Date: Fri, 10 Jun 2022 16:52:42 -0400
Message-ID: <20220610205245.174802-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ada5959-4c1c-487d-f5a5-08da4b234d4b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1401:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1401C253827C3AB130EBD606F4A69@DM5PR12MB1401.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AayiLScTWqohf9KnfaQCj4Wzf2dikjidKfm0OQXowkhrIlOcNeGcAG84XXW+d6WFBXcLs2lx1+0dPj5nMym9mbtS8DN6mzk9t3+pn1E1T3Vl8ulb3aztqrL0aVOKJIiqjcPk0HZufmE+xMWtU1e6Jhqhqf0j3t7CMvgak5O15LFCW4m5lX5WFvIO4fL1SAsf2Y1iEaa9SXYE2vZjRaH+LRlSmNOKUZmQs8F1mmAwojVMFSz8NAUXJ0Dw5aqXyzkd9dSk6dNDY/Sawu5BJXrzWgQQC2M1t7xuJllveG4fGNdy2tRPKXEeYUl0X7LKMnbxhX4YXcNzX56kc+KtwHl+cQE2BKsZ5VIycAh6WLJSdRuFsnyFxV9jU7JF3wvZo11PXY/dnt5YKBltiXqSzvsZGrDbtB9rFvyZzK9kgYsT7nDqANhsFIljofU0G0kegwSesjG0dF+ID0Y13yqYDnvJ9FQK0VF9YxkwwIaFx7zMuin/Wz2XgwrvC7I0QRWPg8sGG9kA6tvmSYRZPXFThHRfOXeqvU5BXtsi6bOnG+R5yD/s9bbUO3xcBiRTgbXMt2canmg9PolDVUN59e1Z5IvNGUDEgAmT+q13AuUUyb2DVngFhp2DOwQJpiMTUWuAZmbLXeQihApNSGwZBtYckhki6jdNkOgbgn8X2AtFbvO7JpUDn4LTXkLFsqSAdXlkbMUGnUwPYi9fjNU3OlVrTW56pQJL41dT0yhx8XEkn63bFGeM0ovSjQKH6VbEoaXRuT1p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(8676002)(86362001)(8936002)(508600001)(36860700001)(70206006)(36756003)(44832011)(356005)(82310400005)(6666004)(336012)(47076005)(70586007)(5660300002)(4326008)(2616005)(1076003)(81166007)(2906002)(426003)(186003)(7696005)(16526019)(83380400001)(40460700003)(54906003)(6916009)(316002)(26005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:41.7233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ada5959-4c1c-487d-f5a5-08da4b234d4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1401
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 Harry VanZyllDeJong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>

[WHY]
Game performace may be affected if dynamic memory clock switching
is enabled while playing games.

[HOW]
Propagate the vrr active state to dirty bit so that on mode set it
disables dynamic memory clock switching.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h              | 1 +
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 3 +--
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7c2b65226131..49339c5c7230 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2652,6 +2652,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->allow_freesync)
 		stream->allow_freesync = *update->allow_freesync;
 
+	if (update->vrr_active_variable)
+		stream->vrr_active_variable = *update->vrr_active_variable;
+
 	if (update->crtc_timing_adjust)
 		stream->adjust = *update->crtc_timing_adjust;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index ae9382ce82d3..5a894c19b0ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -304,6 +304,7 @@ struct dc_stream_update {
 	bool *dpms_off;
 	bool integer_scaling_update;
 	bool *allow_freesync;
+	bool *vrr_active_variable;
 
 	struct colorspace_transform *gamut_remap;
 	enum dc_color_space *output_color_space;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index aa121d45d9b8..0686223034de 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1374,7 +1374,7 @@ unsigned long long mod_freesync_calc_field_rate_from_timing(
 	return field_rate_in_uhz;
 }
 
-bool mod_freesync_get_freesync_enabled(struct mod_vrr_params *pVrr, struct dc_stream_state *const pStream)
+bool mod_freesync_get_freesync_enabled(struct mod_vrr_params *pVrr)
 {
 	return (pVrr->state != VRR_STATE_UNSUPPORTED) && (pVrr->state != VRR_STATE_DISABLED);
 }
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 62e326dd29a8..afe1f6cce528 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -195,7 +195,6 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 		unsigned int refresh_in_uhz);
 
 // Returns true when FreeSync is supported and enabled (even if it is inactive)
-bool mod_freesync_get_freesync_enabled(struct mod_vrr_params *pVrr,
-		struct dc_stream_state *const pStream);
+bool mod_freesync_get_freesync_enabled(struct mod_vrr_params *pVrr);
 
 #endif
-- 
2.36.1

