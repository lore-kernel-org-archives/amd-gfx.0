Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB1AE83045
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 06:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F2E10E140;
	Wed,  4 Feb 2026 06:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3Pm+LsA";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A650C10E140
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 06:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnne6QnDY4gSHwcrrvUl6xPBJryUCqLrgTl/qDd4c+QVp0uhE7YHcqD1MiZNUry0nEqx6KqOlvojK/NNBcM5R9nN4Du9p4KYVleZbBM3uKPkY5qlq2nQQnC+tDRBUsh5i5bzr7C5uU3LxR1md4vtECMZtKHE/mpqW/HCK5wB+EP5l1Npoer9J5RuinsisAkJSwvWC3n2nGkNOd6G5GNe1s7HuLrMHhLaic76kW1AHjXkrsIDLWEJ663lwGF/qo+8tlSKd7cCv6Kf/Qf+ZVvMgpB+xYfxXxXrmH5+4I0TjIySc2Wrb1BA7KFQBTGGa5GkaYm7CMYGFI+1YBH6eASCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMxDO/bpzYPWE7loNw9ffG+BeR9j8aIupfeAhLwgqls=;
 b=AWNjqU/YKD3XjaH1AhszduI41IR6vxNtHKJRCPlTuGA9azCz1vG4OQm5h5SXIqIO3NktOBFh4sPTtFyE3lLnYT8YB9aEa3Zwa8BELmI7JRedkgGHnGUfb84ixlwDgzSKLm2OtWwVlKo5mkxNB5bP28+Lg4WVePILP5Nt2DynVN2ZaoRuiIUbc96UclqKjY1nr/yzEk5jEOci2yFH0FS6+NNBu21j9iJxm30wUYCvz8UT0degjqitX4zDBUhZID7UaeUsMO8Tcx98InfF03Kmcj6VR92AM2Ro/OVs8LdxCh1fvT3VQB5IUqVPEFqNise4bc9s93uhal0HdLdXyUuUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMxDO/bpzYPWE7loNw9ffG+BeR9j8aIupfeAhLwgqls=;
 b=d3Pm+LsAh866oP8sWpYVBCUVXCgX3gYTh2OAN07yaI7f92g64d9FWznSDM21+hvUzmjl4NZL0hxF2Psgw1nVWZgnKkXFWvVK4dx8HHaU/vbrBCVGIg/bbwi/iCdjO5DmqF0L7ts7KK4oOYz4teuhEi2VkHc4//dOekj2gHE58QY=
Received: from SA1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::22)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 06:57:56 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::e8) by SA1P222CA0007.outlook.office365.com
 (2603:10b6:806:22c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 06:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 4 Feb 2026 06:57:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 00:57:53 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: use sysfs_streq for string matching in amdgpu_pm
Date: Wed, 4 Feb 2026 01:57:43 -0500
Message-ID: <20260204065743.206914-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: f819d8e5-4388-41e7-5780-08de63bab944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A+6hYn+cdHvGJppX/GRMk6DQPCmxgGWkoD5I/dsuS8eeEPjltXrke8J6YMyX?=
 =?us-ascii?Q?nqatvybZfs18G6/xx2LLqcv2JO7hPRR+lteKxSNL1s/m08yMbJD+loPXZhS0?=
 =?us-ascii?Q?aQBxmmv4OHUkFSuGk0mPYJStkXXjyD3AYQDNFOORZLrAf0MxwsBnWVSfXTkk?=
 =?us-ascii?Q?c8pC2rBfStQF4Z4RsT1IR5rP5hcXH/6FNLrSyIzsT/ZEjcGrRrx8o4zhqSkQ?=
 =?us-ascii?Q?vbYJpincvdNAKnSpoTNZPi0yYVBRB01km/LjiNkfeNm/1mck7LUTgeL0bGl3?=
 =?us-ascii?Q?ZGJhPJZ/mnzcU2t6lx3SxlvWgX2+0Bi2PGZb/8+uxry80KG6tD9gXqOnC1jQ?=
 =?us-ascii?Q?F78/m9K596KYP0Y8z9tDOLInzqXmAMU/ZsVxR6o5bBtQNXfOMcC5JL5x504T?=
 =?us-ascii?Q?wgtIYmbwNyrXAnG1+r0mjJajW28sbkVgHfoJb6oW/05uZL85Lj6VaBQjOxZO?=
 =?us-ascii?Q?tG4f/5Xa14LdVt6nbVa/YT3f5/y8bqHmLhQzw1wt4YugWD60llHz9NXuvE+g?=
 =?us-ascii?Q?6B7DXetEsQnveg7EkwZpufUpaaEpa/T5i++JL1wtpLQDEmkkDFEqjdBBWmN8?=
 =?us-ascii?Q?R8EUq0+XI+UaFBXWpkJm+6J3tfM7ozt9sAyoB3N0ZU0PmMu4XGIYrMP5Zp+y?=
 =?us-ascii?Q?NsGZMNy6HM+hxwbvR0hbYYcPDG3d3GQNTn5W/OlOgJ+WplODMYwPxdpC7rIO?=
 =?us-ascii?Q?0fsFRr2kZoYTMT5If5UFwEnEDvqOQ4UitVxrE5nuudkPbRRcXseHazhFT1Jm?=
 =?us-ascii?Q?i1OwPt0+K/lJ18pkt6RUk40pxnb3gGUtFFP0EnsyV5Wjgnj8fuYynW/iDZJz?=
 =?us-ascii?Q?55Hr0lIk984bdGrRqsOuaocfCpRgmXdc/sRnuQcoteKwxmB2TJjYnZEyRxI/?=
 =?us-ascii?Q?LE6q5VLBGWoZqwqzInz6diUqVaZPkRD24RN3wtg8A7fG4bSz/408Ax708xF3?=
 =?us-ascii?Q?ZseGIQfRpGAUXbevW9vyR3Q/WnOazj3GXHLpsvHdUDgB/beP1jQXz6T7UIM+?=
 =?us-ascii?Q?/+t9Bb6CafHqHH5EOvK0CoN0UG2I/pQGMupVmg4uew75KFXuv6ABQmIMvVIF?=
 =?us-ascii?Q?ddk+/n+PkuFgJMhS9vPioEz2BVe8MICH48MX6W6GYlZbTOiOwIr1cXnNpFUm?=
 =?us-ascii?Q?ONRIuHg16SUTnqg3QeiINzxLqmT2NIaNggCU9qn8kFfs306TKLugLapzIiCU?=
 =?us-ascii?Q?RKKYoXW4gZYNbI/Sm1W8dcmRTdZYMT8s5y3VQdpE5MgFxxYrvRr62uOcmngG?=
 =?us-ascii?Q?pVae1mZX+67p+7YKRIWMEAs0SA1m69dLGxH6vHKx3JJ7nMlPyxDpz3Sjxhu1?=
 =?us-ascii?Q?XIh017ZrTPE3UvRoFx9lFXR30pp07bfKBSO8GCSE+Kxpe3l+4EtwDk2fFB75?=
 =?us-ascii?Q?jesUo0v2pzcOHC7g8PBusv1LR8Aa2bRAxYjllZSd8jq5h3ICgWbAsS6Q91Ny?=
 =?us-ascii?Q?h1oQ3HfcL6Te4Qs4JCtomcbQ5VsiwJ5kTRa4lhSIGPcf/J88NCpdXzrxWirB?=
 =?us-ascii?Q?6E13b5gcdE2y+d2EkSHpT+zmHmx0bsR3Wbe29pqhCx30DEsX08Cdl2u7xmhD?=
 =?us-ascii?Q?z12+yxndRnX/IXMoIyd07+p37wuh6wYHfDMCAPSzEvYWWri1xmCWSbb1JUli?=
 =?us-ascii?Q?60YrE7saT7VKVDuggCVOlTGKmle4h+tcubXqzheBZ5FM9/SamAPv+LgPVPvw?=
 =?us-ascii?Q?2dGnVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDIzgb4EA9sXk9X88Sh0cx75obc8V1plbZSORFqiUuO4RLNASP7zcYMLoJpzduEwkO27VkiFsHHjbdnX795XKdiMWSSHlF87KsfrAthTmxyrPrJDvjlJYcFovg5SYjh05lbhEyVpR1RdALNFac3vltrVNzISuF4Wbbf1UwW3XV+05RGYoqLOnxxWX15mU2EaPePBn81g14rrkZaA5EX/afRZq6JcOy+cRn+QDrEBHZTKs9/xPR2kg61nn9RwjIBfA+D4QEnF+uyNVF5ZHBjn0vR76VEFAE6sexl38jQvY+CBtxuojqwYpt3P1dRezy5rY21/xkc4z0vjNQpA87k3fmXKs8e7Lg1STzPK2n9ZXaVyZoYCt4FxsvtHf24cO2/zEoAw45AJRduOD95Z15KhEGnebJ72JxnXFzLY8lxIAOYp0MxLvQ6q1Wgo7n+5Q60Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 06:57:55.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f819d8e5-4388-41e7-5780-08de63bab944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

The driver uses strncmp() to compare sysfs attribute strings,
which does not handle trailing newlines and lacks NULL safety.

sysfs_streq() is the recommended function for sysfs string equality
checks in the kernel, providing safer and more correct behavior.

replace strncmp() with sysfs_streq() in drivers/gpu/drm/amd/pm/amdgpu_pm.c

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 07641c9413d2..938361ecae05 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -243,11 +243,11 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (strncmp("battery", buf, strlen("battery")) == 0)
+	if (sysfs_streq(buf, "battery"))
 		state = POWER_STATE_TYPE_BATTERY;
-	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
+	else if (sysfs_streq(buf, "balanced"))
 		state = POWER_STATE_TYPE_BALANCED;
-	else if (strncmp("performance", buf, strlen("performance")) == 0)
+	else if (sysfs_streq(buf, "performance"))
 		state = POWER_STATE_TYPE_PERFORMANCE;
 	else
 		return -EINVAL;
@@ -363,29 +363,28 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	int ret = 0;
 
-	if (strncmp("low", buf, strlen("low")) == 0) {
+	if (sysfs_streq(buf, "low"))
 		level = AMD_DPM_FORCED_LEVEL_LOW;
-	} else if (strncmp("high", buf, strlen("high")) == 0) {
+	else if (sysfs_streq(buf, "high"))
 		level = AMD_DPM_FORCED_LEVEL_HIGH;
-	} else if (strncmp("auto", buf, strlen("auto")) == 0) {
+	else if (sysfs_streq(buf, "auto"))
 		level = AMD_DPM_FORCED_LEVEL_AUTO;
-	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
+	else if (sysfs_streq(buf, "manual"))
 		level = AMD_DPM_FORCED_LEVEL_MANUAL;
-	} else if (strncmp("profile_exit", buf, strlen("profile_exit")) == 0) {
+	else if (sysfs_streq(buf, "profile_exit"))
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;
-	} else if (strncmp("profile_standard", buf, strlen("profile_standard")) == 0) {
+	else if (sysfs_streq(buf, "profile_standard"))
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
-	} else if (strncmp("profile_min_sclk", buf, strlen("profile_min_sclk")) == 0) {
+	else if (sysfs_streq(buf, "profile_min_sclk"))
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
-	} else if (strncmp("profile_min_mclk", buf, strlen("profile_min_mclk")) == 0) {
+	else if (sysfs_streq(buf, "profile_min_mclk"))
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
-	} else if (strncmp("profile_peak", buf, strlen("profile_peak")) == 0) {
+	else if (sysfs_streq(buf, "profile_peak"))
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
-	} else if (strncmp("perf_determinism", buf, strlen("perf_determinism")) == 0) {
+	else if (sysfs_streq(buf, "perf_determinism"))
 		level = AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM;
-	}  else {
+	else
 		return -EINVAL;
-	}
 
 	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
-- 
2.47.3

