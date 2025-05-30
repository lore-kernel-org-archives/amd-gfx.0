Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4139C3ABB2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F8810E7C3;
	Fri, 30 May 2025 07:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AkozAAUg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F9810E7F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpfAnK9eGRmWcWWCQNhLhBMKQPtb7SCOEvL2NIrwtLiBAlHWCFRhQvwkJXj5Z2K8tOAH+g3bqXoymOZq4UIMDnb5/eHmIhdrdUgsHRtwNiQDpIem/lp5WWXwy2/eSBIyMZsj1d6E1iLOAZ3AAkb8YSKTWlDo5FHqOjY2auMYeGKMRCLlmtdZSc4IRbIbaX9UkVc+yyBw6Pe5Bc2mU4nV7IUZeOU+QJ/sRUAoFSvJycDzb0hYaIbAiN5pRPzHmUHOJMQUiA7SNctPNBW3udgqXHd+200K+FctHXSXp/e9pjIc9BG985Xz4Tl94pPWlDJsZNVF019qIt9L4QMS/cQfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBrCA/1h8jNb07xncY4ED95UGoXj68RaTOdlsWCMqy4=;
 b=Mf1HmB55OfS+QAahdLKvKmzyKY+iYiBRaqrQB0my71NXo55qFlUlkyKZD4lx41jX6kXKCbuU3qiHX7whyUcog19l4tKhjCKxz58jmt26DF1aRN6H9W29YoPn8aExUOjUAsbODMpTAsMxZ8c+wHsDsEeFFV5NlEWi9X1yswsPnmO6zsClVQd19hjuDB8Bubh88189eP8cO/0wIYx6WqF6wCNKnvkRXP+7L6kkT0FzUJlj0V9fWerJEBreFN6wKBP2ERRcZSqNDtn9UT4T8nw5eVtARPNf0sey07iieR5E39vpCHUi/gqws1rq74LEzPVkVuUJROnNhp3UsPzjcc5mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBrCA/1h8jNb07xncY4ED95UGoXj68RaTOdlsWCMqy4=;
 b=AkozAAUgF8fwQ1VUc9c8yazZeybKQAOCgiUAy/pF8gQj1mZYZs/LwndFC/tC1exz6o8wgGjbGtqRS2TT2mlNAlShKRqKmsbp+nNd8BK+AYxDXpVp8qRJwXUA5LOq5c2fScwv/A/mCBrlVHmfkr78pWwKmrtvmiRs9RGoslFtgIA=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 07:55:29 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::1e) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Fri,
 30 May 2025 07:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:28 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:26 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: add user queue vm identifier
Date: Fri, 30 May 2025 15:55:03 +0800
Message-ID: <20250530075505.882004-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ff2b08-acf5-4dd3-632c-08dd9f4f583f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JU0rOE3SZeRIWQ19b884zMjuYKo/weQ6VrmmSsriXFpb7Zp/INs5Kh4s4lru?=
 =?us-ascii?Q?AENCSrD1091c/OdMgsQ5ufbVQMxZToTu0D/CR2cZ4KD/hnmzuFFdfcgfzUq1?=
 =?us-ascii?Q?u7tMJK5BeRvL+CCBf4eriv6xc9N6MlsfAP71gc6uG35tr9bGMb6Gnu/IFyqB?=
 =?us-ascii?Q?+3WDFXFzUKOYkx+fzR/rOSmXLkhX2U39tby+WssTCeItF8Tqv4ZLdZ1aWpiW?=
 =?us-ascii?Q?4dOKD/ErFY/di/3JqQdlPROweSYAeyNShV5fQWOFpkKffOjuY89FLZPwcImO?=
 =?us-ascii?Q?i5g9a0edX+ATNl3aIR5S26SN5erKKaF7/WH1TnkuSDqIKEmK/Z5Ca5Bqu5DJ?=
 =?us-ascii?Q?CFrgHn5eefnINtEb1UrK8Ff00QektTVDrBDSBVHs+sBsjxDy2n6JZxStDA8C?=
 =?us-ascii?Q?amU8LZftx8ii4hkodTjD/iGYEHfNvRxvV+BQ12RgplXsx47TDDRwiiAP9I99?=
 =?us-ascii?Q?RjyFPWs5v+y1t+3ph2xBnMr/aRAEt0NNVNjs4tEbCoDlYkmSPVgIqPS6bN8I?=
 =?us-ascii?Q?C0yhajNwHjreqAENSDzpJVm9rMV11hEtot8DNHcMSZR+YjdCjBHaDqRNCevK?=
 =?us-ascii?Q?K+0f1HJFJSKsaqfi9MJstGZ4RN/mURixavc8MJ/HWx7AjUx/sCSLSCZJTemF?=
 =?us-ascii?Q?kK9lJrcpkU/uR3Vg9DJKAinmXXEZVQxDDPNAtLy5rGwXYdSYfAYWOvIctAOY?=
 =?us-ascii?Q?do6BRWbXP3gKIqTyh4FFovsVJ39DhUX527HMXTB7NvQoEbdG9Z5dKArqchRg?=
 =?us-ascii?Q?gq/ie5JDEiFRZe1MIzht3o/8Py6sPOanMoBcKnLK6p6chMCu6YgvxLbap1FI?=
 =?us-ascii?Q?HnPjUoahHtkYMcSR4E+sMoKtSPpiGh+/7aNG7psB2u+THTqSOQIMok1X9VNC?=
 =?us-ascii?Q?ATcZn230PVFKl9rbG8afViD45AnR5bOFBPpthJdeioEaY8kriXv7Zzcazgst?=
 =?us-ascii?Q?XpOpDI2Y/Ejvah7n7piRYaLY+CeV9f2H9+JeBQIzFGeX3Kf8U/m7w9jBWs1q?=
 =?us-ascii?Q?MHe8XimWOq17yZp1Xotaf2nVZjydlPqvvg4DIy8tIKHmLat1ORZ/rmjFK7CL?=
 =?us-ascii?Q?X3JTJor6XMqAbpVQ186rSu1dpSzxcLf++JyM2Zs+aq5uErnM8Ooc42AhUOPI?=
 =?us-ascii?Q?0Lk5OLjFUcRD3hpPgOzxgxLOxr15b0xkdijj9cF3HOlueIimApjLUmrEBTtX?=
 =?us-ascii?Q?J1Pzlb6VJMe/0opLymmxOU/jqIw10Dp/+wwHJszGksW8KgVs8qX5HW0iVDTz?=
 =?us-ascii?Q?7wtIkoYBbWsMNFwYdptmN/xqkK+X7rDy/EorbuWMwwFlV5duN5XKbcnQkqcy?=
 =?us-ascii?Q?vABg6YCQ/ljWjBDQD1BLlxdk+Vnl6lOdzyWoMqBO/GEJn697an/EUgRlc+uE?=
 =?us-ascii?Q?lbb09BiKM/QeFfCQoee4KmqR+f26MBcZPCYk2Iz86VaCDrkgv786h9FX1RBO?=
 =?us-ascii?Q?2Fpf88YBnX0YI4k5OtgO6c21CAEbD/xXnbdUSyfX5TRbjjlmO59xAfVJYYpH?=
 =?us-ascii?Q?cwRCsPl+fhHgDcfOYsFGJqM2xhOejix9wxrP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:28.6761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff2b08-acf5-4dd3-632c-08dd9f4f583f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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

Add a user queue vm identifier for each userqueue
kms opt accessing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6267993deb8c..1c58ddbd654f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -496,6 +496,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
+	fpriv->vm.is_userq_context = false;
+
 	return r;
 }
 
@@ -530,6 +532,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
+	fpriv->vm.is_userq_context = true;
+
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..5e075e8f0ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
-
+	vm->is_userq_context = false;
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..1e3c0f85c98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -422,7 +422,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
-
+	bool			is_userq_context;
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 
-- 
2.34.1

