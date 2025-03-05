Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757EEC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E1A10E158;
	Wed,  5 Mar 2025 05:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PxKfisU9";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86E210E158
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtIGIcq3tuYF4zVjKr4PdcrAq/HDn1BsGpvyintrm+zBoM3phZvDezpesEVm6Ri2HbukxRzdFxVArq6K36BKfF13wgXazjv22xby+KtS2qQRSGBCM9DwuD/p+9PVyxNSjGt4p4NeRWLPUKpTiWCYmHjgJGjDTlZQWfeTS8wyqsZ9RATfStDGDdsOwhj7VBJ5hi7gSeA2v9nxTT/qZFWy6laAd0h7p/X9AnHZmhkEtU1IZHOWCcJynIR65AH9PMpNnb/hjbe1aI+TKfwVgYOg7QkE7LAspBHjsl4ztbqu5UZVyJy+BeirONAVK4BqkEzW2Eo8ObJsPEJH++mX9Ypp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQeqXrFqT0rZuX5UE4C+XZt3oo6z1qgD5uqz3wUkSYw=;
 b=eK8W98nclXWFxLW4OVoGlEoineDBKF7rLyBWlzVtGUQ0jT1jkMg5eqzNcAVT2W4Cl9HRb8tsIOv5f4vmx/GDT9/UXPXmQ8xQlkx7T2ROYLMqJmfBwrHq/14TqnKAoCRQR2pHDLNVWYlCmYHTlRTnexMO0H/cc1w40qGxKeegeJiv+4RVSYG2+O48QrIe5UOg07ZHLjHzuaB30ft1INIJN3kuAEcur97eRoKeJBeYrD5Ds0e4Wd/SX1IRN1n/HEQ6zsy/svuV4/rwjYBLzwcILUQRFQ+Ww8HGIVnMnsdrKIywTR2ziI7pwpT/HtAyI3bWu8g3IDiCPdvKMq1w4OfyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQeqXrFqT0rZuX5UE4C+XZt3oo6z1qgD5uqz3wUkSYw=;
 b=PxKfisU93GSPdd08yTbKrYn1Mi9k0MFntP9NTLNAEz94EqsqqpI48B9FGzrWfh9BZeoQKJy4l+SDmrwsMJUlciMZ741vlvG/C1JEEUwDJgI2+Pc89HtPaDTJlyPQRz7KJL3lu9bt9iiB51XxEjsR74LY6/tys6TSYew42YOd1Mc=
Received: from BN7PR06CA0066.namprd06.prod.outlook.com (2603:10b6:408:34::43)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 05:14:58 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::9e) by BN7PR06CA0066.outlook.office365.com
 (2603:10b6:408:34::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 05:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:14:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:56 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:14:48 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 04/22] drm/amd/display: fix default brightness
Date: Wed, 5 Mar 2025 13:13:44 +0800
Message-ID: <20250305051402.1550046-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e77692-f0b7-4cc8-9205-08dd5ba4abfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+sIyMW6ZeMt2LWp8vYkDggnqAwQatkrH02bUyq/EbIX5MPOm/uLtysluHJh?=
 =?us-ascii?Q?ke4V1IJMWgnDnJuzF+WWNOs6NzhD0A8CLXSeJFRi60FklNCju2T4E/Boijra?=
 =?us-ascii?Q?5VcWZM1KJkOKMZqzZbRsWeSNfHsSVwE/NAui3e3TMSR2Tju4COz5uxzhMogs?=
 =?us-ascii?Q?XTPKRxNcqyuSyCkDi7O4YSS9C5PbfCj2Dre/yeR9X+FQDHvduOoocZTzSAk6?=
 =?us-ascii?Q?KXI+kDvwRAdGwk/C8yeoN6f0jCB8nGIfQm52s8TPZQ+TiNvBxBjTb/HKNsCN?=
 =?us-ascii?Q?QJ6Z6ZgXDsprh8ELpb1Ci8lR1GWDg/bV56KdVWQi+cs6qQcuJ6K2ZiK/w8Hi?=
 =?us-ascii?Q?B4MQgJZ1QY0vMlTyQrYEh0KoUNj/KiLXHMXgThKzoTh63Qb8XTdTBGdvtOuS?=
 =?us-ascii?Q?ZoYTb8WCXNTxCEzjdx5ne1dWlRtMK51hH5qQWBUrCHm/FCpHJXNta0rm05xf?=
 =?us-ascii?Q?sRpKYe03/lOoxkSeQGmjtIpVidY2SgROR4CiLF+y9JGwrsg7iEjYXcuqUZaB?=
 =?us-ascii?Q?MkH6T3X4U06isCK7Ymlb4hA5TzETqwP//8TUo5gWKIrAadTlHvphR9CnKqZW?=
 =?us-ascii?Q?MWo3LQSlDioXm6UwD0o62F3AiKWL3xg637X4T9+7/CvnstllUpw7DGH0zJNh?=
 =?us-ascii?Q?Bd6+m8uMNWPa9K7bvM5/NcpR7ARbNp8MG+dNMqslvN8Ifk0XbgfpUq+ZcwH8?=
 =?us-ascii?Q?5ivw8rX9veln4Hmtgu5Egg59yF6u1mCbeuT8Ica3GZXBIaQ7s4ggAopvsoFD?=
 =?us-ascii?Q?nhZTrTnLQRa+aXhHr4ivDS0wwcBu6yh3i8XWIYC1dxtLWD7ykKFa/nou1F1n?=
 =?us-ascii?Q?GjwT57stAHAXgPz7VZfQ5H9IMvT5dNN/mhDlsAsMezlyXoT0ZoG/u9SXdkxK?=
 =?us-ascii?Q?gs8BXnXmZZeHyHlIZ9kqAhRZfh3Hs0GJJ45Wf3/UbgKswSRGP9l7JqzvApE+?=
 =?us-ascii?Q?/pkmM+8Z6G9d/nDn8D8dHnHgHH0TYSG//oDJ2hog/KT5Mnni5QJz+sg0yiob?=
 =?us-ascii?Q?h1VuY4P+iGkFMAsjRLew38iAy+PIZcdQpf9uVvI+YUBPDgJ1Yki7s9Qv1Lsy?=
 =?us-ascii?Q?+x5FkfyWmhHAvX6GpA56EdBzCAjgbZR1m0/94RGqn/daA647RPld539PPZz8?=
 =?us-ascii?Q?t7P9sZKBTE5guoMUzS9v4hCK6cgyVY+2NQrZ7X+nc6MrT0y9wdkUyyT6SFW9?=
 =?us-ascii?Q?fktzmHwAdLuqmK8abHEznAqxTMAngKqn5GtITu1we2JsU+dOcaVBF+HxynuR?=
 =?us-ascii?Q?NqEBBuRhjL1MtBgtO+v5GZCP75Vmj/FTzu2DnIWU+WL7CK+PONPxwarJDSNR?=
 =?us-ascii?Q?Tw461AFHnr/HFJhZZ34S42UAclmA1LhwHXCkNHUAdR1WJhArI7W0+HDeuF4P?=
 =?us-ascii?Q?E4OtNKpzn/tGJLcoIwAa4t91BeaM8wZf4c7UShc0m1aP4+Io6FanHFKnvDf3?=
 =?us-ascii?Q?8yniHFnLRM9AuUFbBV8yHLw7hHK2Yi47DxP+6WbvobX2S92/g1sOSGeDMhmA?=
 =?us-ascii?Q?OzP3jN69PQdJB+g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:14:57.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e77692-f0b7-4cc8-9205-08dd5ba4abfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
To avoid flickering during boot default brightness level set by BIOS
should be maintained for as much of the boot as feasible.
commit 2fe87f54abdc ("drm/amd/display: Set default brightness according
to ACPI") attempted to set the right levels for AC vs DC, but brightness
still got reset to maximum level in initialization code for
setup_backlight_device().

[How]
Remove the hardcoded initialization in setup_backlight_device() and
instead program brightness value to match BIOS (AC or DC).  This avoids a
brightness flicker from kernel changing the value.  Userspace may however
still change it during boot.

Fixes: 2fe87f54abdc ("drm/amd/display: Set default brightness according to ACPI")

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 73c95c3c39f9..6e2dd3555165 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4926,6 +4926,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	dm->backlight_dev[aconnector->bl_idx] =
 		backlight_device_register(bl_name, aconnector->base.kdev, dm,
 					  &amdgpu_dm_backlight_ops, &props);
+	dm->brightness[aconnector->bl_idx] = props.brightness;
 
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
 		DRM_ERROR("DM: Backlight registration failed!\n");
@@ -4993,7 +4994,6 @@ static void setup_backlight_device(struct amdgpu_display_manager *dm,
 	aconnector->bl_idx = bl_idx;
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
-	dm->brightness[bl_idx] = AMDGPU_MAX_BL_LEVEL;
 	dm->backlight_link[bl_idx] = link;
 	dm->num_of_edps++;
 
-- 
2.34.1

