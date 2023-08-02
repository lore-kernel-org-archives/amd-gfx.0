Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261EFC001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE1710E4B5;
	Wed,  2 Aug 2023 06:53:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEAB10E4B5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSK0EwXvQmrz9cc4uWtdDpEBnEdohwgcZ9u1q0hsSoM0EHJAyTOXeLurYjltrfuqVPfcgIRVGJmFYMJ7VCQDUUJTtc1zqwukPU/L25lAam9wCapUt6d88YdTTyzUkYaw142wgmm/bHPXfZzbMXg1d95YvUrM1JYFbA3VmTwGEws3/5+0SV7ekk5MTvI5pVrPA+P3PDXwY+NryBLoM5UyOEP0EM1nCc78DgmicoqI5JHheFunWIk/8R2+t4W61EE3Bk2k7A0Y2lAn51ihOX5m1P6Ia6XK1bZcXEy0F7IXOI2zZ7Li1erLdE/z0c4HZx+5SxvO83i7/zLZOBI1V5j+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IgCEdETZbtql+YdtF+qUyw6ygr/kdnDKpc6ib9u5Iw=;
 b=Xdk/40jptAJ39qll7zd5EGeWsGBttKm/Bztp726tvLwwua95g+6xWZtL+TH+/nexBdPYeQaitjdVGC/EwZMfyKEcRN1B8HkP2HY9lf+eZzLwxNCFdI7AVhG0HUDtJXiUXXYTOC2v/P/AWdTqnjR7cCKCNCudbK9j5HzFB483ZxXXWUHGlc6jEykXPZDlBXXjFcavTwnrT+JhTsFhIp8AE/8I6RbC3tD9guIW1Xw84BzLdpmSc5E9MBDzqf5rouSjTnwrZB/Vc3dw6DwvvySaZh8RMeIqlv7ItAgAK0o91xkLWN36Xvwn81hJqyUfeoXtVLzppbHPOx0RcGfyyR0Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IgCEdETZbtql+YdtF+qUyw6ygr/kdnDKpc6ib9u5Iw=;
 b=GRV/lZBUxJrxr9/oi1MJkkLroNMlj3hlvQv0qiYiFi07rID7nEJ5b4g77WxDd3YSs/REX7Mv14LBRXkQUZ8QHMGkHVKpVpQtR4FoN0FYXvdm6VGerx+jkh1yLDIkCSOCu8zY/pnhR4X2DZWH8Pa/H1P4Rxe1rHL4tQtjMdAOMCQ=
Received: from CY8PR12CA0051.namprd12.prod.outlook.com (2603:10b6:930:4c::29)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:14 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::e9) by CY8PR12CA0051.outlook.office365.com
 (2603:10b6:930:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:12 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:54 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: Blocking invalid 420 modes on HDMI
 TMDS for DCN31
Date: Wed, 2 Aug 2023 14:51:24 +0800
Message-ID: <20230802065132.3129932-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c87121-5b0d-4f28-7750-08db93252462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgRYTJUDBqqxr1mGuSGBxTieXCQ6/pygufSO5KTg6Mm13vgf6XXjqLNZwT+LJUq7ItauG7+gqzOOXE62OYOpb84QdqwN5Yr/pk8DRnxFMnN5UObW2gaggobA8JFnacPe8LjeORgvM0zLsiOXQ3mE5hwBuklUBmfFvuS5EOQDcdqg8vHZ73z+Uq7g4A+CD6JuQt+BLKo90QdejV+AhlrfKJ+rEAayO74QYe4G1aTTyjyE3IyN9juwzaO45uIj9+JKjyTcRtCtEuBFE7dBrGEVIpWYFeLOmqS0Dw01OqGIfdoELo2spL19wKAiLXiJb2swsDVLz7n0N4LPaApEjv/eZt6iTJNmJ/2JX2jzy8xxN9+qdzzfDB6ZvmA5ZSJOtRryXbSTmTJShHIkhjOrjcnVx3dzQlExc10+aMPbCOdgQXdR+KDGJOH+e48YTq4l6SaHtP/vQZGrNxJk8T6m01N1VYxrYHmLe+CzlJ46pNrUkW55DWn9gflzvOVF0blpoVLbd428D/0qIhGTF9ajqEDVp3BZLquljm9aftea3i8Z8tmkc0aC1W/0oYw0h8NKHz7iWrLyc5lLKcIoUqqCZCJ5IY40zZLo4SwxlIyZ/Tdj/x4bdDvop5bGQIrnvkYRv0XgVwBtkIoosFfCvnTaV189iHqio5iyFPr+MzM6asIf225p9iqYeKdppLA9iTZM4DY4KAGUYZsHB4RwTRZo+hdFUl7DC7k/oN3McJQtJ5oHFpxuy8otJ5IjqaaIzmt08+LjjWW+k1NtxoxdJUquLLIFnaFCYHsOU0izel08TBZ857k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(40460700003)(2616005)(36756003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(7696005)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:13.5313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c87121-5b0d-4f28-7750-08db93252462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: stylon.wang@amd.com, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
HDMI TMDS does not have ODM support. Filtering 420 modes that
exceed the 4096 FMT limitation on DCN31 will resolve
intermittent corruptions issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index eba51144fee7..adea459e7d36 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4135,7 +4135,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
-- 
2.25.1

