Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FE606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zIIYOowd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB3B10E134;
	Mon, 23 Nov 2026 02:47:54 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716B710E15E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 02:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7zriVBgJQMb2mpyY+6NPMhSsTBC17Zy8HRgY7KnfCrbdDA340yPEa5ZQhNUG0bwDdBr95OTwpjUISiWXmEyLNvNoQ2eocnoXlkKrNghepU1JgS6gpd/SCna2sh0gzJkBF5dlYF5PA3YZuGNsDiRqrvrqOCJ/VGTVflY3fHVZI0jLomfy9lC7Jd7VrWGw42/DoKd+Ls+odQ00Liac7tU4yAICCgI3PG0Rv0p2d57m53BelyvokT1Fohe3298dknvP9q3FZ8CxUqdwk0LXWVTilOPzTSSOMhJ6+J+ztybkBpCdIc02DIzZgRiMOxQPkgeq/HsqscmRfGvMHRZC8knmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR/BvgPVDEJsRxdh6XmFSsZblmrWu1CFq7nChFx6hWc=;
 b=Trv2kNEa5utefZ8VxvKJMSJYiR8CIdtZnQcljqvg11ZLtQT73eIjIhQoMc1u3qeVc8G3J+cjmx5Tgsnyahlwlt0S5NJcq/xfI4fUKm6eWBXwXF6iztblLF5t+VPYA46bdRs3WCAig4MoDG4NfAWJb4J9ZAqnEpVDBoa4vyRp3uXtNrZ7k1Mb9/vyOtQ69N4nXiyh8bjC89jxfudV/96TcDHCw9IT8DCPNY8jLCqpn5IZLachrZdvFCzBOx/fAArmZnhcyHS54mLKcKFK5lXwINEg3MzhLkJERzIGiDSX9H/znKhFhCzdbNMZL6wdfGLmdmDpcNVro1/neKIKayENtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR/BvgPVDEJsRxdh6XmFSsZblmrWu1CFq7nChFx6hWc=;
 b=zIIYOowd1d8eafjveQUoK6wEkEC/o6Q5xVs9yffzF5WDGYD/ARnFR5DUCZaVRh67bmXtU2nzlRCAN9G1mzrh9OucQlCLqwFa6iLYW5PE2zOsXrYAuor+I3CW69QADix/fRH3GddlcGvsdDxHLBXKHq+potvEf7bEMIy0O5bZXSE=
Received: from CH0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:610:e4::31)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:47:43 +0000
Received: from DS2PEPF0000710B.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::a1) by CH0PR03CA0206.outlook.office365.com
 (2603:10b6:610:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 02:47:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000710B.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 02:47:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 20:47:42 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 22 Nov 2026 20:47:41 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Date: Mon, 23 Nov 2026 10:47:08 +0800
Message-ID: <20261123024737.1475714-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
References: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000710B:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba73ccc-1bd2-4e1a-6d87-08df490c25d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10086099003|18092099006|22082099003|18002099003|3023799007|5023799004|11063799006|56012099006|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: Bdic5mLm1x/KuE4pWIr6Y4jpW6aBqQz53Knc5e20xxVatNpTaXVHa7GJr/dAyTCFlXPfYJTvvDNOi+svB/LH2AUxwu3JMIFoftL01ZSChA9jc1V6lNK+blPweME7q7UT6xibpZgNYWlOsO6IVgnxRwYxvjwXYvZy1iIzAP6ro7qkt9fV3O1G9S3AXvVRpoDOwpeIw3gnQfYVQBOvPdRjhjoxLGbM5wW0H9J0EVu6QAzK+0pnALYDEOBU3DXZkrZ9PvFVx2KFyd9YwSfZXwWOc/nrVVhxORiVTpxqcrbyRc09SJmPRVepE+81q3+8dt84Dy7qNNcZSRXaVbIFb7DpxzjMHCg1sPVlfK5J0ylvOlK8ZfNa6cMvXeJN53kk+TBsQe+zUYfUU98FKtEbA5Eenjco5dQK8cfcQswyf98XeniWZfFlbG+CVjSm00BAPihV7/mQTfgHEV5b/Fz+aUNul1zQ2/3G0OIWMUTfA5WeQBqgSa5hv1xbVq9vN3QjyUR/DHN88e++sKbYMAlbM35yrgF+Tf2oPSGR/2+b3DYtpy/DPnxKnbUCNxxMiQCCOk8IUwM0sTNbw88oJ8K/2ZNY8bScu74C0A7r76bealpNRDE9Kwr4KpGwvIhlSwn2x3QVwOYkEQeVHMc3UPpyyQfppSlhSBGVDGjDZGXPUXYfXFhUC+3UfhtHQUrBU+8aL+Ioy3R8cF1IzGtnCTvuyEyrcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10086099003)(18092099006)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XtPxlRg8iPTPzWAtB/qrRmhWrV9QKvmhf/6UKIrbkUBp5/c8p1Ch2rxQUi+QKzihqFQ0a1zDy4A7Zw7ElRY3CXQJAgMOjfpX4pr6aqx58MZi84UboR8mubvnUecKnB11iRYihwN9RCjuitKUe/DBDC262hyY4A6t4IkBn4pyJT4GNOyklGsQpUTIpqFwJVirTKcH7acORdM/VrlpPZYwm5k3W2Kdkp9lpbA5gTCBmyI1Bt4vknJ5Vug8J8svB6fuzu6C7OdaWGGlHCZdOveiLbaw8lUPL4qg/Wpn5oG5qM/cWXANMgM4wCMQChtvP4z5IY/9F5zOOslZvc3cA1BhdPMdgAWeauKFg+LVR9PDbPi4MKYZaMK+eK00+T+ua5UM9n2jvUYsE251ndUpm1hZVFneuVXpl//kia1RDl/aPRObOVwufIeGW4h3Y9zvbCWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 02:47:43.2370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba73ccc-1bd2-4e1a-6d87-08df490c25d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000710B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KFD_IOC_DBG_TRAP_ENABLE stores the caller in target->debugger_process
before calling kfd_dbg_trap_enable(), and nothing resets it when that
fails (-EALREADY, -ENODEV, -EBUSY, -EBADF for a bad dbg_fd, -EFAULT).
The permission check at the top of kfd_ioctl_set_debug_trap() accepts
any caller equal to target->debugger_process, so the caller keeps
debug access after it stopped ptracing the target. The pointer is also
not reference counted, so it dangles once the caller exits, and a later
successful ENABLE by the target itself increments
debugged_process_count of the freed process.

A parent that ptraces its child, tries to enable debugging with
dbg_fd = -1 (-EBADF) and then detaches can still enable debugging on
the child with a valid fd:

  1. ptraced, ENABLE with dbg_fd=-1      -> -9 (Bad file descriptor)
  2. ptrace detached
  3. not ptraced, ENABLE with valid fd  -> 0 (success)

An ENABLE of an already enabled session also overwrites the pointer
temporarily, so the exit of the debugger of that session, which looks
for its targets by this pointer before taking target->mutex, can miss
the target and leave its debug mode enabled.

Set the pointer in kfd_dbg_trap_enable() only once the session is
enabled, and clear it again when copying the runtime info fails. Step 3
now fails with -EPERM.

v2: clear the pointer instead of restoring it (Jon)
v3: set the pointer in kfd_dbg_trap_enable() (Jon)

Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and disable")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +----
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..5785cb8b4393 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3227,10 +3227,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 
 	switch (args->op) {
 	case KFD_IOC_DBG_TRAP_ENABLE:
-		if (target != p)
-			target->debugger_process = p;
-
-		r = kfd_dbg_trap_enable(target,
+		r = kfd_dbg_trap_enable(target, p,
 					args->enable.dbg_fd,
 					(void __user *)args->enable.rinfo_ptr,
 					&args->enable.rinfo_size);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 14e7ee30cbdf..f7d5dc90f8e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -781,8 +781,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 	return r;
 }
 
-int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
-			void __user *runtime_info, uint32_t *runtime_size)
+int kfd_dbg_trap_enable(struct kfd_process *target, struct kfd_process *debugger,
+			uint32_t fd, void __user *runtime_info, uint32_t *runtime_size)
 {
 	struct file *f;
 	uint32_t copy_size;
@@ -823,6 +823,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 	kref_get(&target->ref);
 	target->debug_trap_enabled = true;
 
+	if (target != debugger)
+		target->debugger_process = debugger;
 	if (target->debugger_process)
 		atomic_inc(&target->debugger_process->debugged_process_count);
 
@@ -832,6 +834,7 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 		target->dbg_ev_file = NULL;
 		if (target->debugger_process)
 			atomic_dec(&target->debugger_process->debugged_process_count);
+		target->debugger_process = NULL;
 		target->debug_trap_enabled = false;
 		kfd_unref_process(target);
 		r = -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 5babf9b992cd..f675fe6ed353 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -44,8 +44,8 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 			void *exception_data,
 			size_t exception_data_size);
 int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs);
-int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
-			void __user *runtime_info,
+int kfd_dbg_trap_enable(struct kfd_process *target, struct kfd_process *debugger,
+			uint32_t fd, void __user *runtime_info,
 			uint32_t *runtime_info_size);
 int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 					uint32_t trap_override,
-- 
2.50.1

