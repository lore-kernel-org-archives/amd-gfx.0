Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AEEC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 18:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD91310E817;
	Fri, 16 Aug 2024 18:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K2gJ0QG9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E5810E817
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 18:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOrV4egkJqiOpdlpDXTo2AEa6osxzOt0q10oc4k3iHLJskWbWuLN0uQAOfwVZjiNAL3e475IcvZQMsY41a0VMZdI5VjX8yxXwNMtccooheUKoHahU81CnqvcoZ1N2joQtq99yz79z3wBg9fH706njOXaI68VjHskSs6gj0mOkt/79qOKhSUjtBkKLa10r5wsAEyPzP08c2JnZ8eUjANfI8S7XnDxD3gz5ZJTUz56vYUw2TNnxTWlJlB95SnDfYPs6ervQOvEO3EOU+A9CcRDwQ7zI64ST5bfSdu7AJ9PMyUlOuJOTmf9/cuYkj6C/LVKyg1yKI/P1iSASVWbaP1zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6mn+ssBW0ReMnswvhjyuntRKI8e7KUPPUu7i17ATdA=;
 b=pEpcLYAJ2cYlAYOFHn32gt7aaIyuRy+YOaIjnERfxwevzao4i8ggbxD2MKkon1lUZXar1ns6SLBfarPraSK3ZEhJOD/I03UC0jg+W4MjcjtpdDQwDoiZ7z25WpPF6RD97z8xPametvEK+qNbpGaB69tT6afKFmNGlnBwHyc2Gtt+MDwY/e5eRFLreVf9i+rSWJApbgp8/A+CIRM1lGUx4XDSjoLKUX4ziFYa55p+/a+sQ0Ngynzn4tfarPZSPG/8prrpiQtcpG7cMRWeCVSJHyzRtfZwzy0Vqsawss9rL07j75id/JTv0/cG258fOFuKCiGbo4X4yTkWia5sA5KPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6mn+ssBW0ReMnswvhjyuntRKI8e7KUPPUu7i17ATdA=;
 b=K2gJ0QG9RC71kSQAiQVdPCUF8R5gwBbZ+AsXh6VRbvwkDxqTwE0J9GrUm8Mfmr9ezK0ywxBDuEvrPCAQV3WwGK6AOocqP8zRiCDWCadSy7X9KCAWyErF8LlXXa6B7zmUQqcD20S2DHT3w+ZWTaGOhtolAGU/8mKZyYpT8siWwmc=
Received: from CYZPR05CA0009.namprd05.prod.outlook.com (2603:10b6:930:89::26)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Fri, 16 Aug
 2024 18:01:55 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::b6) by CYZPR05CA0009.outlook.office365.com
 (2603:10b6:930:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10 via Frontend
 Transport; Fri, 16 Aug 2024 18:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 18:01:54 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 13:01:53 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCHv3 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs for
 GFX11
Date: Fri, 16 Aug 2024 14:01:36 -0400
Message-ID: <20240816180138.1171558-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a3ab11-1e43-4acf-15af-08dcbe1d837b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dieM6ObjyiEVAHdyfT5fFMITt2v3ZWhAHZBHbtXGv0z7/hLykVXq2Tb6r97n?=
 =?us-ascii?Q?4sIQFkNccRiPHPByahiN/AYVx+N1GDzE6FbIiaWmwtFOr8v6ihMMry0jZRqU?=
 =?us-ascii?Q?0GR0sUpH9qyEQS0JwjuGcq0oPjJSrHzGb5LXO3KSuFDVZ7O2Vo3AvTIC2/1E?=
 =?us-ascii?Q?JgmhSG/HGTs4XqUcmrnjzHPFK+m4Hl7YSXTmKOEAR4MQnoSNH43aibb5bBsA?=
 =?us-ascii?Q?sBT7jNl9BHSr8ja8bRjUtZwVxy67lEaLCUXpmaJmOpz74C+0ZIW7ggM8qbqb?=
 =?us-ascii?Q?7CnO1DM8FIp1FeUoXd0HBidD8nGy950UapKoQfKTKsy7vFWI+bPnsY+F4pRh?=
 =?us-ascii?Q?st9l5QAt3t9pDxez2rHl8/38YujRPJwJ2e8rJqe9taO/N+Qu/ihLas1zv0BI?=
 =?us-ascii?Q?Cel71fvVOpZE2bQbBXqlis2c7TTP2TLGkZRSxdnNKcsgrZIOpPQUr/kAdgVj?=
 =?us-ascii?Q?DBvVug2an7JypARczt5BoeTsHvZxHNIXETYvwjIvGHdKVZsH8m3dnQD6y5ys?=
 =?us-ascii?Q?WSHtnHzpLopEQy4ZnlWbwxxqbmPcHVMTWKeRA5WfK/C14vTzZXA9G+FuZMmd?=
 =?us-ascii?Q?1GCcIj2+hpRbGHaRjN6sYOlVBZrXQAR1BqYzYxXiNNGoMcq4xE2uKUxgJg+V?=
 =?us-ascii?Q?JEn7cAfEJIoXoe72Nq2+rMpni/WlvOqx512kqWVR+jVvxtLuOsysw5k2azg/?=
 =?us-ascii?Q?BKnWGQ+ucJuwerZGJsoc+O2H1AstFcucjJPlrJ3vOrZ/m8JCBGmn9BECb721?=
 =?us-ascii?Q?4xilJpA2fQ4YNW5PNJXlP0UQ+idorcjkJpdIrbgUk+Zxfkchg8ayUBNeMasF?=
 =?us-ascii?Q?BOO57iuRRsndSjQLFgXbb7tW++hXZHJqhLqd7BDA0OyGdw5FBDzJZhIWzoYz?=
 =?us-ascii?Q?atH8xzzLtBmz1skSIihxvzIDsseJMkLDBuSZTboiiKNRG1FScuKnQgf9GFnO?=
 =?us-ascii?Q?BF5M/ZKJ/5UjEhKvHsJ6bINpTZqv4+r1na/+nBKPIDYkryS8rHp5f9nbnzCA?=
 =?us-ascii?Q?2mx1XV0bTQjNUwKVBoivMQdKxfdXCF2drJ38AHM4l1uPGkfNh+8shZheap9Z?=
 =?us-ascii?Q?bdTqSud7r3YhHbmQnF09sd9eY+heqoKmgUZSiMhIQ/prL0BtJeOGD8KI2LAC?=
 =?us-ascii?Q?MLPgbnYoAcMZAG+Na64XSFlSOsfh6mqVzujUnvBLRFEpWDvuCiil6PYwKbID?=
 =?us-ascii?Q?ftK+3nzptwCJ0evmaIZnigKNeDcVcmcMXZ3EQpjW8Nz5bpsPu0R9G17Shcdc?=
 =?us-ascii?Q?GZzRFVNKTNgFiHiUtT6MmIsMG8xNHtac9mtXgxSUHUqL1HbQ1DzCvAvLaRwI?=
 =?us-ascii?Q?L6l7TwmN1WOjPPOxolHuepR0HC0DFfmfl+fQv7evx+Ps+s9ZQJiDM3Jfgsss?=
 =?us-ascii?Q?+4rI8M+fbXKzmx29cBdYtrto6YOF5ZxDSwfdvD/vHuRrt7wMBkCmIPWhA/Tx?=
 =?us-ascii?Q?g+zTKqcxBz19lguD0aNFu7j0jfGyCDB/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:01:54.7572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a3ab11-1e43-4acf-15af-08dcbe1d837b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

Add implementation for MES Suspend and Resume APIs to unmap/map
all queues for GFX11. Support for GFX12 will be added when the
corresponding firmware support is in place.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v1->v2:
- Add MES FW version check.
- Update amdgpu_mes_suspend/amdgpu_mes_resume handling.

v2->v3:
- No change.

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 71 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 32 ++++++++++-
 3 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 04a4f0dfec15..44c74a08987d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -501,60 +501,50 @@ int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id)
 
 int amdgpu_mes_suspend(struct amdgpu_device *adev)
 {
-	struct idr *idp;
-	struct amdgpu_mes_process *process;
-	struct amdgpu_mes_gang *gang;
 	struct mes_suspend_gang_input input;
-	int r, pasid;
+	int r;
+
+	if (!amdgpu_mes_suspend_resume_all_supported(adev))
+		return 0;
+
+	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
+	input.suspend_all_gangs = 1;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
 	 * lock dependencies.
 	 */
 	amdgpu_mes_lock(&adev->mes);
-
-	idp = &adev->mes.pasid_idr;
-
-	idr_for_each_entry(idp, process, pasid) {
-		list_for_each_entry(gang, &process->gang_list, list) {
-			r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
-			if (r)
-				DRM_ERROR("failed to suspend pasid %d gangid %d",
-					 pasid, gang->gang_id);
-		}
-	}
-
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
-	return 0;
+	if (r)
+		DRM_ERROR("failed to suspend all gangs");
+
+	return r;
 }
 
 int amdgpu_mes_resume(struct amdgpu_device *adev)
 {
-	struct idr *idp;
-	struct amdgpu_mes_process *process;
-	struct amdgpu_mes_gang *gang;
 	struct mes_resume_gang_input input;
-	int r, pasid;
+	int r;
+
+	if (!amdgpu_mes_suspend_resume_all_supported(adev))
+		return 0;
+
+	memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
+	input.resume_all_gangs = 1;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
 	 * lock dependencies.
 	 */
 	amdgpu_mes_lock(&adev->mes);
-
-	idp = &adev->mes.pasid_idr;
-
-	idr_for_each_entry(idp, process, pasid) {
-		list_for_each_entry(gang, &process->gang_list, list) {
-			r = adev->mes.funcs->resume_gang(&adev->mes, &input);
-			if (r)
-				DRM_ERROR("failed to resume pasid %d gangid %d",
-					 pasid, gang->gang_id);
-		}
-	}
-
+	r = adev->mes.funcs->resume_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
-	return 0;
+	if (r)
+		DRM_ERROR("failed to resume all gangs");
+
+	return r;
 }
 
 static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev,
@@ -1651,6 +1641,19 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	return r;
 }
 
+bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
+{
+	uint32_t mes_rev = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
+	bool is_supported = false;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
+	    mes_rev >= 0x63)
+		is_supported = true;
+
+	return is_supported;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5c8867d2380a..a5b1ea60cac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -503,4 +503,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 	memalloc_noreclaim_restore(mes->saved_flags);
 	mutex_unlock(&mes->mutex_hidden);
 }
+
+bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 6f5a80519af9..8edcd85a1261 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -441,13 +441,41 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
-- 
2.35.1

