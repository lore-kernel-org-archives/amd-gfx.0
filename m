Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506FACF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E943210E7B4;
	Thu, 20 Nov 2025 18:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qHz4u7nq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0283B10E7B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpmZAjXZhdRMKMArigkwZH7I2R9amm7bPnQTvb6F/t9X1f/Dyvg73Mo0EYbtetJbr8bQ23E9By1Dhs3cImxJX/NZUJ+QYPVw7DsRXO65LwaLLWtOh6MROB4Wi02zyMegAYo94ZqVLYJHsGAg3rqubfCIspXiVl4XvFmfj93EOXCDAP0sNKElHnba/rfdHkJ0jPiRxlEeICjcp+ABATxqnluNjW5r1xG6rph6Vq26fBzpUpV42pM8yMP2/5/OWpBgdetSPPmdfOtpB9s+h6hcqsBUi2j/WpW5xDZ0JNUe6KoqwoY+tmhfpUtw8/lz1PbHnWOsuI7Z7Cv9l0Te6ZwSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIS0VahadJgCiMW89fH6IkufRVp3ZWAir/Tbt5laF/M=;
 b=Uzp6kVI/Gka84WHL7H2OKzs99DB2LsQMQfxe0eZFTPWwgNHLmOljsa3rFsw5xURNtJ0Sa1KIRZUfFbVnJgPMKkxMpRJm1Te13V+VtZmMKhoO1TBAZWnCsKot+rHVuJsYBcB/9D9Te7eNWaA+Ju3pYNBRxyc7yfsX1l8kN5wfsEk0WaOw7YI8yMENC3rG88M0j1/4J3oNaXsuTTAcfYudmA15tEDB+1DtCTX4vo7p+pUY8eIOSW9EwZGH8B4GApMyF7E9LS5nj2YFKDFTiGpuITM/1p4ALpyVoPZO6rOWOH7XIU12wszcZ17Qesuap14cby1OZLIknsm57GgiHkWvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIS0VahadJgCiMW89fH6IkufRVp3ZWAir/Tbt5laF/M=;
 b=qHz4u7nq3oseOIkRdzSUODtyxTOilj4MBZNDqlSVSENzAKSVGlmyjrGAaTLQUHzEEX3FgKAbtFj/xYRQmEaI+2jnzlPTFWjj6UpQqsYi3F/PTz3yO7cAoIt0z4fL4Iu9QeiwU3EN+NzJsHn+eEEP5UMZz8xuvwMYc/3nrBssKYU=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 18:19:24 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::a5) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 18:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:19:24 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:19:21 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 10/26] drm/amd/display: Don't change brightness for disabled
 connectors
Date: Thu, 20 Nov 2025 11:03:06 -0700
Message-ID: <20251120181527.317107-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f2f4e4-f92c-41fd-5aff-08de2861555b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imCNm/IMKrIIA9Wu3bP9vlMV0dB6t5DYHrCLUAdJpuEEFURKHJInOoiTp1aa?=
 =?us-ascii?Q?kC+jk4ZN9f2j/yjZLv1E4naNGsAL7z+AHtCrTmHT9uG+0jJsG0lkKx+sDk68?=
 =?us-ascii?Q?mso4FeCBXnHvXl3XgpiqrQt914LGJ0AnoYvkcJgocqC7tSDvqMI7DnFJoGKX?=
 =?us-ascii?Q?ctiO2fBxHRGVpqDyz1AneSeqjs4Bgjq+J64Q4bCaQjzbf73/AwxWEkN3Kiop?=
 =?us-ascii?Q?SY3snJbngLMcJgjPaclqZUQhIQ26u18Afn9HPpPqX1zb9esJsaZyBBvbUmY+?=
 =?us-ascii?Q?Zk4NFOoSdLZJs1FbpTaeoXG3RVKQu4nZje0rtA+Z6rQudlzlyICuiuN4wy22?=
 =?us-ascii?Q?04lL1Z6COCS4Fjm5nc3+EJTiRFMYBMaoeG3p1eGMAQkHXZrvf+DWjbXY6YJO?=
 =?us-ascii?Q?WkGc5vaUd2O6dgJ5O4T+DbVURXP0F8TJDMQOzqNpuXqoTxADmfHld1HuY9PZ?=
 =?us-ascii?Q?RsKzpotZdxEn1xEhpp30nzSbQgM3q9ClmxhmZfV9h55A5gYHRnUbm5kDd8hq?=
 =?us-ascii?Q?qiSO0+POriUCjnatus0KQqFU2Ztb7c9aOvljPVyeDSy0J6/HtTEUGuUdeik4?=
 =?us-ascii?Q?RrFqAlwjotIP/v75XKk1uoQaB9593RNJGCGngkf4tcor/2lUg/XtUcnVdKwW?=
 =?us-ascii?Q?kdTxGFYuHiwy/hMUDyJjbWfpmX2lq80BmnbC1M851FuLKoK+FFvkeTdZBpjV?=
 =?us-ascii?Q?KQsH3cpXtd4ws+YKdC/UGEXHfEnSiUnqwM8XphC3qLqlj511LwrH3egpXFvn?=
 =?us-ascii?Q?c7oJPb9RTdXRE5XG0LPoKXNnaPr+QUn3fHp0qHGISPsrflC9L2bu+XDt/hRq?=
 =?us-ascii?Q?NKc413RfWwRmwZQWpZbLR/plolJcNpDD/m88sZcCp6Yvt7RtKHLoi7cOdqAy?=
 =?us-ascii?Q?Q1zu9uEHneMCq91vql/9J5oLiTjLTfec+bKKgmJCDzEYpJEVdKorC+T6ELst?=
 =?us-ascii?Q?BRUq1EmlWISju4jyq3J5NQnglhl7p0vfOMJQ/oB90vGfc0jH2v81kynDQbDw?=
 =?us-ascii?Q?fb9zjl/6D8bIu9a7EMppR3kKLmh1xCthLLFmkjwJrgOhq8GXYnH//lidtXgk?=
 =?us-ascii?Q?OF+9ct/6nnO/wPTyr91O7y7dSmZWKGT5B3Nrrih7//apIU5v1LL1fbXkQweN?=
 =?us-ascii?Q?kXTeF6kPGPUH/QwN4Y8rfO/rKlVDrNES5E8i71YZjAbDzqIZRGnWQp4yllUl?=
 =?us-ascii?Q?WfeR0hdplGSiVW1gJHV4us4rdRw3A+J1fx6yJsepwxl/LdtKUN7cI1KlPxF/?=
 =?us-ascii?Q?cF1aJkSsfx/zcFac6ZIB9x8ZVT0XsV3PCQveGncXjk3ucf/s4s3UCkLIWJlh?=
 =?us-ascii?Q?2GiPAfLiT2AyGENTo6nyjhYu19aeD2LkBuqIUCgyxWkWg6y5joV5SkfIQyNF?=
 =?us-ascii?Q?LXxjvf/WLLBeFMsoxqZ6igsL8BRuwD6czMVyz3XEnBRckSTMgNgQ1sI8oMxX?=
 =?us-ascii?Q?DYI2qvjArq7Mcd6PMmQPMxr5sJTPIzZHvOsS14qjBMylXu7LVY71PZhdN770?=
 =?us-ascii?Q?K0tlTTXJ5leytJRyrAUuc4ObQAOriwHTOw/1EPwirMBd3j/gogQiP12mn3DW?=
 =?us-ascii?Q?0+FggMt8ZwJVh1NVa1A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:19:24.1382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f2f4e4-f92c-41fd-5aff-08de2861555b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[WHY]
When a laptop lid is closed the connector is disabled but userspace
can still try to change brightness.  This doesn't work because the
panel is turned off. It will eventually time out, but there is a lot
of stutter along the way.

[How]
Iterate all connectors to check whether the matching one for the backlight
index is enabled.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4675

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a0555365719..424020c0756d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5108,6 +5108,21 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	struct dc_link *link;
 	u32 brightness;
 	bool rc, reallow_idle = false;
+	struct drm_connector *connector;
+
+	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		if (aconnector->bl_idx != bl_idx)
+			continue;
+
+		/* if connector is off, save the brightness for next time it's on */
+		if (!aconnector->base.encoder) {
+			dm->brightness[bl_idx] = user_brightness;
+			dm->actual_brightness[bl_idx] = 0;
+			return;
+		}
+	}
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
 	caps = &dm->backlight_caps[bl_idx];
-- 
2.43.0

