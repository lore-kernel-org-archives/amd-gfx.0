Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B6606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=op83WAI4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439F010E43C;
	Tue, 24 Nov 2026 06:16:58 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2911310E21F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 06:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD5LZe/jRWvGZQmSoHVHNkQdNlYBWeq34KV9Kx2lhEq/J8aOw4ReJrMGnmRU8dUUvuGczepIMEUPihjkyYKIyCwXCUib3ITqH51aRhrUYpZNo9N+t722yyUT+wJQyFLmy30ggGeQE/ZzW4qHRYRxsWG/e1qa/pKkVRYbs5pAqJODNR+vRAgLsYeaIK8726OyXFnhmt0eeiInQqOOpYWUbjrE1ed5D6UQIemkCxd0hXdhGO3xBzs2uaWAOI6uNyk56Zv4MxXV/QzKUs14FILfwfnZ/VxC/QbUPEUFd+ezece+kLiBH7cDnHyma1M3C3Nvn8jbPdWZjBJsiXL5SK35RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ComcmRzb06Z1vXZha8muKYIjhk3c/r5eop6on07/+vM=;
 b=I+zdovX3/AEX/1FrmlhpTPWu7IfzUg0RedkW9yKmUitfly1EvEkZJhpoNriuinOoDwvarGuMZamOLUEfA2Aed563TJxnwa7vpdFDc12zKHBH5MNUzKt1o1KHVa4MhCb1S4ceEpFH3+39+tEmVCIZ4y/Vl6M1i+YqojBiaBbjL739nJnh5ExGAY6POG/yrKslgN7Xx1uP004KZz9nPoaaO/GB+6W6vV4PMJmhVxNLIvcf2Uy6gP0aC4f62e2GfTY4EHLy3rzi75TWld58seDbgjrpWTv/Wu/EdzIllfC/9KoefGi5GedExXqGnJVl5izqjY2mLIg35OtWRl9qOnPkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ComcmRzb06Z1vXZha8muKYIjhk3c/r5eop6on07/+vM=;
 b=op83WAI48cQPp4klhkB/+jBOw4DYNrDqjgobVnu4SNlwibiVkFLaJmEN7R0NHovDjuqTf+LyQxP4orCIQExyjNdxgkznddOmj3xpnAhTtzgvrQoHcDm9VFkjAua0SunUoiVSBcQEfi3oWE/YlFXlbKk9FHMb1AICXPnMwmTo47k=
Received: from PH7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::8)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 06:16:47 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::a) by PH7P222CA0020.outlook.office365.com
 (2603:10b6:510:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 06:16:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 06:16:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 00:16:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 00:16:45 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 24 Nov 2026 00:16:44 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable traps for compute user queues with an L2
 trap handler on GFX 11.0.x
Date: Tue, 24 Nov 2026 14:16:02 +0800
Message-ID: <20261124061643.2043178-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4623bac0-576d-4677-05a5-08df49f284b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|18002099003|3023799007|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261009223027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: y4HKYEz27aR83RWGazelPsRA5VIJdwIr2XzrapTAtFor7hSXSp60cav4tVXGWzbLGTGkBQl5QV/0IFJVz9WDvSnDqZhmwmTwh+j5CNgKca7TLWdZE6JzkfW9sbqXs4qtqB1DdRuBU9K5wPqkJbV9/mRFlXuj447MHF5HC4bkdPz7QxQQcBNzvqdOcB2rA0B2GWuF51eayqrYt0exYFHzx8QHr2dwpAMXgH4UQOakhjHKKnXgs0q+pvGoZTudoFCbhsQZK5Hstcho8Ooj4tL47IFE1jBdjNv7YC2FqpW1NcppuBkuIEyvtPBt2bDhe45x44X6NcbVZUi1eJlt5ecIFulAU0/NpR5A6nCm/3nIj4MPMLY39WkXiwzipNROW7QT2dQriXlivVoq+8uNxZPRufRxjLchv2H0ta76KjhqKkf+CNk86fDum5i/qbGIIC4cj3jY0LEJAuQCoknNk57YZYJkbclm9vlaqbqvyA5XeDzUV3OJztdeFBmgnyKrboMh5FB9TIqWMkrZNDajqV/GleW9stkmdg9h9Xn+k5BTs56D/jxajoFzPYvoO/uLA7TbMQ3hfP2fL4LbdnYDGBim0cGoAP5CoFz3Qokj5e4wjMDM7aZ5fgJfP4Lc8dMpmRmx1IXvbKbfolO7fTqBNvcH7m6nzjDDZeELWT7lUkitjsKUiGfjl7VlzOjsMjGywRUFNKU/8JfKcOaZ7n/IvwMJjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(3023799007)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PY+ZkFg6IbqYcKYVPUcYECTpQlyF9Ezz8GY5scMYmO0GMjXCUMQnSlMp3gwM5bi02qg/YdFQJKa5u5FOgFAhGNizuEIJpMDk0xoBa/4YDTIxjyx/g4HvD1VMpVYWDmnMuzH7DSmjr486gq5+FhqVf7QrOaocImwNQX42RF6B6uk4Tm0elHY5uSkEKbzUommn//H4TdeA1cUPemWu6H2KMQyUyL8qQ6VU8yAVJpBmZ9TGjzSKQH7k9KdVHU3N1AjbUOy6kfPNG6nW/195uooIn68x//2IQUjRF0e/TEGDZtGx+UyIOpsR6LRVGwFqMV2l31E+NRKd1K4bxKIV1W1GgkZxL3SX0lu1dEcihBhO1r5hqbhYcRQP4JRymbUQl+lfPRqE3W2v/y6WNv+n5SlKA8NoR+LbfCrqKK/8HQXWqVer4UVme6cgD84ttFcbPLUJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:16:46.6415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4623bac0-576d-4677-05a5-08df49f284b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On GFX 11.0.0-11.0.3 only waves in the first shader array (SA0) of each
SE can enter the trap handler, see commit 69a8c3ae2dea ("drm/amdkfd:
apply trap workaround for gfx11"). User queues are mapped with traps
disabled there, so a handler installed with AMDGPU_VM_OP_SET_L2_TRAP
never runs.

Like KFD does for debug sessions, restrict the compute user queues
created while a second-level trap handler is installed to SA0 of each SE
through the MQD CU mask, and map them with traps enabled. The decision
is made at queue creation and kept across unmap/map.

The MQD mask is only the initial value: COMPUTE_STATIC_THREAD_MGMT_SE*
writes from the queue override it, so the UMD must keep its dispatches
on SA0 as well.

Also set the mask for SE4-SE7, which were left at 0 and thus disabled
SE4/SE5 on Navi31.

GFX user queues are not covered: the GFX11 MES firmware does not program
TBA/TMA for the GFX queue VMID.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++++++++++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index fea1f2b32b42..6e7ad1411071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -696,6 +696,8 @@ int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
 		goto out_unreserve;
 
 	r = amdgpu_trap_update_l2_handler(trap_obj, tba_va, tma_va);
+	if (!r)
+		trap_obj->l2_trap = true;
 
 out_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
@@ -729,6 +731,8 @@ int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
 	}
 
 	r = amdgpu_trap_clear_l2_handler(vm, trap_obj);
+	if (!r)
+		trap_obj->l2_trap = false;
 
 out_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 523f65cb3d3d..516840c6fa40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -45,6 +45,9 @@ struct amdgpu_trap_obj {
 	struct amdgpu_bo *tma_bo;
 	struct amdgpu_bo_va *tba_va;
 	struct amdgpu_bo_va *tma_va;
+
+	/* A second-level trap handler is installed for the GPUVM */
+	bool l2_trap;
 };
 
 struct amdgpu_trap_info {
@@ -107,6 +110,24 @@ static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 	       gc_ver <= IP_VERSION(11, 0, 3);
 }
 
+/**
+ * amdgpu_trap_vm_dbg_wa - check if user queues need the trap workaround
+ * @adev: AMDGPU device
+ * @trap_obj: first-level trap object of the GPUVM
+ *
+ * On GFX 11.0.0-11.0.3 only waves in the first shader array of each SE can
+ * enter the trap handler, so traps stay disabled there. Compute user queues
+ * created while the GPUVM has a second-level trap handler are restricted to
+ * the first shader array of each SE instead, and get traps enabled.
+ *
+ * Return: true if new compute user queues of the GPUVM need the workaround.
+ */
+static inline bool amdgpu_trap_vm_dbg_wa(struct amdgpu_device *adev,
+					 struct amdgpu_trap_obj *trap_obj)
+{
+	return amdgpu_trap_has_dbg_wa(adev) && trap_obj && trap_obj->l2_trap;
+}
+
 /**
  * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler
  * @adev: AMDGPU device
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fff8f1de23ea..e05130dc80ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4245,6 +4245,10 @@ static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
 		mqd->compute_static_thread_mgmt_se1 = wa_mask;
 		mqd->compute_static_thread_mgmt_se2 = wa_mask;
 		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		mqd->compute_static_thread_mgmt_se4 = wa_mask;
+		mqd->compute_static_thread_mgmt_se5 = wa_mask;
+		mqd->compute_static_thread_mgmt_se6 = wa_mask;
+		mqd->compute_static_thread_mgmt_se7 = wa_mask;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5fdaac36b9f3..4be550abab4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -179,7 +179,13 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	if (fpriv->vm.trap_obj) {
 		queue_input.tba_addr = fpriv->vm.trap_obj->tba_gpu_va_addr;
 		queue_input.tma_addr = fpriv->vm.trap_obj->tma_gpu_va_addr;
-		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
+		/*
+		 * Only the queues restricted to the CUs that can enter the
+		 * trap handler get traps enabled with the workaround.
+		 */
+		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev) ||
+			(userq_props->cu_flags &
+			 AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE);
 	}
 
 	if (mes->use_rs64mem) {
@@ -575,6 +581,11 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			mqd_user->flags &
 			AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
 
+		/* Keep the waves where they can enter the trap handler */
+		if (amdgpu_trap_vm_dbg_wa(adev,
+					  uq_mgr_to_fpriv(queue->userq_mgr)->vm.trap_obj))
+			userq_props->cu_flags = AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE;
+
 		if (amdgpu_trap_is_enabled(adev)) {
 			struct amdgpu_fpriv *fpriv =
 				uq_mgr_to_fpriv(queue->userq_mgr);
-- 
2.50.1

