Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C56C25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E64510F2B3;
	Thu, 23 May 2024 19:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xv4a4acn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B7510F2A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3u/PQsZdtpl1WtH6GwohrJ51aHyMbBb6Jw5+KB6fEU0wusrLiQsXOkT07Eq1fhLwZ/PyxkWw/gM1CB0SzAPROcXlmYF1xDOAc5a6fNwG+ZmUOz4IkPGbTa4WGcZ4JeAhGG78g2ym3JWddy+/aCUNLTnUN+f32vOeAm0w80T8JtmJuvRDYmtLoBWunkSTC/hNlU/6PpzgQRO/12EbnyDbNtZLAmG5Oty/qlZQSKiJY0TIPy3EvcewZmLpCewHnMoyT6h/o94cGnyWcFFoQ8J8dEM0GXIftndA0eXELCOqHNOQJy3YOMbDpfB/NUzLI8F3ohI5bCfqT0y850jzlxz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvVVfn+VpQdYy73PCIbiQ1koofoWnI6Y40RlILqYIL0=;
 b=Ez0qWtLvHcivFywK/V7ToLKDrA6xfwa67Rd/k1zK8mDVEUnUwCUtngAvQ+EV+IlRaP6RvOIb+njvB7j8xAYu+M4lzBZlePEqEBfsuB0Yee9H+4xZW0xDsnpm4oM8R6UfQez2bvwNd2YFjLCKc+H3i0RlCgWrTkerDIQQIrPoKQ9xPmpJ6jacq4KNxuEbEMsQ6sevOs8MyeGOFyApo0BRM2P6pc3HIjIhF02k5wNpjJzUFvYet//KYXX19MH+ZqyJj2z41bW9seED4nAnI2uBdRRLafG18Hx6SFv4dQ2uLYXeLoG1ItzQayOL+2ZQelAeteuv7QKr/R+wnk8JH66j+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvVVfn+VpQdYy73PCIbiQ1koofoWnI6Y40RlILqYIL0=;
 b=xv4a4acn2DpJRiX5b0OTT8cvorCbAEiAJuHkjKHmPkPslBA4XSCFyIIqXPzuWtsa+xok18VcjRGarW4vER9N/Am7a8dxMG/igO9aK76B9spQk8VM15IamUu8refKKpKUAyrWlfvRDcBfy7TzzyidIVetH1sb3jWhZoC8Wuo4diU=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 19:21:24 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::1e) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 19:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:23 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Move some init routines to dm_sw_init()
Date: Thu, 23 May 2024 19:20:25 +0000
Message-ID: <20240523192027.50630-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e20736c-cbd8-4006-68fb-08dc7b5d8934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpgH4e5YAtYahxkwClCDytqX+NmPEFP8v7NCD2fAwnpIkcf4teqJyniELRoS?=
 =?us-ascii?Q?nv0NozWuItHCLWsHSgGIdEyuvw9eVcuq4pFEaGaTfN3NQJXk5iMOPqLLNhMb?=
 =?us-ascii?Q?U/lmc/NYYXjzCqjYPSt4qu+ODMh2mwxvlPcRVQA7PVtVE9UfiHlNRFGZwWgS?=
 =?us-ascii?Q?LPgWTyPnJWXGARG5AS1AsQdRL71Cp0a1sdxLcda8h3BGIHRe6VpAHpas6xYJ?=
 =?us-ascii?Q?KCHb332n9YFUneq1IkTNTysdaNZBZb1Rgi9R2Yl3ORwaBkQ7sVQRUYsLUwfY?=
 =?us-ascii?Q?ecZooN/7Hzm+zDH4/TbU1/M0CZbJnuIusZT0P1WtZ0VEj+GYZHhr6gAlG4tc?=
 =?us-ascii?Q?XDQbCLYJMn7QGqTCjNmfTLOX1Z+AkYyAIJlgmuBSLvhldeGFZ+3MwkH9tQIr?=
 =?us-ascii?Q?D3WYDczzhWA6IZrCGPxfkjdrlfN3XurQPC75ilzqw8ieIw6WnkDDghPG+uqK?=
 =?us-ascii?Q?ykZzHfn+pNTaTaocD5flumxinz+tw1aVxTaPdNkymGzlpBILLB9A4yw5fI1N?=
 =?us-ascii?Q?P+sZR6ey8oNVIbwmjDuVzLYTRpsla8jtsakA2S4G9NiyJIFD+NxcqI/z7HQs?=
 =?us-ascii?Q?0n0O3ztHW7GImoOKvQ3fG5fHUhN8SNjAxM1SmlwLTKgdyC4xTUTDREyUFpV7?=
 =?us-ascii?Q?05n6AAuClkE+eomQn0PA3DLe2VBc5L2AUE/OXTIgnf6lLPsStORtt7Ekc1gS?=
 =?us-ascii?Q?iDRjG+pYKlDkovviiWebkpBJs1VTCZRMK9UXHGs2lUcMm5KLhOYY26dnnJG5?=
 =?us-ascii?Q?2/tFkVdXcswmQUJgq/ddoGzSqZwO0v881c081IvrP4gkWQhwokyi4bE3w0a0?=
 =?us-ascii?Q?iJEhLahXxQTLZfRQNyQAKddVm3s+bbmO2QGlU8SweSR1duL+AEHdS/5oVIqr?=
 =?us-ascii?Q?y0qd23454UOKGrLeZfU/SpFKrQV/p0IvXMu+hyCikd0JDtfr7rOW42DfPiYE?=
 =?us-ascii?Q?pb4eUmoiQO8vlFVYptCOurHKAOKGPJhZ3Ek4diBgcYj5aZkQJU8wVJaTZfjy?=
 =?us-ascii?Q?7BmZlL40gIMsFHS1v0aw0VBsoPg6JXGHgPigsStSF4IdsgLAlV3cfT34kcS6?=
 =?us-ascii?Q?4t/ix9u4ryf39hMpy4zyvu3g7LxEUCSl9rblQJAciF7SF52FG8flcN6Wmjap?=
 =?us-ascii?Q?8ufWDz0e/0N8looo2yKNbZEkr+objRWTVco/1pRm10EHww2sOWpyatr6k2m1?=
 =?us-ascii?Q?+K9ef8U+csiDYIgc1auyZTEduyxrMPNQboiL22Hu62ModyVBX2W/Pyqs0ZRe?=
 =?us-ascii?Q?/XFqGa+316GPHbJowKqFguEFWsWY0BGpa6ZuFiDbM9QNagCrDyUpJpe+D8Dp?=
 =?us-ascii?Q?oSvvot4OzWw9gUUyFB/G42xwBb91ruD7Nr9fpJXE0xp3SQrNojYMh+R4NVz2?=
 =?us-ascii?Q?rlBok/3L0HzEHpX7Tc14pn0wk/QH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:24.3387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e20736c-cbd8-4006-68fb-08dc7b5d8934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

Move creation of CGS device node and the DAL allocation list from
amdgpu_dm_init() to dm_sw_init() which runs before dmub's sw init hook.

This is required for communicating with the VBIOS DMUB image from the
VBIOS that was loaded for early pre-os boot.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e263b357c13..bb4573603479 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1662,13 +1662,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.driver = adev;
 
-	adev->dm.cgs_device = amdgpu_cgs_create_device(adev);
-
-	if (!adev->dm.cgs_device) {
-		DRM_ERROR("amdgpu: failed to create cgs device.\n");
-		goto error;
-	}
-
+	/* cgs_device was created in dm_sw_init() */
 	init_data.cgs_device = adev->dm.cgs_device;
 
 	init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
@@ -1752,8 +1746,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
 
-	INIT_LIST_HEAD(&adev->dm.da_list);
-
 	retrieve_dmi_info(&adev->dm);
 
 	/* Display Core create. */
@@ -2321,6 +2313,16 @@ static int dm_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	adev->dm.cgs_device = amdgpu_cgs_create_device(adev);
+
+	if (!adev->dm.cgs_device) {
+		DRM_ERROR("amdgpu: failed to create cgs device.\n");
+		return -EINVAL;
+	}
+
+	/* Moved from dm init since we need to use allocations for storing bounding box data */
+	INIT_LIST_HEAD(&adev->dm.da_list);
+
 	r = dm_dmub_sw_init(adev);
 	if (r)
 		return r;
-- 
2.39.2

