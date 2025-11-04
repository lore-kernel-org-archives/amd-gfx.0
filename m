Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013E6CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D5310E029;
	Tue,  4 Nov 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3HA8gmXt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8278310E029
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj1Uoa9yXtre1jYv2MBdH6b14SYwf+mhkS3xq4CHRJVmLggNNBbn9cs8GFO0rBbKqag3UqYf5aJjNU0KD3xY42nmYTYqpOWuxMvoHxcHQe+QYniIf9EMNxy30M/X37WrgImFmqtCZ161YI0zsWHa8bM4VHWBxo7/BaK/PRGIj+62v8yKIwy5R0vKS9N+kECX7756vdWOS/JZD53BlRzw/FgxFy8kYMcwHsUUJEoPL6BueROWgx2brbHDcu/9TVHuRvQmUVjJ0I+VExJsPuzMGrlNacTvV39WSKHcsZ2e57Oa4L32JUDEeoMklekkvrQ5n7svPeemEyFrK9DHzpRVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4xwnjsqUq/y4e5s/uSHv1fOm7H3D5T8+/eP83eGPzA=;
 b=FsKS5c+EvrBH2Mo+uYKeX4nF8rO+HmDzJ/2bNo6eKbdv/5UMaxM1TddgUeIW/rrcOCt1yPR05+HxkYe4JZ7+qB2+ZwIzTuhBYkWxOR3T1dgStTqs7sHy/Kcc/HGjnN9K8PPJj1/AOJf+gs5VtAY1ltY73VDzh3ew6YJatERl60UfYGuCyurelqy7Ece6cS//zoJmuO6MM9wNzVb4jbsWOU0GfP/0wISoZkvUA/p/Rl6ZCD7dNPj3DuliPGt3ECpbxBIT/OYv32REfDnGGY1yoyR0/wZM44SlaWsBZkk5Q3hQ5/bPe0TdNcvwtbY8AcneChnPLSJN9nksCOgFCm1xSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4xwnjsqUq/y4e5s/uSHv1fOm7H3D5T8+/eP83eGPzA=;
 b=3HA8gmXtoLB0TOWjcDnHHcaSzsqMcSndv2Dj26n+kXNYDjAnoZ4wzEGC19/GzU16Q/lSjW+0FFynK5EWEwwNYvrkwvqRlXKawfY57AofhfK6HHkSF7FsN4PPpVDA5pssWcmOxeDgYVNZ7tS9SMLazObblYCvxExyRjDyHtV7HFk=
Received: from SJ0PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:33f::24)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:03:06 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::33) by SJ0PR05CA0049.outlook.office365.com
 (2603:10b6:a03:33f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:03:05 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:03:03 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5] drm/amdgpu: suspend ras module before gpu reset
Date: Tue, 4 Nov 2025 16:02:12 +0800
Message-ID: <20251104080212.3641072-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed7d2a1-d8d1-4293-296f-08de1b7895f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n6kkA/YQ4h9bujeZovOjfx2por/icgM3f0pUNU3IwY1PYD+YUBh8UV1HmOVJ?=
 =?us-ascii?Q?Ksf7OM9YutrmnJSzXEwSyNMzzLiJTN++0uNQkGT9K7KbeWv0/TimzUb4/mqJ?=
 =?us-ascii?Q?72/2aYUQpZg5upvRuDIYg0LNvKehv2ksAjRJLCNd9wG1VNwo7QNLLWnf2skG?=
 =?us-ascii?Q?L5IsFXwpYAyfJX6pw0v2mF+5ySEpXdA4CkOo8X1gQDUrSy1AvNR11kwwWrJW?=
 =?us-ascii?Q?yZYu5sTR7flDtEfv6a1ue6DysTuA1EFuYPFvSflqEMLwc21+w2F3Xl+oIF7H?=
 =?us-ascii?Q?ePGSpvcdUsZlnDMe2lUCJ5igbGe1k7B0Gasul3iJWhD3/aAB7DvTf1W1hcF8?=
 =?us-ascii?Q?1096vtiWNo9Cue6x5QxfCcOyz1+WmHok8sZciXd50f1otICes4c1IX0IqHqv?=
 =?us-ascii?Q?vmPUOxmafWhgovKCrkql9tP7VBtKxxjA0Cf8uFPXpivmgyW+hinayNZ8y1/A?=
 =?us-ascii?Q?n4tJ0LcJfLsDAdcSNYJjswAhTBpCDbv884dpgs6Rp3+h5DDli15kIUdUL8K1?=
 =?us-ascii?Q?qm9goUOFcr68PYNEx+TF8JNKVDZgPSgHwNbElz0kR29IjtpgT5cVVCJGks7a?=
 =?us-ascii?Q?PmUXS4KKAugty4chvFkCPxiyZeOiQm2rmY96G3mhvVXKfPYGMq/Px4a6xL1Y?=
 =?us-ascii?Q?5dkhnxd7VkdKWUqMOkFRBRxdfr4u1rXv99TByT8r8klId/Akx6GlqZBfWJQp?=
 =?us-ascii?Q?OEFkejaLp2WVJ/2B7DHRp+2yvah98s19lb3ETDnDIW1E1jhbVFluC5+U3vAB?=
 =?us-ascii?Q?OrJb/eZLx0rZ78CNRQ2CXbXmQWCgYPlo7hD9/BUiHlq3OlE1sIiqNloOGmAi?=
 =?us-ascii?Q?lsU4ydWjJRwQlPwdm2Y+XP/+b+JRGAJ3aplRKgrR3ipZ3bww8bF7OEyvNHMc?=
 =?us-ascii?Q?BGPMUb/v5zNCagO6vcleHjXE/SIrR8+9bljBdfW/CxkYSjah/3WMHus6OKbB?=
 =?us-ascii?Q?2+FoXyYYUCCzn0ajWjEfhmav3PVK+yx59JFfYDFVeyLEYKbD7H3IVjAeFRPR?=
 =?us-ascii?Q?+wKK59OETi4E2Xv1S2vrGyrXJhBG6jWFvHjTAuLSGQzsOWzzjj6CN/AJEFgR?=
 =?us-ascii?Q?QSKmbUzCxzLzo0A8w1272gSpm5wODUR+IAHYa0SWNcsEEzdThxb17C3p+ydS?=
 =?us-ascii?Q?Hp77YYHzzgyI6bhG9TRZ4UF6h0F+f/On0EtKi2XSDRmZqpDCRYzPeT7inC0l?=
 =?us-ascii?Q?WffoxJJxm25RvDAEo6nzKv/nINOK7lSj/CaqMHrGmaLqMvxxy9NoApXnMadY?=
 =?us-ascii?Q?SaRlZhuauE8j/E4dt+T9p2RHVYILyirZnPFl0yH9TIharc6yRSApt9e3MijI?=
 =?us-ascii?Q?9IF+LvKkrBoVBcsq6tyslpJOV5mrLr8PZj02lguCU3X3k2BqecK5I2cC8FYB?=
 =?us-ascii?Q?dQ/BYDg8iVHsJm9B3nw+39TV/MNdDHgIOhqct7myvbi6oT14I8Zzr7N7GwGS?=
 =?us-ascii?Q?X/JYcUFDUe72vG8w5bj2/wHQu7hgAo4ueX5c3nxZEk9PdM7B3O60JWEy6+gy?=
 =?us-ascii?Q?J3c0mc3qblPjldNeDyqvpHIRxiYGIvdzhB5GFGr/RVPoSH/s0mC/B9hF4IrL?=
 =?us-ascii?Q?2+1lY1sQsdGC0G7lfes=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:03:05.7550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed7d2a1-d8d1-4293-296f-08de1b7895f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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

During gpu reset, all GPU-related resources are
inaccessible. To avoid affecting ras functionality,
suspend ras module before gpu reset and resume
it after gpu reset is complete.

V2:
  Rename functions to avoid misunderstanding.

V3:
  Move flush_delayed_work to amdgpu_ras_process_pause,
  Move schedule_delayed_work to amdgpu_ras_process_unpause.

V4:
  Rename functions.

V5:
  Move the function to amdgpu_ras.c.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 30 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 ++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22 +++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  5 ++
 .../drm/amd/ras/ras_mgr/amdgpu_ras_process.c  | 64 +++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_ras_process.h  |  4 ++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  6 ++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 +
 drivers/gpu/drm/amd/ras/rascore/ras_process.c |  7 ++
 10 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc6e59208cac..04e6a0c85065 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -71,6 +71,7 @@
 
 #include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ras_mgr.h"
 #include "amdgpu_pmu.h"
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
@@ -6660,6 +6661,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			goto end_reset;
 	}
 
+	/* Cannot be called after locking reset domain */
+	amdgpu_ras_pre_reset(adev, &device_list);
+
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
@@ -6691,6 +6695,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 end_reset:
+	amdgpu_ras_post_reset(adev, &device_list);
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
 		amdgpu_put_xgmi_hive(hive);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5377cde0c55d..75d61a7653c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2921,8 +2921,12 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		type = amdgpu_ras_get_fatal_error_event(adev);
 		list_for_each_entry(remote_adev,
 				device_list_handle, gmc.xgmi.head) {
-			amdgpu_ras_query_err_status(remote_adev);
-			amdgpu_ras_log_on_err_counter(remote_adev, type);
+			if (amdgpu_uniras_enabled(remote_adev)) {
+				amdgpu_ras_mgr_update_ras_ecc(remote_adev);
+			} else {
+				amdgpu_ras_query_err_status(remote_adev);
+				amdgpu_ras_log_on_err_counter(remote_adev, type);
+			}
 		}
 
 	}
@@ -5672,3 +5676,25 @@ bool amdgpu_ras_check_critical_address(struct amdgpu_device *adev, uint64_t addr
 
 	return ret;
 }
+
+void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
+					  struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		if (amdgpu_uniras_enabled(tmp_adev))
+			amdgpu_ras_mgr_pre_reset(tmp_adev);
+	}
+}
+
+void amdgpu_ras_post_reset(struct amdgpu_device *adev,
+					  struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		if (amdgpu_uniras_enabled(tmp_adev))
+			amdgpu_ras_mgr_post_reset(tmp_adev);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 40c0bf85f1d3..0bcf73f8c840 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -1012,4 +1012,9 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 				const char *fmt, ...);
 
 bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
+
+void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
+					  struct list_head *device_list);
+void amdgpu_ras_post_reset(struct amdgpu_device *adev,
+					  struct list_head *device_list);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index adb01bdee003..afe8135b6258 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -624,3 +624,25 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_mgr_is_ready(adev)) {
+		RAS_DEV_ERR(adev, "Invalid ras suspend!\n");
+		return -EPERM;
+	}
+
+	amdgpu_ras_process_pre_reset(adev);
+	return 0;
+}
+
+int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_mgr_is_ready(adev)) {
+		RAS_DEV_ERR(adev, "Invalid ras resume!\n");
+		return -EPERM;
+	}
+
+	amdgpu_ras_process_post_reset(adev);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 42f190a8feb9..8fb7eb4b8f13 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -52,6 +52,9 @@ struct amdgpu_ras_mgr {
 	struct ras_event_manager ras_event_mgr;
 	uint64_t last_poison_consumption_seqno;
 	bool ras_is_ready;
+
+	bool is_paused;
+	struct completion ras_event_done;
 };
 
 extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
@@ -75,4 +78,6 @@ bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 		uint32_t cmd_id, void *input, uint32_t input_size,
 		void *output, uint32_t out_size);
+int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
index 6727fc9a2b9b..5782c007de71 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -29,6 +29,7 @@
 #include "amdgpu_ras_process.h"
 
 #define RAS_MGR_RETIRE_PAGE_INTERVAL  100
+#define RAS_EVENT_PROCESS_TIMEOUT  1200
 
 static void ras_process_retire_page_dwork(struct work_struct *work)
 {
@@ -57,6 +58,9 @@ int amdgpu_ras_process_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 
+	ras_mgr->is_paused = false;
+	init_completion(&ras_mgr->ras_event_done);
+
 	INIT_DELAYED_WORK(&ras_mgr->retire_page_dwork, ras_process_retire_page_dwork);
 
 	return 0;
@@ -66,6 +70,7 @@ int amdgpu_ras_process_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 
+	ras_mgr->is_paused = false;
 	/* Save all cached bad pages to eeprom */
 	flush_delayed_work(&ras_mgr->retire_page_dwork);
 	cancel_delayed_work_sync(&ras_mgr->retire_page_dwork);
@@ -124,3 +129,62 @@ int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
 
 	return ras_process_add_interrupt_req(ras_mgr->ras_core, &req, false);
 }
+
+int amdgpu_ras_process_begin(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (ras_mgr->is_paused)
+		return -EAGAIN;
+
+	reinit_completion(&ras_mgr->ras_event_done);
+	return 0;
+}
+
+int amdgpu_ras_process_end(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	complete(&ras_mgr->ras_event_done);
+	return 0;
+}
+
+int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	long rc;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
+
+	if (!ras_mgr->ras_core->is_initialized)
+		return -EPERM;
+
+	ras_mgr->is_paused = true;
+
+	/* Wait for RAS event processing to complete */
+	rc = wait_for_completion_interruptible_timeout(&ras_mgr->ras_event_done,
+			msecs_to_jiffies(RAS_EVENT_PROCESS_TIMEOUT));
+	if (rc <= 0)
+		RAS_DEV_WARN(adev, "Waiting for ras process to complete %s\n",
+			 rc ? "interrupted" : "timeout");
+
+	flush_delayed_work(&ras_mgr->retire_page_dwork);
+	return 0;
+}
+
+int amdgpu_ras_process_post_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
+
+	if (!ras_mgr->ras_core->is_initialized)
+		return -EPERM;
+
+	ras_mgr->is_paused = false;
+
+	schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
index b9502bd21beb..d55cdaeac441 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
@@ -34,4 +34,8 @@ int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *adev,
 		void *data);
 int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
 		void *data);
+int amdgpu_ras_process_begin(struct amdgpu_device *adev);
+int amdgpu_ras_process_end(struct amdgpu_device *adev);
+int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev);
+int amdgpu_ras_process_post_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index f21cd55a25be..45ed8c3b5563 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -142,6 +142,12 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 	case RAS_EVENT_ID__RESET_GPU:
 		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
 		break;
+	case RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN:
+		ret = amdgpu_ras_process_begin(ras_core->dev);
+		break;
+	case RAS_EVENT_ID__RAS_EVENT_PROC_END:
+		ret = amdgpu_ras_process_end(ras_core->dev);
+		break;
 	default:
 		RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
 		break;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index fa224b36e3f2..3396b2e0949d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -115,6 +115,8 @@ enum ras_notify_event {
 	RAS_EVENT_ID__FATAL_ERROR_DETECTED,
 	RAS_EVENT_ID__RESET_GPU,
 	RAS_EVENT_ID__RESET_VF,
+	RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN,
+	RAS_EVENT_ID__RAS_EVENT_PROC_END,
 };
 
 enum ras_gpu_status {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 02f0657f78a3..3267dcdb169c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -162,6 +162,11 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
 	uint32_t umc_event_count;
 	int ret;
 
+	ret = ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN, NULL);
+	if (ret)
+		return ret;
+
 	ras_aca_clear_fatal_flag(ras_core);
 	ras_umc_log_pending_bad_bank(ras_core);
 
@@ -185,6 +190,8 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
 		atomic_set(&ras_proc->umc_interrupt_count, 0);
 	}
 
+	ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__RAS_EVENT_PROC_END, NULL);
 	return ret;
 }
 
-- 
2.34.1

