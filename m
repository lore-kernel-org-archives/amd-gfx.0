Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A985C4450E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDC610F0EC;
	Wed, 15 Jul 2026 14:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cnrc94w7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F36710F0EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyM/tMvVcVuaMMeIRZETxcZXW+rsE1KJMQBMqrYG8Le/OS0yDTnaaiUJYcQSB31I67WIQiLMezvyfS5v0YRuZsh7qH3KucDjo6aGR02NMAz8omar72d1SXzAvyGJh1A/SBIx09Gey4vucctPmUX3jnNJ9v/3WT4lbQuIbS3g1Yce4NDChZ36Wyb87yrZ4wdhordqwC3PsITWpdwt1QrHWhTLrxtse1BrlS2P3NeW57PWJqVnxp7XrhRP8Q0p0Vn4HwNY664+5T6Uc5VcLPkNAylQPQSorc/w7h4lRE28SnUiYVE9uMo5/+CCaexc4navjXNRaItyXKws1C6SgqA96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uStDRCgzuf7MedmTnfCytUY/QaDoGCMV7U2/Vy+f7l0=;
 b=qQGd2XgGR28pt8/Vmlwzyx48iWf3RuP9kmL/vDPWNSG6jlmXuimyFWjG3MknwLqe7UTy2xyEjfUzEI882pWNMuV6ttqxa0v3zqh50lQxezTYHv9fAp75t2XioU7gfc1U/7zp2TSq7BBmh19LS68TDjvAjJ9IqffQk4xZM4ASDGOy9siqQwxYKn8HbR9m8pSAtScWkCfUnoHuvjr55+QLwvZje12A8uPyb3M8yiGiChKSwF1Oz4952VmUlASBqywVFOfDn1hHs5i5g23LdzVWcBnnsHxbVlXghUpsSxE5RhjS+h7RjwInC1ThggQyqBmC8gH1JDf3gKJjeyIQW9Ev1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uStDRCgzuf7MedmTnfCytUY/QaDoGCMV7U2/Vy+f7l0=;
 b=Cnrc94w7X/mlE0abZ4ysXRjQ1V05b55hid+d6dMqSoAzpEVhUUHcFfR0GqXjsIw2QSbxPn15OwgB2nlBlQGxscwLwsHDwOB7X9/AL9Imb5V8CKR+0tRhNC5wctlsY6x0xTuCu/FX9iMlSAdxwE8Mtp4E2w5tm6MQTgya/RZ1UR4=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 14:28:47 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::13) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.7 via Frontend Transport; Wed, 15
 Jul 2026 14:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:28:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:28:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 4/4] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Date: Wed, 15 Jul 2026 19:58:24 +0530
Message-ID: <20260715142824.3475418-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
References: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: e52cbca8-7203-4eb6-19fa-08dee27d61da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6XWRRlmrKG8Ft6a3eYzNK6te0+1orNrxsgPZ505iG46FjQiwbhU6v85ywXbv3ZTqh3+Km8kdvRh9LV7tvjOsGPnerUuAxLTL9AFzsK0/H6aXFDNsJBc2w6oMqpEID6kBALwintQVjubRtv7u3kLZ8FSUIvVzxNxHa/ebC7llNLGBGV626GwAQDGIpw96bHLpIs6de3h0oUNcmk4CGqbVPrXMok/SE3CkQ5Viu+gylxCLSv6PyxZEzJgyqRrQ9cNnfxYSyQb2lFtKLdmMjXouRs3Utf0O/SeF1yeceVvsc1bsCrhwV1tDzHpantEkjLJEoXST9IAA9j6ArDPvatrb1oqGN/3KtXRKUr09f4WMS1ZKJrgRTWc8RyTniHgC9sqZ2y1mLOiJFyjrE1O3OQA3IUDdNAsQ7d0yme1X5CjCRP+QHiSLZNQn/+WpZucluLWqFYJRfBjs8K82TwaP/vDINzg7JlsQpfE01Pb16HKyJO5PriqBKWSlWTyCMz4qoT+T2pZo615nlhMaG9WwLjTjLT9hLDt9OybsddP68of2HkYdfHufY4PNODGjQggutvSObX7EquWknFzb4ms9/u6P1I0d4q5DIj1tLxyaP0MA178XmXkffMhw9HGGFJrxdYKkl3Ls0BuqL1sVTisZc/dW544/16pp7/bpN7XtMs3gQj19kxPDSePpYJwoiVIJsqMynkq9tObN7N541ONRx6fdUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QFLSZP/4K43QoFABnYYAR3XhkhlhsjF9qjLKTsv83q8joon9fJnmYVQx+6fji0Jym0oAHZBVFKvJRRvAJnjBOO4dbgegC7wxmAbRSDnnwERRYXhg4fuXRqCqU0gvsZc7id1kjGHHRk2RyfRuIjwxzZQgZh5ikuVXNuzhUpZPhksq79RBOS+N+fLgGKZThA3y+n+j643TbZIQcOC1uX5wJXWZcjE2zjvbK7uJgzpHiHhGKf8VCW/OF++HGqAWmgbr8Xxt3h4p9swz9U3A7mJLR+SVst2TqTwxGhzekf2WqfTvmytEtxG6W3Ko5bJ6ztjLCbLWhBH6c5fvQVaFCsp+Fx9i2MUruBjLvvrUDi/9BVxAYDMgxmWqJaPC3PEF5kG7ZPA9J0q/e9l+fp9cSPsB9mEcGg6POiEvhafVbLFYcXws67FD8FaCS2gSFhZXARTX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:28:47.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52cbca8-7203-4eb6-19fa-08dee27d61da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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

