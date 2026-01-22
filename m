Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81E7C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B01C10E18A;
	Thu, 22 Jan 2026 10:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGXs81BY";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F15110E18A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM+2QmTmNskA8tSUVmF6p3kUmSsyiR/Xb4e0WORk5SqglgD9pwvP+tyEez33juyVK3pOSB9cnBxvX8iKiH4wA/X26EyqKqUamdJyfcM5f6oYiqrVwqk6zADiGFNh9m+h0mr2BrmQuWi8DMQXEITKPQYwgEC02GlJ2kXhDMRMnHReXivKWw207GlQohC7oB6e+bPtIkbHBCkn61ADFN6R2wWeygmZtHVDaroRKSfKumWwy84sMxmadQV4z62AKn808s7ABWyS5f2jrTIVFExJv2SxVAaqbwzR6Lk5AgMNBnED/XEoi9YqbZMWLLBCBhwcJVnHjo8ySLA7gAyNd08BSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhAxtSXp9simesC2q7FqofjPoYX7ypIeoj2atxwXjuA=;
 b=xKFs4Qf9m2X6QBpeTgHMmFbe+iWcRKPwu44t8BnbhTS8VqUiiXbPmm+oRATTOnMMHvKnIEJmmHnTyPh12A9jlwmEWhDOb6oZG2bZeoEZgQOEd+9nwgoDHXbsthrtikCG0jLpsA0jOdr6BhO+tSmf9FAvzaGJVsTKlCpbLwGq599jk3fDWVz7Yh2icK3mSRBw5SvlM7H+x5hMpJPzCXfD/P9hJbWBVEKI1po+Vy0oppX2lloW2s4enriboWPud8OpUyt5pBKlyBxpC9UW35piHnbI5GOwWfao0wPwtmcZBOt8dORtB9ZIYzLw8IXUgLWxlaKaiCl5/C3DwFRPkGLO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhAxtSXp9simesC2q7FqofjPoYX7ypIeoj2atxwXjuA=;
 b=oGXs81BY6czdCRDS0HhCFWPU9uVSpAaTJ3sM7cWM4DZGaz6NYjLNXOg/nKUCgaOBLo2Z7ZxM7bQ0QGXEdL0p+iFEEIQjxRTTlC02XdwFvqiAjkJTJfso6XzpzIIaPID1lQRpJNNnsVWCKZAKRYXuAGC3X296+HbA65Exc0qc3ME=
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 10:41:55 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::b5) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 10:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 06/11] drm/amdgpu: Add first level cwsr handler to userq
Date: Thu, 22 Jan 2026 16:09:55 +0530
Message-ID: <20260122104118.1682154-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 60af7d43-1007-4e34-1cf7-08de59a2dc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7zPDUobEae4UuEkq+6N15KNTmk1nRymtAgz3S8tRZEt9hmc7Kw+jceBggyf?=
 =?us-ascii?Q?PLVpR2B4+vyZXMUMbNJ3igeibB5qy9FibG2YXHL4EuxaEjEAkEVCgAkKzH89?=
 =?us-ascii?Q?pgXkBgqOZ/iS4GaszhlY0xBV3FnDMQNppNSy/DSiyK4neBBQUhg7kJ3b+41P?=
 =?us-ascii?Q?ZTRAeqOyq4mUoHclff8SlY8BnFYhwCnUFXSBjq7Nq/N59V93YxrVFow57foW?=
 =?us-ascii?Q?E432x4NBM9n3b/KLnZWKPjVrkeine7tXywd8tgjqLS9Gzt3+A9ilpvUES0pu?=
 =?us-ascii?Q?cMjDvEYyPh1KWLIsXoCSUiPOF+nl+OMqlimNxqZzt5oZqSNTNCvjCc/MRbgZ?=
 =?us-ascii?Q?GCLRnRBUknKq2Dk5hnyeoOC0+NwpztHSEhvWLEjVvyxIK/a6ifR6aWBUCReS?=
 =?us-ascii?Q?3p2r0q2T3+5bFbtAGkyjuPyPiC8pwEe3kEtsIUDEwjPJg8TygqGTeRUsslYJ?=
 =?us-ascii?Q?P2oMBWEXIED73tFNZX9BBxTBQlUPfBzr8ICcFlBf1KDg7zfEeqzIXd20+OTv?=
 =?us-ascii?Q?jVadUVzfA/nDr6qNB32gOGmzctCSXA/qA8FelHhyzXX9o4h34fUrRmEw02P9?=
 =?us-ascii?Q?9R1T944QQaBVbQjjdL1NSt8g96wENs0zEdgnwGrl8DEacbzO4D6lfTMFK01Q?=
 =?us-ascii?Q?LwUeoVvFHTPkAhbtX+YWl6EWRhB8yhF381yA/Ancn8viDYeBYn4a0tgGIacx?=
 =?us-ascii?Q?nljlSsZC6a5diO0aPIFbRmyqLNFE+4FVfjra+AD/IOOjoirrgW4HAxsgfKrO?=
 =?us-ascii?Q?5dDUO6UHyVR+52Lafc14wj4WoXuYYDsRIhAazsx7S7HDtevETIpt1kR25nmN?=
 =?us-ascii?Q?FK7mUjU2SSmE8cn7TyNAocEdeiIbXpNetmwSTAF6t01PwdHka2XubS1FowLa?=
 =?us-ascii?Q?KbAlfWdXebK8rEiLZiQGuoFvw/59kUCmVUAQ28iyp838SjL+YfqqMuwU26q3?=
 =?us-ascii?Q?mcGOKLuav7TuSb/sdGcwshNIIAMT06KOSIaeLw+hR59Yi6pmlRGvoFs+6Jkg?=
 =?us-ascii?Q?Kxo1CYZvLD7JRuO/l6Afqpuze8YIHzhCJLKdn5pHyMZLB3HryDqbh7Bu2LSR?=
 =?us-ascii?Q?4qbh2dp4f4iAesxS2r/x2gJiKb7kOy1Vrrcb1tsGfnnNIK8DXKxJ3N0wwp7Z?=
 =?us-ascii?Q?vZuFM5jcF2HNhPQrns5o4cLwphiiOOcKoQ+MPiBQKpZnpYWIosIKkofL1xq4?=
 =?us-ascii?Q?iWtmSxqQU2cGSV9FpRG6hScAjsvVWovoOwWW633YEWSRNnqZSyL2g6MaTmok?=
 =?us-ascii?Q?uIvYIFRKGcNflt8k6MtN3wXDNMFr+ksonDUH9Z1Fyrj9f94X2CMghdnFv6Bf?=
 =?us-ascii?Q?586JbxYOg3n8aMNX8jtbDoj5dr0DML6fEoxh626vsJpomLvgt8b0p0A6Zp0N?=
 =?us-ascii?Q?eGXjfpxBBRf5ERU4Ij8MmViJKchFur3PrwQtAqTM9I0FHl2aa4ZRiGG3B3Pl?=
 =?us-ascii?Q?RJ6LY2Je1EFka6THJM5wljMLG/rHZ/6c7Lzoc+CUhMw14A9A7lRTU/eQH2zg?=
 =?us-ascii?Q?W1l3EvNeF652hitupgJAbbjBAIWKBxjOZxMJzXZxbaPaCUdOfGu0LBi99eah?=
 =?us-ascii?Q?yyRhSjqGLeCTd80fDiR5E9wLqjlmdvVC1O5rJjpv2GUai8Z9PqzMdBQ1R2cP?=
 =?us-ascii?Q?2nGRNpoHYnHy9bcCMxcZdIUb+tEXHHNMVgsbUu0CkJVDsCg9B7XYIVC3EyUF?=
 =?us-ascii?Q?EOHbAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:54.7480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60af7d43-1007-4e34-1cf7-08de59a2dc46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

Add cwsr_trap_obj to render file handle. It maps the first level cwsr
handler to the vm with which the file handle is associated. Use
cwsr trap object's tba/tma address for the userqueue.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0ace28c170bb..218d8030a07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -329,6 +329,7 @@ struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_cwsr_isa;
+struct amdgpu_cwsr_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -449,6 +450,7 @@ struct amdgpu_fpriv {
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+	struct amdgpu_cwsr_trap_obj *cwsr_trap;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 96b03a8ed99b..b54240d40a6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -79,4 +79,10 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
 int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_cwsr_params *cwsr_params,
 				int num_xcc);
+static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 728033a88078..fed15a922346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -46,6 +46,7 @@
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_cwsr.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1512,6 +1513,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 "Failed to init usermode queue manager (%d), use legacy workload submission only\n",
 			 r);
 
+	if (amdgpu_cwsr_is_enabled(adev)) {
+		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
+		if (r)
+			dev_dbg(adev->dev, "cwsr trap not enabled");
+	}
+
 	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
 	if (r)
 		goto error_vm;
@@ -1584,6 +1591,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
+	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 	if (pasid)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2309d72bbe6..27917614b1a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -136,6 +137,7 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -165,6 +167,11 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
+	if (fpriv->cwsr_trap) {
+		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
+		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
+	}
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-- 
2.49.0

