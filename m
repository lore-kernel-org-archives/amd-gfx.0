Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38182C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1ED10EE3F;
	Wed, 26 Aug 2026 23:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXvt0e76";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A73910EE3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwMjV0PfyPMGs4nxFDyfbJmyXvJOqcg94ityax2EGis+eSWyaGcXllWKzX1MNxd/H9je0Qmf9MEc0uwj9Lu4G034h8umWOm6AaylGoFJif5fJqdnIUPNDGbAQrQGuVeXtNyfesPORiVSIXc5YgtCqmJ2YBTo85kwsES7FVbuvkl0f9wuBUHRGhXme4nLsf4kpTfxXIKxZpSD49eYX03P5+4VCuiL5V04nk77B9TGb0kfJTAYrgaS15bGNiw78BY73Ttc066JvBKG9Pcpx2kCqc1Db3HTBfioIK0M7yhgs/c0irGBFmHfECmCCcbN1BAjc6M1iOfgQqHW0gXz1HU72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpIe6zXGz2rr8/+Mje8yMjyi0F0KFrptytATseeE/3M=;
 b=NtzHoTARYgyb2oyndcmOrIknFUOYTfJytJcrXaCAPv8L5EzXtP8erCOvFySbncFgM/ql/CVeZ/3vkifJl2z/iB9Y08yiAfzbIDF51pX6sKtxAg2Hn687RDeFTYddZ7Y3gDTsohrB8PxMFD8zEJZZFXj+W+oi6HIbSzrN/2V7PehfdKl2PU5NO2Z2LUawP6znJ7OY3KzrXQywM1K2hZOBqQsr+9YnCuphWfZWCuRTesp/R0KtqyOMU0b2x+AlcyrhtTJlQD2cUROklFMnBF776/7P5URtVkKZPuOreUqOT3TFEoZlJKZv1j4zu+8rwZqHL0v6jlUGO3cPNg22n9vZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpIe6zXGz2rr8/+Mje8yMjyi0F0KFrptytATseeE/3M=;
 b=YXvt0e76eMWpW8/cqzJtMX8OZ48GKz7S1vymEnjIrrmhvZ6geScJLrCZz39K8DvDENHzh7jSB33HPG0Sz8ukSqssqqrq+c1OF3K+Pvj5KLT6BnK9/FkcsymZIYLFZxpNtWO8txFAC5e60Pa/mpuiA+K+F3LQ/Ol1ZHd1BTxOGck=
Received: from SA9PR13CA0119.namprd13.prod.outlook.com (2603:10b6:806:24::34)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:21:16 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::9c) by SA9PR13CA0119.outlook.office365.com
 (2603:10b6:806:24::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 23:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:21:16 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:21:11 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Qi <Haoming.Qi@amd.com>
Subject: [PATCH 16/59] drm/amd/display: Add max_downscale_src_width debugfs
 for IGT validation
Date: Wed, 26 Aug 2026 17:04:47 -0600
Message-ID: <20260826231519.881949-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a804274-0875-4f74-f306-08df03c8ba69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gFIc/KXdAL5u+TdiGWG8P5fthDx9anGxrQ0rDS0x/hx0e8pUQ66k9sERAiVYIxY8TZYbSa4W+zvxwzshyvgbl9o5CZwIwmaTy9cpZhsScVJwosy/RIiWgqWkAc/IlTqT5AG4kNnkJqpyRS4YPJUqBZQhqoN8SgKYii1sMAky1OAklUWwt0VDTbyuUdeSmbTHOpv2v2NLqS5ipJFX5s8YxaXvBi6B2+zrHJ+FSgh4/ffPwM00g3MloUD3ttoV2pYBDZVQJw8cZdLRsLLMwqempIwVu93gNLhMbMUvUgAQ+onhyuFDU4eLtDbS/5GIDaiOSwDA8JxFJYJiX1fBxOO98DoXUuZzDGkX4w8FtVtlXrqsigERGmzQzfKCDLnmXqWkWN8pDhhmRp0ut1uc9oMPMHQqw5UCJ6C5m2VYnnaFXPJlMAW7jQtgRqZcmxLWjOiECflLMrfZJw5MwqS+azBOT8ZpjamqHiLN75Y9NvMV2GZiKVSMPyXXd8O/uUi0FMqPOg+zTp4V6KBjO/8z2zFRCE/UhGb8ESjtdsg5saKR44WxdTMoHytANmS/DSMdl+ptKOZUMmK17DFCHgUNo/++cG7XPTMfgsDJw0tB+EXJ1OirpjkMrFaqEIV4Xi7qhoiXvFyW64wja58G5O411Wdedq3bwGruMmNzJlUW0f4XfszdE+d7v4jOoRgDa1ND/hu8gistOGMoAo5vudDitkeHZw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qOHBwo0XNrkvIoTZBOdMgStZjbMEoYNdeAQDkGXy4dBMbBJPjBwYCnLhCWtHdE9aFzRk7/gzfpgWI2hYQKIH0OUIYehKe62LXhCDCVzt0mnu25MNZz/a7eDp2BcKOgLXtrkEvqBQ1NkNhdRyLZQIIH0eVkCCd6xs4vtlVDuKtQHKYL9KeVxgkkpOeRkEKNtkvt1cxochmkFBol7Eb3849pXYasPlnwAWTQpwN5YwQ7Zp3LhXogFazPaQozWeOvbEMCvyTEamlOpsJ4jgnG4zHC5BlDphV575m5b9LwCdvL/tQhu5RJUTxrv9Lu5fJwInEDE8KYwuZsuTZXWwpSmC6EsyaZgYkywFFiba2J1/bH7EOk9D9rnf6QzXwKatqN+iSx+EPEdoWSeJNepCXqRACOgi2QmKqgsjLKkyGM6EYZE1y7wt39Xo79g9sAcJ7hPH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:21:16.4528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a804274-0875-4f74-f306-08df03c8ba69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

From: Tony Qi <Haoming.Qi@amd.com>

[WHY]
The maximum source viewport width the ASIC can downscale from is held in
dc->debug.max_downscale_src_width and is not visible to userspace. Tests
(e.g. IGT amd_cursor_overlay scaling subtests) that downscale a plane
cannot tell whether a given source width is a genuine hardware
limitation or a driver defect, so they cannot correctly distinguish a
SKIP from a FAIL.

[HOW]
Add a read-only per-connector max_downscale_src_width debugfs file that
reports dc->debug.max_downscale_src_width, following the existing
internal_display debugfs entry. A value of 0 means no limit.

Assisted-by: Claude:opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Qi <Haoming.Qi@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1a574f508b8d..e4c92b1fa22e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1286,6 +1286,24 @@ static int internal_display_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+/*
+ * Returns the maximum source viewport width (in pixels) this ASIC can
+ * downscale from. A value of 0 means there is no such limit.
+ * Example usage: cat /sys/kernel/debug/dri/0/eDP-1/max_downscale_src_width
+ */
+static int max_downscale_src_width_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(m->private);
+	struct dc_link *link = aconnector->dc_link;
+
+	if (!link)
+		return -ENODEV;
+
+	seq_printf(m, "%d\n", link->dc->debug.max_downscale_src_width);
+
+	return 0;
+}
+
 /*
  * Returns the number of segments used if ODM Combine mode is enabled.
  * Example usage: cat /sys/kernel/debug/dri/0/DP-1/odm_combine_segments
@@ -3045,6 +3063,7 @@ DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 DEFINE_SHOW_ATTRIBUTE(internal_display);
+DEFINE_SHOW_ATTRIBUTE(max_downscale_src_width);
 DEFINE_SHOW_ATTRIBUTE(odm_combine_segments);
 DEFINE_SHOW_ATTRIBUTE(replay_capability);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
@@ -3753,6 +3772,7 @@ static const struct {
 		{"force_yuv_pixel_format", &force_yuv_pixel_format_fops},
 		{"trigger_hotplug", &trigger_hotplug_debugfs_fops},
 		{"internal_display", &internal_display_fops},
+		{"max_downscale_src_width", &max_downscale_src_width_fops},
 		{"odm_combine_segments", &odm_combine_segments_fops}
 };
 
-- 
2.43.0

