Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3998CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB5910F238;
	Fri, 12 Jun 2026 05:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRLU7oU+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0001810F238
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLKpatvk8pJykQVdzQivZp8hhMy1CgmxBcIRU9/ciiT3nGr5ajo97RPx5r3hFL/J4944D5wk7xoIr2nT+OTXERTduS92aw52WvBiRd4XF11GANoO8DFeVigBzlY998p7ESF/i+ZBrtCC79ATZ6iTR8BTsVW2qGjcvDpdELNgmYuQF8S99Ul1IblgFFp3IvSLSTGmjHvh8KsnfUejqWRf0F2t97VPxtS4aLztCsXVDfZAeluj1kuGjrzV9EX8Kst0erLt4vWoGqXC6EPm+1IJJ7E6juMLGMWmH5YqWiWcJJfkX4X84a9WCxhhpJwjLsnXZslozet7+iKTJH/02AYpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63+PykalBZ6RkWsr/3oq3xK0hoEoIQbivudq4iws65s=;
 b=RGZPeH5cOmBR7ktRPa9ZK2mrpVr/aJF6CW3Tn6BrbsxQi5p2mGUH47BDJVCgCkzwzOC0EF4iKdmDvFhTU9Ghg3ves2vKbUWGG6hO2lGHUbtx2elpsg7IR18qF0WEyMWYcQdxhfUY2UPjLml9DmRssIXAknNRnzse/ynReFtiUW5L1iqHIxP/sbNfcGmMPq6F01ucm6d9x5ECTok4cxIijo5uhROUFmD77124kbIn+H5+Rrw0P69NaRmXidH6SIVLwAqcT4WZj67fbUZctq1WL/D8bAu8USE3Vui6qmXmRKH87rxD40mthVmh4q4NHs5Z+hlT1orqQyvsPBsg/y9CLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63+PykalBZ6RkWsr/3oq3xK0hoEoIQbivudq4iws65s=;
 b=oRLU7oU+BdyXz9MD9M0KSu7opPUq+bRIm60Yrrw5y3ucm9tNDEfA84cOWUruVxwaeUncclNtZWkW6b77xaLh5SIhuYIlflVk0aurCZxkxt+W/0YqDGG1cdOUc1wbTN+aTum6Z3GXqDWr0uIr0Jaqqm+J1wX7szBqytbU3w8nuOY=
Received: from BY3PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:39a::34)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 05:53:04 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::74) by BY3PR03CA0029.outlook.office365.com
 (2603:10b6:a03:39a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 05:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 05:53:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 00:53:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Date: Fri, 12 Jun 2026 11:22:26 +0530
Message-ID: <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a562bd0-550f-4a13-2e7d-08dec846def2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: dofZazFHeqKzlYCLP7hjK1cY+cftxCFLQ7b0MmksVUCsjZLxYdpzN6thJe5hodCUgTXIbGMobtQly4XoQbFM6WKXxf2vXJsRErUd+XZaFNLK76mtHhzs91t0mnth2dB8XRwceeXeRjyxdxDoni0ZJyLkSRFBYvqg6wSiEufpGe2sm/0MrgMgnAfCxhEG3OsQ9JkE9X+3qL+t2ESUEmOWwzr0OhGH608/gafP8SQRNV7ABRYC4uyoE+VTfiXosu527n842YHKscMk0o/XjfAYKrEVQlpsKY4y22wSDPhM0K9TlAKcJenX6bW7QxBKZJjljPqxLm7Xl+SMmsauZHOkIlZIeXVAENBsnZ8rOcf1MypTziNE7uNRxa6ZWIOhvQZbiGC5y4H6lHc8dLRAmza1iqi8/KAEWY98MWF1fL67Mm8Wqj45JshNnyaee885+F7C5d09qLYwVuXAtFoNbgKQPcXphzKDHGuAQumQLc+NEbb/SHtg2k1o9nJGd9Ki1aurHUDP9phOFg5NuW4cr9Dp8Zh+wAxwCAeAbUnR2j620bo3sktKDcVGwV1NzCYf2yYBFetGObHyJkaBu0ag4UtT/j36eWLcXWKEJY2vUVuXrh4yPP38JqIhboZ7NsH4s5NsypSglEsAOvKNqIwC8yi1ML3pKj4YbT+zyifWnWwQO7+F+v9ajadrhJ5vvC7UBHsI7hqdfImWCv8WdDxkj0yH2JGaRVU6C2MzKDYRrtoxj98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OOcjq5F0vfTCB3oj8AYT77rcCoEFcQ9jY0DcRg4VP7gWXR6jhaEc2ZtVvfhFqmg4jzhGXKcoeRsniz9GWZiLydBmGE4btqevup+E7q0sH+b7rCQAP0ACOolhcyZmJFKn1phanAWkZ6FBr/d0EbDTFrvc048F+ON7KwNS2gsD8oEXnRazM07+aqYuLpuSTnTgK+r1SSczbtfdfRV+5aB9ZRZL55+qCp/3vwpix/NI0NHXt5QfIUFmwUsZV6eU3zq/Oi9iEn28jyvB3PFSLyvOCaztTZCfXu/8x0a+YCKPmPB+K4OaR5mJEdjfIVvP+RjW981EdmHjtu2oXSsMPv/gL7ZunvxJVf+gECOIgGc0yOcbMvJp6f3Bmo8aM0GZk070qXRm27os0R0q9P8kq5gGr9iylXOaSSDAEm8wmXZdKevyFfnfXEQ2qYh/P1DDuBsq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:53:04.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a562bd0-550f-4a13-2e7d-08dec846def2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
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

Signal GPU_RESET EVENTFD subscriptions from the GPU recovery path.

The GPU recovery flow already determines when a device reset has
completed successfully. Use that point to wake up matching EVENTFD
subscribers.

GPU_RESET is a device-scoped event, so no queue object is used.  All
processes that subscribed to GPU_RESET on the device are notified.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e46cdd6ecd42..8f28716912c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5694,6 +5694,32 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+/*
+ * Signal GPU_RESET EVENTFD subscriptions for all open DRM files.
+ *
+ * GPU reset is a device-wide event rather than being associated with a
+ * specific user queue. Notify every process that subscribed to the
+ * GPU_RESET event on this device.
+ */
+static void amdgpu_device_eventfd_signal_gpu_reset(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct drm_file *file;
+
+	mutex_lock(&ddev->filelist_mutex);
+
+	list_for_each_entry(file, &ddev->filelist, lhead) {
+		struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+		if (fpriv)
+			amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+					      DRM_AMDGPU_EVENT_TYPE_GPU_RESET,
+					      NULL);
+	}
+
+	mutex_unlock(&ddev->filelist_mutex);
+}
+
 static int amdgpu_device_sched_resume(struct list_head *device_list,
 			      struct amdgpu_reset_context *reset_context,
 			      bool   job_signaled)
@@ -5738,6 +5764,9 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 		} else {
 			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n",
 				 atomic_read(&tmp_adev->gpu_reset_counter));
+
+			amdgpu_device_eventfd_signal_gpu_reset(tmp_adev);
+
 			if (amdgpu_acpi_smart_shift_update(tmp_adev,
 							   AMDGPU_SS_DEV_D0))
 				dev_warn(tmp_adev->dev,
@@ -5775,7 +5804,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 	}
 }
 
-
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
-- 
2.34.1

