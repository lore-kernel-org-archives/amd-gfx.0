Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352F7C3ABB2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8E910E7F7;
	Fri, 30 May 2025 07:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YVlfqeYk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5F110E7F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSD3sCtR1uYhBX6TLD1NY9YtLIjjWxSDzMIIyCN061z8Gh7aiR8tM6X0cRgHDkH4q2DLosLOcHfiX+qlpANM8iiQOHBWAnS/lrGCvmSSk/wMZWxUiRFH5L3vDdK97LCuryEBMR27jty7GdmPkdXBQO2/IM3mGkTNrSHb4lMf5Yis7yfICQmbldSalvvykJ8COZdA8ivF/EW4yB30scyrBIxEIpXlJOdq/v472eVUYIwFJKNP3y+FBmoI/cc72dGdrdB3NZeLGBbOsyDTmK5PMULCo2WaqS593aBBm9lXjKqf99E02oBcG4lNwazsY57LWpQeadcNTb2fzR1C1FKiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz4XRip4axyywYIp3hqM9Mk2UVbr2ZAdcJDYQ7bdT60=;
 b=oOgtn4NBPapzcbPzCbAesAfQ2wc1Dc9Rc3edWwzBQH6dibhxIGQPOKxw79AalRyXmamrqIG9siDYyVD2ycXX0dbc+0cB9jUTkNl4/Tu6Xuwx+v7CxTriiORu4UYld8tCPMan+xdxUu8AT7Y5gxgKNMDTbCCCCkeH12rTadOCcHZffDKnD1AbYw5cHjDyUm3FsU2loO8Dy5rMMs+/6Nho5s8eT16ZYaKlwPGnL6ZpzkoKcvs7fztg/QC7zs6P4adPcKgr7BxZA9ZQ8L9YvHpfoQsy17dPMEgBHhgZFOOKQi4dsOx6LlZua3uC8n+BaFbmmlY+1CIE+It/IIr7+8lpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz4XRip4axyywYIp3hqM9Mk2UVbr2ZAdcJDYQ7bdT60=;
 b=YVlfqeYk4/3PK8xQ/8XAIT6Uig4ZO1VJkcHgeQME2bhdPnz17P4IB9BU66dU76oztnjV/AyD7i9ju1V60OWxkRnZ/oZPkxoLShWxh+MDT3gZJiNcoFdzZ3yFkXs7FxmMHzuPjiORggFv7N/d0ysoABLXtydNHeexplF8IPekibs=
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 07:55:31 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::6) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 30 May 2025 07:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:30 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:28 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: add userq va unmap wait helper
Date: Fri, 30 May 2025 15:55:04 +0800
Message-ID: <20250530075505.882004-8-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f69d05c-6fd9-43d9-0c85-08dd9f4f5955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DE35HbqMYVLj1fRehb+VXhDkUUhazYBOn5d6pJr2FVZ5zCi+ee4phAQafyVZ?=
 =?us-ascii?Q?pR1DeD/N3qong3qVAVCoPWr+SxJgd3NFoyu/oUyP5R0LltBNxD+MdqgO3oaf?=
 =?us-ascii?Q?J98jDeFXsNf5Tsc70zBVkhf8E7AZjKCLSg7gC1/uyoLiP/vSk812sztm7+OO?=
 =?us-ascii?Q?IwaH29qmf+WPFzynAXxJvAKBwem531fjzVAz2FyDeGY+mXi6R6VICEV0RDIr?=
 =?us-ascii?Q?Mf2gcS305JQL5Slrbrt/2Ba1BxW1E5+848r7IEeic+hDiYveO3YY4GbHMJzA?=
 =?us-ascii?Q?KEij/TPbiqN7FRi8thy0E7mDwx10ePla/nhnUy76mAXKzpRpvNOI2ldFnG3j?=
 =?us-ascii?Q?raUI0E3Qa+R6j+ZQTXWU1IyY+3DnHeuT3EtHX1EsdtLegRIM1rPwKprSg8or?=
 =?us-ascii?Q?Ztpfp7vFDbLA8iDdfPaslJM3hETgFZyBGY1QEk2JCfY9yUJXphpqZURHN54t?=
 =?us-ascii?Q?LhG/Jp9W0SUkcQXbhRKNSTYAIdxUqkJzkWLxKCVe11EZsJ4KIzT9IVXhCp8X?=
 =?us-ascii?Q?H1P08SiCHUkWdda2qfZe7U3M5RZeC8WFlZ5iI62QPVjXVo+lSXv94WGpQmga?=
 =?us-ascii?Q?Ez14SuNggOinhnJcOxJ9OA8N44stIIeRJMNb/CDQn27C6uxq3Co02xwPtehz?=
 =?us-ascii?Q?+KIeDqwg5Te2X37zQpBuqllRos5MLwv8KUeeAKPWejg++Y2rQaJTzSk8vET5?=
 =?us-ascii?Q?y4sZpCf7RpmJ2I+AUDexP9sgQ5mGrAUK3K4cxeoy4Bhz2PCmymEcqwz5EIW+?=
 =?us-ascii?Q?RAUl6DFkG7ECINdtVOHz7x3nla8WJl1GTGYLKYd4XbJdn1JOWN3xnZUS5JMz?=
 =?us-ascii?Q?oRrBBmVKCkvk2Vh9fgy7vc8I24gCI7RsPX8p7PKx63hxVjRAin44NWf7jXOf?=
 =?us-ascii?Q?qo7P1SKtIsy1UyAnQpgVFZIVtYtlXCnXuWqifdA+ymh+bYsWGYYMM88e4B/6?=
 =?us-ascii?Q?ok/xVWU7ffiQIFypc4p1OcKYg9604uVOFOx5EyTVaBVP5neeaZWlYH9clXaI?=
 =?us-ascii?Q?Fzcf0rVmJe5BUEmJOjF/9BcGMWMQS569UabMcO0fpwAbhY2MfAf9ZVWzgbRS?=
 =?us-ascii?Q?kFsttALQD3MwGY3LR0J4YqFKWDt8RM1Cu2EHFdzh6Ov8bpA6/wLC6XlmfxAp?=
 =?us-ascii?Q?1mTIdOdeUZSx02SzczJkURYV8Lh0aabu7C5Kk83D/+FLaSwzS9SbXnGew1M9?=
 =?us-ascii?Q?IBZHm5i/qU853KtMITARhju/eSuTRD43XLctjqRtZvdyvFwrsH1f5h3jjgyk?=
 =?us-ascii?Q?gN3aJ7Le5bgf2tqv8BpwK4QqutTdMy6CS5t+p7cngdK7x09awiyHpAXL0dtZ?=
 =?us-ascii?Q?I86zAf1WnldmqgCMsyEnMNZMCEu6lPEdnYiHtv8MWTc27DXe2gQwo24ylE/u?=
 =?us-ascii?Q?GcsmVnJJyLCdcLYRN7ThnVc+U+lWHYQF8znIh0cq1P/JbpdlqowsFVgPIjnH?=
 =?us-ascii?Q?Ao2yH807GKL3545e9uEnCmIHmpMuxPzyIzjCvjZ5Y9ifgNEUXzzhhS6czhyo?=
 =?us-ascii?Q?xixjfewqWLSwepXF1xNu0x17W9oFg8l5/3oi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:30.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f69d05c-6fd9-43d9-0c85-08dd9f4f5955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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

This helper can validate the userq whether is ative
prior to the userq VA GEM unmap.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1c58ddbd654f..e43a61f64755 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1152,3 +1152,16 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_gem_va_unmap_wait(struct amdgpu_vm *vm)
+{
+	struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+
+	if (vm->is_userq_context && &fpriv->vm == vm) {
+		dev_dbg(uq_mgr->adev->dev, "try to unmap an userq by gem va ioctl\n");
+		return amdgpu_userq_wait_for_signal(uq_mgr);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 65f9bd91ac73..ea1b631331c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,7 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
@@ -145,4 +146,5 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_wait(struct amdgpu_vm *vm);
 #endif
-- 
2.34.1

