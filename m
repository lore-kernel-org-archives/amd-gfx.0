Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA7C02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 21:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392D710E02F;
	Fri,  7 Feb 2025 21:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlbeAZJL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A5910E02F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 21:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTKu/G6eS6gzk4ND4a7Ylp7y23Y582I1dbFk4Q9CjQl6NuPeziNTQ+7JQdX/iXAS+8iJb9SJeTmn2M7E0XrjQUfjwz0CN7DxKC54LV14UmzYs+gvLug/7YBo7XL60Bb8fVBRxIYNHJEYcFczO0aoI0yGELF7f/tmlCxX8NxjmIAGEgYTTKX6wGOrUCeVDtjVOR9UfQJJO96wgMGaV+8iS1o4tOA7q8H6eoAt5q2KkIGMQB0YBcXr5zH1tqTYYa+u70kSXaxKhpxzRKFKIdYalsfSyGdBAbzKZQ4de/jFIV7e9F6+JsKszV6MTGVfawB5tuy+0tYpuuqOE3PU2PDoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG4vq7JJbrrADtEctZ9pUodNIGxFvYFh+O2J6mrnEeo=;
 b=v2j8eMw09Jp764rW9SnbPPqdes7M/adwdHxpEGnPhz8oGpujqPMCXdHVcl3vDg9ZX7KnMuoSNfMw0D4Nx/4vXVfvPbTURP2rhynyne+a6KsJs68xc0EwASRfa5mbav+keVgmmlzwaA8CRB5Pjk2p0mCD0/RqRIXRkfKaDNs0cHgcyj6mcSvxmGi3BsdrthhPrI10vvaeXZJmXrrmnR9GQBDJHNaV62nmibes/kgPQMfgxzQhFe7nqS5adBSvWbC2U42H9r17Dh6ADRo6v9KkGcL+baOvj/sjv4bvdN/zMZMlpBxkJ5lu/pLSjY3WDnUofg2PEgCGtsS22VEajqmhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG4vq7JJbrrADtEctZ9pUodNIGxFvYFh+O2J6mrnEeo=;
 b=IlbeAZJLz8uk/826BuRKn5Axf+vgsgqHXA1xWpFPvONwxHRH/fC+cIVFM58TDLE+tqFwL2ojzBQMH5WEmtiU0VPvFli4ye90263ywBDnex66Yig3kkFS7uIhtivXzQp8MW599hEPhl/ydqO6ZW+KGLP1pvCLeax+vrCZrehBP1k=
Received: from CH2PR14CA0046.namprd14.prod.outlook.com (2603:10b6:610:56::26)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 21:27:40 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::6d) by CH2PR14CA0046.outlook.office365.com
 (2603:10b6:610:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 21:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 21:27:40 +0000
Received: from rliang-PowerEdge-R740.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 15:27:39 -0600
From: Ying Li <yingli12@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Mario <Mario.Limonciello@amd.com>, Alex
 <alexander.deucher@amd.com>, <ray.huang@amd.com>
CC: Richard <Richardqi.Liang@amd.com>, YING LI <yingli12@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add support for IP version 11.5.2
Date: Fri, 7 Feb 2025 16:27:33 -0500
Message-ID: <20250207212734.1986678-1-yingli12@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 556a123d-dcf1-4f40-cc84-08dd47be4069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rde5g3BPkOZRV340PS2HPIdVineun4UwC/EtTbl+SLD4gmUYiguB5xcA3BfZ?=
 =?us-ascii?Q?iM2ccLpdahTFDPGiJT99RK7Ez3+53y/et4phc+tCFfUZSZs6fmQMi7u/O3O6?=
 =?us-ascii?Q?/ofBWDD5vlULsDfKqFSz8kJEOqbFskPTnHm15iH/8gWZs/d6fDheStU3bynH?=
 =?us-ascii?Q?bIR64iIeiMp/RvCDMAhk3T5VDzKbpmZLLkqyDLUhhFi0AtqA0JdooQ5QS14h?=
 =?us-ascii?Q?uGj0CkEl7GDQselVXK5N9JeSjJfMyYPk700yQ8feloF6nVlekVMq2I0j/Gyn?=
 =?us-ascii?Q?0QHmY+0KxNaPZ6Y3PQAkMudKO/hDRX2gLrngVJ3KbuN10dZ40OaJxzM45YPJ?=
 =?us-ascii?Q?GVfemM4y5sVLTQLwl1faG6AbtS/DNcs7pUQrA9y84BXoq3tAPOI/JNSK+fmh?=
 =?us-ascii?Q?L3I6nduVzBZvEBSpoZshHVi4wlVUEOAn1jxgnKoBnOSqMw0pvrRIunimhOpy?=
 =?us-ascii?Q?cXoSzPcWE+svBzevtSgLngjRi3PabqwTNerWctPm2zJJnd1vgr8TyztYdHkE?=
 =?us-ascii?Q?pgzBV5XB8Piq73C22Dp29P3QydoWGO04wBdaKCfOd5056mYazDkcCMhTO6zr?=
 =?us-ascii?Q?d/9aJ/pQZAXJJTCh2yfIowhh4OuI6DPSsKW+PR/6JArNPBluv2RQy/+q2gmG?=
 =?us-ascii?Q?i9dymgS7xHdSkJcGFUDAcI/99C4hvUjDqYArLpdPnO+jEexp4k176JyTX994?=
 =?us-ascii?Q?JRx7yxb5jZNXq06X4S0IirAZJuSmFGxZVYOu517EZI+Quu+e2S1GSqziAvq+?=
 =?us-ascii?Q?JFgfciYjmcFrH4mlv5rb8HpybgnVsHxSSZATFIXKZsBNMAo+O68Tl4HIm1XD?=
 =?us-ascii?Q?0uxIwVwxfP9A58xDS6Zgf7KkylacRgr4X0KXxwne+1CP4tbH5/KODy/Dtj4b?=
 =?us-ascii?Q?vtg57ZLfShTn3XeXgSoV9EnGdbKz6esC1GlEaKvv2yYR2VztDm8m74uQSaoU?=
 =?us-ascii?Q?Kqk6Tq4gCrC/T/Np3Ekt6Yck0E+Ys0cD8k6GwEd1T0HREEsSE62mBaBnDB0E?=
 =?us-ascii?Q?Nta6sbfLUGT8b2ByYiuEOU0GgbtzxRPEDv1ZwNQT6YDwvOmx8PQcNYLAyHP0?=
 =?us-ascii?Q?zWjyKbn5hT+2gJwpI0tIDie7wHAmCPy6PIvtDcvq3oRjUvlNQgLA4WYS+xjl?=
 =?us-ascii?Q?oKRHRRV58yMiM4rjo4M9t5Fmrbs7iAfsjjLM92UcnRT05W1DNIE9iIV7zHNe?=
 =?us-ascii?Q?OnGbRrJFDBIMdHxhesCOjjzhIehocutUaNnuBuO63leZxJuYK599umq3dd4V?=
 =?us-ascii?Q?6kcSOinMGCK0h+Yq4Xalei0zCFutNCslis8fyTiK6u9Yg/+OqcVRGSynaByJ?=
 =?us-ascii?Q?g4XLiopU7+ceBf23mfTDxOOXwaR0cqrdS19Gb/1lrkS4R1ui2IOKLNGFgNT5?=
 =?us-ascii?Q?pzGkIr1NxBbozSuqxMtj8djhaxxOw23jgfUXzCB1CPEnExLjTegczYOpsfGu?=
 =?us-ascii?Q?IQ1NpQWvS+Qbjydr6Y+bAH3ESKJETkpgYBR5M7GD9Prxkmw0NRcpWIlm0fKv?=
 =?us-ascii?Q?oOvrAuzirXrihWU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:27:40.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556a123d-dcf1-4f40-cc84-08dd47be4069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

This initializes drm/amd/pm version 11.5.2

Signed-off-by: YING LI <yingli12@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 51c2a7f4aba2..dd4cffd94a90 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -693,6 +693,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		renoir_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		vangogh_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(13, 0, 1):
@@ -1565,6 +1566,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 0, 12):
 		if (adev->in_suspend && smu_is_dpm_running(smu)) {
 			dev_info(adev->dev, "dpm has been enabled\n");
@@ -1918,6 +1920,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 0, 7):
 		case IP_VERSION(11, 0, 11):
 		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
 			return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 189c6a32b6bd..8a9d5ec2fd43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -227,6 +227,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
 		break;
 	case IP_VERSION(11, 0, 12):
@@ -471,10 +472,11 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
-	size_t size = amdgpu_ip_version(adev, MP1_HWIP, 0) ==
-				      IP_VERSION(11, 5, 0) ?
-			      sizeof(struct smu_11_5_power_context) :
-			      sizeof(struct smu_11_0_power_context);
+	u32 ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
+	size_t size = (	(ip_version == IP_VERSION(11, 5, 0)) ||
+			(ip_version == IP_VERSION(11, 5, 2)) ) ?
+				sizeof(struct smu_11_5_power_context) :
+				sizeof(struct smu_11_0_power_context);
 
 	smu_power->power_context = kzalloc(size, GFP_KERNEL);
 	if (!smu_power->power_context)
@@ -731,6 +733,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	 */
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 11) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 12) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 13))
 		return 0;
@@ -1110,6 +1113,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.34.1

