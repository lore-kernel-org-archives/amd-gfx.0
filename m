Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28792CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E7010E4C9;
	Tue, 24 Sep 2024 05:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ug9PVwKp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CDC10E4CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuWIlfQvJEoDbyVmEAmzcoIQ+RkIzhNfMtthDiO3S/kMe8mkmrrCCjlswZVjx0vk0KnhIYIqTGiJ0qHseBQcsnE1pBAUPl2oHmWPlmImu2fcMsoyaKDhnHHW0titmN/v//DhjEBoJAHyiNnNIIcq95tOlmyWPHNJqdXvhrIRb0KC4bzIWRIs5rABGGOYQaAYSXTh7kzlDdWmRSWbe0gbZY0iUmwUxrZ9rX1GpCLf6XsO9VJS8hbOi71aOegz/Ggyh2LtBJ/xljh3hriKsQ5HgiWbWlgBcqz48TEExmUTTPbP+iMWTtDxbOphvEnNoI5QRGyRUSSciOIIyuOu5+K9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkvPUgpi6s8c5cr6W+xwmDzKGB4R54hn3bAKqo/TpLk=;
 b=b2H3obegnDY1Okh1YRC1eNmJxFIgiZz5/5wGXKsnazh6OsMHtnNRlfj5UuqEeUVUjL/wnx+7uxw3Zpy6pdYyybEw5Was5al3tf0F+Wf7+LHJUD8qbomg1ISmQv0McJlX0ZbW1cEKmyiz2ps3yFORZd6R7nWkLzUxI8tEYbS8xdL43kCLFNMv9i8ThT+PYoH9diQ7F3lI7tSkHlDOrvswKa11PbwApz9Lb46DLO24/6bBMqnk7fdJOaB5zIVFx+769C1quwLVqaJxa67uNMx+7jHqsaOOghx0RElVwaxYm/5WoxgZIRY8J9VGQyaA53ls0rwmOXmMJOlRdHzCiIhg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkvPUgpi6s8c5cr6W+xwmDzKGB4R54hn3bAKqo/TpLk=;
 b=Ug9PVwKpBWvJnGZfovNrAHxPDOcN+tVqKWwcaHEGMiLUy/2a1s+C/WcbVEvTn2PtEuI0eAyhbLei6RdbkywJKOqvnDi90hZh3N47lpBq/5eWUYf5BvQ1ptkcEfzeRiQUiz7+bqsnpqEZHuOTmvPvXjDDGWgffSGfPUGadGernc8=
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 05:57:27 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::c) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 05:57:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:24 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
Date: Tue, 24 Sep 2024 11:26:51 +0530
Message-ID: <20240924055652.2678433-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4af54b-fe65-45bb-63ad-08dcdc5dc4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yeo68RaODf05gNhHAYTzxypYPiEg4sAA7aasUnhYn6LsBoAqVSIF7FdABCPy?=
 =?us-ascii?Q?8LO7i5R1z45xg9XELYcA1goNU6Sxq5z2QqaFy4mtlLWEL3y9aZHn/tJ0lFBL?=
 =?us-ascii?Q?K32HnMLrozt7BAmkDZ/IPPtIT8RO9H+wqChGjEO1bc6eMHJhTsvg59Df/Kqi?=
 =?us-ascii?Q?fxqJtK1W6CoN/aeQF6E6ln2rb4e7Wx31DPrI0V6rvTfgcNtw2GmiH6dv1pbF?=
 =?us-ascii?Q?anSriqtPqEfShEd9BfgtXoRggF41gJY4eqiD4ERH66BnIo4LcobR0bskByjM?=
 =?us-ascii?Q?MOQHD09QZVUNk/4jWbUHGoNpAIlJz99M2oBMc6F6HT5qF22CnlizujGHTd8J?=
 =?us-ascii?Q?4X68dC98efV4PmyTJpvfsj++J7vYdHJdrwtutxH/8fQuxmINUNwKDbBfBsg8?=
 =?us-ascii?Q?8WkDhZ/EqQr2m/2B37XbWbLWucyBWl0RW1Hi3G5S4T+ral3EpXiFd6KLP3Sv?=
 =?us-ascii?Q?fYmZJUYbG/pXY7SmVWqreur/fwR89Z4SLHQROYZ9oKFiENBXeJfQZGKmlVfG?=
 =?us-ascii?Q?9/2P15Um0t9BDy2m01ib3T2cN6qyRU+dl/oqp1D/NLpXtSYzEyZvkmC0DIzF?=
 =?us-ascii?Q?C8JJ8lBXHxj0/zwgAgwiyfQMmLuxhMLKOEIvj/J1ITjr2E0QRa6cvUodlody?=
 =?us-ascii?Q?dvO+5J6E/1bf9asidszaBztGmOmXi3AWkM2CuFY+poGytOPiAp4W4zQoiZkt?=
 =?us-ascii?Q?RgawJIvPVzWZOUBf1R28WfwBICnBhHo02s5ZFHiTAVrbfCn+ihPqNzcky44v?=
 =?us-ascii?Q?G9NRGwehEsPf20a6j0o33rU9GNL4p4T2MzrT8VPtTVaeShLfkGCVL9/6N3JE?=
 =?us-ascii?Q?C4mC3ETFLK82y8+JL/EgYTRJ44aJG8QgxrkvufIKamstNbmf5Z33/MWdlJ8d?=
 =?us-ascii?Q?LpW6Y8psTMU4S9R2I7w5JCxzu3udtdEPwcvF+lMfcgGZ9EUKeSbzEYxHQTB+?=
 =?us-ascii?Q?T88XOHBg7yxQBY5+g3SW0WDRAKee/tG+cyOsx5hsKiqoQd3FNN4L43bgew6h?=
 =?us-ascii?Q?VxINBPobnZepVUH0TESV3WYLvm3ZYCCuG03MGsXmJGZMZJf6Vk9lgzZ0yAjV?=
 =?us-ascii?Q?eZ4PKmuXapckFHqDWOaNMhgLi+hh7Hwa8Z62c1oiUHeG4IQgtE/XDto0Xy09?=
 =?us-ascii?Q?+QkZHoD4L1EWDVbtUtfAU6mGCDLACZEH5VTIEp/C2DwnNGFg9hMIJDVgYPdI?=
 =?us-ascii?Q?3d6AJtrZ7j1dKiVPhabQpCz/EZVXmaZOjJR4d9bV5+2VhPunK5goMp8mDTci?=
 =?us-ascii?Q?5olkUzgAs3aSnjhWMy5Cb504Vyqo00TKa8RcFQFuWTIFG3idp8sNMF1MfkON?=
 =?us-ascii?Q?Z5pIAGCajFjpAfjCw/THw0Kh24gZw2jV0p00LQhSo/bJOXGq7E66CeXECeDm?=
 =?us-ascii?Q?O7qLX5A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:27.1546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4af54b-fe65-45bb-63ad-08dcdc5dc4da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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

Add a callback to check if there is any condition detected by GMC block
for reset on init. One case is if a pending NPS change request is
detected. If reset is done because of NPS switch, refresh NPS info from
discovery table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 21f1e65c9dc9..011fe3a847d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	struct amdgpu_gmc_memrange *ranges;
 	int range_cnt, ret, i, j;
 	uint32_t nps_type;
+	bool refresh;
 
 	if (!mem_ranges)
 		return -EINVAL;
 
+	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
+		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
 	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
-					    &range_cnt, false);
+					    &range_cnt, refresh);
 
 	if (ret)
 		return ret;
@@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
 			adev->dev,
 			"NPS mode change request done, reload driver to complete the change\n");
 }
+
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev)
+{
+	if (adev->gmc.gmc_funcs->need_reset_on_init)
+		return adev->gmc.gmc_funcs->need_reset_on_init(adev);
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b13d6adb5efd..d4cd247fe574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
 	 BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
 	 BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
 
+#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
+
 /*
  * GMC page fault information
  */
@@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
 	/* Request NPS mode */
 	int (*request_mem_partition_mode)(struct amdgpu_device *adev,
 					  int nps_mode);
+	bool (*need_reset_on_init)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_xgmi_ras {
@@ -314,6 +317,7 @@ struct amdgpu_gmc {
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
 	enum amdgpu_memory_partition	requested_nps_mode;
 	uint32_t supported_nps_modes;
+	uint32_t reset_flags;
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
@@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 					int nps_mode);
 void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 619933f252aa..97ca4931a7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 
 	if (amdgpu_psp_tos_reload_needed(adev))
 		return true;
+	if (amdgpu_gmc_need_reset_on_init(adev))
+		return true;
 	/* Just return false for soc15 GPUs.  Reset does not seem to
 	 * be necessary.
 	 */
-- 
2.25.1

