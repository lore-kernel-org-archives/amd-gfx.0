Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B93C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B775210EA2F;
	Mon, 13 Jul 2026 16:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuUWqa1b";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA4E10E981
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOXH2P/3nn44rswpQuqzxJtCLQlMiYr7GlTaLjRSV9lMLeEBFIv78Am+vmvV7nJP8fI047V7yBYABjaWCth1O/7+D0a0qPeb+oL4okjM7Hitepxe9fraE5OPPd/JLSiKISBrlkQu5qKf8ia8nPWT+nM0IZpybKIZLUlTb3LQs6lskEn97lQXQDNqaBReJJCIj5zVjKHKAOUGz7dAGKY8OxUJ6YYpFKUN6wPrl8GRRWWC4sJSxfasZKVOClqSDCDHf+LPBnS+4bvF/HBbu4GCFHDFj8UIGSyL3osRY4YCDETCzLFb/iASnDkQ62GVrEUvFsqp6mDJpaTs77XB2noGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Cs6PpebSZESXVIcDXH+eCXOrE2w4Jp4gbTJcy25Fc=;
 b=n1GQjVn54fUrStPZWmnHLQUifVckQAkqU4rxy8yn3ovtnr6MiZ6hAJn+OpseoR7YGwQgk+zrB6IpzLNGFpD+usOD9I9c0HjezBa4XpM36d2awUztpxrmMeAY2gtFZZBF5ipXw3PAaI0m/urY48/awF+ZGnnH2+EvkhNtIYD17fUXZR+10nzGNu7nZvRRmTljNRBcTac5kcsY26ngP5cKdnWlmFdkrTEcwwh9yUDD8ruJeVk7NPUKcZ/xDzarsIxi6JPKSYkvzGbTbr/opGlcOfsLIzqnlq/LMW7wIctTi+SFrOb0WY3Q7KZRLEFwWDhvf6RIFY4s8GPf0m7aCwfL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Cs6PpebSZESXVIcDXH+eCXOrE2w4Jp4gbTJcy25Fc=;
 b=ZuUWqa1bIh4p450apCjMtLy3S7JeJjPDejBCPQ8GNCp6OOq8+YLZDLeYF0fhE6eghhF8mgsDdzYHAKLYg8q4Ew/3Nob5/pdbjTCEHrVaEtA63MjrmvTh5tygID3cszDLnFUI+qZe3AqFvgHzE4siHuWNz9yi4KbrqmCZRDFejzk=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 16:27:54 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::89) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 16:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:27:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:27:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Date: Mon, 13 Jul 2026 21:57:22 +0530
Message-ID: <20260713162722.3349626-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
References: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: ce42ddc5-80c2-4b55-b056-08dee0fbaf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CvlvmMiCUC1ZgqAPVcn855Aa4n9LHKbRaksROJQG7d44rskpO3Ra0NA71UKJvNcTIKxnQsTjBTyokDtA6/3ufTkZBd6/IaK9Hdhmqy+WmYEpWmr6g+weStiJxPI+wKHFY2b4UhVpkKLZDbHDRFSdbbGaB6k3NL5Wz6sW6FvaCJg2UynA7Ht69H/Ztfkv6dm+YUSJtNN/WE82RCIHQSPb05gVWq6152E0wdnfpYqG6fjhFUf50jpY/ssYm5UHuHGabvLZHCMzlpxjKoOm2PCa9EmMTydmnENrwkTzYuB08Mt/9u6MiZLQ+/0y7dS7M4FN1CVRfzxQiWxWrQWNKkQGDs1eW9USA6uKyjv6Cbfjel5m3wfdzHdiucrbTLK9CbAZwKSF19La3zaOk5LJCbHZcpcPeWpRCQimqjodzRn5uBZ+L5vm08TAfLd2wa4TEjp1yK8S7tITuGzt6jIL6ot8xzm94SUrwQJNH6Nat1/Zeh/KAe3woaGWGih0iRlv1RqYUQwL9kNagRcs6ASro/HQ/+0HjxWJOF5BiMcNWoUA4ssgSrLMmQruqM68xXhdtQrdSmDBw4NMbUn+eQ6Y0qTSO41Lv3Q1GwDrKhaVsJkZx5ecw8xiEnKAFweUaWMKOdP6Tg/gvVZxx0zvgSZS8/ULFl1ORE3UPtYufO57+DuakWTzsAqUioBkgO/DOq83esy8W3l46Rr0+WUZbLcKsS8cWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3JRTlW28Ze2W3LIR/k6tnyRZai3GGWM9tK+qCJbw/4foVE3pXHJuGxtINxtzHpj+8cotbdbd8k9p5QxBzwjRZBLNE6gDQUKOIIH1O702lGu1ylFnHp3+sxqOqSBBwTMwHtmlB2n8pJLPcDzKtDXRPJ0ZyB+GJ7TyBWQJG+FQS5o5OdghW376/K8s7KUxXTpJcGVboriH3OSmMtP1NZOhdLqfN7KE5tDBnbfz28MkYvcQAVbAtwafyajORKXWCWbvXMUmKm2vYQC/UjsCOpmg3XjFXCpjoAdEjLqwdMzRdMemMaKHWut9XYjhdNxu6hkYVTmih39LfKup3jBmiFD0KDl6Kw9wWrClj6lQ7lEVk1JLOr+S9UOzA8cJiDhqlvZIVw9wczhIK+EUDLRz7L+WGPyyMpem5HwoKOxCxOGajzlBGtHhuckENl5TpY3FSqxo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:27:51.5820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce42ddc5-80c2-4b55-b056-08dee0fbaf62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

