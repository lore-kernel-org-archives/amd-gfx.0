Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ECDC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D287210E568;
	Mon, 28 Apr 2025 13:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DPA1vzFy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3514210E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhDExmQcevh5HJVpii8dptvsTiVnhSbGcxfI34X9Ko7wwKJOmq0rvYlYrnsndvixC8gK4FpKx9GjANdjgDBIQtKmP5FkfVCmGTX94lvLcq3DazeOmXas4Vdz6GoWVJqMJH/77t47LVLnZWpx6800QNmg1Ug7rW1Xw2QVHMxEiGf/Ws2rskt791yzLC4/d1baKg7VHwuveM1v7gP2fAlPwsaifGIDgkA6cwDF80JoQjz2TKe/O94908AMHKmYya6Ixujw4YU6JIxvd3HnDFdoaxtXNztFZzJtt5VSXXriVT/5X7gHxMPWjnb5n8pAkBcM8ODg/BpedD1zKudPVrkP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwnxMFnAQmHf+yg8IcLCnJ60OrpRUfDV8uezLt47n/w=;
 b=QUc3WQu27RVzfxKzd/AdhrtaOpL0NKY3NT/OCEIIXahtz6HPa2kNv7tIVeIu3Avh8vmukfHvVgrrZMBPMrnHnuxM6KKw0p6xFhAGampONmQ1R6jKu2aSmAzax7pUqcjLddOBi/ovvsbNOI/qo9T+EAKf53DXQvrclq7dkNHn4Zbwa7C8k/fpQB1MJCiG+0we1i4bp0T4tm0oK5+RGxQgc6UcI/AUchRdWsMZIXbjxAW9Hext3QBgwn0eetEWqEYZWJ41jO4IkUFa2PVPIFT3ED1ZpOJqNr6XSsajqxkeu1nPWnUMowYkF6PyyrdnyUKLAQxIkC7sEVTGQNuol4C8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwnxMFnAQmHf+yg8IcLCnJ60OrpRUfDV8uezLt47n/w=;
 b=DPA1vzFy4Q40+lszJWTYJybuuD4E38CHTAGEOi1Wp3hszpQbnIQEN4C7aGINrWiAfHNSp0yI7r6DXAkpglNFpR/DWyHZwyt+2eHl/v66OWcmQg5vR049258yoaR+YywpMiR3m3TiqdKiyNhNqzG5tgjBd35n0jnjcQDASh2YtqQ=
Received: from BN9PR03CA0751.namprd03.prod.outlook.com (2603:10b6:408:13a::6)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 13:56:47 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::85) by BN9PR03CA0751.outlook.office365.com
 (2603:10b6:408:13a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 13:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:44 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:41 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, 
 Ray Wu <ray.wu@amd.com>
Subject: [PATCH 15/28] Revert "drm/amd/display: turn off eDP lcdvdd and
 backlight if not required"
Date: Mon, 28 Apr 2025 21:50:45 +0800
Message-ID: <20250428135514.20775-16-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: afc70dde-27e1-4c2d-e44a-08dd865c8341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gFKas5GZs0K+Mssh59DqWHGPMQ7+KchyCYVp5ih/QEIaAeEH7jBR0438WH06?=
 =?us-ascii?Q?cjeyRaTNmyfRltumoFhQ1UuEGDycr1OF853txM2Ixt/rAqzWQoF70IbJBrn4?=
 =?us-ascii?Q?XemInBuZ2sB+salp7XUFgD99/1rw2f5uOW7zMQBmri/cROS4KsSLYFH/2Na3?=
 =?us-ascii?Q?H0NshTioRNOeM6mKiLOXGaIQee2QewDpzsXjPQo1G9twrYYzLL6hzHOo4DN8?=
 =?us-ascii?Q?phcCzEnqNJOvQengMqA8p3+pMZ9HCfiH3As6H3Fwg41QjRzyjndb3XMOsFvu?=
 =?us-ascii?Q?BOIFa+8jmx+CMfnAAwS66KXmOWlli9a4vSCFIa38FRAO+bVrHK6xfON9DeB0?=
 =?us-ascii?Q?hKPe2oFt7vMPz7qnOjsLY0zA46QYIPTKgB9Qb3IAzFfcKhFLxArReBFchoEH?=
 =?us-ascii?Q?ZVRXomQ2bzAiZwD30iB6SxprciYaJtOdioBx+xooBd4P5xV1sr/zFG7YDQB1?=
 =?us-ascii?Q?9Mm1+rDq4QjI6kGsHSf8IEPmiIqs+Ohycod0QrYW+s09zSlYdZ37egFtbBYZ?=
 =?us-ascii?Q?fSfycxuhsZwpcP98mf/l7Kbc13rGjhsguZuyuMKCONAyTro6nLRm8NIZ33i3?=
 =?us-ascii?Q?6aAM8RJBzw1RzdMNapUbrvxY2KmflQYhkSzVjp1Hp7fkJeSQtjDX7S4Q7Tjw?=
 =?us-ascii?Q?6fx2BU0yhkiKBGXQTlOoYMpknGHnikXTmZ7dzHahvEmffzQHxcHMjx4Qo/kl?=
 =?us-ascii?Q?AoGBa5F7vCZtY27vjP542bdAcNZVXvUazV2zqcrifTIU4qogozNcUQBI7OEW?=
 =?us-ascii?Q?PvdeacSu2sesA2XzzC6FKqMlr0bTzE/aQopt7ObqqkqM0LbEuWemOncEjBcV?=
 =?us-ascii?Q?ZmGUMFjmIfaB1glU44BHhV5LbJMxCAH7g63dNO2hqi2vRGfTv6fXe5Ryg0Pi?=
 =?us-ascii?Q?kExBs1nU+C9JOF0IweChtP84e6DRhpEuuOHHMiV34Ct9Y9xUJM5n8gtgOPW8?=
 =?us-ascii?Q?qsC1xaVPXFcEBVIE00BGHS28zYp+NnYYoj47uOaB8JJRiGj8G3MEMLxB0oGY?=
 =?us-ascii?Q?mWeZZQlb9oOAruQ+JPARHq52HpcxJZfy0dILodzcNbo+U5BIyYi9t+4bDdXO?=
 =?us-ascii?Q?VRUckPjYhwyXeItmmyA1xhb0S5HbDI/Xd8Zh6eBkHvj7MIcT9gngjpmvD7NX?=
 =?us-ascii?Q?xEFRKfpJJHg+7hUAMiRQjVxt0orOgcduuiiVcyF7QiqEObapXlX5YiACCFBZ?=
 =?us-ascii?Q?ryZLsFrPucP8Heo5Bnf1khknComz5aNwIvTw3ftMsUzV0pMpI2xpno3p+1eZ?=
 =?us-ascii?Q?PDi+kJtHoyVNtUAEX2ydfYZRn66yCOp1LbFUTeIISgN5Cv3zT1EtWZ91fbUK?=
 =?us-ascii?Q?G5hpjQEW70eN34h7NBqYpDCI/dwxOnD9R6eSl+Ht8TWKuuNmigSIjjoBVDdx?=
 =?us-ascii?Q?w/USLdmeeUTofpU/2z43rfejOuJi9g++4Pi/PrVMD67/jncS9RI3YuUpS/hr?=
 =?us-ascii?Q?HpLcdf4VWPwYmXIld6a127nw3N6Yqs2nz/iztajkGNe9pYdVdgzE2GRMtgRy?=
 =?us-ascii?Q?qXLDGij3lRJRQ3lE3GW9RrFv08md1Cr6t4G6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:45.3288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc70dde-27e1-4c2d-e44a-08dd865c8341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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

This reverts commit b91fff88686e("drm/amd/display: turn off eDP lcdvdd and backlight if not required")

Reason for revert: Causes S4 lightup regressions.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                      | 4 ++--
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 66e23507eb82..636999fcaebb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6298,10 +6298,10 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 				 bool powerOn)
 {
-	if (!edp_link || !edp_link->dc || !edp_link->dc->link_srv)
+	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
 		return;
 
-	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
+	if (edp_link->skip_implict_edp_power_control == false)
 		return;
 
 	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index f50c4dbc7553..da74c2b5854f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -393,7 +393,6 @@ void edp_set_panel_power(struct dc_link *link, bool powerOn)
 
 		// 3. Rx power on
 		dpcd_write_rx_power_ctrl(link, true);
-		DC_LOG_BACKLIGHT("eDP power and backlight: Power on");
 	} else {
 		// 3. Rx power off
 		dpcd_write_rx_power_ctrl(link, false);
@@ -405,7 +404,6 @@ void edp_set_panel_power(struct dc_link *link, bool powerOn)
 		// 1. panel VDD off
 		if (!link->dc->config.edp_no_power_sequencing)
 			link->dc->hwss.edp_power_control(link, false);
-		DC_LOG_BACKLIGHT("eDP power and backlight: Power off");
 	}
 }
 
-- 
2.43.0

