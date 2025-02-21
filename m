Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D6FC021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6E910EB0D;
	Fri, 21 Feb 2025 17:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+YSGfwl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF8010EB08
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqW7QokzDiI96C2SDZVOM1QGA7oL/5913Ml1EpdYx1Kj9hGTLFoUW/Rw35EIP5v8jWSSl7bsx1FHMUpyxd5gZwbb+tYIT6wklPfEchPT4Zut9no2+OzFySl+gprN75iAfK40LFB+4fQ+PEJjZ9cCxB6b+XznkPdnXpv+qnIpmLGUXOUEQz0jl/7eS1SP24qbrfedYVOcsDvBZtTEWfHzEct+qXeY6pmW4CVCn/edsQK0GEXI9zE7aySzwTNgWjVjZ08X9tvu6G3hc9IVr3RTr+WKMRfuiYESfW+Di6lSx25kmbxzWoohwVqT4EUbELHEoKGrZi7QAhjNbBBXaAIjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhDtID0ip5QTRW70SRzHRRGdL9AqlfWlxhR+mWId/fA=;
 b=iqwS8nU05NCu579HK5J68ClzqwG9Tkj3lauCgGDU+ngVeLTXaDSTrE7O00kaOaIDxJIqHVAdIlZcsXGNyTg9E9nxZiMsqA3ZGBzYPg0PfMBRgS6ipc1vJ6vReCpg/fGX1cYiOdsKIwKVMZCq6gozuoGskBSPDRSmwLRW3N3OGpRP8nXg6BO/wNTZtxwudWEV+/ge+ThRcL15fwhTjxZiiuqccHbKO0E8OaDD6S4lZiSJXdsIeYo0yIJEX7Di7xqa2csH44Bk2T/m4AMytyUSdoYruCOpvZPYAB1cEc3WG9aQOFDZan20BSNfIO2TszISd2uyPV175oRfXs2cU51Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhDtID0ip5QTRW70SRzHRRGdL9AqlfWlxhR+mWId/fA=;
 b=e+YSGfwlOb2TG8fEOc7rM7iUXHau8hzv+ye8QFxYE34ohkeXxXc32JCcqDO2CJcuY0/xb6HfEQgE1TJR+nTGmnSx7aetYOh0GikqSAWYA/FcbRjjrEz6UyTYPj4xYWmXWMQl5Mj+f4Fm1z1biLaewGf6JKSedR7RNLkY0mm95BE=
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 17:10:20 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e1) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 17:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:10:19 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:10:18 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 5/5] drm/amd/display: Add a new dcdebugmask to allow turning
 off brightness curve
Date: Fri, 21 Feb 2025 11:10:02 -0600
Message-ID: <20250221171002.209895-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221171002.209895-1-mario.limonciello@amd.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 690e6d6e-c409-42ae-c98a-08dd529a9ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xm+ZtL11LJs3JnOhCRCvvA5j6OFJj4qL1qJcMAMV4qIqrdEcd8lZ1wVhSLpG?=
 =?us-ascii?Q?wndRJdHn8mxd6mHopi5QdyZSuMl8PMnMDvx4BRfumPPp80aJQwBZ31dobVc7?=
 =?us-ascii?Q?DVADtCA7kgtI9a26PcRSIFCjPMMVr5IRrHsdKU22ZoSUGCCiGq4QnJ5HdPN+?=
 =?us-ascii?Q?CLRTysq/lCUi96GXk8wg9x5Iuk49qjCGFIPTj4KlKD/yPoBpbTr/+SmNDIpb?=
 =?us-ascii?Q?EibApg6TzS82mmHuc12hPbPuHLxi8wTN/j9v7N2xKocHA557tbVOO2lzAPx7?=
 =?us-ascii?Q?mLL1Mk48BBQqoTCVdCTbGm2nZZPOR3L4gNPYZfHEi30dXzrR6ntUi0Zy7+R6?=
 =?us-ascii?Q?koDv67dSM5K6SYVUCoDXRTfqwSpaA8fD7DQkDvdiwetVDN7c01/WWd/GVLjD?=
 =?us-ascii?Q?OPb93SfEIGgcaVCtp1VjrfqjAWKG1vnebZZWonE9it5rgQ6EFGBuElMvq7+m?=
 =?us-ascii?Q?9fuMO75D+vXXWnUGHlIGtO9ow5Lh+/9i/WWff3+QJCDGHItQEICv3t5DAP5J?=
 =?us-ascii?Q?jIGClCNjNNjJin4ur7NANQOX99xCqvHsoDeJu5UdmPHgTkQUOrRiFPclNXaj?=
 =?us-ascii?Q?/7bVMoBVHOhH9zcsTEdWumWKIPM09e+x957QwjCYSdKuF1ckyDy3qLL9tLtB?=
 =?us-ascii?Q?Kqc/QDV+VaWLHQIix7rzSFkiw8EQjafCiEWOlAYn5Fokmpt0ZpH+Cr8Pr2FP?=
 =?us-ascii?Q?PghTh6i7Y3ru5tee7kIBsSE7LJKxAFsXWuT3h4Zp9KftdrVjyLqckvGJMdSR?=
 =?us-ascii?Q?rI46d3GtXgcx4+X9fZpJbdWvHNxcRd9RS3AMC7S6QpAtxBWetD5io9i7Bv5M?=
 =?us-ascii?Q?HRE3HbybwlqpqqGMBWFkNfk77QbLQFgh/WR1ul73Tc/amkA1rBAXcTAUH+r4?=
 =?us-ascii?Q?cEBTwfWhFQwQkVXMHCBTdKJMpEg6GEvR292KeBtiMqnVLOIEpMY1MYzxsWba?=
 =?us-ascii?Q?8SpnLDa5hvtwraieOuFkcRcQJDIPnR/WaZObcwGEelRNchKbbr2nfDHKiJ2A?=
 =?us-ascii?Q?W8zHrCAssxjiORBgxX/nRr0CqtifPldLx9YxBIA4a9OAa+g8BxEWpb4kHsRO?=
 =?us-ascii?Q?pS0L4zm/VlJoi0CRT1zRQVA3r/DKIs2RLqc3lHvhp7A7LRyLZH/ouiIHS4E/?=
 =?us-ascii?Q?cXPaChfQ7u8vKwFAkGhY5ODKDHjgLC4XKy5N3R5j7NgXlHyTOa7+QbWAoQ3u?=
 =?us-ascii?Q?SSBTWxe7ajS2/3ZavWByHw1JJhgdNWewLLgepIIY+mVgO48MoV9Nv7FJ4y4j?=
 =?us-ascii?Q?ztlVZyi8gAGF3GGePtEp45voo2NZY1ZNrdIvPrfnJGsnqYNMRPVh6aNHyMqU?=
 =?us-ascii?Q?7lBHp99HEc/NOGFyaCspjeEy9FOKcPbIRekLjuDUsdhIg+4Hu49XZAPFkx3d?=
 =?us-ascii?Q?6qKSoRbt8kBBGL8jTM3J9xsaXdwMVXz1QKm73TBI8PFPdWg7fthaTcfvCoME?=
 =?us-ascii?Q?8X59fd2gZGqHum6YWPm0NLfECMEzWWyYh5UG/xoCvNXLkEcRIz4TEUCb4o/E?=
 =?us-ascii?Q?p3eUxEXGQoeSNFQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:10:19.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690e6d6e-c409-42ae-c98a-08dd529a9ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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

Upgrading the kernel may cause some systems that were previously not using
a firmware specified brightness curve to use one.

In the event of problems with this curve (for example an interpolation
error) add a new dcdebugmask value that can be used to turn it off.  Also
add an info message to show that custom brightness curves are currently in
use.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 drivers/gpu/drm/amd/include/amd_shared.h          | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 136abfcdb76d..904a2d2a9664 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4712,6 +4712,9 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 	for (int i = 0; i < caps->data_points; i++) {
 		u8 signal, lum;
 
+		if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+			break;
+
 		signal = caps->luminance_data[i].input_signal;
 		lum = caps->luminance_data[i].luminance;
 
@@ -4896,6 +4899,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	} else
 		props.brightness = AMDGPU_MAX_BL_LEVEL;
 
+	if (caps.data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
+		drm_info(drm, "Using custom brightness curve\n");
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index c0538763ec1a..485b713cfad0 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -354,6 +354,10 @@ enum DC_DEBUG_MASK {
 	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
 	 */
 	DC_DISABLE_SUBVP = 0x20000,
+	/**
+	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
+	 */
+	DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE = 0x40000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.48.1

