Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E75E7718B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2024 08:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1720B10E36A;
	Wed, 25 Dec 2024 08:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GemhoxsR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A23F10E36A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 08:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3/n61WfBdBmNG/fGZLCc94bK4ipYxrz0MAyvUQhE6VE0wj2/7YLFvQn8o6T086xAOyL9j3XanEzPO0N5Zpr+mtDNVjx18LvnDBZnoVOgq7dJZ79nxv4MbwFyWuMTGcClbaQESF0qOggMW5GIN6C4oXPc0/VviJyt6zzM8FveZ4QbfJfN4abVNBUpWXSgdX7OVXxfZBbLm/mqR622Ct7Gc3OaPKAZLknVPqTHbpwH8Y3Bdg6jSeU2BqgHZRjFH2yR/fcMiCfa3GLBy+BQuxFJHI+e3xyd/TU/ngQ0OCI+t/yP+TEOPBbg7tDVDl8Qbkla5k/IQ1JVMjGMbpTLorTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8YwIiTV+oDvQh6rMh2a2jJ/dvC05Q6lmuCrn5msB08=;
 b=YQ+7sY/gpYjnXOP/PIGrgz4w5FnluX1dwiwW4/7m+cEmfA+/NTXdzCU7VruwWTLETfvJv8jjcj1fBappAWxhcrT+0+3VGW9CKh1MKnwn2zms7RVNG/NwlYZ4X+8prQ9cQo1oPiZXqyaZLACv1/wf0KH3S0MC/uKpadIuFFSrr2+nIxCHpywyLstmASBhpcs0yESinAgpH3PqmJfWZcMzRIOSl1CU/BYRP0qY641VfdqvWpfR7r5gAEMkXEh+vq9Gfg+fdg4tSvjslouDTgv3KSInf0eXngkVn64DNeecucOCNzjh1nRlPTz/wNFyJoEQXoRSlOCTVS/cN49IBtSxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8YwIiTV+oDvQh6rMh2a2jJ/dvC05Q6lmuCrn5msB08=;
 b=GemhoxsRETq+66KuURzu4HYX1Sk4dAbTOp/3cuIipXECtJIyLt5EW+nE4jgmaNJhw99H497ewIQvu4nP13wm5yvRIXkuo3KwIeYQWxp5SWkA9cL3r/UwS15HrbXO91vFX0rchqe7lk0IL2QFgdsb/qJRA6fhGQiZw3h9BsOWZcQ=
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 08:08:19 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::b8) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Wed,
 25 Dec 2024 08:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Wed, 25 Dec 2024 08:08:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Dec
 2024 02:08:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Dec
 2024 02:08:18 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 25 Dec 2024 02:08:16 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add the interface to set and save the bootup
 workload type
Date: Wed, 25 Dec 2024 16:08:13 +0800
Message-ID: <20241225080814.1692482-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: c6042719-eefe-4621-23f6-08dd24bb4acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sZBb94DrmX+plFWud9wN7yLzkQOafJ0abNN6n/zcZfOswLJI02RMiSz7VOhN?=
 =?us-ascii?Q?9Hl2/IminEuKj1yMs4UjTb1Hc2+lHX9KKsmi7fbINlmdfhLwl2rE/vVpoCRr?=
 =?us-ascii?Q?MKA5M8xSeTM6EQhC1W4ash5oNeJVOhmtfZA1giBBhH1lQuTmTd5OnFqsog87?=
 =?us-ascii?Q?VdDbXypNP1XgWVUPPfv6OoGu4QGXKZaNrm4/rEKd5bPI9GEDn2YPeUk1SoF8?=
 =?us-ascii?Q?6hf+1srlpZzJmULGFmCi1GkRHXNvzD8IUIjMtwcaeyFz6sjNZYFqVEs9AMeJ?=
 =?us-ascii?Q?RH2Vz44uNQIOOZv6JQ/pSEzxJQFLy3GOPlFJKwH6ECOYT/hwA48VtZaxHc8X?=
 =?us-ascii?Q?/n9pCQlzXFZfiRqIG/kULEgF3PqcTItKWgQ8pUJ4ryilGn3qiPl6iP854DyX?=
 =?us-ascii?Q?5gzDTDJrK80G58NknIJnMw+EKKXoSjN6IsJR++V1LMGaYlBHSvxqKkXrGR9R?=
 =?us-ascii?Q?Z91/+rrFvQJVefoL+9LtzxHV+exBjf5pVRfxSLl33rdZgw6Emxc5B1ImF7D1?=
 =?us-ascii?Q?4Gk4+qHGCsAQUNr4Gn2egdufpCCoIQwHJPUd2azcnvzQq4AM92qv0MXkeGNy?=
 =?us-ascii?Q?tER/BhyRvKcn/wwiXBZHLe9Z9B8cuQYPDsU+6OM7W34WK+gBLlpsoNGZusWx?=
 =?us-ascii?Q?i5Y8gSARHI6VUJ1d83OQ42H4QQqlzDJxBNqyVe1PJdWiXNl049oBRm3aRGWt?=
 =?us-ascii?Q?BkCjZ6XxkFVFxzab6+UV3hv0TVJJt3ACra10DfLmfMCs4TwQDXZF+jaCIzQb?=
 =?us-ascii?Q?o0XdcjPMvEt4egWDBsFilEa89wVMcLSKw7Q3YSOf+0w6IeGTMiqUnPP8FomB?=
 =?us-ascii?Q?ZWDX961I1iCPNfOEni70YvGQNWJ1pymqAn5gXAzaVGTKLWGcViKK0b9gIiPk?=
 =?us-ascii?Q?cqPahsR/YUx5fdnMtBC3LP9nj3YZgmNz0xwy3dRKz0XawXUHx+ageWehrKsp?=
 =?us-ascii?Q?quVxwVkzZPxl5p9iDelW/9f3KYz0Hj7AmuiroKzdFKvGJJYtIJiZ9JT3sCkT?=
 =?us-ascii?Q?LWZgaQhWCoKM5HBZaHfSbUUBk3KozPVx3hIuzoxxDrKOz47hIJ7pQJVzssUC?=
 =?us-ascii?Q?IeG+1207xIMkBUs+yKbn2WI2CuQpSyOSWZNFTXr+PYOIPMWo0TiOGn0O3mKY?=
 =?us-ascii?Q?xqCmR6mrlzDoQ6lu4k/Re7tTcC7F0TC7OOz7KtyN/Jed81l/lGyCG4m9Jhap?=
 =?us-ascii?Q?Ht4RTu/ZRgPUJ49sZM8K+zeH8oDlTTd1tCwHUdqNhPUQ8/p6cmPlv9dogjf2?=
 =?us-ascii?Q?j19fPJ1g4RSU6Z/Pkke9/bJa3Qn+Oup+kvslKj3qkgIQJxTGvyTRuMA9aJGw?=
 =?us-ascii?Q?//zgmH2kmk33qNEHoz2N5OeNGeRw6H8V31ivVagv8HqlbJsWvC+juZ1S9caL?=
 =?us-ascii?Q?n6xWbQsEjb+e1nIyLloku94UYef6YmFR8ppEcBpmFKbeHarGBNUEQNMgSkZL?=
 =?us-ascii?Q?37jP4mFHfm7qPKS9d9pbyNnycJbsZNw5yPpfpLiOrYaJytGphouy+3EZs1d9?=
 =?us-ascii?Q?/s7sGr2nN19UPtM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 08:08:18.8270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6042719-eefe-4621-23f6-08dd24bb4acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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

add the interface to set and save the bootup workload type

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 27 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 4 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edf..92fa19cac32a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -349,6 +349,33 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
+						bool en)
+{
+	struct smu_context *smu = (struct smu_context*)(adev->powerplay.pp_handle);
+	int current_profile_mode = smu->power_profile_mode;
+	int saved_profile_mode = smu->saved_power_profile_mode;
+	int ret = 0;
+
+	if (en && current_profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
+		return 0;
+
+	if (!en && current_profile_mode != PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
+		return 0;
+
+	if (en) {
+		ret = amdgpu_dpm_switch_power_profile(adev, current_profile_mode, !en);
+		smu->saved_power_profile_mode = current_profile_mode;
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	} else {
+		ret = amdgpu_dpm_switch_power_profile(adev, saved_profile_mode, !en);
+		smu->power_profile_mode = saved_profile_mode;
+		smu->saved_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	}
+
+	return ret;
+}
+
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..5fe404bbb033 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en);
 
+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
+				    bool en);
+
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..a6f748361198 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_context *smu)
 				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	}
 	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+	smu->saved_power_profile_mode = smu->power_profile_mode;
 }
 
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..c58fc31fb1d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -560,6 +560,7 @@ struct smu_context {
 	uint32_t workload_mask;
 	/* default/user workload preference */
 	uint32_t power_profile_mode;
+	uint32_t saved_power_profile_mode;
 	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
 	/* backend specific custom workload settings */
 	long *custom_profile_params;
-- 
2.34.1

