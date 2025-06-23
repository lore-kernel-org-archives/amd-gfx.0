Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D2BC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 17:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205DA10E432;
	Mon, 23 Jun 2025 17:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTydyO08";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCC610E432
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 17:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlbT7KB8YSeyGQ7yEXnsDsAkchbsBeQ6ETBfI4Ptj6QLn+Sq5OQFFbvlxWL85/2xQ59IiUGFwmkA3je5IcQ0kG6m1282dT97oFRXEbu5bLEEpi7eClbOxuilpxCPRKeetcg1VaFw74UbsOYZoSva6MKHD2EHvszWVH+e4Bccv2ylXnIka+o1fZOG1w027P9WEza4PS6f9f4U1sdy5Ufeg+sEbUBfxVsFV25Pq8/ZgXMB9GAAzUI8B3qv4IYUXBjEnb1V+omiFKh+dAT9xbdb76dHqavxWmZh31Exmb5OKI7WZMWg+cCWvJEekMg5KSjPGTVluQOxX/2WN4kpO77mHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpPZTOetR8fLKrrjIE7Nab6QFT7A77RH+ZrqXnHktt8=;
 b=uzbgTTvAtnVu/4M0QXYPCIwFCtiR3+5mGT08jGoBp9BCsE3xcHtYNXHDqrpU/DBhFn0IOt0aSIoZP1BevgYywlKAw18YoBwesflnZm6mAXkPC22ClA8lPiO94uDVuULDcpel+LjZO2fb0Ood/h9cJyMaZiCdBPHG46wf6WiRxw62mvFjRK5p2vZ5a91cs+KGBCSpbVbXDjPEAaet0z7BZezSaMYjuafomLfTVrqUjKAxN3tHlklvyXWBs2t4k8dpCtRy2fZiLB4xtNKyMGRurv08tgcBGIg1XYa4dY53g0FEGvhGCdcAoiHTaayEeCbbNQuWNB+ntNlQxrhpjgVZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpPZTOetR8fLKrrjIE7Nab6QFT7A77RH+ZrqXnHktt8=;
 b=JTydyO086kc3aJTJklVspVY+AzL7nqsizmjcAWfZCCgx0AsKGpGwSvAM/Qb9KBIQFyQDEzA48+JYta53V5qnDFrQVbcp+HeM7E51DjLd5dBuOi93fzG+G1sdgVf905hG5nrU3ElZ52q+VSaLIdbP6J6bt1p184WrmpwjxbDbFIU=
Received: from BN9PR03CA0794.namprd03.prod.outlook.com (2603:10b6:408:13f::19)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 17:12:11 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::d8) by BN9PR03CA0794.outlook.office365.com
 (2603:10b6:408:13f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 17:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 17:12:10 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Jun 2025 12:12:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
Date: Mon, 23 Jun 2025 12:11:13 -0500
Message-ID: <20250623171114.1156451-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf7a3a2-9352-4b0c-e209-08ddb279170b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TfNZndDnZZG3uk8g6JZUPhY5g9uPPbbXOxX0Wt5XsShC82ip5Kwvbhli5WWz?=
 =?us-ascii?Q?NL8t7hyNUFuK6yOVC25xayS6FwOb7YbnK/eB08wGspl4cWriJxZTeAib6feP?=
 =?us-ascii?Q?jcxj1d9k32MOTsku1h5NifSUmosKEospgKiTHFKQWtAmtX+bMAVbo0nQPd74?=
 =?us-ascii?Q?Ir11O/y8a9cmTSHqc2iKH3Aw40JpsJD1Jmw/FPMUj+6kktb/PZq780VamNTV?=
 =?us-ascii?Q?yUvqLJj9T+o7m+KLygzWFy4oz8LQ2LDLV3LX7nFY6GMC2glrB2JQOApSO7bf?=
 =?us-ascii?Q?KClMGkPzPDsL9C/no16Ar43OvX3dhOhmtMRm/NXj9AAkUMe8hM6UcFgTrze3?=
 =?us-ascii?Q?utFfykMaOYB4mPdXrhJdasaiut5xUCFcTigEKL4zFjm9CLYqKUBNh9U5NZ48?=
 =?us-ascii?Q?Tea6r8F1CmbbyfSA3GeZoa1nmtKUZtL40nvjdFED2+wiMMeVH5hjuLNeTYxn?=
 =?us-ascii?Q?NQLBUxWGbm+eZMWzD6ZWZ5Km/i8Ejh3+03ZXAziH/CyoArlqxIcaV8Q0XjhT?=
 =?us-ascii?Q?CpOtF4OjHXPFifb2bFyOKSGfTkNALYrdH7bSLOi2CH2Q7Wkz8joLAam/O6VW?=
 =?us-ascii?Q?Nzxb3JvVVpq/xV5C/kNxaErdzsQD7wyDwE0YN5gS2jsIiIfSlsmb/P1+lgtr?=
 =?us-ascii?Q?sLm5mp4KPvQVoazhL8ENBxx8zEWoM3Asui4FmaF8BF+M8HdEYOwUsD7zLaWj?=
 =?us-ascii?Q?MZrJtagbalJDcHixj565TqjZBA9UuAElaxCU6C4LHQkmVNUQ0HdkvxguqWfD?=
 =?us-ascii?Q?6uZYfqQUFCKfTea+jA+fQwJxu3Y5I/40PgJp/1+QwLXLsttpuStXGfQ+1iqB?=
 =?us-ascii?Q?bS6YfnlrtJ5XXDc7OlZVb2kbXHTPYhllqrJgj/vAoJhJPPmivJK/8fr1N66y?=
 =?us-ascii?Q?PG8RBS+D6UdMt/7GS5ZxxGrEpd7SVoa8itE/1/RINZ3IrnOmWjinfE2LW+yl?=
 =?us-ascii?Q?dRnJqJXOuB+Qfy4SBFrL8kyAQCj9iGDKlsPqfwHslP4XmCdC3jpUSD1kqGiM?=
 =?us-ascii?Q?nJzwOnlLkiwYkSUEPesK8h6/0bJlZV/GTQj7MhqFN4D0k8m0XJV7ON1W+EWb?=
 =?us-ascii?Q?80ys8+uozxydFyNQn0jj/iuIyNBC3eoold7PEB/++YGMg/+HXffZgMlm1YHA?=
 =?us-ascii?Q?hSE/gjCtP5E31b+FEyBUjGw0SGXnA7waizNkmMoNYHt4BQTV0s+vwJpRZj4K?=
 =?us-ascii?Q?sUWtYdTFakXBsipVd5Nze1yUEg2jws6A0vSEpwGIiCVJ0iDK3abziy8gUzLe?=
 =?us-ascii?Q?ZBpZCXHJNT0IA6fw7YM7D9lDyb5YU+wFIlHHEUwTz7CT8dsmyKfL2ipOabUi?=
 =?us-ascii?Q?vsi8MPLvyxGEbBG4kd0IbZaMh7jDhzxwR8vjysgzE/8WjoJiCauS1Qvib98i?=
 =?us-ascii?Q?Wq32AGrhbOGmg3SS/ZvtsAPqcUFMx2Lw78w0M61ydgRITqDNAVgCRLVAuisz?=
 =?us-ascii?Q?X6QqwqspJ91HUkepWM26MvEIt707H6yjfB4xp+D+2mzTf/x7+fLwm5LY32S7?=
 =?us-ascii?Q?a0dvEgJmVcc/sXWw7AgFhBiLJxuxzNHp+f/3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 17:12:10.3481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf7a3a2-9352-4b0c-e209-08ddb279170b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

[Why]
commit 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to
userspace") adjusted the brightness range to scale to larger values, but
missed updating AMDGPU_MAX_BL_LEVEL which is needed to make sure that
scaling works properly with custom brightness curves.

[How]
As the change for max brightness of 0xFFFF only applies to devices
supporting DC, use existing DC define MAX_BACKLIGHT_LEVEL.

Fixes: 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to userspace")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use DC define instead
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a139da1c47af..77302caaf24a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4689,7 +4689,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 }
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
-#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
+#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT MAX_BACKLIGHT_LEVEL
 #define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
 #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
 
@@ -4751,16 +4751,16 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
+/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
 static inline u32 scale_input_to_fw(int min, int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - min);
 }
 
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
+/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
 static inline u32 scale_fw_to_input(int min, int max, u64 input)
 {
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKLIGHT_LEVEL);
 }
 
 static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
@@ -4980,7 +4980,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-		props.brightness = props.max_brightness = AMDGPU_MAX_BL_LEVEL;
+		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
-- 
2.49.0

