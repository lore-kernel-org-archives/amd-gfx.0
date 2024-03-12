Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBBBC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EC0112D45;
	Tue, 12 Mar 2024 09:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D/hD8PIU";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E420D112D45
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyYuTeZtwzvguI9M+q1oAaf61mBxSQ41ftMhl26cHn4iAQ/I3H01Dh+sN6bk0TaQauWlviMyHmihe7p65lwLxeA0QHnZC0Qx+ATiUe6P3hQ5vsCfG5gwUTzoNxwMh+T5jmu73VKcyMXYbAoasZx3zsPunxHRqnhYoaT43mo8WOeROsDQK/QwAOueB2MmYnFMOygg4VdGP4xm53SOwry/GKEr/3LJdEL0YMS8GqAUGNV/x7+xumrODG+Ct4eyYInFebqLDQDZ2eNLlLyj+5iGYLC04oBA5JjG1VBPhfvTV/uQ2W4WTcagbH3fIX7rF1UGJEy7PO033RM6kq7sqRf2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHsROwfneFTP00SEn+Qlj8uRdbCUm4pB/3FK/iWqPOU=;
 b=fexPmJJzcb6Mm+YRa+VLMmDBW+qIBtEYykVfjaROopMwOCq0MVguEXrJ5MKbAQO1G40B6IBMQi8gq2pwHM5QERYap80eFqwqIshou/FBIxUCXofH6q0/lCpX1VZTZNJAheXoTRg3MrCKoTha78V0DDySPnvJ/JTb2kRgoOlPBAy/jKWeQ18J83CE8p3eXiRDA1hnAFydTATP9oKZDA7bogpXA18BLvREiAUZd7lxKlcW/rYxe7MtW1jkdSoygrYnSq7zTwWB/H/FnTQTDbujW6SmlnuAoB8KxclajY3JWlTKFBgCava+Vm2TY2nJlwa5FcDxVWYMSJdFROzuXSn4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHsROwfneFTP00SEn+Qlj8uRdbCUm4pB/3FK/iWqPOU=;
 b=D/hD8PIU9D9PGFFVJS23+hNmHwQ5a0S4DPaMeiTpD1bJq6a8NkqY2c5lXrrF2F9/VWgZYKuNyL+243ays4IwVC3sYWAG2WGozQw6jDFlHqf1AAh+DROAZ4jBj+iPx+4QU+V4iYunA8JL8D1bq/+AXHAgClKnmw8F66hZFJr994Q=
Received: from CH0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:610:b3::19)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:25:04 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::fa) by CH0PR03CA0044.outlook.office365.com
 (2603:10b6:610:b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.48 via Frontend
 Transport; Tue, 12 Mar 2024 09:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:25:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:02 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 40/43] drm/amd/display: Enable reallow for idle on DCN35
Date: Tue, 12 Mar 2024 17:20:33 +0800
Message-ID: <20240312092036.3283319-41-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd84bcc-016a-4674-0da9-08dc42764ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUn5+WHw7jS/vCqPm2P2aTOxbvG5vblgjk7DR4psOENsfcI4m4loBlr/GpvkWiz65j1gWmYgwA3elWaAb09dMvFT90ReuQgNpak+9UXxa9avJg740hpGulEcoPtdBwEII3LXPwF909ruFWEBZA/aPxjNJhIsZ/xgbfL1ldqJi+XfSUr67DgBYDd7OFqhyMte2DlfdXWW+YTfbYLMBJxuF9Fo5+z4z07SH8J4QVR5kkqIB10TahnLLNSCo0SJkk2NAJAkSn1+tbydXlxuSPQPPOfRTZqwMu+OnbSPfzwCEAXvbF8WSyrv17wMEyoFbPGvGN3wCHyb4bvXaV30i9yJDnKDySuafQRPTZklaRgobsmPKLrLwkLAtrSm768CkVLJygZERB0UQV3p46e+ohZLZGoN0FKa/dHTKyAEBN3qj5O8gspSXpUnMa7cN6XQoJwOQQv5yzvEDr2STiEoO+Lc4Wh2xC637cM1ptcChUOoYydRqY+KKpQ+tc7OBncipdfQg6CYi3q3OKzr1vNT+uwJJvLPQWAHjyAGOpCOkEey/yxD9UIKpzwN+8R43zME6fL1hEv51rfWbK8QlgdNNtEV8nvQ4k8wohfb2EiA2ta4m5Qy1DRSRd//KeJengPbFV3jxo6DQln9FoO0ckQvV+ManhcE5Buif9+UT4n48RJotkRYyMqK6Afp60AS9k2RG3ktUyWHzV9Gs/nZm4dDXF3owSquLRGa+wakzLeRh0zURJO7h+24bbic5/ljn731Qhmi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:25:03.7962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd84bcc-016a-4674-0da9-08dc42764ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
It was previously disabled for stability purposes, but command
submission causes residency issues in IPS video playback.

[How]
Enable the disallow/reallow pattern back. There's additional checks
now in DMCUB that should make this safer stability wise.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 4ba234b01f04..0a5fb659791c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -783,7 +783,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.psp_disabled_wa = true,
 	.ips2_eval_delay_us = 2000,
 	.ips2_entry_delay_us = 800,
-	.disable_dmub_reallow_idle = true,
+	.disable_dmub_reallow_idle = false,
 	.static_screen_wait_frames = 2,
 	.optimize_ips_handshake = true,
 };
-- 
2.37.3

