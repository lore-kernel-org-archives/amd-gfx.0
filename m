Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98928CA5FE4
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 04:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BD910E73C;
	Sat,  3 Oct 2026 04:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12NpTyXi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3FA10E73C
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 04:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPc5bXAnekWQFALw1cdNXQjAFj7oN7hUyWXCDRe4ncpg/aCzKRu/V+jiBPz5eJsqr7O5x6cIGgdAOJOgcQB7Vn2goCN0Ps1swv0KP59vdcfsyDT8Y/gaAa4B8fL7WqIhqvPOfKcG+jqVbJMG4w3yHjMj27qlEh+2R/kElbNkDjLAPL10dJOqrRgBJ9mUSkaGS5N1hg+Xtf/xeovWMuyTIAfET4h1+PhEtn/i+A2PFEhQPEtAsq5yCpkAfYzJwqcNwLO/Mdm1oqF70FBUSmDaXG7gECJra3lxcWry2VX8TW8SNbldaQFH4YKZlFea/yyPeyA0rciSSPzMbj7bFP4wgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/xIyaR1OQ90hYSmGZJFWfQJiiLDzUVYnmxtgoxykzg=;
 b=CXRA5L377kadSRmd79JX68c3OQkp9MwNqJoY19qMoijV/jaR5+aWluING0s3g/52lwz99vXlKcAeN94iZLqHtvaPswjN8uWYCRjRevkwVSZeyZPZjas6xbm22qXT9thL0AQz3Ft/MwPwHiUkiC3WVpxb8A1Oh+zXzSamQf4FrEM/bVHj8MKPPd9hYeWO6UVxcqb9KjFvEeaov12Hp942mHroxPjMsfO6xpVXSsOoH9Q/mo/JDCoZSl3fukO32cmuO4DwE5BvVnOE4pfudqp8HKL2KRZ4rPI5SK0g7+MQ46vQo33k+rGa0sDFJelIslqAVapWnIhSnFezDvLJ6XyFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/xIyaR1OQ90hYSmGZJFWfQJiiLDzUVYnmxtgoxykzg=;
 b=12NpTyXiyVaUmLn3POxiPi3tKcxmyd/LWsFhjPWIoD0YTZyVCjQDpER7mDv1RC2DcbTN+BvhlSNZUkMmsldAzDW9llrXCZTmKngdInyUfZwc5M2feLjophj9WDRm3exdqCGmlF4c7u6wuHSca3+Vpj//EIEVtLD1iIfwO8zFAH4=
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Sat, 3 Oct
 2026 04:40:28 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1a) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Sat, 3
 Oct 2026 04:40:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sat, 3 Oct 2026 04:40:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 23:40:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Sat, 3 Oct 2026 10:09:53 +0530
Message-ID: <20261003043953.936202-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
References: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 722a8c37-1ad2-482d-4405-08df21087359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: pMNh9BgQ1OEjheV/3Ly28R72hjziwMg9i1pe0NMIgWOTGEE1vBbDmr+pmG9gyKscKbA+UTenHZGTkDPW60W2rICaBPV551kwp1UOzbk/NEKWpJ7BxGjfngwk2D+ZDimRiBguZwH+QzbxBi5NViXrKOpI4ISf05sFuPeSGhVsFCiL6rzHAjcGBMuvkMytf85ngFJzcKjPOZtLP5+2mxqrN+UjALKiVNsQM9iNylURUx05Hf0nhJNIh0li0lp4K4wdVOMZpTPLHJm53HbRs9vUojzOygIQgVoBp93X4T1Mi0wrYKFwz5VeJg1yRjvh72ueHvG6zFXwKpSkuln2lVZiLadUbXoG61gjJAN0oTG/16FBVJ40e2sFBajZK+oARs9RlSztqae4yZV2jwkRxBOZEWKq+pU7u7enjcHO+EM87J2DaSwJknNunCSXeZsFJAWkQupKCgYWxEEj42ODZZRmwdVcOXbohP18fwrQiOhh/XtmeI8i2YYedn4bMl+IlwtT40Qnw9zX1GMi/fqlvgbH4VMRjQ0Lu0hT7BXd1bMvbxoOL4teFk7yTvWMO+sdKVrLaCZTKJoztH4J9D4XQj6/ksuptuBLYSE90r7ka7cl93WU1hrx3pmO7srV0SGdlnQJp69rck0dgcLrTDiK2wLKOM06R7LFMVrOcah9esfVkm+y31uZdEEwEph+uOKK5YWi9WOrhqgVPg1lStyXXDOUJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pYuvzk/qn6pWdLrDStXhXoMXz+EgK9clli9cnE21eak7nvYK8TDou8OeTJPay1atZK7aEEV3Ghd0Ydt/JE0EvyBzAH2RyY8kJhxtY75NKa/c67PUVoL/+JUlvln1i2MIVXWnsBHtlVdqTO5x20Q2+a+Qk/RMAri5oINyX2njQ8qedAiKLmRksYInaNFTJCE9aNo8dpFa8b59rLwmsPLWRN/+ngSv0igTFwDs1Kpj6B8CWpuoXcOswTdWX+Hs0dZ4Oa6t5oUaqJYbEyJ0zdvXY9SB7IenbMt0QKlWzrmvQMfSwpblgyYzWYIYQySw8oinTvWnjbz3E4OxMV3nPxO73uYALNrCY7hLYAVR/fQSi9mreUgDNtd8FudRZ24jYxZoGHTDZzftbjsPeqAD5LA+L8d3Pptcx1RLVwc82zq2vXd6O1KxPC7Z/lPFpiFSdf8n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 04:40:28.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722a8c37-1ad2-482d-4405-08df21087359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

Add SET_L2_TRAP and CLEAR_L2_TRAP operations to the VM ioctl.

The second-level trap handler is set per GPUVM. All shader waves using
the same GPUVM use the same second-level trap handler, regardless of the
queue type.

SET_L2_TRAP sets the userspace TBA and TMA addresses for the GPUVM. The
kernel checks that both address ranges are mapped in the GPUVM before
using them.

CLEAR_L2_TRAP clears the second-level TBA and TMA addresses from the
first-level trap descriptor.

Userspace must keep the TBA and TMA mappings valid after SET_L2_TRAP.
The mappings can be removed after CLEAR_L2_TRAP completes successfully.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
Changes in v3:
- Remove the old TRAP UAPI cleanup from this patch because it is now
  done completely in patch 1.
- Remove the explicit user queue evict/restore flow from SET/CLEAR.
- Use the existing GPUVM fence and VM root synchronization.
- Validate reserved VM ioctl input fields.
- Require unused L2 trap input fields to be zero for CLEAR.
- Document that userspace must keep the TBA and TMA mappings valid until
  CLEAR_L2_TRAP completes successfully.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 29 ++++++++++++
 include/uapi/drm/amdgpu_drm.h          | 65 ++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fe1289abb56c..3c551fe8c9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2917,6 +2917,13 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (args->in.flags)
 		return -EINVAL;
 
+	if (args->in.op == AMDGPU_VM_OP_SET_L2_TRAP) {
+		if (args->in.l2trap._pad || args->in.l2trap._pad2)
+			return -EINVAL;
+	} else if (memchr_inv(args->in._pad, 0, sizeof(args->in._pad))) {
+		return -EINVAL;
+	}
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
@@ -2924,6 +2931,28 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
+	case AMDGPU_VM_OP_SET_L2_TRAP:
+		/*
+		 * Install or replace the per-VM second-level trap handler.
+		 * Applies to all shader waves using this GPUVM regardless of
+		 * queue type.
+		 */
+		if (!vm->trap_obj)
+			return -EOPNOTSUPP;
+
+		return amdgpu_trap_vm_set_l2_trap(adev, vm,
+						 vm->trap_obj,
+						 args->in.l2trap.tba_va,
+						 args->in.l2trap.tba_sz,
+						 args->in.l2trap.tma_va,
+						 args->in.l2trap.tma_sz);
+	case AMDGPU_VM_OP_CLEAR_L2_TRAP:
+		/* Disable the per-VM second-level trap handler. */
+		if (!vm->trap_obj)
+			return -EOPNOTSUPP;
+
+		return amdgpu_trap_vm_clear_l2_trap(adev, vm,
+						   vm->trap_obj);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 86f957d07f4c..020edbbb01d6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -644,10 +644,75 @@ struct drm_amdgpu_userq_wait {
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
 
+/**
+ * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
+ * handler for this GPUVM.
+ *
+ * The second-level trap handler is a per-GPUVM setting. All shader waves
+ * using this GPUVM use the same handler regardless of queue type.
+ *
+ * TBA is the GPU virtual address of the second-level trap handler code.
+ * TMA is the GPU virtual address of the second-level trap handler scratch
+ * memory. Both ranges must be non-empty and fully mapped in this GPUVM.
+ *
+ * This operation may block until outstanding GPUVM work completes.
+ *
+ * Userspace must keep the TBA and TMA mappings valid while the second-level
+ * trap handler is installed.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if TBA/TMA is invalid or not mapped in this GPUVM;
+ *  -ETIMEDOUT    if outstanding GPUVM work does not complete;
+ *  negative errno if the GPUVM reservation fails.
+ */
+#define AMDGPU_VM_OP_SET_L2_TRAP	3
+
+/**
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
+ *
+ * This operation may block until outstanding GPUVM work completes.
+ *
+ * The l2trap input members must be zero for this operation.
+ *
+ * After this operation succeeds, userspace may remove the second-level
+ * TBA and TMA mappings.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if the GPUVM trap state is invalid;
+ *  -ETIMEDOUT    if outstanding GPUVM work does not complete;
+ *  negative errno if the GPUVM reservation fails.
+ */
+#define AMDGPU_VM_OP_CLEAR_L2_TRAP	4
+
 struct drm_amdgpu_vm_in {
 	/** AMDGPU_VM_OP_* */
 	__u32	op;
 	__u32	flags;
+	union {
+		struct {
+			/** GPU VA of second-level trap handler code buffer */
+			__u64 tba_va;
+			/** TBA buffer size in bytes */
+			__u32 tba_sz;
+			/** Explicit padding; tma_va starts at offset 24 */
+			__u32 _pad;
+			/** GPU VA of second-level trap handler scratch buffer */
+			__u64 tma_va;
+			/** TMA buffer size in bytes */
+			__u32 tma_sz;
+			/** Padding to fix total union size at 32 bytes */
+			__u32 _pad2;
+		} l2trap;
+		/**
+		 * Padding; keeps the union at a fixed 32-byte size for
+		 * future ops. Zero-initialise for RESERVE/UNRESERVE_VMID.
+		 */
+		__u64 _pad[4];
+	};
 };
 
 struct drm_amdgpu_vm_out {
-- 
2.34.1

