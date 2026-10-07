Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B8CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F131210E572;
	Wed,  7 Oct 2026 11:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/E1qC3B";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA9710E572
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJV/BsU2JhM5vYDaECeTYAATvrGejkCR5QfqhyM670JybMVPy6gC+TRlvMnEJP16MpjNsH59t4UOMmq8iLdj7q0vQYBkp1E89IpExwRC6WKLAHKNZ8ZUZcyfKV3e2vXcEhki4bskBAVvtkrT9VAc1bvLbRLzBte+eErzwhr7TG22/Gj0KgPQjgv3Pm5y7l7KiLPmintnN5B1sT9mARPwCnkqAbQU4lHlVC0JTnIX/HjYZstgRXOYfcklDypvZNTvrnGdPNJvrFjjGodx25HxZCeba4CI6nu8MxqupQTNRrSpZUROUrymYoCDw/uZoNJdPFyXx9iRa1zO75QsoS4YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtOvvwyxBjxITnAYdvBOfb9wZTENrFVLvaO2jBms0Es=;
 b=fwPnwG9YKwPwbQtCj4F+7HkSaqZDfSvsloVlyE4zCFyKm8zaSZuV8dlHszlp2XL3dENkWoLYScRpw/OUBP288QcuWEkdDZ+a9BIj4AngEf9bWCed1Xkrqo+moTOg3/+j+zOuHktU7drd3pLJpOFzxNrn8hamNLH/ODcflC495dL7jeLk/thy7+yFQq9MmPyW+aYW/keOvwZn2PuaILHlgb4YMXu99kdRZhxesk1uoQLiyFfbHdU3cneZQT9+Zg9A5cP5aReHKPxnb7lNnviKi727n2pK+3EwG5ijIxNHBbBwSrTO84CtFSAeZrLm9D/6uU2c6H5uG8mQNrn+R+3sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtOvvwyxBjxITnAYdvBOfb9wZTENrFVLvaO2jBms0Es=;
 b=E/E1qC3BCJyFkQ9u9XeW4cM/tsTDaGI2xJJHA6dsorEPeqYdYfvBQgI3TQTf+RML9b3edX4uDh6ktdDO9jVTlLddZW0eXxd45bTs8AljqVfHtsxqqaOHcwvJwhUT5U1G8siJzkfmNvb0dLm7cYr8aMlfVBI7x0TxanojLnwnQsI=
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:05:31 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::2b) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 11:05:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "James
 Zhu" <James.Zhu@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: Add user save area params to mqd input
Date: Wed, 7 Oct 2026 16:35:01 +0530
Message-ID: <20261007110506.1065076-5-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8628522e-2819-442a-f89a-08df2462e6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|3023799007|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sMxvO2kbTSSffUZ2i5PtR1m1+TXzzHYv/NBsFBOY54SzgEm8xB8y3wDFqVwnuOiddQNl61+2x58XNY6Tcpf21u9WVJSrwBF244Kq3Ia8I8C9MinxnFnHmhI/bJZP0WHsXt/+LnfSkdcxH+mJn/XDl4Pol1cnG32XAgZBEIKGXGJ73pYB3+YWdGwmZk7JPYi8bSLbgebyodmo1hez5QuBg4UyhWQIbeu6gbKJxwLE/g+9DzASUJ8zv0tSKz4Vl5H95AxGSH0i6+SGDYeG4Wlebg6YsI/dN+goteMSsUHOgHneSPgGx0FPpcvcXfbeJTIAAR4IiBSTdQlmYOGberEH5lDcZOZYU7JesAsZ5/o4g9EPxVHG14XCvOjaHWViup6gAXTc/lsK58NOls6vv87v1Vwxily199/ptNzt0ry3ancupADmWFWB+G5ahwEFnU1sqMnAWctO7+iWXPycivs3qym4YZ2QRfHzJ5ZhercNv9KKCC06wKKr583S9aUN1vYkLocBsfrX616jX5mjA5TXmP1gAd23xa6XKbTG7C0vp0V0Ypoe2OujWNng0pGjAre/8aI3vHlK4Q5eGiODjskpAFTOGSYcOkVA8DrCma2O4ZuSgO3cJOutE1uQUOh+NRGISo7PPlUgbF4LCxLxxFe5DvXGyEdQAFNvhOKXKfEUEUpbAilWm72ip3PQ2qeDMnpeNwAecoZoqoz6OF9818y7AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(3023799007)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z/aDwEOKOLPtT5p211SdTy3RoSVg89ZoQLE49RrKAR+v0Qzacay40gfpB/4T8lE/V6g1mqAhLPvkED0BPNEpmibLTLmXPrd2BfcXX2uHTT2arx9BR4HKlBik5wMmTN+khVvev7771Y5cK3OBy3Qc2RV/0gk60kGS1yoCvrTXqgUn0ZuudB28DR7Nr+IjgeIw9B23wDdgJtL3gi/iLtn64Rv5i2mIiMc1XIXm4ArRXmddoevA9rLNrRlEgBSQGnQ+sfnF1K9OGF5aG7CqaLKfeJiWOZ2GcOicGhW7WlsJh0iW/bJINro+D1ccWncLXuPJKPV1qyVTcv/WOF5BmnsLxIqMQ/FpzV6kf/eDgtXh0OOvcISnFbQrRuZmFPNJ0EcSbqPs6O8CLEP93xuTDERORUu+EYClc9oJkhrRS6EbByyjmttjA6NfAr8tWrOhVM8z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:30.8981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8628522e-2819-442a-f89a-08df2462e6f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

Add user save area parameters to the MQD properties for queue creation
and validate the parameters before using them for MQD initialization.

The CWSR parameter validation walks the VM mapping tree and updates the
user queue VA mapping state. Reserve the VM root BO around the
validation so the required VM reservation is held while accessing the
mapping tree.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Change-Id: I8b6f3a38a64280f043a060ebce958d7a425b2199
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 25 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  8 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 14 +++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 73 ++++++++++++++++++----
 5 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2b13a5b37539..b3df09dbcbad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -527,6 +527,14 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	bool aql_queue;
+	uint32_t queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	uint32_t pm4_target_xcc;
+	/* cwsr params */
+	uint64_t ctx_save_area_addr;
+	uint32_t ctx_save_area_size;
+	uint32_t ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e29823ae8672..6eea0ca40556 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -35,6 +35,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_cwsr.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -266,6 +267,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	uint32_t cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
+		&queue->userq_vas.va.cwsr);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..727f60c40bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_cwsr_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -97,8 +98,9 @@ struct amdgpu_usermode_queue {
 			u64 eop;
 			u64 shadow;
 			u64 csa;
+			u64 cwsr;
 		} va;
-		u64 va_array[6];
+		u64 va_array[7];
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
@@ -200,4 +202,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 420ce997bebc..b5326c2067db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3327,6 +3327,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set CU mask */
 	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 89a35fd53cba..3b7a1479fbf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -415,6 +415,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_cwsr_params cwsr_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -422,7 +423,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					  mqd_user->mqd_size);
 		if (IS_ERR(compute_mqd)) {
 			r = PTR_ERR(compute_mqd);
 			goto free_mqd;
@@ -433,6 +435,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(compute_mqd);
 			goto free_mqd;
 		}
+
 		r = amdgpu_userq_input_va_validate(adev, queue,
 						   compute_mqd->eop_va, 2048,
 						   &queue->userq_vas.va.eop);
@@ -444,29 +447,63 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_queue_priority =
+			AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_cwsr_is_enabled(adev)) {
+			struct amdgpu_fpriv *fpriv =
+				uq_mgr_to_fpriv(queue->userq_mgr);
+			int num_xcc;
+
+			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
+							 fpriv->xcp_id);
+			cwsr_params.ctx_save_area_address =
+				userq_props->ctx_save_area_addr;
+			cwsr_params.cwsr_sz =
+				userq_props->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+
+			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+
+			r = amdgpu_userq_input_cwsr_params_validate(
+				queue, &cwsr_params);
+			amdgpu_bo_unreserve(queue->vm->root.bo);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
 		struct amdgpu_gfx_shadow_info shadow_info;
 
 		if (adev->gfx.funcs->get_gfx_shadow_info) {
-			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+			adev->gfx.funcs->get_gfx_shadow_info(adev,
+							     &shadow_info, true);
 		} else {
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					   mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
 			r = PTR_ERR(mqd_gfx_v11);
 			goto free_mqd;
@@ -482,7 +519,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_gfx_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size,
 						   &queue->userq_vas.va.shadow);
 		if (r) {
@@ -491,7 +530,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -504,13 +544,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
 
-		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					    mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
 			r = PTR_ERR(mqd_sdma_v11);
 			goto free_mqd;
@@ -521,7 +563,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_sdma_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_sdma_v11->csa_va,
 						   32,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -536,7 +580,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	queue->userq_prop = userq_props;
 
-	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+				     userq_props);
 	if (r) {
 		DRM_ERROR("Failed to initialize MQD for userqueue\n");
 		goto free_mqd;
@@ -545,7 +590,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	/* Create per-process MES process context BO */
 	r = mes_userq_create_proc_ctx_space(uq_mgr);
 	if (r) {
-		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
+		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n",
+			  r);
 		goto free_mqd;
 	}
 
@@ -557,7 +603,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	}
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue,
+					  userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
-- 
2.34.1

