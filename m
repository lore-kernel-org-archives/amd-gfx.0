Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1F5CD5BD5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 14:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAAC10E80A;
	Wed, 27 May 2026 14:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ybl3FKP6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986B810E80A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 14:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcNxXW1Zwd6zaOmmNWY/K6bF/zSWvuM6bF+D38BbO4MEp6YmSpcOHrWnnEdBZqNLx9GJpvWVXgLtvX7mQOtGyJSlB3cBqXtLJerW4d6vI6vhDccHo2iRD7ffvoG/KKnrnSlEal6BtcLJPWnYyg6dpilWej1y47tOA6W9vNn/BSrm4v9Wc7rrTgZOzLU0DrSw06eCiRrBqRR3NGX/XdWJOI1VfPd1PzyzpTTAHGq2SqNjP+VxWAZAdXZ6FAzTXRwKaGw5ZokXJ3n1zkalL9eZdSXkyoB+SiNRB2SxNKhldxC+VoApXL7InlH1IGgUwcb6u8GK35AflEWFYyDtdYYm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP0OP4QZDQ0uyorgvs6SQOmR4keGN8Yi4yVliZxWyK4=;
 b=ku8QZmI3uB359UO1oUSk2l8eiWm/hAzm2hNqKD9JW+t0D9P6jSBBvrW//zkkLLKZonUXOCth0h567CHVxS84oqeCxOGcHseOuaaGEzVGQEy/Z0/CNw3i9AlbeyRUSuDse902/YXf5lUmWJm525G3D3ii9phsx9NmtvszJfK15s4nemaSF2xaB3hYyZ1f3Otgikyv2D5I/EZNCQk24g45W/4zLBXoiXgnxl9fZDueuyKiKBd6acriRCDowAVI3xVNoL+2QqcQHTYwMlLvKd6L7GCtuCbMt7exqcOwGrEAgCuCzY+7uUvNlKAPVc2yBv8bx9kcZpkCN7MXH2J2fAEHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP0OP4QZDQ0uyorgvs6SQOmR4keGN8Yi4yVliZxWyK4=;
 b=Ybl3FKP6AKen+o+7GWpQLpSA7M2E7vUFRnluGO0yZDxJl89E7haQ6wpRAgDK8FahPZte3ECPWJVademo/ne5rjB0awRAWvfaVdsKxVCnNrz7bFatNJz6+BT7Qjzt7AwM+wBi0NFzVAtlXA0ogd9mzg30kUWLWIq0CIiVEP/xgNY=
Received: from MN2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:208:236::31)
 by LVXPR12MB999197.namprd12.prod.outlook.com (2603:10b6:408:3dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 27 May
 2026 14:10:32 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::d) by MN2PR05CA0062.outlook.office365.com
 (2603:10b6:208:236::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 14:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 14:10:30 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 27 May 2026 09:10:30 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix SMI event cross-process information leak
Date: Wed, 27 May 2026 10:10:14 -0400
Message-ID: <20260527141014.567441-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|LVXPR12MB999197:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f33a11-85e6-41aa-fd20-08debbf9b5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: o+7l+dZjnr+6UHAbdgk6hlXVWhLxiel6Qyp+uB5xnqUX4g9MK9I+X3JV5MWephepTSYMfqYxrADZUxK0JeVYTLzeADvoZ9za0oxE+uvpuK7sZhlPUgqaNzrrkT26x9zujQ0Zhd3+JF5XcJQWZIDajEK6KrMpq/YnXONSzu+TdBrEiUloyhabtVQ2cy+IUSo7Pu1LLVSPypSx9Uvfta5AnEPaSteaTgF/eI/7iwZ/x1f0QpnCEBBgP/Yktoj2H9DDpVErnBtAJXUqg8V90wFPIiIikPppUZGCWW7n9VkhMdS/r4F03HYr92T5w2Z/EPlrFngLX9H+O6l5tKAD+rvUAkmjJfaU6fUylhu0eY50WRAkiPGIx9BV+CRbHO7f2k6HDa8zQ2eQE3I2htxKpXxdnuwMlFU6rPdUcgiyVprkyspQNwSYeD5O0X1GzBUYTaX8lRHRVLu32iawUMCGu4FQKayRDEhT5b61TdC24B3IaOfnHTH6EHfa9dkFmb4Oi8bWTJ4rEcNnQQeBJ//gtqhVo+7HP8veCnME+xh9fr9wvwiWBNyLO7HVJuJg+G4bCwAFgBvFwLU7NXF7OtCSfMKZEeCAV3AXjMjcQRupl4zYbI42KkEgeMW3c0D4XXqqz4WDd8vXTuL/KhENz68yZTsAlVz1tdBsI4HsZWkoXLN1JNLM8SksRch1tquFSxv0qTqGXt2V98C6y/rFjvCk6M4LCSyhWmp3qSf867JakHFkVeA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1HXdLMFUdqbSA/CCG8e6MCpq9e7YwMwZEXFJLK1Y81Kffj0pIJKjW66U62V9rdP7WXW/IcK7TvTWv0eZ7Vz04A7dqWzcjvmemmCBtbDlty/K0CitT+02MJ01XxDQFVw4W/IVnCL5wRySuLRjYFLiRboeU+XdDfdFwNhAemlHn9OLnr2UCc4tWJylD6NWClXrx13TrWgaxsCiqL8XrWkRd+oY68xXFov7GyNymq4HMcNyZYQWi8vAuZY36BMGkxk5ICYBbVW35plVHVDh9UT0dAwYHusUYsKOV2yGbYYOQ8wVTD2dnQ6IxLLkUECul3Y6MbH5MPk/iZ9iy+NplxEZmk1stgq7Q64cGtuM/9il38wPr9YPm0/r5GXGQFpgJJyncLKGZwp7xWzKY9C9kp1Eq8fD+biNdHSfNayM7O9XFLjQXraxY7RbCuHpjtU+l/o/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:10:30.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f33a11-85e6-41aa-fd20-08debbf9b5f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999197
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

kfd_smi_ev_enabled() skips the suser privilege check when pid=0.
PROCESS_START, PROCESS_END, and VMFAULT events are emitted with
pid=0 while carrying another process's PID and command name, so any
/dev/kfd user in the render group can monitor all GPU workloads.

Pass the target process PID into kfd_smi_event_add() for these events
so the existing per-client filter restricts delivery to the owning
process or CAP_SYS_ADMIN subscribers.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d2bc169e84b0..82f9165225fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -254,8 +254,10 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 	if (task_info) {
 		/* Report VM faults from user applications, not retry from kernel */
 		if (task_info->task.pid)
-			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
-					  task_info->task.pid, task_info->task.comm));
+			kfd_smi_event_add(task_info->task.pid, dev,
+					  KFD_SMI_EVENT_VMFAULT,
+					  KFD_EVENT_FMT_VMFAULT(task_info->task.pid,
+								task_info->task.comm));
 		amdgpu_vm_put_task_info(task_info);
 	}
 }
@@ -356,7 +358,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
 	task_info = amdgpu_vm_get_task_info_vm(avm);
 
 	if (task_info) {
-		kfd_smi_event_add(0, pdd->dev,
+		kfd_smi_event_add(task_info->task.pid, pdd->dev,
 				  start ? KFD_SMI_EVENT_PROCESS_START :
 				  KFD_SMI_EVENT_PROCESS_END,
 				  KFD_EVENT_FMT_PROCESS(task_info->task.pid,
-- 
2.43.0

