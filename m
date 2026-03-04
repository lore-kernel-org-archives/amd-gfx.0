Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A8EEFCE4C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B8510EAC5;
	Wed,  4 Mar 2026 22:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OjL+KMbA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5425510EAC5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDngaH+mjrt5we5NppfiDncEFJ2zqz6S1z1XhgPyjsLEWjKglpsP57+HqxJGjYYieEzIU90Ml964LRcwdU9MWxkCggjYQfW61ruk8kEgJqP1QQvEWmpjhhLjsOH270KfdiVsMgN50xrf2/v6LIbh0gxCnVwh/xMZ+9WpVJ+beaAORJaMulmi5fwIMldFEqCsf5eZEQ0oz8nAk2TTxRW31uGG/2S+eT+G33/XC5p1laRGEHhn5/0eDsBRK+xqKqCE5fjTxNakjLCnNO1Kf6lj5WiDh/v7r1tZX2/AKezfhG3bQr8UFFpgwtlEqQsGQcGb6C8u44po6s5o0Ie9hc5c9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7+LAk/auGHzb4AC9bW2E8uZyXpeWQ0JgcMPiO2ZVZA=;
 b=jM6YcVzXlkPwYyR0ig4UykD/Rcd5o/2/eSEoWO1OOIjovxr2bj92/IAOrzRVg8bynSrrYG0wqetLc8oeGOpP8o31QyPAheAJmiTrA8IP4EgsIi5To4HJ3qNId9l5lR6cAQxccSzTKOccSzZqEA1LA+7PppXefG2vPd7Dud4DXSUm6EhU13zHA68L2lN6+Td1P00wwzEbfXjRXhlwwVq+Q6oGIjKljZReGUrR7lI+7GxHUQ3SZdx8c9vFYsfR8VkySlsYRjwLEspG65SpxLPKw4gBJ8V0wmHEF9X4lFw76OmsSHpJYnbjCN8UF4iYibyjU2GspftT81ClIEyw0Jyq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7+LAk/auGHzb4AC9bW2E8uZyXpeWQ0JgcMPiO2ZVZA=;
 b=OjL+KMbAaufF9TCuZiVe3AYJ8bi+WuRRhYxfnGU0z4u4h4O5vE2S2djmgiHKH/grLzJ9XqcXEPC/id4C6q0WRyXCOxNgT/dQUipqA1avcnt4jmlSEWWcIMZOg9Ca7vJAWc+kEJPUAtI1gx3wIvkZURKYu3Cgj1FXU0yEVBJ01yc=
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Wed, 4 Mar
 2026 22:27:45 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::76) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 22:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:27:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Mar
 2026 16:27:44 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 16:27:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/mmhub3.0.1: add bounds checking for cid
Date: Wed, 4 Mar 2026 17:27:28 -0500
Message-ID: <20260304222732.2403409-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222732.2403409-1-alexander.deucher@amd.com>
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 905d6a45-9639-4874-4e88-08de7a3d41e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: QZz1S5Qvbikf04+UCNdmig68SWh+FCOrAxiCTbz3rPAj2eOxgCy7wkaHGwAIVi5MFFSqXQRMhr+jhw+Mj8ih/K9g1fIFC/R5iR5vOFZ//4PltoElxktsKvoJjBMIHcqt3NfDEWDi4irXL3eVG3RoXVbTwAAl/PqhW28i41T50u+2jeq+JpWoye98E/XUugOBrrSj+iDi2qzXwadldxIqA8mLmqqjGHmXZ1HUtaQAN29YEawJq7TxU/oO64gHvyPn7ps7om6qzLICqZUZ1nOgl1OyvS2a9eyUyNFDq1STm8GPkuvONPZkjorxJ9auJT8VO2iaWXwfpJUV6853UVs/BAfQ6iz4ux3FSjnrticStmzAx+7q8lzepgUCmPmWMPjIsGz/WOxJxxxcAn70EA0zo1HA5bjuMgh/09pKNFoglGiMfPWP+/Be0MyDZrdZ1An0XbEIJD34QqUhWi8FneEn17sE1Ao/tz89TlyOus5ZYZ0kVE/KlE/iVmallllRfzIODBxoy+iJxSOHC0Fv9JJE344D50saBlHxYZhG+Gow8D+HbdpD78AOQ7XsH3j+ITCihTGEqIUg0q62o5muOJv33wgqdYvTVTdNIV355QvYgXIutGCqY/jo6rSX5hrLmRygf8645U6jxq2TrthRW5tzRJn8fZIxkkFlZqLDSQkZvim0x5AjlY2e02sIH8XtYmLsAqrDxlxeZLRqv6uZsEeyki9k5kjWuEPrcglB6CLdDeupG7zezTi5GOv5JCoL4a7oQzamlY3QBILt+32hvAwZ9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Ak2FKKMCimg3Etq7wERKbMka0mADrXMJ63/iLk1/RTaR+tXxvFGORpsUfBZJs0FxA3x/tUMG3FdnChQuw42LBq5C0LEsxgb8mTPeqU1lvi+BZCVEDop9HZzKX8facGY/bRkCHMc4G/gwWz6dRnyRNsvIqNPpcC9k6LZeQRVLFIL3/XHipRPy1FI5oBOgG29IUj/p/jLLjm2M37J+HqaoiBsawMbPdsG1DlbUd5tGmlp25gvXUp+jKiQ0ldsZQEvPumYtahlGkzLudHe9vqg7IHr+/PcNl9oM5TKvdD5qbCfTJndaUJO2fE93JKRjlzCeKHWcqlyBTOIgYokdNrjtIiswUAlr3LKCfJ1fcwsUZfDn6P6dtIm3BVXsG4iToXl94xgx6bfisHbuW9iNtNRZ+OYRWr7cEGxVC0V3TFJheTMJWs9ulrAzay0ykowNUrA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:27:44.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905d6a45-9639-4874-4e88-08de7a3d41e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 910337dc28d10..14a742d3a99d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -117,7 +117,8 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 0, 1):
-		mmhub_cid = mmhub_client_ids_v3_0_1[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_1) ?
+			mmhub_client_ids_v3_0_1[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
-- 
2.53.0

