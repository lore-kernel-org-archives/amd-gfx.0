Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CDFC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A77610E89B;
	Thu,  1 Aug 2024 07:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jGbeyw4n";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1D010E89B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK5Qc510LPmTBz0bUAx0W0R0I6aOB3R0u143FKfrrZmP+CEJXtIIecFMgw0Vh2oGKT/0wnj5ZTMWazN1MwqtKvTzdZpKt1H4j4Qfz67VP/mnI2wEDkv5fceM6+A858XY/LqSTg8gHSci0ax+n+dBc5yIdiTRtc5b62PThmci9bVqG6HgaGjpzqabOBxr2/A6CAL+1k88hJ/XUVnPqzGq48aUMOPd843POBjXEAw99lxoueS/jWNItEBUfURP3vjK1vmz7wst89LAigWxAOX8Q1bmSmj6m33zwNMUj+qDwFdffB/+aUoS9dtyXd3sMSiCEXFICbG++zMmqwgCUTCpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjxkfmpgRm4MdI8U2vGPQ8At2HzDjKomItABSsqBUxs=;
 b=EOhfK/UKMzV+89BgTL0V3fU/aLw9UlYoSBMGsxH2enQ8YYSCqaGDf64XhriM9c3A4OkzSYxJfAX7Rr5Z2w8QNt5WkXwR/iIl60+w+Jxi6vG6Kj9uT+p0xaZBpPTOd3Eu5sf5CoFY7DNlpcq1YcJyI66rPUU+PzFQKoo8472u+b2lCMc0MbejVRy9jzoH0UkvT68/VTGtQhiaRvBOu/cHkL+9hrqNCP3SKaMIxTDWa4iJ/fWnI1kJc+E5/iWv4vBdlkCp+MyU0qmobQsywtSLat34Rbj7a6g0Q/aw/3sEVBIBOYUWBkhOsASYZzIP386EHiy68cbHfE0LJodQ2bnVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjxkfmpgRm4MdI8U2vGPQ8At2HzDjKomItABSsqBUxs=;
 b=jGbeyw4nEspn4YcU6JykoamAHGSiHPGPwxfqAT24r3PI6ZdDDuGO/72UDTmtIVjkfwQ7R696T7DLKGum7VH/WXjUacZm2A4gvqd2xhd1K27mGxoSaZtMKOLkL2OEqOLYDKPxZHHDOTjR6WZLAZV/gbhT1E1Z1llsSyCeFiM/XEs=
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 07:04:44 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3e) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 07:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 07:04:43 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 02:04:39 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jesse.zhang@amd.com>, <bob.zhou@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: fix unchecked return value warning for
 vega10_hwmgr
Date: Thu, 1 Aug 2024 15:03:30 +0800
Message-ID: <20240801070333.423881-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6e4768-a561-425c-18b8-08dcb1f83837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUktMIXMDUQI4SAhNr0cpmEYyheArXG8WmuJgItaYDcO1nrvQynzvy58EV1s?=
 =?us-ascii?Q?ybizesk5hID4tdAppC8bp1hqEOXCcCIU4TErJXLWaCNdo/anGTaor2+TRHZa?=
 =?us-ascii?Q?HT1BykRA39cRJRq9vCYJk6Gk0hzh2KxpniScSfLDL0pMJm6xDUKk2HdV3gte?=
 =?us-ascii?Q?9C5NrETXf4C1EggvNTLxu+Wl1z4wkdTeolaDtM/qVC+UG/wpAy9ZekYSTdAV?=
 =?us-ascii?Q?alnwagmJbumzi/YkTr74gdbiekyTbxaIFxyUGRwRkaJ1LsyzjI7Fw+61l1Yj?=
 =?us-ascii?Q?G/dRzvV9c13V3rHMejRHEn40dY6W5i/bXqicvC9EmVEKKSku6VpbpPzs2zjq?=
 =?us-ascii?Q?XJkI8ufkQU6FkxiXvVkVOa8M5l74rFadZwS9iEbhWDyfSyLfI1rb03+iiSwR?=
 =?us-ascii?Q?9ENF0vgCcsQiEN1Fy6gFuOz48ogIvJxNP6LaqqHEN9eIKOzGre+1MdCVm8to?=
 =?us-ascii?Q?H5YudjGO3/C+7QiKz5FZbUKyPX972pJLD2QBX/2qfZk808vun5TVUmEViRL0?=
 =?us-ascii?Q?7P/G+3oBpYHHbBDQkPLLMx3u0iRc+zgzMSclrLJh7ApD2u0iamfQcHHhAhM+?=
 =?us-ascii?Q?Z7ChA0dRzraujL9TelE+ghYCQbBwmgAhJwJK1g0tRRNatPvrvOXZfXNey4JW?=
 =?us-ascii?Q?EYYjG/+LSeM2s2PD+HppVHUArdiqBrY6qrL8WN1XgmzSUT1VZVU1vatgtBZo?=
 =?us-ascii?Q?OzMJumxLAWcMWz6Yv0kkEabKIKhBncsK6Zxwf1SWF6Ey0OlRctslEMphSV2o?=
 =?us-ascii?Q?30TnrnkmXg5n5eCEhUOMbcgoIPfL02FhNKZw4wnQBLZk+0aoRml/e9BRlUX5?=
 =?us-ascii?Q?gzmQsX83kGowhgtmsloZd93j2IrXqcC6Kw070n97KHGqz1ZbYY96tTezpmC0?=
 =?us-ascii?Q?IIls5hUl7q8ZnQu1GD3PE947LAK8me+9dUw/RjPPffWKfTAmAlSXZP9toagN?=
 =?us-ascii?Q?AHSWET8aDL80SmGSMQ7L2sUxdo2qQhpiM1brjjqFo65hRv+jhBKCjTBw9WMy?=
 =?us-ascii?Q?ZW8Cvy82IHJ4Hr47mRSpEP6tZ+t/eYzpky9cHXHj8ZrwahSzkTNSVOQZaKIB?=
 =?us-ascii?Q?FupkQpHuURqx2rSdGFCFsH3PTXlm6ILk39cnHFjmRBqB0ftRdEawvGqmhAv0?=
 =?us-ascii?Q?bT69AqJdehn0GMd3yFLGThXMRkJS/LdzR0JQLfYN1M/Cx0kLX4/FjlnLYEdK?=
 =?us-ascii?Q?RTB6azJLTn29vvNz3JEOTZZH2DI28PuIiAg+PkDxbJjBOEM7knp4jab77fRo?=
 =?us-ascii?Q?9l5LLLtehgiSfMNOll59AAJdw5B5CZyyi28QiaokFM0/V+dLDGjw/DAPKxd+?=
 =?us-ascii?Q?Qve+NmwgXwFgQouiaONkYTa7jj89jJBu3as8v2pDvzRucaW34OpXFD2mL9nC?=
 =?us-ascii?Q?W8XS45XdmDfxwDD8zSVKwlIBQbLUQTtoJJVa8aeOq/Sz8gzZrWXubiFC3tcN?=
 =?us-ascii?Q?M05SQPnXWHc0NBFOpd7mXAK0C2yBZfML?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:04:43.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6e4768-a561-425c-18b8-08dcb1f83837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

This resolves the unchecked return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6e717ddbb029..9ace863792d4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2934,9 +2934,7 @@ static int vega10_stop_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 		}
 	}
 
-	vega10_enable_smc_features(hwmgr, false, feature_mask);
-
-	return 0;
+	return vega10_enable_smc_features(hwmgr, false, feature_mask);
 }
 
 /**
-- 
2.43.0

