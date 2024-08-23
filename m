Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71496C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E2D10E0B6;
	Fri, 23 Aug 2024 14:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JrN5t5Lt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7478510E095
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os2cnSEq05kD5yyNBf6NyrasfnAODWIjoiu0+JRizuDBvjQZQ+fGczbDgaKtVhEFz2/SsHaFkm8Zg6Se7U7QBHVeFKS+ojIb6GkdjKC92cVhOyMaWTgvWF8sSZKx+hwZJ99TErLm6q+oHsBo44YgWS02O66eaAVh6sBCvjOYg0Gps7nunD3wiUDVU24Lr8wOZLIejJkpxEvOsyVx2JPCM4vJJVpnPM7hLM2Vd64Dr4n1K4dDRzrq+KmiGG7iXokxV00KzN6JaivSq+90tn9l9Q6/SFkYUelaZeGlHpn5LwSoWvegIF7IgRPgIovzzHvNqd10YGUxX9MuB7/Wln9hAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcP6/Yq3NLTBBLzynKgQ8anLiYi212d5GSuE0gtu+s0=;
 b=KhrgP4z7kqX87LVmUkDLsYzLH/9+duZS92yOUIaeWZDAfgUKarVHwGO3sh8c/RidTRZxrT2ulKHyYuf2i6IV72zHuQ9Hluh9IZONik4OF3m3UHB91OXPWsJhMQPKKf57O7Pt5iXbGxln1zSjp18vljtZ/DgUXD3GjZe1PHgeDBGQ5mI8SEYd0P3xb6Q+FLYH3NNiTxjaKyZsfOAkx/TdikXsFOBGIv9ShkmfG79eSQJBNSbskA1/0c1r2F9RgzKz9qwFnaYTHDdD+XJEsFjLF5Nr1J3ttiCAHDoBPerSGt3y1yEWoR9kgO0p2sDyVzK6tpitjx/ozOm6Bpn+CVtnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcP6/Yq3NLTBBLzynKgQ8anLiYi212d5GSuE0gtu+s0=;
 b=JrN5t5LtGe/Oh/D9OTUkzneydJv3AzotvKuBVkd2gvqA4dcdhDTShy+pTq9t+jbZ6m69WjsccDvvuuDaTFnnhU9FckGgH5xMYt4eT9ar60odpY7k+hLAPGkaRp7xVx0Qv3P26j6B8RBnJzle9K7V2MfzC4aoec2FEnDx+KkBLV8=
Received: from MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 14:55:45 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::58) by MW3PR06CA0003.outlook.office365.com
 (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Fri, 23 Aug 2024 14:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:55:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:55:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <luke@ljones.dev>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] drm/amd: Reduce sysfs and debugfs attribute boilerplate
Date: Fri, 23 Aug 2024 09:55:26 -0500
Message-ID: <20240823145527.150749-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: c284dc92-ae62-4d13-2648-08dcc383aa8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qKuQAKQGFJJ9rovFGRVEUDSdGGR7wYrzWpNTRaQUyTI15y93Rxvurxr3U4ts?=
 =?us-ascii?Q?SUDRRa3RP51oM2JtWrWncjmSnj/ltujSkGBXwicYAuHIuQ2AVV7XoY7eFFWs?=
 =?us-ascii?Q?MvyVPN5HaxCfYegjpNJ3nrIlLCsMRctr53yec1OU9ZMeYEp3LMAjNywW3i7Z?=
 =?us-ascii?Q?HbtltDqDYMoEwqNf64Krrb3Aj/vMUUSS32bnDaNdW/UnM2ALWY6H935mKut3?=
 =?us-ascii?Q?kI8pUJAwByVnPl74vlwKYOYvXhiyNeuLjHf2SSZxkJrfJ6MQN+u0tOZiwAS4?=
 =?us-ascii?Q?quzJPlE/CeF/jvBRoS/Rf4P8hsjnLwl+xbuJOMeD6G174yJVrsZA0l1SBfQm?=
 =?us-ascii?Q?Ax+6h2TFrUFgn7y6TtI5xkl0u1gSZafZkfRBtPhSfjuAfkVUwpRIaaEo7lLO?=
 =?us-ascii?Q?e6wAxHV9IaVRRSOJmIGUD6E1LyKsD7ww8zypt5PkxfAO5pm3YtI0m7it3HH9?=
 =?us-ascii?Q?P5zUJ5QKWETIa9QYDaLx3bEYnCirJG2PLolMu4kUNkkRHzCW2LWLvqu7AbVE?=
 =?us-ascii?Q?NqckaV6Bi24VhVgBvt+w0a3VdHTzfU6vwq6S/8hUO2jwqgjJmF7fK2nLQjjr?=
 =?us-ascii?Q?S9M6BTYcP7H4LvZUdVW5G4dJ1LWX4cgQ1637lGCmbDtfW2b/uIEVFO/zm02o?=
 =?us-ascii?Q?lp0ZBXl1Koi1bIgz2+xZU7gH77QRyTfk1Pt4rSSCrA3bzOWhYkpDTsJxbe5Z?=
 =?us-ascii?Q?WqH4EgfyCilI+8eRhWZMzhOQX5rMZY9PEa+c5qvHfhDqjZOnIE0SHIfLUVx4?=
 =?us-ascii?Q?6GYV/CehIYkyGQevWJsjdfzlUsT5OYLpj2wfUa3dR5DgNZQz0XjCGPrjGzVz?=
 =?us-ascii?Q?odYC4DOkcE+cwovXColDH0BpXUQBpFaWVn63lpU/+VuN1KphI6u9Cj1dwPIN?=
 =?us-ascii?Q?mOvSpG240AgFIac9oU3aiALS0XxrGYMejWI60fkW032Lc7O2IPR1fCLm3BmI?=
 =?us-ascii?Q?MSWfQle3PlrdUeCqol22u9q7VjqhfqHEVeQs9kD1ewlnKjBdP9H/hfYZ3GTG?=
 =?us-ascii?Q?02+cvh40jDbtHsj380ycuctaP5tJWHyOx/bb6q0UP+/+1Jyh4pajjXSueq4U?=
 =?us-ascii?Q?0UWt8pCwsRMbaIR+x2AGGyCVeikmrGZZmsZCk34QfT1MMowkCDq6LQplmjLp?=
 =?us-ascii?Q?6nG4qmaypno9zwwGUqL7oCPPLS6ab0f4IyIilqxjrbYzUGGHPbz1yO+cdC+M?=
 =?us-ascii?Q?17Au7RMzyF24q2KsIi2UkBqSL47dmIttfKFiFOVukfa/Hx73Ckqi/AlEo9GH?=
 =?us-ascii?Q?Zxielacj1/fBhIDwakUr/ZRTtNF96JN2c26xgNH7jOWMIfHOMw9Ordh+oykZ?=
 =?us-ascii?Q?Qsm2ba0CmKoJu4qlbXwKGZQY5XankhA02OZPdvlSZipjNMa9TXELzv8arltV?=
 =?us-ascii?Q?JZoVB5MxCrbBeGFaN1hdcZFaAmCuI5PNjzJhoJuAo59k7ZAnZwgTYitu9nDY?=
 =?us-ascii?Q?WX+vqUtsEtbqCG+zuXRvr1PBFxVes6YK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:55:44.8001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c284dc92-ae62-4d13-2648-08dcc383aa8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
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

All accesses to attributes have a check for reset/suspend/runpm. Move this
code into dedicated functions. No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Split out to two patches to reduce boilerplate with common functions
 * Different behavior for sysfs and debugfs

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 194 +++++++++--------------------
 1 file changed, 59 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d5d6ab484e5ad..bbd6f3e617358 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -97,6 +97,20 @@ const char * const amdgpu_pp_profile_name[] = {
 	"UNCAPPED",
 };
 
+static bool amdgpu_sysfs_attr_accessible(struct amdgpu_device *adev)
+{
+	if (amdgpu_in_reset(adev))
+		return false;
+	if (adev->in_suspend && !adev->in_runpm)
+		return false;
+	return true;
+}
+
+static bool amdgpu_debugfs_attr_accessible(struct amdgpu_device *adev)
+{
+	return amdgpu_sysfs_attr_accessible(adev);
+}
+
 /**
  * DOC: power_dpm_state
  *
@@ -140,9 +154,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -171,9 +183,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (strncmp("battery", buf, strlen("battery")) == 0)
@@ -268,9 +278,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -307,9 +315,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (strncmp("low", buf, strlen("low")) == 0) {
@@ -369,9 +375,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	uint32_t i;
 	int buf_len, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -407,9 +411,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -446,9 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (adev->pm.pp_force_state_enabled)
@@ -469,9 +469,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	adev->pm.pp_force_state_enabled = false;
@@ -539,9 +537,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -575,9 +571,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -758,9 +752,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (count > 127 || count == 0)
@@ -860,9 +852,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	};
 	uint clk_index;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -920,9 +910,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = kstrtou64(buf, 0, &featuremask);
@@ -955,9 +943,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1024,9 +1010,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	int size = 0;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1093,9 +1077,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1278,9 +1260,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1307,9 +1287,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1340,9 +1318,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1369,9 +1345,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1422,9 +1396,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1461,9 +1433,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	tmp[0] = *(buf);
@@ -1515,9 +1485,7 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 {
 	int r, size = sizeof(uint32_t);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -1628,9 +1596,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
@@ -1671,9 +1637,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (adev->unique_id)
@@ -1844,9 +1808,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 	ssize_t size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1885,9 +1847,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	ssize_t size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -2003,9 +1963,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 	int r = 0;
 	int bias = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
@@ -2284,9 +2242,7 @@ static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
 	policy_attr =
 		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);
@@ -2305,9 +2261,7 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 	char *tmp, *param;
 	long val;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	count = min(count, sizeof(tmp_buf));
@@ -2767,9 +2721,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2799,9 +2751,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	u32 pwm_mode;
 	int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -2857,9 +2807,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = kstrtou32(buf, 10, &value);
@@ -2902,9 +2850,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2932,9 +2878,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2996,9 +2940,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	int err;
 	u32 rpm = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -3027,9 +2969,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = kstrtou32(buf, 10, &value);
@@ -3071,9 +3011,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -3103,9 +3041,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	int value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -3243,9 +3179,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -3324,9 +3258,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	if (amdgpu_sriov_vf(adev))
@@ -3782,9 +3714,7 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	int size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->dev);
@@ -3866,9 +3796,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	long parameter[64];
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_sysfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = parse_input_od_command_lines(in_buf,
@@ -4753,9 +4681,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 	u64 flags = 0;
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_debugfs_attr_accessible(adev))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -4798,9 +4724,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 	void *smu_prv_buf;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (!amdgpu_debugfs_attr_accessible(adev))
 		return -EPERM;
 
 	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
-- 
2.43.0

