Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE4CFA469
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 02:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B886410E0F7;
	Fri, 21 Nov 2025 02:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8omkIze";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B0410E0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 02:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdAwJLEmN8lZj/9y7l75vL5hn+AGRLYZCz80Q/J3hX/Enf/J+eVGISRo5MI4gQdPaBByGn3LFvmtMmMCW9fjGCKLm9t4CLgAPotDuao57bpX1sjHxeX8aDlglQMt3VZa7+4gbLxVd9BCB1hxMUjmv8Dxi2gG5nr+7kHoOYrdXz4t/BDBd1OFoRZDrYDFmaclyY8XdisqfzVjD+oCWIJSTo2tMLmMaGoa2xZ21++YKOoDW4UdSr70o0WRgfQSMX5TonTaLkrwAOpm26OnPRF4kxjJ7WELVuSPBgBl4ofDxnT8wHyG8oxUrqCN215DjD+yLcLZ9y7GEm3V969UXu82uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtN8PP8BQb6WvCm0hgCK7JUBAVejtIkiCKWL+a02iSs=;
 b=kVWkwqNv4O0ktnJ/KVVD5k6Q7hPrFq6ind7J+T49ihDv6ScUmezC6d4KUWdUl1N5BMqtotgV8Ck3yHZ/6cZEzTicyjeHa7rf4x0iHvaX0eMxDh9LD2LVjrUn1xRlSxGjBJf0f1Fi9OeUV+JFP2GekuUPD0IwZhQ3YOeCLPbI2OuXciRI2LlsnosahhleM9ODMuJkEUzrTIg3m5pzT8krU1HMJEq9w/mJyfjZejH6cdO1f3ZaCbOkXrHPCBP/IwvCcrMZnd87vwqKPctzdhGZ6Lv5lH/R3sHJMwg0iTRK65grrih4luIDe0gmhiPzBhV89Y5fzuUcb/Ve7cZDrOdeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtN8PP8BQb6WvCm0hgCK7JUBAVejtIkiCKWL+a02iSs=;
 b=j8omkIzeLG06/YvQW8KEvkwvJdpJ0fkmgDhYknCaMCMlmBaumeiw2UzVO/ZihoImmzURMCwHU4WIzCiIV4g3Q5DxlVXXRHe6lixkQjTVFlMj304kZxQmni43ULRwsXlBYySe7ivJTQ3FbLWFOKQZqYMyZr/E1Zbb721pycyMxCE=
Received: from SA1P222CA0162.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::13)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:54:10 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::15) by SA1P222CA0162.outlook.office365.com
 (2603:10b6:806:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 02:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 02:54:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 18:54:08 -0800
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH v3] drm/amd/pm: adjust the visibility of pp_table sysfs node
Date: Fri, 21 Nov 2025 10:53:58 +0800
Message-ID: <20251121025358.3060551-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 039d9ef6-39a8-4a20-9379-08de28a93f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v6olA1QmLKbrQZlTxDw5ePKkiq6njVcliMhqK4WN4f4zMsYNXGGZjBqoLSJz?=
 =?us-ascii?Q?AYBLgS2Z306B6N0TZ4lqcu/YU8kDdJwPjhWRpI9Ru+DOFRB+7rFyERjwrgY7?=
 =?us-ascii?Q?Uei8c4UgIT0skeN0aq9zPQzdMiDcWyvfERoPFKr9HcHWbrmuSXqdDD0+/UMj?=
 =?us-ascii?Q?PFRRKAxNBlb5z8hCHmx2mhsiXkmgxlgRzqR5rhUHmWFfpclzUL1ns87jcp0a?=
 =?us-ascii?Q?d1R06FYVnqIQJ9bcbK4TSi0Wc2jET23j41dkPjdyL0kmKPYj1vX2TOLN/hQ+?=
 =?us-ascii?Q?TgIeAnhIOQAOtuWCmLeKUyzSLvPVTQeVYd/XO8/qzdOzRyZ9JisSPw8Gl9MW?=
 =?us-ascii?Q?dsn0gOt7gHcY+IWCcoA7treFzUswrrbjJrqs7PGqEMLt86jZTSJjNXw3XX0X?=
 =?us-ascii?Q?lTvetgmTO+EiYy3ISlGOvbB+FxZdXdMtStxICnmV2LLlbGH2q9kKfefGFbz0?=
 =?us-ascii?Q?OXG6lFktM7dFCr/so+iE0XIJ9FKAzcxzjv+cFlsNMKHGu+oZ1CycGDa7J/Q3?=
 =?us-ascii?Q?rkM+72t6grlLQu7TKrpvFf2THvkGnmvYwkmCfGpFmCNfLrGAb+1hanfQos85?=
 =?us-ascii?Q?hLHlNiySgGywewIooMK57ZAsf5ifEyYZMGqsBAAwUxaA5fSt6+HlDi5XKsIQ?=
 =?us-ascii?Q?BIhfFbZFkmog2ujLAL2oDjwpiv6ZVbELc6Y6fAG8IclLW4ffWpwhshOj6vQo?=
 =?us-ascii?Q?L57C7gHfZYlpdZOjd+aKTJTe4/J7PKyDFDPDI6sFLVFDfxAbgg9eospymC26?=
 =?us-ascii?Q?JNPzsKtCBEffB3aSe6XgKzRW7V6p5nedLmngbRoUAaCOdPm3CnK+CVe3Q1Gg?=
 =?us-ascii?Q?Xm4rS7pze2GVxI6mHJR1xaUPa2DFwdN82u+eK+cOS7JqTIsmhJdobrJD/mTv?=
 =?us-ascii?Q?l4iwHiMAYOz/e7in4eGY6aPN4wtItDO1qSCccfmOXmlfNp5oZzGwmkj9iu8r?=
 =?us-ascii?Q?9QmLNR7AK/y/mhgq5F1BYV/qa5ieqnd6aBIP8ZtN5A0QZGVp5ZBM9HhkZ99V?=
 =?us-ascii?Q?/DjxdCvOcKTgcPiEelugbTG1Cc3UfY/pYSPQsc+JA6uCorEZ8L4cS+zmhe67?=
 =?us-ascii?Q?ifeoKjWtHPFRPnjYpDJOW9MblFLE33wP678oIgV/7EfxRgIUsQoT4svj6mcj?=
 =?us-ascii?Q?ZkbRbHAQlBuGLGnGzihf4/YETRKjHzv7alReMr7EQZX1jq0HX8kszSqj8if0?=
 =?us-ascii?Q?jPj9qKmBLl3kYtUbdRVZGW6Ztcn6kMDd3yItoaWXW5UBqEHjMUd/iSE0XOfF?=
 =?us-ascii?Q?tkCqY0vtz52cET6vxyfGNfPv6DUTSpicmeGj/eXf3uinItk6yd1XBVvlBXw7?=
 =?us-ascii?Q?wqB/zIW7YaVXViNRiLYUZaBVvloqnyyQGQ86eBL1209K/KwTPfwbPgmFdvHQ?=
 =?us-ascii?Q?abUnVtOWcvntXltSYU/kAZMJuUnG2uMkIEzlgW8I+fnNxT8NsibXThPSEPwJ?=
 =?us-ascii?Q?aYZfsxqTz5CunHdCPfoJXSqa5qVEQC8BIRhO6w4YPC4pO7/FcuEJq2gAjDaf?=
 =?us-ascii?Q?r9UevvRR5f28x9egw/dtLhvZft28E5iH3CrbLBi5jF1RQG+gw1GmUE622cnT?=
 =?us-ascii?Q?clxbVGbQ2Te0JzGxNN4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:54:10.4248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039d9ef6-39a8-4a20-9379-08de28a93f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

v1:
- make pp_table invisible on VF mode (only valid on BM)
- make pp_table invisible on Mi* chips (Not supported)
- make pp_table invisible if scpm feature is enabled.

v2:
move pp_table invisible code logic into amdgpu_dpm_get_pp_table() function.

v3:
add table buffer pointer check both on powerplay & swsmu.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 12 +++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 11 ++++++++++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  2 +-
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c6f55d3522cd..79b174e5326d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1187,8 +1187,11 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (!pp_funcs->get_pp_table)
-		return 0;
+	if (!table)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
@@ -1715,7 +1718,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (!pp_funcs->set_pp_table)
+	if (!buf || !size)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2a9467fe86db..f7103b35a9f1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2560,7 +2560,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
 			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
@@ -2692,6 +2692,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
 		    -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_table)) {
+		int ret;
+		char *tmp = NULL;
+
+		ret = amdgpu_dpm_get_pp_table(adev, &tmp);
+		if (ret == -EOPNOTSUPP || !tmp)
+			*states = ATTR_STATE_UNSUPPORTED;
+		else
+			*states = ATTR_STATE_SUPPORTED;
 	}
 
 	switch (gc_ver) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 76a5353d7f4a..3aaf3dd71868 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -631,9 +631,12 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->soft_pp_table)
+	if (!hwmgr || !hwmgr->pm_en || !table)
 		return -EINVAL;
 
+	if (!hwmgr->soft_pp_table)
+		return -EOPNOTSUPP;
+
 	*table = (char *)hwmgr->soft_pp_table;
 	return hwmgr->soft_pp_table_size;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2aad25dce009..10575ecba5ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -634,7 +634,7 @@ static int smu_sys_get_pp_table(void *handle,
 		return -EOPNOTSUPP;
 
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (smu_table->hardcode_pptable)
 		*table = smu_table->hardcode_pptable;
-- 
2.34.1

