Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19315CC6B10
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F95C10E75F;
	Tue, 13 Oct 2026 08:25:33 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3C610F5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYTmPmEdpHK7lTuJLNsVYwf6gUS3IJ9alIWjR9/oCdflrUGqPTOX1C66dTKea3fbz9EwMP+nYkQacR21WRU1pZDERCcZJCA123JFDQytuICc7eZXZdJ18mpMo+qzuU9R+E4wLKx8whNkoJheGWGV0ztrjuAZxOaJCAM5G1PHihbp29vwhI97d1QXd15ZfHZ4eg6ZPfBSF7wkce5yvCxPsIQ9URz4LVVpeFhp861wrerrsxO4ixgMxAQYF5xChATHVt3DPxFp/S4SbKq3qVVkL/J6Sk63l5RzVWT/HfqH0ypflFqEotk8Iw9ZKGFAYDSA276LYtvaFLzJbrnDO7nBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHEi5OIeanD9gHSHoYugxIkJuZFm36t4p3+KlBf10Y0=;
 b=K5rHFjqPVL8MW4X7xN14ATEvShgIdKalATbP9Rx7djJmuKrhg91gHsDpvRLwvjidLlILcVuPxMpVicG9yCRm060SFmGSOlJwC06Fu8wlwPDqqHVRn4+LzMWYngcITNHQKn/NKoWhQZ+lDEO17g0VvkEEoeXywY7sNa0ybociPEGM0Lx3DE48Zh2VsOYfXUxp/5ypplJa35ZcdfvdnKsT8SwOs0Wx8jiOpNm/n8K4pFlo8s7l327wlOB/stsy6EwrK/gDHSjeaxOulTWbvmuOKqqGFjirTGcUk0hlGg5LZfk27UtJe1X/VOWi/dYzc5u2Kfisq8FJxugTnTHKeUzJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHEi5OIeanD9gHSHoYugxIkJuZFm36t4p3+KlBf10Y0=;
 b=T3ZbgPN9KGFsJ27bahKeK3GC0ojuSbBbP1kcqIlZHJQkMBzjy5735bsYdLtUijkWjUgpKVbRCKoY8IuO4o9ZGrEddaRavH1EQRkGPpCmfd0XVZwmSpiR6iGuetEq9d/4VjTF8vBzwQ8ATQPZ7stt+R/m3CGT6WeZx6hR4UVgPzQ=
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 PH8PR12MB999272.namprd12.prod.outlook.com (2603:10b6:510:42f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 08:25:23 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::a3) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:10 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Date: Tue, 13 Oct 2026 16:24:53 +0800
Message-ID: <20261013082457.2492273-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|PH8PR12MB999272:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbc5532-50d1-44fa-c5b3-08df29038671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Ddt7fmJweO4fAbj2aMQijQLQ4DV1sNcxe3iOR0q41Pxjo6dgPT7lb9u/mN3YcY4tf+DYIcPAaPWN0LzsiwJnMEJbKb6bS9tEOqAj4UrKWGghSbyk1xdCRSlM682lP3W9BN+4N9xaIPnWiGjq9hKBACyqE+Kh2u7BdV+OXgDDLmWETFi8KFhTGpHcPF3lgEHUPsLeGl0AL0kr6wE0YgFhmR2WAZd+cI9MzSQqfr4RPelfuAHuraVVRo7bNSjmOOlrLW8dL+OOUASpOKhhPStMlih/QrvxtMA/1I64mO/00JDr2MMCKi5fVUyrKeVlmMCk4unE4iii9teItbxXoCPOTL0yW3mKQNvu5jxN5v8X4sD9EGh7FnsGFVfSUJnoKOVwj6z2fVSViTax+caJxuAcSgi8Kh9PQmdgpKmen9+sdKDUEVh4w9+gYul/reSytaTL4rGfIpEEikIkJhismRVcnQDhoCTwCgUGgfOt+H3UQfhznlZtPfgITv2EzvZjACO9W69Ld/vMhSqtpeK+VFEtRElbcvAeuUEDVLXNu4qud1Yv9zX8UElq+1rpadoWHmlLegrxAwagUBBINOecg524hYfofHIi99Sfpeuz+ksxANeLzvm7dITgDeXc5/L9+MRy+J8D2qd+HYDY0wz3tPjHjeeCf4aexwx/ZYO0S5JyfPxsvxPhX+fgebQjaFBNp3IKXRzLfbM+wOSvIUb++Ykz+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B+riZZxS3Nrnde/9cyrT8lWyj6oMewoJ/Uk6KLjWc2q1ntIp7s0b0p+p02LzEH3vZn9cGVkeL2VlsYn1G2Y12RMYZ8jGjtx0YbX9ZIrwxh85d9E3yXqHWBuJU1kFGI2EbsmXNQajkRvLHtewZ1DvE6rufUMuhU/1gweEI1sFMh1t+JE8FwssgMrzCUeBUg6lqI/G33PH4DJsBqocY0K82fCVEUiAFqpdcgfQulfnyaXct0AAN7CAYbY9ydQpO3IcdRXrtMupr2bYPsbGLBBbjyj+3pWtBVExF5YCEVrMfVs/98mHhHSM3s+GGyiaQjERLf5QTBrVPKB9WA6apVqKsGDRzETH0RSfHGKVyb0d7NoX2ZnKPy8hElUJbGGf45OBu33gxNEIups1p/J9MI7W+oeW5/bAKR3D3Qb/YTAyZTXptO/MOY3tRFmw2sXHv51q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:22.6337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbc5532-50d1-44fa-c5b3-08df29038671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999272
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

Run GPU post-reset callbacks, including KFD and display-audio resume,
before restarting DRM scheduler workqueues. IP hardware initialization
already happens inside ASIC recovery; this change orders the remaining
callbacks before new scheduler submissions. Preserve the emergency-stop
and guity job completition path's callbacks without starting schedulers,

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fa67de6d066c..83d98c9191b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5783,8 +5783,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
-	if (need_emergency_restart)
-		goto skip_sched_resume;
+	if (need_emergency_restart) {
+		amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+		goto reset_unlock;
+	}
 	/*
 	 * Must check guilty signal here since after this point all old
 	 * HW fences are force signaled.
@@ -5794,18 +5796,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
 		goto reset_unlock;
-skip_hw_reset:
+post_resume:
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
 		goto reset_unlock;
-skip_sched_resume:
-	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	amdgpu_ras_post_reset(adev, &device_list);
-- 
2.34.1

