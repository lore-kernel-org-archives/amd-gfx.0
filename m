Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CBFD10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AFF10E608;
	Wed, 26 Nov 2025 13:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UD+kf2dY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1724310E606
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhU+uUubPCD3S3ejpzfATFAu8yexsMTDueusnMJ75j56h9pKUDM1ulz0zX3Iqsa4TLlTbct5a3kAs/t+VL0xUFuEc6idl4X7AFOw+w2icKceENnFHrXjdSrAueBNlCoRZl0UStSOFG4aFXzzMqiWVhmI3ALSp2PBXbv9mnZAaeI+XmZHLwiAfsiGOj2sn9FFtJqXfdSEeggINIFdsmHEDCXgkeUHHyiaiTU2BxZZABGe7KinVzNvawVGk6bykkcPuIomTThbyrKzdybpJ36zRzc+vVXvYUB0vtR8rOFsTIgmbQMtehz0rJRPdBBDsARkfdI9Pv6007IhU27MmzLNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C55SHRplRVgEzvjKhjSRUi9HeHibejPkQ7S1jN104o=;
 b=oOLIiRdBNX1nrRD4UtiJNlq1zZmH8N57tHlKSK0xQ2c7kzCSWolC4B5UYwpGe6/DchlSywt4k0qco8XEBjPullduiPW+OaGusG27IRkZomGOCjjMmmO3Jof26EbI+ZYTv3uE/GxdzAkX4cYIL5q7zUjS6TSdKwQ3deNPsYvBz0Jph+Qh76ZqQTT379TJeqT1zscNMtSK4Gwbs/b0v9OohIEUTtshDQ+mRfrc6WsnqV7SWU91/s+CWkSD7wWVCTdr650nOODCpZuTqLsE+fvzOeZ7Il9UjGyl/GzSP4U32EnzZ08cjiqLFa6Mc7vYmT1q8uOprINaRyTdCiVdL5Y1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C55SHRplRVgEzvjKhjSRUi9HeHibejPkQ7S1jN104o=;
 b=UD+kf2dYkhL4BpZFQ27yn1iiWfwpGJ+C8N4dHD9iAzgy4n1wAQ3h1XJ9/VGAJHvhmrLmoyJAB2GddRbo0D1y4esoX51YtSjphkOj8gv0XGZMo9bMCoTlmsnEpC+uvBUUa4uRY38Cdu2mbxuM8TBfvU2a673JY2J/bsi/73bUMOE=
Received: from BY3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:254::30)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Wed, 26 Nov
 2025 13:29:16 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::bf) by BY3PR05CA0025.outlook.office365.com
 (2603:10b6:a03:254::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 20/20] drm/amd/pm: Deprecate print_clock_levels interface
Date: Wed, 26 Nov 2025 18:54:07 +0530
Message-ID: <20251126132822.3266730-21-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: fe24461e-69df-4858-ffa0-08de2cefcbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBScY4eT3G2fgNtfpATq0hpjb4R8q8WxfIR/gSu8+KJNew0ZmKLK9qYs7X9y?=
 =?us-ascii?Q?F4VezYn1fW6CIDFbGCsFItFrBscaMvPX41eu8XsTfUru6UqcDLDYZ1x1jgWy?=
 =?us-ascii?Q?KZUjGJyHWNB/Q1kgNTDG3R5kaBR1rfH4KFArNRbtQ+kHj19Huj2U9/LIhrGN?=
 =?us-ascii?Q?nPWRlqxAbuY9qf2EwVGvC5E9KE1j7NmhdqsMSTgmCgZxqgVzZ03f8SqyIj9B?=
 =?us-ascii?Q?qv8w73H3Omn7j2/y9yUNAB924u1Kdi4EPQhq/masnnJ2rL7HLi9i1Cs1H/d6?=
 =?us-ascii?Q?Qg7BM7+lWIL7pmVPbVVyY+0Cum4sXlmOKuFUrprrIfqqTzdhj7YkNPBEdxbg?=
 =?us-ascii?Q?9IyLvLHz5TyNBJAPUoz9wqv6mRbvq/hSRg3RlO6JVLRU9N7iMq5rKBkJLeFI?=
 =?us-ascii?Q?zrj0j4aTsk/wTnamsp3NJSabgi48u9aB38Iw8f4PnXamCbEjVrDGgJESqW4t?=
 =?us-ascii?Q?380FmueFcvNINeE6n3DalzuR8ssN6sZggOYG4bK1DTlpnEv98B93fwTUUSvL?=
 =?us-ascii?Q?CyOMDF0lWxm/X/zYHLJbJ8V6da0NmqR9Xw4kc13G8LIkbfpswUtiBEfVcp/a?=
 =?us-ascii?Q?6Nh3IIJYKbgo3roT8aZETER/hPMxYEFPdUkTaEeLaApQYysLJHxro2MU7RTX?=
 =?us-ascii?Q?C6OWRA9GMAeFxVgUDH0dEB38OXa1d0krRCwCBobLgdzLBigAZYv+AxL5KZRX?=
 =?us-ascii?Q?Tr6K1/hsAxWyim4aAt/HXEE11h2dzO8+Qy5BxCWW1uLXY68JLmdaq6MnSdEM?=
 =?us-ascii?Q?rTeMdp2B/noDTkEJJOmo5blwYlpF0IYnL6JJhgrzomKZ96XzAUkL2NtYncyq?=
 =?us-ascii?Q?MOZZeQS0ycbqrwJjbjzvPYRUVKACFtrDUk0kDkduyRP6KTtQFwZYYtkKhtci?=
 =?us-ascii?Q?t2yBsu3hCnsU168mceWEJeWNNUfc+CBVIOJPn5GTMtOOzcS1nstxdUAu8X/s?=
 =?us-ascii?Q?b511TQtKuMwiT1S59svxEmrZoqU7SdjE5HX9mXcFvFNVycSsqL07QzTRnzRp?=
 =?us-ascii?Q?pggDznevfH+4E4Ul5AbfMbh4pvmT2c74w+yODF6tG6WvdV4v2ldph0NAcMt8?=
 =?us-ascii?Q?TJ8tIpQQV4x5FiQdziShWkw4eHuY6M0z906TgEZepRHiNAN55mw7hgZINA2P?=
 =?us-ascii?Q?YEXGA731SiJ9TGuCxfClP7zRDzkZShnrSHWgiOZEywDYbe475eUCduOBTCju?=
 =?us-ascii?Q?871UtVkun73pwcrZn+rhrdCej/wDNRUSnfLnYf1JIOkf41gOzEjm9OLW30bc?=
 =?us-ascii?Q?Y3emFRxnd/2dIw+R/ctRqgWetT2Wp4kzd/8WdDkBvlXdXvmY81EG+IM2+LMw?=
 =?us-ascii?Q?Y/V65f0r01FQYrmXBFQOWJUrQaM94k68b4U/3qunt3FFkJ4l0yqf3zZzyuia?=
 =?us-ascii?Q?dFIX8OIQuTJ8EUxK/Mj6Mmwv+ORKQJf0CuD5NnN2OFbt7SM2klRQdqpGEOQS?=
 =?us-ascii?Q?BWodvBPi1Lr227vQWs0v2q9rQlQd929hsB+Sj/rVdvB6VXXit6Q12p+Gvma/?=
 =?us-ascii?Q?azr+lQTVMG82rCUjRAqp67Rq+TV5Nk7wmh9o5i+p0rxGcHm82CW9cxPo9s9q?=
 =?us-ascii?Q?pxnrK7EMKd94+gyYTVk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:15.9029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe24461e-69df-4858-ffa0-08de2cefcbbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

Use emit_clock_levels instead of print_clock_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 19 -------------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 16 ++++-------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 16 -----------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 28 -------------------
 4 files changed, 5 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 79b174e5326d..74bb2d9f7faa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1243,25 +1243,6 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
-				  enum pp_clock_type type,
-				  char *buf)
-{
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
-
-	if (!pp_funcs->print_clock_levels)
-		return 0;
-
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
-					   type,
-					   buf);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
-}
-
 int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  char *buf,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f7103b35a9f1..4c152df3fdfa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -864,14 +864,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		if (ret)
 			break;
 	}
-	if (ret == -ENOENT) {
-		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
-	}
 
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
@@ -1000,8 +992,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
-	if (ret == -ENOENT)
-		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
+	if (ret)
+		return ret;
 
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
@@ -3922,7 +3914,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
+	ret = amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
+	if (ret)
+		return ret;
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 3aaf3dd71868..c10cb8124349 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -724,21 +724,6 @@ static int pp_dpm_emit_clock_levels(void *handle,
 	return hwmgr->hwmgr_func->emit_clock_levels(hwmgr, type, buf, offset);
 }
 
-static int pp_dpm_print_clock_levels(void *handle,
-		enum pp_clock_type type, char *buf)
-{
-	struct pp_hwmgr *hwmgr = handle;
-
-	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
-
-	if (hwmgr->hwmgr_func->print_clock_levels == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
-	return hwmgr->hwmgr_func->print_clock_levels(hwmgr, type, buf);
-}
-
 static int pp_dpm_get_sclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
@@ -1582,7 +1567,6 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.set_pp_table = pp_dpm_set_pp_table,
 	.force_clock_level = pp_dpm_force_clock_level,
 	.emit_clock_levels = pp_dpm_emit_clock_levels,
-	.print_clock_levels = pp_dpm_print_clock_levels,
 	.get_sclk_od = pp_dpm_get_sclk_od,
 	.set_sclk_od = pp_dpm_set_sclk_od,
 	.get_mclk_od = pp_dpm_get_mclk_od,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f51fa265230b..b7dfd98d387d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3014,19 +3014,6 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 	return 0;
 }
 
-static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	if (smu->ppt_funcs->print_clk_levels)
-		ret = smu->ppt_funcs->print_clk_levels(smu, clk_type, buf);
-
-	return ret;
-}
-
 static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 {
 	enum smu_clk_type clk_type;
@@ -3091,20 +3078,6 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 	return clk_type;
 }
 
-static int smu_print_ppclk_levels(void *handle,
-				  enum pp_clock_type type,
-				  char *buf)
-{
-	struct smu_context *smu = handle;
-	enum smu_clk_type clk_type;
-
-	clk_type = smu_convert_to_smuclk(type);
-	if (clk_type == SMU_CLK_COUNT)
-		return -EINVAL;
-
-	return smu_print_smuclk_levels(smu, clk_type, buf);
-}
-
 static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *buf, int *offset)
 {
 	struct smu_context *smu = handle;
@@ -3941,7 +3914,6 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
 	.force_clock_level       = smu_force_ppclk_levels,
-	.print_clock_levels      = smu_print_ppclk_levels,
 	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
-- 
2.49.0

