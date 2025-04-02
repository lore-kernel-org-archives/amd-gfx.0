Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790F5C3601B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF4B10E82F;
	Wed,  2 Apr 2025 16:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KLIqUY6/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B7D10E81D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruuQOZBD8fheU0T1iK3X1BvYVp5/Qk2D5VPUYwcOKVzrBHVZo5CavXaR+ZDXW3wchXJ/B9nUbHbSTQgEgHHpcGLhpPIlwR3pAwK4xAFZNc43gempnyEm37OxUxf6jIB8V2SzyQBkty4b0paOqMctxaetyNQgt+BnGlFvd83vX4b2VR5CIyd9R/aEEU3Wk77CQigB3JJ2diuq3bwwUutqjfL24eSm0TLSFAEXpqrKXAOPKhYFyasGkYqdWsIUtBpYOybEl3szxXQEgCtB68l/KHPuGIBRlYeWBPUcfQQlgYIjushZDDYlmvuQUn7NLdBJb5Yyoxd07mm61q56Y1ABiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qzZubG9AYS3uH4EEhCfqIdkLERJtZQXQEA2VBSK1Ds=;
 b=saHYvct1sy9vwzjZ/vAiPjThen9rdBuKkW4exPD5cpcsu+GJ6FXNbvU/KCWtSJoI6vvQ3eFUMVC5zoCubwz26YYzY+MYlk5NyMgoNLHqCOdTWT/aycCfCmXd/ksDF/5zUz0iYhPVH/Ex/CLSlkl3DeE5NE/jwa/gML7jy230+qpt/MCymU9R32Bsl1lnWMg9aieTAnZZ1EWO6gSe+lLShAWjavqMxBbfmdZvCz/BCW8FxHrb5//5C+9Ce+nIQfz0S1PH66V2vN+ut0xlN85LB5E9AyJc3RxWqnWTwWHX9v+f5RquhSsQE5+idam39KC7/n/Fu2fB3gKegw+wk2lcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qzZubG9AYS3uH4EEhCfqIdkLERJtZQXQEA2VBSK1Ds=;
 b=KLIqUY6/2cCsJd9Y/d4bIRrUhVowE5m+L3ZF/e+BsgxzDGe14i5OyqQBdt3jCYBCwjc8XSep5o6sXMzVKg5vvfXtxU6xmfWeILKwIr/bLwuYyAKnDs+z/xNfpkkFVB7yKOUBU9/8HYdVycJ57IvtOAhWfd1A2T1fromvoxd5UUs=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 16:13:41 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::97) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:40 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Move PSR support message into amdgpu_dm
Date: Wed, 2 Apr 2025 12:13:09 -0400
Message-ID: <20250402161320.983072-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: a5471c1d-06f5-4bb2-fb5e-08dd72015598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GUt6jTtdrN6WH3dg5HDv+UB+ytjrVXb79niq7k7fHXLHQhPqqpHABQ692yR?=
 =?us-ascii?Q?FJBAMYX1pnAaSkHdgc6A7VzyR2A3xwJOQ5KYBtc8isjsepdY6FEU7oBs68g6?=
 =?us-ascii?Q?IOlFn3bZSXxldRQt8b9/ntmMXTy2aq/BmNaq88Lhx1ZPobYlBd7ju+02WqxL?=
 =?us-ascii?Q?PWyCuLaKOZG9m+2CpsWcxGnSbnX89bCs1z4/bfeHmiGoqMSmRyuODFZFC/Zc?=
 =?us-ascii?Q?n2iW+RbI/FDIU7nASW9AvUVggJUlDLg+3Mfn7KmXraQFZcevdjWea7Iw9DU/?=
 =?us-ascii?Q?6LG9KwOTj8Q2Hu0a2ruGdKhRxl9axLWsTn7G4KrJ74FjAGVBuDEuu0jaTJXA?=
 =?us-ascii?Q?UKaCrov/kGdxGjOS4Qj0LwDShxafJIpO/++TpxNRnjARRBuVFD5BZ4OiaJBa?=
 =?us-ascii?Q?M0KEOJMW8mzM/3y9+jCAII5AAB9h8xv1hSDwUjVIDwm8jT3G6Bk0PmLy74Fo?=
 =?us-ascii?Q?3qL53vpa9Na47RSLq4iVQDo/O0M88ruvEXtmoSJ1JkJV0R7j/xXlb52HuxNc?=
 =?us-ascii?Q?tGBe8hXZyliDXZTxzPw8UsWkXanTmDEBwNYAkuo3eG5nC0Axozmq3y+ebduz?=
 =?us-ascii?Q?X1SLcBEJVWk0Qu+yA6EqTsWttWVTu8g+BFozvl6jr+LK1vGVKUgpGXBM1iZv?=
 =?us-ascii?Q?8+YnXEaJOlNiezlByHKjuNdvL3hoquZ0Cn+qSGeWKgymGMyoPQ78VqsOdJv8?=
 =?us-ascii?Q?pBubOEsY2jnXmEAHvJvMmBNgVsxbUWZ7mOEsoNDNIvZkePWMKirJpB6uINYI?=
 =?us-ascii?Q?neat3HrekF+BMTst9I7fUak7zefMbKLZGQfTOHYbo4sq1kezYe3NVJP6Rd/B?=
 =?us-ascii?Q?Q69wgw9Fhzg/ZkrdFJVV6YYE7v1A0Kq0Zk+DsE6oV/AtlCng7L7rSZe7w3pI?=
 =?us-ascii?Q?klagcrSZU5S9W/xX99XCnAt4fRH0FvUbCYMNKfCfkmAq9jvmbJ5MBFvnAfXa?=
 =?us-ascii?Q?TMEnkqpeMq+ZrJscOgS9N0y5AgAysOXZm0dFHNejxsisZRP05V/eUj5omyfP?=
 =?us-ascii?Q?qaXsTCOqpg/l+u9NqmmdJkf8B/jChijNhAoGViBreNb3t8Z2sO/LYQp4C7qp?=
 =?us-ascii?Q?PvhvInrcsBAzJBhbJNB9MFZTQsqMQPN7Yk7+8ZMPkpi2RNXrlCzT8Ove2ULt?=
 =?us-ascii?Q?a5yMgF+YJk0eF2h1EjRyykMZiBTSNyh/tKNlJSBzgJMZ0/aPtYyXvc4WxU68?=
 =?us-ascii?Q?ezz5W61g/GOdNvRdETZJrhcmAY+O9/au9ZMyQz6cTd3wX+jHZszNUFKZRdjK?=
 =?us-ascii?Q?W0glPvdhu5HAYrXdAH0TduTn3sN0rc6EDcgkMqNN1+0VXwo0iFtMOOlrPZeI?=
 =?us-ascii?Q?CGHEL8aAGk14vouVO9cliCFSIlDkLxXP5wSI8WaNOn7sb+cLDVAme/hfhm/i?=
 =?us-ascii?Q?FAF+55YnAHz/cIj0e9Mp+0lQY6L70aLfEidobk3Qx4NuAFFBL13mueEHLbV0?=
 =?us-ascii?Q?ZogntXzEkaLJ7nboOfSvOblWWtrJfcHZS6moReYoMeD0Jkg+nTKug7MEglkJ?=
 =?us-ascii?Q?62Nz67IpIfmjL4c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:41.2163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5471c1d-06f5-4bb2-fb5e-08dd72015598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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
PSR support could vary from the panels connected to one GPU versus
another.

[How]
Move PSR support message into amdgpu_dm which has the scope of the
GPU and use that information.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 9 ++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 --------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 65162e581fae..7cfb6fb89fca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5388,8 +5388,15 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 					if (amdgpu_dm_set_replay_caps(link, aconnector))
 						psr_feature_enabled = false;
 
-				if (psr_feature_enabled)
+				if (psr_feature_enabled) {
 					amdgpu_dm_set_psr_caps(link);
+					drm_info(adev_to_drm(adev), "PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
+						 link->psr_settings.psr_feature_enabled,
+						 link->psr_settings.psr_version,
+						 link->dpcd_caps.psr_info.psr_version,
+						 link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
+						 link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
+				}
 			}
 		}
 		amdgpu_set_panel_orientation(&aconnector->base);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index e140b7a04d72..f984cb0cb889 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -87,14 +87,6 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 
 		link->psr_settings.psr_feature_enabled = true;
 	}
-
-	DRM_INFO("PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
-		link->psr_settings.psr_feature_enabled,
-		link->psr_settings.psr_version,
-		link->dpcd_caps.psr_info.psr_version,
-		link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
-		link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
-
 }
 
 /*
-- 
2.34.1

