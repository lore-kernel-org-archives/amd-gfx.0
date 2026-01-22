Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197AC44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE9B10E97B;
	Thu, 22 Jan 2026 10:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Mb3o9Yh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E44B10E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHG2Lc262SglvIXq9UWI/TrZ3xfxVsxzL4Y+PECl0h8zOUeW1lGTuqvBjPLrV+6XqPGFfuEWFqiBrWV9lbAgpCYY4/XEEPAukHn4Elo+UJKVdav8N6PQkJgoHkOGCP7eqChJr4dd6js05x7/49ZFNxjHljVFeMC6QfFz+6TPEylRIrdvg8DzJt2lzBxDZQdj4bWh8LFxdcc6C7Reyr2zkhzRjikkvPuyZyqfq3lE+yrAd794ZC2Y3PJyZ7EuzCQekc5gGVas38dfE9AKEbugZDEO4Ktt2ePplVU099zs11gl37hymSJkdlpgpFeA/R1ryDMYBcSncKDTF158fy1mQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnHe63uYUUCTwr6+2L6A9cwC+AMDluwk2QPdu1rrqxA=;
 b=O9rLxV+U6EIlZGIxJAutyygsG88lmc2MzoWFS2ascWgPIKOFhOW5lyxtDE/ZGrE0EkepP8lInH61rZ5+RlnZfXqx94MIMMujLS7gRiQo1dPgMBiHU9ZLG+Z0ToKfZYv85IE2eVEmeiOonxY/2PkORYwt2ycX4mjipf84C03VG7nc10wrzqV8NLAID82+HxdyseDNg4pwp1NkWni/LS7kkF9Q3vXSjdFW3QGG09RESYbKRXdqytarH4QkPyIb+nhbz0Vrwro0eNVIi3iIbPxNOcl/Hso0je0Cm0qMeZOjDSni6DK4mnvB2mlSK029KleMUZFhQkV/XENSxpdQtP6lkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnHe63uYUUCTwr6+2L6A9cwC+AMDluwk2QPdu1rrqxA=;
 b=2Mb3o9YhHpRc2xNXHEYdjNZkiKAN6hxgpgZ570uHVTC9O35d95KqqEMKuq4T7EU527PQX4Lh+nvaen0ZIzbe++w6zLXPAEUsqk3ON0fJUEr+F1T27l9sXNsHuoJTEyJKP17q+B+tWsjs610SYaV9Z5s343D2hsG5gbOmYqtUymI=
Received: from DS7PR03CA0117.namprd03.prod.outlook.com (2603:10b6:5:3b7::32)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:42:06 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::c1) by DS7PR03CA0117.outlook.office365.com
 (2603:10b6:5:3b7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:42:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:42:00 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 10/11] drm/amdgpu: Add ioctl to set level2 handler
Date: Thu, 22 Jan 2026 16:09:59 +0530
Message-ID: <20260122104118.1682154-11-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc21444-e846-4b89-b413-08de59a2e2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FDlmfXiW/QV3k1uEuui19y0xSBPIeyTqzjSlM6R0Sq6WFOXZfJYigG2bsP0x?=
 =?us-ascii?Q?v1uMjxGygYDS5/KPPRkl5EtyX3FVKcx9dphCgfcIu04+1aI2v3kMIzYz6CPQ?=
 =?us-ascii?Q?WdsTMbk7g+R9gakmKGJBk76G666GolAjDS8mJKmuebk/AnIWPHHo9Gpcp6I7?=
 =?us-ascii?Q?aYg8whu0iapctp/RACY/NX7rTj74G/WcqEu3rKXqZ8LNVd8jqThZNw5sHRET?=
 =?us-ascii?Q?/I4ACPZwe2wLSabfF+l5/c+PtYK8DfhbC+EO743ROJFJXkEQ46quh5MgLOYm?=
 =?us-ascii?Q?acZZRyysY8X+Y4pM86L/etcyPeNHSslK5CWpHFh7qRqehZjjWKmLFLNaWwMN?=
 =?us-ascii?Q?253QXK0qFi78Hnr/G/eF2s+F2ikYlTlvcfLTSfzkSDCAznOMbhiqVi86Gsyi?=
 =?us-ascii?Q?Or526OnlnBYqPrPAVvzMOzHgkFE91vdyjWUSB1PYBpNNG7ZXbeKMGVn2pugL?=
 =?us-ascii?Q?h5ulq/AM5UQQxiHkhKdCqQkt4U0aOZC6aI41TD+qa/y0I6qXA3oyrhuhdamD?=
 =?us-ascii?Q?kAPH0B7PbVbjogtUY6XOaPiPSxzF0mS2IlcHtaaiXKk+eeQgFHzXccdjO61W?=
 =?us-ascii?Q?9r5wXpiL/qZLo+1cepwgvGNHYRbJTdj4qFxCpHK2k+UsidTBhrv7mwwftOV4?=
 =?us-ascii?Q?ig7K7/R+nkWqV7POkLW8W2tnOe6bQ02YlVaSsPTW46KlH4cD+NJzelztsQbi?=
 =?us-ascii?Q?DgubnfZW1lstGlGPQnsZoY5FJMlYkVWdcCEnQwJ+wyWAMTNN5sqZe3wh2iGP?=
 =?us-ascii?Q?rRuT4ncl/yi/czDKf4xNEHEHS8pV0atzwfvJ01SVjiIgkA07u9oz147ENKgT?=
 =?us-ascii?Q?ssuqQtYO6i7xDxkFN9TbKwuEsHiAV0shvWxwckHU3b/FHa3UhFUtTdTC5cIK?=
 =?us-ascii?Q?LORdZwLujJ9e1gMhoDEtqS3H1stied8up6pUTVnaPy0Cfvt2pApBF65dCE1p?=
 =?us-ascii?Q?5uxlgbJswmk1iIbi/PF7QXQYcfNDz9dhQfortslDVyLJapDPwAw/5i5Nh486?=
 =?us-ascii?Q?nCGl1zBnwj3m8q4a/qrb8O7smBFNNSnXtCYA85AFZvsJ4n9V3i7PEj2Dw28V?=
 =?us-ascii?Q?UA49Ex+nIYzvI91z+JzN3gm6OnZEH2vZq46M5mbTRhXQGICESNVAjLo9Rcfx?=
 =?us-ascii?Q?PfVop0OU33g2m3/1FkEdVDtQrPOY16pMahfOubCvF+3qX9mhG9CM2wVz+bXh?=
 =?us-ascii?Q?kQBkbaJHvrTvZ8Oxg3JsHGhM06s131Qf3pNJ/Hg/j7pRymsEnDk8y0QpQZUG?=
 =?us-ascii?Q?/BDKilZxKpiH2WYjm0FJ/S65jqLkngOmq96fcJvi7bEurUA4DS/xYa7o934e?=
 =?us-ascii?Q?OVd+PT+DmU65qYVTILU43TmFM7hbSHe6AQx3qJa/Dwi3Z7F1bQSwGz+7wnV9?=
 =?us-ascii?Q?hIKbzLjT21T1U4fPFDcqYfc9Um4k2GtWROJmKm1hA0ML/t2k/DaTSgyQyMUy?=
 =?us-ascii?Q?h+OulHpjrAlxh7vcTgA30pZ/I2THJuxbm88LEgK4DMzotj0b33xY/wDRB/he?=
 =?us-ascii?Q?y5RLeymwXF8c3jV2Phc+o4ulUMUM/RR9TVCkmageiWZG8ahGI51oxvhzhB61?=
 =?us-ascii?Q?/tEMiNODvahfc30nzfl+VPxCVkrypX1cyRwgmfaw9kh9ks97sWpbHawOqUAh?=
 =?us-ascii?Q?tBHk+dpcSKvKFfU6ZXUfBG4jY93a/GhQo8Q6Y+TE656n5v/GWg3OufPNdiAD?=
 =?us-ascii?Q?puCF+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:42:06.0345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc21444-e846-4b89-b413-08de59a2e2fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

Add ioctl to set tba/tma of level2 trap handler

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 105 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 include/uapi/drm/amdgpu_drm.h            |  24 ++++++
 5 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 26b757c95579..c3dfd84c2962 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1575,7 +1575,6 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
-
 /*
  * functions used by amdgpu_encoder.c
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 32d9398cd1d1..70f444afece0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -510,3 +510,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
index b54240d40a6c..c9f61e393fde 100644
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
@@ -63,6 +63,11 @@ struct amdgpu_cwsr_params {
 	uint32_t cwsr_sz;
 };
 
+struct amdgpu_cwsr_usr_addr {
+	uint64_t addr;
+	uint32_t size;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -85,4 +90,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
 
 	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
 }
+
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *filp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 771c89c84608..7fbd106fff8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -53,6 +53,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_cwsr.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
@@ -3074,6 +3075,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b7a858365174..a36e3e2e679c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_CWSR 0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_CWSR \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
 
 /**
  * DOC: memory domains
@@ -1680,6 +1683,27 @@ struct drm_amdgpu_info_cwsr {
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
2.49.0

