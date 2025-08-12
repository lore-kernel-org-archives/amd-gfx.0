Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D230C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 08:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A81310E5BE;
	Tue, 12 Aug 2025 08:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ty2I3vmC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC8110E5BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 08:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0DQ7mprabuY4bjkof92qdQ2YM0dV9bpIXFyo3v0ytDrwMt7UplshB7Y8gin+rweqUm0OPoAvOQ0L6/cjNGvAapXkyZ45+dKSHHN8plI9iaDQxM8w2rUqVL7Xr+TgC0C038r8a9nEfzWv+hwO33lAHvegHWctnlyAgAJXvCNpK+eyW3MS2fGOROFASef4MVPrXbY7n2VealV+YTY3aAR/W0sZJ8vvInu9V2ftuIo16uX27dAagMZCFRj5dDhZ33BzluySTWrRklixnWRPkd/whk4u+UAt3l4EmpoWjv491X8hUlmafQiF4xWVcupJr4fs1xQrf1SFCESlHEv09uO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5DTQ+SQ/Jrm7ys3VYSCG5sy6QJVeiZxLf7wHTFVVDs=;
 b=VaQQKUOgXJFbH7dafPGr8BCxbKEAq1qBN+/kFbDrmQc5dUTzY3z3A9oSAmr6WDjfX4iKmOwWWm/LwPMuQKkwPRW/Dop1jfpqtf83J04ZOesqFmQQdt9rZ/a4TbQrtJO1DbYQstCdhIYDiU2dxZRnV/UBrQWwaBiLs/CsN82ISep35q7H/0cwenq1x7RgaACI0kllcjQHgMiVPz+e0NyM2KLPCtoyOAiS8YYk3gweOr4zhNRmz6OU2m9NRGSiJj5/ZVMP267Siqa9e2VD73sglIoPOW+3BNZmU1eNKPIs+/V+iDv5QfWg1bli1zmYAxoBujsCxt89xCvOe2zRfAPXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5DTQ+SQ/Jrm7ys3VYSCG5sy6QJVeiZxLf7wHTFVVDs=;
 b=Ty2I3vmCJu5FJwzUPeAUKEErYxwuCzSUo7bN4qPq/8gEOegMA2YxbcMRGPJG7DSwMkwomfjK5dwyXVh5O9ZmgE+yVhbVv/VLGHPwMak8D+ehiUtSEXquvfZFdFdcnrns6ei6JdqkQqFtfRtOjKB8ewlcn1ARvBNdm37G1YJAVhk=
Received: from MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 08:31:35 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::5) by MN2PR10CA0009.outlook.office365.com
 (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 08:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 08:31:35 +0000
Received: from amd-SYS-esther.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 03:31:33 -0500
From: Liu01 Tong <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <gang.ba@amd.com>, Liu01 Tong
 <Tong.Liu01@amd.com>, "Lin . Cao" <lincao12@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix task hang from failed job submission
 during process kill
Date: Tue, 12 Aug 2025 16:31:16 +0800
Message-ID: <20250812083116.4091828-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e43356-f7e9-4657-dbe6-08ddd97aa61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vgMcdzNJt19ZsI6ACG64PsJisHA9atEZn2bp5XgwVj/0qeX0SM0qNX+HeSkP?=
 =?us-ascii?Q?zdfM/DPAt6WvvTl89wjkYrnWUJ32uWJdiHWhG55Vn2/AdfH3TlQwqERfhQcN?=
 =?us-ascii?Q?cBJ+1WmJy4e6SkZINNk63pEQPD08L8+ovEzk78ijOCUsPGqmjPi/H6lixhIq?=
 =?us-ascii?Q?RDDS5fP8ZHXtz7CdiYhOXE5kW02TTbJ0kplbaptJozXkntS6cMOK65hMsE4N?=
 =?us-ascii?Q?E3F9QE021h6ymuLyX17t40pCa5nQXiqGiQkq8PGvHafBudE4Q2y7rp0ZJ+48?=
 =?us-ascii?Q?c0rvCKBBMqT0tp1eNmWNewYckMNUUQW2PPDoH26PY8ES1qmRW/HrdDpfnMJz?=
 =?us-ascii?Q?dyS4Nhea7PtP47v5BF8F2EdIkh2nBWjJ4I+FOx7cYpnQiW+EaL7E404mpcjO?=
 =?us-ascii?Q?RR5UH6AYPEFmpCxtItwoNYJkCky6Pd4CdPRMwDhsR8CEzjX/VbLfQNyMDdx5?=
 =?us-ascii?Q?6RTfaF403jrI1FdQpAmVJMrP252S3CaHTpXXdbwbTxEaSgWMbYSuZCEv36Ly?=
 =?us-ascii?Q?cR+S8jo6H5xtU39YJlTFotOInaU9Pvq9/Kuwa2HsCpQeP7Gn//beSXYNw0vo?=
 =?us-ascii?Q?fIBW/W2gPmtcLBHaP0IuTk5Fx58h25m3/l4hHpksKq3xgLqHGAP20DrgSIg0?=
 =?us-ascii?Q?IH8FIuklUjiWJa9CId09MGNBFXcwpOgu/g7RFc26qsMQ3V1eliBSpcKfq5/L?=
 =?us-ascii?Q?MZS4Fsq1Yqw73Xml2Epw3uSBtBWE3bme745TwAdEuwDHNbkeh11J92lnjQZO?=
 =?us-ascii?Q?uL+4SDGv3gP1RxtMUphSTK0bb6sXPWdA+2FNbR9sPyNcrQ5pa7hC42ti8sXO?=
 =?us-ascii?Q?gkTXUFnslOLwuiaZJ6GTUVkqMvhVDa4r9/Ok+zvxDYMzTQODKuLVo6APrEyW?=
 =?us-ascii?Q?kW8n2cylcjWvgf3D9mrVKdvU4/IrxOp4Za29A687GfwEOL0yxTLAe9qL3EpK?=
 =?us-ascii?Q?0p/aCo2yB7hc8oQt20XZloiDr2pKqHoPGT0K1qHOHNzn+l/pI4cy5nxYPbRJ?=
 =?us-ascii?Q?NdxW9xSY6IjeIbTMHx8dPB0gHIKsIP07/2d+4oVRc9sQdD8s8Z92/xYIS0M/?=
 =?us-ascii?Q?XomOZd+AJoQDaE7gCp0IxEqvSChtnGibE9Xet4XnhRR2bP7yBQU6CCsHlUbc?=
 =?us-ascii?Q?F64XcjuTl6+mpgd6m8kGkk1bKRUyFSJrDWTlSw43kmoW9gFrzGPyaahaH8SH?=
 =?us-ascii?Q?WinSOW8HO3/OeHpNUbHujmfkQPpYXWvIBHm+u+ndvF1753//zVHTMYxal0v0?=
 =?us-ascii?Q?qGC2v6TaAY4hseSgQii5sTPXpY01e1xi7zV3+n/9f3Fvs6SX07749l6grd09?=
 =?us-ascii?Q?8/+k42OUTAVX1ymLO6DLTXDSgPKre9Gjc6+aeX1S+bDdUA+/z9w6qnzqWtnU?=
 =?us-ascii?Q?/gZexiqS5jE9ji4mEjZUd3KGT4Z62iP2CVa0PP49RrwF8odCe0TpC5swEYNA?=
 =?us-ascii?Q?VFUPeM/7ulUcsuv4jPN7Yo658P50EXM/AzDCglBK6cPjRGfOV66QjlLaqlef?=
 =?us-ascii?Q?ul7Rtuc4xLlcuzyYrhxPf2Q5GENpDI9UO+uN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:31:35.2259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e43356-f7e9-4657-dbe6-08ddd97aa61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478
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

During process kill, drm_sched_entity_flush() will kill the vm
entities. The following job submissions of this process will fail, and
the resources of these jobs have not been released, nor have the fences
been signalled, causing tasks to hang and timeout.

Fix by check entity status in amdgpu_vm_ready() and avoid submit jobs to
stopped entity.

v2: add amdgpu_vm_ready() check before amdgpu_vm_clear_freed() in
function amdgpu_cs_vm_handling().

Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e1e48e6f1f35..cdc02860011c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1138,6 +1138,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		}
 	}
 
+	if (!amdgpu_vm_ready(vm))
+		return -EINVAL;
+
 	r = amdgpu_vm_clear_freed(adev, vm, NULL);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 283dd44f04b0..bf42246a3db2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -654,11 +654,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * Check if all VM PDs/PTs are ready for updates
  *
  * Returns:
- * True if VM is not evicting.
+ * True if VM is not evicting and all VM entities are not stopped
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
-	bool empty;
 	bool ret;
 
 	amdgpu_vm_eviction_lock(vm);
@@ -666,10 +665,18 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	amdgpu_vm_eviction_unlock(vm);
 
 	spin_lock(&vm->status_lock);
-	empty = list_empty(&vm->evicted);
+	ret &= list_empty(&vm->evicted);
 	spin_unlock(&vm->status_lock);
 
-	return ret && empty;
+	spin_lock(&vm->immediate.lock);
+	ret &= !vm->immediate.stopped;
+	spin_unlock(&vm->immediate.lock);
+
+	spin_lock(&vm->delayed.lock);
+	ret &= !vm->delayed.stopped;
+	spin_unlock(&vm->delayed.lock);
+
+	return ret;
 }
 
 /**
-- 
2.34.1

