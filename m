Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF846D49C7C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F24F10E97C;
	Fri, 30 Jan 2026 08:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dzRf79WQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173F310E974
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXIdhM5cW/i18Cw+7ewh1Ax+yWCHwSdVJhBvXnjrTU9ulrELjsriDmCpZNm8SDtjFBNvdQvcV6K4rUQeHMeURtiWb3vl2AlDAnR0x8DOX1LlJur1vBoN1IQD0QLm35g593KD8S1fJMJzBzpSKPo7IZDbcIzEmnqVPVEr1M5y9LvWSOkgxDEdpnCorvfNDb4YtPFHEZr2DEOsu2DG0qCEpKuTA1bObT2zl4641wwaSPY4ay5WwUFs0/CHp+C74OIznz5c6IyqOhlb3PXF8qY2gMEuiehp5zM0WLKS5wtWEglrrDREhZLJiowrYgHd2ceKl9T0wet4/UUdlSdkQDDWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loWo7KcB7yhfplB0vKve5HknBw6udFJCsIHvTCUA8bA=;
 b=T9+k7Bucpj7wHiQ11qdj5cSRvPbeulaJAR/lZkdf+OdamJ/1sdqp0RAGOuezNgtWTdmxZK6c43Hz23hkIl/a0VxsoTXAJ76xElJUPT7pO/bfYuLiPi8rk426TJ9FcjOVv+M+L4QfK7ybJ+/c8gJ+FZcWPU+2I5JK7yLgfJNThp98GAOBNJS6WrHkkaYuiZdb1SkEOVu4hNccQgNsreHUITjCcVkxD8lrOm0uqDNd4c172Vec0xFvTUgh7+RhfeUNY+zw8P0DO2WkRodPMV/u28zt8stcv3Cwm0YPTI35cGYKH5CXJnG3qHH4Y5i3LejSLfVGobGyGmIPoza4/cPyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loWo7KcB7yhfplB0vKve5HknBw6udFJCsIHvTCUA8bA=;
 b=dzRf79WQFTNxnQk8DwGoFvFvva3djOf8c80iC8esvTYuZX4RvFj1yrUcnXMsvGH58Lb0Kutz3BB3nUYzFud5uNHvgPn7nY0BSCTlca4KicAul7cs1d2hXTV7mAFlQ1QRvtkEpWQ7VRIi6jRmIAPu5KeK4eO/83DSQqUhBAp3hJ8=
Received: from BY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:a03:1b8::19)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 30 Jan
 2026 08:42:20 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::e3) by BY5PR17CA0006.outlook.office365.com
 (2603:10b6:a03:1b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 06/11] drm/amdgpu: Add first level cwsr handler to userq
Date: Fri, 30 Jan 2026 14:08:00 +0530
Message-ID: <20260130084137.2906792-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: a07d07b8-9e93-4658-dfbc-08de5fdb7ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b8r4XVEB3yh6fncaaGaYkTZVsdUurS04tTj8o72VgcwP8qvmMwSmOrLuRd1v?=
 =?us-ascii?Q?T3YOboc2r4K6xKkarYzKc/PRISn832xaK3thJePdgcQ0QkQUMHGfAh0nm0gU?=
 =?us-ascii?Q?3dU8jttbaDpKIwjLOiWdx7v8B5kfy+ThJm3Gu4S4kD9AGYES3jKZhTnSBe3I?=
 =?us-ascii?Q?G1ObqhKd7ux1AMq9kZXzHurm0LaUhJY/CO+VOvV8y1QhVw3sIekfvR7A9meR?=
 =?us-ascii?Q?gaxh7YbtZbAKzPj9l4BwVRUanhAquwSMpL+z746O3eLkXVA+IUqe0d6gkF1B?=
 =?us-ascii?Q?/nINCla+3Zwx9ZJaCZy8j1k1Q+6fdEEFgwCaLsG4S0wz8J+HPRDF5tSck5bW?=
 =?us-ascii?Q?AnaDOp+ghESnsCDF4NXjZ6DIl1ndfs+/veXQ2d7IqgFDgke55zCMOstjQ2lv?=
 =?us-ascii?Q?UfpGfcdud6T5tvAi/1Zpo5ufuaMR9ZyC3/UgADFbOELLuOPAQHCkN55P0APQ?=
 =?us-ascii?Q?uamNxTJx102Rc58fAnkz+gSxn0W43dKdWugzOTobBsUEBAqI9PbTEXWozBMo?=
 =?us-ascii?Q?r8teGxdVv/YvtvzMzCkuzclaU18edkjG+podUt3NTtm8EY5t0om4cjAvSxNv?=
 =?us-ascii?Q?tYsfEv7zUI+B3Advb9wkguzD/N3UZpViXmMYrpgSVzGQ044U4fAzf3l9XLOR?=
 =?us-ascii?Q?5auDYZZXQDvO7JQMHStU4E250ruE4ksYcnmaKyrqioN3HWIE2nXQUrtlMpv0?=
 =?us-ascii?Q?mhc3jRkQtKd/EfbadNRACOMHeApZoBixXQ7AdBEplOIk4qKMUQfmXH8x1dat?=
 =?us-ascii?Q?3sBUCSMUUsEwYsy7ELbjR/0G/E+G6LlGMFeugDQXEsMFpD1Ya7T2AMFkAkVH?=
 =?us-ascii?Q?orY8Co3JBjcfPZPwTCPxM3kZ2DrfogYdwAwn9d7NJu5ecUF9VBoXrPPZ/a4X?=
 =?us-ascii?Q?/5tGrwH96a8gTscT5/ck2SNedQ0J77pCR9S2grBulapZRuKjLplJstETp+oR?=
 =?us-ascii?Q?KryUF6DgRr8zC1pzoRax6g2an7u51aG8Erkw4dF2zP8gl+NIIAizE7kJJyVf?=
 =?us-ascii?Q?W8S9/QBGkOPcUamkwtOS+ekOnJ719BHeh0Qv/WDOM06xf3B0RpeJELKLXf82?=
 =?us-ascii?Q?3Q1A+WwkYcB2fegp+FWrnT2hwJW9wX6C/zrDPSnmOtxvV4Ayqoj8/HSPfvBX?=
 =?us-ascii?Q?B0eE2mQT6jnzx37Uad+to6I5xT2rJAssNa84+VTw48S2kvVJ3I5KXFDppqIw?=
 =?us-ascii?Q?Sop+xLFGOXcugfTff/+x4kPXXK/FPnLaNPtihkn6AkB0PmW7Z5nT1wj+EcgW?=
 =?us-ascii?Q?iuS8jNzaib4DktieGqgus+QVfTB1m1j0znJ0yhKJx39L64ykU6zf+JubsaaA?=
 =?us-ascii?Q?QeBoeNIS8070P7Z020Y7eNkzISYuiwhwsXNR5QEpHTAKBMVQUgyESXonJ/Tn?=
 =?us-ascii?Q?lYG3VxgiK3KbfOQbMDxCybmzEDTUn4zlSDycm+HBjnOnpp4SbT9M9cdOsOb/?=
 =?us-ascii?Q?vOfDp6R2XXQtwv1dt74ytj1ILzbzf85Bn//W+A6CdIvh3/Z9dYvvw+UaqIGf?=
 =?us-ascii?Q?Zyoa2LcEw89eAEx+673IMGKD7nTfJlwRtwxcE3yTimS5UH1Q7nEx+m3v3pzT?=
 =?us-ascii?Q?Imu/+nCVajysuKikWVw17DJd2v9T+pe/lay7ZUqPw48RxehjiOrPXqpBopX+?=
 =?us-ascii?Q?s+crLKRaFQ6fR3gySBWk534m8n1XaXUz1C+Hzxh9k44Zs34K3uDHzjIxrMhC?=
 =?us-ascii?Q?a4WKnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bAcDvJAC96a7pHZK+g7R4wBCceKC33kXjFO+NpfnNwVsq0NG/Z5x583nNuMMwlmKnSwTHYZPNv9mDIKapjDFvHdgdsW5KP/XNPMwpiKPopPuHAf28rV3u3hXdHrX8GR+BeBSV07bWKOfhEltDivSODiiIS1yJZ3KZ1GgOZ+H2sGDgkchux4YRlyt33QWECZjKLRxM9gIBuqcgP0icx6BL4FomNN4BjesEOMdrvjFvZNkX9TaZXIh3gnxAyUGJgukzxmOU5SLvjRViSFIzKKXagOUhwcJlPFP7e+569vBqtjz7IXXM1ftbPwgdwtZXGB1UOI/BH6sN8XoJwW0OWfL1RYYlRA0vpnSwOFxLMAoB9KVgZIjTSKdfndCaooNQ/m8AtMB5oxPEfLhBaku5ZD+hHxEhg6UkfteZBreloLTE8wi2WZbzgCD8sdM3TwomFGO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:19.6004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d07b8-9e93-4658-dfbc-08de5fdb7ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
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
index 7f922559e297..5717e1d662fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -78,4 +78,10 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
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

