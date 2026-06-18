Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102E7CD98F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7ED10F171;
	Thu, 18 Jun 2026 05:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKLl3OuN";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96E110EC57
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DchqIlb8gWiOuBYuxa61OWW7XEn/eo2Eo9b5b+UoriSmf7m3l+5AvNEqp5vx5XbaQxEXqGpOv4IohSxmvLvYeLHHddUx+ULovPxWozRAqYg3qFmfkZw/ocv/e8X9Mi86Sg4kghiOIQduxKnDxANUhnN3XL+1+avMN0P0TWQ9lQ46dLV/vS2L+A+QVS8urQ6v3wNQW3cgMDfBNSql24LLBJBKm/8TKk+8hSvAVJtIXKWbIkYr/RNZSiuNGAbvghQlhEm45CIHq3RmmRBpy3jP27Lm7aVzOGqzSe5xl+nNMQ6tNfvpwML3HINpYSVsNYTYPuGtMUmWaGekjFe0BBKxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v58LONz47/8t055Dsta0ahHHJzJIxszIaObTu53fuU=;
 b=x3z6eigjGouEHTT2lWqWG5OBWsuQ4D/mRADH5XvIkYWuJkCf5A2p0zVg/leRzrxGPbBO5PA77MtLKz+Z9ou4fMuOVqZ4mVZBctjoiIRDUacvU7ckqoW0IsSDKjCZ1afCmbZIpHX8haTZrUeyxrezoAlogIb1Y0pRJQAXmHmHNZG+b9rsD7nbsp7+TKBbJLWGZyPMBe2xSx3UD8CBFz+Nr4027zFPtIjxjRJKoLxLlAz2R1My/qWfz/Y9bI1JDvreE7cFXU/3MKxtYBdp3xEKAgM2KFWU8nqYGvxJLi9xsJe05F/EaDCJZJUKDkVAZXhd8Bf8yjOyYUpyeiAaBwzPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v58LONz47/8t055Dsta0ahHHJzJIxszIaObTu53fuU=;
 b=hKLl3OuNl3QcsZdmmSxvJJ1JN689R6uzy3wtvu31/caFEkaSScjj7BdnHHp1c3/fUjoEYA0ClSl12QVk2ruzMSZ2vRQ6/c8+AKwZ1JFfS9YKlWpYSm3UJhTODhEHyUMiMODeHcQBo7h/Ml/Al69HbtH49DX4tUc7t6Xg0dn0s0Y=
Received: from MW4PR04CA0077.namprd04.prod.outlook.com (2603:10b6:303:6b::22)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:46:43 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::7c) by MW4PR04CA0077.outlook.office365.com
 (2603:10b6:303:6b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 05:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 18 Jun 2026 05:46:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 18 Jun 2026 00:46:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Date: Thu, 18 Jun 2026 11:16:18 +0530
Message-ID: <20260618054618.2956952-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618054618.2956952-1-srinivasan.shanmugam@amd.com>
References: <20260618054618.2956952-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 4340ea65-3c63-4a2f-39a7-08deccfcfa35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PxgiLv1X46LC3vFtshUq9PWa4pTpINsHZz8PFf4x4+QVQLfrdP0SC9DKhOdVpACPPcehidu+EX5htUO12F1uSmnW6RBI/41df96bRJBez31lQBZbKCypcFVe6BsAKLWrW9f2a2Zk/Ezu33UgGlBJByTmPeckw91RkNPqCcn9qOYVDbHvY1PBHtitb8Cbdh5Eqi6vcPjtYGuQSFy6v77onsRPpdShYlfAX1l54bQM79oo1o7PFxccvWq1roD9rnFMtLqG6iSAopESHUJlcXfnxLiXtkMIiMIkZgMvDiVBLMfNfzKVgRBLknoNXw2H7wjGIjA3IDqp71nTOvM6WzDOStLi9W8BsbtVvGKywXmCzk6bsaQeGfBMg4eVYRyZnaC38/oTSWFAmwceIhwz+IG0N188pQCseafQKgLPyy+s1kAkck65/LAj8MkWm86V3iXsL/ixVNpCTcHx/rwusRBUoHp8xYy5Jm2o3RcSEQv2HT23jrU1ObfWN/eFo4aRyDbQBnSnPt6M6qSTiClTbJMnVfjCFcbArz1vSZPXalPBhDrTAhzRzjFIsldvdVSdVZnmPt5Hv9OODSwNKFLUun1xkodUfzYGjC5jJugVbFH1lmVaQiA8vco645olzLJkAbPruVjV42JjApnZYJm5tWXU6bh9NzP8UWY4a/ceFhx6yahyY6kLizE4VT9JrjubHejhOFy/3D4H/XpWP/4qy0IqbUUxEqfO+RFDwpyrUomqOz8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bgXmG1NAChSJkLKDc3njw92JhvzUm5LOhd+3mqhfDJULl5kAGWWjdcjJGtS7UXwQBzkSkT+rkc6kYEFafgj8ZQEAbrqJc4/n/QRT22VhJ3T1KVnRO+qipcKZ10OiGQ+oLGncDAr+ZqgGO44OijdQw4LarxPEkYngWH4ZPmS72EMSE+O18WCCvwsLYgtV2H0nQCCSuHlGh4BGHGcn8RKSA93E2I8u7QLqLE8LLzYDIn+0sJMaHeFswn5KyLOzQ8eoNpnOwt7p2MjNEwDjgorotTX6DRLQAyJ056ckFHGehsn19kJjbmCvrkXRxOdHGzz57Kfxfc1j2kV25P1CfnPZOI6TD2lYaZPykvSlLen6r6Zsam6cOuLVl1K1uSmfHvwgriig+D4jdX6sjaJlHZ0AXtmGOMwQTfogpXWJItQokN5DtH+pZ3W3DlVdYkxPPix3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:46:43.3459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4340ea65-3c63-4a2f-39a7-08deccfcfa35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e46cdd6ecd42..cb793277ae48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5635,15 +5635,43 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
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
@@ -5675,10 +5703,30 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
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
@@ -5775,7 +5823,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 	}
 }
 
-
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
-- 
2.34.1

