Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A35C2A09B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 13:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5C210F4DC;
	Fri,  7 Aug 2026 13:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/6S+FiV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7979510F4DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 13:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUw3kqcLLfQgEoYPOifzvVSc/MuG+W8ffApo5lQhD0YBsOsJa8GuvvdfpqcDsE28hGpRP5lZGc1iHQIUslXa2foOIHJY6r3lJCnrwLXBSzxcVg8eWer5F0/2VFF/1RO/d9W7cnZnwcgWMGCvwL6rS46gRZXZZ+JPN0mzWBr6Dr8vS7lJGwXnGcgVwR1Wp1CmBYnjumI0OGh06PEUEIJzrZj9yyLuikoKqKlhTW4kywPPKgIsbywKfgVFC5RiTcaNCurkPo6cZ9bL6iTa3+htNG94ZEgWF7zpRxMFeBcEfGVTeaQYeJVSBsBrrfi84AE5DVfXEd3zvCGtrW5EH/KLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Pd6XhKZYmYWprbaRDaLKS8o6wlxtx6lqwxVybxbOg=;
 b=n7m5Ey/rYZmSKD6B1SDysFQDOCoG6BXgI8w+Qq+3Asflp1X8Fu9p51V7StQ8vqDHmmokqgBVg5/JTlVCrUwqra1I5Ey0TBsoj5bwhIG5b8Bh4i+iGWe4MPQjpzFM/pGVetIuGKbE71l40njYJPCOAZfpbhYl914CJc5gLgDIfnpXHCjHlNly9jcyUXt2oIpms9UlqWTKzPz+Q1RTgvKAC3i+79op/XjuUV+XCMZWRn6a4/zeLnuUgmthc96byq+92C1yEp6BuU9q9I/KM2hSe0cL8qHdErKw00SFXQ+qZ8kF87mrF9esA8/SSnyRvL4/Z5lryYJAzOlqkyrB5sHZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Pd6XhKZYmYWprbaRDaLKS8o6wlxtx6lqwxVybxbOg=;
 b=q/6S+FiVL5bnAmkZz6mf4ToiwTOjnNRH7lYCb8pu+UQqobEM7MiXxupRhEiuGGrHphZ9xJLH7lhhels2yVNWiKtmjnDbU7kQiEh+5PRAwDQNGQca8DPnTfgNEcqP4W5/cw0u2BzAngyEBjPLHuU+9vfqUpSin4KZo5B8+ICiprc=
Received: from SN7PR04CA0115.namprd04.prod.outlook.com (2603:10b6:806:122::30)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 13:42:55 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::6d) by SN7PR04CA0115.outlook.office365.com
 (2603:10b6:806:122::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 13:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 13:42:55 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 08:42:54 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Sunil Khatri <Sunil.Khatri@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add trace events for pid register/deregister
Date: Fri, 7 Aug 2026 09:42:41 -0400
Message-ID: <20260807134241.845819-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: c3491e54-1d41-45e3-bbc3-08def489c8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Jy24RExy0ecwhLkpxPE6c4WZ79TCVOPXLo5uhcKdBOhhCOX8HEhamnS7T4X3lxdA+oCn4Iperh3Td82tdmODar45Ol6b+jz1tLe6YqeAzFFEWH1ZSeHCxsdFNyj0f2DIza0i0UFI0pXMCO+VuxUKNMmBDokz5aFXPC7MDSnByXJAFO+XiOu83e8HBZ6sqziFycz9aNZmAi2ib+N9xFp6vSvydz8CzSvFYoWQh4jh6fU/l2yVKvM70Ry/X9w8QyezPu6bKogestzp0iIu9Blceq5cb6t3kVb6020qVlcDp6wtAWMSB+85cysj4HJbjxRSI6SLfgRmqWHSBK2JHzMA4pSXYnYsXNM67VI2g4tD2zUTtFyebVgevsCqYHeOWiYZrIVKdHa3tFfeQDtJiZHXNGCRPRpCvNQyU5MMwWrAqA0Ab48FVHiYIoW3L0DZONdTWoz1eLiDQGCX1MWA7zCcaq1qaRzKfByQoT5JuNswYiEAH3LyrBNXCdkKHC7a8PKaeH0EIvEUh5JOakJftHOQEZOZvRxX2CQ9ByW5bGYfQQm8yDMwuIQRIxFP9mH1VSz8GHZXSKZoZ6uu1XkNjLEkHsEkEOzMrE75rAgHX0Pv2DvdMbtrexmLXlrxW493ExrFX4polGBA+3oi105IYlnvKcSqAo9lJCd9oiNVBxJavuSSy9l5WzOIqfm2kImiLJ81Hbqjw0rE21XvzuL6ESP5tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DrNAqzxLFpc2q02PSMgF7OnZZJbAfRq2C7BKI9NLspCJN7vHMIVtmuUM82ShK8BXATqsRhM50UzINdptcShZeKNjDALnqpeACwO/OoWEZvCSZ8BLE7UpMTf81E2aIxoz4TLO6/vbBFRA1+ZHFwedkI8U0mXpmzGgMeSYavFvGgyZhB2kmiy3D+TRIYAfksdfXVetupS5KPTZZf+5QmE4IoD+KD62NsXBSSIb/pvjiE2ovxz7zisFlD+qxawmHQZb0+Bo6JVK+Nr9D85pd5Eq+NiIyCq0BhzD7YddgYNW4JPkRkPwnUhM1MGeOJ3g7HK9vnBfL9cUh40N3pSm1J7a1YQk9hnRKcH7AVPMkx885wz1HKEqMl23OHK2zQKXVkJydh4K99/s1dj2zDZ/1bn+AgHVxWF+RYVvnspRw1Br8Cy33gben7/MvHcACtq7uSKn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:42:55.1107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3491e54-1d41-45e3-bbc3-08def489c8ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

cc: Sunil Khatri <Sunil.Khatri@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5324030a13f5..2aeda13e49dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
 		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
 );
 
+TRACE_EVENT(amdgpu_register_pid,
+	    TP_PROTO(uint32_t pid),
+	    TP_ARGS(pid),
+	    TP_STRUCT__entry(__field(uint32_t, pid)),
+	    TP_fast_assign(__entry->pid = pid;),
+	    TP_printk("amdgpu register pid %d",
+		      __entry->pid)
+);
+TRACE_EVENT(amdgpu_deregister_pid,
+	    TP_PROTO(uint32_t pid),
+	    TP_ARGS(pid),
+	    TP_STRUCT__entry(__field(uint32_t, pid)),
+	    TP_fast_assign(__entry->pid = pid;),
+	    TP_printk("amdgpu deregister pid %d",
+		      __entry->pid)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aac8ace9d7a6..48a725a0154e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2543,6 +2543,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	if (vm->task_info->task.pid == current->pid)
 		return;
 
+	if (vm->task_info->task.pid)
+		trace_amdgpu_deregister_pid(vm->task_info->task.pid);
+	trace_amdgpu_register_pid(current->pid);
+
 	vm->task_info->task.pid = current->pid;
 	get_task_comm(vm->task_info->task.comm, current);
 
@@ -2803,6 +2807,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 			 ti->process_name, ti->task.pid, ti->task.comm, ti->tgid);
 	}
 
+	if (vm->task_info->task.pid)
+		trace_amdgpu_deregister_pid(vm->task_info->task.pid);
+
 	amdgpu_vm_put_task_info(vm->task_info);
 }
 
-- 
2.34.1

