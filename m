Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19085C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA33910E532;
	Mon, 13 May 2024 08:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kfw5VfNd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9000B10E532
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM6Aet66NB6ABxVe4ccZIVxOQJ8+2DspcR5b1MeEFCtyPApZ80IAg4qZXeJHHqUUcc1YTUxWphQD1vF+L8heWL3u5gt4CeIQlJolvBe4Goj3hr9RPPnWqjz3IWJqbo9RTEcym4UwA7mvCFvRy9X4HizO8jbFDt/2jcWnNTOXpRlcpJ8NkJCQEwzWnXstNbkKOn9NZ5mosgpjrpMZZyIaPkM774lmNVce2rKvzyRSoTKYSb8RsA6DlaAz9xRwZtYtV9PigJkiAwVetpQh+mRaqFfF5vLr6dh+4yPMZIZL30ynUwKCoeK13+6n6fc+01e4TGhWhht6nCXrj3sD1e+XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq/sXNJPAPbK4O2hPsI0SB4GZiX66FWC9+CcwBav0Ac=;
 b=kw3zhVc44LmCLv9Ig5m3wH9oTZlJvBYzke0TsbvXrzbTArXZeRpE22xW86Xt8ZU2t7Q4MzM2GRNlwDWCYSwWXoejqLNoQYSJsy+c3xrJQqYUCsh9NZ1qlXBLi0MhMrcQ5Jzvg+MhEbNsLvfR0LugDZhN/8apKEcQ4J4PEvQqNucBr2UJPJZt243J2r5Ggf16nlNdELkJ4sQLVnEXtoJY8UDf3aHl06qn8pV1cigVPXAWtJ8W2XFillSsO/q/kLbq/EfhcjdlzLs05NBIOVgyb0hvUo+lrnsorLiac9xuodHBNF2w18WbWZKEuRwuEcHhnH1IlckkEIuJOOokTJocpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq/sXNJPAPbK4O2hPsI0SB4GZiX66FWC9+CcwBav0Ac=;
 b=kfw5VfNdINDvcjggCfVsAKCF7aK30DU3WeFxqBqdvDcCKIaGwhkchU85GfHVb5bqlF5MmVSgigbBDLQbqSOXs/tnr9Lg57YpSvceQao8Iftoq6bsqW52f2GKu0bLma06QoZWlcsXLcBR3zrFvqctMvXae1zWmyg/ZqpX/MjuQ34=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 08:56:42 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::a5) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 08:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 08:56:42 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 03:56:38 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/pm: Fix the null pointer dereference for smu7
Date: Mon, 13 May 2024 16:56:12 +0800
Message-ID: <20240513085616.584249-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d37241-1d97-4b38-4cac-08dc732a9c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pZRaWzA3kwk1TCPqvYI+rDaYLkg3HUnwoD/ApX/gkliM3CCcDJxYacNUs+mS?=
 =?us-ascii?Q?NyRKQXd/bZkfBEnbH+YQe6jApG7g5RcXRWfYK2v3Jvi370WX5kKc53w+Ii3B?=
 =?us-ascii?Q?6W2SSQyRHtn6kVclhMfjpTq1pjA/XVFsmIvaPUi3kHwzG2G6L5Cryr6xBylN?=
 =?us-ascii?Q?0p2boGAOLns0qESagtE4fvcK/VrSl9RawAP1sOgOGGF5cfAkwd0hv6OPFCb/?=
 =?us-ascii?Q?j8QlcKgNDVv3+T/bI+R2/N5q21Tv3tSnrZXvqU0EGH4X0g6w81Ep2C8EZUXj?=
 =?us-ascii?Q?rJ+BRku611dgU2ekFGgc1HznriiUYMoSXdhP3yw1pJOHig0TyMhV2N4GlxNs?=
 =?us-ascii?Q?753XVHM9VdFrjBNr1q9CLg8diA85E/9RgUVItQfHV0nbw+gZtRJDHYna5Pfx?=
 =?us-ascii?Q?QjNEVWDYUsyKk2HynFb3B+AJEfVhI1qegqjdJ3qcu6ZmXteHpkKmbEFsCQce?=
 =?us-ascii?Q?7Nsm6pzgV9Ss1M9RjE/GkiN4QxlzXKV9DvnTwKlYg7AyYT1F+gTMdxMjl6PC?=
 =?us-ascii?Q?fK+/aXK9jrAU4u0OxaU9kcz217KTSE/GPk3XfodZ/78ioPpN3GH7wQ8nIqZG?=
 =?us-ascii?Q?sYI+7jV+C6C8BnIx3XsiSCpbznyJjc7h3GBULGqW/qhmV5Y14HyRnGUgiXAx?=
 =?us-ascii?Q?CLGjAChWsMEP/In/GS1lWU33R0Bj7jjOOFEg25RVZ1P9RO82PLNe6/Y1/Qh4?=
 =?us-ascii?Q?nNr2yJ9e4NOpqtR+QojJL8UQeHTxrmfUvpsSAeEsBSxCY93en7E7eqhW4P77?=
 =?us-ascii?Q?pX9/pQQ0OmRBAr3z+KfIf4Rkar0p0ycpdv0EeyEvqdlpDF/Or1QoV3r9n9M5?=
 =?us-ascii?Q?uF+MFnTRTh1z6in72BNgDKxyEP2cx8oHJLIkI4+DbD7RdWgY1i9efLl9US8r?=
 =?us-ascii?Q?Zk6JOH1wGHO7XcPUN+Xn+8MQ0FhLJkQmA4LdHd/Flp9yDHMrK0b+itGUtfz4?=
 =?us-ascii?Q?/2bptBPkUW9alKtS318oE9FbPQXLACLczi6J1kho7Me22TB1bdfXCbOFcCIA?=
 =?us-ascii?Q?VlKx33AL85NuvMCDXXymGLH18TvRnBNRmY4jaD9Y5Yck7SaqSnvpyfUaDpXj?=
 =?us-ascii?Q?junvoy0lwww54R4/04dOe26SjK/RYyLfELdMFKukpMlwQ+Xn0tQFiZtbj3UB?=
 =?us-ascii?Q?HDNpJyIw4HzSQDG4Bl3cq0cVtjO/PpDhEvU/nc3YrqpDXVb3u3CSIZTe6HIo?=
 =?us-ascii?Q?v7vuLTqnXdeUpPgYUTKPqfejuCCqh6VzJL6YMbwQ+ScRcZRVigO6sgKvdJGx?=
 =?us-ascii?Q?EUVBFBqGgMcHkPgydx8q6Namt0iwmEXeAQWHuffOJIkibuakO9aRzz1FEmZV?=
 =?us-ascii?Q?oD3jMDghaYyh8lpHf5D96DiHnspBeJ1iuZphv9DwXL7XDPOSS5oYwePpzvNQ?=
 =?us-ascii?Q?0K5wqOg8La+LHy53ImCNTdRJCnYN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:56:42.2309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d37241-1d97-4b38-4cac-08dc732a9c06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
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

optimize the code to avoid pass a null pointer (hwmgr->backend)
to function smu7_update_edc_leakage_table.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 50 +++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 123af237878f..632a25957477 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2957,6 +2957,7 @@ static int smu7_update_edc_leakage_table(struct pp_hwmgr *hwmgr)
 
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	struct smu7_hwmgr *data;
 	int result = 0;
 
@@ -2993,40 +2994,37 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 	/* Initalize Dynamic State Adjustment Rule Settings */
 	result = phm_initializa_dynamic_state_adjustment_rule_settings(hwmgr);
 
-	if (0 == result) {
-		struct amdgpu_device *adev = hwmgr->adev;
+	if (result)
+		goto fail;
 
-		data->is_tlu_enabled = false;
+	data->is_tlu_enabled = false;
 
-		hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
+	hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
 							SMU7_MAX_HARDWARE_POWERLEVELS;
-		hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
-		hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
+	hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
+	hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
 
-		data->pcie_gen_cap = adev->pm.pcie_gen_mask;
-		if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-			data->pcie_spc_cap = 20;
-		else
-			data->pcie_spc_cap = 16;
-		data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
-
-		hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
-/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
-		hwmgr->platform_descriptor.clockStep.engineClock = 500;
-		hwmgr->platform_descriptor.clockStep.memoryClock = 500;
-		smu7_thermal_parameter_init(hwmgr);
-	} else {
-		/* Ignore return value in here, we are cleaning up a mess. */
-		smu7_hwmgr_backend_fini(hwmgr);
-	}
+	data->pcie_gen_cap = adev->pm.pcie_gen_mask;
+	if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		data->pcie_spc_cap = 20;
+	else
+		data->pcie_spc_cap = 16;
+	data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
+
+	hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
+	/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
+	hwmgr->platform_descriptor.clockStep.engineClock = 500;
+	hwmgr->platform_descriptor.clockStep.memoryClock = 500;
+	smu7_thermal_parameter_init(hwmgr);
 
 	result = smu7_update_edc_leakage_table(hwmgr);
-	if (result) {
-		smu7_hwmgr_backend_fini(hwmgr);
-		return result;
-	}
+	if (result)
+		goto fail;
 
 	return 0;
+fail:
+	smu7_hwmgr_backend_fini(hwmgr);
+	return result;
 }
 
 static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
-- 
2.34.1

