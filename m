Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6F1CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64AC10E448;
	Wed, 18 Oct 2023 17:44:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EC210E448
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrYOitf8zhy98huw7eflA1/btBiJNs1g+msNioUHATlRWZwMgHYvYDled2WK4iffo6LGkaUf2/SSUn+hN5un37/HW7tBYgLpXro5PTXOEs1+dE4vOVJJd9V+ncHgzU92cjwzkIy8zWWDgr+HlZzXtyjudAldCGAEB9WD1o0o065plOF836jZSCiBucaD+ZzTwI1SRGFijkUV2AnsaIc2SvcDs5Aylz3zqfqB2f9qKStJhyib/6E2dhZlOUtHdI+SKLMIgMIuuEYJ5zX2LzOvkZKvTrdrhAmX/0O6xyd7BlldSeIEaQD0vTDWLgxWN9anIdrTgTZZAyI/o+yKtLBsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crsMgNsU0oZkIgrMDtn2/C7XmVw6q5GlEqZD1eJo524=;
 b=XPmXe9kPf4H3CR4olp/6DMdBypWBdV0bxm7HoGpEq/SNqJdw0QTC1O7QzFsYAYzGjH0R2w9f83Q+QLUN/v3rXoMPdeZnbYso5OIbxQ8wmj7EPNJvmCp/+/jGfzsMsmU51aBhRSgnv+4sTUwQs9y/xRodEU0sluvgShUDWrxXNIRz7l5SYOMoas4KudufolPV10GQ3+ZBRelUGDR+eywxu5YMsNz8+fKXfo1uqcTDb7FzPtlmXU3ogD5oXu93y23/E3m5Bs6ADk0RU0S0DYCVtOEpr0QasxgfGXsjAnzp3IUilM8kQaXjEOFfXCssG/o45jxaaCdQ1JKuwnnZ9bnrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crsMgNsU0oZkIgrMDtn2/C7XmVw6q5GlEqZD1eJo524=;
 b=HKGIY38PIu0Epm4xwWPg6OxcoefH+32ANIXyMYpKvR+zHbhwGEAPqhyJXoSNzRRfHrwnAWyoIEJA5aWds7QdZl/9N9YWibLSlUMV0qMtztqwkO/ZWUb3MeARryfs6aXi0hV2tUJ5ByvLbFoKnwgvQD39+6qDUClbXyWBcuOX25s=
Received: from SJ0PR05CA0138.namprd05.prod.outlook.com (2603:10b6:a03:33d::23)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:44:00 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c4) by SJ0PR05CA0138.outlook.office365.com
 (2603:10b6:a03:33d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:43:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:43:30 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:29 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/26] drm/amd/display: Read before writing Backlight Mode Set
 Register
Date: Wed, 18 Oct 2023 13:41:31 -0400
Message-ID: <20231018174133.1613439-25-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 167b203c-572e-4f6d-b968-08dbd001cf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jw30pxYYbfcTi0KUshOVNgx0lL80pCSZtMD9EtjYRGnbgUTvZMtOaZ02+CwAyi53qCQBHYCyIp+YQ1cjyIdkuFVrggliuTuCJ5kfB9N4UwiK9Bv7F5IptsDqs5hKJcdyJgcM/3fRQ25x5booHQ01WsY2fpJkc7DPjtQCldQngGgnY+TevVE0K5KoHQrMoV9qhjWRL+qF7PyveGMvJaq8YbGENoeBkqnPqgFL7PVBx93VYYWKkMnRi5W2adwzE/pcfL3GDX77nGBAEOwNPN3JKyJbXqDRR8lDPGQyRQtzsAAOjDoq2C64QXjCHeGq3p+vHAIR7Rww48fEivUZvkSmTqAN3bul6jFlzEzIjHbRwCjkyRhhmqin7PBL+iowRVeSYGa+t6avHWiw1Q4Ivau4IYlazHqMYErGQaCLtw0tHkMtL8jmacYgADeNCkGsVL78N4ayxjby8rpc0spFTpwIYawTHggfWmbGdP6Fy+PEESVfYQ+iGKmauARizdzC+DEZajiSXhhFz/e+FjXtWqQbRxKkDiiO0ba87CTzgLK+hXGdKHzQenQ9wWkh8TQRzSqrx8ejlfIYa3n1vfNE4uS9+ni1dhY3EFrlyA94+Kb2XnlFRRwiw1+G/IXEXDkW+ttT/6yo0+3aq364C1zNlzgE6qSNODIYJ/RGZ6PBbZxjUGjP/e7QR68cHOK7ctxdVuNHuz3Gdemkr2mYFypngUkOXkE1MqyQUaZazVsIC4buXtaDq6FsSwgf7HZYYYUaCxJMopmv7kerz1z4GVz71MvUiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(86362001)(2906002)(2876002)(81166007)(1076003)(2616005)(336012)(26005)(426003)(5660300002)(4326008)(8676002)(356005)(41300700001)(8936002)(83380400001)(40460700003)(478600001)(316002)(6916009)(6666004)(7696005)(54906003)(70586007)(70206006)(82740400003)(40480700001)(47076005)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:43:59.9106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167b203c-572e-4f6d-b968-08dbd001cf9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com,
 Iswara Nagulendran <iswara.nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Sreeja Golui <sreeja.golui@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Harry
 Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <iswara.nagulendran@amd.com>

[HOW&WHY]
Reading the value from
DP_EDP_BACKLIGHT_MODE_SET_REGISTER, DPCD 0x721
before setting the
BP_EDP_PANEL_LUMINANC_CONTROL_ENABLE bit
to ensure there are no accidental overwrites.

Reviewed-by: Sreeja Golui <sreeja.golui@amd.com>
Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 86f97ddcc595..e32a7974a4bc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -182,7 +182,7 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			&backlight_control, 1) != DC_OK)
 			return false;
 	} else {
-		const uint8_t backlight_enable = DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE;
+		uint8_t backlight_enable = 0;
 		struct target_luminance_value *target_luminance = NULL;
 
 		//if target luminance value is greater than 24 bits, clip the value to 24 bits
@@ -191,6 +191,11 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 
 		target_luminance = (struct target_luminance_value *)&backlight_millinits;
 
+		core_link_read_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+			&backlight_enable, sizeof(uint8_t));
+
+		backlight_enable |= DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE;
+
 		if (core_link_write_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
 			&backlight_enable,
 			sizeof(backlight_enable)) != DC_OK)
-- 
2.34.1

