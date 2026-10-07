Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B8ACA5FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313CA10EE8A;
	Wed,  7 Oct 2026 11:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0oitOlK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C37E10EE8A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX40jn4IOkUD0RGE29HE5BoZhVy4v/Xn2Ggz9XNyWUXUYzU3Fa6u+Cnw4Mqyo27NUISLiML5Kin0gK9n4FfUsX1DBKeGt8RFa0NuvYO0d/IcQs9wgqMiiwQS2vxjhEf8I5n9wvU4fGkZcSFXA3/zZW9BX+0iiahn7lF4Tq1DmAD/b3BtMZcnAO6I/cuv/huvGwJBh4x3Tu83zEoOW01uafziHHRvlzURcpk6irhLk+TAt4Iw5nvZu7xWyoN3sun4KYgoZcrWTdf6xJk9IIsb8f4WfK7pm/Xz/61PEtGTTPpbORog+dn/mBx9Wp8TrXlllxa5KM+ItIKGaUI4HNy7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhFRTH7lUAWBOah1O7L7NiRtmGRf6SFP8oKvcJTQ/+g=;
 b=IoQAm4lo7WrExqfmSyoNmA0X6Nkajk/xzQTaLyIQWnAxkFN6E3Yg4wUcxMNqeFcKc3qoy1PiWiUD3ZV/DVKFem1Pxp0iqY4VKxULzqRD+/5w61NVTxsaooa8NRzal8LvIleuASobyI1uqG57KUVE0VbBeOnQWS2apYvlJl8bwgS/2lDsIxOZh/9lbiowxhzrSMMChziDTNWysKjpINhCIBiVZmOvP2e79W0prgcej8d6q1syECtMQRxwGq6XyqCTb4hECtJsVte7Cz3/ioCYUkFrNE+r/aSg9lBIVTTkv0UrYKJGGLD5jMwgostJe4AliaXgHecNxGkJhK1S7Pthcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhFRTH7lUAWBOah1O7L7NiRtmGRf6SFP8oKvcJTQ/+g=;
 b=U0oitOlK+lFN06mBXtUBpUKvSOjBudXzXJ7aEE0tR0RuTP9Zr6vJo9nBGvZaVMv5G/Hlme7HLoSDIqL5d9vFdBfXyMd7MmFkouuZme1lvu2ksLpX5vGS4O8d5DRWID2o7Xrwax7kdZGMu4Z+0uiQvh+28IZ+l/cebD/KTG/057A=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by SA5PPF634736581.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:05:37 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::3e) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Wed, 7
 Oct 2026 11:05:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: Add ioctl to set level2 handler
Date: Wed, 7 Oct 2026 16:35:04 +0530
Message-ID: <20261007110506.1065076-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0bf867-4e3f-45f2-a5e0-08df2462ea5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|260925021311599003|260925021911599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: WH+yoHsYL+EIkMvpsdy4lCJovihQFHCrLTZOjHeNu2S2CuCZsf2SML2br2jyJ/kTzoERAlHn6e55c9p08rdGTgOkcHGrhenBLXJqTpHMwtzlKS7xaqSLzLzUd8SDr4cz2EGP+dsLCAu1J6XdPL1kaNFOi6m0Ag74Td8zcZbSByOAHqWchUo7AmEOsQOHOVAyPsPjjBEVHsiL8bMZthU72eec8fh1IEhwSrNYKpgWg/zBHXZ6DQKPgB20OPe1rM0enV6PkSiz+M66KuU5g6G4kgNhMgIGnyXslv7aT9MSGQAFdOlLL0PFhUykOpirwAfo+24JrJ7OmivbkBQQoiM2P/IhntqQYLpfqFyEYaQwiTR6UA7Hfq8turhkMRfFzarTgw0i/gkZrQcV+LsApXaihtrcHfDsUs6OFOFxl5C0NVA+kY/3ZRix/VDrXPWNO9hz73VyFBuZOjZj4UJUyD0+Y78XtbMDOs79skChbDkclrYSjSchi+yxvMfgsiPWdH7Z733M4pf2kOnTw/JGCPcsaRv5Kdj2ZEkBU1t0ADCBoQEXSq194LWabGdZPn55z24hbdjreswMGPTXZFW/UM47CMeDdGtTxpRS6TNXGxySguGt6+h+Rs7QexcYGXGS8EeqBVt3uTfVxCoyw4VkM3Fs6v81JBrXoiv4t1/MotY+Xd/SuftXMj41aDocivxE8inLvWs15gGdiTgJumOs9jOoOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 19lBaf9JVSHwdYi4PDrZ/O2ZMtscHqtS7I5puvW2ElkzKdzGehX/c4cDyL/yfbnkQ4RUh0YMh+YDB43u/amiH28z13Bzn+Bqu34AUMrs8jFeh2cdeukTulMANYB6iFjf4QDbz6KdbPTVtCLchvGJmHe9tVd0H6bwrgajnmaEpYx8weNPaoNm+zet1u9zh/3xzIGb1INcruMmo0vjBob+EK197mjqohGe/L68fkzTMrQf/y/ae5S7q9O6dOoT2gLUO4ZLTrZ+OfjCVrjSu4Zky8ObkqXRTCdf4i5cBHT8DfAY25aNGcoekrHmCsXAr8QoySAC2UCzqsdII5/XWc2spMghtt/AXAD3zmrq7M9ndqLWGfbOND9I8ouo5McrRD/66myZ0LockNVHG2T2mCDGw7LsDv+eXOI8YSRJYOYUfeCJjKQCtf13pFmnyb73f5cQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:36.6706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0bf867-4e3f-45f2-a5e0-08df2462ea5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add ioctl to set tba/tma of level2 trap handler

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I6e3d326b6772e1e6ca4355ce82743e1714449713
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 105 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 include/uapi/drm/amdgpu_drm.h            |  23 +++++
 4 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 6b6c11bb5fd7..1db74e1fc97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -532,3 +532,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	kfree(*trap_obj);
 	*trap_obj = NULL;
 }
+
+static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
+					  struct amdgpu_vm *vm,
+					  struct amdgpu_cwsr_usr_addr *usr_addr)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	uint64_t addr;
+	uint32_t size;
+	int r;
+
+	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!va_map) {
+		r = -EINVAL;
+		goto err;
+	}
+	/* validate whether resident in the VM mapping range */
+	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+	r = -EINVAL;
+err:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+static int amdgpu_cwsr_set_l2_trap_handler(
+	struct amdgpu_device *adev, struct amdgpu_vm *vm,
+	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
+	struct amdgpu_cwsr_usr_addr *tba)
+{
+	uint64_t *l1tma;
+	int r;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+		return -EINVAL;
+	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
+	if (r)
+		return r;
+	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
+	if (r)
+		return r;
+
+	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
+	l1tma[0] = tma->addr;
+	l1tma[1] = tba->addr;
+
+	return 0;
+}
+
+/*
+ * Userspace cwsr related ioctl
+ */
+/**
+ * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
+ *
+ * @dev: drm device pointer
+ * @data: request object
+ * @filp: drm filp
+ *
+ * This function is used to perform cwsr and trap handler related operations
+ * Returns 0 on success, error code on failure.
+ */
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	union drm_amdgpu_cwsr *cwsr = data;
+	struct amdgpu_fpriv *fpriv;
+	int r;
+
+	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+
+	if (!fpriv->cwsr_trap)
+		return -EOPNOTSUPP;
+
+	switch (cwsr->in.op) {
+	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
+		struct amdgpu_cwsr_usr_addr tba;
+		struct amdgpu_cwsr_usr_addr tma;
+
+		tba.addr = cwsr->in.l2trap.tba_va;
+		tba.size = cwsr->in.l2trap.tba_sz;
+		tma.addr = cwsr->in.l2trap.tma_va;
+		tma.size = cwsr->in.l2trap.tma_sz;
+		r = amdgpu_cwsr_set_l2_trap_handler(
+			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
+	} break;
+	default:
+		return -EINVAL;
+	}
+
+	return r;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 5717e1d662fc..2cf485111e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -31,7 +31,7 @@ struct amdgpu_device;
 struct amdgpu_vm;
 
 /**
- * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
  * @bo: Buffer object for CWSR area
  * @bo_va: Buffer object virtual address mapping
  */
@@ -62,6 +62,11 @@ struct amdgpu_cwsr_params {
 	uint32_t cwsr_sz;
 };
 
+struct amdgpu_cwsr_usr_addr {
+	uint64_t addr;
+	uint32_t size;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -84,4 +89,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
 
 	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
 }
+
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *filp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b2a8a8b37006..7a2b97d9f51a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -52,6 +52,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_cwsr.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 #include "amdgpu_ualink.h"
@@ -3122,6 +3123,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9317018330ec..eed8a7f7e88b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_UALINK_HANDLE	0x1B
+#define DRM_AMDGPU_CWSR			0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
+#define DRM_IOCTL_AMDGPU_CWSR		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
 
 /**
  * DOC: memory domains
@@ -1695,6 +1697,27 @@ struct drm_amdgpu_info_cwsr {
 	__u32 min_save_area_size;
 };
 
+/* cwsr ioctl */
+#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
+
+struct drm_amdgpu_cwsr_in {
+	/* AMDGPU_CWSR_OP_* */
+	__u32 op;
+	struct {
+		/* Level 2 trap handler base address */
+		__u64 tba_va;
+		/* Level 2 trap handler buffer size (in bytes) */
+		__u32 tba_sz;
+		/* Level 2 trap memory buffer address */
+		__u64 tma_va;
+		/* Level 2 trap memory buffer size (in bytes) */
+		__u32 tma_sz;
+	} l2trap;
+};
+
+union drm_amdgpu_cwsr {
+	struct drm_amdgpu_cwsr_in in;
+};
 /*
  * Supported GPU families
  */
-- 
2.34.1

