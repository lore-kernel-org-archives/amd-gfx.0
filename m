Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFB3CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902C310E60D;
	Thu, 18 Sep 2025 01:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TzBuq5qA";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B8610E61A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw9mp6plqCilramWRN85DJlQymLVbT4hMk76reVLkD4HQexmyyNT4Tw4pqgw7Vguwg2r2UyMD0VM4+cRzilzrNWsQCCUSpDF0k0nElUQE8rbuKAoeHtE5fDoZsrmyAYnUmkYUo+Je8TBfdsrimWAtHftIAlLIEizaf93b3g/hAEECRRZWUXCmXnjfKNe/jMQg5XRERtGYzKOXj+Bd62/PAJhB+uQ5YeH83eux79bFwL34Cl5PhvAJfabV8hl4SeMZYWqg18XXwED6MlozEqIwKOwqNTELN/BZs4IBMFHrHpD6P4XJtnZAvvUhBYRWuVctPLlJmF65DyK11tx91gnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/2JUUR5LVvlttC4U7dVVF1/rqUFhiUipGSVOCVbCSo=;
 b=xObaZCc9VRNBsysfGHkmbFSmMONwYPRWFfErpABdviB+FMX+vVDuYQRp6VC1kehXBvCqXJNxQXgOiQHwPgN/1XggkJBZOn/aDk+jOb3OeUyW6W0MiigpGUFh/p847dvRWFtNZUA5v5s9me83eqsUqu2weF6e05Xs+wN4Il13qjzcwD+w80F6m2SLcdlQZ2tFb8lrhhfxzSk7jC/9x755zHpbIRFt62UQ0wtnHuSW7f5IoKyQpBFRBLW4Xy5oGcbkhW7Zix2PUYzhWfpF+fdXBfhTnk/WbV+d3kxXtmcZIOrlmkABD+oEB3XsPFVb3kd6v4WmZCyeFyrOZev4UljEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/2JUUR5LVvlttC4U7dVVF1/rqUFhiUipGSVOCVbCSo=;
 b=TzBuq5qA6VLfDRwIy9Im1PyDqZZZsHbnb0Xby8JTdbWjo9dVzg2x2uxWlUIQne6Q+mByxLpga4ObjZyDJrw37/6ukMVsICQTvH6jRomOVGmtjdPR8tSL59mz0VuzDMXJc0qgYjQuvdMSH6C9TNkV79tuQsXDFPzTT8Ku/kDhcaQ=
Received: from SN6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:805:66::23)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:36:54 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::3b) by SN6PR08CA0010.outlook.office365.com
 (2603:10b6:805:66::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Thu,
 18 Sep 2025 01:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:54 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:52 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
Date: Thu, 18 Sep 2025 09:35:03 +0800
Message-ID: <20250918013507.2629620-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: f63b2ecf-2179-43f4-8e22-08ddf653d94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vNSEnc8j650ao2XORsonI0xvxZubUiYuBh/OWmhBoFwJW6dBcV4c4dfNawAi?=
 =?us-ascii?Q?8sl59xF0nRSOgG4ZneYcVQyqs+RRCXrBDqDBwXlgfKBzFelqxOVt9LJngdV6?=
 =?us-ascii?Q?V/6tZmuVM4aUO60i+QXkpUrb7y7Cq3LWzdKfn0CiLbr5Su+VxURCq/tcVIt+?=
 =?us-ascii?Q?k7+BdG1MtLgDY2rEEFxZ62V7lTAq+li2QEaF6ix78BTY4W88moUJEigUPamv?=
 =?us-ascii?Q?sQAgqmP+4II7gbIKRyrwrQBQbWB3expivxGZZMQh+GMutjQWYq3LTLG0fL6H?=
 =?us-ascii?Q?nIpMPK4vaaj5bRNUmyusjPcGauOq4zlcisPc7sD2NdbOmKD9+IC6Rr2HaiSd?=
 =?us-ascii?Q?r/TIc7jRx1bm214x+Rh0PUw2Wdemdy2oSZOudWeLasRBq+yQIpS151ql1FQS?=
 =?us-ascii?Q?iBDBStROSoDJckiBfhD9PndObD0YX0tnWZaHEgbKW4Af6uJmWs2VqlklGor4?=
 =?us-ascii?Q?cNpYgbtZ6ZVWPdnD7sZyX2pSVNf+bM2H1hvCsMoU0Q3Yr4dm50/A8hFWMBtY?=
 =?us-ascii?Q?Pbwo1lmPyjIOHeQwS0XcEte8n+5c97Auv94R7Y4bDPM/9mBYxCNUK/dOgYys?=
 =?us-ascii?Q?Hu65+7S8uM4DcU+9wqc7YAKinQXrsY/1yCGMRNo5yDJhIvsUO2KSZz2/KF6t?=
 =?us-ascii?Q?yU1Qi9A++0Y7veXJaPRz8uHDib0neocEZV0DWV/eesDwfZkZlba0VPm1MDva?=
 =?us-ascii?Q?CufItI77jvdToWQd/JeKGpAeIAYhwAaUtTrKqHQEijJ/CS+gX9PYb/87sx/l?=
 =?us-ascii?Q?ucqZuSS9mYnOKBDDFlqx5zfX71g2taXJ44GotIbKXuOVngTKsEhemAVp2INQ?=
 =?us-ascii?Q?Hq54d9jVmSeuy/kB6kpXv+TDRUjS3ibbW4QfrVyLq1jH7NCwfuSV5nq4q2/I?=
 =?us-ascii?Q?kDKAiG2o8AgKpnlr9lpV+HFD61lFnJI9vLy8/z99xles2b3Hb9glIv7o4XXx?=
 =?us-ascii?Q?LmKmqGmAzo/O2QYwBO9wwn1Lo6QK1krEwOfjvZ3UbCT7TrJXtemqef0VcLkC?=
 =?us-ascii?Q?5pX6aS3ruDaxl11ivy/mqqSJBguP9a84tjuMDUiXS49Pom6ZQ7nfI0wk9eij?=
 =?us-ascii?Q?7VRxfuSP1YMFDLSxDwxteK8pGQdhqgKeATjitjlkEnN/DVBF5kTgJ46J5AnD?=
 =?us-ascii?Q?xMBuVbyBXc41+M8qSnUtMng6RnzYvFXPXe8cWX+U+CI/I7g60STRZWK0XxZ0?=
 =?us-ascii?Q?IVrLTkir51/dtxjwP4N/hI/y6WdgWRy9zkfyn5BmYwGjK3pDyfz44qVbWHfs?=
 =?us-ascii?Q?h6AEuxYdLt59+Dve13vqwW07Nuroplq6Cbi5BP7P173wYFPxxyViRZxd/AQs?=
 =?us-ascii?Q?8DBXhoN6T/winKcOuOQEuD6Ua7pGqENvQVK6qDafq/jezhGHHGth36GuEMZW?=
 =?us-ascii?Q?OcWS9hmk1lx3I3NRfQjaBQoqSThMPR8zJ1B6QtPjdlVmP3REo6MptiI9ubMT?=
 =?us-ascii?Q?utcnEH6Ubo1VhTEYOcDHLC/UaHef7XlvteNTeeNGk2km6CtGUFCZQIY4FwEl?=
 =?us-ascii?Q?SKhh3unhD/xSO/wWoDy7Z4TV9TebPjJEc7jn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:54.4115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b2ecf-2179-43f4-8e22-08ddf653d94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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

Add amdgpu ras system functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 268 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     | 109 +++++++
 2 files changed, 377 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
new file mode 100644
index 000000000000..40071b876333
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "ras_sys.h"
+#include "amdgpu_ras_mgr.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
+
+static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context *ras_core, void *data)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	uint64_t seq_no;
+
+	seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_UE);
+	RAS_DEV_INFO(adev,
+		"{%llu} Uncorrectable hardware error(ERREVENT_ATHUB_INTERRUPT) detected!\n",
+		seq_no);
+
+	return amdgpu_ras_process_handle_unexpected_interrupt(adev, data);
+}
+
+static int amdgpu_ras_sys_poison_consumption_event(struct ras_core_context *ras_core,
+				void *data)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_event_req *req = (struct ras_event_req *)data;
+	pasid_notify pasid_fn;
+
+	if (!req)
+		return -EINVAL;
+
+	if (req->pasid_fn) {
+		pasid_fn = (pasid_notify)req->pasid_fn;
+		pasid_fn(adev, req->pasid, req->data);
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_sys_gen_seqno(struct ras_core_context *ras_core,
+			enum ras_seqno_type seqno_type, uint64_t *seqno)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_event_manager *event_mgr;
+	struct ras_event_state *event_state;
+	struct amdgpu_hive_info *hive;
+	enum ras_event_type event_type;
+	uint64_t seq_no;
+
+	if (!ras_mgr || !seqno ||
+		(seqno_type >= RAS_SEQNO_TYPE_COUNT_MAX))
+		return -EINVAL;
+
+	switch (seqno_type) {
+	case RAS_SEQNO_TYPE_UE:
+		event_type = RAS_EVENT_TYPE_FATAL;
+		break;
+	case RAS_SEQNO_TYPE_CE:
+	case RAS_SEQNO_TYPE_DE:
+		event_type = RAS_EVENT_TYPE_POISON_CREATION;
+		break;
+	case RAS_SEQNO_TYPE_POISON_CONSUMPTION:
+		event_type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
+		break;
+	default:
+		event_type = RAS_EVENT_TYPE_INVALID;
+		break;
+	}
+
+	hive = amdgpu_get_xgmi_hive(adev);
+	event_mgr = hive ? &hive->event_mgr : &ras_mgr->ras_event_mgr;
+	event_state = &event_mgr->event_state[event_type];
+	if ((event_type == RAS_EVENT_TYPE_FATAL) && amdgpu_ras_in_recovery(adev)) {
+		seq_no = event_state->last_seqno;
+	} else {
+		seq_no = atomic64_inc_return(&event_mgr->seqno);
+		event_state->last_seqno = seq_no;
+		atomic64_inc(&event_state->count);
+	}
+	amdgpu_put_xgmi_hive(hive);
+
+	*seqno = seq_no;
+	return 0;
+
+}
+
+static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
+				   enum ras_notify_event event_id, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(ras_core->dev);
+	int ret = 0;
+
+	switch (event_id) {
+	case RAS_EVENT_ID__BAD_PAGE_DETECTED:
+		schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
+		break;
+	case RAS_EVENT_ID__POISON_CONSUMPTION:
+		amdgpu_ras_sys_poison_consumption_event(ras_core, data);
+		break;
+	case RAS_EVENT_ID__RESERVE_BAD_PAGE:
+		ret = amdgpu_ras_reserve_page(ras_core->dev, *(uint64_t *)data);
+		break;
+	case RAS_EVENT_ID__FATAL_ERROR_DETECTED:
+		ret = amdgpu_ras_sys_detect_fatal_event(ras_core, data);
+		break;
+	case RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM:
+		ret = amdgpu_dpm_send_hbm_bad_pages_num(ras_core->dev, *(uint32_t *)data);
+		break;
+	case RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP:
+		ret = amdgpu_dpm_send_hbm_bad_channel_flag(ras_core->dev, *(uint32_t *)data);
+		break;
+	case RAS_EVENT_ID__DEVICE_RMA:
+		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, NULL);
+		ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
+		break;
+	case RAS_EVENT_ID__RESET_GPU:
+		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
+		break;
+	default:
+		RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
+		break;
+	}
+
+	return ret;
+}
+
+static u64 amdgpu_ras_sys_get_utc_second_timestamp(struct ras_core_context *ras_core)
+{
+	return ktime_get_real_seconds();
+}
+
+static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ras_core,
+				uint32_t *status)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	uint32_t gpu_status = 0;
+
+	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
+		gpu_status |= RAS_GPU_STATUS__IN_RESET;
+
+	if (amdgpu_sriov_vf(adev))
+		gpu_status |= RAS_GPU_STATUS__IS_VF;
+
+	*status = gpu_status;
+
+	return 0;
+}
+
+static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context *ras_core,
+			struct device_system_info *dev_info)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+
+	dev_info->device_id = adev->pdev->device;
+	dev_info->vendor_id = adev->pdev->vendor;
+	dev_info->socket_id = adev->smuio.funcs->get_socket_id(adev);
+
+	return 0;
+}
+
+static int amdgpu_ras_sys_gpu_reset_lock(struct ras_core_context *ras_core,
+			bool down, bool try)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret = 0;
+
+	if (down && try)
+		ret = down_read_trylock(&adev->reset_domain->sem);
+	else if (down)
+		down_read(&adev->reset_domain->sem);
+	else
+		up_read(&adev->reset_domain->sem);
+
+	return ret;
+}
+
+static bool amdgpu_ras_sys_detect_ras_interrupt(struct ras_core_context *ras_core)
+{
+	return !!atomic_read(&amdgpu_ras_in_intr);
+}
+
+static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
+	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct psp_context *psp = &adev->psp;
+	struct psp_ring *psp_ring;
+	struct ta_mem_context *mem_ctx;
+
+	if (mem_type == GPU_MEM_TYPE_RAS_PSP_RING) {
+		psp_ring = &psp->km_ring;
+		gpu_mem->mem_bo = adev->firmware.rbuf;
+		gpu_mem->mem_size = psp_ring->ring_size;
+		gpu_mem->mem_mc_addr = psp_ring->ring_mem_mc_addr;
+		gpu_mem->mem_cpu_addr = psp_ring->ring_mem;
+	} else if (mem_type == GPU_MEM_TYPE_RAS_PSP_CMD) {
+		gpu_mem->mem_bo = psp->cmd_buf_bo;
+		gpu_mem->mem_size = PSP_CMD_BUFFER_SIZE;
+		gpu_mem->mem_mc_addr = psp->cmd_buf_mc_addr;
+		gpu_mem->mem_cpu_addr = psp->cmd_buf_mem;
+	} else if (mem_type == GPU_MEM_TYPE_RAS_PSP_FENCE) {
+		gpu_mem->mem_bo = psp->fence_buf_bo;
+		gpu_mem->mem_size = PSP_FENCE_BUFFER_SIZE;
+		gpu_mem->mem_mc_addr = psp->fence_buf_mc_addr;
+		gpu_mem->mem_cpu_addr = psp->fence_buf;
+	} else if (mem_type == GPU_MEM_TYPE_RAS_TA_FW) {
+		gpu_mem->mem_bo = psp->fw_pri_bo;
+		gpu_mem->mem_size = PSP_1_MEG;
+		gpu_mem->mem_mc_addr = psp->fw_pri_mc_addr;
+		gpu_mem->mem_cpu_addr = psp->fw_pri_buf;
+	} else if (mem_type == GPU_MEM_TYPE_RAS_TA_CMD) {
+		mem_ctx = &psp->ras_context.context.mem_context;
+		gpu_mem->mem_bo = mem_ctx->shared_bo;
+		gpu_mem->mem_size = mem_ctx->shared_mem_size;
+		gpu_mem->mem_mc_addr = mem_ctx->shared_mc_addr;
+		gpu_mem->mem_cpu_addr = mem_ctx->shared_buf;
+	} else {
+		return -EINVAL;
+	}
+
+	if (!gpu_mem->mem_bo || !gpu_mem->mem_size ||
+		!gpu_mem->mem_mc_addr || !gpu_mem->mem_cpu_addr) {
+		RAS_DEV_ERR(ras_core->dev, "The ras psp gpu memory is invalid!\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
+	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
+{
+
+	return 0;
+}
+
+const struct ras_sys_func amdgpu_ras_sys_fn = {
+	.ras_notifier = amdgpu_ras_sys_event_notifier,
+	.get_utc_second_timestamp = amdgpu_ras_sys_get_utc_second_timestamp,
+	.gen_seqno = amdgpu_ras_sys_gen_seqno,
+	.check_gpu_status = amdgpu_ras_sys_check_gpu_status,
+	.get_device_system_info = amdgpu_ras_sys_get_device_system_info,
+	.gpu_reset_lock = amdgpu_ras_sys_gpu_reset_lock,
+	.detect_ras_interrupt = amdgpu_ras_sys_detect_ras_interrupt,
+	.get_gpu_mem = amdgpu_ras_sys_get_gpu_mem,
+	.put_gpu_mem = amdgpu_ras_sys_put_gpu_mem,
+};
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
new file mode 100644
index 000000000000..c48ff26525d6
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __RAS_SYS_H__
+#define __RAS_SYS_H__
+#include <linux/stdarg.h>
+#include <linux/printk.h>
+#include <linux/dev_printk.h>
+#include "amdgpu.h"
+
+#define RAS_DEV_ERR(device, fmt, ...)                                               \
+	do {                                                                      \
+		if (device)                                                             \
+			dev_err(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__); \
+		else                                                                  \
+			printk(KERN_ERR fmt, ##__VA_ARGS__);                              \
+	} while (0)
+
+#define RAS_DEV_WARN(device, fmt, ...)                                               \
+	do {                                                                       \
+		if (device)                                                              \
+			dev_warn(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__); \
+		else                                                                   \
+			printk(KERN_WARNING fmt, ##__VA_ARGS__);                           \
+	} while (0)
+
+#define RAS_DEV_INFO(device, fmt, ...)                                                 \
+	do {                                                                         \
+		if (device)                                                                \
+			dev_info(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__);   \
+		else                                                                     \
+			printk(KERN_INFO fmt, ##__VA_ARGS__);                                \
+	} while (0)
+
+#define RAS_DEV_DBG(device, fmt, ...)                                                  \
+	do {                                                                         \
+		if (device)                                                                \
+			dev_dbg(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__);    \
+		else                                                                     \
+			printk(KERN_DEBUG fmt, ##__VA_ARGS__);                               \
+	} while (0)
+
+#define RAS_INFO(fmt, ...)  printk(KERN_INFO fmt, ##__VA_ARGS__)
+
+#define RAS_DEV_RREG32_SOC15(dev, ip, inst, reg) \
+({ \
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			 0, ip##_HWIP, inst); \
+})
+
+#define RAS_DEV_WREG32_SOC15(dev, ip, inst, reg, value) \
+({ \
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
+			  value, 0, ip##_HWIP, inst); \
+})
+
+/* GET_INST returns the physical instance corresponding to a logical instance */
+#define RAS_GET_INST(dev, ip, inst) \
+({ \
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
+	adev->ip_map.logical_to_dev_inst ? \
+		adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP, inst) : inst; \
+})
+
+#define RAS_GET_MASK(dev, ip, mask) \
+({ \
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
+	(adev->ip_map.logical_to_dev_mask ? \
+		adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) : mask); \
+})
+
+static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *root, void *iter)
+{
+	return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->index);
+}
+
+static inline long ras_wait_event_interruptible_timeout(void *wq_head,
+			int (*condition)(void *param), void *param, unsigned int timeout)
+{
+	return wait_event_interruptible_timeout(*(wait_queue_head_t *)wq_head,
+				condition(param), timeout);
+}
+
+extern const struct ras_sys_func amdgpu_ras_sys_fn;
+
+#endif
-- 
2.34.1

