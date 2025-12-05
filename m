Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBACFD2F7EA
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 12:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6270210EAE9;
	Fri,  5 Dec 2025 12:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ne3QvX5+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073BD10EAE9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 12:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvw32zcWho30A71tnnq51DF9/I8JFEYHVp4yJk+fevIcWgkUr1ApRVIgZyvEhX7gmsU3Ha/Zkc6fsEU5Ux3+BS310hjk/SfQzMv2NAgXBxXVltTCU/hGvmSPlTEawFls1JHa2j2cKpDdMRKlrVB0n0sRhAVkagE0L6L1LmWpzyAM3Hh8ES6alq0i2U4kMItXoofXq6E+bnWMolqCjk40TRLDSSkUAE4QAKs/a39i6sHVorJK/sOmkubZeIvDvMWHBuZrW12K1rOHP0HbdUbs9JJRuKkXN/kbUCkkv4OeAouKi6UsdTRQjYdftOwPjSwnJq7UlITgBast/ajIZe06tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/MFEIPAOIN0zHFhjUz/YMr7U8VjwdCMQnsKBc/D3o=;
 b=B7+KvFJ4t257wCO2MGoQUB8QLW5jWyQZ2vDuApnI/D07W8wxAclWqxIRlBiC2TuRBeDS6LuEfvl163aXDdlqAIAPCG2ZYH5zuBvvxAxYojc4wuoKuX4Qu5vi1wOoyOF99WwofZobz+e4bQQNKKhIHjaFXKbW0oU5izcMds7YBec/oYe6G4f4TJapR/ZN8Rl8hz4ueyIY3f5REeYKWH9A/5c59xP3gfW9YAWV65ipc0r6gppWHMdScBgmNPoOBT+xcHr3vTh5KqvwGkwDgfM6Fivhf1qOWOd2Ub6ESa1ggMorb5QqPsNilJK95NWl+hIiYNyQI97dSMlQf/mg9bqRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av/MFEIPAOIN0zHFhjUz/YMr7U8VjwdCMQnsKBc/D3o=;
 b=ne3QvX5+hnNwL55I0dDtxeK2ar1rY64B3gMWdTz4AZK/Zy21hJz1/Ep6j+G7q4hM4Tra5rfYl6fMvR9smg4urnKAMeQUey+OGfZVVfzeIdJW/qxKNqa7LnEEHAjFi4A68vw1Rrs94LhDN8g7op4P9rjhzSE8togC/s8LJDAnfwo=
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 12:14:26 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::2d) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 12:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 12:14:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 06:14:22 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Reduce stack usage in amdgpu_userq_wait_ioctl()
Date: Fri, 5 Dec 2025 17:44:14 +0530
Message-ID: <20251205121414.408466-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 463c4170-2198-4b2e-0fef-08de33f7d4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUZEV3MwTWFmYnJRQ0xRbXVXMnpURVlrazVvK3hSSnhMbHEwNy9rMURXdEYx?=
 =?utf-8?B?a2RUWGRUZmFDaExiVzdiTEVxZGEzT2pDdE5qN2RYQkNaaE9HeDU4L0xsRmov?=
 =?utf-8?B?Q0lIaWFPYmFTL1BCaHZqU1RQZUxsQ1Rnby9peGhIeHBlWmoyanpmaUhNZnNa?=
 =?utf-8?B?V0dOd0g2YXFXOXZCKytwK0VIVEkzSjRBeHhJQlMxQzU3eGoybnA1OE5vRFVE?=
 =?utf-8?B?M1FJNEpnR3BsRnF2TU1qWFNLVmh4dTRqTGpxZmhya1V2UkVEYUlSUkplcWJ2?=
 =?utf-8?B?bEVBN3BOREs0bU1hSnZseURCVm9IRFhab0grNTA2Mjl3TE9TYXhRdzJNa3B6?=
 =?utf-8?B?VjRRV2ZEWmpxclNTMWZoN3ZNZUlRdWpvOFhSUGRzR0hYMFQvbTRUNmJxaDg2?=
 =?utf-8?B?enZtNGR6a3U3V2dtdVJpWDhuT3JhTjZEZ0tVREhweFN5QVJPSG4rdlc4NTlY?=
 =?utf-8?B?dlVzQUNURys5YUlzWm1rQjZ6QjBNOGNudVQyaTV5RUR3ZDBaaXdTdWVXM2pJ?=
 =?utf-8?B?Myt1Qk15NVJKRTZlRE9ZcWxjNmpKV0FwYnowNGtGcnZvV0NtZDduMWJ3RTVp?=
 =?utf-8?B?bHJtRjdGUUNWWGprdkdKMUkvcEhpNUk4NEljeGRjK0kvSGdXR2JJQmcyN21r?=
 =?utf-8?B?QXdBaGhCMEVVK2lhclR2bUpOalByZzNva28zcmRFeGt1Nk4wSFZUY1Y2MitU?=
 =?utf-8?B?ektjSVFBcmRaQzdMK0Qxb1dNZGc0MWp1akR6ZStsTThXNnFsclpRTExSWThi?=
 =?utf-8?B?MUF3eHB6UjR6ZGp3bFFkNzhHRTBHZnBPRHVvYmY2eFl3eFRrSmQ4aHB4UHNF?=
 =?utf-8?B?OU80aXFTVjJvMGE0ZUtiUTlLVUpraVJKNU9xYkp6VHJiWUNIcm43UVJEOCtx?=
 =?utf-8?B?YXB2MFZnWWRjd1RLcGtSQ3B0SkRYQjhIMkJXMUZNOFZTN0g2NEVyaTBlcHpC?=
 =?utf-8?B?RXJNNlFlaEVIQmo2Smx6ekk1TGoycktWMkNtMmgyZUhtK00zUGJkMTZ0VVl5?=
 =?utf-8?B?MmtYMjZGeThzRTlWa3VLaWc1eTE4M1Y0dE5QMndmOG9lajZVdStOcE1qVlYy?=
 =?utf-8?B?RktvdE9kdDVWeGJTQ25lR25XcGsvZXkyZXduenQwQW5XSEphYWwyZ2FhdTAw?=
 =?utf-8?B?OG5nNm1JUVpSN0pOeUJLZ3kzL0pLL2xLNXRXQ2hxa21jSVhSc0RJRTNWcElJ?=
 =?utf-8?B?YisrMlZSZUtKTWxSSDVIRUJSZ1JKcFI3WkQrUU92b2Qwc2dTeEdHTHc4STNk?=
 =?utf-8?B?YytQblQ1UEJNaHFXbnNKcDFHVVNxUXNqUEJxZ0tFVStsdUR1VVR5VHlNWFdm?=
 =?utf-8?B?TTVMVDRaN1I2RmdSZjJ3ZU9GdUlLQlhuT1NLMVQ1eitoTW1VSmNDSGFteUVB?=
 =?utf-8?B?cDBBYkxuTTBFQmF3SmRuZkI4Y3hDQTlwaC9uT2M5cXV5MTA1dDZrSDgxYmtP?=
 =?utf-8?B?bGhLL2pEbHJLRmcvOHMyVVNjbkNLWkUwSjhWdEdyR1dGUlFRc1VNTjBiaHNI?=
 =?utf-8?B?MGYzdGkwSHVCYW5ER3BvTUZXRy9YUHREdTdUQWlXNnQyb2YyeUJMbTZyS0ZV?=
 =?utf-8?B?b3lTUTRkUnZjbTFBVkhmTGRldk43Rkc2UXAxaFp6UnVqM3V0d2pnYVpaNkRY?=
 =?utf-8?B?ZFg4VkFtUFhZdGkyUUcweEdRb24xL0tvMnRPNVFrN0RHTVBodmhBREdvZ1N4?=
 =?utf-8?B?dDJtSERPRW5PY3d0WUhJenhlckEySjEyOW4xZWV0T1J0NENSY3kxUFAvcm5N?=
 =?utf-8?B?TWxtYS94UDJUN3lBcHFhc1g0NmlISzlYY0REQ0owWFZjYXZmaW10VHZLVWo5?=
 =?utf-8?B?S2UyNmpNZzBGeWREUndHTm9WVEY4aFZtVk8rUTlET1QrNW1uU3IrSkQrYUt2?=
 =?utf-8?B?TjNNdzVKM3JGeEUwMVMycUxDTTRrcmpyZ1ZLMU1HbGlyTTZrVk5rSDIwZWtK?=
 =?utf-8?B?WHRjOU53TUtDVVI0ZGpFa0FVN09zdWFYMnoyRjlwRlRIcGdqNStKUFJkZjRF?=
 =?utf-8?B?aWlEUk9mRW5DM1pvOG5QdDE5NjBjTnRnRXFYSWpTVGFpb2U0SWNMMitra3BJ?=
 =?utf-8?B?SnJsK3BpaGI0M3dHTmJyN3lhVkRqVDhPZzRlZngrYUNBS3kzWGV4cWRCUDhz?=
 =?utf-8?Q?rWWU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:14:25.1282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c4170-2198-4b2e-0fef-08de33f7d4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

Checked all the local variables in the function. Most of them are small
numbers or pointers and use very little stack space. The only large item
stored on the stack is struct drm_exec, and this is what pushes the
stack size over the limit.

To fix this, struct drm_exec is now allocated with kmalloc() instead of
being placed on the stack. All call sites were updated to use a pointer,
and all cleanup paths now call drm_exec_fini() and kfree() to release
the memory safely.

This reduces stack usage, fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:642:5: warning: stack frame size (1176) exceeds limit (1024) in 'amdgpu_userq_wait_ioctl' [-Wframe-larger-than]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 40 +++++++++++--------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 25f178536469..b5839acde14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -654,7 +654,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence **fences = NULL;
 	u16 num_points, num_fences = 0;
 	int r, i, rentry, wentry, cnt;
-	struct drm_exec exec;
+	struct drm_exec *exec = NULL;
 
 	num_read_bo_handles = wait_info->num_bo_read_handles;
 	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
@@ -721,24 +721,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+	exec = kmalloc(sizeof(*exec), GFP_KERNEL);
+	if (!exec) {
+		r = -ENOMEM;
+		goto put_gobj_write;
+	}
+
+	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
 		      (num_read_bo_handles + num_write_bo_handles));
 
 	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
+	drm_exec_until_all_locked(exec) {
+		r = drm_exec_prepare_array(exec, gobj_read, num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(exec);
+		if (r)
+			goto exec_fini;
 
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
+		r = drm_exec_prepare_array(exec, gobj_write, num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(exec);
+		if (r)
+			goto exec_fini;
 	}
 
 	if (!wait_info->num_fences) {
@@ -966,7 +968,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		kfree(fence_info);
 	}
 
-	drm_exec_fini(&exec);
+	drm_exec_fini(exec);
+	kfree(exec);
 	for (i = 0; i < num_read_bo_handles; i++)
 		drm_gem_object_put(gobj_read[i]);
 	kfree(gobj_read);
@@ -990,7 +993,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 free_fence_info:
 	kfree(fence_info);
 exec_fini:
-	drm_exec_fini(&exec);
+	if (exec) {
+		drm_exec_fini(exec);
+		kfree(exec);
+	}
 put_gobj_write:
 	while (wentry-- > 0)
 		drm_gem_object_put(gobj_write[wentry]);
-- 
2.34.1

