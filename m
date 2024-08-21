Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE973C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 08:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A82F89226;
	Wed, 21 Aug 2024 08:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MrbbNkG";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B6E89226
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 08:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X91KSuiDTIbM2DvNxFYDf+x/EYQGJaBUebWG7L9kR+50nhsv1005tJTeSahpS3cEgO5dNmB2HJG21gNpIxglyj3k4Xq5TUcsNbh6p7A29+5Yi7mcmT0ahYoaBiQM9pdq2KjhLqKMDEyGi38pnBYdL6tlV6qCLJZnlevOY7Y01digIa8t6NG2hUaUPZd0w+w7I2HiuAh6hMsWsdVEA5bX/NXW69hRCWiuwzilXNHWg4FF0nVBvTu/pnFB88/znYOMwlSJiqA63msCTkbyNN7PjCcQccuwW52pnSyPB7nOyV/eo1p1dgobrsv9dD2745XI5YaITQOF/wZ2KoqYHxai5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beqk3DLlrDIfQ32VHSmivzpoF4NaRIKtDqF9r2TU7Bs=;
 b=heKwUxFyoIhRAvpK3OGE3R2UV5zMl9qHoJ8tAPotgGHCKU3R12lj8KGKwlcweGhs7QF3opjXyipdMFiYVlrBVyG3v4ZaUdqM5w254W67eBANQQwkPsnoTV3x0pebwOx9Ef8VOgTyIGMITtLUTgrcbGAo4OnImuN5NuhHUXc9zOAlR5HyEJavnCMXF35EMWu/1+ZKH4V6ASn47QxdZ5ncj6/NwgiQAyoXLPfqe5LqrmFxe3TLyT5OeTdUK3xm7WNpEYAcCFdq5eWoSfQcwLc7lX7A5z2MJXm3T5CjdMqYwVhZAOuKDgmtHg9ZGqeGlCYbNUSfdQYApNcG9m1sNr0m6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beqk3DLlrDIfQ32VHSmivzpoF4NaRIKtDqF9r2TU7Bs=;
 b=5MrbbNkGrLnPKr5unCAFKmTl8xd9ziSczDTGK7x+VeTpgMWDfGJlYmlIZGdU+AQ+Etf4UaHIwlBqX5BclCesgluOFYig5hbDY674bSlEkdc+QOhaC/Io1dmFF/NAc1IlXAdKZQ7AhnkoZQsi9Kh8zV4BCvsagQw8n00HwzSlVgc=
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 08:39:46 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::e) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 08:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 08:39:46 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 03:39:44 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: skip printing vram_lost if needed
Date: Wed, 21 Aug 2024 16:38:40 +0800
Message-ID: <20240821083841.477392-2-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821083841.477392-1-Trigger.Huang@amd.com>
References: <20240821083841.477392-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fff7e6-622f-4479-9d36-08dcc1bccfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iTFsZCQE/0W+r5crzszAJLghJlaS5vua+MbQogSToJmlrsQ+BBrPzc5NUz87?=
 =?us-ascii?Q?JPQc6nTdH+HiqQWkAltbwJHATNU/vmGMmNum+BMSPW4iyBMwRIdnlQZwvAyz?=
 =?us-ascii?Q?fnm/PL8WYPjSkS1aYEmz+Wylt4wp1CZn32y3wOfI02Dax74ZdV+qeFli7bDs?=
 =?us-ascii?Q?MS6FjdQkL4zwg0D5rOkUQf7Xfpc3tgPBXhVu8tJqvMZil5V56bTbtH4cFavj?=
 =?us-ascii?Q?S4CSDEkJRUpSxwNOHoN1Y5nsKAO+LgH+Iko+HvaQmaRbujGaL7tWFdS6NJFJ?=
 =?us-ascii?Q?Wv/JuJhfh6bln6REZyUSJm69RIRaVOEu98oVdagm2fHWYlRjP0cT8kAMBHJG?=
 =?us-ascii?Q?8/wpvydHvXrgp5REn6RZd5fjvOlTdv7kzyuHBia7P4brkNcUI+Z+32kChACU?=
 =?us-ascii?Q?7l9xL0mbiipRFSeppAKSbI3Wdt1E2iZQ82qWkbEJddcUTtzH5A5I+w0Yz3wH?=
 =?us-ascii?Q?Q6vrpiE03BzZFiNkuenX9s9phP5WcE+5xrVBKLaAS08L/xTSm3fcNLK4GtcT?=
 =?us-ascii?Q?PxLoii/p8CecWm9JEfepmltWyVBmEHSHlzem1ppk1q8Z+Ufq5iyEbGcirDYE?=
 =?us-ascii?Q?J/ylMr/uQXoTeOE3GqiT0wF9ZE1nskChRNCIejfpTHHmSq8on4mD7lpUYvjA?=
 =?us-ascii?Q?l3QcTqv5kNCAYuLmTxqLRzhoyYoRHXZHsiYEOhUvi5WSsovxI8eAm0IiSIOO?=
 =?us-ascii?Q?RT2UvblSmn1iZFsDx9RQE25YOBo09NIkYqcwFXRQVirEeQmcEpHTc10j1WvG?=
 =?us-ascii?Q?xJm9OQ2j+87P7u5wFZqHv67ws61kta84W6Yd+gWmL8m1I4OM1t3D37f/HV+P?=
 =?us-ascii?Q?Nz0mtqd+6RxoGIFSi76F5fcUo+YO48FzfeKQnHIAT40NWvjgIzINKkkZsrl0?=
 =?us-ascii?Q?IGSG+cianuXnQycfxKat8l4CRkFUp87k2JcSLQVTZtkW91f3xfaNmpifH5xM?=
 =?us-ascii?Q?LPPNyDFf+jTv9X2dsrNijVbbDQEpYPvQMz72dc0iekBRY6wxyHFoS2Z246MP?=
 =?us-ascii?Q?G52aLDzQmFfpbsdtPAQYQgeohPb54Jwu8p/MOfcQYHjGV+g5cUYAgt4D7KZa?=
 =?us-ascii?Q?TGj8pfIhugZ57XMag7JicMA/SmkVufA5eKQbntNjcPRqsPxiMVu6K6372rV1?=
 =?us-ascii?Q?zR/QPPISV8IQS68cFeVxl7Y4EauTyCZIkIwPnM3SMkWggIsOslr4WPwku7qh?=
 =?us-ascii?Q?Ph9ixHu7gxmfA6qUJ8qgWUJ4TRUgsMg92EtdN3finjSgAD3k/SaoQ4E8QyGA?=
 =?us-ascii?Q?nNUmV24gnU/j2wJCoFl9Bj7sF3Yslo7I4TB86avpbXB6DIUyJ8hxLSN4VnrK?=
 =?us-ascii?Q?qGuTfMmurzp0BjVcJCyXHOdyPUOii7MzS3rr59LRfOmfN9mcmDhma3NlBdDa?=
 =?us-ascii?Q?oa9HiUShkkxQokJsv4rcy9KhvR2GgxbhAwOEfjlEq2S+d77dgjsX6aHTp/E6?=
 =?us-ascii?Q?4WSY2UwakntvZpv4z89VBJM6a0dYbjGW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:39:46.0766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fff7e6-622f-4479-9d36-08dcc1bccfaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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

From: Trigger Huang <Trigger.Huang@amd.com>

The vm lost status can only be obtained after a GPU reset occurs, but
sometimes a dev core dump can be happened before GPU reset. So a new
argument is added to tell the dev core dump implementation whether to
skip printing the vram_lost status in the dump.
And this patch is also trying to decouple the core dump function from
the GPU reset function, by replacing the argument amdgpu_reset_context
with amdgpu_job to specify the context for core dump.

V2: Inform user if VRAM lost check is skipped so users don't assume
VRAM wasn't lost (Alex)

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 20 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index cf2b4dd4d865..5ac59b62020c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -28,8 +28,8 @@
 #include "atom.h"
 
 #ifndef CONFIG_DEV_COREDUMP
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context)
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job)
 {
 }
 #else
@@ -315,7 +315,9 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 		}
 	}
 
-	if (coredump->reset_vram_lost)
+	if (coredump->skip_vram_check)
+		drm_printf(&p, "VRAM lost check is skipped!\n");
+	else if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
 	return count - iter.remain;
@@ -326,12 +328,11 @@ static void amdgpu_devcoredump_free(void *data)
 	kfree(data);
 }
 
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context)
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job)
 {
-	struct amdgpu_coredump_info *coredump;
 	struct drm_device *dev = adev_to_drm(adev);
-	struct amdgpu_job *job = reset_context->job;
+	struct amdgpu_coredump_info *coredump;
 	struct drm_sched_job *s_job;
 
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
@@ -341,11 +342,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		return;
 	}
 
+	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
 
-	if (reset_context->job && reset_context->job->vm) {
+	if (job && job->vm) {
+		struct amdgpu_vm *vm = job->vm;
 		struct amdgpu_task_info *ti;
-		struct amdgpu_vm *vm = reset_context->job->vm;
 
 		ti = amdgpu_vm_get_task_info_vm(vm);
 		if (ti) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 52459512cb2b..ef9772c6bcc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -26,7 +26,6 @@
 #define __AMDGPU_DEV_COREDUMP_H__
 
 #include "amdgpu.h"
-#include "amdgpu_reset.h"
 
 #ifdef CONFIG_DEV_COREDUMP
 
@@ -36,12 +35,12 @@ struct amdgpu_coredump_info {
 	struct amdgpu_device            *adev;
 	struct amdgpu_task_info         reset_task_info;
 	struct timespec64               reset_time;
+	bool                            skip_vram_check;
 	bool                            reset_vram_lost;
 	struct amdgpu_ring              *ring;
 };
 #endif
 
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context);
-
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ad97f03f1358..59a443abc11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5468,7 +5468,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
 				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
-					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
+					amdgpu_coredump(tmp_adev, false, vram_lost, reset_context->job);
 
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
-- 
2.34.1

