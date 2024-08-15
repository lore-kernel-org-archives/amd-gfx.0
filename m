Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8CAC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1339C10E325;
	Thu, 15 Aug 2024 00:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSb/0XCK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018D710E325
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTjGheT0djyNlwEfURY+BmmgfUjGq5ZbI/Ye+qvqfoRhYpKB8THD7jC5EveKCS0LrbPRUnoLmk3gpR1q99Ug0QTJ42nYuKDX/pCArSxjVwjUVOvaB4yiyb3Apjh6XCttwc3I5HW1WSh1WJdKfMi7ZCNtFBtHOX+4BW/PujGQsAHjv7yfRj+nQ/mPT9biia9dikSvTkLu4GcUDHmGuh5t1/KhrsF9nsxJ9Y8VKezAliNGd7bvP4U5vAhognEBYkHqD2vS2VRLO8lWvSO+UQ1hgxk4tnYo2J+TvMVHZW+0n5lSHTNlAlHFbLay8vSC+EYxvuUJCBRmxUI0Z3aMAC/XFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgTlHIBMAEFbYXiHAJGUt2H2qEgIyd9MK0nEMsvicgQ=;
 b=JUwgT2MFIFcW5dtjqT2YAyIJsp9AzqyfRKkyM14RJK40xvnSHLfw5sOWs/v9BWpQZWxmU395NccRD5ESfsGPfLNgc3hZcBQbxbjEJeb4OMKXrf4kasHkav5xHvYXqJd42cG+7SFh6mu56AKhvdGPofVCGt0V5TjkNPWz6/I5+yNJEZKG74mgER3AzisZxTDRMtoaxEgpSQd69zwcE0EEZZQU6nQB9etXEVq4+ofVUCP7R+AAGrNrHT5JHz7gB4WAaXFZW2by7s+dPHw3ia2elgUrB3Qi57c8CoWyYAnlauH6C+I+QRGgA4Di6tV6gGotMzTeygLVaj2tlIDrGEIoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgTlHIBMAEFbYXiHAJGUt2H2qEgIyd9MK0nEMsvicgQ=;
 b=xSb/0XCKOJNZtSuP3slxL+1UjLxmo8Ad3oeGJgS2xrWDlmZ808CHhj9j6p1XNFQsJ9lBzY6+4rIubqfqXUa5gw3uW9ue1g4oXxpQQvZdBoIPtH8egJe/Eo25h6WgTpPQCfrzgl8HDFtDnsZxO2ERxNttP4MQ7T/3+RfsU8LwEUI=
Received: from BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::22)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 00:05:22 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::26) by BL1P221CA0006.outlook.office365.com
 (2603:10b6:208:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 06/17] drm/amdgpu: Add enforce_isolation sysfs attribute
Date: Wed, 14 Aug 2024 20:04:50 -0400
Message-ID: <20240815000501.1845226-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 6015c67e-6528-4573-8fc6-08dcbcbdf4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXJpenhISmc3ai8zb3h6bjFSd1lDNm5DRW9MYnFQWTRFUzdtSHh0OUpYSFcr?=
 =?utf-8?B?dkd1QWRrd1FGZDFSeGtaQkZWS1F6QlRZQ3dHN2h1eW13TVgvM3FlRkNEV1Nk?=
 =?utf-8?B?MDArbmFBWXVmMC9pWnJKWTNubTBoamxqRjVVZ2lTZTA0SU1RRXNLQ1pVdkZD?=
 =?utf-8?B?RHBKZ0x6eGhlNEhrWGEyT0pHRHBUU2FDc0djdUloUmF4N282ZloyTlFaVTlF?=
 =?utf-8?B?WGhveFlNWE1zb0ZNQ3NWa2lKMFlVSjRDbG85K1JQVWFPNVVnUDllbWxjbWZi?=
 =?utf-8?B?bUVrNHhBaWJhVXFIVnU5eTJxMTA3WDV4aUxMNkZpWVl6UHVIVUZ0QUVYU2ZX?=
 =?utf-8?B?VlFJSkU2UnpmckJjZlNnME5aeFJLcGRNdHc4bVQzbVhRNTdJMW9Jekp1NWxR?=
 =?utf-8?B?V1dWcmd2VVBQVWgxY0pNY2JFZnBUTHdQcjJnV092WENQK045eGxMcldMbmJP?=
 =?utf-8?B?YWJ2dGNkVlh1M3BsUWNXN0hzNWhQNGU0SlY1NXllL2lVOWNWNnVkTUlwNE1D?=
 =?utf-8?B?MTUyb2FheHo4YlZHZWEvQ2NJM0xBNmpEVE9SRytJM0NtZHIxVUJyV0hrYjZ3?=
 =?utf-8?B?VTRZeWpaSEdveEV5M01hSHVPajFFU1FCN2dqV2oyeXptRzM4bEZZMmVyNXZr?=
 =?utf-8?B?NjgzY3Ayay9KbkJwdXJocGU2UEcrMWVPUVJhbndZMDF1UnZEOXo5a3IvODhi?=
 =?utf-8?B?M09HTXFGQThGa1h3TjVmZHVzd3FyVW1udHVuSFlwNzFybEc5QjV5Z2dlTis2?=
 =?utf-8?B?ZUhOOG9CNHU4QzNjMlJrV3VPaGJVRDUweUFUK1l2WG52eTVuL0M5eFN5b3U2?=
 =?utf-8?B?bGJFZ1RlWUZzRGUxYUI3cTFaVGVnTFBlaFF4TzBvcnhacm95WDJpbCtSdUgv?=
 =?utf-8?B?enRvRHI5alZSVFI0dE5GM3pEcFFPVTV6VzBSZ3c3VWVQb0ZOa0VKb1Era3Yv?=
 =?utf-8?B?djdrT0VqYVdiN2ZnV0RMNjhsL0hOa0ZYak9JOS9lckpxOXZWTldaRFA5YTNW?=
 =?utf-8?B?LzVVa0k3MkpueVVCZlF6NzVjVUhPQ0VqNzFFQTl1N3pzcWx4cTg1RnRlVVox?=
 =?utf-8?B?YVJEWHBlRnVyNmlKdVU2cExGWERYWFZ1d2QxRzRUd2NUWUxuU3dmVjJ6am1x?=
 =?utf-8?B?YUlqd2FTTTRUekVsUStDL3ZNNXFYOVB4ZXVOSzZ1K3kvRnUyUkZJR1I4SDJI?=
 =?utf-8?B?QjZkMVhnUVRBTTY2U2J4L3JjL2k2WUFpRWFGdDRtUk9HWEYzaE01QURtOHpP?=
 =?utf-8?B?RDJEWmJUSkZXRk1yTXBwRGlrTlNXU3BFTURScmVCY0NlNTdBTkd0VDNoRUZa?=
 =?utf-8?B?TCtqMlVZVmJESTJLMjVwRUpKdFB3Qi8xU2NvTllTUDFIV0xxRHRLL3locUFR?=
 =?utf-8?B?QThRdjh5S0w0MjArZVU2d00wTXNBMFVjdDVMWmpoRXllSndFYy82OVk3dUpU?=
 =?utf-8?B?bGJHaTR0bTdwVzRZRUZ2blEzTkNjZE02RHc5a3M3enpCRU94cnZ5dllRS0t4?=
 =?utf-8?B?Qkw1UnVkMWUrQzlrUStKZFZTM0M5UGNEQ0pKZy9SQ2pEcGlrcVdMRTE1UXpQ?=
 =?utf-8?B?NVY3YVJIalkxYlJzR2IzRHg4OWZTYmIvUW50VDBFMUdQeEZXRHJUUGdWNGtH?=
 =?utf-8?B?Y0RURE52T3FBZWVTUGhtanJBRVpCbXc2MDlsU293cGwxd2JwMFROUXdKYWds?=
 =?utf-8?B?MXRqUVltK29ZaWh4bW1ZOFh4djk5SkdwRzFUbFBZS2VVSWdjakFmOXdhUDA0?=
 =?utf-8?B?QVVLRXJYMWo0VkFqam1YZm0xRDhTNTZiN2lLZ3MwdWhzd1M3NlFrb1N4akhM?=
 =?utf-8?B?dHJ1MlBXaHJKaXZ6YWVhLzMwVGgxTjcramhVWkp3M1ZEakpUVXBib0xLNXRv?=
 =?utf-8?B?RUIvZTJ0aWZ6UXNMVm1VT0dYSllUckZIZ09WaXlkenI1TVdLV3U2eEt1UkJG?=
 =?utf-8?Q?OR5iRLmf2o7Mvk2YcVt05+EnUxQSN4ok?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:22.3127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6015c67e-6528-4573-8fc6-08dcbcbdf4ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit adds a new sysfs attribute 'enforce_isolation' to control
the 'enforce_isolation' setting per GPU. The attribute can be read and
written, and accepts values 0 (disabled) and 1 (enabled).

When 'enforce_isolation' is enabled, reserved VMIDs are allocated for
each ring. When it's disabled, the reserved VMIDs are freed.

The set function locks a mutex before changing the 'enforce_isolation'
flag and the VMIDs, and unlocks it afterwards. This ensures that these
operations are atomic and prevents race conditions and other concurrency
issues.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 101 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   2 +
 4 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ae3e827da5ec..fac632986866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1164,6 +1164,8 @@ struct amdgpu_device {
 	bool                            debug_enable_ras_aca;
 
 	bool				enforce_isolation[MAX_XCP];
+	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
+	struct mutex                    enforce_isolation_mutex;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 95953c028ca5..a6e714d1fe4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4064,6 +4064,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
+	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
+	mutex_init(&adev->enforce_isolation_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 4ed69fcfe9c1..2e35fc2577f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1391,6 +1391,88 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 	return sysfs_emit(buf, "%s\n", supported_partition);
 }
 
+static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int i;
+	ssize_t size = 0;
+
+	if (adev->xcp_mgr) {
+		for (i = 0; i < adev->xcp_mgr->num_xcps; i++) {
+			size += sysfs_emit_at(buf, size, "%u", adev->enforce_isolation[i]);
+			if (i < (adev->xcp_mgr->num_xcps - 1))
+				size += sysfs_emit_at(buf, size, " ");
+		}
+		buf[size++] = '\n';
+	} else {
+		size = sysfs_emit_at(buf, 0, "%u\n", adev->enforce_isolation[0]);
+	}
+
+	return size;
+}
+
+static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	long partition_values[MAX_XCP] = {0};
+	int ret, i, num_partitions;
+	const char *input_buf = buf;
+
+	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
+		ret = sscanf(input_buf, "%ld", &partition_values[i]);
+		if (ret <= 0)
+			break;
+
+		/* Move the pointer to the next value in the string */
+		input_buf = strchr(input_buf, ' ');
+		if (input_buf) {
+			input_buf++;
+		} else {
+			i++;
+			break;
+		}
+	}
+	num_partitions = i;
+
+	if (adev->xcp_mgr && num_partitions != adev->xcp_mgr->num_xcps)
+		return -EINVAL;
+
+	if (!adev->xcp_mgr && num_partitions != 1)
+		return -EINVAL;
+
+	for (i = 0; i < num_partitions; i++) {
+		if (partition_values[i] != 0 && partition_values[i] != 1)
+			return -EINVAL;
+	}
+
+	mutex_lock(&adev->enforce_isolation_mutex);
+
+	for (i = 0; i < num_partitions; i++) {
+		if (adev->enforce_isolation[i] && !partition_values[i]) {
+			/* Going from enabled to disabled */
+			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
+		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
+			/* Going from disabled to enabled */
+			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+		}
+		adev->enforce_isolation[i] = partition_values[i];
+	}
+
+	mutex_unlock(&adev->enforce_isolation_mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(enforce_isolation, 0644,
+		   amdgpu_gfx_get_enforce_isolation,
+		   amdgpu_gfx_set_enforce_isolation);
+
 static DEVICE_ATTR(current_compute_partition, 0644,
 		   amdgpu_gfx_get_current_compute_partition,
 		   amdgpu_gfx_set_compute_partition);
@@ -1417,6 +1499,25 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
 }
 
+int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev))
+		device_remove_file(adev->dev, &dev_attr_enforce_isolation);
+}
+
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
 				      unsigned int cleaner_shader_size)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5ff3ab7d429a..cb83b66aba89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -559,6 +559,8 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 				    unsigned int cleaner_shader_size,
 				    const void *cleaner_shader_ptr);
+int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.46.0

