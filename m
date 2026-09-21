Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58752C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60A010E986;
	Mon, 21 Sep 2026 20:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cA5KeVuX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9358910E91B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbkVz1VDJ/0xPDA+YsKT076K39/pH+1Or0NYNqyCNIs8pwoEOR9HNKL9BSniqBeIaewTBrSk8ytRpO9QC2CnVeScBxhUEmBo8Ks7MRYfQqGrrBCT9u1+cx0dHABLGIMHgM/+cvO4a9UodKQvZJ4nRITZGxSemd05UvrYhFELpoovsCA6coNplgsrPwMKc9wGr3eH/DNhRX8MEsy9KIt/idXCJFzX9KyEAt11pJskn2/W35pM/N1nUhSTnEnhwhUDre56t5oe7SjM5S66PKzIwAlsBzihyhAEGvGDLp6G2F2vbK8DOPwbJB3KI4kQWse83RqlxKByhfcNhYOm/92qgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4U7rrjlSwyf+vx9TuHfVcd/p5EIEEcPJPsI3YmlGuM=;
 b=khQn/HKKWE3MrU/VRR2dzCExTEeFh5VYsHya3qF7ggclRPibqDVsMryAT74SGzrsIfSKMDLNjsOB+cLzPnzhBtVLb7uvkzQOATUwQISnI44ybTGyZvL3M2alaZJ7ucUJbqpLaV4mdCC7eGn7q1+Fn1ygIGCzN17GuB6Buw7xY9VbWB8ytozFHNdSxKRpfzIa4/GfAwx7ZmCXYAnHZbVNq5Cz7UOEFzEAxpWS0aw4OQgm9XdDoamLDG4R2XgS2MAU5WiGLfucKPPLgIhXYz+zwyVKQMJxZ9uZLclJcvOIuTL9HtVfrz5Bd6qnFiCQ1uRW+xDA5IZcHmdQgrJIzVZ44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4U7rrjlSwyf+vx9TuHfVcd/p5EIEEcPJPsI3YmlGuM=;
 b=cA5KeVuXBqFKOAq4gLOjRfJ4+++/NpD9zz//3/M+MCCUC1DbYNkpU2bcaTmCHCmGH76Y82CCCktTt0iZ19gE5weQGcoMycxsDg2csiCkdHssOYfaAmncOrZUYfpCG8EaYstZlfxjPPO9Jt9lrN2aSeCyVYxDyorCewfoO3S2gZw=
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:21 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::94) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:20 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:19 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 02/12] drm/amdgpu: Add profiler UAPI infrastructure
Date: Mon, 21 Sep 2026 16:03:03 -0400
Message-ID: <20260921200313.865829-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: b93c10f4-eb2b-4336-dde0-08df181b6270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|22082099003|18002099003|5023799004|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: EHIy5BlnnW4mKFh38UWvFXgN06X/O13Hs1+FOSCjUL8z9ufaoHkrEbiRx5RcVwSqgvbeqo+556JhVbbu8Y0xGkRMiKHybH5tgJ0ht7N7gMJ1r2O/Mb8neky7LKLd0oij/Cb09ppq5H3NtCn3TEk3xn6D66x4KZ8QSvRvctL78uDDc7hChy/8aH+4DKVHq+wYL+YOa4YB2Id6bDzlMQun+ZcwyCGe10Ctju0yEuolYriDq5o3O/9f2wKARNCA5uksmYfDEtwgVEZrHp6VS2y+12AmOF65YBv8rlkfVJ64Pv4VNqWZIKASX/ECIc0/M4kCQy3e/KoiEOEGUeylhSGb+2UTYeOC/KEz22DOv7r7W6yQzEgvoFn3qvTElduE+OwInZyO3fYc7y38ChoswW4A1101ALRcVWs22cfibuqS7t//7F70xYl/Hw3DHCiKZkY/J0Sb4MkPdibTEJa9I/cMaUsUFqXYteqW2UkEJWSF6AFQW+ht5vx9MLwDrkwzssqkPGEsd2USbz9jYWTyKPB+ctk/+Oxk+oXwlAQTGO8EFm9Tj+CYB7RwITW8qbqnNOCsPgAFxVxOK/p5YCFdqWJaNvKiEJYL+OWOxeRD0JcGUq09U1DLvgh84j94yqX0x20R8rfT+zLtHUMkrcRQUzbtlFK+8YRC3YFDFmrXVWyVk686LRWFdpNUk8fJ9Mp6kBqt3eD4JvlnmvlJMUEy1EvgRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFsIuxPIGd93nvT4/umBPDE8stQgKSKfeYr/cWxg4PG+p38WmoUz/P0HrDEphXUDcuzfTTKNKj7W9nudyfav5329Gel0jRJEW76iMrD+VK9JHyuAClXUdotpdKGRV3KXzrZD1giN8NqJbjqU0yryPErQMVHZBjQuTuaEMRP5TuMTa5Q7xAFhd3eC2o4Ss845QXmepE8kNpllD8zgqGZy319RbBtj3fTdgzJn+cXFjA7hHcBIge1nDQAsSgq9UuNV76j387Dsbt9id2/pqMWIinWeblMd/Zz73eQdorAy1RdRIsDtC2gv2LTVCFITQgXLgXpQS7DqP5f2VtjZx3jjB0LZ0/beghIVwnbQHhd47ycTpfG++SZdwthkDQxyyjBT6RxvHpFAfp5+IF2HUspWRUOd/W3XXSCKmTOcggf1bgBAZYPErC01vjpmm/EAO3lB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:20.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93c10f4-eb2b-4336-dde0-08df181b6270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

Add the DRM_AMDGPU_PROFILER ioctl handler and its manager, the base for
GPU performance monitoring features such as SPM (Stream Performance
Monitor).

The manager is per-XCP (eXtended Compute Partition) and refcounted, so
several clients can share a partition. Clients with no partition assigned
are rejected on a partitioned device, to keep partition 0's counters
isolated. Teardown is split into a prepare/fini pair so that in-flight
ioctls are drained across drm_dev_unplug().

The ioctl is not registered in amdgpu_ioctls_kms[] and the SPM operations
return -EOPNOTSUPP. Both land later in this series, so the UAPI only
becomes reachable once it is fully implemented.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 303 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  92 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      |  98 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  43 +++
 9 files changed, 575 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ec199715ee76..b17d8f7b4e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_trap.o amdgpu_events.o
+	amdgpu_wb.o amdgpu_trap.o amdgpu_events.o amdgpu_profiler.o amdgpu_spm.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3763c197138..244215320916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -110,6 +110,7 @@
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_profiler.h"
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
@@ -424,6 +425,11 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+	/** Profiler XCP manager this fd holds a reference on, latched by
+	 *  amdgpu_profiler_mgr_init(). NULL if no reference was taken, which
+	 *  gates the matching release and the profiler ioctl.
+	 */
+	struct amdgpu_profiler_xcp_mgr	*prof_xcp_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
@@ -960,6 +966,8 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	struct amdgpu_profiler_mgr      prof_mgr;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 380989f4c965..a4703bc28359 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3686,6 +3686,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
+	amdgpu_profiler_device_init(adev);
 
 	spin_lock_init(&adev->irq.lock);
 
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->pci_state);
 	kfree(adev->pcie_reset_ctx.swds_pcistate);
 	kfree(adev->pcie_reset_ctx.swus_pcistate);
+
+	amdgpu_profiler_device_sw_fini(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a93ee106ab92..03bbf101bf23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2556,9 +2556,25 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	amdgpu_ras_eeprom_check_and_recover(adev);
+	/*
+	 * Signal profiler teardown and wake any blocked SPM waiters so their
+	 * ioctls can exit. This must run before drm_dev_unplug(dev) below,
+	 * which is what drains in-flight profiler ioctls via SRCU: a profiler
+	 * ioctl blocked in a client-supplied SPM wait would otherwise stall
+	 * that unplug until the client's timeout expired. (XCP partition nodes
+	 * redirect their ioctls to the primary drm_device in
+	 * amdgpu_xcp_dev_alloc(), so they register on the primary device's SRCU
+	 * and amdgpu_xcp_dev_unplug() itself never waits on a profiler ioctl.)
+	 */
+	amdgpu_profiler_device_prepare_fini(adev);
 	amdgpu_xcp_dev_unplug(adev);
 	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
+	/*
+	 * Release profiler/SPM state now that drm_dev_unplug() guarantees no
+	 * ioctl is in flight. HW is still live (before amdgpu_driver_unload_kms()).
+	 */
+	amdgpu_profiler_device_fini(adev);
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 47e4680db797..57fa69c0382d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1647,6 +1647,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			dev_dbg(adev->dev, "trap handler not enabled");
 	}
 
+	/* Profiler is optional - don't fail open if unavailable */
+	if (amdgpu_profiler_mgr_init(adev, fpriv))
+		dev_dbg(adev->dev, "Can't setup profiler, continuing without it\n");
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1693,6 +1697,13 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	pm_runtime_get_sync(dev->dev);
 
+	/* Drop the profiler reference here rather than in ->release: postclose
+	 * also runs for in-kernel drm_client teardown (drm_file_free), and
+	 * before kfree(fpriv) below. Placed after pm_runtime_get_sync() so a
+	 * later SPM release can touch registers on a resumed device.
+	 */
+	amdgpu_profiler_mgr_fini(file_priv);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
new file mode 100644
index 000000000000..da322d2e6431
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <drm/drm_drv.h>
+
+#include "amdgpu.h"
+
+/*
+ * Profiler revision change log
+ *
+ * 1.0 - Initial revision
+ */
+
+#define AMDGPU_PROFILER_VERSION_MAJOR 1
+#define AMDGPU_PROFILER_VERSION_MINOR 0
+
+int amdgpu_profiler_ioctl(struct drm_device *dev,
+			  void *data,
+			  struct drm_file *filp)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_profiler_mgr *prof_mgr = &adev->prof_mgr;
+	struct drm_amdgpu_profiler_args *args = data;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = fpriv->prof_xcp_mgr;
+	int ret = 0, idx;
+
+	if (args->pad)
+		return -EINVAL;
+
+	/* Reject clients that never took a profiler reference, i.e. never
+	 * successfully called amdgpu_profiler_mgr_init(). Without this an fd
+	 * that never initialized could ride on another client's XCP-0
+	 * reference and reach amdgpu_spm_ioctl().
+	 */
+	if (!prof_xcp_mgr)
+		return -EACCES;
+
+	/* Prevent ioctl from racing with device removal. drm_dev_enter()
+	 * fails once drm_dev_unplug() has been called, and drm_dev_unplug()
+	 * blocks until every in-flight drm_dev_enter() section (this ioctl
+	 * included) has exited. The torn_down flag, set before unplug, keeps
+	 * new ioctls from touching resources that are about to be released.
+	 */
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
+
+	mutex_lock(&prof_mgr->mutex);
+	if (!prof_xcp_mgr->refcount || prof_xcp_mgr->torn_down) {
+		dev_dbg(adev->dev, "Profiler IOCTL op %u on xcp %u %s\n",
+			args->op, prof_xcp_mgr->xcp_id,
+			prof_xcp_mgr->torn_down ? "torn down" : "not initialized");
+		mutex_unlock(&prof_mgr->mutex);
+		ret = -ENODEV;
+		goto exit;
+	}
+	/*
+	 * Dispatch without prof_mgr->mutex: holding it here would let a
+	 * client-supplied SPM wait in amdgpu_spm_ioctl() stall every other
+	 * profiler fd. The fd's own reference keeps refcount >= 1 so a
+	 * concurrent close (amdgpu_profiler_mgr_fini) cannot release the
+	 * manager (and its spm_mgr) under us; device teardown is instead
+	 * excluded by the drm_dev_enter() section that drm_dev_unplug() drains.
+	 * The reference does not serialize spm_mgr mutation against
+	 * amdgpu_spm_mgr_release_owner() on another fd's close, so the SPM
+	 * layer serializes that itself by taking prof_xcp_mgr->mutex around
+	 * spm_mgr->file on both the acquire and the release/close paths.
+	 */
+	mutex_unlock(&prof_mgr->mutex);
+
+	switch (args->op) {
+	case AMDGPU_PROFILER_OP_GET_VER:
+		if (memchr_inv(&args->data, 0, sizeof(args->data))) {
+			ret = -EINVAL;
+		} else {
+			args->data.version = ((u32)AMDGPU_PROFILER_VERSION_MAJOR << 24) |
+					     (AMDGPU_PROFILER_VERSION_MINOR & GENMASK(23, 0));
+			ret = 0;
+		}
+		break;
+
+	case AMDGPU_PROFILER_OP_SPM:
+		ret = amdgpu_spm_ioctl(dev, &args->data.spm, filp);
+		break;
+
+	default:
+		dev_dbg(adev->dev, "Invalid profiler op: %u\n", args->op);
+		ret = -EINVAL;
+		break;
+	}
+
+exit:
+	drm_dev_exit(idx);
+	return ret;
+}
+
+void amdgpu_profiler_device_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_profiler_mgr *prof_mgr = &adev->prof_mgr;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+	int xcp_id;
+
+	mutex_init(&prof_mgr->mutex);
+
+	/* Initialize adev, xcp_id, and the per-XCP mutex for all XCP managers
+	 * at device init. adev and xcp_id remain constant for the device
+	 * lifetime, eliminating the need for mutex protection when reading
+	 * them. Both these mutexes and prof_mgr->mutex are only destroyed by
+	 * amdgpu_profiler_device_sw_fini(), which runs after the last drm_file
+	 * is gone, so teardown paths (amdgpu_spm_mgr_release_owner() and
+	 * amdgpu_spm_mgr_fini()) can take them regardless of the fd refcount.
+	 */
+	for (xcp_id = 0; xcp_id < MAX_XCP; xcp_id++) {
+		prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[xcp_id];
+		prof_xcp_mgr->adev = adev;
+		prof_xcp_mgr->xcp_id = xcp_id;
+		mutex_init(&prof_xcp_mgr->mutex);
+	}
+}
+
+void amdgpu_profiler_device_sw_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_profiler_mgr *prof_mgr = &adev->prof_mgr;
+	int xcp_id;
+
+	for (xcp_id = 0; xcp_id < MAX_XCP; xcp_id++)
+		mutex_destroy(&prof_mgr->prof_xcp_mgr[xcp_id].mutex);
+
+	mutex_destroy(&prof_mgr->mutex);
+}
+
+int amdgpu_profiler_mgr_init(struct amdgpu_device *adev,
+			     struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_profiler_mgr *prof_mgr = &adev->prof_mgr;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+	u32 xcp_id;
+
+	/* On a partitioned device, reject clients with no partition
+	 * assigned (AMDGPU_XCP_NO_PARTITION): amdgpu_prof_xcp_id() maps
+	 * them to XCP 0, which would expose partition 0's performance
+	 * counters as a cross-partition side channel. Enforce isolation
+	 * here, since amdgpu_xcp_get_xcc_mask() returns the full device
+	 * mask for NO_PARTITION.
+	 */
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION &&
+	    adev->xcp_mgr && adev->xcp_mgr->mode != AMDGPU_XCP_MODE_NONE)
+		return -EINVAL;
+
+	/* fpriv->xcp_id is mutable (rewritten by amdgpu_xcp_select_scheds on
+	 * first submit), so the resolved manager is latched into
+	 * fpriv->prof_xcp_mgr below and close drops the refcount on that same
+	 * XCP.
+	 */
+	xcp_id = amdgpu_prof_xcp_id(fpriv->xcp_id);
+	if (xcp_id >= MAX_XCP || !adev->ddev.render)
+		return -ENODEV;
+
+	mutex_lock(&prof_mgr->mutex);
+
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[xcp_id];
+
+	/* Prevent initialization during device teardown */
+	if (prof_xcp_mgr->torn_down) {
+		mutex_unlock(&prof_mgr->mutex);
+		return -ENODEV;
+	}
+
+	if (!prof_xcp_mgr->refcount) {
+		/* First open - initialize everything */
+		prof_xcp_mgr->refcount = 1;
+		dev_dbg(adev->dev, "Initialize profiler on render %u\n",
+			adev->ddev.render->index);
+		amdgpu_spm_mgr_init(&prof_xcp_mgr->spm_mgr);
+	} else {
+		/* Subsequent opens - just increment refcount */
+		prof_xcp_mgr->refcount++;
+	}
+
+	/* Latch the reference. Only set on the success path, so release and
+	 * the profiler ioctl act only for clients that actually took one.
+	 */
+	fpriv->prof_xcp_mgr = prof_xcp_mgr;
+
+	mutex_unlock(&prof_mgr->mutex);
+	return 0;
+}
+
+static void amdgpu_profiler_xcp_mgr_release(struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr)
+{
+	amdgpu_spm_mgr_fini(&prof_xcp_mgr->spm_mgr);
+}
+
+void amdgpu_profiler_mgr_fini(struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = fpriv->prof_xcp_mgr;
+	struct amdgpu_profiler_mgr *prof_mgr;
+
+	/* Only clients that successfully took a reference may drop one. fpriv
+	 * is kzalloc'd, so a client that failed or never called mgr_init has
+	 * this NULL and must not decrement any refcount.
+	 */
+	if (!prof_xcp_mgr)
+		return;
+
+	/* prof_xcp_mgr->adev is set at device init: after unplug
+	 * filp->minor->dev may point at a partition drm_device, so
+	 * drm_to_adev() would be bogus here.
+	 */
+	prof_mgr = &prof_xcp_mgr->adev->prof_mgr;
+
+	/* Release outside prof_mgr->mutex: the release path can block on
+	 * prof_xcp_mgr->mutex during another fd's acquire, and holding
+	 * prof_mgr->mutex there would stall all profiler ioctls. No-op unless
+	 * this fd owns the session.
+	 */
+	amdgpu_spm_mgr_release_owner(&prof_xcp_mgr->spm_mgr, filp);
+
+	mutex_lock(&prof_mgr->mutex);
+	/* Skip if device_fini already tore down this XCP manager */
+	if (!prof_xcp_mgr->torn_down) {
+		if (!WARN_ON(!prof_xcp_mgr->refcount) &&
+		    --prof_xcp_mgr->refcount == 0)
+			amdgpu_profiler_xcp_mgr_release(prof_xcp_mgr);
+	}
+	mutex_unlock(&prof_mgr->mutex);
+}
+
+void amdgpu_profiler_device_prepare_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_profiler_mgr *prof_mgr = &adev->prof_mgr;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+	int xcp_id;
+
+	/*
+	 * First stage of PCI-removal teardown, run *before* drm_dev_unplug().
+	 *
+	 * Mark every XCP torn down so no new ioctl proceeds. teardown_cb
+	 * provides the hook for waking a thread blocked in an SPM wait so its
+	 * ioctl can return promptly, but no callback is registered until a
+	 * later patch wires it up; until then this stage only sets torn_down.
+	 * drm_dev_unplug() then drains all in-flight profiler ioctls via SRCU
+	 * without stalling on a client-supplied SPM timeout. The actual
+	 * resource release happens afterwards in amdgpu_profiler_device_fini().
+	 */
+	mutex_lock(&prof_mgr->mutex);
+	for (xcp_id = 0; xcp_id < MAX_XCP; xcp_id++)
+		prof_mgr->prof_xcp_mgr[xcp_id].torn_down = true;
+
+	for (xcp_id = 0; xcp_id < MAX_XCP; xcp_id++) {
+		prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[xcp_id];
+		if (prof_xcp_mgr->refcount > 0 && prof_xcp_mgr->teardown_cb)
+			prof_xcp_mgr->teardown_cb(prof_xcp_mgr);
+	}
+	mutex_unlock(&prof_mgr->mutex);
+}
+
+void amdgpu_profiler_device_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_profiler_mgr *prof_mgr = &adev->prof_mgr;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+	int xcp_id;
+
+	/*
+	 * Second stage of PCI-removal teardown, run *after* drm_dev_unplug().
+	 *
+	 * drm_dev_unplug() has already drained every in-flight profiler ioctl
+	 * via SRCU, so nothing can be running here and no active-ioctl drain is
+	 * needed. torn_down was set in amdgpu_profiler_device_prepare_fini().
+	 * Release the HW/SPM resources of any XCP that still holds a session;
+	 * the device is still live (this runs before amdgpu_driver_unload_kms()).
+	 */
+	mutex_lock(&prof_mgr->mutex);
+	for (xcp_id = 0; xcp_id < MAX_XCP; xcp_id++) {
+		prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[xcp_id];
+		if (prof_xcp_mgr->refcount > 0) {
+			amdgpu_profiler_xcp_mgr_release(prof_xcp_mgr);
+			prof_xcp_mgr->refcount = 0;
+		}
+	}
+	mutex_unlock(&prof_mgr->mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..a220f05c9512
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef AMDGPU_PROFILER_H_
+#define AMDGPU_PROFILER_H_
+
+#include <linux/mutex.h>
+
+#include "amdgpu_xcp.h"
+#include "amdgpu_spm.h"
+
+/* Map XCP ID to profiler array index.
+ * AMDGPU_XCP_NO_PARTITION maps to 0. On a partitioned device the SPM
+ * consumer rejects NO_PARTITION before this mapping (see
+ * amdgpu_profiler_mgr_init()), so mapping to 0 only applies to
+ * non-partitioned systems, which legitimately use XCP 0.
+ */
+static inline u32 amdgpu_prof_xcp_id(u32 xcp_id)
+{
+	return xcp_id == AMDGPU_XCP_NO_PARTITION ? 0 : xcp_id;
+}
+
+/*
+ * y is the member name within amdgpu_profiler_xcp_mgr (e.g., spm_mgr)
+ */
+#define to_prof_xcp_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_xcp_mgr, y)
+
+struct amdgpu_profiler_xcp_mgr {
+	/* track multiple file opens (protected by prof_mgr->mutex) */
+	unsigned int                   refcount;
+	/* back-pointer to device */
+	struct amdgpu_device           *adev;
+	/* protect xcp_mgr shared resources */
+	struct mutex                   mutex;
+	u32                            xcp_id;
+	/* device removal in progress */
+	bool                           torn_down;
+	/* Called during device teardown (before drm_dev_unplug()) to wake
+	 * threads blocked in SPM waits so their ioctls can exit.
+	 * IMPORTANT: Invoked while holding prof_mgr->mutex.
+	 * Callback MUST NOT attempt to acquire prof_mgr->mutex to avoid deadlock.
+	 */
+	void (*teardown_cb)(struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr);
+
+	/*
+	 * Union scaffolding for future profiler sub-managers (PC, SPM2, etc.).
+	 * Currently only SPM, but designed for extensibility.
+	 */
+	union {
+		struct amdgpu_spm_mgr      spm_mgr;
+	};
+};
+
+struct amdgpu_profiler_mgr {
+	/* protect profiler manager share resource */
+	struct mutex                   mutex;
+	struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP];
+};
+
+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
+			  struct drm_file *filp);
+void amdgpu_profiler_device_init(struct amdgpu_device *adev);
+void amdgpu_profiler_device_sw_fini(struct amdgpu_device *adev);
+int amdgpu_profiler_mgr_init(struct amdgpu_device *adev,
+			     struct amdgpu_fpriv *fpriv);
+void amdgpu_profiler_mgr_fini(struct drm_file *filp);
+void amdgpu_profiler_device_prepare_fini(struct amdgpu_device *adev);
+void amdgpu_profiler_device_fini(struct amdgpu_device *adev);
+
+#endif /* AMDGPU_PROFILER_H_ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
new file mode 100644
index 000000000000..06747dd22b85
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "amdgpu.h"
+
+/* Check if the calling file owns the SPM session */
+static bool amdgpu_spm_is_owner(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	return spm_mgr->file == filp;
+}
+
+int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
+		     struct drm_file *filp)
+{
+	if (memchr_inv(args->reserved, 0, sizeof(args->reserved)))
+		return -EINVAL;
+
+	switch (args->op) {
+	case AMDGPU_SPM_OP_ACQUIRE:
+		/* Implemented in a later patch */
+		return -EOPNOTSUPP;
+
+	case AMDGPU_SPM_OP_RELEASE:
+		/* Implemented in a later patch */
+		return -EOPNOTSUPP;
+
+	case AMDGPU_SPM_OP_SET_DEST_BUF:
+		/* Implemented in a later patch */
+		return -EOPNOTSUPP;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
+{
+	/* TODO */
+}
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+
+	/* Full teardown lands with AMDGPU_SPM_OP_RELEASE. Re-check ownership
+	 * under the mutex so a close and a concurrent device teardown cannot
+	 * both release the same session.
+	 */
+	mutex_lock(&prof_xcp_mgr->mutex);
+	if (!spm_mgr->file) {
+		mutex_unlock(&prof_xcp_mgr->mutex);
+		return 0;
+	}
+	if (filp && !amdgpu_spm_is_owner(spm_mgr, filp)) {
+		mutex_unlock(&prof_xcp_mgr->mutex);
+		return -EPERM;
+	}
+	spm_mgr->file = NULL;
+	mutex_unlock(&prof_xcp_mgr->mutex);
+
+	return 0;
+}
+
+void amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
+{
+	amdgpu_spm_init_device(spm_mgr);
+}
+
+void amdgpu_spm_mgr_release_owner(struct amdgpu_spm_mgr *spm_mgr,
+				  struct drm_file *filp)
+{
+	amdgpu_spm_release(spm_mgr, filp);
+}
+
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
+{
+	amdgpu_spm_release(spm_mgr, NULL);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
new file mode 100644
index 000000000000..59fa641ebb86
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef AMDGPU_SPM_H_
+#define AMDGPU_SPM_H_
+
+struct drm_device;
+struct drm_file;
+struct drm_amdgpu_spm_args;
+
+struct amdgpu_spm_mgr {
+	struct drm_file *file;
+};
+
+int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
+		     struct drm_file *filp);
+
+void amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_mgr_release_owner(struct amdgpu_spm_mgr *spm_mgr,
+				  struct drm_file *filp);
+
+#endif
-- 
2.34.1

