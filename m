Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B121FC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F11910EC45;
	Tue, 14 Jul 2026 08:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJZVLP5n";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C4410EC45
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9wPGpH9gI9rFv6I4oeaku/dcfAQKE719PvgW8zBLteDG1+ZQZFmakGwU58fuhID4E+M/+Xzyv+QqDBKr0MBJ8Oi/g8Lupkg2kR2R1m397WWLf9zr+fGbxKitoYQfQ0FUSBHh2tH5Ljg8+HtuzQMal+zhHWQ2bEd4iVrfMJeOoDh2hWsPpJJNCJzB2YYT+dJ1r495dXx02me94u3FycBr0NGNqC8RNeZ858uc7pXjlJ9n7Tige7LBjOQa2YzxJcZGU0MhV/EgVpiuULa/e2Sdbd/W/zg8NqDRTYSHfZAHt32jK9QNeNKmR/rYY4EVBdgTRc4kHKEUXkwcA/Q5r4k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uStDRCgzuf7MedmTnfCytUY/QaDoGCMV7U2/Vy+f7l0=;
 b=RmG4szmrVxrg1j36C+TddhjEGWGr/fMbz7ql9nUy9IBZpjAadV5Es7xAcclz1r63CjQgPAWZXAZ3o+WRTAeL2PHOs7TaU2cGw4QYoOsarW5MsVxUE7ZgG5mCNk297BZ/zAYQfDGHwvii5FNK0UBtJdlhlehZb5ai1di/N0tLj0dxIALsbWtY41t6dmPAwAEMS7+iQPnv2nnMy58AlFFMTEr1duP+T6d+5Aetvg0XELzUV2pSRAlhC9v3KxHAQuKjbEte8qxAdOOXPEuzD8R4LX0Fzik6kzuSIQaAvEeGJD0gIEEQnH6sjKiypfleIC9RxWq3mKbPYDwConrgZlN++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uStDRCgzuf7MedmTnfCytUY/QaDoGCMV7U2/Vy+f7l0=;
 b=FJZVLP5n7VLBPa6TZFN0TVkpU03vYDQN1oojvYI3VmCCUrvjUwWHTj8om955lJ0GZ3Njv7sTh35XnqPeAD5odngDsNf34RlyQj+EJmXc4DsSdMH0FyW/Yd7afB6hHNo+9mR9Ajxhkpl0rmwtTxkj2+0oWVy8x4JRxKtDYw4eVbQ=
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:03:21 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::3c) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 08:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:03:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:02:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 4/4] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Date: Tue, 14 Jul 2026 13:32:20 +0530
Message-ID: <20260714080220.3395155-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa1e10e-653f-4873-6064-08dee17e5f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: dpS3U/m+NDZCxi9LuSHE7G7aK2vVwi6nJWJ8A/f3B5nzxdcFMO00bU/AXG8tEOXBR43fzBPyiK0zKN+b7ekt74ApCVuzTzVUGgHlJBbImZapwTJpJ8e/zajX8UUkNRf7Eh4e6Lhp4o/QZSGXaO+TbdI6+7JuxLLdvx4SQHAu5mHaD07wKSH/UaOVMupjDfaPqweqRltr/vX6iQlr5uLPPohW1FYFlid35BquyDi6CQcBLyMv2GEoZxsgbmn7a8FQl6TPz+oTKUT1dsomYAMe4o6tre/az1/w4VZKptKp4qRcbv5dPpyDx2K8GknWxNqT55TmOnR98LqlAGK0Wi+CfVNROIcfhuWCYUkcsAW7VW7WJqLtzCQi+SlPYlhFv4YCNEFsl+DiC2BV52XzNeAW8JnuHH0C4NM2vBgZAEHxrTd4G7HKgG2wJ5C4RKK0KOIWVTawGEQ4klEi896ATK5hNh0JiZ0xrOo4wZ4FPHmBOAb96byaVkK+lsbL1IYyl4aSAlIbIm2PxBHeT4utDFkwwW4X9GerGE/Czb49uF8HVszrP0Xelj9+JsW4ny/2zctppMoK2op77iLTWvVtHUowPEmhyuMf4axtF1Mmy/nCkyAQz9Vj2WQaR1HS323X5FVQHrDMU7I71VjZ5XGHAhZ3zdZ8ms108x1VkDoVcuWoMm/PbnsJlNFYC0yZEfR0ien3SEYAwPH31/nq4CSDUhCy5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0uZXTTpt2x8eGyq8hwSfZmRfMr3tWM8ok67dTGVII+AvcB/IgHRWQSZjI1exSP2Sri1lN13ADDxq/KFpHs/w0/Dnxfo9vPRh0SXr+9Z6cXZ/OCWs3VpesBrPOab0xWc71GACxc9nni/FYA0rScXQgUYJY0CqjNwQOGLFfdmdxltMj9weTveBh4Y/XkMNjcwPsC9Rl57M7RekWacBMaDS+dI6tgp6o8gehBb8DTz6MONHsOL3qJfW7m6gBhnLMuEbn4xT0UOcDB62sako1kq5VDDQk0poRIsv4zFU7+hTPHPNTnOzuT5fr3CJNUrNbVbyeWkgvaR/Jnxxy2HF+Ergyd1XcLa72+KBXWY/7lpPROuVybjHK6nvuLyHIoKlp3jyBe+/hL3e2TUaUQvd2tgG22VkvyjUP8s4xiZgikwzfyzOyoaZMLQmh7XovUtNaKDH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:03:20.8282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1e10e-653f-4873-6064-08dee17e5f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826
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

Signal GPU_RESET EVENTFD subscriptions after successful GPU reset
completion.

GPU reset notifications allow userspace to observe that GPU recovery has
completed and the device is operational again.

GPU_RESET is a device-scoped event, so no queue object is used. All
processes that subscribed to GPU_RESET on the device are notified.

EVENTFD remains notification-only.

v2:
- Move GPU_RESET EVENTFD signaling to the path that confirms a real
  GPU hardware reset occurred.
- Notify only after successful hardware reset completion.
- Do not signal reset-skip or recovery-only paths.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c924a55fd16f..15aaceae13d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5390,15 +5390,43 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 	}
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
 static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 			      struct list_head *device_list,
 			      struct amdgpu_reset_context *reset_context)
 {
 	struct amdgpu_device *tmp_adev = NULL;
+	bool need_full_reset, skip_hw_reset;
 	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
 	int r = 0;
 
-retry:	/* Rest of adevs pre asic reset from XGMI hive. */
+retry:
+	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
@@ -5430,10 +5458,30 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 		}
 		if (r)
 			adev->asic_reset_res = r;
+		else
+			amdgpu_device_eventfd_signal_gpu_reset(adev);
 	} else {
+		/*
+		 * Save the reset decision before amdgpu_do_asic_reset(),
+		 * which may clear AMDGPU_NEED_FULL_RESET before returning.
+		 */
+		need_full_reset =
+			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+		skip_hw_reset =
+			test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
+
 		r = amdgpu_do_asic_reset(device_list, reset_context);
 		if (r && r == -EAGAIN)
 			goto retry;
+
+		/*
+		 * Notify only after a real hardware reset completed.
+		 * Do not notify recovery-only or reset-skip paths.
+		 */
+		if (!r && need_full_reset && !skip_hw_reset) {
+			list_for_each_entry(tmp_adev, device_list, reset_list)
+				amdgpu_device_eventfd_signal_gpu_reset(tmp_adev);
+		}
 	}
 
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
@@ -5530,7 +5578,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 	}
 }
 
-
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
-- 
2.34.1

