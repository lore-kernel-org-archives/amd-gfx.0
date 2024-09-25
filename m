Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201AEC369A9
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87B010E7B6;
	Wed, 25 Sep 2024 07:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FvgEe4mU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9AC10E7B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOoASFGmzj7Yq6Tho83Gt/SR/cfbvp6GuUH3DHaQ0CM1k8HewznJHzyURwxwxtXSCAxDnNyIapGNUQcgSlpFk8GVofdQOPMlAkNuxVmA4ZQthfDD+Lv79ZET6nwLWifok5CzN58BDRP+PkBfoO6cBSKGR/5fzIz1Nl64oUwbOH7mLJwx78Rmh9nodwtZq+TuImJWdga6B1fOaBYeibkF89ti9SMRArPTzBPfG+Wp49yKJvhnbNPwSxn0F+yUQqbehfOQZkugnWrA4TNOGodrGLPPKcyhon571f79yYf+zJYm+Nid5Ss3KaIrE3uEHgGG5GXq1kNewv88skIOERWERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFqh55pS08zpSIDpQkSCrtEMUy7KL/ibzxNvhIJnbgg=;
 b=Ko9q7yf5EJXiB/xL8hQigTIxWZdiBLtsHcCF3zL2Qp6GNaaUsmc1AE3g6bVMTAuGUa1zzpTS+6gwFmHlboG8ukvQ6wHO2p5VKB13ZZUyebThPUokDa5ZL9hBT0oB+9HSYEx3oM3gdWc/gugs7J5I1FV7tJsS9paFkVjZfEYHS9IjzIpOg98UcCcWd/2Ti1pXwLjN12sZWwvT2afvLwjeT1vCGTvdyIQHcXBwbm2XkXDQRCc/iUecbXpBMqXrZH/MFU6F1VjfAjNuJBmGDdJIDCsdCNWwgkpOQSRrlCDcXL1J68J2L1497P3qZn2HVVYJKQi56MRBnleJKTqoA2JuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFqh55pS08zpSIDpQkSCrtEMUy7KL/ibzxNvhIJnbgg=;
 b=FvgEe4mUhpmcT27bJFRXJJey9WrsuTsG642FHDXThOJvGQw30X3KlNE7TC89rIonjcXS7N6Mlt4i88V9jO3QrGo8fmg7OrhiLy4YqozoIifCiv0ep7MB3L6FCGFj0i7d6diyehmyKNTgjkA1wdYJ23L2Byi6HCSlh30CpNhtwuM=
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 07:57:08 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::51) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.27 via Frontend
 Transport; Wed, 25 Sep 2024 07:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:57:07 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:57:01 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 6/9] drm/amd/pm: stop extra checks for runtime pm state
Date: Wed, 25 Sep 2024 09:54:30 +0200
Message-ID: <20240925075607.23929-7-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea45ca8-e5d8-4cea-daba-08dcdd37a740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i253GuNscAJNu+YpHJ7dq1XgbzH35OMnm1wbP5L5zXKv83xVPTV3kxVPAN6q?=
 =?us-ascii?Q?cIMtZvsSdAbvK/ReAsF+ySv6MG3YIam1glyLhslQljFqXfwNgAStXPYj767u?=
 =?us-ascii?Q?pDiN1QKBev6OFDDKbADH/bQNXXPmNrH7fpTYfZA3GVKrnVOAxs6tyJh7gJPY?=
 =?us-ascii?Q?8vt7QrirJBTjiOdafvc8JmT6RSIfiFOtsFkkOG9x4oiexc11nKSY33x+J5UF?=
 =?us-ascii?Q?amjgIsZFgqXKT5eTA7/LdpaRk3pV5m3ZKei4RkQsa9nMKGRjUTS7lOtxyT6I?=
 =?us-ascii?Q?nbIjvFGT7f2u1mHbak3zz8f0CyF9qv44Krasj5d/JUkLnHk/72F5SjNF3NQ2?=
 =?us-ascii?Q?p57xyOb4/iYjSEkDZUuJrHTnkDV5E5e4IjOXJdzRTzBjiibwMsFWidriXjEA?=
 =?us-ascii?Q?xosFRTydsSzgeWlikGuFbbIYhJ1n5ziDvEcCCVdlT20VREWNsTZ/1P+MNCsX?=
 =?us-ascii?Q?y9WnaAa406dJ7J1PvdxEDedgtf27De9dOvA94dSpdwwcBRL+LbjURxL0eY+v?=
 =?us-ascii?Q?EQ/WDIUJh3CDWD/MGi7lH4WUfqTOOEb8pZ4AxlAoJ0bCfz0wvNatnOwIJFBp?=
 =?us-ascii?Q?IIlUgZryIoF3BbSySRtdr5yexqNQUDOw1qyZ5m3pLIwr7fu8f1Zo7Ne6OTNX?=
 =?us-ascii?Q?AorX6nWExNeDPXU6gxvd9BFWsdP2nOlf5fK+GK1rM4y+fvtHiUCPURxjEkVg?=
 =?us-ascii?Q?hQgvlxQTgk44kIO/YBEejHoS0OEja4Liok5vXpshFENoOS/Si12YO71n4P6G?=
 =?us-ascii?Q?kXLVDkWjer72u4tkeIlXFNz9U6Y1mdb0Mpt+e/DSvzzKtDTOXTo4/iAvSdq9?=
 =?us-ascii?Q?06HJ2QDUekRh+NRT+r8oE7oxVnG25/m9x8tHxz1i63sXKdL7yNsbyQxiaYh1?=
 =?us-ascii?Q?+dq36vpS0Qaa2JuhABvJJ3eX+RDChE8CbGWr1J6olRzjdEo9z7HXJa8ft+NL?=
 =?us-ascii?Q?9mZlRky77Qya+1YsLFAM0zVoCoyiGPIiFrMy8RwIavzyTTsdx9miMYdkOAX5?=
 =?us-ascii?Q?qcjYCw/ujvoJRogOACNGwSYAL3Q7OW33vLoj6f2I4uN7uDio0rcpmKgIPQPO?=
 =?us-ascii?Q?AoY+escaKt0L4nC8YmFFwJq9+ofclxrK/vkxwqkQ4E69TCoSIFTUlDFZZ8TR?=
 =?us-ascii?Q?pPOycT79JOuK3I/keMeJSH8FnXNz80eaLfo1BSVM7QFNDOd+jk4HENLAE1GP?=
 =?us-ascii?Q?+tdFr+tY9EPXKmRbAf7vqY/8XeUOmFmHVShnTou88QCvFABKOENvnQEWplGo?=
 =?us-ascii?Q?+W6uIuwwIeYdcC4m2pf133zKrDPhZJsdz9kruvzF/xay9mbZjVAzheKqmwLb?=
 =?us-ascii?Q?RMAV7CKiSmYl+ywQUxvRoTgs8d9uv3iZG8qREwg9oIJcy/9sP+CGYifu+E6F?=
 =?us-ascii?Q?1sTVP1v68Mou/QBeJJ2qPJkxsvltTuKec0Qgi94MOKWzgyY2WtwEiUJso04s?=
 =?us-ascii?Q?EWvVD78b3LaSuvWsP7dHhERMhYh4GcbO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:57:07.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea45ca8-e5d8-4cea-daba-08dcdd37a740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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

pm_runtime_get_if_in_use already checks if the GPU is active,
so there's no need for manually checking runtimepm status:

   if (adev->in_suspend && !adev->in_runpm)
      return -EPERM;

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 46 ------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f1f339b75380..13be5e017a01 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -142,8 +142,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -265,8 +263,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -361,8 +357,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -396,8 +390,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -523,8 +515,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -837,8 +827,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -927,8 +915,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -993,8 +979,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -1242,8 +1226,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -1299,8 +1281,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -1376,8 +1356,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -1464,8 +1442,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	r = pm_runtime_get_if_active(adev->dev, true);
 	if (r <= 0)
@@ -1574,8 +1550,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
 		return -ENODATA;
@@ -1784,8 +1758,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -1822,8 +1794,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(ddev->dev, true);
 	if (ret <= 0)
@@ -2697,8 +2667,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(adev->dev, true);
 	if (ret <= 0)
@@ -2825,8 +2793,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	err = pm_runtime_get_if_active(adev->dev, true);
 	if (err <= 0)
@@ -2852,8 +2818,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	err = pm_runtime_get_if_active(adev->dev, true);
 	if (err <= 0)
@@ -2913,8 +2877,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	err = pm_runtime_get_if_active(adev->dev, true);
 	if (err <= 0)
@@ -2983,8 +2945,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(adev->dev, true);
 	if (ret <= 0)
@@ -3149,8 +3109,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	r = pm_runtime_get_if_active(adev->dev, true);
 	if (r <= 0)
@@ -3682,8 +3640,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	ret = pm_runtime_get_if_active(adev->dev, true);
 	if (ret <= 0)
@@ -4649,8 +4605,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
 
 	r = pm_runtime_resume_and_get(dev->dev);
 	if (r < 0)
-- 
2.40.1

