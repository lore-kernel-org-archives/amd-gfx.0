Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9AECA5FFF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1171F10F4F4;
	Wed,  7 Oct 2026 11:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nS/hg8/I";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1A710EE6B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVbRtbDNqU2FOy5m2AFIpSboxN1neu9WVn2bjcml6lkO8IQIfT3Z5LbRqbf0BpZEEF4jZMjG82LPKxfIleAcNp/27VUpwkFh+MD4//eQPDZHjNe4gCDliSqDcGYNVKmnUhpseCPpHPGHl+2A1XN2/J11tOUXixfkC/Yl58AD3frhpo3nAJnm3WL+/1VKdu41rJ7zm40RFLADcKn8qsgCtMLYp8DwKPqQdViQSiiE6DWDoiDluok147c1IsN88heIyO/VMy70zJSXeFgKWkfWsgvVJuhhR1JqqOsOXmQiYyiGxf3FF6SUuOq9Xj3PiX4yD8QroJ3QYz0LS6sAzI62tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKrXO0bhkq3AwddYglP2vh+1i+1TZr1PGzUHwqUXxUI=;
 b=DYLMKnehTaKND0cg96MhHR0B+M943aB9eqJi3z1ZCPuwNQuDad3TodUifm7SOTcHsvqDAV2VrgyPnUGyVCJteC0VDuaTRU5WOqeQC8W3JywGQ6ciHSvFD9C7mRXwvRi788lTzu5T8+J5fLYxYqk2TbhHyEG3lvwsEtAw5JOhZjmlPsa497eZwzeqqmCANv4jVF4sDgUGoJ0buKhWAlPvp4GycOoXyOv2oCxpUqixvEH6uJJ4rMN8+9LxG/M71yQ2pL8Mtj8mCYpBw1u26HbOcTPzyEGHj3TSYVOmbGsNUc6O7GKC1C3T9htaSRWnygz+mJQE5azruYzGBd4qngNuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKrXO0bhkq3AwddYglP2vh+1i+1TZr1PGzUHwqUXxUI=;
 b=nS/hg8/IksIOBT01NhqLQLJ9YN9BlRON6NqEtdzypkD9wfeQSslstUqLi3aaRDPBjhxOnLFCFF7yj9MYXQBwQ+v3BTEQazSMhP1RnKgwmDJJ5+vsBVZoQF9Xd/2oiNZe4fQVxAEMyWBa6qLObQ/ovhrjI2G14mB/ldA6esMZbek=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 7 Oct
 2026 11:05:29 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::23) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 11:05:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: Enable CWSR for user queues
Date: Wed, 7 Oct 2026 16:35:00 +0530
Message-ID: <20261007110506.1065076-4-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 8515abb5-14bb-480c-c118-08df2462e5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: DGSqMFvOBLn/yPJfWNwp1vrBH/Re7K1n9+VUL8LcfhSEXlse8gd2/U3SQMJHjWdQ3ZQeVsL0KrtajN3vJiDM8dxBI3mmgoDFWEtigy7GyNpWSySuhqeBBm39x6vS592Qu3mrwsLOPiE3A7XHoV/dme7vHDcUoEQlwx/DwF7wWyihn6Sn3st8zdpFcqG7SP1eIrptf4ExjeWV6U4ThtN7Dr5rmoEsDAYlIhtTS1Ivaa7iAnQFdALBePwfpi19XdVfwUulugkdbqyfzB7ZB4IxNZVNIcvS1VeQW62Jnk+6WsTQfcB4XBoStISjgZPSa1o2IGQczBF7hFoMiNUwKi0vAbSRYn0ayJQaS2Pu4ghnb1asyaPH6dg1UEXSY9bYQgwz+l1doIk+4Tbcz9xLEToXdTPOHRH3dhyv0YW3Q3G9I4AOU+pTiA4dFsw/FKcUSh4X7KxiqQGSOJtLHiXqsgO0A5VAr6xmzigHujJu84BvAB+Ohv4ugQ1zRKW5N/scpa2wgrcMrLsSw1tUdqUirSVIU3WbQUSOgbEH+QMSbXcL+uNAZ1z1Al/CKsrApqMfI9DeCi6leFoSlRBEBX7a0FPwMAINdHlWGIluWz7R9e8e4vD17iIi4gyaCGDyBytRrXdoRpjnRntuevafJuL71IAZ4wrkwxBeGuUP+50nFqN0JW+31iRF4rClKjONeFUuzbAmOn0lgav8mHvPlyeYQ1T51g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xY3qxrthxZjUYYf+Z7dCxNIE0Ux9acE/+G97GwZtdgEg0Oo6hi7d7D2hkPMdOPq2zyfk96Rwsd2aHx6N5DhSPDVulZmbsOMlothKuM02KEFZv+5WXmmoQL17CjzkbJKdpIeSYxT6IrEWmmE9S+gD+BmdDn/fIInavaUOwk7OXogYf+0QcGe94C9E1Z9FkIBapZ2nHvJeOs3zc39kibksxEf/tTdGRx+XyyW2Fgns1zz+1FGbHPvUJjfcrGaT4FgQWXwhYysgPatLGOLubrZJqAfWEZTxuI6sWq/EwyRvV9u6K5w5j7wJ/a82P1cRCthtu23vN4GUG6do+mbgsAW+KKnHtmqqi/LWNWHmpCeaX331zhnHhshjCEWFvbSYnn0l7n+FwkVlAGwTzFUTnpLgaWATdHADqLgi669fDw+iF/Go6Y5iz4O3R8TjI3BPyFcO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:28.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8515abb5-14bb-480c-c118-08df2462e5b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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

Initialize the CWSR handler during device initialization and release
the associated resources during device teardown.

Add a per-file CWSR trap object for render-node user queues and map the
first-level CWSR trap handler into the GPUVM associated with the file.
Use the mapped TBA and TMA addresses when programming user queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Change-Id: I35b7007318a467bf391460cc42414eb808d512cf
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 10 ++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 29 +++++++++++++++++-----
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 26561a4f4db8..bdd55ac5b06e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -333,6 +333,7 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
 struct amdgpu_cwsr_isa;
+struct amdgpu_cwsr_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -421,6 +422,7 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..5a7f111763bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,6 +81,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_cwsr.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -2549,6 +2550,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	r = amdgpu_cper_init(adev);
 
+	if (!r) {
+		r = amdgpu_cwsr_init(adev);
+		if (r == -EOPNOTSUPP)
+			r = 0;
+	}
+
 init_failed:
 
 	return r;
@@ -2946,6 +2953,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cwsr_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f34150d20a2f..f3945b3988d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -49,6 +49,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_video_codecs.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_cwsr.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1552,6 +1554,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 r);
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
+
+	if (amdgpu_cwsr_is_enabled(adev)) {
+		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
+		if (r)
+			dev_dbg(adev->dev, "cwsr trap not enabled");
+	}
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1621,6 +1630,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
+	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1b76c10d1ac2..89a35fd53cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -27,6 +27,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -115,6 +116,7 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -146,24 +148,37 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
+	if (fpriv->cwsr_trap) {
+		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
+		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
+	}
+
 	if (mes->use_rs64mem) {
 		if (!uq_mgr->proc_ctx_allocated) {
-			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
+			r = amdgpu_mes_alloc_proc_ctx_index(mes,
+							    &uq_mgr->proc_ctx_array_index);
 			if (r) {
-				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
+				DRM_ERROR("Failed to allocate userq process index err:%d\n",
+					  r);
 				return r;
 			}
 			uq_mgr->proc_ctx_allocated = true;
 		}
 
-		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
+		r = amdgpu_mes_alloc_gang_ctx_index(mes,
+						    &queue->gang_ctx_array_index);
 		if (r) {
 			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
 			return r;
 		}
-		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
-		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
+
+		queue_input.process_context_array_index =
+			uq_mgr->proc_ctx_array_index;
+		queue_input.gang_context_array_index =
+			queue->gang_ctx_array_index;
 	}
+
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
@@ -174,7 +189,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 
 	amdgpu_mes_userq_queue_mapped(adev);
 
-	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
+			 userq_props->doorbell_index);
+
 	return 0;
 }
 
-- 
2.34.1

