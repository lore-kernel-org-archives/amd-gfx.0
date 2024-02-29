Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E69C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 06:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E3710E039;
	Thu, 29 Feb 2024 06:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zamF16ux";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD2910E039
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 06:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyHINs3TpFeJz4HrXAW+TAqhinQOOTGPvbdnpwuTQdRE3U7/0GUbmsBieXt1hvHsH9JPQGOpguotBAAJ67+q0t7K5WQWkb2FJHB4rFVWGGHBXuQTSbJKhOPz6mjdb4GCSIMSq0gJJYMEzHdj1Dhp9MJ5A/kuGMHUAZT3eBpTkzsfx1TS2/hfxQ3eORHcBlUowr/odxoZxFPqO0NAJIItZUadug6/yfNAYkoZF3Fx28+cHbAdh5MF+LhoepmArQhAO3RfWesaNDIlXBFqAeroW2rzqTiGni2WV2ThhzThr8nSeL7/4mSd0gbG1Wym+9IDcG9FLz3hjqHgiUObDLMD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OzC/h5E3vOVnGWcD4IEMXLnJZzIgOatszSgNl4FEHI=;
 b=HnO3DVsWbbCBRqkoAdBJxvQHhlmIsn0/z4BSI7WmiiFvzg05w6lZxfJQ+OCOebCkypP3a9OBxi0AzH0WJO4XfEFy4JGwn7jgC2VnrtfDJNqlmEulV8Hv1SNou8m/iFspyKD0D2KINiymPtZyeDSMsDLmNM588wJetw/L3qo4e9Rht+rm/3YBgiWznC0/Ni7YtAP0fsMYno7SIiEVW4yB/qjV5tQCJNqoopfRO6sKF5becVbnHs/qlniCPiEkIXCmxmmFPMl1iUh4BbXyEeglw9pKF5yItAxBw1Gy+boxQQMNsHc2UrLI7qIPiHj7siyflg8kyvR2hNz/IBKLkNiWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OzC/h5E3vOVnGWcD4IEMXLnJZzIgOatszSgNl4FEHI=;
 b=zamF16ux2M3+mm1T56UENUK0x0dJO1kkkxpZ4ofPuF61vsRyxV8gOn7oYJCm1cgzNb4vGubOgUZZny33vBk/w63zwVtVzPg7AUF4AvJ+zU9NbLRAC7+yMcUB56tUFW5f4j5OjtJfLfcCkGEEW4ZyATEQ/WtCmHJDgsuei04qS6o=
Received: from CY8PR19CA0023.namprd19.prod.outlook.com (2603:10b6:930:44::9)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 06:20:44 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::d4) by CY8PR19CA0023.outlook.office365.com
 (2603:10b6:930:44::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.31 via Frontend
 Transport; Thu, 29 Feb 2024 06:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 06:20:44 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 00:20:42 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>, <lijo.lazar@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
Date: Thu, 29 Feb 2024 14:19:41 +0800
Message-ID: <20240229061941.1970301-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cf7e3b-a937-426f-9bcd-08dc38ee8fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+a9y1eLgraWwz15FPMfaz3xOjvYrcXE+pqhxSmCZ63Xuk7Ku/zlWI3H17mLuNXJKE8PHQJFNCsBILeo9yEf+/4AdVdv5UxDD9Wohf3zHjrHIUy8syfeJW3/XsWHe5p9VFCQnWnxqfVrb9nlN0D8fSwYPGSEZ/UYtpQv6Vesg4l3vto2U5yUXmFf4uCJxlfFBVTNjJoIX6cla3JHKS9fWRYaODjC6j/TgXvgL19qO2fCbxjpS8/iBw5hekf3UoAbtK/hRfoxTKhbg1PmZLdeLZvblPdFBODAMXnRbinq0F3nCOzJtJUmEJhZnXrrT9cgEcEId1I9lxXHNiDGccWrsvnaokixU/u8F8UCfUd3ycqdX43CcjICU1IRJi6Lxa3WrX5z1+bpmWfQakZPsULASri32vRRrr/3moYokt5vQHzfA7rAK3BLE4MVHFf4G5rYrcGbH4qPfeEzLdHix+NEwKQenaf88YsW0XXqi65kopk2Nmzj49mHlbRK34vDpGHDWaK4YPmpr4lzgZQ78QU7jv5Rz3GSWqFuQqmDTfNW5XgCkb2sc+mtczB5tFb/0lVCq4jcii/KE2Qu/VBUFtowUBT6gBxVJGsUyvEtfcgm6cbzTUjeRJeQfvUVPdkTaSh9dFYVDutqDuJS+g4bDfJRKbadkvJeZ8v5PPvnEtFl6Rkfx3FV9eNpaKdWISuB3m/jxkjzXqhsW2feeVVIek+4YtLXZ3ZEkbg8l8sTml2nyHBng39RQ1p0xbyk6MgCUBcL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:20:44.2590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cf7e3b-a937-426f-9bcd-08dc38ee8fab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

Check return value of amdgpu_device_baco_enter/exit and print
warning message because these errors may cause runtime resume failure

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e68bd6f8a6a4..4928b588cd12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6000,15 +6000,24 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int ret = 0;
 
-	if (!amdgpu_device_supports_baco(dev))
-		return -ENOTSUPP;
+	if (!amdgpu_device_supports_baco(dev)) {
+		ret = -ENOTSUPP;
+		goto baco_error;
+	}
 
 	if (ras && adev->ras_enabled &&
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
-	return amdgpu_dpm_baco_enter(adev);
+	ret = amdgpu_dpm_baco_enter(adev);
+
+baco_error:
+	if (ret)
+		dev_warn(adev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
+
+	return ret;
 }
 
 int amdgpu_device_baco_exit(struct drm_device *dev)
@@ -6017,12 +6026,14 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
-	if (!amdgpu_device_supports_baco(dev))
-		return -ENOTSUPP;
+	if (!amdgpu_device_supports_baco(dev)) {
+		ret = -ENOTSUPP;
+		goto baco_error;
+	}
 
 	ret = amdgpu_dpm_baco_exit(adev);
 	if (ret)
-		return ret;
+		goto baco_error;
 
 	if (ras && adev->ras_enabled &&
 	    adev->nbio.funcs->enable_doorbell_interrupt)
@@ -6032,7 +6043,11 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev->nbio.funcs->clear_doorbell_interrupt)
 		adev->nbio.funcs->clear_doorbell_interrupt(adev);
 
-	return 0;
+baco_error:
+	if (ret)
+		dev_warn(adev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
+
+	return ret;
 }
 
 /**
-- 
2.34.1

