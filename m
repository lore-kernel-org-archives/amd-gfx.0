Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DFEFF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC7510E39F;
	Wed, 29 Apr 2026 01:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dfhqaw4a";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3296110E39F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNiGCBaQVdoeTRYOiD8gYqXrVJr5vtZwIsEcOF1ZF7uprV0LrKIv3WxXALCk6gShWZ066xAFRdAiltLiT8f0B8m4V80R/p1oQgj1oWwjEGJ/PSLs0b5FTPqbE9ZAmi2l+AgYGrcps8BE+n8X20zSEubBgrxqfKbV4F84tF3Hw+HyoZXMof/uwDOM1t0Peq0ZJ5uaH5nQGeHP2ssF//Cl/wswtZSRuOtqfF/a1cBhyFCdC1YlV7dzrPw/xpUVIiVTmcoHWDAMOabsdVTBCb+aIlhvjRv41KCLRn2VXUgWh+DoV26+EZ3rqyXal3Aj3MiDgDiKomAT8KAReujPyuDSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70wQPe6zRO1151ktXV4vynEoBzXjxm0oP1k+fQYPkoc=;
 b=s+6Jp+cdBSkBkFCroMxTK/wfZKBSYH38yFmQCIqHRTaeV3jvbANnZTYTyGlpAN/ZRS7w8xVGd/YoG6pzq13RX9qZ49I9kaULDzthJ9MDhwCfNg1RymAS/TRG3Fg5Q0bnenM+53YsqajT/ttdabdLtEEMWsXkrXhvQXDXWO5SIxxP9SjoIgloKMvAtwF1YDVqqsUV7DWIqz5PUtrFesfdErT26VIzn+Hw085VT8WCu2YLKiB2F4qdInLUs141iIIy/ra1H4mTg+O16yhIdNbLijdtLGM89F8a/M8XrZe5C186lAjk8kk68/0nHOw/S3fM+wfmrtDJGWPlMdJTL7lc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70wQPe6zRO1151ktXV4vynEoBzXjxm0oP1k+fQYPkoc=;
 b=Dfhqaw4apEjkFZ+IK059852PS7utbvw0fA7UlR85xwarorw3FjiWuDM/gE8KnIr2ujVMCkNs6Ikh3suYAZOdDRSCIzTp1xM2yydhQ3E+m4wHxd5e81KHAE2iRhquuV6qYtYFYnRAFKOvXkzbjDa9T+hCzRAVoXyXj3f+6cSVx0U=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 01:53:13 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::5e) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:53:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:08 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:52:55 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 08/17] drm/amd/display: Rename backlight_properties to
 pwr_backlight_properties
Date: Wed, 29 Apr 2026 09:19:17 +0800
Message-ID: <20260429012055.2065869-9-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c5d382-28b1-4d64-2a04-08dea59212cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9zA8jSPGiZWe/1iKj5vgfSc3pbDp7UbHDxLS2Ixfv6uuOC9KiOoZh7XFgHM7S6skFYWpXrSIYuHuGi0dKLcYhR75aRs+37qhJcBkTeKrFUbjL9Gn0ymZxZO6B/IJ+qlZOnvUitfcpL2tF/ISKwU19gHLEtpBdz5xF4ud6XJB2kKpuL+RJuxf7okWQd/DhK8bQNLCPZMfzTkclef0YoI4FqQ2NK99UQkaatuyK3QwALJO15U/GSpt63zBqA7IqU9lusSUov7A0hXkWqLKaJGJe2MT3cA+sY8oBzEXOVB9GBcgOMmZlf+IkUlKgDBp7RcL+plWcmGEIUpZfJJrt0pCICqYGdpFcTYaR0Kty1FDB7FC+dZcj2DyySSMaJyCHFRwvOkkDrsJr/rjUYvaw1xTgjnPoO7UOLUqmv30ZywIX/EsFC16HNOe6uG8qzuxooO/LHG7SbLcgDMEsLpN/wwPxPTlHo/9OWxm2IBx1Qqoi58HXIUOQHLWQtBISsIBqcXPiH/e5NU9IeopewlFH2rG7//0pqqVQq+hO/OupLZm8dWR3mjUcgw2Px0ZK/DR8L8tpZ5ZaSHCrdH8qn8OZo4RLTaHpChdL0BiNXAS0lf+/E1QsQNOvUiin4pnai3hN2ZBkV31hiAmeUrQmAq8+FrZLExCdIOL1dBdmEn/qqgpvSj0W64JowE4jFFgUnQZU9QyPlaQ0I6/T3Vk8ov2Ti3HA62XwKnkvlnSLp47lpCqbF1TYjdJo7RcSwEtsOGgdm8MGSR3QngRcX48jjAmODmLog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pP524ffT3h2KBj3HY9MzGyfI2puT7FIf9oLe3S9F+dFusVdgGgigPN0KNz8QHji7z1obHRh0Hm5M46ljpZ3VlPTZdpXEjcwUtChIg+l0WHxR0a+jX+FMrb2UR58rmD6sHibcTJUEFrm3aaD9RKspWEp9c3sPnuIOIbxNuM2osMj4oMvULVdnvawz0u310sq+80tlWTQ/S+zNrmtznY3ccNzF3s2oF8DfdVv8kym30Yniow2+L2TkeMPMS4SLDqUP4qgI7VFYOL73Eg9TJNAH1/L2OwrkG/taXASuJhPej/l3tcS/CVh+MXqX5B4SXmqLlAg8mDQi1FXyTge6T8AQfxUnKCuzg5fJryDUadt74U2T8mAKxWGiUrdFByLFkiXunLgGS3BYQA3hEIBBWyqlrJU+fg+pDFYLjt+4tCByP+HrL1xaKRXnksdDkXiBeUWT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:53:13.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c5d382-28b1-4d64-2a04-08dea59212cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

From: Ray Wu <ray.wu@amd.com>

[Why]
'struct backlight_properties' in power.c has the same name as the kernel's
struct defined in <linux/backlight.h>. In out-of-tree backport build
environments, the header is forcefully injected via command-line includes,
causing a redefinition error.

[How]
Rename the file-local 'struct backlight_properties' to
'pwr_backlight_properties' to avoid the name collision. No functional
change.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 81d15a51e045..5cef60079d67 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -70,7 +70,7 @@ struct power_entity {
 	unsigned int replay_events;
 };
 
-struct backlight_properties {
+struct pwr_backlight_properties {
 	bool use_nits_based_brightness;
 	bool disable_fractional_pwm;
 
@@ -118,7 +118,7 @@ struct core_power {
 	struct dc *dc;
 	struct power_entity *map;
 	struct dmcu_varibright_cached_properties varibright_prop;
-	struct backlight_properties bl_prop[MAX_NUM_EDP];
+	struct pwr_backlight_properties bl_prop[MAX_NUM_EDP];
 	struct backlight_state bl_state[MAX_NUM_EDP];
 	unsigned int edp_num;
 
@@ -1103,7 +1103,7 @@ static void fill_backlight_level_params(struct core_power *core_power,
 	unsigned int backlight_millinit, unsigned int transition_time_millisec,
 	bool is_hdr)
 {
-	struct backlight_properties *bl_prop = &core_power->bl_prop[panel_inst];
+	struct pwr_backlight_properties *bl_prop = &core_power->bl_prop[panel_inst];
 
 	backlight_level_params->aux_inst = aux_inst;
 	backlight_level_params->backlight_pwm_u16_16 = backlight_pwm;
-- 
2.43.0

