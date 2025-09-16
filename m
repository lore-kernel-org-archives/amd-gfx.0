Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6620CAC59F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF35310E55E;
	Tue, 16 Sep 2025 19:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TxgtSxSI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB29210E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPUAXN7Wh4TWlZa3UtRSsTKz3xfncA9aYUpNzbQHqLIUuHvl7JoXbZS7QwtqCr2mdRMLyYsW6qG0wNrDA4SMpN0BCI1AYo/bjYW+clm3vFm3JAWJO3wxkUb3Q54IjuPlFy8rIeLV3fyJGfrciia5bqRZFGVoI7372XiKx5aRPJ8cPceqW6Ju5gXH+xgx7PNkAM363+kXOfJL6J3gTDFZ3BictFguQ5AEBMPcPohFAVhke7yTn4K3cixACq90wuy+vMgKS9omu+NwKpWOHI136mq66p1ajVnKk4kymgSMCCiTgqrvFdZ+iwvbM2OyFlhvA4i+JVIWVDt2f5mNlkLpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cstgD494b7b3fLvhnh0jF1iVNFW8RRKR9qis7yF+AcM=;
 b=lpxZ7FxM2XOl+Mir5r9/eiHF26rNQIuOOFS990mooZc61nNRPbXz13wjQtC0FcQGtPxfdW0p6GZvUqOD/t2fZfJYSz7PaOs1B31B4XZFkRIinxfl4JKolXDLEUnpvOEaksMlF4EK7zvv6r3Sab33YButdvfM+2pe8AJ88HE+lmrDrR3zIqLmBV1Q1jSwJg0pu5eC2F8NNCVagAectSijuvRZr6lgaRjOusPIWlz72JxS7Y+29fyclbxUn9ajkeSGzGURIxfhjH/nKCPsOldUi6ZnRBxLJe67fiqfSK74y//B2raMV29TOaBEwwlHvYcrTTRIKC+pYgrNusMHPJ6DVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cstgD494b7b3fLvhnh0jF1iVNFW8RRKR9qis7yF+AcM=;
 b=TxgtSxSIXFvPC32HmIiO0dP58aQ1H2SoVtAbpa13EyWlhjQyl4Y6K2wdcbBXKfHnNK7XIwJpBxT5PYNHl8mSsGg8HORV6TwYLl/AQAiUKtr35dR1BeedY8PzlcNhbYh5cf8UbchN4DYmMd6sL1azxMz5HR9YAk1NlcKmgbsAYok=
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 19:12:18 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::73) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:12 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:12 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:11 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 09/20] drm/amd/display: Use mpc.preblend flag to indicate
 preblend
Date: Tue, 16 Sep 2025 15:09:29 -0400
Message-ID: <20250916191142.3504643-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: ac309b5b-62ad-425c-bdfc-08ddf554f406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R17GMbLYlmuY0Buq1iJ/x5W4FrQYa5GXUuXh3XAl/CrlVBenKwdhvYLARn64?=
 =?us-ascii?Q?gcOt5HwjMNccX5R+/bL6x/NMPG4OnkNpJKiczyCuOLvejp54Ed3dn86jsi6D?=
 =?us-ascii?Q?pHSLz+6wvHP38bLlpiFhEY4hgK4kVh8fCC42uiuwDO3wy31GsZeGi2Cvr7J3?=
 =?us-ascii?Q?MtzFJPetSwuk7Ekmq3tlF/Xq27MLz/qGRJrf+eCVrZt1mZnwkQK0QpH6c3Qd?=
 =?us-ascii?Q?NZw86OWGuA9XLIMlGdymKTp9+0P1ktQ0kPK5SZ2gqOQk/Sqn2go54ABBTvco?=
 =?us-ascii?Q?/Whs/t1mQxxt8mHBBI5cGmHELPPJA+5TWIvEHbuXQrHMfFitpRDCW3mTQKF/?=
 =?us-ascii?Q?pG7qQ1rJAkNAWmcH8QBteWWXe2sKXBkPb5NfI6V7qinpabraZFJAvFYytA+0?=
 =?us-ascii?Q?9aRQPMjif93IUopgUIn3pWfWOH/Nfu/vFmhAZFoNXQ6Pq6kRZULlKrQ/5KcA?=
 =?us-ascii?Q?euoZc3+3WZhPJlJdgbucEhC6AoF2aCPMHTjz6DIYeejbESNbb9hdsnE7WUYN?=
 =?us-ascii?Q?WIkgyWgr1+9fsm0w2B47gb0XbQwbYRT3VVhO+lu8jVTCMXwAOTrL4wCptfKC?=
 =?us-ascii?Q?XTNd9MBXfWyrAR2cpsITLei0djYkQa4Zr8blAuWggz6GLxUyPj2jaqw7gUmM?=
 =?us-ascii?Q?W1P4mqSMIehNGPsWNLtyNvE2Qk9QaGAv3qMLTeho53ozc5IG+EVvveaAodQN?=
 =?us-ascii?Q?AEoKKPN9QE+Z77YJZUzQjdPVfyFEW6xCgw+T8IVsDZ+Zork9BG/nVR6G512B?=
 =?us-ascii?Q?Du5lkeXQWPea+uBMp/7+3RfQ65w+ekJwJLTqf/Rs5jgFNrQfb+oaD5VaPbr3?=
 =?us-ascii?Q?0gCjcIi/QJrCCH8PP2LpdbM9ABECDJdrcxkEQPzLGBuzMOxxsPS0Fn/uOoeT?=
 =?us-ascii?Q?yRv10ok0k+cnsTZUh0PYTqDvSNx/ocMyah/qBt08u1QVGUBa/3hXXqVWkxlw?=
 =?us-ascii?Q?xubnTlfAG8EULMbsVs3eN8NArydVACnl8fOvNDLxprxf48YRoKllxouXpWA4?=
 =?us-ascii?Q?sjbmlVrZw0hE8PIRgSHW9IMKRhaofauE5sLv3oR0b7sm761YqgIsKiqxjZTv?=
 =?us-ascii?Q?igQTeshtXtH+JVLJn7/O2M7bs4Qg9KZn0Ku19a6KheKS2gCdh5pxqJ1PgYQ4?=
 =?us-ascii?Q?cV1PpvsfGnnKr6e483xDS7chExPeR4AuTMPUgagyuQCt779ExTAguI7+Egt4?=
 =?us-ascii?Q?ReXneTSz8kWpqkXgDauzNVes6tjQ681o+WweNBFcZXBPjnUhdKo1AC4DWA50?=
 =?us-ascii?Q?JzxglkkyoVbetYZHHQFRF3mlT/if0THqOBi12/aZ1bcHNJX6rK0xZhlT/kT8?=
 =?us-ascii?Q?8mTJ3W+hoGF557jeAlbjsQ9ilOI3sWEiAwnSaIR7HQ8+4gv5HP4Baw+Qr8qO?=
 =?us-ascii?Q?yD00/5T17khl2SV5jcRbg1eobYSSdNYabBJFC5XSvLp0ozkuEd99dUn0FhRk?=
 =?us-ascii?Q?C/i6xNBYFQua6ef6BbQ3ApGKMaiwbnf7QDz+NF296srWfeLlg/V/DxkqwzQV?=
 =?us-ascii?Q?KYmBu+QQrwsi5PWrEMBezUnBUFeym7ZbE6M0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:17.5811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac309b5b-62ad-425c-bdfc-08ddf554f406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Modifications in per asic capability means mpc.preblend flag should be used
to indicate preblend. Update relevant paths to use this flag.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index c7387af725d6..b0ef157f1333 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -821,7 +821,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
 	const struct drm_color_lut *shaper = NULL, *lut3d = NULL;
 	uint32_t exp_size, size, dim_size = MAX_COLOR_3DLUT_SIZE;
-	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut;
+	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 
 	/* shaper LUT is only available if 3D LUT color caps */
 	exp_size = has_3dlut ? MAX_COLOR_LUT_ENTRIES : 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b7c6e8d13435..96914f372d53 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1633,7 +1633,7 @@ dm_atomic_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
 		drm_object_attach_property(&plane->base,
 					   dm->adev->mode_info.plane_ctm_property, 0);
 
-	if (dpp_color_caps.hw_3d_lut) {
+	if (dpp_color_caps.hw_3d_lut || dm->dc->caps.color.mpc.preblend) {
 		drm_object_attach_property(&plane->base,
 					   mode_info.plane_shaper_lut_property, 0);
 		drm_object_attach_property(&plane->base,
-- 
2.43.0

