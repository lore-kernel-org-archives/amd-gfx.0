Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7FDCDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B72D10E4D9;
	Thu, 19 Oct 2023 13:33:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EFE10E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/uNGTXGj2/rC7uOrhiGqshHJ6rHimmR+2nH0CtA1PbK/Ppbl445pra5QatGMIZbjLzf58s8VlZ/SBJX4mqodO4hgksP3y38/RhuJovdLphTYey0nMJ64mZQWLKu98f2EWIatP/EbH0c3Nv574iWsZygjXgiXQY7U4/Z0EHyKp0FxPiu5JQsmIYw2RoX3SpAM/8tvm0Kgwpo6thf7VsoxhqDvx8d1ELLtMZdwa5UqoDAmZyQHPaqU3PUUWF5jBMApkQlQ/9Ea4rh/HGjltLt34LnVpDvl1EBKur5+iqELRw8GSerJtBbH4/agEyD7Tbn1GZICl4bVojVe4UTKtpHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTxUc9ftsO9KePBFajZhryoSYZA1Dt/jhxNb62vnLV0=;
 b=QN+qljsrZOon9DD3xVfuxzrBlsuT3av7ZEVavs+OSY5TGe2u8bqywvM3A4Ub2C5MKokfmirsc63T+bc6qZ779+mFwE0yVq3UMQ5lR3PicNoth8ASXYund2LpDEL1Rsr/HHWYJ19IycjKRd6zfUbkNeeN6w77OULkU+LUP1CcANGKSOb8y6kFhRNOqXQhZWFscaNIeGdfDsgT1rsRwtQO3SJvybuB6J4H0s2Iae4e+IdWuRb4daNkswtbDobeUkl4X5rMBUFunhl5tZ/vvCx4/ZfLNGoNKpX5C7CT+Ec2Q1BgWAC2kWIeVUg5MjBcPvnn8xg8lVZxK0Bj6usazHfWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTxUc9ftsO9KePBFajZhryoSYZA1Dt/jhxNb62vnLV0=;
 b=18QPismLgupNbO3tiW0QNpnjIteyOT9hx3BmYUjyNOJoTtwieLBMCztOIT3VwoNm8adLUohvd0iF65hcVTcUgpuS6tyZjksp0LUp1d1gahj/xN5hZs00/gfImhYGHMvJDUPf6gG3BgOo/s8DlepR/M7xYyNJICV8ibBxUAdQogY=
Received: from BL0PR1501CA0031.namprd15.prod.outlook.com
 (2603:10b6:207:17::44) by DS7PR12MB6311.namprd12.prod.outlook.com
 (2603:10b6:8:94::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 13:33:01 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::ef) by BL0PR1501CA0031.outlook.office365.com
 (2603:10b6:207:17::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:59 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/24] drm/amd/display: Reduce default backlight min from 5
 nits to 1 nits
Date: Thu, 19 Oct 2023 09:32:05 -0400
Message-ID: <20231019133222.1633077-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed429f9-1c40-4a36-9686-08dbd0a7ea4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: greZ78hXNvYQRWr3/4kYoFsqgFdPC+AyMHt1B4qJKFJ0alqWib/CDCsF0MlWdXVxL0f4uyEJ/SFmvt7YzWHc2HaXmM+uygyNiQlVSIgpCR6hI0Zp6cRzMQ4c7SOA7X4diFfUUsfNqikNM0XP+sdXzKClr3HIWZmZYGs1L0s59VY9MAoIJLzlNQpzNtBUA24tSchU6L7rgszLoibx3nr1kGaWi3mHMwgp2ds8AFSEKU2uPv8rRn9KU5biyROtgXYKrVWL6hfJU2Ct7NRfKKTpc6ox7R2QJ2+4PWFc3CyfTSIjVXVevGb9pH7gCooV6rU51zrrr/8/vElVBJCxGLq8/UIDgZy+/b2XzSBK1hei2X7K3uW9somHSb9HU5hbDdPi+1zAu9KzrMry4kAoIoVSJpRPQLnHboX9pZIKegHRxUAZIhS5PvbSO7e5xL9nFiIPeYRl6u8VKdOdV2YQ6SAhdr2n9AvOkXdTvyht2hI61l69tI6eYpQ+naUYk/NELJmLlskPLDqfKwe4jzGtg60D6XXh/Q13xl0UNU2Veiieip3HRtA1ZzMPo7P48bWHj56358dU4B6RYlDPdgRwXSTvK2TdhTQflxsYMRokLtgsE3xVpaYft/mkGjoUDberTlPpvbeNjx7pc/i4mIJFGXEB5yV9+19CFpN0fQ9mw7+WjWiquid6KCmfmWdM9PCOWNoHJc6ViZAznsvtg8yYX0f3bVTWh4rQgDvkYca9RlvSOhxcIpcu6kkzbRkqtcqd5/2icZB3ZHsrxRT2yO5yEXViMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(36756003)(40480700001)(82740400003)(40460700003)(336012)(47076005)(6916009)(316002)(70586007)(478600001)(54906003)(81166007)(356005)(70206006)(36860700001)(426003)(5660300002)(26005)(1076003)(2616005)(6666004)(8676002)(8936002)(7696005)(83380400001)(4326008)(2876002)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:01.0835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed429f9-1c40-4a36-9686-08dbd0a7ea4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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
 Swapnil Patel <swapnil.patel@amd.com>, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Swapnil Patel <swapnil.patel@amd.com>

[Why & How]
Currently set_default_brightness_aux function uses 5 nits as lower limit
to check for valid default_backlight setting. However some newer panels
can support even lower default settings

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 938df1f0f7da..86f97ddcc595 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -283,8 +283,8 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if < 5 nits or > 5000, it might be wrong readback
-		if (default_backlight < 5000 || default_backlight > 5000000)
+		// if < 1 nits or > 5000, it might be wrong readback
+		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000; //
 
 		return edp_set_backlight_level_nits(link, true,
-- 
2.34.1

