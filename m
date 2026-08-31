Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B0EC61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 19:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB41010EAE3;
	Mon, 31 Aug 2026 19:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qHIGEl/I";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637B110EAE3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 19:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y90N3eRjT4Zhz+DWTakTAJh+2u6ltAf3uM0IyKKD5wbRPuVbqmGT8FqxFl5BPnpVJ0XRz5TO9ZAoF0OmTVLc0RYlvtjJGIm/TaK3OWTZCIda43HPfZskvnLtlSUJ5PchM4U3LLXAtQqXL2VFw9hFE3u1qQNi6kir4xDoTVux2m6GHIG3dBXrVLfu6/t5/R9X8v4y5XFdAa9Yqse0/D1BrFDUrNKr98OhAzqW4GqLj29KVCiAbRbJV+jDOZA3F8/Zz5zZxmHkXqOcMf5L6WjAfcyYgzxqqkB0MGw0NE85jU1CJ+HNRv9YbPzxWbq2nugeVmP8i+5plIkmeAORwN8zeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0npQaoroZQbkjmhaRxs/9mJ491NQMG1orP2Uv0BZIQ=;
 b=J2Ekm9DieIQZd0bF5NtFLrt4NKew2gC9u30wDMKkk+LkQIz5o1Q7CCjppJQwszSOeqvGS+2BIS+X3nY5VNOKhJ/3anY19aqdPPUTh337XbqPRZWcKsZt3Y1G7sWrB7iJltcW6LiqWonOZiGMjCAuapNr0da88JkjszR0jf0Yjxq383s+QyobgMW20VLOC0NKSQbXbAd7aCCoiEZEfZvqRZn8iei5x1k0zaVvsZf32LNfTIGx2bWCLDptULoDxr2iomA9rfNLy87aYLF+FDjKPDa1g6fxQCVMV0SP4k4LVz0naz0op2+ZwNgaKNKUG5Oi+EfUVR5zF3LsWq+9R6bvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0npQaoroZQbkjmhaRxs/9mJ491NQMG1orP2Uv0BZIQ=;
 b=qHIGEl/IoiJxc+dnWPGUAMl1Og8oWs5PkyGSyYrE4nmbElcM6M7zwjNBf874SJxMftfRYHpRFJqzSw2F1KqDUBy8Okb6XjVpl6bX+z+sgB5dqmgZLr+R7fBTg4r+XGrzmykoMkLyuaTuMSERg9l96W1V3XCJpGnoCBkIywyI0hM=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Mon, 31 Aug
 2026 19:56:03 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::38) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 19:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 19:56:03 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 14:56:02 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Sunil Khatri <Sunil.Khatri@amd.com>
Subject: [PATCH v4] drm/amdgpu: Add trace events for pid register/deregister
Date: Mon, 31 Aug 2026 15:55:50 -0400
Message-ID: <20260831195550.962209-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 7143878c-9afe-4438-dab5-08df0799e341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: UgMubJFKjon4I1U4EU7gtwSWH536w3vPJ4Ey3yajgf+iZ1zcYNckAjo/yl78pI5hAhDhr8uDLxh+GEQ7Lj0IbqwWy50BbeO4EgbOXc029Il66cgmJhoERl61FxO9aJPeqxpZAN1hIZyB/zSB+ofuD2NyawbjFZPJz2gn6LRGWiFhaVBCCfM7TVBPH6v06V6Iyb2lZrKlNg3Vm9W/Ki5IAxZIil9noqw3bD68YBrl4bejvdHFRMIC2/ChGK0CQIGtj/JAPp3x64rflAMQ6fxT1oAp+JCk9qjYbHblpfskB1jmdUhwGGBgJJBY3P0epxaesH0GwY8RA7tFuVfe70fhQ5rZyaSEIAszW1/vBd8ImUWXOP7KPVuPkW8DRcUGxuwDlOKnS4+LLgU0VAsv7MJPB8puDoUwzSM9THEJ7p1deh7/IEENBvPA9Y37QObR217LEJ04SOUmq4OljGSUOTi6cwLM6zS+3GXu+69uWba9bbMI+tgA0dZM/fXD8phJel6a6WulHWeaUpExlSHIkEqsNjUJtZxpzx23FBMfwLwnLuhv65fIearnY0mVjHixsnnUPodz1DKBb46apfee/5oZOak//j2MQ1Gg0TZM+PBf96a2SdUa0ufXOLvHsB/4j5wBCPqBNMytDkd+OSt6Yvf8Dwr9YRAISs5sdV40/bFmpDVgplwHKMCwDu/1wISDt/XW8KK8vhkw6/f5WzIJanPfrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Gt2hwezyuP5ibeD/gp3KGrNrTdni9fFXMQX7kM7ws9GUOhLsjQQEyPGpzWxmVoxKZX+jYEuUOiXq2KAyG1XZStay4Kz3mQrokHIh30ZQ2IBlPwtCACp6qRLtLRrqq+6TuPRrBeAvDT9rvQqhgCOAXdrA1U5XsSQa2T+BpBd+2vBAfbwuIGGlTvvquLS37uAAQ3SuplPNeYtc2V+a4RrQe8xFomql/KFi9irw/p82FN+iD8iDryfC4Ap/ryKr7rUedP9MZa4Qjw/rFodfwNmgUB9zbOrtyCKxc1AfkVZipcYiOcCGFoV8Zt0/DS//AU2dCZmnzyVKTiY82vXL91StvsVCPve+xe1m/tr33Zn9yyXhmdMxhfqZ0L18OlGr/foXLeN0ymEZAZA2n3QjZhAPfpUpkiNJydWbh45jkXg7NhOdhWHYQ/SLUxewVGpM5F3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:56:03.3606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7143878c-9afe-4438-dab5-08df0799e341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

Some debugging applications need to track when a process starts
or stops using the amdgpu driver. For those processes, add ftrace
events that track when a amdgpu_vm task info is changed or destroyed.

v2: Deregister in fini, not destroy.

v3: Also report render minor and major

cc: Sunil Khatri <Sunil.Khatri@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 33 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 26 +++++++++++++++
 .../amd/amdkfd/ctx_save_restore_area_address  |  0
 3 files changed, 59 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/ctx_save_restore_area_address

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5324030a13f5..546794097631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -732,6 +732,39 @@ TRACE_EVENT(amdgpu_userq_state_changed,
 		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
 );
 
+TRACE_EVENT(amdgpu_register_pid,
+	    TP_PROTO(uint32_t pid, int major, int minor),
+	    TP_ARGS(pid, major, minor),
+	    TP_STRUCT__entry(
+			__field(u32, pid)
+			__field(int, major)
+			__field(int, minor)
+	    ),
+	    TP_fast_assign(
+			__entry->pid = pid;
+			__entry->major = major;
+			__entry->minor = minor;
+	    ),
+	    TP_printk("amdgpu register pid %d render %d:%d",
+		      __entry->pid, __entry->major, __entry->minor)
+);
+TRACE_EVENT(amdgpu_deregister_pid,
+	    TP_PROTO(uint32_t pid, int major, int minor),
+	    TP_ARGS(pid, major, minor),
+	    TP_STRUCT__entry(
+			__field(u32, pid)
+			__field(int, major)
+			__field(int, minor)
+	    ),
+	    TP_fast_assign(
+			__entry->pid = pid;
+			__entry->major = major;
+			__entry->minor = minor;
+	    ),
+	    TP_printk("amdgpu deregister pid %d render %d:%d",
+		      __entry->pid, __entry->major, __entry->minor)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aac8ace9d7a6..6be83cd2e162 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -33,6 +33,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_ioctl.h>
 #include <drm/ttm/ttm_tt.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
@@ -2530,6 +2531,12 @@ static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
 	return 0;
 }
 
+static void amdgpu_vm_render_devt(struct amdgpu_device *adev, int *major, int *minor)
+{
+	*major = DRM_MAJOR;
+	*minor = adev_to_drm(adev)->render->index;
+}
+
 /**
  * amdgpu_vm_set_task_info - Sets VMs task info.
  *
@@ -2543,6 +2550,18 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	if (vm->task_info->task.pid == current->pid)
 		return;
 
+	if (vm->root.bo) {
+		struct amdgpu_device *adev = amdgpu_ttm_adev(vm->root.bo->tbo.bdev);
+		int major, minor;
+
+		amdgpu_vm_render_devt(adev, &major, &minor);
+
+		if (vm->task_info->task.pid)
+			trace_amdgpu_deregister_pid(vm->task_info->task.pid,
+						    major, minor);
+		trace_amdgpu_register_pid(current->pid, major, minor);
+	}
+
 	vm->task_info->task.pid = current->pid;
 	get_task_comm(vm->task_info->task.comm, current);
 
@@ -2803,6 +2822,13 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 			 ti->process_name, ti->task.pid, ti->task.comm, ti->tgid);
 	}
 
+	if (vm->task_info->task.pid) {
+		int major, minor;
+
+		amdgpu_vm_render_devt(adev, &major, &minor);
+		trace_amdgpu_deregister_pid(vm->task_info->task.pid, major, minor);
+	}
+
 	amdgpu_vm_put_task_info(vm->task_info);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/ctx_save_restore_area_address b/drivers/gpu/drm/amd/amdkfd/ctx_save_restore_area_address
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

