Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8820C982D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 06:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9033810F17B;
	Fri, 18 Sep 2026 06:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAMMXLmP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7ABD10F17B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 06:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo18bPg4PhEqDcccfdZ0P6pyABFCPg2C7SynxdqzzAcAa5m/JJqkSq5WIbfciRnJdErSWhhlhVdQffljEDf3X1CMY1Iu87xN+jmCprbS+dPEhqyrkweRcbAkH3XAPPsk0C7Jw3nTKckh1H/Y7GfLAUaG1fyKQSR5UJDuH0cVI9Bd0GLD2dCtdI8pD+OuuwrqUOhp6iycPKaOV8bPZ3N1YOZFzscmhBY7iylBprt/JcxK2qbBPEmlrwrQXwrimucxjRB8elI/cmEZ23DJxYGQHsC6QctS3MMXX45819rxleLvMqf+6izcmsTMf/W21bdzo01zSV2KxHpNqtkPCTeyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic2yLiMyV3/ntx0LfKU89xtFakVbAR5jHH1YEqOnIB4=;
 b=iljZFkQBeqijofoD4ddrkAtbygY0xxwoT9Ae9yDfZpy+/olWqOcOwe0sicrSPIeBOwTeS30VmIMl+dOZX3KyIzBRhLlndlzwz8iZJBS+V0RYAOoSD/Q3ePc3/D7++W3Zr9M7qKhavgOLdV+FrjEf1mVvfl0JAw7veFfcySpM8bpeDMYMiF1G8ppHaX2nLgy6pdjrvnLvC/g/iIcrHPQVIxmzZQhAME+aeZWTj0jhJWHTQMzA44mpWfRd/5hld9MhkBnL7tFUFwdPjtNyHHq+2EqOFa/ho+jkG12tOxt2d77/jQx9f8CQmeF96+TnBPy/gTEnIStDoE/AX7c+NJYpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic2yLiMyV3/ntx0LfKU89xtFakVbAR5jHH1YEqOnIB4=;
 b=rAMMXLmPF5EzSR+RzGV0jMTkmHZn7b9bIddFLmUZHGLAQvjSjbSdxSl2kpPqzNSs5SMipeOT7+1dKEZ3JHrjWIFFay3w+40ZbmWzXcw3aYilTnkxsoHwZwbGDhFFJFUKCaEaozjer07OQJSZGczML6gU/6sc/Rt/gCWeEp1X6d4=
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 06:10:17 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::6c) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 06:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 06:10:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:10:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add NPM status sensor
Date: Fri, 18 Sep 2026 11:39:55 +0530
Message-ID: <20260918060955.1802688-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ae9fc4-7e57-4038-cf59-08df154b82ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NqCyX2btMhCqqR59uk+7Zzoe1e4JMMKslFRp920p+fSWDOXAL6PmT08J57jQZHxZV8O8WhS3iaKpOGdF8ZrGaro/QSi5O6TajMaDuFaKPiRhMhu/hV09a3o3+NpAe5b46PewS6wMCw39VkJoNqKUnhtVXI8ugwh7hTsvs1KhvdLW/M09L6L1gpRs/SkEV10OznXN/CGdvvSr5kjvP/utttGu8Nw0zufCr2s5pmVSsB4RsP6v+Ii7unMnypWwC5thTjS5pByLysmTV6Dn5Ea1zpklWN0maOzqk6Y7yIMLqmcQxyQ7T6s/3UHXkkwamWoiWlxUMZM4jXh3pLXlqfpHSH2Yn1+DJzJiz/bOMME9DBEFJTcYKH208VC2JsXmC/6nE3Nvt5ry50abk8RtDX5gGID4DEjet7wrlBli/NEUvKeLknQ5TXjjRVbFk/59kOY+kqlFmRoSCr66BB9ItdbeAwC7AIMqNKDUcb9b6ddXbThpSXggqLFkmq7+oKoPYV3yg5493mRxx1nepV4cCTOaQ9BolBgC3kii+gdgYlU+PYJ0gzPS/nH8XqXzL5hoe7JH1Tui+ML646hIJhJa2CduMEPxkP7Yxe0b+def1xnjK4QiC0hEJ3I+KHQrhxrSm/k38cWPLvraEPbxITtOKoB/A1AocRdaHGb0NzkW2zqFb9FXswa3gnWpX0DNg9LFievZaeQIufad1EMtqwsgLXjxIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nw2o31hjyo8pLY4Ql7hYlgCGDnSG/Tej4nMXo+9bghaDNLFFNKPfj/sJbpSctXp/n4jbvQtAgllnisV7TFgDY1RwBVjofQ7tnzIKO+r77SWWI0YhXLGvwcj9cnK9kGOIDZur8PrRS1Pw2bR59s2Pbq4I9lHyr9GZLlSraDnbsgyvHvPrG1RHQPR9zmmf7i/Pq34FR1K5Ol5aWflZdvfM4qG7OBA+/VyMDKp3n2S52jf9yV0+jLHP7RDFImLq8n8DdDwMLpbXwPHR/gATuQbhLoopurCPFB4maD9Cup7OicbIyx81lsF4mz+gtNlBOUpvsrhgPXkQ7eKT38lxkmFiszuJtYq6QfyKkZI4gwVylr0qOIZIjY+jJ91jM+Ma80vjhDkxMPNDI7MUNMxe6JnFsWH4jteaM5d93ReDvIFJ1UrlVui7QrdA/E2tRaA+7h3C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:10:16.8673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ae9fc4-7e57-4038-cf59-08df154b82ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

The logic for checking whether NPM is enabled/disabled stays within the
particular IP version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h        | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                    | 9 ++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 4 ++++
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 5e8476c4b808..4b863a2e38f1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -172,6 +172,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
 	AMDGPU_PP_SENSOR_UBB_POWER,
 	AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
+	AMDGPU_PP_SENSOR_NPMSTATUS,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6f8252376127..c6e3748bb11b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2266,16 +2266,15 @@ static ssize_t amdgpu_show_npm_status(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	u32 npower;
+	u32 npm_status;
 	int r;
 
-	/* get the node power */
-	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NODEPOWER,
-					 (void *)&npower);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NPMSTATUS,
+					 (void *)&npm_status);
 	if (r)
 		return r;
 
-	return sysfs_emit(buf, "%s\n", str_enabled_disabled(npower));
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(npm_status));
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0ca5973391e8..1691a0be4f7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -685,6 +685,9 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 	case AMDGPU_PP_SENSOR_NODEPOWER:
 		*value = SMUQ10_ROUND(metrics->NodePower);
 		break;
+	case AMDGPU_PP_SENSOR_NPMSTATUS:
+		*value = !!SMUQ10_ROUND(metrics->NodePower);
+		break;
 	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
 		*value = SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 83a5a4614a4b..95e288327e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1678,6 +1678,7 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 	case AMDGPU_PP_SENSOR_NODEPOWER:
 	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
 	case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+	case AMDGPU_PP_SENSOR_NPMSTATUS:
 		ret = smu_v13_0_12_get_npm_data(smu, sensor, (uint32_t *)data);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index b69efaecc1bb..5c8bfe7ecaa3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -618,6 +618,9 @@ static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
 	case AMDGPU_PP_SENSOR_NODEPOWER:
 		*value = SMUQ10_ROUND(metrics->NodePower);
 		break;
+	case AMDGPU_PP_SENSOR_NPMSTATUS:
+		*value = !!SMUQ10_ROUND(metrics->NodePower);
+		break;
 	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
 		*value = SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
 		break;
@@ -681,6 +684,7 @@ static int smu_v15_0_8_read_sensor(struct smu_context *smu,
 	case AMDGPU_PP_SENSOR_NODEPOWER:
 	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
 	case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+	case AMDGPU_PP_SENSOR_NPMSTATUS:
 		ret = smu_v15_0_8_get_npm_data(smu, sensor, (uint32_t *)data);
 		if (ret)
 			return ret;
-- 
2.49.0

